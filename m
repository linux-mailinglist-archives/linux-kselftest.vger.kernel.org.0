Return-Path: <linux-kselftest+bounces-47473-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA4BCB7C2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26A8A3044859
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8D83002B5;
	Fri, 12 Dec 2025 03:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="QqQ3t8OE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993402BDC33;
	Fri, 12 Dec 2025 03:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509940; cv=none; b=CMbn4W3GUiIAlXarOO6GrHkqeOkEL9TUMmpvB7d8EEMaSDjbuXlnnGXoE9XxzFGTnmoUFr02o+3vF3ElfckTHnMAsfPrtvuCn5cDcZCIKJv56LnzfmiONmxJyWNA81KFXKOcPhuYu9k8waFfbFBGwnowVtXh6uzWXwixcqh9yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509940; c=relaxed/simple;
	bh=rnpDRseKuu1oN8cp3YcqKaQfXZngEhiYuWq2pbqtt18=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=hBBMRxWpAwfV0EW822vDubBgSV8KDeYEDhl4Yooz1wxCRZO8Fmty1zrG5e1f+MueikDZKTd3xMpLRpJanKOZg9SlD+NTPNAiZ7uTDl5wNIUPvZe1Ji8tNB7Kqk66wQav1z4SDuM5wA5tYjwXRvkKmngvA/7LnKi5Z29XWPKQnyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=QqQ3t8OE; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509925;
	bh=t1EEodWpGoWnLWEjGc4KI0PlVkqXQi/P4R9mrlY7TsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QqQ3t8OECn3YJJlfe/idNW6IM0P/opHeUJZjyZe3fz7qlfoHkeHpXo4CwobfRft6S
	 omu0auBudUgGj7mC5KPxyqPsPo2YA6RmHBkq+bJ/EcsgGF9QVBVZMYTJepGQOvkTcS
	 yBF7metCq/RC/yH6nWegd2VY4i4CnUizhVUeG+jU=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 6550C291; Fri, 12 Dec 2025 11:25:21 +0800
X-QQ-mid: xmsmtpt1765509921tyekpd4jx
Message-ID: <tencent_FD541759D11337DCF8B2EBCE79435EF21706@qq.com>
X-QQ-XMAILINFO: NsQpel/Jbc8WVc6udj2FQ5rYW7aNg1fLRhgfjUiq26lolWIRdGhDwwv4VWoq7/
	 jIOt+q9kFAhManen0WnriHXYXfSk6tegRfh98AIEmGSoQVaqFylM01A7jUjJCVKfsIT3wTb/BHV+
	 0Rz6Zw35ULVauyB5LHvKo7MQX+Xt1jlvcR0BYGVu9aquzRRn5kRDPv/mA6lBeZFXc5F5RU11QqTn
	 hXZlvVZeD5PjPG5sDZ5bo6flizX9XyFEjVX5Bot2DTTAN0Sxj9TkpIobaR3KMBVCg20oM9mmAkaf
	 zueNjLFTr3rtcbuBQpnR5lT7QN9r4/lvSY3ikwrcKpUFYt6gNZLOZfRvsKzjvEkhx50Mkh1fd2pU
	 kTk9D3pq8qY7rIi37bK0+CcnMNYiK5BQW+2qIy4FWCw+7dwKC/t9sNmNx5ZSidS72mq6Augd60sj
	 zG4vOeUPRGG5u6mE96BEMhjt9pTlAlLNhP0g4dphBSMTbgSloaQGOfEDX8eTiJ25tsZDbShGMyVq
	 jQkOYPyP/040niqlLIqnOK4/powCvyv14/jfpQwxzXQ0H437iKaR8PojG3qO8tYL6P4/xRpGJ7NT
	 MnJ3HTzBBEcBtRUrl8/baUuNGNCmhkA4IZYJsiA083uyz0uaD2YaU0JPH6M0c14zr38kO1cXUpE/
	 Ex7Yc2izU1Ph3+S5BSzUqe2vxngcjx05ANbQehCeHDX2hvNyKx54OMYJfaL5DnC178k95dTARgI1
	 0wUdLjDRPTqepokD2gPCZ40AEsIluONnzx4OfzVVFWx+k9XkJgkohRUa4Cr2fFY5T0lUZOsI9n+C
	 RqIMFjxLVeaXjMVLXCnQcwCaoN6rtKm9NoLpHcUEKP8elGWgii3dJs/8/9PkPSAaSz4NEMju/QjW
	 FC9obwZfV3BgXltwDZEtdDm6T/lb59bvAS3SCibsPHxOk+xEJHJYN1iEg2HqjtbzU271clB0lI0b
	 P9y2UabTWqjL+GOkEZylgpEBAlVE1WuWQRaoKjO79ETfcCAGvEaLaKL9B5+dy/uTnNUh7nKafXK4
	 4vVpeBVON2cdL29xcJ7ZOj1PBCVNyZ7ZUtA1gRWP/PGLV8brpRp4pPM7uUnhAedJFqssQZoIAR+1
	 UKc4UnpqW1lGwVHgomsLuTpas9kD/TUwegA9Mj
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 4/5] selftests/futex: introduce the declaration of atomic_t from types.h
Date: Fri, 12 Dec 2025 11:25:19 +0800
X-OQ-MSGID: <20251212032519.1842463-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
References: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the header files specifically prepared for test programs
from the tools/include directory. And solve the problem that
atomic_read and atomic_set may not be safe in a multi - threaded
environment.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512112344.gsyPl2ag-lkp@intel.com/
---
 .../selftests/futex/functional/Makefile       |  2 +-
 .../testing/selftests/futex/include/atomic.h  | 25 +++++++++----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 490ace1f017e8..8589917a4b126 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -2,7 +2,7 @@
 PKG_CONFIG ?= pkg-config
 LIBNUMA_TEST = $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.16 > /dev/null 2>&1 && echo SUFFICIENT || echo NO")
 
-INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
+INCLUDES := -I../include -I../../ $(KHDR_INCLUDES) -I../../../../include
 CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 $(INCLUDES) $(KHDR_INCLUDES) -DLIBNUMA_VER_$(LIBNUMA_TEST)=1
 LDLIBS := -lpthread -lrt -lnuma
 
diff --git a/tools/testing/selftests/futex/include/atomic.h b/tools/testing/selftests/futex/include/atomic.h
index c0dccb1b966ba..b23e1a50949a7 100644
--- a/tools/testing/selftests/futex/include/atomic.h
+++ b/tools/testing/selftests/futex/include/atomic.h
@@ -18,9 +18,8 @@
 #ifndef _ATOMIC_H
 #define _ATOMIC_H
 
-typedef struct {
-	volatile int val;
-} atomic_t;
+#include <linux/types.h>
+#include <linux/compiler.h>
 
 #define ATOMIC_INITIALIZER { 0 }
 
@@ -30,36 +29,36 @@ typedef struct {
  * @oldval:	The expected value of the futex
  * @newval:	The new value to try and assign the futex
  *
- * Return the old value of addr->val.
+ * Return the old value of addr->counter.
  */
 static inline int
 atomic_cmpxchg(atomic_t *addr, int oldval, int newval)
 {
-	return __sync_val_compare_and_swap(&addr->val, oldval, newval);
+	return __sync_val_compare_and_swap(&addr->counter, oldval, newval);
 }
 
 /**
  * atomic_inc() - Atomic incrememnt
  * @addr:	Address of the variable to increment
  *
- * Return the new value of addr->val.
+ * Return the new value of addr->counter.
  */
 static inline int
 atomic_inc(atomic_t *addr)
 {
-	return __sync_add_and_fetch(&addr->val, 1);
+	return __sync_add_and_fetch(&addr->counter, 1);
 }
 
 /**
  * atomic_dec() - Atomic decrement
  * @addr:	Address of the variable to decrement
  *
- * Return the new value of addr-val.
+ * Return the new value of addr-counter.
  */
 static inline int
 atomic_dec(atomic_t *addr)
 {
-	return __sync_sub_and_fetch(&addr->val, 1);
+	return __sync_sub_and_fetch(&addr->counter, 1);
 }
 
 /**
@@ -67,12 +66,12 @@ atomic_dec(atomic_t *addr)
  * @addr:	Address of the variable to set
  * @newval:	New value for the atomic_t
  *
- * Return the new value of addr->val.
+ * Return the new value of addr->counter.
  */
 static inline int
 atomic_set(atomic_t *addr, int newval)
 {
-	addr->val = newval;
+	WRITE_ONCE(addr->counter, newval);
 	return newval;
 }
 
@@ -80,12 +79,12 @@ atomic_set(atomic_t *addr, int newval)
  * atomic_read() - Atomic read
  * @addr:	Address of the variable to read
  *
- * Return the value of addr->val.
+ * Return the value of addr->counter.
  */
 static inline int
 atomic_read(atomic_t *addr)
 {
-	return addr->val;
+	return READ_ONCE(addr->counter);
 }
 
 #endif
-- 
2.34.1


