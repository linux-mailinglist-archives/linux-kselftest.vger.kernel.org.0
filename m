Return-Path: <linux-kselftest+bounces-30066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F78A7A516
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 16:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846E1681E5
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 14:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025A324EAB2;
	Thu,  3 Apr 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGts9A16"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98C24EA90;
	Thu,  3 Apr 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690315; cv=none; b=qdJdBn1OamqUP0NslYJRI2JRiwMd6JC3J3xvDxlgaWhMkff5niqenXDd8KCL33jzfKhs+PaYCovBKWBxbtrNkdLXB0CkFw2eRyFdJ3wEK/HIcBLTrU0ZqxJWtoqu57276HbOZKh6bJJch1JLBWKM5cJUc03FIJNW5WM3Ftg+mKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690315; c=relaxed/simple;
	bh=tKG4mgxr/waIXYy3UE25TN/Cf98+hnU2uITZp+axu1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=towyJEHmxYeaA5ZWm1XAILh2Zeysr1I+MclcqkHZ5urKbQnGl2HOpN6lD+pjV8b6KHLaN0xSF+NquMayoocY2Kgg5QooDPe9uuIvYuxsL8SQwhsT+W4iT48FQfVWv2SDqmF7yGWOwrbxqLiC2tgwi8WrLBhyJ1+I3moOd8xuZcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGts9A16; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d0782d787so6340625e9.0;
        Thu, 03 Apr 2025 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690312; x=1744295112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bYt3/DwYVuXN5SPjLpQjF/KbDAzdmiI9+JL6XuVsme4=;
        b=CGts9A16taOdsG7gm1S5QeyBfdl/JTbajDjeV8bO4RBcxL9lWd1FEL9SE8zC2dSplG
         EMzy7B93b4v34nYprCYwTv0n/vCgnQ0pp4QIXZznGZtDSTNMmyDcCkyy6f+a9vYO/9aY
         Q2KNJndfS8ObjqOfD2+9g90qRq2+GmFy/0DB8bumF3W0h358z6XxK+2B42iLhrj83kVB
         8mBiv9uRvVjwCkJeU3vJhwlFQ5IClk20GUqgsGZBbXBSPAtuJ7KITASYLEP9l3/ibYDL
         gSuGCWtuKgQbnBiqQU4FatFj1gkbN0u94z2sstImS5rbp5zggs/dKNhT0p2MX8eqvkzA
         EHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690312; x=1744295112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bYt3/DwYVuXN5SPjLpQjF/KbDAzdmiI9+JL6XuVsme4=;
        b=AXivcSxbACqfwfi6eOpMcvI5Bjh1VTHxD4xLIFF+O8COg6qGlijztF+Sr2wvFZ6oPY
         TTmWFvt1pNkC91/kczTh+RFsTER586AKsx5hwgLDrCqsuOkihmjxhkYWC6QmN4r+EONC
         OJTt8cPShcOjUI5Ky0nIMXStSVPVfcQHk8xGObCgdYrx5bKOdRAmpMk8jGO7fOVAVh8N
         P+Hvjd2dsAvH/XOrdZqDKV2bPiHAvZF9zOU46kNbHe49l1oUuLjP29HlkKEhxyy5Leva
         LbY6yPN0+prbiSI6YamtgzOI+eT54kDPTTOZ4XSqD9oafn90J8bTFYi1t0v2izenhq+t
         dfYw==
X-Forwarded-Encrypted: i=1; AJvYcCUmdh2IpD2pDTL/dG6Mdyf1OzG0L8+h4Q6yBt7r9w6N67KE8ChCbiayzISXml7yTqVIIW0tC8pCuHui/iAk1S2+@vger.kernel.org, AJvYcCUmgOA1ehczkB9hZEsmCs6gf16JN5WoyC8EyA+UF7I+KSyBRBLVg5ciAh7lqXS5p1Xdq/becMsM@vger.kernel.org, AJvYcCV0Z4EfcaBJPm02t1xKcx9KrPRvW8JEpqhiEF/qkgEgHRuRKKcowMzjnzk6msF72uzELl8i89L9HhTfP3I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3kCEEmg1/0C1jFHk+l5AOCZ5sy19+P9SvfkJJpyM82c+yntBy
	WelkTAdq5VkXaRAHRfgtH8NmH96EeHLxXzp5Gpf0OgnWMagx7J6VFxk4OE/gW47JnuwonIDD9I8
	NzY64c6JDoDKT/1kTKpc+Ova2Vrk=
X-Gm-Gg: ASbGncv9UXOoIfpzk4sOquGBiPH7f3yl4UMmA37/3Dt2KiuksUtsshosNrhuOcVCamq
	loYYlSp06RJH05scdGjqe/FPsZ+Qy6M2BLohru0sGWu/wv3zrgr9OLhGloNHjiSn6vns4Hisoz3
	B3SPLXgZ2t8boDX/WLLnF6U5rucygk3+7jkuIQoCJRgw==
X-Google-Smtp-Source: AGHT+IHUkOyw3ev23XqXHBt0KxfVIhLR/1X4BbNWvcbsg0kdXKegScCaWHDKnAMpZBX6hw7sIGdWPn1U4w8qAoQQkB0=
X-Received: by 2002:a05:6000:1862:b0:390:f6aa:4e7c with SMTP id
 ffacd0b85a97d-39c120e0bc1mr17240592f8f.28.1743690312134; Thu, 03 Apr 2025
 07:25:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331032354.75808-1-jiayuan.chen@linux.dev> <20250331032354.75808-2-jiayuan.chen@linux.dev>
In-Reply-To: <20250331032354.75808-2-jiayuan.chen@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 07:24:58 -0700
X-Gm-Features: ATxdqUHpnDryxsVQqbU7wXWf5I9AbRjQwuexib-K1AFMMQc4NlaNR5RWjUUlZVo
Message-ID: <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Jiayuan Chen <mrpre@163.com>, 
	syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Anton Protopopov <aspsk@isovalent.com>, 
	Abhishek Chauhan <quic_abchauha@quicinc.com>, Jordan Rome <linux@jordanrome.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>, David Lechner <dlechner@baylibre.com>, 
	LKML <linux-kernel@vger.kernel.org>, Network Development <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 30, 2025 at 8:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> The device allocates an skb, it additionally allocates a prepad size
> (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
> uninitialized.
>
> The bpf_xdp_adjust_head function moves skb->data forward, which allows
> users to access data belonging to other programs, posing a security risk.
>
> Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@google.c=
om/T/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  include/uapi/linux/bpf.h       | 8 +++++---
>  net/core/filter.c              | 5 ++++-
>  tools/include/uapi/linux/bpf.h | 6 ++++--
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index defa5bb881f4..be01a848cbbf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2760,8 +2760,9 @@ union bpf_attr {
>   *
>   * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
>   *     Description
> - *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note=
 that
> - *             it is possible to use a negative value for *delta*. This =
helper
> + *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note=
 that
> + *             it is possible to use a negative value for *delta*. If *d=
elta*
> + *             is negative, the new header will be memset to zero. This =
helper
>   *             can be used to prepare the packet for pushing or popping
>   *             headers.
>   *
> @@ -2989,7 +2990,8 @@ union bpf_attr {
>   * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
>   *     Description
>   *             Adjust the address pointed by *xdp_md*\ **->data_meta** b=
y
> - *             *delta* (which can be positive or negative). Note that th=
is
> + *             *delta* (which can be positive or negative). If *delta* i=
s
> + *             negative, the new meta will be memset to zero. Note that =
this
>   *             operation modifies the address stored in *xdp_md*\ **->da=
ta**,
>   *             so the latter must be loaded only after the helper has be=
en
>   *             called.
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 46ae8eb7a03c..5f01d373b719 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff *, =
xdp, int, offset)
>         if (metalen)
>                 memmove(xdp->data_meta + offset,
>                         xdp->data_meta, metalen);
> +       if (offset < 0)
> +               memset(data, 0, -offset);
>         xdp->data_meta +=3D offset;
>         xdp->data =3D data;
>
> @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff *, =
xdp, int, offset)
>                 return -EINVAL;
>         if (unlikely(xdp_metalen_invalid(metalen)))
>                 return -EACCES;
> -
> +       if (offset < 0)
> +               memset(meta, 0, -offset);

Let's make everyone pay a performance penalty to silence
KMSAN warning?

I don't think it's a good trade off.

Soft nack.

