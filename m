Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2080249389A
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jan 2022 11:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348533AbiASKeG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jan 2022 05:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343802AbiASKeB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jan 2022 05:34:01 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A00BC061746;
        Wed, 19 Jan 2022 02:34:01 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B49011F44460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642588440;
        bh=Ok+oNRTJoeyZh+8y6c73p7PjPSC6YypeZj6bp2whWWs=;
        h=From:To:Cc:Subject:Date:From;
        b=n7US8/u1f9kWZhQhLywVehUPFSkcpOaeBRuWBMcuc4nlETNS8TpfvWuXlFFCAMcLO
         Y3ZAIn/8aC12d1EJhLLHeMqK2Ew1NYE2FGgnSh7IRLbl40A3y7+qz6ZbEkF9z3RMFS
         rdGCRQLot31Vz9eAOFWabLBfNN67H0h6VXQ47xQQDFhR3g6+RNn6asuFJzoaFWOvSv
         haWpwQNwT26QisGKzq4aeM6XTqxNKibzB7bW3MhgrzHt7MFebLfawZz/tWgEmIguyN
         B7UYdTfIYZYsDuIL7SPXQrqRYwimbxWLtoiPLnZE7ezfk95dOQ7puLHpjxNaBFrS6Y
         BfGE8S8EnrpCw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests: futex: set DEFAULT_INSTALL_HDR_PATH
Date:   Wed, 19 Jan 2022 15:33:32 +0500
Message-Id: <20220119103332.2887370-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If only futex selftest is compiled, uapi header files are copied to the
selftests/futex/functional directory. This copy isn't needed. Set the
DEFAULT_INSTALL_HDR_PATH variable to 1 to use the default header install
path only. This removes extra copy of header file.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/futex/functional/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 5cc38de9d8ea..9a8c3700d773 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -24,6 +24,7 @@ TEST_PROGS := run.sh
 
 top_srcdir = ../../../../..
 KSFT_KHDR_INSTALL := 1
+DEFAULT_INSTALL_HDR_PATH := 1
 include ../../lib.mk
 
 $(TEST_GEN_FILES): $(HEADERS)
-- 
2.30.2

