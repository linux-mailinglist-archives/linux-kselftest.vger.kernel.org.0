Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD70706957
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjEQNN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbjEQNNk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86E87ED0;
        Wed, 17 May 2023 06:13:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08718641C7;
        Wed, 17 May 2023 13:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0DAC433D2;
        Wed, 17 May 2023 13:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329198;
        bh=tA8vDceOtwnaYEmuvRonEkfnHU5EgkwYZJxxRjDBrtY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZhlxehR2rDeiAnVDqzTiOa3ksnRODBJzi001SQy9km83BCh+sSslpUVguoSeN8Il
         uwXHjW+IYnLrcNsvGw9/vc5PlLdSb4Gcq8SNGb+9U7jqrv+4zSwUd9/9bPNimcMQok
         LPjRXrVXwWwUwdDMoTBXVMqAwdmMv0pYUVWZ/lWbR3Sum2O620By8zNUB4CsRzRnGT
         B8+bZt42Vt5lZ795+/xA9/1lKx/j2eJjWnya+dwVW+/eXJBG2ACQBiEl2QIn7S24uR
         aIHSN8P8r0X9oWG4waSTw5ry47uHOhsMogxlxAjjiT3E57B6sfhCFfCGfKcQYgqDcQ
         jSutqMkSXP8Ng==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: [PATCH 13/14] thread_info: move function declarations to linux/thread_info.h
Date:   Wed, 17 May 2023 15:11:01 +0200
Message-Id: <20230517131102.934196-14-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

There are a few __weak functions in kernel/fork.c, which architectures
can override. If there is no prototype, the compiler warns about them:

kernel/fork.c:164:13: error: no previous prototype for 'arch_release_task_struct' [-Werror=missing-prototypes]
kernel/fork.c:991:20: error: no previous prototype for 'arch_task_cache_init' [-Werror=missing-prototypes]
kernel/fork.c:1086:12: error: no previous prototype for 'arch_dup_task_struct' [-Werror=missing-prototypes]

There are already prototypes in a number of architecture specific headers
that have addressed those warnings before, but it's much better to have
these in a single place so the warning no longer shows up anywhere.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/thread_info.h | 4 ----
 arch/s390/include/asm/thread_info.h  | 3 ---
 arch/sh/include/asm/thread_info.h    | 3 ---
 arch/x86/include/asm/thread_info.h   | 3 ---
 include/linux/thread_info.h          | 5 +++++
 5 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 848739c15de8..553d1bc559c6 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -55,10 +55,6 @@ struct thread_info {
 void arch_setup_new_exec(void);
 #define arch_setup_new_exec     arch_setup_new_exec
 
-void arch_release_task_struct(struct task_struct *tsk);
-int arch_dup_task_struct(struct task_struct *dst,
-				struct task_struct *src);
-
 #endif
 
 #define TIF_SIGPENDING		0	/* signal pending */
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index c7c97921ed8d..a674c7d25da5 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -52,9 +52,6 @@ struct thread_info {
 
 struct task_struct;
 
-void arch_release_task_struct(struct task_struct *tsk);
-int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
-
 void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 
diff --git a/arch/sh/include/asm/thread_info.h b/arch/sh/include/asm/thread_info.h
index 1400fbb8b423..9f19a682d315 100644
--- a/arch/sh/include/asm/thread_info.h
+++ b/arch/sh/include/asm/thread_info.h
@@ -84,9 +84,6 @@ static inline struct thread_info *current_thread_info(void)
 
 #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
 
-extern void arch_task_cache_init(void);
-extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
-extern void arch_release_task_struct(struct task_struct *tsk);
 extern void init_thread_xstate(void);
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index f1cccba52eb9..d63b02940747 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -232,9 +232,6 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
-extern void arch_task_cache_init(void);
-extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
-extern void arch_release_task_struct(struct task_struct *tsk);
 extern void arch_setup_new_exec(void);
 #define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index c02646884fa8..9ea0b28068f4 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -256,6 +256,11 @@ check_copy_size(const void *addr, size_t bytes, bool is_source)
 static inline void arch_setup_new_exec(void) { }
 #endif
 
+void arch_task_cache_init(void); /* for CONFIG_SH */
+void arch_release_task_struct(struct task_struct *tsk);
+int arch_dup_task_struct(struct task_struct *dst,
+				struct task_struct *src);
+
 #endif	/* __KERNEL__ */
 
 #endif /* _LINUX_THREAD_INFO_H */
-- 
2.39.2

