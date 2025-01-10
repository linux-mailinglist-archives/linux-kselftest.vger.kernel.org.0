Return-Path: <linux-kselftest+bounces-24175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54693A085F4
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 04:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F14E18844AE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 03:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67637205AA3;
	Fri, 10 Jan 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PC20kvAB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974401E22F0
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 03:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736479674; cv=none; b=etgIWaDoXJlSwVX0MhYxoEoEvZYLLV7nJSwykmqkiC691T+3eClcPSVcfrh3Ahr9Iw0EEmUfk3H7DcRUj8yMrrLO/mHl09SF8QZY40ybwxV+543Yh1NJhqV0zZefSIfzA1h6hlozAIr/SDCwzgwXpl9f8td3sRZ+tLhNbHSAKUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736479674; c=relaxed/simple;
	bh=bvWTIT+RRjRSbxQiao2G4A++ngFStBHKJpnvXhynHk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dsd83ihr5WxJzftZQc5DGzuil+wSiVJbs1hSNGud0MtY002skKDnKK+IJaNCqqI6KUNYLheBO5pS5rNa5u8s+ew+WNNV9BRe9DBWKn15LompK0LSw+3wLcwGrSg5956dUGqmJGIMsC/JuXNVJ4/lSAEEuSRGLD8Y4+98tmX7vMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PC20kvAB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736479671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iajL1yDgIUIr5hibojx7mafI5SxR1wepNTMSNzOVtuU=;
	b=PC20kvABsfvfy6Z/+muDX++E9b5N9/eSCbhahHRjoP9miPSAKLG4GFtkR57RMk43jNfWWT
	GmYvdo51Hj7YPd/Ya5SvNMrNJlnohyESVcOzL9rgibiLZMReJKqoiz5R0wA83FQyxciYE3
	MUF+0TDS2mgByOh8EW/5A45JP/fkpCg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-fZ3JrsB_NTS4FpIjESOI6A-1; Thu, 09 Jan 2025 22:27:49 -0500
X-MC-Unique: fZ3JrsB_NTS4FpIjESOI6A-1
X-Mimecast-MFC-AGG-ID: fZ3JrsB_NTS4FpIjESOI6A
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2f2a9f056a8so3002239a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 19:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736479668; x=1737084468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iajL1yDgIUIr5hibojx7mafI5SxR1wepNTMSNzOVtuU=;
        b=VfqpgTPtezvQSkVu6FStTHe1w0YWAT4wuMfErFYubWArkxeYogMZk7+IgQDI928i6J
         oqH6PNhRS83by2ugVNUawXRkrKw4qysLhkU91Ow4FhQ1JuwnI/f3kRV1pi+xg4PBl8fm
         /i5jLV421F+k1/puq0fO76pkSGQc9NBBaNCIklPBT45l+NzMOq8Ha1LhPEZclBC2PcEm
         oLERwKSpFnZlXsZyHfvL/J+3UuZiJMdEdvvFPCRPN+N0MqMzWtjP4yjIYL405tK1AJ/0
         vFNCqz747weOVh5vNji/JxsRk2aeAoTDyi5GoJeJrhdNgrtUVzez+CIm6bFyqjzW9+r0
         ezLg==
X-Forwarded-Encrypted: i=1; AJvYcCXpH/NMZPt29SaMY4E9E5FFU81e74TwCwc5y7sVIajNmz9iCB2xz46PDEfqorM1UiqQ41EgsLKs10NdNhzaKMo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi7T9VKF1FV5CDyMWono9/e8jNCRRzLP/psKJlZTEzVJVEU0v8
	DeKx/aL+T5/iFNm+aq5DY8OvgBcXzMU42pLfRwIo3Ic+wsXN9noF+K30wgQbnbESxvwjBqN5JZA
	AN3i/B8H/SC+F2ZZmRjHMPpneMGLsS/Q/D817Pyh9P8mrbwc9Qt0puPAeXhWm0Lc1zdTEfBMYUu
	UfYKKmfLpmcMSbWWa5G9KeOhTe0On396of8HpIJWkG
X-Gm-Gg: ASbGncsz4HxawMbPFMnB5lK5A4t01Rmo8fx8lA8Nfb9xUF73qGNAMHUVtTX7ZdKOCQE
	EZgS1r6Y60sMK8c83RWikxLy6593LU5feJGtiRhE=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id 98e67ed59e1d1-2f548e98ea9mr13264764a91.5.1736479668660;
        Thu, 09 Jan 2025 19:27:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM0zVlBA7j66fikaniieFtidBDy2a+ngdaxzHXHvpNz92dgP0y0YBOPXi63aR37F36fwt1W0RporavDwFYaFI=
X-Received: by 2002:a17:90b:2f4e:b0:2ee:f550:3848 with SMTP id
 98e67ed59e1d1-2f548e98ea9mr13264741a91.5.1736479668256; Thu, 09 Jan 2025
 19:27:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com> <20250109-tun-v2-2-388d7d5a287a@daynix.com>
In-Reply-To: <20250109-tun-v2-2-388d7d5a287a@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 Jan 2025 11:27:23 +0800
X-Gm-Features: AbW1kvblvM77hJwOCPbcZnQaLsOAKege2X0nqRs93PNDqFsP8xaZKCI_l-JSk84
Message-ID: <CACGkMEs73Pms5FB3ouzrLsDjAsQ4OhMMDVD2LnO6kVHCsN0A0w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
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
> tun used to simply advance iov_iter when it needs to pad virtio header,
> which leaves the garbage in the buffer as is. This is especially
> problematic when tun starts to allow enabling the hash reporting
> feature; even if the feature is enabled, the packet may lack a hash
> value and may contain a hole in the virtio header because the packet
> arrived before the feature gets enabled or does not contain the
> header fields to be hashed. If the hole is not filled with zero, it is
> impossible to tell if the packet lacks a hash value.

I'm not sure I will get here, could we do this in the series of hash report=
ing?

>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>  drivers/net/tun_vnet.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.c b/drivers/net/tun_vnet.c
> index fe842df9e9ef..ffb2186facd3 100644
> --- a/drivers/net/tun_vnet.c
> +++ b/drivers/net/tun_vnet.c
> @@ -138,7 +138,8 @@ int tun_vnet_hdr_put(int sz, struct iov_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;

There're various callers of iov_iter_advance(), do we need to fix them all?

Thanks

>  }

>
> --
> 2.47.1
>


