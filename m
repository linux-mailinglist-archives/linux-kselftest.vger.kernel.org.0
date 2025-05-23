Return-Path: <linux-kselftest+bounces-33568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EF6AC1B57
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 06:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3925A42DC6
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 04:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A95D25DAE8;
	Fri, 23 May 2025 04:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHB1UIrX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67D24DD01;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747975181; cv=none; b=BmVjFcHP+03Z90gW2U/DmGv1mT6Jvw88gEu+xZ31kKO0tRL+up7Mr9QuY9C7GbeRakQxSQg9bIkrvf2+lZ2y3siSvp17vnCAM089QckW8bq971T3v7Y8LDmmwxIQ+3dsngju1GL0Z1wb4r/XKVkW+Qx/SVtJyBf7KFeMv2XGP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747975181; c=relaxed/simple;
	bh=yaSxmxtYpasuc+rufEWrdAWe3aDh1VboHkgvW7Uuxmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UomziwWio9H4bDynr6IoRvU6GmqiEPlmT9enYGVbSp4Dw1SM6ezGFSK5yBQ0gXg76W1KTdyqJ28Fg0t5fjIy/iVGebQl8iomLj7D1ITdyFzvDV4HNjRG9khlRNIQ7rHWDbhzfq3x/73oV6ABQfHshzHMtrX17ObGCyFP8mTwjYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHB1UIrX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E840C4CEED;
	Fri, 23 May 2025 04:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747975181;
	bh=yaSxmxtYpasuc+rufEWrdAWe3aDh1VboHkgvW7Uuxmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CHB1UIrXXIJNnDqoawhvxACuyRxlpr3fsHJOcaMiX78eZBw6bj2aCmamSdxBgr0Q1
	 cv2JxCHOnwvyafgtOlwyLeWkIJcvvmBOc3FGaH7CycNh6ciUxu783i7rIN1Q7uR/YZ
	 egoHkAstCNIvH0Ni9mbt5Ty4Gh02RZ66vXL7zkVg5EvNVKTTIDuVY7AvMEtb0fYV8p
	 mJKUBNr2h5nbAO7s6Ui4esyy2FZgHJ+NnCkDJYKNpnSZCOqTVyO+IRaFk0btgFjTdO
	 S8daDPWHmwFh5MEl/KFRRxM9icxB3PHJq5dg1QlY9jE+fNHEdaX6TMoMVDjrVztIdI
	 PtpSj3RRaZDNw==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linuxppc-dev@lists.ozlabs.org,
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
	linux-s390@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 08/14] powerpc: Handle KCOV __init vs inline mismatches
Date: Thu, 22 May 2025 21:39:18 -0700
Message-Id: <20250523043935.2009972-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250523043251.it.550-kees@kernel.org>
References: <20250523043251.it.550-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1981; i=kees@kernel.org; h=from:subject; bh=yaSxmxtYpasuc+rufEWrdAWe3aDh1VboHkgvW7Uuxmk=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn6v3+dEGvzLNyc4frZMlegpp5xqfLf4qvOhQ6vClwWG c4+vkWro5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgFYCJ6nYwMa39MVvl34OWuxWLC YitLL7uZs+fqxoq1bLk+uZ0hXWGaIMP/IouHmyfNuDCZ8fKpT88FFNw8Sr8vU98je2Fj6/LNOe9 62AA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

When KCOV is enabled all functions get instrumented, unless
the __no_sanitize_coverage attribute is used. To prepare for
__no_sanitize_coverage being applied to __init functions, we have to
handle differences in how GCC's inline optimizations get resolved. For
s390 this requires forcing a couple functions to be inline with
__always_inline.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Naveen N Rao <naveen@kernel.org>
Cc: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: <linuxppc-dev@lists.ozlabs.org>
---
 arch/powerpc/mm/book3s64/hash_utils.c    | 2 +-
 arch/powerpc/mm/book3s64/radix_pgtable.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
index 5158aefe4873..93f1e1eb5ea6 100644
--- a/arch/powerpc/mm/book3s64/hash_utils.c
+++ b/arch/powerpc/mm/book3s64/hash_utils.c
@@ -409,7 +409,7 @@ static DEFINE_RAW_SPINLOCK(linear_map_kf_hash_lock);
 
 static phys_addr_t kfence_pool;
 
-static inline void hash_kfence_alloc_pool(void)
+static __always_inline void hash_kfence_alloc_pool(void)
 {
 	if (!kfence_early_init_enabled())
 		goto err;
diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 9f764bc42b8c..3238e9ed46b5 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -363,7 +363,7 @@ static int __meminit create_physical_mapping(unsigned long start,
 }
 
 #ifdef CONFIG_KFENCE
-static inline phys_addr_t alloc_kfence_pool(void)
+static __always_inline phys_addr_t alloc_kfence_pool(void)
 {
 	phys_addr_t kfence_pool;
 
-- 
2.34.1


