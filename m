Return-Path: <linux-kselftest+bounces-28052-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263ADA4C1E6
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160B33AA264
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Mar 2025 13:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041D13BC0E;
	Mon,  3 Mar 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ITTKtL4D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A8B53365;
	Mon,  3 Mar 2025 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008626; cv=none; b=INAlfBJFFfapxVocY3KodjtLHgjepk5o1oyOjZApsQX4Dwd/1xv3GZN1jlPWG9Grd53zoQKbPhB19/r7+Xa/6jlSVivLvIDbP21Y7c4vvYDT3p3tEqpjYC0RiS8W3/iiaKu/Kg+AOHsxl+jUQ1tTr9gCfYHCwbSSpPz22/kiESU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008626; c=relaxed/simple;
	bh=MyaeKqfVcMrkKZ9YXltjW2dOr6aOi7EKVIuukUVWLRg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JtsfifJpDh51QTkYxcHff2I6vVrnZ8hEuLXMCjes86IhYFZbUOFF62VM9Tcr3Mx0P3sd8hmrwen/jjwL6g47QOr5xt9thjahf8DBO//e80WHzl35zVrzOsWWskp0gjPoEhJwVohy9YpFbFddy1dtB6JYxXZlgWTsnDe0fe1/jE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ITTKtL4D; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741008624; x=1772544624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2L3Lyb/8WcMt5Xzo+0pszQ2qfPvOzityflFvXPF/tvA=;
  b=ITTKtL4DflFJzaMt/1iqJ6tvidMkgcLJb5gCKMhVftiv/eUt1Zy2Ay+s
   N4q4qv5FU/c4Gc9IpGoyP6hs3bSD3scCWYiQ/q8DPVhIcW3lBk+bfvirg
   8bU95t7Ejp4D9TsVtyMLnLsXRhDXwcOcrWLjCyGSbUzSNJrYJMk/WTgff
   4=;
X-IronPort-AV: E=Sophos;i="6.13,329,1732579200"; 
   d="scan'208";a="498891611"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 13:30:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:4349]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.36:2525] with esmtp (Farcaster)
 id 30b52795-a314-42f7-b716-d33823c57578; Mon, 3 Mar 2025 13:30:18 +0000 (UTC)
X-Farcaster-Flow-ID: 30b52795-a314-42f7-b716-d33823c57578
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:15 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 3 Mar 2025 13:30:15 +0000
Received: from email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14 via Frontend Transport; Mon, 3 Mar 2025 13:30:15 +0000
Received: from dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com (dev-dsk-kalyazin-1a-a12e27e2.eu-west-1.amazon.com [172.19.103.116])
	by email-imr-corp-prod-pdx-all-2c-8a67eb17.us-west-2.amazon.com (Postfix) with ESMTPS id 014DD40434;
	Mon,  3 Mar 2025 13:30:12 +0000 (UTC)
From: Nikita Kalyazin <kalyazin@amazon.com>
To: <akpm@linux-foundation.org>, <pbonzini@redhat.com>, <shuah@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
	<lorenzo.stoakes@oracle.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<quic_eberman@quicinc.com>, <jthoughton@google.com>, <peterx@redhat.com>,
	<graf@amazon.de>, <jgowans@amazon.com>, <roypat@amazon.co.uk>,
	<derekmn@amazon.com>, <nsaenz@amazon.es>, <xmarcalx@amazon.com>,
	<kalyazin@amazon.com>
Subject: [RFC PATCH 0/5] KVM: guest_memfd: support for uffd missing
Date: Mon, 3 Mar 2025 13:30:06 +0000
Message-ID: <20250303133011.44095-1-kalyazin@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

This series is built on top of the v3 write syscall support [1].

With James's KVM userfault [2], it is possible to handle stage-2 faults
in guest_memfd in userspace.  However, KVM itself also triggers faults
in guest_memfd in some cases, for example: PV interfaces like kvmclock,
PV EOI and page table walking code when fetching the MMIO instruction on
x86.  It was agreed in the guest_memfd upstream call on 23 Jan 2025 [3]
that KVM would be accessing those pages via userspace page tables.  In
order for such faults to be handled in userspace, guest_memfd needs to
support userfaultfd.

This series proposes a limited support for userfaultfd in guest_memfd:
 - userfaultfd support is conditional to `CONFIG_KVM_GMEM_SHARED_MEM`
   (as is fault support in general)
 - Only `page missing` event is currently supported
 - Userspace is supposed to respond to the event with the `write`
   syscall followed by `UFFDIO_CONTINUE` ioctl to unblock the faulting
   process.   Note that we can't use `UFFDIO_COPY` here because
   userfaulfd code does not know how to prepare guest_memfd pages, eg
   remove them from direct map [4].

Not included in this series:
 - Proper interface for userfaultfd to recognise guest_memfd mappings
 - Proper handling of truncation cases after locking the page

Request for comments:
 - Is it a sensible workflow for guest_memfd to resolve a userfault
   `page missing` event with `write` syscall + `UFFDIO_CONTINUE`?  One
   of the alternatives is teaching `UFFDIO_COPY` how to deal with
   guest_memfd pages.
 - What is a way forward to make userfaultfd code aware of guest_memfd?
   I saw that Patrick hit a somewhat similar problem in [5] when trying
   to use direct map manipulation functions in KVM and was pointed by
   David at Elliot's guestmem library [6] that might include a shim for that.
   Would the library be the right place to expose required interfaces like
   `vma_is_gmem`?

Nikita

[1] https://lore.kernel.org/kvm/20250303130838.28812-1-kalyazin@amazon.com/T/
[2] https://lore.kernel.org/kvm/20250109204929.1106563-1-jthoughton@google.com/T/
[3] https://docs.google.com/document/d/1M6766BzdY1Lhk7LiR5IqVR8B8mG3cr-cxTxOrAosPOk/edit?tab=t.0#heading=h.w1126rgli5e3
[4] https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/
[4] https://lore.kernel.org/kvm/20250221160728.1584559-1-roypat@amazon.co.uk/T/#ma130b29c130dbdc894aa08d8d56c16ec383f36dd
[5] https://lore.kernel.org/kvm/20241122-guestmem-library-v5-2-450e92951a15@quicinc.com/T/

Nikita Kalyazin (5):
  KVM: guest_memfd: add kvm_gmem_vma_is_gmem
  KVM: guest_memfd: add support for uffd missing
  mm: userfaultfd: allow to register userfaultfd for guest_memfd
  mm: userfaultfd: support continue for guest_memfd
  KVM: selftests: add uffd missing test for guest_memfd

 include/linux/userfaultfd_k.h                 |  9 ++
 mm/userfaultfd.c                              | 23 ++++-
 .../testing/selftests/kvm/guest_memfd_test.c  | 88 +++++++++++++++++++
 virt/kvm/guest_memfd.c                        | 17 +++-
 virt/kvm/kvm_mm.h                             |  1 +
 5 files changed, 136 insertions(+), 2 deletions(-)


base-commit: 592e7531753dc4b711f96cd1daf808fd493d3223
-- 
2.47.1


