Return-Path: <linux-kselftest+bounces-21772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE7E9C3BE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F471F2210F
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EF11990A7;
	Mon, 11 Nov 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V173LC85"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86761946CF;
	Mon, 11 Nov 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320896; cv=none; b=dz1JGcWUDm8ro4J2m0gMHs0BjrZP9m9NNFrSFvniteQMFi1ND7c5Q4VdWC8BmsdAQ2bysnZZY9Jotek/XfF+VydLPWqeo2t2ZChUmnaytY63bzFh4UAUM55x4rsoWXuTdzAluwUC2+8cw1ilmS+KLJ73oqJikZhHVKNsZO7mIFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320896; c=relaxed/simple;
	bh=ld2htNMH0wPiH0yxfy3DynYM6vkDFeKlfvMRDP8V8sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WRFlDHmKc08ZD4PVqYluaRdbhSqDzddsZFQZyEUb68TnyL+fkls7M/wI7smYGdLBwy9UCpvYf/6y75bkjepF+kzRLO3YepoAxEAUC0t/VmEKZ79x/10Z767gu0smzc4OwaLtOUDzpY6xVCdtSV7yN1IxcuUSb1GRRwF1xL5Dxgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V173LC85; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320895; x=1762856895;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ssZRDwUFYvqJoo1dkCRAk/I8OZ5DCMExWyKykGpw3fw=;
  b=V173LC85Ld6MJ8D9Ry48jalfF5u2K2Ru0Tipdvh3jJqVsrbwbHMpuP5U
   McJdN1QVe1AZQaxboGXnOyx1l+rYnT3jVuNrWKEFAqMAMeZNIj1Q9twl/
   t4uza4QXrvo/WTYkhwitT1kIM6nQyxkjacfKrr5oZsSrhX1tk587DgRme
   I=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="441674387"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:14 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.0.204:45389]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.26.144:2525] with esmtp (Farcaster)
 id c672870c-d482-4391-913e-d42e6c81d821; Mon, 11 Nov 2024 10:28:13 +0000 (UTC)
X-Farcaster-Flow-ID: c672870c-d482-4391-913e-d42e6c81d821
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:08 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:07 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 9F7EBA04F9;
	Mon, 11 Nov 2024 10:28:05 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 4/6] KVM: SVM: Handle MMIO during vectroing error
Date: Mon, 11 Nov 2024 10:27:47 +0000
Message-ID: <20241111102749.82761-5-iorlov@amazon.com>
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

Handle MMIO during vectoring error in check_emulate_instruction to
prevent infinite loop on SVM and eliminate the difference in how the
situation when the guest accesses MMIO during vectoring is handled on
SVM and VMX.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Detect the unhandleable vectoring error in svm_check_emulate_instruction
instead of handling it in the common MMU code (which is specific for
cached MMIO)

 arch/x86/kvm/svm/svm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c1e29307826b..b69f0f98c576 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4797,9 +4797,16 @@ static void svm_enable_smi_window(struct kvm_vcpu *vcpu)
 static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 					 void *insn, int insn_len)
 {
-	bool smep, smap, is_user;
+	bool smep, smap, is_user, is_vect;
 	u64 error_code;
 
+	is_vect = to_svm(vcpu)->vmcb->control.exit_int_info &
+		  SVM_EXITINTINFO_TYPE_MASK;
+
+	/* Emulation is not possible when MMIO happens during event vectoring. */
+	if (kvm_is_emul_type_mmio(emul_type) && is_vect)
+		return X86EMUL_UNHANDLEABLE_VECTORING_IO;
+
 	/* Emulation is always possible when KVM has access to all guest state. */
 	if (!sev_guest(vcpu->kvm))
 		return X86EMUL_CONTINUE;
-- 
2.43.0


