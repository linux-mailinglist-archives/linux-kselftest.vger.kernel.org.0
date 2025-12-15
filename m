Return-Path: <linux-kselftest+bounces-47575-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F6CCBCC27
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 08:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A76143007EE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Dec 2025 07:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A123128AC;
	Mon, 15 Dec 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nv289lAK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F03430E82B;
	Mon, 15 Dec 2025 07:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765783580; cv=none; b=Ojjuesiw8yI4t/PvWQ6gz94b9hZLMXJcoaxa19Dni8d03zVQBHw5l4lhXOTNtEpjQdWHYScKGk3fa2ixzOesn9Dsy6qu9aUrDjaaswF5ovEvV5pGnC1yJyIxIgC6kcg8T/8kknB/fPOei96e8InmrbdxZ+10d7rUtUklc3Gxjsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765783580; c=relaxed/simple;
	bh=KXSd9MZrnFCunqVNIQVkaVq7EmYUIaCUSrg+xNneJIM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YSo6Rh828FEr17wC9UbsZalSthyiIWjO8DLbiQC364TF301HJhxO/8MGMsOADzxP+e1lNwccCJ3eyabOqfj0ZYxzYUa9sJu5FOR8Kdj8LReMWmlIB6G/Uzd4/iFc88ukca9S9O6YnbUBNmEGfeCqsZSMjwJ8n2oaE10mFKRrX/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nv289lAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73169C4CEF5;
	Mon, 15 Dec 2025 07:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765783580;
	bh=KXSd9MZrnFCunqVNIQVkaVq7EmYUIaCUSrg+xNneJIM=;
	h=From:To:Cc:Subject:Date:From;
	b=nv289lAKLjqyljikfpuKXAxIDklEiHkhXS4yKoPJ3ZWN3rHQDfd18llyYVMaiVOLe
	 J6KNVklGCTxap5DBH0MbmLMbPCAy03Zr1uJ83eulYahi744m2WEjYqwWXUfouoAciG
	 FsdNr5EQUl7EPPrQa9VhwfrHfr+2bniSUBnC9KGqy4wma4JmP2SHFF5OTDtZ6LbEWb
	 7Sgu0Gtt8CeuY4NGnsNEPxs89MYNGufD0kFRO8YfCDieuKX8+q/ursJQmqFGj2d1jH
	 qx9bEEUBCVpvhyiuSQNIczWgWriVlDI/jiZIvqMQUjKR//LVO81XZQq4pHkYPcPQog
	 gfZBZx5X4DZnw==
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	tzungbi@kernel.org
Subject: [PATCH v3] lkdtm: Add lockdep related crash tests
Date: Mon, 15 Dec 2025 07:25:39 +0000
Message-ID: <20251215072539.2580180-1-tzungbi@kernel.org>
X-Mailer: git-send-email 2.52.0.305.g3fc767764a-goog
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce various lockdep related crash tests.

Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>
---
v3:
- Add some entries in tools/testing/selftests/lkdtm/tests.txt.

v2: https://lore.kernel.org/all/20251117033337.3730681-1-tzungbi@kernel.org/
- Fix "warning: suggest braces around empty body in an 'else' statement [-Wempty-body]"
  reported by 0day test robot.

v1: https://lore.kernel.org/lkml/20251114062535.1827309-1-tzungbi@kernel.org/T/#u

 drivers/misc/lkdtm/Makefile             |  1 +
 drivers/misc/lkdtm/core.c               |  1 +
 drivers/misc/lkdtm/lkdtm.h              |  1 +
 drivers/misc/lkdtm/lockdep.c            | 98 +++++++++++++++++++++++++
 tools/testing/selftests/lkdtm/tests.txt |  8 ++
 5 files changed, 109 insertions(+)
 create mode 100644 drivers/misc/lkdtm/lockdep.c

diff --git a/drivers/misc/lkdtm/Makefile b/drivers/misc/lkdtm/Makefile
index 03ebe33185f9..830b71c8e6a0 100644
--- a/drivers/misc/lkdtm/Makefile
+++ b/drivers/misc/lkdtm/Makefile
@@ -11,6 +11,7 @@ lkdtm-$(CONFIG_LKDTM)		+= usercopy.o
 lkdtm-$(CONFIG_LKDTM)		+= kstack_erase.o
 lkdtm-$(CONFIG_LKDTM)		+= cfi.o
 lkdtm-$(CONFIG_LKDTM)		+= fortify.o
+lkdtm-$(CONFIG_LKDTM)		+= lockdep.o
 lkdtm-$(CONFIG_PPC_64S_HASH_MMU)	+= powerpc.o
 
 KASAN_SANITIZE_stackleak.o	:= n
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 5732fd59a227..43e91388940f 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -96,6 +96,7 @@ static const struct crashtype_category *crashtype_categories[] = {
 	&stackleak_crashtypes,
 	&cfi_crashtypes,
 	&fortify_crashtypes,
+	&lockdep_crashtypes,
 #ifdef CONFIG_PPC_64S_HASH_MMU
 	&powerpc_crashtypes,
 #endif
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 015e0484026b..d2d97e6f323e 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -84,6 +84,7 @@ extern struct crashtype_category usercopy_crashtypes;
 extern struct crashtype_category stackleak_crashtypes;
 extern struct crashtype_category cfi_crashtypes;
 extern struct crashtype_category fortify_crashtypes;
+extern struct crashtype_category lockdep_crashtypes;
 extern struct crashtype_category powerpc_crashtypes;
 
 /* Each category's init/exit routines. */
diff --git a/drivers/misc/lkdtm/lockdep.c b/drivers/misc/lkdtm/lockdep.c
new file mode 100644
index 000000000000..e029e9e60ce6
--- /dev/null
+++ b/drivers/misc/lkdtm/lockdep.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2025 Google LLC
+ *
+ * Tests related to lockdep warnings.
+ */
+#include "lkdtm.h"
+#include <linux/cleanup.h>
+#include <linux/irqflags.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/srcu.h>
+
+static DEFINE_SPINLOCK(lock_A);
+static DEFINE_SPINLOCK(lock_B);
+
+/* For "WARNING: possible circular locking dependency detected". */
+static void lkdtm_LOCKDEP_CIRCULAR_LOCK(void)
+{
+	scoped_guard(spinlock, &lock_A)
+		scoped_guard(spinlock, &lock_B) {}
+	scoped_guard(spinlock, &lock_B)
+		scoped_guard(spinlock, &lock_A) {}
+}
+
+/* For "WARNING: possible recursive locking detected". */
+static void lkdtm_LOCKDEP_RECURSIVE_LOCK(void)
+{
+	guard(spinlock)(&lock_A);
+	guard(spinlock)(&lock_A);
+}
+
+/* For "WARNING: inconsistent lock state". */
+static void lkdtm_LOCKDEP_INCONSISTENT_LOCK(void)
+{
+	lockdep_softirq_enter();
+	scoped_guard(spinlock, &lock_A) {}
+	lockdep_softirq_exit();
+
+	scoped_guard(spinlock, &lock_A) {}
+}
+
+/* For "WARNING: Nested lock was not taken". */
+static void lkdtm_LOCKDEP_NESTED_LOCK_NOT_HELD(void)
+{
+	spin_lock_nest_lock(&lock_B, &lock_A);
+}
+
+/* For "WARNING: bad unlock balance detected!". */
+static void lkdtm_LOCKDEP_BAD_UNLOCK_BALANCE(void)
+{
+	spin_unlock(&lock_A);
+}
+
+/* For "WARNING: held lock freed!". */
+static void lkdtm_LOCKDEP_HELD_LOCK_FREED(void)
+{
+	spin_lock(&lock_A);
+	spin_lock_init(&lock_A);
+}
+
+/* For "WARNING: lock held when returning to user space!". */
+static void lkdtm_LOCKDEP_HELD_LOCK(void)
+{
+	spin_lock(&lock_A);
+}
+
+/* For "WARNING: suspicious RCU usage". */
+static void lkdtm_LOCKDEP_SUSPICIOUS_RCU(void)
+{
+	struct srcu_struct srcu;
+	void __rcu *res = NULL;
+	int idx;
+
+	init_srcu_struct(&srcu);
+
+	idx = srcu_read_lock(&srcu);
+	rcu_dereference(res);
+	srcu_read_unlock(&srcu, idx);
+
+	cleanup_srcu_struct(&srcu);
+}
+
+static struct crashtype crashtypes[] = {
+	CRASHTYPE(LOCKDEP_CIRCULAR_LOCK),
+	CRASHTYPE(LOCKDEP_RECURSIVE_LOCK),
+	CRASHTYPE(LOCKDEP_INCONSISTENT_LOCK),
+	CRASHTYPE(LOCKDEP_NESTED_LOCK_NOT_HELD),
+	CRASHTYPE(LOCKDEP_BAD_UNLOCK_BALANCE),
+	CRASHTYPE(LOCKDEP_HELD_LOCK_FREED),
+	CRASHTYPE(LOCKDEP_HELD_LOCK),
+	CRASHTYPE(LOCKDEP_SUSPICIOUS_RCU),
+};
+
+struct crashtype_category lockdep_crashtypes = {
+	.crashtypes = crashtypes,
+	.len	    = ARRAY_SIZE(crashtypes),
+};
diff --git a/tools/testing/selftests/lkdtm/tests.txt b/tools/testing/selftests/lkdtm/tests.txt
index cff124c1eddd..7b32dece3d3a 100644
--- a/tools/testing/selftests/lkdtm/tests.txt
+++ b/tools/testing/selftests/lkdtm/tests.txt
@@ -83,3 +83,11 @@ FORTIFY_STR_MEMBER detected buffer overflow
 FORTIFY_MEM_OBJECT detected buffer overflow
 FORTIFY_MEM_MEMBER detected field-spanning write
 PPC_SLB_MULTIHIT Recovered
+#LOCKDEP_CIRCULAR_LOCK Lockdep can only trigger once
+#LOCKDEP_RECURSIVE_LOCK Hangs the system
+#LOCKDEP_INCONSISTENT_LOCK Lockdep can only trigger once
+#LOCKDEP_NESTED_LOCK_NOT_HELD Cause a deadlock in subsequent lockdep tests
+#LOCKDEP_BAD_UNLOCK_BALANCE Lockdep can only trigger once
+#LOCKDEP_HELD_LOCK_FREED Lockdep can only trigger once
+#LOCKDEP_HELD_LOCK Cause a deadlock in subsequent lockdep tests
+#LOCKDEP_SUSPICIOUS_RCU Lockdep can only trigger once
-- 
2.52.0.305.g3fc767764a-goog


