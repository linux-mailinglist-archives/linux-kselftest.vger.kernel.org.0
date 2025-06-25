Return-Path: <linux-kselftest+bounces-35731-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F27C6AE7972
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 10:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7104C1BC6114
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 08:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1F20C476;
	Wed, 25 Jun 2025 08:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B78t5m2C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AF19259F
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 08:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838710; cv=none; b=Tu7O3YNWFSxB4NZ3ALs+8RWhOwlb+RP5aj4yFBH50tRdG8y6nXUG2hC1B3TvpYK5Qpan3/p9tv+3h288S5ODp+i/BE2heq6ZoZS29AZ06xH52UbI08VkSjCR4C1Ooc1wHKHmQMo5xa2OdoE/xHmN35qkLOBA2TMj3IpSI7LMrWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838710; c=relaxed/simple;
	bh=doj2KxQXr2JYgemiYHZoSgaibHLUKUsXh4X7WLjs+7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpFre4+xHLKWgD+4IvLoI40zXFGeXaT9p8USoEOyzNQ0PUdAk25nSxyH/BEXTlpn61lhCLkgMyNSmiX2ByIb4pDrWlQC2y9vbPkWnUE6TQ/A8T0DlFJGvUvlyuMzW8NQsi42hOmYhyRyM5edI7DFruBh2G8tTFjx6e08536/tAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B78t5m2C; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a58f79d6e9so17566381cf.2
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750838707; x=1751443507; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VGwrH8Yuzi84pW5ge3AgF7wFAMzfKjXr17ViqErgJDc=;
        b=B78t5m2CdEhGGADeWJFQW+4elkv1LXdc0DMV57dfIsmvvmGLBRt3hQSgAWao/LJEAQ
         s4pjRM0BA4aomT7nTuCIF97Us243oM11gY257ZLh3WwSwz1m4tWLhBiHHSsKwD1ELBq3
         CqBporbMX5sXxSAXxE+7Su44FxmXy18yW4cLkcIlpEvdF35CBPGKSHAiHGaD6kLrjR//
         AwC5SgKDrbMHa0sUlkN2m0/sJyxcodzQi8jIx4GuCU+onYMgHp9d/7QPFX3mWYJoBieA
         DexWG0Jgj51cJYe1biQKlbeCQo4dhlaosMzKqftspTtVSQoROvaOMCacIgJlew1LUW7N
         pHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838707; x=1751443507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VGwrH8Yuzi84pW5ge3AgF7wFAMzfKjXr17ViqErgJDc=;
        b=k1NWoa8H3M6etMfNrA2EH7AuDYG0pyxuYNcpkSpbx7a6i5nlbFMntm8U0S0jLAcB2j
         L/8eDHgWJJSgdnut+3JudhlNZNxzd76zvWQWqukUGz+8jVr+aGvn+IjUT4+bqCKZst+N
         Sz9uWz5SrxSeSmpRfMfa0fA66j2OLbddUvYauXKCELNp6jVoSxrf17f1eXp0OyYfuiXi
         Hj/uH3qVkpqsso5OZA4pNwe+rbPGjlesxid8tp4FKW9zJPmpNQZKArxkz9w7kQT2E7S9
         smgp1DgDHawsy10IGvq/dh3FcYxLTBXoxuQsUAOPSVE8DZGYVN+SzJPnvTWUtcPdDlXq
         aRdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnqR1PPyJM8jdz4ZCdZiTdfIyIBarDjdxtWmPByq64IqM9I6YoN2+G0ftndLFVcKjgrlGjCKpr1GYOhMJ1QC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LRfELUCggaVQVHeXSctNzgWUAPZRnty5XlZSRVj2Bsz4pZYm
	5eCKYkZUYey0QHvSK/ljD1PA7JNCaA++Ka18J//JOX9AmQng7wQxHiGWN3H9L+cJSy94a2khXB6
	SnmN2hQ4qC4kX3ArHScFHrxRi0CgzIBmb1OenmRoY
X-Gm-Gg: ASbGncuAEnBeCtLbWqv578M4rB6hysnMsUJKsGUcWagqcTBSQdLE25fGJpm0j50hOrO
	9YnrWvkSJRz7aWMPOpglucMTPDeilnbL0ntq/82okkTuVlt8/93Mb+NOcQO2ku7//GeZhEsyN2a
	gHyaMEirSPiu3NkN/iUzbHyw9grx38QXCSvtOk2BLAWQ==
X-Google-Smtp-Source: AGHT+IGpOxiBre/vup+vst4NlCcAzrArd6tOzCflb4YUs2+5cQjZ4QL6ilGCUwvQktonV2BKmME/MpGBAimXnaxEbc0=
X-Received: by 2002:a05:622a:2307:b0:476:7b0b:30fb with SMTP id
 d75a77b69052e-4a7c0b19e16mr32748951cf.22.1750838706706; Wed, 25 Jun 2025
 01:05:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-7-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-7-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 01:04:55 -0700
X-Gm-Features: AX0GCFtpL32jv2U4LejzfAmi77DRfLRJlefavX_UqRzas3dpA2rqHt37JW4XfP8
Message-ID: <CANn89iKuE7gLXq5qn0PDCKOXxOZdMXXxtW1dA-D0eLjfhwApgQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 06/15] tcp: accecn: add AccECN rx byte counters
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch, 
	donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org, 
	ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> These three byte counters track IP ECN field payload byte sums for
> all arriving (acceptable) packets for ECT0, ECT1, and CE. The
> AccECN option (added by a later patch in the series) echoes these
> counters back to sender side; therefore, it is placed within the
> group of tcp_sock_write_txrx.
>
> Below are the pahole outcomes before and after this patch, in which
> the group size of tcp_sock_write_txrx is increased from 95 + 4 to
> 107 + 4 and an extra 4-byte hole is created but will be exploited
> in later patches:
>
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ce;         /*  2640     4 */
>     u32                        received_ce;          /*  2644     4 */
>     u32                        app_limited;          /*  2648     4 */
>     u32                        rcv_wnd;              /*  2652     4 */
>     struct tcp_options_received rx_opt;              /*  2656    24 */
>     __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2680     0 */
>
>     [...]
>     /* size: 3264, cachelines: 51, members: 169 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ce;         /*  2640     4 */
>     u32                        received_ce;          /*  2644     4 */
>     u32                        received_ecn_bytes[3];/*  2648    12 */
>     u32                        app_limited;          /*  2660     4 */
>     u32                        rcv_wnd;              /*  2664     4 */
>     struct tcp_options_received rx_opt;              /*  2668    24 */
>     __cacheline_group_end__tcp_sock_write_txrx[0];   /*  2692     0 */
>     /* XXX 4 bytes hole, try to pack */
>
>     [...]
>     /* size: 3264, cachelines: 51, members: 170 */
> }
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v8:
> - Add new helper function tcp_ecn_received_counters_payload()
> ---
>  .../networking/net_cachelines/tcp_sock.rst    |  1 +
>  include/linux/tcp.h                           |  4 ++++
>  include/net/tcp.h                             | 20 +++++++++++++++++-
>  net/ipv4/tcp.c                                |  3 ++-
>  net/ipv4/tcp_input.c                          | 21 +++++++++++++++----
>  net/ipv4/tcp_minisocks.c                      |  2 +-
>  6 files changed, 44 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Docum=
entation/networking/net_cachelines/tcp_sock.rst
> index 22ac668fe6c7..804480d39132 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -102,6 +102,7 @@ u32                           prr_out                =
 read_mostly         read_m
>  u32                           delivered               read_mostly       =
  read_write          tcp_rate_skb_sent, tcp_newly_delivered(tx);tcp_ack, t=
cp_rate_gen, tcp_clean_rtx_queue (rx)
>  u32                           delivered_ce            read_mostly       =
  read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
>  u32                           received_ce             read_mostly       =
  read_write
> +u32[3]                        received_ecn_bytes      read_mostly       =
  read_write
>  u8:4                          received_ce_pending     read_mostly       =
  read_write
>  u8:2                          syn_ect_snt             write_mostly      =
  read_write
>  u8:2                          syn_ect_rcv             read_mostly       =
  read_write
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 1d8301f2883c..0c2331e186e8 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -306,6 +306,10 @@ struct tcp_sock {
>         u32     delivered;      /* Total data packets delivered incl. rex=
mits */
>         u32     delivered_ce;   /* Like the above but only ECE marked pac=
kets */
>         u32     received_ce;    /* Like the above but for rcvd CE marked =
pkts */
> +       u32     received_ecn_bytes[3]; /* received byte counters for thre=
e ECN
> +                                       * types: INET_ECN_ECT_1, INET_ECN=
_ECT_0,
> +                                       * and INET_ECN_CE
> +                                       */
>         u32     app_limited;    /* limited until "delivered" reaches this=
 val */
>         u32     rcv_wnd;        /* Current receiver window              *=
/
>  /*
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 4d6325fa3f67..b861941a2213 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -467,7 +467,10 @@ static inline int tcp_accecn_extract_syn_ect(u8 ace)
>  bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_e=
ct);
>  void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
>                           u8 syn_ect_snt);
> -void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *sk=
b);
> +void tcp_ecn_received_counters_payload(struct sock *sk,
> +                                      const struct sk_buff *skb);
> +void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *sk=
b,
> +                              u32 payload_len);
>
>  enum tcp_tw_status {
>         TCP_TW_SUCCESS =3D 0,
> @@ -1035,6 +1038,20 @@ static inline u32 tcp_rsk_tsval(const struct tcp_r=
equest_sock *treq)
>   * See draft-ietf-tcpm-accurate-ecn for the latest values.
>   */
>  #define TCP_ACCECN_CEP_INIT_OFFSET 5
> +#define TCP_ACCECN_E1B_INIT_OFFSET 1
> +#define TCP_ACCECN_E0B_INIT_OFFSET 1
> +#define TCP_ACCECN_CEB_INIT_OFFSET 0
> +
> +static inline void __tcp_accecn_init_bytes_counters(int *counter_array)
> +{
> +       BUILD_BUG_ON(INET_ECN_ECT_1 !=3D 0x1);
> +       BUILD_BUG_ON(INET_ECN_ECT_0 !=3D 0x2);
> +       BUILD_BUG_ON(INET_ECN_CE !=3D 0x3);
> +
> +       counter_array[INET_ECN_ECT_1 - 1] =3D 0;
> +       counter_array[INET_ECN_ECT_0 - 1] =3D 0;
> +       counter_array[INET_ECN_CE - 1] =3D 0;
> +}
>
>  /* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
>   * attemped to be negotiated and requested for incoming connection
> @@ -1053,6 +1070,7 @@ static inline void tcp_accecn_init_counters(struct =
tcp_sock *tp)
>  {
>         tp->received_ce =3D 0;
>         tp->received_ce_pending =3D 0;
> +       __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
>  }
>
>  /* State flags for sacked in struct tcp_skb_cb */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index e6d7b5420c88..0e779de3ce01 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -5122,6 +5122,7 @@ static void __init tcp_struct_check(void)
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, delivered);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, delivered_ce);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, received_ce);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, received_ecn_bytes);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, app_limited);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, rcv_wnd);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_txr=
x, rx_opt);
> @@ -5129,7 +5130,7 @@ static void __init tcp_struct_check(void)
>         /* 32bit arches with 8byte alignment on u64 fields might need pad=
ding
>          * before tcp_clock_cache.
>          */
> -       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx,=
 95 + 4);
> +       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx,=
 107 + 4);
>
>         /* RX read-write hotpath cache lines */
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 bytes_received);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index c986452302cb..5c0159cc0083 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -6013,8 +6013,17 @@ static void tcp_urg(struct sock *sk, struct sk_buf=
f *skb, const struct tcphdr *t
>         }
>  }
>
> +void tcp_ecn_received_counters_payload(struct sock *sk,
> +                                      const struct sk_buff *skb)
> +{
> +       const struct tcphdr *th =3D (const struct tcphdr *)skb->data;
> +
> +       tcp_ecn_received_counters(sk, skb, skb->len - th->doff * 4);
> +}
> +
>  /* Updates Accurate ECN received counters from the received IP ECN field=
 */
> -void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *sk=
b)
> +void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *sk=
b,
> +                              u32 payload_len)
>  {
>         u8 ecnfield =3D TCP_SKB_CB(skb)->ip_dsfield & INET_ECN_MASK;
>         u8 is_ce =3D INET_ECN_is_ce(ecnfield);
> @@ -6034,6 +6043,9 @@ void tcp_ecn_received_counters(struct sock *sk, con=
st struct sk_buff *skb)
>                 tp->received_ce +=3D pcount;
>                 tp->received_ce_pending =3D min(tp->received_ce_pending +=
 pcount,
>                                               0xfU);
> +
> +               if (payload_len > 0)
> +                       tp->received_ecn_bytes[ecnfield - 1] +=3D payload=
_len;
>         }
>  }
>
> @@ -6307,7 +6319,7 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>                                         flag |=3D __tcp_replace_ts_recent=
(tp,
>                                                                         d=
elta);
>
> -                               tcp_ecn_received_counters(sk, skb);
> +                               tcp_ecn_received_counters(sk, skb, 0);
>
>                                 /* We know that such packets are checksum=
med
>                                  * on entry.
> @@ -6353,7 +6365,8 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>                         /* Bulk data transfer: receiver */
>                         tcp_cleanup_skb(skb);
>                         __skb_pull(skb, tcp_header_len);
> -                       tcp_ecn_received_counters(sk, skb);
> +                       tcp_ecn_received_counters(sk, skb,
> +                                                 len - tcp_header_len);
>                         eaten =3D tcp_queue_rcv(sk, skb, &fragstolen);
>
>                         tcp_event_data_recv(sk, skb);
> @@ -6400,7 +6413,7 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>                         tcp_accecn_third_ack(sk, skb, tp->syn_ect_snt);
>                 tcp_fast_path_on(tp);
>         }
> -       tcp_ecn_received_counters(sk, skb);
> +       tcp_ecn_received_counters_payload(sk, skb);

I missed this from a prior patch, but is it expected to account bytes
even if the packet is dropped ?

>
>         reason =3D tcp_ack(sk, skb, FLAG_SLOWPATH | FLAG_UPDATE_TS_RECENT=
);
>         if ((int)reason < 0) {
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index 779a206a5ca6..f1e698c323f3 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -500,7 +500,7 @@ static void tcp_ecn_openreq_child(struct sock *sk,
>                 tcp_ecn_mode_set(tp, TCP_ECN_MODE_ACCECN);
>                 tp->syn_ect_snt =3D treq->syn_ect_snt;
>                 tcp_accecn_third_ack(sk, skb, treq->syn_ect_snt);
> -               tcp_ecn_received_counters(sk, skb);
> +               tcp_ecn_received_counters_payload(sk, skb);
>         } else {
>                 tcp_ecn_mode_set(tp, inet_rsk(req)->ecn_ok ?
>                                      TCP_ECN_MODE_RFC3168 :
> --
> 2.34.1
>

