Return-Path: <linux-kselftest+bounces-20530-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87FA9AE1DB
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 12:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3AA9280FBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Oct 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665EC1B21AD;
	Thu, 24 Oct 2024 10:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="jIXhL67Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4D31B0F2E;
	Thu, 24 Oct 2024 10:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729764085; cv=none; b=tLJUFNf+rqO/NjxtA7DfpaHGbZ+43sBP0PrLMpHMFvgWHuTkmxoRulaMwOq0cqUpLSiHlGzKMOCXsw213s3A3pyrK1R6iGpDDfmDh4fFftEufc0Zd5L3h00FSQtJoDO7pWMRfzoHUG4+bnAn6j0Kjmg6qaCG8XiKrNdEO0G7qyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729764085; c=relaxed/simple;
	bh=rTaEixUjq69X3PsehfWtcV4xr2/JgkjOMzNJ5s0sNr0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=apIxygR5yGehyHRPyc2E90y5Bh90G68972iT1xRM+PYWJ7ACuuYWMjWPzABSD4eJ4GQ/H+VQca8b5jRq0/a2e87xTPeeewtNJN6eyJCnpm3IMi6DWwI0gzPvJPofDDye/FNW5faHzK2+g7YcnK7CURTeNVaLRd5Seg8imHmB/ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=jIXhL67Z; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1729764083; x=1761300083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5apd9HcXeKuq8wX3cYQw2KG3LxM7fHdbRFcmZPkFS4s=;
  b=jIXhL67Z9LEtuFu/qws+p15BGkDKcoy6Xk39TN2cr8f79yWosvGesVTw
   5CCuVJHyBn0XJML6jO17mvAgUzd+Mdrm6j4uZ/KpseGe79JbhC9skqSZ0
   rx4Vh23nz9z1hxlKu2OvIjhGZSNckF+4Jqi7O5vbB3yu9iEk8jD4dsB9q
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,228,1725321600"; 
   d="scan'208";a="141281902"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 10:01:21 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:19050]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.143:2525] with esmtp (Farcaster)
 id 6dfb1a6f-113c-4c87-ac50-28e96b604137; Thu, 24 Oct 2024 10:01:20 +0000 (UTC)
X-Farcaster-Flow-ID: 6dfb1a6f-113c-4c87-ac50-28e96b604137
Received: from EX19D020UWC002.ant.amazon.com (10.13.138.147) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 10:01:20 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D020UWC002.ant.amazon.com (10.13.138.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 24 Oct 2024 10:01:19 +0000
Received: from email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 24 Oct 2024 10:01:19 +0000
Received: from ua2d7e1a6107c5b.home (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-c1559d0e.us-west-2.amazon.com (Postfix) with ESMTPS id 9325640316;
	Thu, 24 Oct 2024 10:01:17 +0000 (UTC)
From: Patrick Roy <roypat@amazon.co.uk>
To: <pbonzini@redhat.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Patrick Roy <roypat@amazon.co.uk>, <chao.p.peng@linux.intel.com>,
	<ackerleytng@google.com>, <seanjc@google.com>, <graf@amazon.com>,
	<jgowans@amazon.com>
Subject: [PATCH] kvm: selftest: fix noop test in guest_memfd_test.c
Date: Thu, 24 Oct 2024 10:59:53 +0100
Message-ID: <20241024095956.3668818-1-roypat@amazon.co.uk>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain

The loop in test_create_guest_memfd_invalid that is supposed to test
that nothing is accepted as a valid flag to KVM_CREATE_GUEST_MEMFD was
initializing `flag` as 0 instead of BIT(0). This caused the loop to
immediately exit instead of iterating over BIT(0), BIT(1), ... .

Fixes: 8a89efd43423 ("KVM: selftests: Add basic selftest for guest_memfd()")
Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
---
 tools/testing/selftests/kvm/guest_memfd_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/guest_memfd_test.c b/tools/testing/selftests/kvm/guest_memfd_test.c
index ba0c8e9960358..ce687f8d248fc 100644
--- a/tools/testing/selftests/kvm/guest_memfd_test.c
+++ b/tools/testing/selftests/kvm/guest_memfd_test.c
@@ -134,7 +134,7 @@ static void test_create_guest_memfd_invalid(struct kvm_vm *vm)
 			    size);
 	}
 
-	for (flag = 0; flag; flag <<= 1) {
+	for (flag = BIT(0); flag; flag <<= 1) {
 		fd = __vm_create_guest_memfd(vm, page_size, flag);
 		TEST_ASSERT(fd == -1 && errno == EINVAL,
 			    "guest_memfd() with flag '0x%lx' should fail with EINVAL",
-- 
2.47.0


