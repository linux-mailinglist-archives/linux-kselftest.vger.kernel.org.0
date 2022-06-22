Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720715552E8
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jun 2022 19:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376397AbiFVR7B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 22 Jun 2022 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376714AbiFVR6b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 22 Jun 2022 13:58:31 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC7826563
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 10:58:29 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1048b8a38bbso6718848fac.12
        for <linux-kselftest@vger.kernel.org>; Wed, 22 Jun 2022 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=zUajASBiQjHAZhnPOiOhijZT69w/khebQsFCRqwrBWg=;
        b=dyCCzi1meBRMQu6ugcIRNgKFAUqiyWIwMRcVvFBCJ8C9U0Ih1bjpQz1f8setXQieRN
         DI6LZYshkQ6PKYaavyfMtwa1rUjXyXyPOHuUDKDic/F/B07IE+juuttK4eXNefNbPSna
         Ojpy5EBs87pUa/uKWlrwQV5036etVMQlBON6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=zUajASBiQjHAZhnPOiOhijZT69w/khebQsFCRqwrBWg=;
        b=OcBU76JErpd7I/QBi0MZkI5vSLYyMRUggiv8cZ3YcsevtQloJV5ntY6ANvXNHHcdhQ
         8gPFLRCZF/rol+1LbhtIbsFmgWYWiSit2yGIV5M3zHxWti5Kqhl4vLsK6g+SHjWGpIH5
         MCZOgDvKTVdRdIAXe5+Yyo76aV9vr/HWcfZ9xUqekN4cdRRv5VBfpWeODDzJQZhjvyPq
         ugrwNbPrpI6u4gCEBaNV1CL0Rqke9LBjb3DtkunBE2uttG71ZvFcERRL7hcRF24U+2dL
         UcmdVzoE2Ed84EINEHWg1F9y1sANXaodq1OMNU0251Lk2CDGKzpe5O+eHV67igy7wAHQ
         kWJQ==
X-Gm-Message-State: AJIora8/4hvIhz82SkCjLiAeYx6lkpQTAZ4IrSqoSicyJe0vOAGj7U7t
        h03KTEQJ87DxWyZ5J8EyTc5Knvvc6UeaOA==
X-Google-Smtp-Source: AGRyM1vUbtfCh50xzZtbEhJ6b0A3Z5MVSz7r1DkRc0PxGTKuuQq2qtOzJiN98nJqsdqgISApqkm9AQ==
X-Received: by 2002:a05:6870:78f:b0:f2:c91f:1b0a with SMTP id en15-20020a056870078f00b000f2c91f1b0amr25471335oab.299.1655920709264;
        Wed, 22 Jun 2022 10:58:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id bi6-20020a056808188600b0032e442f6a72sm11631440oib.40.2022.06.22.10.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 10:58:28 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kselftest fixes update for Linux 5.19-rc4
Message-ID: <477c2f03-a733-cd05-2551-759de9273cff@linuxfoundation.org>
Date:   Wed, 22 Jun 2022 11:58:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------2F3D1A702E73BF4F538B8002"
Content-Language: en-US
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------2F3D1A702E73BF4F538B8002
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kselftest fixes update for Linux 5.19-rc4

This Kselftest fixes update for Linux 5.19-rc4 consists of compile
time fixes and run-time resources leaks.

-- Fix clang cross compilation
-- Fix resource leak when return error
-- fix compile error for dma_map_benchmark
-- Fix regression - make use of GUP_TEST_FILE macro

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

   Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-fixes-5.19-rc4

for you to fetch changes up to 9b4d5c01eb234f66a15a746b1c73e10209edb199:

   selftests: make use of GUP_TEST_FILE macro (2022-06-16 17:05:50 -0600)

----------------------------------------------------------------
linux-kselftest-fixes-5.19-rc4

This Kselftest fixes update for Linux 5.19-rc4 consists of compile
time fixes and run-time resources leaks.

-- Fix clang cross compilation
-- Fix resource leak when return error
-- fix compile error for dma_map_benchmark
-- Fix regression - make use of GUP_TEST_FILE macro

----------------------------------------------------------------
Ding Xiang (1):
       selftests: vm: Fix resource leak when return error

Joel Savitz (1):
       selftests: make use of GUP_TEST_FILE macro

Mark Brown (1):
       selftests: Fix clang cross compilation

Yu Liao (1):
       selftests dma: fix compile error for dma_map_benchmark

  tools/testing/selftests/dma/Makefile            |  1 +
  tools/testing/selftests/dma/dma_map_benchmark.c |  2 +-
  tools/testing/selftests/lib.mk                  | 25 +++++++++++++++++++++++--
  tools/testing/selftests/vm/gup_test.c           |  4 ++--
  tools/testing/selftests/vm/ksm_tests.c          |  2 ++
  5 files changed, 29 insertions(+), 5 deletions(-)

----------------------------------------------------------------

--------------2F3D1A702E73BF4F538B8002
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-fixes-5.19-rc4.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-fixes-5.19-rc4.diff"

diff --git a/tools/testing/selftests/dma/Makefile b/tools/testing/selftests/dma/Makefile
index aa8e8b5b3864..cd8c5ece1cba 100644
--- a/tools/testing/selftests/dma/Makefile
+++ b/tools/testing/selftests/dma/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 CFLAGS += -I../../../../usr/include/
+CFLAGS += -I../../../../include/
 
 TEST_GEN_PROGS := dma_map_benchmark
 
diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
index c3b3c09e995e..5c997f17fcbd 100644
--- a/tools/testing/selftests/dma/dma_map_benchmark.c
+++ b/tools/testing/selftests/dma/dma_map_benchmark.c
@@ -10,8 +10,8 @@
 #include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/mman.h>
-#include <linux/map_benchmark.h>
 #include <linux/types.h>
+#include <linux/map_benchmark.h>
 
 #define NSEC_PER_MSEC	1000000L
 
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 2a2d240cdc1b..1a5cc3cd97ec 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -7,10 +7,31 @@ else ifneq ($(filter -%,$(LLVM)),)
 LLVM_SUFFIX := $(LLVM)
 endif
 
-CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX)
+CLANG_TARGET_FLAGS_arm          := arm-linux-gnueabi
+CLANG_TARGET_FLAGS_arm64        := aarch64-linux-gnu
+CLANG_TARGET_FLAGS_hexagon      := hexagon-linux-musl
+CLANG_TARGET_FLAGS_m68k         := m68k-linux-gnu
+CLANG_TARGET_FLAGS_mips         := mipsel-linux-gnu
+CLANG_TARGET_FLAGS_powerpc      := powerpc64le-linux-gnu
+CLANG_TARGET_FLAGS_riscv        := riscv64-linux-gnu
+CLANG_TARGET_FLAGS_s390         := s390x-linux-gnu
+CLANG_TARGET_FLAGS_x86          := x86_64-linux-gnu
+CLANG_TARGET_FLAGS              := $(CLANG_TARGET_FLAGS_$(ARCH))
+
+ifeq ($(CROSS_COMPILE),)
+ifeq ($(CLANG_TARGET_FLAGS),)
+$(error Specify CROSS_COMPILE or add '--target=' option to lib.mk
+else
+CLANG_FLAGS     += --target=$(CLANG_TARGET_FLAGS)
+endif # CLANG_TARGET_FLAGS
+else
+CLANG_FLAGS     += --target=$(notdir $(CROSS_COMPILE:%-=%))
+endif # CROSS_COMPILE
+
+CC := $(LLVM_PREFIX)clang$(LLVM_SUFFIX) $(CLANG_FLAGS) -fintegrated-as
 else
 CC := $(CROSS_COMPILE)gcc
-endif
+endif # LLVM
 
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 6bb36ca71cb5..a309876d832f 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -209,7 +209,7 @@ int main(int argc, char **argv)
 	if (write)
 		gup.gup_flags |= FOLL_WRITE;
 
-	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	gup_fd = open(GUP_TEST_FILE, O_RDWR);
 	if (gup_fd == -1) {
 		switch (errno) {
 		case EACCES:
@@ -224,7 +224,7 @@ int main(int argc, char **argv)
 			printf("check if CONFIG_GUP_TEST is enabled in kernel config\n");
 			break;
 		default:
-			perror("failed to open /sys/kernel/debug/gup_test");
+			perror("failed to open " GUP_TEST_FILE);
 			break;
 		}
 		exit(KSFT_SKIP);
diff --git a/tools/testing/selftests/vm/ksm_tests.c b/tools/testing/selftests/vm/ksm_tests.c
index 2fcf24312da8..f5e4e0bbd081 100644
--- a/tools/testing/selftests/vm/ksm_tests.c
+++ b/tools/testing/selftests/vm/ksm_tests.c
@@ -54,6 +54,7 @@ static int ksm_write_sysfs(const char *file_path, unsigned long val)
 	}
 	if (fprintf(f, "%lu", val) < 0) {
 		perror("fprintf");
+		fclose(f);
 		return 1;
 	}
 	fclose(f);
@@ -72,6 +73,7 @@ static int ksm_read_sysfs(const char *file_path, unsigned long *val)
 	}
 	if (fscanf(f, "%lu", val) != 1) {
 		perror("fscanf");
+		fclose(f);
 		return 1;
 	}
 	fclose(f);

--------------2F3D1A702E73BF4F538B8002--
