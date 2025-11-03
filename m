Return-Path: <linux-kselftest+bounces-44645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A08C2BCE8
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 13:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C186349879
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 12:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D2930E0C8;
	Mon,  3 Nov 2025 12:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vPmF0CSo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C804305062
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 12:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173946; cv=none; b=MUtn4h/3oOmuDtUp1bNXVs6cAr0vlZAkUDzvTRy3j8QCmrRYzLlYHoVyUJrHqlepqpHBPC55bd3kIdUubcawzH/PRTTXDqisxBD3GYb4NFQ9YM2iRFIadrQGisCydiZ0Dj5Y4aVwSEb/0RHKghAt34Yx8iuXE2CSdeLwZ3DVCpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173946; c=relaxed/simple;
	bh=PXv1z36/be6/4aY9ewYt8RoZMabXtTyrqmzZIbYsjrg=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=I7EmUqbt4zsMmUxg8Wnv0U6Wi/KKDHF4vVkVinLeODL95Mnj4BmvyO6u0LNmOKGcns4wTFPazTSuOIHI58lQPUz82qUdZc4v/BFOwO2BsjGbVycyX5zQfGv/k0MsaFncUAA2o7H2xohr0eQvVy8tVzdA7DrXwLMiyQUZ9ZhbthE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vPmF0CSo; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762173932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1BZfPsf1uykEsk+GOZr7evhjaMa7D7ZzUYhWF9AmfpY=;
	b=vPmF0CSob2yFKuI+FJqd06xxfooXyeA+NbfplTK9R97Dz+z4wtnUJcjGrjjIFv/PFY3/x4
	1g4cGTwE/H/xndi4RmDpIdrXZtl6N5zdHsQYML0E6jkTvTMEFixJC+0jrgQZWOlweA4gwF
	4RTX2ZHzgNFnGJjCn/PqUSq9rhXF1qw=
Date: Mon, 03 Nov 2025 12:45:29 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <43899f2857ba10fbcc90f9d273bb09dadd7229ec@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: "Paolo Abeni" <pabeni@redhat.com>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Matthieu Baerts" <matttbe@kernel.org>, "Mat Martineau"
 <martineau@kernel.org>, "Geliang Tang" <geliang@kernel.org>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>, "Florian Westphal" <fw@strlen.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
 <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
X-Migadu-Flow: FLOW_OUT

October 28, 2025 at 19:47, "Paolo Abeni" <pabeni@redhat.com mailto:pabeni=
@redhat.com?to=3D%22Paolo%20Abeni%22%20%3Cpabeni%40redhat.com%3E > wrote:


>=20
>=20On 10/28/25 12:30 PM, Paolo Abeni wrote:
>=20
>=20>=20
>=20> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
> >=20
>=20> >=20
>=20> > When the server has MPTCP enabled but receives a non-MP-capable r=
equest
> > >  from a client, it calls mptcp_fallback_tcp_ops().
> > >=20
>=20> >  Since non-MPTCP connections are allowed to use sockmap, which re=
places
> > >  sk->sk_prot, using sk->sk_prot to determine the IP version in
> > >  mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assi=
gning
> > >  incorrect ops to sk->sk_socket->ops.
> > >=20
>=20>=20=20
>=20>  I don't see how sockmap could modify the to-be-accepted socket sk_=
prot
> >  before mptcp_fallback_tcp_ops(), as such call happens before the fd =
is
> >  installed, and AFAICS sockmap can only fetch sockets via fds.
> >=20=20
>=20>  Is this patch needed?
> >=20
>=20Matttbe explained off-list the details of how that could happen. I th=
ink
> the commit message here must be more verbose to explain clearly the
> whys, even to those non proficient in sockmap like me.
>=20
>=20Thanks,
>=20
>=20Paolo
>

Thanks, I will add more details into commit message :).

