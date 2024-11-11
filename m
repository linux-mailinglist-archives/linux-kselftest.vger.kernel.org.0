Return-Path: <linux-kselftest+bounces-21771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 372A49C3BE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C4B71C217DA
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739DD198A21;
	Mon, 11 Nov 2024 10:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bZBQvS5+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26318A6AE;
	Mon, 11 Nov 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320896; cv=none; b=ugLI/uX9MaByzW6E3XO173UPl1QhUzweO13zqcCULmk6md4R7rHAgIzzyhBgAWrHiDRGz+iTzcTg4PcmUL1CSfhKSkEX80Y/J1TefOiv7b+bMoAAB3QE137R7Z0JLL0dE4RMsSC5wWZPD+S1NJVAJ3Te2hUZ6WrQz+IPiDlAfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320896; c=relaxed/simple;
	bh=7dO0arnWA1VJCyyAIjlCytHy6vOCA1OXvPvcwF8Dzm8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUq/uYoFalYpmEyHrf7r07dpbF2vGeQCwz0QjQhEuEl0Rqw8MykJxS0zfzby3H2izZpaJUE1OeGMhEZAvE7X5dN3LRYZ25kQ/WfZMrBYuE68y0dYZOd1THbDnIeJck8Q5z5AQQFldx/Kd9WvP2+Y1KWJRs81kGLMVi0x0ifWOug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bZBQvS5+; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320891; x=1762856891;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGbwD6a3e8Ydvdk8hk6S240bw0jqNpcW0bpsM765uBY=;
  b=bZBQvS5+dVvCiPPMg83oH3A1Z2f20IGdVVnvt+j+7vYc3gdX126KYcJi
   Tn/uH3fDQlH0AbCtG7JZ5WdDBKiPqOPGjLTdOLWQuTbdB/Scv4oVeEikI
   3NTQKuJ9winX3ahKH9gdx4icOe4BwfCKd97BNDRt+lHon/fLfHeHi+EZ0
   k=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="441674374"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:09 +0000
Received: from EX19MTAUEA002.ant.amazon.com [10.0.29.78:23109]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.90.76:2525] with esmtp (Farcaster)
 id 7b9b6d70-a9ff-45a1-9d42-40b3e8884867; Mon, 11 Nov 2024 10:28:08 +0000 (UTC)
X-Farcaster-Flow-ID: 7b9b6d70-a9ff-45a1-9d42-40b3e8884867
Received: from EX19D008UEA002.ant.amazon.com (10.252.134.125) by
 EX19MTAUEA002.ant.amazon.com (10.252.134.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:08 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D008UEA002.ant.amazon.com (10.252.134.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:08 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.124.125.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:08 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 04A25A065E;
	Mon, 11 Nov 2024 10:28:06 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 5/6] selftests: KVM: extract lidt into helper function
Date: Mon, 11 Nov 2024 10:27:48 +0000
Message-ID: <20241111102749.82761-6-iorlov@amazon.com>
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

Implement a function for setting the IDT descriptor from the guest
code. Replace the existing lidt occurrences with calls to this function
as `lidt` is used in multiple places.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- This patch wasn't included in V1.

 tools/testing/selftests/kvm/include/x86_64/processor.h | 5 +++++
 tools/testing/selftests/kvm/set_memory_region_test.c   | 2 +-
 tools/testing/selftests/kvm/x86_64/sev_smoke_test.c    | 2 +-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
index e247f99e0473..1a60c99b5833 100644
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
index 2e9197eb1652..8c33e02a3183 100644
--- a/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
+++ b/tools/testing/selftests/kvm/x86_64/sev_smoke_test.c
@@ -166,7 +166,7 @@ static void guest_shutdown_code(void)
 
 	/* Clobber the IDT so that #UD is guaranteed to trigger SHUTDOWN. */
 	memset(&idt, 0, sizeof(idt));
-	__asm__ __volatile__("lidt %0" :: "m"(idt));
+	set_idt(&idt);
 
 	__asm__ __volatile__("ud2");
 }
-- 
2.43.0


