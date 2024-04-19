Return-Path: <linux-kselftest+bounces-8462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D90B8AB351
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 18:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE0A8285FAE
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 16:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5C131BBC;
	Fri, 19 Apr 2024 16:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J6yGG/3L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE513118B;
	Fri, 19 Apr 2024 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713544104; cv=none; b=IzYe2r5lAtL4m5dWLqskrwiLpxGY0QifZastQ3rMIus/gEG4+wnZLQFhs1DVHNcRFrQzQHT8+5DTEut7mBpB/JcmtP1eZ3sxNn+csOHi/xEzNmw9naiEuR0fUM27qtRu5o2AaHvIvLFDXWkCdHljcj1Qcp6+gPfNNGHkUAL5Yuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713544104; c=relaxed/simple;
	bh=DOmX0iOkHW2cJzuR1rPdldKVk2CxrIbKn1lcMhY+CDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TBRpZvU5aGkf7I1we8ihYBXMWBhtZa5xBppQ0tap6X4EnGsh2bIrkIYqqUqOolrRge+1axBZdFArTR9FL6RAw1TYLQQa+cbDnaPsZBCn7QqpBxZsFWBxEzwMwoSdfM1XP9ZCrmoNXfSa+iVL4HetTg0Qrf2sAy+cRvP1Mu5gURA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=J6yGG/3L; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3/ZWGvXqRoKz8HtRF0dXAu1mFH2qGH4fmM0vuYDhJ6k=; b=J6yGG/3La4BTYI8JjhMgOM7BQH
	4bVt0d/koOOfAgayreGIR4vWa1RtMTXmzYkc1qNlcQ5trwiIzLagCVciUOhSDHagyXODbTLsc23rS
	+HodFCLUZgyXFfsH+eP36bUtZxkwIujqWPjgP04weXE4krKr/fX/Cw1rUbmPQoZF3IHNXmoPQWFDW
	FTHKP3eaE7uahB6Z8Lgb1bEeAm/Lr139fcDI4ucyQUFJIlp3WwYjNqTCCeR5e/iheOGk3yFd6YvS3
	dCnXFADnnwkcN3754SnScOY2hJl8UL4vI3pgK7rhisrD1nQ50FfSmLhSyIey4ETj2PhmsuG9U6FZd
	w/K4JtVg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxr5y-0000000CVku-3Wke;
	Fri, 19 Apr 2024 16:28:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7BA8130043E; Fri, 19 Apr 2024 18:28:14 +0200 (CEST)
Date: Fri, 19 Apr 2024 18:28:14 +0200
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
Message-ID: <20240419162814.GA39162@noisy.programming.kicks-ass.net>
References: <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416010837.333694-3-zfigura@codeweavers.com>
 <20240417113703.GL30852@noisy.programming.kicks-ass.net>
 <3479054.QJadu78ljV@camazotz>
 <20240418093511.GQ40213@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240418093511.GQ40213@noisy.programming.kicks-ass.net>

On Thu, Apr 18, 2024 at 11:35:11AM +0200, Peter Zijlstra wrote:
> On Wed, Apr 17, 2024 at 03:03:05PM -0500, Elizabeth Figura wrote:
> 
> > Ach. I wrote this with the idea that the race isn't meaningful, but
> > looking at it again you're right—there is a harmful race here.
> > 
> > I think it should be fixable by moving the atomic_read inside the lock,
> > though.
> 
> Right, I've ended up with the (as yet untested) below. I'll see if I can
> find time later to actually test things.

Latest hackery... I tried testing this but I'm not having luck using the
patched wine as per the other email.

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
 
@@ -132,14 +134,107 @@ struct ntsync_device {
 	 * wait_all_lock is taken first whenever multiple objects must be locked
 	 * at the same time.
 	 */
-	spinlock_t wait_all_lock;
+	struct mutex wait_all_lock;
 
 	struct file *file;
 };
 
+/*
+ * Single objects are locked using obj->lock.
+ *
+ * Multiple objects are 'locked' while holding dev->wait_all_lock to avoid lock
+ * order issues. In this case however, single objects are not locked by holding
+ * obj->lock, but by setting obj->dev_locked.
+ *
+ * This means that in order to lock a single object, the sequence is slightly
+ * more complicated than usual. Specifically it needs to check obj->dev_locked
+ * after acquiring obj->lock, if set, it needs to drop the lock and acquire
+ * dev->wait_all_lock in order to serialize against the multi-object operation.
+ */
+
+static void dev_lock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert(obj->dev == dev);
+	spin_lock(&obj->lock);
+	/*
+	 * By setting obj->dev_locked inside obj->lock, it is ensured that
+	 * anyone holding obj->lock must see the value.
+	 */
+	obj->dev_locked = 1;
+	spin_unlock(&obj->lock);
+}
+
+static void dev_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	lockdep_assert_held(&dev->wait_all_lock);
+	lockdep_assert(obj->dev == dev);
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
+		lockdep_assert(!obj->dev_locked);
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
+static bool ntsync_lock_obj(struct ntsync_device *dev, struct ntsync_obj *obj)
+{
+	bool all;
+
+	obj_lock(obj);
+	all = atomic_read(&obj->all_hint);
+	if (unlikely(all)) {
+		obj_unlock(obj);
+		mutex_lock(&dev->wait_all_lock);
+		dev_lock_obj(dev, obj);
+	}
+
+	return all;
+}
+
+static void ntsync_unlock_obj(struct ntsync_device *dev, struct ntsync_obj *obj, bool all)
+{
+	if (all) {
+		dev_unlock_obj(dev, obj);
+		mutex_unlock(&dev->wait_all_lock);
+	} else {
+		obj_unlock(obj);
+	}
+}
+
+#define ntsync_assert_held(obj) \
+	lockdep_assert((lockdep_is_held(&(obj)->lock) != LOCK_STATE_NOT_HELD) || \
+		       ((lockdep_is_held(&(obj)->dev->wait_all_lock) != LOCK_STATE_NOT_HELD) && \
+			(obj)->dev_locked))
+
 static bool is_signaled(struct ntsync_obj *obj, __u32 owner)
 {
-	lockdep_assert_held(&obj->lock);
+	ntsync_assert_held(obj);
 
 	switch (obj->type) {
 	case NTSYNC_TYPE_SEM:
@@ -171,11 +266,11 @@ static void try_wake_all(struct ntsync_d
 
 	lockdep_assert_held(&dev->wait_all_lock);
 	if (locked_obj)
-		lockdep_assert_held(&locked_obj->lock);
+		lockdep_assert(locked_obj->dev_locked);
 
 	for (i = 0; i < count; i++) {
 		if (q->entries[i].obj != locked_obj)
-			spin_lock_nest_lock(&q->entries[i].obj->lock, &dev->wait_all_lock);
+			dev_lock_obj(dev, q->entries[i].obj);
 	}
 
 	for (i = 0; i < count; i++) {
@@ -211,7 +306,7 @@ static void try_wake_all(struct ntsync_d
 
 	for (i = 0; i < count; i++) {
 		if (q->entries[i].obj != locked_obj)
-			spin_unlock(&q->entries[i].obj->lock);
+			dev_unlock_obj(dev, q->entries[i].obj);
 	}
 }
 
@@ -220,7 +315,7 @@ static void try_wake_all_obj(struct ntsy
 	struct ntsync_q_entry *entry;
 
 	lockdep_assert_held(&dev->wait_all_lock);
-	lockdep_assert_held(&obj->lock);
+	lockdep_assert(obj->dev_locked);
 
 	list_for_each_entry(entry, &obj->all_waiters, node)
 		try_wake_all(dev, entry->q, obj);
@@ -230,7 +325,8 @@ static void try_wake_any_sem(struct ntsy
 {
 	struct ntsync_q_entry *entry;
 
-	lockdep_assert_held(&sem->lock);
+	ntsync_assert_held(sem);
+	lockdep_assert(sem->type == NTSYNC_TYPE_SEM);
 
 	list_for_each_entry(entry, &sem->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -250,7 +346,8 @@ static void try_wake_any_mutex(struct nt
 {
 	struct ntsync_q_entry *entry;
 
-	lockdep_assert_held(&mutex->lock);
+	ntsync_assert_held(mutex);
+	lockdep_assert(mutex->type == NTSYNC_TYPE_MUTEX);
 
 	list_for_each_entry(entry, &mutex->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -276,7 +373,8 @@ static void try_wake_any_event(struct nt
 {
 	struct ntsync_q_entry *entry;
 
-	lockdep_assert_held(&event->lock);
+	ntsync_assert_held(event);
+	lockdep_assert(event->type == NTSYNC_TYPE_EVENT);
 
 	list_for_each_entry(entry, &event->any_waiters, node) {
 		struct ntsync_q *q = entry->q;
@@ -302,6 +400,7 @@ static int post_sem_state(struct ntsync_
 	__u32 sum;
 
 	lockdep_assert_held(&sem->lock);
+	lockdep_assert(sem->type == NTSYNC_TYPE_SEM);
 
 	if (check_add_overflow(sem->u.sem.count, count, &sum) ||
 	    sum > sem->u.sem.max)
@@ -317,6 +416,7 @@ static int ntsync_sem_post(struct ntsync
 	__u32 __user *user_args = argp;
 	__u32 prev_count;
 	__u32 args;
+	bool all;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -325,30 +425,18 @@ static int ntsync_sem_post(struct ntsync
 	if (sem->type != NTSYNC_TYPE_SEM)
 		return -EINVAL;
 
-	if (atomic_read(&sem->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
-
-		prev_count = sem->u.sem.count;
-		ret = post_sem_state(sem, args);
-		if (!ret) {
-			try_wake_all_obj(dev, sem);
-			try_wake_any_sem(sem);
-		}
-
-		spin_unlock(&sem->lock);
-		spin_unlock(&dev->wait_all_lock);
-	} else {
-		spin_lock(&sem->lock);
+	all = ntsync_lock_obj(dev, sem);
 
-		prev_count = sem->u.sem.count;
-		ret = post_sem_state(sem, args);
-		if (!ret)
-			try_wake_any_sem(sem);
-
-		spin_unlock(&sem->lock);
+	prev_count = sem->u.sem.count;
+	ret = post_sem_state(sem, args);
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, sem);
+		try_wake_any_sem(sem);
 	}
 
+	ntsync_unlock_obj(dev, sem, all);
+
 	if (!ret && put_user(prev_count, user_args))
 		ret = -EFAULT;
 
@@ -377,6 +465,7 @@ static int ntsync_mutex_unlock(struct nt
 	struct ntsync_device *dev = mutex->dev;
 	struct ntsync_mutex_args args;
 	__u32 prev_count;
+	bool all;
 	int ret;
 
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -387,30 +476,18 @@ static int ntsync_mutex_unlock(struct nt
 	if (mutex->type != NTSYNC_TYPE_MUTEX)
 		return -EINVAL;
 
-	if (atomic_read(&mutex->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
-
-		prev_count = mutex->u.mutex.count;
-		ret = unlock_mutex_state(mutex, &args);
-		if (!ret) {
-			try_wake_all_obj(dev, mutex);
-			try_wake_any_mutex(mutex);
-		}
+	all = ntsync_lock_obj(dev, mutex);
 
-		spin_unlock(&mutex->lock);
-		spin_unlock(&dev->wait_all_lock);
-	} else {
-		spin_lock(&mutex->lock);
-
-		prev_count = mutex->u.mutex.count;
-		ret = unlock_mutex_state(mutex, &args);
-		if (!ret)
-			try_wake_any_mutex(mutex);
-
-		spin_unlock(&mutex->lock);
+	prev_count = mutex->u.mutex.count;
+	ret = unlock_mutex_state(mutex, &args);
+	if (!ret) {
+		if (all)
+			try_wake_all_obj(dev, mutex);
+		try_wake_any_mutex(mutex);
 	}
 
+	ntsync_unlock_obj(dev, mutex, all);
+
 	if (!ret && put_user(prev_count, &user_args->count))
 		ret = -EFAULT;
 
@@ -438,6 +515,7 @@ static int ntsync_mutex_kill(struct ntsy
 {
 	struct ntsync_device *dev = mutex->dev;
 	__u32 owner;
+	bool all;
 	int ret;
 
 	if (get_user(owner, (__u32 __user *)argp))
@@ -448,28 +526,17 @@ static int ntsync_mutex_kill(struct ntsy
 	if (mutex->type != NTSYNC_TYPE_MUTEX)
 		return -EINVAL;
 
-	if (atomic_read(&mutex->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&mutex->lock, &dev->wait_all_lock);
+	all = ntsync_lock_obj(dev, mutex);
 
-		ret = kill_mutex_state(mutex, owner);
-		if (!ret) {
+	ret = kill_mutex_state(mutex, owner);
+	if (!ret) {
+		if (all)
 			try_wake_all_obj(dev, mutex);
-			try_wake_any_mutex(mutex);
-		}
-
-		spin_unlock(&mutex->lock);
-		spin_unlock(&dev->wait_all_lock);
-	} else {
-		spin_lock(&mutex->lock);
-
-		ret = kill_mutex_state(mutex, owner);
-		if (!ret)
-			try_wake_any_mutex(mutex);
-
-		spin_unlock(&mutex->lock);
+		try_wake_any_mutex(mutex);
 	}
 
+	ntsync_unlock_obj(dev, mutex, all);
+
 	return ret;
 }
 
@@ -477,34 +544,22 @@ static int ntsync_event_set(struct ntsyn
 {
 	struct ntsync_device *dev = event->dev;
 	__u32 prev_state;
+	bool all;
 
 	if (event->type != NTSYNC_TYPE_EVENT)
 		return -EINVAL;
 
-	if (atomic_read(&event->all_hint) > 0) {
-		spin_lock(&dev->wait_all_lock);
-		spin_lock_nest_lock(&event->lock, &dev->wait_all_lock);
+	all = ntsync_lock_obj(dev, event);
 
-		prev_state = event->u.event.signaled;
-		event->u.event.signaled = true;
+	prev_state = event->u.event.signaled;
+	event->u.event.signaled = true;
+	if (all)
 		try_wake_all_obj(dev, event);
-		try_wake_any_event(event);
-		if (pulse)
-			event->u.event.signaled = false;
+	try_wake_any_event(event);
+	if (pulse)
+		event->u.event.signaled = false;
 
-		spin_unlock(&event->lock);
-		spin_unlock(&dev->wait_all_lock);
-	} else {
-		spin_lock(&event->lock);
-
-		prev_state = event->u.event.signaled;
-		event->u.event.signaled = true;
-		try_wake_any_event(event);
-		if (pulse)
-			event->u.event.signaled = false;
-
-		spin_unlock(&event->lock);
-	}
+	ntsync_unlock_obj(dev, event, all);
 
 	if (put_user(prev_state, (__u32 __user *)argp))
 		return -EFAULT;
@@ -984,7 +1039,7 @@ static int ntsync_wait_all(struct ntsync
 
 	/* queue ourselves */
 
-	spin_lock(&dev->wait_all_lock);
+	mutex_lock(&dev->wait_all_lock);
 
 	for (i = 0; i < args.count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
@@ -1004,7 +1059,7 @@ static int ntsync_wait_all(struct ntsync
 
 	try_wake_all(dev, q, NULL);
 
-	spin_unlock(&dev->wait_all_lock);
+	mutex_unlock(&dev->wait_all_lock);
 
 	/* sleep */
 
@@ -1012,7 +1067,7 @@ static int ntsync_wait_all(struct ntsync
 
 	/* and finally, unqueue */
 
-	spin_lock(&dev->wait_all_lock);
+	mutex_lock(&dev->wait_all_lock);
 
 	for (i = 0; i < args.count; i++) {
 		struct ntsync_q_entry *entry = &q->entries[i];
@@ -1029,7 +1084,7 @@ static int ntsync_wait_all(struct ntsync
 		put_obj(obj);
 	}
 
-	spin_unlock(&dev->wait_all_lock);
+	mutex_unlock(&dev->wait_all_lock);
 
 	signaled = atomic_read(&q->signaled);
 	if (signaled != -1) {
@@ -1056,7 +1111,7 @@ static int ntsync_char_open(struct inode
 	if (!dev)
 		return -ENOMEM;
 
-	spin_lock_init(&dev->wait_all_lock);
+	mutex_init(&dev->wait_all_lock);
 
 	file->private_data = dev;
 	dev->file = file;

