require "lfs"

for dirname in lfs.dir'square' do
  if string.sub(dirname,1,1)~='.' then
    lfs.mkdir('test/'..dirname)
    for filename in lfs.dir('square/'..dirname) do
      if string.sub(filename,1,1)~='.' then
        io.close(assert(io.open('test/'..dirname..'/'..filename,'w')))
      end
    end
  end
end
