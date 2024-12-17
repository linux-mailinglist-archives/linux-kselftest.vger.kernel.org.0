Return-Path: <linux-kselftest+bounces-23459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18AD9F55CF
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F0D18894AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE631F941F;
	Tue, 17 Dec 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SO9mURks"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AC31F8926;
	Tue, 17 Dec 2024 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459323; cv=none; b=CC1IA12GJQaHD2374KElojAhnZ2I/RDe19FLX+U6xWtQRPHXN+LguKAbkudWHdN4rSxLwWSDpB4Jcn14Gy80XV51AQePLtXZjfCXyiLpQYOPORpfaliXwN6dANSESPnOdQLJNvSBgVFnmIYB6oOKupbSxFk0bc7yFRkQGmQRU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459323; c=relaxed/simple;
	bh=BlFiVRX84VKB+lYW0JlENh5OHc/YiO1YD8ZW2XFsitY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XYSdiBr2n5mjP7p+nwwJgzOm5joC9AJSV56n0F3VziC6eFGqZLqpvSb2YAjDzgW25KWfMuSvJkyXZPlG3IYbwo7VRax0szwSvkRmhdDXeVmI5tuT3Gb6bcprYAG4YKwVP0gCFgHNxuHpOG230hyxin7PFOXPKsx88Q74JACNEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SO9mURks; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459321; x=1765995321;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Bb3yk5m8+2ssI3UJ2EET3EK/UrkVfIMo+0kcIuYef0=;
  b=SO9mURksLHEZ2EOElVjKX1wjJjnYEFQrC6GitprwmlGqhEpMRZaRwAfH
   83B7qScdvLQYNgiOdkSMd6a+eVOzrnCICS6c0fppIgItNz3V+bRC41oXR
   BqsG8w5O4e3cl79x/v9Srz9IvMjDrXOQ+rYXPZhDVwgvM0205z4s39saM
   I=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="682125540"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:18 +0000
Received: from EX19MTAUEC002.ant.amazon.com [10.0.29.78:60145]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.36.121:2525] with esmtp (Farcaster)
 id 365cb594-0db9-4605-a381-469b8f367db5; Tue, 17 Dec 2024 18:15:18 +0000 (UTC)
X-Farcaster-Flow-ID: 365cb594-0db9-4605-a381-469b8f367db5
Received: from EX19D008UEA003.ant.amazon.com (10.252.134.116) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:18 +0000
Received: from EX19MTAUEB002.ant.amazon.com (10.252.135.47) by
 EX19D008UEA003.ant.amazon.com (10.252.134.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:18 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:18 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id 7FA39A0790;
	Tue, 17 Dec 2024 18:15:15 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 5/7] KVM: SVM: Handle vectoring error in check_emulate_instruction
Date: Tue, 17 Dec 2024 18:14:56 +0000
Message-ID: <20241217181458.68690-6-iorlov@amazon.com>
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

Detect unhandleable vectoring in check_emulate_instruction to prevent
infinite loop on SVM and eliminate the difference in how intercepted #PF
during vectoring is handled on SVM and VMX.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Detect the unhandleable vectoring error in svm_check_emulate_instruction
instead of handling it in the common MMU code (which is specific for
cached MMIO)
V2 -> V3:
- Use more generic function to check if emulation is allowed when
vectoring

 arch/x86/kvm/svm/svm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dd15cc635655..e89c6fc2c4e6 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4802,6 +4802,12 @@ static int svm_check_emulate_instruction(struct kvm_vcpu *vcpu, int emul_type,
 	bool smep, smap, is_user;
 	u64 error_code;
 
+	/* Check that emulation is possible during event vectoring */
+	if ((to_svm(vcpu)->vmcb->control.exit_int_info &
+	    SVM_EXITINTINFO_TYPE_MASK) &&
+	    !kvm_can_emulate_event_vectoring(emul_type))
+		return X86EMUL_UNHANDLEABLE_VECTORING;
+
 	/* Emulation is always possible when KVM has access to all guest state. */
 	if (!sev_guest(vcpu->kvm))
 		return X86EMUL_CONTINUE;
-- 
2.43.0


