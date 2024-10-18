Return-Path: <linux-kselftest+bounces-20113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A9E9A384B
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 10:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77F01C2120D
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E9F18CBEA;
	Fri, 18 Oct 2024 08:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SurcIdm6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19DE183CB0
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729239330; cv=none; b=llguEJEDrzSEyV9/3pz5l1jS/OUEI23kBJD9qP6xMca9yfNMjA+2R5W7eFQ61Yt0sP10tIRAXFocWCTuMVBuF4iaoISmXq+aFiVi97GuE55DZ62VAf6D3Ovt9XXLMVXXEIU4CbKWP1eTUjb6ETA+Bm8bnTtk6OXDXndIC7JyyXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729239330; c=relaxed/simple;
	bh=RyCuiX7Z7beQNgjkYjzS1E6I9EFHABI+uLFOdorHDUA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REATReWz1SjdFQl2w+Sl9/3tTYWcDSlTOLcQnhbzWEcUM7tyofjr8/uAopvkadAebgVNIdG1Z7eVhrjsW2vyuKTzqyBR54PDihXpymPPrfLsmRkAtD8fcJ+iG5uGf2bR8Bq6q65EK2XNwZvu2wsQWPiozWB8cJfgQoCEMItS5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SurcIdm6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729239327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yr2YuJLh1oBlVb3LAJ7sYOHk9wkq05eBctRIWz59ZDw=;
	b=SurcIdm6DneiQRILf//r8UdHEP4CM454HX008sS8QK7o6BpWI7H+8FNQAsrvYseJG+QLiL
	+O4fKlJQvKWjZs4HNeC9aOG1BF/CkiXu0cswQOGWW6aXUbEWHIErQ0On57ZhFFlSmjOLhe
	OTUDlk6sAwmo3qamnQ31COJdyiQXMIU=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-jZZA-Qq4PeSRD7q_zGjNcA-1; Fri, 18 Oct 2024 04:15:25 -0400
X-MC-Unique: jZZA-Qq4PeSRD7q_zGjNcA-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-7ea9acf089bso1436118a12.1
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Oct 2024 01:15:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729239324; x=1729844124;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yr2YuJLh1oBlVb3LAJ7sYOHk9wkq05eBctRIWz59ZDw=;
        b=Ml7nwadK4j6Ej2PYuSh8i+GGqtqrDuscSn4HONMCA6WEmRN++KhU0l1Ypj1yQPabes
         Gx2Ut0IWnSU5k9moRQCdCun3Wa+ORuGT7VcjNwVPw1RN9RLB9ReKW3XQIApG2s9UBJY0
         VGR6yOzlQJq288J2RCleZLqTlC5F51CovJvjlnE7oNRoNHeG/FkXOyii0E+Jl0c3/lko
         iPhdE/BNZBX+dVvGWgSvc7pQHBX/G0b567GsV3VFlo63GrBNyx92ppEQ/InPHwHG8frd
         k4tyVTKDU+09PoJgsrdXrKL8E20/JNePTV5XM3o0ZUsWRXQdo9Nlnl9ItI15+kWRIGbP
         XJaA==
X-Forwarded-Encrypted: i=1; AJvYcCWOF/Gw54mYJTSiW6EDOy7CGxCdOobNm7UAT788QpDy83aURgEeCckgpaExktXxCrums+MvxrwPpYMNLiz6d08=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0OwngIp3c0NmeidvCJaKHl0Ph/zDMLW0mfQH2cUgcQDUKKLGx
	HVcMQLxJDbk6eGZIrgtaWj0uEwVvhOzM4SMl7YyMfySJxdt++hAmz0r51Be0FJDfjNI3Cs0lwS3
	ZbfKIhFRMazSaBpKkv2pW4iVn+radWpO/HzRgBl6Wrl9nD8MWRqPMh4k8Ev5j96g84Sd59UVZt7
	YBxdoO+3XK7IZqvGf+PXOXVfRuEzfT1I2fy7O64McR
X-Received: by 2002:a05:6a21:178a:b0:1d8:aa1d:b30c with SMTP id adf61e73a8af0-1d92c9f8becmr2035164637.1.1729239324399;
        Fri, 18 Oct 2024 01:15:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGLD3LtPmdn3YgZFunCmr4YCke9ZeVKhkDNBtOgm6i/o4DVa5u2WpwUUag2e6tVVnOKvDE1CSmiKahP3Ex3VII=
X-Received: by 2002:a05:6a21:178a:b0:1d8:aa1d:b30c with SMTP id
 adf61e73a8af0-1d92c9f8becmr2035126637.1.1729239323920; Fri, 18 Oct 2024
 01:15:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-7-f3cf68df005d@daynix.com>
 <CACGkMEsPNTr3zcstsQGoOiQdCFQ+6EG6cSGiZzNxONsH9Xm=Aw@mail.gmail.com> <4bc7dfaa-a7cd-41f4-a917-e71b5c7241f7@daynix.com>
In-Reply-To: <4bc7dfaa-a7cd-41f4-a917-e71b5c7241f7@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Oct 2024 16:15:12 +0800
Message-ID: <CACGkMEtt7a4+gadQt2=3zz+MCUtueuWj+zwaHR_gXCvLg=0PcQ@mail.gmail.com>
Subject: Re: [PATCH RFC v5 07/10] tun: Introduce virtio-net RSS
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Andrew Melnychenko <andrew@daynix.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 12, 2024 at 6:29=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/10/09 17:14, Jason Wang wrote:
> > On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@day=
nix.com> wrote:
> >>
> >> RSS is a receive steering algorithm that can be negotiated to use with
> >> virtio_net. Conventionally the hash calculation was done by the VMM.
> >> However, computing the hash after the queue was chosen defeats the
> >> purpose of RSS.
> >>
> >> Another approach is to use eBPF steering program. This approach has
> >> another downside: it cannot report the calculated hash due to the
> >> restrictive nature of eBPF steering program.
> >>
> >> Introduce the code to perform RSS to the kernel in order to overcome
> >> thse challenges. An alternative solution is to extend the eBPF steerin=
g
> >> program so that it will be able to report to the userspace, but I didn=
't
> >> opt for it because extending the current mechanism of eBPF steering
> >> program as is because it relies on legacy context rewriting, and
> >> introducing kfunc-based eBPF will result in non-UAPI dependency while
> >> the other relevant virtualization APIs such as KVM and vhost_net are
> >> UAPIs.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   drivers/net/tap.c           | 11 +++++-
> >>   drivers/net/tun.c           | 57 ++++++++++++++++++++-------
> >>   drivers/net/tun_vnet.h      | 96 +++++++++++++++++++++++++++++++++++=
++++++----
> >>   include/linux/if_tap.h      |  4 +-
> >>   include/uapi/linux/if_tun.h | 27 +++++++++++++
> >>   5 files changed, 169 insertions(+), 26 deletions(-)
> >>

[...]

> >> diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
> >> index d11e79b4e0dc..4887f97500a8 100644
> >> --- a/include/uapi/linux/if_tun.h
> >> +++ b/include/uapi/linux/if_tun.h
> >> @@ -75,6 +75,14 @@
> >>    *
> >>    * The argument is a pointer to &struct tun_vnet_hash.
> >>    *
> >> + * The argument is a pointer to the compound of the following in orde=
r if
> >> + * %TUN_VNET_HASH_RSS is set:
> >> + *
> >> + * 1. &struct tun_vnet_hash
> >> + * 2. &struct tun_vnet_hash_rss
> >> + * 3. Indirection table
> >> + * 4. Key
> >> + *
> >
> > Let's try not modify uAPI. We can introduce new ioctl if necessary.
>
> 2, 3, and 4 are new additions. Adding a separate ioctl for them means we
> need to call two ioctls to configure RSS and it is hard to design the
> interactions with them.
>
> For example, if we set TUN_VNET_HASH_RSS with TUNSETVNETHASH before
> setting struct tun_vnet_hash_rss with another ioctl, tuntap will enable
> RSS with undefined parameters. Setting struct tun_vnet_hash_rss with
> TUN_VNET_HASH_RSS unset also sounds unreasnoable.
>
> Letting the new ioctl set TUN_VNET_HASH_RSS does not help either.
> TUNSETVNETHASH still sets the bitmask of allowed hash types so RSS will
> depend on two ioctls.

I meant let's avoid introducing an ioctl with function 1 in one patch,
and adding 2,3,4 in exactly the same ioctl in the following. It breaks
the uABI consistency and bisection.

We can add all in one patch.

Thanks


