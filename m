Return-Path: <linux-kselftest+bounces-39661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 294C3B3119E
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 10:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C24C7AA08C
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Aug 2025 08:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A712EACE1;
	Fri, 22 Aug 2025 08:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n3hw1yrz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545572475C7;
	Fri, 22 Aug 2025 08:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755850988; cv=none; b=JBLJN8HHrWdUqMVSnsi9BxWMY8U2mslo2qsCDiNEc1JUowPnlP2WEsDLFfAQkkgzPEIU+Wz0fUeY6ep2XGUUpN1v6QpjqCrd6dOGHDojrRnUwPuyhG7a+Sy9id3vu0asHsFJfFKmoqSDoy8t8e29vrywNX24wlqHYEKCfkVfjxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755850988; c=relaxed/simple;
	bh=hVavycqMrPemBzWjKcAFiAsh6MQHU/3hvyOrGOvCTsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c/8OLmqmzm0KOxnFQRem3mTYEIg/dFNvnHF3dJO4Vp7ORf7Em00Xzrkx0NkGthd9PEsUUNiqwrcuF92IBksE+mJBzI7XdCVd0ktnHE9drXFMJoq28VnTvcBQj0OQoac52c83pIFzNju9xgFbbDoUERqv9zSHWy7ogttl9Qx5hEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n3hw1yrz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1755850979;
	bh=hVavycqMrPemBzWjKcAFiAsh6MQHU/3hvyOrGOvCTsk=;
	h=From:To:Cc:Subject:Date:From;
	b=n3hw1yrzFgymnMe6I39Ns8dAbaU8ke443nB8cex/RWNnDprZnhw0sqOPfZd4Le99v
	 hPXcfKSRVBu4C6xGfAg4cssdVFfafUv8ugUAapbCOl2TmLMVFQYQoD3oEtLxbl/zeS
	 GciTxfY981eGp4kmylCkGfyZ0M6ADazxeVrzmuxE/QNBk3KBbYFFbBTs1N8z7AItg+
	 CFWwaYpj/vmujGXXm52IYTyLG+3fQi2RpwYFpU+LCXWvvfA71bg53Sp49dPSse3sG7
	 cI7woKUzjOu2DCLTMz2L5ky4xCn+DNnWh12gWAzbToSFmmrV3Yzfm4b9qBiaZSCQT1
	 /UcWVZwNiAf/w==
Received: from mt.tail9873f4.ts.net (unknown [103.151.43.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6910617E12FF;
	Fri, 22 Aug 2025 10:22:54 +0200 (CEST)
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
Subject: [PATCH v3 0/8] selftests/mm: Add compiler flags and fix found warnings
Date: Fri, 22 Aug 2025 13:20:57 +0500
Message-ID: <20250822082145.4145617-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recently, I reviewed a patch on the mm/kselftest mailing list about a
test which had obvious type mismatch fix in it. It was strange why that
wasn't caught during development and when patch was accepted. This led
me to discover that those extra compiler options to catch these warnings
aren't being used. When I added them, I found tens of warnings in just
mm suite.

In this series, I'm adding these flags and fixing those warnings. In the
last try several months ago [1], I'd patches for individual tests. I've
made patches better by grouping the same type of fixes together. Hence
there is no changelog for individual patches.

The changes have been build tested on x86_64, arm64, powerpc64 and
partially
on riscv64. The test run with and without this series has been done on
x86_64.

---
Changes since v1:
- Drop test harness patch which isn't needed anymore
- Revamp how patches are written per same kind of failure

Changes since v2:
- split_huge_page_test.c: better deadcode removal
- Drop -Wunused-parameter flag as kernel also doesn't enable it and it
  causes too much hassle
- Drop previous patches 6 and 7 as they are just marking unused parameters
  with unused flag
- Rename __unused to __always_unused and also add __maybe_unused

Muhammad Usama Anjum (8):
  selftests/mm: Add -Wunreachable-code and fix warnings
  selftests/mm: protection_keys: Fix dead code
  selftests: kselftest.h: Add unused macro
  selftests/mm: Add -Wunused family of flags
  selftests/mm: Remove unused parameters
  selftests/mm: Fix unused parameter warnings for different
    architectures
  selftests/mm: mark variable unused with macro
  selftests/mm: pkey-helpers: Remove duplicate __maybe_unused

 tools/testing/selftests/kselftest.h           |  8 ++++++
 tools/testing/selftests/mm/Makefile           |  2 +-
 tools/testing/selftests/mm/compaction_test.c  |  2 +-
 tools/testing/selftests/mm/cow.c              |  2 +-
 tools/testing/selftests/mm/droppable.c        |  2 +-
 tools/testing/selftests/mm/gup_longterm.c     |  2 +-
 tools/testing/selftests/mm/hmm-tests.c        |  5 ++--
 tools/testing/selftests/mm/hugepage-vmemmap.c |  2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |  2 +-
 .../selftests/mm/hugetlb-soft-offline.c       |  2 +-
 tools/testing/selftests/mm/ksm_tests.c        | 17 ++++++-------
 tools/testing/selftests/mm/madv_populate.c    |  2 +-
 tools/testing/selftests/mm/map_populate.c     |  2 +-
 tools/testing/selftests/mm/memfd_secret.c     |  2 +-
 .../testing/selftests/mm/mlock-random-test.c  |  2 +-
 tools/testing/selftests/mm/mlock2-tests.c     |  2 +-
 tools/testing/selftests/mm/mseal_test.c       |  8 ++++--
 tools/testing/selftests/mm/on-fault-limit.c   |  2 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  3 ---
 .../selftests/mm/pkey_sighandler_tests.c      | 25 +++++++++++++++----
 tools/testing/selftests/mm/protection_keys.c  |  6 ++---
 tools/testing/selftests/mm/soft-dirty.c       |  6 ++---
 .../selftests/mm/split_huge_page_test.c       |  2 +-
 tools/testing/selftests/mm/uffd-common.c      |  4 +--
 tools/testing/selftests/mm/uffd-common.h      |  2 +-
 tools/testing/selftests/mm/uffd-stress.c      |  2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  |  8 +++---
 tools/testing/selftests/mm/uffd-wp-mremap.c   |  2 +-
 .../selftests/mm/virtual_address_range.c      |  2 +-
 29 files changed, 73 insertions(+), 55 deletions(-)

-- 
2.47.2


