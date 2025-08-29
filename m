Return-Path: <linux-kselftest+bounces-40296-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72D78B3BD90
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19065163F46
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DC43203AE;
	Fri, 29 Aug 2025 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Kgrp4vLi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C7A32039E;
	Fri, 29 Aug 2025 14:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477629; cv=none; b=sVM+DDylAoHVv4en8evrQ2+XEcaSuEszamnJgiP+B8hPSqO9p1oT8H1q2aGTKKOmNj8TBcqeSslbtYMxlgYi+b2XYeG8UoENIsnu6cXtw0mT8bOCVJzaKEG+BdSYs5RgWdjrwRD9LdAdUGTtz2L5RwL9ntz6zQY66Ci0ZXr6q0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477629; c=relaxed/simple;
	bh=45c7aOoMugCT34BB86u6Wsrfo0KiaPUsDD2kYQQm1co=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnkVU8XM858tBMtikZTJOfkGgpIiRLyHNyKb13Y3zNmzJo4rDCtHCAWx35u44rQyjJknkZWMMdxwlrItup5rrPKOpwJyr8pwlSXVmRCX7C5jmnLn4qEkyVS+1HC/ueeW/Fnmb9iFZrJpnOTXrG8gkWziT59Ty6h66TwN73l7Ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Kgrp4vLi; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477628; x=1788013628;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7ppU9t0QbYKZe/Oy8B/CUwnA5uXwTdR2UElV1XQQFH8=;
  b=Kgrp4vLiyDZOuT2z8RiLMJbC9pGvWrgq09MxWUpUGTlo4R1t6NR6//vJ
   emXI0NbXm2gzO/FIn5kb5mkFXVeLk2u6+T/G4vyRHJ8OL9xBnB739DvLJ
   hfcPOsySNYj4U8X5f+sH6vjw43UA1oxFWJS3znjPK9sBtSrr2NO8BQvxr
   ADrtQsSR/PAUryFFJfn6iE047YunjxodkdN4HDuitfV28bGcnW4XkR7cr
   Y5IeeBT3dt9158Lhf5idLV31uWEktAmY9bZeglgTptAhT6LwyVbvVo59i
   nDwUW6jPvzPpMeLOtpKm4fhZOxZRslQ9juPaUCfuzNlmfnYqbKTO3Grn/
   A==;
X-CSE-ConnectionGUID: Ful/5iCGRky6vhMWZjZI+w==
X-CSE-MsgGUID: 5fSx+Yr4TyW/V7Oeu935CA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2035837"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:27:06 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:35672]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id f2839b29-c636-47d2-8770-4aedfb1e295b; Fri, 29 Aug 2025 14:27:06 +0000 (UTC)
X-Farcaster-Flow-ID: f2839b29-c636-47d2-8770-4aedfb1e295b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:06 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:04 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 2/9] KVM: selftests: Add __packed attribute fallback
Date: Fri, 29 Aug 2025 14:25:46 +0000
Message-ID: <20250829142556.72577-3-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Kernel UAPI headers use __packed but don't provide the definition in
userspace builds.

Add a fallback definition matching the kernel's implementation. This
follows the same pattern used by BPF and SGX selftests.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 23a506d7e..7fae7f5e7 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -5,6 +5,10 @@
 #ifndef SELFTEST_KVM_UTIL_H
 #define SELFTEST_KVM_UTIL_H
 
+#ifndef __packed
+#define __packed __attribute__((__packed__))
+#endif
+
 #include "test_util.h"
 
 #include <linux/compiler.h>
-- 
2.47.3


