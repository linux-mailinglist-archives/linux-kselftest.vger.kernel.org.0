Return-Path: <linux-kselftest+bounces-4938-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33F185AB0A
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 19:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C311C21F56
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Feb 2024 18:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52E168A3;
	Mon, 19 Feb 2024 18:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8okv9Fu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F02125D2
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367603; cv=none; b=kqC6PUAtByZF+Upvr+knsUBB1gEmuWXXg1AGCB2eXCUUaUtaeQAmODz4rEi3ToHCHCFhZofUMul26kJsVRSt+mgCC9yNhfv9x6F8x/vwDyaLmSkYVWBxxIDPqH1Nr0TyBgzEhbWtPVS01s9fIbsEA9FcZ1QUcW2+pe7nr4fSz8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367603; c=relaxed/simple;
	bh=urfjPGxUSCWZFzm7sWzHsWMp9j1mL/hHkq92hRdEMl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZtPA+NsI5tHLa7EPvoiUZKfyb2J5775TUjJEVJfsKHlyPmDLxDxPDF07eTXf5laWW9YzyrR+ow7koaSsXqtIevKcKkiMzginpQVPKF7Asj8fyygSEHynVBOJpBnGAGPrUaDQAcHa/0LoldbAZN8DlRpkCeByikGVAYP51XXKZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s8okv9Fu; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5647f4aac6aso11225a12.0
        for <linux-kselftest@vger.kernel.org>; Mon, 19 Feb 2024 10:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708367594; x=1708972394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1K9icUn6knVrJjpIsa0lgiaeTMRuttYU/puu1i4laUA=;
        b=s8okv9Fu6ugklSSAh+1VvYNdFqIWO7S+Yi52wmbJ9bmAw24/VugS11dUM5WUrPBtHI
         NMwJ3QWUsIlkJi1+nD5pvk3VtqzZffg7J4qvGpSFL74d6EsqMecm1ugKOaDMQ2XyX1/O
         6oD9tQu5j2fg2bDq5cfLulm3MJ5qDSV+5ol/hixvROZkvMVCL9dChxI/voD2+7c9RdZQ
         nEp47/GMlNn6SBmTmB4NqoamG+Kj4xnmKAYIdV3FgAh3eZCkU9/szRVHXfUU+Qy21wZk
         NpOSMrioIgrQSmtw+58Qz1YUzpQtTmTe/+DV2rjIIi5A+lj6JzDtFBERShV8+DKbGJaH
         UlwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708367594; x=1708972394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1K9icUn6knVrJjpIsa0lgiaeTMRuttYU/puu1i4laUA=;
        b=cB+uSTnzpv+2R2Dm+kgpHQ9LamNfadI6kqCLTXTPruWuSpasn+UNwuJPGQo2PIvdU+
         RD7K0PKKvkUYTNLRlpHDC0aDglO3QF6zv8aVZlECZvuTqltYduQnAgtN4e+0fHPZgPeO
         M3IztHeZJQYJ+REvtEPlNaTOhOkcuS34U1MZ45WhLmfDgfyXKEINvJAlWAuXNViB5xjy
         7cTyVFEbWB6b/QgkZZoNFc58z5H1vpdI/QEe1Uwzjh/h9dK3cfInjfbTio74Od8jyln/
         XD9+f/aLG2swpgdfHeYcn6Jiu4iyMqkPZ0rPdDLjOLe0qPjerHNLMEbaJoA5jBkpoi6Q
         s3RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr5Ltlq25sUzaglH8DGo6LVcgIBkLzZzSjeYed80OZURZ0i+WKjuJt44rDa8wAR0Dwzh182wvJXZmqXpLayKlODjDoJTXgHu5YjxTPfKd8
X-Gm-Message-State: AOJu0YwGoBH+DebNzB20o2to0pSD1G31hDIFXcvW2r+eZkzhbR6AArg/
	llnhlZuhZS7y2HgCK80JYnA3yscuhzA3nC9hJNUX4tJXHHSZwoqv7d5f/ZZGkVvpRa4AmOy3Pqh
	uEHEy0GDBFygOE1RE9IWUJkirKQMifK522Zr6
X-Google-Smtp-Source: AGHT+IFpLAhyqckLFaen7AWiB1PwE14LElLyPxQQTPrAyv7t4Ui0vG+fVundmKcVTiRmAyxVzowrJkDr8lUWD34KkII=
X-Received: by 2002:a50:9e25:0:b0:560:1a1:eb8d with SMTP id
 z34-20020a509e25000000b0056001a1eb8dmr262864ede.7.1708367593611; Mon, 19 Feb
 2024 10:33:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-upstream-net-20240215-misc-fixes-v1-0-8c01a55d8f6a@kernel.org>
 <20240215-upstream-net-20240215-misc-fixes-v1-3-8c01a55d8f6a@kernel.org>
 <CANn89iJ=Oecw6OZDwmSYc9HJKQ_G32uN11L+oUcMu+TOD5Xiaw@mail.gmail.com>
 <CANn89iJDypRXX-8S-UdqWgw73eOgt0+D74qUCLDkb0cRpFFXkg@mail.gmail.com> <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
In-Reply-To: <278c26d6f4042dc6dadb9742afe11b7fa610f0b2.camel@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Feb 2024 19:33:02 +0100
Message-ID: <CANn89iK72hE16sQcGPUFG6Am_V-77PNJOYHgeAA6M+SD5UO13A@mail.gmail.com>
Subject: Re: [PATCH net 03/13] mptcp: fix lockless access in subflow ULP diag
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, mptcp@lists.linux.dev, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Davide Caratti <dcaratti@redhat.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	stable@vger.kernel.org, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 7:04=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Mon, 2024-02-19 at 18:35 +0100, Eric Dumazet wrote:
> > On Mon, Feb 19, 2024 at 6:21=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > On Thu, Feb 15, 2024 at 7:25=E2=80=AFPM Matthieu Baerts (NGI0)
> > > <matttbe@kernel.org> wrote:
> > > >
> > > > From: Paolo Abeni <pabeni@redhat.com>
> > > >
> > > > Since the introduction of the subflow ULP diag interface, the
> > > > dump callback accessed all the subflow data with lockless.
> > > >
> > > > We need either to annotate all the read and write operation accordi=
ngly,
> > > > or acquire the subflow socket lock. Let's do latter, even if slower=
, to
> > > > avoid a diffstat havoc.
> > > >
> > > > Fixes: 5147dfb50832 ("mptcp: allow dumping subflow context to users=
pace")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > > > Reviewed-by: Mat Martineau <martineau@kernel.org>
> > > > Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> > > > ---
> > > > Notes:
> > > >   - This patch modifies the existing ULP API. No better solutions h=
ave
> > > >     been found for -net, and there is some similar prior art, see
> > > >     commit 0df48c26d841 ("tcp: add tcpi_bytes_acked to tcp_info").
> > > >
> > > >     Please also note that TLS ULP Diag has likely the same issue.
> > > > To: Boris Pismenny <borisp@nvidia.com>
> > > > To: John Fastabend <john.fastabend@gmail.com>
> > > > ---
> > > >  include/net/tcp.h  | 2 +-
> > > >  net/mptcp/diag.c   | 6 +++++-
> > > >  net/tls/tls_main.c | 2 +-
> > > >  3 files changed, 7 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > > > index dd78a1181031..f6eba9652d01 100644
> > > > --- a/include/net/tcp.h
> > > > +++ b/include/net/tcp.h
> > > > @@ -2506,7 +2506,7 @@ struct tcp_ulp_ops {
> > > >         /* cleanup ulp */
> > > >         void (*release)(struct sock *sk);
> > > >         /* diagnostic */
> > > > -       int (*get_info)(const struct sock *sk, struct sk_buff *skb)=
;
> > > > +       int (*get_info)(struct sock *sk, struct sk_buff *skb);
> > > >         size_t (*get_info_size)(const struct sock *sk);
> > > >         /* clone ulp */
> > > >         void (*clone)(const struct request_sock *req, struct sock *=
newsk,
> > > > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> > > > index a536586742f2..e57c5f47f035 100644
> > > > --- a/net/mptcp/diag.c
> > > > +++ b/net/mptcp/diag.c
> > > > @@ -13,17 +13,19 @@
> > > >  #include <uapi/linux/mptcp.h>
> > > >  #include "protocol.h"
> > > >
> > > > -static int subflow_get_info(const struct sock *sk, struct sk_buff =
*skb)
> > > > +static int subflow_get_info(struct sock *sk, struct sk_buff *skb)
> > > >  {
> > > >         struct mptcp_subflow_context *sf;
> > > >         struct nlattr *start;
> > > >         u32 flags =3D 0;
> > > > +       bool slow;
> > > >         int err;
> > > >
> > > >         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
> > > >         if (!start)
> > > >                 return -EMSGSIZE;
> > > >
> > > > +       slow =3D lock_sock_fast(sk);
> > > >         rcu_read_lock();
> > >
> > > I am afraid lockdep is not happy with this change.
> > >
> > > Paolo, we probably need the READ_ONCE() annotations after all.
> >
> > Or perhaps something like the following would be enough.
> >
> > diff --git a/net/mptcp/diag.c b/net/mptcp/diag.c
> > index 6ff6f14674aa2941bc04c680bacd9f79fc65060d..7017dd60659dc7133318c1c=
82e3f429bea3a5d57
> > 100644
> > --- a/net/mptcp/diag.c
> > +++ b/net/mptcp/diag.c
> > @@ -21,6 +21,9 @@ static int subflow_get_info(struct sock *sk, struct
> > sk_buff *skb)
> >         bool slow;
> >         int err;
> >
> > +       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> > +               return 0;
> > +
> >         start =3D nla_nest_start_noflag(skb, INET_ULP_INFO_MPTCP);
> >         if (!start)
> >                 return -EMSGSIZE;
>
> Thanks for the head-up. This later option looks preferable, to avoid
> quit a bit of noise with _ONCE annotation. Is there a syzkaller splat I
> could look at? if it landed on the ML, I missed it.
>

Not landed yet, here is the splat :

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
WARNING: possible circular locking dependency detected
6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0 Not tainted
------------------------------------------------------
syz-executor.2/24141 is trying to acquire lock:
ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
ffff888045870130 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at:
tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137

but task is already holding lock:
ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
include/linux/spinlock.h:351 [inline]
ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&h->lhash2[i].lock){+.+.}-{2:2}:
lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
__raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
_raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
spin_lock include/linux/spinlock.h:351 [inline]
__inet_hash+0x335/0xbe0 net/ipv4/inet_hashtables.c:743
inet_csk_listen_start+0x23a/0x320 net/ipv4/inet_connection_sock.c:1261
__inet_listen_sk+0x2a2/0x770 net/ipv4/af_inet.c:217
inet_listen+0xa3/0x110 net/ipv4/af_inet.c:239
rds_tcp_listen_init+0x3fd/0x5a0 net/rds/tcp_listen.c:316
rds_tcp_init_net+0x141/0x320 net/rds/tcp.c:577
ops_init+0x352/0x610 net/core/net_namespace.c:136
__register_pernet_operations net/core/net_namespace.c:1214 [inline]
register_pernet_operations+0x2cb/0x660 net/core/net_namespace.c:1283
register_pernet_device+0x33/0x80 net/core/net_namespace.c:1370
rds_tcp_init+0x62/0xd0 net/rds/tcp.c:735
do_one_initcall+0x238/0x830 init/main.c:1236
do_initcall_level+0x157/0x210 init/main.c:1298
do_initcalls+0x3f/0x80 init/main.c:1314
kernel_init_freeable+0x42f/0x5d0 init/main.c:1551
kernel_init+0x1d/0x2a0 init/main.c:1441
ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
ret_from_fork_asm+0x1b/0x30 arch/x86/entry/entry_64.S:242

-> #0 (k-sk_lock-AF_INET6){+.+.}-{0:0}:
check_prev_add kernel/locking/lockdep.c:3134 [inline]
check_prevs_add kernel/locking/lockdep.c:3253 [inline]
validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
__lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
lock_sock_fast include/net/sock.h:1723 [inline]
subflow_get_info+0x166/0xd20 net/mptcp/diag.c:28
tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
inet_sk_diag_fill+0x10ed/0x1e00 net/ipv4/inet_diag.c:345
inet_diag_dump_icsk+0x55b/0x1f80 net/ipv4/inet_diag.c:1061
__inet_diag_dump+0x211/0x3a0 net/ipv4/inet_diag.c:1263
inet_diag_dump_compat+0x1c1/0x2d0 net/ipv4/inet_diag.c:1371
netlink_dump+0x59b/0xc80 net/netlink/af_netlink.c:2264
__netlink_dump_start+0x5df/0x790 net/netlink/af_netlink.c:2370
netlink_dump_start include/linux/netlink.h:338 [inline]
inet_diag_rcv_msg_compat+0x209/0x4c0 net/ipv4/inet_diag.c:1405
sock_diag_rcv_msg+0xe7/0x410
netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0x221/0x270 net/socket.c:745
____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
___sys_sendmsg net/socket.c:2638 [inline]
__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
do_syscall_64+0xf9/0x240
entry_SYSCALL_64_after_hwframe+0x6f/0x77

other info that might help us debug this:

Possible unsafe locking scenario:

CPU0 CPU1
---- ----
lock(&h->lhash2[i].lock);
lock(k-sk_lock-AF_INET6);
lock(&h->lhash2[i].lock);
lock(k-sk_lock-AF_INET6);

*** DEADLOCK ***

5 locks held by syz-executor.2/24141:
#0: ffffffff8f380bc8 (sock_diag_mutex){+.+.}-{3:3}, at:
sock_diag_rcv+0x1b/0x40 net/core/sock_diag.c:279
#1: ffffffff8f380a28 (sock_diag_table_mutex){+.+.}-{3:3}, at:
sock_diag_rcv_msg+0xc6/0x410 net/core/sock_diag.c:259
#2: ffff8880586f5680 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{3:3}, at:
netlink_dump+0xde/0xc80 net/netlink/af_netlink.c:2211
#3: ffffffff8f464568 (inet_diag_table_mutex){+.+.}-{3:3}, at:
inet_diag_lock_handler net/ipv4/inet_diag.c:63 [inline]
#3: ffffffff8f464568 (inet_diag_table_mutex){+.+.}-{3:3}, at:
__inet_diag_dump+0x191/0x3a0 net/ipv4/inet_diag.c:1261
#4: ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
include/linux/spinlock.h:351 [inline]
#4: ffffc9000135e488 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
inet_diag_dump_icsk+0x39f/0x1f80 net/ipv4/inet_diag.c:1038

stack backtrace:
CPU: 0 PID: 24141 Comm: syz-executor.2 Not tainted
6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/25/2024
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
check_prev_add kernel/locking/lockdep.c:3134 [inline]
check_prevs_add kernel/locking/lockdep.c:3253 [inline]
validate_chain+0x18ca/0x58e0 kernel/locking/lockdep.c:3869
__lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
lock_sock_fast include/net/sock.h:1723 [inline]
subflow_get_info+0x166/0xd20 net/mptcp/diag.c:28
tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
inet_sk_diag_fill+0x10ed/0x1e00 net/ipv4/inet_diag.c:345
inet_diag_dump_icsk+0x55b/0x1f80 net/ipv4/inet_diag.c:1061
__inet_diag_dump+0x211/0x3a0 net/ipv4/inet_diag.c:1263
inet_diag_dump_compat+0x1c1/0x2d0 net/ipv4/inet_diag.c:1371
netlink_dump+0x59b/0xc80 net/netlink/af_netlink.c:2264
__netlink_dump_start+0x5df/0x790 net/netlink/af_netlink.c:2370
netlink_dump_start include/linux/netlink.h:338 [inline]
inet_diag_rcv_msg_compat+0x209/0x4c0 net/ipv4/inet_diag.c:1405
sock_diag_rcv_msg+0xe7/0x410
netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0x221/0x270 net/socket.c:745
____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
___sys_sendmsg net/socket.c:2638 [inline]
__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
do_syscall_64+0xf9/0x240
entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fbc4c07dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc4ce750c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbc4c1abf80 RCX: 00007fbc4c07dda9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fbc4c0ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbc4c1abf80 R15: 00007ffcc3d92258
</TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3554
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24141, name:
syz-executor.2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 24141 Comm: syz-executor.2 Not tainted
6.8.0-rc4-syzkaller-00212-g40b9385dd8e6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine,
BIOS Google 01/25/2024
Call Trace:
<TASK>
__dump_stack lib/dump_stack.c:88 [inline]
dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
__might_resched+0x5d3/0x780 kernel/sched/core.c:10176
__lock_sock_fast+0x31/0xe0 net/core/sock.c:3554
lock_sock_fast include/net/sock.h:1725 [inline]
subflow_get_info+0x172/0xd20 net/mptcp/diag.c:28
tcp_diag_put_ulp net/ipv4/tcp_diag.c:100 [inline]
tcp_diag_get_aux+0x738/0x830 net/ipv4/tcp_diag.c:137
inet_sk_diag_fill+0x10ed/0x1e00 net/ipv4/inet_diag.c:345
inet_diag_dump_icsk+0x55b/0x1f80 net/ipv4/inet_diag.c:1061
__inet_diag_dump+0x211/0x3a0 net/ipv4/inet_diag.c:1263
inet_diag_dump_compat+0x1c1/0x2d0 net/ipv4/inet_diag.c:1371
netlink_dump+0x59b/0xc80 net/netlink/af_netlink.c:2264
__netlink_dump_start+0x5df/0x790 net/netlink/af_netlink.c:2370
netlink_dump_start include/linux/netlink.h:338 [inline]
inet_diag_rcv_msg_compat+0x209/0x4c0 net/ipv4/inet_diag.c:1405
sock_diag_rcv_msg+0xe7/0x410
netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2543
sock_diag_rcv+0x2a/0x40 net/core/sock_diag.c:280
netlink_unicast_kernel net/netlink/af_netlink.c:1341 [inline]
netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1367
netlink_sendmsg+0xa3b/0xd70 net/netlink/af_netlink.c:1908
sock_sendmsg_nosec net/socket.c:730 [inline]
__sock_sendmsg+0x221/0x270 net/socket.c:745
____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
___sys_sendmsg net/socket.c:2638 [inline]
__sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
do_syscall_64+0xf9/0x240
entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7fbc4c07dda9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbc4ce750c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fbc4c1abf80 RCX: 00007fbc4c07dda9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fbc4c0ca47a R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fbc4c1abf80 R15: 00007ffcc3d92258

