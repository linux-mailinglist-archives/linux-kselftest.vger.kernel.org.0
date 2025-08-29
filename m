Return-Path: <linux-kselftest+bounces-40298-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D430B3BDAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37FD43BFC10
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAD3203B9;
	Fri, 29 Aug 2025 14:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EgQ+8Ff6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A951729E110;
	Fri, 29 Aug 2025 14:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477682; cv=none; b=NRF6y0I06tWrSw1n8ZM4qq6gU+9DoUg63ClaybHHBeX6uwQDsNCR6Es97q3BB/I46ycfe5Ydxd2a2ajbGhw03JlEpGSpYahVPqSHmuwjF8XMa2D/UJedf/H5PNkifYRZzZBU15ld9q/7gg8N7XNleooJlSEkE3bQmiI4rkCyDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477682; c=relaxed/simple;
	bh=aSGoFnFQ0ZBKPYFtEyjLzr+DV+s1lmNOa+QCBhXKlPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOkNisZkMRcpdwCVQi7ND0pPa+Zewc9/USrJwquIFrp1CCVip749CYxRb/Q5Tam09hBdd7ZR8aEvm+1KNFz6CGRMAslOTx0YE2XGwh3GHML5mJTmqYsckt9XNxyKll5DzQ1x4l37v+x4rmiG3ipaUfk4VHNffooekaX/Z23Xnzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EgQ+8Ff6; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477680; x=1788013680;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SrDvul6Y20T+lfkQmfSur3fHwO9mehvp95HPlsLgOXw=;
  b=EgQ+8Ff6sJh3jvxW3n++VJGJGdjIThGUs7R2SoWy/IzcYn9Vnv9zWOrn
   z+Zjq0mM2pKEgosT0d/Iop9vG0nK63C5N0of+CYQLMFdDPZtecirGm05j
   sYHYoFtg46NEqxavI+SN3clu4O9Ebz9Q1ZgBmKKCsU5QvxaZOX1aqDQha
   g3qKoj9m9nkiIYd/q0Q1dAIVeQr3ycAL4iD/Y8O3AELSQuQk49R5kJ4hc
   +llVG4cXY4gNxdyKEGnZLq7kHuRVCd5I6AjWM+gaXBvhAW+I0+jiSBQZY
   fiz8mD4b9xCW/3rBjIDavWy2bYo3NWOSiK/leRIyJYhpVuITJLZNg6XPv
   Q==;
X-CSE-ConnectionGUID: OUUng9rLR2Cp84oeRZ08Bw==
X-CSE-MsgGUID: yFjXuJCnRW+ZGIiu7kQrxA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2045020"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:27:58 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:52512]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.88:2525] with esmtp (Farcaster)
 id 0eb3ccb2-a05f-4e8e-8737-06363af62346; Fri, 29 Aug 2025 14:27:58 +0000 (UTC)
X-Farcaster-Flow-ID: 0eb3ccb2-a05f-4e8e-8737-06363af62346
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:57 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:55 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Shuah Khan <shuah@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kvm@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 4/9] selftests: kselftest: Add memfd_create syscall compatibility
Date: Fri, 29 Aug 2025 14:25:48 +0000
Message-ID: <20250829142556.72577-5-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D042UWA002.ant.amazon.com (10.13.139.17) To
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
index 5ce80303d..cb5209f6a 100644
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


