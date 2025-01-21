Return-Path: <linux-kselftest+bounces-24819-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9C3A175F6
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 03:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33A33AA4BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 Jan 2025 02:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198A2154C00;
	Tue, 21 Jan 2025 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u8nO/kyE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820061537C6
	for <linux-kselftest@vger.kernel.org>; Tue, 21 Jan 2025 02:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737426605; cv=none; b=lg/Phe26cGk3adT9sDYedAWDbbwbvGhePS4mIBoboXx0jOoHgPs6wOWvGzkY0TGuODtnT7dNzc5PHTrte/O685W2nUWHCUdil7F8DgWLnox0/L1YjdeGpHR+17la7OqZf7/uAd6EywZVkok07xwdnY9mCbAjHLtdPyc7yTgCbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737426605; c=relaxed/simple;
	bh=kkfCkGHH/5pcAL0xqI/wvdSZvH51iCZ4dgaEReAVEIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Li9icCkqgSr2pZkTWCF7jffd7III1za7RR6M915NtRHxupS7VMgBPD4tGWBay8PNOItbGwqFT5ir8quPzIMx5Pn183LNHFiMA7NzKgpg4p1wmeCOyh5ucgd84FycQP7+OSKoiKQYqx6Gh9oxDFiqnnQMV3Xoja2NjGnvDM7yY3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u8nO/kyE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ce7e876317so45ab.1
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 18:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737426602; x=1738031402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPH2l5qf1qTVXhW3y6X6yrEqTd9SkGMkHh8IfEKrlFk=;
        b=u8nO/kyE5GH6ee2wsFEwh1foOoz4DgjTuauzcqHWH1ZzPUFFMF/x1upQGnSRtuXD+O
         Nl+kU47W5nGKMLg11zujBUY7CVn+Js7xVFRNKI8+h+xLoXFzrs/HH30sgVDtacKqdEay
         A+Y1N+7kqVEFpaNs9ZylkYpsJq4YsIj4Ddl/3/RTi0g/FQbrOYDI/wzDY4U1X/q6IA5A
         VBO3tQwrpO3UXrDbLN2zu/nR8yYYbP7b+vkn5DkY8ImVHFurX6HVnTuhhcRTfQZfEIBG
         /ooaYOI0Iwfe5dbtB7xX+wkJkj63D2FeyHwgNeUi7y0ayZlLB/JCmnunBQ+2pltGc3IG
         zGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737426602; x=1738031402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPH2l5qf1qTVXhW3y6X6yrEqTd9SkGMkHh8IfEKrlFk=;
        b=VGpzVrpmTz9dVY//gB4aNWr2bHtDkWIq/QMwnVvoGLKOXR9YPq84S7AEu3Dz4lRMeQ
         gMBbACoNkNeiq2pvVMQ2ArpO1cAlLHcPQ4uWJGxQX0jm9WyB+nziAZxiQbUHq+/5wrXZ
         ON7svHdIzfpPljOCp/iOc8GEC8NrW7byDGCkArkrYxs57EXgkGd6/LGUif8CBpP6ufMC
         vf/byClWGFC8zUgaMMLQQx6Iglr5XNwKWBr6wTc6wB5M5fqkGAhgzPkV+nwtdkjg5x8I
         qqzYg7IExCViapU4EYYlkszNZfPBOLVa4l78HXX3Z0rMJGIm0UsnZAnNy5BGTa568CoS
         XZfg==
X-Forwarded-Encrypted: i=1; AJvYcCW6brFgMyL4MwwRiJtpdZca+FYPVIZCkd/18Yrbpiv079H83wLA8qe+8JSUiadYsjFAdnTcKCyvCmV0Cds7SGg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweGrsrhFl103gvX7kpx6ayD9AJ5hLiNyqdixbXn6GbfZ4U5EvS
	hDhDwi38nUvAOJf76sH0O2bWVHYWXbnn18XrMFEzgYvBge8MwoiXtfVSY4aUxRNJeYA0xghqL9y
	Esn09Cmya6nfGwpUn1WNPU5SjsNWIfC+7wifV
X-Gm-Gg: ASbGncvbDnb7bNHEWf+taTI45yIqEY3dQm4eZVNnwuSxYluoD/gfuXzXuBVhYiJhW7m
	7ieg4QEUMNVpdzeo+SrTNQPrukJLRtxgjWBWjeq+/UZdczX7e/DpmzRlZPdm2gEzDj40zYQq4s5
	Kic5O/LQ==
X-Google-Smtp-Source: AGHT+IFlz4TxB3vciHD96WStNcWKfDv2nt6pDTX2HSfNXumM8/MVKhR4YG5/U51YA28bK2CS8jm9EvWOsee1FBpIG28=
X-Received: by 2002:a05:6e02:1111:b0:3ce:51bd:3b05 with SMTP id
 e9e14a558f8ab-3cfa9443651mr11835ab.2.1737426600885; Mon, 20 Jan 2025 18:30:00
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117081600.150863-1-yuyanghuang@google.com> <20250120164621.287af2eb@kernel.org>
In-Reply-To: <20250120164621.287af2eb@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Tue, 21 Jan 2025 11:29:24 +0900
X-Gm-Features: AWEUYZkgAGWY6e-kgWc5FZORob9sGJ4tEP4o23gzR672JEL0GNHYtT3vCoErJAY
Message-ID: <CADXeF1F5R+p7ohvMRDBsRSxxqqAO-zXwctSz5KvMJEPbQLy90Q@mail.gmail.com>
Subject: Re: [PATCH net-next, v6 1/2] netlink: support dumping IPv4 multicast addresses
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the feedback.

>IIUC Paolo's suggestion was to create a new header file under net/ipv4,
>if you consider addrconf.h unsuitable. There is no need to expose this
>argument struct in kernel-wide headers.

Currently the structure is like follows:

IPv4:  `struct inet_fill_args` in igmp.h and use it in igmp.c/devinet.c
IPv6: `struct inet6_fill_args` in addrconf.h and use it in mld.c/addrconf.c

We could move `struct inet_fill_args` to a separate header file, but
this would cause the IPv4 and IPv6 code to diverge. Therefore, we may
need to modify the IPv6 header structure slightly as well.

I propose moving `struct inet_fill_args` to `igmp_internal.h` and, in
a separate patch, moving struct inet6_fill_args to
addrconf_internal.h.

Please let me know if you have any other suggestions.

Thanks,

Yuyang



On Tue, Jan 21, 2025 at 9:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 17 Jan 2025 17:15:58 +0900 Yuyang Huang wrote:
> >  include/linux/igmp.h | 12 +++++++
> >  net/ipv4/devinet.c   | 76 ++++++++++++++++++++++++++++++++++++--------
> >  net/ipv4/igmp.c      | 13 +++++---
>
> IIUC Paolo's suggestion was to create a new header file under net/ipv4,
> if you consider addrconf.h unsuitable. There is no need to expose this
> argument struct in kernel-wide headers.

