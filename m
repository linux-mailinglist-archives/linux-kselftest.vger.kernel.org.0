Return-Path: <linux-kselftest+bounces-18219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E69497ECF0
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBD271F221EC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC7F19D89A;
	Mon, 23 Sep 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="C7g+Nakc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9897019CCFA;
	Mon, 23 Sep 2024 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101109; cv=none; b=mw4bF01t4s2DFxnjDG63T8cUQAhrVkHZo0mcYEwti03ZTVW2/k5d5rV9J73bVWjPNvQD+ablHF2yjb7mULBWpx6+U+re2/YWANM95SkvPuibjhIOZ0/DLc45N5pSLcDYG7sIHyLhgVE310fTKEmsw088q+XjYKvZN94nhjTJ2j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101109; c=relaxed/simple;
	bh=uvZHZhXORwWLt3EuUDk4U5ebdUUe0uJW4Sh7k48mXpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw/Wydg0ATPobbr2jsA/feK8aC1Jn6nAoi3hWr0AXqZ5Rv6uxgnb6w90eR+HOvwToFnEWT0GnR47ThSdtxP55yzSgsonbLRdCDmAy4GeTBE6GRCQzk4fTN2J2eDspvZo2uZTSMya6q3GJmjalFEOI+BKwTo0NAnhBMUnrxJ3aOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=C7g+Nakc; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727101108; x=1758637108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sXVT52UMCjmzy+YBBlIyrCdztT/CnyQJDSmFN7zEL+k=;
  b=C7g+NakcdNzbkUJskw7tpp0E/OyJtVCx3qN27khE9j3r6gNrkZffQ9ax
   nhCSpxhJdvVg3vYPxLArFu+FMhejXCdC3rCz4h+0XhW8PL47Tmc9BOQFO
   2oZVG9r2xUL7mKMBxZZRcwYDS64PmYfHaMrLHq039kV5Aws339uXoHlcX
   Q=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719878400"; 
   d="scan'208";a="762881537"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:18:20 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.10.100:15088]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.171:2525] with esmtp (Farcaster)
 id 1b97b3a0-d6be-4ba2-83f8-c6f1c649c930; Mon, 23 Sep 2024 14:18:18 +0000 (UTC)
X-Farcaster-Flow-ID: 1b97b3a0-d6be-4ba2-83f8-c6f1c649c930
Received: from EX19D033EUC003.ant.amazon.com (10.252.61.134) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:18 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D033EUC003.ant.amazon.com (10.252.61.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:17 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 23 Sep 2024 14:18:17 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id 4D6CA40599;
	Mon, 23 Sep 2024 14:18:16 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <hpa@zytor.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH 2/4] KVM: x86: Inject UD when fetching from MMIO
Date: Mon, 23 Sep 2024 14:18:08 +0000
Message-ID: <20240923141810.76331-3-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240923141810.76331-1-iorlov@amazon.com>
References: <20240923141810.76331-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, we simply return a KVM internal error with suberror =
KVM_INTERNAL_ERROR_EMULATION if the guest tries to fetch instruction
from MMIO range as we simply can't decode it.

I believe it is not the best thing to do, considering that

  1) we don't give enough information to VMM about the issue we faced
  2) the issue is triggered by the guest itself, so it is not the KVM
     "internal" error.

Inject the #UD into the guest instead and resume it's execution without
giving an error to VMM, as it would be if we can't find a valid
instruction at MMIO address.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 arch/x86/kvm/emulate.c     | 3 +++
 arch/x86/kvm/kvm_emulate.h | 1 +
 arch/x86/kvm/x86.c         | 7 ++++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index e72aed25d721..d610c47fa1f4 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -4742,10 +4742,13 @@ int x86_decode_insn(struct x86_emulate_ctxt *ctxt, void *insn, int insn_len, int
 	ctxt->fetch.end = ctxt->fetch.data + insn_len;
 	ctxt->opcode_len = 1;
 	ctxt->intercept = x86_intercept_none;
+	ctxt->is_mmio_fetch = false;
 	if (insn_len > 0)
 		memcpy(ctxt->fetch.data, insn, insn_len);
 	else {
 		rc = __do_insn_fetch_bytes(ctxt, 1);
+		if (rc == X86EMUL_IO_NEEDED)
+			ctxt->is_mmio_fetch = true;
 		if (rc != X86EMUL_CONTINUE)
 			goto done;
 	}
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 55a18e2f2dcd..46c0d1111ec1 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -362,6 +362,7 @@ struct x86_emulate_ctxt {
 	u8 seg_override;
 	u64 d;
 	unsigned long _eip;
+	bool is_mmio_fetch;
 
 	/* Here begins the usercopy section. */
 	struct operand src;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c983c8e434b8..4fb57280ec7b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8857,7 +8857,12 @@ static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 
 	kvm_queue_exception(vcpu, UD_VECTOR);
 
-	if (!is_guest_mode(vcpu) && kvm_x86_call(get_cpl)(vcpu) == 0) {
+	/*
+	 * Don't return an internal error if the emulation error is caused by a fetch from MMIO
+	 * address. Injecting a #UD should be enough.
+	 */
+	if (!is_guest_mode(vcpu) && kvm_x86_call(get_cpl)(vcpu) == 0 &&
+	    !vcpu->arch.emulate_ctxt->is_mmio_fetch) {
 		prepare_emulation_ctxt_failure_exit(vcpu);
 		return 0;
 	}
-- 
2.43.0


