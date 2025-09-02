Return-Path: <linux-kselftest+bounces-40632-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DEAB40B80
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D601B622C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F16E2EB5DA;
	Tue,  2 Sep 2025 17:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="s2i64Gvm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718F32DE1E3;
	Tue,  2 Sep 2025 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832601; cv=none; b=tUUWlb5yd2aJQDtyMpNe21Zdv/C3S/Y+yLC7AScpHA0P4beBN9xGg0wo1ETvs8fTnvqcVB/aTgNIYkVxLAvrJA0RcxdiwHo1ARgwBIg9+/Qn7WLkY3ejbaK3errx2t33gkm5gZjEQo4TKFnslhqDkmPVaJrU+5cmlT8sk9lV+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832601; c=relaxed/simple;
	bh=GAzUTkg2t0FKlEtMspkbfVsM9F/3ShzZcYlzXEpJ3Aw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxZWWh40BjZhuhs5PcZgRSmqTYGpYRVuPLIVmg0Nw4DqrC2dyunIyi10CmfwTszkCYscdWimNypRkotTCVBRHgUOj6SJy/ZMbqrDt70VNWbDd5IifQT410FP5hL+3URqKFEUKdtAqbckfsaZL3Ey3cZBtpiSOu+B6N3atBMGbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=s2i64Gvm; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832599; x=1788368599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hnWWntazb36HQ0Hxk/LBzvzq1USYr0PJXvk2r6jX0Og=;
  b=s2i64Gvm/vyhERRv/0CycJ+7HNT4ohSBGhdKva70qI9R+vJMP9SNljfz
   QjKWlVKwq/VR32nAyM02lBfLh88xFtB8B+lQeM/PGHcBxy7aLMcHCFTJu
   wlFZ5vWxOenVR9vbVXTa9kvT/YyIXv6kTHPLDx/pHIKiEwsV7+u2rqwqJ
   AuJPsOoaO2+4e6yWy+5+XiDdfrtW9jeucKlCSdexwkWJ0S41aDMIyFJIv
   hV5fdvxcZ40UpIMhpOUO/Bjjp+kGQDAEmn3MKytvvdswsjTtRovxMe/Wa
   avqv/PE1ccvkpf4wNtxSOLCHDER9tzhbRuyj3wYMp+0wCiLvEZy+ms+ob
   Q==;
X-CSE-ConnectionGUID: Oe/kozayQSy9Gb6A2612xA==
X-CSE-MsgGUID: +0sjVJkNTIW4zFgCbtTChg==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2116380"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:03:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:17666]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.48:2525] with esmtp (Farcaster)
 id 9e68ad25-9ae0-4f99-93ee-e38e2e170ca3; Tue, 2 Sep 2025 17:03:17 +0000 (UTC)
X-Farcaster-Flow-ID: 9e68ad25-9ae0-4f99-93ee-e38e2e170ca3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:03:16 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:03:14 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 3/7] selftests: kselftest: Add memfd_create syscall compatibility
Date: Tue, 2 Sep 2025 17:01:40 +0000
Message-ID: <20250902170147.55583-4-aqibaf@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250902170147.55583-1-aqibaf@amazon.com>
References: <20250902170147.55583-1-aqibaf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA003.ant.amazon.com (10.13.139.46) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The memfd_create function and related MFD_* flags may not be available
in non-glibc C libraries. Some selftests use memfd_create for
memory backing operations.

Add fallback definitions for MFD_CLOEXEC and MFD_HUGETLB flags, and
provide a memfd_create wrapper.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest.h        | 19 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c |  1 +
 2 files changed, 20 insertions(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index c3b6d2604..f362c6766 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -57,6 +57,7 @@
 #include <string.h>
 #include <stdio.h>
 #include <sys/utsname.h>
+#include <sys/syscall.h>
 #endif
 
 #ifndef ARRAY_SIZE
@@ -80,6 +81,24 @@
 #endif
 #endif /* end arch */
 
+#ifndef MFD_CLOEXEC
+#define MFD_CLOEXEC 0x0001U
+#endif
+
+#ifndef MFD_HUGETLB
+#define MFD_HUGETLB 0x0004U
+#endif
+
+static inline int memfd_create(const char *name, unsigned int flags)
+{
+#ifdef __NR_memfd_create
+	return syscall(__NR_memfd_create, name, flags);
+#else
+	errno = ENOSYS;
+	return -1;
+#endif
+}
+
 /* define kselftest exit codes */
 #define KSFT_PASS  0
 #define KSFT_FAIL  1
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0..a78b64117 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -15,6 +15,7 @@
 #include <sys/resource.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/syscall.h>
 #include <unistd.h>
 #include <linux/kernel.h>
 
-- 
2.47.3


