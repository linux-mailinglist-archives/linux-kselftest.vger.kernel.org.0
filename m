Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3A307A83
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Jan 2021 17:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhA1QSJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Jan 2021 11:18:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:45280 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbhA1QSH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Jan 2021 11:18:07 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1l59z1-0002aT-Kf
        for linux-kselftest@vger.kernel.org; Thu, 28 Jan 2021 16:17:23 +0000
Received: by mail-il1-f200.google.com with SMTP id b4so5079564ilj.10
        for <linux-kselftest@vger.kernel.org>; Thu, 28 Jan 2021 08:17:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tkk2BUb79GCkzB0eTMBLvXetGKpINayzR/LLA/HkVzI=;
        b=R2D4W6YULsH7e0D8IBOXuUytjKz/6/LRhK8eB8VoSRlcXgASj3nsU/JQPrvMF/RUEX
         M4g3XlVtI5lPMPP5wMIgIWnSJfEiGUBoMWhvFsZi7TYGrOGBNxSPy11liFWN6kgdup2R
         Uvnl9SgnpgJOLSV1e0f7K+v7flMICUhMzOfAoYCjBQF8HBY4JbvVZVWxtudgxZoNNCKi
         CAV99z2uFbzhV2xaQYj5dcfF3nG5hkv54W1rZemhlMNsn6HXKIEO8xixzlY/Ess9dqun
         qG2Tui4t65KXJX80OJo6CaenjdNuvlq2HgnXIXo2CKnHUrfg3IVMYBD71OO0/TT+ueLV
         oJfA==
X-Gm-Message-State: AOAM531lwKPRLJ8WuLIUpuZz8wSL7JdyynuRCXVe26lenCK5DeZh7Pg9
        GCAPjTwGiTBjGQ3wovhTVmZgnn3YyWIKTLifyclmRztmozPwaEEBmOOolwxhm+tyW84H6P14PVh
        qBbbyDJbBXvjssLxp9zMhb8W8NBq1CnOLIEOYHufXIgG9mw==
X-Received: by 2002:a92:358b:: with SMTP id c11mr13334168ilf.305.1611850642724;
        Thu, 28 Jan 2021 08:17:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXRVKkWU+ASLPWgeU5gL8fF7xCAiBTAgC12qWAiH5/nqd6FGmSEQ3n97e9J3Cd5lbQs6y/QQ==
X-Received: by 2002:a92:358b:: with SMTP id c11mr13334147ilf.305.1611850642504;
        Thu, 28 Jan 2021 08:17:22 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:52bc:7bc4:5d05:b6a5])
        by smtp.gmail.com with ESMTPSA id y11sm2796979ilv.64.2021.01.28.08.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jan 2021 08:17:21 -0800 (PST)
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/seccomp: Accept any valid fd in user_notification_addfd
Date:   Thu, 28 Jan 2021 10:17:21 -0600
Message-Id: <20210128161721.99150-1-seth.forshee@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test expects fds to have specific values, which works fine
when the test is run standalone. However, the kselftest runner
consumes a couple of extra fds for redirection when running
tests, so the test fails when run via kselftest.

Change the test to pass on any valid fd number.

Signed-off-by: Seth Forshee <seth.forshee@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c72f2b61b1..9338df6f4ca8 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4019,18 +4019,14 @@ TEST(user_notification_addfd)
 
 	/* Verify we can set an arbitrary remote fd */
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
-	/*
-	 * The child has fds 0(stdin), 1(stdout), 2(stderr), 3(memfd),
-	 * 4(listener), so the newly allocated fd should be 5.
-	 */
-	EXPECT_EQ(fd, 5);
+	EXPECT_GE(fd, 0);
 	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
 
 	/* Verify we can set an arbitrary remote fd with large size */
 	memset(&big, 0x0, sizeof(big));
 	big.addfd = addfd;
 	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD_BIG, &big);
-	EXPECT_EQ(fd, 6);
+	EXPECT_GE(fd, 0);
 
 	/* Verify we can set a specific remote fd */
 	addfd.newfd = 42;
-- 
2.29.2

