Return-Path: <linux-kselftest+bounces-28444-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE6AA55ADA
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Mar 2025 00:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 291BB18916B5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Mar 2025 23:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9727811E;
	Thu,  6 Mar 2025 23:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IHuZa2Y3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C849417B50B;
	Thu,  6 Mar 2025 23:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741303353; cv=none; b=fHzmdrpwjIk8x7GEDkrbumtt2m4AaKaC3ftpPK45vQd2iWB2MGGXLZ/Js4ELKxgQbeH6DELsa7JWE91gkHujkJZGI+FvauC3qMtrCJ3kmqzoBZF/y0RqWkUoxo5jFkm6kGn8L7GoD1eJQlEwaGkxShN0EFXxdYH4icvsy8kK+8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741303353; c=relaxed/simple;
	bh=FQKwi2RpsEPtPJYNKOqwYo3KLh9T8f/v/uynBA7Sowk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=T6jeyWhRFiJv8e6MS3GhIQofpjhvfManqlcxRpL0JPCSx8tgajIXBIhITKoxL8JD4Gy0eV2JIaCUQy67WYkXOQ95hckdoJpnOosvpDn+PGY5I0ezx9EhzWcrIJyMJhichDQZdF8uaBkNIuYEnLIWDTIuTRGAwxWnQqGVMMWBwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IHuZa2Y3; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e8f05acc13so12042266d6.2;
        Thu, 06 Mar 2025 15:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741303350; x=1741908150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Twj0Fw1nbiazziIk6/g3nWgynDdti7bN7lR1cuE/+CU=;
        b=IHuZa2Y351MuyxlvaHyNnbYiM3OtYHPSY++nZffaQE2jh1B+dNEOrJBm5HNDYwzowB
         4/yzRsTB88popLlrnTjEMjPvnwtOPWmBwFy4GMfXItGiVE6EcyoF4gMVn3BhB2Z8VUgX
         uff0LEyo5zcknPaKFBV76eXNRzzCZAPltOyEm1R+WmPcpl7wi+7XF1vCp808eQ3HC+/Y
         Wuali/nM197m2HwvxehtapJmggpweG/1paOE3+18p+OEhtoe4bYnINlcu0Dvb95Ncp9A
         xBzQv9am2BhINvqUv/RmsJvIxzITCKo53SYsHwWFVgOXprQ0DpeUvlZ0AdezUUJC0b6J
         HOmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741303350; x=1741908150;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Twj0Fw1nbiazziIk6/g3nWgynDdti7bN7lR1cuE/+CU=;
        b=t092fmD0RHD02l8AXgd4pgj7Us9GEKU6cE+8HCAmCrbQHwuz/lUm64U64bzoY2k/6J
         I6NtwyREBRLt5TnRtBhCeTkgZLbpSiZuPvlEYPuUxLeJ9mVXGQMiaexsU9GQRb6E9f40
         bd0BAMlnGV5wUrOjszQ4NzHUWOlU4upzxH8FESnmM0qtSCCPCYd/uMrC2ET6DLowPuQn
         aW2NqMd6v8RBV+Liy3OFNDPDJe/WkdijlVHixETAjwtv5Zbi7ydE+WnmPpFz3qGEp74G
         kfEAFfvHPO+CRyZqzawJdUz2xFnMgrEu2M6vN9uFtuJr/+FBChvRMN5XJXCampANhhET
         Ho1A==
X-Forwarded-Encrypted: i=1; AJvYcCWDQrR5LTtVvRyIXrqOupBC91GhxJkOYy1s+9Z072isZIwOfhiBPz56n3vidD/C2ValnaVVm6JYHmH3+dg526XD@vger.kernel.org, AJvYcCWHjfIjT3KOwMWhqTulD8xrRbCLwMvuF9771bCpHr28p9aglhgzOu+G1q3GpCv2Dh9K+rM=@vger.kernel.org, AJvYcCWVwZnrB1MTF86wq67R6yoFiEeyzza0NO9mJJCCqJQgzRtpxn/v0ILyqJSF2uzMrOevut/jqvapHoyRhrrE@vger.kernel.org, AJvYcCWl5R6J+fv0MmK5L+kIXrv8FgjyVr3yzaeqKrqhQvaJcXVP9OOA0libAT7KaAqd7jL1DbM61s2CfiJz@vger.kernel.org, AJvYcCX7kz3t666v/KBFgAt9G4SchM61jk/dFHkCEAk2fJKmAyQnDzq1jMCwqiySoZ30Yj7LgFFc85XO@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ciIBBq8ggPIxj4McNAzcikUFpVHuIadxy5naAdxmyELpxtGj
	fnhI/CRiQRJSWEsKhYYeT7lDbQYVQf5iwCW5dMATLPJqwHQGUa85
X-Gm-Gg: ASbGnctKkQZowRUc2oh4MrnefaFmOEdEpdFteJ5v+SgrYacivinxk5RLq5xygh9D3/W
	H3+aVAYGgSMBbxdSWY84nkQaDn84ddPmWqYkDkZPYhccLY4Rz0k9iDQW2G1/Jyn8DdaG6SPZXvn
	k1wMlmAG5RfbFk7IEkut9zjwrG2CdjRQfNfsmOM4bQNAJNtt8dutSBYus8uUKkNxpaj1/oTQ2w8
	L9GnG+qp8AujCdZKZzWtX5YxrDEDhND6eaGUWMF/QOIWysKy3zyUq1Wk8f/tDP7tJ1iIlSV23aL
	kwgza7lGiguaUt7MEdd5BMSFc87g8QOJdAAIAg9321jJj7KtBlHiRxrtmUkL7tF6Hjzb950crIm
	YrB+/rGyn6va9Ef4RU3MUkA==
X-Google-Smtp-Source: AGHT+IFJOZJD5sARwEyPr0FygyKi+XS53r3utqjUWk1sDqXC/avHS6/glE7hkif/N9K1k6uHaaUJ0Q==
X-Received: by 2002:a05:6214:19eb:b0:6e8:f133:3795 with SMTP id 6a1803df08f44-6e9006751cfmr15738296d6.32.1741303350496;
        Thu, 06 Mar 2025 15:22:30 -0800 (PST)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f707bf85sm12334176d6.18.2025.03.06.15.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 15:22:28 -0800 (PST)
Date: Thu, 06 Mar 2025 18:22:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Mina Almasry <almasrymina@google.com>
Cc: Pranjal Shrivastava <praan@google.com>, 
 Shivaji Kant <shivajikant@google.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jeroen de Borst <jeroendb@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?UTF-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Shuah Khan <shuah@kernel.org>, 
 sdf@fomichev.me, 
 asml.silence@gmail.com, 
 dw@davidwei.uk, 
 Jamal Hadi Salim <jhs@mojatatu.com>, 
 Victor Nogueira <victor@mojatatu.com>, 
 Pedro Tammela <pctammela@mojatatu.com>, 
 Samiullah Khawaja <skhawaja@google.com>, 
 dvyukov@google.com, 
 nogikh@google.com
Message-ID: <67ca2e3467212_3c5672949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250306150244.7797232f@kernel.org>
References: <20250227041209.2031104-1-almasrymina@google.com>
 <20250227041209.2031104-2-almasrymina@google.com>
 <20250228163846.0a59fb40@kernel.org>
 <CAHS8izNQnTW7sad_oABtxhy3cHxGR0FWJucrHTSVX7ZAA6jT3Q@mail.gmail.com>
 <20250303162051.09ad684e@kernel.org>
 <CAHS8izNWt2-1bC2f0jv4Qpk_A9VpEXNvVRoXUtL43_16d-Ui-A@mail.gmail.com>
 <20250306134019.1702e609@kernel.org>
 <CAHS8izM8dnFNj5p8vKiyhV9qeE+9=a=BWRnH=vCu49Tq_XTL9g@mail.gmail.com>
 <20250306150244.7797232f@kernel.org>
Subject: Re: [PATCH net-next v6 1/8] net: add get_netmem/put_netmem support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Thu, 6 Mar 2025 14:44:41 -0800 Mina Almasry wrote:
> > > Meaning it doesn't currently do anything special, or you can't make it
> > > do anything special with netdevsim?
> >
> > Meaning it currently doesn't do anything special with netdevsim. I
> > imagine we may be able to create a specialized syzbot instance that
> > loads netdevsim and starts fuzzing its APIs. However I'm told
> > specialized syzbot instances are much less valuable than making the
> > feature discoverable to existing syzbot instances, which is why our
> > thoughts went to adding devmem/unreadable skb support to virtio or
> > tun/tap.
> > 
> > Do I surmise from your question you prefer a netdevsim-based approach?
> > (and just curious maybe, why?)
> 
> My exposure to syzbot is mostly as a consumer of reports, I thought
> from looking at the repros that there's a way of teaching syzbot
> how to perform more complex "ops", like a sequence of specific
> writes. IIRC for netlink it does things like resolve family.
> But not sure if it's true or how much of an exception adding such
> things is.

The standard way of increasing coverage is by teaching syzbot about
new ABI extensions.

Adding additional initialization, such as setting up a usdma buf,
requires changing the repro scripts that it generates. Not sure where
that code gen lives. But all .c repros consist of a small loop() that
does the pertinent work, wrapped in a lot of initialization of the
tun devices, tunnel devices, netns, etc, etc.

> Here we'd need to guide syzbot towards a specific series of
> sysfs writes, so that it creates the correctly configured netdevsim
> instance with higher probability.
> 
> Just explaining my thinking, not saying this is the way we should
> necessarily go.


> > > > We'll need to add queue API/page_pool/unreadable netmem support to
> > > > one of the drivers qemu (syzbot) uses, and that should get syzbot
> > > > fuzzing the control plane.
> > > >
> > > > To get syzbot to fuzz the data plane, I think we need to set up a
> > > > special syzbot instance which configures udmabuf/rss/flow  
> > >
> > > To be clear for Tx you don't need RSS and flow steering, Tx should
> > > be trivial for any device driver which managers DMAs directly (not USB).
> > 
> > Yes, we don't need queue API or page_pool support or header split
> > either for that matter. TX fuzzing is definitely simpler. Maybe we can
> > start with that.
> 
> Adding support to virtio would be ideal, if syzbot already fuzzes it. 
> I was recently talking to David Wei about it for the Rx side, too, 
> so we can test io_uring ZC. But io_uring can only ZC user memory now.
> I'm not sure what adding DEVMEM support to virtio would entail.

By default syzbot uses a local tun device.

At least all the reports that I have seen. That is why virtio_net_hdr_to_skb
was such a frequent target.

We also added tun IFF_NAPI and IFF_NAPI_FRAGS to get more coverage of those
receive paths in syzbot.

If expanding syzkaller to a devmem rx path, tun would be more first choice.
But since devmem requires page_pool, queue API, etc., another virtual
device that already has those may be an alternative, not sure.

