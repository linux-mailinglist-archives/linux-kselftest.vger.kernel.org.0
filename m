Return-Path: <linux-kselftest+bounces-48866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A4CD198B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 34D00306D28B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 14:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125942882D0;
	Tue, 13 Jan 2026 14:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H082tutc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="s2E2NNak"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9231C2BE632
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 14:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315085; cv=none; b=sCnOxCB3O6KBAKyup9UEL3qD0vlAHLGYxIetgMo2UOcohLdBwSrnNL9f5qtOwKNQ5aNTl+iqhdtmk4PwACIiVNicAjbzbkxxLutwF5qYG92erjjfYCfw1mZRBqkTi4bIQ2qjf34aCzovB6bFMDN6SFI42wvyJ9FHydR/9BalKhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315085; c=relaxed/simple;
	bh=E5/n+gp4oJScjwiNqhRtlKeTPug5EnnZg1wflCdJ81E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOKkbSQgTy97M62d4srWNUeaoW+CwLYpBrRpnGjy2f9NEDQx6LCaNzsInTwqv9GXptsIhhYpV6MbdoESYoCBa9QwnRiow5yMyHnDeBoYklV1O9dnAyyrmcL0wiX1Y7kU90dSNVa39LVuNnVeLd4ERFjQT53vZUZzDLO7p5rZe60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H082tutc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=s2E2NNak; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768315079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9LgnqaJM+XpiwDFJ8HhQp/PFSeMXCj9ObUTssbWH+C8=;
	b=H082tutcl6OzTNk1i4B3qBcU3KBJ7/9O7VEZzIGRBIYlWtIiJwSfqrvsh/pCQmW6Ch/oW6
	PK+3pDFP7tMAHucc9jRwajJcrPQZLNLTms01r8PrI6EvE9z2cI0B24t6My+HEuaM1KOgQF
	thcsCr2ir89eZeAfwvueCOM+LX+W20g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-obggjqztP-KZmxa38Tz8Ew-1; Tue, 13 Jan 2026 09:37:55 -0500
X-MC-Unique: obggjqztP-KZmxa38Tz8Ew-1
X-Mimecast-MFC-AGG-ID: obggjqztP-KZmxa38Tz8Ew_1768315074
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4325aa61c6bso4829509f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 06:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768315074; x=1768919874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9LgnqaJM+XpiwDFJ8HhQp/PFSeMXCj9ObUTssbWH+C8=;
        b=s2E2NNakzQc7podiTgkDwSS5JrrpBYsAzaBHukJI9cqCG7upriReWrViXdTo2VMN0z
         LotNkZzHizyLR6li7dHoBMGiiQktpC9CIZB4UiXf2olFdiLvJEc0pXtYNTFWgKr88uMC
         zsoEMY9hDitlVZlhniO4dU6uiBM2o4qVMrz4pKwXfK8mbOGW8K0kye5K4gxlFkfeGNyP
         G34PO3NqjWoj1l/j4KV6sy1YTr17HPyKQnGPTRmTjH+7oFmeyDjJ9EGQIpjGdJEq5REf
         0aFvAal+JDajv63n8AotnK7fETt5wITk/BS0xsHAwCUBMsxEQ/fm100YlBmnLWlbTYDP
         MElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315074; x=1768919874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9LgnqaJM+XpiwDFJ8HhQp/PFSeMXCj9ObUTssbWH+C8=;
        b=cc7zHr8F/N+z/Fr4kpJhuaG09cWP/O2qyvsT1YoyyjkGQZ3stDSnf/51kUZISVVEhn
         hx14UJFi8E+ZsC7F9MT/VtNutTXQSvuc98hJDgw953MwG5y/SpTA9CA5gvl+jwUdS/Jm
         FayYpAKypcLPpCw9Qt80VpMp0M7BSGiuJzrDpKM2tb6CVEd1IYRXdhqj7C+s0/nUxX+C
         5/I4jsRF5yqSwbUydqSb6LUd2Fe6rGZddQAoH3iXMH8Eh2Tqm+0Wf3Xys/lMFc/bEFrZ
         sqL59V82I6x7jNaJmy81NknonD9yZ/RiLCOZD2MsUVqR9/YKC48v+9bCI/1E0w1SMh7k
         CATg==
X-Forwarded-Encrypted: i=1; AJvYcCXQxZ8q29h9ytX0pmilJ936YPUOYndhOqoxGsKoxJcPnVxZbeILBaeI72AXcp0hFmqa9FIN5INUuLt75HaW5gs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3g6byfkqmYCIMK/7EOGXmsfNSXqI5XrtSvnnIKndssGqcJF4d
	nFr82n09FzDjAAORE1ikpnr3dnZS7TJBfZCq5Ip1GVSPDcysPMEqNWx0ZuEm0jkg8B1gxisi+Xv
	6cRUc8TIyINJsRMJ2N5XsrguVTp6a2XqxU83hAH+wfwTGBUK1Jm4vmbS+6QMJtfwBy+Ae5Q==
X-Gm-Gg: AY/fxX60JNv0vygYLEeiz54/KUQ5auUmL84kDjbEe1ZDzZcwD/FlvRNYKrlwpgzp4/B
	8CcXlFgNg6afwSnCQQy5RfXGX1qRhAw46buxUf46/wH2sszaM4g2k7PQa0rqXUborLNry3RXCnX
	R1wueofBGaErYV/Bqdj52BRwNoEgEgHqihJCwmhGW/iik6T9wuW3xBjnFK6VyJZw9Grs/2Pd57w
	j2FPmGpwAzZcAP63F3XKXbhpCuDUJI5ZekPsDCb9syVgSovkvcUy67jgWAQTKiMxMagCW3LgMc8
	d7WFhnVr3tYMjs/iO+tgpG7KQX4h6CUo1MuuTTf/4svdnlWJcnhdHebhYkmud1jpX6jLm5+gPFy
	2VhE5e9JihkwRwXjiXXs1Rxe5YRoWSk7ODk5a9yHW/PGGoeHG+TUMoMaSONaLXA==
X-Received: by 2002:a05:6000:2512:b0:430:f58d:40e5 with SMTP id ffacd0b85a97d-432c374ff28mr26117971f8f.30.1768315074296;
        Tue, 13 Jan 2026 06:37:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaDijBjyQACs7Ec+s3xS5LP+GgM+l6sMs4Twqit+l71cMf1frrOWuoQfHaWNAhM1zfLnP+kg==
X-Received: by 2002:a05:6000:2512:b0:430:f58d:40e5 with SMTP id ffacd0b85a97d-432c374ff28mr26117921f8f.30.1768315073807;
        Tue, 13 Jan 2026 06:37:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm45089151f8f.15.2026.01.13.06.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:37:53 -0800 (PST)
Date: Tue, 13 Jan 2026 15:37:50 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 03/12] vsock: add netns support to virtio
 transports
Message-ID: <aWZSeBAdiVs89wz7@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-3-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-3-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:12PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns support to loopback and vhost. Keep netns disabled for
>virtio-vsock, but add necessary changes to comply with common API
>updates.
>
>This is the patch in the series when vhost-vsock namespaces actually
>come online.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v14:
>- fixed merge conflicts in drivers/vhost/vsock.c
>
>Changes in v13:
>- do not store or pass the mode around now that net->vsock.mode is
>  immutable
>- move virtio_transport_stream_allow() into virtio_transport.c
>  because virtio is the only caller now
>
>Changes in v12:
>- change seqpacket_allow() and stream_allow() to return true for
>  loopback and vhost (Stefano)
>
>Changes in v11:
>- reorder with the skb ownership patch for loopback (Stefano)
>- toggle vhost_transport_supports_local_mode() to true
>
>Changes in v10:
>- Splitting patches complicates the series with meaningless placeholder
>  values that eventually get replaced anyway, so to avoid that this
>  patch combines into one. Links to previous patches here:
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-3-852787a37bed@meta.com/
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-6-852787a37bed@meta.com/
>  - Link: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-7-852787a37bed@meta.com/
>- remove placeholder values (Stefano)
>- update comment describe net/net_mode for
>  virtio_transport_reset_no_sock()
>---
> drivers/vhost/vsock.c                   | 38 ++++++++++++++++-------
> include/linux/virtio_vsock.h            |  5 +--
> net/vmw_vsock/virtio_transport.c        | 13 ++++++--
> net/vmw_vsock/virtio_transport_common.c | 54 +++++++++++++++++++--------------
> net/vmw_vsock/vsock_loopback.c          | 14 +++++++--
> 5 files changed, 84 insertions(+), 40 deletions(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>


