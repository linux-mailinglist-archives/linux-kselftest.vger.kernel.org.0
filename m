Return-Path: <linux-kselftest+bounces-8616-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 372C98ACE27
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F176B20AC8
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Apr 2024 13:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3DE14F13B;
	Mon, 22 Apr 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="IYlrk6k5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A914F134
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Apr 2024 13:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713792485; cv=none; b=p/8+Z62sUtGQNkjjIAWSyHHKVPsuQGHQ4zWBVRQ+Dh/Rr+VCyrLDBIW0Mvx4OAJCixFzhEOAShaCs8k8ZG0xI8V7fl4uGm+rOflOTB0BLLzHfI4zhRkROaZkusJumO/7/oGT6rPmfkJlvNkrS4295oUSw/yp8jQ2QK8H/e5Qe3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713792485; c=relaxed/simple;
	bh=2wVOc0LcNiAPYF1poDQ5+Qb3SUHTUJKNYzdcxm6mZa0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wstl0sKNYpbvw15Rcj1RZfjG3EBUwuGYrFSJ9Y62x8R5ZnC0/T4MCTkrHEaY6YB5UxL1UHsFosRg9JSXD2BCcF17Zny3Ho+3vAN8abQlJJ34duVCPI3rd022jIk9ehJU8Mz8ZT3glYojTpc527H2psme+m/rlm0vwRZNqnq1XEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=IYlrk6k5; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1713792480;
	bh=BQUr0fFzE7pyBmR7yj7oL7BXKgYhVK8wJb/BSyGZC+U=;
	h=From:To:Cc:Subject:Date:From;
	b=IYlrk6k5+AAq7109LfcCjFRGpDNWxuKAYgb9Td5DQfxgesiTJTHaDT+C381zX918l
	 Ln54g49t3RedpUCS30F5m/vY1+GyW90gfb5deO2ssqQaGcg/EvhOXC9il6q05sAabI
	 ddLr6DyPokwZQEKHk/cFxZi+bRed7liloxfkke+nfqqFS3hnduJtFT2f6HaZ7lEFAi
	 7Q/ebnHQtllhZbJeWMJCmr811+DCYUWGKfEZ6u9AAhegDLvLhntD7hGKbPaBtWZRIv
	 9diGcnojqDlsWhVCszZCLf1fg8CC7JJXw1sr80bYWf8+lxWtnQMOxdriEyFPyCxHZ7
	 YrO0nNPSzNIng==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VNQzh2sVGz4wbr;
	Mon, 22 Apr 2024 23:28:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <maddy@linux.ibm.com>,
	spoorthy@linux.ibm.com,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH] selftests/powerpc: Install tests in sub-directories
Date: Mon, 22 Apr 2024 23:27:46 +1000
Message-ID: <20240422132746.1790844-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The sources for the powerpc selftests are arranged into sub-directories.
However when the tests are built and installed, the sub-directories are
squashed, losing the structure.

For example, with the current code the result of installing the selftests is:

  $ tree tools/testing/selftests/kselftest_install
  tools/testing/selftests/kselftest_install
  ├── kselftest
  │   ├── ktap_helpers.sh
  │   ├── module.sh
  │   ├── prefix.pl
  │   └── runner.sh
  ├── kselftest-list.txt
  ├── powerpc
  │   ├── alignment_handler
  │   ├── attr_test
  │   ├── back_to_back_ebbs_test
  │   ├── bad_accesses
  │   ├── bhrb_filter_map_test
  │   ├── bhrb_no_crash_wo_pmu_test
  │   ├── blacklisted_events_test
  │   ├── cache_shape
  │   ├── close_clears_pmcc_test
  │   ├── context_switch
  │   ├── copy_first_unaligned
  ...
  │   ├── settings
  ...
  │   └── wild_bctr
  └── run_kselftest.sh

All the powerpc tests are squashed into the single powerpc directory. In
particular, note that there is a single `settings` file, even though
there are multiple settings files in the powerpc selftest sources. One
of the settings files ends up installed, depending on install order,
even if they have different contents.

Similarly if there were two tests with the same name in different
sub-directories they would clobber each other.

Fix it by replicating the directory structure of the source tree into
the install directory. The result being for example:

  $ tree tools/testing/selftests/kselftest_install
  tools/testing/selftests/kselftest_install
  ├── kselftest
  │   ├── ktap_helpers.sh
  │   ├── module.sh
  │   ├── prefix.pl
  │   └── runner.sh
  ├── kselftest-list.txt
  ├── powerpc
  │   ├── alignment
  │   │   ├── alignment_handler
  │   │   └── copy_first_unaligned
  │   ├── benchmarks
  │   │   ├── context_switch
  │   │   ├── exec_target
  │   │   ├── fork
  │   │   ├── futex_bench
  │   │   ├── gettimeofday
  │   │   ├── mmap_bench
  │   │   ├── null_syscall
  │   │   └── settings
  ...
  │   ├── eeh
  │   │   ├── eeh-basic.sh
  │   │   ├── eeh-functions.sh
  │   │   └── settings
  ...
  │   └── vphn
  │       └── test-vphn
  └── run_kselftest.sh

Note multiple settings files in different sub-directories.

This change also has the effect of changing the names of the tests from
the point of view of the kselftest runner. Before the tests are named
eg:

  powerpc:copy_first_unaligned
  powerpc:cache_shape
  powerpc:reg_access_test

After, the test collection names include the sub-directory:

  powerpc/alignment:copy_first_unaligned
  powerpc/cache_shape:cache_shape
  powerpc/pmu/ebb:reg_access_test

That means whereas previously all powerpc tests could be run with:

  $ ./run_kselftest.sh -c powerpc

After the change it's necessary to pass a regex that matches all powerpc
entries, eg:

  $ ./run_kselftest.sh -c "powerpc.*"

The latter form also works before and after the change.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/Makefile     | 4 ++--
 tools/testing/selftests/powerpc/pmu/Makefile | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index 2f299fd04d2d..b175e94e1901 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -52,14 +52,14 @@ endef
 override define INSTALL_RULE
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET INSTALL_PATH=$$INSTALL_PATH/$$TARGET -C $$TARGET install;\
 	done;
 endef
 
 emit_tests:
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET $@;\
 	done;
 
 override define CLEAN
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 773933e5180e..7e9dbf3d0d09 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -44,7 +44,7 @@ emit_tests:
 	done
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
-		$(MAKE) OUTPUT=$$BUILD_TARGET -s -C $$TARGET emit_tests; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET emit_tests; \
 	done;
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
@@ -52,7 +52,7 @@ override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET install; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET INSTALL_PATH=$$INSTALL_PATH/$$TARGET -C $$TARGET install; \
 	done;
 endef
 
-- 
2.44.0


