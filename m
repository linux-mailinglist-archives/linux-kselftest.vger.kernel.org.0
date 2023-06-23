Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D494273BA0B
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 16:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjFWOZj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 10:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbjFWOZi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 10:25:38 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C80212129
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 07:25:36 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4007b5bafceso200761cf.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 07:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687530336; x=1690122336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s/bCSs0leHkuLRbxqFmm0F7Q7sN6QnEGgQAjeg/q0qg=;
        b=UTZVbyQ60s3edg9VnLDzaUWbDypdj28SZVR8ORjENRuaRiabrst5RbRNeghP7SLiCK
         lzj3erCDxHr3zLPcKgJsWY5F7cngB8TwMbvnv+2AUaVx/OdmByNIDSDh9Vm1k9kFjh8d
         76o5QNN9Zd6zaYsJKBO5mFeKHvDl5ILDpITmYxe4++IPSDlhhGUVMuNrUuOFmsC7jwQQ
         ipVFsd4q1aBjWz6rnO6HqP2/UXd4pB5FmM0k6fDUPDmC8Yx2rdo1SpTllHPvFBqKDFdI
         N0hS8Oh5+NuZlGjby9aEfihExKeOkN6I7wHaHwyQr/Ox6PmOyyfNSmHlQtm2hTpRrK9B
         pU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687530336; x=1690122336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s/bCSs0leHkuLRbxqFmm0F7Q7sN6QnEGgQAjeg/q0qg=;
        b=SC6h2pEJXLCiOXyvz6ii/GQ/9y7wIjp/kFJr+Nez40gn5+uN6BGenxa7uSBOPer3tJ
         0TwDoi+zWoh0r7U+OXYIWyIhp7xlgAoDfEXTYk1uAsx8k61rvZpRuU9dS3HRW7TMgzzd
         uRtwFi2TKXYEgzkhji5GBGJ/LRwcc/6zLvRHkcg69+Y1cBXTp0f7K1GAZcS6SANyFjAU
         QHSIX31guZuTmH0/pMRIlLxZIaK8rTAnRQhxuRqVv1VY2CxKli242SxVu34+VXf/hS7H
         KavuBIWVRP1E4rgVKK519yiAO2HWrQyAAzBbIcO50cY4FsV9qaFkARkjoSbracexbejj
         3H4w==
X-Gm-Message-State: AC+VfDx34mLZrEYcNOUquCU6PwbJvp1xsGuHX2Ob0niGqCaGu15dNGr2
        P0EoVYmfjKhmpua4c3Hsp76y3TvJcQC77HYs+LbpwA==
X-Google-Smtp-Source: ACHHUZ5jZ12FZsK8Y92FgrzseF5pA9PD4EDiuRL9JxcjCqi2LGKGe0DGGx/J26qUY+k7whWLkj7LfzQr7rzORr9tpBY=
X-Received: by 2002:ac8:598a:0:b0:3f5:49b6:f18d with SMTP id
 e10-20020ac8598a000000b003f549b6f18dmr141113qte.11.1687530335543; Fri, 23 Jun
 2023 07:25:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
 <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-2-62b9444bfd48@tessares.net>
In-Reply-To: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-2-62b9444bfd48@tessares.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 23 Jun 2023 16:25:24 +0200
Message-ID: <CANn89iK+yWD8jKwvRO_4-Kz7Qumk5WwmtwJDWMKDU2oLyDdGxA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/9] mptcp: track some aggregate data counters
To:     Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jun 20, 2023 at 6:30=E2=80=AFPM Matthieu Baerts
<matthieu.baerts@tessares.net> wrote:
>
> From: Paolo Abeni <pabeni@redhat.com>
>
> Currently there are no data transfer counters accounting for all
> the subflows used by a given MPTCP socket. The user-space can compute
> such figures aggregating the subflow info, but that is inaccurate
> if any subflow is closed before the MPTCP socket itself.
>
> Add the new counters in the MPTCP socket itself and expose them
> via the existing diag and sockopt. While touching mptcp_diag_fill_info(),
> acquire the relevant locks before fetching the msk data, to ensure
> better data consistency
>
> Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/385
> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> ---
>  include/uapi/linux/mptcp.h |  5 +++++
>  net/mptcp/options.c        | 10 ++++++++--
>  net/mptcp/protocol.c       | 11 ++++++++++-
>  net/mptcp/protocol.h       |  4 ++++
>  net/mptcp/sockopt.c        | 25 ++++++++++++++++++++-----
>  5 files changed, 47 insertions(+), 8 deletions(-)
>
> diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> index 32af2d278cb4..a124be6ebbba 100644
> --- a/include/uapi/linux/mptcp.h
> +++ b/include/uapi/linux/mptcp.h
> @@ -123,6 +123,11 @@ struct mptcp_info {
>         __u8    mptcpi_local_addr_used;
>         __u8    mptcpi_local_addr_max;
>         __u8    mptcpi_csum_enabled;
> +       __u32   mptcpi_retransmits;
> +       __u64   mptcpi_bytes_retrans;
> +       __u64   mptcpi_bytes_sent;
> +       __u64   mptcpi_bytes_received;
> +       __u64   mptcpi_bytes_acked;
>  };
>
>  /*
> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index 4bdcd2b326bd..c254accb14de 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1026,6 +1026,12 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
>         return cur_seq;
>  }
>
> +static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd_u=
na)
> +{
> +       msk->bytes_acked +=3D new_snd_una - msk->snd_una;
> +       msk->snd_una =3D new_snd_una;
> +}
> +
>  static void ack_update_msk(struct mptcp_sock *msk,
>                            struct sock *ssk,
>                            struct mptcp_options_received *mp_opt)
> @@ -1057,7 +1063,7 @@ static void ack_update_msk(struct mptcp_sock *msk,
>                 __mptcp_check_push(sk, ssk);
>
>         if (after64(new_snd_una, old_snd_una)) {
> -               msk->snd_una =3D new_snd_una;
> +               __mptcp_snd_una_update(msk, new_snd_una);
>                 __mptcp_data_acked(sk);
>         }
>         mptcp_data_unlock(sk);
> @@ -1123,7 +1129,7 @@ bool mptcp_incoming_options(struct sock *sk, struct=
 sk_buff *skb)
>                 /* on fallback we just need to ignore the msk-level snd_u=
na, as
>                  * this is really plain TCP
>                  */
> -               msk->snd_una =3D READ_ONCE(msk->snd_nxt);
> +               __mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));
>
>                 __mptcp_data_acked(subflow->conn);
>                 mptcp_data_unlock(subflow->conn);
> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 9c756d675d4d..d5b8e488bce1 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -377,6 +377,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk, =
struct sock *ssk,
>
>         if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
>                 /* in sequence */
> +               msk->bytes_received +=3D copy_len;
>                 WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
>                 tail =3D skb_peek_tail(&sk->sk_receive_queue);
>                 if (tail && mptcp_try_coalesce(sk, tail, skb))
> @@ -760,6 +761,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
>                         MPTCP_SKB_CB(skb)->map_seq +=3D delta;
>                         __skb_queue_tail(&sk->sk_receive_queue, skb);
>                 }
> +               msk->bytes_received +=3D end_seq - msk->ack_seq;
>                 msk->ack_seq =3D end_seq;
>                 moved =3D true;
>         }
> @@ -1531,8 +1533,10 @@ static void mptcp_update_post_push(struct mptcp_so=
ck *msk,
>          * that has been handed to the subflow for transmission
>          * and skip update in case it was old dfrag.
>          */
> -       if (likely(after64(snd_nxt_new, msk->snd_nxt)))
> +       if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
> +               msk->bytes_sent +=3D snd_nxt_new - msk->snd_nxt;
>                 msk->snd_nxt =3D snd_nxt_new;
> +       }
>  }
>
>  void mptcp_check_and_set_pending(struct sock *sk)
> @@ -2590,6 +2594,7 @@ static void __mptcp_retrans(struct sock *sk)
>         }
>         if (copied) {
>                 dfrag->already_sent =3D max(dfrag->already_sent, info.sen=
t);
> +               msk->bytes_retrans +=3D copied;
>                 tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
>                          info.size_goal);
>                 WRITE_ONCE(msk->allow_infinite_fallback, false);
> @@ -3102,6 +3107,10 @@ static int mptcp_disconnect(struct sock *sk, int f=
lags)
>         WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_net(=
sk)));
>         mptcp_pm_data_reset(msk);
>         mptcp_ca_reset(sk);
> +       msk->bytes_acked =3D 0;
> +       msk->bytes_received =3D 0;
> +       msk->bytes_sent =3D 0;
> +       msk->bytes_retrans =3D 0;
>
>         WRITE_ONCE(sk->sk_shutdown, 0);
>         sk_error_report(sk);
> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> index 47b46602870e..27adfcc5aaa2 100644
> --- a/net/mptcp/protocol.h
> +++ b/net/mptcp/protocol.h
> @@ -262,10 +262,13 @@ struct mptcp_sock {
>         u64             local_key;
>         u64             remote_key;
>         u64             write_seq;
> +       u64             bytes_sent;
>         u64             snd_nxt;
> +       u64             bytes_received;
>         u64             ack_seq;
>         atomic64_t      rcv_wnd_sent;
>         u64             rcv_data_fin_seq;
> +       u64             bytes_retrans;
>         int             rmem_fwd_alloc;
>         struct sock     *last_snd;
>         int             snd_burst;
> @@ -274,6 +277,7 @@ struct mptcp_sock {
>                                                  * recovery related field=
s are under data_lock
>                                                  * protection
>                                                  */
> +       u64             bytes_acked;
>         u64             snd_una;
>         u64             wnd_end;
>         unsigned long   timer_ival;
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index e172a5848b0d..fa5055d5b029 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -889,7 +889,9 @@ static int mptcp_getsockopt_first_sf_only(struct mptc=
p_sock *msk, int level, int
>
>  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *inf=
o)
>  {
> +       struct sock *sk =3D (struct sock *)msk;
>         u32 flags =3D 0;
> +       bool slow;
>
>         memset(info, 0, sizeof(*info));
>
> @@ -898,6 +900,9 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, str=
uct mptcp_info *info)
>         info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_acc=
epted);
>         info->mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_use=
d);
>
> +       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> +               return;
> +
>         /* The following limits only make sense for the in-kernel PM */
>         if (mptcp_pm_is_kernel(msk)) {
>                 info->mptcpi_subflows_max =3D
> @@ -915,11 +920,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, s=
truct mptcp_info *info)
>         if (READ_ONCE(msk->can_ack))
>                 flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
>         info->mptcpi_flags =3D flags;
> -       info->mptcpi_token =3D READ_ONCE(msk->token);
> -       info->mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
> -       info->mptcpi_snd_una =3D READ_ONCE(msk->snd_una);
> -       info->mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
> -       info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
> +       mptcp_data_lock(sk);
> +       info->mptcpi_snd_una =3D msk->snd_una;
> +       info->mptcpi_rcv_nxt =3D msk->ack_seq;
> +       info->mptcpi_bytes_acked =3D msk->bytes_acked;
> +       mptcp_data_unlock(sk);
> +
> +       slow =3D lock_sock_fast(sk);

This causes a lockdep issue.

lock_sock_fast(sk) could sleep, if socket lock is owned by another process.

But we are called from a context where both a spin lock and
rcu_read_lock() are held.

BUG: sleeping function called from invalid context at net/core/sock.c:3549
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 316, name: syz-execu=
tor.4
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 0
7 locks held by syz-executor.4/316:
#0: ffffffff8e125408 (sock_diag_mutex){+.+.}-{3:3}, at:
sock_diag_rcv+0x1b/0x40 net/core/sock_diag.c:279
#1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at:
sock_diag_rcv_msg net/core/sock_diag.c:259 [inline]
#1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at:
sock_diag_rcv_msg+0x2d2/0x440 net/core/sock_diag.c:248
#2: ffff8880232bb688 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{3:3}, at:
netlink_dump+0xbe/0xc50 net/netlink/af_netlink.c:2215
#3: ffffffff8e29a628 (inet_diag_table_mutex){+.+.}-{3:3}, at:
inet_diag_lock_handler+0x6e/0x100 net/ipv4/inet_diag.c:63
#4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at:
mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:95 [inline]
#4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at:
mptcp_diag_dump+0x7c8/0x1330 net/mptcp/mptcp_diag.c:197
#5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
include/linux/spinlock.h:350 [inline]
#5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:98 [inline]
#5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
mptcp_diag_dump+0x838/0x1330 net/mptcp/mptcp_diag.c:197
#6: ffff88802c42a5f0 (msk_lock-AF_INET){+.+.}-{0:0}, at:
mptcp_diag_get_info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
Preemption disabled at:
[<0000000000000000>] 0x0

> +       info->mptcpi_csum_enabled =3D msk->csum_enabled;
> +       info->mptcpi_token =3D msk->token;
> +       info->mptcpi_write_seq =3D msk->write_seq;
> +       info->mptcpi_retransmits =3D inet_csk(sk)->icsk_retransmits;
> +       info->mptcpi_bytes_sent =3D msk->bytes_sent;
> +       info->mptcpi_bytes_received =3D msk->bytes_received;
> +       info->mptcpi_bytes_retrans =3D msk->bytes_retrans;
> +       unlock_sock_fast(sk, slow);
>  }
>  EXPORT_SYMBOL_GPL(mptcp_diag_fill_info);
>
>
> --
> 2.40.1
>
