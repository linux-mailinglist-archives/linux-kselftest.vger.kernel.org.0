Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105DA73BA6E
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Jun 2023 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjFWOmP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 23 Jun 2023 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjFWOmD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 23 Jun 2023 10:42:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBD81BE2
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 07:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687531267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sqYSUw7QzPfprFmPveFR/00tu6i/Fm8VFN1BravdvaE=;
        b=R6ClH6kE5BcINT99eOH/EYNsfNaFrsNPqvl1GYSjbPVIsGTR8SCAf8fVvKfwWcEEAWxjH0
        lr6aX0GNY5/HnYw+Lhgh/smwQiRf4Y0WSZROUwSvSBRTex9cuQUt5VIlGR31HOWqEJ5dfi
        4SWORiGHvBmQqJxGShQ62vF2BPfIt44=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-204-CNYqNI5NOKameWMEad94aA-1; Fri, 23 Jun 2023 10:41:06 -0400
X-MC-Unique: CNYqNI5NOKameWMEad94aA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-765342b83faso17829885a.1
        for <linux-kselftest@vger.kernel.org>; Fri, 23 Jun 2023 07:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531266; x=1690123266;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sqYSUw7QzPfprFmPveFR/00tu6i/Fm8VFN1BravdvaE=;
        b=h89/TtVhvAADWb1Rfj2PyvNgdoYfwRRPb4omMHwwawPqGROI0t35NWro2rr2eD3Kw3
         5dNUpb14lIgY7wKIvn3iRfIEAbgELpAMMx1GEcjF6bEKJ0UNabcBQ2htetKU1DQL4LMc
         mkuNiqoWlFPCKZTWPurJNhbj59Alzgw6f2fYlK+W4rTZYYwyyzvmFRy8fCTViP3a8U2T
         o/iR0nj4eO9WjkdHc2gLcxToNM5+JJL23whkwPOarePik945Ol3LSkKDmf/fRbf+7Ut0
         bPkzohzetYM4di6sfonEm/gH8s/k1BApXmUG3Jumo5tY2uaTzu2pCH5Ci9VLV9Q2jasS
         kC+g==
X-Gm-Message-State: AC+VfDzXfotenfVzQaEwOCkrQedM4NppSJKeZVvqCPjjxYAMJGAjWvKq
        TZCaeU9NyG2F/t1IXlYWCFaxDi2JToieDFNPQ0IDyRGDEZE0DuoJGhQtr10eGJRiz1kShAe0AY7
        bHNECTyoBMepzS8zL72s+UO+E9Q+g
X-Received: by 2002:a05:620a:c45:b0:75b:23a1:69e4 with SMTP id u5-20020a05620a0c4500b0075b23a169e4mr24288352qki.4.1687531265882;
        Fri, 23 Jun 2023 07:41:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5N/IMdXrvX1b4+X6A/rHUywM2Pf2WsjHR+/tW1JW7belWg0QfWf7CK3sJH3AqiEPVgUJjNLQ==
X-Received: by 2002:a05:620a:c45:b0:75b:23a1:69e4 with SMTP id u5-20020a05620a0c4500b0075b23a169e4mr24288332qki.4.1687531265552;
        Fri, 23 Jun 2023 07:41:05 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-231-243.dyn.eolo.it. [146.241.231.243])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a03c600b00761fc8a7bc4sm4585785qkm.22.2023.06.23.07.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:41:05 -0700 (PDT)
Message-ID: <55a98e578c8654fec32bef22e811336b3c59ed68.camel@redhat.com>
Subject: Re: [PATCH net-next 2/9] mptcp: track some aggregate data counters
From:   Paolo Abeni <pabeni@redhat.com>
To:     Eric Dumazet <edumazet@google.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>
Cc:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date:   Fri, 23 Jun 2023 16:41:01 +0200
In-Reply-To: <CANn89iK+yWD8jKwvRO_4-Kz7Qumk5WwmtwJDWMKDU2oLyDdGxA@mail.gmail.com>
References: <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-0-62b9444bfd48@tessares.net>
         <20230620-upstream-net-next-20230620-mptcp-expose-more-info-and-misc-v1-2-62b9444bfd48@tessares.net>
         <CANn89iK+yWD8jKwvRO_4-Kz7Qumk5WwmtwJDWMKDU2oLyDdGxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi,

On Fri, 2023-06-23 at 16:25 +0200, Eric Dumazet wrote:
> On Tue, Jun 20, 2023 at 6:30=E2=80=AFPM Matthieu Baerts
> <matthieu.baerts@tessares.net> wrote:
> >=20
> > From: Paolo Abeni <pabeni@redhat.com>
> >=20
> > Currently there are no data transfer counters accounting for all
> > the subflows used by a given MPTCP socket. The user-space can compute
> > such figures aggregating the subflow info, but that is inaccurate
> > if any subflow is closed before the MPTCP socket itself.
> >=20
> > Add the new counters in the MPTCP socket itself and expose them
> > via the existing diag and sockopt. While touching mptcp_diag_fill_info(=
),
> > acquire the relevant locks before fetching the msk data, to ensure
> > better data consistency
> >=20
> > Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/385
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
> > ---
> >  include/uapi/linux/mptcp.h |  5 +++++
> >  net/mptcp/options.c        | 10 ++++++++--
> >  net/mptcp/protocol.c       | 11 ++++++++++-
> >  net/mptcp/protocol.h       |  4 ++++
> >  net/mptcp/sockopt.c        | 25 ++++++++++++++++++++-----
> >  5 files changed, 47 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
> > index 32af2d278cb4..a124be6ebbba 100644
> > --- a/include/uapi/linux/mptcp.h
> > +++ b/include/uapi/linux/mptcp.h
> > @@ -123,6 +123,11 @@ struct mptcp_info {
> >         __u8    mptcpi_local_addr_used;
> >         __u8    mptcpi_local_addr_max;
> >         __u8    mptcpi_csum_enabled;
> > +       __u32   mptcpi_retransmits;
> > +       __u64   mptcpi_bytes_retrans;
> > +       __u64   mptcpi_bytes_sent;
> > +       __u64   mptcpi_bytes_received;
> > +       __u64   mptcpi_bytes_acked;
> >  };
> >=20
> >  /*
> > diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> > index 4bdcd2b326bd..c254accb14de 100644
> > --- a/net/mptcp/options.c
> > +++ b/net/mptcp/options.c
> > @@ -1026,6 +1026,12 @@ u64 __mptcp_expand_seq(u64 old_seq, u64 cur_seq)
> >         return cur_seq;
> >  }
> >=20
> > +static void __mptcp_snd_una_update(struct mptcp_sock *msk, u64 new_snd=
_una)
> > +{
> > +       msk->bytes_acked +=3D new_snd_una - msk->snd_una;
> > +       msk->snd_una =3D new_snd_una;
> > +}
> > +
> >  static void ack_update_msk(struct mptcp_sock *msk,
> >                            struct sock *ssk,
> >                            struct mptcp_options_received *mp_opt)
> > @@ -1057,7 +1063,7 @@ static void ack_update_msk(struct mptcp_sock *msk=
,
> >                 __mptcp_check_push(sk, ssk);
> >=20
> >         if (after64(new_snd_una, old_snd_una)) {
> > -               msk->snd_una =3D new_snd_una;
> > +               __mptcp_snd_una_update(msk, new_snd_una);
> >                 __mptcp_data_acked(sk);
> >         }
> >         mptcp_data_unlock(sk);
> > @@ -1123,7 +1129,7 @@ bool mptcp_incoming_options(struct sock *sk, stru=
ct sk_buff *skb)
> >                 /* on fallback we just need to ignore the msk-level snd=
_una, as
> >                  * this is really plain TCP
> >                  */
> > -               msk->snd_una =3D READ_ONCE(msk->snd_nxt);
> > +               __mptcp_snd_una_update(msk, READ_ONCE(msk->snd_nxt));
> >=20
> >                 __mptcp_data_acked(subflow->conn);
> >                 mptcp_data_unlock(subflow->conn);
> > diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> > index 9c756d675d4d..d5b8e488bce1 100644
> > --- a/net/mptcp/protocol.c
> > +++ b/net/mptcp/protocol.c
> > @@ -377,6 +377,7 @@ static bool __mptcp_move_skb(struct mptcp_sock *msk=
, struct sock *ssk,
> >=20
> >         if (MPTCP_SKB_CB(skb)->map_seq =3D=3D msk->ack_seq) {
> >                 /* in sequence */
> > +               msk->bytes_received +=3D copy_len;
> >                 WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
> >                 tail =3D skb_peek_tail(&sk->sk_receive_queue);
> >                 if (tail && mptcp_try_coalesce(sk, tail, skb))
> > @@ -760,6 +761,7 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *ms=
k)
> >                         MPTCP_SKB_CB(skb)->map_seq +=3D delta;
> >                         __skb_queue_tail(&sk->sk_receive_queue, skb);
> >                 }
> > +               msk->bytes_received +=3D end_seq - msk->ack_seq;
> >                 msk->ack_seq =3D end_seq;
> >                 moved =3D true;
> >         }
> > @@ -1531,8 +1533,10 @@ static void mptcp_update_post_push(struct mptcp_=
sock *msk,
> >          * that has been handed to the subflow for transmission
> >          * and skip update in case it was old dfrag.
> >          */
> > -       if (likely(after64(snd_nxt_new, msk->snd_nxt)))
> > +       if (likely(after64(snd_nxt_new, msk->snd_nxt))) {
> > +               msk->bytes_sent +=3D snd_nxt_new - msk->snd_nxt;
> >                 msk->snd_nxt =3D snd_nxt_new;
> > +       }
> >  }
> >=20
> >  void mptcp_check_and_set_pending(struct sock *sk)
> > @@ -2590,6 +2594,7 @@ static void __mptcp_retrans(struct sock *sk)
> >         }
> >         if (copied) {
> >                 dfrag->already_sent =3D max(dfrag->already_sent, info.s=
ent);
> > +               msk->bytes_retrans +=3D copied;
> >                 tcp_push(ssk, 0, info.mss_now, tcp_sk(ssk)->nonagle,
> >                          info.size_goal);
> >                 WRITE_ONCE(msk->allow_infinite_fallback, false);
> > @@ -3102,6 +3107,10 @@ static int mptcp_disconnect(struct sock *sk, int=
 flags)
> >         WRITE_ONCE(msk->csum_enabled, mptcp_is_checksum_enabled(sock_ne=
t(sk)));
> >         mptcp_pm_data_reset(msk);
> >         mptcp_ca_reset(sk);
> > +       msk->bytes_acked =3D 0;
> > +       msk->bytes_received =3D 0;
> > +       msk->bytes_sent =3D 0;
> > +       msk->bytes_retrans =3D 0;
> >=20
> >         WRITE_ONCE(sk->sk_shutdown, 0);
> >         sk_error_report(sk);
> > diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
> > index 47b46602870e..27adfcc5aaa2 100644
> > --- a/net/mptcp/protocol.h
> > +++ b/net/mptcp/protocol.h
> > @@ -262,10 +262,13 @@ struct mptcp_sock {
> >         u64             local_key;
> >         u64             remote_key;
> >         u64             write_seq;
> > +       u64             bytes_sent;
> >         u64             snd_nxt;
> > +       u64             bytes_received;
> >         u64             ack_seq;
> >         atomic64_t      rcv_wnd_sent;
> >         u64             rcv_data_fin_seq;
> > +       u64             bytes_retrans;
> >         int             rmem_fwd_alloc;
> >         struct sock     *last_snd;
> >         int             snd_burst;
> > @@ -274,6 +277,7 @@ struct mptcp_sock {
> >                                                  * recovery related fie=
lds are under data_lock
> >                                                  * protection
> >                                                  */
> > +       u64             bytes_acked;
> >         u64             snd_una;
> >         u64             wnd_end;
> >         unsigned long   timer_ival;
> > diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> > index e172a5848b0d..fa5055d5b029 100644
> > --- a/net/mptcp/sockopt.c
> > +++ b/net/mptcp/sockopt.c
> > @@ -889,7 +889,9 @@ static int mptcp_getsockopt_first_sf_only(struct mp=
tcp_sock *msk, int level, int
> >=20
> >  void mptcp_diag_fill_info(struct mptcp_sock *msk, struct mptcp_info *i=
nfo)
> >  {
> > +       struct sock *sk =3D (struct sock *)msk;
> >         u32 flags =3D 0;
> > +       bool slow;
> >=20
> >         memset(info, 0, sizeof(*info));
> >=20
> > @@ -898,6 +900,9 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk, s=
truct mptcp_info *info)
> >         info->mptcpi_add_addr_accepted =3D READ_ONCE(msk->pm.add_addr_a=
ccepted);
> >         info->mptcpi_local_addr_used =3D READ_ONCE(msk->pm.local_addr_u=
sed);
> >=20
> > +       if (inet_sk_state_load(sk) =3D=3D TCP_LISTEN)
> > +               return;
> > +
> >         /* The following limits only make sense for the in-kernel PM */
> >         if (mptcp_pm_is_kernel(msk)) {
> >                 info->mptcpi_subflows_max =3D
> > @@ -915,11 +920,21 @@ void mptcp_diag_fill_info(struct mptcp_sock *msk,=
 struct mptcp_info *info)
> >         if (READ_ONCE(msk->can_ack))
> >                 flags |=3D MPTCP_INFO_FLAG_REMOTE_KEY_RECEIVED;
> >         info->mptcpi_flags =3D flags;
> > -       info->mptcpi_token =3D READ_ONCE(msk->token);
> > -       info->mptcpi_write_seq =3D READ_ONCE(msk->write_seq);
> > -       info->mptcpi_snd_una =3D READ_ONCE(msk->snd_una);
> > -       info->mptcpi_rcv_nxt =3D READ_ONCE(msk->ack_seq);
> > -       info->mptcpi_csum_enabled =3D READ_ONCE(msk->csum_enabled);
> > +       mptcp_data_lock(sk);
> > +       info->mptcpi_snd_una =3D msk->snd_una;
> > +       info->mptcpi_rcv_nxt =3D msk->ack_seq;
> > +       info->mptcpi_bytes_acked =3D msk->bytes_acked;
> > +       mptcp_data_unlock(sk);
> > +
> > +       slow =3D lock_sock_fast(sk);
>=20
> This causes a lockdep issue.
>=20
> lock_sock_fast(sk) could sleep, if socket lock is owned by another proces=
s.
>=20
> But we are called from a context where both a spin lock and
> rcu_read_lock() are held.
>=20
> BUG: sleeping function called from invalid context at net/core/sock.c:354=
9
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 316, name: syz-exe=
cutor.4
> preempt_count: 1, expected: 0
> RCU nest depth: 1, expected: 0
> 7 locks held by syz-executor.4/316:
> #0: ffffffff8e125408 (sock_diag_mutex){+.+.}-{3:3}, at:
> sock_diag_rcv+0x1b/0x40 net/core/sock_diag.c:279
> #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at:
> sock_diag_rcv_msg net/core/sock_diag.c:259 [inline]
> #1: ffffffff8e125588 (sock_diag_table_mutex){+.+.}-{3:3}, at:
> sock_diag_rcv_msg+0x2d2/0x440 net/core/sock_diag.c:248
> #2: ffff8880232bb688 (nlk_cb_mutex-SOCK_DIAG){+.+.}-{3:3}, at:
> netlink_dump+0xbe/0xc50 net/netlink/af_netlink.c:2215
> #3: ffffffff8e29a628 (inet_diag_table_mutex){+.+.}-{3:3}, at:
> inet_diag_lock_handler+0x6e/0x100 net/ipv4/inet_diag.c:63
> #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at:
> mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:95 [inline]
> #4: ffffffff8c7990c0 (rcu_read_lock){....}-{1:2}, at:
> mptcp_diag_dump+0x7c8/0x1330 net/mptcp/mptcp_diag.c:197
> #5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at: spin_lock
> include/linux/spinlock.h:350 [inline]
> #5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> mptcp_diag_dump_listeners net/mptcp/mptcp_diag.c:98 [inline]
> #5: ffffc90001316bf0 (&h->lhash2[i].lock){+.+.}-{2:2}, at:
> mptcp_diag_dump+0x838/0x1330 net/mptcp/mptcp_diag.c:197
> #6: ffff88802c42a5f0 (msk_lock-AF_INET){+.+.}-{0:0}, at:
> mptcp_diag_get_info+0x1ae/0x380 net/mptcp/mptcp_diag.c:224
> Preemption disabled at:
> [<0000000000000000>] 0x0

Thank you for the report.

out-of-order patches here. "mptcp: track some aggregate data counters"
should have landed to net-next only after:

57fc0f1ceaa4 mptcp: ensure listener is unhashed before updating the sk
status

The latter should explicitly avoid the critical scenario above. Anyhow
the current net-next tree (after merging back net) should be ok (at
least I can't repro the issue here).

Thanks,

Paolo

