Return-Path: <linux-kselftest+bounces-24173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3417DA085E3
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 04:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D573A9CAD
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564CD1E22F0;
	Fri, 10 Jan 2025 03:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGoWxuua"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555286EB7D
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479503; cv=none; b=baolT/AWcT3sQBPwiPQVcndI9MYm4i78NAbdJRKVCX5otq2B4752bprCJqA+u/A+PELx5MOCo9B/RKrV6AmX3pHABbw6jsrBVyOjcGf7owv/tLbSJwAecqc9z1GLyR2rUUuShArPODHd20ysawcmPyUUtAhKLeCY2OSy6p0uxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479503; c=relaxed/simple;
	bh=xiIZOksV9gK8x5lTS+rlahAEFaL/qj64KXL6RVencw0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XPGVTbJuf8CYb102zwepKJSzBlFyqF1BmSpEFeCEJbmuLo7fXIJJCnwp3lExdR4DyixHDQBb/a/WRK1/4SoNa+xTzuzmn/MH2VOdpOPs3hpm0uHmBOQRtx7on3lAcFmjrxP+Oq6zXTMtT29nuReVsYQ5pdhSkMU1S+frRHc13g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGoWxuua; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ux/EFJGUhHtGiPWKsNCatUDg5uRU42FVCWFIHQvV8s8=;
	b=FGoWxuua4vh9ZGE34vxHBfMXrmAA0IqaqUQSOfBG14Fh7uMn7akli2l2u5ChCY5ZzuQiai
	o3YzTmCAGJczKmJVWDj/QvsEw8WVVAySuMG3y+UmmTVj+YEtpATcoctzDK/WfsG1GDdbiF
	EMBAkw/0kZAYfn+UfNrFcYCF29oT4Qs=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-QYx2z-wNMrOXtiqbxDjU-Q-1; Thu, 09 Jan 2025 22:24:58 -0500
X-MC-Unique: QYx2z-wNMrOXtiqbxDjU-Q-1
X-Mimecast-MFC-AGG-ID: QYx2z-wNMrOXtiqbxDjU-Q
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ee46799961so4206804a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 19:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479498; x=1737084298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ux/EFJGUhHtGiPWKsNCatUDg5uRU42FVCWFIHQvV8s8=;
        b=mPwacPdi5bpAcSwnN9j1vOhhdmlJCrCWrGWmtBDXPGimHdtKxfdlfJGWISgNLCQMpT
         ZnbdG0rbQuihET1gtvLt/4TSJFOtBcA7TYF1/4zJYVyF6eXwTqRe6x35UOBNEIZDdVpJ
         AMhS01+jknMw98Zqi2Gw1EJvRHN83DDzolfNPlKkPIUP7aUJM2UuDpjTOyA9cxh+XMa/
         CHFEP/rn5d/6Jw2Kb3kjZI8PXnUYbLcfd9QrGaG/Gs8xou14e+/g8eWILVwbfNfjojSf
         1QTCV5iNsAg7nH0ItGAvm3VqO+lyoJ4G+WIuubeZxLbUY3fVWpktsn2twfXzP6Anai7k
         3fRg==
X-Forwarded-Encrypted: i=1; AJvYcCXWBQ2D1Pnayx+C3c074cFgEpX13cAje3IC52FZ7IzWbXi9H4TDd7godhIjcKkitmFdVJsQg1j08Zfd1DL9zE8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1tyXlzh0Nxe+nVQ+Wi+SNMuNLkXH93g8vIMjcpoVJFwpTjHBV
	5nbWBHdHLPxkC311WFQZteU6VdqDIFj9YYv0q+cT6AUxmNcnn7YcopKUGmDm0DNwE6afj/9uQHT
	suKVLu9MBwPmqdsVRid9jIUVbnjRUPR1IJBPVTmvBYpfz7WRmW+2/zHFw6qSiFiEMbaRdwHfBmk
	No6wVJCDcfgONsow/TWhdCkpuz9z1aTRuroNO7XQ1t
X-Gm-Gg: ASbGncuPu0iCSj3cjBYPM/a+Ta5VHcx7xqL2G7xsMd7JKwRQ1qkiA3DnvocYOsSL9/e
	MWzhv7PenAsB43SkIE2MaasJTZ75w7jqTafdi1oc=
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id 98e67ed59e1d1-2f548ece7afmr14119978a91.18.1736479497870;
        Thu, 09 Jan 2025 19:24:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGl4su9kuwxLueN6s9pabolA/u0yv9vnPxFtYkK0ZVCk201Nafu3Va6ZCJu8GUQ/vQJh85IIDkmsOql8mxd8mA=
X-Received: by 2002:a17:90b:2f45:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2f548ece7afmr14119944a91.18.1736479497484; Thu, 09 Jan 2025
 19:24:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-1-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-1-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:24:45 +0800
X-Gm-Features: AbW1kvayDbWMw6YuULfNbkLhEoUv0nyH0UVx2PFd5rLWnQcrUga4t_8H0CMLDNk
Message-ID: <CACGkMEs2S=G-Y077hCeFE57ar0h1A5EaySOOTcvFZUVC0oGdXQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] tun: Unify vnet implementation
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com, devel@daynix.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 2:59=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
com> wrote:
>
> Both tun and tap exposes the same set of virtio-net-related features.
> Unify their implementations to ease future changes.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  MAINTAINERS            |   1 +
>  drivers/net/Kconfig    |   5 ++
>  drivers/net/Makefile   |   1 +
>  drivers/net/tap.c      | 172 ++++++----------------------------------
>  drivers/net/tun.c      | 208 ++++++++-----------------------------------=
------
>  drivers/net/tun_vnet.c | 186 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  24 ++++++
>  7 files changed, 273 insertions(+), 324 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 910305c11e8a..1be8a452d11f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23903,6 +23903,7 @@ F:      Documentation/networking/tuntap.rst
>  F:     arch/um/os-Linux/drivers/
>  F:     drivers/net/tap.c
>  F:     drivers/net/tun.c
> +F:     drivers/net/tun_vnet.h
>
>  TURBOCHANNEL SUBSYSTEM
>  M:     "Maciej W. Rozycki" <macro@orcam.me.uk>
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 1fd5acdc73c6..255c8f9f1d7c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -395,6 +395,7 @@ config TUN
>         tristate "Universal TUN/TAP device driver support"
>         depends on INET
>         select CRC32
> +       select TUN_VNET

I don't think we need a dedicated Kconfig option here.

Btw, fixes should come first as it simplifies the backporting.

Thanks


