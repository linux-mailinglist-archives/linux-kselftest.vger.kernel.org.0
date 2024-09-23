Return-Path: <linux-kselftest+bounces-18221-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B1097ECF7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE291C21438
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEC619E982;
	Mon, 23 Sep 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="PBpNBhDQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AA19D080;
	Mon, 23 Sep 2024 14:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101113; cv=none; b=old0+CgvPB8B5DbV9b706ylAU5hHX93Vrflsn9SSj/uRbkqIvEwQ62LzrfwM9ZMgX1Q28aylGstp9KjYpaaGu0a6kw3Hyh2NhbhlB2c7i8o8mnomrpzn/UeP2fpH/Js5+SJ9VPr2flPoK7q/7aU6aDgbqicjXV3UsB/BU3LkAPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101113; c=relaxed/simple;
	bh=ReqY0L7Jtzg8i0INnc+0MTwXnMWRWujG1K+IBvmcoGk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjNJQRXIag6X2rzmXSOvGpxbQhtvkcZyXREDEbY9yRrChBiP47EsbhgupA82/IeBWvXT6d2ZMXHbG9OKnFEZSNiKJfz49/Ca/vtvwtfRJfGRjY45ruizeY6TOGb3MAR1XlPgussj1POlKYRHzM0NO1UQiTLb+hoAT6zSRcyqvS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=PBpNBhDQ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727101109; x=1758637109;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3S25fca7vLdE5XnX/SYke2OMDRQglZZJ2XXDI9ojeGg=;
  b=PBpNBhDQpKHl74N7sSvKnbtfXVG45RmA2lQ1dg/+c7kO+OO/9Pp6gXkO
   VFY2EBsN7J4z8g+lxych9pVHf12TiNBNqJpR1Ap4hFjzS4oesPEMtPBsJ
   h5lDIC+rJwn0/jQDY2eXRLKG4TfZhAZcuqh2F6VQKPgPBAJIDcEGzPAIR
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719878400"; 
   d="scan'208";a="457053117"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:18:17 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.17.79:19364]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.171:2525] with esmtp (Farcaster)
 id c53ccefd-03c2-4238-bb01-cb9f0f8978e6; Mon, 23 Sep 2024 14:18:16 +0000 (UTC)
X-Farcaster-Flow-ID: c53ccefd-03c2-4238-bb01-cb9f0f8978e6
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:15 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 23 Sep 2024 14:18:15 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 8D1B440592;
	Mon, 23 Sep 2024 14:18:13 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <hpa@zytor.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH 0/4] Process some MMIO-related errors without KVM exit
Date: Mon, 23 Sep 2024 14:18:06 +0000
Message-ID: <20240923141810.76331-1-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, KVM may return a variety of internal errors to VMM when
accessing MMIO, and some of them could be gracefully handled on the KVM
level instead. Moreover, some of the MMIO-related errors are handled
differently in VMX in comparison with SVM, which produces certain
inconsistency and should be fixed. This patch series introduces
KVM-level handling for the following situations:

1) Guest is accessing MMIO during event delivery: triple fault instead
of internal error on VMX and infinite loop on SVM

2) Guest fetches an instruction from MMIO: inject #UD and resume guest
execution without internal error

Additionaly, this patch series includes a KVM selftest which covers
different cases of MMIO misuse.

Also, update the set_memory_region_test to expect the triple fault when
starting VM with no RAM.

Ivan Orlov (4):
  KVM: vmx, svm, mmu: Fix MMIO during event delivery handling
  KVM: x86: Inject UD when fetching from MMIO
  selftests: KVM: Change expected exit code in test_zero_memory_regions
  selftests: KVM: Add new test for faulty mmio usage

 arch/x86/include/asm/kvm_host.h               |   6 +
 arch/x86/kvm/emulate.c                        |   3 +
 arch/x86/kvm/kvm_emulate.h                    |   1 +
 arch/x86/kvm/mmu/mmu.c                        |  13 +-
 arch/x86/kvm/svm/svm.c                        |   4 +
 arch/x86/kvm/vmx/vmx.c                        |  21 +-
 arch/x86/kvm/x86.c                            |   7 +-
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/set_memory_region_test.c    |   3 +-
 .../selftests/kvm/x86_64/faulty_mmio.c        | 199 ++++++++++++++++++
 10 files changed, 242 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/faulty_mmio.c

-- 
2.43.0


