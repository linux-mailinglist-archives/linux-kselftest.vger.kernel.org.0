Return-Path: <linux-kselftest+bounces-21767-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 297BC9C3BD8
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB8B9282447
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604BB17BB2E;
	Mon, 11 Nov 2024 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NJlFjfEw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F8E14600D;
	Mon, 11 Nov 2024 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320887; cv=none; b=HoW0cWiHkpmKDlgpynax1DmAYa1XZEoKMpUCX6CuoD9iBc/yQ1B1ruGiUOiEunB47yVAEN6IaDQWcch/lnYhY8U3iwkwnbWJZjN6dnfjXt/95wUENkFrCcWEGViztP2qmBx19B7PYTai11/h+HFfLOpL+5KTZ1oa5HKkQLPWPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320887; c=relaxed/simple;
	bh=cI9q99rlDOxAqO3bS4eVJfx48G3XhrUSNcG3XRTjaLk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Uw1bPJE6RvWcA3OlW3iywDZ4V/dRDV3kBtUBAJYUOMSfU0QbsCnDvPi9lbzvWznmeTFMIxPKjk8vHmfUbbWhFDgK2VEzpLIfnAp2qXVyw+lBiL2NUzTKebPbQgcjAaLmMzp26kek8/ieFL3WGanJol+cOPbYlHrI2nMQZvVPcbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=NJlFjfEw; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320885; x=1762856885;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PpjRqEBAyVw7Qd4OepFho+pIzvM5vUo5vshUaJauZwQ=;
  b=NJlFjfEwHxfvPwglq3171qleFbPXMuC9gbJbxiP+AdEZp2IKNRaIX0dW
   PfFH9oxYms4xIf0jIXVB3eEqQ0a1/DF7EK6FCB0PxbMzfJ/8+laXhE8cy
   HOiu1Fxzsy9vBleL+Xlo2q/PnX4EXC4bfop0mtMjziUAJne5Uvlrw68t9
   c=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="146200995"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:02 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.29.78:20452]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.63:2525] with esmtp (Farcaster)
 id 63d9a5ec-5156-4eac-8bb3-a9473dc3626f; Mon, 11 Nov 2024 10:28:02 +0000 (UTC)
X-Farcaster-Flow-ID: 63d9a5ec-5156-4eac-8bb3-a9473dc3626f
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:01 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:01 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:01 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 2E751A0227;
	Mon, 11 Nov 2024 10:28:00 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 0/6] Enhance event delivery error handling
Date: Mon, 11 Nov 2024 10:27:43 +0000
Message-ID: <20241111102749.82761-1-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the situation when guest accesses MMIO during vectoring is
handled differently on VMX and SVM: on VMX KVM returns internal error,
when SVM goes into infinite loop trying to deliver an event again and
again.

This patch series eliminates this difference by returning a KVM internal
error when guest performs MMIO during vectoring for both VMX and SVM.

Also, introduce a selftest test case which covers the error handling
mentioned above.

V1 -> V2:
- Make commit messages more brief, avoid using pronouns
- Extract SVM error handling into a separate commit
- Introduce a new X86EMUL_ return type and detect the unhandleable
vectoring error in vendor-specific check_emulate_instruction instead of
handling it in the common MMU code (which is specific for cached MMIO)

Ivan Orlov (6):
  KVM: x86: Add function for vectoring error generation
  KVM: x86: Add emulation status for vectoring during MMIO
  KVM: VMX: Handle vectoring error in check_emulate_instruction
  KVM: SVM: Handle MMIO during vectroing error
  selftests: KVM: extract lidt into helper function
  selftests: KVM: Add test case for MMIO during vectoring

 arch/x86/include/asm/kvm_host.h               | 12 ++++-
 arch/x86/kvm/kvm_emulate.h                    |  2 +
 arch/x86/kvm/svm/svm.c                        |  9 +++-
 arch/x86/kvm/vmx/vmx.c                        | 33 +++++-------
 arch/x86/kvm/x86.c                            | 27 ++++++++++
 .../selftests/kvm/include/x86_64/processor.h  |  7 +++
 .../selftests/kvm/set_memory_region_test.c    | 53 ++++++++++++++++++-
 .../selftests/kvm/x86_64/sev_smoke_test.c     |  2 +-
 8 files changed, 119 insertions(+), 26 deletions(-)

-- 
2.43.0


