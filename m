Return-Path: <linux-kselftest+bounces-19030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1541B99057C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3661C21C84
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A76242178F7;
	Fri,  4 Oct 2024 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Cpwj0U9h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C222141D3;
	Fri,  4 Oct 2024 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051005; cv=none; b=YSNxDUUq4T5ETgee9uL8PkZ1n66JaN1xGckHs9GR0RRsR0Q6VSgffF2CWlLgedGH8sHb3uHs8N5gu0YIB3pKnneWbVor3C9keHxujTwfyfUlPdDKGPWCA8kEUkUCEZeZij4pWOzwtajH2b7K6l4erc5ER4uKfmlFjK5tBAEh/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051005; c=relaxed/simple;
	bh=vrF9jUMfBrFiNavN18zZLj43ZpdBHA7TJjesVWiYw4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGx7qzWNm6lbh3ARWu3KDbupyxQtEnybAuAbOukEcQwvCJrmmpPoBZ+IGGKdTMyQybgOxpYSROwRo/2k4T8ZzDQ7hH58Lm+uwgwt1A1eZR0HrT5tYY+xMLSQQFrEwelwxpbgXiwI1mhfKzl85H4Hg07svQ6v2M2ZGY1YK2OBiD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Cpwj0U9h; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728051004; x=1759587004;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OeoT6WkOeJV7Rwi3GpbrV9LuWN/LKpWTB6zvQCrlovE=;
  b=Cpwj0U9hfHG9iT9rj2BcOB8MG3Coq919g5NgRyEowgXNmBJ3nf8XNtpN
   NfgUXWU9mTdFQf0jPt1EQPl8ydxY48MCtSOTvt9RjRm7f0SrTSIaXHYS2
   CMTUeJpndUn8qYdsi5i5IwK3Ehr+OocI3GRgr9ePFYAOSDIBnjVQRx/9Z
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="134729068"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:10:02 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.17.79:24900]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.12:2525] with esmtp (Farcaster)
 id c23a1a42-86a1-4515-b757-3dc0de7b5e83; Fri, 4 Oct 2024 14:10:01 +0000 (UTC)
X-Farcaster-Flow-ID: c23a1a42-86a1-4515-b757-3dc0de7b5e83
Received: from EX19D004EUA004.ant.amazon.com (10.252.50.183) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:10:01 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D004EUA004.ant.amazon.com (10.252.50.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:10:00 +0000
Received: from email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:10:00 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-iad-all-1a-f1af3bd3.us-east-1.amazon.com (Postfix) with ESMTPS id DBE154037C;
	Fri,  4 Oct 2024 14:09:58 +0000 (UTC)
From: Nikolas Wipper <nikwip@amazon.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Nikolas
 Wipper" <nikwip@amazon.de>
Subject: [PATCH 6/7] KVM: x86: Add trace events to track Hyper-V suspensions
Date: Fri, 4 Oct 2024 14:08:09 +0000
Message-ID: <20241004140810.34231-7-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004140810.34231-1-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Add trace events to track suspensions and unsuspensions vCPUs, because of
Hyper-V mechanisms.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/kvm/hyperv.c |  4 ++++
 arch/x86/kvm/trace.h  | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 40ea8340838f..55b8f88a91cb 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2944,6 +2944,8 @@ void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
 	/* waiting_on's store should happen before suspended's */
 	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
 	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
+
+	trace_kvm_hv_vcpu_suspend_tlb_flush(vcpu->vcpu_id, vcpu_id);
 }
 
 void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)
@@ -2962,6 +2964,8 @@ void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)
 			WRITE_ONCE(v->arch.hyperv->waiting_on, -1);
 			WRITE_ONCE(v->arch.hyperv->suspended, false);
 			__set_bit(i, vcpu_mask);
+
+			trace_kvm_hv_vcpu_unsuspend_tlb_flush(v->vcpu_id);
 		}
 	}
 
diff --git a/arch/x86/kvm/trace.h b/arch/x86/kvm/trace.h
index d3aeffd6ae75..5564ef52fd9d 100644
--- a/arch/x86/kvm/trace.h
+++ b/arch/x86/kvm/trace.h
@@ -1871,6 +1871,45 @@ TRACE_EVENT(kvm_rmp_fault,
 		  __entry->error_code, __entry->rmp_level, __entry->psmash_ret)
 );
 
+/*
+ * Tracepoint for Hyper-V TlbFlushInhibit suspension
+ */
+TRACE_EVENT(kvm_hv_vcpu_suspend_tlb_flush,
+	TP_PROTO(int vcpu_id, int waiting_on),
+	TP_ARGS(vcpu_id, waiting_on),
+
+	TP_STRUCT__entry(
+		__field(int, vcpu_id)
+		__field(int, waiting_on)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id  = vcpu_id;
+		__entry->waiting_on = waiting_on;
+	),
+
+	TP_printk("suspending vcpu %u waiting on %u",
+		  __entry->vcpu_id, __entry->waiting_on)
+);
+
+/*
+ * Tracepoint for Hyper-V TlbFlushInhibit unsuspension
+ */
+TRACE_EVENT(kvm_hv_vcpu_unsuspend_tlb_flush,
+	TP_PROTO(int vcpu_id),
+	TP_ARGS(vcpu_id),
+	TP_STRUCT__entry(
+		__field(int, vcpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id  = vcpu_id;
+	),
+
+	TP_printk("unsuspending vcpu %u",
+		  __entry->vcpu_id)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


