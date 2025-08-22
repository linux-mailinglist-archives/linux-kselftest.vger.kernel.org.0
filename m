Return-Path: <linux-kselftest+bounces-39667-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F58B311BD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 757661D0224B
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9284F2EBBB3;
	Fri, 22 Aug 2025 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Vqqzialm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BD32EBB9F;
	Fri, 22 Aug 2025 08:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851016; cv=none; b=MKYL2JwS1E4RY4DnApC2Xozq+4ffJqn4DmMuluF9iBZG1dxlxJomYbPCGaQNF+74S9V4dOqW/wtSEwhxLRwu1Yop9caJRPTVIeughfszcs1Kb55MYexq7PAeMj8Ab4rDHqHlTOP6mCjbVo9oEsQXyUDBufPFHBAYJnupQL8g3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851016; c=relaxed/simple;
	bh=6J5PSXxqtGmjRoT5d0cfiijsJ6CAzjFznigi7LNiQE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQEcEUbtQtiaNFAX/+0T3sV6fbplfdybxa7myd98HSxgW3mOpDSFlNMfBIscSguAO01BgjCMjO6EoK1bMJH9vAbw7uAv+oPWRyVdE0z5e1O3Tce0mDFEnSCRqp818ay3WkyhbQ/3JwykLg33ziAi873KgLh+G8cDeTqLy8gOyDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Vqqzialm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755851012;
	bh=6J5PSXxqtGmjRoT5d0cfiijsJ6CAzjFznigi7LNiQE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vqqzialm4g5wrtv4tvyw9MWWk2aTcdXQRG/VnvvvKbnIolO8f8llGOC4Oc6EVk4BN
	 XM9SJgbGlENhJR55OH6sBWy3cuyX5s//oWsx8t4qNIo7DDmccDvzX8FWuyEJ/SvIX/
	 UIRQzy1GoYwa/2d2Exavog6avBcMun0Tslwrn1CX64BdpOyMfGQxgMefXXVlRkSiTu
	 GvO0r4vVX028IQWvhrdiPZ0keGQKh6Zk9+NVXJdH4TC3LXdbdTs6pcIpcdc/vSZ48S
	 bTYiBDOB4vR9KrDQOnhiRVV/SbnAU/+HiIG9x7/AqJPe6wrPSuqJpoLqJT5o3wOlgJ
	 Nv1Ox3SSXTWhw==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BA4FC17E12DF;
	Fri, 22 Aug 2025 10:23:26 +0200 (CEST)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	John Hubbard <jhubbard@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Leon Romanovsky <leon@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	kevin.brodsky@arm.com
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v3 6/8] selftests/mm: Fix unused parameter warnings for different architectures
Date: Fri, 22 Aug 2025 13:21:03 +0500
Message-ID: <20250822082145.4145617-7-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250822082145.4145617-1-usama.anjum@collabora.com>
References: <20250822082145.4145617-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are functions which have unused arguments for different
architectures. Separate the code for each architecture and move #ifdef
arch outside these functions.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
 tools/testing/selftests/mm/mseal_test.c       |  8 +++++--
 .../selftests/mm/pkey_sighandler_tests.c      | 21 ++++++++++++++++---
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 005f29c86484e..4c2a232796866 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -131,17 +131,21 @@ static unsigned int __read_pkey_reg(void)
 	return pkey_reg;
 }
 
+#if defined(__i386__) || defined(__x86_64__) /* arch */
 static void __write_pkey_reg(u64 pkey_reg)
 {
-#if defined(__i386__) || defined(__x86_64__) /* arch */
 	unsigned int eax = pkey_reg;
 	unsigned int ecx = 0;
 	unsigned int edx = 0;
 
 	asm volatile(".byte 0x0f,0x01,0xef\n\t"
 			: : "a" (eax), "c" (ecx), "d" (edx));
-#endif
 }
+#else
+static void __write_pkey_reg(u64 __always_unused pkey_reg)
+{
+}
+#endif
 
 static unsigned long pkey_bit_position(int pkey)
 {
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
index eb4ef8532c0bf..bfa88fe188f66 100644
--- a/tools/testing/selftests/mm/pkey_sighandler_tests.c
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -41,11 +41,12 @@ static siginfo_t siginfo = {0};
  * syscall will attempt to access the PLT in order to call a library function
  * which is protected by MPK 0 which we don't have access to.
  */
+#ifdef __x86_64__
 static __always_inline
 long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 {
 	unsigned long ret;
-#ifdef __x86_64__
+
 	register long r10 asm("r10") = a4;
 	register long r8 asm("r8") = a5;
 	register long r9 asm("r9") = a6;
@@ -53,12 +54,26 @@ long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 		      : "=a"(ret)
 		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
 		      : "rcx", "r11", "memory");
+	return ret;
+}
 #elif defined __i386__
+static __always_inline
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long __always_unused a6)
+{
+	unsigned long ret;
+
 	asm volatile ("int $0x80"
 		      : "=a"(ret)
 		      : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)
 		      : "memory");
+	return ret;
+}
 #elif defined __aarch64__
+static __always_inline
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
+{
+	unsigned long ret;
+
 	register long x0 asm("x0") = a1;
 	register long x1 asm("x1") = a2;
 	register long x2 asm("x2") = a3;
@@ -71,11 +86,11 @@ long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
 		      : "r"(x0), "r"(x1), "r"(x2), "r"(x3), "r"(x4), "r"(x5), "r"(x8)
 		      : "memory");
 	ret = x0;
+	return ret;
+}
 #else
 # error syscall_raw() not implemented
 #endif
-	return ret;
-}
 
 static inline long clone_raw(unsigned long flags, void *stack,
 			     int *parent_tid, int *child_tid)
-- 
2.47.2


