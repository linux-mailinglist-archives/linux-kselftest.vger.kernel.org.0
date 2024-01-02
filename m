Return-Path: <linux-kselftest+bounces-2592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED378224BF
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 23:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F77A1C22B19
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jan 2024 22:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212891772E;
	Tue,  2 Jan 2024 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TM9Jwa1p"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548F01772A
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Jan 2024 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704234685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WxX/DwYRiytQqrsyv6xPbUj6O86YcsayJdMC1Rh079w=;
	b=TM9Jwa1psXALhsjwGR1vRVu0TzU07A3kPdV1UKoGZI81ae/VkbBs44unakvJ3W3Dgnv+QR
	vWH52G6l40d/stVWjVB4DO9IWOXdx6NRhg+HEUcptKlxRgf6ksQrjnEbLCqqmTeRZinLtv
	FKYZCHDutwoRmU/t0PMmD24ZTCEJBIc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-102-41CIv6mVMvuFpQ2fC74M9w-1; Tue, 02 Jan 2024 17:31:21 -0500
X-MC-Unique: 41CIv6mVMvuFpQ2fC74M9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E456D848A64;
	Tue,  2 Jan 2024 22:31:20 +0000 (UTC)
Received: from redhat.com (unknown [10.22.9.153])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3ED1040C6EB9;
	Tue,  2 Jan 2024 22:31:20 +0000 (UTC)
Date: Tue, 2 Jan 2024 17:31:18 -0500
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
Subject: Re: [PATCH RESEND v4 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR
 variable
Message-ID: <ZZSOtsbzpy2mvmUC@redhat.com>
References: <20231220-send-lp-kselftests-v4-0-3458ec1b1a38@suse.com>
 <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231220-send-lp-kselftests-v4-1-3458ec1b1a38@suse.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Wed, Dec 20, 2023 at 01:53:12PM -0300, Marcos Paulo de Souza wrote:
> Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
> a directory containing kernel modules that will be used by
> selftest scripts.
> 
> The modules are built as external modules for the running kernel.
> As a result they are always binary compatible and the same tests
> can be used for older or newer kernels.
> 
> The build requires "kernel-devel" package to be installed.
> For example, in the upstream sources, the rpm devel package
> is produced by "make rpm-pkg"
> 
> The modules can be built independently by
> 
>   make -C tools/testing/selftests/livepatch/
> 
> or they will be automatically built before running the tests via
> 
>   make -C tools/testing/selftests/livepatch/ run_tests
> 
> Note that they are _not_ built when running the standalone
> tests by calling, for example, ./test-state.sh.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  Documentation/dev-tools/kselftest.rst |  4 ++++
>  tools/testing/selftests/lib.mk        | 20 +++++++++++++++-----
>  2 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
> index ab376b316c36..7f3582a67318 100644
> --- a/Documentation/dev-tools/kselftest.rst
> +++ b/Documentation/dev-tools/kselftest.rst
> @@ -245,6 +245,10 @@ Contributing new tests (details)
>     TEST_PROGS, TEST_GEN_PROGS mean it is the executable tested by
>     default.
>  
> +   TEST_GEN_MODS_DIR should be used by tests that require modules to be built
> +   before the test starts. The variable will contain the name of the directory
> +   containing the modules.
> +
>     TEST_CUSTOM_PROGS should be used by tests that require custom build
>     rules and prevent common build rule use.
>  
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 118e0964bda9..6c7c5a0112cf 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -70,12 +70,15 @@ KHDR_INCLUDES := -isystem $(KHDR_DIR)
>  # TEST_PROGS are for test shell scripts.
>  # TEST_CUSTOM_PROGS and TEST_PROGS will be run by common run_tests
>  # and install targets. Common clean doesn't touch them.
> +# TEST_GEN_MODS_DIR is used to specify a directory with modules to be built
> +# before the test executes. These modules are cleaned on the clean target as well.
>  TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
>  TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
>  TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
> +TEST_GEN_MODS_DIR := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_MODS_DIR))
>  
>  all: kernel_header_files $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) \
> -     $(TEST_GEN_FILES)
> +     $(TEST_GEN_FILES) $(if $(TEST_GEN_MODS_DIR),gen_mods_dir)
>  
>  kernel_header_files:
>  	@ls $(KHDR_DIR)/linux/*.h >/dev/null 2>/dev/null;                      \
> @@ -105,8 +108,8 @@ endef
>  
>  run_tests: all
>  ifdef building_out_of_srctree
> -	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)" != "X" ]; then \
> -		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
> +	@if [ "X$(TEST_PROGS)$(TEST_PROGS_EXTENDED)$(TEST_FILES)$(TEST_GEN_MODS_DIR)" != "X" ]; then \
> +		rsync -aq --copy-unsafe-links $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(TEST_GEN_MODS_DIR) $(OUTPUT); \
>  	fi
>  	@if [ "X$(TEST_PROGS)" != "X" ]; then \
>  		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
> @@ -118,6 +121,12 @@ else
>  	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
>  endif
>  
> +gen_mods_dir:
> +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR)
> +
> +clean_mods_dir:
> +	$(Q)$(MAKE) -C $(TEST_GEN_MODS_DIR) clean
> +
>  define INSTALL_SINGLE_RULE
>  	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
>  	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links $(INSTALL_LIST) $(INSTALL_PATH)/)
> @@ -131,6 +140,7 @@ define INSTALL_RULE
>  	$(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
>  	$(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
>  	$(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
> +	$(eval INSTALL_LIST = $(TEST_GEN_MODS_DIR)) $(INSTALL_SINGLE_RULE)

Hi Marcos,

Sorry for the late reply on this, but I'm reviewing this version by
trying to retrofit it into our selftest packaging (pre-build the test
module .ko's and stash those into an rpm rather than building on the
test host).

Since $TEST_GEN_MODS_DIR is treated as a directory, I found that the
selftest install target copies a bunch of intermediate object and kbuild
files:

  $ mkdir /tmp/test-install
  $ make KDIR=$(pwd) INSTALL_PATH=/tmp/test-install TARGETS=livepatch \
       -C tools/testing/selftests/ install

  [ ... builds livepatch selftests ... ]

the rsync in question:

  rsync -a --copy-unsafe-links /home/jolawren/src/kernel/tools/testing/selftests/livepatch/test_modules /tmp/test-install/livepatch/
  ...

and then looking at the destination:

  $ tree -a /tmp/test-install/
  /tmp/test-install/
  ├── kselftest
  │   ├── module.sh
  │   ├── prefix.pl
  │   └── runner.sh
  ├── kselftest-list.txt
  ├── livepatch
  │   ├── config
  │   ├── functions.sh
  │   ├── settings
  │   ├── test-callbacks.sh
  │   ├── test-ftrace.sh
  │   ├── test_klp-call_getpid
  │   ├── test-livepatch.sh
  │   ├── test_modules
  │   │   ├── Makefile
  │   │   ├── modules.order
  │   │   ├── .modules.order.cmd
  │   │   ├── Module.symvers
  │   │   ├── .Module.symvers.cmd
  │   │   ├── test_klp_atomic_replace.c
  │   │   ├── test_klp_atomic_replace.ko
  │   │   ├── .test_klp_atomic_replace.ko.cmd
  │   │   ├── test_klp_atomic_replace.mod
  │   │   ├── test_klp_atomic_replace.mod.c
  │   │   ├── .test_klp_atomic_replace.mod.cmd
  │   │   ├── test_klp_atomic_replace.mod.o
  │   │   ├── .test_klp_atomic_replace.mod.o.cmd
  │   │   ├── test_klp_atomic_replace.o
  │   │   ├── .test_klp_atomic_replace.o.cmd
  ...

On the other hand, variables like $TEST_GEN_FILES specify individual
files, so only final binaries like test_klp-call_getpid (and not
test_klp-call_getpid.c) are copied to $INSTALL_PATH.

Since the selftest module builds appear to ignore
CONFIG_MODULE_COMPRESS_* the smallest tweak I can think of to avoid the
above scenario is:

  --- a/tools/testing/selftests/lib.mk
  +++ b/tools/testing/selftests/lib.mk
  @@ -106,7 +106,7 @@ define INSTALL_RULE
          $(eval INSTALL_LIST = $(TEST_CUSTOM_PROGS)) $(INSTALL_SINGLE_RULE)
          $(eval INSTALL_LIST = $(TEST_GEN_PROGS_EXTENDED)) $(INSTALL_SINGLE_RULE)
          $(eval INSTALL_LIST = $(TEST_GEN_FILES)) $(INSTALL_SINGLE_RULE)
  -       $(eval INSTALL_LIST = $(TEST_GEN_MODS_DIR)) $(INSTALL_SINGLE_RULE)
  +       $(eval INSTALL_LIST = $(shell sed 's/.o$$/.ko/' $(TEST_GEN_MODS_DIR)/modules.order)) $(INSTALL_SINGLE_RULE)
          $(eval INSTALL_LIST = $(wildcard config settings)) $(INSTALL_SINGLE_RULE)
   endef

However, that will copy .ko's directly into $INSTALL_PATH and out of the
$TEST_GEN_MODS_DIR subdirectory(s), so maybe not a great solution after
all.

Anyway, I thought I might mention this in case it runs against the
spirit of the selftest install target.  I only tripped over it while
digging into the bowels of our kernel specfile and discovered that it
invoked this target.

--
Joe


