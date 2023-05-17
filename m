Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA5A3706937
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbjEQNNQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbjEQNNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA12D49;
        Wed, 17 May 2023 06:12:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 896486470A;
        Wed, 17 May 2023 13:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95E2C433A7;
        Wed, 17 May 2023 13:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329160;
        bh=d7hci1xlNwrYn7pn2ZxyBhUcLTuHLDJnwYAYODDw+K0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ry4ynhpM0kH4rjI0rh27VkbB9E0CWT+emj5Pf/VEWNSnq4ZNK/M0fPh3cd3q8xggp
         XRmtMiQP7iAsNbqYWMSUPC8ui7Ko1plq3L731BWwuxTvktD4xwc0Fwm8+ZbdJOinpu
         E5F+Zt68Uh0ReLFtTc+9w4Sdc36Fa6sO6d1cku2QZJFWlJnDsfIx2on9pHNO6EAyzZ
         xeqy14d7YG5nUChEEpW0QW2tnXvHSS5RGHByFH3OOuQwyKOcT6RbH/3/530rIYIBOg
         MWRRI0jMvTIltxR96cvRD26/c3bUU+bo0he6G/0VxA7U/gBKch6tCkyA3fkP+AS0sz
         9DLeC9jPuwnpA==
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
Subject: [PATCH 08/14] panic: make function declarations visible
Date:   Wed, 17 May 2023 15:10:56 +0200
Message-Id: <20230517131102.934196-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230517131102.934196-1-arnd@kernel.org>
References: <20230517131102.934196-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few panic() related functions have a global definition but
not declaration, which causes a warning with W=1:

kernel/panic.c:710:6: error: no previous prototype for '__warn_printk' [-Werror=missing-prototypes]
kernel/panic.c:756:24: error: no previous prototype for '__stack_chk_fail' [-Werror=missing-prototypes]
kernel/exit.c:1917:32: error: no previous prototype for 'abort' [-Werror=missing-prototypes]

__warn_printk() is called both as a global function when CONFIG_BUG
is enabled, and as a local function in other configs. The other
two here are called indirectly from generated or assembler code.

Add prototypes for all of these.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/asm-generic/bug.h | 5 +++--
 include/linux/panic.h     | 3 +++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 4050b191e1a9..6e794420bd39 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -87,10 +87,12 @@ struct bug_entry {
  *
  * Use the versions with printk format strings to provide better diagnostics.
  */
-#ifndef __WARN_FLAGS
 extern __printf(4, 5)
 void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		       const char *fmt, ...);
+extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
+
+#ifndef __WARN_FLAGS
 #define __WARN()		__WARN_printf(TAINT_WARN, NULL)
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
@@ -98,7 +100,6 @@ void warn_slowpath_fmt(const char *file, const int line, unsigned taint,
 		instrumentation_end();					\
 	} while (0)
 #else
-extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 #define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
diff --git a/include/linux/panic.h b/include/linux/panic.h
index 979b776e3bcb..6717b15e798c 100644
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -32,6 +32,9 @@ extern int sysctl_panic_on_stackoverflow;
 
 extern bool crash_kexec_post_notifiers;
 
+extern void __stack_chk_fail(void);
+void abort(void);
+
 /*
  * panic_cpu is used for synchronizing panic() and crash_kexec() execution. It
  * holds a CPU number which is executing panic() currently. A value of
-- 
2.39.2

