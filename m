Return-Path: <linux-kselftest+bounces-10399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B328C9651
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 22:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E78F1F21245
	for <lists+linux-kselftest@lfdr.de>; Sun, 19 May 2024 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28137580E;
	Sun, 19 May 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="EUu3gCOW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CBC6E61E;
	Sun, 19 May 2024 20:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716150318; cv=none; b=Vgv9CS8xgoWeHzbf5K/H/4KY5ruqVB+RbqgRugoCv641X/SEdJljeTjlNJuUiJEg1KXSHsxVBxp0YxuZMCe9RhrSFfL7JjSwagnxWKfFU+DNqp9AfRiCo/HxOW7EqImiiG66sS2rfwQ/7kqF1DLnrrFyGum7526OQHRzzjFvz94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716150318; c=relaxed/simple;
	bh=2kXwj1nDuQyD4SNlNedYooti+VEh/c2JKHTckHGmiG8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHQtSNPqwwmpLXB2t01lstjDVeW9WZnv54aJNdpjYW7wG9BIEbL4Xgs3cNlkYLlzKmkSSWtI2EMdssN2gDA2C3Dd/8dY/CK+NHjnXTSYIW/KtwmvlZ6yPqMFDBXtx3oL44I+YGpPHvNhAd4acBTjQoBEZq3Z4fQqtQQm0uZ2ACY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=EUu3gCOW; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Yx0E1bGyvZjffiUNbQX+Ji2zc/69nwwUYWh+P+iWrSM=; b=EUu3gCOWZ4G1cQJPyvDPT8S7MF
	s+9uDni6qFtKgObd1o3MYvza6TLYdn36EWJIuWQ//xepu0T6g4tjnZln82LN0Z1Z/zxz03BMsJBlQ
	RHIv65jPYqdrZ99hF08CHTcoANX3A67TQrpjA8u85onAsFqVnziWZ649Y8iGWC/IDFl4B46+cVBf5
	NBhphNh2edRPDeBmRAxrKFVC79FHWh4yj1dFJUlelgQP1/V6hAY2jjpnZeUPbG+WNll+qG2NNdFEx
	1uWc7O3HcFcvaXwSRQZWcE5WqBvhM/G5o+NRgTyAJmk1xKEZJTy0NXC1eazrUuavOWMVj6ehbnltU
	L0vZIRpA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s8n5d-008wIn-1Y;
	Sun, 19 May 2024 15:25:05 -0500
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
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH v5 13/28] ntsync: Introduce alertable waits.
Date: Sun, 19 May 2024 15:24:39 -0500
Message-ID: <20240519202454.1192826-14-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240519202454.1192826-1-zfigura@codeweavers.com>
References: <20240519202454.1192826-1-zfigura@codeweavers.com>
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
 drivers/misc/ntsync.c       | 70 ++++++++++++++++++++++++++++++++-----
 include/uapi/linux/ntsync.h |  3 +-
 2 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/drivers/misc/ntsync.c b/drivers/misc/ntsync.c
index a11fe2469841..87a24798a5c7 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -885,22 +885,29 @@ static int setup_wait(struct ntsync_device *dev,
 		      const struct ntsync_wait_args *args, bool all,
 		      struct ntsync_q **ret_q)
 {
+	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
-	int fds[NTSYNC_MAX_WAIT_COUNT];
 	struct ntsync_q *q;
+	__u32 total_count;
 	__u32 i, j;
 
-	if (args->pad[0] || args->pad[1] || (args->flags & ~NTSYNC_WAIT_REALTIME))
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
@@ -910,7 +917,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->ownerdead = false;
 	q->count = count;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = get_obj(dev, fds[i]);
 
@@ -960,10 +967,10 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 {
 	struct ntsync_wait_args args;
+	__u32 i, total_count;
 	struct ntsync_q *q;
 	int signaled;
 	bool all;
-	__u32 i;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -973,9 +980,13 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
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
 
@@ -984,9 +995,15 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 		ntsync_unlock_obj(dev, obj, all);
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
@@ -1003,7 +1020,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 
 	/* and finally, unqueue */
 
-	for (i = 0; i < args.count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
@@ -1063,6 +1080,14 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 		 */
 		list_add_tail(&entry->node, &obj->all_waiters);
 	}
+	if (args.alert) {
+		struct ntsync_q_entry *entry = &q->entries[args.count];
+		struct ntsync_obj *obj = entry->obj;
+
+		dev_lock_obj(dev, obj);
+		list_add_tail(&entry->node, &obj->any_waiters);
+		dev_unlock_obj(dev, obj);
+	}
 
 	/* check if we are already signaled */
 
@@ -1070,6 +1095,21 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
 	mutex_unlock(&dev->wait_all_lock);
 
+	/*
+	 * Check if the alert event is signaled, making sure to do so only
+	 * after checking if the other objects are signaled.
+	 */
+
+	if (args.alert) {
+		struct ntsync_obj *obj = q->entries[args.count].obj;
+
+		if (atomic_read(&q->signaled) == -1) {
+			bool all = ntsync_lock_obj(dev, obj);
+			try_wake_any_obj(obj);
+			ntsync_unlock_obj(dev, obj, all);
+		}
+	}
+
 	/* sleep */
 
 	ret = ntsync_schedule(q, &args);
@@ -1095,6 +1135,18 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
 	mutex_unlock(&dev->wait_all_lock);
 
+	if (args.alert) {
+		struct ntsync_q_entry *entry = &q->entries[args.count];
+		struct ntsync_obj *obj = entry->obj;
+		bool all;
+
+		all = ntsync_lock_obj(dev, obj);
+		list_del(&entry->node);
+		ntsync_unlock_obj(dev, obj, all);
+
+		put_obj(obj);
+	}
+
 	signaled = atomic_read(&q->signaled);
 	if (signaled != -1) {
 		struct ntsync_wait_args __user *user_args = argp;
diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
index 74abeba832f7..4a8095a3fc34 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -37,7 +37,8 @@ struct ntsync_wait_args {
 	__u32 index;
 	__u32 flags;
 	__u32 owner;
-	__u32 pad[2];
+	__u32 alert;
+	__u32 pad;
 };
 
 #define NTSYNC_MAX_WAIT_COUNT 64
-- 
2.43.0


