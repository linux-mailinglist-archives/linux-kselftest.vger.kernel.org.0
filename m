Return-Path: <linux-kselftest+bounces-40297-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF8B3BDA3
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3EA7BC202
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AC3218D4;
	Fri, 29 Aug 2025 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="doxBPOWs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAAE321444;
	Fri, 29 Aug 2025 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477656; cv=none; b=nri02Tgzj5zG3RGJhbI/kKMOHmOC6UBuEg6ilPyEUF5MD56OqlVZZipWDychx5e5K/LhemKv0hynFigg4cAhAi1SQ7MK6RX46MoNx/BvhWVeblVnj8c1Tm4aQhjHYkkELn69oY7//xJD3rwjtK5sF3rfWLbHHmBPcTSP0bJwPZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477656; c=relaxed/simple;
	bh=y9gL/UGvJfVzOPZZ/KT87SlBY/VScKVrmeHHSQs3I3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QN2MnReAbpLCXn2eDpr4a2n4o2yTIaNV7422TdOGEPwlbKCQzf79aTdQG6gZzBoqvaqLU2lM6sh6YQt4yqr2yJ8Kuy1iWi6b0tPoY301B8HLOpZWrx53q2T7NiH/mC6uV8PkC0vTQi6NqW44K/KcnlGpIl28szb85N90oL3mrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=doxBPOWs; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477655; x=1788013655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0qBLhzlQ0K0cOHPaZz1B5AlYgKIDArcMpwFYu5ZedWI=;
  b=doxBPOWsHv2LsvnnUwlAwK6cJE9had0cfgnvi5uHH0wc1LuPYkbAXaLU
   VgwrSt7A/S8H9mHPWPvgANdOLb5jlhktrIu6qgDun9OX0wm5n/zjsjKI+
   cJSI6TWQEy7elvW1LDN2WlSWrISNxb8fNS4quZ1KxevaZmlrbDhVWRjON
   W28prRbxxuDOOYw272mG0J+d6FLRgwMIHxrO+2JFR9NRFSUqzuGwprEzT
   iIU5O4IuMEHgaFXc9k919+LCuS5YhdY7uIUpDcFPXKzTi4BwI5qp/6qqs
   hwmdeySj06Fz3INP3gqqaYV1ywt0hMHylfQgPLI9SLrGhGXuXdL6yoC2N
   A==;
X-CSE-ConnectionGUID: 5sLIGh9OT4CF7z/7qI9oNA==
X-CSE-MsgGUID: vGYmQyhZRmCdw21oRGSVWw==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1927937"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:27:33 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:52600]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.56:2525] with esmtp (Farcaster)
 id 9bde94d1-7135-4966-972f-6c1896eb93bc; Fri, 29 Aug 2025 14:27:32 +0000 (UTC)
X-Farcaster-Flow-ID: 9bde94d1-7135-4966-972f-6c1896eb93bc
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:32 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:27:31 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 3/9] KVM: selftests: Add pthread_attr_setaffinity_np fallback
Date: Fri, 29 Aug 2025 14:25:47 +0000
Message-ID: <20250829142556.72577-4-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA001.ant.amazon.com (10.13.139.110) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The pthread_attr_setaffinity_np function is a GNU extension that may not
be available in non-glibc C libraries. Some KVM selftests use this
function for CPU affinity control.

Add a function declaration and weak stub implementation for non-glibc
builds. This allows tests to build, with the affinity setting being a
no-op and errno set for the caller when the actual function is not available.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/include/kvm_util.h |  4 ++++
 tools/testing/selftests/kvm/lib/kvm_util.c     | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 7fae7f5e7..8177178b5 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -31,6 +31,10 @@
 #include "kvm_util_types.h"
 #include "sparsebit.h"
 
+#ifndef __GLIBC__
+int pthread_attr_setaffinity_np(pthread_attr_t *attr, size_t cpusetsize, const cpu_set_t *cpuset);
+#endif /* __GLIBC__ */
+
 #define KVM_DEV_PATH "/dev/kvm"
 #define KVM_MAX_VCPUS 512
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index c3f5142b0..5ce80303d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -20,6 +20,17 @@
 
 #define KVM_UTIL_MIN_PFN	2
 
+#ifndef __GLIBC__
+int __attribute__((weak))
+pthread_attr_setaffinity_np(pthread_attr_t *__attr,
+				size_t __cpusetsize,
+				const cpu_set_t *__cpuset)
+{
+	errno = ENOSYS;
+	return -1;
+}
+#endif
+
 uint32_t guest_random_seed;
 struct guest_random_state guest_rng;
 static uint32_t last_guest_seed;
-- 
2.47.3


