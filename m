Return-Path: <linux-kselftest+bounces-35730-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5405AE793F
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 09:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6A134A0C9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Jun 2025 07:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8502209F38;
	Wed, 25 Jun 2025 07:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ujNnfFsB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65310207A26
	for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750838281; cv=none; b=ttYXtVHh6hx1TSxm32k05rO58orcoQZKYMF2Hvdy9iIbx4/1SKInVqSsXI7gYZkv7piFR6JMirEo0ATNdudpZtyvCHyKA28FwJdLfZlupwPh0kUSpBX+DwQ/2sWFMjLo6Sfw4nL7wZ9/5cXQbylSBvaup3MfIOFgG/wGSqMD/BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750838281; c=relaxed/simple;
	bh=/mtwWfsWiStrRt9xzFNufdbjs4sUAxH4mtS0ijFv/9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2WRc9ChMkpwucop1m5Jm+S+AwA3mef6ProUiX3G0VqTtRknDkGMZAGqSCT3aIuRiIZ54ixYwfGbkchraktxdgeuuo5QhRMlitnb6A+7uMTSYteUkkROE9+Q4ZjEWdmrf37JN9jzB537i51sRD6uAo4K3Pwtn9u+jjVlIHJz3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujNnfFsB; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a43afb04a7so45084831cf.0
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Jun 2025 00:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750838277; x=1751443077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pqnipp14Bd62N/nYS3BesVJTfKC3tAwdpA7j5blhz7U=;
        b=ujNnfFsBhFzeEIIJvTBKfQYg9FYJspB9Rsmqdu268VrcpZaBm8T9zASNWiyuMshf7f
         t+Xg3zLOBFdJ4mex26M1tTMK2RcVXZdGeLjeNH+yesItP7Fg/frFY9mD2ngOeEFrL7Ju
         fyZetp7hV8iz73qxCc96w+I5Dr0kdtdDKe1X6BEeyr5UuZ81tc/DOyIhaAbPni+Ps4e6
         kqJgd0WracOd5Y55BRuE8PqL67CbcRV6QjC9KVqeiHhTIDeSZKWjKi44rljUKzq15TdB
         Cr7yyVcJO2c3VvYRTh7GncXpwat0DA1Imu58fXcC37+P3sbfnBJeN026zIffdzGmLQfD
         MRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750838277; x=1751443077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pqnipp14Bd62N/nYS3BesVJTfKC3tAwdpA7j5blhz7U=;
        b=VJnY/YpgM08oLRjQkE6GkJ6UXgJhu13pSuZsv+pABJStGNYU4yvfpQb2l/FR4ZWPwN
         NzZWLeTyFhxSa9Va5KpfAgMW7SqgdrvtRnFjYvxdHrs3ckEYf7qstWcQlXuQh+/5RiC1
         b29dCzx9l0eUG3HDGFByAZSv5qOFEwnFQRXwlvYxgegvsq+qdtbU3SOuCCiUgYsEbiZM
         adCtTvkKjqkYCMCB+1DO024NWkumG2RYXsiG+AkYZSc7kMOTHhkUGLqybt7JN+kHH+it
         gYlKsl5ZBoY/BtWirnDRzic8kxKd8GQNofrJ6uBOcnwE3yR7TBtakEwLIMmnD1Mm2Wcr
         2zrg==
X-Forwarded-Encrypted: i=1; AJvYcCUgHBemQRdaQ40CFGu9vkJU+5XK3L2A5fUbUVNEBx4dIpiH+DI94txTqMBjf+6qBP+KErT9ipQ09qqiQUhFPME=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAvcJ/oCiQykX1/02c/mzu64ghz2U6+qt99GfPDk6OhZtNVRgv
	4Nb7eCSlw2lBdXzALeB0myvewZ8lxF8KxM2LSU2bOIrDysFQ88IGUcKhudkVdzvSte4HHyNMIcv
	rP3NYCI+wo/hL1QOHNXzvUBC7NE4jPw/rEr8oLPks
X-Gm-Gg: ASbGnctY0HW13RXlXXQmZwKjEACS33bFE3nIn5F1IQRpfN+/3lyYLDlIG3s0xzomCvv
	fQJr8LZUQD1C4YwlsDZomF/HVgVPpdXoTXiUrSMXa/06D/4WJMnWhEw3l+9wenzWJyool2uQcWL
	q9FhC3RhfVteZK2rKTo38/oUfV5BOg+/u/KdZHFO+23Q==
X-Google-Smtp-Source: AGHT+IHmt36K6t91zSOfSfHY9NhWEzM7Rgt9ta0rw5KX2OezjAz30ArIJ4ZE8pWg4uNbejGWcfNHEjaFqMmPxCb7ng8=
X-Received: by 2002:ac8:5f4d:0:b0:4a7:62da:d0fc with SMTP id
 d75a77b69052e-4a7c0664497mr29969351cf.12.1750838276864; Wed, 25 Jun 2025
 00:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250621193737.16593-1-chia-yu.chang@nokia-bell-labs.com> <20250621193737.16593-6-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250621193737.16593-6-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Jun 2025 00:57:45 -0700
X-Gm-Features: AX0GCFtf7GCks5J-HlhhQGr4ZwW298o8fPjdDZse_TKWqlzTgWMoiTCCMVMD99M
Message-ID: <CANn89iKX+DxvcM6t8KjanRofdz8ksMkcHj_V0w_LAoredq2gZw@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 05/15] tcp: accecn: AccECN negotiation
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, linux-doc@vger.kernel.org, corbet@lwn.net, 
	horms@kernel.org, dsahern@kernel.org, kuniyu@amazon.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, jhs@mojatatu.com, kuba@kernel.org, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, ncardwell@google.com, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com, Olivier Tilmans <olivier.tilmans@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 21, 2025 at 12:37=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Ilpo J=C3=A4rvinen <ij@kernel.org>
>
> Accurate ECN negotiation parts based on the specification:
>   https://tools.ietf.org/id/draft-ietf-tcpm-accurate-ecn-28.txt
>
> Accurate ECN is negotiated using ECE, CWR and AE flags in the
> TCP header. TCP falls back into using RFC3168 ECN if one of the
> ends supports only RFC3168-style ECN.
>
> The AccECN negotiation includes reflecting IP ECN field value
> seen in SYN and SYNACK back using the same bits as negotiation
> to allow responding to SYN CE marks and to detect ECN field
> mangling. CE marks should not occur currently because SYN=3D1
> segments are sent with Non-ECT in IP ECN field (but proposal
> exists to remove this restriction).
>
> Reflecting SYN IP ECN field in SYNACK is relatively simple.
> Reflecting SYNACK IP ECN field in the final/third ACK of
> the handshake is more challenging. Linux TCP code is not well
> prepared for using the final/third ACK a signalling channel
> which makes things somewhat complicated here.
>
> tcp_ecn sysctl can be used to select the highest ECN variant
> (Accurate ECN, ECN, No ECN) that is attemped to be negotiated and
> requested for incoming connection and outgoing connection:
> TCP_ECN_IN_NOECN_OUT_NOECN, TCP_ECN_IN_ECN_OUT_ECN,
> TCP_ECN_IN_ECN_OUT_NOECN, TCP_ECN_IN_ACCECN_OUT_ACCECN,
> TCP_ECN_IN_ACCECN_OUT_ECN, and TCP_ECN_IN_ACCECN_OUT_NOECN.
>
> After this patch, the size of tcp_request_sock remains unchanged
> and no new holes are added. Below are the pahole outcomes before
> and after this patch:
>
>
> }
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Signed-off-by: Olivier Tilmans <olivier.tilmans@nokia.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> ---
>  .../networking/net_cachelines/tcp_sock.rst    |   4 +
>  include/linux/tcp.h                           |   9 +-
>  include/net/tcp.h                             |  93 ++++++++-
>  net/ipv4/syncookies.c                         |   3 +
>  net/ipv4/sysctl_net_ipv4.c                    |   3 +-
>  net/ipv4/tcp.c                                |   2 +
>  net/ipv4/tcp_input.c                          | 178 ++++++++++++++++--
>  net/ipv4/tcp_ipv4.c                           |   5 +-
>  net/ipv4/tcp_minisocks.c                      |  51 ++++-
>  net/ipv4/tcp_output.c                         |  78 ++++++--
>  net/ipv6/syncookies.c                         |   1 +
>  net/ipv6/tcp_ipv6.c                           |   1 +
>  12 files changed, 384 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Docum=
entation/networking/net_cachelines/tcp_sock.rst
> index 31313a9adccc..22ac668fe6c7 100644
> --- a/Documentation/networking/net_cachelines/tcp_sock.rst
> +++ b/Documentation/networking/net_cachelines/tcp_sock.rst
> @@ -103,6 +103,10 @@ u32                           delivered             =
  read_mostly         read_w
>  u32                           delivered_ce            read_mostly       =
  read_write          tcp_rate_skb_sent(tx);tcp_rate_gen(rx)
>  u32                           received_ce             read_mostly       =
  read_write
>  u8:4                          received_ce_pending     read_mostly       =
  read_write
> +u8:2                          syn_ect_snt             write_mostly      =
  read_write
> +u8:2                          syn_ect_rcv             read_mostly       =
  read_write
> +u8:1                          wait_third_ack                            =
  read_write
> +u8:4                          accecn_fail_mode
>  u32                           lost                                      =
  read_mostly         tcp_ack
>  u32                           app_limited             read_write        =
  read_mostly         tcp_rate_check_app_limited,tcp_rate_skb_sent(tx);tcp_=
rate_gen(rx)
>  u64                           first_tx_mstamp         read_write        =
                      tcp_rate_skb_sent
> diff --git a/include/linux/tcp.h b/include/linux/tcp.h
> index 874e0e45dfad..1d8301f2883c 100644
> --- a/include/linux/tcp.h
> +++ b/include/linux/tcp.h
> @@ -168,6 +168,10 @@ struct tcp_request_sock {
>                                                   * after data-in-SYN.
>                                                   */
>         u8                              syn_tos;
> +       bool                            accecn_ok;
> +       u8                              syn_ect_snt: 2,
> +                                       syn_ect_rcv: 2,
> +                                       accecn_fail_mode:4;
>  #ifdef CONFIG_TCP_AO
>         u8                              ao_keyid;
>         u8                              ao_rcv_next;
> @@ -375,7 +379,9 @@ struct tcp_sock {
>         u8      compressed_ack;
>         u8      dup_ack_counter:2,
>                 tlp_retrans:1,  /* TLP is a retransmission */
> -               unused:5;
> +               syn_ect_snt:2,  /* AccECN ECT memory, only */
> +               syn_ect_rcv:2,  /* ... needed durign 3WHS + first seqno *=
/
> +               wait_third_ack:1; /* Wait 3rd ACK in simultaneous open */
>         u8      thin_lto    : 1,/* Use linear timeouts for thin streams *=
/
>                 fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
>                 fastopen_no_cookie:1, /* Allow send/recv SYN+data without=
 a cookie */
> @@ -391,6 +397,7 @@ struct tcp_sock {
>                 syn_fastopen_child:1; /* created TFO passive child socket=
 */
>
>         u8      keepalive_probes; /* num of allowed keep alive probes   *=
/
> +       u8      accecn_fail_mode:4;     /* AccECN failure handling */
>         u32     tcp_tx_delay;   /* delay (in usec) added to TX packets */
>
>  /* RTT measurement */
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index 6cf5cea992e3..4d6325fa3f67 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -27,6 +27,7 @@
>  #include <linux/ktime.h>
>  #include <linux/indirect_call_wrapper.h>
>  #include <linux/bits.h>
> +#include <linux/bitfield.h>
>
>  #include <net/inet_connection_sock.h>
>  #include <net/inet_timewait_sock.h>
> @@ -234,6 +235,37 @@ static_assert((1 << ATO_BITS) > TCP_DELACK_MAX);
>  #define TCPOLEN_MSS_ALIGNED            4
>  #define TCPOLEN_EXP_SMC_BASE_ALIGNED   8
>
> +/* tp->accecn_fail_mode */
> +#define TCP_ACCECN_ACE_FAIL_SEND       BIT(0)
> +#define TCP_ACCECN_ACE_FAIL_RECV       BIT(1)
> +#define TCP_ACCECN_OPT_FAIL_SEND       BIT(2)
> +#define TCP_ACCECN_OPT_FAIL_RECV       BIT(3)
> +
> +static inline bool tcp_accecn_ace_fail_send(const struct tcp_sock *tp)
> +{
> +       return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_SEND;
> +}
> +
> +static inline bool tcp_accecn_ace_fail_recv(const struct tcp_sock *tp)
> +{
> +       return tp->accecn_fail_mode & TCP_ACCECN_ACE_FAIL_RECV;
> +}
> +
> +static inline bool tcp_accecn_opt_fail_send(const struct tcp_sock *tp)
> +{
> +       return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_SEND;
> +}
> +
> +static inline bool tcp_accecn_opt_fail_recv(const struct tcp_sock *tp)
> +{
> +       return tp->accecn_fail_mode & TCP_ACCECN_OPT_FAIL_RECV;
> +}
> +
> +static inline void tcp_accecn_fail_mode_set(struct tcp_sock *tp, u8 mode=
)
> +{
> +       tp->accecn_fail_mode |=3D mode;
> +}
> +
>  /* Flags in tp->nonagle */
>  #define TCP_NAGLE_OFF          1       /* Nagle's algo is disabled */
>  #define TCP_NAGLE_CORK         2       /* Socket is corked         */
> @@ -420,6 +452,23 @@ static inline u8 tcp_accecn_ace(const struct tcphdr =
*th)
>         return (th->ae << 2) | (th->cwr << 1) | th->ece;
>  }
>
> +/* Infer the ECT value our SYN arrived with from the echoed ACE field */
> +static inline int tcp_accecn_extract_syn_ect(u8 ace)
> +{
> +       if (ace & 0x1)
> +               return INET_ECN_ECT_1;
> +       if (!(ace & 0x2))
> +               return INET_ECN_ECT_0;
> +       if (ace & 0x4)
> +               return INET_ECN_CE;
> +       return INET_ECN_NOT_ECT;
> +}
> +
> +bool tcp_accecn_validate_syn_feedback(struct sock *sk, u8 ace, u8 sent_e=
ct);
> +void tcp_accecn_third_ack(struct sock *sk, const struct sk_buff *skb,
> +                         u8 syn_ect_snt);
> +void tcp_ecn_received_counters(struct sock *sk, const struct sk_buff *sk=
b);
> +
>  enum tcp_tw_status {
>         TCP_TW_SUCCESS =3D 0,
>         TCP_TW_RST =3D 1,
> @@ -657,6 +706,15 @@ static inline bool cookie_ecn_ok(const struct net *n=
et, const struct dst_entry *
>                 dst_feature(dst, RTAX_FEATURE_ECN);
>  }
>
> +/* AccECN specification, 5.1: [...] a server can determine that it
> + * negotiated AccECN as [...] if the ACK contains an ACE field with
> + * the value 0b010 to 0b111 (decimal 2 to 7).
> + */
> +static inline bool cookie_accecn_ok(const struct tcphdr *th)
> +{
> +       return tcp_accecn_ace(th) > 0x1;
> +}
> +
>  #if IS_ENABLED(CONFIG_BPF)
>  static inline bool cookie_bpf_ok(struct sk_buff *skb)
>  {
> @@ -968,6 +1026,7 @@ static inline u32 tcp_rsk_tsval(const struct tcp_req=
uest_sock *treq)
>
>  #define TCPHDR_ACE (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)
>  #define TCPHDR_SYN_ECN (TCPHDR_SYN | TCPHDR_ECE | TCPHDR_CWR)
> +#define TCPHDR_SYNACK_ACCECN (TCPHDR_SYN | TCPHDR_ACK | TCPHDR_CWR)
>
>  #define TCP_ACCECN_CEP_ACE_MASK 0x7
>  #define TCP_ACCECN_ACE_MAX_DELTA 6
> @@ -977,6 +1036,19 @@ static inline u32 tcp_rsk_tsval(const struct tcp_re=
quest_sock *treq)
>   */
>  #define TCP_ACCECN_CEP_INIT_OFFSET 5
>
> +/* The highest ECN variant (Accurate ECN, ECN, or no ECN) that is
> + * attemped to be negotiated and requested for incoming connection
> + * and outgoing connection, respectively.
> + */
> +enum tcp_ecn_mode {
> +       TCP_ECN_IN_NOECN_OUT_NOECN =3D 0,
> +       TCP_ECN_IN_ECN_OUT_ECN =3D 1,
> +       TCP_ECN_IN_ECN_OUT_NOECN =3D 2,
> +       TCP_ECN_IN_ACCECN_OUT_ACCECN =3D 3,
> +       TCP_ECN_IN_ACCECN_OUT_ECN =3D 4,
> +       TCP_ECN_IN_ACCECN_OUT_NOECN =3D 5,
> +};
> +
>  static inline void tcp_accecn_init_counters(struct tcp_sock *tp)
>  {
>         tp->received_ce =3D 0;
> @@ -1051,6 +1123,15 @@ struct tcp_skb_cb {
>
>  #define TCP_SKB_CB(__skb)      ((struct tcp_skb_cb *)&((__skb)->cb[0]))
>
> +static inline u16 tcp_accecn_reflector_flags(u8 ect)
> +{
> +       u32 flags =3D ect + 2;
> +
> +       if (ect =3D=3D 3)
> +               flags++;

A comment might help, I have no idea of what is going on here.

> +       return FIELD_PREP(TCPHDR_ACE, flags);
> +}
> +
>  extern const struct inet_connection_sock_af_ops ipv4_specific;
>
>  #if IS_ENABLED(CONFIG_IPV6)
> @@ -1173,7 +1254,10 @@ enum tcp_ca_ack_event_flags {
>  #define TCP_CONG_NON_RESTRICTED                BIT(0)
>  /* Requires ECN/ECT set on all packets */
>  #define TCP_CONG_NEEDS_ECN             BIT(1)
> -#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN)
> +/* Require successfully negotiated AccECN capability */
> +#define TCP_CONG_NEEDS_ACCECN          BIT(2)
> +#define TCP_CONG_MASK  (TCP_CONG_NON_RESTRICTED | TCP_CONG_NEEDS_ECN | \
> +                       TCP_CONG_NEEDS_ACCECN)
>
>  union tcp_cc_info;
>
> @@ -1305,6 +1389,13 @@ static inline bool tcp_ca_needs_ecn(const struct s=
ock *sk)
>         return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ECN;
>  }
>
> +static inline bool tcp_ca_needs_accecn(const struct sock *sk)
> +{
> +       const struct inet_connection_sock *icsk =3D inet_csk(sk);
> +
> +       return icsk->icsk_ca_ops->flags & TCP_CONG_NEEDS_ACCECN;
> +}
> +
>  static inline void tcp_ca_event(struct sock *sk, const enum tcp_ca_event=
 event)
>  {
>         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
> index 5459a78b9809..3a44eb9c1d1a 100644
> --- a/net/ipv4/syncookies.c
> +++ b/net/ipv4/syncookies.c
> @@ -403,6 +403,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>         struct tcp_sock *tp =3D tcp_sk(sk);
>         struct inet_request_sock *ireq;
>         struct net *net =3D sock_net(sk);
> +       struct tcp_request_sock *treq;
>         struct request_sock *req;
>         struct sock *ret =3D sk;
>         struct flowi4 fl4;
> @@ -428,6 +429,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>         }
>
>         ireq =3D inet_rsk(req);
> +       treq =3D tcp_rsk(req);
>
>         sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
>         sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
> @@ -482,6 +484,7 @@ struct sock *cookie_v4_check(struct sock *sk, struct =
sk_buff *skb)
>         if (!req->syncookie)
>                 ireq->rcv_wscale =3D rcv_wscale;
>         ireq->ecn_ok &=3D cookie_ecn_ok(net, &rt->dst);
> +       treq->accecn_ok =3D ireq->ecn_ok && cookie_accecn_ok(th);
>
>         ret =3D tcp_get_cookie_sock(sk, skb, req, &rt->dst);
>         /* ip_queue_xmit() depends on our flow being setup
> diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
> index 3a43010d726f..75ec1a599b52 100644
> --- a/net/ipv4/sysctl_net_ipv4.c
> +++ b/net/ipv4/sysctl_net_ipv4.c
> @@ -47,6 +47,7 @@ static unsigned int udp_child_hash_entries_max =3D UDP_=
HTABLE_SIZE_MAX;
>  static int tcp_plb_max_rounds =3D 31;
>  static int tcp_plb_max_cong_thresh =3D 256;
>  static unsigned int tcp_tw_reuse_delay_max =3D TCP_PAWS_MSL * MSEC_PER_S=
EC;
> +static int tcp_ecn_mode_max =3D 5;
>
>  /* obsolete */
>  static int sysctl_tcp_low_latency __read_mostly;
> @@ -728,7 +729,7 @@ static struct ctl_table ipv4_net_table[] =3D {
>                 .mode           =3D 0644,
>                 .proc_handler   =3D proc_dou8vec_minmax,
>                 .extra1         =3D SYSCTL_ZERO,
> -               .extra2         =3D SYSCTL_TWO,
> +               .extra2         =3D &tcp_ecn_mode_max,

Please change Documentation/networking/ip-sysctl.rst tcp_ecn accordingly ?

>         },
>         {
>                 .procname       =3D "tcp_ecn_fallback",
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 8e0e8d784b1c..e6d7b5420c88 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -3392,6 +3392,8 @@ int tcp_disconnect(struct sock *sk, int flags)
>         tp->window_clamp =3D 0;
>         tp->delivered =3D 0;
>         tp->delivered_ce =3D 0;
> +       tp->wait_third_ack =3D 0;
> +       tp->accecn_fail_mode =3D 0;
>         tcp_accecn_init_counters(tp);
>         if (icsk->icsk_ca_initialized && icsk->icsk_ca_ops->release)
>                 icsk->icsk_ca_ops->release(sk);
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0fa3803b353d..c986452302cb 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -411,14 +411,114 @@ static void tcp_data_ecn_check(struct sock *sk, co=
nst struct sk_buff *skb)
>         }
>  }

I do think this patch is too big and should be split.

