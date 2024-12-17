Return-Path: <linux-kselftest+bounces-23462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 862CE9F55D7
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 19:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9EAC1889FED
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0EB1F9F4D;
	Tue, 17 Dec 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YQz5IhIz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5223B1F8AEC;
	Tue, 17 Dec 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459326; cv=none; b=MLl1TX/cF7PW4z2DZ+A3ACca6ms4qLRkXkI4F6EWQT+7jOfxRC5lpOqFc9gAR5IIIzTZkvazVkf5h3o7yZ+Co4uxP+pxCBjYBrmDCPYYQXmf7zZnvIGU40y5lz2kXzY3T24dVVgMiHaV6PLasdJwzSHbhzxpYtUqucr1vw8MhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459326; c=relaxed/simple;
	bh=2o7S8BDu0sZi5YHEyQOzYJEOVcXGnKx1bjML9XDHTm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKC3kR4uXxkOpca4i+M9zaKPqQtaqCt6oeEZ/DCpTA6lBJnNTf2v6nwGBNTa1Du5j+VB7SDW6W0PnMAeja9DUPIuLPzSvbf7+37qYqTfqD5FQ0SCk+wuIyNh5LvGzjpcuxQDYjji0Kkmh55xgvXlw/C+hniRogsc4D++H71WkaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YQz5IhIz; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734459323; x=1765995323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hK4TfNbzwafMN1JBUmasDQUaI0rwkIzBfWJzH6DW6to=;
  b=YQz5IhIzFg9Gqxh7F8vaS3QVIVTb7e1ZfF/DDFhyG1FDU8oB8ESIahl1
   8QzAe4Rr0gWubSY71evBPwo+XvkVMY4tAwICes9qjvW6R9XtmL3yLGBR3
   rkToS2GP2rqkYqPWE7dpYF4pD0dlSEoOOR+2qIdVWeDAUc/8jU4W75GTR
   8=;
X-IronPort-AV: E=Sophos;i="6.12,242,1728950400"; 
   d="scan'208";a="446604429"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 18:15:22 +0000
Received: from EX19MTAUEB002.ant.amazon.com [10.0.0.204:44920]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.36.121:2525] with esmtp (Farcaster)
 id 05bd3edc-a4ab-4399-bf04-79b001e25ed6; Tue, 17 Dec 2024 18:15:23 +0000 (UTC)
X-Farcaster-Flow-ID: 05bd3edc-a4ab-4399-bf04-79b001e25ed6
Received: from EX19D008UEA004.ant.amazon.com (10.252.134.191) by
 EX19MTAUEB002.ant.amazon.com (10.252.135.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:20 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D008UEA004.ant.amazon.com (10.252.134.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 18:15:20 +0000
Received: from email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.39 via Frontend Transport; Tue, 17 Dec 2024 18:15:20 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-pdx-1box-2b-8c2c6aed.us-west-2.amazon.com (Postfix) with ESMTPS id D5E3AA0723;
	Tue, 17 Dec 2024 18:15:17 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <dwmw@amazon.co.uk>, <pdurrant@amazon.co.uk>,
	<jalliste@amazon.co.uk>
Subject: [PATCH v3 6/7] selftests: KVM: extract lidt into helper function
Date: Tue, 17 Dec 2024 18:14:57 +0000
Message-ID: <20241217181458.68690-7-iorlov@amazon.com>
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

Implement a function for setting the IDT descriptor from the guest
code. Replace the existing lidt occurrences with calls to this function
as `lidt` is used in multiple places.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- This patch wasn't included in V1.
V2 -> V3:
- No changes

 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 +++++
 tools/testing/selftests/kvm/set_memory_region_test.c   | 2 +-
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index 645200e95f89..69938c649a5e 100644
--- a/tools/testing/selftests/kvm/include/x86_64/processor.h
+++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
@@ -571,6 +571,11 @@ static inline void set_cr4(uint64_t val)
 	__asm__ __volatile__("mov %0, %%cr4" : : "r" (val) : "memory");
 }
 
+static inline void set_idt(const struct desc_ptr *idt_desc)
+{
+	__asm__ __volatile__("lidt %0"::"m"(*idt_desc));
+}
+
 static inline u64 xgetbv(u32 index)
 {
 	u32 eax, edx;
diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index a8267628e9ed..a1c53cc854a5 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -235,7 +235,7 @@ static void guest_code_delete_memory_region(void)
 	 * in the guest will never succeed, and so isn't an option.
 	 */
 	memset(&idt, 0, sizeof(idt));
-	__asm__ __volatile__("lidt %0" :: "m"(idt));
+	set_idt(&idt);
 
 	GUEST_SYNC(0);
 
diff --git a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
index ae77698e6e97..a1a688e75266 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -155,7 +155,7 @@ static void guest_shutdown_code(void)
 
 	/* Clobber the IDT so that #UD is guaranteed to trigger SHUTDOWN. */
 	memset(&idt, 0, sizeof(idt));
-	__asm__ __volatile__("lidt %0" :: "m"(idt));
+	set_idt(&idt);
 
 	__asm__ __volatile__("ud2");
 }
-- 
2.43.0


