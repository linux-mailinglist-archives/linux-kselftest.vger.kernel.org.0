Return-Path: <linux-kselftest+bounces-32458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DDAAB0A4
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 05:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33561BA115B
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 May 2025 03:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F4316DD3;
	Mon,  5 May 2025 23:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpggm2qF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8C939FE62;
	Mon,  5 May 2025 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487608; cv=none; b=u9mcmbC+18wNkCDcqkEz/dFMMhgmEk0Lzh+0VtpVGDDsGcwDYlegUNBssAi1Gl93/5vWRGsDmzm/7SQGBtjIF4sJKkBoQk0XpUWNz3cO+ptSFzSEyn7PWkv06IxOCfVA8swEUi9+KnpoSmIjxmK2qEhisKWzemN2gCs1etzGqgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487608; c=relaxed/simple;
	bh=NI1weFRp69aLLX3aQNP5hOOXCfiH/cY1nvFD2lXLJos=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GjT8RaZooCA2a9+HQBsymyz9YTinoIsHWLWtfKzbX6Q7wvOJwEqs1McSkXNB3FE6nud92PHn9mCnEqhoT1R0EJyYKxAgrajryAUWuKG4Klsu9mLD78QTqtWFRILyHko06uqaT42grQMrBDZpMjOTIbwe5cviMRkzAfEAMb/3baY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpggm2qF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7EBC4CEED;
	Mon,  5 May 2025 23:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487607;
	bh=NI1weFRp69aLLX3aQNP5hOOXCfiH/cY1nvFD2lXLJos=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=qpggm2qFTv2HfZCl2OEOa7+ajxaQ18zXfV/NHSCmP2wAaoh1dGnlQ591oD/KMj6u6
	 yW279w7wCDpmecW+FOX1fND5TK+a0xIHHpKbZjvfCj14nDC8OAk/aN00hMbLccORJC
	 NE7Q1kYcAa1/n1Or3h24i3sML8izsaE/DChwZh/ABWpiadIvts4XDxW7xvv2T0SBqx
	 7UwtSASjoztoTKvaNZiIHUZ4Q86eB20DETPPHtdNCBOnMGf21olqitYWp7fFJi1xY/
	 VLXx1qa5dp33htO9/OkED0e/8bZGhSqln9B+1U8ARlnEZFh/qLsMDF6CJRLmIsThOy
	 1bjIaLgu005Rw==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Tue, 6 May 2025 02:26:41 +0300 (EEST)
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
cc: Paolo Abeni <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>, 
    "dsahern@kernel.org" <dsahern@kernel.org>, 
    "kuniyu@amazon.com" <kuniyu@amazon.com>, 
    "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
    "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
    "dave.taht@gmail.com" <dave.taht@gmail.com>, 
    "jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
    "stephen@networkplumber.org" <stephen@networkplumber.org>, 
    "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, 
    "jiri@resnulli.us" <jiri@resnulli.us>, 
    "davem@davemloft.net" <davem@davemloft.net>, 
    "edumazet@google.com" <edumazet@google.com>, 
    "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
    "donald.hunter@gmail.com" <donald.hunter@gmail.com>, 
    "ast@fiberby.net" <ast@fiberby.net>, 
    "liuhangbin@gmail.com" <liuhangbin@gmail.com>, 
    "shuah@kernel.org" <shuah@kernel.org>, 
    "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
    "ncardwell@google.com" <ncardwell@google.com>, 
    "Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
    "g.white" <g.white@cablelabs.com>, 
    "ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
    "mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, 
    "cheshire@apple.com" <cheshire@apple.com>, 
    "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
    "Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, 
    vidhi_goel <vidhi_goel@apple.com>
Subject: RE: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send
 control
In-Reply-To:  <PAXPR07MB79845AAB1468B67FE9BD2EDCA38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Message-ID: <9d741b0d-fff8-5565-f6e7-491a1d0928f7@kernel.org>
References: <20250422153602.54787-1-chia-yu.chang@nokia-bell-labs.com> <20250422153602.54787-11-chia-yu.chang@nokia-bell-labs.com> <0a5c7897-ed95-4198-9896-ddae64335083@redhat.com> 
 <PAXPR07MB79845AAB1468B67FE9BD2EDCA38E2@PAXPR07MB7984.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1936862257-1746487601=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1936862257-1746487601=:1002
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 5 May 2025, Chia-Yu Chang (Nokia) wrote:

> > -----Original Message-----
> > From: Paolo Abeni <pabeni@redhat.com>=20
> > Sent: Tuesday, April 29, 2025 2:10 PM
> > To: Chia-Yu Chang (Nokia) <chia-yu.chang@nokia-bell-labs.com>; horms@ke=
rnel.org; dsahern@kernel.org; kuniyu@amazon.com; bpf@vger.kernel.org; netde=
v@vger.kernel.org; dave.taht@gmail.com; jhs@mojatatu.com; kuba@kernel.org; =
stephen@networkplumber.org; xiyou.wangcong@gmail.com; jiri@resnulli.us; dav=
em@davemloft.net; edumazet@google.com; andrew+netdev@lunn.ch; donald.hunter=
@gmail.com; ast@fiberby.net; liuhangbin@gmail.com; shuah@kernel.org; linux-=
kselftest@vger.kernel.org; ij@kernel.org; ncardwell@google.com; Koen De Sch=
epper (Nokia) <koen.de_schepper@nokia-bell-labs.com>; g.white <g.white@cabl=
elabs.com>; ingemar.s.johansson@ericsson.com; mirja.kuehlewind@ericsson.com=
; cheshire@apple.com; rs.ietf@gmx.at; Jason_Livingood@comcast.com; vidhi_go=
el <vidhi_goel@apple.com>
> > Subject: Re: [PATCH v5 net-next 10/15] tcp: accecn: AccECN option send =
control
> >=20
> >=20
> > CAUTION: This is an external email. Please be very careful when clickin=
g links or opening attachments. See the URL nok.it/ext for additional infor=
mation.
> >=20
> >=20
> >=20
> > On 4/22/25 5:35 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > >
> > > Instead of sending the option in every ACK, limit sending to those=20
> > > ACKs where the option is necessary:
> > > - Handshake
> > > - "Change-triggered ACK" + the ACK following it. The
> > >   2nd ACK is necessary to unambiguously indicate which
> > >   of the ECN byte counters in increasing. The first
> > >   ACK has two counters increasing due to the ecnfield
> > >   edge.
> > > - ACKs with CE to allow CEP delta validations to take
> > >   advantage of the option.
> > > - Force option to be sent every at least once per 2^22
> > >   bytes. The check is done using the bit edges of the
> > >   byte counters (avoids need for extra variables).
> > > - AccECN option beacon to send a few times per RTT even if
> > >   nothing in the ECN state requires that. The default is 3
> > >   times per RTT, and its period can be set via
> > >   sysctl_tcp_ecn_option_beacon.
> > >
> > > Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> > > Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> > > ---
> > >  include/linux/tcp.h        |  3 +++
> > >  include/net/netns/ipv4.h   |  1 +
> > >  include/net/tcp.h          |  1 +
> > >  net/ipv4/sysctl_net_ipv4.c |  9 ++++++++
> > >  net/ipv4/tcp.c             |  5 ++++-
> > >  net/ipv4/tcp_input.c       | 36 +++++++++++++++++++++++++++++++-
> > >  net/ipv4/tcp_ipv4.c        |  1 +
> > >  net/ipv4/tcp_minisocks.c   |  2 ++
> > >  net/ipv4/tcp_output.c      | 42 ++++++++++++++++++++++++++++++------=
--
> > >  9 files changed, 90 insertions(+), 10 deletions(-)

> > > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c index=20
> > > 3f3e285fc973..2e95dad66fe3 100644
> > > --- a/net/ipv4/tcp_ipv4.c
> > > +++ b/net/ipv4/tcp_ipv4.c
> > > @@ -3451,6 +3451,7 @@ static int __net_init tcp_sk_init(struct net=20
> > > *net)  {
> > >       net->ipv4.sysctl_tcp_ecn =3D 2;
> > >       net->ipv4.sysctl_tcp_ecn_option =3D 2;
> > > +     net->ipv4.sysctl_tcp_ecn_option_beacon =3D 3;
> > >       net->ipv4.sysctl_tcp_ecn_fallback =3D 1;
> >=20
> > Human readable macros instead of magic numbers could help.
>=20
> OK, commments will be added here.

Hi,

Using named defines to replace literals would be more useful than comments=
=20
(names can be grepped for, do not fall out-of-sync with code, etc.).

> > > @@ -1237,13 +1253,18 @@ static unsigned int=20
> > > tcp_established_options(struct sock *sk, struct sk_buff *skb
> > >
> > >       if (tcp_ecn_mode_accecn(tp) &&
> > >           sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> > > -             int saving =3D opts->num_sack_blocks > 0 ? 2 : 0;
> > > -             int remaining =3D MAX_TCP_OPTION_SPACE - size;
> > > -
> > > -             opts->ecn_bytes =3D tp->received_ecn_bytes;
> > > -             size +=3D tcp_options_fit_accecn(opts, tp->accecn_minle=
n,
> > > -                                            remaining,
> > > -                                            saving);
> > > +             if (sock_net(sk)->ipv4.sysctl_tcp_ecn_option >=3D 2 ||
> > > +                 tp->accecn_opt_demand ||
> > > +                 tcp_accecn_option_beacon_check(sk)) {
> >=20
> > Why a nested if here and just not expanding the existing one?
>=20
> Sure, will merge them.

While I don't remember everything that well anymore, this might have been=
=20
to reduce code churn in some later patch, so it might be worth to check=20
it first (that patch might even fall outside of this series now that these=
=20
are split into multiple chunks).

--=20
 i.

--8323328-1936862257-1746487601=:1002--

