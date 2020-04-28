Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB9D1BB290
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Apr 2020 02:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgD1ALM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Apr 2020 20:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgD1ALM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Apr 2020 20:11:12 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4835C03C1A8
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Apr 2020 17:11:10 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b12so20918210ion.8
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Apr 2020 17:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ip5XKPL15A4yt5XH2ob0YgQ09dtD4HhrbWkXwxt++Q4=;
        b=aO2dI+I3TrK3LiHDpEJ623k8hhROirWFwckfcdAn+yHCE4/y8ssmdcYfeRSVZTC5oW
         LcAYc9jiQkSh+rBVguJuac/L3bT1cx9aINMQABrzO2RX4rhdJihkHSIKBdvHPOrM7xiL
         nCAGtt7P9UdOh2lT/XNWupDaE9O9zUA1hVHGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ip5XKPL15A4yt5XH2ob0YgQ09dtD4HhrbWkXwxt++Q4=;
        b=RZAMiEcqdIWuDRrvShV5D2iHnxGOuMO8rrtpUxYaBVtsx8tZGEwX0hSG4QFWC62u9t
         Y7VqKrqhqD35rNJk21elVQQ4i1Lgke1sNUzA2JFPJqb6gerKcMVSyh08A+OeHCdVPabG
         y7H3OA+lU4Fw539cxQsL4AjaXOOgr2m4CJAN3znBmwV69EbrbZ354y7FiC4JBPmHBSVO
         qjlRsR/73aP4ypqf/aoQgPK9fnuMYt6VFJlXXIWddkYQQNVE8i+VKP0iCM8nWwNp1g0h
         991VWRhbQDcuV9cjEnrdnB13U+UThs6htJE7tad36EfMl9R5dfOKIGjXWwAaRwhkScRP
         duBg==
X-Gm-Message-State: AGi0PuarkorIA3HJx6+o2oIhWDivuvSC72jqwNcp/2ugJvIXXTQQRXF1
        GeoHY3sDaFGqBy3f3rislOsodA==
X-Google-Smtp-Source: APiQypJwOikjE0kbIVE5N7lK5n4r9xPWCPkC2mlLixbg80Xq950I2YDQgew6ClksYpcG0RUuZYsMKA==
X-Received: by 2002:a02:cbc6:: with SMTP id u6mr23777221jaq.27.1588032670022;
        Mon, 27 Apr 2020 17:11:10 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 140sm6028419ilc.44.2020.04.27.17.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 17:11:09 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     pbonzini@redhat.com, shuah@kernel.org
Cc:     Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: fix kvm relocatable native/cross builds and installs
Date:   Mon, 27 Apr 2020 18:11:07 -0600
Message-Id: <20200428001107.11281-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kvm test Makefile doesn't fully support cross-builds and installs.
UNAME_M = $(shell uname -m) variable is used to define the target
programs and libraries to be built from arch specific sources in
sub-directories.

For cross-builds to work, UNAME_M has to map to ARCH and arch specific
directories and targets in this Makefile.

UNAME_M variable to used to run the compiles pointing to the right arch
directories and build the right targets for these supported architectures.

TEST_GEN_PROGS and LIBKVM are set using UNAME_M variable.
LINUX_TOOL_ARCH_INCLUDE is set using ARCH variable.

x86_64 targets are named to include x86_64 as a suffix and directories
for includes are in x86_64 sub-directory. s390x and aarch64 follow the
same convention. "uname -m" doesn't result in the correct mapping for
s390x and aarch64. Fix it to set UNAME_M correctly for s390x and aarch64
cross-builds.

In addition, Makefile doesn't create arch sub-directories in the case of
relocatable builds and test programs under s390x and x86_64 directories
fail to build. This is a problem for native and cross-builds. Fix it to
create all necessary directories keying off of TEST_GEN_PROGS.

The following use-cases work with this change:

Native x86_64:
make O=/tmp/kselftest -C tools/testing/selftests TARGETS=kvm install \
 INSTALL_PATH=$HOME/x86_64

arm64 cross-build:
make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
	CROSS_COMPILE=aarch64-linux-gnu- defconfig

make O=$HOME/arm64_build/ ARCH=arm64 HOSTCC=gcc \
	CROSS_COMPILE=aarch64-linux-gnu- all

make kselftest-install TARGETS=kvm O=$HOME/arm64_build ARCH=arm64 \
	HOSTCC=gcc CROSS_COMPILE=aarch64-linux-gnu-

s390x cross-build:
make O=$HOME/s390x_build/ ARCH=s390 HOSTCC=gcc \
	CROSS_COMPILE=s390x-linux-gnu- defconfig

make O=$HOME/s390x_build/ ARCH=s390 HOSTCC=gcc \
	CROSS_COMPILE=s390x-linux-gnu- all

make kselftest-install TARGETS=kvm O=$HOME/s390x_build/ ARCH=s390 \
	HOSTCC=gcc CROSS_COMPILE=s390x-linux-gnu- all

No regressions in the following use-cases:
make -C tools/testing/selftests TARGETS=kvm
make kselftest-all TARGETS=kvm

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile | 29 +++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 712a2ddd2a27..b728c0a0f9b2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -5,8 +5,34 @@ all:
 
 top_srcdir = ../../../..
 KSFT_KHDR_INSTALL := 1
+
+# For cross-builds to work, UNAME_M has to map to ARCH and arch specific
+# directories and targets in this Makefile. "uname -m" doesn't map to
+# arch specific sub-directory names.
+#
+# UNAME_M variable to used to run the compiles pointing to the right arch
+# directories and build the right targets for these supported architectures.
+#
+# TEST_GEN_PROGS and LIBKVM are set using UNAME_M variable.
+# LINUX_TOOL_ARCH_INCLUDE is set using ARCH variable.
+#
+# x86_64 targets are named to include x86_64 as a suffix and directories
+# for includes are in x86_64 sub-directory. s390x and aarch64 follow the
+# same convention. "uname -m" doesn't result in the correct mapping for
+# s390x and aarch64.
+#
+# No change necessary for x86_64
 UNAME_M := $(shell uname -m)
 
+# Set UNAME_M for arm64 compile/install to work
+ifeq ($(ARCH),arm64)
+	UNAME_M := aarch64
+endif
+# Set UNAME_M s390x compile/install to work
+ifeq ($(ARCH),s390)
+	UNAME_M := s390x
+endif
+
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
@@ -53,7 +79,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
 LINUX_TOOL_INCLUDE = $(top_srcdir)/tools/include
-LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/x86/include
+LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
@@ -84,6 +110,7 @@ $(LIBKVM_OBJ): $(OUTPUT)/%.o: %.c
 $(OUTPUT)/libkvm.a: $(LIBKVM_OBJ)
 	$(AR) crs $@ $^
 
+x := $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 all: $(STATIC_LIBS)
 $(TEST_GEN_PROGS): $(STATIC_LIBS)
 
-- 
2.20.1

