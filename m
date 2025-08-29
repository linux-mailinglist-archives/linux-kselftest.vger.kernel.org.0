Return-Path: <linux-kselftest+bounces-40295-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E34A3B3BD8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 16:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5588E1617D7
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 14:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A9FB3203A9;
	Fri, 29 Aug 2025 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="KFEz5sdJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BB29E110;
	Fri, 29 Aug 2025 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477605; cv=none; b=G8LgcvoejVg1cKcTev3qMbt1BGsN0CIgXwkn0RN1r+3rzBdSreiinW9My+WDOajkhEyiAT1L3xpVGCd4VLVFUxmFan/ckXxUwEGd5+P3D+BHNjCRct6ShlC5qPzP1upl2oISznVo/0yvcVGnNlvw7A9LvxO9WWv7fDNTvjP3B+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477605; c=relaxed/simple;
	bh=iFPU0HmO64vVywW5BVEcQ20yR+WVfRKLA5xXSYp/Y7o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/NyWw/7OcVtNaAi/BQdMgD1KE8SCdX7teBsP2mbJbX2ACRPIg3bFVAnr0qcKkWCJ1oGYMiHTXJF/vbDf1osVXANU2SeN3WaXW1y1w12JMymdHcu4eXTKW9iuv9mLY+BTLQaa4CzNpZz6YU2ISnOhzgY3MOy0/Ws7n6j0fEIDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=KFEz5sdJ; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756477604; x=1788013604;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CBcd3l86glEqKVjmRZ8g6niN7tm/UMtN3UNtLRqWzXY=;
  b=KFEz5sdJEa7PQUXuWz2zWaFwERuUfIZrbFV4V0Tkhz+jwXmj1TIqrOqN
   LgMnFreuuyYXt1gU3lTRZ1q+jnhGaDllhpU3rucj44bzYQiMh/w5a0jWP
   A/H9rlJ8qLRAQFI/qu8t4Uuvyj0pCJcdxaPE/ZKS4CvFEmU2hKih8CEpj
   PSEw1ymUZ8fqkGViGkeetLnBbbFWeoB4G9gmwU3Qz6Q3zdhNsMbnI6KnR
   Ds2Q95gabeZKdT7L/ksOXfnKrLXz4uDovVhqfr1hOGNBsS5dgAyIZf5st
   OOzHN2XrUCWipLQJFKm914g36vCGnsr5APJuwmki9xptXNOn6R6Eqc5x6
   g==;
X-CSE-ConnectionGUID: 2V+5NFmxR/iXTWkiV0aEew==
X-CSE-MsgGUID: nxv9gPoFRfG9BQkjyld3Ag==
X-IronPort-AV: E=Sophos;i="6.18,221,1751241600"; 
   d="scan'208";a="1927367"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 14:26:42 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:4630]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.88:2525] with esmtp (Farcaster)
 id 6e300a94-20ab-4b89-9a75-b45e32f23903; Fri, 29 Aug 2025 14:26:42 +0000 (UTC)
X-Farcaster-Flow-ID: 6e300a94-20ab-4b89-9a75-b45e32f23903
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:26:42 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Fri, 29 Aug 2025 14:26:40 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, "Will
 Drewry" <wad@chromium.org>, Shuah Khan <shuah@kernel.org>, Christian Brauner
	<brauner@kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH 1/9] KVM: selftests: Add pidfd_open syscall number fallback
Date: Fri, 29 Aug 2025 14:25:45 +0000
Message-ID: <20250829142556.72577-2-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The kselftest-harness uses pidfd_open() for test timeout handling, but
non-glibc C library headers may not define this syscall number.

Add architecture-specific fallback definitions to pidfd.h, including
support for Alpha (544) and other architectures (434). Update
kselftest_harness.h to include pidfd.h for the syscall definitions.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/kselftest_harness.h | 1 +
 tools/testing/selftests/pidfd/pidfd.h       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 2925e47db..1dd3e5a1b 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -69,6 +69,7 @@
 #include <unistd.h>
 
 #include "kselftest.h"
+#include "pidfd/pidfd.h"
 
 #define TEST_TIMEOUT_DEFAULT 30
 
diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index f87993def..c373ff18e 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -45,8 +45,12 @@
 #endif
 
 #ifndef __NR_pidfd_open
+#ifdef __alpha__
+#define __NR_pidfd_open 544
+#else
 #define __NR_pidfd_open 434
 #endif
+#endif
 
 #ifndef __NR_pidfd_send_signal
 #define __NR_pidfd_send_signal 424
-- 
2.47.3


