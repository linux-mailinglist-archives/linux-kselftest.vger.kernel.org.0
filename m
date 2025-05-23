Return-Path: <linux-kselftest+bounces-33571-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB7FAC1B58
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A31484A87B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A1226FD9F;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6TfYX4s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20EA253947;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975182; cv=none; b=bog9WG/UA6U308UzYGgUBt4c8Y1M8Ar9LZyLXB4T9xPv4HGGhHg2gHzhembJWK1+piVy1OJ4DfYMa2ZRRueLsWZzhW2xSSVT5O7+E5b6nz7PaR8NFKaCxQY683LpYrGtwE7xPuXMf2jG15Su957FdNz9z9hMIwSEeIJrOYUqB70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975182; c=relaxed/simple;
	bh=SyZieAtSFEV9PhSUW/pPII2GWOki6kjF+H9/UmF+VLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S2quAldDSMjgXSz+t8uL87vmlcT/hx9GNNe+F2yIAaJUSj50MGoXpfAByqQatoJWYAuLdCD8QsH2qobWvjsSDe8QeUeW42jjFjgPVqiUTEio32y9AoohHX5m9vUvNW05omIsIDqrPTJOHp4N/TE7VxbqzbixOlMbngswjYnAcDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6TfYX4s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2A2C4AF0D;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=SyZieAtSFEV9PhSUW/pPII2GWOki6kjF+H9/UmF+VLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J6TfYX4sDZSOJ6cC3hQx7PEZ/P0hoeBP28dc1+Brd35hPTwJ6k97WHpqZa8fbAVeq
	 5juHb3DUqOGqceXSEGpBdDtPMfNBhFApP7wKwIKL/2C2LYJMNlzzzjE3NXvmYvwsfp
	 cpTPBe3558GSOBbtXZAqbFeXxHg2JthsF0YNO/uRw7JXFf41SXkcV3im1cjmlK+M1C
	 VUyAGWEUKYn0vNFv+3oOS0ipT5PIApXQfiGYPlh9IaMysvmKeUOnyVfpdzxHcsFBsS
	 0SBVqnX3srPSUhXwXJv3jgYKgf/cSp/Ef3sURkijydoETVLUBeuCiISO09TxrEUBXW
	 YO1ES1sgKvMwg==
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
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Marco Elver <elver@google.com>,
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
Subject: [PATCH v2 07/14] s390: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:17 -0700
Message-Id: <20250523043935.2009972-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2325; i=kees@kernel.org; h=from:subject; bh=SyZieAtSFEV9PhSUW/pPII2GWOki6kjF+H9/UmF+VLY=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3/W2hxYfnr9mkd3prUpF7sxH1j6p+qa4A+jPlbJO ZrHeJwyOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACaynZfhn9Ljrme7X4ZanbzI enOKheqe3dPnMBjFOf2a8H5d36lL53Yz/BW9v3h2neSzt9ozGS8uNX7i59RwPPZXRVlAzeyrGhL 31/ACAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
s390 this exposed a place where the __init annotation was missing but
ended up being "accidentally correct". Fix this cases and force a couple
functions to be inline with __always_inline.

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
index afa085e8186c..0f83c82af7a6 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -143,7 +143,7 @@ bool force_dma_unencrypted(struct device *dev)
 }
 
 /* protected virtualization */
-static void pv_init(void)
+static void __init pv_init(void)
 {
 	if (!is_prot_virt_guest())
 		return;
-- 
2.34.1


