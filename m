Return-Path: <linux-kselftest+bounces-27250-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F92A40413
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 01:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9B0705D23
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Feb 2025 00:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5981A61FFE;
	Sat, 22 Feb 2025 00:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2AYvz4m+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267B33D76
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Feb 2025 00:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740183877; cv=none; b=p4Mfg3m+0TzXtegUE7CkLf2Y1wOjgsdwTii2RSJL/+QjfDDSP8x/a2UgeDqquLlzXIRJX2dqV+um/qKN8vEb06SWRHCf2UXcteRuT8z6IxEDfMW1U86YbVZ/ny+XZFSDZmtzNyy2Ch1LrF2avbb2LaXoHhOy6BBD9pYWfzkpIAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740183877; c=relaxed/simple;
	bh=hPpnlZKOG91aAsSK3c+6EiQG/hLmCAaD3GdYrIVqp9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I972VQ3n13SG8ALSBK+s6I/uAojM/bHGjXRgZx/nWWm1L2sxRriwLji50c1XA/8I8CxFWc48Av/LZLyd3NiBKlBKiIT1GOcaOvPjVMBh9JIVQbsM6xPAsTGddy4fbO4FEemTG1yW++D2NQJktJX26lvkBit1f+EjmWhCYz8fUXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2AYvz4m+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-221ac1f849fso29345ad.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740183873; x=1740788673; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K/x8vAcUB/ic855YHRH64Mw9k0JCngQUmBTGGdXhTfY=;
        b=2AYvz4m+K6F8QwW5gnKX6LbPIGX20iGZuVJxycLDL9cynZQnpcczgfCUaYwVUkfsQ0
         waBnFfvlNEh7NbS7kX3XpOhNi5BxlLLG2o+Nm2JchiBNIFsjsq77YEwlJukJSxSO6Iol
         PHKFcgU986z/DMnkmHhb4n4NLVBVsDA8Wo0d5YiXny6MRInQJ5lTUtvsRmavhRGVot4r
         6n7lfBXSbySZ4BMUDBcyvK48XUdJy+kfNPOecidXxDV+IrlZWX+qSwV24+rPyrxlIbyB
         6a7SW/3iYtmDX/rme4/R69ewJIEk/5iCzV/XvuO37vZRMEbEEOOxOXZ0G5H2tj1bx2CF
         M8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740183873; x=1740788673;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/x8vAcUB/ic855YHRH64Mw9k0JCngQUmBTGGdXhTfY=;
        b=AjQ/HokObxt5Y0qeh86iIZLcOQ2BSCbdy7EfvywLLc6k7jG+yrKFyuZO2hs5b/UeQ9
         Zl2wTSJFR6EIBTi+SnrufhH5v0a1VUmpXawpM+MJZ4II7PpdWBSx3m77Qi9niaaDuzNr
         njdcBUO6P09Z3OQ+DLouXkYGOiilYqlsf4IiC87F3oOnmLI7HmeP1RolBX/I1aXfuRgj
         txShh77xIxYhBda2dIo8CNVvUnke4rO0derMUdYFeAauTEJdmw8xaPr1IBXXozCCIoSy
         GKfW4k9sGRBWzzKa4fEa0vEvxHEirEE3b/y6A2B+ato71MeKDnDUSKU+q5EmLG1eAq5x
         gJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmzo6CaHmjaAb+M6tCTIwq3ykxYu/s1qvPC50jijG85b/kolEGF5wWqG+sEpRt+iG1OGaLrI9yrXwrNQVlLM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI80FqY+70qePhSvkvjOjJqNiyi0nvLHTEu6ptDwyC8Z6pIlsC
	aFcrgroqfUi4L7CRqE/IBrvoZTN1iySTh2fFLFKGDOsh9g4TgYkrT5nFvBTayiiLqY1bf7OHE12
	yYcllBSQDH3k20sTjj7zf/OaKLd82GyAumMoX
X-Gm-Gg: ASbGncsV1oCvKQMZQoLRoP2oVIQhL1aGWECXu+yIodJ0PoorVj5B8UVX5VQ3DZrdBwO
	OJJ5BMSLj687hzWbS8BcBVVNN+AUBeXNS+GtluIsOvhxrZRk60+dkiu2le/nhCbj8E6FKwhvMXZ
	O7SetG3vw=
X-Google-Smtp-Source: AGHT+IGVsr7xcN9MCd6339oiPC71YpQrUXMaUKu2w5DQntfyomcz0s1pc+sIqfRcq3uFYKJynoApH5QECxwHh6kTReI=
X-Received: by 2002:a17:903:228c:b0:21f:44eb:80f4 with SMTP id
 d9443c01a7336-221b9cfbfbamr1012175ad.4.1740183873140; Fri, 21 Feb 2025
 16:24:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220020914.895431-1-almasrymina@google.com>
 <20250220020914.895431-10-almasrymina@google.com> <Z7eKHlA0rCF2Wgxb@mini-arch>
 <CAHS8izPA2eQ251-whnsT7ghG01c0e=tERL4Cwg1tBr+ZfVNHpA@mail.gmail.com> <Z7kYYXixRws7Kk-q@mini-arch>
In-Reply-To: <Z7kYYXixRws7Kk-q@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Feb 2025 16:24:20 -0800
X-Gm-Features: AWEUYZlIN4OsigwtyTsPVx6XPhcjksTX5jYAgeD4mnU6jpvOBA8xEU409eVhNLw
Message-ID: <CAHS8izNF=wAhT29zHzUTtNMnm43NFGYOEeyHc+Gf_S3EDTd+-w@mail.gmail.com>
Subject: Re: [PATCH net-next v4 9/9] selftests: ncdevmem: Implement devmem TCP TX
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Shailend Chand <shailend@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 4:20=E2=80=AFPM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 02/21, Mina Almasry wrote:
> > Hi Stan,
> >
> > Thank you very much for testing. I was wondering/worried that there
> > will be some churn in getting the test working on both our setups.
> > It's not unheard of I think because your ncdevmem changes had to go
> > through a couple of iterations to work for our slightly different
> > setups, but do bear with me. Thanks!
> >
> > On Thu, Feb 20, 2025 at 12:01=E2=80=AFPM Stanislav Fomichev
> > <stfomichev@gmail.com> wrote:
> > > > @@ -25,18 +25,36 @@ def check_rx(cfg) -> None:
> > > >      require_devmem(cfg)
> > > >
> > > >      port =3D rand_port()
> > > > -    listen_cmd =3D f"./ncdevmem -l -f {cfg.ifname} -s {cfg.v6} -p =
{port}"
> > > > +    listen_cmd =3D f"{cfg.bin_local} -l -f {cfg.ifname} -s {cfg.v6=
} -p {port}"
> > > >
> > > >      with bkg(listen_cmd) as socat:
> > > >          wait_port_listen(port)
> > > > -        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:[{cfg.v6}=
]:{port}", host=3Dcfg.remote, shell=3DTrue)
> > > > +        cmd(f"echo -e \"hello\\nworld\"| socat -u - TCP6:{cfg.v6}:=
{port},bind=3D{cfg.remote_v6}:{port}", host=3Dcfg.remote, shell=3DTrue)
> > >
> > > IPv6 address need to be wrapped into [], so has to be at least:
> > >         socat -u - TCP6:[{cfg.v6}]:{port},bind=3D[{cfg.remote_v6}]:{p=
ort}
> > >
> >
> > Yeah, I will need to propagate the ncdevmem ipv4 support to devmem.py
> > in the future, but unnecessary for this series. Will do.
> >
> > > But not sure why we care here about bind address here, let the kernel
> > > figure out the routing.
> > >
> >
> > I will need to add this in the future to support my 5-tuple flow
> > steering setup in the future, but it is indeed unnecessary for this
> > series. Additionally the bind in the check_tx test is unnecessary,
> > removed there as well. Lets see if it works for you.
>
> Hmm, true that it's not needed in check_tx as well. Let's drop from
> check_tx and introduce when you need it? (but up to you really,
> was just wondering why change rx side..)

Yes, that's what I meant. The next iteration will not change the rx side.

A follow up series will add ipv4 and 5-tuple flow steering support to
devmem.py, but that's unrelated. We can discuss when I send it.

--=20
Thanks,
Mina

