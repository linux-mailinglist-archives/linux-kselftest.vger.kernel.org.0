Return-Path: <linux-kselftest+bounces-37532-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862D8B09794
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 01:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97A94A779B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 23:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00AD2676CD;
	Thu, 17 Jul 2025 23:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncp2Paoy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CEE256C89;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794721; cv=none; b=A5t7sdEChzMDfIAArfNi01iZpl9zA7lrAVZUftxtKDHxMx14ZGwBr7oODWGZWwaAqeGzw/QTB2gtyW59ENIJM4JTXieNZS655MgtzllGDxOT3WPPgEsL0H9QSnD9FEkz9ynBhutFTC9Juf1y75j7kxn6enTBf6s6l2KhY2ls1mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794721; c=relaxed/simple;
	bh=osvUgpgEO64bNEnbAttwqVDbq5vm5KYdqiVGeRyBetc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=l2UOSrz0Oo+h9c4CD3OPWAliBAqEfhwV7q0Eo0ITRCApyE/z95ayCQCysFPFjPxH1EH9KPCp01rgKMmfspmklwTw2NLckAgifZhwZteytBGpXhnyHwndwUh6eDqKphEOZPqfNNJzrfY2B6i6d769OAIRo2LrBLM3+LY1PJR7EU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncp2Paoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A59C4AF53;
	Thu, 17 Jul 2025 23:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794720;
	bh=osvUgpgEO64bNEnbAttwqVDbq5vm5KYdqiVGeRyBetc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ncp2PaoyESx2mGPRUqpIl0USPY8odVZlpHCAh8Jn8DMOfU2i3n6bxhTits5POjFD/
	 bY4yixVHOiYP4Xr5dlJRUNXHIu0s3iF+7Jvzx7ManD4PgBcgoDYwpxzyP5HZBUbEKf
	 N5jHFE8Q4iH4wYl9qS/j1MV1rhYbo+WiB/igaYTWTayw1U+4sCLdqlfJBc3EAxGAbp
	 nGQOt09scJ/N1rGKReZbb+NdWKcJQXbmcKxaPIjYigz7JLWgHP6pmAB6xsB3vM43U0
	 65A2iSAqp3UWSI4HOKWJdn4TUFpTPnOHuWSJMjk/OBW/zagGOcIRnp8f70lkanBO7A
	 GO84yR/PXKBLA==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	kernel test robot <lkp@intel.com>,
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
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3 08/13] powerpc/mm/book3s64: Move kfence and debug_pagealloc related calls to __init section
Date: Thu, 17 Jul 2025 16:25:13 -0700
Message-Id: <20250717232519.2984886-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717231756.make.423-kees@kernel.org>
References: <20250717231756.make.423-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3037; i=kees@kernel.org; h=from:subject; bh=CG642rxsBTdbPAtwaZfuIeBH3/DpJlnhh8PcAMrPPa0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmVbTEqNd9vzJzycNaO4gcXLpt8qbN9PS/KjKft9UGzD eY5vwSjO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZSI8jI8GVbRcbCExcPa6wy fDZNO+lvONfEslf91zgk5+/tDwzasp+RYXdX0OYrJ9+2fley5O3+YLKGlStl6nnrVzK5ghu5VvP GMQEA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

Move a few kfence and debug_pagealloc related functions in hash_utils.c
and radix_pgtable.c to __init sections since these are only invoked once
by an __init function during system initialization.

i.e.
- hash_debug_pagealloc_alloc_slots()
- hash_kfence_alloc_pool()
- hash_kfence_map_pool()
  The above 3 functions only gets called by __init htab_initialize().

- alloc_kfence_pool()
- map_kfence_pool()
  The above 2 functions only gets called by __init radix_init_pgtable()

This should also help fix warning msgs like:

>> WARNING: modpost: vmlinux: section mismatch in reference:
hash_debug_pagealloc_alloc_slots+0xb0 (section: .text) ->
memblock_alloc_try_nid (section: .init.text)

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202504190552.mnFGs5sj-lkp@intel.com/
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c    | 6 +++---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 5158aefe4873..4693c464fc5a 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -343,7 +343,7 @@ static inline bool hash_supports_debug_pagealloc(void)
 static u8 *linear_map_hash_slots;
 static unsigned long linear_map_hash_count;
 static DEFINE_RAW_SPINLOCK(linear_map_hash_lock);
-static void hash_debug_pagealloc_alloc_slots(void)
+static __init void hash_debug_pagealloc_alloc_slots(void)
 {
 	if (!hash_supports_debug_pagealloc())
 		return;
@@ -409,7 +409,7 @@ static DEFINE_RAW_SPINLOCK(linear_map_kf_hash_lock);
 
 static phys_addr_t kfence_pool;
 
-static inline void hash_kfence_alloc_pool(void)
+static __init void hash_kfence_alloc_pool(void)
 {
 	if (!kfence_early_init_enabled())
 		goto err;
@@ -445,7 +445,7 @@ static inline void hash_kfence_alloc_pool(void)
 	disable_kfence();
 }
 
-static inline void hash_kfence_map_pool(void)
+static __init void hash_kfence_map_pool(void)
 {
 	unsigned long kfence_pool_start, kfence_pool_end;
 	unsigned long prot = pgprot_val(PAGE_KERNEL);
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9f908b1a52db..be523e5fe9c5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -363,7 +363,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_KFENCE
-static inline phys_addr_t alloc_kfence_pool(void)
+static __init phys_addr_t alloc_kfence_pool(void)
 {
 	phys_addr_t kfence_pool;
 
@@ -393,7 +393,7 @@ static inline phys_addr_t alloc_kfence_pool(void)
 	return 0;
 }
 
-static inline void map_kfence_pool(phys_addr_t kfence_pool)
+static __init void map_kfence_pool(phys_addr_t kfence_pool)
 {
 	if (!kfence_pool)
 		return;
-- 
2.34.1


