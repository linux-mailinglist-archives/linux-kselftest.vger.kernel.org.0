Return-Path: <linux-kselftest+bounces-30089-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C9A7B532
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 02:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7705188F948
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068191F55FB;
	Fri,  4 Apr 2025 00:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEh9Wm9G"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232B207A2B;
	Fri,  4 Apr 2025 00:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743726506; cv=none; b=YSrhefHsyA0PutXj3SNdVFNqk0NcrHEefST0sjhrwpdN1QXipAL7rfpYeQtvRrdxG5CW+mr7pWcG3jVeTHmCbeOOhBm1aQmSH7043ZLTwF3r3MU7GIplJQDvMjqoJk3oKvKfOHS071B7cwSpGdLDS2ECEmnZ4LuFiiY9xuw4/38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743726506; c=relaxed/simple;
	bh=uHAFIXvSqhdI1aB49w+rPPMjSqQgJtlh0O+dhLWVhPs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gKxsbw3OKIjn+sGPZsq74S1qv8jWhApxyp3C9Pm6DmVhJWFpuVkeHnLf/7iE5YKkATkq1853g9MYvU6YIPIdHoDwunhUHJRCI/a2p1+KNPbvHcSy8UdgbK2OO1ecW4yGPy/cdLGhnNG9rVKK0eR9desXnz2yKgTQsNamVXAmvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEh9Wm9G; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso7184705e9.3;
        Thu, 03 Apr 2025 17:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743726503; x=1744331303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsJalMCnIbyYUDREZzETsh7CC8zJvSaK1Doibamq2oQ=;
        b=QEh9Wm9Gr+IivDGinfMU4abquaya6qSQxZ0dOrObpwbQvgbjpfaIgcvBnicHbWQTlq
         6VfFn9i9St2WXreCliH8jFQGlpy+oq0+F+2kDAsgsfrOwWRlpwZlR90srAPTFxrv3LA4
         LA1NWoOWRR76nZwAEB/1sGKwF6WyhdNMjJCOU+ETyXv62ht4dAHatXIyBUlh0pcq8jf+
         UeL1U0oxpACK/gFq9SJxwpP1ajWXSyy3XMEtAOsTcQdZiExrl/VKDsNtNyjHa1evNS54
         4GY1uTvHzIvspgNFFbIhs0Z+oxtNqLRDY+5yzPRKcI76tZV0CgEbK1/GkrAjS2YZn9IE
         n96w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743726503; x=1744331303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsJalMCnIbyYUDREZzETsh7CC8zJvSaK1Doibamq2oQ=;
        b=PFEp/VwAGDph2+sG6gRpGWadTTguBzqIaD40r8VO0zywTmXRhMJJ/oVCbFm/zzVusx
         OEQjSe83Q/T0MILw8K7hkRleMUpOhcuYvgZviIRy5YMEiHOioY5m/hHvXJEb/d2NRcfH
         v7D+SJYCBPUHUuSl9m6/8J/AWnH9PYkSl3vF6mD23Vh20CYQkla7Xj1ZHm97JEVm3T1Z
         PU9k+g6pm9WRDf8Wa/M4vQz8UM+DsX/ksqPo1DkWf2AbtOsLH5vowlzrqHP9mtkjDbS+
         cYA5nPzwW4182wMfTwk2pTlbMI2I/Knhx++hm3LleON0E7uTrRg53G1gxVkXqYBEbqwX
         rIrA==
X-Forwarded-Encrypted: i=1; AJvYcCV+l7UNX10WBfoVumIYyPvtj777X2zHWXPma1ob3nNPSyz1YfUf4zSuXQX/eRh7l9XadWIvkBla@vger.kernel.org, AJvYcCX/gPSBUzCCsz4ec8q9alS2BzeWqPiZcDiI+x5bnBBqyrHgGyECTLyKeUAJtCAdkpBc/ann09gvlnc8rSCG@vger.kernel.org, AJvYcCXAg7GLT2X3ZrBkG8frTkMDZWFRLlYohVPWOfREs4nK2YIP3WQ/t8gARe4IgWWNrScPfTE=@vger.kernel.org, AJvYcCXFZG2chuTpHGSESR54W69vIcC2elLOS2X8BRsg6HnUp0f2sKbD3QOp/qJWwLvPpxz91G7TVeeBaTAckWVfZodp@vger.kernel.org
X-Gm-Message-State: AOJu0YxcrGw9aHEiayIjtCf4gRjf1YaVdyI6Gkqr4aFDcADJRPT11Hz2
	pS3ajvs6KavzLlMZvyqrfCJ1j+GfDwHxjl5+wA30HsQaRrAsLcm7EmyA4Xy6gVpeF42uOFRABXG
	8maX7X+Kx1czVa4uB+td8iNy3N3k=
X-Gm-Gg: ASbGncsQusFezepox3/ReFflnXnQQ9wkXmO31GpPa8BH1LFhZo3JIomiSkXp5NHBi4p
	vj0MXGAPbPTk0PM/7b4SA9+d1vW0PU2riFEjyZj9yXihkv6o2LAyaXpMwalnbB7iQJnjjUk656x
	SiOUajNedxAbdVw+DL52ZbYjyP/Pl1rJjLXv169bVfHA==
X-Google-Smtp-Source: AGHT+IF4jOHMVxLKwpyTVp4jJNRqM1SWPpZtFvlb0mCP/+k22RUzCUAv49nijPp+o+h12sypmv2fV/5Qr071bYNrMQg=
X-Received: by 2002:a05:600c:3596:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-43ed0db3b83mr4248275e9.27.1743726502822; Thu, 03 Apr 2025
 17:28:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-2-jiayuan.chen@linux.dev> <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
 <67ee9be9db59b_138964294b7@willemb.c.googlers.com.notmuch>
In-Reply-To: <67ee9be9db59b_138964294b7@willemb.c.googlers.com.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 17:28:11 -0700
X-Gm-Features: ATxdqUHpKf8yEtqfLl0IozrpSVSxJWlHaoXuUysIiRdjG68X57Hqbi5k8WYXjAc
Message-ID: <CAADnVQK_8-3mpQMptGCdgZv71okKT6haZ0Wrw+fUoWV3kif9DA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf, xdp: clean head/meta when expanding it
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Jiayuan Chen <mrpre@163.com>, syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com, 
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

On Thu, Apr 3, 2025 at 7:32=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Alexei Starovoitov wrote:
> > On Sun, Mar 30, 2025 at 8:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linu=
x.dev> wrote:
> > >
> > > The device allocates an skb, it additionally allocates a prepad size
> > > (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
> > > uninitialized.
> > >
> > > The bpf_xdp_adjust_head function moves skb->data forward, which allow=
s
> > > users to access data belonging to other programs, posing a security r=
isk.
> > >
> > > Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> > > Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@goog=
le.com/T/
> > > Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > > ---
> > >  include/uapi/linux/bpf.h       | 8 +++++---
> > >  net/core/filter.c              | 5 ++++-
> > >  tools/include/uapi/linux/bpf.h | 6 ++++--
> > >  3 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > > index defa5bb881f4..be01a848cbbf 100644
> > > --- a/include/uapi/linux/bpf.h
> > > +++ b/include/uapi/linux/bpf.h
> > > @@ -2760,8 +2760,9 @@ union bpf_attr {
> > >   *
> > >   * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
> > >   *     Description
> > > - *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. =
Note that
> > > - *             it is possible to use a negative value for *delta*. T=
his helper
> > > + *             Adjust (move) *xdp_md*\ **->data** by *delta* bytes. =
Note that
> > > + *             it is possible to use a negative value for *delta*. I=
f *delta*
> > > + *             is negative, the new header will be memset to zero. T=
his helper
> > >   *             can be used to prepare the packet for pushing or popp=
ing
> > >   *             headers.
> > >   *
> > > @@ -2989,7 +2990,8 @@ union bpf_attr {
> > >   * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
> > >   *     Description
> > >   *             Adjust the address pointed by *xdp_md*\ **->data_meta=
** by
> > > - *             *delta* (which can be positive or negative). Note tha=
t this
> > > + *             *delta* (which can be positive or negative). If *delt=
a* is
> > > + *             negative, the new meta will be memset to zero. Note t=
hat this
> > >   *             operation modifies the address stored in *xdp_md*\ **=
->data**,
> > >   *             so the latter must be loaded only after the helper ha=
s been
> > >   *             called.
> > > diff --git a/net/core/filter.c b/net/core/filter.c
> > > index 46ae8eb7a03c..5f01d373b719 100644
> > > --- a/net/core/filter.c
> > > +++ b/net/core/filter.c
> > > @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buff=
 *, xdp, int, offset)
> > >         if (metalen)
> > >                 memmove(xdp->data_meta + offset,
> > >                         xdp->data_meta, metalen);
> > > +       if (offset < 0)
> > > +               memset(data, 0, -offset);
> > >         xdp->data_meta +=3D offset;
> > >         xdp->data =3D data;
> > >
> > > @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buff=
 *, xdp, int, offset)
> > >                 return -EINVAL;
> > >         if (unlikely(xdp_metalen_invalid(metalen)))
> > >                 return -EACCES;
> > > -
> > > +       if (offset < 0)
> > > +               memset(meta, 0, -offset);
> >
> > Let's make everyone pay a performance penalty to silence
> > KMSAN warning?
> >
> > I don't think it's a good trade off.
> >
> > Soft nack.
>
> I also assumed that this was known when the feature was originally
> introduced and left as is for performance reasons.
>
> Might be good to have that explicit. And that it is deemed safe by
> virtue of XDP requiring superuser privileges anyway. Or at least I
> guess that was the thought process?

Correct. When prog extends the headroom it is suppose to write
something in there. Extending the packet just to capture
some garbage bytes from the previous packet is dumb,
but doesn't compromise the safety of the kernel.
There were proposals to ask the verifier to track that the headroom
is actually initialized by the program, but it's pointless.
Dumb prog can write garbage in there just as well.
bpf_probe_read_kernel( from_random_addr) and store into the headroom.

