Return-Path: <linux-kselftest+bounces-36944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23767AFFF68
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08877487D7B
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Jul 2025 10:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D352D8DBE;
	Thu, 10 Jul 2025 10:37:56 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DDC246788
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Jul 2025 10:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752143876; cv=none; b=kTW8cT3UELvtmZz8WOHTtu1nsZP8uOB8rWl2hhhT43wSa1o3R+/FUWjP19opLIoYkSqYN/uVzpVkR0WdaffN+EWvnflHSWKe8eP/XKbrdc1E/uD52GCvE4KxtFbPEz+ycaYdYpxqIzFTyevbtbx2IXeJDiu8TaAgzgrJRN/QhtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752143876; c=relaxed/simple;
	bh=NydJ29IjgJTCURFL78kOCTvD7Ht2lS66ZjTpm2V2Wyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jlPa+dx9RV0ZKyczQMOnhcf1F428V98ti1+2Fwbbu34k1yCQBcC+fUWUf0TnLIrow4fU0iP5yjLHccwXMvQempbgv5O6lkCcU6JWKe6KbdTVPsSo19ZFDuG4UHILCSuOeWaQUJXm63t39MKlTXT1ZYjAaDENeZKhroe+5K6BsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 56AAaWfu094219
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Jul 2025 18:36:32 +0800 (+08)
	(envelope-from ben717@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS31.andestech.com
 (10.0.1.89) with Microsoft SMTP Server id 14.3.498.0; Thu, 10 Jul 2025
 18:36:32 +0800
From: Ben Zong-You Xie <ben717@andestech.com>
To:
CC: <tglx@linutronix.de>, <mingo@redhat.com>, <peterz@infradead.org>,
        <dvhart@infradead.org>, <dave@stgolabs.net>, <andrealmeid@igalia.com>,
        <shuah@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <tim609@andestech.com>,
        Cynthia Huang
	<cynthia@andestech.com>,
        Ben Zong-You Xie <ben717@andestech.com>,
        "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>
Subject: [PATCH v3] selftests: futex: define SYS_futex on 32-bit architectures with 64-bit time_t
Date: Thu, 10 Jul 2025 18:36:30 +0800
Message-ID: <20250710103630.3156130-1-ben717@andestech.com>
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
X-MAIL:Atcsqr.andestech.com 56AAaWfu094219

From: Cynthia Huang <cynthia@andestech.com>

Linux kernel does not provide sys_futex() on some 32-bit architectures
that do not support 32-bit time representations, such as riscv32.
As a result, glibc cannot define SYS_futex, causing compilation failures
in tests that rely on this syscall. Define SYS_futex as SYS_futex_time64
in such cases to ensure successful compilation and compatibility.

Signed-off-by: Cynthia Huang <cynthia@andestech.com>
Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes since v2:
  - Refine the commit message suggested by tglx
  - Attribute the authorship to Cynthia
  - Add the Reviewed-by tag from Muhammad

v2 : https://lore.kernel.org/all/20250627090812.937939-1-ben717@andestech.com/

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

