Return-Path: <linux-kselftest+bounces-27138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69759A3ED60
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 08:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFF6516EB23
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 07:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EA51FF7C1;
	Fri, 21 Feb 2025 07:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6JpJ457"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064691E47C2;
	Fri, 21 Feb 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123307; cv=none; b=b6QpijdsajTn9HX83LQdDAsHeLBroWxbK0IwPFO7d4Lbzkuu2SVO4Gd5nUa/2p0I1hyexcKj0nzgZ6F0EkwPEneS6NYWjNT+hUrtLKMN4IDdVMjHOvwOVBQW5XC4quSvWluRDvSxzFCeXneQR16ep/wPF9ZMom8MlzSpwhG8lSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123307; c=relaxed/simple;
	bh=T1VOQiQtQXiQ9wkvgL+WC9xJqcl7iT4O6gvw688nMkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udBIafiy8mpy5ULEuGxuht3LzdHn/7U6dr10U7rsu06kkFkWs9QeGu+s7yZwCLUKxxWdtRkZE+/WVXBx694fxSMk5sAl+JdeP6KthDalOmq+H8ndYPI1+vZtyEiZgzDbsJ1SShVlIgDbbURH7UuhVVm/bhvVVNTxCJDxPafEQ/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6JpJ457; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38f2b7ce319so1464011f8f.2;
        Thu, 20 Feb 2025 23:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740123304; x=1740728104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=U6JpJ457jP2izXV8r/eMuvXycpbgUpO7ekUzuySgQ/mxiwuQADcgrrGQ24uLCn3zLv
         yZYPnrzne7VNjkMkUwRtTh5pfnISomK95JFYM3us61r7XNqNzo3QJV39bJSQjJ2ppSeY
         zyWFUmS8XpsLxbrYFfKk92rRcrj5cxbhnwaR01Qmo9WVq6cG3KboI9EHo4pkMrOLEdT1
         IuHawhQKlwB0U1ah4y7L0PjiN9S8bef5ZwgoMI+IIfe6kDX0YH4wLR8BTCr2L9S7hz6g
         gQQ7wNtEdGvxkwvuk7xiRwFFUteObuw/hSuAl+ZzcXsEabp4D3wNdhDARer7tt7AzU/h
         SxWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740123304; x=1740728104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z+QeLQVPsYwD13WdLTO9iwIZOqXlzHUuuYA44GHEnsU=;
        b=XmxsRYtWEC496Z7ZsXLaLpC/H5vEKVpw+Zq2Klmy+tP6bgsC2h6biVOLP6qWVMlFbF
         kmRodck5JG679E9Mgx7ospyvlShrPfywJeyGiZ9PE4BqJ+Gc2QfCKHW4kxJCxHC0ko6I
         IuIl0raCi1mel8PGkgvu9Pvb50lGpebRN4f29wNkXhgnndDen0lwldd/vWe15CbgvQHD
         EhQsR3j5NyoO+KmKxadyC/3RGZB0wki6BNhZ+mKDULcYhDi2Et+gKk/0d6pmR7mjIm7Q
         tf4RK11qCL4HxCPzwhOBsKhuPqJE2a1U1sWSiidz5FbdU4D0CmDgudANR67eeOb2m3Np
         HbnA==
X-Forwarded-Encrypted: i=1; AJvYcCU9P+XNvRzAvk1jFKczjlrFOkuagMQSeJmIF4BaOxm/Di53yfkwD1/W3cqycDtlmfuRF1QrWzfLX5vpQQ==@vger.kernel.org, AJvYcCULxHTsdTum9DUSghT+QNq82RmXpLIzEsBr1cMF5YioE/Heyq4kdQ5m1bR3CY4YPU418yyf4GsSHLHkCQ==@vger.kernel.org, AJvYcCUi/6+SSFnRDyxgrsE/+yPkfZm0GbMRQ1jXT9yb9imSidW+SKSOB6pfwiHXtxrkNtGqNvVPOOm6t8RlinTz4EE=@vger.kernel.org, AJvYcCVBkCunSMgHIAazgRoWurTNMJKG7WlUl3cImzlc90uNCUjhjc1bcvxV+a/SMtSzsclMIzv+cTev58bIDJ+5@vger.kernel.org, AJvYcCVmC/0jWlNj1U+vrvhHC39R0O95XIqzIEWHW0gUaUfDBvqC3zMSwsgXoIS/4sGqStuG6HFzZftsXxbe@vger.kernel.org, AJvYcCWXnVF9jHY0+KAU1zucfOJCd1lgmy36OZlUHtvsoJdwSLsxnKU778KwplDU4Ry3t6+grBkdFvqK9ZfX/hhGQ5F5@vger.kernel.org, AJvYcCX+GU5TA1jp7gAx6VQCazY9fzPjT0cseS9eMoL9UrZZ3P9gMOi3D6R2AFdGmnDnSPN1vHA4eUls@vger.kernel.org, AJvYcCXXZdkX6yCGLQJ6v12VcINeYXBhLErs4peKZ9aBYGYIcKgqN5WhYY+UXNKspL4g44O83K0=@vger.kernel.org, AJvYcCXbSLj2op01AnruCL4TDWcyVqbiOn3XtxyS+qeumcp91VtzZoiA6/Aj4dmPr75rMCeeFKlUUSCQk9yX@vger.kernel.org
X-Gm-Message-State: AOJu0YwOysp3c2b71HetMD2mwvwOLmw3YMNU7cu3Dej2JbN7xDoS2JcO
	zashF8skDnQcwKD53cl8Fv+EBMoAYBrd5veQCWwTL/ptJosdwEDcn0LEOUDNBEVVXMtheJJg0mJ
	YjUePpKlJFXebC/PEhc4H2Frg3ZI=
X-Gm-Gg: ASbGnctrC+gmKyKMoxLzbnq4IEI0b9IvQCjViA/mdnJdyXoP3ebwrtP14Jos1jJqtA9
	2NPemW/bmeIFpgx+lJlePZ/e5ki5yLw7tSwyk00WZBG6ANKLixpEB80LCfQBNy1Q+Kg9RTE9O75
	DX6mDvwg==
X-Google-Smtp-Source: AGHT+IEnf7T/XWdU9Kctt2h3J5gBBMYg3Bh51JvuIgDPQVVK7cGhz8HpBuMv8GGd62Uk1SqkypkvwsyahBFfgLBFMsQ=
X-Received: by 2002:a05:6000:4026:b0:38f:2856:7d9a with SMTP id
 ffacd0b85a97d-38f6e7563cfmr1756891f8f.3.1740123304054; Thu, 20 Feb 2025
 23:35:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125039.18024-8-shaw.leon@gmail.com> <20250221040641.77646-1-kuniyu@amazon.com>
In-Reply-To: <20250221040641.77646-1-kuniyu@amazon.com>
From: Xiao Liang <shaw.leon@gmail.com>
Date: Fri, 21 Feb 2025 15:34:27 +0800
X-Gm-Features: AWEUYZnNy9JuajIA_7tDw52YSOa4CSIEVEzv6mMTGyYFjN7-s6b2UXlhoSAg5e4
Message-ID: <CABAhCOS3BC+spLNrb_P8Ovzo18BwHU6UEc6Aq80_YKUoc8rfMQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 07/13] net: ipv6: Init tunnel link-netns
 before registering dev
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alex.aring@gmail.com, andrew+netdev@lunn.ch, 
	b.a.t.m.a.n@lists.open-mesh.org, bpf@vger.kernel.org, bridge@lists.linux.dev, 
	davem@davemloft.net, donald.hunter@gmail.com, dsahern@kernel.org, 
	edumazet@google.com, herbert@gondor.apana.org.au, horms@kernel.org, 
	kuba@kernel.org, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-ppp@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, shuah@kernel.org, 
	stefan@datenfreihafen.org, steffen.klassert@secunet.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 12:07=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.c=
om> wrote:
>
> From: Xiao Liang <shaw.leon@gmail.com>
> Date: Wed, 19 Feb 2025 20:50:33 +0800
> > Currently some IPv6 tunnel drivers set tnl->net to dev_net(dev) in
> > ndo_init(), which is called in register_netdevice(). However, it lacks
> > the context of link-netns when we enable cross-net tunnels at device
> > registration time.
> >
> > Let's move the init of tunnel link-netns before register_netdevice().
> >
> > ip6_gre has already initialized netns, so just remove the redundant
> > assignment.
> >
> > Signed-off-by: Xiao Liang <shaw.leon@gmail.com>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>
> left a small comment, but not a blocker.
>
>
> > @@ -1565,6 +1565,7 @@ static int ipip6_newlink(struct net_device *dev,
> >       int err;
> >
> >       nt =3D netdev_priv(dev);
> > +     nt->net =3D net;
>
> This hunk is not necessary as we'll call ipip6_tunnel_locate(),
> but it's harmless and not worth reposting the whole series given
> we are alredy in v10.  You can just post a follow-up patch after
> the series is applied.

Seems ipip6_tunnel_locate() only sets netns for newly created
devices (for ioctl). ipip6_newlink() is calling it to check for
conflicts, so we might need this line.

Thanks for your review!

