Return-Path: <linux-kselftest+bounces-8480-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 450B68AB619
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 22:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E58D1C212F0
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Apr 2024 20:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD00E29D08;
	Fri, 19 Apr 2024 20:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="fR9v3p+z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6802229CE5;
	Fri, 19 Apr 2024 20:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559581; cv=none; b=D4jite2ZiTQdsOGGx7UUM23yZYnjyOC5nLKI9WPMNeQRboxVjyCF7FwA6HbiG2/cCElJNIfuVu+eXvQwEsIF0VCVbEy81bLDXafi+sejbV4G+x3A2RwbFqhcHCxX6T0BEPteG1WmXL0VFG4mg48jd9YjIqeYl4qDoQQZTmRVPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559581; c=relaxed/simple;
	bh=Q0n2p3Gl2XGwFRL69wM+4Pn8DrdIQvix54nl3TqcDfI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYnhi/OzRzzfGL5LxbED5XEctWb/2+xE54e5HaTiGYk+UZBJkZPjjILic0FZSSo/YQEDV0BS3VUkWIbuyrPOenMmO7WQUSmeZJNuDmr6riBjbnMjKLywPQUtQJf9itR8/J9f3Pidz5gcAoakDjem0bFq5XKaUyz9DpwRnXtiOiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=fR9v3p+z; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=5p2yQvQe15hu1/dZghXrbNWOB2J/4kqzCzCcLTivdwE=; b=fR9v3p+zjVf9sCIqkYiQdMIBvS
	FQWQVZ71cUCDyVhziOVnArmJjPymIm2os81/0UHq/3QVttuvtt4/WXtfa2arno+JquVqpETCQzu8j
	WEN74vvkg3kh8B+URuhpz+FpbM+nnmYSrkz5OW0/2pXVxXHgAkkcPhbb+T+jF7DkFSdA6NXxkHGb2
	a8ZtvB9ROZMZAbLXO8w6xshaP/5lW+FZ6GPMvA+V/fP0/CXdGFYcJFAQL2RQdTIJ3p0Fu0lVgABRx
	GMqAq0xAcPtwtt+QZBQXBARwETz2JXk+TFEI9Ip6q/TsffEH+Wpu2x5I8J6Ka3l5B306VEtmGY9Kw
	zf83hOmQ==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rxv7X-001bTU-1M;
	Fri, 19 Apr 2024 15:46:07 -0500
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
 Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v4 00/30] NT synchronization primitive driver
Date: Fri, 19 Apr 2024 15:46:07 -0500
Message-ID: <4560699.LvFx2qVVIh@camazotz>
In-Reply-To: <20240419161611.GA23130@noisy.programming.kicks-ass.net>
References:
 <20240416010837.333694-1-zfigura@codeweavers.com>
 <3743440.MHq7AAxBmi@terabithia>
 <20240419161611.GA23130@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Friday, 19 April 2024 11:16:11 CDT Peter Zijlstra wrote:
> On Tue, Apr 16, 2024 at 05:18:56PM -0500, Elizabeth Figura wrote:
> > On Tuesday, 16 April 2024 16:18:24 CDT Elizabeth Figura wrote:
> > > On Tuesday, 16 April 2024 03:14:21 CDT Peter Zijlstra wrote:
> > > > I don't support GE has it in his builds? Last time I tried, building
> > > > Wine was a bit of a pain.
> > >=20
> > > It doesn't seem so. I tried to build a GE-compatible ntsync build, up=
loaded
> > > here (thanks Arek for hosting):
> > >=20
> > >     https://f002.backblazeb2.com/file/wine-ntsync/ntsync-wine.tar.xz
> >=20
> > Oops, the initial version I uploaded had broken paths. Should be fixed =
now.
> >=20
> > (It's also broken on an unpatched kernel unless explicitly disabled wit=
h=20
> > WINE_DISABLE_FAST_SYNC=3D1. Not sure what I messed up there=E2=80=94it =
should fall back=20
> > cleanly=E2=80=94but hopefully shouldn't be too important for testing.)
>=20
> So I've tried using that wine build with lutris, and I can't get it to
> start EGS or anything else.
>=20
> I even added a printk to the ntsync driver for every open, to see if it
> gets that far, but I'm not even getting that :/

That's odd, it works for me, both as a standalone build and with
lutris...

Does /dev/ntsync exist (module is loaded) and have nonzero permissions?
I forgot to mention that's necessary, sorry.

Otherwise I can try to look at an strace, or a Wine debug log. I don't
think there's an easy way to get the latter with Lutris, but something
like `WINEDEBUG=3D+all ./wine winecfg 2>log` should work.



