Return-Path: <linux-kselftest+bounces-26817-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6118A38F9C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 00:28:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929583A47AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Feb 2025 23:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B4E1B0406;
	Mon, 17 Feb 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LecC7O2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A191ABEC1
	for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 23:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739834795; cv=none; b=OpJNER1bY3FsNEwxnLahRSmXUqat8JKaSWTN8Yab40Ja0lIgoK56r8iBqEfknNkCCiU9o0vxXNdNHRwlhzfwRkvpC7oZdVdf3D8l+h61bXaOspKZLCzoQBT+rQxfoEGukumzfCtsVMXfh3nmBnH6htUsopL/kFP37mACNMnvWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739834795; c=relaxed/simple;
	bh=e15tfvqLJ167hVdakQyut1lmoKwKCOmcthYLadFB7bA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aL7to+04jNjB5XjbCssVIh2RDoduiukDpNkcGbhKELvkvv9nPuTFDWRWasChRC69be3odLRyyfFqVZXps2aHRfBNv10A6QFPrHFzaU8/ci50YaFHlGw8gJ7DHKtGoMqJ6zEwpY2tnrYr1KpDT5na0DmnLO8uzaMzpr2wJlc5oYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LecC7O2I; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f6ca9a81so337365ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 17 Feb 2025 15:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739834792; x=1740439592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LU4/0cDqZHRnh9CiIVcjoIP2zXEWwJkeElU0iysFgw0=;
        b=LecC7O2IieFQoAYBg7q/bbm5Dy8Tb67Zf5OXCXsND+sGb24jFjPKVJehv79GmtUBCk
         L0awW9D6t0PYQ9ainmgI1/Gz34G+gCoORp4QpxlthVPeZcVd+eHU3ijayJZqu4jq3zho
         sqaR9rfFIb1OZXguKLwG89M8uNipG5ZLKGCzLvLiy2By+ndjNu3dcZhu65MlUdQ8pM6s
         3m/t3Czq82etZ/5OYPaGfcu+moububa7vRhBK5YIfVLscHj8GAUGZLhnW3n39mBCQJ5Y
         6rMIejebtmVDC37PJPqJD3n0RzYopOytrsmp73hPIYBA64EEfcMqooM/WNu9GztLw2Pq
         8d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739834792; x=1740439592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LU4/0cDqZHRnh9CiIVcjoIP2zXEWwJkeElU0iysFgw0=;
        b=NsSq/564tjJR/vNih8+veXqziP+R316Kn3hGvUAF2U9A/tBNmW2lMElxdcViwCyiXM
         zr5U+l5h3jzInm5ieEIaWvkhvvxf/SAb/c1H+b1OvXDR8sbxnuBJJijwKEPk4Fpr9iDS
         R+OejKIEXbyP+9m4oFLFbkdSpks5nIhSUa+Hy204NowYppgRP1/qUxKgxelN2K+qL85L
         bgtcmNHc8i+jUb9sUMCQNEWMO2JMJOTTljgMqgAeukXPszUAaVEgC/0pGU2lN/4LYq4x
         H/7lMebQ0U5ELhQWuC0BoN0+X9JTxDEUq+NgrM4FviTbXsm5Q8TASik91iDCg/wDQ6Gj
         92eA==
X-Forwarded-Encrypted: i=1; AJvYcCWyPlaihP5LReYTsnDb1UIvDotvgXk4vzdQWHAt4EDaXZ4m6OowztpNXPCOY+0MPqyLpRFSWWoJVWAfRA5p2x8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvVgBXU5WMVtsaMegYYFBOfn7Nt7pgFOUcvoH//J7mGMnoOcG4
	nCTBmoFDwIwPLA2VI1sRHb0rd9D2yjz3XtcDeYe3155k0a/wL09i4JSMh+15eMkbYkGtIs15T5f
	fSP///rsRKyvIvWGlPWiYsZtdvczQgq76QfbT
X-Gm-Gg: ASbGncu94Rsy1PdcF9X82aXC0P2J5I/BZqT/LmrUliLbTc45LgCrgiDCt7bDFROM/Id
	VXmfbg58aFMQB70NN3N5H311qh2CYKh8BWxHUS3abFMMcgEm9u2FMrMEwYxWs+lU0AXy/FYl6
X-Google-Smtp-Source: AGHT+IEz2Vjx4sspzRYyerWy/4H+lWv6VlJ3XI4nEpHd7psvEF5u3oZI0j4vbRhndLp+h57tbEMfk5dYT2aH2zu++aE=
X-Received: by 2002:a17:903:1cc:b0:21f:40e8:6398 with SMTP id
 d9443c01a7336-22104cf7bf5mr4662555ad.26.1739834791554; Mon, 17 Feb 2025
 15:26:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250203223916.1064540-1-almasrymina@google.com>
 <20250203223916.1064540-6-almasrymina@google.com> <abc22620-d509-4b12-80ac-0c36b08b36d9@gmail.com>
 <CAHS8izNOqaFe_40gFh09vdBz6-deWdeGu9Aky-e7E+Wu2qtfdw@mail.gmail.com>
 <28343e83-6d93-4002-a691-f8273d4d24a8@gmail.com> <CAHS8izOE-JzMszieHEXtYBs7_6D-ngVx2kJyMwp8eCWLK-c0cQ@mail.gmail.com>
 <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com>
In-Reply-To: <9210a12c-9adb-46ba-b92c-90fd07e1980f@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 17 Feb 2025 15:26:17 -0800
X-Gm-Features: AWEUYZkNcuzch3JnUQ41m7NwTl507Jdryfd99v6tS9trGnS4pxPErojvBtyR8mY
Message-ID: <CAHS8izPHtk5x-W05_svxU53X-V4+++PiYErCgfr-3iDGgEaUig@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/6] net: devmem: Implement TX path
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Neal Cardwell <ncardwell@google.com>, 
	David Ahern <dsahern@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:17=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 2/12/25 19:18, Mina Almasry wrote:
> > On Wed, Feb 12, 2025 at 7:52=E2=80=AFAM Pavel Begunkov <asml.silence@gm=
ail.com> wrote:
> >>
> >> On 2/10/25 21:09, Mina Almasry wrote:
> >>> On Wed, Feb 5, 2025 at 4:20=E2=80=AFAM Pavel Begunkov <asml.silence@g=
mail.com> wrote:
> >>>>
> >>>> On 2/3/25 22:39, Mina Almasry wrote:
> >>>> ...
> >>>>> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> >>>>> index bb2b751d274a..3ff8f568c382 100644
> >>>>> --- a/include/linux/skbuff.h
> >>>>> +++ b/include/linux/skbuff.h
> >>>>> @@ -1711,9 +1711,12 @@ struct ubuf_info *msg_zerocopy_realloc(struc=
t sock *sk, size_t size,
> >>>> ...
> >>>>>     int zerocopy_fill_skb_from_iter(struct sk_buff *skb,
> >>>>>                                 struct iov_iter *from, size_t lengt=
h);
> >>>>> @@ -1721,12 +1724,14 @@ int zerocopy_fill_skb_from_iter(struct sk_b=
uff *skb,
> >>>>>     static inline int skb_zerocopy_iter_dgram(struct sk_buff *skb,
> >>>>>                                           struct msghdr *msg, int l=
en)
> >>>>>     {
> >>>>> -     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_i=
ter, len);
> >>>>> +     return __zerocopy_sg_from_iter(msg, skb->sk, skb, &msg->msg_i=
ter, len,
> >>>>> +                                    NULL);
> >>>>
> >>>> Instead of propagating it all the way down and carving a new path, w=
hy
> >>>> not reuse the existing infra? You already hook into where ubuf is
> >>>> allocated, you can stash the binding in there. And
> >>>
> >>> It looks like it's not possible to increase the side of ubuf_info at
> >>> all, otherwise the BUILD_BUG_ON in msg_zerocopy_alloc() fires.
> >>>
> >>> It's asserting that sizeof(ubuf_info_msgzc) <=3D sizeof(skb->cb), and
> >>> I'm guessing increasing skb->cb size is not really the way to go.
> >>>
> >>> What I may be able to do here is stash the binding somewhere in
> >>> ubuf_info_msgzc via union with fields we don't need for devmem, and/o=
r
> >>
> >> It doesn't need to account the memory against the user, and you
> >> actually don't want that because dmabuf should take care of that.
> >> So, it should be fine to reuse ->mmp.
> >>
> >> It's also not a real sk_buff, so maybe maintainers wouldn't mind
> >> reusing some more space out of it, if that would even be needed.
> >>
> >
> > netmem skb are real sk_buff, with the modification that frags are not
>
> We were discussing ubuf_info allocation, take a look at
> msg_zerocopy_alloc(), it has nothing to do with netmems and all that.
>

Yes. My response was regarding the suggestion that we can use space in
devmem skbs however we want though.

> > readable, only in the case that the netmem is unreadable. I would not
> > approve of considering netmem/devmem skbs "not real skbs", and start
> > messing with the semantics of skb fields for devmem skbs, and having
> > to start adding skb_is_devmem() checks through all code in the skb
> > handlers that touch the fields being overwritten in the devmem case.
> > No, I don't think we can re-use random fields in the skb for devmem.
> >
> >>> stashing the binding in ubuf_info_ops (very hacky). Neither approach
> >>> seems ideal, but the former may work and may be cleaner.
> >>>
> >>> I'll take a deeper look here. I had looked before and concluded that
> >>> we're piggybacking devmem TX on MSG_ZEROCOPY path, because we need
> >>> almost all of the functionality there (no copying, send complete
> >>> notifications, etc), with one minor change in the skb filling. I had
> >>> concluded that if MSG_ZEROCOPY was never updated to use the existing
> >>> infra, then it's appropriate for devmem TX piggybacking on top of it
> >>
> >> MSG_ZEROCOPY does use the common infra, i.e. passing ubuf_info,
> >> but doesn't need ->sg_from_iter as zerocopy_fill_skb_from_iter()
> >> and it's what was there first.
> >>
> >
> > But MSG_ZEROCOPY doesn't set msg->msg_ubuf. And not setting
> > msg->msg_ubuf fails to trigger msg->sg_from_iter altogether.
> >
> > And also currently sg_from_iter isn't set up to take in a ubuf_info.
> > We'd need that if we stash the binding in the ubuf_info.
>
> https://github.com/isilence/linux.git sg-iter-ops
>
> I have old patches for all of that, they even rebased cleanly. That
> should do it for you, and I need to send then regardless of devmem.
>
>

These patches help a bit, but do not make any meaningful dent in
addressing the concern I have in the earlier emails.

The concern is that we're piggybacking devmem TX on MSG_ZEROCOPY, and
currently the MSG_ZEROCOPY code carefully avoids any code paths
setting msg->[sg_from_iter|msg_ubuf].

If we want devmem to reuse both the MSG_ZEROCOPY mechanisms and the
msg->[sg_from_iter|ubuf_info] mechanism, I have to dissect the
MSG_ZEROCOPY code carefully so that it works with and without
setting msg->[ubuf_info|msg->sg_from_iter]. Having gone through this
rabbit hole so far I see that it complicates the implementation and
adds more checks to the fast MSG_ZEROCOPY paths.

The complication could be worth it if there was some upside, but I
don't see one tbh. Passing the binding down to
zerocopy_fill_skb_from_devmem seems like a better approach to my eye
so far

I'm afraid I'm going to table this for now. If there is overwhelming
consensus that msg->sg_from_iter is the right approach here I will
revisit, but it seems to me to complicate code without a significant
upside.


--
Thanks,
Mina

