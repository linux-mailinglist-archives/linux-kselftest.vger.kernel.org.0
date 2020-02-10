Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89A3E15839E
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 20:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgBJTbF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 14:31:05 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46199 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727761AbgBJTbF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:05 -0500
Received: by mail-ot1-f68.google.com with SMTP id g64so7521792otb.13
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 11:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DhYTjIJlfhAdVkQDwNkbgCuN+O7kJMRLXmPZSNfrFMQ=;
        b=Dq23bl6vQ5GYWu+qXbbm3ywpJuoquMABzduG3ja8SrHuEWakgb5g99LQjU9/o1Dasx
         BSdy+vt620n5X/zV49LCGyY1+af2KOLd6H9OKdhofiuqC49AzF8MrE82v122cbzl6q+1
         5NFBliiePxKLKssh2fiNiQKRiSvwHByvjxNnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DhYTjIJlfhAdVkQDwNkbgCuN+O7kJMRLXmPZSNfrFMQ=;
        b=UVHbo/IC2e0TPlde8LxvDQdi017EMunVG8sNmbD28QwjonGmi7Lt58rT05USUMURx4
         zjAfgfnzJ9/uF7sWupgRgS3RP1zRByREkxXqMTLHw6T47SCmf+aQ4uXo7n3co7EDqeSl
         kR0dDn+JqcLHUzmDWk9Pb9sD0TcvMo0UgKT6Xo4bfsyQJBgYiNgb9+9CZ1dCHXSsl7TH
         dIzdJ8AlxDz99N3KdrgEB8XqBO72UNZ/CT4on2OhRm7Xyr1sTH4PcF0kB2uxTD0BfVfJ
         C0GJvQJgfE/QnJXgiamdIpcWN5lvU1+zq9wfuxSDcrHIVFSmJyshyBs7l7aZATaQbbl6
         qkgw==
X-Gm-Message-State: APjAAAVosQD7g9H8l1d7UxGW3idgwdGpt6HCvnweekjmrRDz77fzJATV
        3+/gNrdU/kc0rCL9EvTc2J/jFA==
X-Google-Smtp-Source: APXvYqwa0CUBeygnsizZAtkXo0YElyu1+Z7uLDxN7c38yNFFZ5699HBdDmcdJAXUU7zBCJHjZcCrcA==
X-Received: by 2002:a9d:7508:: with SMTP id r8mr2262030otk.116.1581363063188;
        Mon, 10 Feb 2020 11:31:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t22sm416199otq.18.2020.02.10.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 11:31:01 -0800 (PST)
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
Subject: [PATCH v3 6/7] arm64, elf: Disable automatic READ_IMPLIES_EXEC for 64-bit address spaces
Date:   Mon, 10 Feb 2020 11:30:48 -0800
Message-Id: <20200210193049.64362-7-keescook@chromium.org>
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

With arm64 64-bit environments, there should never be a need for automatic
READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
(as in, the default memory protection should be NX unless a region
explicitly requests to be executable).

Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/include/asm/elf.h | 4 ++--
 fs/compat_binfmt_elf.c       | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 03ada29984a7..ea9221ed68a1 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -105,7 +105,7 @@
  *             CPU*: | arm32      | arm64      |
  * ELF:              |            |            |
  * -------------------------------|------------|
- * missing GNU_STACK | exec-all   | exec-all   |
+ * missing GNU_STACK | exec-all   | exec-none  |
  * GNU_STACK == RWX  | exec-stack | exec-stack |
  * GNU_STACK == RW   | exec-none  | exec-none  |
  *
@@ -117,7 +117,7 @@
  *  *all arm64 CPUs support NX, so there is no "lacks NX" column.
  *
  */
-#define elf_read_implies_exec(ex,stk)	(stk == EXSTACK_DEFAULT)
+#define compat_elf_read_implies_exec(ex, stk)	(stk == EXSTACK_DEFAULT)
 
 #define CORE_DUMP_USE_REGSET
 #define ELF_EXEC_PAGESIZE	PAGE_SIZE
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index aaad4ca1217e..3068d57436b3 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -113,6 +113,11 @@
 #define	arch_setup_additional_pages compat_arch_setup_additional_pages
 #endif
 
+#ifdef	compat_elf_read_implies_exec
+#undef	elf_read_implies_exec
+#define	elf_read_implies_exec compat_elf_read_implies_exec
+#endif
+
 /*
  * Rename a few of the symbols that binfmt_elf.c will define.
  * These are all local so the names don't really matter, but it
-- 
2.20.1

