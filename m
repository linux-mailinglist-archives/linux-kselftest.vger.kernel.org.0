Return-Path: <linux-kselftest+bounces-21770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF979C3BE1
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C64E1C217CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706D318BB88;
	Mon, 11 Nov 2024 10:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="M3kPzYYj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE6E18A6A8;
	Mon, 11 Nov 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320893; cv=none; b=VetdastXtNaY3VNdOKkrTq/9yLjqeFreeQWG/rEca7fIHLD8axs9eUCzUd+pzaBwRA8oz66iJjzxxRUDKN/+rsQXvk+Sm8GsvQN7FegoTCaOCWCm2ojH29ByN9hKM9uWA2BsBtDrAOScbfpdvlH2dW9Odv6ssnrdCIN2ZBUJ7ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320893; c=relaxed/simple;
	bh=p7dFqWihnN+QLL8mvTGL9gu/pqIIO0i8Bjb0XT62xZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+0asWM1BM6RfCi8YlTN8JEAtVSrgRhaIDJQTAEfsCkJ79v9sgUC38CEY3yVQizV8qKCThWTY00LoJOYTGjAK3+zmnnGaArtwm4tZHyebx+PaeyqiiUYJjUHefFQXtcGhGU3FTzQAqmEI5d2LMRhz18hdq5qncmtT4Oplt50ytY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=M3kPzYYj; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320892; x=1762856892;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Znt9LySH4ZA9vBeKigC6MzlcO4GT24cmcWxN+qM4QI=;
  b=M3kPzYYjP75pF39phwOT+Pg4x50lfI+ISBL4J6Wi/QywPkCwXQeTu3kE
   l2HpPG+fW31OwwThWspIfYZM+vu3+El1UdhiBwsZ4xQsU5t7oaKBnlWju
   qezvDPLKvsghx4K7hqbyQEJcFGNBTDOUuGhBePMLAGFAUNRZGHU9dx2Oc
   E=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="447786885"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:09 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.29.78:23533]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.63:2525] with esmtp (Farcaster)
 id 288f9a74-d88c-4846-9043-07a72c6cd009; Mon, 11 Nov 2024 10:28:08 +0000 (UTC)
X-Farcaster-Flow-ID: 288f9a74-d88c-4846-9043-07a72c6cd009
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:05 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:04 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:04 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id E159AA04F9;
	Mon, 11 Nov 2024 10:28:02 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 2/6] KVM: x86: Add emulation status for vectoring during MMIO
Date: Mon, 11 Nov 2024 10:27:45 +0000
Message-ID: <20241111102749.82761-3-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add emulation status for vectoring error due to MMIO. Such a situation
can occur if guest sets the IDT descriptor base to point to MMIO region,
and triggers an exception after that.

Exit to userspace with event delivery error when MMIO happens during
vectoring.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- This patch wasn't included in V1.

 arch/x86/kvm/kvm_emulate.h | 2 ++
 arch/x86/kvm/x86.c         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd..f856bc979bdb 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -88,6 +88,8 @@ struct x86_instruction_info {
 #define X86EMUL_CMPXCHG_FAILED  4 /* cmpxchg did not see expected value */
 #define X86EMUL_IO_NEEDED       5 /* IO is needed to complete emulation */
 #define X86EMUL_INTERCEPTED     6 /* Intercepted by nested VMCB/VMCS */
+/* Vectroing requires MMIO and can't be emulated */
+#define X86EMUL_UNHANDLEABLE_VECTORING_IO	7
 
 /* x86-specific emulation flags */
 #define X86EMUL_F_WRITE			BIT(0)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e338d583f48f..4ba371040685 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9122,6 +9122,11 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
 			return 1;
 
+		if (r == X86EMUL_UNHANDLEABLE_VECTORING_IO) {
+			kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
+			return 0;
+		}
+
 		WARN_ON_ONCE(r != X86EMUL_UNHANDLEABLE);
 		return handle_emulation_failure(vcpu, emulation_type);
 	}
-- 
2.43.0


