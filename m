Return-Path: <linux-kselftest+bounces-30018-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF7DA792AE
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 18:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5295E1896B51
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Apr 2025 16:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4312217E01B;
	Wed,  2 Apr 2025 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X2ON5Hw2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9206C1426C;
	Wed,  2 Apr 2025 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610057; cv=none; b=kZ55g6rF/k/SOer6YD+zDapZeiR/R3Crvno/2GdkDrz5CtmxS8MS7lJeY3iOptkf3+eaL4q3lgEAKb2wWqcmt8jaBkmT+3uyhPd/Bnk3lQrp2EkXuFeVy2giPxqWw9XYSrhbbII4PPvr+M5veT6sr62X2WmjOB2o+OyFt71pGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610057; c=relaxed/simple;
	bh=wQ6M/vT6iqrzoIUJHG42s5kf2HGU5FrKdDgxFDHWSTg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d0DelTsMy9VzUAbN5X6DY1V0HO+Q4W7P1k28jT7LSQUTMEn4nmZB9zhXcvsbUXU9GSsIDL4DTRishEx6umHSoBGXH6EHZwxUfzk8u1cgXZBBdwwz6PsOydkSvXWTyV9Y886mbKjnI+m4txDldwNHTHD8A0uv+fBzYDFuWIR/2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X2ON5Hw2; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743610055; x=1775146055;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ykJjfCmlolWCrZ+wMpqsGGROl+iLthzyksVnMeJ/bsI=;
  b=X2ON5Hw2Bt4jz7VsYp7HU1QsvP7dSJ5/q90O8EgxqDrQIE92kvt5uj72
   E+KyMsi45ZdrKctXGNAm7nF26bp/jl48msmcigZ6NU3431yScLU9F2Nim
   3JqXSjxQZDBVTeFEiFYuqL0ikp1eGsNGBGdRsgejZD6T3Tz6nARI3umM0
   A=;
X-IronPort-AV: E=Sophos;i="6.15,182,1739836800"; 
   d="scan'208";a="187481073"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 16:07:31 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:35474]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.18.64:2525] with esmtp (Farcaster)
 id c135015f-45aa-440b-8b20-346c1d1d6670; Wed, 2 Apr 2025 16:07:24 +0000 (UTC)
X-Farcaster-Flow-ID: c135015f-45aa-440b-8b20-346c1d1d6670
Received: from EX19D014EUC003.ant.amazon.com (10.252.51.184) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:24 +0000
Received: from EX19MTAUEA001.ant.amazon.com (10.252.134.203) by
 EX19D014EUC003.ant.amazon.com (10.252.51.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 2 Apr 2025 16:07:23 +0000
Received: from email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.102) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Wed, 2 Apr 2025 16:07:23 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-iad-all-1a-6ea42a62.us-east-1.amazon.com (Postfix) with ESMTPS id 2C31B431A3;
	Wed,  2 Apr 2025 16:07:22 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [PATCH v2 0/5] KVM: guest_memfd: support for uffd minor
Date: Wed, 2 Apr 2025 16:07:16 +0000
Message-ID: <20250402160721.97596-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

This series is built on top of Fuad's v7 "mapping guest_memfd backed
memory at the host" [1].

With James's KVM userfault [2], it is possible to handle stage-2 faults
in guest_memfd in userspace.  However, KVM itself also triggers faults
in guest_memfd in some cases, for example: PV interfaces like kvmclock,
PV EOI and page table walking code when fetching the MMIO instruction on
x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
that KVM would be accessing those pages via userspace page tables.  In
order for such faults to be handled in userspace, guest_memfd needs to
support userfaultfd.

Changes since v1 [4]:
 - James, Peter: implement a full minor trap instead of a hybrid
   missing/minor trap
 - James, Peter: to avoid shmem- and guest_memfd-specific code in the
   UFFDIO_CONTINUE implementation make it generic by calling
vm_ops->fault()

While generalising UFFDIO_CONTINUE implementation helped avoid
guest_memfd-specific code in mm/userfaulfd, userfaultfd still needs
access to KVM code to be able to verify the VMA type when handling
UFFDIO_REGISTER_MODE_MINOR, so I used a similar approach to what Fuad
did for now [5].

In v1, Peter was mentioning a potential for eliminating taking a folio
lock [6].  I did not implement that, but according to my testing, the
performance of shmem minor fault handling stayed the same after the
migration to calling vm_ops->fault() (tested on an x86).

Before:

./demand_paging_test -u MINOR -s shmem
Random seed: 0x6b8b4567
Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
guest physical test memory: [0x3fffbffff000, 0x3ffffffff000)
Finished creating vCPUs and starting uffd threads
Started all vCPUs
All vCPU threads joined
Total guest execution time:	10.979277020s
Per-vcpu demand paging rate:	23876.253375 pgs/sec/vcpu
Overall demand paging rate:	23876.253375 pgs/sec

After:

./demand_paging_test -u MINOR -s shmem
Random seed: 0x6b8b4567
Testing guest mode: PA-bits:ANY, VA-bits:48,  4K pages
guest physical test memory: [0x3fffbffff000, 0x3ffffffff000)
Finished creating vCPUs and starting uffd threads
Started all vCPUs
All vCPU threads joined
Total guest execution time:	10.978893504s
Per-vcpu demand paging rate:	23877.087423 pgs/sec/vcpu
Overall demand paging rate:	23877.087423 pgs/sec

Nikita

[1] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/
[2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
[3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
[4] https://lore.kernel.org/kvm/20250303133011.44095-1-kalyazin@amazon.com/T/
[5] https://lore.kernel.org/kvm/20250318161823.4005529-1-tabba@google.com/T/#Z2e.:..:20250318161823.4005529-3-tabba::40google.com:1mm:swap.c
[6] https://lore.kernel.org/kvm/20250303133011.44095-1-kalyazin@amazon.com/T/#m8695dc24d2cc633a6a486a8990e3f7d50d4efb79

Nikita Kalyazin (5):
  mm: userfaultfd: generic continue for non hugetlbfs
  KVM: guest_memfd: add kvm_gmem_vma_is_gmem
  mm: userfaultfd: allow to register continue for guest_memfd
  KVM: guest_memfd: add support for userfaultfd minor
  KVM: selftests: test userfaultfd minor for guest_memfd

 include/linux/mm_types.h                      |  3 +
 include/linux/userfaultfd_k.h                 | 13 ++-
 mm/hugetlb.c                                  |  2 +-
 mm/shmem.c                                    |  3 +-
 mm/userfaultfd.c                              | 25 +++--
 .../testing/selftests/kvm/guest_memfd_test.c  | 94 +++++++++++++++++++
 virt/kvm/guest_memfd.c                        | 15 +++
 virt/kvm/kvm_mm.h                             |  1 +
 8 files changed, 146 insertions(+), 10 deletions(-)


base-commit: 3cc51efc17a2c41a480eed36b31c1773936717e0
-- 
2.47.1


