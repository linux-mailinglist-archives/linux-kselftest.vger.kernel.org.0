Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7D86C7E21
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 13:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231636AbjCXMgk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjCXMgj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 08:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D9612CE9;
        Fri, 24 Mar 2023 05:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB25162A91;
        Fri, 24 Mar 2023 12:36:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EBAC433D2;
        Fri, 24 Mar 2023 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679661397;
        bh=wHdqUGeejIKT/uaNZyVOzSQNAwbfI8EP7ra7QHVcAjM=;
        h=From:To:Cc:Subject:Date:From;
        b=cov4O4J4ZyGhYF1TegabOXvkxRb939jcOk2Eu5yO3NF0Dubw0QEfMI6xlPkQqqIv3
         JECeR74GialtlRzKuJxO+8zVwo6JVWwf+oBjGz8CUohhf8yXEAjgEWahk2d30rc6Hf
         2UN+nFuDvhLcqztE/ewY8iJTP5rgsCBRCXnz7j8pilKI93V8+HWdsEYGbAkFNBUZD6
         uiU1CYmwQtBSfE9owjtxhIvqej8K/mjFk6USluqolgI1icEo614lYx48G2MiVcVNnl
         sslXFHKzHV73SWhG9kZeWba3vf/1W6r9FMV7cQ4pR2FbfX0Kbr8TIQYZ3jnwgDwhBU
         /le61NlrjFI7A==
From:   Sasha Levin <sashal@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     andrii@kernel.org, mykolal@fb.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH] capability: test_deny_namespace breakage due to capability conversion to u64
Date:   Fri, 24 Mar 2023 08:36:26 -0400
Message-Id: <20230324123626.2177476-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit f122a08b197d ("capability: just use a 'u64' instead of a 'u32[2]'
array") attempts to use BIT_LL() but actually wanted to use BIT_ULL(),
fix it up to make the test compile and run again.

Fixes: f122a08b197d ("capability: just use a 'u64' instead of a 'u32[2]' array")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile                    | 2 +-
 tools/testing/selftests/bpf/progs/test_deny_namespace.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b677dcd0b77af..91a4e61b61f6d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -353,7 +353,7 @@ endif
 CLANG_SYS_INCLUDES = $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_ARCH))
 BPF_CFLAGS = -g -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN) 		\
 	     -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)			\
-	     -I$(abspath $(OUTPUT)/../usr/include)
+	     -I$(abspath $(OUTPUT)/../usr/include) -I$(TOOLSINCDIR)
 
 CLANG_CFLAGS = $(CLANG_SYS_INCLUDES) \
 	       -Wno-compare-distinct-pointer-types
diff --git a/tools/testing/selftests/bpf/progs/test_deny_namespace.c b/tools/testing/selftests/bpf/progs/test_deny_namespace.c
index 591104e79812e..0a619c34d692d 100644
--- a/tools/testing/selftests/bpf/progs/test_deny_namespace.c
+++ b/tools/testing/selftests/bpf/progs/test_deny_namespace.c
@@ -4,6 +4,7 @@
 #include <bpf/bpf_tracing.h>
 #include <errno.h>
 #include <linux/capability.h>
+#include <vdso/bits.h>
 
 struct kernel_cap_struct {
 	__u64 val;
@@ -19,7 +20,7 @@ SEC("lsm.s/userns_create")
 int BPF_PROG(test_userns_create, const struct cred *cred, int ret)
 {
 	struct kernel_cap_struct caps = cred->cap_effective;
-	__u64 cap_mask = BIT_LL(CAP_SYS_ADMIN);
+	__u64 cap_mask = BIT_ULL(CAP_SYS_ADMIN);
 
 	if (ret)
 		return 0;
-- 
2.39.2

