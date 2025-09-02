Return-Path: <linux-kselftest+bounces-40634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD60B40B87
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88EED1B62554
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC902E11B8;
	Tue,  2 Sep 2025 17:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="fW11kl93"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.13.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F712DE1E3;
	Tue,  2 Sep 2025 17:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.13.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832671; cv=none; b=PPEPlpuKOvSpOkKUYxMLkAtP4e6ykTSr1OOyYCOlNX0n5W2eaByTBsrew3RMETDr7bfo2+nKQ/ILImKiEpX1uP+rd4VKmCRGFVPIK534K8tXLvvbgST3zdsvRrX9/6LbD50fIeRD9ityubcHL3Yykc7WlLjEpCBk4HOlfNGVSrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832671; c=relaxed/simple;
	bh=rU+fLxvTaRy7DwhjNz0lm5qjvvl5TYDWMqyZPyOWOb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IIt4nRMlwbf4vyRBYqxFdX9mzNkAoRqktAokYIqC+Dek/J1ZBwb+QqOGC0iRqDebF48lk7EMuNZeXPq9HY4aQoiViKRRQNOeGhfKp4V66YZVzpd9Z8VDipPEPDIF+ykHxoz2gOd81MD5B5bNxml/Zv/CarHkrodh0S86r3g58c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=fW11kl93; arc=none smtp.client-ip=52.13.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832670; x=1788368670;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbM/0yOz9WDa95qPkBH7SGv+efQUpCt1bttW+4Uxv94=;
  b=fW11kl93qJgWESeNJCEqV4+iTFiSAuUiePdiKroNHQTANVRsvkKaQ8Ms
   cxBw8CUlz0DNjFT010/2TbrHw8HWvSwGEd8qQyRzafIL8lRR5U+/9r9+n
   HhEiN1APNrWPXoVHVvLfJQlkrWFd2prwhE5QQPFp/c0k7eJCVSFwelXma
   dae6XbvYMcsSU4Hi84kruqvy0sEyckYHnyOIzVVN0U2/z2JggeCrq4Il7
   GpSS5lP49uKFVmCpjf3C9lHT6c//klhIcEzDH03B9xvtJvSX8ay77DMTo
   G8+2Dd1N8tvgJAH8n+f97edYR2OOG/reAq8gcgp491CcHOf105rJlZ5TW
   w==;
X-CSE-ConnectionGUID: 7fU8GG6uQB6+JVmgZOY2iA==
X-CSE-MsgGUID: rsTY48ZdRVWSSkQ7KbWwNQ==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2231007"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-005.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:04:27 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33529]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id 160f2fe7-b49e-4ec3-bfa4-8df325412cf5; Tue, 2 Sep 2025 17:04:27 +0000 (UTC)
X-Farcaster-Flow-ID: 160f2fe7-b49e-4ec3-bfa4-8df325412cf5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:04:27 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:04:25 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 5/7] rseq: selftests: Add non-glibc compatibility fixes
Date: Tue, 2 Sep 2025 17:01:42 +0000
Message-ID: <20250902170147.55583-6-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The rseq selftests rely on features provided by glibc that may not be
available in non-glibc C libraries:

1. The __GNU_PREREQ macro and glibc's thread pointer implementation are
   not available in non-glibc libraries
2. The __NR_rseq syscall number may not be defined in non-glibc headers

Add a fallback thread pointer implementation for non-glibc systems using
the pre-existing inline assembly to access thread-local storage directly
via %fs/%gs registers. Also provide a fallback definition for __NR_rseq
when not already defined by the C library headers: 527 for alpha and 293
for other architectures.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 .../selftests/rseq/rseq-x86-thread-pointer.h       | 14 ++++++++++++++
 tools/testing/selftests/rseq/rseq.c                |  8 ++++++++
 2 files changed, 22 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h b/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
index d3133587d..a7c402926 100644
--- a/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
+++ b/tools/testing/selftests/rseq/rseq-x86-thread-pointer.h
@@ -14,6 +14,7 @@
 extern "C" {
 #endif
 
+#ifdef __GLIBC__
 #if __GNUC_PREREQ (11, 1)
 static inline void *rseq_thread_pointer(void)
 {
@@ -32,6 +33,19 @@ static inline void *rseq_thread_pointer(void)
 	return __result;
 }
 #endif /* !GCC 11 */
+#else
+static inline void *rseq_thread_pointer(void)
+{
+	void *__result;
+
+# ifdef __x86_64__
+	__asm__ ("mov %%fs:0, %0" : "=r" (__result));
+# else
+	__asm__ ("mov %%gs:0, %0" : "=r" (__result));
+# endif
+	return __result;
+}
+#endif /* !__GLIBC__ */
 
 #ifdef __cplusplus
 }
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 663a9cef1..1a6f73c98 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -36,6 +36,14 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
+#ifndef __NR_rseq
+#ifdef __alpha__
+#define __NR_rseq 527
+#else
+#define __NR_rseq 293
+#endif
+#endif
+
 /*
  * Define weak versions to play nice with binaries that are statically linked
  * against a libc that doesn't support registering its own rseq.
-- 
2.47.3


