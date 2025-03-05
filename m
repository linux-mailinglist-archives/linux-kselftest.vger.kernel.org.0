Return-Path: <linux-kselftest+bounces-28265-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6256A4F3F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 02:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AF6C3AB3D5
	for <lists+linux-kselftest@lfdr.de>; Wed,  5 Mar 2025 01:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF2814A630;
	Wed,  5 Mar 2025 01:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEmY2HhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BEF1459F6
	for <linux-kselftest@vger.kernel.org>; Wed,  5 Mar 2025 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741138793; cv=none; b=K0GdzlGMBcI2cB1xiC4qCEiZwOT4Ds47ereyHooWmBFjJWLteOpmqYYARrJKDFdg/RzztVMgprwWCDxAviv+iMSnKQifpkO9LVaR0ejYjQW3tSZGDcuxt0sJ2vaa9YJyEDrdvEcgpAhGCuPvy1oJcqtwvBjCeh+fGJuOJrkEoIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741138793; c=relaxed/simple;
	bh=dqWsSzrccmVHnLHCLmkQRVxxeSfQIVPPMj9Ba8t5jOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gM7a3a4rP0opYAYefpOoihoqnEONA5395gFW3M66G4DtusCcf6xJCaDFgnacp8fBWk0qgnM7lxLQ0LMo3OsHvwTO1XCJIyiymMQe8c68yp2tlk56DsQLvJBghu08ixZxDbcXwPPA5FaXQrrp3nE98MGewBOb60j/2ArrSaOkGro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEmY2HhO; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2237a32c03aso43645ad.1
        for <linux-kselftest@vger.kernel.org>; Tue, 04 Mar 2025 17:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741138791; x=1741743591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fA2KYQHik2cIQjoxJaa3twCTPuvqgtb1JUSNyfAxYc=;
        b=KEmY2HhOS8mF2KDj8S398zL/v1r7A/0pFXXbr7COg5sO4riLlxI+m9l5LS63Xw5H0z
         DFtXfHaP8JmFmct3QWE4c+tNRkETsrVr3cSXac1HnQz8L1vhBD5r2C1g6CdahfZv/RnG
         fhuH3+R35Ks7+4UXylW1Fhn6EHMFOQtsksGyM57fwxCd3nwTobKe3uXRWUGaza7HaWNs
         LBjL2DV26rHB0+ouRAVVz+OZGdnNh4icMh0dqTL8daa2+0a7J+eJzjUvZ2hx4MeNAIU2
         f0QXmHMg8PpJC5IzwjgfQl5yBkwcTnKYkGg6y43zvO0zGHNByYsznxQdNvmXY9gjdc3J
         QtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741138791; x=1741743591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fA2KYQHik2cIQjoxJaa3twCTPuvqgtb1JUSNyfAxYc=;
        b=Sdh+cH+SuQpR5CQXIxLpeShfSe4xrnZg+uXfVhF/BQ10098RBlQsyMZf9QIMXokhzz
         93Go/UM5fq/y5TFwQfZXz//03T7XZGaxJJV1znkPsaWywKfVN/WzBtj7TQepARU4lyw1
         /CXzWmu4ztf6J3C8nUTJHPM7frCe06+egWmnQ4PNxTjvUoYmjz0rNP66Cz+VS5347VgB
         HEj2A1L9rY6jO0+Btp6D6z6KJy9EqOhtlwPn6ncvvGzIqpNKBk6aWHHbkkXK5QlqrJ+N
         v/g/4JmUtOiMo1oo3WqAfUUmqfye/N/ZU522941M//o5A/XMFnstIlPjyibYg4zYaKo+
         EiTA==
X-Forwarded-Encrypted: i=1; AJvYcCW7QV2cpQOGgGv8KTErhiP5jGim1+TJalIEAagK99QV6jl+IgZ2xql9hWlAztll/A8IWfuN0DFIUl0haIVfIKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe569TzMFPweEiYzLK5SBFTO++Oy/B9O0IESYaZsFTp3mW9s+I
	dLhC4nkmmpiGSzb9+USG2IzWG6Aa2FdDQwGGIu8gBvBfW2ImFZghCgW4RJuzFoni4VgUJrZ5vr9
	sbgHX9o2fhxy4pF3Q2hkbwcIthVKfX8nY4Aqt
X-Gm-Gg: ASbGnctxXUHetk3tpCVkC33bZ/Bc/ZPt8XuCOp22Mb9hEATztHr9zEmiLLF5OjzeZH2
	rUvYfYzf6m0vVFcnForyH9l6DKSnHa1H6c1aprwDPHmhappmdGSs5FELSWi7F3WQdnJ/eB5x4qq
	FM+57EIyAlMRHlQ60j/ZKWyqdlDsvGhqG5vl3OsrAcJCloDa9Jqpiwz0Xo
X-Google-Smtp-Source: AGHT+IH5gXmkQSdJDrmvDbhcX1gVqatKumUNqefxFocuBrCcwtKWp6uWzxr+bTikNvWZpTgRK27RGaHlzULM/jBATGw=
X-Received: by 2002:a17:903:494:b0:216:2839:145 with SMTP id
 d9443c01a7336-223f44abcf5mr798995ad.1.1741138790491; Tue, 04 Mar 2025
 17:39:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com> <20250228163846.0a59fb40@kernel.org>
 <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com> <20250303162051.09ad684e@kernel.org>
In-Reply-To: <20250303162051.09ad684e@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 4 Mar 2025 17:39:37 -0800
X-Gm-Features: AQ5f1JokmBfu9vApWvP6OeSWBJnA3SLQMcYEIWf9RLvx2TEKaGIWTz1vBTgX4iM
Message-ID: <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 4:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 28 Feb 2025 17:29:13 -0800 Mina Almasry wrote:
> > On Fri, Feb 28, 2025 at 4:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Thu, 27 Feb 2025 04:12:02 +0000 Mina Almasry wrote:
> > > >  static inline void __skb_frag_ref(skb_frag_t *frag)
> > > >  {
> > > > -     get_page(skb_frag_page(frag));
> > > > +     get_netmem(skb_frag_netmem(frag));
> > > >  }
> > >
> > > Silently handling types of memory the caller may not be expecting
> > > always worries me.
> >
> > Sorry, I'm not following. What caller is not expecting netmem?
> > Here we're making sure __skb_frag_ref() handles netmem correctly,
> > i.e. we were not expecting netmem here before, and after this patch
> > we'll handle it correctly.
> >
> > > Why do we need this?
> > >
> >
> > The MSG_ZEROCOPY TX path takes a page reference on the passed memory
> > in zerocopy_fill_skb_from_iter() that kfree_skb() later drops when the
> > skb is sent. We need an equivalent for netmem, which only supports pp
> > refs today. This is my attempt at implementing a page_ref equivalent
> > to net_iov and generic netmem.
> >
> > I think __skb_frag_[un]ref is used elsewhere in the TX path too,
> > tcp_mtu_probe for example calls skb_frag_ref eventually.
>
> Any such caller must be inspected to make sure it generates
> / anticipates skbs with appropriate pp_recycle and readable settings.
> It's possible that adding a set of _netmem APIs would be too much
> churn, but if it's not - it'd make it clear which parts of the kernel
> we have inspected.
>

I see, you're concerned about interactions between skb->pp_recycle and
skb->unreadable. My strategy to handle this is to take what works for
pages, and extend it as carefully as possible to unreadable
net_iovs/skbs. Abstractly speaking, I think skb_frag_ref/unref should
be able to obtain/drop a ref on a frag regardless of what the
underlying memory type is.

Currently __skb_frag_ref() obtains a page ref regardless of
skb->pp_recycle setting, and skb_page_unref() drops a page_ref if
!skb->pp_recycle and a pp ref if skb->pp_recycle. I extend the logic
so that it applies as-is to net_iovs and unreadable skbs.

After this patch, __skb_frag_ref() obtains a 'page ref equivalent' on
the net_iov regardless of the pp_recycle setting. My conjecture is
that since that works for pages, it should also work for net_iovs.

Also after this patch, skb_page_unref will drop a pp ref on the
net_iov if skb->pp_recycle is set, and drop a 'page ref equivalent' on
the net_iov if !skb->pp_recycle. The conjecture again is that since
that works for pages, it should extend to net_iovs.

With regards to the callers, my thinking is that since we preserved
the semantics of __skb_frag_ref and skb_page_unref (and so
skb_frag_ref/skb_frag_unref by extension), then all existing callers
of skb_frag_[un]ref should work as is. Here is some code analysis of
individual callers:

1. skb_release_data
      __skb_frag_unref
        skb_page_unref

This code path expects to drop a pp_ref if skb->pp_recycle, and drop a
page ref if !skb->pp_recycle. We make sure to do this regardless if
the skb is actually filled with net_iovs or pages, and the conjecture
is that since the logic to acquire/drop a pp=3Dpage ref works for pages,
it should work for the net_iovs as well.

2. __skb_zcopy_downgrade_managed
      skb_frag_ref

Same thing here, since this code expects to get a page ref on the
frag, we obtain the net_iov equivalent of a page_ref and that should
work as well for net_iovs as pages. I could look at more callers, but
the general thinking is the same. Am I off the rails here?

Of course, we could leave skb_frag_[un]ref as-is and create an
skb_frag_[un]ref_netmem which support net_iovs, but my ambition here
was to make skb_frag_[un]ref itself support netmem rather than fork
the frag refcounting - if it seems like a good idea?

> > > In general, I'm surprised by the lack of bug reports for devmem.
> >
> > I guess we did a good job making sure we don't regress the page paths.
>
> :)
>
> > The lack of support in any driver that qemu will run is an issue. I
> > wonder if also the fact that devmem needs some setup is also an issue.
> > We need headersplit enabled, udmabuf created, netlink API bound, and
> > then a connection referring to created and we don't support loopback.
> > I think maybe it all may make it difficult for syzbot to repro. I've
> > had it on my todo list to investigate this more.
> >
> > > Can you think of any way we could expose this more to syzbot?
> > > First thing that comes to mind is a simple hack in netdevsim,
> > > to make it insert a netmem handle (allocated locally, not a real
> > > memory provider), every N packets (controllable via debugfs).
> > > Would that work?
> >
> > Yes, great idea. I don't see why it wouldn't work.
> >
> > We don't expect mixing of net_iovs and pages in the same skb, but
> > netdevsim could create one net_iov skb every N skbs.
> >
> > I guess I'm not totally sure something is discoverable to syzbot. Is a
> > netdevsim hack toggleable via a debugfs sufficient for syzbot? I'll
> > investigate and ask.
>
> Yeah, my unreliable memory is that syzbot has a mixed record discovering
> problems with debugfs. If you could ask Dmitry for advice that'd be
> ideal.

Yes, I took a look here and discussed with Willem. Long story short is
that syzbot support is possible but with a handful of changes. We'll
look into that.

Long story long, for syzbot support I don't think netdevsim itself
will be useful. Its our understanding so far that syzbot doesn't do
anything special with netdevsim. We'll need to add queue
API/page_pool/unreadable netmem support to one of the drivers qemu
(syzbot) uses, and that should get syzbot fuzzing the control plane.

To get syzbot to fuzz the data plane, I think we need to set up a
special syzbot instance which configures udmabuf/rss/flow
steering/netlink binding and start injecting packets through the data
path. Syzbot would not discover a working config on its own. I'm told
it's rare to set up specialized syzbot instances but we could sell
that this coverage is important enough.

Hacking netdevsim like you suggested would be useful as well, but
outside of syzbot, AFAICT so far. We can run existing netdevsim data
path tests with netdevsim in 'unreadable netmem mode' and see if it
can reproduce issues. Although I'm not sure how to integrate that with
continuous testing yet.

--
Thanks,
Mina

