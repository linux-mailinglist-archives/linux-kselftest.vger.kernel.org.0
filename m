Return-Path: <linux-kselftest+bounces-43-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6AAE7E95E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 05:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F221280F2C
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Nov 2023 04:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A01C2CD;
	Mon, 13 Nov 2023 04:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+FFgZhF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A692DC131
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Nov 2023 04:08:26 +0000 (UTC)
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4DD109
	for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 20:08:24 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-45f0e332d6bso1767356137.2
        for <linux-kselftest@vger.kernel.org>; Sun, 12 Nov 2023 20:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699848503; x=1700453303; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fNlzfs8IwIwZE9A6q67KhpJlkrTSE+tePrP0YR73OHc=;
        b=b+FFgZhFiHmLXWmqoAhNMS1lbkXEc0mXk09wrBWGLfC4pSfA6wnJv3t4DUT4cx4ndT
         ovU1rRVOO6u/o6eOR05cjBJbSLyumJnvo72fEoTqecEDThGeRG4tIyorrirhwUr7jBFh
         mcd8HfpGU7/QrzGJ5HKySkzPtYQr1Q1iYuKKvgiTJJRbninSAFc4kf2s9tth5JPlVKXR
         oor5lOrS39Iv79hyG7MYwTnjftV49Vl1yvNPdq7L5SvMO3C4KIEL9NSyzls4AtB5R/+J
         GGOSFcTuyB3wOwM69hwkPJBZhwATztT0o2pIFn/HjD17prcKn79aPetGM0s6oXTZqBw/
         5OLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848503; x=1700453303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fNlzfs8IwIwZE9A6q67KhpJlkrTSE+tePrP0YR73OHc=;
        b=bLaHhYoYtI2udHpQdvt0TD4c7AKchFQfv+T1hWLLc0h1KyZL1NX4Y6a7wAH5HJP16U
         +A0busI+1NcWAqkNndxe1l4W42LqrgvxTrZGIOn74LrOHfZWKuJQvL/KG/BIPJUQNMfz
         3vGG/HL8PyG1cNq20WCG/8AcDqv1D775dnodrQSY7Hq1tiIGiaijcYtXo4LEr6W/OZih
         QuqajMB2EsfvqL7ycEWwaVsTOb89dF1d/RablfeQQM5n3XPULuiNG9BmI20MGM0LiXjl
         5ZiAmir2CvCO2jP2HCtYGEcGmwFWJhf8nT9CBDcKtSdSJgDyfSGBC5tkNflWnX8lR1XP
         nYYA==
X-Gm-Message-State: AOJu0Ywcu9alZ88TXG06vXqMRmqfR6jwv6m8b1jvH92yCwm0OnNQZI8P
	rWyXUjbvvYhcWYTrf4f92sSoUHzXX7fpchMyJqWzQQ==
X-Google-Smtp-Source: AGHT+IHqCItyp2X183Is4ZUWWeu08E03+bCPhwHxhH1umjtWjuw2QPn7bjsb51GqQnBkszbQBlUyYv0Wl+YEehcAH+Y=
X-Received: by 2002:a67:c19a:0:b0:45f:b92c:663b with SMTP id
 h26-20020a67c19a000000b0045fb92c663bmr5549887vsj.29.1699848503509; Sun, 12
 Nov 2023 20:08:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-13-almasrymina@google.com> <20231110151335.38a1c6ec@kernel.org>
 <CAHS8izNFnE8RGgBhKzxhVoKXtXgZGVQCLSdm4_dWNeH9Gx-WDQ@mail.gmail.com> <20231110183556.2b7b7502@kernel.org>
In-Reply-To: <20231110183556.2b7b7502@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 12 Nov 2023 20:08:10 -0800
Message-ID: <CAHS8izMQQekAdkLF7eFHfwGJJ=LFmGLHpSpOYiQeLs96ByEK7w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 12/12] selftests: add ncdevmem, netcat for devmem TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

j

On Fri, Nov 10, 2023 at 6:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 Nov 2023 18:27:08 -0800 Mina Almasry wrote:
> > Thanks for the clear requirement. I clearly had something different in =
mind.
> >
> > Might be dumb suggestions, but instead of creating a new ndo that we
> > maybe end up wanting to deprecate once the queue API is ready, how
> > about we use either of those existing APIs?
> >
> > +void netdev_reset(struct net_device *dev)
> > +{
> > +       int flags =3D ETH_RESET_ALL;
> > +       int err;
> > +
> > +#if 1
> > +       __dev_close(dev);
> > +       err =3D __dev_open(dev, NULL);
> > +#else
> > +       err =3D dev->ethtool_ops->reset(dev, &flags);
> > +#endif
> > +}
> > +
> >
> > I've tested both of these to work with GVE on both bind via the
> > netlink API and unbind via the netlink socket close, but I'm not
> > enough of an expert to tell if there is some bad side effect that can
> > happen or something.
>
> We generally don't accept drivers doing device reconfiguration with
> full close() + open() because if the open() fails your machine
> may be cut off.
>
> There are drivers which do it, but they are either old... or weren't
> reviewed hard enough.
>
> The driver should allocate memory and whether else it can without
> stopping the queues first. Once it has all those, stop the queues,
> reconfigure with already allocated resources, start queues, free old.
>
> Even without the queue API in place, good drivers do full device
> reconfig this way. Hence my mind goes towards a new (temporary?)
> ndo. It will be replaced by the queue API, but whoever implements
> it for now has to follow this careful reconfig strategy...

OK, thanks. I managed to get a POC (but only POC) of the queue API
working with GVE. I still need to test it more thoroughly and get a
review before I can conclude it's actually a viable path but it
doesn't seem as grim as I originally thought:

https://github.com/torvalds/linux/commit/21b8e108fa88d90870eef53be9320f136b=
96cca0

So, seems there are 2 paths forward:

(a) implement a new 'reconfig' ndo carefully as you described above.
(b) implement a minimal version of the queue API as you described
here: https://lore.kernel.org/netdev/20230815171638.4c057dcd@kernel.org/

Some questions, sorry if basic:

1. For (b), would it be OK to implement a very minimal version of
queue_[stop|start]/queue_mem_[alloc|free], which I use for the sole
purpose of reposting buffers to an individual queue, and then later
whoever picks up your queue API effort (maybe me) extends the
implementation to do the rest of the things you described in your
email? If not, what is the minimal queue API I can implement and use
for devmem TCP?

2. Since this is adding ndo, do I need to implement the ndo for 2
drivers or is GVE sufficient?

--
Thanks,
Mina

