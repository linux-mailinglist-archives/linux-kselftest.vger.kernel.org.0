Return-Path: <linux-kselftest+bounces-40304-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB31BB3BDCF
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E9D3A87DC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FCD3203B2;
	Fri, 29 Aug 2025 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Wxw/cVHV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F1E1E2823;
	Fri, 29 Aug 2025 14:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477834; cv=none; b=dXahI3mfF9T3Tios/D3dJ0OXLbEglHLTeyzaELDitpYdgDnGyzPxG5bowFoRbuLAZ6hcKK7tBu07gUFiQVVt8P+VXxQLBy8GL4BjqIJY4ek8np3ahwfuDCsxVJz9u7oJwn13sAdJNErW+oiljWPB27gahzxERbtKEUeBV+NMC3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477834; c=relaxed/simple;
	bh=QobdhLlZNjl3QjlIX3rgbdoxLs2+ODRJC7JZyFR/2jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNlneTmL3OQsWsPfa70zXagdXHlQM/GMLkwoucf5n0vHqbbebrRaoJ4R4b9opdSAPTjuQiAW5rzMSKzXGEeaU9B9EKcPeHb7Q+Afrp24NYb1V9yN/seFMScHOpEi+Xlb1bQJXHxqbFQa2bFVe5GDzWj2vq+is7BoHkNfG6V6JvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Wxw/cVHV; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477833; x=1788013833;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=a5jwovR6cUtAAK5RNs9kUpvz4Sb+WrBMm5wfVaSNJno=;
  b=Wxw/cVHVl7Aiy0A7xb1CWjJgqRSN8l46ZjRizhpMtDu4PZOLQKA8XSr7
   IL8hmuK2gcuOkiEDi4dcQ7Q7Z97aUmJNxygHY7DQMt6Jk8DBRjVFjaTxU
   FspKs5eHM01/+/wDSOdKRgiBfQRAECROnm1CdN/TGQ4tsi3R51APt1aoI
   M2psUG3rP5COblXbICQAgYDDiSfTaBXaEmUI9/fskPI2bgwmNZmHFrVcV
   dqT80lmK9g4fLru3fCdWsiWMC/oqPdku2MCjgn9Bh/0R6AZMsK1mgJR3d
   AzXWfS3DogXcFIlxIHVC1YG6O0GGzV56fhEGIZZ0qYMRXGNKpwUSQZxir
   w==;
X-CSE-ConnectionGUID: ohE/63QHQKiaGt8zE6e3qA==
X-CSE-MsgGUID: JY8oAtOeTwSh1DgIDWZR3A==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1926273"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:30:30 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:48703]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.19:2525] with esmtp (Farcaster)
 id 013b6866-e744-4603-9cb2-3cd92c1192d2; Fri, 29 Aug 2025 14:30:29 +0000 (UTC)
X-Farcaster-Flow-ID: 013b6866-e744-4603-9cb2-3cd92c1192d2
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:30:29 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:30:28 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 9/9] selftests: kselftest: Add ulong typedef for non-glibc compatibility
Date: Fri, 29 Aug 2025 14:25:53 +0000
Message-ID: <20250829142556.72577-10-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Some C libraries may not define the ulong typedef that is commonly
available as a BSD/GNU extension. Add a fallback typedef to ensure ulong
is available across all selftest environments.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index f362c6766..a1088a2af 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -58,6 +58,11 @@
 #include <stdio.h>
 #include <sys/utsname.h>
 #include <sys/syscall.h>
+#include <sys/types.h>
+#endif
+
+#ifndef ulong
+typedef unsigned long ulong;
 #endif
 
 #ifndef ARRAY_SIZE
-- 
2.47.3


