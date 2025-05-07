Return-Path: <linux-kselftest+bounces-32590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA3AAE8A1
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 20:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A58961B619B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 May 2025 18:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4910728E569;
	Wed,  7 May 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VAzZdzFh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91CD28937E;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746641779; cv=none; b=JTXv10zWUqCut3uhGZxhvgFTqlOBTeqhh8dLDyG6j0AGKA/gCuWyO843BKO3IGoH1k9TyZeIzKb7pBAAaU/FsqrA5gEx3bzTBXP3yr3vJwmT4nt2IPRK59GvEdbG7r95A9rq2tkVrB1IagfXhUmAo4PYpcchK68emFhfmm024T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746641779; c=relaxed/simple;
	bh=6rPKdmTAkNXJoVHpXuZmVez15fxfVheZEKRm8PRLszw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pz23SZq4UcDLQhPkRMyrhSl7Ykyjq8b1DsI/jpql+pzzzPvGi5+Wt9gfRvZ8vPq3FkywR4hKAwnRP+b5RSWa++DQEDgTy0P74t2oXrko8CadJL/oBpwiXHhSPVRLaLrExtlvNAENvyfLn2xlsUM1N9b1AODU8TODMg/apDzQZK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VAzZdzFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EB2C4CEEE;
	Wed,  7 May 2025 18:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746641778;
	bh=6rPKdmTAkNXJoVHpXuZmVez15fxfVheZEKRm8PRLszw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VAzZdzFhyHK4hcYMx6h4ckMTSI+LlhSKdAtwFvjz9tbhT0nBTr5KJFgWlhi2wtZW/
	 ZzGxndt5dvrv00FL5R15AI1le3EUu9V88krt5z14PpQMWgd+L30/QUDzBqofcmrIgl
	 yxpJqJbdVkT2LinqfQHV62UV6AQafZKnP3k3QlBcIjQGFePWBeJekzdtgna8DoiOQ/
	 +Nh47SJz4O6J/weH9MlaBma8jtuS5N4n+8CtMkcM9sBYa5GwiBdMIZVmE4P9hSAzZY
	 TaSOCwfdoTaWqWcAkblT7sxQ9LCysQFg11kYlLPMizueE96aREtxnfaLBY1vYuxwI8
	 UZYfJy+RQWs6A==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	kasan-dev@googlegroups.com,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org,
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
Subject: [PATCH 2/8] init.h: Disable sanitizer coverage for __init and __head
Date: Wed,  7 May 2025 11:16:08 -0700
Message-Id: <20250507181615.1947159-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507180852.work.231-kees@kernel.org>
References: <20250507180852.work.231-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2847; i=kees@kernel.org; h=from:subject; bh=6rPKdmTAkNXJoVHpXuZmVez15fxfVheZEKRm8PRLszw=; b=owGbwMvMwCVmps19z/KJym7G02pJDBnSi7MPFhcujE1p83GNUj2Vetl/6Q7ju5xS7tumPJN5t DQ2USaro5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCKXJBgZ/igUKc35wvT3UdQu sR4u1YLZi59d21ljXfz+Qtf5bvnJmowMzbyyqauq9ef6NGj9Et9r9GSFGxfTTW/fIBMRRfdvObL 8AA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While __noinstr already contained __no_sanitize_coverage, it needs to
be added to __init and __head section markings to support the Clang
implementation of CONFIG_STACKLEAK. This is to make sure the stack depth
tracking callback is not executed in unsupported contexts.

The other sanitizer coverage options (trace-pc and trace-cmp) aren't
needed in __head nor __init either ("We are interested in code coverage
as a function of a syscall inputs"[1]), so this appears safe to disable
for them as well.

Link: https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/kernel/kcov.c?h=v6.14#n179 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: <x86@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: <kasan-dev@googlegroups.com>
---
 arch/x86/include/asm/init.h | 2 +-
 include/linux/init.h        | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/init.h b/arch/x86/include/asm/init.h
index 8b1b1abcef15..6bfdaeddbae8 100644
--- a/arch/x86/include/asm/init.h
+++ b/arch/x86/include/asm/init.h
@@ -5,7 +5,7 @@
 #if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION < 170000
 #define __head	__section(".head.text") __no_sanitize_undefined __no_stack_protector
 #else
-#define __head	__section(".head.text") __no_sanitize_undefined
+#define __head	__section(".head.text") __no_sanitize_undefined __no_sanitize_coverage
 #endif
 
 struct x86_mapping_info {
diff --git a/include/linux/init.h b/include/linux/init.h
index ee1309473bc6..c65a050d52a7 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -49,7 +49,9 @@
 
 /* These are for everybody (although not all archs will actually
    discard it in modules) */
-#define __init		__section(".init.text") __cold  __latent_entropy __noinitretpoline
+#define __init		__section(".init.text") __cold __latent_entropy	\
+						__noinitretpoline	\
+						__no_sanitize_coverage
 #define __initdata	__section(".init.data")
 #define __initconst	__section(".init.rodata")
 #define __exitdata	__section(".exit.data")
-- 
2.34.1


