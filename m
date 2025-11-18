Return-Path: <linux-kselftest+bounces-45904-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A48C6B231
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 19:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 68C5934A40C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Nov 2025 18:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06887355050;
	Tue, 18 Nov 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbSD2g4i";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bgobyGdq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470952D8368
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 18:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489565; cv=none; b=uuNxHGoBf8ZFh5a2g12CgVuQUCo1jdp3pHipp+iyJela0xF1W5MTp/KRPDsNi/lgGu0BCvii3KDmynAYcfhCohb8te2Mro7ISFdiHvJnJF1e5NrhbgAaKX+hrHdtiJ8jTasH/l7J+qlrEu/JW4BEj/H9ZU2HTI0YnWe5UCQzrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489565; c=relaxed/simple;
	bh=er1J307+KJnRBNUgsTZ17cqFXn2zardiLpzpxp0mLOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLBI5TFIwXRMKo7n/4+uSJOsMINKOISKr+uc/Q4QtXu4HK5hB7CksaX0xELQPMjV+VO329pEGw5tcfAHPQ7e+njCsGiFtEoQ55WJoecX/ybrnsPWI0byvq/kYE+RAFNynU8UV0/rIbUcF8RXARGFsBhhYjZVqBbcFmU9eZoOKDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gbSD2g4i; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bgobyGdq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
	b=gbSD2g4iiIEB9AJFemhWr27zXXtkHP6FmT4PwYOBzzMjtFysavo332E3PD0FRKKTEyBUII
	eDAR/YXOgqACCBWPSaWDUgZrYrbmq/y4uXlwpa3Fh0BT58LAlunlms7R/rbi0lCCxgPn8c
	qyNWycF0aZWz/rTsPJpVxVKVZtaB/x0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-PTJw0QUSNIe_K6yaCqWJqg-1; Tue, 18 Nov 2025 13:12:42 -0500
X-MC-Unique: PTJw0QUSNIe_K6yaCqWJqg-1
X-Mimecast-MFC-AGG-ID: PTJw0QUSNIe_K6yaCqWJqg_1763489561
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso71690795e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Nov 2025 10:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489561; x=1764094361; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=bgobyGdqdIbD62/NuL81F0Tvj+BcEyw97DZXBgJNbFZAg0aeRiTWj+2OVIubV2pksc
         8iujT4+gm/6CqOV2YwO1Q+p6mZhGQFD0EtnuutRLco1NI/LtVnpJVsv2iBtsP4XzaaqG
         pH3PvZCsozAuKHOThSbGn06chBFgB+zEzbMyGfbcerFCevVKy+ictSQCw2CXnueqUIH0
         e1NUNI9PBgG1/8XFw+lT33XYdZoTvlka2X+6whpne1F4vCwQWozeHo3hKx+ADbmV1FH3
         MuHQ15MRDQEj+FQAM9InHW8gbDAjdrOWJQcoTTJxx9BSFanNlKiB0+vngx5lgnwdBYP6
         /WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489561; x=1764094361;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+h5sKZ9VJjMM8mERtb5Zt23BghZJxFGhKJW89VCOck8=;
        b=qavTAZh8Y3RR0J0n2YHceZp6dqVMU4kerRtFHp884vLdHiiZZSwI4P3GpZFFDm+bNa
         csI1CmakElies13mEP6FmkuSsQRmiXqxqYRfMNdDbZms/Ctudvgw5AGKoAsqTtQPY8KR
         +85T3rUdbD7cjmLZdP8U94XcdBq7CStQqhhCMX+uYHJgZrDuuC5ruebxzrOe32cCK2TZ
         Trcz6V5yKaG8Ny/19CGQPORORo63LrZOmLDbmHVOW3NzChi+V5KbgLEvCewfSOhXkxO5
         E5k2cGFvGgtmWydrOsJAnYz3fjorjqD901gkns43wr6cIPho0qvDZ2LgKvWYiMJBmKuy
         diWQ==
X-Forwarded-Encrypted: i=1; AJvYcCViwo3Ky3i4zoPbNmH6mNUgzoxbUv6669T4nFeL0PbQUujVAHk0VLqnuhPPW1YWqFQ+JCjpOQu7YQn/7TAntRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB4dDyVFJTbAUmb/8ZGE71SNiLffLOxYuC6G/b3vy5Ls53/C5E
	RUCCsmSfTTn1ClesORjEpGvc04ziBr+39TixBIR85hjQ9OD/nZ11RlmLXiJhBvF/pL9UkJWnV60
	bLYMBwyyZTpWAeDJ51o0uUFCeCFm3+95esunSfe8QzVI3Wj6xzkFQaF/iRVFSRcMLHcCBLQ==
X-Gm-Gg: ASbGncvqJCgC62+5Zg+kFu4j9aR5lHeWdiS6THULlGwVUi8+5io4GENOgFO32RoWZ3G
	c3v5KqOVf3SJmqrKyLDCd9GiMXh8tkEPi2sRg7P0TRK6hXcw3TH4FdsjkARKfwYLRB3pAxjDp4d
	CvHTakEeXm4rLCsDAHvcNvM0nseNr+UBJdq6hLZangmZPqVMjM5wYqwQBIQlTUNHf1Q1jdQMVIp
	FEVTwUI7ODIOkqRK0E9XMa7L4/XXmtG1/EwIfaKIW3+I1IgEBCiVzcedmGsKja4vXrDoJOv9EcM
	zWYanc31R2tSmeLIMrG+Lw1wHJESUORko6Ub6pKRlhFFI6E4lx5eKTcmvAyYRphIMWrWGhiMyYQ
	sjmJOLfDGbtgqJppFsyITKrJ+I7RC2JrLIKP6TLbb5P1JvRRkrh3KdgwVFgU=
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144928385e9.32.1763489560847;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOpTmbeuBuF6OCuotMnf25yLK3sUbAbvYEMuVVlK2CBmGppKS9Ccp0DvA2VuQ7IZI1U9CwzQ==
X-Received: by 2002:a05:600c:a43:b0:477:5af7:6fa with SMTP id 5b1f17b1804b1-4778fea84e4mr144927985e9.32.1763489560327;
        Tue, 18 Nov 2025 10:12:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10142d3sm4356375e9.5.2025.11.18.10.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:12:39 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 05/11] virtio: set skb owner of
 virtio_transport_reset_no_sock() reply
Message-ID: <zwpwgzf6opt2qiqrnpas7bwyphpvrpjmy4pee5w6e3um557x34@wnqbvwofevcs>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-5-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:28PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Associate reply packets with the sending socket. When vsock must reply
>with an RST packet and there exists a sending socket (e.g., for
>loopback), setting the skb owner to the socket correctly handles
>reference counting between the skb and sk (i.e., the sk stays alive
>until the skb is freed).
>
>This allows the net namespace to be used for socket lookups for the
>duration of the reply skb's lifetime, preventing race conditions between
>the namespace lifecycle and vsock socket search using the namespace
>pointer.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v10:
>- break this out into its own patch for easy revert (Stefano)
>---
> net/vmw_vsock/virtio_transport_common.c | 6 ++++++
> 1 file changed, 6 insertions(+)

IIUC the previous patch only works well whit this one applied, right?

Please pay more attention to the order; we never want to break the 
bisection.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 168e7517a3f0..5bb498caa19e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -1181,6 +1181,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>
>+		/* Set sk owner to socket we are replying to (may be NULL for
>+		 * non-loopback). This keeps a reference to the sock and
>+		 * sock_net(sk) until the reply skb is freed.
>+		 */
>+		.vsk = vsock_sk(skb->sk),
>+
> 		/* net or net_mode are not defined here because we pass
> 		 * net and net_mode directly to t->send_pkt(), instead of
> 		 * relying on virtio_transport_send_pkt_info() to pass them to
>
>-- 
>2.47.3
>


