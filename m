Return-Path: <linux-kselftest+bounces-10597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA708CCAB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 04:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9A2D1C2107B
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 02:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A55469D;
	Thu, 23 May 2024 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="qr2XdU4C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787A14690;
	Thu, 23 May 2024 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716431117; cv=none; b=uN1y0uCX/aFkpMzTFER7C/lkrYsTl2X5NwHGpGEhNzTUkgzOj2aKvzF3zs1Nrzo6DVa5LsFYr2YQbvPsUoVderc3Ts2ZQd1SVNA4Pl74O/AOPCH/S7Ww5Sq1zyg383IgG8Q1zdpc0qgDf45fRY0JRVxSjiV2Qp1ZGczkl+pvWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716431117; c=relaxed/simple;
	bh=O1CV/B9LphTJrxPOucqjkcv56j8RNm7CStUV/UI6DbA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lUe5W7V+77ARU3XMC9ulU8ukl6zOsYHFIzGbYkqnwcYl5MhSrFgZV4Kqu6MqcVMNv9P4T86S20HuoJh+oDoGbXURoxsK/qGOEhrqY8NWFOnUdvsn7eZ454Q5ePruPD71WfBb0fUnhlLNx4kXlerlmgTkZ0idS097yEMQCVrS+i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=qr2XdU4C; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1716431108; x=1716690308;
	bh=a8pilQrg+0LcR8JZ6a5Lw64IT07R5JeNXi2Sc07VtB4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qr2XdU4CmvcjXQ/Ji5hOJs60iVCpZlR9xiT9We0JAy9Yjj+ax6UIfDjmc5aqdhr64
	 GcXV8qVxcDNxWVu7WdGC3PYOscTDob5nKQz96ufHTs5TEjs+lWwLnbqm7C09QxOgJT
	 3qaeiW+IYKWObwAMfHomBt7CzbgN0gkztzQrn2sXK9Osb6sSUA4VPAOjkHo9IYy50n
	 Zz7i0J7hJ8IpzBtkR8E31TpIPqCxfXcDGKvjdv2lYmyMeBLsWc9zErIga3dB3jvyhE
	 XSRL17heXB/dRmFMqsgsK+HoawKRRi27a7b/YT5qvOuOcXPHbXojWMQIFRxV1DXhkZ
	 v18zdL41AXivA==
Date: Thu, 23 May 2024 02:25:04 +0000
To: Andrew Morton <akpm@linux-foundation.org>
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: Jeff Xu <jeffxu@google.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, dmitry.torokhov@gmail.com, dverkamp@chromium.org, hughd@google.com, jorgelo@chromium.org, skhan@linuxfoundation.org, keescook@chromium.org
Subject: Re: [PATCH v1] memfd: `MFD_NOEXEC_SEAL` should not imply `MFD_ALLOW_SEALING`
Message-ID: <1KDsEBw8g7ymBVpGJZp9NRH1HmCBsQ_jjQ_jKOg90gLUFhW5W6lcG-bI4-5OPkrD24RiG7G83VoZL4SXPQjfldsNFDg7bFnFFgrVZWwSWXQ=@protonmail.com>
In-Reply-To: <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
References: <20240513191544.94754-1-pobrn@protonmail.com> <CALmYWFt7MYbWrCDVEKH4DrMQGxaXA2kK8qth-JVxzkvMd6Ohtg@mail.gmail.com> <20240522162324.0aeba086228eddd8aff4f628@linux-foundation.org>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 5f6b9c478d44802fc89ce6227ae33d51f6a60db9
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi


2024. m=C3=A1jus 23., cs=C3=BCt=C3=B6rt=C3=B6k 1:23 keltez=C3=A9ssel, Andre=
w Morton <akpm@linux-foundation.org> =C3=ADrta:

> On Wed, 15 May 2024 23:11:12 -0700 Jeff Xu <jeffxu@google.com> wrote:
>=20
> > On Mon, May 13, 2024 at 12:15=E2=80=AFPM Barnab=C3=A1s P=C5=91cze <pobr=
n@protonmail.com> wrote:
> > >
> > > `MFD_NOEXEC_SEAL` should remove the executable bits and set
> > > `F_SEAL_EXEC` to prevent further modifications to the executable
> > > bits as per the comment in the uapi header file:
> > >
> > >   not executable and sealed to prevent changing to executable
> > >
> > > However, currently, it also unsets `F_SEAL_SEAL`, essentially
> > > acting as a superset of `MFD_ALLOW_SEALING`. Nothing implies
> > > that it should be so, and indeed up until the second version
> > > of the of the patchset[0] that introduced `MFD_EXEC` and
> > > `MFD_NOEXEC_SEAL`, `F_SEAL_SEAL` was not removed, however it
> > > was changed in the third revision of the patchset[1] without
> > > a clear explanation.
> > >
> > > This behaviour is suprising for application developers,
> > > there is no documentation that would reveal that `MFD_NOEXEC_SEAL`
> > > has the additional effect of `MFD_ALLOW_SEALING`.
> > >
> > Ya, I agree that there should be documentation, such as a man page. I w=
ill
> > work on that.
> >
> > > So do not remove `F_SEAL_SEAL` when `MFD_NOEXEC_SEAL` is requested.
> > > This is technically an ABI break, but it seems very unlikely that an
> > > application would depend on this behaviour (unless by accident).
> > >
> > > [0]: https://lore.kernel.org/lkml/20220805222126.142525-3-jeffxu@goog=
le.com/
> > > [1]: https://lore.kernel.org/lkml/20221202013404.163143-3-jeffxu@goog=
le.com/
> >
> > ...
> >
> > Reviewed-by: Jeff Xu <jeffxu@google.com>
>=20
> It's a change to a userspace API, yes?  Please let's have a detailed
> description of why this is OK.  Why it won't affect any existing users.

Yes, it is a uAPI change. To trigger user visible change, a program has to

 - create a memfd
   - with MFD_NOEXEC_SEAL,
   - without MFD_ALLOW_SEALING;
 - try to add seals / check the seals.

This change in essence reverts the kernel's behaviour to that of Linux <6.3=
, where
only `MFD_ALLOW_SEALING` enabled sealing. If a program works correctly on t=
hose
kernels, it will likely work correctly after this change.

I have looked through Debian Code Search and GitHub, searching for `MFD_NOE=
XEC_SEAL`.
And I could find only a single breakage that this change would case: dbus-b=
roker
has its own memfd_create() wrapper that is aware of this implicit `MFD_ALLO=
W_SEALING`
behaviour[0], and tries to work around it. This workaround will break. Luck=
ily,
however, as far as I could tell this only affects the test suite of dbus-br=
oker,
not its normal operations, so I believe it should be fine. I have prepared =
a PR
with a fix[1].


>=20
> Also, please let's give consideration to a -stable backport so that all
> kernel versions will eventually behave in the same manner.
>=20
>=20

I think that is a good idea, should I resend this with the `Cc: stable@...`=
 tag or
what should I do?


Regards,
Barnab=C3=A1s P=C5=91cze


[0]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f2=
67d4a8784cb/src/util/misc.c#L114
[1]: https://github.com/bus1/dbus-broker/pull/366

