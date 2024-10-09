Return-Path: <linux-kselftest+bounces-19325-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CFA996229
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 10:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9391B23F3E
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2024 08:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95B9188587;
	Wed,  9 Oct 2024 08:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i879GOZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA3184535
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Oct 2024 08:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728461688; cv=none; b=N5BkfmCdeHSUo8nrSccKmM9HdNff4vxKYWeZdvZPLb5QQIVR4S16R8PCaTJHzlZ8BIdqVOwxcR18aiRDIIyM6/ji4E/ubxQN+u4cvphOwQ8SBoSgRmt+tpSBdM+Qpze7y4ZZPCyh2UFbE5oS4dg7ibzMe7nl7sVrlyNqw58IPOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728461688; c=relaxed/simple;
	bh=AXLP2KyrAqjaejcHnTbI8HMVGaKN1T0qdKQjIwPuqBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HkFdi2oavzSkrwqW2g22Zw6yX5ACeEGw6Xb9TuwJHWpfcIuh3xLGR4jNc+eXy27zkbrkehTi6/4Mr48hu8NJdXMAomZWfZGn1el12rW6A6gya9MG2m4HnLTS2TjvdacwK4vPighS6IXAuP3ZT2AWKDSrbWpDV8xizimEpLfppN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i879GOZe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728461686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
	b=i879GOZeQxqFyWzemKKfXniaBGnOuG6T3vh9qzOSMU+FdqJzPushct7/UukHy5N0mm/Nnp
	P+gCbs3begxX+YxCDzF++Oa0EsciirdfgHyWZttjBJIBxF4m8nMg7FAKSMow51dpCTRpyQ
	8kWZVY0zn0WIWoDOkGHJXFvlEvkXOVM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-pxmtmgPPN9qDsOwNqJg8oA-1; Wed, 09 Oct 2024 03:45:12 -0400
X-MC-Unique: pxmtmgPPN9qDsOwNqJg8oA-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2e281e07f14so2234767a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Oct 2024 00:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728459912; x=1729064712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7WnLoztQpWL0UuoG5WJ33odis8tMGytHkOB4fwng3Y=;
        b=mUSt3Rv5f+Fn8qtb4eMapecwz7dVnYvwzw9Ka05DJg5E9VTRSNbwEb1a1LKFCv/5KN
         heZNzwl0RmQoqR/5rWIOrvgI/3EFqFWeGYBGoJwMNTVIxDdS9e2mr2vYJ+P/YHxVbYRH
         lVYmcA6kASuPNTVZkDYFYkwDY3MBOKZzI02Q8C//SCoZcnjiQh/O9gmryCGSg88lEZmG
         jk3QgWjbAemu52RqX9ibsPBaOaQEQvp7eKs+omaWSDv9edNVe9hRQZGkxejMGlMR1liO
         9w64Aa1mXv8uPlXFGfbzY4j+JiJnVaWW4khed7V/EvwIrE1clrNRK5aG0duItjTf0fvQ
         ZigA==
X-Forwarded-Encrypted: i=1; AJvYcCWFUdDgAMeBH6y3cO0sK2gSrZerDdVp4QVfnS2nQweS1TsLuYdKIfe1wVdbClYl7PE3Acq5n6CgvKKv3tMTESM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt22DoxRzC9T8W69mlQjpsTEYleHpCHYZe0GZZCFddYEqK5qs0
	N4/rwP+1CTuFO/8zUM8Wbu743fUhd3sdSxOzU7sXWxXyMjruIsmWutEz18ySPlnR4Uh1l1inqi4
	4bL8FsMHP54rKzsd6yyC7qP/rHrsyG1P8fODNG+iMdktE42u1QO4Kj9Gn7aNKAjyg+DLBYiL8D4
	0KnJSAlmAunmpjAS2TgAmyqmwGnLGCPEvoBteK+SFO
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id 98e67ed59e1d1-2e2a2587e6cmr1772587a91.40.1728459911727;
        Wed, 09 Oct 2024 00:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUXS3Vu8tqbV1XHkGBTCNaL2VDRz7beWlworvX+yKRqbV5bgZG5ofneJzBijB1Dsili4oRB7g3ygL6aKFSPxI=
X-Received: by 2002:a17:90b:4a52:b0:2e2:991c:d795 with SMTP id
 98e67ed59e1d1-2e2a2587e6cmr1771623a91.40.1728459881543; Wed, 09 Oct 2024
 00:44:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008-rss-v5-0-f3cf68df005d@daynix.com> <20241008-rss-v5-5-f3cf68df005d@daynix.com>
In-Reply-To: <20241008-rss-v5-5-f3cf68df005d@daynix.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 9 Oct 2024 15:44:30 +0800
Message-ID: <CACGkMEt054F1AZP7V0ocbUce_AvQV_Cw-K21y7Ky1gWa=eSpCA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 05/10] tun: Pad virtio header with zero
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

On Tue, Oct 8, 2024 at 2:55=E2=80=AFPM Akihiko Odaki <akihiko.odaki@daynix.=
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
>
> In theory, a user of tun can fill the buffer with zero before calling
> read() to avoid such a problem, but leaving the garbage in the buffer is
> awkward anyway so fill the buffer in tun.
>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

This sounds like an independent fix that is worth going to -net first.

Thanks

> ---
>  drivers/net/tun_vnet.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
> index 7c7f3f6d85e9..c40bde0fdf8c 100644
> --- a/drivers/net/tun_vnet.h
> +++ b/drivers/net/tun_vnet.h
> @@ -138,7 +138,8 @@ static inline int tun_vnet_hdr_put(int sz, struct iov=
_iter *iter,
>         if (copy_to_iter(hdr, sizeof(*hdr), iter) !=3D sizeof(*hdr))
>                 return -EFAULT;
>
> -       iov_iter_advance(iter, sz - sizeof(*hdr));
> +       if (iov_iter_zero(sz - sizeof(*hdr), iter) !=3D sz - sizeof(*hdr)=
)
> +               return -EFAULT;
>
>         return 0;
>  }
>
> --
> 2.46.2
>


