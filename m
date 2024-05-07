Return-Path: <linux-kselftest+bounces-9570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77CF8BD8BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 02:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D6A1C22269
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 00:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34680138C;
	Tue,  7 May 2024 00:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="XyjeBPDv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CDA389;
	Tue,  7 May 2024 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715043138; cv=none; b=j3vCIsI41Kv33oWkJ2i/4hjfCogZWkeabJlTo9KTRKULAwzhlaHHZJIRiXVflYESicXfa/TUn/oRHVS3+GQtu7OkZqVW8KgXDEoMAL5/EqiMUnqIx1KzgF+Z3wrlrS9+0sJ6wT2uhAWUT74gcxYqI1AM7/tzbgMWbd3mhXb7A1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715043138; c=relaxed/simple;
	bh=0stx+ewjnR9CGCQ3QyccP+nXxnu5nDvOdTMiMFTSrsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ogbhKsd/X+tT/HLaCbAC4w8aLFVt5W5UkwHu3XFnog8rs56R+bRkzni5CVe/1g7VmAUT37CMgg0qJe+8Aa2i1Tm6EOlrq/RroLEAf4k0RomuTJ3PfnwPfSAyTAlKV40Ao5lofEp2AfL5Wn/Oy6YVY7V7owPCXLMCUE0KwI8pmJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=XyjeBPDv; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=yuieM5pWoXr+YclrzFb7svS//LQa/jXP2pIhgfolNkw=; b=XyjeBPDvYUzSDjEOjn8SxvJuAm
	VaZis4PYb9Vc/IvM+6wCjBEFkSQHHzK34beHoqVH0/LOeZQoQJOKmBQYz5mURVPWMJIYg3esfxaKp
	ozWkn4YyGvHD54t0o7eG+utZZtHmxFThN8loknbRv153iVBfGyjEujRyhBysMDJ66dbsRm5FGXxkW
	SSmhgI91Y0u3brgngfMLw8rWXIsjuW3D2nsz+8E0g711sjR3xwDbMFZsvQuWA9dt4TsGyq1FqIYMI
	3zx5KoV3uVO0JwEOlMvc5LgRKzsMU0uAgtYPN2CU2fURZDajYenR3hDmYhoe0h01mSZY+cbCCUF1B
	3spsCJLg==;
Received: from [10.69.139.6] (helo=watership.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1s48tC-00FgPg-0C;
	Mon, 06 May 2024 19:41:02 -0500
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Peter Zijlstra <peterz@infradead.org>, wine-devel@winehq.org
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
Date: Mon, 06 May 2024 19:40:45 -0500
Message-ID: <5199277.LvFx2qVVIh@watership>
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

It's also possible I made that build against a too-new distribution. I've=20
created a new build against Debian 12, which is hopefully better, and it ha=
s=20
some extra debug logging:

https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine2.tar.xz

Hopefully that's functional enough to test with, or at least give more a hi=
nt=20
as to why it doesn't work?



