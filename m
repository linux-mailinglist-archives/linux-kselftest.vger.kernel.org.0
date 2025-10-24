Return-Path: <linux-kselftest+bounces-43968-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA51BC044F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 06:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFA744E6B2C
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Oct 2025 04:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42150285C9D;
	Fri, 24 Oct 2025 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LoDe8ebH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D1327FD44
	for <linux-kselftest@vger.kernel.org>; Fri, 24 Oct 2025 04:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761279211; cv=none; b=Ync9GUMy48wSZlBTpnMt2kRYOZORtNFtVdg4PaQdiDhir+LcKEv0WsgMtIpYa81LUwdpwX2Qe9Fn5OZXRsLLawRbSbvyUS6auxkL+QEtPshro3lE2rr0AtQmM1J96Uc40VAxIZO+5pTtOlJ58uB+EePFe89Oxhchk5INSmz0Uwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761279211; c=relaxed/simple;
	bh=FMNaLFDjx69v6ZzbO/4atk50VxceYVKBeF/2QQssp6E=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=ok/trMTAPH3KhcJVIt9t4yHlDO84NAjjHaVPDUkXlk2reVdSJw8yNjabcsUU0hRIjnKO/2nO1g9XqCDJ1gelgC0KINvL7vQVcilR5Kxz3+exME0wEU0+PBob2GbDeAcjM9uu5+GPq2739fF9KHRP3MbPGNTDJ5G+1weUNahh4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LoDe8ebH; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761279196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NRsGgrjIKsQrMKsBDmX9pjVYYabxhQ/HoNpJSeaQfa8=;
	b=LoDe8ebHaOq7xdpyZZcnnEt0x3wAfZWdFVPu4aL/qZJU2e0m7fBYfeUmFicNASdr7MKVDW
	6ugPwjNAyWGzS3CxAM3KbRUVGsusQ0UkV/ujzP062yM1WXzqui9LscJwkPnebsj5d+NxNP
	ibgSidUC/rTBWqp/xmhIQ8PErNUPM5s=
Date: Fri, 24 Oct 2025 04:13:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <319c419455b73deb312b53d99c30217f6b606208@linux.dev>
TLS-Required: No
Subject: Re: [PATCH net v3 0/3] mptcp: Fix conflicts between MPTCP and
 sockmap
To: "Matthieu Baerts" <matttbe@kernel.org>, mptcp@lists.linux.dev
Cc: "John Fastabend" <john.fastabend@gmail.com>, "Jakub Sitnicki"
 <jakub@cloudflare.com>, "Eric Dumazet" <edumazet@google.com>, "Kuniyuki
 Iwashima" <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Willem
 de Bruijn" <willemb@google.com>, "David S. Miller" <davem@davemloft.net>,
 "Jakub Kicinski" <kuba@kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>, "Geliang Tang"
 <geliang@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "KP Singh" <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>, "Hao Luo" <haoluo@google.com>, "Jiri Olsa"
 <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Florian Westphal"
 <fw@strlen.de>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <14b565a1-0c2a-420d-ab2a-dc8a46dbf33c@kernel.org>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <14b565a1-0c2a-420d-ab2a-dc8a46dbf33c@kernel.org>
X-Migadu-Flow: FLOW_OUT

2025/10/23 22:10, "Matthieu Baerts" <matttbe@kernel.org mailto:matttbe@ke=
rnel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E > =E5=
=86=99=E5=88=B0:


> >  MPTCP creates subflows for data transmission between two endpoints.
> >  However, BPF can use sockops to perform additional operations when T=
CP
> >  completes the three-way handshake. The issue arose because we used s=
ockmap
> >  in sockops, which replaces sk->sk_prot and some handlers.
> >=20
>=20Do you know at what stage the sk->sk_prot is modified with sockmap? W=
hen
> switching to TCP_ESTABLISHED?
> Is it before or after having set "tcp_sk(sk)->is_mptcp =3D 0" (in
> subflow_ulp_fallback(), coming from subflow_syn_recv_sock() I suppose)?


Yes, there are two call points. One is after executing subflow_syn_recv_s=
ock():
tcp_init_transfer(sk, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);

So at this point, is_mptcp =3D 0. The other call point is when userspace =
calls
the BPF interface, passing in an fd while it's not a subflow but a parent=
 sk
with its own mptcp_prot we will also reject it.

You can refer to my provided selftest, which covers these scenarios.

> If MPTCP is still being used (sk_is_tcp(sk) && sk_is_mptcp(sk)), I gues=
s
> sockmap should never touch the in-kernel TCP subflows: they will likely
> only carry a part of the data. Instead, sockmap should act on the MPTCP
> sockets, not the in-kernel TCP subflows.

Yes, I agree.

For full functionality, we need to retrieve the parent socket from MPTCP
and integrate it with sockmap, rather than simply rejecting.

The current implementation rejects MPTCP because I previously attempted t=
o
add sockmap support for MPTCP, but it required implementing many interfac=
es
and would take considerable time.

So for now, I'm proposing this as a fix to resolve the immediate issue.
Subsequently, we can continue working on fully integrating MPTCP with soc=
kmap.

> There is one particular case to take into consideration: an MPTCP
> connection can fallback to "plain" TCP before being used by the
> userspace. Typically, that's when an MPTCP listening socket receives a
> "plain" TCP request (without MPTCP): a "plain" TCP socket will then be
> created, and exposed to the userspace. In this case, sk_is_mptcp(sk)
> will return false. I guess that's the case you are trying to handle,
> right? (It might help BPF reviewers to mention that in the commit
> message(s).)

Yes, this is primarily the case we're addressing. I will add this descrip=
tion
to the commit message.


> I would then say that sk->sk_prot->psock_update_sk_prot should not poin=
t
> to tcp_bpf_update_proto() when MPTCP is being used (or this callback
> should take the MPTCP case into account, but I guess no). In case of
> fallback before the accept() stage, the socket can then be used as a
> "plain" TCP one. I guess when tcp_bpf_update_proto() will be called,
> sk_prot is pointing to tcp(v6)_prot, not the MPTCP subflow override one=
,
> right?

Yes, when tcp_bpf_update_proto is called the sk_prot is pointing to tcp(v=
6)_prot.
subflow_syn_recv_sock
 mptcp_subflow_drop_ctx
  subflow_ulp_fallback
   mptcp_subflow_ops_undo_override -> reset sk_prot to original one

So [patch 2/3] aims to prevent psock_update_sk_prot from being executed o=
n subflows.

Actually, replacing the subflow's callbacks is also incorrect, as you men=
tioned earlier,
because subflows only carry part of the data. By checking for subflows ea=
rly and skipping
subsequent steps, we avoid incorrect logic.

Furthermore, there's another risk: if an IPv6 request comes in and we per=
form the replacement,
MPTCP will roll it back to inet_stream_ops. I haven't delved too deeply i=
nto the potential
impact, but I noticed that inet6_release has many V6-specific cleanup pro=
cedures not present
in inet_release.

> >=20
>=20> Since subflows
> >  also have their own specialized handlers, this creates a conflict an=
d leads
> >  to traffic failure. Therefore, we need to reject operations targetin=
g
> >  subflows.
> >=20
>=20Would it not work to set sk_prot->psock_update_sk_prot to NULL for th=
e
> v4 and v6 subflows (in mptcp_subflow_init()) for the moment while
> sockmap is not supported with MPTCP? This might save you some checks in
> sock_map.c, no?

This seems like a reliable alternative I hadn't considered initially.

However, adding the check on the BPF side serves another purpose: to expl=
icitly
warn users that sockmap and MPTCP are incompatible.

Since the latest Golang version enables MPTCP server by default, and if t=
he client
doesn't support MPTCP, it falls back to TCP logic. We want to print a cle=
ar message
informing users who have upgraded to the latest Golang and are using sock=
map.

Perhaps we could add a function like sk_is_mptcp_subflow() in the MPTCP s=
ide?
The implementation would simply be sk_is_tcp(sk) && sk_is_mptcp(sk).

Implementing this check logic on the BPF side might become invalid if MPT=
CP internals
change later; placing it in the MPTCP side might be a better choice.


> >=20
>=20> This patchset simply prevents the combination of subflows and sockm=
ap
> >  without changing any functionality.
> >=20
>=20In your case, you have an MPTCP listening socket, but you receive a T=
CP
> request, right? The "sockmap update" is done when switching to
> TCP_ESTABLISHED, when !sk_is_mptcp(sk), but that's before
> mptcp_stream_accept(). That's why sk->sk_prot has been modified, but it
> is fine to look at sk_family, and return inet(6)_stream_ops, right?

I believe so. Since MPTCP is fundamentally based on TCP, using sk_family =
to
determine which ops to fall back to should be sufficient.

However, strictly speaking, this [patch 1/3] might not even be necessary =
if we
prevent the sk_prot replacement for subflows at the sockmap layer.

> A more important question: what will typically happen in your case if
> you receive an MPTCP request and sockmap is then not supported? Will th=
e
> connection be rejected or stay in a strange state because the userspace
> will not expect that? In these cases, would it not be better to disallo=
w
> sockmap usage while the MPTCP support is not available? The userspace
> would then get an error from the beginning that the protocol is not
> supported, and should then not create an MPTCP socket in this case for
> the moment, no?
>
> I can understand that the switch from TCP to MPTCP was probably done
> globally, and this transition should be as seamless as possible, but it
> should not cause a regression with MPTCP requests. An alternative could
> be to force a fallback to TCP when sockmap is used, even when an MPTCP
> request is received, but not sure if it is practical to do, and might b=
e
> strange from the user point of view.

Actually, I understand this not as an MPTCP regression, but as a sockmap
regression.

Let me explain how users typically use sockmap:

Users typically create multiple sockets on a host and program using BPF+s=
ockmap
to enable fast data redirection. This involves intercepting data sent or =
received
by one socket and redirecting it to the send or receive queue of another =
socket.

This requires explicit user programming. The goal is that when multiple m=
icroservices
on one host need to communicate, they can bypass most of the network stac=
k and avoid
data copies between user and kernel space.

However, when an MPTCP request occurs, this redirection flow fails.

Since the sockmap workflow typically occurs after the three-way handshake=
, rolling
back at that point might be too late, and undoing the logic for MPTCP wou=
ld be very
complex.

Regardless, the reality is that MPTCP and sockmap are already conflicting=
, and this
has been the case for some time. So I think our first step is to catch sp=
ecific
behavior on the BPF side and print a message
"sockmap/sockhash: MPTCP sockets are not supported\n", informing users to=
 either
stop using sockmap or not use MPTCP.

As for the logic to check for subflows, I think implementing it in subflo=
w.c would be
beneficial, as this logic would likely be useful later if we want to
support MPTCP + sockmap.

Furthermore, this commit also addresses the issue of incorrectly selectin=
g
inet_stream_ops due to the subflow prot replacement, as mentioned above.

> >=20
>=20> A complete integration of MPTCP and sockmap would require more effo=
rt, for
> >  example, we would need to retrieve the parent socket from subflows i=
n
> >  sockmap and implement handlers like read_skb.
> >=20=20
>=20>  If maintainers don't object, we can further improve this in subseq=
uent
> >  work.
> >=20
>=20That would be great to add MPTCP support in sockmap! As mentioned abo=
ve,
> this should be done on the MPTCP socket. I guess the TCP "in-kernel"
> subflows should not be modified.


I think we should first fix the issue by having sockmap reject operations=
 on subflows.
Subsequently, we can work on fully integrating sockmap with MPTCP as a fe=
ature
(which would require implementing some handlers).

> >=20
>=20> [1] truncated warning:
> >  [ 18.234652] ------------[ cut here ]------------
> >  [ 18.234664] WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 mpt=
cp_stream_accept+0x34c/0x380
> >  [ 18.234726] Modules linked in:
> >  [ 18.234755] RIP: 0010:mptcp_stream_accept+0x34c/0x380
> >  [ 18.234762] RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
[...]
> >=20
>=20Please next time use the ./scripts/decode_stacktrace.sh if possible.
> (and strip the timestamps if it is not giving useful info)
> Just to be sure: is it the warning you get on top of net or net-next? O=
r
> an older version? (Always useful to mention the base)

Thank you, Matthieu. I will pay attention to this.


> >=20
>=20> ---
> >  v2: https://lore.kernel.org/bpf/20251020060503.325369-1-jiayuan.chen=
@linux.dev/T/#t
> >  Some advice suggested by Jakub Sitnicki
> >=20=20
>=20>  v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05=
534fe6f1@linux.dev/T/#t
> >  Some advice from Matthieu Baerts.
> >=20
>=20(It usually helps reviewers to add more details in the notes/changelo=
g
> for the individual patch)

Thank you, Matthieu. I will provide more detailed descriptions in the fut=
ure.


Best regards,
Jiayuan

