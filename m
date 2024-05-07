Return-Path: <linux-kselftest+bounces-9569-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E1F8BD8BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 02:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F57283F8F
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 00:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8011138C;
	Tue,  7 May 2024 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="jvSsoX4H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C529389;
	Tue,  7 May 2024 00:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043040; cv=none; b=NBLMv0tibUvjbdoOTsR+CPIkLNxfsBoS7mk6/o18GXfVjixqqdz94Db5Mpt6feeKTXJDKdt9ZFTBbu3VF3Ar+KCh4eXYZLwnY91YQGcZypOEpOt0kYeCN3zkcSYFbksNmF0cBmL+QxmX661zwa+VVz0ckgAmi2lqQKQqGP5LPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043040; c=relaxed/simple;
	bh=ZFwYXSUEUJ7GtWn4g6K2L0ODS19vwoG9t774Aj8p1Ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CJAjmx6niz9q1ALccWlI3r8+XBI07cosm9xbfeg6p5Q8dqvrVI5yVyN4SHZmh0Yql1wf1nXQQ5aPCvKYzA2MBIe/i537JtjqDDQfqS8BNKs/xNRBxG82zSTIKOk7qf4xTKpSNX0ZC22WE5JYQfoh3si1G5fP7rXHvqKbdSbn844=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=jvSsoX4H; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=ZRma+TmGKw3NTq5BF25piq4ird9OossEUWl7xifP6as=; b=jvSsoX4HQtDd4ZWS8FuW7Csjj0
	vRkmivbaWCgzWBDvERJE/2jR2sqbPuMGBo7C//qSVgXGrQzqimil/U+QRsQAiHgd0bhlguC3SDgs3
	fwEeL7wROiuQsQ83dYpXM7/ZxYgxx6TOLFH2JbM/tXkG8AgiZKeppskKkVm5jbV4PU4WKwBKS3dle
	AgUqwtpHG2hjnnVhmTNodGRi5AkxiDU+I9l+sTADWodzS7/lEhSDKMWWUAVnq4XO56nMcCkSid8RK
	937Sh3ecNzUWXlgtJJCotaLAdm6Kp6h4xmjqM+Cb69Hns1MyMvChBh1uQ+HGGcCZlKBH43DVRqj+B
	Is6ZQG0A==;
Received: from [10.69.139.6] (helo=watership.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s492T-00Fgi0-0B;
	Mon, 06 May 2024 19:50:37 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: wine-devel@winehq.org, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Elizabeth Figura <zfigura@codeweavers.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Mon, 06 May 2024 19:50:34 -0500
Message-ID: <3923517.aeNJFYEL58@watership>
In-Reply-To: <4560699.LvFx2qVVIh@camazotz>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <20240419161611.GA23130@noisy.programming.kicks-ass.net>
 <4560699.LvFx2qVVIh@camazotz>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, April 19, 2024 3:46:07=E2=80=AFPM CDT Elizabeth Figura wrote:
> On Friday, 19 April 2024 11:16:11 CDT Peter Zijlstra wrote:
>=20
> > On Tue, Apr 16, 2024 at 05:18:56PM -0500, Elizabeth Figura wrote:
> >=20
> > > On Tuesday, 16 April 2024 16:18:24 CDT Elizabeth Figura wrote:
> > >=20
> > > > On Tuesday, 16 April 2024 03:14:21 CDT Peter Zijlstra wrote:
> > > >=20
> > > > > I don't support GE has it in his builds? Last time I tried,
> > > > > building
> > > > > Wine was a bit of a pain.
> > > >=20
> > > >=20
> > > > It doesn't seem so. I tried to build a GE-compatible ntsync build,
> > > > uploaded
 here (thanks Arek for hosting):
> > > >=20
> > > >=20
> > > >     https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine.tar.xz
> > >=20
> > >=20
> > > Oops, the initial version I uploaded had broken paths. Should be fixed
> > > now.
=20
> > > (It's also broken on an unpatched kernel unless explicitly disabled w=
ith
> > >=20
> > > WINE_DISABLE_FAST_SYNC=3D1. Not sure what I messed up there=E2=80=94i=
t should fall
> > > back=20
 cleanly=E2=80=94but hopefully shouldn't be too important for testing.)
> >=20
> >=20
> > So I've tried using that wine build with lutris, and I can't get it to
> > start EGS or anything else.
> >=20
> > I even added a printk to the ntsync driver for every open, to see if it
> > gets that far, but I'm not even getting that :/
>=20
>=20
> That's odd, it works for me, both as a standalone build and with
> lutris...
>=20
> Does /dev/ntsync exist (module is loaded) and have nonzero permissions?
> I forgot to mention that's necessary, sorry.
>=20
> Otherwise I can try to look at an strace, or a Wine debug log. I don't
> think there's an easy way to get the latter with Lutris, but something
> like `WINEDEBUG=3D+all ./wine winecfg 2>log` should work.
>=20
>=20

It's also possible that the build was made against too new libraries. I've=
=20
created a new build, built and tested on stock Debian 12, and with some ext=
ra=20
debugging:

https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine2.tar.xz

Hopefully that's good enough to test with, or at least gives more of a hint=
 as=20
to why it fails?



