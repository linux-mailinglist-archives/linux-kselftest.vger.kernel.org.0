Return-Path: <linux-kselftest+bounces-29424-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F3BA687CF
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 10:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5387A1887359
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Mar 2025 09:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E93252903;
	Wed, 19 Mar 2025 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SqfL4RF5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9B2505C7
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 09:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742376086; cv=none; b=mi2cKx+gkHckwyawJvd/YzASOpsrp2nre0OTeyxcAA26+exuYdfGB16c+CzeWCfsUy/CD9msDjY3ZUZqqFZIPhKgoRLTrnzrdCFGFDbOePuq4qiOrIkKFZ6JUyGjhW9ak+2oUB225RpeP2mDIcmSFkbMI/r3AZa/rvyvHVb0dCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742376086; c=relaxed/simple;
	bh=hayqKUFA/zQJSjM3dzvjLdtKtJ8WDFXlSPyW2SDZhz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PC0BEb1ubMer7SENVbyub15H8PKlu9GpdfiP12BDmrSoOQUB8FkBagntY5PKQNZymQCiOjB0DMbYVCvPAnjdFXiBvU8Qk7o3PrDPNeBIRu1te/t8ZqJulC/mgjcNngnoYCjmiERxw/JAKkwphYii3//EhG2eAkF94gQ4bbq0YGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SqfL4RF5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742376084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
	b=SqfL4RF5On3PKul5OWVvei4wV8b8IBO64+lZ0pqKLcYPyrI3P97llBDZsH6LcLogBjH20p
	653J9Q/XKCdPYlYFh9RSNhRekl9+qG5NGVb/CqsE+jtlL5MuplvwHm3FWg702gb77C2U5d
	v4KUfkOBMq0QeEP9sZQw8mPAdQAEzF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-FJXWOy6WPUiiPpdpViVf9g-1; Wed, 19 Mar 2025 05:21:22 -0400
X-MC-Unique: FJXWOy6WPUiiPpdpViVf9g-1
X-Mimecast-MFC-AGG-ID: FJXWOy6WPUiiPpdpViVf9g_1742376082
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43ceb011ea5so26693495e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Mar 2025 02:21:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742376082; x=1742980882;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SBldNCvr3M04fJOmB6HQlMjvE8qJv/8GrRmjEF3wfqc=;
        b=od9tBO/Na1OtR1GFU0nqENwkh3PAVOYUX84qvtd7++tmNyu/+7ayNmfvIXe35ZHoTT
         SiDv1N21ELhJWbobr3P7CivdFuE5srO68AO1CABktPmnX5fqJ5zegMZTrhMQoqw+acfE
         dZQMnpLE8vjTijwwqeBvML4vjZJU+AsVPYRJyrdcnS6IwhsjcLyZ5KO6tIHKt32JVuVZ
         azJCyPweeTsemvs5KOvDLWmufALF2z0bJjunM6eA3KexlXMiohk+yukGRfkukZSSMcQJ
         EEfx6O5QSV0HOsMArlldTZ1++GZTMNr04f/wcBP/dnyy3BIFNVaKGzT1nrWA5SkMZkPq
         hIkA==
X-Forwarded-Encrypted: i=1; AJvYcCX4Qn/R+kEfjxD2klrZAgCliq1eXkWV1SZeuaeZ/HT9e8bxs2pYrTRaKYIAg1EVobzv4RoWTOKJPSu5VXeKHIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUhKglnha3FisyNYRQPAJ6ikMCFN5dm0qO+CMgqCdqarFmRFAr
	U+iW2yLB+cW1Bazwh7LhdPVallBGf0Fzs1Ph1aKw23uJ1s414vpRn1CCucHdS/lCmdRNt2ozTxP
	8TaWZ8I0KBwkJ1DkWrr8e9RWvTqnOUepIbsEKZzA6LJjenBvQCm20NP5VrE8cmERttA==
X-Gm-Gg: ASbGnctopZITPTLPZJORE5SakXciErivLdPQ2miMya/GN9PMESpXaeWsfpJZUWP8EeD
	wyBohuYm8SZnB09PAsgHeBKsyGcDmgisJU0da1vKJKgBYHycJvRzkrmgUHwtVHpjXkCzNFIWQ5t
	SAafhQzA2Zz1Jg6100hBj13Ro0WYnOe5Eq7eNhtvcGCPHnUjeiLhSlriqj9koU2zT+5Znm0BJll
	z7UdkCRGHq54UgrCUdrg2L3YlEU32H3yNAgr24ydhrZDWmt9CLyeTVyPhk35mZ2/Ypcg0Spx3fm
	EhjI0IWuWg==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15053095e9.3.1742376081560;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFTbAy+ec2vOHg58y5rxcFbvt1zKhjrhAbtgCtsF91K96gkFV7iO8cXVF5jgAUnN+dJQoKFQ==
X-Received: by 2002:a05:600c:4fc8:b0:43a:b8eb:9e5f with SMTP id 5b1f17b1804b1-43d43781d7dmr15052755e9.3.1742376081050;
        Wed, 19 Mar 2025 02:21:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f84f9bsm13000475e9.33.2025.03.19.02.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 02:21:20 -0700 (PDT)
Date: Wed, 19 Mar 2025 05:21:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v4 0/3] vsock/bpf: Handle races between sockmap
 update and connect() disconnecting
Message-ID: <20250319052106-mutt-send-email-mst@kernel.org>
References: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-vsock-trans-signal-race-v4-0-fc8837f3f1d4@rbox.co>

On Mon, Mar 17, 2025 at 10:52:22AM +0100, Michal Luczaj wrote:
> Signal delivery during connect() may disconnect an already established
> socket. Problem is that such socket might have been placed in a sockmap
> before the connection was closed.
> 
> PATCH 1 ensures this race won't lead to an unconnected vsock staying in the
> sockmap. PATCH 2 selftests it. 
> 
> PATCH 3 fixes a related race. Note that selftest in PATCH 2 does test this
> code as well, but winning this race variant may take more than 2 seconds,
> so I'm not advertising it.
> 
> Signed-off-by: Michal Luczaj <mhal@rbox.co>

vsock things:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> Changes in v4:
> - Selftest: send signal to only our own process
> - Link to v3: https://lore.kernel.org/r/20250316-vsock-trans-signal-race-v3-0-17a6862277c9@rbox.co
> 
> Changes in v3:
> - Selftest: drop unnecessary variable initialization and reorder the calls
> - Link to v2: https://lore.kernel.org/r/20250314-vsock-trans-signal-race-v2-0-421a41f60f42@rbox.co
> 
> Changes in v2:
> - Handle one more path of tripping the warning
> - Add a selftest
> - Collect R-b [Stefano]
> - Link to v1: https://lore.kernel.org/r/20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co
> 
> ---
> Michal Luczaj (3):
>       vsock/bpf: Fix EINTR connect() racing sockmap update
>       selftest/bpf: Add test for AF_VSOCK connect() racing sockmap update
>       vsock/bpf: Fix bpf recvmsg() racing transport reassignment
> 
>  net/vmw_vsock/af_vsock.c                           | 10 ++-
>  net/vmw_vsock/vsock_bpf.c                          | 24 ++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c       | 99 ++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 9 deletions(-)
> ---
> base-commit: da9e8efe7ee10e8425dc356a9fc593502c8e3933
> change-id: 20250305-vsock-trans-signal-race-d62f7718d099
> 
> Best regards,
> -- 
> Michal Luczaj <mhal@rbox.co>


