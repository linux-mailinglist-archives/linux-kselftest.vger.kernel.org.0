Return-Path: <linux-kselftest+bounces-4694-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0E98557C1
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Feb 2024 00:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF06B2A93B
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C042148FFB;
	Wed, 14 Feb 2024 23:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="ZFm4GufW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936B1487E3;
	Wed, 14 Feb 2024 23:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707954819; cv=none; b=tgQutCpiTbqM2X3MIpnCY/gO43tZJp7uWdb5Qq3Ek2yfS4MXx4dhegUny8+RaiTutYufTJqsSgaARULitQX3AoKGNiwJdAdF3tM3Csn6kCShu+us0EILcbY6MWhQ4DAby8HlxYrwV0L6s3vxpB8Zhry8JtI6mCA6ilpGcnmdafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707954819; c=relaxed/simple;
	bh=rtyTKQiLKDkf87TwOX0OHpNk/dIQS6klJO2zDXPJGZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBpfjYrzkUp8t+7o7wHKH/6FUGtO3A93IVKZMmfSq9tw1YWmf20z37dEZP/OrIYf7F5VlnB4H9BGsG1OeoRNsWcyaO2ZLhWX7HSkH3VrKqLUFcapUkMslSGRoDLtPLTjyJJ1yAR2l8FWGXrJkBsFa408QR6dnQ7tBFVZCjgEk1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=ZFm4GufW; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=aZYNOwb29gWNQzvTlREYZIBloWSXlYgqolSN8OjEbzk=; b=ZFm4GufW/ApDIHtPUhPbGEbxk9
	8cMdCp0qEOcdNw10BKqT2bRoeqB1TCU5lPyXsgXfgkl3KkDXN3tEclNpaznubK3NWkMQkoDTHDYCm
	49btvJrqVrzvUiqWCnFAuPmrN+QmSNMy8Y0H1GnkGFfTDNUyxrM8Ewf0Od0hBHRGvtn+ja9Ma/Okv
	IGYD7wnqD3HDmMSzcdyc1Ag77NZtbRVfUsRYyj65dus3d/N5bEuOWYDGBUHcJ92CNFE5wlpLY6nQ3
	mlcrbu3FAc7kQEoE4NKH6LpTFVwBi64DSN1F/3Wj0X0wmQCAeyL7XK+trPgTFjBOLzYXQgEtV0YxE
	sEI7IGyA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.mn.codeweavers.com)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1raP4G-00GcSK-1n;
	Wed, 14 Feb 2024 17:53:32 -0600
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
	Elizabeth Figura <zfigura@codeweavers.com>
Subject: [PATCH 16/31] ntsync: Introduce alertable waits.
Date: Wed, 14 Feb 2024 17:52:51 -0600
Message-ID: <20240214235307.10494-7-zfigura@codeweavers.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214235307.10494-1-zfigura@codeweavers.com>
References: <20240214233645.9273-1-zfigura@codeweavers.com>
 <20240214235307.10494-1-zfigura@codeweavers.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NT waits can optionally be made "alertable". This is a special channel for
thread wakeup that is mildly similar to SIGIO. A thread has an internal single
bit of "alerted" state, and if a thread is made alerted while an alertable wait,
the wait will return a special value, consume the "alerted" state, and will not
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
index 5bf7af8095e6..0773602cc86d 100644
--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -795,22 +795,29 @@ static int setup_wait(struct ntsync_device *dev,
 		      const struct ntsync_wait_args *args, bool all,
 		      struct ntsync_q **ret_q)
 {
+	int fds[NTSYNC_MAX_WAIT_COUNT + 1];
 	const __u32 count = args->count;
-	int fds[NTSYNC_MAX_WAIT_COUNT];
 	struct ntsync_q *q;
+	__u32 total_count;
 	__u32 i, j;
 
-	if (!args->owner || args->pad)
+	if (!args->owner)
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
@@ -820,7 +827,7 @@ static int setup_wait(struct ntsync_device *dev,
 	q->ownerdead = false;
 	q->count = count;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = get_obj(dev, fds[i]);
 
@@ -870,9 +877,9 @@ static void try_wake_any_obj(struct ntsync_obj *obj)
 static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 {
 	struct ntsync_wait_args args;
+	__u32 i, total_count;
 	struct ntsync_q *q;
 	int signaled;
-	__u32 i;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -882,9 +889,13 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
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
 
@@ -893,9 +904,15 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
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
@@ -912,7 +929,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, void __user *argp)
 
 	/* and finally, unqueue */
 
-	for (i = 0; i < args.count; i++) {
+	for (i = 0; i < total_count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
 		struct ntsync_obj *obj = entry->obj;
 
@@ -972,6 +989,14 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
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
 
@@ -979,6 +1004,21 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
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
@@ -1001,6 +1041,16 @@ static int ntsync_wait_all(struct ntsync_device *dev, void __user *argp)
 
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
index 582d33b0dcac..7c91af7011e4 100644
--- a/include/uapi/linux/ntsync.h
+++ b/include/uapi/linux/ntsync.h
@@ -34,7 +34,7 @@ struct ntsync_wait_args {
 	__u32 count;
 	__u32 owner;
 	__u32 index;
-	__u32 pad;
+	__u32 alert;
 };
 
 #define NTSYNC_MAX_WAIT_COUNT 64
-- 
2.43.0


