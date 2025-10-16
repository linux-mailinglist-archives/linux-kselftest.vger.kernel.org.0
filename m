Return-Path: <linux-kselftest+bounces-43352-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B5A3BE564E
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 22:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 264294F81C4
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Oct 2025 20:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACE02DECDF;
	Thu, 16 Oct 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uko6yZo/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70831A9F93;
	Thu, 16 Oct 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760646424; cv=none; b=XjAYbgyy8SG0XMWzzDl/9iQ/GtzOarBLmXrhIlxIEywMSuFfTvQ6vxrhezX2DrLA4sGJlngziXDPvzM5zIgNzhq4Hv8y14kE+BWWH6xjF1wKFyiOGP0wq9I6GSjpxBtNWP2v+yhIIW2OcAlMNlkl3Kyk7EL02qNVSvAhg/YFHFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760646424; c=relaxed/simple;
	bh=xxvesUj/77OAj0Ah3EU6upE1SK/vnUKpxtya594I4DM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iRctQAvACmgKzw/NJHkmuhdPTQw95M6l/teW/pxvn2gI8O3JmUwa8LSb9icGmDwhcwF+YLRsBfnUTZW4phjlD14ETv8at2slJU9IVMB4RVGKwTEmnUndMom6Wzntx08UY5EBg5vTLTEvgiMN9bQZ926RSwrTKLMPidOs7nUb0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uko6yZo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86ED7C4CEF1;
	Thu, 16 Oct 2025 20:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760646422;
	bh=xxvesUj/77OAj0Ah3EU6upE1SK/vnUKpxtya594I4DM=;
	h=From:Date:To:cc:Subject:In-Reply-To:References:From;
	b=Uko6yZo/whJf0nUbs6gMeHcSM30hY6D9x6Bdg/s8Kb4BsvdbgBnlZY+kUs1XPquHw
	 qATNi7E3UYCq9W8Ev4hgil5cEdsOhSCMw/U7owlZ+e5ptwu5tsYErsqDu/PNa2C5eQ
	 xySzY2MO0uKaxasLyKZKZhguMtaHSqyod0JGmRcmndGf9FMLcoqnMShRQ69xabafs7
	 b1yG9y8OFEZ3hpH8Ot33XSJkJUVu7nrZqYxf7JFK27I+OQx2JVu0YTVvFb3q3A4euA
	 VDgR4qQCKChlx1Z4UYvz5HN8wN8sS3/EgLC6M6WOIGf0oWcLBuj/p97MsyahxKeThm
	 mGjgrPlTMYUfQ==
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ij@kernel.org>
Date: Thu, 16 Oct 2025 23:26:57 +0300 (EEST)
To: Paolo Abeni <pabeni@redhat.com>
cc: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, 
    linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
    dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
    netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
    kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
    jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
    donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
    shuah@kernel.org, linux-kselftest@vger.kernel.org, ncardwell@google.com, 
    koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
    ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
    cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
    vidhi_goel@apple.com
Subject: Re: [PATCH v4 net-next 02/13] gro: flushing when CWR is set negatively
 affects AccECN
In-Reply-To: <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
Message-ID: <24bc44a8-6045-9565-c798-a9d4597366e8@kernel.org>
References: <20251013170331.63539-1-chia-yu.chang@nokia-bell-labs.com> <20251013170331.63539-3-chia-yu.chang@nokia-bell-labs.com> <98342f21-08c8-46de-9309-d58dfc44d0a0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1306421146-1760646417=:6153"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1306421146-1760646417=:6153
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 16 Oct 2025, Paolo Abeni wrote:
> On 10/13/25 7:03 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> > From: Ilpo J=C3=A4rvinen <ij@kernel.org>
> >=20
> > As AccECN may keep CWR bit asserted due to different
> > interpretation of the bit, flushing with GRO because of
> > CWR may effectively disable GRO until AccECN counter
> > field changes such that CWR-bit becomes 0.
> >=20
> > There is no harm done from not immediately forwarding the
> > CWR'ed segment with RFC3168 ECN.
>=20
> I guess this change could introduce additional latency for RFC3168
> notification, which sounds not good.
>=20
> @Eric: WDYT?

I'm not Eric but I want to add I foresaw somebody making this argument=20
and thus wanted to not hide this change into some other patch so it can be=
=20
properly discussed and rejected if so preferred, either way it's not a=20
correctness issue.

I agree it's possible for some delay be added but the question is why=20
would that matter? "CWR" tells sender did already reduce its sending rate=
=20
which is where congestion control aims to. So the reaction to congestion=20
is already done when GRO sees CWR (some might have a misconception that
delivering CWR causes sender to reduce sending rate but that's not the=20
case). With RFC 3168 ECN, CWR only tells the receiving end to stop sending=
=20
ECE. Why does it matter if that information arrives a bit later?

If there are other segments, they normally don't have CWR with RFC 3168=20
ECN which normally set CWR once per RTT. A non-CWR'ed segment results in=20
flush after an inter-packet delay due to flags difference. That delay is=20
nothing compared to GRO aggregating non-CWR segments en masse which is=20
in n times the inter-packet delay (simplification, ignores burstiness,=20
etc.).

If there are no other segments, the receiver won't be sending any ECEs=20
either, so the extra delay does not seem that impactful.

Some might argue that with this "special delivery" for CWR the segment=20
could trigger an ACK "sooner", but GRO shouldn't hold the segment forever=
=20
either (though I don't recall the details anymore). But if we make that=20
argument (which is no longer ECN signalling related at all, BTW), why use=
=20
GRO at all as it add delay for other segments too delaying other ACKs, why=
=20
is this CWR'ed segment so special that it in particular must elicit ACK=20
ASAP? It's hard to justify that distinction/CWR speciality, unless one has=
=20
that misconception CWR must arrive ASAP to expedite congestion reaction=20
which is based on misunderstanding how RFC 3168 ECN works.

Thus, what I wrote to the changelog about the delay not being harmful=20
seems well justified.

> On the flip side adding too much
> AccECN logic to GRO (i.e. to allow aggregation only for AccECN enabled
> flows) looks overkill.

The usual aggregation works on header bits remaining identical which=20
just happens to also suit AccECN better here. The RFC 3168 CWR trickery is=
=20
what is an expection to the rule, and as explained above, it does not seem=
=20
even that useful.

This CWR special delivery rule, on the other hand, is clearly harmful for=
=20
aggregating AccECN segments which may have long row of CWR flagged=20
segments if ACE field remains unchanging. None of them can be aggregated=20
by GRO if this particular change is not accepted. Not an end of the world=
=20
but if we weight the pros and cons, it seems to clearly favor not keeping=
=20
this special delivery rule.


--=20
 i.

--8323328-1306421146-1760646417=:6153--

