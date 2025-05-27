Return-Path: <linux-kselftest+bounces-33843-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466DAC4BAF
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 11:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED73F7A0611
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 09:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5569922A4E2;
	Tue, 27 May 2025 09:43:40 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E5A242D79
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748339020; cv=none; b=ddkZzwBc3Q8X/Pnc3I9y+spJYvVGXwVJ1tvJYvKHdOESA16A/LUGQ0v8YUMRXRQigydZ96EuoeZwIHwf7TnI8iQ/04TGzU8n6yOOZvjVvIxAtIOVqe5z9S4iSuO2taLx2zAeWieHzrImidGqc7io8W8CeyO/n+cXEXS1OUCGQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748339020; c=relaxed/simple;
	bh=jf1Sif/8EOJ2zS9yNCRkbVUsWGn9SWm/3FhJjJi4h9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nnKH+4BrCeDynsuEhukn82et4338h7hdZRpfPqd8esP7i+xJOBCm670wJgB0hPNzQchh8uRnLdZnmtVMqcM2lgJmzAq7Z6jiModjGyxI6Z9s1488SJ9mEoxTNugsXCaCIBuFaZZlhsa7k7osvanX32nQb07KKv8TSRVuq1kpwmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from Atcsqr.andestech.com (localhost [127.0.0.2] (may be forged))
	by Atcsqr.andestech.com with ESMTP id 54R9Znm6060851
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 17:35:49 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 54R9ZbEc060798
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 May 2025 17:35:37 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Tue, 27 May 2025
 17:35:37 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To:
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>, <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <tim609@andestech.com>,
        Ben Zong-You Xie
	<ben717@andestech.com>,
        Cynthia Huang <cynthia@andestech.com>
Subject: [PATCH] selftests: futex: define SYS_futex on 32-bit architectures with 64-bit time_t
Date: Tue, 27 May 2025 17:35:36 +0800
Message-ID: <20250527093536.3646143-1-ben717@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 54R9Znm6060851

glibc does not define SYS_futex for 32-bit architectures using 64-bit
time_t e.g. riscv32, therefore this test fails to compile since it does not
find SYS_futex in C library headers. Define SYS_futex as SYS_futex_time64
in this situation to ensure successful compilation and compatibility.

Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Signed-off-by: Cynthia Huang <cynthia@andestech.com>
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


