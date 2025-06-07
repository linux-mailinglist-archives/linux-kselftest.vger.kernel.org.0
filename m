Return-Path: <linux-kselftest+bounces-34436-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC7DAD101F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 23:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA516C9F2
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Jun 2025 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5C6207E1D;
	Sat,  7 Jun 2025 21:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pWkfsfnI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647AD1EF389
	for <linux-kselftest@vger.kernel.org>; Sat,  7 Jun 2025 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749332034; cv=none; b=g9zMlPd6wDaljGanVADR8SNm3eg9tha5Pw713WEk3thhnQCyyb9nA6l7RytX/J1GtKsyXH/2CA/RQaFB+6akQq95ltYrnJytTewpLDTfhecj6U1hjLi981zreXhgrResS9uTDT6XEoMUeYoP36mAxpfbz62ivPv6s06Ywo2kvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749332034; c=relaxed/simple;
	bh=3/M3ccrWZp5u2VNOBbvcJoc7wo14vpHAa7KQVn3+GrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DFTGpny+LSf6elgGmsgm9iQWAS1MP+6TVApuzDTo1zdME1omlIJwUn9iy/8kM4eLF9Sca4vDKjDL1xFIZ/tIKBlNdD+HQc49l0b9QDL5rqtx9U9pQwrh7GLones0WMAiR8kUSyeKCp9d4py7MROCigQ47G/W+9Fn4SyWIKpYCO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pWkfsfnI; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-601a67c6e61so6107a12.0
        for <linux-kselftest@vger.kernel.org>; Sat, 07 Jun 2025 14:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749332031; x=1749936831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ULC9uw+RVtU2OdxAfjiUwybXCKSG72R6i3xFRi9IKKQ=;
        b=pWkfsfnIfhO28gOAH8COjiOt7oLoGYKxC0LF8CIuJ9XpVxu3wX8aRkuniq4vZCga1B
         6zW4efU1SvvYZJuapmYHVixWqgY0MYwUuJWvmoh4RvFEN4R4fWhfWBInB6sk2yaBQU5d
         D/myTecazpXNRc3KIrP6jATmBaqT0c7i8RrmFOPo9+MN13mceJNmcq7V3G/PNvkt82/T
         zB0ifG8Xe9zg8ORnIri9fyvJS+eXaXTJ8gWxA2m5hI9MATXwx48GjJXhCv/BHVQAbsSz
         rBeHiB/iRVgTbqOdi6geWsoqpsGSF3RN8BzfB7Cgqrk4oehlW+NGhQEF3lpgoev/2hhQ
         omqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749332031; x=1749936831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ULC9uw+RVtU2OdxAfjiUwybXCKSG72R6i3xFRi9IKKQ=;
        b=VOgfQcBGqWnNAh4NY+f9skppmE18QF7JnsqK7aYWENBXbj1+h+30/f8cRsx2tkLjgg
         6QWushsviqY7RSYeL+XKNh9xR/WFy85oytOY8ZVO+6JzTcATvPHhQzCplexyJnox7r92
         YyiIrqf7ro41FA+SoZopT7kiKVsYglcA9UBJ6AMKGUZZ+3KIeeBTPNCeUq03Q4Mh/VR4
         lzCO8jASiD+oK2IVRqHxu/nhROaiQUTjlw1LTgmL2/IqUIv2pDi4ikHq/SBYjJNmA+1U
         1Ojo2YndqrTFDgwMXTK/MM+aaL2jBBM+63lFkorqpg+fKWEBI+Wi4cdpbSNOlINhTS4i
         3k+Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6Xrh2fn8pmLx6VA/EteeZ5Y9ddVUbYuJIjrQTIhUwLeUdywlvQ32eYCCVebGyEz4QpAvC7+NiMkrLxhoSMz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe1xHbY6EBPQK8llgYhptF7+whgKQnAo1vH3iHumVNC8lsLBdO
	+JUSaEcncH9PLcKdxggjY3xMA5sJ+DsTqDT8M6KCf/2mMeWtCCdYUCriz6HCmrceny4pyZZgr8r
	1NWPM7ulRd9493t14DEgLwrxajZzQ+naj38AyJokz3SmWblpY1Q1w0sPs
X-Gm-Gg: ASbGncsTDRTlkV3udCPRoDXvm7eaPPGcq25xyzeS40Uq6EJ+Cxmpac+CjldvZQocM+Q
	Q2SFCRcs+YdwiU1GXzu4ydosfQEw6WbuRgiyXx8aYiS+Tb/dfYOSDnPfH72OT41ak0AXPmOaMjY
	2bygdTwmd2EwEsXyd38q1Rro7pGPlJzBKhhQJxKYWqH6g+rzO8EZ/8cIU4fYxUr7LDg9soTF5ss
	DdZ
X-Google-Smtp-Source: AGHT+IHZRw75GHcfGKidr88HD4akXh5GHOYLSnXUBzwNvKK0NFSaNvii2au/1wkAxzA5bTDf1WVuilINzQxwF0wUBpA=
X-Received: by 2002:a05:6402:78a:b0:5e6:15d3:ffe7 with SMTP id
 4fb4d7f45d1cf-607bc5b1adfmr37729a12.7.1749332030475; Sat, 07 Jun 2025
 14:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250607204734.1588964-1-kuba@kernel.org>
In-Reply-To: <20250607204734.1588964-1-kuba@kernel.org>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Sat, 7 Jun 2025 23:33:39 +0200
X-Gm-Features: AX0GCFveamE-E1Ol5AvUbHWowgW6jiuE_W-0_tRJ-bcHM84FhrgZa_Krv70YkoU
Message-ID: <CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: clear the dst when changing skb protocol
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev, john.fastabend@gmail.com, 
	eddyz87@gmail.com, sdf@fomichev.me, haoluo@google.com, willemb@google.com, 
	william.xuanziyang@huawei.com, alan.maguire@oracle.com, bpf@vger.kernel.org, 
	shuah@kernel.org, linux-kselftest@vger.kernel.org, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 7, 2025 at 10:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> A not-so-careful NAT46 BPF program can crash the kernel
> if it indiscriminately flips ingress packets from v4 to v6:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
>     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
>     process_backlog (net/core/dev.c:6186:4)
>     napi_poll (net/core/dev.c:6906:9)
>     net_rx_action (net/core/dev.c:7028:13)
>     do_softirq (kernel/softirq.c:462:3)
>     netif_rx (net/core/dev.c:5326:3)
>     dev_loopback_xmit (net/core/dev.c:4015:2)
>     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
>     NF_HOOK (./include/linux/netfilter.h:314:9)
>     ip_mc_output (net/ipv4/ip_output.c:400:5)
>     dst_output (./include/net/dst.h:459:9)
>     ip_local_out (net/ipv4/ip_output.c:130:9)
>     ip_send_skb (net/ipv4/ip_output.c:1496:8)
>     udp_send_skb (net/ipv4/udp.c:1040:8)
>     udp_sendmsg (net/ipv4/udp.c:1328:10)
>
> The output interface has a 4->6 program attached at ingress.
> We try to loop the multicast skb back to the sending socket.
> Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
> and changes skb->protocol to v6. We enter ip6_rcv_core which
> tries to use skb_dst(). But the dst is still an IPv4 one left
> after IPv4 mcast output.
>
> Clear the dst in all BPF helpers which change the protocol.
> Also clear the dst if we did an encap or decap as those
> will most likely make the dst stale.
> Try to preserve metadata dsts, those may carry non-routing
> metadata.
>
> Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
> Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_skb_=
adjust_room()")
> Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")
> Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - drop on encap/decap
>  - fix typo (protcol)
>  - add the test to the Makefile
> v1: https://lore.kernel.org/20250604210604.257036-1-kuba@kernel.org
>
> I wonder if we should not skip ingress (tc_skip_classify?)
> for looped back packets in the first place. But that doesn't
> seem robust enough vs multiple redirections to solve the crash.
>
> Ignoring LOOPBACK packets (like the NAT46 prog should) doesn't
> work either, since BPF can change pkt_type arbitrarily.
>
> CC: martin.lau@linux.dev
> CC: daniel@iogearbox.net
> CC: john.fastabend@gmail.com
> CC: eddyz87@gmail.com
> CC: sdf@fomichev.me
> CC: haoluo@google.com
> CC: willemb@google.com
> CC: william.xuanziyang@huawei.com
> CC: alan.maguire@oracle.com
> CC: bpf@vger.kernel.org
> CC: edumazet@google.com
> CC: maze@google.com
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> CC: yonghong.song@linux.dev
> ---
>  tools/testing/selftests/net/Makefile   |  1 +
>  net/core/filter.c                      | 31 +++++++++++++++++++-------
>  tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++
>  3 files changed, 39 insertions(+), 8 deletions(-)
>  create mode 100755 tools/testing/selftests/net/nat6to4.sh
>
> diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftes=
ts/net/Makefile
> index ea84b88bcb30..ab996bd22a5f 100644
> --- a/tools/testing/selftests/net/Makefile
> +++ b/tools/testing/selftests/net/Makefile
> @@ -27,6 +27,7 @@ TEST_PROGS +=3D amt.sh
>  TEST_PROGS +=3D unicast_extensions.sh
>  TEST_PROGS +=3D udpgro_fwd.sh
>  TEST_PROGS +=3D udpgro_frglist.sh
> +TEST_PROGS +=3D nat6to4.sh
>  TEST_PROGS +=3D veth.sh
>  TEST_PROGS +=3D ioam6.sh
>  TEST_PROGS +=3D gro.sh
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 327ca73f9cd7..d5917d6446f2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3406,8 +3406,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *,=
 skb, __be16, proto,
>          * need to be verified first.
>          */
>         ret =3D bpf_skb_proto_xlat(skb, proto);
> +       if (ret)
> +               return ret;
> +
>         bpf_compute_data_pointers(skb);
> -       return ret;
> +       if (skb_valid_dst(skb))
> +               skb_dst_drop(skb);
> +
> +       return 0;
>  }
>
>  static const struct bpf_func_proto bpf_skb_change_proto_proto =3D {
> @@ -3554,6 +3560,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u3=
2 off, u32 len_diff,
>                 else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
>                          flags & BPF_F_ADJ_ROOM_ENCAP_L3_IPV4)
>                         skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
>         }
>
>         if (skb_is_gso(skb)) {
> @@ -3581,6 +3590,7 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u3=
2 off, u32 len_diff,
>  static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff=
,
>                               u64 flags)
>  {
> +       bool decap =3D flags & BPF_F_ADJ_ROOM_DECAP_L3_MASK;
>         int ret;
>
>         if (unlikely(flags & ~(BPF_F_ADJ_ROOM_FIXED_GSO |
> @@ -3603,13 +3613,18 @@ static int bpf_skb_net_shrink(struct sk_buff *skb=
, u32 off, u32 len_diff,
>         if (unlikely(ret < 0))
>                 return ret;
>
> -       /* Match skb->protocol to new outer l3 protocol */
> -       if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> -           flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> -               skb->protocol =3D htons(ETH_P_IPV6);
> -       else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> -                flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> -               skb->protocol =3D htons(ETH_P_IP);
> +       if (decap) {
> +               /* Match skb->protocol to new outer l3 protocol */
> +               if (skb->protocol =3D=3D htons(ETH_P_IP) &&
> +                   flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV6)
> +                       skb->protocol =3D htons(ETH_P_IPV6);
> +               else if (skb->protocol =3D=3D htons(ETH_P_IPV6) &&
> +                        flags & BPF_F_ADJ_ROOM_DECAP_L3_IPV4)
> +                       skb->protocol =3D htons(ETH_P_IP);
> +
> +               if (skb_valid_dst(skb))
> +                       skb_dst_drop(skb);
> +       }
>
>         if (skb_is_gso(skb)) {
>                 struct skb_shared_info *shinfo =3D skb_shinfo(skb);
> diff --git a/tools/testing/selftests/net/nat6to4.sh b/tools/testing/selft=
ests/net/nat6to4.sh
> new file mode 100755
> index 000000000000..0ee859b622a4
> --- /dev/null
> +++ b/tools/testing/selftests/net/nat6to4.sh
> @@ -0,0 +1,15 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +NS=3D"ns-peer-$(mktemp -u XXXXXX)"
> +
> +ip netns add "${NS}"
> +ip -netns "${NS}" link set lo up
> +ip -netns "${NS}" route add default via 127.0.0.2 dev lo
> +
> +tc -n "${NS}" qdisc add dev lo ingress
> +tc -n "${NS}" filter add dev lo ingress prio 4 protocol ip \
> +   bpf object-file nat6to4.bpf.o section schedcls/egress4/snat4 direct-a=
ction
> +
> +ip netns exec "${NS}" \
> +   bash -c 'echo 0123456789012345678901234567890123456789012345678901234=
56789012345678901234567890123456789012345678901234567890123456789abc | soca=
t - UDP4-DATAGRAM:224.1.0.1:6666,ip-multicast-loop=3D1'
> --
> 2.49.0

Submit away.

1 meta question: as this is a fix and will thus be backported into
5.4+ LTS, should this be split into two patches? Either making the
test a follow up, or even going with only the crash fix in patch 1 and
putting the 4-in-4 and 6-in-6 behavioural change in patch 2?  We'd end
up in the same state at tip of tree... but it would affect the LTS
backports.  Honestly I'm not even sure what's best.

