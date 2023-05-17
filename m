Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29B3706919
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 May 2023 15:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjEQNMW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 May 2023 09:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjEQNMR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 May 2023 09:12:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859842D73;
        Wed, 17 May 2023 06:12:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F292064711;
        Wed, 17 May 2023 13:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E219C433A8;
        Wed, 17 May 2023 13:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684329129;
        bh=m4CC8jzjsL/DB4zhl/Y597jyiUuMzUYclEl5YRgzTWo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I6TCINxJI0woqSGR6ssIvaSj6epLLVO81LOzyVaPT8/vzZI9AB8IWfkQCSXQEHhXj
         emmu7MtAnphbx6efp3NtZZlhdUPe7PobFSbrgE0GW1MxwsjqRKhXtsARowKgI7TJl1
         M8K+xUmMlgWQeI0sMhDqBlo2KcTRfdwZaRrzSuAmdzwi2gCudljKNjdsRsUPUgknLD
         dFngQPAXjy/SCR0E/q5jywBkSs9H4bdCiuKXgEHWHkpEKogI02+rydRudhNs/4FwF/
         rKa/Win+V5kAOFnp1Q7tVYGNdR9eUslE6Gou6+cruOq5EcoezzwmGP3r8Tp1Dhm35i
         hSLiw0TbCv7FA==
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
Subject: [PATCH 04/14] audit: avoid missing-prototype warnings
Date:   Wed, 17 May 2023 15:10:52 +0200
Message-Id: <20230517131102.934196-5-arnd@kernel.org>
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

Building with 'make W=1' reveals two function definitions without
a previous prototype in the audit code:

lib/compat_audit.c:32:5: error: no previous prototype for 'audit_classify_compat_syscall' [-Werror=missing-prototypes]
kernel/audit.c:1813:14: error: no previous prototype for 'audit_serial' [-Werror=missing-prototypes]

The first one needs a declaration from linux/audit.h but cannot
include that header without causing conflicting (compat) syscall number
definitions, so move the it into linux/audit_arch.h.

The second one is declared conditionally based on CONFIG_AUDITSYSCALL
but needed as a local function even when that option is disabled, so
move the declaration out of the #ifdef block.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/audit.h      | 2 --
 include/linux/audit_arch.h | 2 ++
 kernel/audit.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 31086a72e32a..6a3a9e122bb5 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -130,8 +130,6 @@ extern unsigned compat_dir_class[];
 extern unsigned compat_chattr_class[];
 extern unsigned compat_signal_class[];
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
-
 /* audit_names->type values */
 #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
 #define	AUDIT_TYPE_NORMAL	1	/* a "normal" audit record */
diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
index 8fdb1afe251a..0e34d673ef17 100644
--- a/include/linux/audit_arch.h
+++ b/include/linux/audit_arch.h
@@ -21,4 +21,6 @@ enum auditsc_class_t {
 	AUDITSC_NVALS /* count */
 };
 
+extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+
 #endif
diff --git a/kernel/audit.h b/kernel/audit.h
index c57b008b9914..94738bce40b2 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -259,8 +259,8 @@ extern struct tty_struct *audit_get_tty(void);
 extern void audit_put_tty(struct tty_struct *tty);
 
 /* audit watch/mark/tree functions */
-#ifdef CONFIG_AUDITSYSCALL
 extern unsigned int audit_serial(void);
+#ifdef CONFIG_AUDITSYSCALL
 extern int auditsc_get_stamp(struct audit_context *ctx,
 			      struct timespec64 *t, unsigned int *serial);
 
-- 
2.39.2

