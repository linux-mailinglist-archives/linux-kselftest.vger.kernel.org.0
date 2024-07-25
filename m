Return-Path: <linux-kselftest+bounces-14236-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5D93C41F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82FFF28562F
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 14:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5325C19DFA4;
	Thu, 25 Jul 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmjCUg2s"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BB19DF82;
	Thu, 25 Jul 2024 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721917676; cv=none; b=d+6GtBxtuALze8osjp9/LPDrStR6cj+zB8sFkvq/D68wnZLwbepiLvkNs1x12oiHBKij4xyA5m3KMnl8HMar7kUqot+tWbGXgfjkX14FnSrueyeZ5xn6yStM6m5+Mses3K6Jgztj5N/GdSqnbqyCKRAMjCyc/+Nrod7f7PAFlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721917676; c=relaxed/simple;
	bh=XHO1nFBL0im1uK7xwc2iVzZ8l8PrKgpCKDDqZg7yXV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IAKZKkOO5Xz6a9GON/OY1UVIm6l9iANinads9XzyKQhuq9/vn4b3bir/jsQtWRhDnxkd30fb0EjI2Aou/VK5angPtrhGO4lyr7JlqXU0W7P2HtPfbmfrkht7J6vEeNNhWfAYU+9DK7qXzqS/96KSNYQ3wWEfAGlWGKJhp+Z1ZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmjCUg2s; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db14cc9066so410793b6e.3;
        Thu, 25 Jul 2024 07:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721917673; x=1722522473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFCck7sxDvRtwwI607C6VaRUtbYIw5wbK945M/Wp52s=;
        b=YmjCUg2s0wxyOejM5HwLL2lifetdc5HIXdbxvX1ugazmXU/9OcC5oK2dnK4UCIlvJE
         G0QBB1Yf95Hjpk4f97Q6OlKHLkUgceWBR5UR4Vuo8OtCn0GgFl+G1tq+KkdPe4eJAl4h
         Eid2BbtXIXycZYcBDvBD8draviiR2KruzEqU6Q/GeBiIpGXLI5kBY9LoJtrrdNXayaLg
         Q6CtGiNVM6llCFilTj9qIOsYS1FAfLAoDBJJOO+qLIOqRAM+WpJG27PVlQkjETA7yMM0
         7kv+CN3VcjK3sqpYEMn2IriA55U0DG6yh7Yh14T3ntO6kMyhYrL1hlmEKkcDUv9+JjPZ
         +mqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721917673; x=1722522473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFCck7sxDvRtwwI607C6VaRUtbYIw5wbK945M/Wp52s=;
        b=lGLsU7OUk/8XhsNLFwPaGtow79cio+zZbbRu/5ht6b3UR3rDy1kb8zfaf9TOGNiU86
         ECtLF/kScWSaORag11wl4gVczpVp75xEUKOAyWffL+nsJxLKqYRapB6OE74VdsZgu/Jb
         Dc1V08lFNF0s7Yvkm2RWpvRAq9N8bn+SWV9G5KTs/HPd7mzB1iCuQOxVTW5heLmVwTns
         W7ZMUOZD+lp9rC//AEaqE+tdCrdkPaRapQdowOzjpHtuPdvPkLBD7jddw6iFq0VLsr7y
         nAgCuKSdHrqid6O5Sqt+XPnC0Ixd6FqToDDQND+m0K1nrQD3J1U8twViuK+IjaybM3lh
         by4A==
X-Forwarded-Encrypted: i=1; AJvYcCVpJD/vkrfugBb8LWdJytV/FuA62alOf/jYreuiEzChkDlB2zVZfzhDVLa1oXQidLTEe9SwxET9vTWPIG2kYCZ/5UIS/c5mnMHPS8YKbJiIAv0gurmaBg07hHt9PRnrQfJVkvYIKr9p
X-Gm-Message-State: AOJu0YwT3f+AeSSoxoX2NAo1mopxj+OCdQotF1dM/DwVE64R/nF1UvVD
	BhDtLwZAKfmjTc2A8aMD8DXaMB5WagOL6i6sDn0Fo68vWz9r3fGq2sOSsE44YIevnJIUxS4BqQO
	IX7JKy6bSivSwbv4ZZuu2TTShk9M=
X-Google-Smtp-Source: AGHT+IHPbvYGSnJR0GCBEsQswJKhQFu8SSG99BreHttMoIIqrMlrP75kEoeevLP4byiQ5tutKuOkj52VVk/J1v94Brk=
X-Received: by 2002:a05:6358:41a1:b0:1a6:b070:a58e with SMTP id
 e5c5f4694b2df-1acf8878353mr440623855d.9.1721917673197; Thu, 25 Jul 2024
 07:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240723223109.2196886-1-kuba@kernel.org> <20240725092203.26366-1-arefev@swemel.ru>
In-Reply-To: <20240725092203.26366-1-arefev@swemel.ru>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Thu, 25 Jul 2024 10:27:15 -0400
Message-ID: <CAF=yD-Kz3PRncy4N0LkTSDGm95Zg7yfKDm+BOHBs4NfkEDSJUw@mail.gmail.com>
Subject: Re: [PATCH net] virtio: fix GSO with frames unaligned to size
To: Denis Arefev <arefev@swemel.ru>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com, 
	eperezma@redhat.com, jasowang@redhat.com, linux-kselftest@vger.kernel.org, 
	mst@redhat.com, netdev@vger.kernel.org, pabeni@redhat.com, shuah@kernel.org, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 5:22=E2=80=AFAM Denis Arefev <arefev@swemel.ru> wro=
te:
>
> I checked the patch on three reproducers and all three DEFINITELY broke t=
he core.
>
> There are two malfunctions.
>
> 1. No flag skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
>  If it is not set then __skb_linearize will not be executed in skb_checks=
um_help.
>  sk_buff remains fragmented (non-linear) and this is the first warning.
>  OR add skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG.
>  OR ask Eric Dumazet (cef401de7be8c). Is checking if (skb_has_shared_frag=
(skb)) so important?
>  in the skb_checksum_help function, is it enough if (skb_is_nonlinear(skb=
)) ?

Thanks for sharing the reproducers. Having a look.

On SKBFL_SHARED_FRAG: as Eric's commit indicates, that flag identifies
packets with contents writable from userspace, such as vmsplice or
later introduced MSG_ZEROCOPY. That is not the case for these packets.

Setting the flag may have the desired effect of triggering
linearization, but it does not match the intent of the flag.

I think we can catch these bad packets with illegal csum_start and
simply drop them. The question is where is the best place to detect
them. I gave one suggestion. Great to have reproducers. Let's see if
that indeed addresses them.

