Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16F4A1583A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2020 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbgBJTbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Feb 2020 14:31:01 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37688 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727639AbgBJTbB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:01 -0500
Received: by mail-ot1-f67.google.com with SMTP id d3so7577984otp.4
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2020 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6noGYPwM3SA0qSn1DjhC04WI3GU5Jbgm29601EFLQxY=;
        b=hvrKfX5YTyjWi1ypYrma3QUvOIzzwx5eP1e5SWnVM7fYdEB7cTXp0VLscQZXxlorII
         KASkYlwnUbwRoj+rvzhAZPJR542QwWgAtt0bf9LEgpg4gV9JV9tO3B0r5MmgGnJbfqjc
         KS/hLBOlgW90PWNOGQmPIgcyzMg0ZELj7LhF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6noGYPwM3SA0qSn1DjhC04WI3GU5Jbgm29601EFLQxY=;
        b=pnifBFGk9uwgt1FTgNNrLoiosY+Ca6ahODbdfhCuZwpXCqyDU/4mNshdl7uQTeOmkM
         3cDEPbQ0GWG8R+i6rRzKf5pVsZD4d80CGKWHozpJ6+DYaNkQ/qBf0uWuM5W6wsaxFU2V
         /BBIJcfvU0ZAG5r6VD6UH3mmbWsIlMrhYN9O0zxyhDoPrs3OBK+hfym38rlhYw0ucdbw
         a9WrgiauTGRFfiQeCloJvX+nAvJjJUvfKlYSV8VF0vDxlYE1ubhJJ6PDdSeTQ7c7f8Ki
         W3mtoTeMqY6rtw/7dvCF5aZPXeMqjKSZ9igYOIA6kS3GNs5gPUiWD8Af8rIJqJ4VU5WG
         jQjA==
X-Gm-Message-State: APjAAAUMiljs2uLaZkKvrJ9uWDoC2GnUdaOqrYHkytylvaptwPMLwA1A
        eng6TRR56PQ/u1ZJ57pXDVwCPQ==
X-Google-Smtp-Source: APXvYqzRvao2CNFFWbyoxZWSuc7lKKPgMkVudeHRv3oBDW5/WpFR518lDppuCkgzALOGlW3N5WFORw==
X-Received: by 2002:a9d:6289:: with SMTP id x9mr2292404otk.8.1581363059840;
        Mon, 10 Feb 2020 11:30:59 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm359826oti.44.2020.02.10.11.30.58
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
Subject: [PATCH v3 1/7] x86/elf: Add table to document READ_IMPLIES_EXEC
Date:   Mon, 10 Feb 2020 11:30:43 -0800
Message-Id: <20200210193049.64362-2-keescook@chromium.org>
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

Add a table to document the current behavior of READ_IMPLIES_EXEC in
preparation for changing the behavior.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/elf.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 69c0f892e310..733f69c2b053 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -281,6 +281,25 @@ extern u32 elf_hwcap2;
 /*
  * An executable for which elf_read_implies_exec() returns TRUE will
  * have the READ_IMPLIES_EXEC personality flag set automatically.
+ *
+ * The decision process for determining the results are:
+ *
+ *              CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
+ * ELF:              |            |                  |                |
+ * -------------------------------|------------------|----------------|
+ * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
+ * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |
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
 #define elf_read_implies_exec(ex, executable_stack)	\
 	(executable_stack != EXSTACK_DISABLE_X)
-- 
2.20.1

