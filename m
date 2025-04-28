Return-Path: <linux-kselftest+bounces-31804-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E6A9F89D
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B69B466208
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540B629293A;
	Mon, 28 Apr 2025 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IHQuDnbd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847A5253F3A
	for <linux-kselftest@vger.kernel.org>; Mon, 28 Apr 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864972; cv=none; b=ao6I7KEOlAMge8kmgPFxOJtD1c7l1bwW7FSDbVPoPCY1L5foyjc5KzAiDtoAukHfdjMJg3UdDYpU71PkZcwyleh7UX2GUWcO3SlyXo989gCByVdxjsrkxlbqS0oHgfundPwcTcca5Xxc6gCll2mzj7YVlpWbzrZHu9+GkjQZXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864972; c=relaxed/simple;
	bh=p13D1eVIQwiWavUWJs1JcoUqzsrV/zu2I5OyDrzN+DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U8iD7Rp+WKoSP50QevUG6ETMbqkCUpn/94AV0QJ/f7cGUZ02TSOl2E7ng9/ODM3SaXKGG2IJrxS0t9ejSHRuBm7qfbW2OSXB0OG8FlhIsFNDyCPlZ7CipMTuheXnn+WFN7AFlszuGaGcvM5DpGGBZfkT3PSp/TyzWxLllHRiWDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IHQuDnbd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745864969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vn6qN5R0W1vyV94Pxo62dc7PUSUH9kpksvjrmkO531Q=;
	b=IHQuDnbdlL8pNreXcZ7emE1ag5jl5g9OoYJGiNSj6mm0gokQjuXIRzlXm/Nak9ry4V58+C
	j3syju8pAkceWs26W8GzKlnc6qYvNIwPxfh1vlhOeGev2cyAfB+uGCAXDGnYhMzsR5LlNN
	GnCso1AJ0EhR/fglu28GJ0uENcBkV2I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-gKDvzwrDOpeQZ_TyPCDpuQ-1; Mon,
 28 Apr 2025 14:29:25 -0400
X-MC-Unique: gKDvzwrDOpeQZ_TyPCDpuQ-1
X-Mimecast-MFC-AGG-ID: gKDvzwrDOpeQZ_TyPCDpuQ_1745864961
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 708BE180036E;
	Mon, 28 Apr 2025 18:29:20 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.65.12])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D2B9830001A2;
	Mon, 28 Apr 2025 18:29:10 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	corbet@lwn.net,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	david@redhat.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	ryan.roberts@arm.com,
	willy@infradead.org,
	peterx@redhat.com,
	shuah@kernel.org,
	ziy@nvidia.com,
	wangkefeng.wang@huawei.com,
	usamaarif642@gmail.com,
	sunnanyong@huawei.com,
	vishal.moola@gmail.com,
	thomas.hellstrom@linux.intel.com,
	yang@os.amperecomputing.com,
	kirill.shutemov@linux.intel.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	tiwai@suse.de,
	will@kernel.org,
	dave.hansen@linux.intel.com,
	jack@suse.cz,
	cl@gentwo.org,
	jglisse@google.com,
	surenb@google.com,
	zokeefe@google.com,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	hannes@cmpxchg.org,
	rientjes@google.com,
	mhocko@suse.com,
	rdunlap@infradead.org
Subject: [PATCH v5 0/4] mm: introduce THP deferred setting
Date: Mon, 28 Apr 2025 12:29:00 -0600
Message-ID: <20250428182904.93989-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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
still operate on pages that are not MADV_HUGEPAGE.

This allows for three things... one, applications specifically designed to
use hugepages will get them, and two, applications that don't use
hugepages can still benefit from them without aggressively inserting
THPs at every possible chance. This curbs the memory waste, and defers
the use of hugepages to khugepaged. Khugepaged can then scan the memory
for eligible collapsing. Lastly there is the added benefit for those who
want THPs but experience higher latency PFs. Now you can get base page
performance at the PF handler and Hugepage performance for those mappings
after they collapse.

Admins may want to lower max_ptes_none, if not, khugepaged may
aggressively collapse single allocations into hugepages.

TESTING:
- Built for x86_64, aarch64, ppc64le, and s390x
- selftests mm
- In [1] I provided a script [2] that has multiple access patterns
- lots of general use.
- redis testing. This test was my original case for the defer mode. What I
   was able to prove was that THP=always leads to increased max_latency
   cases; hence why it is recommended to disable THPs for redis servers.
   However with 'defer' we dont have the max_latency spikes and can still
   get the system to utilize THPs. I further tested this with the mTHP
   defer setting and found that redis (and probably other jmalloc users)
   can utilize THPs via defer (+mTHP defer) without a large latency
   penalty and some potential gains. I uploaded some mmtest results
   here[3] which compares:
       stock+thp=never
       stock+(m)thp=always
       khugepaged-mthp + defer (max_ptes_none=64)

  The results show that (m)THPs can cause some throughput regression in
  some cases, but also has gains in other cases. The mTHP+defer results
  have more gains and less losses over the (m)THP=always case.

V5 Changes:
- rebased dependent series
- added reviewed-by tag on 2/4

V4 Changes:
- Minor Documentation fixes
- rebased the dependent series [1] onto mm-unstable
    commit 0e68b850b1d3 ("vmalloc: use atomic_long_add_return_relaxed()")

V3 Changes:
- Combined the documentation commits into one, and moved a section to the
  khugepaged mthp patchset

V2 Changes:
- base changes on mTHP khugepaged support
- Fix selftests parsing issue
- add mTHP defer option
- add mTHP defer Documentation

[1] - https://lore.kernel.org/lkml/20250428181218.85925-1-npache@redhat.com/
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
 mm/khugepaged.c                            |  8 +--
 tools/testing/selftests/mm/thp_settings.c  |  1 +
 tools/testing/selftests/mm/thp_settings.h  |  1 +
 6 files changed, 106 insertions(+), 22 deletions(-)

-- 
2.48.1


