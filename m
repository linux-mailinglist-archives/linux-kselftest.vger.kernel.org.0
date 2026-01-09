Return-Path: <linux-kselftest+bounces-48586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D66BD072EF
	for <lists+linux-kselftest@lfdr.de>; Fri, 09 Jan 2026 06:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B3B3016359
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Jan 2026 05:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A2C22576E;
	Fri,  9 Jan 2026 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="MKmBQjpf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4353770B;
	Fri,  9 Jan 2026 05:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767935524; cv=none; b=P4mGkaJllsfzKEbi3O7jlzozLYobbPZ+TJw0rMHdtyNxgPjUHG1nW/BGlT6OYaOYDBAaBtBZeBy6cWZBJyo/omkJrF8J9NoBbM+rkXgjQMX03voAQCAPnLndP6v5JIsdnK8Lm1aXZrgl8elqRbPu+rj+zA+h8OM1aZxj56Dd6UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767935524; c=relaxed/simple;
	bh=XUGcHWBeKsSGyKahv/f9EJ/2cAIemFw0hvMY1sSvpLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5GrKcMcUvBPgxy47udxC4FkNDi2sx+ZRasG5aDdO3VQ61pLr3beFnhCT59Ata3XteyO1+x1uVrHpS6MqE7zwl8qRB7167Rf3fPL19crV4V+KkQJgdK77aHvfqAQEVe241M7rq9X8+wLzTTPKHZgw1n4voRpEj6Y0lktvGvSDBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=MKmBQjpf; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay2.mymailcheap.com (relay2.mymailcheap.com [217.182.66.162])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 4C88E2022D;
	Fri,  9 Jan 2026 05:11:54 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay2.mymailcheap.com (Postfix) with ESMTPS id 434793E877;
	Fri,  9 Jan 2026 05:11:46 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 4B996400D4;
	Fri,  9 Jan 2026 05:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1767935504; bh=XUGcHWBeKsSGyKahv/f9EJ/2cAIemFw0hvMY1sSvpLA=;
	h=From:To:Cc:Subject:Date:From;
	b=MKmBQjpfw3rjzq1XIKddnhmvXl4W21WgFm7GKA2WJWuobYtzF5ETYkoBj70Jj8GhW
	 iPZfi6ThuPeUymAoQVr1kVKaGmROIxh/81TWsCWF0z0HTroQu+iKirfg0oJ1YwZ+Jl
	 jyEq0RexZEMVlx7+MKKp8jEhf5OYpr3p7c1h9ZVE=
Received: from Mir.wok.cipunited.com (unknown [130.162.235.122])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 3DAFC407DF;
	Fri,  9 Jan 2026 05:11:37 +0000 (UTC)
From: Lain Fearyncess Yang <fearyncess@aosc.io>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>,
	Mingcong Bai <jeffbai@aosc.io>,
	"Lain \"Fearyncess\" Yang" <fearyncess@aosc.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Arnd Bergmann <arnd@arndb.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH] loongarch: wire up memfd_secret system call
Date: Fri,  9 Jan 2026 13:10:51 +0800
Message-ID: <20260109051054.188030-1-fearyncess@aosc.io>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4B996400D4
X-Rspamd-Server: nf2.mymailcheap.com
X-Spamd-Result: default: False [1.40 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPFBL_URIBL_EMAIL_FAIL(0.00)[fearyncess.aosc.io:server fail];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Action: no action

From: "Lain \"Fearyncess\" Yang" <fearyncess@aosc.io>

LoongArch supports ARCH_HAS_SET_DIRECT_MAP, therefore wire up the
memfd_secret system call, which depends on it.

Signed-off-by: Lain "Fearyncess" Yang <fearyncess@aosc.io>
---
 arch/loongarch/include/asm/unistd.h     | 1 +
 arch/loongarch/kernel/Makefile.syscalls | 6 +++---
 tools/testing/selftests/mm/Makefile     | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/unistd.h b/arch/loongarch/include/asm/unistd.h
index e2c0f3d86c7bd..e7649c1582482 100644
--- a/arch/loongarch/include/asm/unistd.h
+++ b/arch/loongarch/include/asm/unistd.h
@@ -10,5 +10,6 @@
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_MEMFD_SECRET
 
 #define NR_syscalls (__NR_syscalls)
diff --git a/arch/loongarch/kernel/Makefile.syscalls b/arch/loongarch/kernel/Makefile.syscalls
index cd46c2b69c7fd..6360381baf931 100644
--- a/arch/loongarch/kernel/Makefile.syscalls
+++ b/arch/loongarch/kernel/Makefile.syscalls
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 
-# No special ABIs on loongarch so far
-syscall_abis_32 +=
-syscall_abis_64 +=
+# Add memfd_secret explictly for la64 and la32
+syscall_abis_32 += memfd_secret
+syscall_abis_64 += memfd_secret
diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index eaf9312097f7b..79582438efc4d 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -72,7 +72,7 @@ TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
 TEST_GEN_FILES += map_hugetlb
 TEST_GEN_FILES += map_populate
-ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64))
+ifneq (,$(filter $(ARCH),arm64 riscv riscv64 x86 x86_64 loongarch32 loongarch64))
 TEST_GEN_FILES += memfd_secret
 endif
 TEST_GEN_FILES += migration
-- 
2.52.0


