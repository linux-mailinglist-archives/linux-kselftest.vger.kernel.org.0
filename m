Return-Path: <linux-kselftest+bounces-37537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDB5B09792
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04C964A7618
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAD9277CAD;
	Thu, 17 Jul 2025 23:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCLGzgvX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCED2550CF;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=X7cieHtf3UnRcugMr4rdvDFeEiw7hIb1aLo1LS6jNiGfV5DGtpMn98ujphqTNzYYc5jXy8NwSQPVzmW8nw+XOhSIf5hrGb6Vjfz1B6GLqru77nsVSsDcPph6MkFsZfWzoeaSJ3LuWTDCgTiszJlQIQjNyiZ55well8s4dDFcinM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=w4dfSlEX1TBFugBqGp8JAUT2yBh6pSwtKD0mxGK1YQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FmYT57sb6M1aNQ+p1ld2yePvwi/U+9LWqhALUZTCNV0MA+y8d4IvMO0GhRlfHN+RVHdM4t5FyQxpC0k/2gaEVZgwZIzDdlMBKDw2Xq3zn3ju9uQeBfSFMm5oBR8InBfl8FUVaT2WfU3J+jZwwQ5+40oRYOzS45QwxfKTCoTt5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCLGzgvX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A518C19424;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=w4dfSlEX1TBFugBqGp8JAUT2yBh6pSwtKD0mxGK1YQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bCLGzgvXVHsHkz8w3Y0Kb2UmtdjsIVjMDj9d4MbqlBY2vMFC06YtJ8ndKGIbuwa4T
	 cTP6dtj6xqil4DQudwS8dDj06vEw0tdANDNY4YWGYpv9PBYCZV7PzKOyZ20A3DqmIk
	 GoL2uVHjWuIIwUnzP5LSkfJEjV/ENP7/xGPvPrKD5vizLyb9mhYCmDeaooINsuO4xm
	 unrjEQZvM3C5gvqrYkyStpgP4R+W5gIXbatg6wHTzD7uaZLrZVYwsHz9djIrXk1hCu
	 dOEphjp1hPldDWw3cfeJYEoVkoG/ytzYmICpWeNgkb9M3gseDiqbCDsFjvUvuvY+6k
	 VQE2gjmuFnegA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Gaosheng Cui <cuigaosheng1@huawei.com>,
	linux-s390@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 07/13] s390: Handle KCOV __init vs inline mismatches
Date: Thu, 17 Jul 2025 16:25:12 -0700
Message-Id: <20250717232519.2984886-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2371; i=kees@kernel.org; h=from:subject; bh=w4dfSlEX1TBFugBqGp8JAUT2yBh6pSwtKD0mxGK1YQU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbdG/2KY8Xu85O2j+4nWyVw/mC3Emf3168P7KWTN/x p5rPzPPrKOUhUGMi0FWTJElyM49zsXjbXu4+1xFmDmsTCBDGLg4BWAiD+QZGT4bhW+wyPBOq197 8b3pj39iU253eKhfucT7+XV+gIb17DkM/738av/xuz8z5jvAWfzMWOHsI8UljCZsWs2/wlaI/f6 Yzg0A
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
s390 this exposed a place where the __init annotation was missing but
ended up being "accidentally correct". Fix this cases and force a couple
functions to be inline with __always_inline.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Gaosheng Cui <cuigaosheng1@huawei.com>
Cc: <linux-s390@vger.kernel.org>
---
 arch/s390/hypfs/hypfs.h      | 2 +-
 arch/s390/hypfs/hypfs_diag.h | 2 +-
 arch/s390/mm/init.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/hypfs/hypfs.h b/arch/s390/hypfs/hypfs.h
index 83ebf54cca6b..4dc2e068e0ff 100644
--- a/arch/s390/hypfs/hypfs.h
+++ b/arch/s390/hypfs/hypfs.h
@@ -48,7 +48,7 @@ void hypfs_sprp_exit(void);
 
 int __hypfs_fs_init(void);
 
-static inline int hypfs_fs_init(void)
+static __always_inline int hypfs_fs_init(void)
 {
 	if (IS_ENABLED(CONFIG_S390_HYPFS_FS))
 		return __hypfs_fs_init();
diff --git a/arch/s390/hypfs/hypfs_diag.h b/arch/s390/hypfs/hypfs_diag.h
index 7090eff27fef..b5218135b8fe 100644
--- a/arch/s390/hypfs/hypfs_diag.h
+++ b/arch/s390/hypfs/hypfs_diag.h
@@ -19,7 +19,7 @@ int diag204_store(void *buf, int pages);
 int __hypfs_diag_fs_init(void);
 void __hypfs_diag_fs_exit(void);
 
-static inline int hypfs_diag_fs_init(void)
+static __always_inline int hypfs_diag_fs_init(void)
 {
 	if (IS_ENABLED(CONFIG_S390_HYPFS_FS))
 		return __hypfs_diag_fs_init();
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 074bf4fb4ce2..e4953453d254 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -142,7 +142,7 @@ bool force_dma_unencrypted(struct device *dev)
 }
 
 /* protected virtualization */
-static void pv_init(void)
+static void __init pv_init(void)
 {
 	if (!is_prot_virt_guest())
 		return;
-- 
2.34.1


