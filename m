Return-Path: <linux-kselftest+bounces-26329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611D0A302F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 06:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82DCC7A2379
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Feb 2025 05:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A651E3DD8;
	Tue, 11 Feb 2025 05:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giKA0Z+c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAD1E47C2
	for <linux-kselftest@vger.kernel.org>; Tue, 11 Feb 2025 05:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739252622; cv=none; b=p/AkFw6nUDbultO3KGb3987Uk1HVwdoda89inFtAXxmOPXHuIpW95iw1YOU5kuvmqaF1IolbNoGYma34mcgQmaOEndeYKlU7CpNG8MJkOumYknqbQh3PVNP6UyvCQyWEZdQHBNeno/0RboNyoD+Xp9Z5fi/heeLd0DIQg3RmUjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739252622; c=relaxed/simple;
	bh=yiutF29gJafdhIkoJFYAc9y4gay9BN34SrcFu5zNZuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3LyRIn67+CAFveDn20IpR8CAithsEq92CGFYhCJogo/SYjhxD6SFE9mYlfNA3CJiyR0XmcWrPu5cBeY+PBo3cBS+mmR+0WIM+dK6Xsc3HAKlvjdFrdEEDVsEmnWQnb+skRWluQeK8Ii8rE+idVyAHI6pBxgUoH0PQ8WZtthPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=giKA0Z+c; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-471836d9c05so11cf.1
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 21:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739252620; x=1739857420; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvPUz/tKMvoI4V8mQFLMl7NVNOQxnWrC6+o5gP+Aun4=;
        b=giKA0Z+cSWBx/0zURPAyC5USWyiKNT4/tZZGr0Sq9KXKX5F1ZhQJjccoWb73tiQ0n/
         fKkLcuUJPejL8SvB2aNBf5PwQM0dXgllqlyoSXX0/gwVsFA8SQU9NOCIUMSv88CUhAN0
         8g0JUdyoLVonAanr9RTAGvGochFKDl9ZtSPnAaj4i7spJlB6S71JstBnsGQ7+TgnmXTv
         k/Iz9tVWy7w4O2tBILIXeMsSb8zhX6PTgjTjC9A4Q/N9jC9xi4Mg/9uT/aijh18i4aSk
         0kGvOH/iyBr33M2ylf9FNsE0uUW6WDBRN6seVei0GOIVCbOOz4n+0a1zFY7EHkmeweL5
         nHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739252620; x=1739857420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PvPUz/tKMvoI4V8mQFLMl7NVNOQxnWrC6+o5gP+Aun4=;
        b=W+e7aRJFZHWWHzZyFagA/rbgEjZ8qzi56p+GvMPnt02a6C8wY4mJQueFiu9v/toXIy
         6yQcDX/95QbRMEu37kAKerW4qxGHK727wioxpfB4WSb9hevYNCAdcxkRkWspAQxfjl1d
         XAVr31F8iRNI9i0z31aabkrn2IoHm9BzaA2zUt4B5W1tNSkLYlDCAhlskntOjwT6iHYN
         fiAU6IgFdG+YYosyv53rVpAMSjMw6nq8BOagnXktgqAzxmvhBLmS0rTV91wv6qHHYTua
         fB1zRdFamuGQR+2G56l06kQY/luqgZa/GUXd9jeZJA5gu8nE7nMBcBWsvyrqOURf51zK
         n1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXz7aImlA3nOlLAttXjXMi1fXc8N3adI299wsHEvGqQyO+eA9IWENWTmGuRsqsYPITST3ge0LeYyCwuANmGyVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWoWv2nQjqTTPcJ3WckjRsiB1P/hd4+IAwvYouk/0jnh+sx0tF
	isRvSHKSQm8wP9Jp0kZdEoGCVkLitCcT/HStTItBzlbSTjLiWaGiaXau1wx2hU8SpJuFR3n5jSk
	WjSuBBzPTD2mOHcdzBLiIwdCibpepPeTRB2Fl
X-Gm-Gg: ASbGnctviz0v3LJ4Ook25XRC2nZm06cEiGaiCOn7QzsRFYWNURrHtWpyy22mGr7iTmn
	kvl+s4z/BERjvAMMHzL4QY63HvHZXXYpaO+NfoSG7N1Hl528g5nK3csgDMUO5D4hT02vVcelw4t
	4=
X-Google-Smtp-Source: AGHT+IFdPC2jxNjIQ60tB1qHYw35wQPcR+ebUuPbTINTbB3BgR5ZvL+qydjb39WrysC4U8S2UIzDA8MJwdVbCXOxWXU=
X-Received: by 2002:ac8:66c6:0:b0:46e:3537:f21e with SMTP id
 d75a77b69052e-471a910d664mr4321cf.2.1739252619289; Mon, 10 Feb 2025 21:43:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207110836.2407224-1-yuyanghuang@google.com>
 <20250207110836.2407224-2-yuyanghuang@google.com> <20250210161306.GE554665@kernel.org>
In-Reply-To: <20250210161306.GE554665@kernel.org>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Mon, 10 Feb 2025 21:43:03 -0800
X-Gm-Features: AWEUYZkxPTkcoZEBe3_5sAnOnmrjICkKYhcLeSxWg-C3j3ZJ3rn8M2ow9fKXuiY
Message-ID: <CADXeF1GP24uJNYBPjjegs=sycUa1d=cVacvchKdAk5+p=ZOj8w@mail.gmail.com>
Subject: Re: [PATCH net-next, v8 2/2] selftests/net: Add selftest for IPv4
 RTM_GETMULTICAST support
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Hangbin Liu <liuhangbin@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, petrm@nvidia.com, 
	linux-kselftest@vger.kernel.org, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>FWIIW I think that the YAML spec entry is distinct from, although a
>dependency of, adding the test. I would put it in a separate patch.

Thanks for the feedback! I will split the change into two patches in
the next submission.

Thanks,

Yuyang


On Mon, Feb 10, 2025 at 8:13=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> On Fri, Feb 07, 2025 at 08:08:36PM +0900, Yuyang Huang wrote:
> > This change introduces a new selftest case to verify the functionality
> > of dumping IPv4 multicast addresses using the RTM_GETMULTICAST netlink
> > message. The test utilizes the ynl library to interact with the
> > netlink interface and validate that the kernel correctly reports the
> > joined IPv4 multicast addresses.
> >
> > To run the test, execute the following command:
> >
> > $ vng -v --user root --cpus 16 -- \
> >     make -C tools/testing/selftests TARGETS=3Dnet \
> >     TEST_PROGS=3Drtnetlink.py TEST_GEN_PROGS=3D"" run_tests
> >
> > Cc: Maciej =C5=BBenczykowski <maze@google.com>
> > Cc: Lorenzo Colitti <lorenzo@google.com>
> > Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
> > ---
> >
> > Changelog since v7:
> > - Create a new RtnlAddrFamily to load rt_addr.yaml.
> >
> > Changelog since v6:
> > - Move `getmaddrs` definition to rt_addr.yaml.
> >
> >  Documentation/netlink/specs/rt_addr.yaml      | 23 ++++++++++++++
>
> Hi Yuyang Huang,
>
> FWIIW I think that the YAML spec entry is distinct from, although a
> dependency of, adding the test. I would put it in a separate patch.
>
> >  tools/testing/selftests/net/Makefile          |  1 +
> >  .../testing/selftests/net/lib/py/__init__.py  |  2 +-
> >  tools/testing/selftests/net/lib/py/ynl.py     |  4 +++
> >  tools/testing/selftests/net/rtnetlink.py      | 30 +++++++++++++++++++
> >  5 files changed, 59 insertions(+), 1 deletion(-)
> >  create mode 100755 tools/testing/selftests/net/rtnetlink.py
>
> ...

