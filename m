Return-Path: <linux-kselftest+bounces-40630-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F445B40B7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 19:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C61E7B2380
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A18B2DF12F;
	Tue,  2 Sep 2025 17:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="XCBW60TS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79718DB02;
	Tue,  2 Sep 2025 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832547; cv=none; b=SETGDSqjUPRGe0g6eKLUfNcIWmeLvQ6549Q/CtznH3nWEUc+CK9VUVx5HeH17+MESeWmbhJ98vliEUmuTPimOjWxRRqLwZyNqgC2Q77DPfleGZZcgLC/Ojc/ayvaLSr1rJNyI1mzeIiuxLY8m03QlFIGd3xbtmXvdn+3F8HrjBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832547; c=relaxed/simple;
	bh=ugkcA7r6kNBQjmtE83xEiGCVJ9e8AnYbjt9BMUnM9Ro=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfocGWmE4UP5/+ixSp8te2kYZwr8DbKP2Uj/M47Il0UpWYI7DQGA2P5p0U7SVlow9qV6llQRqYRebHYBsE0WIoKeGZ2x3DVgWSPCCKD2WKz511KX711VNCP6roSESiSVfWYWfI6i6JfwRiVMPQVntnJO/oVanMyFrIcSSlamJLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=XCBW60TS; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1756832545; x=1788368545;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4eN3H4gUTxiDGL0gbX6jPnbdGToINp5ex5FqH9wcFdw=;
  b=XCBW60TS7f2CfD6/S5dn2MZjzc1oxcz70RNz65p0sw0zGAZYXwXRs7Lz
   xRnbioltwWyK7tcgVoDCONHhMZ82RCTnWJJRYrqI8d5SnGScXY4EYTN+p
   pssYwjoHI5wAh4Pgz7IKmd1waEXiPpOFkEWxbS2CaJZppPouQRYv+xShN
   yNmlnA/zWnW//oEqs7RU4UToFoKmFi2962zo2t9sa8H39bynIafmm4POl
   B+SjyjYNkbz9jpJ4Ylokpre2BzgSCHaao/urXq2XnRQUjqYXagoAKQbin
   DcZWwRRnWxHYwlRH30OcILbgMHKMd+Lmst8pWw6kzRVKGQdw/ZRr7RYcY
   A==;
X-CSE-ConnectionGUID: dSkxISX+Sdilzx77kjCyDQ==
X-CSE-MsgGUID: L7iqPandRPqSLDZqEh+Itw==
X-IronPort-AV: E=Sophos;i="6.18,233,1751241600"; 
   d="scan'208";a="2115778"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 17:02:23 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33092]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.106:2525] with esmtp (Farcaster)
 id 070b649c-b5b4-4584-8a0a-426c4fca832f; Tue, 2 Sep 2025 17:02:23 +0000 (UTC)
X-Farcaster-Flow-ID: 070b649c-b5b4-4584-8a0a-426c4fca832f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.17;
 Tue, 2 Sep 2025 17:02:22 +0000
Received: from dev-dsk-aqibaf-1b-17060f52.eu-west-1.amazon.com (10.253.72.42)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Tue, 2 Sep 2025 17:02:21 +0000
From: Aqib Faruqui <aqibaf@amazon.com>
To: Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <nh-open-source@amazon.com>, <aqibaf@amazon.com>
Subject: [PATCH v2 1/7] selftests/pidfd: Add architecture-specific fallback definitions for pidfd_open
Date: Tue, 2 Sep 2025 17:01:38 +0000
Message-ID: <20250902170147.55583-2-aqibaf@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

The pidfd_open syscall number varies by architecture. Add fallback
definitions for Alpha (544) and other architectures (434) to ensure
compatibility with non-glibc C libraries that may not define these
syscall numbers.

Signed-off-by: Aqib Faruqui <aqibaf@amazon.com>
---
 tools/testing/selftests/pidfd/pidfd.h | 4 ++++
 1 file changed, 4 insertions(+)

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


