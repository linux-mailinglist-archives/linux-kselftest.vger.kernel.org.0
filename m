Return-Path: <linux-kselftest+bounces-30795-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C34A9A88F04
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 00:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D14E73B1E2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 22:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D321F4295;
	Mon, 14 Apr 2025 22:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHNtrNJo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CE1F12FF
	for <linux-kselftest@vger.kernel.org>; Mon, 14 Apr 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669538; cv=none; b=cGJcPWR2FNnstEOZMvurKDFiZQVvdr+tud+rQggHocnPGBis4bAGLGTx7ys5K6/mmFIO6foiy522Shq67DSUBpjZR59tLks1AbmBTqclJko7BSk0s8Tv3XHtL5Z5vlfxjALtwYS8lXyjl2uLhbryUbffLzakptPer7C80L/xMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669538; c=relaxed/simple;
	bh=yJh360MlnBAEJy/QLsiSOsRpkj+tmEeTtyeIyewln0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FyD7JKsAAzD4mNOlfOc8FDLqblui3xPS2INLQGy3HJULcXdYor9MP+wwDNO6oYuR4bbQ/G+LuSM4hVvWlIrEqUBQ8T/3GrHcT1M90OxlqU9Kd0qQ2wTNZC9JfPbFn5tyA9zDX0zeeeAcOjb+wWIi+lq5rxCw0qbK/P0EFY0Y274=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHNtrNJo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744669535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Wasdk2OzhDHLNgttFk1rmIb7qXMNrsMULtRHlj6BUo4=;
	b=ZHNtrNJoBr6/6Z6IYKQymF6neO0mL8OywUygM/GKtc1vBxUUjDVXVKcCfHSAUcUytP/8C7
	CldSk/m//UoXCwICJXCmiVfhSigcfVjC6mlnzZT9ZDJoUylH8yywX1RjIW9uWarBDkH+54
	0gPKclxStHSjqDAUHqFw4WnSBS9fM1Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-nNWww7m0NbSHMf6qDuTOAw-1; Mon,
 14 Apr 2025 18:25:29 -0400
X-MC-Unique: nNWww7m0NbSHMf6qDuTOAw-1
X-Mimecast-MFC-AGG-ID: nNWww7m0NbSHMf6qDuTOAw_1744669525
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CDC61800349;
	Mon, 14 Apr 2025 22:25:24 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.64.91])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C771F180B487;
	Mon, 14 Apr 2025 22:25:13 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	shuah@kernel.org,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	ioworker0@gmail.com,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	dev.jain@arm.com,
	mhocko@suse.com,
	rientjes@google.com,
	hannes@cmpxchg.org,
	zokeefe@google.com,
	surenb@google.com,
	jglisse@google.com,
	cl@gentwo.org,
	jack@suse.cz,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	tiwai@suse.de,
	catalin.marinas@arm.com,
	anshuman.khandual@arm.com,
	raquini@redhat.com,
	aarcange@redhat.com,
	kirill.shutemov@linux.intel.com,
	yang@os.amperecomputing.com,
	thomas.hellstrom@linux.intel.com,
	vishal.moola@gmail.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v3 0/4] mm: introduce THP deferred setting
Date: Mon, 14 Apr 2025 16:24:52 -0600
Message-ID: <20250414222456.43212-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series is a follow-up to [1], which adds mTHP support to khugepaged.
mTHP khugepaged support is a "loose" dependency for the sysfs/sysctl
configs to make sense. Without it global="defer" and  mTHP="inherit" case
is "undefined" behavior.

We've seen cases were customers switching from RHEL7 to RHEL8 see a
significant increase in the memory footprint for the same workloads.

Through our investigations we found that a large contributing factor to
the increase in RSS was an increase in THP usage.

For workloads like MySQL, or when using allocators like jemalloc, it is
often recommended to set /transparent_hugepages/enabled=never. This is
in part due to performance degradations and increased memory waste.

This series introduces enabled=defer, this setting acts as a middle
ground between always and madvise. If the mapping is MADV_HUGEPAGE, the
page fault handler will act normally, making a hugepage if possible. If
the allocation is not MADV_HUGEPAGE, then the page fault handler will
default to the base size allocation. The caveat is that khugepaged can
still operate on pages thats not MADV_HUGEPAGE.

This allows for three things... one, applications specifically designed to
use hugepages will get them, and two, applications that don't use
hugepages can still benefit from them without aggressively inserting
THPs at every possible chance. This curbs the memory waste, and defers
the use of hugepages to khugepaged. Khugepaged can then scan the memory
for eligible collapsing. Lastly there is the added benefit for those who want
THPs but experience higher latency PFs. Now you can get base page performance at
the PF handler and Hugepage performance for those mappings after they collapse.

Admins may want to lower max_ptes_none, if not, khugepaged may
aggressively collapse single allocations into hugepages.

TESTING:
- Built for x86_64, aarch64, ppc64le, and s390x
- selftests mm
- In [1] I provided a script [2] that has multiple access patterns
- lots of general use. These changes have been running in my VM for some time
- redis testing. This test was my original case for the defer mode. What I was
   able to prove was that THP=always leads to increased max_latency cases; hence
   why it is recommended to disable THPs for redis servers. However with 'defer'
   we dont have the max_latency spikes and can still get the system to utilize
   THPs. I further tested this with the mTHP defer setting and found that redis
   (and probably other jmalloc users) can utilize THPs via defer (+mTHP defer)
   without a large latency penalty and some potential gains.
   I uploaded some mmtest results here [3] which compares:
       stock+thp=never
       stock+(m)thp=always
       khugepaged-mthp + defer (max_ptes_none=64)

  The results show that (m)THPs can cause some throughput regression in some
  cases, but also has gains in other cases. The mTHP+defer results have more
  gains and less losses over the (m)THP=always case.

V3 Changes:
- moved some Documentation to the other series and merged the remaining
   Documentation updates into one

V2 Changes:
- base changes on mTHP khugepaged support
- Fix selftests parsing issue
- add mTHP defer option
- add mTHP defer Documentation

[1] - https://lore.kernel.org/lkml/20250414220557.35388-1-npache@redhat.com/
[2] - https://gitlab.com/npache/khugepaged_mthp_test
[3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html

Nico Pache (4):
  mm: defer THP insertion to khugepaged
  mm: document (m)THP defer usage
  khugepaged: add defer option to mTHP options
  selftests: mm: add defer to thp setting parser

 Documentation/admin-guide/mm/transhuge.rst | 31 +++++++---
 include/linux/huge_mm.h                    | 18 +++++-
 mm/huge_memory.c                           | 69 +++++++++++++++++++---
 mm/khugepaged.c                            | 10 ++--
 tools/testing/selftests/mm/thp_settings.c  |  1 +
 tools/testing/selftests/mm/thp_settings.h  |  1 +
 6 files changed, 107 insertions(+), 23 deletions(-)

-- 
2.48.1


