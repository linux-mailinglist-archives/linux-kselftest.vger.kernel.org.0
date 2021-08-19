Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80E13F1E7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 18:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhHSQ60 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 12:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:35326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230447AbhHSQ6Z (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 12:58:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 460FE601FD;
        Thu, 19 Aug 2021 16:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629392268;
        bh=4Z1HZ0K086DZLnkbmc0mR7qpEi1HN+RlBAKc4MS6lHI=;
        h=From:To:Cc:Subject:Date:From;
        b=gg7IYKb//PtDZrWhmh1oYkdjSYiAPbFh6bzAgwS331SYDj2OyD+7zdiKXipjyL/Gq
         yd5Myx32TEFNeDRtQfoEnedI/ZA/YXYwIsphFDWzWBasMCnOAXTGjr1RL/lghAyYGa
         oN4NC5eO991jYlGyEJHXfbPih5CzkX8n9hZn+h8b+idJmWzg+YXsv/yej0/XCLbyUK
         dOaRwWvjdWZgTLyP/38DGJu2lVtG+JckksGsrP22OoSdD+tKAcXeO8TxdKh1k5XNR+
         lwNKCwD4fFJ9Y9HvKyN63eEWyPmVwkYQtWuqZ3qZcVee5vmElbI2YOyBYXez+D+cPY
         t+s3wjKm4WYgg==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc:     Boyan Karatotev <boyan.karatotev@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH] kselftest/arm64: pac: Fix skipping of tests on systems without PAC
Date:   Thu, 19 Aug 2021 17:57:23 +0100
Message-Id: <20210819165723.43903-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207; h=from:subject; bh=4Z1HZ0K086DZLnkbmc0mR7qpEi1HN+RlBAKc4MS6lHI=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhHo0e5zwWI5Jb7YrULW3YqzKg05453QjFmhcXdI6L KkKc7nmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYR6NHgAKCRAk1otyXVSH0JSiB/ wLmJrovhbkeBfjz/scIub4P3eSfyGeLxSNN+yNbWKpDnVw4fl/lC525Kwpz85Yiiv0o1NnFndfyz5R 71sViBOvVZRZec8rfIhkjzs83nlC0ZfTi2lpC1zGe5SWR0Jq6qnh9rqSbsW7BZqr/1iEb4ma8fYmkY m2/quYrZJy1kpQ8cAdtOFfgYTDSOBLYi27yo8qzEgs5a75zPXxx1JYHoJpcRWW14cxEwH2zfxHQkcw WuebSWi3Uo2e0wxhJy49JH9PABm1GnntWU5WrBDI0aLQm7OciBQEsmvSkVOfouhTuIewo551ua6Has quqtq05Tt6jQKoX6C5XOkMuSHpDaen
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The PAC tests check to see if the system supports the relevant PAC features
but instead of skipping the tests if they can't be executed they fail the
tests which makes things look like they're not working when they are.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/pauth/pac.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
index 592fe538506e..b743daa772f5 100644
--- a/tools/testing/selftests/arm64/pauth/pac.c
+++ b/tools/testing/selftests/arm64/pauth/pac.c
@@ -25,13 +25,15 @@
 do { \
 	unsigned long hwcaps = getauxval(AT_HWCAP); \
 	/* data key instructions are not in NOP space. This prevents a SIGILL */ \
-	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
+	if (!(hwcaps & HWCAP_PACA))					\
+		SKIP(return, "PAUTH not enabled"); \
 } while (0)
 #define ASSERT_GENERIC_PAUTH_ENABLED() \
 do { \
 	unsigned long hwcaps = getauxval(AT_HWCAP); \
 	/* generic key instructions are not in NOP space. This prevents a SIGILL */ \
-	ASSERT_NE(0, hwcaps & HWCAP_PACG) TH_LOG("Generic PAUTH not enabled"); \
+	if (!(hwcaps & HWCAP_PACG)) \
+		SKIP(return, "Generic PAUTH not enabled");	\
 } while (0)
 
 void sign_specific(struct signatures *sign, size_t val)
@@ -256,7 +258,7 @@ TEST(single_thread_different_keys)
 	unsigned long hwcaps = getauxval(AT_HWCAP);
 
 	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
-	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
+	ASSERT_PAUTH_ENABLED();
 	if (!(hwcaps & HWCAP_PACG)) {
 		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
 		nkeys = NKEYS - 1;
@@ -299,7 +301,7 @@ TEST(exec_changed_keys)
 	unsigned long hwcaps = getauxval(AT_HWCAP);
 
 	/* generic and data key instructions are not in NOP space. This prevents a SIGILL */
-	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled");
+	ASSERT_PAUTH_ENABLED();
 	if (!(hwcaps & HWCAP_PACG)) {
 		TH_LOG("WARNING: Generic PAUTH not enabled. Skipping generic key checks");
 		nkeys = NKEYS - 1;
-- 
2.20.1

