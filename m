Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE662450A2D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 17:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbhKOQzm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 11:55:42 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42444
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231767AbhKOQz3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 11:55:29 -0500
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 92A5C3F1AA
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Nov 2021 16:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636995150;
        bh=PNH2v6es8O5TOQZzDLjEqkCgdBVGSVqHubwT7Cy+HTU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=CU4CBpfM4YuPt/teKruLLRKucAGjvddKhKs1PGKICag8ROjQ95O2lu1R3wvendmG9
         +6b0rLoida6drtws2TQo+e8lRq7kVW9KuB0+FHMIaKX0cMI8WX+DzTKfOY9RQ4i5QI
         p2D0PDEW56XVSyDXKovtpc88+ucxjDEXoUnpQ/tx15pwefANHx2R1/2dOKBKhYqyG3
         8f+3R+0i91Gf5L1Fbi/Amg4Uo5Zt30PbRyffWdx73jLcGcsjgax+4FBzt0aScygyae
         mRCm8d+lbfAljLXw+z9F2GdhkMWFMaor0ZiX84dJ8y1lSJyT8pVBL4olWV/GtIozQ5
         UiyMdC2GLp+uA==
Received: by mail-ed1-f72.google.com with SMTP id bx28-20020a0564020b5c00b003e7c42443dbso2579721edb.15
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Nov 2021 08:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PNH2v6es8O5TOQZzDLjEqkCgdBVGSVqHubwT7Cy+HTU=;
        b=yag0FOfOYJn3E4CB7SA9Brkq0WJ0BroBET7qbEYnT09zRB53nnhHGIVYzoL7vim9Xy
         WFvkKyCcI65jromae1l7/2x3qUr7m7ahgyEf6c4zqrqlCDngFerV8SVlvXctSlZVHDIR
         +bg0bD9Kj+2yxLCav534EI+P1801OJiUnJRupdDQn8fdd4go2Tck3G8uh3y160K2g3p9
         LqRZIplKvJRU8jeNrRfvn83oG+RBhnifRBDBLL/mI/AcqC/fnK/COe3D2DBwsi4x95F0
         oOjQ8s6ihzCgdNJ3GrMQlYfoZ4NqFez7OnTzUkG3gxPzJfaG9/7uyklVEVHtVJY66icR
         E8Iw==
X-Gm-Message-State: AOAM533AxIAV9Tlv2fH6PoNkZ19OyW599enGJ154fmxJcQoEfFA46Sed
        tMfcR52EJZJ2d8km5dyqjgBxQFE0ssKzXxz3TYWdz9vegTyp2IYeiv25YSD+5NyATQ1x7Fmscgh
        +b+UNzxTQoYqs1tEoV9f/4DYpu0EhfvFTJuw6mh3UpQerww==
X-Received: by 2002:a17:906:4099:: with SMTP id u25mr447157ejj.453.1636995150309;
        Mon, 15 Nov 2021 08:52:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz1ddN8Ya6WZiEz3nrE5A7ROfH6GkWWKrtT46rgA6RW+xJPsLTeHGOQjE2zXjDLcd9AVi28lQ==
X-Received: by 2002:a17:906:4099:: with SMTP id u25mr447122ejj.453.1636995150100;
        Mon, 15 Nov 2021 08:52:30 -0800 (PST)
Received: from arighi-desktop.homenet.telecomitalia.it ([2001:67c:1560:8007::aac:c1b6])
        by smtp.gmail.com with ESMTPSA id o14sm7770903edj.15.2021.11.15.08.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 08:52:29 -0800 (PST)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Shuah Khan <shuah@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/seccomp: fix check of fds being assigned
Date:   Mon, 15 Nov 2021 17:52:27 +0100
Message-Id: <20211115165227.101124-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There might be an arbitrary free open fd slot when we run the addfd
sub-test, so checking for progressive numbers of file descriptors
starting from memfd is not always a reliable check and we could get the
following failure:

  #  RUN           global.user_notification_addfd ...
  # seccomp_bpf.c:3989:user_notification_addfd:Expected listener (18) == nextfd++ (9)
  # user_notification_addfd: Test terminated by assertion

Simply check if memfd and listener are valid file descriptors and start
counting for progressive file checking with the listener fd.

Fixes: 93e720d710df ("selftests/seccomp: More closely track fds being assigned")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index d425688cf59c..4f37153378a1 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -3975,18 +3975,17 @@ TEST(user_notification_addfd)
 	/* There may be arbitrary already-open fds at test start. */
 	memfd = memfd_create("test", 0);
 	ASSERT_GE(memfd, 0);
-	nextfd = memfd + 1;
 
 	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
 	}
 
-	/* fd: 4 */
 	/* Check that the basic notification machinery works */
 	listener = user_notif_syscall(__NR_getppid,
 				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
-	ASSERT_EQ(listener, nextfd++);
+	ASSERT_GE(listener, 0);
+	nextfd = listener + 1;
 
 	pid = fork();
 	ASSERT_GE(pid, 0);
-- 
2.32.0

