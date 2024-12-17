Return-Path: <linux-kselftest+bounces-23457-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A979F55C9
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A2C188894C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEE214900B;
	Tue, 17 Dec 2024 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TeJ72Cu2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856901F869E;
	Tue, 17 Dec 2024 18:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459322; cv=none; b=LycgzV8uacs3js2mNNsoIlEV3xtUE2o+1L07TUohyzRdYaSlHB+KDnTTLQARtiwtpwFP7iMr7wG6Bar083IMxCl1KIYvwK8yuXmKlsP+V0IDJrRB8/M1OvVQhBdXt77WERx6E6zvDx8Wmz4K2lUDt9dTk9F9gp4o5+uZx9G4hDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459322; c=relaxed/simple;
	bh=9H/Cqy3PV0ClCDquXysgjPLOWLpExtRhMDhj1G0LfPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ko+Ir2U2+4qFrkxpwzjjVmatG2J70RoT7xTNx9m9ynKxicUsGRTv7d7ontDyrQ9aw+OBGGs3qeCR579PujYBFgqKjPiexLmZlXNKUk4Ir2FO69bnmOjGUnQtBYf99isiuJ0ZeL+i/evoHEzyj1+4vFzfn2v1DFtPX77tC9B/zHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TeJ72Cu2; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459320; x=1765995320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CWb9mwdiPjYqt8933wN0Q1+0SMJntSgscimdaSQvyGY=;
  b=TeJ72Cu2skrhhmGKQ92aRAfZJ4LBeWfqk8UeZeEkx2vuE5McmoEhyrTx
   UFISAN/Za+q0SbFwPhPFzUyen/ji2IV77MZ193mS6tMt7kq8Oa0A+fwJq
   DtRY0zRcSh8tbwsdZhJH2jcfl7Ox4TQFbncWmnzD65ZHHvNz5nUw5YpWG
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="255725015"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:16 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.0.204:63049]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.38:2525] with esmtp (Farcaster)
 id f5bab109-1f85-48c7-9761-74a3f1bf25e4; Tue, 17 Dec 2024 18:15:15 +0000 (UTC)
X-Farcaster-Flow-ID: f5bab109-1f85-48c7-9761-74a3f1bf25e4
Received: from EX19D008UEA001.ant.amazon.com (10.252.134.62) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:11 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D008UEA001.ant.amazon.com (10.252.134.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:11 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:11 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 70DF5A0723;
	Tue, 17 Dec 2024 18:15:08 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 2/7] KVM: x86: Add emulation status for unhandleable vectoring
Date: Tue, 17 Dec 2024 18:14:53 +0000
Message-ID: <20241217181458.68690-3-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241217181458.68690-1-iorlov@amazon.com>
References: <20241217181458.68690-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add emulation status for unhandleable vectoring, i.e. when KVM can't
emulate an instruction during vectoring. Such a situation can occur
if guest sets the IDT descriptor base to point to MMIO region, and
triggers an exception after that.

Exit to userspace with event delivery error when KVM can't emulate
an instruction when vectoring an event.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- This patch wasn't included in V1.
V2 -> V3:
- Make new X86EMUL_ code more generic to allow using it for any type
of unhandleable vectoring

 arch/x86/kvm/kvm_emulate.h | 2 ++
 arch/x86/kvm/x86.c         | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10495fffb890..5bcf50ffc3de 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -88,6 +88,8 @@ struct x86_instruction_info {
 #define X86EMUL_CMPXCHG_FAILED  4 /* cmpxchg did not see expected value */
 #define X86EMUL_IO_NEEDED       5 /* IO is needed to complete emulation */
 #define X86EMUL_INTERCEPTED     6 /* Intercepted by nested VMCB/VMCS */
+/* Vectroing can't be emulated */
+#define X86EMUL_UNHANDLEABLE_VECTORING	7
 
 /* x86-specific emulation flags */
 #define X86EMUL_F_WRITE			BIT(0)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7ce9cdb66f19..849a6fc364b3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9107,6 +9107,11 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
 			return 1;
 
+		if (r == X86EMUL_UNHANDLEABLE_VECTORING) {
+			kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
+			return 0;
+		}
+
 		WARN_ON_ONCE(r != X86EMUL_UNHANDLEABLE);
 		return handle_emulation_failure(vcpu, emulation_type);
 	}
-- 
2.43.0


