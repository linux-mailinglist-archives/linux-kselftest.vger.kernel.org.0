Return-Path: <linux-kselftest+bounces-35878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 007BDAEA42B
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5356A3AA900
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78912EE5FE;
	Thu, 26 Jun 2025 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HXXp8UdS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12922EE5EF;
	Thu, 26 Jun 2025 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957994; cv=none; b=LKzfqJOdaX7NnTk3y8FFTbSRAGtZer1yyAMXnP9Re7sfSXCa3Lhpqj4d7/s/BFeRBbMcVSnU+T9wBYDPFbybvlmOlDYqvO+xIG2PXQAFP0hfrJ+kuh2t4a9R3NPrnlL4mBW3w5oM5e/nGEdJ4M5HczOlFOsq3ELLx2j/7hUWtP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957994; c=relaxed/simple;
	bh=L+yDCa4YX7Kzh7XaudDcK5zKNCQHWJnIOk24dS5deLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jnmcJc6ZJaiogq+joTuxVJX99SM4xx52yeA0XXXzozSM4wKtvy9ovG5kw09qBo+DD6gFQxG5Y3r+V/T00v8BcXeQbvy/0pP7qeWpn2vD2MLVGb+nXgHBDdV5HnAYJNGAxLipmZ0zQUk3JM0JCc1aqzzU5PDjy2droKkK76OLtKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HXXp8UdS; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qs2vETcoHAY6vX820qt2WOjLKOQBnsAu6xn0RHkzj+Q=; b=HXXp8UdSOrobfyUMbHJAKyrwTn
	VFW6UC69aRzKkHJ2zhCP2KNTanFJckjzunG+kbPQSQNJ2DAlinI1/CX44b3VpGPEosuQL7lnMJCMZ
	rmgbxtHLUmXKzDFnPWJE2e0tdczvVTJXe2xOGW/eDDU/H/TN2krAkGUkSGcaQ8HI06FxzTva949Wn
	3ZP3tpdPs56yv5Qy93JE+ivgYMlzIIBcMWBTCKj0jcwr7kVE5n1JRxYwV2Z3NBejBdJOmSOeGCdLx
	LndjC5qrXaHInRLFmCLSlyoBxyV86VO6mU0BgVaTUGFZq5xRljXVlFXUZ/CBAPiCqOwg+vinNcPaq
	CLhylgOA==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9u-009491-QI; Thu, 26 Jun 2025 19:13:11 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 26 Jun 2025 14:11:29 -0300
Subject: [PATCH v5 5/7] futex: Remove the limit of elements for
 sys_set_robust_list2 lists
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-tonyk-robust_futex-v5-5-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
In-Reply-To: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Remove the limit of ROBUST_LIST_LIMIT elements that a robust list can
have, for the ones created with the new interface. This is done by
overwritten the list as it's proceeded in a way that we avoid circular
lists.

For the old interface, we keep the limited behavior to avoid changing
the API.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 kernel/futex/core.c | 37 +++++++++++++++++++++++++++++--------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 1049f8ef3ce3c611b3be0ca12df34a98f710121d..942b66facdea16cd7be2235d95c2bbbae8d7cc63 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -1152,7 +1152,8 @@ static inline int fetch_robust_entry(struct robust_list __user **entry,
  * We silently return on any sign of list-walking problem.
  */
 static void exit_robust_list64(struct task_struct *curr,
-			       struct robust_list_head __user *head)
+			       struct robust_list_head __user *head,
+			       bool destroyable)
 {
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
@@ -1196,13 +1197,17 @@ static void exit_robust_list64(struct task_struct *curr,
 		}
 		if (rc)
 			return;
-		entry = next_entry;
-		pi = next_pi;
+
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
-		if (!--limit)
+		if (!destroyable && !--limit)
 			break;
+		else
+			put_user(&head->list, &entry->next);
+
+		entry = next_entry;
+		pi = next_pi;
 
 		cond_resched();
 	}
@@ -1214,7 +1219,8 @@ static void exit_robust_list64(struct task_struct *curr,
 }
 #else
 static void exit_robust_list64(struct task_struct *curr,
-			       struct robust_list_head __user *head)
+			       struct robust_list_head __user *head,
+			       bool destroyable)
 {
 	pr_warn("32bit kernel should not allow ROBUST_LIST_64BIT");
 }
@@ -1252,7 +1258,8 @@ fetch_robust_entry32(u32 *uentry, struct robust_list __user **entry,
  * We silently return on any sign of list-walking problem.
  */
 static void exit_robust_list32(struct task_struct *curr,
-			       struct robust_list_head32 __user *head)
+			       struct robust_list_head32 __user *head,
+			       bool destroyable)
 {
 	struct robust_list __user *entry, *next_entry, *pending;
 	unsigned int limit = ROBUST_LIST_LIMIT, pi, pip;
@@ -1474,10 +1481,19 @@ static void exit_pi_state_list(struct task_struct *curr)
 static inline void exit_pi_state_list(struct task_struct *curr) { }
 #endif
 
+/*
+ * futex_cleanup - After the task exists, process the robust lists
+ *
+ * Walk through the linked list, parsing robust lists and freeing the
+ * allocated lists. Lists created with the set_robust_list2 don't have a limit
+ * for sizing and can be destroyed while we walk on it to avoid circular list.
+ */
 static void futex_cleanup(struct task_struct *tsk)
 {
 	struct robust_list2_entry *curr, *n;
 	struct list_head *list2 = &tsk->robust_list2;
+	bool destroyable = true;
+	int i = 0;
 
 	/*
 	 * Walk through the linked list, parsing robust lists and freeing the
@@ -1485,15 +1501,20 @@ static void futex_cleanup(struct task_struct *tsk)
 	 */
 	if (unlikely(!list_empty(list2))) {
 		list_for_each_entry_safe(curr, n, list2, list) {
+			destroyable = true;
+			if (tsk->robust_list_index == i)
+				destroyable = false;
+
 			if (curr->head != NULL) {
 				if (curr->list_type == ROBUST_LIST_64BIT)
-					exit_robust_list64(tsk, curr->head);
+					exit_robust_list64(tsk, curr->head, destroyable);
 				else if (curr->list_type == ROBUST_LIST_32BIT)
-					exit_robust_list32(tsk, curr->head);
+					exit_robust_list32(tsk, curr->head, destroyable);
 				curr->head = NULL;
 			}
 			list_del_init(&curr->list);
 			kfree(curr);
+			i++;
 		}
 	}
 

-- 
2.49.0


