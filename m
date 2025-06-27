Return-Path: <linux-kselftest+bounces-35956-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC37AEB29C
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 11:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C087AA3D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Jun 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B431E296169;
	Fri, 27 Jun 2025 09:18:11 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756C4293C78
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 09:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751015891; cv=none; b=S+PtobG3GysAdLWk8MU26j/D2bvatVqwZGeAbZeP4QfYRK3jybLZOgs4yyOiLss6ZR7ET9Poq19FE6iYJDlqQJzZeKdrrJ7TQPpJFQM/rMCDlzsftQCkKYLgXR6NDYsJz/NpwPYAnJpxUy9bUM3IGaVzir6XP8Cbe5iKKKo1PAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751015891; c=relaxed/simple;
	bh=Izm8MqI7uCMyrD97oNc/Jc+iWnkGXHI/bYDqMxEzfW4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p1lEHLFarJTPd0TRb2znEjWj+XZos+syNCwU4Kd3frnIpSBRfSO67mpYQoEIypFVrZ1ZkhVEUar5nrJgDKuPbPt+dDWBqtsuDdfPyEJeGGZEDcWZ9JDtpi/aVW7E2aohz2PYfXM49TYNBN2jw/QWsI3ZsaE7pDrS1ynCUoqkja0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 55R98Ta9013106
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Jun 2025 17:08:29 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 55R98EZA012876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 17:08:14 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Fri, 27 Jun 2025
 17:08:14 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To:
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>, <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>,
        Cynthia Huang <cynthia@andestech.com>
Subject: [PATCH v2] selftests: futex: define SYS_futex on 32-bit architectures with 64-bit time_t
Date: Fri, 27 Jun 2025 17:08:12 +0800
Message-ID: <20250627090812.937939-1-ben717@andestech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 55R98Ta9013106

glibc does not define SYS_futex for 32-bit architectures using 64-bit
time_t e.g. riscv32, therefore this test fails to compile since it does not
find SYS_futex in C library headers. Define SYS_futex as SYS_futex_time64
in this situation to ensure successful compilation and compatibility.

Signed-off-by: Cynthia Huang <cynthia@andestech.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
---
Changes since v1:
  - Fix the SOB chain

v1 : https://lore.kernel.org/all/20250527093536.3646143-1-ben717@andestech.com/
---
 tools/testing/selftests/futex/include/futextest.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..7a5fd1d5355e 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -47,6 +47,17 @@ typedef volatile u_int32_t futex_t;
 					 FUTEX_PRIVATE_FLAG)
 #endif

+/*
+ * SYS_futex is expected from system C library, in glibc some 32-bit
+ * architectures (e.g. RV32) are using 64-bit time_t, therefore it doesn't have
+ * SYS_futex defined but just SYS_futex_time64. Define SYS_futex as
+ * SYS_futex_time64 in this situation to ensure the compilation and the
+ * compatibility.
+ */
+#if !defined(SYS_futex) && defined(SYS_futex_time64)
+#define SYS_futex SYS_futex_time64
+#endif
+
 /**
  * futex() - SYS_futex syscall wrapper
  * @uaddr:	address of first futex
--
2.34.1

