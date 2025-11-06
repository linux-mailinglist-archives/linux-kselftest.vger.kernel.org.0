Return-Path: <linux-kselftest+bounces-45013-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D75C3C707
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 17:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1CF354F7BD3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 16:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86FF34CFDC;
	Thu,  6 Nov 2025 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wzh1+7BN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="naptq2FY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509B34CFDE
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445927; cv=none; b=ssRsen5JxQ251BDK/+6JRsSkBWL9ZzB6Z7NQU/p6Eseel9Iv+0WMIZkuqQu7WHeSR7rpYmfZ9WMOlp21Vu3Kt788K5aTzqKVUX6TNy5xbEeXnzr6F0Wd7vyt+iU9JNZcIQSE/lkmGDYPrAN5jeNTcBIrwO1H24Evsp82Z6/aILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445927; c=relaxed/simple;
	bh=P6dqZEO6asp6iI5HNxSfu9qxJ1GAnGbKVOQiwtyp9f0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlCfCSAViS/0yvVLt3yed5iHYLFN5A9FSnDw9GeG2jObENw+jYdd/XlP5VQh4jYLp7TnMubval5g70PS2rxhbTh+mzW4H/+Tq9FMW57uEbIesfFqE5AFNjyntcBw9//SIMwnhh4L34N4H3hCg8Uz63GY9tYPV5LsOtlHVaIx3Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wzh1+7BN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=naptq2FY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762445925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
	b=Wzh1+7BNBcYsPVC74gTquuXgmHuWiarz/scb5Rq9CZxeKqNg1W5PhRKk6nQAPtHkL3p3a4
	eoql4tFU/y3SyDTEiiZRrjswB9vJ2WvDL9ixd4XLXPJfRiBpMeuahpVmMOyDq88rR838nL
	vGu8t4pxeOoF9gGyGd9NT1DpqVlkSjI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-t0dlprLVOauANRcJdvnnjg-1; Thu, 06 Nov 2025 11:18:44 -0500
X-MC-Unique: t0dlprLVOauANRcJdvnnjg-1
X-Mimecast-MFC-AGG-ID: t0dlprLVOauANRcJdvnnjg_1762445923
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e39567579so5894125e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 08:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762445922; x=1763050722; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=naptq2FY7vSy6FB81bWqWweXzkkfSANvNAOsfCt7jdTi8zUsspJAuzTbEFHsLhWyVV
         Iuh+DSI02FpkpGfOyGdH5Z1qJOP52LlN8PMHKGCVGNFj8tZ+CAOj8ZTg5DKHXKthWOEQ
         0ckrpwdpyVS9f/+4Anqcw+8Dx8D4+rgsbontvpkJjbN+2eljAeLg9kLr+GiOyXbRo0L5
         o0AiiCM41C+2hPMzKrhSg+9FgzH8tNnZyQ2s0hY6r8mLNUehUZQ+/WX6FkLbydRWDypx
         NTQqLvYAzNxfCuxcGznAqxNxtH97qXY/AZiCRlWTOpx/iA2P0sZGxHvQn8YJ8XcPMI3l
         T6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445923; x=1763050723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlaSIzfnjC1rglQ5EMwdrXBGdH8/0geumBayPNyr3uQ=;
        b=EBfvGRMSE3CCskRvt9R1SJXOkWR6gTtyE6ntfM5DFK72Lb2YZYK1YvUbPwHZPUEZYs
         DtnY6HFMY0q5x0NKxzIM7qsc7yXpFCvC0oURI1JuH6icY4/WpqC/AIqyJB/sXWvVjhwI
         3pVhPT/ZmnB0qkHSsCGpM4mpPojYO4nqqsv10ntOUUeSUYa6wR22Vj/1rvFUnn+w3cSR
         Y3ThyLSAIPb7PR9Vs+p/yS9Yefg2tpNnPbRjS4zIlwoSDNDJmb+a22dc6jX4L1B1QVqN
         +ADm3yUqqyCDEsuyzAhSrx6HEk62Z9SwJxKgmBV/lbsY7zC5CKhr0i5rBWoj7uvrMibP
         QaNg==
X-Forwarded-Encrypted: i=1; AJvYcCXnuWPgKStX3DF3dEAe5SPMkskjjwI5vF4AVrnanWWF4WAAxTfduw19zr3XpPqcq7EZZa9NJUgFEFtRR5IF+7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPSYZSymp4DU/bjYMsYNfmknCZ5dCqjc4qaTjdz8hyABfDTiq
	8o5pd830JXUFcpXXeyx35LJnaCWrLnLeXHcs89fAks7ZZ3VDb1PL7nhPoOo6H08Y0Qe7WrslA8g
	1JcbVKZQRNm8ceKVejuz2oVak+KPcZyLHPkcr1u4sobPLCj8+1pCoEl/v0kiki3AYjG+W2w==
X-Gm-Gg: ASbGncsmWfeyqYtigkw7kSwGXqSTlsTBu4DCBUiGrZSa4m0EsF23ZW+0wT+zB0dKd68
	xrKBKb3Og9HORNyajKt/Y+nxoRNxjki1DixZVjOQuknit4rs4Shqkn1wmqOqggXQF8m07cUDWNz
	a8wDKwjR3OCPQ0UStb4pRDaSfXa3pxYCFET03oVMpzvGNFXlLx6ui6Elu0iYjX6ZO+ebzJoLteC
	UtQsFAbi15if7S+oE+PudD4uYTwi0exYrg7dPC1a5JDvUx/j9B8psaivaXZscQd9vskvhv2T6I9
	am/AhPvx9p701nXRQ2Il6qh1y4LVm6TtP8CI7Bq7Y6WPuWmuFZVjEcXYMwWVYTZeVOIrkLJu6+V
	B8Q==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60025015e9.5.1762445922545;
        Thu, 06 Nov 2025 08:18:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFP/WvasiwYTgtNLqdi1/A6yt0PQxbP4Abxbsn2GMIJwekrkfT7LDMidIZ3T6Hr6zobvw5ZaQ==
X-Received: by 2002:a05:600c:5251:b0:470:fe3c:a3b7 with SMTP id 5b1f17b1804b1-4775cdbd546mr60024435e9.5.1762445921975;
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Received: from sgarzare-redhat ([78.209.9.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477626eb4fdsm55397145e9.17.2025.11.06.08.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:18:41 -0800 (PST)
Date: Thu, 6 Nov 2025 17:18:36 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 05/14] vsock/loopback: add netns support
Message-ID: <tuclqrdg5p2uzfvczhcdig7jlifvhqtlafe4xcqy4x4p3vrya6@jq5mujdluze5>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251023-vsock-vmtest-v8-5-dea984d02bb0@meta.com>

On Thu, Oct 23, 2025 at 11:27:44AM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add NS support to vsock loopback. Sockets in a global mode netns
>communicate with each other, regardless of namespace. Sockets in a local
>mode netns may only communicate with other sockets within the same
>namespace.
>
>Use pernet_ops to install a vsock_loopback for every namespace that is
>created (to be used if local mode is enabled).
>
>Retroactively call init/exit on every namespace when the vsock_loopback
>module is loaded in order to initialize the per-ns device.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---

I'm a bit confused, should we move this after the next patch that add 
support of netns in the virtio common module?

Or this is a pre-requisite?

>Changes in v7:
>- drop for_each_net() init/exit, drop net_rwsem, the pernet registration
>  handles this automatically and race-free
>- flush workqueue before destruction, purge pkt list
>- remember net_mode instead of current net mode
>- keep space after INIT_WORK()
>- change vsock_loopback in netns_vsock to ->priv void ptr
>- rename `orig_net_mode` to `net_mode`
>- remove useless comment
>- protect `register_pernet_subsys()` with `net_rwsem`
>- do cleanup before releasing `net_rwsem` when failure happens
>- call `unregister_pernet_subsys()` in `vsock_loopback_exit()`
>- call `vsock_loopback_deinit_vsock()` in `vsock_loopback_exit()`
>
>Changes in v6:
>- init pernet ops for vsock_loopback module
>- vsock_loopback: add space in struct to clarify lock protection
>- do proper cleanup/unregister on vsock_loopback_exit()
>- vsock_loopback: use virtio_vsock_skb_net()
>
>Changes in v5:
>- add callbacks code to avoid reverse dependency
>- add logic for handling vsock_loopback setup for already existing
>  namespaces
>---
> include/net/netns/vsock.h      |  2 +
> net/vmw_vsock/vsock_loopback.c | 85 ++++++++++++++++++++++++++++++++++++------
> 2 files changed, 75 insertions(+), 12 deletions(-)
>
>diff --git a/include/net/netns/vsock.h b/include/net/netns/vsock.h
>index c9a438ad52f2..9d0d8e2fbc37 100644
>--- a/include/net/netns/vsock.h
>+++ b/include/net/netns/vsock.h
>@@ -16,5 +16,7 @@ struct netns_vsock {
> 	/* protected by lock */
> 	enum vsock_net_mode mode;
> 	bool mode_locked;
>+
>+	void *priv;
> };
> #endif /* __NET_NET_NAMESPACE_VSOCK_H */
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a8f218f0c5a3..474083d4cfcb 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -28,8 +28,16 @@ static u32 vsock_loopback_get_local_cid(void)
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	struct vsock_loopback *vsock;
> 	int len = skb->len;
>+	struct net *net;
>+
>+	net = virtio_vsock_skb_net(skb);
>+
>+	if (virtio_vsock_skb_net_mode(skb) == VSOCK_NET_MODE_LOCAL)
>+		vsock = (struct vsock_loopback *)net->vsock.priv;

Is there some kind of refcount on the net?
What I mean is, are we sure this pointer is still valid? Could the net 
disappear in the meantime?

The rest LGTM!

Thanks,
Stefano

>+	else
>+		vsock = &the_vsock_loopback;
>
> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>@@ -134,11 +142,8 @@ static void vsock_loopback_work(struct work_struct *work)
> 	}
> }
>
>-static int __init vsock_loopback_init(void)
>+static int vsock_loopback_init_vsock(struct vsock_loopback *vsock)
> {
>-	struct vsock_loopback *vsock = &the_vsock_loopback;
>-	int ret;
>-
> 	vsock->workqueue = alloc_workqueue("vsock-loopback", WQ_PERCPU, 0);
> 	if (!vsock->workqueue)
> 		return -ENOMEM;
>@@ -146,15 +151,73 @@ static int __init vsock_loopback_init(void)
> 	skb_queue_head_init(&vsock->pkt_queue);
> 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
>
>+	return 0;
>+}
>+
>+static void vsock_loopback_deinit_vsock(struct vsock_loopback *vsock)
>+{
>+	if (vsock->workqueue) {
>+		flush_work(&vsock->pkt_work);
>+		virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+		destroy_workqueue(vsock->workqueue);
>+		vsock->workqueue = NULL;
>+	}
>+}
>+
>+static int vsock_loopback_init_net(struct net *net)
>+{
>+	int ret;
>+
>+	net->vsock.priv = kzalloc(sizeof(struct vsock_loopback), GFP_KERNEL);
>+	if (!net->vsock.priv)
>+		return -ENOMEM;
>+
>+	ret = vsock_loopback_init_vsock((struct vsock_loopback *)net->vsock.priv);
>+	if (ret < 0) {
>+		kfree(net->vsock.priv);
>+		net->vsock.priv = NULL;
>+		return ret;
>+	}
>+
>+	return 0;
>+}
>+
>+static void vsock_loopback_exit_net(struct net *net)
>+{
>+	vsock_loopback_deinit_vsock(net->vsock.priv);
>+	kfree(net->vsock.priv);
>+	net->vsock.priv = NULL;
>+}
>+
>+static struct pernet_operations vsock_loopback_net_ops = {
>+	.init = vsock_loopback_init_net,
>+	.exit = vsock_loopback_exit_net,
>+};
>+
>+static int __init vsock_loopback_init(void)
>+{
>+	struct vsock_loopback *vsock = &the_vsock_loopback;
>+	int ret;
>+
>+	ret = vsock_loopback_init_vsock(vsock);
>+	if (ret < 0)
>+		return ret;
>+
>+	ret = register_pernet_subsys(&vsock_loopback_net_ops);
>+	if (ret < 0)
>+		goto out_deinit_vsock;
>+
> 	ret = vsock_core_register(&loopback_transport.transport,
> 				  VSOCK_TRANSPORT_F_LOCAL);
> 	if (ret)
>-		goto out_wq;
>+		goto out_unregister_pernet_subsys;
>
> 	return 0;
>
>-out_wq:
>-	destroy_workqueue(vsock->workqueue);
>+out_unregister_pernet_subsys:
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>+out_deinit_vsock:
>+	vsock_loopback_deinit_vsock(vsock);
> 	return ret;
> }
>
>@@ -164,11 +227,9 @@ static void __exit vsock_loopback_exit(void)
>
> 	vsock_core_unregister(&loopback_transport.transport);
>
>-	flush_work(&vsock->pkt_work);
>-
>-	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
>+	unregister_pernet_subsys(&vsock_loopback_net_ops);
>
>-	destroy_workqueue(vsock->workqueue);
>+	vsock_loopback_deinit_vsock(vsock);
> }
>
> module_init(vsock_loopback_init);
>
>-- 
>2.47.3
>


