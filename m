Return-Path: <linux-kselftest+bounces-35734-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5FAE7CD6
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 11:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C55A3AAE99
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 09:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F3229E0E0;
	Wed, 25 Jun 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M/jNDulB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FF729E0F9
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750843285; cv=none; b=R9xQFORTaB/LX73pMZA08h24bFWNNLLrk/7dHwfVGW3vRXIyXK8lx46YIGBJxYNaCNadHPKKOPFnh7wvUrtVm7Mh67jvzcMQxMoB3ENRZjIgOfjwRrGuhmybszZhCRuIt1/KiZYd8KnDAjKKAFaiGKEJkmY2EVX9HgUMX0NV0yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750843285; c=relaxed/simple;
	bh=YE02Z+QfGBWMM9UIUrGyhShwIO62lbLm+nQ7oNBwqgo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4nWkSfENQIhyuv7nIWy2LFmq5EW4DKb4G49cbAsJ53e7YVjbISQAom62R1mTj0Vyd3wWRPD9ZO52udqcPXCi9/4GbCO8Lxm4CsLgBsE5buLjgz/6CQ6v5XTTD+eZs60xnqTR4Gn3hT7KpjsO14/YH9gG8M06Z4a0zmVyzwGLrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M/jNDulB; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4a589b7dd5fso23445971cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750843282; x=1751448082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g/GrnNjGC0WaHnuMgC7eeWgwqPuwpgzRSnZMMOt1oyE=;
        b=M/jNDulBan+eWaR849NSieB2Ypyfip1trXlvtw9hrP7b6uNOplnT3MhzU0wb01hT1t
         waV9jatpYfWAYuXjLb9zSdZBH3ESqmBLmN4FC3RisgNXMNiANLYdm6g5bkb9tIWGjGXH
         yDEaFRJX3q4/i+vgRVpKaWqXfW/GRH2lvmmcp9vLL4Ki/i9LQTCKcCRKIC6U9zBW55ov
         xukRPX/du1VSrRCgDQuZymfY1cSw6LxUPPaR66Aqb30w5WL19QDDiBB5uwSaVGKuHq+q
         6ltv7MoSjQZCRxzQrGGV0oDQiS4HbeC2FfUN2HMOb83SVniyDUtR8YBUsO6pnPxE42u2
         jLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750843282; x=1751448082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/GrnNjGC0WaHnuMgC7eeWgwqPuwpgzRSnZMMOt1oyE=;
        b=wUTPFtww2jYb+5V6wWAuqywhGfFeQ17/mzBVoTx7VkYSfg32xwzUDNtiamYiUf/RbS
         FFiJz5g2jOSk5npQBWBzfS08AGC6FDygRqFHFwfoibBUBPU+KTP12UpgnLk3U75fzFA+
         16rW0FHktSBbyV9xJJt380lwdKU1QJI/nwu6+bl+AhaJCYgXVFljuHsaBlOjXsoUuzUu
         Ilj9KtuXVkWItwgIizSpczSuvILBglFaRNUYP34g853Qk6xx+rOrs9rf6rfGILd+tvYu
         IbcJIJsYZWAWxJtGQDo5Hx5OYLDBLmzDNvXDnQiOHSOJim1MmosuKAqsv6iK3a7853F3
         p00g==
X-Forwarded-Encrypted: i=1; AJvYcCVlEWVZ2MAUPzQk6iYix23Erao0VnBicresgr5j/ti8/L07bEh234gIv0gAFf49QHxMvb6EeOYi+c5b56/oBQo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/qp2B5MfGry2eJCHyHJiDWAWxHWBSZBn4dt+7042CghxFuU4b
	aX+Yg+W8LzBAN0GiqaVpNk3v8A3uiGD1WZ8uSHwCGVRMA+UlVNpzUxVOLCHvMKKxwcmIorjFKFt
	aIXcD7DpmyzNyWULFa4bZDqTtI8cEM/aTrb/uVGrM
X-Gm-Gg: ASbGncuUuKdq7h+bbrWWdESrSPBtIYkNfqX3Sl1r6tu0anj2+TSy4BilAyrmybJkYeM
	jwhx6mg3Gl2cVfkz/rA2j95QRCB2W2fS5yGIOr8DCHAqhiHa/2r6zas2aGlkevXOtv59VKBVZdx
	b8PSmsimzt3OZeyhMvMolaXbsCfGQKeUrOTVquIpPuXOEI/qAx2g0d
X-Google-Smtp-Source: AGHT+IHrAX7UPOenq7/pUkTHQS45lDfkp8gikpxanxD6KZ3vtNBuQViBrWHQ30jD+i9AHlmNszBXDdrgKt7DKUw//O8=
X-Received: by 2002:ac8:5891:0:b0:494:84a3:77c8 with SMTP id
 d75a77b69052e-4a7c08aa80emr47050941cf.50.1750843281422; Wed, 25 Jun 2025
 02:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-10-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-10-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 02:21:08 -0700
X-Gm-Features: AX0GCFtudPl5akw3PnnIYLhIN1Ntb5hx6LE5pib777QS7kEB50w87cbbGNXGOHU
Message-ID: <CANn89i+6o9sZMgEgP9ZxARVAw9f2KFVqTYPcM_8ZXRHw+-=esA@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 09/15] tcp: accecn: AccECN option
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

On Sat, Jun 21, 2025 at 12:38=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> The Accurate ECN allows echoing back the sum of bytes for
> each IP ECN field value in the received packets using
> AccECN option. This change implements AccECN option tx & rx
> side processing without option send control related features
> that are added by a later change.
>
> Based on specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
> (Some features of the spec will be added in the later changes
> rather than in this one).
>
> A full-length AccECN option is always attempted but if it does
> not fit, the minimum length is selected based on the counters
> that have changed since the last update. The AccECN option
> (with 24-bit fields) often ends in odd sizes so the option
> write code tries to take advantage of some nop used to pad
> the other TCP options.
>
> The delivered_ecn_bytes pairs with received_ecn_bytes similar
> to how delivered_ce pairs with received_ce. In contrast to
> ACE field, however, the option is not always available to update
> delivered_ecn_bytes. For ACK w/o AccECN option, the delivered
> bytes calculated based on the cumulative ACK+SACK information
> are assigned to one of the counters using an estimation
> heuristic to select the most likely ECN byte counter. Any
> estimation error is corrected when the next AccECN option
> arrives. It may occur that the heuristic gets too confused
> when there are enough different byte counter deltas between
> ACKs with the AccECN option in which case the heuristic just
> gives up on updating the counters for a while.
>
> tcp_ecn_option sysctl can be used to select option sending
> mode for AccECN: TCP_ECN_OPTION_DISABLED, TCP_ECN_OPTION_MINIMUM,
> and TCP_ECN_OPTION_FULL.
>
> This patch increases the size of tcp_info struct, as there is
> no existing holes for new u32 variables. Below are the pahole
> outcomes before and after this patch:
>
> [
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v9:
> - Restruct the code in the for loop of tcp_accecn_process_option()
> - Remove ecn_bytes and add use_synack_ecn_bytes flag in tcp_out_options
>   struct to identify whether syn_ack_bytes or received_ecn_bytes is used
> - Replace leftover_bytes and leftover_size with leftover_highbyte and
>   leftover_lowbyte and add comments in tcp_options_write()
>
> v8:
> - Reset leftover_size to 2 once leftover_bytes is used
> ---
>  .../networking/net_cachelines/tcp_sock.rst    |   3 +
>  include/linux/tcp.h                           |   9 +-
>  include/net/netns/ipv4.h                      |   1 +
>  include/net/tcp.h                             |  20 +++
>  include/uapi/linux/tcp.h                      |   7 +
>  net/ipv4/sysctl_net_ipv4.c                    |   9 +
>  net/ipv4/tcp.c                                |  15 +-
>  net/ipv4/tcp_input.c                          | 166 ++++++++++++++++-
>  net/ipv4/tcp_ipv4.c                           |   1 +
>  net/ipv4/tcp_output.c                         | 170 +++++++++++++++++-
>  10 files changed, 388 insertions(+), 13 deletions(-)
>
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Docum=
entation/networking/net_cachelines/tcp_sock.rst
> index 804480d39132..ed6af7d0110c 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -104,9 +104,12 @@ u32                           delivered_ce          =
  read_mostly         read_w
>  u32                           received_ce             read_mostly       =
  read_write
>  u32[3]                        received_ecn_bytes      read_mostly       =
  read_write
>  u8:4                          received_ce_pending     read_mostly       =
  read_write
> +u32[3]                        delivered_ecn_bytes                       =
  read_write
>  u8:2                          syn_ect_snt             write_mostly      =
  read_write
>  u8:2                          syn_ect_rcv             read_mostly       =
  read_write
>  u8:1                          wait_third_ack                            =
  read_write
> +u8:2                          accecn_minlen           write_mostly      =
  read_write
> +u8:2                          est_ecnfield                              =
  read_write
>  u8:4                          accecn_fail_mode
>  u32                           lost                                      =
  read_mostly         tcp_ack
>  u32                           app_limited             read_write        =
  read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_=
rate_gen(rx)
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 0c2331e186e8..0008b8190ea0 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -122,8 +122,9 @@ struct tcp_options_received {
>                 smc_ok : 1,     /* SMC seen on SYN packet               *=
/
>                 snd_wscale : 4, /* Window scaling received from sender  *=
/
>                 rcv_wscale : 4; /* Window scaling to send to receiver   *=
/
> -       u8      saw_unknown:1,  /* Received unknown option              *=
/
> -               unused:7;
> +       u8      accecn:6,       /* AccECN index in header, 0=3Dno options=
 */
> +               saw_unknown:1,  /* Received unknown option              *=
/
> +               unused:1;
>         u8      num_sacks;      /* Number of SACK blocks                *=
/
>         u16     user_mss;       /* mss requested by user in ioctl       *=
/
>         u16     mss_clamp;      /* Maximal mss, negotiated at connection =
setup */
> @@ -293,6 +294,9 @@ struct tcp_sock {
>                 rate_app_limited:1;  /* rate_{delivered,interval_us} limi=
ted? */
>         u8      received_ce_pending:4, /* Not yet transmit cnt of receive=
d_ce */
>                 unused2:4;
> +       u8      accecn_minlen:2,/* Minimum length of AccECN option sent *=
/
> +               est_ecnfield:2,/* ECN field for AccECN delivered estimate=
s */
> +               unused3:4;
>         __be32  pred_flags;
>         u64     tcp_clock_cache; /* cache last tcp_clock_ns() (see tcp_ms=
tamp_refresh()) */
>         u64     tcp_mstamp;     /* most recent packet received/sent */
> @@ -337,6 +341,7 @@ struct tcp_sock {
>         u32     rate_delivered;    /* saved rate sample: packets delivere=
d */
>         u32     rate_interval_us;  /* saved rate sample: time elapsed */
>         u32     rcv_rtt_last_tsecr;
> +       u32     delivered_ecn_bytes[3];
>         u64     first_tx_mstamp;  /* start of window send phase */
>         u64     delivered_mstamp; /* time we reached "delivered" */
>         u64     bytes_acked;    /* RFC4898 tcpEStatsAppHCThruOctetsAcked
> diff --git a/include/net/netns/ipv4.h b/include/net/netns/ipv4.h
> index 6373e3f17da8..4569a9ef4fb8 100644
> --- a/include/net/netns/ipv4.h
> +++ b/include/net/netns/ipv4.h
> @@ -148,6 +148,7 @@ struct netns_ipv4 {
>         struct local_ports ip_local_ports;
>
>         u8 sysctl_tcp_ecn;
> +       u8 sysctl_tcp_ecn_option;
>         u8 sysctl_tcp_ecn_fallback;
>
>         u8 sysctl_ip_default_ttl;
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index b861941a2213..f7ba314eb7f9 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -204,6 +204,8 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define TCPOPT_AO              29      /* Authentication Option (RFC5925=
) */
>  #define TCPOPT_MPTCP           30      /* Multipath TCP (RFC6824) */
>  #define TCPOPT_FASTOPEN                34      /* Fast open (RFC7413) */
> +#define TCPOPT_ACCECN0         172     /* 0xAC: Accurate ECN Order 0 */
> +#define TCPOPT_ACCECN1         174     /* 0xAE: Accurate ECN Order 1 */
>  #define TCPOPT_EXP             254     /* Experimental */
>  /* Magic number to be after the option value for sharing TCP
>   * experimental options. See draft-ietf-tcpm-experimental-options-00.txt
> @@ -221,6 +223,7 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define TCPOLEN_TIMESTAMP      10
>  #define TCPOLEN_MD5SIG         18
>  #define TCPOLEN_FASTOPEN_BASE  2
> +#define TCPOLEN_ACCECN_BASE    2
>  #define TCPOLEN_EXP_FASTOPEN_BASE  4
>  #define TCPOLEN_EXP_SMC_BASE   6
>
> @@ -234,6 +237,13 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define TCPOLEN_MD5SIG_ALIGNED         20
>  #define TCPOLEN_MSS_ALIGNED            4
>  #define TCPOLEN_EXP_SMC_BASE_ALIGNED   8
> +#define TCPOLEN_ACCECN_PERFIELD                3
> +
> +/* Maximum number of byte counters in AccECN option + size */
> +#define TCP_ACCECN_NUMFIELDS           3
> +#define TCP_ACCECN_MAXSIZE             (TCPOLEN_ACCECN_BASE + \
> +                                        TCPOLEN_ACCECN_PERFIELD * \
> +                                        TCP_ACCECN_NUMFIELDS)
>
>  /* tp->accecn_fail_mode */
>  #define TCP_ACCECN_ACE_FAIL_SEND       BIT(0)
> @@ -1066,11 +1076,21 @@ enum tcp_ecn_mode {
>         TCP_ECN_IN_ACCECN_OUT_NOECN =3D 5,
>  };
>
> +/* AccECN option sending when AccECN has been successfully negotiated */
> +enum tcp_ecn_option {
> +       TCP_ECN_OPTION_DISABLED =3D 0,
> +       TCP_ECN_OPTION_MINIMUM =3D 1,
> +       TCP_ECN_OPTION_FULL =3D 2,
> +};
> +
>  static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
>  {
>         tp->received_ce =3D 0;
>         tp->received_ce_pending =3D 0;
>         __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
> +       __tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +       tp->accecn_minlen =3D 0;
> +       tp->est_ecnfield =3D 0;
>  }
>
>  /* State flags for sacked in struct tcp_skb_cb */
> diff --git a/include/uapi/linux/tcp.h b/include/uapi/linux/tcp.h
> index bdac8c42fa82..53e0e85b52be 100644
> --- a/include/uapi/linux/tcp.h
> +++ b/include/uapi/linux/tcp.h
> @@ -316,6 +316,13 @@ struct tcp_info {
>                                          * in milliseconds, including any
>                                          * unfinished recovery.
>                                          */
> +       __u32   tcpi_received_ce;    /* # of CE marks received */
> +       __u32   tcpi_delivered_e1_bytes;  /* Accurate ECN byte counters *=
/
> +       __u32   tcpi_delivered_e0_bytes;
> +       __u32   tcpi_delivered_ce_bytes;
> +       __u32   tcpi_received_e1_bytes;
> +       __u32   tcpi_received_e0_bytes;
> +       __u32   tcpi_received_ce_bytes;

We need to immediately fill the 32bit hole, otherwise we won't be able
to use it in the future.

>  };
>
>  /* netlink attributes types for SCM_TIMESTAMPING_OPT_STATS */
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 75ec1a599b52..1d7fd86ca7b9 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -731,6 +731,15 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .extra1         =3D SYSCTL_ZERO,
>                 .extra2         =3D &tcp_ecn_mode_max,
>         },
> +       {
> +               .procname       =3D "tcp_ecn_option",
> +               .data           =3D &init_net.ipv4.sysctl_tcp_ecn_option,
> +               .maxlen         =3D sizeof(u8),
> +               .mode           =3D 0644,
> +               .proc_handler   =3D proc_dou8vec_minmax,
> +               .extra1         =3D SYSCTL_ZERO,
> +               .extra2         =3D SYSCTL_TWO,

Please add documentation in Documentation/networking/ip-sysctl.rst

> +       },
>         {
>                 .procname       =3D "tcp_ecn_fallback",
>                 .data           =3D &init_net.ipv4.sysctl_tcp_ecn_fallbac=
k,
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 0e779de3ce01..1c1d4cbdda1c 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -270,6 +270,7 @@
>
>  #include <net/icmp.h>
>  #include <net/inet_common.h>
> +#include <net/inet_ecn.h>
>  #include <net/tcp.h>
>  #include <net/mptcp.h>
>  #include <net/proto_memory.h>
> @@ -4138,6 +4139,9 @@ void tcp_get_info(struct sock *sk, struct tcp_info =
*info)
>  {
>         const struct tcp_sock *tp =3D tcp_sk(sk); /* iff sk_type =3D=3D S=
OCK_STREAM */
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> +       const u8 ect1_idx =3D INET_ECN_ECT_1 - 1;
> +       const u8 ect0_idx =3D INET_ECN_ECT_0 - 1;
> +       const u8 ce_idx =3D INET_ECN_CE - 1;
>         unsigned long rate;
>         u32 now;
>         u64 rate64;
> @@ -4264,6 +4268,14 @@ void tcp_get_info(struct sock *sk, struct tcp_info=
 *info)
>         if (tp->rto_stamp)
>                 info->tcpi_total_rto_time +=3D tcp_clock_ms() - tp->rto_s=
tamp;
>
> +       info->tcpi_received_ce =3D tp->received_ce;
> +       info->tcpi_delivered_e1_bytes =3D tp->delivered_ecn_bytes[ect1_id=
x];
> +       info->tcpi_delivered_e0_bytes =3D tp->delivered_ecn_bytes[ect0_id=
x];
> +       info->tcpi_delivered_ce_bytes =3D tp->delivered_ecn_bytes[ce_idx]=
;
> +       info->tcpi_received_e1_bytes =3D tp->received_ecn_bytes[ect1_idx]=
;
> +       info->tcpi_received_e0_bytes =3D tp->received_ecn_bytes[ect0_idx]=
;
> +       info->tcpi_received_ce_bytes =3D tp->received_ecn_bytes[ce_idx];
> +
>         unlock_sock_fast(sk, slow);
>  }
>  EXPORT_SYMBOL_GPL(tcp_get_info);
> @@ -5142,12 +5154,13 @@ static void __init tcp_struct_check(void)
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 rate_delivered);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 rate_interval_us);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 rcv_rtt_last_tsecr);
> +       CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 delivered_ecn_bytes);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 first_tx_mstamp);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 delivered_mstamp);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 bytes_acked);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 rcv_rtt_est);
>         CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_write_rx,=
 rcvq_space);
> -       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 9=
6);
> +       CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_rx, 1=
12);
>  }
>
>  void __init tcp_init(void)
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index a327fc14b207..66390966cc41 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -70,6 +70,7 @@
>  #include <linux/sysctl.h>
>  #include <linux/kernel.h>
>  #include <linux/prefetch.h>
> +#include <linux/bitops.h>
>  #include <net/dst.h>
>  #include <net/tcp.h>
>  #include <net/proto_memory.h>
> @@ -530,6 +531,139 @@ static bool tcp_ecn_rcv_ecn_echo(const struct tcp_s=
ock *tp, const struct tcphdr
>         return false;
>  }
>
> +/* Maps IP ECN field ECT/CE code point to AccECN option field number, gi=
ven
> + * we are sending fields with Accurate ECN Order 1: ECT(1), CE, ECT(0).
> + */
> +static u8 tcp_ecnfield_to_accecn_optfield(u8 ecnfield)
> +{
> +       switch (ecnfield & INET_ECN_MASK) {
> +       case INET_ECN_NOT_ECT:
> +               return 0;       /* AccECN does not send counts of NOT_ECT=
 */
> +       case INET_ECN_ECT_1:
> +               return 1;
> +       case INET_ECN_CE:
> +               return 2;
> +       case INET_ECN_ECT_0:
> +               return 3;
> +       }
> +       return 0;
> +}


net/ipv4/tcp_input.c has already 7273 lines....

I would suggest adding all these tcp ecn helpers in a separate include file=
,
and move existing ones.


> +
> +/* Maps IP ECN field ECT/CE code point to AccECN option field value offs=
et.
> + * Some fields do not start from zero, to detect zeroing by middleboxes.
> + */
> +static u32 tcp_accecn_field_init_offset(u8 ecnfield)
> +{
> +       switch (ecnfield & INET_ECN_MASK) {
> +       case INET_ECN_NOT_ECT:
> +               return 0;       /* AccECN does not send counts of NOT_ECT=
 */
> +       case INET_ECN_ECT_1:
> +               return TCP_ACCECN_E1B_INIT_OFFSET;
> +       case INET_ECN_CE:
> +               return TCP_ACCECN_CEB_INIT_OFFSET;
> +       case INET_ECN_ECT_0:
> +               return TCP_ACCECN_E0B_INIT_OFFSET;
> +       }
> +       return 0;
> +}
> +
> +/* Maps AccECN option field #nr to IP ECN field ECT/CE bits */
> +static unsigned int tcp_accecn_optfield_to_ecnfield(unsigned int optfiel=
d,
> +                                                   bool order)
> +{
> +       u8 tmp;
> +
> +       optfield =3D order ? 2 - optfield : optfield;
> +       tmp =3D optfield + 2;
> +
> +       return (tmp + (tmp >> 2)) & INET_ECN_MASK;
> +}
> +
> +/* Handles AccECN option ECT and CE 24-bit byte counters update into
> + * the u32 value in tcp_sock. As we're processing TCP options, it is
> + * safe to access from - 1.
> + */
> +static s32 tcp_update_ecn_bytes(u32 *cnt, const char *from, u32 init_off=
set)
> +{
> +       u32 truncated =3D (get_unaligned_be32(from - 1) - init_offset) &
> +                       0xFFFFFFU;
> +       u32 delta =3D (truncated - *cnt) & 0xFFFFFFU;
> +
> +       /* If delta has the highest bit set (24th bit) indicating
> +        * negative, sign extend to correct an estimation using
> +        * sign_extend32(delta, 24 - 1)
> +        */
> +       delta =3D sign_extend32(delta, 23);
> +       *cnt +=3D delta;
> +       return (s32)delta;
> +}
> +
> +/* Returns true if the byte counters can be used */
> +static bool tcp_accecn_process_option(struct tcp_sock *tp,
> +                                     const struct sk_buff *skb,
> +                                     u32 delivered_bytes, int flag)
> +{
> +       u8 estimate_ecnfield =3D tp->est_ecnfield;
> +       bool ambiguous_ecn_bytes_incr =3D false;
> +       bool first_changed =3D false;
> +       unsigned int optlen;
> +       bool order1, res;
> +       unsigned int i;
> +       u8 *ptr;
> +
> +       if (!(flag & FLAG_SLOWPATH) || !tp->rx_opt.accecn) {
> +               if (estimate_ecnfield) {
> +                       u8 ecnfield =3D estimate_ecnfield - 1;
> +
> +                       tp->delivered_ecn_bytes[ecnfield] +=3D delivered_=
bytes;
> +                       return true;
> +               }
> +               return false;
> +       }
> +
> +       ptr =3D skb_transport_header(skb) + tp->rx_opt.accecn;
> +       optlen =3D ptr[1] - 2;
> +       WARN_ON_ONCE(ptr[0] !=3D TCPOPT_ACCECN0 && ptr[0] !=3D TCPOPT_ACC=
ECN1);
> +       order1 =3D (ptr[0] =3D=3D TCPOPT_ACCECN1);
> +       ptr +=3D 2;
> +
> +       res =3D !!estimate_ecnfield;
> +       for (i =3D 0; i < 3; i++) {
> +               u32 init_offset;
> +               u8 ecnfield;
> +               s32 delta;
> +               u32 *cnt;
> +
> +               if (optlen < TCPOLEN_ACCECN_PERFIELD)
> +                       break;
> +
> +               ecnfield =3D tcp_accecn_optfield_to_ecnfield(i, order1);
> +               init_offset =3D tcp_accecn_field_init_offset(ecnfield);
> +               cnt =3D &tp->delivered_ecn_bytes[ecnfield - 1];
> +               delta =3D tcp_update_ecn_bytes(cnt, ptr, init_offset);
> +               if (delta && delta < 0) {
> +                       res =3D false;
> +                       ambiguous_ecn_bytes_incr =3D true;
> +               }
> +               if (delta && ecnfield !=3D estimate_ecnfield) {
> +                       if (!first_changed) {
> +                               tp->est_ecnfield =3D ecnfield;
> +                               first_changed =3D true;
> +                       } else {
> +                               res =3D false;
> +                               ambiguous_ecn_bytes_incr =3D true;
> +                       }
> +               }
> +
> +               optlen -=3D TCPOLEN_ACCECN_PERFIELD;
> +               ptr +=3D TCPOLEN_ACCECN_PERFIELD;
> +       }
> +       if (ambiguous_ecn_bytes_incr)
> +               tp->est_ecnfield =3D 0;
> +
> +       return res;
> +}
> +
>  static void tcp_count_delivered_ce(struct tcp_sock *tp, u32 ecn_count)
>  {
>         tp->delivered_ce +=3D ecn_count;
> @@ -546,7 +680,8 @@ static void tcp_count_delivered(struct tcp_sock *tp, =
u32 delivered,
>
>  /* Returns the ECN CE delta */
>  static u32 __tcp_accecn_process(struct sock *sk, const struct sk_buff *s=
kb,
> -                               u32 delivered_pkts, int flag)
> +                               u32 delivered_pkts, u32 delivered_bytes,
> +                               int flag)
>  {
>         const struct tcphdr *th =3D tcp_hdr(skb);
>         struct tcp_sock *tp =3D tcp_sk(sk);
> @@ -557,6 +692,8 @@ static u32 __tcp_accecn_process(struct sock *sk, cons=
t struct sk_buff *skb,
>         if (!(flag & (FLAG_FORWARD_PROGRESS | FLAG_TS_PROGRESS)))
>                 return 0;
>
> +       tcp_accecn_process_option(tp, skb, delivered_bytes, flag);
> +
>         if (!(flag & FLAG_SLOWPATH)) {
>                 /* AccECN counter might overflow on large ACKs */
>                 if (delivered_pkts <=3D TCP_ACCECN_CEP_ACE_MASK)
> @@ -582,12 +719,14 @@ static u32 __tcp_accecn_process(struct sock *sk, co=
nst struct sk_buff *skb,
>  }
>
>  static u32 tcp_accecn_process(struct sock *sk, const struct sk_buff *skb=
,
> -                             u32 delivered_pkts, int *flag)
> +                             u32 delivered_pkts, u32 delivered_bytes,
> +                             int *flag)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         u32 delta;
>
> -       delta =3D __tcp_accecn_process(sk, skb, delivered_pkts, *flag);
> +       delta =3D __tcp_accecn_process(sk, skb, delivered_pkts,
> +                                    delivered_bytes, *flag);
>         if (delta > 0) {
>                 tcp_count_delivered_ce(tp, delta);
>                 *flag |=3D FLAG_ECE;
> @@ -4119,6 +4258,7 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>         if (tcp_ecn_mode_accecn(tp))
>                 ecn_count =3D tcp_accecn_process(sk, skb,
>                                                tp->delivered - delivered,
> +                                              sack_state.delivered_bytes=
,
>                                                &flag);
>
>         tcp_in_ack_event(sk, flag);
> @@ -4158,6 +4298,7 @@ static int tcp_ack(struct sock *sk, const struct sk=
_buff *skb, int flag)
>         if (tcp_ecn_mode_accecn(tp))
>                 ecn_count =3D tcp_accecn_process(sk, skb,
>                                                tp->delivered - delivered,
> +                                              sack_state.delivered_bytes=
,
>                                                &flag);
>         tcp_in_ack_event(sk, flag);
>         /* If data was DSACKed, see if we can undo a cwnd reduction. */
> @@ -4285,6 +4426,7 @@ void tcp_parse_options(const struct net *net,
>
>         ptr =3D (const unsigned char *)(th + 1);
>         opt_rx->saw_tstamp =3D 0;
> +       opt_rx->accecn =3D 0;
>         opt_rx->saw_unknown =3D 0;
>
>         while (length > 0) {
> @@ -4376,6 +4518,12 @@ void tcp_parse_options(const struct net *net,
>                                         ptr, th->syn, foc, false);
>                                 break;
>
> +                       case TCPOPT_ACCECN0:
> +                       case TCPOPT_ACCECN1:
> +                               /* Save offset of AccECN option in TCP he=
ader */
> +                               opt_rx->accecn =3D (ptr - 2) - (__u8 *)th=
;
> +                               break;
> +
>                         case TCPOPT_EXP:
>                                 /* Fast Open option shares code 254 using=
 a
>                                  * 16 bits magic number.
> @@ -4436,11 +4584,14 @@ static bool tcp_fast_parse_options(const struct n=
et *net,
>          */
>         if (th->doff =3D=3D (sizeof(*th) / 4)) {
>                 tp->rx_opt.saw_tstamp =3D 0;
> +               tp->rx_opt.accecn =3D 0;
>                 return false;
>         } else if (tp->rx_opt.tstamp_ok &&
>                    th->doff =3D=3D ((sizeof(*th) + TCPOLEN_TSTAMP_ALIGNED=
) / 4)) {
> -               if (tcp_parse_aligned_timestamp(tp, th))
> +               if (tcp_parse_aligned_timestamp(tp, th)) {
> +                       tp->rx_opt.accecn =3D 0;
>                         return true;
> +               }
>         }
>
>         tcp_parse_options(net, skb, &tp->rx_opt, 1, NULL);
> @@ -6054,8 +6205,12 @@ void tcp_ecn_received_counters(struct sock *sk, co=
nst struct sk_buff *skb,
>                 tp->received_ce_pending =3D min(tp->received_ce_pending +=
 pcount,
>                                               0xfU);
>
> -               if (payload_len > 0)
> +               if (payload_len > 0) {
> +                       u8 minlen =3D tcp_ecnfield_to_accecn_optfield(ecn=
field);
>                         tp->received_ecn_bytes[ecnfield - 1] +=3D payload=
_len;
> +                       tp->accecn_minlen =3D max_t(u8, tp->accecn_minlen=
,
> +                                                 minlen);
> +               }
>         }
>  }
>
> @@ -6275,6 +6430,7 @@ void tcp_rcv_established(struct sock *sk, struct sk=
_buff *skb)
>          */
>
>         tp->rx_opt.saw_tstamp =3D 0;
> +       tp->rx_opt.accecn =3D 0;
>
>         /*      pred_flags is 0xS?10 << 16 + snd_wnd
>          *      if header_prediction is to be made
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index c5b93802d7c0..387cf8994202 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -3450,6 +3450,7 @@ static void __net_init tcp_set_hashinfo(struct net =
*net)
>  static int __net_init tcp_sk_init(struct net *net)
>  {
>         net->ipv4.sysctl_tcp_ecn =3D TCP_ECN_IN_ECN_OUT_NOECN;
> +       net->ipv4.sysctl_tcp_ecn_option =3D TCP_ECN_OPTION_FULL;
>         net->ipv4.sysctl_tcp_ecn_fallback =3D 1;
>
>         net->ipv4.sysctl_tcp_base_mss =3D TCP_BASE_MSS;
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 37c981aa9bc6..ca36f5d775f7 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -492,6 +492,7 @@ static inline bool tcp_urg_mode(const struct tcp_sock=
 *tp)
>  #define OPTION_SMC             BIT(9)
>  #define OPTION_MPTCP           BIT(10)
>  #define OPTION_AO              BIT(11)
> +#define OPTION_ACCECN          BIT(12)
>
>  static void smc_options_write(__be32 *ptr, u16 *options)
>  {
> @@ -513,6 +514,8 @@ struct tcp_out_options {
>         u16 mss;                /* 0 to disable */
>         u8 ws;                  /* window scale, 0 to disable */
>         u8 num_sack_blocks;     /* number of SACK blocks to include */
> +       u8 num_accecn_fields:7, /* number of AccECN fields needed */
> +          use_synack_ecn_bytes:1; /* Use synack_ecn_bytes or not */
>         u8 hash_size;           /* bytes in hash_location */
>         u8 bpf_opt_len;         /* length of BPF hdr option */
>         __u8 *hash_location;    /* temporary pointer, overloaded */
> @@ -521,6 +524,11 @@ struct tcp_out_options {
>         struct mptcp_out_options mptcp;
>  };
>
> +/* Initial values for AccECN option, ordered is based on ECN field bits
> + * similar to received_ecn_bytes. Used for SYN/ACK AccECN option.
> + */
> +static u32 synack_ecn_bytes[3] =3D { 0, 0, 0 };

Are you trying to use a global variable, shared by all cpus in the host ?

Please do not do that, we had CONFIG_SMP=3Dy for a while.

> +
>  static void mptcp_options_write(struct tcphdr *th, __be32 *ptr,
>                                 struct tcp_sock *tp,
>                                 struct tcp_out_options *opts)
> @@ -728,6 +736,8 @@ static void tcp_options_write(struct tcphdr *th, stru=
ct tcp_sock *tp,
>                               struct tcp_out_options *opts,
>                               struct tcp_key *key)
>  {
> +       u8 leftover_highbyte =3D TCPOPT_NOP; /* replace 1st NOP if avail =
*/
> +       u8 leftover_lowbyte =3D TCPOPT_NOP;  /* replace 2nd NOP in succes=
sion */
>         __be32 *ptr =3D (__be32 *)(th + 1);
>         u16 options =3D opts->options;    /* mungable copy */
>
> @@ -763,15 +773,75 @@ static void tcp_options_write(struct tcphdr *th, st=
ruct tcp_sock *tp,
>                 *ptr++ =3D htonl(opts->tsecr);
>         }
>
> +       if (OPTION_ACCECN & options) {
> +               const u8 ect0_idx =3D INET_ECN_ECT_0 - 1;
> +               const u8 ect1_idx =3D INET_ECN_ECT_1 - 1;
> +               const u8 ce_idx =3D INET_ECN_CE - 1;
> +               u32 e0b;
> +               u32 e1b;
> +               u32 ceb;
> +               u8 len;
> +
> +               if (opts->use_synack_ecn_bytes) {
> +                       e0b =3D synack_ecn_bytes[ect0_idx] + TCP_ACCECN_E=
0B_INIT_OFFSET;
> +                       e1b =3D synack_ecn_bytes[ect1_idx] + TCP_ACCECN_E=
1B_INIT_OFFSET;
> +                       ceb =3D synack_ecn_bytes[ce_idx] + TCP_ACCECN_CEB=
_INIT_OFFSET;
> +               } else {
> +                       e0b =3D tp->received_ecn_bytes[ect0_idx] + TCP_AC=
CECN_E0B_INIT_OFFSET;
> +                       e1b =3D tp->received_ecn_bytes[ect1_idx] + TCP_AC=
CECN_E1B_INIT_OFFSET;
> +                       ceb =3D tp->received_ecn_bytes[ce_idx] + TCP_ACCE=
CN_CEB_INIT_OFFSET;
> +               }
> +
> +               len =3D TCPOLEN_ACCECN_BASE +
> +                     opts->num_accecn_fields * TCPOLEN_ACCECN_PERFIELD;
> +
> +               if (opts->num_accecn_fields =3D=3D 2) {
> +                       *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> +                                      ((e1b >> 8) & 0xffff));
> +                       *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> +                                      (ceb & 0xffffff));
> +               } else if (opts->num_accecn_fields =3D=3D 1) {
> +                       *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> +                                      ((e1b >> 8) & 0xffff));
> +                       leftover_highbyte =3D e1b & 0xff;
> +                       leftover_lowbyte =3D TCPOPT_NOP;
> +               } else if (opts->num_accecn_fields =3D=3D 0) {
> +                       leftover_highbyte =3D TCPOPT_ACCECN1;
> +                       leftover_lowbyte =3D len;
> +               } else if (opts->num_accecn_fields =3D=3D 3) {
> +                       *ptr++ =3D htonl((TCPOPT_ACCECN1 << 24) | (len <<=
 16) |
> +                                      ((e1b >> 8) & 0xffff));
> +                       *ptr++ =3D htonl(((e1b & 0xff) << 24) |
> +                                      (ceb & 0xffffff));
> +                       *ptr++ =3D htonl(((e0b & 0xffffff) << 8) |
> +                                      TCPOPT_NOP);
> +               }
> +               if (tp)
> +                       tp->accecn_minlen =3D 0;
> +       }
> +
>         if (unlikely(OPTION_SACK_ADVERTISE & options)) {
> -               *ptr++ =3D htonl((TCPOPT_NOP << 24) |
> -                              (TCPOPT_NOP << 16) |
> +               *ptr++ =3D htonl((leftover_highbyte << 24) |
> +                              (leftover_lowbyte << 16) |
>                                (TCPOPT_SACK_PERM << 8) |
>                                TCPOLEN_SACK_PERM);
> +               leftover_highbyte =3D TCPOPT_NOP;
> +               leftover_lowbyte =3D TCPOPT_NOP;
>         }
>
>         if (unlikely(OPTION_WSCALE & options)) {
> -               *ptr++ =3D htonl((TCPOPT_NOP << 24) |
> +               u8 highbyte =3D TCPOPT_NOP;
> +
> +               /* Do not split the leftover 2-byte to fit into a single
> +                * NOP, i.e., replace this NOP only when 1 byte is leftov=
er
> +                * within leftover_highbyte.
> +                */
> +               if (unlikely(leftover_highbyte !=3D TCPOPT_NOP &&
> +                            leftover_lowbyte =3D=3D TCPOPT_NOP)) {
> +                       highbyte =3D leftover_highbyte;
> +                       leftover_highbyte =3D TCPOPT_NOP;
> +               }
> +               *ptr++ =3D htonl((highbyte << 24) |
>                                (TCPOPT_WINDOW << 16) |
>                                (TCPOLEN_WINDOW << 8) |
>                                opts->ws);
> @@ -782,11 +852,13 @@ static void tcp_options_write(struct tcphdr *th, st=
ruct tcp_sock *tp,
>                         tp->duplicate_sack : tp->selective_acks;
>                 int this_sack;
>
> -               *ptr++ =3D htonl((TCPOPT_NOP  << 24) |
> -                              (TCPOPT_NOP  << 16) |
> +               *ptr++ =3D htonl((leftover_highbyte << 24) |
> +                              (leftover_lowbyte << 16) |
>                                (TCPOPT_SACK <<  8) |
>                                (TCPOLEN_SACK_BASE + (opts->num_sack_block=
s *
>                                                      TCPOLEN_SACK_PERBLOC=
K)));
> +               leftover_highbyte =3D TCPOPT_NOP;
> +               leftover_lowbyte =3D TCPOPT_NOP;
>
>                 for (this_sack =3D 0; this_sack < opts->num_sack_blocks;
>                      ++this_sack) {
> @@ -795,6 +867,14 @@ static void tcp_options_write(struct tcphdr *th, str=
uct tcp_sock *tp,
>                 }
>
>                 tp->rx_opt.dsack =3D 0;
> +       } else if (unlikely(leftover_highbyte !=3D TCPOPT_NOP ||
> +                           leftover_lowbyte !=3D TCPOPT_NOP)) {
> +               *ptr++ =3D htonl((leftover_highbyte << 24) |
> +                              (leftover_lowbyte << 16) |
> +                              (TCPOPT_NOP << 8) |
> +                              TCPOPT_NOP);
> +               leftover_highbyte =3D TCPOPT_NOP;
> +               leftover_lowbyte =3D TCPOPT_NOP;
>         }
>
>         if (unlikely(OPTION_FAST_OPEN_COOKIE & options)) {
> @@ -875,6 +955,55 @@ static void mptcp_set_option_cond(const struct reque=
st_sock *req,
>         }
>  }
>
> +static u32 tcp_synack_options_combine_saving(struct tcp_out_options *opt=
s)
> +{
> +       /* How much there's room for combining with the alignment padding=
? */
> +       if ((opts->options & (OPTION_SACK_ADVERTISE | OPTION_TS)) =3D=3D
> +           OPTION_SACK_ADVERTISE)
> +               return 2;
> +       else if (opts->options & OPTION_WSCALE)
> +               return 1;
> +       return 0;
> +}
> +
> +/* Calculates how long AccECN option will fit to @remaining option space=
.
> + *
> + * AccECN option can sometimes replace NOPs used for alignment of other
> + * TCP options (up to @max_combine_saving available).
> + *
> + * Only solutions with at least @required AccECN fields are accepted.
> + *
> + * Returns: The size of the AccECN option excluding space repurposed fro=
m
> + * the alignment of the other options.
> + */
> +static int tcp_options_fit_accecn(struct tcp_out_options *opts, int requ=
ired,
> +                                 int remaining, int max_combine_saving)
> +{
> +       int size =3D TCP_ACCECN_MAXSIZE;
> +
> +       opts->num_accecn_fields =3D TCP_ACCECN_NUMFIELDS;
> +
> +       while (opts->num_accecn_fields >=3D required) {
> +               int leftover_size =3D size & 0x3;
> +               /* Pad to dword if cannot combine */
> +               if (leftover_size > max_combine_saving)
> +                       leftover_size =3D -((4 - leftover_size) & 0x3);
> +
> +               if (remaining >=3D size - leftover_size) {
> +                       size -=3D leftover_size;
> +                       break;
> +               }
> +
> +               opts->num_accecn_fields--;
> +               size -=3D TCPOLEN_ACCECN_PERFIELD;
> +       }
> +       if (opts->num_accecn_fields < required)
> +               return 0;
> +
> +       opts->options |=3D OPTION_ACCECN;
> +       return size;
> +}
> +
>  /* Compute TCP options for SYN packets. This is not the final
>   * network wire format yet.
>   */
> @@ -957,6 +1086,17 @@ static unsigned int tcp_syn_options(struct sock *sk=
, struct sk_buff *skb,
>                 }
>         }
>
> +       /* Simultaneous open SYN/ACK needs AccECN option but not SYN */
> +       if (unlikely((TCP_SKB_CB(skb)->tcp_flags & TCPHDR_ACK) &&
> +                    tcp_ecn_mode_accecn(tp) &&
> +                    sock_net(sk)->ipv4.sysctl_tcp_ecn_option &&

Please add READ_ONCE() over every reads of sysctl (for all your patches)

> +                    remaining >=3D TCPOLEN_ACCECN_BASE)) {
> +               u32 saving =3D tcp_synack_options_combine_saving(opts);
> +
> +               opts->use_synack_ecn_bytes =3D 1;
> +               remaining -=3D tcp_options_fit_accecn(opts, 0, remaining,=
 saving);
> +       }
> +
>         bpf_skops_hdr_opt_len(sk, skb, NULL, NULL, 0, opts, &remaining);
>
>         return MAX_TCP_OPTION_SPACE - remaining;
> @@ -974,6 +1114,7 @@ static unsigned int tcp_synack_options(const struct =
sock *sk,
>  {
>         struct inet_request_sock *ireq =3D inet_rsk(req);
>         unsigned int remaining =3D MAX_TCP_OPTION_SPACE;
> +       struct tcp_request_sock *treq =3D tcp_rsk(req);
>
>         if (tcp_key_is_md5(key)) {
>                 opts->options |=3D OPTION_MD5;
> @@ -1036,6 +1177,14 @@ static unsigned int tcp_synack_options(const struc=
t sock *sk,
>
>         smc_set_option_cond(tcp_sk(sk), ireq, opts, &remaining);
>
> +       if (treq->accecn_ok && sock_net(sk)->ipv4.sysctl_tcp_ecn_option &=
&
> +           remaining >=3D TCPOLEN_ACCECN_BASE) {
> +               u32 saving =3D tcp_synack_options_combine_saving(opts);
> +
> +               opts->use_synack_ecn_bytes =3D 1;
> +               remaining -=3D tcp_options_fit_accecn(opts, 0, remaining,=
 saving);
> +       }
> +
>         bpf_skops_hdr_opt_len((struct sock *)sk, skb, req, syn_skb,
>                               synack_type, opts, &remaining);
>
> @@ -1108,6 +1257,17 @@ static unsigned int tcp_established_options(struct=
 sock *sk, struct sk_buff *skb
>                 opts->num_sack_blocks =3D 0;
>         }
>
> +       if (tcp_ecn_mode_accecn(tp) &&
> +           sock_net(sk)->ipv4.sysctl_tcp_ecn_option) {
> +               int saving =3D opts->num_sack_blocks > 0 ? 2 : 0;
> +               int remaining =3D MAX_TCP_OPTION_SPACE - size;
> +
> +               opts->use_synack_ecn_bytes =3D 0;
> +               size +=3D tcp_options_fit_accecn(opts, tp->accecn_minlen,
> +                                              remaining,
> +                                              saving);
> +       }
> +
>         if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
>                                             BPF_SOCK_OPS_WRITE_HDR_OPT_CB=
_FLAG))) {
>                 unsigned int remaining =3D MAX_TCP_OPTION_SPACE - size;
> --
> 2.34.1
>

