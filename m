Return-Path: <linux-kselftest+bounces-44643-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEF0C2BC43
	for <lists+linux-kselftest@lfdr.de>; Mon, 03 Nov 2025 13:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C9B1F4F2E8B
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Nov 2025 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC99313E07;
	Mon,  3 Nov 2025 12:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Hxg5uF7d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AAC30649A
	for <linux-kselftest@vger.kernel.org>; Mon,  3 Nov 2025 12:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762173307; cv=none; b=LEt9iJlwB+WWsm50Ihmh60oByAYs/BsF7isVR4gJ/ck05FQ1P3MFMh63pBRi6IxEnQw2bvI2Y30fYLxI3lmYe2g5CEjbNo1kQUllCn4lL5LZMbkLuXoeRp1zOi12jXxR5WjWHCKcOXAfGYU132vvKsjsqGX/qHQ0NMontXTvqfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762173307; c=relaxed/simple;
	bh=BrHANmSqz135iJ6rgC04qJmCezE4SuPX8VM26jPrRxs=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=KHlIHbRH+KDcYrn8FI1tSrBliVAVmV9jc8XyL8U+1OeePf9g3aNXCinjMeLbAbrtrs4fKgcuhW85TuM17HC1QmoNflSKqfxCVrMkae8TS8QjhPtW4o1w9Kfc4hh1R7exBf/XMdSaBH9f4XD1G7tsoNkRDpmHGUMMhKhY87SOqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Hxg5uF7d; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762173293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vstW+wjqIPjiCYxZam24Gld8JAMPyQM9Z5et7SY16eQ=;
	b=Hxg5uF7dtXYqq3hzgQWDGCl6OV7CJBlRrWE/9XXoaiHUoB4d9Nb8OH16CdgyB1XXcjlkI+
	45s/n2LT/MYddzCewBKbINBtw24CEZK2lB/lswhtToJBmnsKsnzYhdG9gjdbv6s/xZodhf
	dnd3jkIgi2xkXjMG5E2u+ZMrVwJ27xk=
Date: Mon, 03 Nov 2025 12:34:45 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <55049e76c1e86825ff963c381ef01e38cfc08b10@linux.dev>
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
In-Reply-To: <bc5831bb-cfa3-4327-b129-30ca5d17b45e@kernel.org>
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <14b565a1-0c2a-420d-ab2a-dc8a46dbf33c@kernel.org>
 <319c419455b73deb312b53d99c30217f6b606208@linux.dev>
 <bc5831bb-cfa3-4327-b129-30ca5d17b45e@kernel.org>
X-Migadu-Flow: FLOW_OUT

October 29, 2025 at 1:26 AM, "Matthieu Baerts" <matttbe@kernel.org mailto=
:matttbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.or=
g%3E > wrote:

Hi Matthieu, apologies for the delayed response.

>=20
>=20Hi Jiayuan,
>=20
>=20Thank you for your reply!
>=20
>=20On 24/10/2025 06:13, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> 2025/10/23 22:10, "Matthieu Baerts" <matttbe@kernel.org mailto:matt=
tbe@kernel.org?to=3D%22Matthieu%20Baerts%22%20%3Cmatttbe%40kernel.org%3E =
> =E5=86=99=E5=88=B0:
> >=20=20
>=20>=20=20
>=20>  MPTCP creates subflows for data transmission between two endpoints=
.
> >  However, BPF can use sockops to perform additional operations when T=
CP
> >  completes the three-way handshake. The issue arose because we used s=
ockmap
> >  in sockops, which replaces sk->sk_prot and some handlers.
> >=20
>=20> >=20
>=20> > Do you know at what stage the sk->sk_prot is modified with sockma=
p? When
> > >  switching to TCP_ESTABLISHED?
> > >  Is it before or after having set "tcp_sk(sk)->is_mptcp =3D 0" (in
> > >  subflow_ulp_fallback(), coming from subflow_syn_recv_sock() I supp=
ose)?
> > >=20
>=20>=20=20
>=20>=20=20
>=20>  Yes, there are two call points. One is after executing subflow_syn=
_recv_sock():
> >  tcp_init_transfer(sk, BPF_SOCK_OPS_PASSIVE_ESTABLISHED_CB, skb);
> >=20=20
>=20>  So at this point, is_mptcp =3D 0. The other call point is when use=
rspace calls
> >  the BPF interface, passing in an fd while it's not a subflow but a p=
arent sk
> >  with its own mptcp_prot we will also reject it.
> >=20
>=20OK, thank you for the explanations! I think your commit message in pa=
tch
> 1/3 should then explain the conditions to have mptcp_fallback_tcp_ops()
> being called with a different sk_prot. In short: MPTCP listening socket=
,
> TCP request without MPTCP, sk_prot reset to TCP (subflow_syn_recv_sock)
> when SYN RECV, then reset by sockmap when ESTABLISHED, then accept part
> and sk_prot is not the expected one.
>=20
>=20>=20
>=20> You can refer to my provided selftest, which covers these scenarios=
.
> >=20=20
>=20>=20
>=20> >=20
>=20> > If MPTCP is still being used (sk_is_tcp(sk) && sk_is_mptcp(sk)), =
I guess
> > >  sockmap should never touch the in-kernel TCP subflows: they will l=
ikely
> > >  only carry a part of the data. Instead, sockmap should act on the =
MPTCP
> > >  sockets, not the in-kernel TCP subflows.
> > >=20
>=20>=20=20
>=20>  Yes, I agree.
> >=20=20
>=20>  For full functionality, we need to retrieve the parent socket from=
 MPTCP
> >  and integrate it with sockmap, rather than simply rejecting.
> >=20
>=20We should be careful when adding such exceptions. I will add more
> details below.
>=20
>=20>=20
>=20> The current implementation rejects MPTCP because I previously attem=
pted to
> >  add sockmap support for MPTCP, but it required implementing many int=
erfaces
> >  and would take considerable time.
> >=20=20
>=20>  So for now, I'm proposing this as a fix to resolve the immediate i=
ssue.
> >  Subsequently, we can continue working on fully integrating MPTCP wit=
h sockmap.
> >=20
>=20It makes sense to start with the fix for stable, then the implementat=
ion
> later. I think the implementation should not be that complex: it is jus=
t
> that it has to be done at MPTCP level, not TCP. sockmap supports
> different protocol, and it doesn't seem to be TCP specific, so that
> should be feasible.

I agree with that. From a userspace perspective, we can't really manipula=
te subflow
TCP directly, and I also think it's correct to handle this at the MPTCP l=
ayer.

But I didn't quite get your point about "it has to be done at MPTCP level=
." Currently,
BPF provides 'sockops' capability, which invokes BPF programs in the prot=
ocol stack.
The input parameter sk for the BPF program is actually a TCP sk (subflow)=
.

Many helper functions (like sockmap) have no choice but to care about whe=
ther it's MPTCP
or not.

> >=20
>=20> >=20
>=20> > There is one particular case to take into consideration: an MPTCP
> > >  connection can fallback to "plain" TCP before being used by the
> > >  userspace. Typically, that's when an MPTCP listening socket receiv=
es a
> > >  "plain" TCP request (without MPTCP): a "plain" TCP socket will the=
n be
> > >  created, and exposed to the userspace. In this case, sk_is_mptcp(s=
k)
> > >  will return false. I guess that's the case you are trying to handl=
e,
> > >  right? (It might help BPF reviewers to mention that in the commit
> > >  message(s).)
> > >=20
>=20>=20=20
>=20>  Yes, this is primarily the case we're addressing. I will add this =
description
> >  to the commit message.
> >=20
>=20Thanks!
>=20
>=20>=20
>=20> >=20
>=20> > I would then say that sk->sk_prot->psock_update_sk_prot should no=
t point
> > >  to tcp_bpf_update_proto() when MPTCP is being used (or this callba=
ck
> > >  should take the MPTCP case into account, but I guess no). In case =
of
> > >  fallback before the accept() stage, the socket can then be used as=
 a
> > >  "plain" TCP one. I guess when tcp_bpf_update_proto() will be calle=
d,
> > >  sk_prot is pointing to tcp(v6)_prot, not the MPTCP subflow overrid=
e one,
> > >  right?
> > >=20
>=20>=20=20
>=20>  Yes, when tcp_bpf_update_proto is called the sk_prot is pointing t=
o tcp(v6)_prot.
> >  subflow_syn_recv_sock
> >  mptcp_subflow_drop_ctx
> >  subflow_ulp_fallback
> >  mptcp_subflow_ops_undo_override -> reset sk_prot to original one
> >=20
>=20I see, it would be good to add that in the commit message as well.

Thanks, I will add it.

>=20
>=20>=20
>=20> So [patch 2/3] aims to prevent psock_update_sk_prot from being exec=
uted on subflows.
> >=20=20
>=20>  Actually, replacing the subflow's callbacks is also incorrect, as =
you mentioned earlier,
> >  because subflows only carry part of the data. By checking for subflo=
ws early and skipping
> >  subsequent steps, we avoid incorrect logic.
> >=20=20
>=20>  Furthermore, there's another risk: if an IPv6 request comes in and=
 we perform the replacement,
> >  MPTCP will roll it back to inet_stream_ops. I haven't delved too dee=
ply into the potential
> >  impact, but I noticed that inet6_release has many V6-specific cleanu=
p procedures not present
> >  in inet_release.
> >=20
>=20That's why we have the WARN_ON_ONCE(): this sk_prot was not expected,=
 a
> fix in the code is required if another value is accepted.
>=20
>=20>=20
>=20> Since subflows
> >  also have their own specialized handlers, this creates a conflict an=
d leads
> >  to traffic failure. Therefore, we need to reject operations targetin=
g
> >  subflows.
> >=20
>=20> >=20
>=20> > Would it not work to set sk_prot->psock_update_sk_prot to NULL fo=
r the
> > >  v4 and v6 subflows (in mptcp_subflow_init()) for the moment while
> > >  sockmap is not supported with MPTCP? This might save you some chec=
ks in
> > >  sock_map.c, no?
> > >=20
>=20>=20=20
>=20>  This seems like a reliable alternative I hadn't considered initial=
ly.
> >=20=20
>=20>  However, adding the check on the BPF side serves another purpose: =
to explicitly
> >  warn users that sockmap and MPTCP are incompatible.
> >=20=20
>=20>  Since the latest Golang version enables MPTCP server by default, a=
nd if the client
> >  doesn't support MPTCP, it falls back to TCP logic. We want to print =
a clear message
> >  informing users who have upgraded to the latest Golang and are using=
 sockmap.
> >=20=20
>=20>  Perhaps we could add a function like sk_is_mptcp_subflow() in the =
MPTCP side?
> >  The implementation would simply be sk_is_tcp(sk) && sk_is_mptcp(sk).
> >=20=20
>=20>  Implementing this check logic on the BPF side might become invalid=
 if MPTCP internals
> >  change later; placing it in the MPTCP side might be a better choice.
> >=20
>=20I can understand that adding an error message can be helpful, but I
> don't think we should add MPTCP specific checks in sockmap for the mome=
nt.

Thanks, I will try to set psock_update_sk_prot to NULL and test it, and i=
f it works I will send a new patch then.

> >=20
>=20> This patchset simply prevents the combination of subflows and sockm=
ap
> >  without changing any functionality.
> >=20
>=20> >=20
>=20> > In your case, you have an MPTCP listening socket, but you receive=
 a TCP
> > >  request, right? The "sockmap update" is done when switching to
> > >  TCP_ESTABLISHED, when !sk_is_mptcp(sk), but that's before
> > >  mptcp_stream_accept(). That's why sk->sk_prot has been modified, b=
ut it
> > >  is fine to look at sk_family, and return inet(6)_stream_ops, right=
?
> > >=20
>=20>=20=20
>=20>  I believe so. Since MPTCP is fundamentally based on TCP, using sk_=
family to
> >  determine which ops to fall back to should be sufficient.
> >=20=20
>=20>  However, strictly speaking, this [patch 1/3] might not even be nec=
essary if we
> >  prevent the sk_prot replacement for subflows at the sockmap layer.
> >=20=20
>=20>=20
>=20> >=20
>=20> > A more important question: what will typically happen in your cas=
e if
> > >  you receive an MPTCP request and sockmap is then not supported? Wi=
ll the
> > >  connection be rejected or stay in a strange state because the user=
space
> > >  will not expect that? In these cases, would it not be better to di=
sallow
> > >  sockmap usage while the MPTCP support is not available? The usersp=
ace
> > >  would then get an error from the beginning that the protocol is no=
t
> > >  supported, and should then not create an MPTCP socket in this case=
 for
> > >  the moment, no?
> > >=20
>=20> >  I can understand that the switch from TCP to MPTCP was probably =
done
> > >  globally, and this transition should be as seamless as possible, b=
ut it
> > >  should not cause a regression with MPTCP requests. An alternative =
could
> > >  be to force a fallback to TCP when sockmap is used, even when an M=
PTCP
> > >  request is received, but not sure if it is practical to do, and mi=
ght be
> > >  strange from the user point of view.
> > >=20
>=20>=20=20
>=20>  Actually, I understand this not as an MPTCP regression, but as a s=
ockmap
> >  regression.
> >=20=20
>=20>  Let me explain how users typically use sockmap:
> >=20=20
>=20>  Users typically create multiple sockets on a host and program usin=
g BPF+sockmap
> >  to enable fast data redirection. This involves intercepting data sen=
t or received
> >  by one socket and redirecting it to the send or receive queue of ano=
ther socket.
> >=20=20
>=20>  This requires explicit user programming. The goal is that when mul=
tiple microservices
> >  on one host need to communicate, they can bypass most of the network=
 stack and avoid
> >  data copies between user and kernel space.
> >=20=20
>=20>  However, when an MPTCP request occurs, this redirection flow fails=
.
> >=20
>=20This part bothers me a bit. Does it mean that when the userspace crea=
tes
> a TCP listening socket (IPPROTO_TCP), MPTCP requests will be accepted,
> but MPTCP will not be used ; but when an MPTCP socket is used instead,
> MPTCP requests will be rejected?

"when the userspace creates a TCP listening socket (IPPROTO_TCP), MPTCP r=
equests will be accepted,
but MPTCP will not be used"
--- Yes, that's essentially the logic behind MPTCP fallback, right? In th=
is case, it should work
fine with sockmap as well. That's exactly what this patch aims to achieve=
.

"but when an MPTCP socket is used instead, MPTCP requests will be rejecte=
d?"
--- Exactly. Currently, because sockmap operates directly on the subflow =
sk, it breaks the MPTCP
connection. The purpose of this patch is to explicitly return an error wh=
en users try to replace
certain handlers of the subflow sk.

This way, users at least get a clear error message instead of just experi=
encing a mysterious connection
failure.

> If yes, it might be clearer not to allow sockmap on connections created
> from MPTCP sockets. But when looking at sockmap and what's happening
> when a TCP socket is created following a "plain TCP" request, we would
> need specific MPTCP code to catch that in sockmap...

I know what you're concerned about, and I also don't want to add any MPTC=
P-specific checks on the
sockmap or BPF side :).

I will try to set psock_update_sk_prot to NULL first.


> >=20
>=20> Since the sockmap workflow typically occurs after the three-way han=
dshake, rolling
> >  back at that point might be too late, and undoing the logic for MPTC=
P would be very
> >  complex.
> >=20=20
>=20>  Regardless, the reality is that MPTCP and sockmap are already conf=
licting, and this
> >  has been the case for some time. So I think our first step is to cat=
ch specific
> >  behavior on the BPF side and print a message
> >  "sockmap/sockhash: MPTCP sockets are not supported\n", informing use=
rs to either
> >  stop using sockmap or not use MPTCP.
> >=20=20
>=20>  As for the logic to check for subflows, I think implementing it in=
 subflow.c would be
> >  beneficial, as this logic would likely be useful later if we want to
> >  support MPTCP + sockmap.
> >=20
>=20Probably yes.
> >=20
>=20> Furthermore, this commit also addresses the issue of incorrectly se=
lecting
> >  inet_stream_ops due to the subflow prot replacement, as mentioned ab=
ove.
> >=20
>=20(indeed, but this seems to happen only when sk_prot has been replaced=
 by
> sockmap :) )
>=20
>=20>=20
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
>=20> >=20
>=20> > That would be great to add MPTCP support in sockmap! As mentioned=
 above,
> > >  this should be done on the MPTCP socket. I guess the TCP "in-kerne=
l"
> > >  subflows should not be modified.
> > >=20
>=20>=20=20
>=20>=20=20
>=20>  I think we should first fix the issue by having sockmap reject ope=
rations on subflows.
> >  Subsequently, we can work on fully integrating sockmap with MPTCP as=
 a feature
> >  (which would require implementing some handlers).
> >=20
>=20OK for me!
>=20
>=20>=20
>=20> [1] truncated warning:
> >  [ 18.234652] ------------[ cut here ]------------
> >  [ 18.234664] WARNING: CPU: 1 PID: 388 at net/mptcp/protocol.c:68 mpt=
cp_stream_accept+0x34c/0x380
> >  [ 18.234726] Modules linked in:
> >  [ 18.234755] RIP: 0010:mptcp_stream_accept+0x34c/0x380
> >  [ 18.234762] RSP: 0018:ffffc90000cf3cf8 EFLAGS: 00010202
> >  [...]
> >=20
>=20> >=20
>=20> > Please next time use the ./scripts/decode_stacktrace.sh if possib=
le.
> > >  (and strip the timestamps if it is not giving useful info)
> > >  Just to be sure: is it the warning you get on top of net or net-ne=
xt? Or
> > >  an older version? (Always useful to mention the base)
> > >=20
>=20>=20=20
>=20>  Thank you, Matthieu. I will pay attention to this.
> >=20=20
>=20>=20=20
>=20>=20
>=20>  ---
> >  v2: https://lore.kernel.org/bpf/20251020060503.325369-1-jiayuan.chen=
@linux.dev/T/#t
> >  Some advice suggested by Jakub Sitnicki
> >=20=20
>=20>  v1: https://lore.kernel.org/mptcp/a0a2b87119a06c5ffaa51427a0964a05=
534fe6f1@linux.dev/T/#t
> >  Some advice from Matthieu Baerts.
> >=20
>=20> >=20
>=20> > (It usually helps reviewers to add more details in the notes/chan=
gelog
> > >  for the individual patch)
> > >=20
>=20>=20=20
>=20>  Thank you, Matthieu. I will provide more detailed descriptions in =
the future.
> >=20
>=20Thanks!
>=20
>=20So for the v4, patch 2/3 would be replaced by one setting ...
>=20
>=20 tcp_prot_override.psock_update_sk_prot =3D NULL;
>  (...)
>  tcpv6_prot_override.psock_update_sk_prot =3D NULL;
>=20
>=20... in mptcp_subflow_init(). (+ more details for patch 1/3).
> From there, we can discuss with other maintainers what to do with the
> MPTCP listening socket + sockmap case. And in parallel, we can also
> discuss MPTCP support with sockmap. WDYT?
>=20

Thanks,=20I will do it.

> Cheers,
> Matt
> --=20
>=20Sponsored by the NGI0 Core fund.
>=20
>=20pw-bot: cr
>

