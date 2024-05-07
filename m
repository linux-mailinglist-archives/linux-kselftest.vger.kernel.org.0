Return-Path: <linux-kselftest+bounces-9640-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F598BEB38
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 20:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CD731F241F1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 May 2024 18:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8CB16D4CA;
	Tue,  7 May 2024 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CBNJnyNw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF35216D339
	for <linux-kselftest@vger.kernel.org>; Tue,  7 May 2024 18:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715105300; cv=none; b=dwr0aVOpOQKUICWw4AjcxdABJ3+ZLprYl00bNwI+ILtjdmDNCNwTxKReMOCnpS1dq3NjcIju6e8uyf9ZMkJDYaEM28M99wZpTfLZkyvL3lj/Yn+ga+8HUiU/4n7U+0MImJEXOm4X53r97l+PHTQhtbnzdoVvVopPMTiWhxAEj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715105300; c=relaxed/simple;
	bh=1p+UvRkwILv7j+uU2Wfe+g+eScb0cDzf5sxz0CAgfdg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D/sPanPNLH7g4Rp1Bv64Q2UROczuh0oM1C+XTR7VY0qGQGH5U+TpulYt/xCiwN/gKztrZeVOL0OZ96Si0ex3PtCv3TmuYhd77fNSJGWId7cTCHMTRtRA9rgE5HJoHtfMMiz0CWZAJjYfx0MICGn4cdkPhFs8c0IUdKiGVbDpffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CBNJnyNw; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso2754a12.0
        for <linux-kselftest@vger.kernel.org>; Tue, 07 May 2024 11:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715105296; x=1715710096; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9y4Lt3e39ao1KvAxZTkx82JWTupI8h7IYYpm7rSkMok=;
        b=CBNJnyNwMH11EMpu2xokBxn3OhsiUP7Z9h8QDgGJG72JGVWy6PWfKesBM+9XbZmm+A
         dcSQoJia/lWyPvCTQYIVlZxruWRkxb2t1bstWubTPfV5xiwUk+GlpxMqqZPm9iZlG8Xz
         h8MZfoGDjBJF424v8gj5MTT1qb/zYEcMu+mLKUFyfVqoRRkkQHbL42TVqsiNdU5dG1IK
         Otju2bqFuPtFYRojcTz2KgUPthOZ2r/AR/iqyEBAtBaqxA3Tdod3JNbvxKH8F/SxG0Y8
         57KXSCf91HDluHsLEcKIl+82vCF/eJDuf5cFaPDMUdgBbXtMPWXaDfuaLeRtQfKf5N6s
         d54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715105296; x=1715710096;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9y4Lt3e39ao1KvAxZTkx82JWTupI8h7IYYpm7rSkMok=;
        b=PRcfTBiaWoDNTprKdho3pMLSnkJ+Xo5ZoyVeHiJl8kbUNnsedZAsltTSFkjOB8OKOT
         6C/WGQcLwNn/5X2yzxMT1fTqXZh5cKRI9JmQXDW9Qq5/Q2ggidDxRLgMs+QBigjm2rRM
         WPf+VdeXtnSZQZwBrlSUzeobvej3BFBTBP8oe5VyiSD1CRAm2znJGdaiXVFTUcvzHYww
         oJJ+Me/jH4UrUYFWROq0N0yHut/wdGV+rqtTGAn0rxksBpuvdSNPIqikupHOEQNTstKf
         1p0UrxMkFPCIOGmo53y63EKtIXv46ChehgfdwVP6rNIAZ1D+RQEWkoUsfNExS99yjCjG
         /A5g==
X-Forwarded-Encrypted: i=1; AJvYcCWGty48sIniFaY3VPdocvBn4KSf6na4XLgtwNdxZtHmtF+mnpEMoiHYrY4QSAj0wcmAMyZ61tgqR9EyZq8sFs2H8XR8YQazMga7pvLRJgyM
X-Gm-Message-State: AOJu0Yw4i/3ycSdR5T0qmqYCQnSGn7NhblIvErjcWQILIydgvx6sMxf4
	7bOyAHOT2kO0h90Ft3hcryTamZgSZSom0mMsJbZqzM0RqThysEfAtHli20Dl90rDm1MIDdy1AZn
	aZ3sun9XBuqNhEOKN+ABAkDdLJJv6fuw4VI0q
X-Google-Smtp-Source: AGHT+IFms1rHyG/HROh20QipaFnMsmtruhARrzeshL1FUbecblfZ10EdE42yb5F1d0+3w9zzAlWcQCspDTWUYmKpHJM=
X-Received: by 2002:a50:d486:0:b0:573:1366:d196 with SMTP id
 4fb4d7f45d1cf-5731febed56mr14877a12.1.1715105295937; Tue, 07 May 2024
 11:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507162349.130277-1-richardbgobert@gmail.com> <20240507163021.130466-1-richardbgobert@gmail.com>
In-Reply-To: <20240507163021.130466-1-richardbgobert@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 7 May 2024 20:08:03 +0200
Message-ID: <CANn89iJfVHA=n-vSpFwoP3Jb8Wxr1hgem1rLqmyPWPUwDpe-cg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/3] net: gro: move L3 flush checks to
 tcp_gro_receive and udp_gro_receive_segment
To: Richard Gobert <richardbgobert@gmail.com>
Cc: alexander.duyck@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	shuah@kernel.org, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:30=E2=80=AFPM Richard Gobert <richardbgobert@gmail=
.com> wrote:
>
> {inet,ipv6}_gro_receive functions perform flush checks (ttl, flags,
> iph->id, ...) against all packets in a loop. These flush checks are used =
in
> all merging UDP and TCP flows.
>
> These checks need to be done only once and only against the found p skb,
> since they only affect flush and not same_flow.
>
> This patch leverages correct network header offsets from the cb for both
> outer and inner network headers - allowing these checks to be done only
> once, in tcp_gro_receive and udp_gro_receive_segment. As a result,
> NAPI_GRO_CB(p)->flush is not used at all. In addition, flush_id checks ar=
e
> more declarative and contained in inet_gro_flush, thus removing the need
> for flush_id in napi_gro_cb.
>
> This results in less parsing code for non-loop flush tests for TCP and UD=
P
> flows.
>
> To make sure results are not within noise range - I've made netfilter dro=
p
> all TCP packets, and measured CPU performance in GRO (in this case GRO is
> responsible for about 50% of the CPU utilization).
>
> perf top while replaying 64 parallel IP/TCP streams merging in GRO:
> (gro_receive_network_flush is compiled inline to tcp_gro_receive)
> net-next:
>         6.94% [kernel] [k] inet_gro_receive
>         3.02% [kernel] [k] tcp_gro_receive
>
> patch applied:
>         4.27% [kernel] [k] tcp_gro_receive
>         4.22% [kernel] [k] inet_gro_receive
>
> perf top while replaying 64 parallel IP/IP/TCP streams merging in GRO (sa=
me
> results for any encapsulation, in this case inet_gro_receive is top
> offender in net-next)
> net-next:
>         10.09% [kernel] [k] inet_gro_receive
>         2.08% [kernel] [k] tcp_gro_receive
>
> patch applied:
>         6.97% [kernel] [k] inet_gro_receive
>         3.68% [kernel] [k] tcp_gro_receive
>
> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
> ---
>  include/net/gro.h      | 78 +++++++++++++++++++++++++++++++++++++-----
>  net/core/gro.c         |  3 --
>  net/ipv4/af_inet.c     | 41 +---------------------
>  net/ipv4/tcp_offload.c | 17 ++-------
>  net/ipv4/udp_offload.c | 10 ++----
>  net/ipv6/ip6_offload.c | 11 ------
>  6 files changed, 76 insertions(+), 84 deletions(-)
>
> diff --git a/include/net/gro.h b/include/net/gro.h
> index 3dafa0f31ae1..e0939b4b6579 100644
> --- a/include/net/gro.h
> +++ b/include/net/gro.h
> @@ -36,15 +36,15 @@ struct napi_gro_cb {
>         /* This is non-zero if the packet cannot be merged with the new s=
kb. */
>         u16     flush;
>
> -       /* Save the IP ID here and check when we get to the transport lay=
er */
> -       u16     flush_id;
> -
>         /* Number of segments aggregated. */
>         u16     count;
>
>         /* Used in ipv6_gro_receive() and foo-over-udp and esp-in-udp */
>         u16     proto;
>
> +       /* used to support CHECKSUM_COMPLETE for tunneling protocols */
> +       __wsum  csum;
> +
>  /* Used in napi_gro_cb::free */
>  #define NAPI_GRO_FREE             1
>  #define NAPI_GRO_FREE_STOLEN_HEAD 2
> @@ -75,8 +75,8 @@ struct napi_gro_cb {
>                 /* Used in GRE, set in fou/gue_gro_receive */
>                 u8      is_fou:1;
>
> -               /* Used to determine if flush_id can be ignored */
> -               u8      is_atomic:1;
> +               /* Used to determine if ipid_offset can be ignored */
> +               u8      ip_fixedid:1;
>
>                 /* Number of gro_receive callbacks this packet already we=
nt through */
>                 u8 recursion_counter:4;
> @@ -85,9 +85,6 @@ struct napi_gro_cb {
>                 u8      is_flist:1;
>         );
>
> -       /* used to support CHECKSUM_COMPLETE for tunneling protocols */
> -       __wsum  csum;
> -
>         /* L3 offsets */
>         union {
>                 struct {
> @@ -442,6 +439,71 @@ static inline __wsum ip6_gro_compute_pseudo(const st=
ruct sk_buff *skb,
>                                             skb_gro_len(skb), proto, 0));
>  }
>
> +static inline int inet_gro_flush(const struct iphdr *iph, const struct i=
phdr *iph2,
> +                                struct sk_buff *p, bool outer)
> +{
> +       const u32 id =3D ntohl(*(__be32 *)&iph->id);
> +       const u32 id2 =3D ntohl(*(__be32 *)&iph2->id);
> +       const u16 ipid_offset =3D (id >> 16) - (id2 >> 16);
> +       const u16 count =3D NAPI_GRO_CB(p)->count;
> +       const u32 df =3D id & IP_DF;
> +       int flush;
> +
> +       /* All fields must match except length and checksum. */
> +       flush =3D (iph->ttl ^ iph2->ttl) | (iph->tos ^ iph2->tos) | (df ^=
 (id2 & IP_DF));
> +
> +       if (outer && df)
> +               return flush;
> +
> +       /* When we receive our second frame we can make a decision on if =
we
> +        * continue this flow as an atomic flow with a fixed ID or if we =
use
> +        * an incrementing ID.
> +        */
> +       if (count =3D=3D 1 && df && !ipid_offset)
> +               NAPI_GRO_CB(p)->ip_fixedid =3D true;
> +

I could not find where NAPI_GRO_CB(p)->ip_fixedid was cleared, or initializ=
ed
if/when GRO is fed with a GRO/GSO packet.

> +       if (NAPI_GRO_CB(p)->ip_fixedid && df)
> +               return flush | ipid_offset;
> +
> +       return flush | (ipid_offset ^ count);
> +}
> +
> +static inline int ipv6_gro_flush(const struct ipv6hdr *iph, const struct=
 ipv6hdr *iph2)
> +{
> +       /* <Version:4><Traffic_Class:8><Flow_Label:20> */
> +       __be32 first_word =3D *(__be32 *)iph ^ *(__be32 *)iph2;
> +
> +       /* Flush if Traffic Class fields are different. */
> +       return !!((first_word & htonl(0x0FF00000)) |
> +               (__force __be32)(iph->hop_limit ^ iph2->hop_limit));
> +}
> +
> +static inline int __gro_receive_network_flush(const void *th, const void=
 *th2,
> +                                             struct sk_buff *p, const u1=
6 diff,
> +                                             bool outer)
> +{
> +       const void *nh =3D th - diff;
> +       const void *nh2 =3D th2 - diff;
> +
> +       if (((struct iphdr *)nh)->version =3D=3D 6)
> +               return ipv6_gro_flush(nh, nh2);
> +       else
> +               return inet_gro_flush(nh, nh2, p, outer);
> +}
> +
> +static inline int gro_receive_network_flush(const void *th, const void *=
th2,
> +                                           struct sk_buff *p, int off)
> +{
> +       const bool encap_mark =3D NAPI_GRO_CB(p)->encap_mark;
> +       int flush;
> +
> +       flush =3D __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_=
CB(p)->network_offset, encap_mark);
> +       if (encap_mark)
> +               flush |=3D __gro_receive_network_flush(th, th2, p, off - =
NAPI_GRO_CB(p)->inner_network_offset, false);
> +
> +       return flush;
> +}
> +
>  int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb);
>
>  /* Pass the currently batched GRO_NORMAL SKBs up to the stack. */
> diff --git a/net/core/gro.c b/net/core/gro.c
> index 99a45a5211c9..3e9422c23bc9 100644
> --- a/net/core/gro.c
> +++ b/net/core/gro.c
> @@ -331,8 +331,6 @@ static void gro_list_prepare(const struct list_head *=
head,
>         list_for_each_entry(p, head, list) {
>                 unsigned long diffs;
>
> -               NAPI_GRO_CB(p)->flush =3D 0;
> -
>                 if (hash !=3D skb_get_hash_raw(p)) {
>                         NAPI_GRO_CB(p)->same_flow =3D 0;
>                         continue;
> @@ -472,7 +470,6 @@ static enum gro_result dev_gro_receive(struct napi_st=
ruct *napi, struct sk_buff
>                                         sizeof(u32))); /* Avoid slow unal=
igned acc */
>         *(u32 *)&NAPI_GRO_CB(skb)->zeroed =3D 0;
>         NAPI_GRO_CB(skb)->flush =3D skb_has_frag_list(skb);
> -       NAPI_GRO_CB(skb)->is_atomic =3D 1;
>         NAPI_GRO_CB(skb)->count =3D 1;
>         if (unlikely(skb_is_gso(skb))) {
>                 NAPI_GRO_CB(skb)->count =3D skb_shinfo(skb)->gso_segs;
> diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
> index 428196e1541f..44564d009e95 100644
> --- a/net/ipv4/af_inet.c
> +++ b/net/ipv4/af_inet.c
> @@ -1482,7 +1482,6 @@ struct sk_buff *inet_gro_receive(struct list_head *=
head, struct sk_buff *skb)
>         struct sk_buff *p;
>         unsigned int hlen;
>         unsigned int off;
> -       unsigned int id;
>         int flush =3D 1;
>         int proto;
>
> @@ -1508,13 +1507,10 @@ struct sk_buff *inet_gro_receive(struct list_head=
 *head, struct sk_buff *skb)
>                 goto out;
>
>         NAPI_GRO_CB(skb)->proto =3D proto;
> -       id =3D ntohl(*(__be32 *)&iph->id);
> -       flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id =
& ~IP_DF));
> -       id >>=3D 16;
> +       flush =3D (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (nto=
hl(*(__be32 *)&iph->id) & ~IP_DF));
>
>         list_for_each_entry(p, head, list) {
>                 struct iphdr *iph2;
> -               u16 flush_id;
>
>                 if (!NAPI_GRO_CB(p)->same_flow)
>                         continue;
> @@ -1531,43 +1527,8 @@ struct sk_buff *inet_gro_receive(struct list_head =
*head, struct sk_buff *skb)
>                         NAPI_GRO_CB(p)->same_flow =3D 0;
>                         continue;
>                 }
> -
> -               /* All fields must match except length and checksum. */
> -               NAPI_GRO_CB(p)->flush |=3D
> -                       (iph->ttl ^ iph2->ttl) |
> -                       (iph->tos ^ iph2->tos) |
> -                       ((iph->frag_off ^ iph2->frag_off) & htons(IP_DF))=
;
> -
> -               NAPI_GRO_CB(p)->flush |=3D flush;
> -
> -               /* We need to store of the IP ID check to be included lat=
er
> -                * when we can verify that this packet does in fact belon=
g
> -                * to a given flow.
> -                */
> -               flush_id =3D (u16)(id - ntohs(iph2->id));
> -
> -               /* This bit of code makes it much easier for us to identi=
fy
> -                * the cases where we are doing atomic vs non-atomic IP I=
D
> -                * checks.  Specifically an atomic check can return IP ID
> -                * values 0 - 0xFFFF, while a non-atomic check can only
> -                * return 0 or 0xFFFF.
> -                */
> -               if (!NAPI_GRO_CB(p)->is_atomic ||
> -                   !(iph->frag_off & htons(IP_DF))) {
> -                       flush_id ^=3D NAPI_GRO_CB(p)->count;
> -                       flush_id =3D flush_id ? 0xFFFF : 0;
> -               }
> -
> -               /* If the previous IP ID value was based on an atomic
> -                * datagram we can overwrite the value and ignore it.
> -                */
> -               if (NAPI_GRO_CB(skb)->is_atomic)
> -                       NAPI_GRO_CB(p)->flush_id =3D flush_id;
> -               else
> -                       NAPI_GRO_CB(p)->flush_id |=3D flush_id;
>         }
>
> -       NAPI_GRO_CB(skb)->is_atomic =3D !!(iph->frag_off & htons(IP_DF));
>         NAPI_GRO_CB(skb)->flush |=3D flush;
>         NAPI_GRO_CB(skb)->inner_network_offset =3D off;
>
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index b70ae50e658d..5f0af1338d62 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -232,9 +232,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *hea=
d, struct sk_buff *skb)
>         goto out_check_final;
>
>  found:
> -       /* Include the IP ID check below from the inner most IP hdr */
> -       flush =3D NAPI_GRO_CB(p)->flush;
> -       flush |=3D (__force int)(flags & TCP_FLAG_CWR);
> +       flush =3D (__force int)(flags & TCP_FLAG_CWR);
>         flush |=3D (__force int)((flags ^ tcp_flag_word(th2)) &
>                   ~(TCP_FLAG_CWR | TCP_FLAG_FIN | TCP_FLAG_PSH));
>         flush |=3D (__force int)(th->ack_seq ^ th2->ack_seq);
> @@ -242,16 +240,7 @@ struct sk_buff *tcp_gro_receive(struct list_head *he=
ad, struct sk_buff *skb)
>                 flush |=3D *(u32 *)((u8 *)th + i) ^
>                          *(u32 *)((u8 *)th2 + i);
>
> -       /* When we receive our second frame we can made a decision on if =
we
> -        * continue this flow as an atomic flow with a fixed ID or if we =
use
> -        * an incrementing ID.
> -        */
> -       if (NAPI_GRO_CB(p)->flush_id !=3D 1 ||
> -           NAPI_GRO_CB(p)->count !=3D 1 ||
> -           !NAPI_GRO_CB(p)->is_atomic)
> -               flush |=3D NAPI_GRO_CB(p)->flush_id;
> -       else
> -               NAPI_GRO_CB(p)->is_atomic =3D false;
> +       flush |=3D gro_receive_network_flush(th, th2, p, off);
>
>         mss =3D skb_shinfo(p)->gso_size;
>
> @@ -338,7 +327,7 @@ INDIRECT_CALLABLE_SCOPE int tcp4_gro_complete(struct =
sk_buff *skb, int thoff)
>                                   iph->daddr, 0);
>
>         skb_shinfo(skb)->gso_type |=3D SKB_GSO_TCPV4 |
> -                       (NAPI_GRO_CB(skb)->is_atomic * SKB_GSO_TCP_FIXEDI=
D);
> +                       (NAPI_GRO_CB(skb)->ip_fixedid * SKB_GSO_TCP_FIXED=
ID);
>
>         tcp_gro_complete(skb);
>         return 0;
> diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
> index 8721fe5beca2..726565159dc7 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -466,6 +466,7 @@ static struct sk_buff *udp_gro_receive_segment(struct=
 list_head *head,
>                                                struct sk_buff *skb)
>  {
>         struct udphdr *uh =3D udp_gro_udphdr(skb);
> +       int off =3D skb_gro_offset(skb);
>         struct sk_buff *pp =3D NULL;
>         struct udphdr *uh2;
>         struct sk_buff *p;
> @@ -505,14 +506,7 @@ static struct sk_buff *udp_gro_receive_segment(struc=
t list_head *head,
>                         return p;
>                 }
>
> -               flush =3D NAPI_GRO_CB(p)->flush;
> -
> -               if (NAPI_GRO_CB(p)->flush_id !=3D 1 ||
> -                   NAPI_GRO_CB(p)->count !=3D 1 ||
> -                   !NAPI_GRO_CB(p)->is_atomic)
> -                       flush |=3D NAPI_GRO_CB(p)->flush_id;
> -               else
> -                       NAPI_GRO_CB(p)->is_atomic =3D false;
> +               flush =3D gro_receive_network_flush(uh, uh2, p, off);
>
>                 /* Terminate the flow on len mismatch or if it grow "too =
much".
>                  * Under small packet flood GRO count could elsewhere gro=
w a lot
> diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
> index 288c7c6ea50f..bd5aff97d8b1 100644
> --- a/net/ipv6/ip6_offload.c
> +++ b/net/ipv6/ip6_offload.c
> @@ -290,19 +290,8 @@ INDIRECT_CALLABLE_SCOPE struct sk_buff *ipv6_gro_rec=
eive(struct list_head *head,
>                                    nlen - sizeof(struct ipv6hdr)))
>                                 goto not_same_flow;
>                 }
> -               /* flush if Traffic Class fields are different */
> -               NAPI_GRO_CB(p)->flush |=3D !!((first_word & htonl(0x0FF00=
000)) |
> -                       (__force __be32)(iph->hop_limit ^ iph2->hop_limit=
));
> -               NAPI_GRO_CB(p)->flush |=3D flush;
> -
> -               /* If the previous IP ID value was based on an atomic
> -                * datagram we can overwrite the value and ignore it.
> -                */
> -               if (NAPI_GRO_CB(skb)->is_atomic)
> -                       NAPI_GRO_CB(p)->flush_id =3D 0;
>         }
>
> -       NAPI_GRO_CB(skb)->is_atomic =3D true;
>         NAPI_GRO_CB(skb)->flush |=3D flush;
>
>         skb_gro_postpull_rcsum(skb, iph, nlen);
> --
> 2.36.1
>

