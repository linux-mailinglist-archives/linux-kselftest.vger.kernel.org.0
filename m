Return-Path: <linux-kselftest+bounces-18222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A27597ECFB
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC5C1C2123E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2FB19EEA1;
	Mon, 23 Sep 2024 14:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lUC0xRbD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF719E983;
	Mon, 23 Sep 2024 14:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101114; cv=none; b=Dhvb9w0UAlzpjRgTO7Z4R2aS1DxVlHjvkLNFFGRwYjq9MHqrrqKDfXCg8yJHyoKF3CUiuvtNHl6BTsIyRgoXH6W0zGbt2Dk9dARyjcmT4913y9Xm4yIkW1m5CrT0O2+8VL99TogVAsZYzwiI3a6FpJg/anGZFx4I5FMn/hN8vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101114; c=relaxed/simple;
	bh=ZYlrLWbi9b/qcGYBaeiJTs5niEiceUbuPcDemrSREGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLgKhZzbElckhwUCqMsY/o7N+nYXdyv5BuDpIBLgEIxudflrmhe4PvWt2znMqpVvaXsdCpMtR8HmwI/PcnQKOhceLWurgaDox5VU2Zhz0w94tg0t3FtY4sIb7mSZvVa0XZ9Zir2hoLh9zviURjOAaBMCt3RPGnew0FWb3K0ZIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lUC0xRbD; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727101113; x=1758637113;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MVsCWkFfpqOQith2gEkK3QHBzlLrKHz0IElzLZJJhv0=;
  b=lUC0xRbDpsZM9zJ4QkmqaYO2CMBBRX/1w8dcYKtr5giSFmQXA5Cdo8N1
   kAKTL9PnZTCYkTumB7usVfvk8sgMRKKikxVAK4t3ecoEAiNAwcLN3QJl8
   CcI/FzRvYEhr9I9LmKAwVn/usJwEeu2EgwiF1BZPzEBF0ZFyc7I9nan+Q
   o=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719878400"; 
   d="scan'208";a="457053135"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:18:21 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:38889]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.194:2525] with esmtp (Farcaster)
 id 169203bd-90e1-49ed-a7f6-b1b2dcb14331; Mon, 23 Sep 2024 14:18:19 +0000 (UTC)
X-Farcaster-Flow-ID: 169203bd-90e1-49ed-a7f6-b1b2dcb14331
Received: from EX19D031EUC001.ant.amazon.com (10.252.61.162) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:19 +0000
Received: from EX19MTAUEA002.ant.amazon.com (10.252.134.9) by
 EX19D031EUC001.ant.amazon.com (10.252.61.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:19 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.134.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 23 Sep 2024 14:18:18 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id A7B2240592;
	Mon, 23 Sep 2024 14:18:17 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <hpa@zytor.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH 3/4] selftests: KVM: Change expected exit code in test_zero_memory_regions
Date: Mon, 23 Sep 2024 14:18:09 +0000
Message-ID: <20240923141810.76331-4-iorlov@amazon.com>
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

Update the set_memory_region test, test case test_zero_memory_regions to
use an updated exit code if the VM starts with no RAM. Now we are
issuing a triple fault in such a case, not an internal error.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 tools/testing/selftests/kvm/set_memory_region_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index bb8002084f52..d84d86668932 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -331,7 +331,8 @@ static void test_zero_memory_regions(void)
 
 	vm_ioctl(vm, KVM_SET_NR_MMU_PAGES, (void *)64ul);
 	vcpu_run(vcpu);
-	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_INTERNAL_ERROR);
+	/* No memory at all, we should triple fault */
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
 
 	kvm_vm_free(vm);
 }
-- 
2.43.0


