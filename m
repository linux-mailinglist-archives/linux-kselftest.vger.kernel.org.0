Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE60770E7D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 09:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjHEHiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 03:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHEHiU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 03:38:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F794EC9;
        Sat,  5 Aug 2023 00:38:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [59.103.216.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1FE4D66071AA;
        Sat,  5 Aug 2023 08:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1691221098;
        bh=GzjRATlgGitRF0V9m5rFod6Kq8RaT1OYHkP3KnFTooY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h48Ay0pR0UV9/WSwc4+0lMrsMwIUfCl4GzGUXn6+PaSV4BSkhZvp9unn2QFxEO0SG
         iVlRR7jpaWuWBVd8wvBUfEbicVVmKv5AdYxyCVJP1ZLqJSiLl+wwl49r/OlzKvjFhB
         b+5LJlGcYAtFPP8s2bJjwu/8BGNYGyk2JmCEtKn0KeBxP4ldes+bPXd1iNRTnQ8pJu
         j98RGmG9ByHCj8jSZCtm+AeJSRcX769NyJVLUsAO90NF5RuHdOJ7NFA4xeYHYgWFCN
         CR5VXJIwxAgHYXpA9uRbTnftmxpzTqjMF1pfZGdlLMUc69ikKYmCcg4oZR4GE3VnnY
         wpl2g3/jyVRxw==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     usama.anjum@collabora.com, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 2/6] selftests: clone3: remove duplicate defines
Date:   Sat,  5 Aug 2023 12:38:00 +0500
Message-Id: <20230805073809.1753462-2-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230805073809.1753462-1-usama.anjum@collabora.com>
References: <20230805073809.1753462-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Remove duplicate defines which are included in kernel headers.
MAX_PID_NS_LEVEL macro is used inside kernel only. It isn't exposed to
userspace. So it is never defined in test application. Remove #ifndef in
this case.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
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
2.39.2

