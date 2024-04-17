Return-Path: <linux-kselftest+bounces-8269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D75058A8C97
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 22:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BC511F22967
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 20:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E3647F7C;
	Wed, 17 Apr 2024 20:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="P1f3RaYc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D641C7C;
	Wed, 17 Apr 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713384190; cv=none; b=Jsn+b/kuZDMGT1oGoPfbhBl6fu4duMtk4GPmE3TbvTV2p5wjbZ4fndlGTFBzHcJuCQk815QyAOeNKzPq4togTFj+LsYQ1Zzlv3i+HTz3Wsa0l8EfnDBmH7asbtG8g+LNg8LmYTgyYasJRqolY14YdFoRpEHcjE42Oim77U4r2+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713384190; c=relaxed/simple;
	bh=1gUuVn+QjUd7F5bm51RwKzR6j6BmbQzEDGn5JENwhyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=euCeY19nJTf2cp1TmWC2DGO+7rSHMjtn9zp1sPk8eWO5FfYKhaa3saYXfh3M8l2pe3Ssejh+L5lfqPSFk733ic2Vp+CPpcO1Pc4lqV/XhyOSfP0IzFzCOhYE8l/89zT3UsQSQj+27XfkzmwELCHqzA7CczlQzjEyfL/54rlqT/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=P1f3RaYc; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=8xZy/0NtF+dV+KHcJxF6iRNziuvt+mIUzs1R/Wc34/k=; b=P1f3RaYcYjmQe13JJtjSwquN0U
	U4p4slLzfeBTaq/2KgWu+sL0pIHjRSKxKTGGdt7yYjj9++wr68kfwE5+WrCm7qWqgCWmuh4l4Wlkg
	ibi9u/l/QNtS9BMqlDHfkItTqOWIqTR1qvYMBvdN9gmTKo4y/K0l4rLpMpZR1lLUT/P/PWvKXiRVY
	Abq5b+5glRFq0RcQYJTL1QKMSd0EQbu8PHwcFsLhpts2Y0xOfZcicDWeWvmpGdn5MxIyw++A4GZkk
	/27UKEb1GyF9ARASBfGcnfYPftM4BH+jg5O62lcjreJ/aPYCoYFkwlC7WA0Xg/JY3Ph04Ovzwn3+Y
	lFXytdEA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rxBUn-00HOiY-26;
	Wed, 17 Apr 2024 15:03:07 -0500
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
Date: Wed, 17 Apr 2024 15:03:05 -0500
Message-ID: <3479054.QJadu78ljV@camazotz>
In-Reply-To: <20240417113703.GL30852@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240416010837.333694-3-zfigura@codeweavers.com>
 <20240417113703.GL30852@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 17 April 2024 06:37:03 CDT Peter Zijlstra wrote:
> On Mon, Apr 15, 2024 at 08:08:12PM -0500, Elizabeth Figura wrote:
> > +	if (atomic_read(&sem->all_hint) > 0) {
> > +		spin_lock(&dev->wait_all_lock);
> > +		spin_lock_nest_lock(&sem->lock, &dev->wait_all_lock);
> > =20
> > +		prev_count =3D sem->u.sem.count;
> > +		ret =3D post_sem_state(sem, args);
> > +		if (!ret) {
> > +			try_wake_all_obj(dev, sem);
> > +			try_wake_any_sem(sem);
> > +		}
> > =20
> > +		spin_unlock(&sem->lock);
> > +		spin_unlock(&dev->wait_all_lock);
> > +	} else {
> > +		spin_lock(&sem->lock);
> > +
> > +		prev_count =3D sem->u.sem.count;
> > +		ret =3D post_sem_state(sem, args);
> > +		if (!ret)
> > +			try_wake_any_sem(sem);
> > +
> > +		spin_unlock(&sem->lock);
> > +	}
> > =20
> >  	if (!ret && put_user(prev_count, user_args))
> >  		ret =3D -EFAULT;
>=20
> vs.
>=20
> > +	/* queue ourselves */
> > +
> > +	spin_lock(&dev->wait_all_lock);
> > +
> > +	for (i =3D 0; i < args.count; i++) {
> > +		struct ntsync_q_entry *entry =3D &q->entries[i];
> > +		struct ntsync_obj *obj =3D entry->obj;
> > +
> > +		atomic_inc(&obj->all_hint);
> > +
> > +		/*
> > +		 * obj->all_waiters is protected by dev->wait_all_lock rather
> > +		 * than obj->lock, so there is no need to acquire obj->lock
> > +		 * here.
> > +		 */
> > +		list_add_tail(&entry->node, &obj->all_waiters);
> > +	}
>=20
> This looks racy, consider:
>=20
> 	atomic_read(all_hints) /* 0 */
>=20
> 				spin_lock(wait_all_lock)
> 				atomic_inc(all_hint)	/* 1 */
> 				list_add_tail()
>=20
> 	spin_lock(sem->lock)
> 	/* try_wake_all_obj() missing */
>=20
>=20
>=20
>=20
> I've not yet thought about if this is harmful or not, but if not, it
> definitely needs a comment.
>=20
> Anyway, I need a break, maybe more this evening.

Ach. I wrote this with the idea that the race isn't meaningful, but
looking at it again you're right=E2=80=94there is a harmful race here.

I think it should be fixable by moving the atomic_read inside the lock,
though.



