require_relative '../../lib/labus/build_iteration.rb'

describe Labus::BuildIteration do
  describe :build_iteration do
    subject { Labus::BuildIteration.new(git_describe) }

    context 'with an invalid git_describe' do
      let(:git_describe) { '1.2.3-foo.3' }

      it 'returns 0' do
        expect(subject.build_iteration).to eq('0')
      end
    end

    context 'with a proper git_describe' do
      let(:git_describe) { '1.2.3+foo.4' }

      it 'returns foo.4' do
        expect(subject.build_iteration).to eq('foo.4')
      end
    end

    context 'with multiple plus signs' do
      let(:git_describe) { '1.2.3+foo.4+bar' }

      it 'returns everything after the first plus' do
        expect(subject.build_iteration).to eq('foo.4+bar')
      end
    end
  end
end
