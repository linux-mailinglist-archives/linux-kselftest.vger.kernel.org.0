Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8644F7BB4C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Oct 2023 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbjJFKIH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Oct 2023 06:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjJFKIF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Oct 2023 06:08:05 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B159DAD;
        Fri,  6 Oct 2023 03:08:04 -0700 (PDT)
Received: from localhost.localdomain (unknown [39.34.184.141])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DC83D66125F2;
        Fri,  6 Oct 2023 11:08:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696586883;
        bh=aWtDH3Z6axZxgatd0itj89C7sRFa6SKxitusc/fajtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fmiejCJszjjw+LeJC/lWDS1EKkRjW9s39EVwxYN4hhbVE3b9/OYiGxsjHUFQaRw0s
         POqNcVXNhyaYBvZs+gNcrjvqshzzeqmnKzEyIEYUhuemESiC6ZBo7vDfkOcz/z4hVH
         6NdzdLzd07543vw+/eYchs4pzrdQP41xxD5Eb4x9qO9hFIMEV8ome2TR8XDmLLvgNJ
         yrb9PsD8nmnZJey6pueoGTvLwhcyXWTsb14OSIBR6rCqvI45ISKNm28thw75p8eCVN
         XuoLSMox4yiuQjLltZpf49aE4mNGjnQ1kj53FmMRZhBZGB/pFI7D1qQzmBog3xqPAq
         oZdExzsJxq8Ag==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 2/4] selftests: clone3: remove duplicate defines
Date:   Fri,  6 Oct 2023 15:07:36 +0500
Message-Id: <20231006100743.1631334-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231006100743.1631334-1-usama.anjum@collabora.com>
References: <20231006100743.1631334-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicate defines which are already included in kernel headers.
MAX_PID_NS_LEVEL macro is used inside kernel only. It isn't exposed to
userspace. So it is never defined in test application. Remove #ifndef in
this case.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v1:
- Make patch explanation better
---
 .../clone3/clone3_cap_checkpoint_restore.c          |  2 --
 .../testing/selftests/clone3/clone3_clear_sighand.c |  4 ----
 tools/testing/selftests/clone3/clone3_selftests.h   | 13 -------------
 tools/testing/selftests/clone3/clone3_set_tid.c     |  2 --
 4 files changed, 21 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
index 52d3f0364bdaa..31b56d6256550 100644
--- a/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
+++ b/tools/testing/selftests/clone3/clone3_cap_checkpoint_restore.c
@@ -27,9 +27,7 @@
 #include "../kselftest_harness.h"
 #include "clone3_selftests.h"
 
-#ifndef MAX_PID_NS_LEVEL
 #define MAX_PID_NS_LEVEL 32
-#endif
 
 static void child_exit(int ret)
 {
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 47a8c0fc3676b..54a8b2445be99 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -16,10 +16,6 @@
 #include "../kselftest.h"
 #include "clone3_selftests.h"
 
-#ifndef CLONE_CLEAR_SIGHAND
-#define CLONE_CLEAR_SIGHAND 0x100000000ULL
-#endif
-
 static void nop_handler(int signo)
 {
 }
diff --git a/tools/testing/selftests/clone3/clone3_selftests.h b/tools/testing/selftests/clone3/clone3_selftests.h
index e81ffaaee02ba..3d2663fe50ba5 100644
--- a/tools/testing/selftests/clone3/clone3_selftests.h
+++ b/tools/testing/selftests/clone3/clone3_selftests.h
@@ -15,10 +15,6 @@
 
 #define ptr_to_u64(ptr) ((__u64)((uintptr_t)(ptr)))
 
-#ifndef CLONE_INTO_CGROUP
-#define CLONE_INTO_CGROUP 0x200000000ULL /* Clone into a specific cgroup given the right permissions. */
-#endif
-
 #ifndef __NR_clone3
 #define __NR_clone3 -1
 #endif
@@ -32,18 +28,9 @@ struct __clone_args {
 	__aligned_u64 stack;
 	__aligned_u64 stack_size;
 	__aligned_u64 tls;
-#ifndef CLONE_ARGS_SIZE_VER0
-#define CLONE_ARGS_SIZE_VER0 64	/* sizeof first published struct */
-#endif
 	__aligned_u64 set_tid;
 	__aligned_u64 set_tid_size;
-#ifndef CLONE_ARGS_SIZE_VER1
-#define CLONE_ARGS_SIZE_VER1 80	/* sizeof second published struct */
-#endif
 	__aligned_u64 cgroup;
-#ifndef CLONE_ARGS_SIZE_VER2
-#define CLONE_ARGS_SIZE_VER2 88	/* sizeof third published struct */
-#endif
 };
 
 static pid_t sys_clone3(struct __clone_args *args, size_t size)
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 0229e9ebb995e..ed785afb60770 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -23,9 +23,7 @@
 #include "../kselftest.h"
 #include "clone3_selftests.h"
 
-#ifndef MAX_PID_NS_LEVEL
 #define MAX_PID_NS_LEVEL 32
-#endif
 
 static int pipe_1[2];
 static int pipe_2[2];
-- 
2.40.1

