Return-Path: <linux-kselftest+bounces-8303-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8B98A9647
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E6EF1C21F54
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Apr 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E1A15ADB0;
	Thu, 18 Apr 2024 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WBSI2Lo7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24C215AD93;
	Thu, 18 Apr 2024 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432932; cv=none; b=JuUMOljPoh+euiw+z5VdcZtnLLEYf6NoLynkHvGFR5WonDVqkCtu3ejZUweSIHeLoHEkQTC6vk8Ed+GQEKJ/3paP2ENvl04CxbMx3oDOTepU3DtGeA3gTc/52iqgiR7RPAA9Zb/Gr5iK9n4wn/S7kB+pWySVnbn2RRly1h6oOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432932; c=relaxed/simple;
	bh=+0kwtJoZt9tJauUmdcEXI5iVzfFnGfehiVYt+0ac7ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kq2rn5ZKFMC+sY3QGYCYNS1aMgR6ZzZEVBTcO8IctuKELw2zmHuPy2M/iZ3Z7/injOBuKEuK21lDsr8A1rU4rE1Hr82zr/Y9exU9QFrpoth8FX4VtQ/Ev9KfTvRpHXIJLjEjtuyWElTY/BDQhBCHTPVkqPC7T1k0IDYNi5bGxjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WBSI2Lo7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=oGTILeKlc6FTPHbw4RWanUk3Gk5WS73q7r0ZL6hmbeM=; b=WBSI2Lo7KyxcxRncGNM3Aqqb2a
	TtMi/VxdoqBKPSXEEbbFXCsKNSCQgp1+u7tIBQ37qRBS0PxdAxjLLyHJgJ8dMBK+hXutRYoPFMAgA
	+xGWCxVYWfh3Iy3e043YfoYZP06AXvCHUqVXVbYHgNX76dnfiI1fjQN3k0ldPFsWfG1uwQuwdTzoh
	HqgTtI8NruY+2/nvYFhFpSw+3HnSXrzux3FOAk1pblabXMxcn/VL5mAFaB0jRyEZiCYD8ktdzlTS6
	4spoD9Gr+hb5Wju62icQRtusgD6Z04Eg/mZ6xjLEAUCNcN0ySY5hkPDeJ7Igbu0FU2gt7nU5UGPLU
	d0T3nt+g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxOAh-0000000Bw9a-3p7z;
	Thu, 18 Apr 2024 09:35:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90DF7300362; Thu, 18 Apr 2024 11:35:11 +0200 (CEST)
Date: Thu, 18 Apr 2024 11:35:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	wine-devel@winehq.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Wolfram Sang <wsa@kernel.org>,
	Arkadiusz Hiler <ahiler@codeweavers.com>,
	Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 02/27] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Message-ID: <20240418093511.GQ40213@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416010837.333694-3-zfigura@codeweavers.com>
 <20240417113703.GL30852@noisy.programming.kicks-ass.net>
 <3479054.QJadu78ljV@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3479054.QJadu78ljV@camazotz>

On Wed, Apr 17, 2024 at 03:03:05PM -0500, Elizabeth Figura wrote:

> Ach. I wrote this with the idea that the race isn't meaningful, but
> looking at it again you're right—there is a harmful race here.
> 
> I think it should be fixable by moving the atomic_read inside the lock,
> though.

Right, I've ended up with the (as yet untested) below. I'll see if I can
find time later to actually test things.

---

--- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -18,6 +18,7 @@
 #include <linux/sched/signal.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <uapi/linux/ntsync.h>
 
 #define NTSYNC_NAME	"ntsync"
@@ -43,6 +44,7 @@ enum ntsync_type {
 
 struct ntsync_obj {
 	spinlock_t lock;
+	int dev_locked;
 
 	enum ntsync_type type;
 
@@ -132,7 +134,7 @@ struct ntsync_device {
 	 * wait_all_lock is taken first whenever multiple objects must be locked
 	 * at the same time.
 	 */
-	spinlock_t wait_all_lock;
+	struct mutex wait_all_lock;
 
 	struct file *file;
 };
@@ -157,6 +159,56 @@ static bool is_signaled(struct ntsync_ob
 }
 
 /*
+ * XXX write coherent comment on the locking
+ */
+
+static void dev_lock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	WARN_ON_ONCE(obj->dev != dev);
+	spin_lock(&obj->lock);
+	obj->dev_locked = 1;
+	spin_unlock(&obj->lock);
+}
+
+static void dev_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	WARN_ON_ONCE(obj->dev != dev);
+	spin_lock(&obj->lock);
+	obj->dev_locked = 0;
+	spin_unlock(&obj->lock);
+}
+
+static void obj_lock(struct ntsync_obj *obj)
+{
+	struct ntsync_device *dev = obj->dev;
+
+	for (;;) {
+		spin_lock(&obj->lock);
+		if (likely(!obj->dev_locked))
+			break;
+
+		spin_unlock(&obj->lock);
+		mutex_lock(&dev->wait_all_lock);
+		spin_lock(&obj->lock);
+		/*
+		 * obj->dev_locked should be set and released under the same
+		 * wait_all_lock section, since we now own this lock, it should
+		 * be clear.
+		 */
+		WARN_ON_ONCE(obj->dev_locked);
+		spin_unlock(&obj->lock);
+		mutex_unlock(&dev->wait_all_lock);
+	}
+}
+
+static void obj_unlock(struct ntsync_obj *obj)
+{
+	spin_unlock(&obj->lock);
+}
+
+/*
  * "locked_obj" is an optional pointer to an object which is already locked and
  * should not be locked again. This is necessary so that changing an object's
  * state and waking it can be a single atomic operation.
@@ -175,7 +227,7 @@ static void try_wake_all(struct ntsync_d
 
 	for (i = 0; i < count; i++) {
 		if (q->entries[i].obj != locked_obj)
-			spin_lock_nest_lock(&q->entries[i].obj->lock, &dev->wait_all_lock);
+			dev_lock_obj(dev, q->entries[i].obj);
 	}
 
 	for (i = 0; i < count; i++) {
@@ -211,7 +263,7 @@ static void try_wake_all(struct ntsync_d
 
 	for (i = 0; i < count; i++) {
 		if (q->entries[i].obj != locked_obj)
-			spin_unlock(&q->entries[i].obj->lock);
+			dev_unlock_obj(dev, q->entries[i].obj);
 	}
 }
 
@@ -231,6 +283,7 @@ static void try_wake_any_sem(struct ntsy
 	struct ntsync_q_entry *entry;
 
 	lockdep_assert_held(&sem->lock);
+	WARN_ON_ONCE(sem->type != NTSYNC_TYPE_SEM);
 
 	list_for_each_entry(entry, &sem->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -251,6 +304,7 @@ static void try_wake_any_mutex(struct nt
 	struct ntsync_q_entry *entry;
 
 	lockdep_assert_held(&mutex->lock);
+	WARN_ON_ONCE(mutex->type != NTSYNC_TYPE_MUTEX);
 
 	list_for_each_entry(entry, &mutex->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -302,6 +356,7 @@ static int post_sem_state(struct ntsync_
 	__u32 sum;
 
 	lockdep_assert_held(&sem->lock);
+	WARN_ON_ONCE(sem->type != NTSYNC_TYPE_SEM);
 
 	if (check_add_overflow(sem->u.sem.count, count, &sum) ||
 	    sum > sem->u.sem.max)
@@ -316,6 +371,7 @@ static int ntsync_sem_post(struct ntsync
 	struct ntsync_device *dev = sem->dev;
 	__u32 __user *user_args = argp;
 	__u32 prev_count;
+	bool all = false;
 	__u32 args;
 	int ret;
 
@@ -325,28 +381,27 @@ static int ntsync_sem_post(struct ntsync
 	if (sem->type != NTSYNC_TYPE_SEM)
 		return -EINVAL;
 
-	if (atomic_read(&sem->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
-
-		prev_count = sem->u.sem.count;
-		ret = post_sem_state(sem, args);
-		if (!ret) {
+	obj_lock(sem);
+	all = atomic_read(&sem->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(sem);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, sem);
+	}
+
+	prev_count = sem->u.sem.count;
+	ret = post_sem_state(sem, args);
+	if (!ret) {
+		if (all)
 			try_wake_all_obj(dev, sem);
-			try_wake_any_sem(sem);
-		}
+		try_wake_any_sem(sem);
+	}
 
-		spin_unlock(&sem->lock);
-		spin_unlock(&dev->wait_all_lock);
+	if (all) {
+		dev_unlock_obj(dev, sem);
+		mutex_unlock(&dev->wait_all_lock);
 	} else {
-		spin_lock(&sem->lock);
-
-		prev_count = sem->u.sem.count;
-		ret = post_sem_state(sem, args);
-		if (!ret)
-			try_wake_any_sem(sem);
-
-		spin_unlock(&sem->lock);
+		obj_unlock(sem);
 	}
 
 	if (!ret && put_user(prev_count, user_args))
@@ -376,6 +431,7 @@ static int ntsync_mutex_unlock(struct nt
 	struct ntsync_mutex_args __user *user_args = argp;
 	struct ntsync_device *dev = mutex->dev;
 	struct ntsync_mutex_args args;
+	bool all = false;
 	__u32 prev_count;
 	int ret;
 
@@ -387,28 +443,27 @@ static int ntsync_mutex_unlock(struct nt
 	if (mutex->type != NTSYNC_TYPE_MUTEX)
 		return -EINVAL;
 
-	if (atomic_read(&mutex->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
-
-		prev_count = mutex->u.mutex.count;
-		ret = unlock_mutex_state(mutex, &args);
-		if (!ret) {
+	obj_lock(mutex);
+	all = atomic_read(&mutex->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(mutex);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, mutex);
+	}
+
+	prev_count = mutex->u.mutex.count;
+	ret = unlock_mutex_state(mutex, &args);
+	if (!ret) {
+		if (all)
 			try_wake_all_obj(dev, mutex);
-			try_wake_any_mutex(mutex);
-		}
+		try_wake_any_mutex(mutex);
+	}
 
-		spin_unlock(&mutex->lock);
-		spin_unlock(&dev->wait_all_lock);
+	if (all) {
+		dev_unlock_obj(dev, mutex);
+		mutex_unlock(&dev->wait_all_lock);
 	} else {
-		spin_lock(&mutex->lock);
-
-		prev_count = mutex->u.mutex.count;
-		ret = unlock_mutex_state(mutex, &args);
-		if (!ret)
-			try_wake_any_mutex(mutex);
-
-		spin_unlock(&mutex->lock);
+		obj_unlock(mutex);
 	}
 
 	if (!ret && put_user(prev_count, &user_args->count))
@@ -437,6 +492,7 @@ static int kill_mutex_state(struct ntsyn
 static int ntsync_mutex_kill(struct ntsync_obj *mutex, void __user *argp)
 {
 	struct ntsync_device *dev = mutex->dev;
+	bool all = false;
 	__u32 owner;
 	int ret;
 
@@ -448,26 +504,26 @@ static int ntsync_mutex_kill(struct ntsy
 	if (mutex->type != NTSYNC_TYPE_MUTEX)
 		return -EINVAL;
 
-	if (atomic_read(&mutex->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+	obj_lock(mutex);
+	all = atomic_read(&mutex->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(mutex);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, mutex);
+	}
 
-		ret = kill_mutex_state(mutex, owner);
-		if (!ret) {
+	ret = kill_mutex_state(mutex, owner);
+	if (!ret) {
+		if (all)
 			try_wake_all_obj(dev, mutex);
-			try_wake_any_mutex(mutex);
-		}
+		try_wake_any_mutex(mutex);
+	}
 
-		spin_unlock(&mutex->lock);
-		spin_unlock(&dev->wait_all_lock);
+	if (all) {
+		dev_unlock_obj(dev, mutex);
+		mutex_unlock(&dev->wait_all_lock);
 	} else {
-		spin_lock(&mutex->lock);
-
-		ret = kill_mutex_state(mutex, owner);
-		if (!ret)
-			try_wake_any_mutex(mutex);
-
-		spin_unlock(&mutex->lock);
+		obj_unlock(mutex);
 	}
 
 	return ret;
@@ -477,35 +533,35 @@ static int ntsync_event_set(struct ntsyn
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
+	bool all = false;
 
 	if (event->type != NTSYNC_TYPE_EVENT)
 		return -EINVAL;
 
-	if (atomic_read(&event->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&event->lock, &dev->wait_all_lock);
+	obj_lock(event);
+	all = atomic_read(&event->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(event);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, event);
+	}
 
-		prev_state = event->u.event.signaled;
-		event->u.event.signaled = true;
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = true;
+	if (all)
 		try_wake_all_obj(dev, event);
-		try_wake_any_event(event);
-		if (pulse)
-			event->u.event.signaled = false;
-
-		spin_unlock(&event->lock);
-		spin_unlock(&dev->wait_all_lock);
+	try_wake_any_event(event);
+	if (pulse)
+		event->u.event.signaled = false;
+
+	if (all) {
+		dev_unlock_obj(dev, event);
+		mutex_unlock(&dev->wait_all_lock);
 	} else {
-		spin_lock(&event->lock);
-
-		prev_state = event->u.event.signaled;
-		event->u.event.signaled = true;
-		try_wake_any_event(event);
-		if (pulse)
-			event->u.event.signaled = false;
-
-		spin_unlock(&event->lock);
+		obj_unlock(event);
 	}
 
+
 	if (put_user(prev_state, (__u32 __user *)argp))
 		return -EFAULT;
 
@@ -984,7 +1040,7 @@ static int ntsync_wait_all(struct ntsync
 
 	/* queue ourselves */
 
-	spin_lock(&dev->wait_all_lock);
+	mutex_lock(&dev->wait_all_lock);
 
 	for (i = 0; i < args.count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
@@ -1004,7 +1060,7 @@ static int ntsync_wait_all(struct ntsync
 
 	try_wake_all(dev, q, NULL);
 
-	spin_unlock(&dev->wait_all_lock);
+	mutex_unlock(&dev->wait_all_lock);
 
 	/* sleep */
 
@@ -1012,7 +1068,7 @@ static int ntsync_wait_all(struct ntsync
 
 	/* and finally, unqueue */
 
-	spin_lock(&dev->wait_all_lock);
+	mutex_lock(&dev->wait_all_lock);
 
 	for (i = 0; i < args.count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
@@ -1029,7 +1085,7 @@ static int ntsync_wait_all(struct ntsync
 		put_obj(obj);
 	}
 
-	spin_unlock(&dev->wait_all_lock);
+	mutex_unlock(&dev->wait_all_lock);
 
 	signaled = atomic_read(&q->signaled);
 	if (signaled != -1) {
@@ -1056,7 +1112,7 @@ static int ntsync_char_open(struct inode
 	if (!dev)
 		return -ENOMEM;
 
-	spin_lock_init(&dev->wait_all_lock);
+	mutex_init(&dev->wait_all_lock);
 
 	file->private_data = dev;
 	dev->file = file;

