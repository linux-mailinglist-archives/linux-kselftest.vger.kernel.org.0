Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8425ADA17
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Sep 2022 22:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231979AbiIEUVY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Sep 2022 16:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiIEUVU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Sep 2022 16:21:20 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857F73123A
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Sep 2022 13:21:18 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h1so5758928wmd.3
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Sep 2022 13:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=s6+qmZykHIswHopJm6GXkh46/v6jJ28XKhPoMx9gyR0=;
        b=IB68ixwJq8ZtHVQ5ps954zxadV96jX2U0Q4gDqB1t8B+E9qMCNAXGfGzY+EI4A1Mj3
         +he9YE/7DPong/u0C7VDzSPNswkOubak2u1R2U6PSfPUDvk/2G7UHY02JiCSX4j0Zky3
         gTC+AMuFx/1GjbOPZpKvqQx4hOTSb4V20F4bGh0NgCjlrv8bwU1qyY62RN5s2553duvP
         UUSvvJ0CxW3xw99gbtVfEGza2bTTPQzbJKjkdsyUznOMfMXX8dhk4AQKVXPSRRq6Fwfv
         VojGdlfZhK1uZZA9nkvV8RszT3DU8F6drRtoJATPPioUoxtLPuo+29RUseNcQ7iJ70TW
         fRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=s6+qmZykHIswHopJm6GXkh46/v6jJ28XKhPoMx9gyR0=;
        b=Ev8QtPm6n2I1BKOnH2s6TlXWoMX/2lwr7MZecjgWIjmd2F1Tr8p/i8XWP+eqyLCjRV
         E57AnRTnc9s2+Bj0zrXIzDL3e1vz6Jeaz8vnuqSsib9xA/kRm4MyA5jDoXqvqAwXI5Y1
         SNyBYOwPO4kyJX4uq2LdWbpVTr9iGaWlnJp/hTRLpZ8MKJtrC/UWzrKDkPuV4X6s1T8E
         qD1TQ7J+Pz+IHyatwJfYkkDRZojvf/zst6TecVGaG1CzFGQbdkb0OBHeGSEl3NfTSTDY
         q6eJuW7mXw12NFCdxJkykfOUN7A4zXITqCoqdM5qZcIP1o0WTxHK4cARmSYqS5jFGXvF
         cAwA==
X-Gm-Message-State: ACgBeo0x4OcZd5hW+7rIUPqsqo3nUzo0ciJG3EIaA4pF/bSs2Ok7nuO6
        8ah7xzP8xEfR6sGFGCa3ocBGdg==
X-Google-Smtp-Source: AA6agR4PAdLVHz/FwYi5TvYFkU/TMyXG9hJTrsxld+DkrflC3RnYgzEhH4432LUi6dak3Vyy2Mfupw==
X-Received: by 2002:a7b:cc90:0:b0:3a5:3899:7be1 with SMTP id p16-20020a7bcc90000000b003a538997be1mr11408556wma.19.1662409277035;
        Mon, 05 Sep 2022 13:21:17 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id n19-20020a05600c3b9300b003a846a014c1sm19841272wms.23.2022.09.05.13.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 13:21:16 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 1/3] selftests/Make: Recursively build TARGETS list
Date:   Mon,  5 Sep 2022 21:21:06 +0100
Message-Id: <20220905202108.89338-2-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220905202108.89338-1-dima@arista.com>
References: <20220905202108.89338-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From [1]:
> Please look into a wayto invoke all of them instead of adding individual
> net/* to the main Makefile. This list seems to be growing. :)

I might have misunderstood what was suggested... Here is an attempt to
let sub-selftests define their own $(TARGETS) directories.

[1]: https://lore.kernel.org/all/aa0143bc-b0d1-69fb-c117-1e7241f0ad89@linuxfoundation.org/T/#u

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/Makefile             | 71 ++++----------------
 tools/testing/selftests/drivers/Makefile     |  7 ++
 tools/testing/selftests/filesystems/Makefile |  4 ++
 tools/testing/selftests/lib.mk               | 59 +++++++++++++++-
 tools/testing/selftests/net/Makefile         |  4 ++
 5 files changed, 85 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/drivers/Makefile

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c2064a35688b..69bb25f7b3b8 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -10,15 +10,10 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += damon
-TARGETS += drivers/dma-buf
-TARGETS += drivers/s390x/uvdevice
-TARGETS += drivers/net/bonding
+TARGETS += drivers
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
-TARGETS += filesystems/binderfs
-TARGETS += filesystems/epoll
-TARGETS += filesystems/fat
 TARGETS += firmware
 TARGETS += fpu
 TARGETS += ftrace
@@ -44,9 +39,6 @@ TARGETS += move_mount_set_group
 TARGETS += mqueue
 TARGETS += nci
 TARGETS += net
-TARGETS += net/af_unix
-TARGETS += net/forwarding
-TARGETS += net/mptcp
 TARGETS += netfilter
 TARGETS += nsfs
 TARGETS += pidfd
@@ -93,16 +85,14 @@ TARGETS_HOTPLUG += memory-hotplug
 # BPF since it has cutting edge build time dependencies which require
 # more effort to install.
 SKIP_TARGETS ?= bpf
-ifneq ($(SKIP_TARGETS),)
-	TMP := $(filter-out $(SKIP_TARGETS), $(TARGETS))
-	override TARGETS := $(TMP)
-endif
+export SKIP_TARGETS
 
 # User can set FORCE_TARGETS to 1 to require all targets to be successfully
 # built; make will fail if any of the targets cannot be built. If
 # FORCE_TARGETS is not set (the default), make will succeed if at least one
 # of the targets gets built.
 FORCE_TARGETS ?=
+export FORCE_TARGETS
 
 # Clear LDFLAGS and MAKEFLAGS when implicit rules are missing.  This provides
 # implicit rules to sub-test Makefiles which avoids build failures in test
@@ -145,6 +135,7 @@ endif
 # Prepare for headers install
 include $(top_srcdir)/scripts/subarch.include
 ARCH           ?= $(SUBARCH)
+export abs_objtree
 export BUILD
 export KHDR_INCLUDES
 
@@ -152,23 +143,7 @@ export KHDR_INCLUDES
 # all isn't the first target in the file.
 .DEFAULT_GOAL := all
 
-all:
-	@ret=1;							\
-	for TARGET in $(TARGETS); do				\
-		BUILD_TARGET=$$BUILD/$$TARGET;			\
-		mkdir $$BUILD_TARGET  -p;			\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
-				O=$(abs_objtree)		\
-				$(if $(FORCE_TARGETS),|| exit);	\
-		ret=$$((ret * $$?));				\
-	done; exit $$ret;
-
-run_tests: all
-	@for TARGET in $(TARGETS); do \
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
-				O=$(abs_objtree);		    \
-	done;
+OUTPUT := $(BUILD)
 
 hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
@@ -204,8 +179,9 @@ KSFT_INSTALL_PATH := $(abspath $(KSFT_INSTALL_PATH))
 INSTALL_PATH := $(KSFT_INSTALL_PATH)
 ALL_SCRIPT := $(INSTALL_PATH)/run_kselftest.sh
 TEST_LIST := $(INSTALL_PATH)/kselftest-list.txt
+export TEST_LIST
 
-install: all
+main_install: all
 ifdef INSTALL_PATH
 	@# Ask all targets to install their files
 	mkdir -p $(INSTALL_PATH)/kselftest
@@ -214,31 +190,14 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	install -m 744 run_kselftest.sh $(INSTALL_PATH)/
 	rm -f $(TEST_LIST)
-	@ret=1;	\
-	for TARGET in $(TARGETS); do \
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
-				O=$(abs_objtree)		\
-				$(if $(FORCE_TARGETS),|| exit);	\
-		ret=$$((ret * $$?));		\
-	done; exit $$ret;
-
-
-	@# Ask all targets to emit their test scripts
-	@# While building kselftest-list.text skip also non-existent TARGET dirs:
-	@# they could be the result of a build failure and should NOT be
-	@# included in the generated runlist.
-	for TARGET in $(TARGETS); do \
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
-		echo -ne "Emit Tests for $$TARGET\n"; \
-		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
-			-C $$TARGET emit_tests >> $(TEST_LIST); \
-	done;
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
+include lib.mk
+
+install: main_install
+
 FORMAT ?= .gz
 TAR_PATH = $(abspath ${INSTALL_PATH}/kselftest-packages/kselftest.tar${FORMAT})
 gen_tar: install
@@ -246,10 +205,4 @@ gen_tar: install
 	@tar caf ${TAR_PATH} --exclude=kselftest-packages -C ${INSTALL_PATH} .
 	@echo "Created ${TAR_PATH}"
 
-clean:
-	@for TARGET in $(TARGETS); do \
-		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
-	done;
-
-.PHONY: all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean gen_tar
+.PHONY: run_tests hotplug run_hotplug clean_hotplug run_pstore_crash gen_tar
diff --git a/tools/testing/selftests/drivers/Makefile b/tools/testing/selftests/drivers/Makefile
new file mode 100644
index 000000000000..4d4693c8efbc
--- /dev/null
+++ b/tools/testing/selftests/drivers/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TARGETS += dma-buf
+TARGETS += s390x/uvdevice
+TARGETS += net/bonding
+
+include ../lib.mk
diff --git a/tools/testing/selftests/filesystems/Makefile b/tools/testing/selftests/filesystems/Makefile
index 129880fb42d3..04fde0107d7a 100644
--- a/tools/testing/selftests/filesystems/Makefile
+++ b/tools/testing/selftests/filesystems/Makefile
@@ -4,4 +4,8 @@ CFLAGS += -I../../../../usr/include/
 TEST_GEN_PROGS := devpts_pts
 TEST_GEN_PROGS_EXTENDED := dnotify_test
 
+TARGETS += binderfs
+TARGETS += epoll
+TARGETS += fat
+
 include ../lib.mk
diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index d44c72b3abe3..026a0c5b02e1 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -33,14 +33,17 @@ else
 CC := $(CROSS_COMPILE)gcc
 endif # LLVM
 
+pwd=$(shell pwd)
 ifeq (0,$(MAKELEVEL))
     ifeq ($(OUTPUT),)
-	OUTPUT := $(shell pwd)
+	OUTPUT := $(pwd)
 	DEFAULT_INSTALL_HDR_PATH := 1
     endif
 endif
 selfdir = $(realpath $(dir $(filter %/lib.mk,$(MAKEFILE_LIST))))
 top_srcdir = $(selfdir)/../../..
+testdir = $(pwd:$(selfdir)/%=%)
+export OUTPUT
 
 # The following are built by lib.mk common compile rules.
 # TEST_CUSTOM_PROGS should be used by tests that require
@@ -52,7 +55,24 @@ TEST_GEN_PROGS := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS))
 TEST_GEN_PROGS_EXTENDED := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_PROGS_EXTENDED))
 TEST_GEN_FILES := $(patsubst %,$(OUTPUT)/%,$(TEST_GEN_FILES))
 
+ifneq ($(SKIP_TARGETS),)
+        TARGETS_REL := $(patsubst %,$(testdir)/%,$(TARGETS))
+        TMP := $(filter-out $(SKIP_TARGETS),$(TARGETS_REL))
+        override TARGETS := $(TMP:$(testdir)/%=%)
+endif
+
 all: $(TEST_GEN_PROGS) $(TEST_GEN_PROGS_EXTENDED) $(TEST_GEN_FILES)
+ifneq ($(TARGETS),)
+	@ret=1;							\
+	for TARGET in $(TARGETS); do				\
+		BUILD_TARGET=$$OUTPUT/$$TARGET;			\
+		mkdir $$BUILD_TARGET  -p;			\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET	\
+				O=$(abs_objtree)		\
+				$(if $(FORCE_TARGETS),|| exit);	\
+		ret=$$((ret * $$?));				\
+	done; exit $$ret;
+endif
 
 define RUN_TESTS
 	BASE_DIR="$(selfdir)";			\
@@ -77,6 +97,13 @@ ifdef building_out_of_srctree
 else
 	@$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS))
 endif
+ifneq ($(TARGETS),)
+	@for TARGET in $(TARGETS); do \
+		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests \
+				O=$(abs_objtree);		    \
+	done;
+endif
 
 define INSTALL_SINGLE_RULE
 	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
@@ -97,6 +124,29 @@ endef
 install: all
 ifdef INSTALL_PATH
 	$(INSTALL_RULE)
+ifneq ($(TARGETS),)
+	@ret=1;	\
+	for TARGET in $(TARGETS); do \
+		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install \
+				O=$(abs_objtree)		\
+				$(if $(FORCE_TARGETS),|| exit);	\
+		ret=$$((ret * $$?));		\
+	done; exit $$ret;
+
+
+	@# Ask all targets to emit their test scripts
+	@# While building kselftest-list.text skip also non-existent TARGET dirs:
+	@# they could be the result of a build failure and should NOT be
+	@# included in the generated runlist.
+	for TARGET in $(TARGETS); do \
+		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		[ ! -d $(INSTALL_PATH)/$$TARGET ] && echo "Skipping non-existent dir: $$TARGET" && continue; \
+		echo -ne "Emit Tests for $$TARGET\n"; \
+		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET COLLECTION=$$TARGET \
+			-C $$TARGET emit_tests >> $(TEST_LIST); \
+	done;
+endif # ifneq ($(TARGETS),)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
@@ -118,6 +168,13 @@ endef
 
 clean:
 	$(CLEAN)
+ifneq ($(TARGETS),)
+	@for TARGET in $(TARGETS); do \
+		BUILD_TARGET=$$OUTPUT/$$TARGET;	\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+	done;
+endif
+
 
 # When make O= with kselftest target from main level
 # the following aren't defined.
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index c0ee2955fe54..ef768c0992f5 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -66,6 +66,10 @@ TEST_GEN_FILES += io_uring_zerocopy_tx
 
 TEST_FILES := settings
 
+TARGETS += af_unix
+TARGETS += forwarding
+TARGETS += mptcp
+
 include ../lib.mk
 
 include bpf/Makefile
-- 
2.37.2

