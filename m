Return-Path: <linux-kselftest+bounces-6817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968FF890F8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 01:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49C7828D24C
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Mar 2024 00:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEDB42AAE;
	Fri, 29 Mar 2024 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Af/do5db"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF59814F78;
	Fri, 29 Mar 2024 00:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671869; cv=none; b=AyBO4dUbplZOciOfmYEY5xeZDmI2OilW+BclMMiv5LUZ9zwesaYjk3pNry2tz7KkcTzQxzuXt+vtlJlJL4GtuZP9U9wDs5sVG1L5t9L5VcyUy5M0pajWpvUWU4l7MuVPfaVf66jbfHBUQNu3zuJGg3+1FC9XP/jwTJ0yU4gUKLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671869; c=relaxed/simple;
	bh=AE6NXINBH8omVPz1fHj5ljdzuytgTwzlTVzo/ubdiPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lMMMyMJdcn8vb4OlVxN21NHu5vrtY6EmMVTDWpi88/vxV9M1BbmMcc/XofUXmuusVFUjI6lnGlH/hbc6JTOCo/K5jTauYks5BKZG7XFooDsBFnero7XzTtmpLMGGhPXCQhPwH+YMGFCdihADXZ4FqlytAIcgSfs/lFoPwyKszb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Af/do5db; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=4IcsQqwJDSOpJrs7K0nnQqbkT6O6ZHWNLrwUIQFYjxY=; b=Af/do5dblRI/3DvQ6kE/CYWe72
	K4QeVRYC59m8ZY19UCuar28Z5RODgKIfBXNnzjaDcOfxtRSGqvjPuc3Uh3LCZi5VOdV5lqk78tdR6
	8xEVIX2ASUCeu6WQ/0xnjKSLOTaQZtIrrHdmf3mRD3jH2Ov4VFx5/P9A2BP9P6aBJMJ98Lie9alkx
	0tfEG6IrS/X4RaJkWi86K25kiCN9i78rwJyKeUaNPnVty2D6L6gWjYVwtG7StqbkVhQQT9kGUJc1X
	RpxcnD+EnOH/BPh0GzgBu6ZQl9eRnuR00mZikEz7a1DQTz946JKSyRkj2qKen241YRcjpkDfOXc6k
	2B22s2KQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rpzlP-000iik-1Z;
	Thu, 28 Mar 2024 19:06:31 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v3 16/30] ntsync: Introduce alertable waits.
Date: Thu, 28 Mar 2024 19:06:07 -0500
Message-ID: <20240329000621.148791-17-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329000621.148791-1-zfigura@codeweavers.com>
References: <20240329000621.148791-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NT waits can optionally be made "alertable". This is a special channel for
thread wakeup that is mildly similar to SIGIO. A thread has an internal single
bit of "alerted" state, and if a thread is alerted while an alertable wait, the
wait will return a special value, consume the "alerted" state, and will not
consume any of its objects.

Alerts are implemented using events; the user-space NT emulator is expected to
create an internal ntsync event for each thread and pass that event to wait
functions.

Signed-off-by: Elizabeth Figura <zfigura@codeweavers.com>
---
 drivers/misc/ntsync.c       | 68 ++++++++++++++++++++++++++++++++-----
 include/uapi/linux/ntsync.h |  2 +-
 2 files changed, 60 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index a03c6fceb518..19fd70ac3f50 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -819,25 +819,32 @@ static int setup_wait(struct ntsync_device *dev,
 		      const struct ntsync_wait_args *args, bool all,
 		      struct ntsync_q **ret_q)
 {
+	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
-	int fds[NTSYNC_MAX_WAIT_COUNT];
 	struct ntsync_q *q;
+	__u32 total_count;
 	__u32 i, j;
 
 	if (!args->owner)
 		return -EINVAL;
 
-	if (args->pad || args->pad2 || (args->flags & ~NTSYNC_WAIT_REALTIME))
+	if (args->pad || (args->flags & ~NTSYNC_WAIT_REALTIME))
 		return -EINVAL;
 
 	if (args->count > NTSYNC_MAX_WAIT_COUNT)
 		return -EINVAL;
 
+	total_count = count;
+	if (args->alert)
+		total_count++;
+
 	if (copy_from_user(fds, u64_to_user_ptr(args->objs),
 			   array_size(count, sizeof(*fds))))
 		return -EFAULT;
+	if (args->alert)
+		fds[count] = args->alert;
 
-	q = kmalloc(struct_size(q, entries, count), GFP_KERNEL);
+	q = kmalloc(struct_size(q, entries, total_count), GFP_KERNEL);
 	if (!q)
 		return -ENOMEM;
 	q->task = current;
@@ -847,7 +854,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->ownerdead = false;
 	q->count = count;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = get_obj(dev, fds[i]);
 
@@ -897,9 +904,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 {
 	struct ntsync_wait_args args;
+	__u32 i, total_count;
 	struct ntsync_q *q;
 	int signaled;
-	__u32 i;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -909,9 +916,13 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 	if (ret < 0)
 		return ret;
 
+	total_count = args.count;
+	if (args.alert)
+		total_count++;
+
 	/* queue ourselves */
 
-	for (i = 0; i < args.count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
@@ -920,9 +931,15 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		spin_unlock(&obj->lock);
 	}
 
-	/* check if we are already signaled */
+	/*
+	 * Check if we are already signaled.
+	 *
+	 * Note that the API requires that normal objects are checked before
+	 * the alert event. Hence we queue the alert event last, and check
+	 * objects in order.
+	 */
 
-	for (i = 0; i < args.count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_obj *obj = q->entries[i].obj;
 
 		if (atomic_read(&q->signaled) != -1)
@@ -939,7 +956,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 
 	/* and finally, unqueue */
 
-	for (i = 0; i < args.count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
@@ -999,6 +1016,14 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		 */
 		list_add_tail(&entry->node, &obj->all_waiters);
 	}
+	if (args.alert) {
+		struct ntsync_q_entry *entry = &q->entries[args.count];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock_nest_lock(&obj->lock, &dev->wait_all_lock);
+		list_add_tail(&entry->node, &obj->any_waiters);
+		spin_unlock(&obj->lock);
+	}
 
 	/* check if we are already signaled */
 
@@ -1006,6 +1031,21 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
 	spin_unlock(&dev->wait_all_lock);
 
+	/*
+	 * Check if the alert event is signaled, making sure to do so only
+	 * after checking if the other objects are signaled.
+	 */
+
+	if (args.alert) {
+		struct ntsync_obj *obj = q->entries[args.count].obj;
+
+		if (atomic_read(&q->signaled) == -1) {
+			spin_lock(&obj->lock);
+			try_wake_any_obj(obj);
+			spin_unlock(&obj->lock);
+		}
+	}
+
 	/* sleep */
 
 	ret = ntsync_schedule(q, &args);
@@ -1028,6 +1068,16 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
 		put_obj(obj);
 	}
+	if (args.alert) {
+		struct ntsync_q_entry *entry = &q->entries[args.count];
+		struct ntsync_obj *obj = entry->obj;
+
+		spin_lock_nest_lock(&obj->lock, &dev->wait_all_lock);
+		list_del(&entry->node);
+		spin_unlock(&obj->lock);
+
+		put_obj(obj);
+	}
 
 	spin_unlock(&dev->wait_all_lock);
 
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 80f36de46a75..f21dbac42164 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -37,8 +37,8 @@ struct ntsync_wait_args {
 	__u32 owner;
 	__u32 index;
 	__u32 flags;
+	__u32 alert;
 	__u32 pad;
-	__u32 pad2;
 };
 
 #define NTSYNC_MAX_WAIT_COUNT 64
-- 
2.43.0


