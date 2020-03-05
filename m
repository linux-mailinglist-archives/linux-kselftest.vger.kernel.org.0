Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6D179CDF
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Mar 2020 01:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388597AbgCEAgh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 19:36:37 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42737 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388407AbgCEAgh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 19:36:37 -0500
Received: by mail-io1-f68.google.com with SMTP id q128so4523542iof.9
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 16:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIvX0AGMbgxv4/m6WT+pMJ8EIpqBiUC/PmxWkNGeTko=;
        b=PhSdLw/yrpS/dRaAl33LSLQA0eklLHbyPx2WtBHA5gt3yB5fopfsk4mxkA+52xvqhX
         LgFLy9u42Z2GC79/HmsDVlsg17To6S25aq6YzK7mzm+e8wSy4WoIKI7fwio8eyTX8hfl
         TtTlUG7aQahYP7QAvSO2Ta5+kunpzaYoYdcdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KIvX0AGMbgxv4/m6WT+pMJ8EIpqBiUC/PmxWkNGeTko=;
        b=E4GMLgVXAdtxlsFWJceZi8lMfdyKlJwKfXzQekvVcwKkB0Jtl2ed7wKatqDEJpxpss
         8Lm/mQ/O9fDo12042u9jhyEMtdvrIYDXzYGOOf0TVjn7C+Rlywu8LRRZPBOBS+UA0AJ4
         rVVeKQW9GrqA3FabZLGFe+oWCksFKICynL29lF5sf8YzyOnF754fyVdvAzK0qHpvB8Xx
         36O7iFiojLCMSdG1OgjlvjbrBkoOBYWoxr0q/yf+pnYVJ5i07vrbeqEcj+ntG3szMpCS
         wwotN2HqJG5B14Rmbso5rT+wNMnhJGpEjkh296gfqBCOE1AVuiSiBp3DLG1Z7/JJKS8T
         hVCg==
X-Gm-Message-State: ANhLgQ0f2JN5EjJYMxudPsD6I/4KdFi0ZixBr3OzLD0F226FwXgUQoMk
        422pICM/IMBF6OK9nqJNbUYSmw==
X-Google-Smtp-Source: ADFU+vu80pHUWuXIar7a/NeiyuPykachkqRMBLRI9m0O4J+f56mz7RGfR/avLQkVaOPdAnh7e3ivfA==
X-Received: by 2002:a5e:c70c:: with SMTP id f12mr1029310iop.130.1583368596452;
        Wed, 04 Mar 2020 16:36:36 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id y14sm2828404ilb.29.2020.03.04.16.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 16:36:35 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH v2 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed,  4 Mar 2020 17:36:27 -0700
Message-Id: <20200305003627.31900-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_CUSTOM_PROGS to continue to do custom
build to preserve dependency on kselftest_harness.h local header.
This change applies cutom rule to seccomp_bpf seccomp_benchmark
for a simpler logic. 

Uses $(OUTPUT) defined in lib.mk to handle build relocation.

The following use-cases work with this change:

In seccomp directory:
make all and make clean

From top level from main Makefile:
make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
 CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/Makefile | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..355bcbc0394a 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
+CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
 .PHONY: all clean
 
-BINARIES := seccomp_bpf seccomp_benchmark
-CFLAGS += -Wl,-no-as-needed -Wall
+include ../lib.mk
+
+# OUTPUT set by lib.mk
+TEST_CUSTOM_PROGS := $(OUTPUT)/seccomp_bpf $(OUTPUT)/seccomp_benchmark
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
+$(TEST_CUSTOM_PROGS): ../kselftest_harness.h
 
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
+all: $(TEST_CUSTOM_PROGS)
 
-all: $(BINARIES)
+EXTRA_CLEAN := $(TEST_CUSTOM_PROGS)
-- 
2.20.1

