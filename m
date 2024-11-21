Return-Path: <linux-kselftest+bounces-22391-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A959D49D0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 10:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C44231F2155A
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Nov 2024 09:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 077C91CB9F0;
	Thu, 21 Nov 2024 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i5jhTxvP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA3158D79
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 09:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180849; cv=none; b=KxPFbl+ldbuHpZvBj1guTk6DxZIPXFoG9sJViQIUt0O0aYeMRbv/5f6dfdqeR6TFt03nS51Cinjh7u/9xytDEg7mpCyyNEK5Gohp5QffI4IFARiy6Xsaizctc+zshQHVw/rN0+RDm1LIoieGJ7GaPjOmqd4061wfIoZ/WcuKK2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180849; c=relaxed/simple;
	bh=z3IzFqz6CGkWpS7Db68UfSWXKU8RdvRO9o8tJ0fBkns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBLjHOtuzv9wFTWxA6X4XFLrDeMBFMqdNxL8dV5z7UdT5SZmm9AraZlW9u6ZPZRc+lB8coU+p0fHQvgKDwjC9mEkAPQifBIw4JQZhOtRXErRtsiJlg/4dgUiUCas6osJXDxriqaEpeheO563BL00qlxiUYLg/7rUTzxFymA79Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i5jhTxvP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732180844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pe+KersGjDEJYz4W2aLOhFHR+iyviK6f7r1oEzw1+cc=;
	b=i5jhTxvPpQa348kAnP6f6fiGpQdb6rv4FjRueEIbP2sOMZRzHa070j0wDCjcm5bp0t1FMW
	3kNwGBDbK3udBC/o6LUqFAIjHngzHvub8lWWMoMGsH6AoAtvZOz42ErrrKwWDZrt0VoiI7
	6KKq/CDLV2L5xyw9WtU7fdkMAbbTPac=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-lppsjVHCN2SHrx7jKaZF7g-1; Thu, 21 Nov 2024 04:20:42 -0500
X-MC-Unique: lppsjVHCN2SHrx7jKaZF7g-1
X-Mimecast-MFC-AGG-ID: lppsjVHCN2SHrx7jKaZF7g
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-aa209443786so182088166b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Nov 2024 01:20:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180838; x=1732785638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe+KersGjDEJYz4W2aLOhFHR+iyviK6f7r1oEzw1+cc=;
        b=juw5xqoZ/ayYPfWYA8TApIy7yElcjxqYqprnQoz7x8S52F368OJmQeKe8n3/xYiB5A
         IX94WZAg7UB0sNGMou8maMVV1BsTKE7OgLvFUmaJMkyInARhhRy53EuvPlMInQCllCzY
         8tzgzxcorjTNjJIo1Nw//4O4ye77VG6cPBb4zw/2ZyI6uAkioKrCRXdOTRzaACOxdxDt
         MVJoUuzURLA9PulnzWq03sPtLjT1Y86NrHQ1xOlGH/hC5W8oA7GlMkIAwM1WcF1T2lvp
         31nj2vGjeOqQyTipmFwvZRcrr6d30SPAKqFfBHGT6A8xFHtVb0IhQZ6b8QXWFGv5xX74
         sP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUClzncKWE5d4CiQtehi1h4a8W2q8ddBDRG5xzRnbdbr7AUidlnf27txU/MzhamFBcyNRbNCJOXvEuxvqU+ul8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfNah33jvzEtld59vusFh38HJOJBaEcyYRdv6fnx/qNKzu3lIV
	+USXVgNwh3UfoxSCfhgtoGhv8dfGWscx5XfRZTZ4LxL6fmQvM2vXzi+lpXJDmnNlPZQV2prqsjb
	ER0nGYyg1yiBsliuAa/Lxdh9DxLnS3iNcdnbRDuArnqw3laTvIBPcbKcchgKUkz4k+w==
X-Received: by 2002:a17:907:2d91:b0:a9a:b818:521d with SMTP id a640c23a62f3a-aa4efb8cd32mr245017266b.18.1732180838238;
        Thu, 21 Nov 2024 01:20:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFR9VubEFl+IO+AiFGGZg/eRdEemUzuJZ7gugoLasmFePLIWVWdepkm95op+xuk3Bl3LojEEA==
X-Received: by 2002:a17:907:2d91:b0:a9a:b818:521d with SMTP id a640c23a62f3a-aa4efb8cd32mr245013366b.18.1732180837663;
        Thu, 21 Nov 2024 01:20:37 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa4f4380c16sm56352166b.202.2024.11.21.01.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 01:20:37 -0800 (PST)
Date: Thu, 21 Nov 2024 10:20:34 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf 1/4] bpf, vsock: Fix poll() missing a queue
Message-ID: <rkuislntcknwmj65mghggj3k7jzzp5s5pbs36zacijjhcoag64@p5srullnpbqu>
References: <20241118-vsock-bpf-poll-close-v1-0-f1b9669cacdc@rbox.co>
 <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241118-vsock-bpf-poll-close-v1-1-f1b9669cacdc@rbox.co>

On Mon, Nov 18, 2024 at 10:03:41PM +0100, Michal Luczaj wrote:
>When a verdict program simply passes a packet without redirection, sk_msg
>is enqueued on sk_psock::ingress_msg. Add a missing check to poll().
>
>Fixes: 634f1a7110b4 ("vsock: support sockmap")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Yep, in vsock_bpf.c we set `prot->sock_is_readable = sk_msg_is_readable`,
so it LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index dfd29160fe11c4675f872c1ee123d65b2da0dae6..919da8edd03c838cbcdbf1618425da6c5ec2df1a 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1054,6 +1054,9 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
> 		mask |= EPOLLRDHUP;
> 	}
>
>+	if (sk_is_readable(sk))
>+		mask |= EPOLLIN | EPOLLRDNORM;
>+
> 	if (sock->type == SOCK_DGRAM) {
> 		/* For datagram sockets we can read if there is something in
> 		 * the queue and write as long as the socket isn't shutdown for
>
>-- 
>2.46.2
>


