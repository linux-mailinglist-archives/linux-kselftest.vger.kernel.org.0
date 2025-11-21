Return-Path: <linux-kselftest+bounces-46238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFCDC7A45F
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 15:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 935DE385F82
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Nov 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9C2347BBE;
	Fri, 21 Nov 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UplLZiY1";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZSikdlZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33F351FAE
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763735993; cv=none; b=tZXTO0Z+lHCpt55rIvaOt96oJpnewCOsb5CUrqmLks4fOfNefGLJs68vSprTpnh1tyUrlTkJW9eWhDkAGh3U+LH3qqG6ZMvoRpUBJIPtLMKJnVuf9Y4k95w3CPj7Pj1KQlQGwcH8wEoUn98RXXSkaFT/VUr61R/Bhm4oii3Fh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763735993; c=relaxed/simple;
	bh=KjfXvIpYIlFDHwbGOCAaeCCq1lN3zGocrzE6FEGQ4tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idWmr3z5KrcGdvsipKNDEqEjyHKgqzsRJtzx2Y54ohNCEa/0h592UOEEniqfQZDfzi5KFKMJpF4HBc3kl7JD93WsZjjE2+JXctyY/YQo7rDWHtA/M6Smiu4mJeLApWZpjRonOYf5+bvJS9peseuUMzTtRMWuV9tE0hXSCOTwhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UplLZiY1; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZSikdlZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763735975;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r2MsbJm6TsBGTa64b9vOof2jNUN0EnlrAV3HcNjhRHY=;
	b=UplLZiY17EBQtK0Vft1kzHgWLR644+inoWb2k19a+yGq6fNdFEfqtS/j15tMlqeH6hTS+I
	kq5vwMsETIlxK58Y9NF8pRs+XLqCUZf+CGusrqpd/iytuZi1Fvr1uI/7I4pi7saRuY9FCW
	nI40ZHJe9NkcL+AcrFJkcYrr2ofgUfY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-C9CgX0AZMUew9YrcGcnLrw-1; Fri, 21 Nov 2025 09:39:30 -0500
X-MC-Unique: C9CgX0AZMUew9YrcGcnLrw-1
X-Mimecast-MFC-AGG-ID: C9CgX0AZMUew9YrcGcnLrw_1763735970
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6408222225eso1982675a12.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763735969; x=1764340769; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r2MsbJm6TsBGTa64b9vOof2jNUN0EnlrAV3HcNjhRHY=;
        b=dZSikdlZijnxrXQ2QHQfpIJoNxpYKin89ajGFNtwXpMqNnJeV7Yi9JgL7NegkfX975
         Nn6WKJXLie+QFW6PJhAp9hD51gTv5ZnwSl0oz/DTtijwn6EdrM7zjKz71tEw0ftlKNBS
         4UY0qPZg0fC48KSsYQIYZDQ8QwFqu8hrR2D3Tm6556GKr6qXUkq1y9nCLFGkFMP2qkeq
         T7kzGVAQAwIFnYiZ3KfiIiybdO1jOSyQjYp4jdVdo88eMjQEQGTom31sYsPGVbf+IMQ6
         i3ZjALND+3CwBAvTNmq1y9XqewMD1gtT2DQvqimwhEhlly5jimAUX2m12QtCSE5+e4zF
         oB2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763735969; x=1764340769;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2MsbJm6TsBGTa64b9vOof2jNUN0EnlrAV3HcNjhRHY=;
        b=iUofxLd0E0pTrjEUQ1XbN/nO1lD5RQmLbfuGtAIV+BjNJPJtn2mX0dZfriq6Mhj3Dp
         JFLRttdrqX+MsD5pJ8dKJRNtkYDqcGQ/AuJ2UQYsr/F9NQE5SuQCz5nD0DiJPiBhjr7+
         Ny6vzZex2GtYYZ2vKMPcjzkZ5bF4PXDPCV8APveGBIpaL8hnZzOETD7GlfTdRpqpMSC5
         y0E1NpMxFhw0tYCiElxhug2NuMRCUqHJp9Ngua8HT24oOc3YGsIJyXvKmCPy7gNn3uGh
         ilM6dj6mk6aRN/bgy4ZPXZw7KzuZaQ3YpymNzLXUhq2JDfPxSAzaQyGrIjPaEEMeBHeA
         XW6g==
X-Forwarded-Encrypted: i=1; AJvYcCX0q73bVYAOkGekuEZzKGSbHSyzUEAYHdOqJeRMxJ7hBG/ygK1TfxUAzSByppgCzPof0PwMTvcvxGanu8wXX/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YycKrXKhZxxkfIG0+ZnzrhucvS1Pvd0YfNkvIvNg1Lncu7/Q4JN
	ax29gXiJIkUBQoc/Mn7XQ3uh3He85OfYmCcG+WJEJ0Q0k2xZAnnKi0d4Rrb4Y2JJie8RmEmMwlA
	paopB3dE735jkiICjs3G9LbHs4VCGlbwtVEpKLqq12Bw7/Eq1vz49HhTIwbrNCJEG0KwzLw==
X-Gm-Gg: ASbGncssrWIkjxHyvI/woVraluRLY8Gxpu7I7g3fI3R8zNIsh2dCO8UgWZnVXWFpkui
	AlJpPCJKAHE648Yj6fIQLHmT2HUdvfJJtzYDS78yQ4p719uwsmOPjXDUXAsVDle0bHdYaM8TzhC
	cHU8eLJ2tvMOvPhIjmY2a3lY6h6JxdK/xGll2vjdtphS1z8FpLYgwPIZ+OKZThKXV3h39egznlD
	1+4cMfEsKhPetAyJB1O0sM2RrOHRE6f5Go42N9kO+ImKy0m14q+INA4kxse8GmAdI6CS67cHwq1
	ffwMFXLga3mNqyxW3Jsm+xwqHLBpCn7z8YNIdkEs0K4tMcZZuI6c1EgcYlsRKUfOFnmicoHF/LO
	pOkYLwTsH4d7eMkNEe1wh7jFVOv0+lNu2JzSH6+9zjqCuvarfaLBEpRHo5TCf9A==
X-Received: by 2002:a05:6402:26d3:b0:643:1659:7584 with SMTP id 4fb4d7f45d1cf-6455469ce5dmr2279980a12.33.1763735969562;
        Fri, 21 Nov 2025 06:39:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyR045EfNccb9JPGBN78NJotowuNF5SHRAuZ96VrRB2W9kvcw+Ps92WssUTvZjhnDPTMZUqg==
X-Received: by 2002:a05:6402:26d3:b0:643:1659:7584 with SMTP id 4fb4d7f45d1cf-6455469ce5dmr2279933a12.33.1763735968944;
        Fri, 21 Nov 2025 06:39:28 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453642d321sm4650534a12.20.2025.11.21.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:39:28 -0800 (PST)
Date: Fri, 21 Nov 2025 15:39:25 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 05/13] vsock: add netns support to virtio
 transports
Message-ID: <v6dpp4j4pjnrsa5amw7uubbqtpnxb4odpjhyjksr4mqes2qbzg@3bsjx5ofbwl4>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-5-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-5-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:37PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns support to loopback and vhost. Keep netns disabled for
>virtio-vsock, but add necessary changes to comply with common API
>updates.
>
>This is the patch in the series when vhost-vsock namespaces actually
>come online.  Hence, vhost_transport_supports_local_mode() is switched
>to return true.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
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
> drivers/vhost/vsock.c                   | 47 ++++++++++++++++++------
> include/linux/virtio_vsock.h            |  8 +++--
> net/vmw_vsock/virtio_transport.c        | 10 ++++--
> net/vmw_vsock/virtio_transport_common.c | 63 ++++++++++++++++++++++++---------
> net/vmw_vsock/vsock_loopback.c          |  8 +++--
> 5 files changed, 103 insertions(+), 33 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 4e3856aa2479..e73a6499b9fe 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -46,6 +46,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(vhost_vsock_hash, 8);
> struct vhost_vsock {
> 	struct vhost_dev dev;
> 	struct vhost_virtqueue vqs[2];
>+	struct net *net;
>+	netns_tracker ns_tracker;
>+
>+	/* The ns mode at the time vhost_vsock was created */
>+	enum vsock_net_mode net_mode;
>
> 	/* Link to global vhost_vsock_hash, writes use vhost_vsock_mutex */
> 	struct hlist_node hash;
>@@ -66,13 +71,14 @@ static u32 vhost_transport_get_local_cid(void)
>
> static bool vhost_transport_supports_local_mode(void)
> {
>-	return false;
>+	return true;
> }
>
> /* Callers that dereference the return value must hold vhost_vsock_mutex or the
>  * RCU read lock.
>  */
>-static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
>+static struct vhost_vsock *vhost_vsock_get(u32 guest_cid, struct net *net,
>+					   enum vsock_net_mode mode)
> {
> 	struct vhost_vsock *vsock;
>
>@@ -83,9 +89,10 @@ static struct vhost_vsock *vhost_vsock_get(u32 guest_cid)
> 		if (other_cid == 0)
> 			continue;
>
>-		if (other_cid == guest_cid)
>+		if (other_cid == guest_cid &&
>+		    vsock_net_check_mode(net, mode, vsock->net,
>+					 vsock->net_mode))
> 			return vsock;
>-
> 	}
>
> 	return NULL;
>@@ -274,7 +281,8 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> }
>
> static int
>-vhost_transport_send_pkt(struct sk_buff *skb)
>+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
>+			 enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vhost_vsock *vsock;
>@@ -283,7 +291,7 @@ vhost_transport_send_pkt(struct sk_buff *skb)
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
>+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid), net, net_mode);
> 	if (!vsock) {
> 		rcu_read_unlock();
> 		kfree_skb(skb);
>@@ -310,7 +318,8 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
> 	rcu_read_lock();
>
> 	/* Find the vhost_vsock according to guest context id  */
>-	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid);
>+	vsock = vhost_vsock_get(vsk->remote_addr.svm_cid,
>+				sock_net(sk_vsock(vsk)), vsk->net_mode);
> 	if (!vsock)
> 		goto out;
>
>@@ -470,11 +479,12 @@ static struct virtio_transport vhost_transport = {
> static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk,
> 					    u32 remote_cid)
> {
>+	struct net *net = sock_net(sk_vsock(vsk));
> 	struct vhost_vsock *vsock;
> 	bool seqpacket_allow = false;
>
> 	rcu_read_lock();
>-	vsock = vhost_vsock_get(remote_cid);
>+	vsock = vhost_vsock_get(remote_cid, net, vsk->net_mode);
>
> 	if (vsock)
> 		seqpacket_allow = vsock->seqpacket_allow;
>@@ -545,7 +555,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> 		    le64_to_cpu(hdr->dst_cid) ==
> 		    vhost_transport_get_local_cid())
>-			virtio_transport_recv_pkt(&vhost_transport, skb);
>+			virtio_transport_recv_pkt(&vhost_transport, skb,
>+						  vsock->net, vsock->net_mode);
> 		else
> 			kfree_skb(skb);
>
>@@ -662,6 +673,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> {
> 	struct vhost_virtqueue **vqs;
> 	struct vhost_vsock *vsock;
>+	struct net *net;
> 	int ret;
>
> 	/* This struct is large and allocation could fail, fall back to vmalloc
>@@ -677,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> 		goto out;
> 	}
>
>+	net = current->nsproxy->net_ns;
>+	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
>+
>+	/* Store the mode of the namespace at the time of creation. If this
>+	 * namespace later changes from "global" to "local", we want this vsock
>+	 * to continue operating normally and not suddenly break. For that
>+	 * reason, we save the mode here and later use it when performing
>+	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
>+	 */
>+	vsock->net_mode = vsock_net_mode(net);
>+
> 	vsock->guest_cid = 0; /* no CID assigned yet */
> 	vsock->seqpacket_allow = false;
>
>@@ -716,7 +739,8 @@ static void vhost_vsock_reset_orphans(struct sock *sk)
> 	 */
>
> 	/* If the peer is still valid, no need to reset connection */
>-	if (vhost_vsock_get(vsk->remote_addr.svm_cid))
>+	if (vhost_vsock_get(vsk->remote_addr.svm_cid, sock_net(sk),
>+			    vsk->net_mode))
> 		return;
>
> 	/* If the close timeout is pending, let it expire.  This avoids races
>@@ -761,6 +785,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
> 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
>
> 	vhost_dev_cleanup(&vsock->dev);
>+	put_net_track(vsock->net, &vsock->ns_tracker);
> 	kfree(vsock->dev.vqs);
> 	vhost_vsock_free(vsock);
> 	return 0;
>@@ -787,7 +812,7 @@ static int vhost_vsock_set_cid(struct vhost_vsock *vsock, u64 guest_cid)
>
> 	/* Refuse if CID is already in use */
> 	mutex_lock(&vhost_vsock_mutex);
>-	other = vhost_vsock_get(guest_cid);
>+	other = vhost_vsock_get(guest_cid, vsock->net, vsock->net_mode);
> 	if (other && other != vsock) {
> 		mutex_unlock(&vhost_vsock_mutex);
> 		return -EADDRINUSE;
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index 0c67543a45c8..5ed6136a4ed4 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -173,6 +173,8 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
>+	enum vsock_net_mode net_mode;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>@@ -185,7 +187,8 @@ struct virtio_transport {
> 	struct vsock_transport transport;
>
> 	/* Takes ownership of the packet */
>-	int (*send_pkt)(struct sk_buff *skb);
>+	int (*send_pkt)(struct sk_buff *skb, struct net *net,
>+			enum vsock_net_mode net_mode);
>
> 	/* Used in MSG_ZEROCOPY mode. Checks, that provided data
> 	 * (number of buffers) could be transmitted with zerocopy
>@@ -280,7 +283,8 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
> void virtio_transport_destruct(struct vsock_sock *vsk);
>
> void virtio_transport_recv_pkt(struct virtio_transport *t,
>-			       struct sk_buff *skb);
>+			       struct sk_buff *skb, struct net *net,
>+			       enum vsock_net_mode net_mode);
> void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
> u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
> void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index af4fbce0baab..106d3f25a5cb 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -243,7 +243,8 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
> }
>
> static int
>-virtio_transport_send_pkt(struct sk_buff *skb)
>+virtio_transport_send_pkt(struct sk_buff *skb, struct net *net,
>+			  enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr;
> 	struct virtio_vsock *vsock;
>@@ -675,7 +676,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
> 				virtio_vsock_skb_put(skb, payload_len);
>
> 			virtio_transport_deliver_tap_pkt(skb);
>-			virtio_transport_recv_pkt(&virtio_transport, skb);
>+
>+			/* Force virtio-transport into global mode since it
>+			 * does not yet support local-mode namespacing.
>+			 */
>+			virtio_transport_recv_pkt(&virtio_transport, skb,
>+						  NULL, VSOCK_NET_MODE_GLOBAL);
> 		}
> 	} while (!virtqueue_enable_cb(vq));
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 675eb9d83549..5bb498caa19e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -413,7 +413,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>
> 		virtio_transport_inc_tx_pkt(vvs, skb);
>
>-		ret = t_ops->send_pkt(skb);
>+		ret = t_ops->send_pkt(skb, info->net, info->net_mode);
> 		if (ret < 0)
> 			break;
>
>@@ -527,6 +527,8 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1067,6 +1069,8 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1082,6 +1086,8 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1108,6 +1114,8 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1145,6 +1153,8 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1156,9 +1166,14 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>
> /* Normally packets are associated with a socket.  There may be no socket if an
>  * attempt was made to connect to a socket that does not exist.
>+ *
>+ * net and net_mode refer to the namespace of whoever sent the invalid message.
>+ * For loopback, this is the namespace of the socket. For vhost, this is the
>+ * namespace of the VM (i.e., vhost_vsock).
>  */
> static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>-					  struct sk_buff *skb)
>+					  struct sk_buff *skb, struct net *net,
>+					  enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct virtio_vsock_pkt_info info = {
>@@ -1171,6 +1186,13 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		 * sock_net(sk) until the reply skb is freed.
> 		 */
> 		.vsk = vsock_sk(skb->sk),
>+
>+		/* net or net_mode are not defined here because we pass
>+		 * net and net_mode directly to t->send_pkt(), instead of
>+		 * relying on virtio_transport_send_pkt_info() to pass them to
>+		 * t->send_pkt(). They are not needed by
>+		 * virtio_transport_alloc_skb().
>+		 */
> 	};
> 	struct sk_buff *reply;
>
>@@ -1189,7 +1211,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!reply)
> 		return -ENOMEM;
>
>-	return t->send_pkt(reply);
>+	return t->send_pkt(reply, net, net_mode);
> }
>
> /* This function should be called with sk_lock held and SOCK_DONE set */
>@@ -1471,6 +1493,8 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1513,12 +1537,14 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	int ret;
>
> 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
>+					       vsk->net_mode);
> 		return -EINVAL;
> 	}
>
> 	if (sk_acceptq_is_full(sk)) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
>+					       vsk->net_mode);
> 		return -ENOMEM;
> 	}
>
>@@ -1526,13 +1552,15 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 * Subsequent enqueues would lead to a memory leak.
> 	 */
> 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
>+					       vsk->net_mode);
> 		return -ESHUTDOWN;
> 	}
>
> 	child = vsock_create_connected(sk);
> 	if (!child) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
>+					       vsk->net_mode);
> 		return -ENOMEM;
> 	}
>
>@@ -1554,7 +1582,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 */
> 	if (ret || vchild->transport != &t->transport) {
> 		release_sock(child);
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk),
>+					       vsk->net_mode);
> 		sock_put(child);
> 		return ret;
> 	}
>@@ -1582,7 +1611,8 @@ static bool virtio_transport_valid_type(u16 type)
>  * lock.
>  */
> void virtio_transport_recv_pkt(struct virtio_transport *t,
>-			       struct sk_buff *skb)
>+			       struct sk_buff *skb, struct net *net,
>+			       enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src, dst;
>@@ -1605,24 +1635,25 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 					le32_to_cpu(hdr->fwd_cnt));
>
> 	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		goto free_pkt;
> 	}
>
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket(&src, &dst);
>+	sk = vsock_find_connected_socket_net(&src, &dst, net, net_mode);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
> 		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb);
>+			(void)virtio_transport_reset_no_sock(t, skb, net,
>+							     net_mode);
> 			goto free_pkt;
> 		}
> 	}
>
> 	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		sock_put(sk);
> 		goto free_pkt;
> 	}
>@@ -1641,7 +1672,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
> 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		release_sock(sk);
> 		sock_put(sk);
> 		goto free_pkt;
>@@ -1673,7 +1704,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	default:
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		kfree_skb(skb);
> 		break;
> 	}
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 1e25c1a6b43f..a730fa74d2d9 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -31,7 +31,8 @@ static bool vsock_loopback_supports_local_mode(void)
> 	return true;
> }
>
>-static int vsock_loopback_send_pkt(struct sk_buff *skb)
>+static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>+				   enum vsock_net_mode net_mode)
> {
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>@@ -138,7 +139,10 @@ static void vsock_loopback_work(struct work_struct *work)
> 		 */
> 		virtio_transport_consume_skb_sent(skb, false);
> 		virtio_transport_deliver_tap_pkt(skb);
>-		virtio_transport_recv_pkt(&loopback_transport, skb);
>+
>+		virtio_transport_recv_pkt(&loopback_transport, skb,
>+					  sock_net(skb->sk),
>+					  vsock_sk(skb->sk)->net_mode);
> 	}
> }
>
>
>-- 
>2.47.3
>


