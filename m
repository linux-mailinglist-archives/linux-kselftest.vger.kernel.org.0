Return-Path: <linux-kselftest+bounces-18495-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C269888E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0401F2155B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECB01C173B;
	Fri, 27 Sep 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="laTHtPtJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825CC1339A4;
	Fri, 27 Sep 2024 16:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453829; cv=none; b=d1zXPR5hxeRZ59C1ukywyM8TGK5TV5Bht3kL7lNIQvcpoX7UojSFPBJEQD8SuXrIJDjSCE7TCq67W8IIt18EFnuzJQ1PdYcC4FF9ugBiHJVyd+MbZBN2YkC6fr88ACtmCUf6OfRUyq0OdywJiNBmQ87YoOF8Hpgai05AaY3P3F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453829; c=relaxed/simple;
	bh=yzrKctZAKwgK9erGnRdUthcZlmhUjwpRi/OBXAtr1x0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YkaCNriFPocNm2TMImA4Js/PeeO4+CWceDPs6xhZ+vjilcdRdD/pgXkQaa82FS7cS34YpgQ6M3mHhnbjHjIFTxK9FFhzA/ApsPzSWzRGrjSSQbsGqVqipWtSq4WgZ/gq/RfoIMwdDxQvpdS1QuD/CRUN67MCcMYdtRhlJK3kjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=laTHtPtJ; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727453828; x=1758989828;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2+CGiLOuqlQzvKuL984AV8PU2tD0786sslSnNXNYL0A=;
  b=laTHtPtJekwjVecAGiCGZPB4q+btlwnW4c2cW1jWsgq/S+fzigO5aOwt
   L3JIE+mmI8uAhXxNgr/2sySd356xzbV17XkfSsCcHPaLQ8KXODvypdyfP
   z/vKKyxcO6B0iHEDiyIdLuoRUsDHCu2lmETWOF+rYhiBNHAAimBUkkigc
   M=;
X-IronPort-AV: E=Sophos;i="6.11,159,1725321600"; 
   d="scan'208";a="131040232"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 16:17:05 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.43.254:23623]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.81:2525] with esmtp (Farcaster)
 id 427c4878-1590-4a4f-96c1-fd1843bc240a; Fri, 27 Sep 2024 16:17:04 +0000 (UTC)
X-Farcaster-Flow-ID: 427c4878-1590-4a4f-96c1-fd1843bc240a
Received: from EX19D033EUB001.ant.amazon.com (10.252.61.11) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:04 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D033EUB001.ant.amazon.com (10.252.61.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:03 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 27 Sep 2024 16:17:03 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id 39B074040A;
	Fri, 27 Sep 2024 16:17:02 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <jalliste@amazon.com>, <nh-open-source@amazon.com>,
	<pdurrant@amazon.co.uk>
Subject: [PATCH 0/3] Handle MMIO during event delivery error on SVM
Date: Fri, 27 Sep 2024 16:16:54 +0000
Message-ID: <20240927161657.68110-1-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the situation when guest accesses MMIO during event delivery
is handled differently in VMX and SVM: on VMX KVM returns internal error
with suberror = KVM_INTERNAL_ERROR_DELIVERY_EV, when SVM simply goes
into infinite loop trying to deliver an event again and again.

This patch series eliminates this difference by returning a KVM internal
error with suberror = KVM_INTERNAL_ERROR_DELIVERY_EV when guest is
performing MMIO during event delivery, for both VMX and SVM.

Also, it introduces a selftest test case which covers the MMIO during
event delivery error handling.

Ivan Orlov (3):
  KVM: x86, vmx: Add function for event delivery error generation
  KVM: vmx, svm, mmu: Process MMIO during event delivery
  selftests: KVM: Add test case for MMIO during event delivery

 arch/x86/include/asm/kvm_host.h               |  8 ++++
 arch/x86/kvm/mmu/mmu.c                        | 15 +++++-
 arch/x86/kvm/svm/svm.c                        |  4 ++
 arch/x86/kvm/vmx/vmx.c                        | 32 ++++---------
 arch/x86/kvm/x86.c                            | 22 +++++++++
 .../selftests/kvm/set_memory_region_test.c    | 46 +++++++++++++++++++
 6 files changed, 104 insertions(+), 23 deletions(-)

-- 
2.43.0


