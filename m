Return-Path: <linux-kselftest+bounces-40299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D538B3BDB2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:29:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6637C178BF2
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4DE3218B5;
	Fri, 29 Aug 2025 14:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QAP8O/gg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B933218B4;
	Fri, 29 Aug 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477708; cv=none; b=CAXDeOxnpwJtton9Zb7hUI379OE9+cifT6dTthLlr19IiXPNtVpO6DZMCE9guvpOaJH5R6eppR9VZlDGx8ma2ECl7OoTKtb055SBLChN18UWSVE+lAZNy3L8ElKpTpbSD8LuhNAuqk3hbk5EdYjKaRnBAZKYMmXYJDYh17JbIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477708; c=relaxed/simple;
	bh=jQoNODhJkntIRL8QQO/nmH1rbHykg6p69ISU6D3zjdA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZgUaQT3014v703RY/qlsAaIrXupCeZz9Sq5nW4SHNXvUjGSvaBdDslHVE2k1T80w3VkjqNmMrQnnlhcelT24qw4qZyRVT5/WvEHvpzryypMZ2IYc3G/l5EotfsYiGw6YjZA3PJQsclB8qevdFZBrJtYGg6VMy9uNgopWBNCofw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QAP8O/gg; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477706; x=1788013706;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=V3eFOFcJHvRJU2jEADvRr3ffSJ58rGA/QlP6MbKkTJw=;
  b=QAP8O/ggTRFwOCAuXasK5A68OpfQsUnvv4UzF5StYbbivOj2NYFrzAhg
   i4wSP36V6sLvTnv/dngpkffxF9/MbTyvioGYUUXHsu6epOmTgg4DxoxLj
   bumCUHbSddIRQ95uy9WZNnyiLiOD0RFxV76pm8VQOnI22eRYL6RBstSGr
   O0/vzz7vB9xOz7MnFq9+C8u+kLSXqdKdT9dRnox1lE/5VT5/zYZF98q/3
   wxky4536JvOstxH/1kYrxvZSfeeArciCvY4IFtrxI4PUq2x/1dQSbnb/C
   AWrUcE0ch3qglYNi6s8xwfgHgUHLql25g3vgf7G8aPk1ur+BWdJ4P0Rxk
   g==;
X-CSE-ConnectionGUID: 6Ojez+tbTFeoeJQCgKeFjg==
X-CSE-MsgGUID: bdcNVm+pRsybDUWrs+g03Q==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1927464"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:28:26 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:42649]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.144:2525] with esmtp (Farcaster)
 id 0ede2df0-7149-4e4c-82c6-2b74806a27fc; Fri, 29 Aug 2025 14:28:26 +0000 (UTC)
X-Farcaster-Flow-ID: 0ede2df0-7149-4e4c-82c6-2b74806a27fc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:28:26 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:28:24 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 5/9] KVM: selftests: Prevent PAGE_SIZE redefinition on x86
Date: Fri, 29 Aug 2025 14:25:49 +0000
Message-ID: <20250829142556.72577-6-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250829142556.72577-1-aqibaf@amazon.com>
References: <20250829142556.72577-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA004.ant.amazon.com (10.13.139.68) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Prevent PAGE_SIZE redefinition warnings that can occur due to namespace
pollution from included headers.

Add an #ifndef directive before defining PAGE_SIZE to avoid redefinition
conflicts.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/include/x86/processor.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 2efb05c2f..3f93d1b4f 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -368,7 +368,9 @@ static inline unsigned int x86_model(unsigned int eax)
 #define PHYSICAL_PAGE_MASK      GENMASK_ULL(51, 12)
 
 #define PAGE_SHIFT		12
+#ifndef PAGE_SIZE
 #define PAGE_SIZE		(1ULL << PAGE_SHIFT)
+#endif
 #define PAGE_MASK		(~(PAGE_SIZE-1) & PHYSICAL_PAGE_MASK)
 
 #define HUGEPAGE_SHIFT(x)	(PAGE_SHIFT + (((x) - 1) * 9))
-- 
2.47.3


