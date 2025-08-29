Return-Path: <linux-kselftest+bounces-40302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A52B3BDC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C81211CC32EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A2A322A0A;
	Fri, 29 Aug 2025 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="lVzyKy0h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B0321445;
	Fri, 29 Aug 2025 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.218.115.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477761; cv=none; b=UB+Z9UosjaVLhY2wW3nA3kjl/yUf58vJdIthC1pvAHpqBPPE0ZSx17TwxEpC00juD5KInU6YzppU5y1ytBylvJ7ZpSXHveCXrfrW0qePc7K9XqZt+hPGTNFHo/zu6D/6qFTUh8uAq/I/MjW01c1pX8AvXh8IPwzN6xZzEmFaR4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477761; c=relaxed/simple;
	bh=rU+fLxvTaRy7DwhjNz0lm5qjvvl5TYDWMqyZPyOWOb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGcbOmLV0Pyq38Mp6kDXCvaPT1vDLjTeJwU4f3Ica7ZdNFMRqPNAsnnswo26HwLHO5O8+aZ+wgu8PUax2NkSNnXxzEU2etH/domRRDpDwDfxfkev0wl9SrymK9hVzr7LXsSk2eFhUU3YDUv9Y0hhr+RhZknxKzNmrwe+c+IHy4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=lVzyKy0h; arc=none smtp.client-ip=34.218.115.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477759; x=1788013759;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EbM/0yOz9WDa95qPkBH7SGv+efQUpCt1bttW+4Uxv94=;
  b=lVzyKy0h+jqadhAhFYOYSNKQJP4P7vv/Zz6WqR7+iNqWVCXSAA+eIOMI
   jxC8xRmF7oUGTClWytykawxqPcqff4OZhmjyU1D/wO+uoKgUADOcD5SNV
   5bQlJmuemz6JtVmbuCKJr0NItjkAaZpfHdOZKUWU+u5UslfiNGqhjn89J
   B1IO4ORaXF8VOHe9X9X7PBOGaUWraldhWKFwwsm6Tjk2BvjbvFgresv/w
   X85o7UC88TrcxiKcUhaSVIg5xVEYo1RGPRQ57+OOa+PPfm+UsRLFBoQeN
   eOL4nXQkrnjKMPlKIxVDmgKrDpWDzFUKBUOiLcpcrOJUOYBrgQ9+xAR/9
   Q==;
X-CSE-ConnectionGUID: B+2KgsF+SHyihENIf4zlVg==
X-CSE-MsgGUID: m/x/hPVCRkCAVvHYEpnxaw==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1925993"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:29:17 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:63410]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.13:2525] with esmtp (Farcaster)
 id 947a7021-b2bf-4d75-9263-73008060534f; Fri, 29 Aug 2025 14:29:17 +0000 (UTC)
X-Farcaster-Flow-ID: 947a7021-b2bf-4d75-9263-73008060534f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:29:17 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:29:15 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Peter Zijlstra
	<peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
	<boqun.feng@gmail.com>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 7/9] rseq: selftests: Add non-glibc compatibility fixes
Date: Fri, 29 Aug 2025 14:25:51 +0000
Message-ID: <20250829142556.72577-8-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB002.ant.amazon.com (10.13.139.179) To
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


