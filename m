Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597625BD5A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Sep 2022 22:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiISUUL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Sep 2022 16:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiISUUJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Sep 2022 16:20:09 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BC3E762
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 13:20:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id e18so324351wmq.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Sep 2022 13:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=6xMNpFDctbrTqt09QWL6lfcORm/k7xdMzm5dO9m+m64=;
        b=LzIVQMdGkm9781IqbRx66sZFQ7BVTsW4FrkWL1KPxCt4Bj5KToj+qad547N7m6uZe8
         D5+C7Rz4jWgwY4dYh2iuTLyT4i9DGiVAi5v3v3a0WLpk6vYCncDUjVsLLNAUmYdd5LFX
         NrVtvKLpt+MnKbKz11zAa0vP2FPYH+NNxN6ypshDRZnwkovQiPs8HbWEeJCkTagdOJCu
         qbjJRp6udZtkWQ+IDXzOvwFBJr7IJpuk947JHOg9z1pIVM3z5yQTh2pOf2lzXrmVDSvk
         g3rIFl+avVkENbkuz/pZdEfZyDtDPmXEQGYef0Yu2XRMHtIaDMQIgFV5CDimhOuu77hB
         zpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=6xMNpFDctbrTqt09QWL6lfcORm/k7xdMzm5dO9m+m64=;
        b=I4QycXar6DdC/+eYCS8qVLmuOuH6N47wUwJiohL9eBexrJOfy6+Hvuc4+1MJM44MMh
         BXL1aDl35NvrgvS83QGB8ViuHsatT+iJ/XgT8mgA+wg2y1gJBJbaeZ5Gp6cRellFI/qb
         H+qc9dJGZ4B+ocVbtR0Q8iszXbigFvgIfOAl+fx5bPntEhzz1fG/d41DDhpF7ZCvGac8
         q7vdaF/OgFT0FaHXFFCW/5+eKRmNj0VyDV1ayxKh/SMfRC2sFpdQAow2QAbHozDn3Dy1
         IbYSzQf1QEKZP9EzZ5IcRpGVoTOmiGFto48GzKkiogt/ldizkbEkqhNjeYHmFgQpS3x2
         b+SQ==
X-Gm-Message-State: ACrzQf1KRDtC/S3+LemeatjBKWe7m1qqaPT6mUoSjU3rF+sa5UG7ylaD
        o3kI1fD3MxxuC6UCljrf0rrmew==
X-Google-Smtp-Source: AMsMyM7EnWFZNaeHlqiYqTvahJjboUWoA3yBE+bQe4jeahvxWA2v1tUsR8AiP91T6Hgj8NrI4mDRgA==
X-Received: by 2002:a1c:38c1:0:b0:3b4:a8c8:2558 with SMTP id f184-20020a1c38c1000000b003b4a8c82558mr13639961wma.82.1663618806514;
        Mon, 19 Sep 2022 13:20:06 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b003b47e8a5d22sm17342849wmq.23.2022.09.19.13.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 13:20:05 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <dima@arista.com>, Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        linux-kselftest@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 1/2] selftests/Make: Recursively build TARGETS list
Date:   Mon, 19 Sep 2022 21:19:57 +0100
Message-Id: <20220919201958.279545-2-dima@arista.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220919201958.279545-1-dima@arista.com>
References: <20220919201958.279545-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 tools/testing/selftests/lib.mk               | 60 ++++++++++++++++-
 tools/testing/selftests/net/Makefile         |  4 ++
 5 files changed, 86 insertions(+), 60 deletions(-)
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
index d44c72b3abe3..7aed8dd54da8 100644
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
@@ -97,6 +124,30 @@ endef
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
+ifneq ($(TEST_LIST),)
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
+endif # ifneq ($(TEST_LIST),)
+endif # ifneq ($(TARGETS),)
 else
 	$(error Error: set INSTALL_PATH to use install)
 endif
@@ -118,6 +169,13 @@ endef
 
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

