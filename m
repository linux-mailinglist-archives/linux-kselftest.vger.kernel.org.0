Return-Path: <linux-kselftest+bounces-33763-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330CCAC381A
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 04:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03A8C3B066E
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 02:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1825C17A316;
	Mon, 26 May 2025 02:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxwNn8cY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F65EEEBA;
	Mon, 26 May 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748227982; cv=none; b=U+SlBwLZYROUGdwZDp9ArdU8xWGgHjHaKNyu+8LQtRCuO8B9UrvRL6O4AQpsIF6iSGCQH/cs7cWPXh2ef75hy2N4aLlD8SCFQJTkFMp+S390VFktjajoti0PoKehMKr0sAzFaBNjDZxIJGWvG6oO34gDHFlXcM18u078z5BrylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748227982; c=relaxed/simple;
	bh=Ic3rldhFd7J/0KTpMZOiNrtnmtzUni0MW27IMQUHTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UP2ceDDPIWT+BhLZpoqu2dZZ6M2ZkKShn1J5ERJ9H3e9EeBmlR8Du02qAtLcIjT+rUsWQW8tLKyYcmk7ICduvhwzSgpB8o3X0FDE8b2WhpHyg7Aml1Ar2M3nVz6Do4RJQ9kFYOEyWHDahWdriItvdKi2UW6AGPF1AFxjIhLIPmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxwNn8cY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-234488c2ea6so6644355ad.3;
        Sun, 25 May 2025 19:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748227980; x=1748832780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ic3rldhFd7J/0KTpMZOiNrtnmtzUni0MW27IMQUHTm0=;
        b=HxwNn8cYTu75b2Eo4dePgJBhyJLjGTsbZuQ3qtui8bEPMFcL4aR7ruuG0hrzZ33TxW
         WeokqgkTctUNVd9DYrbxrqOCP8iKS9e4jDX6yZu5mHAp4XarFmQXLjL1NaxZE+o/KkhK
         xJ7EG1tgxXbsJfykb4Cmg9aYXm/TvGt8v0Uv4oYWTTzfeSrRsRlHSX0eT5rxdl0H/wtb
         c6CEgG+jZyzkrJJzIntrNtTm+MZEXLMNZPuO8yrrf1H8hPtZfy0d7WWNQjtrCmoi9fRO
         WlPXcrKUE3ghx5FYeG+PE3eh96gIYPrKb6ojw4LGlIKPQx8RCYI6S98a1lNOHV7zyGpB
         PQ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748227980; x=1748832780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ic3rldhFd7J/0KTpMZOiNrtnmtzUni0MW27IMQUHTm0=;
        b=my341+NaDmXwO7Bg1o2ZITiCXRg3Uj4YTxfFKw36MYbr8BwCLwAQFo2B/93VKsZvYV
         ZJtSKCXq+/fBYitLbY7xiEtFSh4RnZA20dmhXBObkcoi3JuQuFdBNzlDM/BKlfb2wmWQ
         hitGtYiXmRZod6t53tcnUGfbUaJGIDGOYINo6Pt5UT/qTu1rfXVtRlnjO0sgX1piZ+cn
         quT2+1xahla/NIBSZUQ+tq69lafTw2dqGG1vfophGsNmeEIz7JhxiIQmQxPS2oXYqVOS
         +gOXDp0ZwM65Baso6S/q+xXdlNJe/0V6XD/bY0wbW4GzFuMHy4ngpo6z12AHF3ChYAa2
         XIvA==
X-Forwarded-Encrypted: i=1; AJvYcCVTr6+rg8m88PAYPDhN2z7SOP04lrp0sbIjQDDxfZ9oWE4GDGza7vpTwnCWCnLYU3Oy+S2UoIAkuTgc@vger.kernel.org, AJvYcCWmrqs4ptY7tqnwnK/eAYn2PdZ+b6Q4uIQURRhUplAApLQB8jDnDU/stP1MVEVhWEctYlSo803V5qF4sRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM6vnjSJUihxG/YdGUxjyBeTX4DrnSnkWFcJq6nciAhVr4buC5
	AF1aSpy5mY7LXkBQFDFBaq4vjEjOIcQmDWIC2b4RHyKEFY0Hg9d3AAzaeJTgzQ==
X-Gm-Gg: ASbGnctz5uHid3wq3q7oI2D2CVvL8RMWOTS7763mCH8gdemt1B88V3y23XL/dfqfk9X
	bwt/XjeFdvgRqE5WBNTFBca+Es1VRUpVZxDFJamcMaQ9Z1QleOqmggAt82V211m13m1Wt9FMR+G
	94GI8GCTIKBp11c+b9ubqxwNNGl0Nx3c00R4A59PkWTR4TcUyjYU/1vkO6KM1Hv4k7Jg4DN8pVz
	CEBM0Appv/rPMoSDwtjO1feaUzdci6ie7NtSdFXPCOWww/ouDAu840wJxsVKsgHTeD+DFHkKjTd
	GLha7pTEIjBdxaTNH5kYcIvHO+AUBSH8BPPFDeES6rOZS6Jn5S8=
X-Google-Smtp-Source: AGHT+IFVqieLEMKMolbdEk2hFuaJxR+SVCi4ml94UHnzMDO+wHx4vUPHJjf5BqVxIrT2nDpGebPf3w==
X-Received: by 2002:a17:903:4b30:b0:231:d16c:7f55 with SMTP id d9443c01a7336-23414ea1745mr116001445ad.0.1748227979506;
        Sun, 25 May 2025 19:52:59 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4eedb92sm158201015ad.258.2025.05.25.19.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 May 2025 19:52:58 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D0A084209E8A; Mon, 26 May 2025 09:52:56 +0700 (WIB)
Date: Mon, 26 May 2025 09:52:56 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Hanne-Lotta =?utf-8?B?TcOkZW5ww6TDpA==?= <hannelotta@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
	alexandre.belloni@bootlin.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rtc@vger.kernel.org
Subject: Re: [PATCH v2] selftests: Improve test output grammar, code style
Message-ID: <aDPXiE4z1_fejuy3@archie.me>
References: <20250516084233.66594-1-hannelotta@gmail.com>
 <9d502cef-b2cb-4309-b268-7c75f8451833@linuxfoundation.org>
 <ff076589-4a93-4e4c-8e85-77499e27898c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IsOyzGd2L+s1ut4R"
Content-Disposition: inline
In-Reply-To: <ff076589-4a93-4e4c-8e85-77499e27898c@gmail.com>


--IsOyzGd2L+s1ut4R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 09:27:31PM +0300, Hanne-Lotta M=C3=A4enp=C3=A4=C3=
=A4 wrote:
> Hello,
>=20
> On 5/23/25 01:14, Shuah Khan wrote:
> > On 5/16/25 02:42, Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 wrote:
> > > Add small grammar fixes in perf events and Real Time Clock tests'
> > > output messages.
> > >=20
> > > Include braces around a single if statement, when there are multiple
> > > statements in the else branch, to align with the kernel coding style.
> >=20
> > This patch combines several changes in one including combining changes
> > to two tests.
> >=20
> > >=20
> > > Signed-off-by: Hanne-Lotta M=C3=A4enp=C3=A4=C3=A4 <hannelotta@gmail.c=
om>
> > > ---
> > >=20
> > > Notes:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 v1 -> v2: Improved wording in RTC tests base=
d on feedback from
> > > =C2=A0=C2=A0=C2=A0=C2=A0 Alexandre Belloni <alexandre.belloni@bootlin=
=2Ecom>
> > >=20
> > > =C2=A0 tools/testing/selftests/perf_events/watermark_signal.c |=C2=A0=
 7 ++++---
> > > =C2=A0 tools/testing/selftests/rtc/rtctest.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 +++++-----
> > > =C2=A0 2 files changed, 9 insertions(+), 8 deletions(-)
> > >=20
> >=20
> > Send separate patches for selftests/perf_events and selftests/rtc/rtcte=
st.c
>=20
> Sure, I can do that. If I split this patch into two, is it OK to send the
> other patch as a new one (without version history)? Or should I send both
> patches converted to a patch series (v3)?

Send both patches as a series.

> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto cleanup;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > diff --git a/tools/testing/selftests/rtc/rtctest.c b/tools/testing/
> > > selftests/rtc/rtctest.c
> > > index be175c0e6ae3..930bf0ce4fa6 100644
> > > --- a/tools/testing/selftests/rtc/rtctest.c
> > > +++ b/tools/testing/selftests/rtc/rtctest.c
> > > @@ -138,10 +138,10 @@ TEST_F_TIMEOUT(rtc, date_read_loop,
> > > READ_LOOP_DURATION_SEC + 2) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtc_read =3D r=
tc_time_to_timestamp(&rtc_tm);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Time should=
 not go backwards */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_LE(prev=
_rtc_read, rtc_read);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Time should not increa=
se more then 1s at a time */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Time should not increa=
se more than 1s per read */
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_GE(prev=
_rtc_read + 1, rtc_read);
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sleep 11ms to avoid ki=
lling / overheating the RTC */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Sleep 11ms to avoid ov=
erheating the RTC */
> >=20
> > This change removes important information. What is the reason for this
> > change?
>=20
> Well, it is less verbose and still informative (avoiding overheating). I =
can
> leave out this change, though.

s/then/than/ typofix should be kept.

>=20
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nanosleep_with=
_retries(READ_LOOP_SLEEP_MS * 1000000);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prev_rtc_read =
=3D rtc_read;
> > > @@ -236,7 +236,7 @@ TEST_F(rtc, alarm_alm_set) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alarm_state =3D=3D RTC_ALARM_DISAB=
LED)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "=
Skipping test since alarms are not supported.");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alarm_state =3D=3D RTC_ALARM_RES_M=
INUTE)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "Skipping te=
st since alarms has only minute
> > > granularity.");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "Skipping te=
st since alarm has only minute
> > > granularity.");
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rc =3D ioctl(self->fd, RTC_RD_TIME, &t=
m);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ASSERT_NE(-1, rc);
> > > @@ -306,7 +306,7 @@ TEST_F(rtc, alarm_wkalm_set) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alarm_state =3D=3D RTC_ALARM_DISAB=
LED)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "=
Skipping test since alarms are not supported.");
> >=20
> > This one still says "alarms"
>=20
> Yes, because "alarms are not supported" refers to alarms as a feature.

Disambiguate (like "alarms feature is not supported")?

>=20
> >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (alarm_state =3D=3D RTC_ALARM_RES_M=
INUTE)
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "Skipping te=
st since alarms has only minute
> > > granularity.");
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SKIP(return, "Skipping te=
st since alarm has only minute
> > > granularity.");
> >=20
> > Isn't "alarms" consistent with other messages?
>=20
> Yes, plural "alarms" would be consistent with other messages, and when
> referring to them as a feature. The verb form should then change, either:
>=20
> - alarm has ... OR
> - alarms have ...
>=20
> In the test, only one alarm is set - it makes sense to refer to it as
> singular. I received feedback regarding this from Alexandre, because I had
> plural form in the first version of this patch.

I would rather write the message as "Skipping test since the alarm has ..."

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--IsOyzGd2L+s1ut4R
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaDPXiAAKCRD2uYlJVVFO
o8rkAP9VqUjGfIEBUq/vNPbcUN3yntOSa1bmt36Z/68JmexfNwD/eqj+VVhucR13
q03PPGj6Ewtp0eenY+3VDF/9xIaKigc=
=oeJ+
-----END PGP SIGNATURE-----

--IsOyzGd2L+s1ut4R--

