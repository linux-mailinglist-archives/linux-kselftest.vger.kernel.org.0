Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5592E179B8E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Mar 2020 23:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388490AbgCDWOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Mar 2020 17:14:21 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39583 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388484AbgCDWOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Mar 2020 17:14:21 -0500
Received: by mail-io1-f68.google.com with SMTP id h3so4210325ioj.6
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Mar 2020 14:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=I4UUtFHvX08Sx91UacVsT5PS2tj7qzVvr6l/ln4WrvjZxc/i8jv/oFJQOcNxDSmPBd
         ybh5nq8cpARJYCIJvgXwLurW1TEnq2g9Nv81GdPBn4liETzXdczFoTIvy6Zw3R1y+sam
         aa2bFrPARsOlrcGFyug0jM1U6XwTvVb4XBbbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0yZwBZUwL8PIwAcU8o7bWc8CP5XNPRFSTvCyJ7jQ5mQ=;
        b=SrKn1L5pWxTMqMlAYuIbrX6PazRY3uCChvCqYgKBDHd1Eaxwe27yHj/LfvlPSJdzAJ
         8JRRTxUDQBKVIpf87o4kNhYaqwJAvrQcH4JTe4cp5jIk4HDEeJ7tgSmONR9BUwrAXDCW
         Yx1a2ZNe24VnSRigZMIXRpVgN7Afs8A8tANuIQFsYJrUfYInU8fwElz0UvyDf9zUpclF
         St4I4LhG639JPqP2BGHbBexWhJ++UuvNrseonIA5g1b91NF0JZqcUvUh0KnanxNuBMep
         opf3QVnDThFtzG7+2eLyvKDUBT4x5Co9p906gSp3vaHvvK1DbjBcJlBgTefFbV4HB/4M
         sniw==
X-Gm-Message-State: ANhLgQ3gJ3/pC1ldtTj1X1NHG7/JhYXRgp2O+tNRf8jtxqoPIlzthRmf
        JPBKuOym3qlbwjnNaENqDtbl9w==
X-Google-Smtp-Source: ADFU+vu9yfqsq5F9oa+zo3RCZeuK0hGfEJ8oFClTaKU0IJAaGmFuBoMBmSAKAqtJ7WlWRbKZ5R7jew==
X-Received: by 2002:a5d:9697:: with SMTP id m23mr4104634ion.45.1583360060224;
        Wed, 04 Mar 2020 14:14:20 -0800 (PST)
Received: from shuah-t480s.internal (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id g12sm6850409iom.5.2020.03.04.14.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:14:19 -0800 (PST)
From:   Shuah Khan <skhan@linuxfoundation.org>
To:     shuah@kernel.org, keescook@chromium.org, luto@amacapital.net,
        wad@chromium.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andriin@fb.com, gregkh@linuxfoundation.org, tglx@linutronix.de
Cc:     Shuah Khan <skhan@linuxfoundation.org>, khilman@baylibre.com,
        mpe@ellerman.id.au, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH 2/4] selftests: Fix seccomp to support relocatable build (O=objdir)
Date:   Wed,  4 Mar 2020 15:13:33 -0700
Message-Id: <11967e5f164f0cd717921bd382ff9c13ef740146.1583358715.git.skhan@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1583358715.git.skhan@linuxfoundation.org>
References: <cover.1583358715.git.skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix seccomp relocatable builds. This is a simple fix to use the
right lib.mk variable TEST_GEN_PROGS for objects to leverage
lib.mk common framework for relocatable builds.

Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/seccomp/Makefile | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/seccomp/Makefile b/tools/testing/selftests/seccomp/Makefile
index 1760b3e39730..a8a9717fc1be 100644
--- a/tools/testing/selftests/seccomp/Makefile
+++ b/tools/testing/selftests/seccomp/Makefile
@@ -1,17 +1,7 @@
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
+TEST_GEN_PROGS := seccomp_bpf seccomp_benchmark
 
-all: $(BINARIES)
+include ../lib.mk
-- 
2.20.1

