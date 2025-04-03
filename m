Return-Path: <linux-kselftest+bounces-30067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBC9A7A540
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC24A188F2D7
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Apr 2025 14:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1DA24EAB9;
	Thu,  3 Apr 2025 14:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ak0LtGE7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2329524C08A;
	Thu,  3 Apr 2025 14:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743690733; cv=none; b=ivThEpJPkfjx6h6BcWngIgqPmmuk4Se7lpkOtD9JfdMID+CRybs4OVTE5UFBy5w2xKpIGe+uRnT28/L1Hp38sou/7grymiI9xQauF7THvUltWeOKu7xxVqfkz4WgboEUNqj90XxJrvwup3WFDUj81SmwwccGGVmmWK1b/FLeuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743690733; c=relaxed/simple;
	bh=vVR4dzjbwximKMFz2GolQ+usgSrCBodydLu3KgERStE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MOXoDMhT/2FvuvJoKM3UWJbwxQOkCLiwjgR0bDufB8rfAS0usVpydeb3f34mJQyfk02XygZxC/0n4m36EjHVXAjbjSGLfy5bcQG9HPwxxfm1rfFZz/n4R7/BT7vz82uvTtsfvREvhSBuefEk/TZQEpvehbtsePHVGu72fzar3UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ak0LtGE7; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4774d68c670so13065661cf.0;
        Thu, 03 Apr 2025 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743690731; x=1744295531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4cM/Hf3taQ82kW/fJqiW37cU3vX6rk2UxXpAJR5iIVQ=;
        b=Ak0LtGE7xBASbInCTu1D7e/P4BQhde5JHbcAgyy5etK6a2oMLHxBooZGnoZTB7ytK2
         cMBfuG2pRRlNnzbExHVI7mLBY3+nh2UOdinHNE13FOmYqqp5dhEUyZMsUsOJgXvAQGLW
         lfuuKTZnR6DIaRI84Rl/6/bGQNelVl/TPSEjhkH49VcDs3uuq4R5OBkS/bnR5N8/7Efu
         r93cWC6Ml6PWcmZTmpGtrb0qFX6BgH+MgZ2phE/DBmYIQo2zbH6VXB1INnTTBYBPDy2d
         RC1jHR3segbex1Or8imL+4HeUUzAdHr3VOfC4wDU7E7HytrujghIWx1tsHudAt9cqIMX
         /IuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743690731; x=1744295531;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4cM/Hf3taQ82kW/fJqiW37cU3vX6rk2UxXpAJR5iIVQ=;
        b=WZLBrN7HvCaxgNr24FgL7KD+rIEqwpbDMNfYDvmXzx4aTmc8icTaM2UR4lB2JrHNpF
         JDQn8wWyPlPNPKZnUPSh+e7QKgBkToahgsZme77b4qlNCOutwuhOxXsR8Q7GGHbPZTZI
         VgxQAR5tWSIZL9KEBFbvJ6Ch6nbwvWy5J6fWVP+yIqY9JYzKYzZr50P4DOHp0HV48n2D
         gqdwgxd6y5zaznLLEEfEsy0b/m/q29hxu02FVK5bfH3lx650QBD+3xLKYr58UggxO7wu
         dK+467WN1hJmZj5cMGFvgd4R1TYDADIEtBwY5/BcBpyckwvpRYibKGm1wMhv+dOO5jsB
         2YkA==
X-Forwarded-Encrypted: i=1; AJvYcCVRpyn2jn3FuWeZsoZ9fc+fsDEVeWo+b/9lPBJAmKxJ24kubk0qx+pyPZ3G0oFk0a3Rjk10z2dw@vger.kernel.org, AJvYcCWRBaGRR8L2BF/7Okap/KqmZokGbIDP0FQsisoyqhWS6rIaNW0jElOWWNfAw75Bt5Rhd+y0vsxPWpE4SI8=@vger.kernel.org, AJvYcCXYKazXa5W07mhpiSJ9zFumUIb21DHhkiHTIvPrxSpHkP2RnB5Z1/VeC+FMMIj/XcywjatzJY0Lpp3VxCjhh/sO@vger.kernel.org
X-Gm-Message-State: AOJu0YyK5Gx8Ajnn7v0Ays88IoxfHvhDLDasbh0SRCyfFGkaPO8rNS8v
	kYPuSXq8x6kiKqhabVHfXOWZzgH6vOpC21ZMiIV7lhDX/YBP1VO+
X-Gm-Gg: ASbGncuVZ+lEqDcU1kpDxEbjMLDHf4eG8iZXLWmhXphAk8qGQ9s1zvbmjmxywNyGPhz
	QnV4ipCzwUMjwnb6MCj7bIhDhbOHUfB0FjDLj6RmoJvaBATNaQbucnvQO5j1m6MlkVvqfenrR7L
	c7jiog1mCP1PdpvWH0I0p4ic9voFWsnvXk9VCJAW0eBywEsBn/oALoVBl0LAIxAMGpL4U5EmoMp
	S4f+yIq9S8wzo23gRFXGuPmr63Wf32UIr5hpaEH0+1PrlVdXvUH3FolpULInIiw0SnY83gfFkAt
	TWNkPeMnzVPytNo0BdxJGHM6p9thHNbFfaWydmUhV1swzmYlJfT3TR+t0Wy/c6tpp4rss3vrfGZ
	Z3pqShvP8m8rYDEZ1pJ2YiA==
X-Google-Smtp-Source: AGHT+IG5js78IwTVCo0mnbgZawwpmTGNCA/TG7sieG+24V1Gv+bkWWNlJPo/KnhB+g6blu3Sxt7EGg==
X-Received: by 2002:ac8:59cf:0:b0:476:a4eb:10a5 with SMTP id d75a77b69052e-4791925bd09mr33748561cf.12.1743690730655;
        Thu, 03 Apr 2025 07:32:10 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c76e734fc8sm83989885a.5.2025.04.03.07.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 07:32:10 -0700 (PDT)
Date: Thu, 03 Apr 2025 10:32:09 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, 
 Jiayuan Chen <mrpre@163.com>, 
 syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Mykola Lysenko <mykolal@fb.com>, 
 Shuah Khan <shuah@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 Jason Xing <kerneljasonxing@gmail.com>, 
 Anton Protopopov <aspsk@isovalent.com>, 
 Abhishek Chauhan <quic_abchauha@quicinc.com>, 
 Jordan Rome <linux@jordanrome.com>, 
 Martin Kelly <martin.kelly@crowdstrike.com>, 
 David Lechner <dlechner@baylibre.com>, 
 LKML <linux-kernel@vger.kernel.org>, 
 Network Development <netdev@vger.kernel.org>, 
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Message-ID: <67ee9be9db59b_138964294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-2-jiayuan.chen@linux.dev>
 <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexei Starovoitov wrote:
> On Sun, Mar 30, 2025 at 8:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> >
> > The device allocates an skb, it additionally allocates a prepad size
> > (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
> > uninitialized.
> >
> > The bpf_xdp_adjust_head function moves skb->data forward, which allow=
s
> > users to access data belonging to other programs, posing a security r=
isk.
> >
> > Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@goog=
le.com/T/
> > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > ---
> >  include/uapi/linux/bpf.h       | 8 +++++---
> >  net/core/filter.c              | 5 ++++-
> >  tools/include/uapi/linux/bpf.h | 6 ++++--
> >  3 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index defa5bb881f4..be01a848cbbf 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2760,8 +2760,9 @@ union bpf_attr {
> >   *
> >   * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
> >   *     Description
> > - *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. =
Note that
> > - *             it is possible to use a negative value for *delta*. T=
his helper
> > + *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. =
Note that
> > + *             it is possible to use a negative value for *delta*. I=
f *delta*
> > + *             is negative, the new header will be memset to zero. T=
his helper
> >   *             can be used to prepare the packet for pushing or popp=
ing
> >   *             headers.
> >   *
> > @@ -2989,7 +2990,8 @@ union bpf_attr {
> >   * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
> >   *     Description
> >   *             Adjust the address pointed by *xdp_md*\ **->data_meta=
** by
> > - *             *delta* (which can be positive or negative). Note tha=
t this
> > + *             *delta* (which can be positive or negative). If *delt=
a* is
> > + *             negative, the new meta will be memset to zero. Note t=
hat this
> >   *             operation modifies the address stored in *xdp_md*\ **=
->data**,
> >   *             so the latter must be loaded only after the helper ha=
s been
> >   *             called.
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 46ae8eb7a03c..5f01d373b719 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff=
 *, xdp, int, offset)
> >         if (metalen)
> >                 memmove(xdp->data_meta + offset,
> >                         xdp->data_meta, metalen);
> > +       if (offset < 0)
> > +               memset(data, 0, -offset);
> >         xdp->data_meta +=3D offset;
> >         xdp->data =3D data;
> >
> > @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff=
 *, xdp, int, offset)
> >                 return -EINVAL;
> >         if (unlikely(xdp_metalen_invalid(metalen)))
> >                 return -EACCES;
> > -
> > +       if (offset < 0)
> > +               memset(meta, 0, -offset);
> =

> Let's make everyone pay a performance penalty to silence
> KMSAN warning?
> =

> I don't think it's a good trade off.
> =

> Soft nack.

I also assumed that this was known when the feature was originally
introduced and left as is for performance reasons.

Might be good to have that explicit. And that it is deemed safe by
virtue of XDP requiring superuser privileges anyway. Or at least I
guess that was the thought process?

