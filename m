Return-Path: <linux-kselftest+bounces-26305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 787DFA2FF8F
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 01:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2401884442
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 00:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF631F12F6;
	Tue, 11 Feb 2025 00:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a+ObpMKM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732671F0E23
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 00:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739234501; cv=none; b=q5ShlkIY5qz6pSRg1iEf3kFqPCXt4ZKCc02QNgq3JFYHn5pI9JvyXRsV5emoZU2owXkpHxK0XUln0PQHkZ7Dt+oIQzfsZSCddlERDhLUpFZ0RgXWMjfIxdFtO5JsoUaVfe9tBYyU/ApLID/LUqmSM7ceyKuilqNsecuS82e+ADw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739234501; c=relaxed/simple;
	bh=bpieZKu7nF2fBcW+p5hY/rCkCIIcoFokdt3AqsVsiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VSEbTxXPOnt2FvFvk44ZSbMia5JPXsJ9zmVoj41hOF7r9OaTQMSWfbwPWgJFykF1ubxnRofcZuO1pjBe/SA5/53w4udMadCn/2QfMxieF1L4ICMV7EpHY+M54qgiOcMj9NjrGad2d1QGHo1Ge2kYxJn0ll2+fSrAKpmH1PgVit0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a+ObpMKM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739234498;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uW32snpxRzCVSt941LOqOUmwseLr9n4AUtM3i/agsHc=;
	b=a+ObpMKM9m+n5kCHr9rMXlyHKGcYQ2w8uM33qGCHEIRv5AS5K+om9+5BJ5iEm/Vc7Uzf0s
	bmY26NnOho4LJk0YdbqKWVcRIhv2A3zl5U9iK3pxD/RTtTUYolrpWNA5h68qIbesbxftXn
	5uKKn/y2QXz7WzJStl4NEI+bFcy2Hxc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-_e6O-04qOV2n_AD1k2LIuQ-1; Mon,
 10 Feb 2025 19:41:35 -0500
X-MC-Unique: _e6O-04qOV2n_AD1k2LIuQ-1
X-Mimecast-MFC-AGG-ID: _e6O-04qOV2n_AD1k2LIuQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5BC2180087E;
	Tue, 11 Feb 2025 00:41:29 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.88.129])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6BC8A18004A7;
	Tue, 11 Feb 2025 00:41:18 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	cl@gentwo.org,
	vbabka@suse.cz,
	mhocko@suse.com,
	apopple@nvidia.com,
	dave.hansen@linux.intel.com,
	will@kernel.org,
	baohua@kernel.org,
	jack@suse.cz,
	srivatsa@csail.mit.edu,
	haowenchao22@gmail.com,
	hughd@google.com,
	aneesh.kumar@kernel.org,
	yang@os.amperecomputing.com,
	peterx@redhat.com,
	ioworker0@gmail.com,
	wangkefeng.wang@huawei.com,
	ziy@nvidia.com,
	jglisse@google.com,
	surenb@google.com,
	vishal.moola@gmail.com,
	zokeefe@google.com,
	zhengqi.arch@bytedance.com,
	jhubbard@nvidia.com,
	21cnbao@gmail.com,
	willy@infradead.org,
	kirill.shutemov@linux.intel.com,
	david@redhat.com,
	aarcange@redhat.com,
	raquini@redhat.com,
	dev.jain@arm.com,
	sunnanyong@huawei.com,
	usamaarif642@gmail.com,
	audra@redhat.com,
	akpm@linux-foundation.org,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	tiwai@suse.de,
	baolin.wang@linux.alibaba.com,
	corbet@lwn.net,
	shuah@kernel.org
Subject: [RFC v2 0/5] mm: introduce THP deferred setting
Date: Mon, 10 Feb 2025 17:40:49 -0700
Message-ID: <20250211004054.222931-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This series is a follow-up to [1], which adds mTHP support to khugepaged.
mTHP khugepaged support was necessary for the global="defer" and
mTHP="inherit" case (and others) to make sense.

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

This allows for two things... one, applications specifically designed to
use hugepages will get them, and two, applications that don't use
hugepages can still benefit from them without aggressively inserting
THPs at every possible chance. This curbs the memory waste, and defers
the use of hugepages to khugepaged. Khugepaged can then scan the memory
for eligible collapsing.

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

V2 Changes:
- base changes on mTHP khugepaged support
- Fix selftests parsing issue
- add mTHP defer option
- add mTHP defer Documentation

[1] - https://lkml.org/lkml/2025/2/10/1982
[2] - https://gitlab.com/npache/khugepaged_mthp_test
[3] - https://people.redhat.com/npache/mthp_khugepaged_defer/testoutput2/output.html

Nico Pache (5):
  mm: defer THP insertion to khugepaged
  mm: document transparent_hugepage=defer usage
  selftests: mm: add defer to thp setting parser
  khugepaged: add defer option to mTHP options
  mm: document mTHP defer setting

 Documentation/admin-guide/mm/transhuge.rst | 40 ++++++++++---
 include/linux/huge_mm.h                    | 18 +++++-
 mm/huge_memory.c                           | 69 +++++++++++++++++++---
 mm/khugepaged.c                            | 10 ++--
 tools/testing/selftests/mm/thp_settings.c  |  1 +
 tools/testing/selftests/mm/thp_settings.h  |  1 +
 6 files changed, 115 insertions(+), 24 deletions(-)

-- 
2.48.1


