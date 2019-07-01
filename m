Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3585BC51
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Jul 2019 15:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfGANEf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Jul 2019 09:04:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46786 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGANEf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Jul 2019 09:04:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1hhvyx-0001Zp-LY; Mon, 01 Jul 2019 13:04:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Shuah Khan <shuah@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kselftest@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] selftests/x86: fix spelling mistake "FAILT" -> "FAIL"
Date:   Mon,  1 Jul 2019 14:04:31 +0100
Message-Id: <20190701130431.13391-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is an spelling mistake in an a test error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 tools/testing/selftests/x86/test_vsyscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/test_vsyscall.c b/tools/testing/selftests/x86/test_vsyscall.c
index 4602326b8f5b..a4f4d4cf22c3 100644
--- a/tools/testing/selftests/x86/test_vsyscall.c
+++ b/tools/testing/selftests/x86/test_vsyscall.c
@@ -451,7 +451,7 @@ static int test_vsys_x(void)
 		printf("[OK]\tExecuting the vsyscall page failed: #PF(0x%lx)\n",
 		       segv_err);
 	} else {
-		printf("[FAILT]\tExecution failed with the wrong error: #PF(0x%lx)\n",
+		printf("[FAIL]\tExecution failed with the wrong error: #PF(0x%lx)\n",
 		       segv_err);
 		return 1;
 	}
-- 
2.20.1

