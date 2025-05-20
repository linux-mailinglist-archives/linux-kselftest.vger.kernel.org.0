Return-Path: <linux-kselftest+bounces-33434-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F97ABE52D
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 22:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78CC23B87EF
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 May 2025 20:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC48525E833;
	Tue, 20 May 2025 20:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cZR38tR2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06553217648;
	Tue, 20 May 2025 20:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747774168; cv=none; b=ex0to65TIm2SeZ/g2Fts/wOkRMl39vLtG+gOjEsJOVDQ2G3vAGgGH7dVqnaEFgODTPO2f+r4nktu3hg3nZIy25F/845PfPzfQQCqPemp/vKXtplevWmTNKP8ao4KkehocfGDhB1uP8KUE/vqE3iUjOUmf7SqfX5bBhyJ1KGv8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747774168; c=relaxed/simple;
	bh=1Te3gUCb3wx4Xfv+yeVdknw42AFZu1cU2lHKKErDv+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4YrPcN1jcT02tHMy8xpKTBtHViO+WWGdtqV+OFFZlkHSKgoze2qL5+Xb2BsTcHP4AG3Fu1pinrwdqfIIPhHg1+V077GL8oVHle4SajoFOroHxevxCe1YlEXo+0G6FZxtVD3DRU2BMWLnF0u7tT+J+n8Nkz6WzYQS0+zbmzKfe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cZR38tR2; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mf6hTPlKjBS7l4gbTn3lLHJV8+IbbJlPwtkPqOBsY2A=; b=cZR38tR2PGMJ6fuHp5OnXIrhkL
	Da6WdLw36Iyr1SLv/l6z38OD9FaWsxmAJ+vyLs3XUwV+PuVdtl1RVidjih4GoFS/p0zORgNGIXRwU
	AWstWgiZhAnN+dU8nzARhRJ08HF75HY4pcbvxwHZM7J2aN2Z6EUG9rGQ4Erpdyfo8NheRRE9MyJy0
	o/Sa7P+S8X/oEPeGqY0pdvLg0dq4I0vFtJ53JwNJQDA4TCY5KqVCYCebc3G5exOPYrVqRBUfHi+v9
	HPhDNPXek90J3T84gfNYmQzdnC5OscnDvHw1DRNJyH+6JNTfv6MN7lEiWkuMIh4stryur8tlH8cwL
	FSi/s+fw==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uHTto-00AsVE-Mx; Tue, 20 May 2025 22:49:20 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 20 May 2025 17:48:39 -0300
Subject: [PATCH v4 6/7] futex: Remove the limit of elements for
 sys_set_robust_list2 lists
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250520-tonyk-robust_futex-v4-6-1123093e59de@igalia.com>
References: <20250520-tonyk-robust_futex-v4-0-1123093e59de@igalia.com>
In-Reply-To: <20250520-tonyk-robust_futex-v4-0-1123093e59de@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, 
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
 kernel/futex/core.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 49b3bc592948a811f995017027f33ad8f285531f..61f0b48a2bcd8ab926754980ab3454b9ec13a344 100644
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
-			      struct robust_list_head __user *head)
+			      struct robust_list_head __user *head,
+			      bool destroyable)
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
@@ -1301,14 +1308,17 @@ static void exit_robust_list32(struct task_struct *curr,
 		}
 		if (rc)
 			return;
-		uentry = next_uentry;
-		entry = next_entry;
-		pi = next_pi;
 		/*
 		 * Avoid excessively long or circular lists:
 		 */
-		if (!--limit)
+		if (!destroyable && !--limit)
 			break;
+		else
+			put_user((struct robust_list __user *) &head->list, &entry->next);
+
+		uentry = next_uentry;
+		entry = next_entry;
+		pi = next_pi;
 
 		cond_resched();
 	}
@@ -1474,26 +1484,38 @@ static void exit_pi_state_list(struct task_struct *curr)
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
-	 * Walk through the linked list, parsing robust lists and freeing the
-	 * allocated lists
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


