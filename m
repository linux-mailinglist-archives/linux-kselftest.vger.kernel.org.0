Return-Path: <linux-kselftest+bounces-19606-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D44499B660
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 19:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D076282ECF
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Oct 2024 17:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C5E823DE;
	Sat, 12 Oct 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZCvm5VC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1031E529;
	Sat, 12 Oct 2024 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728754822; cv=none; b=Z23C0QzRJDxSFpEjDAUUcLMp5W1DfaABE67uLFuW86dcoE3xToGMz/3H9oDLWvTura6Ml5ZusobCUdqgDb+xc7vsC/4CvoOL/YWRDyenDZrA2y3j7cdoMC9hUhEcccJdP4Bg0Kl70Tmoi8YwaQ98ZI1uKoqgDgmFtzxickVi6VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728754822; c=relaxed/simple;
	bh=j+0eugA5qlshkzOWKhURgw3WOGiDbE79dVsJbtUFeow=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=oaNHgbKv8/MXQmYOqdsoC+V1SI5lRyPVwGkO4jfp/UIxbncV4mWpHQ56FnpmFZD531ZUBANXmo/2vMjVLsNDg+S03J8zcS3hGp9xKIq3R5/s6iGXyvtobUUOwxUhu8Msq3RsTGYaKcmcJvx2X7eoMrCWZsb0io3+udhCJqM3CBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZCvm5VC; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7afc5925679so199781185a.3;
        Sat, 12 Oct 2024 10:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728754820; x=1729359620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qeQVh5vaiF4LZT4ihfN5o5UvxngIEpWBJHf7f40MegM=;
        b=eZCvm5VCYp/LZJpGzPs060EjyOHR2THPclhS7YUG0LYAsBTFigTWV/qLfo0kO8by7S
         E65OiJYfbL3ZesVIWzZnW1zbA8PFJyRczjMcQTplbLqWmkHacP6SnfKPvOVqOEDiITYJ
         OfJAJ0i1v1I62yE5RPccZzDjOKLxxykYBdUHGOf/EcJ1fwxp0vTeM2Nlh/dS4VG1EhL9
         x9goVd9FgCINdYdWE9zdaxTEVSGKe7nDYHvZt/mSHuKiFrWS/rf8L7Ec/vJwqGus9pHk
         e2K44mNtXCsoVWSfkq7xU9tvdJEvL3LUVIdrRoKiNuMVs8IY4ojWHJcEAnG7kAdwW21Q
         fcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728754820; x=1729359620;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qeQVh5vaiF4LZT4ihfN5o5UvxngIEpWBJHf7f40MegM=;
        b=VktZInrqqBtD+QyMi0+9tA1/vwGr3vafqIEOKx5RYB4S2wr2T6kSh5gYYLm6NqQ9Ru
         TKzel2KwDZImceRc4D9AnV26neMPkPC/B0bcAe5p1lg4WrPRL1mOcNrSZJ+gte03CKhJ
         LIFrya9zBCe5T9zOuv5f2pH3tWyBaYGvW6QT6wUDxxPLYiwmZ/W520sVDnuDaBi/Vdq0
         ngA48WeHCJQ/pCTR2d+2uk0sOYsrY6vWvXgLFkM89zhenr0aabtQRwwq4ClKdNKgcRKx
         qhIKL4YGAXuBIApoSDs0pYvkXevpsjopFASIHQjGy8GHfqPrjiCicoHf9fJw3QfbqDac
         AYfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMv/N1PEvTVl61Mq5CHelYmF6mtp415xVq/A1TGb8Tqht6wWfA9AnT22VjU6GpG8q3//k=@vger.kernel.org, AJvYcCVTnuGEBOSy6KdT3vnyHQBn3wQvS5Lhawe+8IAb0MeB8Y+vs2B2IdyZzR+8pvwcOBrjrLfuxY0KnwHI@vger.kernel.org, AJvYcCViWhEfQRwpgJNYCP1neiZ8BJkyHb4eqMenuPHiSyfP1k2ubvC2oGMAs2NfjCVe65p2Ej6keuioYlyQATYY@vger.kernel.org, AJvYcCXbLqUowG7YzRhYD3kC/ZoRGeTJXmv5uxKhTy9KeOYmMNMTSPcCzzG21OkyMUoPvdvAL2JUotf064rB0nB0gUEZ@vger.kernel.org, AJvYcCXmUGvT/NtvQfOlKWQSdI7/nHMLWHgpFE/J2bdzIE2ZPyg+SolShdcw7U0uoT5Gj8b71qHlBz13@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQ1kXvi+7fbqpo2SXIQVXanKHkURLs6R9BVAUqzUXj+5PmAUr
	h7dcw3Gl+IIwsYIyFVOvKQnTVWE5ZS03yUTimtE8tXqFu1l1/G2j
X-Google-Smtp-Source: AGHT+IHm4Bx8DL3ED0EiIGa9UoE0AQ+a9pp5rid+2GyH7NTS4vnz6h0mFmR06lQvNNdN+JG5fbYMyg==
X-Received: by 2002:a05:620a:4446:b0:7af:ce6e:1663 with SMTP id af79cd13be357-7b12101be7bmr436841385a.60.1728754820032;
        Sat, 12 Oct 2024 10:40:20 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b1148c7129sm240855985a.19.2024.10.12.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:40:19 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:40:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Jason Wang <jasowang@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Shuah Khan <shuah@kernel.org>, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, 
 linux-kselftest@vger.kernel.org, 
 Yuri Benditovich <yuri.benditovich@daynix.com>, 
 Andrew Melnychenko <andrew@daynix.com>, 
 Stephen Hemminger <stephen@networkplumber.org>, 
 gur.stavi@huawei.com
Message-ID: <670ab482ba75d_2737bf2945a@willemb.c.googlers.com.notmuch>
In-Reply-To: <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com>
 <20241008-rss-v5-1-f3cf68df005d@daynix.com>
 <67068a7261d8c_1cca3129414@willemb.c.googlers.com.notmuch>
 <30bbebd8-1692-4b62-9a1f-070f6152061c@daynix.com>
Subject: Re: [PATCH RFC v5 01/10] virtio_net: Add functions for hashing
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Akihiko Odaki wrote:
> On 2024/10/09 22:51, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> >> They are useful to implement VIRTIO_NET_F_RSS and
> >> VIRTIO_NET_F_HASH_REPORT.
> >>
> >> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> >> ---
> >>   include/linux/virtio_net.h | 188 +++++++++++++++++++++++++++++++++++++++++++++
> > 
> > No need for these to be in header files
> 
> I naively followed prior examples in this file. Do you have an 
> alternative idea?

This is long overdue really, not specific to this fuatre.

And extends to your patch 4 that deduplicates tun.c and tap.c.

Perhaps drivers/net/virtio_net_hdr.c.

Or drivers/net/tun_vnet.c, matching your choice of drivers/net/tun_vnet.h.


