Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00B3D19346E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Mar 2020 00:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYXQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 19:16:06 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:33838 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgCYXQG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 19:16:06 -0400
Received: by mail-il1-f193.google.com with SMTP id t11so3652246ils.1
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 16:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSRNCN/j478+x+CnZ0YXdwqIE1xrZ/myz7b/YSvrTrk=;
        b=aaHo4yEVDL1GvqdjKihvS4Vo7uEcUGRoKt6DzApCug8OYz8RyyTIf7FZYIkK8BRDjT
         Z/x1pxEZ/hPRmsQog/XjvnKI+fTOKNxA9PVfctfP/+Wbyihore6S2E9M8Bn3focb0/ns
         ggAhVp39/5+Ral0BHiplR8AjTLQDPuaHB2qvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NSRNCN/j478+x+CnZ0YXdwqIE1xrZ/myz7b/YSvrTrk=;
        b=Qd8QWaICvl/LwvAojGhWhFTmVl+X878rYePapgpE/Hhotvc9jl/xoN+B95jFKU4Qwv
         fgUtosKOot5jPmaFu3I73epWyVN9kzz/tX1snHocsW0iKbQBpud26GZdQBuv+BKSfDkd
         1z+XPdvpCAluJ0A/z+F0YGlDbGbq94nX1jJUDoOXNHGWXJdy989vHCtD91Qujd8SW1E0
         v41ivoy3YIAaSfmORlNRIJdhluGIOXQ79Qx6HTJD58TEAqH7cnjOzd6qdmNVqt/PVQbZ
         nPl1foW+6U8ykLy4RBZNAkIejed+GK9lCOVokBDtCb6hnFsE+JHr5Qx71JUIyjb9JBBK
         v19A==
X-Gm-Message-State: ANhLgQ1wFX4+2K/howtP6+jiMBjMEcLEE4QafGXwAhXyENDBRnM2dCCP
        afXJ8Hr9kN8MaB4VBz/YhBz8zw==
X-Google-Smtp-Source: ADFU+vuIrCnX89jT/0He3a9PY5pOYUMa56VJw947AmN53eBLnKN2LzOLpyZAJbEaD9qMy8NGpHiNUg==
X-Received: by 2002:a92:778e:: with SMTP id s136mr6079726ilc.256.1585178164506;
        Wed, 25 Mar 2020 16:16:04 -0700 (PDT)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id k16sm205604ila.38.2020.03.25.16.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:16:03 -0700 (PDT)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     keescook@chromium.org, luto@amacapital.net, wad@chromium.org,
        shuah@kernel.org, mpe@ellerman.id.au
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed, 25 Mar 2020 17:16:02 -0600
Message-Id: <20200325231602.12964-1-skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_GEN_PROGS. Local header dependency
is addressed in a change to lib.mk as a framework change that
enforces the dependency without requiring changes to individual
tests.

The following use-cases work with this change:

In seccomp directory:
make all and make clean

From top level from main Makefile:
make kselftest-install O=objdir ARCH=arm64 HOSTCC=gcc \
 CROSS_COMPILE=aarch64-linux-gnu- TARGETS=seccomp

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
Changes since v3:
Simplified logic based on comments from Kees and Michael

 tools/testing/selftests/seccomp/Makefile | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..0ebfe8b0e147 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
-all:
-
-include ../lib.mk
-
-.PHONY: all clean
-
-BINARIES := seccomp_bpf seccomp_benchmark
 CFLAGS += -Wl,-no-as-needed -Wall
+LDFLAGS += -lpthread
 
-seccomp_bpf: seccomp_bpf.c ../kselftest_harness.h
-	$(CC) $(CFLAGS) $(LDFLAGS) $< -lpthread -o $@
-
-TEST_PROGS += $(BINARIES)
-EXTRA_CLEAN := $(BINARIES)
-
-all: $(BINARIES)
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
+include ../lib.mk
-- 
2.20.1

