Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDAC21C040
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Jul 2020 01:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGJXBN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Jul 2020 19:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgGJXBN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Jul 2020 19:01:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B7EC08C5DD
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id j19so3145571pgm.11
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJc4QERnOgktMF7NqBZjFQHDM5ibkAymhVFvz1eDOmI=;
        b=F0pFYG7+McnKe83941AK8NN4lM4MoyXsDbWy65c09PV1lBw7xVYl0AMgw5QSkOnrJe
         Nwrwtsqvg08baI19s2fDAGmvtoL1rXIyVgD9PID1HW49OQGuQkuUJpQbd9SQQ4MzHVzw
         m7c2lLHklIqQTAETql0ByTPy9X928C9v8zpp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJc4QERnOgktMF7NqBZjFQHDM5ibkAymhVFvz1eDOmI=;
        b=FxQFIQcljUIJT1nw3PycwYkT/+KVqyKNOgOS77UL1WkTZ3dp4GccVzyRxU7v9nyxXS
         GdE4Yf5tIp/Ztpq4PGhR9EBXxJ9kYS3kgeSuxTOW020tjnaOpc+gY9pdRgHp3uhXZM61
         y00efsEr8VFlm207c+e4lU+usm6vRGQNKoMMFqLEQbHfd8Qk1eY8G8wwrZrLub+/WL4o
         yIJX1WuWuFqYUIYRGIZPtbiXr0kztyD25CCJP2Ane8X9npCn5y0223bK/OGbjJKIwq/O
         mcskMer4yTeBYEFvMom4EYwXn+moDI0FhfHI6+0GF3b5lLcpOEKJRGNljL9peBot3htL
         hBkw==
X-Gm-Message-State: AOAM530N6ezoguimH1PWzdqFJIE3omyu+eWZhnJd0JEYzT4DhYuN6df7
        dq1fBznbrTbSfZV+i4+bs4aBHQ==
X-Google-Smtp-Source: ABdhPJy3YT7KkX4oNIVxegNkh5Z8UYtYGphPRPSA5jmBHeGfmGico3ihLD+kNSyKs3e9ilotKrp3Ig==
X-Received: by 2002:a62:ab17:: with SMTP id p23mr48997593pff.177.1594422072450;
        Fri, 10 Jul 2020 16:01:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e5sm6568941pjv.18.2020.07.10.16.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:01:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Shuah Khan <shuah@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH for-next/seccomp v2 1/2] selftests/seccomp: Add SKIPs for failed unshare()
Date:   Fri, 10 Jul 2020 16:01:06 -0700
Message-Id: <20200710230107.2528890-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200710230107.2528890-1-keescook@chromium.org>
References: <20200710230107.2528890-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Running the seccomp tests as a regular user shouldn't just fail tests
that require CAP_SYS_ADMIN (for getting a PID namespace). Instead,
detect those cases and SKIP them. Additionally, gracefully SKIP missing
CONFIG_USER_NS (and add to "config" since we'd prefer to actually test
this case).

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/seccomp/config        |  1 +
 tools/testing/selftests/seccomp/seccomp_bpf.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/seccomp/config b/tools/testing/selftests/seccomp/config
index db1e11b08c8a..64c19d8eba79 100644
--- a/tools/testing/selftests/seccomp/config
+++ b/tools/testing/selftests/seccomp/config
@@ -1,2 +1,3 @@
 CONFIG_SECCOMP=y
 CONFIG_SECCOMP_FILTER=y
+CONFIG_USER_NS=y
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index c0aa46ce14f6..14b038361549 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3439,7 +3439,10 @@ TEST(user_notification_child_pid_ns)
 	struct seccomp_notif req = {};
 	struct seccomp_notif_resp resp = {};
 
-	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWUSER | CLONE_NEWPID), 0) {
+		if (errno == EINVAL)
+			SKIP(return, "kernel missing CLONE_NEWUSER support");
+	};
 
 	listener = user_trap_syscall(__NR_getppid,
 				     SECCOMP_FILTER_FLAG_NEW_LISTENER);
@@ -3504,7 +3507,10 @@ TEST(user_notification_sibling_pid_ns)
 	}
 
 	/* Create the sibling ns, and sibling in it. */
-	ASSERT_EQ(unshare(CLONE_NEWPID), 0);
+	ASSERT_EQ(unshare(CLONE_NEWPID), 0) {
+		if (errno == EPERM)
+			SKIP(return, "CLONE_NEWPID requires CAP_SYS_ADMIN");
+	}
 	ASSERT_EQ(errno, 0);
 
 	pid2 = fork();
-- 
2.25.1

