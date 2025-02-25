Return-Path: <linux-kselftest+bounces-27405-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA5A4338C
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 04:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF0757A44A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 03:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293022441B8;
	Tue, 25 Feb 2025 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22496/5r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95E4430
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453582; cv=none; b=awjJggnLiSG74n59YgakX5JTcILJxj+20JD+3tXc8P8KTtlWCQk3L1r8H2HUK6cHWGb6VG+bm2gRHUYnKO9gCB97NCBauiRYYJi5e/CF5I4RlAGwoydxf30IrTwi62VdNeR5usfDlzMSzSRlk8x7CxIgOETLewb4PczgbNENHCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453582; c=relaxed/simple;
	bh=KmqJ5UPyUn4QKWhlPOJYvXUy8SdtTAvRkRSjnFipiZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOxvSOCSCJ4kI9FRNjHfmtG2J/6p41Y9cHvNzmGDVxdoLlI4F3EKXDW6h2hfuXDnSpdrR3smq0yUyrT+cCDsksluHpIFMYGeViG9W1FPuOv9KONux4gZ5rQJ5wY4x/feWJLY0eNlcjKLJ7vs6geMTaiF8TIbJ8EqfnC7/wqKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22496/5r; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22117c396baso62055ad.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740453580; x=1741058380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=22496/5rvjtyzQzH0W2UwpDmopdQIHamOSIGdKMwVApZn6ch4fQ7Rqj75B9/Hqax71
         +Yq2guFcmiIDCFM5gOL/3n3a1zsTYzeK2zX6xQogM7DHiRuZNXEehzGvBlbUsdu50CTm
         mftau51LHosFLeUs/pqIyOpgizpPQcu5lqGW/9z8WuaT2erles+9DpullQ/Hgrz0rJ+V
         96bXfVjA9CXMKyPmef9qdpDOu7gavaPAfTguaIdeencBnHK496j7byYM6Njsx5+OH3af
         sddMiBAr7k2QoAs0ifssP5UvX1ekfIShCO7e7H+rXm7Leq4pVOfkIkgnE3BbpINsvTMJ
         rZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453580; x=1741058380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=WPEi1ZlC4BWNrTYjl4eWuqv9eeygiQD1pmhh8LmkhhX609OTqPVXzFcfdccULI4JS0
         C8n0g1VrtUAc6evVhjEwUh+niDNVUTl5sIR6QzSY9yisD6woOI/fU7hBuHJrdCglj5L7
         fQ1KLayRMsmYn/6etpb5xRaAHFJAoGNNxkbZ/BSGk+uFxFOmiqFvgvR+/yOax4esWIck
         fmJwX1amS8ef04CWh4YbIgqQPMo05RHgRfEkX9ObzqozyZqbQ/yD63u30hcccb6c4ABh
         iuP63s7W8TLBMYAg2YM5loZBx6/imIYNUdaK45qf5VHHux9/jaRii+wVpfHGJVLtn8DU
         dufw==
X-Forwarded-Encrypted: i=1; AJvYcCXlRbMenjvjZMpofza3nlK97CGDoIakgnggXuDZXPA8wpwz7Ee93bKD0zGUsg0NnxISqC3pC+azUgr8JjGElDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLnlnY+xLm0+QRjjsjfDwhU4e4nZ5IhyJNH0sUJ6GmhZOLBdo
	GN/6Yi3vrJRvwSZL9RKFweuIj+T+QkMsUp1/eOCgqhCbB7gUQGE2gNH+UG/11z31iTzvLtg6BMu
	ON5vQBF0zuXGd/uvmuqp1mBVtfZoz6CCPbPak
X-Gm-Gg: ASbGncvuGeqnIr+16MjQhqrpszxa+zKjvnZaIF7khU8/+U6rwCZzX85Jc8k4uJDomcs
	uCxfK9aZmZgIwbUatrGVatkhFe/DfGdt65mPWaGNv22NqHfBoraGI/OH8o1ypaYOcBE/XLRwnjj
	H5UZvVZ54=
X-Google-Smtp-Source: AGHT+IEtZxuCVd0tnzxcUGZ4gQTicVs14GYdJr0CNhWdXPCDZapgO9XyLPZYzQJgLaG9UA9AQIHRIeLixV4juXWMkIc=
X-Received: by 2002:a17:902:db10:b0:21f:2306:e453 with SMTP id
 d9443c01a7336-22307a3d994mr1928995ad.7.1740453579681; Mon, 24 Feb 2025
 19:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com> <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
In-Reply-To: <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Feb 2025 19:19:25 -0800
X-Gm-Features: AWEUYZkE739kPYOS1vvRcfM-p2BwFYz8vTlR5KcbwCGeAbQzIBCCJ-WS6P6ifgA
Message-ID: <CAHS8izNtGrMV+6T83-tNGpXsFqLo5N5jZpHueZ=SkDZ24pvKsw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/9] Device memory TCP TX
To: Lei Yang <leiyang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:54=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Mina
>
> I'd like to test this series of patches because these changes are network=
-related. But there was some conflict when I tried to apply this feature. C=
ould you please help review it.
> The latest commit id which I tested is following:
> # git log
> commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6 (HEAD -> master, tag: v6.=
14-rc4, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 23 12:32:57 2025 -0800
>
>     Linux 6.14-rc4
>
> About conflict content please review attachment.
>

Thanks Lei,

Did you just want me to review the code in the attached file to make
sure it looks good or was there a merge conflict with some repro steps
that you wanted me to look at? Or you do have a diff of the conflict
you want me to resolve?

The attached file in your email looks like an exact copy of my first
patch in the series,  "[PATCH net-next v5 1/9] net: add
get_netmem/put_netmem support", so it looks good to me.

--=20
Thanks,
Mina

