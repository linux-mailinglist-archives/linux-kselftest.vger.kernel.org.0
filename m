Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7335F2679CA
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Sep 2020 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgILLKx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Sep 2020 07:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgILLJk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Sep 2020 07:09:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E824AC061343
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q4so2984094pjh.5
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Sep 2020 04:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yfwK3v59ulDG8xRv4Cwr4k2seeBZHBJy/fMB9LYQCYQ=;
        b=KLE1PL50FLBo8ev5qSDoj1kBBVOJoMyiHr99ME6rCPqlayRiESNpQWvxCHB3om2Bfc
         XN0BVMjBNpBx5otJmu1jvqPjeWgsI4KksNuYIwR70mc27cvFLWlhjTRLgt83KBE2MFDw
         Dm8vSbSJaJpHsO2XD/IeVUJf+GCoM9n5H04mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yfwK3v59ulDG8xRv4Cwr4k2seeBZHBJy/fMB9LYQCYQ=;
        b=Mpv4D+h1f3euXYHZtgk7S9NeatETJFe9HCiS79imxE39JIAI+wGs5pW3S6/n+12BYB
         qoBrT3rniM5/fdpR8mFdLHBtx1G0iIQ5Efrcf57EJ3QQeP3rclI7BxjiuU/xQBw7iOuq
         Qs52sTu6FraQcr97J/FnDLhKkCZAsRqTouffKM3uzBjAjhIypFPcOInrLX7w7NlDTnZE
         dpfgYUHrAfWlH78baMBHi0ikiuA0cH2c+R482zgmXTvEGb/w8Aj9b7nYek6MDefc+YNK
         UUhptJQBiPGC0nx5RxWrlGcyTQhAgPlm/fKBsWIg5skBXpaDl8FX17hQvKarK146sO+S
         j7nw==
X-Gm-Message-State: AOAM53341zSKKsapoL2mvJTezidfIImolx4zmejjp99zRNqcAe+bZ5ZB
        h3EbYDj8WNr4klI3gEQhBmy5qRELj+/iznH1
X-Google-Smtp-Source: ABdhPJz39VXqPylLzqvKf+nVy4cjgyiwubNgnhEKUOy/E1w6B1m+xyacV3sKJYHyjEOTCLca7/KdBw==
X-Received: by 2002:a17:902:7489:b029:d0:4c09:be with SMTP id h9-20020a1709027489b02900d04c0900bemr6604087pll.0.1599908915516;
        Sat, 12 Sep 2020 04:08:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q190sm5265820pfq.99.2020.09.12.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 04:08:34 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        linux-kselftest@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 14/15] selftests/clone3: Avoid OS-defined clone_args
Date:   Sat, 12 Sep 2020 04:08:19 -0700
Message-Id: <20200912110820.597135-15-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200912110820.597135-1-keescook@chromium.org>
References: <20200912110820.597135-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

As the UAPI headers start to appear in distros, we need to avoid
outdated versions of struct clone_args to be able to test modern
features. Additionally pull in the syscall numbers correctly.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
I needed to fix this to get MIPS to build the seccomp selftests.
---
 .../testing/selftests/clone3/clone3_selftests.h  | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index 91c1a78ddb39..bc0f34e37ae1 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -4,11 +4,19 @@
 #define _CLONE3_SELFTESTS_H
 
 #define _GNU_SOURCE
+
+/* Pull in syscall numbers. */
+#include <unistd.h>
+#include <sys/syscall.h>
+
+/* Avoid old OS versions of "struct clone_args". */
+#define clone_args old_clone_args
 #include <sched.h>
 #include <linux/sched.h>
+#undef clone_args
+
 #include <linux/types.h>
 #include <stdint.h>
-#include <syscall.h>
 #include <sys/wait.h>
 
 #include "../kselftest.h"
@@ -25,6 +33,7 @@
 
 #ifndef __NR_clone3
 #define __NR_clone3 -1
+#endif
 struct clone_args {
 	__aligned_u64 flags;
 	__aligned_u64 pidfd;
@@ -34,13 +43,16 @@ struct clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
+#ifndef CLONE_ARGS_SIZE_VER1
 #define CLONE_ARGS_SIZE_VER1 80
+#endif
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
+#ifndef CLONE_ARGS_SIZE_VER2
 #define CLONE_ARGS_SIZE_VER2 88
+#endif
 	__aligned_u64 cgroup;
 };
-#endif /* __NR_clone3 */
 
 static pid_t sys_clone3(struct clone_args *args, size_t size)
 {
-- 
2.25.1

