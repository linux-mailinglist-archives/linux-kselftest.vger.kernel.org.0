Return-Path: <linux-kselftest+bounces-39668-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E5BB311AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E35C790C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5CD2EBDCD;
	Fri, 22 Aug 2025 08:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mo3SXVoQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B07E2ED156;
	Fri, 22 Aug 2025 08:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851021; cv=none; b=bmPAxeB+SviGhLemYlUlm/k4iuBRpWT6w6jBt/HBdwBw9WF9EUUuZ4iDbtXYp2r9XQL3VolgXinLLRKMABFa7ggClsVbO3YAMoZbaE4EjUtPr0Lp9NGTcqZ6o9iCEKCQFY+8aet0agknGABDv1VsXmMlqT/3AT4bnCLb2SKPLA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851021; c=relaxed/simple;
	bh=0jRkmhz63wy9fDzRoFQ6jLTDJnLHcryUWGPCMeOuRPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbCz+nBa1SBRIGm2hh8n6i5aXJjpwil14HIT+gRx9AqK6OfI+JZb6c3An5ChL1nyU40/pI4r1Z69xPUEi+Q/4tVWM1pj+QgOK6Az56yti5iFzBhemmYw9B0mlk/na5xV/3QLbV+Pr8je8ztIFQiAG2YrdMCd8bhel70DMNUyIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mo3SXVoQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755851017;
	bh=0jRkmhz63wy9fDzRoFQ6jLTDJnLHcryUWGPCMeOuRPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mo3SXVoQX00rreJeQtrS4eVBtHuxZoC8Om/y8ytIGq/Hm+AIS2sawTRGxPwOS96W9
	 wNBFW/mw/O9sWy7szdGOw8HycqUR4gcMMkN/DhV3XbwxRqMXICTXebJxJwdq3VP+iZ
	 Sh1f3k96yvxyiCKRHOcXjOl+Dme79Uf7J+1m+/8oHUvKVS+3YI/N5WHO7s7M+6Vn2B
	 t1cOTldSFakNHnWURgZ7YMM+uFdHevBi57TnfgZ6vNWu+h4NTP4B5sDG6RZCUviId/
	 hncIEU2TG1qFkdVd3SZCasIs8VCwuDleksbR6kr2GDk1WkZZh9Z3+dLxBd2dyLL/5u
	 +GqkA+lOGfJPQ==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A30817E0458;
	Fri, 22 Aug 2025 10:23:33 +0200 (CEST)
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
Subject: [PATCH v3 7/8] selftests/mm: mark variable unused with macro
Date: Fri, 22 Aug 2025 13:21:04 +0500
Message-ID: <20250822082145.4145617-8-usama.anjum@collabora.com>
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

Use __always_unused macro instead of raw compiler attribute.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Introduced in v2
---
 tools/testing/selftests/mm/protection_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 6281d4c61b50e..967181bcb4120 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -1302,7 +1302,7 @@ static void test_mprotect_with_pkey_0(int *ptr, u16 pkey)
 
 static void test_ptrace_of_child(int *ptr, u16 pkey)
 {
-	__attribute__((__unused__)) int peek_result;
+	int __always_unused peek_result;
 	pid_t child_pid;
 	void *ignored = 0;
 	long ret;
-- 
2.47.2


