Return-Path: <linux-kselftest+bounces-46111-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D13E1C746AF
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id D42102B1BC
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8E0346A12;
	Thu, 20 Nov 2025 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o+xUpKA0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77602FE564
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Nov 2025 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647435; cv=none; b=J1U28OQXU9VazYbmf0JcVLb4PHuLPtEWNGHIOnp63iz5wEoCat1MHNFHyWmwipInOhMnLEC86I064L45b4BGv5RA7Jhluv2lTlCTY71F77OwhGs7jQM0pRbumtlTWyOFzqjq+Ut2Js3tZILWDnegzf/175sxMXi35s4kqRG9Xgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647435; c=relaxed/simple;
	bh=CI3aKvMENBD6Wx/BMX3Dm6s28G/RCoH+gf+fXWi+F9U=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=a0nGIH1MvnBLybFmgH3/D2GEWKhWfNhJIV2qji9vM4ZVychHwR4KBfoLd8SY3CcZYI5DKQPgyda2oiBiGButGrBrbk96yrDZozAhFZuEY4sFQBjVJJSmOdtVt7/8Oeh41gs3mMhH2Yq0B2j9nQWCW/XSlxkYicE+IiqeODQzizo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o+xUpKA0; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763647429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t2tROtgsicTEps6RWKZs8tKAeJGs/9o7AxPBq2elSzg=;
	b=o+xUpKA0GTss5Hqr4AOnKIRD0++/yyfuuMREnltWDz/NJroRTWSqaxV9qW8YLNRbTjboLf
	0ZjKKmP/IQWPRCKVZ7l3LweYSzsrygSlUyM1MRKmqcRIXhvZTNOwPHkkgEA/h+UWA+GtmA
	Dg5jZq1PklmquRRuCwEQa3Ouw8++Kzg=
Date: Thu, 20 Nov 2025 14:03:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b6c033deb75243e285fa6b028ee666f874b75eb8@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v1 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David 
 Ahern" <dsahern@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard 
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong 
 Song" <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Michal
 Luczaj" <mhal@rbox.co>, "Stefano Garzarella" <sgarzare@redhat.com>, "Cong
 Wang" <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <87tsyo6ets.fsf@cloudflare.com>
References: <20251117110736.293040-1-jiayuan.chen@linux.dev>
 <20251117110736.293040-2-jiayuan.chen@linux.dev>
 <87zf8h6bpd.fsf@cloudflare.com>
 <5a66955891ef8db94b7288bbb296efcc0ac357cf@linux.dev>
 <87tsyo6ets.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

November 20, 2025 at 20:58, "Jakub Sitnicki" <jakub@cloudflare.com mailto=
:jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare=
.com%3E > wrote:


>=20
>=20On Thu, Nov 20, 2025 at 02:49 AM GMT, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> November 20, 2025 at 03:53, "Jakub Sitnicki" <jakub@cloudflare.com =
mailto:jakub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40clou=
dflare.com%3E > wrote:
> >=20
>=20>  [...]
> >=20
>=20> >=20
>=20> > > +/* The BPF program sets BPF_F_INGRESS on sk_msg to indicate da=
ta needs to be
> > >  > + * redirected to the ingress queue of a specified socket. Since=
 BPF_F_INGRESS is
> > >  > + * defined in UAPI so that we can't extend this enum for our in=
ternal flags. We
> > >  > + * define some internal flags here while inheriting BPF_F_INGRE=
SS.
> > >  > + */
> > >  > +enum {
> > >  > + SK_MSG_F_INGRESS =3D BPF_F_INGRESS, /* (1ULL << 0) */
> > >  > + /* internal flag */
> > >  > + SK_MSG_F_INGRESS_SELF =3D (1ULL << 1)
> > >  > +};
> > >  > +
> > >  >=20
>=20> >  I'm wondering if we need additional state to track this.
> > >  Can we track sk_msg's construted from skb's that were not redirect=
ed by
> > >  setting `sk_msg.sk =3D sk` to indicate that the source socket is u=
s in
> > >  sk_psock_skb_ingress_self()?
> > >=20
>=20>  Functionally, that would work. However, in that case, we would hav=
e to hold
> >  a reference to sk until the sk_msg is read, which would delay the re=
lease of
> >  sk. One concern is that if there is a bug in the read-side applicati=
on, sk
> >  might never be released.
> >=20
>=20We don't need to grab a reference to sk if we're talking about settin=
g
> it only in sk_psock_skb_ingress_self(). psock already holds a ref for
> psock->sk, and we purge psock->ingress_msg queue when destroying the
> psock before releasing the sock ref in sk_psock_destroy().

I see. When it's an ingress to self redirection, the msg.sk would point t=
o
the same socket as psock->sk (the socket itself), not to another socket, =
so
indeed no additional reference grab is needed.

> While there's nothing wrong with an internal flaag, I'm trying to see i=
f
> we make things somewhat consistent so as a result sk_msg state is easie=
r
> to reason about.
>=20
>=20My thinking here is that we already set sk_msg.sk to source socket in
> sk_psock_msg_verdict() on sendmsg() path, so we know that this is the
> purpose of that field. We could mimic this on recvmsg() path.
>

