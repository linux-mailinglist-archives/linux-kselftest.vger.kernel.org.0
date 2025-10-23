Return-Path: <linux-kselftest+bounces-43884-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD5C01DAB
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 16:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 770AD508F58
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Oct 2025 14:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 881383093AB;
	Thu, 23 Oct 2025 14:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kXXlt/Pm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A75C32C31A
	for <linux-kselftest@vger.kernel.org>; Thu, 23 Oct 2025 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761230351; cv=none; b=sOCc/pbfm1XGgqZxjPpEwXrjg6lub1uNtYawMO4TSSS7rmpgfIR3cgZ+lXa8PHZ9EwemB6DmmqgxoNP6/QD1wj1so9YVFA8P8dyKQjEYB0DEVkuHzV0OVC1QX6/Rl1xvkt4vI6wuPcUbUgxEPwZ93wQcTDOhNBfvX9fJw3JJp04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761230351; c=relaxed/simple;
	bh=QhwyrjBpjgfOnL3bdRWqdkRQ3slK04/PCvNpP+0vgrA=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=Kegc7KQliBESGOHYXV4D4PFpizukKtn5ys2+047GKsyz3w8P9vdQqgFpJqPdev9SbcsdNhFI/FdM+GOdZgguFq1XSkQ2ERIE64a1DtY2coiUrmpcBe8bQA9qnmskSRHvjsjMTnVZPLGTQHyXvOcxyv42RIEwZ89P2dllBTUFPYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kXXlt/Pm; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761230335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HXi8UPiE0uzXnPOltiRRjCeAETESSly9AvRlExTJgIA=;
	b=kXXlt/PmnGWBhr/8YGbWQbhMTVtkCX75zpERQmSDEVaSjJ5XMSBNMm/FjDodgaCz1DGrgQ
	68VSl35ipqt3t7pTFE/H3zuXGp4j744g1Fns2ErFrq6kQXzvml8yC13aQWoDgP8RNswLTi
	PSJKoEQLTt2TMZ8UsJO3tpKhi+nTk9Y=
Date: Thu, 23 Oct 2025 14:38:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <b722c37528e6f94bef828d6ca478a9fa8d33501a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, "Jakub Sitnicki" <jakub@cloudflare.com>, "John
 Fastabend" <john.fastabend@gmail.com>, "Eric Dumazet"
 <edumazet@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "Willem de Bruijn" <willemb@google.com>,
 "David S. Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>, "Mat Martineau"
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
In-Reply-To: <cc923a56-cf2d-4c3a-b1bd-90dbc3075ef2@kernel.org>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <cc923a56-cf2d-4c3a-b1bd-90dbc3075ef2@kernel.org>
X-Migadu-Flow: FLOW_OUT

October 23, 2025 at 22:10, "Matthieu Baerts" <matttbe@kernel.org mailto:m=
atttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%=
3E > wrote:


>=20
>=20Hi Jiayuan,
>=20
>=20On 23/10/2025 14:54, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> When the server has MPTCP enabled but receives a non-MP-capable req=
uest
> >  from a client, it calls mptcp_fallback_tcp_ops().
> >=20=20
>=20>  Since non-MPTCP connections are allowed to use sockmap, which repl=
aces
> >  sk->sk_prot, using sk->sk_prot to determine the IP version in
> >  mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assign=
ing
> >  incorrect ops to sk->sk_socket->ops.
> >=20=20
>=20>  Additionally, when BPF Sockmap modifies the protocol handlers, the
> >  original WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot) check would falsel=
y
> >  trigger warnings.
> >=20=20
>=20>  Fix this by using the more stable sk_family to distinguish between=
 IPv4
> >  and IPv6 connections, ensuring correct fallback protocol operations =
are
> >  selected even when BPF Sockmap has modified the socket protocol hand=
lers.
> >=20=20
>=20>  Fixes: 0b4f33def7bb ("mptcp: fix tcp fallback crash")
> >  Cc: <stable@vger.kernel.org>
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> >  ---
> >  net/mptcp/protocol.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> >=20=20
>=20>  diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> >  index 0292162a14ee..2393741bc310 100644
> >  --- a/net/mptcp/protocol.c
> >  +++ b/net/mptcp/protocol.c
> >  @@ -61,11 +61,16 @@ static u64 mptcp_wnd_end(const struct mptcp_sock=
 *msk)
> >=20=20
>=20>  static const struct proto_ops *mptcp_fallback_tcp_ops(const struct=
 sock *sk)
> >  {
> >  + /* When BPF sockmap is used, it may replace sk->sk_prot.
> >  + * Using sk_family is a reliable way to determine the IP version.
> >  + */
> >  + unsigned short family =3D READ_ONCE(sk->sk_family);
> >  +
> >  #if IS_ENABLED(CONFIG_MPTCP_IPV6)
> >  - if (sk->sk_prot =3D=3D &tcpv6_prot)
> >  + if (family =3D=3D AF_INET6)
> >  return &inet6_stream_ops;
> >  #endif
> >  - WARN_ON_ONCE(sk->sk_prot !=3D &tcp_prot);
> >  + WARN_ON_ONCE(family !=3D AF_INET);
> >  return &inet_stream_ops;
> >=20
>=20Just to be sure: is there anything in BPF modifying sk->sk_socket->op=
s?
> Because that's what mptcp_fallback_tcp_ops() will do somehow.
>=20
>=20In other words, is it always fine to set inet(6)_stream_ops? (I guess
> yes, but better to be sure while we are looking at that :) )



Hi Matt,

I can confirm that on the BPF side, the only special operations targeting
sockets currently are sockmap/sockhash. Their implementations do not modi=
fy
sk->sk_socket->ops. Currently, they only modify sk->prot, because the BPF
side typically operates on 'struct sock' and does not concern itself with
'struct socket'.

Therefore, setting inet(6)_stream_ops is fine.

Thanks,
Jiayuan

> >=20
>=20> }
> >=20
>=20Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>

