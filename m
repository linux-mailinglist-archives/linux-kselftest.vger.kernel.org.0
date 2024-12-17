Return-Path: <linux-kselftest+bounces-23460-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7CC9F55D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99D5A188A3E9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7031F9ABF;
	Tue, 17 Dec 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OOC0KBc3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8E1F9402;
	Tue, 17 Dec 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459325; cv=none; b=eHITNAmAw6mKbGPB0f6tlQWAnUmT6nVAgCuR1hl+a5jzvt9LHKngSjeaQk04sdn3FsRZyQXksJOZHc4p4+tV37e5L2rKtWdJ5/eKm5w3S8QD0k6ta90HO16pRa9wvzHqp7VqSwbIdywM12TA9tCKtKMLf3u1LpZKysXY34rPU7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459325; c=relaxed/simple;
	bh=ITkuq+6POg0AanjQB8FVEij5/J3aYF1KyLOXLajovkY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPXNwlX91mq0qL1HVQz5rzYBvnDT067HaCVY8+2+TrJHiVrr62BHUv6k0fGeo3itN6/Hra3tj129bSS6HrivN/DC3V1BFN3+xcZe3sgotnIvSf0yih/4qJq+paWKmVaLYndVXCVHt+RnGZ0IXmAf9Tg8fZ+k/KNdDHtlp77YNzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OOC0KBc3; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459324; x=1765995324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C7BDBrHqmM0HTnPyPCcOuOLMIShtH1iqrRhw5e72kCQ=;
  b=OOC0KBc34LZnDX77Gk58KMIycrZzVIQ10U2joTNursR15wZ7CFPiBRy6
   enZg2aCFE6yy1vmsFGE5VqV2ZzzB1CqnGtKp8z4TPFJMJvjU04bOvRDVC
   RwnV0nZKWj1luKg7ToT61XykCRRtdeuZ1dLl4pj4wGU/7wX1dUaGdnUYb
   8=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="451553361"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:19 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:55090]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.89.141:2525] with esmtp (Farcaster)
 id 9c68495e-a5b7-44a8-a2d2-f592d5e3a294; Tue, 17 Dec 2024 18:15:07 +0000 (UTC)
X-Farcaster-Flow-ID: 9c68495e-a5b7-44a8-a2d2-f592d5e3a294
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:06 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:06 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:05 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id B731CA07D5;
	Tue, 17 Dec 2024 18:15:03 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 0/7] Enhance event delivery error handling
Date: Tue, 17 Dec 2024 18:14:51 +0000
Message-ID: <20241217181458.68690-1-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the unhandleable vectoring (e.g. when guest accesses MMIO
during vectoring) is handled differently on VMX and SVM: on VMX KVM
returns internal error, when SVM goes into infinite loop trying to
deliver an event again and again.

This patch series eliminates this difference by returning a KVM internal
error when KVM can't emulate during vectoring for both VMX and SVM.

Also, introduce a selftest test case which covers the error handling
mentioned above.

V1 -> V2:
- Make commit messages more brief, avoid using pronouns
- Extract SVM error handling into a separate commit
- Introduce a new X86EMUL_ return type and detect the unhandleable
vectoring error in vendor-specific check_emulate_instruction instead of
handling it in the common MMU code (which is specific for cached MMIO)

V2 -> V3:
- Make the new X86EMUL_ code more generic
- Prohibit any emulation during vectoring if it is due to an intercepted
#PF
- Add a new patch for checking whether unprotect & retry is possible
before exiting to userspace due to unhandleable vectoring
- Codestyle fixes


Ivan Orlov (7):
  KVM: x86: Add function for vectoring error generation
  KVM: x86: Add emulation status for unhandleable vectoring
  KVM: x86: Unprotect & retry before unhandleable vectoring check
  KVM: VMX: Handle vectoring error in check_emulate_instruction
  KVM: SVM: Handle vectoring error in check_emulate_instruction
  selftests: KVM: extract lidt into helper function
  selftests: KVM: Add test case for MMIO during vectoring

 arch/x86/include/asm/kvm_host.h               | 11 +++-
 arch/x86/kvm/kvm_emulate.h                    |  2 +
 arch/x86/kvm/svm/svm.c                        |  6 +++
 arch/x86/kvm/vmx/vmx.c                        | 30 ++++-------
 arch/x86/kvm/x86.c                            | 31 +++++++++++
 .../selftests/kvm/include/x86_64/processor.h  |  7 +++
 .../selftests/kvm/set_memory_region_test.c    | 53 ++++++++++++++++++-
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  2 +-
 8 files changed, 117 insertions(+), 25 deletions(-)

-- 
2.43.0


