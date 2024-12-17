Return-Path: <linux-kselftest+bounces-23461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B899F55D4
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483FD167AC0
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEF3B1F9EC8;
	Tue, 17 Dec 2024 18:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QI3QL1vI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02CE1F942E;
	Tue, 17 Dec 2024 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459325; cv=none; b=uZ0jWAu+6yqwzY9cC5RxKsBQS6UNTGYt7AAU6F31K402rI+VJ1Zisttvux1uW3O71kGaHLsz4a89yZq5+DnvAo+I+z/JxY2xzkBpzZGhPkEohG4JtHl4TvUrriMzaO9TziyVuIeZ0JA9fa34w5gxlYJuVb0iYoq2O5KzMAgIWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459325; c=relaxed/simple;
	bh=pCiEw53LX/kiPJff4iFU2sM0ncHJUbxIYel3PKwQkrY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXao9Dy4uzZSHVdX7/pijmVDlKbmiE3GFKpJ3GmAwDJOjYL1sxjXhCBpuleVv+h2isd39/gQrvXZFgWJ0PArPsQQOSDr6cdNv+qdv3cZZZeaOSaQYSlYvNARPAiMBcFLejJq83JjDmN9Ov3TGZS3dwJKrTadGvRc2yEqFZMPxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QI3QL1vI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459324; x=1765995324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qu3I2fuJZWUmuNAenq6eGdr9/4WhHxiZiaa+v1R1fkY=;
  b=QI3QL1vIUSZQoPo73305OcTYPX5P2QELM+eNCcWxu5P0GAbo2ybmNyaD
   AFmxwaZAsyEpvWTLXTvi0tibo9kSr45ix0ulo1gUIvNjS+nD9Gu3CpwX2
   hh2MDG5Z/S7goP81acHL8x7DmWGjoT9Ec0Zor/WVB5eMUzzMgwfYdb6rs
   4=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="456798162"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:21 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:49982]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.24.38:2525] with esmtp (Farcaster)
 id 3eeb9ddb-d581-480d-a478-1c123f119ac3; Tue, 17 Dec 2024 18:15:19 +0000 (UTC)
X-Farcaster-Flow-ID: 3eeb9ddb-d581-480d-a478-1c123f119ac3
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:13 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:13 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:13 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id C742AA07DA;
	Tue, 17 Dec 2024 18:15:10 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 3/7] KVM: x86: Unprotect & retry before unhandleable vectoring check
Date: Tue, 17 Dec 2024 18:14:54 +0000
Message-ID: <20241217181458.68690-4-iorlov@amazon.com>
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

Try to unprotect and retry the instruction execution before checking for
unhandleable vectoring. If there is a write to a shadowed page table
when vectoring an event, KVM should be able to unprotect the gfn and
retry the instruction execution without returning an error to userspace.

This ensures that the subsequent patches won't make KVM exit to
userspace when handling an intercepted #PF during vectoring without
checking whether unprotect & retry is possible.

Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- This patch wasn't included in V1.
V2 -> V3:
- This patch wasn't included in V2.

 arch/x86/kvm/x86.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 849a6fc364b3..26faacc99c4c 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9107,6 +9107,10 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 		if (r == X86EMUL_RETRY_INSTR || r == X86EMUL_PROPAGATE_FAULT)
 			return 1;
 
+		if (kvm_unprotect_and_retry_on_failure(vcpu, cr2_or_gpa,
+						       emulation_type))
+			return 1;
+
 		if (r == X86EMUL_UNHANDLEABLE_VECTORING) {
 			kvm_prepare_event_vectoring_exit(vcpu, cr2_or_gpa);
 			return 0;
-- 
2.43.0


