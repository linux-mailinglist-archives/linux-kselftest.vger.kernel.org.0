Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E422C77D271
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239447AbjHOSua (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239656AbjHOSuX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:50:23 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53B8B1FDB;
        Tue, 15 Aug 2023 11:49:56 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 37FImmdA009380;
        Tue, 15 Aug 2023 20:48:48 +0200
Date:   Tue, 15 Aug 2023 20:48:48 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah <shuah@kernel.org>
Subject: Re: [GIT PULL] nolibc changes for 6.6-rc1
Message-ID: <ZNvIkD1oxZENVkoe@1wt.eu>
References: <20230806172245.GA26239@1wt.eu>
 <3efa3710-4e8b-d187-a24d-ff85858e37fe@linuxfoundation.org>
 <20230815143540.GA15075@1wt.eu>
 <29590d7b-40fd-0426-75c6-36667e344f6c@linuxfoundation.org>
 <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UjeWNFIBQyu8KN2i"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9950607c-cafe-c011-7d5f-76a8a971beb0@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


--UjeWNFIBQyu8KN2i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello Shuah,

On Tue, Aug 15, 2023 at 12:13:24PM -0600, Shuah Khan wrote:
> On 8/15/23 08:39, Shuah Khan wrote:
> > On 8/15/23 08:35, Willy Tarreau wrote:
> > > On Tue, Aug 15, 2023 at 08:25:51AM -0600, Shuah Khan wrote:
> > > > > The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:
> > > > > 
> > > > >     Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >     https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
> > > > > 
> > > > > for you to fetch changes up to d98c1e27e46e47a3ae67e1d048f153598ba82611:
> > > > > 
> > > > >     tools/nolibc: stackprotector.h: make __stack_chk_init static (2023-08-06 18:44:47 +0200)
> > > > > 
> > > > 
> > > > Hi Willy,
> > > > 
> > > > I am sorry for the delay on this. I was traveling last week
> > > > and getting back to digging myself out of emails.
> > > 
> > > No problem, thanks for getting back :-)
> > > 
> > > > I am having trouble pulling this request though:
> > > > 
> > > > git request-pull https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/ 20230806-for-6.6-1
> > > > 
> > > > gives me the following error
> > > > 
> > > > fatal: Not a valid revision: git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git/
> > > > 
> > > > I don't see a tag at https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git
> > > 
> > > Ah sorry for the misunderstanding, that's the branch name, I'll set a
> > > tag then.
> > > 
> > 
> > No worries. Could you also share the test you run? I will pull
> > you request and run tests.
> > 
> 
> Please send either another pull request or send the tag details.

I've pushed a tag named 20230815-for-6.6-2 in the repo below:

  https://git.kernel.org/pub/scm/linux/kernel/git/wtarreau/nolibc.git

Please let me know if you want me to resend a PR.

I'm also attaching a script I'm using here to run the tests on the
various archs. It's quite limited but gets the job done for now.
There are simplifications coming for future versions. The simplest
way to use it is:

  1) make sure you have the relevant toolchains. We're currently
     using those Arnd maintains and that are located here:

       https://mirrors.edge.kernel.org/pub/tools/crosstool/

     If that helps I'm attaching a tiny script I have which downloads
     all needed ones from a given version and extracts them in a same
     directory.

     Please note, if you've downloaded version 13.1.0, I've had a
     segfault on gcc-aarch64 only on this one and that was fixed with
     13.2.0. I preferred to tell you upfront instead of wasting your
     time on it.

  2) from the kernel top dir, copy the test-all-full4.sh script into
     tools/testing/selftests/nolibc/ then indicate where you extracted
     the crosstools:

       $ cd tools/testing/selftests/nolibc
       $ TOOLCHAIN_BASE=/path/to/gcc-13.2.0-nolibc ./test-all-full4.sh

     For each supported arch, it will build the test program, run it in
     userland under qemu with your current kernel, and will also build
     a kernel, install the program in it and run it under qemu. Support
     for loongarch in Qemu is recent, so if the one from your distro
     doesn't have it, you can instead build for all other archs by
     passing their names in argument to the program:

       $ TOOLCHAIN_BASE=... ./test-all-full4.sh \
         i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390

     Note that the archs most of the time match the kernel ones, except
     when there are variants, where we defined extra ones (typically to
     force 32/64 bits), and in this case we use distinct names to avoid
     any ambiguity. This explains "ppc" and "ppc64" above, which both
     map to "powerpc" when building the kernel.

  3) At the end it will show a synthetic report indicating what archs
     succeeded/failed and some will show "warning" if there is at
     least one test skipped:

     #### Synthetic summary:
     USER     i386  160   test(s):  158      passed,  2  skipped,  0  failed  =>  status:  warning
     KERN     i386  160   test(s):  160      passed,  0  skipped,  0  failed  =>  status:  success

     Two "skipped" are expected for the userland tests, due to privileged
     operations being skipped. That is OK. On MIPS and s390 depending on
     the toolchains, another skipped can appear due to the stack-protector
     test being skipped. In this case it will be 3 skipped for userland,
     and 1 skipped for the kernel. There should never be any failure.

  4) Save precious time: it is often useful to just run the userland
     tests when you're not testing for a kernel regression: the program
     is exactly the same and if you didn't change your kernel between
     tests there is no reason you'll get a different result once you know
     what the userland reports. For this, set USER_ONLY=1 when calling
     the script:

       $ TOOLCHAIN_BASE=... ./test-all-full4.sh \
         USER_ONLY=1 \
         i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390

     It will skip all the kernel parts and will only install UAPI headers,
     build nolibc-test for each arch and run it through Qemu. Quite
     honestly this is the recommended way to use it when you're not
     seeking a specific kernel issue. On my laptop it takes 24 seconds
     (loongarch was not tested here):

     #### Synthetic summary:
     USER  i386     160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  x86_64   160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  arm64    160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  arm      160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  mips     160  test(s):  157  passed,  3  skipped,  0  failed  =>  status:  warning
     USER  ppc      160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  ppc64    160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  ppc64le  160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  riscv    160  test(s):  158  passed,  2  skipped,  0  failed  =>  status:  warning
     USER  s390     160  test(s):  157  passed,  3  skipped,  0  failed  =>  status:  warning

  5) Other variables: it's possible to force a specific cross-compiler
     prefix with CROSS_COMPILE_$arch, or when building for a single arch,
     CROSS_COMPILE, a specific CC with CC, and to enable verbose build
     with V=1.

  6) A complete capture of all outputs is done in "report.out", and a
     copy of each used nolibc-test executable is kept with the suffix
     -$arch.

The script contains a "set -e" statement to stop on any error. There is
one known case (missing qemu binary for userlan) where the error is
ignored in the makefile and the build will continue. But this stuff is
currently being improved so I consider there's no point re-changing this
at the last minute at the risk of breaking other stuff.

Do not hesitate to ask if you encounter difficulties or if anything is
not clear.

Thank you!
Willy

--UjeWNFIBQyu8KN2i
Content-Type: application/x-sh
Content-Disposition: attachment; filename="test-all-full4.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0A# uses the following optional variables:=0A#  - NPROC proc=
esses (default: $(nproc))=0A#  - CC: full path to gcc, default: ${CROSS_COM=
PILE}gcc=0A#  - CROSS_COMPILE: prefix to the compiler. default: CROSS_COMPI=
LE_$arch=0A#  - CROSS_COMPILE_$arch: default for $arch, default: located in=
 $TOOLCHAIN_BASE=0A#  - TOOLCHAIN_BASE: directory containing the nolibc too=
lchains=0A#  - USER_ONLY: if set, doesn't build kernels nor start qemu=0A# =
 - V: verbose build, passed through the whole build chain=0A#=0A# Arguments=
: list of archs to build and test=0A#=0ANPROC=3D${NPROC:-$(nproc)}=0ATOOLCH=
AIN_BASE=3D${TOOLCHAIN_BASE:-/f/tc/nolibc/gcc-13.2.0-nolibc}=0A=0Aif [ ! -e=
 nolibc-test.c ]; then=0A	echo "Please run from the nolibc directory."=0A	e=
xit 1=0Afi=0A=0Aexport CROSS_COMPILE_i386=3D"${CROSS_COMPILE_i386:-${TOOLCH=
AIN_BASE}/i386-linux/bin/i386-linux-}"=0Aexport CROSS_COMPILE_x86_64=3D"${C=
ROSS_COMPILE_x86_64:-${TOOLCHAIN_BASE}/x86_64-linux/bin/x86_64-linux-}"=0Ae=
xport CROSS_COMPILE_arm64=3D"${CROSS_COMPILE_arm64:-${TOOLCHAIN_BASE}/aarch=
64-linux/bin/aarch64-linux-}"=0Aexport CROSS_COMPILE_arm=3D"${CROSS_COMPILE=
_arm:-${TOOLCHAIN_BASE}/arm-linux-gnueabi/bin/arm-linux-gnueabi-}"=0Aexport=
 CROSS_COMPILE_mips=3D"${CROSS_COMPILE_mips:-${TOOLCHAIN_BASE}/mips-linux/b=
in/mips-linux-}"=0Aexport CROSS_COMPILE_ppc=3D"${CROSS_COMPILE_ppc:-${TOOLC=
HAIN_BASE}/powerpc-linux/bin/powerpc-linux-}"=0Aexport CROSS_COMPILE_ppc64=
=3D"${CROSS_COMPILE_ppc64:-${TOOLCHAIN_BASE}/powerpc64-linux/bin/powerpc64-=
linux-}"=0Aexport CROSS_COMPILE_ppc64le=3D"${CROSS_COMPILE_ppc64le:-${TOOLC=
HAIN_BASE}/powerpc64-linux/bin/powerpc64-linux-}"=0Aexport CROSS_COMPILE_ri=
scv=3D"${CROSS_COMPILE_riscv:-${TOOLCHAIN_BASE}/riscv64-linux/bin/riscv64-l=
inux-}"=0Aexport CROSS_COMPILE_s390=3D"${CROSS_COMPILE_s390:-${TOOLCHAIN_BA=
SE}/s390-linux/bin/s390-linux-}"=0Aexport CROSS_COMPILE_loongarch=3D"${CROS=
S_COMPILE_loongarch:-${TOOLCHAIN_BASE}/loongarch64-linux/bin/loongarch64-li=
nux-}"=0A=0AARCHS=3D( "$@" )=0Aif [ "${#ARCHS[@]}" =3D 0 ]; then=0A	ARCHS=
=3D( i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390 loongarch )=0A=
fi=0A=0A# stop on first error=0Aset -e=0A=0Arm -f report.out=0A=0Afor arch =
in "${ARCHS[@]}"; do=0A	echo "#### Building for arch $arch ####"=0A=0A	cros=
s_compile=3D"CROSS_COMPILE_${arch}"=0A	cross_compile=3D"${CROSS_COMPILE:-${=
!cross_compile}}"=0A	cc=3D"${CC:-${cross_compile}gcc}"=0A=0A	echo "###### C=
LEAN $arch ######" | tee -a report.out=0A=0A	make clean XARCH=3D"$arch" \=
=0A	     CROSS_COMPILE=3D"$cross_compile" \=0A	     CC=3D"$cc" ${V:+V=3D${V=
}}=0A=0A	if [ -z "$USER_ONLY" ]; then=0A		echo "###### CONFIG $arch ######"=
 | tee -a report.out=0A		=0A		make -C ../../../.. ARCH=3D"${arch//ppc*/powe=
rpc}" mrproper =0A		make defconfig XARCH=3D"$arch" \=0A		     CROSS_COMPILE=
=3D"$cross_compile" \=0A		     CC=3D"$cc" ${V:+V=3D${V}}=0A	fi=0A=0A	echo "=
###### BUILD $arch (cross $cross_compile) ######" | tee -a report.out=0A=0A=
	make -j${NPROC} nolibc-test XARCH=3D"$arch" \=0A	     CROSS_COMPILE=3D"$cr=
oss_compile" \=0A	     CC=3D"$cc" ${V:+V=3D${V}} \=0A	     2>&1 | tee -a re=
port.out=0A=0A	cp nolibc-test nolibc-test-$arch=0A	(echo "# size nolibc-tes=
t-$arch"; size nolibc-test-$arch) | tee -a report.out=0A=0A	echo "###### US=
ER $arch ######" | tee -a report.out=0A=0A	rm -f run.out=0A	make -j${NPROC}=
 run-user XARCH=3D"$arch" \=0A	     CROSS_COMPILE=3D"$cross_compile" \=0A	 =
    CC=3D"$cc" ${V:+V=3D${V}} \=0A	     2>&1 | tee -a report.out=0A=0A	echo=
 "###### RUN-USER LOG for $arch (run.out) ######" | tee -a report.out=0A	ca=
t run.out >> report.out=0A=0A	if [ -z "$USER_ONLY" ]; then=0A		echo "######=
 KERN $arch ######" | tee -a report.out=0A	=0A		rm -f run.out=0A		make -j${=
NPROC} run XARCH=3D"$arch" \=0A		     CROSS_COMPILE=3D"$cross_compile" \=0A=
		     CC=3D"$cc" ${V:+V=3D${V}} \=0A		     2>&1 | tee -a report.out=0A	=0A=
		echo "###### RUN-KERN LOG for $arch (run.out) ######" | tee -a report.out=
=0A		cat run.out >> report.out=0A	fi=0A	echo "###### DONE $arch ######" | t=
ee -a report.out=0Adone=0A=0Aecho "#### Synthetic summary:"=0Agrep -o ' USE=
R [^ ]* \| KERN [^ ]* \|.* status:.*' report.out | sed '$!N;s/\n/ /' | colu=
mn -t=0A
--UjeWNFIBQyu8KN2i
Content-Type: application/x-sh
Content-Disposition: attachment; filename="download.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Aset -e=0A=0AMIRROR=3Dhttps://ftp-stud.hs-esslingen.de/Mirror=
s/ftp.kernel.org/pub/tools/crosstool/files/bin/=0A#MIRROR=3Dhttp://ftp2.fru=
galware.org/mirror/ftp.kernel.org/pub/tools/crosstool/files/bin/=0A#MIRROR=
=3Dhttp://mirror-ext.facebook.net/kernel.org/pub/tools/crosstool/files/bin/=
=0A#MIRROR=3Dhttps://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/=
=0A=0AVERS=3D${VERS:-13.2.0}=0AARCHS=3D${ARCHS:-aarch64 arm i386 loongarch6=
4 mips powerpc powerpc64 riscv64 s390 x86_64}=0A=0Afor arch in ${ARCHS[*]};=
 do=0A	file=3Dx86_64-gcc-$VERS-nolibc-$arch-linux.tar.xz=0A	if [ -z "${file=
##*arm*}" ]; then=0A		file=3D${file/linux/linux-gnueabi};=0A	fi=0A	echo "##=
## $file ####"=0A	if [ -d gcc-$VERS-nolibc/$arch-linux/. ]; then=0A		echo "=
dir already present, not retrieving again."=0A	else=0A		curl $MIRROR/x86_64=
/$VERS/$file | tar Jxf -=0A	fi=0Adone=0A
--UjeWNFIBQyu8KN2i--
