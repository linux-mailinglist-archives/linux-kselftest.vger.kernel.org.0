Return-Path: <linux-kselftest+bounces-10166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53C138C4BB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 06:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB9AE1F22B48
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 04:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DD38C04;
	Tue, 14 May 2024 04:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="lx62fzIB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B34528E3;
	Tue, 14 May 2024 04:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715661081; cv=none; b=uxBDcuzH5xfKQvXtxq/mEZsryU3tNoBnIp0xloP9KJnxM5fdrrnB9S+E/XP1IXa8QhC+RPEZKWPr5YLPfZNdgo6jk1V8obhrs3Qun+K41va/Zo0QfYQeVc/ofmfIo3eMF47l9+39hyoa0cO3KXfxPp7o2j+8CEOHJGX89SKrgMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715661081; c=relaxed/simple;
	bh=KticW/LzOiqW8d+K9WGeuWevQ/oIXO4ouOTY8TyEDiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCTbfscADLNq/TxRkn09mjiR9ytpQuHBjLiuIEKQeKEhTQY9TOzjGPvVDlGX584dZJhh6sAZDv2NhV2N72NwR/Vdsl5iL2ghC3P5T2mBZ3ksXWtLMKImWAgw4JOqlYfTpX92z7Z/1BH9mh3UNzv52YGIyfQ/ZQaCF8ucvBtiM08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=lx62fzIB; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=2SlV9Cal6hzzO4e99rzO08hgr/w9g9NBudXVPOnZiNM=; b=lx62fzIBlSXxKAvTBOFGfvlNFr
	nwE0Vw0azshzqNdst8I71Y7qb9+Oqssb1o1ffMKDm+GNidUzDENaCAi6V/gmPiBygnO7dPzI0YaoU
	rSjDL9FK3Ej5LgNLQvbFVYfPZ63DZvJ+y8nHMZrouCqwq672CU1gyANcrakNgrPG5Lulrjt8fg7YX
	og4f64q5VpjhxrGX8pUt+C8KOBxoRYyKEDiGWY3JItam6Ouu1NF9FTihdbNuzDJTw+nEMM633QD4L
	KssfLvPJ53up9Te+4E20T4ZgrfxBxTWw13257z5TFrVSp9bDYb0Ysa1nnk4/bsC1IiWPKff1unpYx
	fee+IL/Q==;
Received: from [10.69.139.4] (helo=watership.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s6jZn-0041qp-15;
	Mon, 13 May 2024 23:15:44 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 02/27] ntsync: Introduce NTSYNC_IOC_WAIT_ALL.
Date: Mon, 13 May 2024 23:15:42 -0500
Message-ID: <4629754.LvFx2qVVIh@watership>
In-Reply-To: <20240419162814.GA39162@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240418093511.GQ40213@noisy.programming.kicks-ass.net>
 <20240419162814.GA39162@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, April 19, 2024 11:28:14=E2=80=AFAM CDT Peter Zijlstra wrote:
> On Thu, Apr 18, 2024 at 11:35:11AM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 17, 2024 at 03:03:05PM -0500, Elizabeth Figura wrote:
> > > Ach. I wrote this with the idea that the race isn't meaningful, but
> > > looking at it again you're right=E2=80=94there is a harmful race here.
> > >=20
> > > I think it should be fixable by moving the atomic_read inside the loc=
k,
> > > though.
> >=20
> > Right, I've ended up with the (as yet untested) below. I'll see if I can
> > find time later to actually test things.
>=20
> Latest hackery... I tried testing this but I'm not having luck using the
> patched wine as per the other email.
>=20

I converted the rest of the direct uses of spin_lock() using the below patc=
h=20
and tested it myself, and it passes Wine tests. As far as I can tell the lo=
gic=20
is correct, too; I couldn't find any races.

I'll incorporate these changes into the next revision, unless there's a goo=
d=20
reason not to.

=2D--
=2D-- a/drivers/misc/ntsync.c
+++ b/drivers/misc/ntsync.c
@@ -569,17 +569,19 @@ static int ntsync_event_set(struct ntsync_obj *event,=
=20
void __user *argp, bool pu
=20
 static int ntsync_event_reset(struct ntsync_obj *event, void __user *argp)
 {
+	struct ntsync_device *dev =3D event->dev;
 	__u32 prev_state;
+	bool all;
=20
 	if (event->type !=3D NTSYNC_TYPE_EVENT)
 		return -EINVAL;
=20
=2D	spin_lock(&event->lock);
+	all =3D ntsync_lock_obj(dev, event);
=20
 	prev_state =3D event->u.event.signaled;
 	event->u.event.signaled =3D false;
=20
=2D	spin_unlock(&event->lock);
+	ntsync_unlock_obj(dev, event, all);
=20
 	if (put_user(prev_state, (__u32 __user *)argp))
 		return -EFAULT;
@@ -590,16 +592,21 @@ static int ntsync_event_reset(struct ntsync_obj *even=
t,=20
void __user *argp)
 static int ntsync_sem_read(struct ntsync_obj *sem, void __user *argp)
 {
 	struct ntsync_sem_args __user *user_args =3D argp;
+	struct ntsync_device *dev =3D sem->dev;
 	struct ntsync_sem_args args;
+	bool all;
=20
 	if (sem->type !=3D NTSYNC_TYPE_SEM)
 		return -EINVAL;
=20
 	args.sem =3D 0;
=2D	spin_lock(&sem->lock);
+
+	all =3D ntsync_lock_obj(dev, sem);
+
 	args.count =3D sem->u.sem.count;
 	args.max =3D sem->u.sem.max;
=2D	spin_unlock(&sem->lock);
+
+	ntsync_unlock_obj(dev, sem, all);
=20
 	if (copy_to_user(user_args, &args, sizeof(args)))
 		return -EFAULT;
@@ -609,18 +616,23 @@ static int ntsync_sem_read(struct ntsync_obj *sem, vo=
id=20
__user *argp)
 static int ntsync_mutex_read(struct ntsync_obj *mutex, void __user *argp)
 {
 	struct ntsync_mutex_args __user *user_args =3D argp;
+	struct ntsync_device *dev =3D mutex->dev;
 	struct ntsync_mutex_args args;
+	bool all;
 	int ret;
=20
 	if (mutex->type !=3D NTSYNC_TYPE_MUTEX)
 		return -EINVAL;
=20
 	args.mutex =3D 0;
=2D	spin_lock(&mutex->lock);
+
+	all =3D ntsync_lock_obj(dev, mutex);
+
 	args.count =3D mutex->u.mutex.count;
 	args.owner =3D mutex->u.mutex.owner;
 	ret =3D mutex->u.mutex.ownerdead ? -EOWNERDEAD : 0;
=2D	spin_unlock(&mutex->lock);
+
+	ntsync_unlock_obj(dev, mutex, all);
=20
 	if (copy_to_user(user_args, &args, sizeof(args)))
 		return -EFAULT;
@@ -630,16 +642,21 @@ static int ntsync_mutex_read(struct ntsync_obj *mutex=
,=20
void __user *argp)
 static int ntsync_event_read(struct ntsync_obj *event, void __user *argp)
 {
 	struct ntsync_event_args __user *user_args =3D argp;
+	struct ntsync_device *dev =3D event->dev;
 	struct ntsync_event_args args;
+	bool all;
=20
 	if (event->type !=3D NTSYNC_TYPE_EVENT)
 		return -EINVAL;
=20
 	args.event =3D 0;
=2D	spin_lock(&event->lock);
+
+	all =3D ntsync_lock_obj(dev, event);
+
 	args.manual =3D event->u.event.manual;
 	args.signaled =3D event->u.event.signaled;
=2D	spin_unlock(&event->lock);
+
+	ntsync_unlock_obj(dev, event, all);
=20
 	if (copy_to_user(user_args, &args, sizeof(args)))
 		return -EFAULT;
@@ -962,6 +979,7 @@ static int ntsync_wait_any(struct ntsync_device *dev, v=
oid=20
__user *argp)
 	__u32 i, total_count;
 	struct ntsync_q *q;
 	int signaled;
+	bool all;
 	int ret;
=20
 	if (copy_from_user(&args, argp, sizeof(args)))
@@ -981,9 +999,9 @@ static int ntsync_wait_any(struct ntsync_device *dev, v=
oid=20
__user *argp)
 		struct ntsync_q_entry *entry =3D &q->entries[i];
 		struct ntsync_obj *obj =3D entry->obj;
=20
=2D		spin_lock(&obj->lock);
+		all =3D ntsync_lock_obj(dev, obj);
 		list_add_tail(&entry->node, &obj->any_waiters);
=2D		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
 	}
=20
 	/*
@@ -1000,9 +1018,9 @@ static int ntsync_wait_any(struct ntsync_device *dev,=
=20
void __user *argp)
 		if (atomic_read(&q->signaled) !=3D -1)
 			break;
=20
=2D		spin_lock(&obj->lock);
+		all =3D ntsync_lock_obj(dev, obj);
 		try_wake_any_obj(obj);
=2D		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
 	}
=20
 	/* sleep */
@@ -1015,9 +1033,9 @@ static int ntsync_wait_any(struct ntsync_device *dev,=
=20
void __user *argp)
 		struct ntsync_q_entry *entry =3D &q->entries[i];
 		struct ntsync_obj *obj =3D entry->obj;
=20
=2D		spin_lock(&obj->lock);
+		all =3D ntsync_lock_obj(dev, obj);
 		list_del(&entry->node);
=2D		spin_unlock(&obj->lock);
+		ntsync_unlock_obj(dev, obj, all);
=20
 		put_obj(obj);
 	}
@@ -1075,9 +1093,9 @@ static int ntsync_wait_all(struct ntsync_device *dev,=
=20
void __user *argp)
 		struct ntsync_q_entry *entry =3D &q->entries[args.count];
 		struct ntsync_obj *obj =3D entry->obj;
=20
=2D		spin_lock_nest_lock(&obj->lock, &dev->wait_all_lock);
+		dev_lock_obj(dev, obj);
 		list_add_tail(&entry->node, &obj->any_waiters);
=2D		spin_unlock(&obj->lock);
+		dev_unlock_obj(dev, obj);
 	}
=20
 	/* check if we are already signaled */
@@ -1095,9 +1113,9 @@ static int ntsync_wait_all(struct ntsync_device *dev,=
=20
void __user *argp)
 		struct ntsync_obj *obj =3D q->entries[args.count].obj;
=20
 		if (atomic_read(&q->signaled) =3D=3D -1) {
=2D			spin_lock(&obj->lock);
+			dev_lock_obj(dev, obj);
 			try_wake_any_obj(obj);
=2D			spin_unlock(&obj->lock);
+			dev_unlock_obj(dev, obj);
 		}
 	}
=20
@@ -1127,9 +1145,9 @@ static int ntsync_wait_all(struct ntsync_device *dev,=
=20
void __user *argp)
 		struct ntsync_q_entry *entry =3D &q->entries[args.count];
 		struct ntsync_obj *obj =3D entry->obj;
=20
=2D		spin_lock_nest_lock(&obj->lock, &dev->wait_all_lock);
+		dev_lock_obj(dev, obj);
 		list_del(&entry->node);
=2D		spin_unlock(&obj->lock);
+		dev_unlock_obj(dev, obj);
=20
 		put_obj(obj);
 	}




