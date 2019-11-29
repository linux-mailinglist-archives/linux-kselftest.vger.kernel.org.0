Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E92F10D121
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2019 06:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbfK2FwA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Nov 2019 00:52:00 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45909 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbfK2FwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Nov 2019 00:52:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id d20so827474ljc.12;
        Thu, 28 Nov 2019 21:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZpOjVOBEWa5QEebmVIj3lCqVSR7NBCDtDVquQ2awsU=;
        b=rdmEkGmNXhSrrSCnLtL5scTcy/manrkI/KCLkqqwqOPnujZt5knlhlRIejGhp2P9xD
         54ANaSexDgR5PmO2lFzG8tGEmz8ww5hn9N5FIk/GhDOKQFQRq7hnzZdW45FKXnHjn2Wv
         kAXWzexI2B58j8yPPs+6yanFvUkDoJwD9yGwls6hXVvADMLWgP6KJim7r2nDiGXg3E0F
         k+StnmXrGOjM9/V2gw6G5BdWN5MmHo6N6Ajp5BgiPauggUI0EaHAKkj1p6NsEMn1nM5d
         e2KwNBKAWpDjsqHBIKfL+CGwINRdnKEBPaegcnGGRWQHKdLsW/YHDMc/1QYQkOFPw/bW
         Aoqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SZpOjVOBEWa5QEebmVIj3lCqVSR7NBCDtDVquQ2awsU=;
        b=swSouhz7nlImPDZ8Y4kUt4XTn5JogvJgukXJ7FUhaAdQ6HKcEMY8rcilJTMOV2+Sv5
         /BaMpvZ6FJW1JKSNYYf8OK6RFA5H+pCJ3iR1Pdz/yU+vlZVrZATwn3Eo4Bonl6EYn4J8
         iPMINNLVyxWJwHEWADKt6uTyYgRNFM6Yp/GksFJoR+2wyb0gu+CZ9SLOBLiiOitDiOAD
         /uHhdboyagghSohLPOM1+w/oNZF6S4fq1xdVb4a4PYMEkhpQ4YBrPg5riQJMsOQnzKcf
         bTJJ/QFB7oxCPPpGxFmxIZAF2J80KCxvhXVC/huUOJnWdm1KJ511VjYLKyqcEEHeZ/uZ
         3Suw==
X-Gm-Message-State: APjAAAV2671VdeSdPq3dbV7yVl+7CirJoVAUwH9Tl5BoYXy2ACHhWg3l
        aMgh79pTo042I6bdBIe2XskXm7sW
X-Google-Smtp-Source: APXvYqxS34TDkOASGRrtqZPgAYcCDvME02nHh565x/b/A1YYSaMqNNJSShvSF4t0QLHQTJSaMbV1Dw==
X-Received: by 2002:a2e:9a04:: with SMTP id o4mr3961237lji.214.1575006716470;
        Thu, 28 Nov 2019 21:51:56 -0800 (PST)
Received: from octofox.hsd1.ca.comcast.net (jcmvbkbc-1-pt.tunnel.tserv24.sto1.ipv6.he.net. [2001:470:27:1fa::2])
        by smtp.gmail.com with ESMTPSA id e14sm11007948ljj.36.2019.11.28.21.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 21:51:55 -0800 (PST)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] tools/testing/selftests/seccomp: change USER_NOTIF_MAGIC definition
Date:   Thu, 28 Nov 2019 21:51:28 -0800
Message-Id: <20191129055128.25952-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

USER_NOTIF_MAGIC is used to both initialize seccomp_notif_resp::val and
verify syscall resturn value. On 32-bit architectures syscall return
value has type long, but the value of USER_NOTIF_MAGIC has type long
long because it doesn't fit into long. As a result all syscall return
value comparisons with USER_NOTIF_MAGIC are false. This is also reported
by the compiler when '-W' is added to CFLAGS.

Add explicit type cast to USER_NOTIF_MAGIC definition.
This fixes the following seccomp_bpf tests on 32-bit architectures:
 global.user_notification_basic
 global.user_notification_child_pid_ns
 global.user_notification_sibling_pid_ns
 global.user_notification_fault_recv

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 7f8b5c8982e3..16cc30e2ade4 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3077,7 +3077,7 @@ static int user_trap_syscall(int nr, unsigned int flags)
 	return seccomp(SECCOMP_SET_MODE_FILTER, flags, &prog);
 }
 
-#define USER_NOTIF_MAGIC 116983961184613L
+#define USER_NOTIF_MAGIC ((unsigned long)116983961184613L)
 TEST(user_notification_basic)
 {
 	pid_t pid;
-- 
2.20.1

