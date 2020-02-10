Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93BD81583AA
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 20:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBJTbT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 14:31:19 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34164 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbgBJTbE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:04 -0500
Received: by mail-oi1-f193.google.com with SMTP id l136so10359863oig.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 11:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vV+4L9n935hAwwy1rny/bKPJmpM6IQkGJafPemnuM6M=;
        b=PoL0XhCMF5RYylDc0l4IgFMeB8xwO+uVffzPYfytDnFxlYeMxyX/mZuQokiRqvLpeB
         3BSmLKsw8Mn0fTOGDf5FiPjNmXvq0HmdnXXBN/WXOAJCOAtbktliwg0Ij4BFjNLNEwz1
         LFDL39Nbv292S1gxIrW8F3TJd9vj+dby5RYxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vV+4L9n935hAwwy1rny/bKPJmpM6IQkGJafPemnuM6M=;
        b=PqjYj8Tq0eqhUsUn4oJVZgETRNekCBskn8uY6kxU0/jtdfn9vR/TIt28z1mQvOp73f
         yQ/8TaNWL/ePmJCnUSqYeugopZ2QiG7lc+ug981lNleIJdWz60jcgrhkO5GQqMTQMJ7D
         14ZsV9c36ZUudYNyRKrcPmHhmzd28yKcACj2PeMLr6ACMPIutiejvoZTyT+6nRxTFse6
         8GI0Itf0BaBRtiRTbgqU+Y84nKdUadz7++u9GWP4GiXCcsP9NToD+8nKr3loKcU6KUlW
         t2ymHIdk/brvaCjuyjEhRF5SgkkR+/KG5uAcOqZdSZLL4QZP8XnThOrDMHqmhVBJoHkR
         gXbQ==
X-Gm-Message-State: APjAAAXchh2XfVo6kYmmY/8irZkcQHnZ94IFpXgbIBKCZCbFiqp6ROQ2
        3/1Xt/Azq1SH4MfTqZkt42lyPQ==
X-Google-Smtp-Source: APXvYqxxYA/0/Zbqi4Hv0JHtPdrzzbONYFkwCVp0/iu2hk9k8CQImN2sdfiTosdmQZKPTHVPQ7l30Q==
X-Received: by 2002:aca:5083:: with SMTP id e125mr424241oib.96.1581363063722;
        Mon, 10 Feb 2020 11:31:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f1sm370846otq.4.2020.02.10.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:31:02 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 5/7] arm32/64, elf: Split READ_IMPLIES_EXEC from executable GNU_STACK
Date:   Mon, 10 Feb 2020 11:30:47 -0800
Message-Id: <20200210193049.64362-6-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200210193049.64362-1-keescook@chromium.org>
References: <20200210193049.64362-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The READ_IMPLIES_EXEC work-around was designed for old toolchains that
lacked the ELF PT_GNU_STACK marking under the assumption that toolchains
that couldn't specify executable permission flags for the stack may not
know how to do it correctly for any memory region.

This logic is sensible for having ancient binaries coexist in a system
with possibly NX memory, but was implemented in a way that equated having
a PT_GNU_STACK marked executable as being as "broken" as lacking the
PT_GNU_STACK marking entirely. Things like unmarked assembly and stack
trampolines may cause PT_GNU_STACK to need an executable bit, but they
do not imply all mappings must be executable.

This confusion has led to situations where modern programs with explicitly
marked executable stack are forced into the READ_IMPLIES_EXEC state when
no such thing is needed. (And leads to unexpected failures when mmap()ing
regions of device driver memory that wish to disallow VM_EXEC[1].)

In looking for other reasons for the READ_IMPLIES_EXEC behavior, Jann
Horn noted that glibc thread stacks have always been marked RWX (until
2003 when they started tracking the PT_GNU_STACK flag instead[2]). And
musl doesn't support executable stacks at all[3]. As such, no breakage
for multithreaded applications is expected from this change.

This changes arm32 and arm64 compat together, to keep behavior the same.

[1] https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
[2] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=54ee14b3882
[3] https://lkml.kernel.org/r/20190423192534.GN23599@brightrain.aerifal.cx

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/elf.c        | 5 +++--
 arch/arm64/include/asm/elf.h | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 2f69cf978fe3..6965a673a141 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -87,12 +87,13 @@ EXPORT_SYMBOL(elf_set_personality);
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-stack |
  * GNU_STACK == RW   | exec-all   | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *this column has no architectural effect: NX markings are ignored by
  *   hardware, but may have behavioral effects when "wants X" collides with
@@ -102,7 +103,7 @@ EXPORT_SYMBOL(elf_set_personality);
  */
 int arm_elf_read_implies_exec(int executable_stack)
 {
-	if (executable_stack != EXSTACK_DISABLE_X)
+	if (executable_stack == EXSTACK_DEFAULT)
 		return 1;
 	if (cpu_architecture() < CPU_ARCH_ARMv6)
 		return 1;
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 7fc779e3f1ec..03ada29984a7 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -106,17 +106,18 @@
  * ELF:              |            |            |
  * -------------------------------|------------|
  * missing GNU_STACK | exec-all   | exec-all   |
- * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-stack | exec-stack |
  * GNU_STACK == RW   | exec-none  | exec-none  |
  *
  *  exec-all  : all PROT_READ user mappings are executable, except when
  *              backed by files on a noexec-filesystem.
  *  exec-none : only PROT_EXEC user mappings are executable.
+ *  exec-stack: only the stack and PROT_EXEC user mappings are executable.
  *
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
+#define elf_read_implies_exec(ex,stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
-- 
2.20.1

