Return-Path: <linux-kselftest+bounces-39669-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DC2B311B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2638D5C6C6D
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A93C2EDD45;
	Fri, 22 Aug 2025 08:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GVWIKBh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3CB2EBDD2;
	Fri, 22 Aug 2025 08:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851026; cv=none; b=PcPxXr2S2JKoc0mnxbwKmc85nFcPS5tZqopeBxwXmkkyEnTLPVZEpb9mmVRn4StrG+bqzVATKP+pa8GaPSNFQBjzGFefu9O0hqTfodEdri1ck+BFCVrFD3q3hb2d1LeSnhVfu6eJIBtKnon+/PnwP6XC7Il3V88KFNY7lkGBSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851026; c=relaxed/simple;
	bh=W0DS7D8x6Zf79SrfKNqQDnRrrEJR/lLnafAee6VW+oM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUZVQrM6enT6UI+AOzJHqi/IcmHWMLzbBnJUYLwcnlFKQHRS7ukpxpZbo4wE6Tnnlj2hoiSs1eNL+l18Jo7Bpv2AMACgWalOuQJjEfVrzZF7a5NosoHj3OdGeU76nqci+BdSoBuqnhA8pAorLbnrksRGGOZ+Rs5Qz3ozzwIbj7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GVWIKBh9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755851022;
	bh=W0DS7D8x6Zf79SrfKNqQDnRrrEJR/lLnafAee6VW+oM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVWIKBh9ihlMBX5Fn+YlBNuJbGSi8GqX9eRPFApnpkkwsiIvyQRMnZLuT10QU66yX
	 vqg7B2BgPm+cyE4eXy1PKKXWGyxmwD1Jg2uT6JiVg4cvkb3AvnDH+90yOJf+TQfMpX
	 pnc8q5YXa89TwcxOk+JqIcVrRDTAdwT3giy+dCsRslgj5wpEDWrWQ1RZvYzhwYLqV5
	 DV8SWsbzu23eM+BaEzNIYOqkmLiX906nxOwrqtiyEhb75zu26rOrHhtnQkBkgCpGMG
	 0rsvyJHdo7r/+c/tl6aglEfkOKWJaD9KHd8XWbVZNuMYxuScnQrJc8al21Ed3IY3II
	 QNf+g+gTUTYsg==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2AA9717E05F0;
	Fri, 22 Aug 2025 10:23:38 +0200 (CEST)
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
Subject: [PATCH v3 8/8] selftests/mm: pkey-helpers: Remove duplicate __maybe_unused
Date: Fri, 22 Aug 2025 13:21:05 +0500
Message-ID: <20250822082145.4145617-9-usama.anjum@collabora.com>
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

__maybe_unused is now defined in the kselftest.h. Remove from this file
as its not required.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
- Introduced in v2
---
 tools/testing/selftests/mm/pkey-helpers.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index ea404f80e6cb9..fa15f006fa68c 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -84,9 +84,6 @@ extern void abort_hooks(void);
 #ifndef noinline
 # define noinline __attribute__((noinline))
 #endif
-#ifndef __maybe_unused
-# define __maybe_unused __attribute__((__unused__))
-#endif
 
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
-- 
2.47.2


