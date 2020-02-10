Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94115839C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 20:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727707AbgBJTbD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 14:31:03 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46190 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBJTbC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:02 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so7521617otb.13
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xgo1yExYE1FoOrHi/q0yB3FWShMft6x5k4WGrQxm170=;
        b=L4WYG666B6q1Et3bcdlnVISVkOrsiaz/021i2HOtSDO+5jbbvUU8qOhFuAJpImd9Of
         tHvcCRS71nZ2E2PCYI1v1I7/5Fx8qC14IBkh3bZudUkhVCFVSTRXv68LgS4rolJ8b7NO
         oy2IjZYniOec+89rewQ3DeqzhHAbfLUi9rvdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xgo1yExYE1FoOrHi/q0yB3FWShMft6x5k4WGrQxm170=;
        b=p04vkuCAlGXjT6423ohmZ0eXyJ+bOhyT4CxoZquJFEaoWDlpzstsK+TZTofYo2ELWI
         fWoIUDI9g9aNOaN+P3dXV3hVCIah0fpbdWFS8tEmHCHX+Ch1UzXm6hbflInOn7AHptyf
         N27cfYGk1T6TN8jYVgQ5Ye70jgrWyGH0Q6fJoatNDkeUCoQ3a5cPR1inWPFI4Mer5mPo
         /1cx9Pae3D6vu8XHWQoQrdIkDoccF49JVYmiOMidqsegt50eLmG4ept6czv6pgsZu3Lr
         ZNI1YpuGFBdRjPRz1hxqif9Nr1JtCj5dqClIXeiOkNhrD0Gtsb3wXt0gG9bn8fEHKQ9j
         cJfg==
X-Gm-Message-State: APjAAAVo3yjyQADS7x5Wfo7evzYOFjptasNGZu7hwSjCijaaKBGnGnMN
        YHWpQXP1NrhmMQBL6dRBnXMP/g==
X-Google-Smtp-Source: APXvYqxrCRbeRObAKsREPcdxJmg1NESdR+jwjL0VLXI5HeLb3NvoJQshGJ4OJNNqOglQAXv1YayQEA==
X-Received: by 2002:a9d:6e8f:: with SMTP id a15mr2204441otr.178.1581363060517;
        Mon, 10 Feb 2020 11:31:00 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b145sm356027oii.31.2020.02.10.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:30:58 -0800 (PST)
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
Subject: [PATCH v3 4/7] arm32/64, elf: Add tables to document READ_IMPLIES_EXEC
Date:   Mon, 10 Feb 2020 11:30:46 -0800
Message-Id: <20200210193049.64362-5-keescook@chromium.org>
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

Add tables to document the current behavior of READ_IMPLIES_EXEC in
preparation for changing the behavior for both arm64 and arm.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm/kernel/elf.c        | 24 +++++++++++++++++++++---
 arch/arm64/include/asm/elf.h | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/elf.c b/arch/arm/kernel/elf.c
index 182422981386..2f69cf978fe3 100644
--- a/arch/arm/kernel/elf.c
+++ b/arch/arm/kernel/elf.c
@@ -78,9 +78,27 @@ void elf_set_personality(const struct elf32_hdr *x)
 EXPORT_SYMBOL(elf_set_personality);
 
 /*
- * Set READ_IMPLIES_EXEC if:
- *  - the binary requires an executable stack
- *  - we're running on a CPU which doesn't support NX.
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *              CPU: | lacks NX*  | has NX     |
+ * ELF:              |            |            |
+ * -------------------------------|------------|
+ * missing GNU_STACK | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RW   | exec-all   | exec-none  |
+ *
+ *  exec-all  : all PROT_READ user mappings are executable, except when
+ *              backed by files on a noexec-filesystem.
+ *  exec-none : only PROT_EXEC user mappings are executable.
+ *
+ *  *this column has no architectural effect: NX markings are ignored by
+ *   hardware, but may have behavioral effects when "wants X" collides with
+ *   "cannot be X" constraints in memory permission flags, as in
+ *   https://lkml.kernel.org/r/20190418055759.GA3155@mellanox.com
+ *
  */
 int arm_elf_read_implies_exec(int executable_stack)
 {
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index b618017205a3..7fc779e3f1ec 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -96,6 +96,26 @@
  */
 #define elf_check_arch(x)		((x)->e_machine == EM_AARCH64)
 
+/*
+ * An executable for which elf_read_implies_exec() returns TRUE will
+ * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *             CPU*: | arm32      | arm64      |
+ * ELF:              |            |            |
+ * -------------------------------|------------|
+ * missing GNU_STACK | exec-all   | exec-all   |
+ * GNU_STACK == RWX  | exec-all   | exec-all   |
+ * GNU_STACK == RW   | exec-none  | exec-none  |
+ *
+ *  exec-all  : all PROT_READ user mappings are executable, except when
+ *              backed by files on a noexec-filesystem.
+ *  exec-none : only PROT_EXEC user mappings are executable.
+ *
+ *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
+ *
+ */
 #define elf_read_implies_exec(ex,stk)	(stk != EXSTACK_DISABLE_X)
 
 #define CORE_DUMP_USE_REGSET
-- 
2.20.1

