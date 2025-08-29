Return-Path: <linux-kselftest+bounces-40300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2FAB3BDB4
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCA06A2063E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D539132145A;
	Fri, 29 Aug 2025 14:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="YZnJpRC5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.245.243.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B7B320398;
	Fri, 29 Aug 2025 14:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.245.243.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477733; cv=none; b=BBSDgm4LIUXqh71CVcgco/kP6+TvXpCWc0Co9D72co5yDKSnYLETnWYzPWl2sRKeEzGvBqqhvzWbFop3FLHh3Tw1TC4DuEPxUl4WcwQMDy/bYyfzc+opqAumTmF2g3281l1yR8ulncq9ay9Ylmni4zMPFp+CeFT0To2Tmos2jII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477733; c=relaxed/simple;
	bh=5xYildeBtV7+wKmq5h/GNncZ59x6c36yXdu5MireVXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4hljnZnBEAKTMCyxVMQkFASiILkDKDQ42ZEyZt2T1DDIBCEkNzq3cKRfC97C4zpJlLw/1WU5jF25cjcwSmB0px2QC1w3ohSOMvRkJQwa6eo/Pdrbximdta7YQuR/xaNMugyXJrj/8Nvw0c7C79fm5G3OlF/HPKJUrVg2kns4WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=YZnJpRC5; arc=none smtp.client-ip=44.245.243.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477732; x=1788013732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5flslzb4sgnNMOnM+YuL8Hxh+/X8C4hiTYYv7c42G1Q=;
  b=YZnJpRC5f9QYfZ7PAWASqgaf87d9h1ELHA5Ln1iYi2qRHAzKVfl+dJzy
   OEFmTv/54VrUQspJ2DNpEDX/uN/U4nEchIqAg8dUWtKdWiRiWYF8C9jsh
   4iH5C+5dxBEsuGtZI3VZRxcp2IQZKDbpXxxsYsyT5dW5tFXyAA91fhpEm
   q7S7EA6seuiVDZ4BFhmwg8BlqBvddrX8p0f4zuuvLMzbkXTpMwvcl+l+K
   7oiND7SkkmAB0gTBO3w0hOHKDkvv5WjyHc8BXknQDw4cDX7iN4gIIwHXP
   7Eql14ciBFdEr1xZ9iJPoMhS6S53mwvP5DhTh5r6RwRQg7zN6icOUPfk2
   w==;
X-CSE-ConnectionGUID: Rk/n2u2GS96YwiZFNeWTCg==
X-CSE-MsgGUID: /8jYBUzfSYOUof5FbHkazA==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="2045051"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-001.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:28:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:29827]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.92:2525] with esmtp (Farcaster)
 id 8dceb162-eff9-4e34-951c-c2310264cc4d; Fri, 29 Aug 2025 14:28:51 +0000 (UTC)
X-Farcaster-Flow-ID: 8dceb162-eff9-4e34-951c-c2310264cc4d
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:28:51 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:28:50 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	<kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 6/9] KVM: selftests: Add backtrace fallback
Date: Fri, 29 Aug 2025 14:25:50 +0000
Message-ID: <20250829142556.72577-7-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The backtrace() function is a GNU extension available in glibc but may
not be present in non-glibc libraries. KVM selftests use backtrace() for
error reporting and debugging.

Add conditional inclusion of execinfo.h only for glibc builds and
provide a weak stub implementation of backtrace() that returns 0 (stack
trace empty) for non-glibc systems.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kvm/lib/assert.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/lib/assert.c b/tools/testing/selftests/kvm/lib/assert.c
index b49690658..c9778dc6c 100644
--- a/tools/testing/selftests/kvm/lib/assert.c
+++ b/tools/testing/selftests/kvm/lib/assert.c
@@ -6,11 +6,19 @@
  */
 #include "test_util.h"
 
-#include <execinfo.h>
 #include <sys/syscall.h>
 
+#ifdef __GLIBC__
+#include <execinfo.h> /* backtrace */
+#endif
+
 #include "kselftest.h"
 
+int __attribute__((weak)) backtrace(void **buffer, int size)
+{
+	return 0;
+}
+
 /* Dumps the current stack trace to stderr. */
 static void __attribute__((noinline)) test_dump_stack(void);
 static void test_dump_stack(void)
-- 
2.47.3


