Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F22B549E940
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 18:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiA0Rq2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 12:46:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiA0Rq2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 12:46:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C65AC061714;
        Thu, 27 Jan 2022 09:46:28 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 1B44A1F45748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643305586;
        bh=6nLL0GlQ+/wvfrurvSX2IvsVTjXFgHsKVXsPLSsRHxo=;
        h=From:To:Cc:Subject:Date:From;
        b=BQ7ycocYSRMv76zvQaRiiF14784KI1VmX5/qh/dB1hDQoqv0mZJxMkr7POQp8kscb
         58mQecrYBaF2W6YWeaGLjwcZIzQ1Ap8coO0Lw+0ufs4HKkoj39Ho8LaYMP1SpO0Mge
         DQwNfYxL05ZA2IqZDoVOjs6Jd7XaY6VDgsEnYFanpP02IgfZvLLX88VSbqkVRgqql6
         8BopjtaxKfbYeRLaTZhnR1Fg+cvWq/FLd5kBQLcukL17kztAYa3+Rqpj9E9BLwFqAY
         1y8nFobL9gy/ken77qsab/gAWLAg8ufvekdn6LpkfmHAFiayDjVh4Ajt/8ctuCVmws
         9VOkZlvf3UFrA==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>,
        Bamvor Jian Zhang <bamvor.zhangjian@linaro.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: futex: Use variable MAKE instead of make
Date:   Thu, 27 Jan 2022 22:44:46 +0500
Message-Id: <20220127174447.754605-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Recursive make commands should always use the variable MAKE, not the
explicit command name ‘make’. This has benefits and removes the
following warning when multiple jobs are used for the build:

make[2]: warning: jobserver unavailable: using -j1.  Add '+' to parent make rule.

Fixes: a8ba798bc8ec ("selftests: enable O and KBUILD_OUTPUT")
Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/futex/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/futex/Makefile b/tools/testing/selftests/futex/Makefile
index 12631f0076a10..11e157d7533b8 100644
--- a/tools/testing/selftests/futex/Makefile
+++ b/tools/testing/selftests/futex/Makefile
@@ -11,7 +11,7 @@ all:
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 		if [ -e $$DIR/$(TEST_PROGS) ]; then \
 			rsync -a $$DIR/$(TEST_PROGS) $$BUILD_TARGET/; \
 		fi \
@@ -32,6 +32,6 @@ override define CLEAN
 	@for DIR in $(SUBDIRS); do		\
 		BUILD_TARGET=$(OUTPUT)/$$DIR;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		make OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$DIR $@;\
 	done
 endef
-- 
2.30.2

