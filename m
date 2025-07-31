Return-Path: <linux-kselftest+bounces-38103-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018C7B1749C
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 18:04:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BE05865F0
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 16:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0124428E571;
	Thu, 31 Jul 2025 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="kBCYLhCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD0028F935;
	Thu, 31 Jul 2025 16:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753977790; cv=pass; b=efBW+PcqKzDLh5+padF2lpbfzFj7SIr3P1rWJqvmlo85+apmy699z89hdUjKIJPXxpJ8b7cuUxQqQVkj5/F1PK79AYQPi4LCYUHJ3OfqlM29kYV+Mtw3TWA8JmnQpT0/Rzu9krMUaP6cxQVmsn6Da1LAm/HSm4ME9kIKyRweUXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753977790; c=relaxed/simple;
	bh=i32z2NRnLSaZ/lvF/rh8sje1Am2/5H+BvIxFbffC4pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=evoHXGOfkQOJpBLfVIoBJbo3nqG+4NQh1uvznKCAyyOPWOmn6Td1/YRpMLAUTSu2/V881sYuDOoQe7Rv9dAm+ybhAFeLxUe4LJq5RbQ6ii7N29PgfNc0O1eY+v/wTIk67z61+bOqkGubb/tIG37DvtH5LpGeuYxcGOWl1y+OvWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=kBCYLhCZ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753977731; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZEWeWRS9NSRtAoYJxrk6zRnSS7qa1OVpBdM2SJ3xXuAG6R+eXaSMCIA8RNptxud6zJNpzEJC5teZqBpSmHzg8QBojAmMCg/fxqV2N8FDI/+fAZy01OKFsin5Ai4uGkvKTtO8U9wrHCbcJg1hK6DcO0uC06o2t0tEApFWiaylDDU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753977731; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=meNELh8LR1NAeAvdziO/ZgYgHuiniypSBrawhPsx+G4=; 
	b=jHVH1kgjVLXRvCR1F5I0VoPOPqohdomaXMIZAhRmwEtfMjpLxBCNC/mepNDk3dJdLvqCyO29aEzfE010htlexxv9SyI4l+/nXqZq6pZa5UuBftOcXTj8quN2lBKIuAJWbOOAyFPRWtHm0iydZq7ygxyLuea7862o7QbiHn3R7UM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753977731;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=meNELh8LR1NAeAvdziO/ZgYgHuiniypSBrawhPsx+G4=;
	b=kBCYLhCZOgzVeWLofV1x57vA+k/CUZJZToOl5buYcqBdy2YTFJGa6G+bdE2wyS7g
	LN6BRD4KO/J+zQ/2kjx2Qz6vDoj0JQIIzGh+lG55+SYCNMDIx1VlY8YgwgWJbVtyDT2
	uj+RMFayNJ6gciYtQVYIp+1rscQQVv2cQUoqxLe4=
Received: by mx.zohomail.com with SMTPS id 1753977728569555.2914754706031;
	Thu, 31 Jul 2025 09:02:08 -0700 (PDT)
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Andrew Morton <akpm@linux-foundation.org>,
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
	Shuah Khan <shuah@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
	kernel@collabora.com
Subject: [PATCH v2 0/8] selftests/mm: Add compiler flags and fix found warnings
Date: Thu, 31 Jul 2025 21:01:24 +0500
Message-Id: <20250731160132.1795351-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

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

The changes have been build tested on x86_64, arm64, powerpc64 and partially
on riscv64. The test run with and without this series has been done on
x86_64.

---
Changes since v1:
- Drop test harness patch which isn't needed anymore
- Revamp how patches are written per same kind of failure

Muhammad Usama Anjum (8):
  selftests/mm: Add -Wunreachable-code and fix warnings
  selftests/mm: protection_keys: Fix dead code
  selftests: kselftest.h: Add __unused macro
  selftests/mm: Add -Wunused family of flags
  selftests/mm: Remove unused parameters
  selftests/mm: Mark unused arguments with __unused
  selftests/mm: Mark unused arguments with __unused
  selftests/mm: Fix unused parameter warnings for different
    architectures

 tools/testing/selftests/kselftest.h           |  4 ++
 tools/testing/selftests/mm/Makefile           |  3 +-
 tools/testing/selftests/mm/compaction_test.c  |  2 +-
 tools/testing/selftests/mm/cow.c              | 22 +++++------
 tools/testing/selftests/mm/droppable.c        |  2 +-
 tools/testing/selftests/mm/gup_longterm.c     |  2 +-
 tools/testing/selftests/mm/hmm-tests.c        |  5 +--
 tools/testing/selftests/mm/hugepage-vmemmap.c |  2 +-
 tools/testing/selftests/mm/hugetlb-madvise.c  |  2 +-
 .../selftests/mm/hugetlb-soft-offline.c       |  2 +-
 .../selftests/mm/hugetlb_fault_after_madv.c   |  4 +-
 .../selftests/mm/hugetlb_madv_vs_map.c        |  6 +--
 tools/testing/selftests/mm/ksm_tests.c        | 17 ++++-----
 tools/testing/selftests/mm/madv_populate.c    |  2 +-
 tools/testing/selftests/mm/map_populate.c     |  2 +-
 tools/testing/selftests/mm/memfd_secret.c     |  6 +--
 .../testing/selftests/mm/mlock-random-test.c  |  2 +-
 tools/testing/selftests/mm/mlock2-tests.c     |  2 +-
 tools/testing/selftests/mm/mseal_test.c       |  8 +++-
 tools/testing/selftests/mm/on-fault-limit.c   |  2 +-
 tools/testing/selftests/mm/pfnmap.c           |  2 +-
 tools/testing/selftests/mm/pkey-arm64.h       |  5 ++-
 tools/testing/selftests/mm/pkey-powerpc.h     |  2 +-
 tools/testing/selftests/mm/pkey-x86.h         |  3 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 35 ++++++++++++-----
 tools/testing/selftests/mm/protection_keys.c  | 22 +++++------
 tools/testing/selftests/mm/soft-dirty.c       |  6 +--
 .../selftests/mm/split_huge_page_test.c       |  8 ++--
 tools/testing/selftests/mm/uffd-common.c      | 15 ++++----
 tools/testing/selftests/mm/uffd-common.h      |  2 +-
 tools/testing/selftests/mm/uffd-stress.c      |  2 +-
 tools/testing/selftests/mm/uffd-unit-tests.c  | 38 +++++++++----------
 tools/testing/selftests/mm/uffd-wp-mremap.c   |  2 +-
 .../selftests/mm/virtual_address_range.c      |  2 +-
 34 files changed, 130 insertions(+), 111 deletions(-)

-- 
2.39.5


