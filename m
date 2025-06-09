Return-Path: <linux-kselftest+bounces-34477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1A9AD204D
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9F71886A45
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5080325D559;
	Mon,  9 Jun 2025 13:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz3Di2xi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783A62571D8;
	Mon,  9 Jun 2025 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749477034; cv=none; b=Vg/y/mC2jufBp4wzudHcAjgKy6vrjZh+6gfOrHvB4GJKP998SIApcl3/bV2u8oB95subAxedhzbpgwPf73DSw4JxRk7JR6gdZxbq9377K3irr1UJipnpPQ/oG3luYYdixo2k4kIhVtFjWx/ODjQy676wm265zgIgHrpSWHrzT2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749477034; c=relaxed/simple;
	bh=TfJRv3Jq8V/kbJ9EAFnJDVvFjSVflQQqAcFlIwK70d4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ePSqode9XyufJ4eK79zgALDw3XPgg8kSD8ikxMPKa5mogPBFTCZduW48OUAH7hiChQGeetT6ZrikuyiaU6/wuhByp1NndrW3CUAbJcj8Ii6FuPvc0DxvivXtkuJluwM+K+c1eDtLJdMR4dr8+fti13SDxRH4b1i/NlIXn1aGRWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz3Di2xi; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-710f39f5cb9so30749737b3.3;
        Mon, 09 Jun 2025 06:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749477031; x=1750081831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCFKHnn9XDXTSH/ces8W9yv4oDl2tYdrN0/ngfBqiGg=;
        b=Nz3Di2xiHeOWgHzQeuoFddY5EoqXPAP8aTOAFkVKp1e9HoiebY+uJy5TJ4RQtStLWX
         bt//s7veI9hlMO3q18I+41fdn2bu64I3C2APyXfvQrsjmSvbOL8JmbGXRlgYL3nQZwFI
         /nsiFNxwTiG4m4PFRBT1WVxjMgdpt95259JY3c9iCrhXUun/SNkru0H2GFyS7nA2MpAL
         COPDpKmPVq6X4+H4Xc7WU59GPN9QBfxaUFQCbR95OlUGhSP7P9H5nsCAJvNQwTmsuJ3S
         +xIZsc0z+CiR5d+syzZiGhwMEhTk41N2WY/9hi1W4wWKiyHfPx1ovjDbU+TbJ4sj+rpt
         SqpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749477031; x=1750081831;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UCFKHnn9XDXTSH/ces8W9yv4oDl2tYdrN0/ngfBqiGg=;
        b=WlpwTEPYihRb7Q4CArsWAKfmQN1/nr7iTr1BW+2aMdmn7fpu0DHOVWEvOHQIn8h1qI
         rAtQdd+QJzYRjeimdC6wks9q2zkrJV3rTc1Goi913pXyAJVD1g7YCYt0g1YKyKVMbB22
         32sqFJobTxCwBKT7NuLES8M+1EdmAcznj8JViBTc+J9lyiTYC/81zg+31NxvKZ19GSQm
         KEQMf+4YVTNrPwjfi8H4aMuRkm9zs+OP609QLNLG4NX46cTmLI7Gkj8pGrSAZu3htX9q
         6hv9EBKtz2jHvJqrIKamr1E/ylAf/QC/+2sJnmKnozgyz7tIPutjtcSW88t4B5BwC/eS
         esGw==
X-Forwarded-Encrypted: i=1; AJvYcCWIEMRnxUUEogtSORRCXSUnJkeERp/gRMcFlGz3Rv3CMjdz3FiARSeQV3er57k/zpzCY0o=@vger.kernel.org, AJvYcCWXoPRsRcZhRA4W4LKJZwc9/h2SRhblez+dpx0crBRhO06BvuK94A/orQRYI/a4JjrG8QWJa3vn@vger.kernel.org, AJvYcCXgSMraFUNowKQoPkC9AfgCb8H62ESbX2F+cZZvLgnlGQNmN9V91DLE8tJNmfg49v7kAz5yn0brqH0qJTHUAZy5@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0cEwUpqFUJ+4PxJPOXRiFkhY+VlLR224oFoPIHzk4F2mRL9K6
	z6YGywY1l0XZ2TaI22+VwH4YA6gXCHN8EJbhBmS0HvHaj/DmdA30JBtM
X-Gm-Gg: ASbGncuVkFIUsh7boniQalh3CtcB6RLyc31PYk8o2cCn+j1rdTOtVgcbepad2VkkiN7
	eHvuBybtb1YWlXjPL9f8EfxXFMcclgB8eGg/yZbn7wx6zfucRBv8dd9yKE5jVSeicRIdXYe+Yyo
	uB1odTmK6CxiSViiCdow2nJCAtiD97QSABdIVLcSTo4scjpfrSlmwiwpssA+kXNLipXeN9kCvdw
	7aX5x0qmiKgrgxKYUxcAcKARxkMTQtYdrhpyXIGmavNCMnt4t1VszzE5/uaocu+2qiI/uI9J7i4
	KOz7Lq2HXd5AquQv5Mf6GCVBZb/A+5i4pHNy2BzFQImHpVwmW6rx9E8ITi1cREdQUBGZxNge0v6
	tNSuOGEteRBFdWsIIVSupFmO3l//jVk8m2NaRh00Etg==
X-Google-Smtp-Source: AGHT+IE9BX0iSiWC9oKQMJC2n+ps6EL2p2MU+EEs0w2d3NOwBfHjr3+wwU8sQL4sDbXG/qwafEx5UQ==
X-Received: by 2002:a05:690c:389:b0:70d:ed5d:b4bd with SMTP id 00721157ae682-710f76ff597mr174049457b3.21.1749477031438;
        Mon, 09 Jun 2025 06:50:31 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-710f98af944sm12555627b3.13.2025.06.09.06.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 06:50:30 -0700 (PDT)
Date: Mon, 09 Jun 2025 09:50:30 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?TWFjaWVqIMW7ZW5jenlrb3dza2k=?= <maze@google.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, 
 netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 martin.lau@linux.dev, 
 john.fastabend@gmail.com, 
 eddyz87@gmail.com, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 willemb@google.com, 
 william.xuanziyang@huawei.com, 
 alan.maguire@oracle.com, 
 bpf@vger.kernel.org, 
 shuah@kernel.org, 
 linux-kselftest@vger.kernel.org, 
 yonghong.song@linux.dev
Message-ID: <6846e6a6342c7_34e997294f9@willemb.c.googlers.com.notmuch>
In-Reply-To: <CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
References: <20250607204734.1588964-1-kuba@kernel.org>
 <CANP3RGcUbSG3dQQbDrsYq9YSMStXbmEsq6U34jcieA_45H4_JQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: clear the dst when changing skb protocol
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej =C5=BBenczykowski wrote:
> On Sat, Jun 7, 2025 at 10:47=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> >
> > A not-so-careful NAT46 BPF program can crash the kernel
> > if it indiscriminately flips ingress packets from v4 to v6:
> >
> >   BUG: kernel NULL pointer dereference, address: 0000000000000000
> >     ip6_rcv_core (net/ipv6/ip6_input.c:190:20)
> >     ipv6_rcv (net/ipv6/ip6_input.c:306:8)
> >     process_backlog (net/core/dev.c:6186:4)
> >     napi_poll (net/core/dev.c:6906:9)
> >     net_rx_action (net/core/dev.c:7028:13)
> >     do_softirq (kernel/softirq.c:462:3)
> >     netif_rx (net/core/dev.c:5326:3)
> >     dev_loopback_xmit (net/core/dev.c:4015:2)
> >     ip_mc_finish_output (net/ipv4/ip_output.c:363:8)
> >     NF_HOOK (./include/linux/netfilter.h:314:9)
> >     ip_mc_output (net/ipv4/ip_output.c:400:5)
> >     dst_output (./include/net/dst.h:459:9)
> >     ip_local_out (net/ipv4/ip_output.c:130:9)
> >     ip_send_skb (net/ipv4/ip_output.c:1496:8)
> >     udp_send_skb (net/ipv4/udp.c:1040:8)
> >     udp_sendmsg (net/ipv4/udp.c:1328:10)
> >
> > The output interface has a 4->6 program attached at ingress.
> > We try to loop the multicast skb back to the sending socket.
> > Ingress BPF runs as part of netif_rx(), pushes a valid v6 hdr
> > and changes skb->protocol to v6. We enter ip6_rcv_core which
> > tries to use skb_dst(). But the dst is still an IPv4 one left
> > after IPv4 mcast output.
> >
> > Clear the dst in all BPF helpers which change the protocol.
> > Also clear the dst if we did an encap or decap as those
> > will most likely make the dst stale.
> > Try to preserve metadata dsts, those may carry non-routing
> > metadata.
> >
> > Reviewed-by: Maciej =C5=BBenczykowski <maze@google.com>
> > Acked-by: Daniel Borkmann <daniel@iogearbox.net>
> > Fixes: d219df60a70e ("bpf: Add ipip6 and ip6ip decap support for bpf_=
skb_adjust_room()")
> > Fixes: 1b00e0dfe7d0 ("bpf: update skb->protocol in bpf_skb_net_grow")=

> > Fixes: 6578171a7ff0 ("bpf: add bpf_skb_change_proto helper")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> > ---
> > v2:
> >  - drop on encap/decap
> >  - fix typo (protcol)
> >  - add the test to the Makefile
> > v1: https://lore.kernel.org/20250604210604.257036-1-kuba@kernel.org
> >
> > I wonder if we should not skip ingress (tc_skip_classify?)
> > for looped back packets in the first place. But that doesn't
> > seem robust enough vs multiple redirections to solve the crash.
> >
> > Ignoring LOOPBACK packets (like the NAT46 prog should) doesn't
> > work either, since BPF can change pkt_type arbitrarily.
> >
> > CC: martin.lau@linux.dev
> > CC: daniel@iogearbox.net
> > CC: john.fastabend@gmail.com
> > CC: eddyz87@gmail.com
> > CC: sdf@fomichev.me
> > CC: haoluo@google.com
> > CC: willemb@google.com
> > CC: william.xuanziyang@huawei.com
> > CC: alan.maguire@oracle.com
> > CC: bpf@vger.kernel.org
> > CC: edumazet@google.com
> > CC: maze@google.com
> > CC: shuah@kernel.org
> > CC: linux-kselftest@vger.kernel.org
> > CC: yonghong.song@linux.dev
> > ---
> >  tools/testing/selftests/net/Makefile   |  1 +
> >  net/core/filter.c                      | 31 +++++++++++++++++++-----=
--
> >  tools/testing/selftests/net/nat6to4.sh | 15 +++++++++++++
> >  3 files changed, 39 insertions(+), 8 deletions(-)
> >  create mode 100755 tools/testing/selftests/net/nat6to4.sh
> >
> > diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/sel=
ftests/net/Makefile
> > index ea84b88bcb30..ab996bd22a5f 100644
> > --- a/tools/testing/selftests/net/Makefile
> > +++ b/tools/testing/selftests/net/Makefile
> > @@ -27,6 +27,7 @@ TEST_PROGS +=3D amt.sh
> >  TEST_PROGS +=3D unicast_extensions.sh
> >  TEST_PROGS +=3D udpgro_fwd.sh
> >  TEST_PROGS +=3D udpgro_frglist.sh
> > +TEST_PROGS +=3D nat6to4.sh
> >  TEST_PROGS +=3D veth.sh
> >  TEST_PROGS +=3D ioam6.sh
> >  TEST_PROGS +=3D gro.sh
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 327ca73f9cd7..d5917d6446f2 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3406,8 +3406,14 @@ BPF_CALL_3(bpf_skb_change_proto, struct sk_buf=
f *, skb, __be16, proto,
> >          * need to be verified first.
> >          */
> >         ret =3D bpf_skb_proto_xlat(skb, proto);
> > +       if (ret)
> > +               return ret;
> > +
> >         bpf_compute_data_pointers(skb);
> > -       return ret;

I wonder whether that unconditional call to bpf_compute_data_pointers
even if ret was there for a reason.

From reviewing the bpf_skb_proto_xlat error paths, it does seem safe
to remove it. The cases where an error may be returned after the skb
is modified only modify the skb in terms of headroom, not headlen.

> > +       if (skb_valid_dst(skb))
> > +               skb_dst_drop(skb);
> > +
> > +       return 0;
> >  }
> >=

