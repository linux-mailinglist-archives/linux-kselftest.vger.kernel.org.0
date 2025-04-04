Return-Path: <linux-kselftest+bounces-30090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388FFA7B52E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 02:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7E821766B2
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Apr 2025 00:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9212080FE;
	Fri,  4 Apr 2025 00:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aC/pEh39"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736BC481B1;
	Fri,  4 Apr 2025 00:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743726580; cv=none; b=Umocuex+nAWbs8YcR3DZFImGFdBFYT2h0pfnum5MgJEKge4LA/wiIsiWYURAm1B7XSmlgN+2j3bUxnhyq0MTWomdT4woik7WNcgIlXw/3jPygl8p222F8zwbID8oGXdSx6/DoBf6R1JJtaW8WHnZaUFVAxNsRP8o5dtlahkXeiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743726580; c=relaxed/simple;
	bh=St89Kwzj3JRQR9Jf8LzwrVl8hl+hk+d3qKXySXoa7Oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fXF+toz8rB0aWu8Y2J0l5cdYqF2Sgi1EzwgPUefnQua0EHW7uvXlyNLj6SPSl/hD1x/hzXZ8OLvXJL/l/9gyhkHIT6BUnieFtk1TaPv7AjlGUjR/WlQkBYKNqRvHbaG0DGZYfFZu7FF24zxkgZkx/0hwmCRyYRdx9MVU67536rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aC/pEh39; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf0d787eeso14448155e9.3;
        Thu, 03 Apr 2025 17:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743726577; x=1744331377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBiB0ezIz2JVyD/2wk2RTNMgtZ0w5Sl/SCYeQbZaMbY=;
        b=aC/pEh39yCrXQQvpOVWvHLphULrtLIZ/7aaxOxwD8loXJjFZeMwXV+wuMq5ZoSPFWT
         uGnKLXhWSjdDfulFLPgZVAHUfG1/p3xcbv7EOpDxxAY1j9ds/UnXJYUysOs+k0cC+jcG
         Ke4Jz9UQkWLwcsbqnx2TmrO1bd39V30GEIyAuBq0otmPOQ3gUks8ZDNR7BWSx7OPe8Yj
         mYtZYtRe+UqhN2yVghadGweT29weuc/G7q+IH2F38h8zK3pWjo6/fk/+aPBmdANmo24m
         Ysv4R78TQ9bO1+8khcAFozzOu2mf1QVPIqQepC2uqfVEkaDpsHK645E3aPiKpIrJF7Vo
         Bgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743726577; x=1744331377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBiB0ezIz2JVyD/2wk2RTNMgtZ0w5Sl/SCYeQbZaMbY=;
        b=EKG0xSjNDLbveqY9oX18//IMGQq7kjJAC6i2NcA7UkKvtTlifoQlIh3xQQ/UYE8PzR
         ZXL9s0bRL0XmpQDrhlsyWpSDMX4ef+4V+Sf4n7eGw/BaMuI4JQy9HtOyRL7D93BMEPeQ
         jA6ZBaaWRdGgf+r/ygQwzkBlBwkiej5GKtUg4PxrhN0aD4N6nOUXbNuUYj1q/yR6UIks
         VFmImNlU29rjXR7eGtK3V61BPsyu+s9c+zOskCY1Z5XAzZJ8JhtRC+Wun0tAYW9Pt0lz
         J9P75FjpCwzZdG0tMENngAAcinmitDWT0MRJ1F2mc7ClZFdYDXMF5CArD50ogmDeZzvE
         eF6w==
X-Forwarded-Encrypted: i=1; AJvYcCVPlzBtGR3r60aPQ2Y7MUS++u+ZzFY1ae+F85sncZv19WCiCx9qHgtNk7AbvNjdnLdM8V3oeMvS@vger.kernel.org, AJvYcCVgpZBBw2Os5Uxie7uFElPaMAXNwwiQniFRh7DIpp7CwNihViD8K9LPjxFaErxeJNBpl5stksCDQiGMBEc=@vger.kernel.org, AJvYcCVsbRXkt8+eJLOoM+qt5JfHEcOTdyxxkJe/l2ZcyU+gTsT37INd5LSYGHf8D7Pg/fVLZiQ9mgDlQ6BdkjhPrYof@vger.kernel.org
X-Gm-Message-State: AOJu0YywqQStL/KvlJedp29rTGUMcnJY9MyKfgu18SF3pkPpyUZi+391
	XTdlkijxr6eUPMmlLSrpc6geTMY/3lB0Ktoa0qO8TMrm+fA3eXZKSCY2o2sFgztK7XapvXtnxc3
	eXACOxuogeNUoiQ4Z9/Bg8T28oeI=
X-Gm-Gg: ASbGnctTNFeydLFNJEiB56J6U+A+vTrDZgwBD0MxyOAuen2oiFx7GSl2p0KFS8s+iZj
	lBN98DC82ozBus2ZR4TkAQ0SqLVz7cBS7X7LgaX+spwXT6k1P9GTiv4J1e309BfTm8RP5UyqJEL
	WS2DevcejhTKs1T9f6w86u/TCKTCU75lqjGihp2DH5Ow==
X-Google-Smtp-Source: AGHT+IH0WO7alMHnSQ600cGoJ30v59cQ6Hcw8+PewC6V/UOaegICbs42GgT4rYHeJpAu+a4G5NWUjAj8q4o9+SjW5AM=
X-Received: by 2002:a5d:59a8:0:b0:391:ba6:c069 with SMTP id
 ffacd0b85a97d-39d0de67a70mr494591f8f.44.1743726576607; Thu, 03 Apr 2025
 17:29:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331032354.75808-1-jiayuan.chen@linux.dev>
 <20250331032354.75808-2-jiayuan.chen@linux.dev> <CAADnVQJ6NPGuY=c8kbpX_nLYq4oOxOBAxbDPFLuw+yr4WrQQOQ@mail.gmail.com>
 <ce4a0aacecb2db7d232e94a324150dc5936c803a@linux.dev>
In-Reply-To: <ce4a0aacecb2db7d232e94a324150dc5936c803a@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 3 Apr 2025 17:29:24 -0700
X-Gm-Features: ATxdqUFDcIjakGnOj7Wmbqm9yQCN56zvn2RS53u99WJJDy-qNI3FZqsVdqVbQ_E
Message-ID: <CAADnVQLH5d7-=8HLL1c+SZ-drgGf2X0aAGSoK-c7=9G-_Dy6+g@mail.gmail.com>
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

On Thu, Apr 3, 2025 at 5:27=E2=80=AFPM Jiayuan Chen <jiayuan.chen@linux.dev=
> wrote:
>
> April 3, 2025 at 22:24, "Alexei Starovoitov" <alexei.starovoitov@gmail.co=
m> wrote:
>
>
>
> >
> > On Sun, Mar 30, 2025 at 8:27 PM Jiayuan Chen <jiayuan.chen@linux.dev> w=
rote:
> >
> > >
> > > The device allocates an skb, it additionally allocates a prepad size
> > >
> > >  (usually equal to NET_SKB_PAD or XDP_PACKET_HEADROOM) but leaves it
> > >
> > >  uninitialized.
> > >
> > >  The bpf_xdp_adjust_head function moves skb->data forward, which allo=
ws
> > >
> > >  users to access data belonging to other programs, posing a security =
risk.
> > >
> > >  Reported-by: syzbot+0e6ddb1ef80986bdfe64@syzkaller.appspotmail.com
> > >
> > >  Closes: https://lore.kernel.org/all/00000000000067f65105edbd295d@goo=
gle.com/T/
> > >
> > >  Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> > >
> > >  ---
> > >
> > >  include/uapi/linux/bpf.h | 8 +++++---
> > >
> > >  net/core/filter.c | 5 ++++-
> > >
> > >  tools/include/uapi/linux/bpf.h | 6 ++++--
> > >
> > >  3 files changed, 13 insertions(+), 6 deletions(-)
> > >
> > >  diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > >
> > >  index defa5bb881f4..be01a848cbbf 100644
> > >
> > >  --- a/include/uapi/linux/bpf.h
> > >
> > >  +++ b/include/uapi/linux/bpf.h
> > >
> > >  @@ -2760,8 +2760,9 @@ union bpf_attr {
> > >
> > >  *
> > >
> > >  * long bpf_xdp_adjust_head(struct xdp_buff *xdp_md, int delta)
> > >
> > >  * Description
> > >
> > >  - * Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> > >
> > >  - * it is possible to use a negative value for *delta*. This helper
> > >
> > >  + * Adjust (move) *xdp_md*\ **->data** by *delta* bytes. Note that
> > >
> > >  + * it is possible to use a negative value for *delta*. If *delta*
> > >
> > >  + * is negative, the new header will be memset to zero. This helper
> > >
> > >  * can be used to prepare the packet for pushing or popping
> > >
> > >  * headers.
> > >
> > >  *
> > >
> > >  @@ -2989,7 +2990,8 @@ union bpf_attr {
> > >
> > >  * long bpf_xdp_adjust_meta(struct xdp_buff *xdp_md, int delta)
> > >
> > >  * Description
> > >
> > >  * Adjust the address pointed by *xdp_md*\ **->data_meta** by
> > >
> > >  - * *delta* (which can be positive or negative). Note that this
> > >
> > >  + * *delta* (which can be positive or negative). If *delta* is
> > >
> > >  + * negative, the new meta will be memset to zero. Note that this
> > >
> > >  * operation modifies the address stored in *xdp_md*\ **->data**,
> > >
> > >  * so the latter must be loaded only after the helper has been
> > >
> > >  * called.
> > >
> > >  diff --git a/net/core/filter.c b/net/core/filter.c
> > >
> > >  index 46ae8eb7a03c..5f01d373b719 100644
> > >
> > >  --- a/net/core/filter.c
> > >
> > >  +++ b/net/core/filter.c
> > >
> > >  @@ -3947,6 +3947,8 @@ BPF_CALL_2(bpf_xdp_adjust_head, struct xdp_buf=
f *, xdp, int, offset)
> > >
> > >  if (metalen)
> > >
> > >  memmove(xdp->data_meta + offset,
> > >
> > >  xdp->data_meta, metalen);
> > >
> > >  + if (offset < 0)
> > >
> > >  + memset(data, 0, -offset);
> > >
> > >  xdp->data_meta +=3D offset;
> > >
> > >  xdp->data =3D data;
> > >
> > >  @@ -4239,7 +4241,8 @@ BPF_CALL_2(bpf_xdp_adjust_meta, struct xdp_buf=
f *, xdp, int, offset)
> > >
> > >  return -EINVAL;
> > >
> > >  if (unlikely(xdp_metalen_invalid(metalen)))
> > >
> > >  return -EACCES;
> > >
> > >  -
> > >
> > >  + if (offset < 0)
> > >
> > >  + memset(meta, 0, -offset);
> > >
> >
> > Let's make everyone pay a performance penalty to silence
> > KMSAN warning?
> > I don't think it's a good trade off.
> > Soft nack.
> >
>
> It's not just about simply suppressing KMSAN warnings, but for security
> considerations.
>
> So I'd like to confirm: currently, loading an XDP program only requires
> CAP_NET_ADMIN and CAP_BPF permissions. If we consider this as a super
> privilege, then even if uninitialized memory is exposed, I think it's oka=
y,
> as it's the developer's responsibility, for example, like the CVE in meta
> https://vuldb.com/?id.246309.

And we fixed Katran. not the kernel.

> Or I'm thinking, can we rely on the verifier to force the initialization
> of the newly added packet boundary behavior, specifically for this specia=
l
> case (although it won't be easy to implement).

