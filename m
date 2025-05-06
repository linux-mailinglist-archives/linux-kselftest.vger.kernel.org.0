Return-Path: <linux-kselftest+bounces-32523-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E7BAACC7C
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E01A3BB4B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF12284B2A;
	Tue,  6 May 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koXQwthn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA3024166D;
	Tue,  6 May 2025 17:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553789; cv=none; b=WeSBEYewae3GfFvIBLp06wJ3NEK2xs/ui3a+hqBgtZ65Hzxbmm8CEupfgoPiUA59IPmHVjS6fsl6Ikmif5+xMA2MG4eUbLGbv58NGg59MDI3sGiIxhlqyL8Qbdc5pOdR6J1cdov7joNRQTT5KR23HWk/cBSeLlYDvdEbNZ2G6oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553789; c=relaxed/simple;
	bh=HxQaz8h7QlrV6FrmS0RXQ2Cl1/gSYYAu81d0EvJmUQk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jDYY3TD1JcnW9Yof4dwZBLUg+arnYC9idQUi8CQrVUEceCke129WvMpiS25QaWaYzM76BaM3hyrlspP/fny9dYeIZVOXW0jPWeHphPAKnPLPuyw0dkbM8Yt/2qakXASh6ZTr69mIIaPVyjct+uNUUBP6IgcOfQZOg7TTJyKPbNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koXQwthn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAB4C4CEE4;
	Tue,  6 May 2025 17:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746553789;
	bh=HxQaz8h7QlrV6FrmS0RXQ2Cl1/gSYYAu81d0EvJmUQk=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=koXQwthnQuhIC2BX+myHvapaUnphkNQA5YznqrUeSbRpbo66I4BkWZNY+4yVftzCr
	 ntSVGM5j1pDWthOOf7dSsNVG3pTe1iQNq9SiLGB8AUgtqQeCzsNYSb0WZE1kyrpGfK
	 /EdvrY7PkJ5xFM1dn4hD9q0sNqLD7lQskIr6OGr2XuJY3o2heV4FZw/65teCf9g90E
	 22eIW+EI4hbTSfIQpFmLsn6btdOQmJ0soQd8TK6atN/m8qZQBXzcsJV12FM7vuAvOH
	 zqp6mHkG/KM8h6aKDjgfFRhOofmRVGoGc2uXaPY5FS7csL4aC/rQ+e8dK2yD0kJm4k
	 eOuw/jGRtqlMg==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 6 May 2025 20:49:41 +0300 (EEST)
To: Paolo Abeni <pabeni@redhat.com>
cc: chia-yu.chang@nokia-bell-labs.com, horms@kernel.org, dsahern@kernel.org, 
    kuniyu@amazon.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
    dave.taht@gmail.com, jhs@mojatatu.com, kuba@kernel.org, 
    stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
    davem@davemloft.net, edumazet@google.com, andrew+netdev@lunn.ch, 
    donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com
Subject: Re: [PATCH v5 net-next 09/15] tcp: accecn: AccECN option
In-Reply-To: <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org>
Message-ID: <eaa2db1a-dc4f-55f6-c7ef-573acf46c214@kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250422153602.54787-10-chia-yu.chang@nokia-bell-labs.com> <d0969c3d-e33c-472e-815d-70b333990b39@redhat.com> <412724ed-f5a0-9749-8c50-4dd76afd4140@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-599366579-1746553781=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-599366579-1746553781=:1002
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 6 May 2025, Ilpo J=E4rvinen wrote:
> On Tue, 29 Apr 2025, Paolo Abeni wrote:
> > On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:

> > > @@ -1117,6 +1235,17 @@ static unsigned int tcp_established_options(st=
ruct sock *sk, struct sk_buff *skb
> > >  =09=09opts->num_sack_blocks =3D 0;
> > >  =09}
> > > =20
> > > +=09if (tcp_ecn_mode_accecn(tp) &&
> > > +=09    sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> > > +=09=09int saving =3D opts->num_sack_blocks > 0 ? 2 : 0;
> > > +=09=09int remaining =3D MAX_TCP_OPTION_SPACE - size;
> >=20
> > AFACS the above means tcp_options_fit_accecn() must clear any already
> > set options, but apparently it does not do so. Have you tested with
> > something adding largish options like mptcp?
>=20
> This "fitting" for AccEcn option is not to make room for the option but t=
o=20
> check if AccECN option fits and in what length, and how it can take=20
> advantage of some nop bytes when available to save option space.

A minor correction. SACK blocks will naturally fill the entire option=20
space if there are enough holes which would "starve" AccECN from using=20
option space during loss recovery. Thus, AccECN option is allowed allowed
grab some of that space from SACK. There's redundancy in SACK blocks=20
anyway so it shouldn't usually impact SACK signal much.

--=20
 i.

--8323328-599366579-1746553781=:1002--

