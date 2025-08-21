Return-Path: <linux-kselftest+bounces-39479-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACFC7B2F7FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 14:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8EAA16FBDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 12:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406CF31076E;
	Thu, 21 Aug 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XiaaPxYJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2221DB34C
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779394; cv=none; b=KXYxge248UOoLDfBhHwU4zmOGJji83h4QOtqLv0zG/z5JySiYmW/nrQu6WyjxK+tZZXwOF1hKTxszicvufkGgH0s3K/3WK4XtH2Nou6m6mcP/cxdLiquBohGRzF/y7eqANi5WqDBxC0YwnpNbo0O928Od+Oa+TDhKFUQoX4aleA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779394; c=relaxed/simple;
	bh=zkDbxvo7pdEoYH6PpNr9aonByAeBiVU4hVH0AT2E4j0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNuetHtGFOEldZjW2SscX3OpCKNEc1o+70ff7V7R5okeI9lvLfU1eYb6Oy8+0dbNfvfeQTJqa3iS2mbTF1h1zkLFEDoTYoARQ6SLwXQH9OTVdOFaIXCwCnp6JipJVpqsquDy8eaeacw9NEozuEY4L9E4mWQTkfAmqFDRPjoMvnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XiaaPxYJ; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b121dc259cso7047991cf.1
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 05:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755779390; x=1756384190; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yMyf7TUTcVlmFShDFbUR03mYlUdBmR7tL66qjPszynQ=;
        b=XiaaPxYJ9KsUdsZ31BNVF9RoGzGI+oG8SXeJNgH8C2WS3D6F+qxqkjlbF+kKCZcNqn
         k1yU+lXbKFQCK2j2HOP2gO5xGGgqcYLXEYunyppSA8bz/JmgOssllQSWyN5CZkaqyC50
         oZDAHAmVALsWyUp5MeIFxBngn/fABw7QHTG8fGNnJMG9/TF9SGzmnQH535aDkA8ksAng
         UzGRVYIMbMCLAsgeUBDk8qDzUjx+ulDMmJ6gYbZRTE2GxKy4h+OoxTa57QHA3RF+VYwx
         CZncZayiMWgSg0hzlvGNgGq9NN8GjeBoSFzedGDZHF7t8e3MECY1NUHZ4FnMWUv+vLRc
         lbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755779390; x=1756384190;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yMyf7TUTcVlmFShDFbUR03mYlUdBmR7tL66qjPszynQ=;
        b=b7Rzd15dAPUCRkNlmwS7OvMXVwROcGyQpndB5WjTAaJ6FRpYcrb3ImF5sfNBAYDs7h
         9lG41/gmuqxUnPS+ECRXLcsJbRYhrDEOlYjNOplzYkR1O6aa1kQRz2O07nBpCJSsG3YE
         KY5LfXpCGIiDjF/IoOeqQ5xXPM587Z6Mw249oFl97VHbjuq1nbvSp4k4RYwASXYTX3ca
         /8DPJIPwq9azXyzkgjuuatX/egmdzr+wbV2fwd/QEWmWvr+eMdZI8ynludObDtwGbWlf
         ACtJOpdH/NY/rMxUp5/O6hczNsXNdXIwUIUAov+OcJzZJJWe24GBCl7kPjzo+NfJVWjC
         ke0w==
X-Forwarded-Encrypted: i=1; AJvYcCVzxv+blk+O5kysFkpQ637h5ptWogYc8h7aF7LeVbXW5FJ9mSG8GJrS+8+2RbLKcUris7JHPIApKaA+81HchVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc82r0qZ08u/8EYLWzk3vNGk1O5i70P9nEaRSEkEJwjKF4BTfI
	z7rgiYNAmgeJRL/RstwJflfyGWnKDq/Mx9aYXDp7sK2CKU6SZrNeaoup9psgSPC+1taLEO36Wv4
	ZS1jIc31hvcFL5gd0jJs9/v72w0UJ517J6sqjnDqh
X-Gm-Gg: ASbGncvjg3Ox89I/eVEb3uuIczoDVKlXorDPKzVn8lV0XsahmJ7WDfvVeUkXViLGdXa
	ZviIOPksq+XZxU5pbpona+MtRnb8pMZC1BYpFSwMcDtH3RfHY9WYsUXVlT92+wU6OhfIPaFM1QE
	8WNwGs/GnNElERuc5U2kYOtvJbFPaJOp4m04ekQ4AxDF1XIPupzT4RDuw6DSvFjofc3yvz0IfQ7
	o1iXFee2BexFC9thM2FEsp52w==
X-Google-Smtp-Source: AGHT+IGiDTu4Nx/S2i7PXKBQcL0zSflTE4ZdcC1UihTgHSCzCGsNJVk9lvVSiXeTSusqav8nRJ0XJpzvxKMBN8t/Gxk=
X-Received: by 2002:a05:622a:242:b0:4b2:9c3d:bc4c with SMTP id
 d75a77b69052e-4b29fa6dac9mr26388591cf.33.1755779389674; Thu, 21 Aug 2025
 05:29:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815083930.10547-1-chia-yu.chang@nokia-bell-labs.com> <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20250815083930.10547-11-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 21 Aug 2025 05:29:38 -0700
X-Gm-Features: Ac12FXwtX6Y71JLad1BL80WdVtDYKWVSK_UzOY3Wd_laWGj2k0iPGrLqT8yKhgM
Message-ID: <CANn89iKPTWBdi8upoxjFok2CPFhkGB9S3crZcefZ0mRhFHGPhQ@mail.gmail.com>
Subject: Re: [PATCH v15 net-next 10/14] tcp: accecn: AccECN option
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

On Fri, Aug 15, 2025 at 1:40=E2=80=AFAM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
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
> [BEFORE THIS PATCH]
> struct tcp_info {
>     [...]
>      __u32                     tcpi_total_rto_time;  /*   244     4 */
>
>     /* size: 248, cachelines: 4, members: 61 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_info {
>     [...]
>     __u32                      tcpi_total_rto_time;  /*   244     4 */
>     __u32                      tcpi_received_ce;     /*   248     4 */
>     __u32                      tcpi_delivered_e1_bytes; /*   252     4 */
>     __u32                      tcpi_delivered_e0_bytes; /*   256     4 */
>     __u32                      tcpi_delivered_ce_bytes; /*   260     4 */
>     __u32                      tcpi_received_e1_bytes; /*   264     4 */
>     __u32                      tcpi_received_e0_bytes; /*   268     4 */
>     __u32                      tcpi_received_ce_bytes; /*   272     4 */
>
>     /* size: 280, cachelines: 5, members: 68 */
> }
>
> This patch uses the existing 1-byte holes in the tcp_sock_write_txrx
> group for new u8 members, but adds a 4-byte hole in tcp_sock_write_rx
> group after the new u32 delivered_ecn_bytes[3] member. Therefore, the
> group size of tcp_sock_write_rx is increased from 96 to 112. Below
> are the pahole outcomes before and after this patch:
>
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4; /*  2522: 0  1 */
>     u8                         unused2:4;             /*  2522: 4  1 */
>     /* XXX 1 byte hole, try to pack */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;    /*  2668     4 */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];      /*  2728     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 167 */
> }
>
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u8                         received_ce_pending:4;/*  2522: 0  1 */
>     u8                         unused2:4;            /*  2522: 4  1 */
>     u8                         accecn_minlen:2;      /*  2523: 0  1 */
>     u8                         est_ecnfield:2;       /*  2523: 2  1 */
>     u8                         unused3:4;            /*  2523: 4  1 */
>
>     [...]
>     u32                        rcv_rtt_last_tsecr;   /*  2668     4 */
>     u32                        delivered_ecn_bytes[3];/*  2672    12 */
>     /* XXX 4 bytes hole, try to pack */
>
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];     /*  2744     0 */
>
>     [...]
>     /* size: 3200, cachelines: 50, members: 171 */
> }
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> ---
> v13
> - Move TCP_ACCECN_E1B_INIT_OFFSET, TCP_ACCECN_E0B_INIT_OFFSET, and
>   TCP_ACCECN_CEB_INIT_OFFSET to this patch
> - Use static array lookup in tcp_accecn_optfield_to_ecnfield()
> - Return false when WARN_ON_ONCE() is true in tcp_accecn_process_option()
> - Make synack_ecn_bytes as static const array and use const u32 pointer
>   in tcp_options_write()
> - Use ALIGN() and ALIGN_DOWN() in tcp_options_fit_accecn() to pad TCP Acc=
ECN
>   option to dword
>
> v10
> - Add documentation of tcp_ecn_option in ip-sysctl.rst to this patch
> - Remove the global variable u32 synack_ecn_bytes[3]
> - Add READ_ONCE() over every reads of sysctl
>
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
>  Documentation/networking/ip-sysctl.rst        |  19 ++
>  .../networking/net_cachelines/tcp_sock.rst    |   3 +
>  include/linux/tcp.h                           |   9 +-
>  include/net/netns/ipv4.h                      |   1 +
>  include/net/tcp.h                             |  13 ++
>  include/net/tcp_ecn.h                         |  89 +++++++++-
>  include/uapi/linux/tcp.h                      |   7 +
>  net/ipv4/sysctl_net_ipv4.c                    |   9 +
>  net/ipv4/tcp.c                                |  15 +-
>  net/ipv4/tcp_input.c                          |  94 +++++++++-
>  net/ipv4/tcp_ipv4.c                           |   1 +
>  net/ipv4/tcp_output.c                         | 165 +++++++++++++++++-
>  12 files changed, 412 insertions(+), 13 deletions(-)
>


             minlen);
> +               }
>         }
>  }
>
> @@ -263,6 +347,9 @@ static inline void tcp_accecn_init_counters(struct tc=
p_sock *tp)
>         tp->received_ce =3D 0;
>         tp->received_ce_pending =3D 0;
>         __tcp_accecn_init_bytes_counters(tp->received_ecn_bytes);
> +       __tcp_accecn_init_bytes_counters(tp->delivered_ecn_bytes);
> +       tp->accecn_minlen =3D 0;
> +       tp->est_ecnfield =3D 0;
>  }
>
>  /* Used for make_synack to form the ACE flags */
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
>  };
>

We do not add more fields to tcp_info, unless added fields are a
multiple of 64 bits.

Otherwise a hole is added and can not be recovered.

