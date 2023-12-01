Return-Path: <linux-kselftest+bounces-972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F8C800E94
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462B41C20968
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Dec 2023 15:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3044AF69;
	Fri,  1 Dec 2023 15:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g+IK2vIT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F611711
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Dec 2023 07:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701444481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bSnnjRiRBLGXTS1PLg08BCA65STaIHvgjLRP+4oUSmI=;
	b=g+IK2vITV4nnIhcCWnXMd4NvVKL0Tffz3vAbC0qgcOi6lQBdCrrj6mJvkLJu9xsS+iPls5
	WdrdamqHE7rms1XmviDnHrzHbwJ/MKdFoLsYeKELLxRWFLacNoI8ljO3UVWvu2rR4NeFE9
	Pt1pARjh8TtkfGOXbXt0wrpMwm+HPAg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-411-tJlMMF6lOSmmL4iShzZd3A-1; Fri,
 01 Dec 2023 10:27:52 -0500
X-MC-Unique: tJlMMF6lOSmmL4iShzZd3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB2B33C1AC90;
	Fri,  1 Dec 2023 15:27:50 +0000 (UTC)
Received: from redhat.com (unknown [10.2.17.211])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C3612026D4C;
	Fri,  1 Dec 2023 15:27:50 +0000 (UTC)
Date: Fri, 1 Dec 2023 10:27:48 -0500
From: Joe Lawrence <joe.lawrence@redhat.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Petr Mladek <pmladek@suse.com>, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v3 2/3] livepatch: Move tests from lib/livepatch to
 selftests/livepatch
Message-ID: <ZWn7dEzVWoKxycmy@redhat.com>
References: <20231031-send-lp-kselftests-v3-0-2b1655c2605f@suse.com>
 <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031-send-lp-kselftests-v3-2-2b1655c2605f@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

On Tue, Oct 31, 2023 at 06:10:52PM -0300, Marcos Paulo de Souza wrote:
> The modules are being moved from lib/livepatch to
> tools/testing/selftests/livepatch/test_modules.
> 
> This code moving will allow writing more complex tests, like for example an
> userspace C code that will call a livepatched kernel function.
> 
> The modules are now built as out-of-tree
> modules, but being part of the kernel source means they will be maintained.
> 
> Another advantage of the code moving is to be able to easily change,
> debug and rebuild the tests by running make on the selftests/livepatch directory,
> which is not currently possible since the modules on lib/livepatch are
> build and installed using the "modules" target.
> 
> The current approach also keeps the ability to execute the tests manually by
> executing the scripts inside selftests/livepatch directory, as it's currently
> supported. If the modules are modified, they needed to be rebuilt before running
> the scripts though.
> 
> The modules are built before running the selftests when using the
> kselftest invocations:
> 
> 	make kselftest TARGETS=livepatch
> or
> 	make -C tools/testing/selftests/livepatch run_tests
> 

Quick question:

- We have been building with CONFIG_LIVEPATCH_TEST=m to generate the
  test modules at kernel build time

- Our packaging filters out the selftest scripts and supporting modules
  from the general kernel RPM package into their subpackages

- Tests are run as part of CKI or other manual tests by installing the
  pre-built packages from the previous step


After this patch, we would need to add something like the following to
our kernel build, before packaging:

  $ make KDIR=$(pwd) -C tools/testing/selftests/livepatch/
         ^^^^

If this is the correct way to build the test modules for *this* tree and
/lib/modules/$(shell uname -r)/build... it might be useful to document
in the commit message as an alternative use case.

-- Joe

> Having the modules being built as out-of-modules requires changing the
> currently
> used 'modprobe' by 'insmod' and adapt the test scripts that check for the kernel
> message buffer.
> 
> As there aren't any modules being built on lib/livepatch, remove the
> TEST_LIVEPATCH Kconfig and it's references.
> 
> Note: "make gen_tar" packages the pre-built binaries into the tarball.
>        It means that it will store the test modules pre-built for
>        the kernel running on the build host.
> 
>        Note that these modules need not binary compatible with
>        the kernel built from the same sources. But the same
>        is true for other packaged selftest binaries.
> 
>        The entire kernel sources are needed for rebuilding
>        the selftests on another system.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  arch/s390/configs/debug_defconfig                  |  1 -
>  arch/s390/configs/defconfig                        |  1 -
>  lib/Kconfig.debug                                  | 22 ----------
>  lib/Makefile                                       |  2 -
>  lib/livepatch/Makefile                             | 14 ------
>  tools/testing/selftests/livepatch/Makefile         |  1 +
>  tools/testing/selftests/livepatch/README           | 17 +++++---
>  tools/testing/selftests/livepatch/config           |  1 -
>  tools/testing/selftests/livepatch/functions.sh     | 34 ++++++---------
>  .../testing/selftests/livepatch/test-callbacks.sh  | 50 +++++++++++-----------
>  tools/testing/selftests/livepatch/test-ftrace.sh   |  6 +--
>  .../testing/selftests/livepatch/test-livepatch.sh  | 10 ++---
>  .../selftests/livepatch/test-shadow-vars.sh        |  2 +-
>  tools/testing/selftests/livepatch/test-state.sh    | 18 ++++----
>  tools/testing/selftests/livepatch/test-sysfs.sh    |  6 +--
>  .../selftests/livepatch/test_modules/Makefile      | 19 ++++++++
>  .../test_modules}/test_klp_atomic_replace.c        |  0
>  .../test_modules}/test_klp_callbacks_busy.c        |  0
>  .../test_modules}/test_klp_callbacks_demo.c        |  0
>  .../test_modules}/test_klp_callbacks_demo2.c       |  0
>  .../test_modules}/test_klp_callbacks_mod.c         |  0
>  .../livepatch/test_modules}/test_klp_livepatch.c   |  0
>  .../livepatch/test_modules}/test_klp_shadow_vars.c |  0
>  .../livepatch/test_modules}/test_klp_state.c       |  0
>  .../livepatch/test_modules}/test_klp_state2.c      |  0
>  .../livepatch/test_modules}/test_klp_state3.c      |  0
>  26 files changed, 89 insertions(+), 115 deletions(-)
> 
> diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
> index 438cd92e6080..9672b9f31710 100644
> --- a/arch/s390/configs/debug_defconfig
> +++ b/arch/s390/configs/debug_defconfig
> @@ -885,4 +885,3 @@ CONFIG_ATOMIC64_SELFTEST=y
>  CONFIG_STRING_SELFTEST=y
>  CONFIG_TEST_BITOPS=m
>  CONFIG_TEST_BPF=m
> -CONFIG_TEST_LIVEPATCH=m
> diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
> index 1b8150e50f6a..a8a66264a72d 100644
> --- a/arch/s390/configs/defconfig
> +++ b/arch/s390/configs/defconfig
> @@ -813,4 +813,3 @@ CONFIG_KPROBES_SANITY_TEST=m
>  CONFIG_PERCPU_TEST=m
>  CONFIG_ATOMIC64_SELFTEST=y
>  CONFIG_TEST_BPF=m
> -CONFIG_TEST_LIVEPATCH=m
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index fa307f93fa2e..af67c5f5d031 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2862,28 +2862,6 @@ config TEST_MEMCAT_P
>  
>  	  If unsure, say N.
>  
> -config TEST_LIVEPATCH
> -	tristate "Test livepatching"
> -	default n
> -	depends on DYNAMIC_DEBUG
> -	depends on LIVEPATCH
> -	depends on m
> -	help
> -	  Test kernel livepatching features for correctness.  The tests will
> -	  load test modules that will be livepatched in various scenarios.
> -
> -	  To run all the livepatching tests:
> -
> -	  make -C tools/testing/selftests TARGETS=livepatch run_tests
> -
> -	  Alternatively, individual tests may be invoked:
> -
> -	  tools/testing/selftests/livepatch/test-callbacks.sh
> -	  tools/testing/selftests/livepatch/test-livepatch.sh
> -	  tools/testing/selftests/livepatch/test-shadow-vars.sh
> -
> -	  If unsure, say N.
> -
>  config TEST_OBJAGG
>  	tristate "Perform selftest on object aggreration manager"
>  	default n
> diff --git a/lib/Makefile b/lib/Makefile
> index 740109b6e2c8..b96b280787ca 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -132,8 +132,6 @@ endif
>  obj-$(CONFIG_TEST_FPU) += test_fpu.o
>  CFLAGS_test_fpu.o += $(FPU_CFLAGS)
>  
> -obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
> -
>  # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
>  # so we can't just use obj-$(CONFIG_KUNIT).
>  ifdef CONFIG_KUNIT
> diff --git a/lib/livepatch/Makefile b/lib/livepatch/Makefile
> deleted file mode 100644
> index dcc912b3478f..000000000000
> --- a/lib/livepatch/Makefile
> +++ /dev/null
> @@ -1,14 +0,0 @@
> -# SPDX-License-Identifier: GPL-2.0
> -#
> -# Makefile for livepatch test code.
> -
> -obj-$(CONFIG_TEST_LIVEPATCH) += test_klp_atomic_replace.o \
> -				test_klp_callbacks_demo.o \
> -				test_klp_callbacks_demo2.o \
> -				test_klp_callbacks_busy.o \
> -				test_klp_callbacks_mod.o \
> -				test_klp_livepatch.o \
> -				test_klp_shadow_vars.o \
> -				test_klp_state.o \
> -				test_klp_state2.o \
> -				test_klp_state3.o
> diff --git a/tools/testing/selftests/livepatch/Makefile b/tools/testing/selftests/livepatch/Makefile
> index 02fadc9d55e0..119e2bbebe5d 100644
> --- a/tools/testing/selftests/livepatch/Makefile
> +++ b/tools/testing/selftests/livepatch/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +TEST_GEN_MODS_DIR := test_modules
>  TEST_PROGS_EXTENDED := functions.sh
>  TEST_PROGS := \
>  	test-livepatch.sh \
> diff --git a/tools/testing/selftests/livepatch/README b/tools/testing/selftests/livepatch/README
> index 0942dd5826f8..c5eb3cb67b66 100644
> --- a/tools/testing/selftests/livepatch/README
> +++ b/tools/testing/selftests/livepatch/README
> @@ -13,23 +13,26 @@ the message buffer for only the duration of each individual test.)
>  Config
>  ------
>  
> -Set these config options and their prerequisites:
> -
> -CONFIG_LIVEPATCH=y
> -CONFIG_TEST_LIVEPATCH=m
> +Set CONFIG_LIVEPATCH=y option and it's prerequisites.
>  
>  
>  Running the tests
>  -----------------
>  
> -Test kernel modules are built as part of lib/ (make modules) and need to
> -be installed (make modules_install) as the test scripts will modprobe
> -them.
> +Test kernel modules are built before running the livepatch selftests.  The
> +modules are located under test_modules directory, and are built as out-of-tree
> +modules.  This is specially useful since the same sources can be built and
> +tested on systems with different kABI, ensuring they the tests are backwards
> +compatible.  The modules will be loaded by the test scripts using insmod.
>  
>  To run the livepatch selftests, from the top of the kernel source tree:
>  
>    % make -C tools/testing/selftests TARGETS=livepatch run_tests
>  
> +or
> +
> +  % make kselftest TARGETS=livepatch
> +
>  
>  Adding tests
>  ------------
> diff --git a/tools/testing/selftests/livepatch/config b/tools/testing/selftests/livepatch/config
> index ad23100cb27c..e88bf518a23a 100644
> --- a/tools/testing/selftests/livepatch/config
> +++ b/tools/testing/selftests/livepatch/config
> @@ -1,3 +1,2 @@
>  CONFIG_LIVEPATCH=y
>  CONFIG_DYNAMIC_DEBUG=y
> -CONFIG_TEST_LIVEPATCH=m
> diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
> index c8416c54b463..e60cf09491a6 100644
> --- a/tools/testing/selftests/livepatch/functions.sh
> +++ b/tools/testing/selftests/livepatch/functions.sh
> @@ -127,16 +127,14 @@ function loop_until() {
>  	done
>  }
>  
> -function assert_mod() {
> -	local mod="$1"
> -
> -	modprobe --dry-run "$mod" &>/dev/null
> -}
> -
>  function is_livepatch_mod() {
>  	local mod="$1"
>  
> -	if [[ $(modinfo "$mod" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
> +	if [[ ! -f "test_modules/$mod.ko" ]]; then
> +		die "Can't find \"test_modules/$mod.ko\", try \"make\""
> +	fi
> +
> +	if [[ $(modinfo "test_modules/$mod.ko" | awk '/^livepatch:/{print $NF}') == "Y" ]]; then
>  		return 0
>  	fi
>  
> @@ -146,9 +144,9 @@ function is_livepatch_mod() {
>  function __load_mod() {
>  	local mod="$1"; shift
>  
> -	local msg="% modprobe $mod $*"
> +	local msg="% insmod test_modules/$mod.ko $*"
>  	log "${msg%% }"
> -	ret=$(modprobe "$mod" "$@" 2>&1)
> +	ret=$(insmod "test_modules/$mod.ko" "$@" 2>&1)
>  	if [[ "$ret" != "" ]]; then
>  		die "$ret"
>  	fi
> @@ -161,13 +159,10 @@ function __load_mod() {
>  
>  # load_mod(modname, params) - load a kernel module
>  #	modname - module name to load
> -#	params  - module parameters to pass to modprobe
> +#	params  - module parameters to pass to insmod
>  function load_mod() {
>  	local mod="$1"; shift
>  
> -	assert_mod "$mod" ||
> -		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
> -
>  	is_livepatch_mod "$mod" &&
>  		die "use load_lp() to load the livepatch module $mod"
>  
> @@ -177,13 +172,10 @@ function load_mod() {
>  # load_lp_nowait(modname, params) - load a kernel module with a livepatch
>  #			but do not wait on until the transition finishes
>  #	modname - module name to load
> -#	params  - module parameters to pass to modprobe
> +#	params  - module parameters to pass to insmod
>  function load_lp_nowait() {
>  	local mod="$1"; shift
>  
> -	assert_mod "$mod" ||
> -		skip "unable to load module ${mod}, verify CONFIG_TEST_LIVEPATCH=m and run self-tests as root"
> -
>  	is_livepatch_mod "$mod" ||
>  		die "module $mod is not a livepatch"
>  
> @@ -196,7 +188,7 @@ function load_lp_nowait() {
>  
>  # load_lp(modname, params) - load a kernel module with a livepatch
>  #	modname - module name to load
> -#	params  - module parameters to pass to modprobe
> +#	params  - module parameters to pass to insmod
>  function load_lp() {
>  	local mod="$1"; shift
>  
> @@ -209,13 +201,13 @@ function load_lp() {
>  
>  # load_failing_mod(modname, params) - load a kernel module, expect to fail
>  #	modname - module name to load
> -#	params  - module parameters to pass to modprobe
> +#	params  - module parameters to pass to insmod
>  function load_failing_mod() {
>  	local mod="$1"; shift
>  
> -	local msg="% modprobe $mod $*"
> +	local msg="% insmod test_modules/$mod.ko $*"
>  	log "${msg%% }"
> -	ret=$(modprobe "$mod" "$@" 2>&1)
> +	ret=$(insmod "test_modules/$mod.ko" "$@" 2>&1)
>  	if [[ "$ret" == "" ]]; then
>  		die "$mod unexpectedly loaded"
>  	fi
> diff --git a/tools/testing/selftests/livepatch/test-callbacks.sh b/tools/testing/selftests/livepatch/test-callbacks.sh
> index 90b26dbb2626..32b150e25b10 100755
> --- a/tools/testing/selftests/livepatch/test-callbacks.sh
> +++ b/tools/testing/selftests/livepatch/test-callbacks.sh
> @@ -34,9 +34,9 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  unload_mod $MOD_TARGET
>  
> -check_result "% modprobe $MOD_TARGET
> +check_result "% insmod test_modules/$MOD_TARGET.ko
>  $MOD_TARGET: ${MOD_TARGET}_init
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -81,7 +81,7 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  unload_mod $MOD_TARGET
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -89,7 +89,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_TARGET
> +% insmod test_modules/$MOD_TARGET.ko
>  livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
>  $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> @@ -129,9 +129,9 @@ unload_mod $MOD_TARGET
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_TARGET
> +check_result "% insmod test_modules/$MOD_TARGET.ko
>  $MOD_TARGET: ${MOD_TARGET}_init
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -177,7 +177,7 @@ unload_mod $MOD_TARGET
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -185,7 +185,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_TARGET
> +% insmod test_modules/$MOD_TARGET.ko
>  livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
>  $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> @@ -219,7 +219,7 @@ load_lp $MOD_LIVEPATCH
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -254,9 +254,9 @@ load_mod $MOD_TARGET
>  load_failing_mod $MOD_LIVEPATCH pre_patch_ret=-19
>  unload_mod $MOD_TARGET
>  
> -check_result "% modprobe $MOD_TARGET
> +check_result "% insmod test_modules/$MOD_TARGET.ko
>  $MOD_TARGET: ${MOD_TARGET}_init
> -% modprobe $MOD_LIVEPATCH pre_patch_ret=-19
> +% insmod test_modules/$MOD_LIVEPATCH.ko pre_patch_ret=-19
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  test_klp_callbacks_demo: pre_patch_callback: vmlinux
> @@ -265,7 +265,7 @@ livepatch: failed to enable patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
>  livepatch: '$MOD_LIVEPATCH': completing unpatching transition
>  livepatch: '$MOD_LIVEPATCH': unpatching complete
> -modprobe: ERROR: could not insert '$MOD_LIVEPATCH': No such device
> +insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: No such device
>  % rmmod $MOD_TARGET
>  $MOD_TARGET: ${MOD_TARGET}_exit"
>  
> @@ -295,7 +295,7 @@ load_failing_mod $MOD_TARGET
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -304,12 +304,12 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': patching complete
>  % echo -19 > /sys/module/$MOD_LIVEPATCH/parameters/pre_patch_ret
> -% modprobe $MOD_TARGET
> +% insmod test_modules/$MOD_TARGET.ko
>  livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
>  livepatch: pre-patch callback failed for object '$MOD_TARGET'
>  livepatch: patch '$MOD_LIVEPATCH' failed for module '$MOD_TARGET', refusing to load module '$MOD_TARGET'
> -modprobe: ERROR: could not insert '$MOD_TARGET': No such device
> +insmod: ERROR: could not insert module test_modules/$MOD_TARGET.ko: No such device
>  % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH/enabled
>  livepatch: '$MOD_LIVEPATCH': initializing unpatching transition
>  $MOD_LIVEPATCH: pre_unpatch_callback: vmlinux
> @@ -340,11 +340,11 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  unload_mod $MOD_TARGET_BUSY
>  
> -check_result "% modprobe $MOD_TARGET_BUSY block_transition=N
> +check_result "% insmod test_modules/$MOD_TARGET_BUSY.ko block_transition=N
>  $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
>  $MOD_TARGET_BUSY: busymod_work_func enter
>  $MOD_TARGET_BUSY: busymod_work_func exit
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -354,7 +354,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_TARGET
> +% insmod test_modules/$MOD_TARGET.ko
>  livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
>  $MOD_LIVEPATCH: post_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
> @@ -421,16 +421,16 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  unload_mod $MOD_TARGET_BUSY
>  
> -check_result "% modprobe $MOD_TARGET_BUSY block_transition=Y
> +check_result "% insmod test_modules/$MOD_TARGET_BUSY.ko block_transition=Y
>  $MOD_TARGET_BUSY: ${MOD_TARGET_BUSY}_init
>  $MOD_TARGET_BUSY: busymod_work_func enter
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET_BUSY -> [MODULE_STATE_LIVE] Normal state
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
> -% modprobe $MOD_TARGET
> +% insmod test_modules/$MOD_TARGET.ko
>  livepatch: applying patch '$MOD_LIVEPATCH' to loading module '$MOD_TARGET'
>  $MOD_LIVEPATCH: pre_patch_callback: $MOD_TARGET -> [MODULE_STATE_COMING] Full formed, running module_init
>  $MOD_TARGET: ${MOD_TARGET}_init
> @@ -467,7 +467,7 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -475,7 +475,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_LIVEPATCH2
> +% insmod test_modules/$MOD_LIVEPATCH2.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> @@ -523,7 +523,7 @@ disable_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -531,7 +531,7 @@ livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_LIVEPATCH2 replace=1
> +% insmod test_modules/$MOD_LIVEPATCH2.ko replace=1
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> diff --git a/tools/testing/selftests/livepatch/test-ftrace.sh b/tools/testing/selftests/livepatch/test-ftrace.sh
> index 825540a5194d..730218bce99c 100755
> --- a/tools/testing/selftests/livepatch/test-ftrace.sh
> +++ b/tools/testing/selftests/livepatch/test-ftrace.sh
> @@ -35,7 +35,7 @@ disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
>  check_result "livepatch: kernel.ftrace_enabled = 0
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: failed to register ftrace handler for function 'cmdline_proc_show' (-16)
> @@ -44,9 +44,9 @@ livepatch: failed to enable patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': canceling patching transition, going to unpatch
>  livepatch: '$MOD_LIVEPATCH': completing unpatching transition
>  livepatch: '$MOD_LIVEPATCH': unpatching complete
> -modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Device or resource busy
> +insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Device or resource busy
>  livepatch: kernel.ftrace_enabled = 1
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
> diff --git a/tools/testing/selftests/livepatch/test-livepatch.sh b/tools/testing/selftests/livepatch/test-livepatch.sh
> index 5fe79ac34be1..e3455a6b1158 100755
> --- a/tools/testing/selftests/livepatch/test-livepatch.sh
> +++ b/tools/testing/selftests/livepatch/test-livepatch.sh
> @@ -31,7 +31,7 @@ if [[ "$(cat /proc/cmdline)" == "$MOD_LIVEPATCH: this has been live patched" ]]
>  	die "livepatch kselftest(s) failed"
>  fi
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
> @@ -75,14 +75,14 @@ unload_lp $MOD_LIVEPATCH
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  livepatch: '$MOD_LIVEPATCH': patching complete
>  $MOD_LIVEPATCH: this has been live patched
> -% modprobe $MOD_REPLACE replace=0
> +% insmod test_modules/$MOD_REPLACE.ko replace=0
>  livepatch: enabling patch '$MOD_REPLACE'
>  livepatch: '$MOD_REPLACE': initializing patching transition
>  livepatch: '$MOD_REPLACE': starting patching transition
> @@ -135,14 +135,14 @@ unload_lp $MOD_REPLACE
>  grep 'live patched' /proc/cmdline > /dev/kmsg
>  grep 'live patched' /proc/meminfo > /dev/kmsg
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
>  livepatch: '$MOD_LIVEPATCH': completing patching transition
>  livepatch: '$MOD_LIVEPATCH': patching complete
>  $MOD_LIVEPATCH: this has been live patched
> -% modprobe $MOD_REPLACE replace=1
> +% insmod test_modules/$MOD_REPLACE.ko replace=1
>  livepatch: enabling patch '$MOD_REPLACE'
>  livepatch: '$MOD_REPLACE': initializing patching transition
>  livepatch: '$MOD_REPLACE': starting patching transition
> diff --git a/tools/testing/selftests/livepatch/test-shadow-vars.sh b/tools/testing/selftests/livepatch/test-shadow-vars.sh
> index e04cb354f56b..1218c155bffe 100755
> --- a/tools/testing/selftests/livepatch/test-shadow-vars.sh
> +++ b/tools/testing/selftests/livepatch/test-shadow-vars.sh
> @@ -16,7 +16,7 @@ start_test "basic shadow variable API"
>  load_mod $MOD_TEST
>  unload_mod $MOD_TEST
>  
> -check_result "% modprobe $MOD_TEST
> +check_result "% insmod test_modules/$MOD_TEST.ko
>  $MOD_TEST: klp_shadow_get(obj=PTR1, id=0x1234) = PTR0
>  $MOD_TEST:   got expected NULL result
>  $MOD_TEST: shadow_ctor: PTR3 -> PTR2
> diff --git a/tools/testing/selftests/livepatch/test-state.sh b/tools/testing/selftests/livepatch/test-state.sh
> index 38656721c958..10a52ac06185 100755
> --- a/tools/testing/selftests/livepatch/test-state.sh
> +++ b/tools/testing/selftests/livepatch/test-state.sh
> @@ -19,7 +19,7 @@ load_lp $MOD_LIVEPATCH
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -51,7 +51,7 @@ unload_lp $MOD_LIVEPATCH
>  disable_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH2
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  $MOD_LIVEPATCH: pre_patch_callback: vmlinux
> @@ -61,7 +61,7 @@ livepatch: '$MOD_LIVEPATCH': completing patching transition
>  $MOD_LIVEPATCH: post_patch_callback: vmlinux
>  $MOD_LIVEPATCH: fix_console_loglevel: fixing console_loglevel
>  livepatch: '$MOD_LIVEPATCH': patching complete
> -% modprobe $MOD_LIVEPATCH2
> +% insmod test_modules/$MOD_LIVEPATCH2.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> @@ -96,7 +96,7 @@ disable_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH3
>  
> -check_result "% modprobe $MOD_LIVEPATCH2
> +check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> @@ -106,7 +106,7 @@ livepatch: '$MOD_LIVEPATCH2': completing patching transition
>  $MOD_LIVEPATCH2: post_patch_callback: vmlinux
>  $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
>  livepatch: '$MOD_LIVEPATCH2': patching complete
> -% modprobe $MOD_LIVEPATCH3
> +% insmod test_modules/$MOD_LIVEPATCH3.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH3'
>  livepatch: '$MOD_LIVEPATCH3': initializing patching transition
>  $MOD_LIVEPATCH3: pre_patch_callback: vmlinux
> @@ -117,7 +117,7 @@ $MOD_LIVEPATCH3: post_patch_callback: vmlinux
>  $MOD_LIVEPATCH3: fix_console_loglevel: taking over the console_loglevel change
>  livepatch: '$MOD_LIVEPATCH3': patching complete
>  % rmmod $MOD_LIVEPATCH2
> -% modprobe $MOD_LIVEPATCH2
> +% insmod test_modules/$MOD_LIVEPATCH2.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> @@ -149,7 +149,7 @@ load_failing_mod $MOD_LIVEPATCH
>  disable_lp $MOD_LIVEPATCH2
>  unload_lp $MOD_LIVEPATCH2
>  
> -check_result "% modprobe $MOD_LIVEPATCH2
> +check_result "% insmod test_modules/$MOD_LIVEPATCH2.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH2'
>  livepatch: '$MOD_LIVEPATCH2': initializing patching transition
>  $MOD_LIVEPATCH2: pre_patch_callback: vmlinux
> @@ -159,9 +159,9 @@ livepatch: '$MOD_LIVEPATCH2': completing patching transition
>  $MOD_LIVEPATCH2: post_patch_callback: vmlinux
>  $MOD_LIVEPATCH2: fix_console_loglevel: fixing console_loglevel
>  livepatch: '$MOD_LIVEPATCH2': patching complete
> -% modprobe $MOD_LIVEPATCH
> +% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: Livepatch patch ($MOD_LIVEPATCH) is not compatible with the already installed livepatches.
> -modprobe: ERROR: could not insert '$MOD_LIVEPATCH': Invalid argument
> +insmod: ERROR: could not insert module test_modules/$MOD_LIVEPATCH.ko: Invalid parameters
>  % echo 0 > /sys/kernel/livepatch/$MOD_LIVEPATCH2/enabled
>  livepatch: '$MOD_LIVEPATCH2': initializing unpatching transition
>  $MOD_LIVEPATCH2: pre_unpatch_callback: vmlinux
> diff --git a/tools/testing/selftests/livepatch/test-sysfs.sh b/tools/testing/selftests/livepatch/test-sysfs.sh
> index 7f76f280189a..6c646afa7395 100755
> --- a/tools/testing/selftests/livepatch/test-sysfs.sh
> +++ b/tools/testing/selftests/livepatch/test-sysfs.sh
> @@ -27,7 +27,7 @@ disable_lp $MOD_LIVEPATCH
>  
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe $MOD_LIVEPATCH
> +check_result "% insmod test_modules/$MOD_LIVEPATCH.ko
>  livepatch: enabling patch '$MOD_LIVEPATCH'
>  livepatch: '$MOD_LIVEPATCH': initializing patching transition
>  livepatch: '$MOD_LIVEPATCH': starting patching transition
> @@ -56,7 +56,7 @@ check_sysfs_value  "$MOD_LIVEPATCH" "$MOD_TARGET/patched" "0"
>  disable_lp $MOD_LIVEPATCH
>  unload_lp $MOD_LIVEPATCH
>  
> -check_result "% modprobe test_klp_callbacks_demo
> +check_result "% insmod test_modules/test_klp_callbacks_demo.ko
>  livepatch: enabling patch 'test_klp_callbacks_demo'
>  livepatch: 'test_klp_callbacks_demo': initializing patching transition
>  test_klp_callbacks_demo: pre_patch_callback: vmlinux
> @@ -64,7 +64,7 @@ livepatch: 'test_klp_callbacks_demo': starting patching transition
>  livepatch: 'test_klp_callbacks_demo': completing patching transition
>  test_klp_callbacks_demo: post_patch_callback: vmlinux
>  livepatch: 'test_klp_callbacks_demo': patching complete
> -% modprobe test_klp_callbacks_mod
> +% insmod test_modules/test_klp_callbacks_mod.ko
>  livepatch: applying patch 'test_klp_callbacks_demo' to loading module 'test_klp_callbacks_mod'
>  test_klp_callbacks_demo: pre_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
>  test_klp_callbacks_demo: post_patch_callback: test_klp_callbacks_mod -> [MODULE_STATE_COMING] Full formed, running module_init
> diff --git a/tools/testing/selftests/livepatch/test_modules/Makefile b/tools/testing/selftests/livepatch/test_modules/Makefile
> new file mode 100644
> index 000000000000..6f7c2103d27d
> --- /dev/null
> +++ b/tools/testing/selftests/livepatch/test_modules/Makefile
> @@ -0,0 +1,19 @@
> +TESTMODS_DIR := $(realpath $(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
> +KDIR ?= /lib/modules/$(shell uname -r)/build
> +
> +obj-m += test_klp_atomic_replace.o \
> +	test_klp_callbacks_busy.o \
> +	test_klp_callbacks_demo.o \
> +	test_klp_callbacks_demo2.o \
> +	test_klp_callbacks_mod.o \
> +	test_klp_livepatch.o \
> +	test_klp_state.o \
> +	test_klp_state2.o \
> +	test_klp_state3.o \
> +	test_klp_shadow_vars.o
> +
> +modules:
> +	$(Q)$(MAKE) -C $(KDIR) modules KBUILD_EXTMOD=$(TESTMODS_DIR)
> +
> +clean:
> +	$(Q)$(MAKE) -C $(KDIR) clean KBUILD_EXTMOD=$(TESTMODS_DIR)
> diff --git a/lib/livepatch/test_klp_atomic_replace.c b/tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
> similarity index 100%
> rename from lib/livepatch/test_klp_atomic_replace.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_atomic_replace.c
> diff --git a/lib/livepatch/test_klp_callbacks_busy.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_busy.c
> similarity index 100%
> rename from lib/livepatch/test_klp_callbacks_busy.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_busy.c
> diff --git a/lib/livepatch/test_klp_callbacks_demo.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
> similarity index 100%
> rename from lib/livepatch/test_klp_callbacks_demo.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo.c
> diff --git a/lib/livepatch/test_klp_callbacks_demo2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> similarity index 100%
> rename from lib/livepatch/test_klp_callbacks_demo2.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_demo2.c
> diff --git a/lib/livepatch/test_klp_callbacks_mod.c b/tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_mod.c
> similarity index 100%
> rename from lib/livepatch/test_klp_callbacks_mod.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_callbacks_mod.c
> diff --git a/lib/livepatch/test_klp_livepatch.c b/tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
> similarity index 100%
> rename from lib/livepatch/test_klp_livepatch.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_livepatch.c
> diff --git a/lib/livepatch/test_klp_shadow_vars.c b/tools/testing/selftests/livepatch/test_modules/test_klp_shadow_vars.c
> similarity index 100%
> rename from lib/livepatch/test_klp_shadow_vars.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_shadow_vars.c
> diff --git a/lib/livepatch/test_klp_state.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> similarity index 100%
> rename from lib/livepatch/test_klp_state.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_state.c
> diff --git a/lib/livepatch/test_klp_state2.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> similarity index 100%
> rename from lib/livepatch/test_klp_state2.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_state2.c
> diff --git a/lib/livepatch/test_klp_state3.c b/tools/testing/selftests/livepatch/test_modules/test_klp_state3.c
> similarity index 100%
> rename from lib/livepatch/test_klp_state3.c
> rename to tools/testing/selftests/livepatch/test_modules/test_klp_state3.c
> 
> -- 
> 2.42.0
> 


