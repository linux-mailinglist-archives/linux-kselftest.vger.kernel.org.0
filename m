Return-Path: <linux-kselftest+bounces-48499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE34D02CEB
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 14:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 195B630A5E98
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 12:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7E3EF0D6;
	Thu,  8 Jan 2026 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZpPt0D+M"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E027C162
	for <linux-kselftest@vger.kernel.org>; Thu,  8 Jan 2026 11:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872833; cv=none; b=OXuDX71E9PY6r5sEY+9/Ik7MJykijm/gp7dYNtkQOVNEGqUJyTV2PVaXiqKI/y/cCWTQ1CCbMyI1TahZutRBSol8ywiIMPPs3V4YMwbs5ZOJDjfGlacbdswgM7stRuHO6vCAKXMv+A5ObBQLU6O8RCStG8xg2MgSd40kXZlaOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872833; c=relaxed/simple;
	bh=ae1ahcMQ6W4KZC2gE/1OZAOU9eLsdS4SuPOqdQF4o7o=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SDeLOQGzPfDT0C/Iw1rERYj/GJyhc0iQzJctnSGcf9yagfspJkmBK4fCQFylpYT7Rxh3x4x//T5NVtuEHZk8i7KTfO5S6BJhaKxKFaPaADxTiPWC1l5+VlfYKKg3u6hxL8Z3UPBbl6RF6Js8YQDOt3KIMqPz7UPFYRDgV1OTDPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZpPt0D+M; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767872815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UtoPCHhrlUD7ktISh+mpZ5JLYC/bBj6xbi4IbIb21ao=;
	b=ZpPt0D+MZiWgXOEGPQGunqR/Xuf0FYuGpBUcvkesYci2sc/FfSTQewLlSjWyi3fonfP6be
	GWS+OwdoWkiLHyr4kWdf+RbaHiZ1g7RcTr4KE+MhVXAsifWFX+XY906l34+ulH/mWRWHWj
	NN3Sw1c79mus4XV8NYrOitHrVf+cPQE=
Date: Thu, 08 Jan 2026 11:46:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <66843c358b71a0dc3e57cc6ac6c0e8b1bb018e38@linux.dev>
TLS-Required: No
Subject: Re: [PATCH bpf-next v5 2/3] bpf, sockmap: Fix FIONREAD for sockmap
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org, "John Fastabend" <john.fastabend@gmail.com>, "David 
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Neal Cardwell"
 <ncardwell@google.com>, "Kuniyuki Iwashima" <kuniyu@google.com>, "David
 Ahern" <dsahern@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Martin  KaFai Lau" <martin.lau@linux.dev>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "KP  Singh" <kpsingh@kernel.org>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "Hao  Luo" <haoluo@google.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "Stefano
 Garzarella" <sgarzare@redhat.com>, "Michal  Luczaj" <mhal@rbox.co>, "Cong
 Wang" <cong.wang@bytedance.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
In-Reply-To: <87ikddijrd.fsf@cloudflare.com>
References: <20260106051458.279151-1-jiayuan.chen@linux.dev>
 <20260106051458.279151-3-jiayuan.chen@linux.dev>
 <87ikddijrd.fsf@cloudflare.com>
X-Migadu-Flow: FLOW_OUT

January 7, 2026 at 22:23, "Jakub Sitnicki" <jakub@cloudflare.com mailto:j=
akub@cloudflare.com?to=3D%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.c=
om%3E > wrote:


>=20
>=20On Tue, Jan 06, 2026 at 01:14 PM +08, Jiayuan Chen wrote:
>=20
>=20>=20
>=20> A socket using sockmap has its own independent receive queue: ingre=
ss_msg.
> >  This queue may contain data from its own protocol stack or from othe=
r
> >  sockets.
> >=20
>=20>  Therefore, for sockmap, relying solely on copied_seq and rcv_nxt t=
o
> >  calculate FIONREAD is not enough.
> >=20
>=20>  This patch adds a new ingress_size field in the psock structure to=
 record
> >  the data length in ingress_msg. Additionally, we implement new ioctl
> >  interfaces for TCP and UDP to intercept FIONREAD operations. While U=
nix
> >  and VSOCK also support sockmap and have similar FIONREAD calculation
> >  issues, fixing them would require more extensive changes
> >  (please let me know if modifications are needed). I believe it's not
> >  appropriate to include those changes under this fix patch.
> >=20
>=20Nit: These last two lines don't really belong in the commit message.
> Side notes for reviewers can be added after the "---" marker.
>=20
>=20>=20
>=20> Previous work by John Fastabend made some efforts towards FIONREAD =
support:
> >  commit e5c6de5fa025 ("bpf, sockmap: Incorrectly handling copied_seq"=
)
> >  Although the current patch is based on the previous work by John Fas=
tabend,
> >  it is acceptable for our Fixes tag to point to the same commit.
> >=20
>=20>  FD1:read()
> >  -- FD1->copied_seq++
> >  | [read data]
> >  |
> >  [enqueue data] v
> >  [sockmap] -> ingress to self -> ingress_msg queue
> >  FD1 native stack ------> ^
> >  -- FD1->rcv_nxt++ -> redirect to other | [enqueue data]
> >  | |
> >  | ingress to FD1
> >  v ^
> >  ... | [sockmap]
> >  FD2 native stack
> >=20
>=20>  Fixes: 04919bed948dc ("tcp: Introduce tcp_read_skb()")
> >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> >  ---
> >  include/linux/skmsg.h | 67 +++++++++++++++++++++++++++++++++++++++++=
--
> >  net/core/skmsg.c | 3 ++
> >  net/ipv4/tcp_bpf.c | 21 ++++++++++++++
> >  net/ipv4/udp_bpf.c | 25 +++++++++++++---
> >  4 files changed, 110 insertions(+), 6 deletions(-)
> >=20
>=20>  diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> >  index 0323a2b6cf5e..1fa03953043f 100644
> >  --- a/include/linux/skmsg.h
> >  +++ b/include/linux/skmsg.h
> >  @@ -97,6 +97,7 @@ struct sk_psock {
> >  struct sk_buff_head ingress_skb;
> >  struct list_head ingress_msg;
> >  spinlock_t ingress_lock;
> >  + ssize_t ingress_size;
> >=20
>=20The name is not great because we also already have `ingress_bytes`.
> I suggest to rename and add a doc string. Also we don't expect the coun=
t
> to ever be negative. Why ssize_t when we store all other byte counts
> there as u32?
>=20
>=20 /** @msg_tot_len: Total bytes queued in ingress_msg list. */
>  u32 msg_tot_len;
>=20
>=20>=20
>=20> unsigned long state;
> >  struct list_head link;
> >  spinlock_t link_lock;
> >  @@ -321,6 +322,27 @@ static inline void sock_drop(struct sock *sk, s=
truct sk_buff *skb)
> >  kfree_skb(skb);
> >  }
> >=20=20
>=20>  +static inline ssize_t sk_psock_get_msg_size_nolock(struct sk_psoc=
k *psock)
> >  +{
> >  + /* Used by ioctl to read ingress_size only; lock-free for performa=
nce */
> >  + return READ_ONCE(psock->ingress_size);
> >  +}
> >  +
> >  +static inline void sk_psock_inc_msg_size_locked(struct sk_psock *ps=
ock, ssize_t diff)
> >  +{
> >  + /* Use WRITE_ONCE to ensure correct read in sk_psock_get_msg_size_=
nolock().
> >  + * ingress_lock should be held to prevent concurrent updates to ing=
ress_size
> >  + */
> >  + WRITE_ONCE(psock->ingress_size, psock->ingress_size + diff);
> >  +}
> >  +
> >  +static inline void sk_psock_inc_msg_size(struct sk_psock *psock, ss=
ize_t diff)
> >=20
>=20Not sure about this function name. "inc" usually means increment by o=
ne.
> Was that modeled after some existing interface?
>=20
>=20If not, I'd switch rename to sk_psock_msg_len_add(..., int delta)
>=20
>=20Following the naming convention from sk_forward_alloc_add(),
> skb_frag_size_add(), skb_len_add(), etc.
>=20
>=20>=20
>=20> +{
> >  + spin_lock_bh(&psock->ingress_lock);
> >  + sk_psock_inc_msg_size_locked(psock, diff);
> >  + spin_unlock_bh(&psock->ingress_lock);
> >  +}
> >  +
> >  static inline bool sk_psock_queue_msg(struct sk_psock *psock,
> >  struct sk_msg *msg)
> >  {
> >  @@ -329,6 +351,7 @@ static inline bool sk_psock_queue_msg(struct sk_=
psock *psock,
> >  spin_lock_bh(&psock->ingress_lock);
> >  if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
> >  list_add_tail(&msg->list, &psock->ingress_msg);
> >  + sk_psock_inc_msg_size_locked(psock, msg->sg.size);
> >  ret =3D true;
> >  } else {
> >  sk_msg_free(psock->sk, msg);
> >  @@ -345,18 +368,25 @@ static inline struct sk_msg *sk_psock_dequeue_=
msg(struct sk_psock *psock)
> >=20=20
>=20>  spin_lock_bh(&psock->ingress_lock);
> >  msg =3D list_first_entry_or_null(&psock->ingress_msg, struct sk_msg,=
 list);
> >  - if (msg)
> >  + if (msg) {
> >  list_del(&msg->list);
> >  + sk_psock_inc_msg_size_locked(psock, -msg->sg.size);
> >  + }
> >  spin_unlock_bh(&psock->ingress_lock);
> >  return msg;
> >  }
> >=20=20
>=20>  +static inline struct sk_msg *sk_psock_peek_msg_locked(struct sk_p=
sock *psock)
> >  +{
> >  + return list_first_entry_or_null(&psock->ingress_msg, struct sk_msg=
, list);
> >  +}
> >  +
> >  static inline struct sk_msg *sk_psock_peek_msg(struct sk_psock *psoc=
k)
> >  {
> >  struct sk_msg *msg;
> >=20=20
>=20>  spin_lock_bh(&psock->ingress_lock);
> >  - msg =3D list_first_entry_or_null(&psock->ingress_msg, struct sk_ms=
g, list);
> >  + msg =3D sk_psock_peek_msg_locked(psock);
> >  spin_unlock_bh(&psock->ingress_lock);
> >  return msg;
> >  }
> >  @@ -523,6 +553,39 @@ static inline bool sk_psock_strp_enabled(struct=
 sk_psock *psock)
> >  return !!psock->saved_data_ready;
> >  }
> >=20=20
>=20>  +/* for tcp only, sk is locked */
> >  +static inline ssize_t sk_psock_msg_inq(struct sock *sk)
> >  +{
> >  + struct sk_psock *psock;
> >  + ssize_t inq =3D 0;
> >  +
> >  + psock =3D sk_psock_get(sk);
> >  + if (likely(psock)) {
> >  + inq =3D sk_psock_get_msg_size_nolock(psock);
> >  + sk_psock_put(sk, psock);
> >  + }
> >  + return inq;
> >  +}
> >  +
> >  +/* for udp only, sk is not locked */
> >  +static inline ssize_t sk_msg_first_length(struct sock *sk)
> >=20
>=20s/_length/_len/
>=20
>=20>=20
>=20> +{
> >  + struct sk_psock *psock;
> >  + struct sk_msg *msg;
> >  + ssize_t inq =3D 0;
> >  +
> >  + psock =3D sk_psock_get(sk);
> >  + if (likely(psock)) {
> >  + spin_lock_bh(&psock->ingress_lock);
> >  + msg =3D sk_psock_peek_msg_locked(psock);
> >  + if (msg)
> >  + inq =3D msg->sg.size;
> >  + spin_unlock_bh(&psock->ingress_lock);
> >  + sk_psock_put(sk, psock);
> >  + }
> >  + return inq;
> >  +}
> >  +
> >  #if IS_ENABLED(CONFIG_NET_SOCK_MSG)
> >=20=20
>=20>  #define BPF_F_STRPARSER (1UL << 1)
> >  diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> >  index d73e03f7713a..c959d52a62b2 100644
> >  --- a/net/core/skmsg.c
> >  +++ b/net/core/skmsg.c
> >  @@ -455,6 +455,7 @@ int __sk_msg_recvmsg(struct sock *sk, struct sk_=
psock *psock, struct msghdr *msg
> >  atomic_sub(copy, &sk->sk_rmem_alloc);
> >  }
> >  msg_rx->sg.size -=3D copy;
> >  + sk_psock_inc_msg_size(psock, -copy);
> >=20=20
>=20>  if (!sge->length) {
> >  sk_msg_iter_var_next(i);
> >  @@ -819,9 +820,11 @@ static void __sk_psock_purge_ingress_msg(struct=
 sk_psock *psock)
> >  list_del(&msg->list);
> >  if (!msg->skb)
> >  atomic_sub(msg->sg.size, &psock->sk->sk_rmem_alloc);
> >  + sk_psock_inc_msg_size(psock, -((ssize_t)msg->sg.size));
> >=20
>=20Cast won't be needed after you switch param type to `int`.
>=20
>=20>=20
>=20> sk_msg_free(psock->sk, msg);
> >  kfree(msg);
> >  }
> >  + WARN_ON_ONCE(psock->ingress_size);
> >  }
> >=20=20
>=20>  static void __sk_psock_zap_ingress(struct sk_psock *psock)
> >  diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> >  index 6332fc36ffe6..a9c758868f13 100644
> >  --- a/net/ipv4/tcp_bpf.c
> >  +++ b/net/ipv4/tcp_bpf.c
> >  @@ -10,6 +10,7 @@
> >=20=20
>=20>  #include <net/inet_common.h>
> >  #include <net/tls.h>
> >  +#include <asm/ioctls.h>
> >=20=20
>=20>  void tcp_eat_skb(struct sock *sk, struct sk_buff *skb)
> >  {
> >  @@ -332,6 +333,25 @@ static int tcp_bpf_recvmsg_parser(struct sock *=
sk,
> >  return copied;
> >  }
> >=20=20
>=20>  +static int tcp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> >  +{
> >  + bool slow;
> >  +
> >  + /* we only care about FIONREAD */
> >=20
>=20Nit: This comment seems redundant. The expression is obvious.
>=20
>=20>=20
>=20> + if (cmd !=3D SIOCINQ)
> >  + return tcp_ioctl(sk, cmd, karg);
> >  +
> >  + /* works similar as tcp_ioctl */
> >  + if (sk->sk_state =3D=3D TCP_LISTEN)
> >  + return -EINVAL;
> >  +
> >  + slow =3D lock_sock_fast(sk);
> >  + *karg =3D sk_psock_msg_inq(sk);
> >  + unlock_sock_fast(sk, slow);
> >  +
> >  + return 0;
> >  +}
> >  +
> >  static int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size=
_t len,
> >  int flags, int *addr_len)
> >  {
> >  @@ -610,6 +630,7 @@ static void tcp_bpf_rebuild_protos(struct proto =
prot[TCP_BPF_NUM_CFGS],
> >  prot[TCP_BPF_BASE].close =3D sock_map_close;
> >  prot[TCP_BPF_BASE].recvmsg =3D tcp_bpf_recvmsg;
> >  prot[TCP_BPF_BASE].sock_is_readable =3D sk_msg_is_readable;
> >  + prot[TCP_BPF_BASE].ioctl =3D tcp_bpf_ioctl;
> >=20=20
>=20>  prot[TCP_BPF_TX] =3D prot[TCP_BPF_BASE];
> >  prot[TCP_BPF_TX].sendmsg =3D tcp_bpf_sendmsg;
> >  diff --git a/net/ipv4/udp_bpf.c b/net/ipv4/udp_bpf.c
> >  index 0735d820e413..cc1156aef14d 100644
> >  --- a/net/ipv4/udp_bpf.c
> >  +++ b/net/ipv4/udp_bpf.c
> >  @@ -5,6 +5,7 @@
> >  #include <net/sock.h>
> >  #include <net/udp.h>
> >  #include <net/inet_common.h>
> >  +#include <asm/ioctls.h>
> >=20=20
>=20>  #include "udp_impl.h"
> >=20=20
>=20>  @@ -111,12 +112,28 @@ enum {
> >  static DEFINE_SPINLOCK(udpv6_prot_lock);
> >  static struct proto udp_bpf_prots[UDP_BPF_NUM_PROTS];
> >=20=20
>=20>  +static int udp_bpf_ioctl(struct sock *sk, int cmd, int *karg)
> >  +{
> >  + /* we only care about FIONREAD */
> >  + if (cmd !=3D SIOCINQ)
> >  + return udp_ioctl(sk, cmd, karg);
> >  +
> >  + /* works similar as udp_ioctl.
> >  + * man udp(7): "FIONREAD (SIOCINQ): Returns the size of the next
> >  + * pending datagram in the integer in bytes, or 0 when no datagram
> >  + * is pending."
> >  + */
> >=20
>=20Not sure we need to quote man pages here.
>=20
>=20>=20
>=20> + *karg =3D sk_msg_first_length(sk);
> >  + return 0;
> >  +}
> >  +
> >  static void udp_bpf_rebuild_protos(struct proto *prot, const struct =
proto *base)
> >  {
> >  - *prot =3D *base;
> >  - prot->close =3D sock_map_close;
> >  - prot->recvmsg =3D udp_bpf_recvmsg;
> >  - prot->sock_is_readable =3D sk_msg_is_readable;
> >  + *prot =3D *base;
> >  + prot->close =3D sock_map_close;
> >  + prot->recvmsg =3D udp_bpf_recvmsg;
> >  + prot->sock_is_readable =3D sk_msg_is_readable;
> >  + prot->ioctl =3D udp_bpf_ioctl;
> >  }
> >=20=20
>=20>  static void udp_bpf_check_v6_needs_rebuild(struct proto *ops)
> >
>

Thanks Jakub. All good suggestions. I've applied them in v6.

