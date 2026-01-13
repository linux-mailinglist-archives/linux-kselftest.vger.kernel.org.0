Return-Path: <linux-kselftest+bounces-48878-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4B6D19F69
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8053024D41
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636343939A8;
	Tue, 13 Jan 2026 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBwl8Ahy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JrmS9Uxv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDD2C15AC
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318940; cv=none; b=IO3HNEMIGglocCgOTlaYTdVFB0PPOgy3gTRk6xIy3f7LJjQu3sCMApuNwngCWgZNXLCoAcS8DPi8ure+Ni+7gyla+imkrlAacr8k/Dfwuy2pFnMLS+y72SVIGqIMT6cc/4nEmbD9Xhe/cD4UosikS6wWwp33KaXj6u+FXFyAkj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318940; c=relaxed/simple;
	bh=z0ktrf9THh1+HjKG5G+Ar30QQHeNINGUrFDEbpyqHsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ww1DOMMc2mQHGzXcG66x0CoJBCYgGCVHUvuKTD40S6TKE0Zo19g/6ILtbplv20078/DgJWe+MVVl1/UZoGR1VBYgNAfOej7UT+UIaojqBL6+FZo7uUQX56HiuetgiWWLIRBS0r7GSmOFUBRnBsNKxieuqXLAphbiabB+/Y+4yOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VBwl8Ahy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JrmS9Uxv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768318937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
	b=VBwl8AhyOMQBDmI0szaR2ecWm5UqIs8eYGza4Up2dnS/XY3E69U2poOmcMccfLd3DVx9CA
	OomfVKL7tgUnXHArXu+eilkCMZVDDClHSA9bEqzwr8ptZ2UnKWF/KWtogZhbcAWmqJqUeV
	fzxXabDM3rLuwutsQZ8MrvFRRDtkzBA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-jFxGbh0uP4aBw17eyyh92A-1; Tue, 13 Jan 2026 10:42:16 -0500
X-MC-Unique: jFxGbh0uP4aBw17eyyh92A-1
X-Mimecast-MFC-AGG-ID: jFxGbh0uP4aBw17eyyh92A_1768318935
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so51460785e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768318935; x=1768923735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=JrmS9UxvNExe9f0SxaMLZoIqNBf7wtmAt8LITJYbNiw8wcDm6muI6r2os8ZOKn0Ca6
         6WO9MVzG9DOZulAg4srR9tXLbN3f9YohQoXAZ9nBFl8dVw20k1mSwxkOX8w0dTQMliaC
         sOypnMmVoneA9NqPRZEPqV4c3JRZ+QQpTqFsh3Ve7qzdbEvI0ubsOpaDN6KWOxd1mKfa
         k0+ns9Tv3H9VxsrLEMWAUjj5fJt4fdvlxq/kUgGWGhzMPjPS4qxw3rNwXYBqtiGEFRt5
         7o39St8tnHHvicCO5whiI7kF/E/yOR5la0T2nmv3ZTyZhdr4B9mZZNQj7KcyVnk6qM6V
         5NdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318935; x=1768923735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJEPhbiWRGNl7Jboc5mq3GBmXz9jBXvM23UB3dUFjRY=;
        b=eaUPp6Mrq2l2XNufaXlhXsAkcXhxWH1juiNLQOD6CoeGQNjguJDdkdjP6yGHDlz3El
         ypTZPKHctzCHC12pmGOSh7QnG0IZaYl+zjfxOgQEWz+hio3Y7eTNqJ6T58xesH1yZn9v
         a8zVyupJ0AznQdT7wl+TqyXY+cgB9vCNQyaSrOW1frYD68qRwzTPVhY8IsigKj6gZTVG
         VjHc+o2XDdeCrfrPugU1PDklXDEdiOCy2lT2yHrp9KBXdCO71Gl9Ub81jCWQKUmvl9XA
         b8k/5VzRDkhb3+eCisoWMeWme4PWT10KU9Wao6V+N9zPrrEl8DLsQGuGpd1OV9CpcCA1
         y1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCXAwJ6eIt64uSpDJuVqzI5SF5czFmeuZc7RBcDp5kFJup5WrZqJdcnMFN75h9EFMB2stQVTOXcfXZfIBcCxni4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgKkpkGD44Vw7RHu9uVON2Jt8D/8VRO3y4EA0egrNeTqpgHYpS
	scHb1FlvI+qUWSfq54PL/zunRws7tvhRME7OYYsjwaWhBRr9qeaAt7IePeM7+hHcotsC/xn+VQW
	eLyrDRc/HnhAYNj+HvxMePG6QJKjuSIM+MjUbXu+JjZiqLT3NqKXpOAPZzjLUIzGSWrfaMA==
X-Gm-Gg: AY/fxX65/cJqht9iQhAXRZQqIfirvua1EnAEReZvJ69Ma+vnPTFMQwvmlZJD4pRrt70
	YszxclYQD6TL6Ue+8ska3B3tWrqkO8iqhX1+i8ReNXaMCYW0apubqeOI1yrYqRb0fYv3YPaeyVv
	Md0hNdNfYVzBLWF5dQbKAVHkkd5hI/xhU6TagnhgBAXk5HmYWk0fvRSpRMDjCyWSUzWhJCdzVP4
	sv8Wlb5p9Wt6vF3fIiXG8Y5fIP2t0bQNlrn3o4J7kpUjFmdRNHYR/ICnVVY2AOfe/ydwCl+3pHT
	pgOASuDwy6HvyOlQN8lt+QSDcaZBjFHnv2rl7FVhbH/uQjaAkg5DOyjfyffwe9z/QMxRt5dEj06
	TsRsmrk1xY5TmUA5tlz9lP9SZ8NG7E6T3+uUjV0mtd42o+cZMcEuPakql1aYZxw==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241263045e9.32.1768318935387;
        Tue, 13 Jan 2026 07:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4paz0040d/vitY+T5rv1eo5WHxtcQ4X4vPvSUCFKLot5Wf40qNTKU1VjGBirJbB8u4247Wg==
X-Received: by 2002:a05:600c:620c:b0:46e:33b2:c8da with SMTP id 5b1f17b1804b1-47d84b3be47mr241262525e9.32.1768318934958;
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e1adbsm45281481f8f.17.2026.01.13.07.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:42:14 -0800 (PST)
Date: Tue, 13 Jan 2026 16:42:07 +0100
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
Subject: Re: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Message-ID: <aWZnnHxzaV9pgwzb@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:13PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Increase the timeout from 300s to 1200s. On a modern bare metal server
>my last run showed the new set of tests taking ~400s. Multiply by an
>(arbitrary) factor of three to account for slower/nested runners.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/settings | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
>index 694d70710ff0..79b65bdf05db 100644
>--- a/tools/testing/selftests/vsock/settings
>+++ b/tools/testing/selftests/vsock/settings
>@@ -1 +1 @@
>-timeout=300
>+timeout=1200
>
>-- 
>2.47.3
>


