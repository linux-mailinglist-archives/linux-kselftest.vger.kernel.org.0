Return-Path: <linux-kselftest+bounces-42496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D41BA4B13
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 18:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A18D94E22E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Sep 2025 16:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD862FCBF0;
	Fri, 26 Sep 2025 16:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BGR67sLF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9507A229B1F
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 16:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904999; cv=none; b=X0htG2jV6opl+aLwlFrI1cBJIwfNuwHGwBE/XdJTrkMNfxlGBY9wTs9DgOv7XkX8/KQSlicSWQnESSxf7eTf8pr3/FpisJyHa/fJQo8uBwxVyQsLlUMzybRp4dQaVGsD62o9+w6CDDvBlQTMRrfsFTFMu24UVu8pkGOLFFN78WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904999; c=relaxed/simple;
	bh=+Qi6lHi3BWk4h+soVr8AsqrSbtdpevz1/dCL0JiOSVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwEClSFFv9Fne/opJKcQj/56NE/Zh0Y4LyCrmgtuJHu4cqCqEz3/rL0FQBr4n+sFLtubbcRC/7QB9uI95naWxWbikF57siY9nMGQFzdhzSwZ2P0tFADpAHaF7vDfWy0bAfolPc/+w6WPoP9tqNU6qmZpIXY6OfG3XAasOi4Ic3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BGR67sLF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758904996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0W6XP1kSbzIw7BM2wwEE7uA0WcDIj3WgTXNjhtqbHyE=;
	b=BGR67sLFSMtlDoN/z3Mzs9EyMTI52/wBPMLrdJiNAGd7ITci6yuf7qH0w9zjCokjc87k26
	2euJozV8bBSgn4JfwI75QB3vQjhPI7CAjxwKySe8u8uI9sI+deiBoePgD3f0lFmsYy5YEu
	ylkpu60LNbfc8o8keuJlOVjEgJGcT10=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-w1bUtmn4NpyHZMHBfd5CyQ-1; Fri, 26 Sep 2025 12:43:15 -0400
X-MC-Unique: w1bUtmn4NpyHZMHBfd5CyQ-1
X-Mimecast-MFC-AGG-ID: w1bUtmn4NpyHZMHBfd5CyQ_1758904994
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b98de0e34so25671285e9.0
        for <linux-kselftest@vger.kernel.org>; Fri, 26 Sep 2025 09:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904994; x=1759509794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W6XP1kSbzIw7BM2wwEE7uA0WcDIj3WgTXNjhtqbHyE=;
        b=EHvdsVv2Jh0Ml1m+BwxsN+y2W3VFWXZrjatPAFwmrp0l5RPLx9I/1G4CU1aXwVlTIX
         L9VC4LfpOG3XHMqJkHPVZcbvdnPaOCZkaUBMs4DIdLCV2SzBYCT/r90lSY5VoKwvhlEB
         Dmv9iBxocxHyuAoNV6tHNgfE8A83Sldegy3IYWz9gELUXX7P1jrB7gL9dOpq/AMhPEwt
         nw1xOxGAzznHaAvV4XfZv07qq45SP0vaX7KDUjDk+0+10z7ymT7XVixMKjNk9Ro0sPEd
         FmzIZL1vWT4jGe8evr5ndr1/noSHMrvjZd7pCLzPjonS5dzpIlSnLFleOcjvoDi1+NpT
         rQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqqzEauQPtzsbS3jPcjeXZRk75QVfOW72DOYyupJJA/BX7mgOjucaZVuPcHSSL9AfcPVe158tAdw5F9u0LS8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFIVp5KpRfnGMDB5tpnhgBGOZjygGAaWbBbidwqcHP22tzc1ma
	JP/kYVLX1Av7ZDJ3DuC91EqLLjz4IqENGmhlsJSX3nIYg3XGa9PkCGfHJH12sVOmTlomM7HjXhB
	N9kEFN3IlmbX254zl3EaGuaoOgpqAjTRJst6ZC0Fua8gxiNwn3x1o3K7K0MRPmkmd8gQNHA==
X-Gm-Gg: ASbGnctufgeggvYD//S2py2atMGAwKmpXEj0Z2YQETaihSZ1wuVqc+Knv2HkxeGyq82
	NpjW/gXtRylMugWpWPHfWnCSGgsC7Hs1o7iDOo+QjgTVcmislKKuKMMbRfEBRoqHChXvBeCC2c5
	mbWA2NlHjwBo+wEkmnLlZlx5TaviwqRGSMzg7FrNHjiFsRaUT/sR/ChL0rQEl2dTtT5V0MRoTwF
	PuzpFueHpnbH6HC8MGQ+R/HzYeHAcpix/0t2Om6bVeEfSw5/lteBsaI3chzQO5Sm0ST3eEHc/Jg
	8GEAUridgoRhpCOEB5JPP+mWzL8ytY3zVEi2za44
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46e330a1a9cmr61704745e9.22.1758904993877;
        Fri, 26 Sep 2025 09:43:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQy5MzShEqo4W4mpHSCNBzEP0InFkBO55wUBdI9t6CxMRbrJ2zCQ8i54MhS96fd25/1RMU9g==
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id 5b1f17b1804b1-46e330a1a9cmr61704445e9.22.1758904993353;
        Fri, 26 Sep 2025 09:43:13 -0700 (PDT)
Received: from sgarzare-redhat ([5.77.94.69])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e33bef4b4sm79560515e9.20.2025.09.26.09.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:43:12 -0700 (PDT)
Date: Fri, 26 Sep 2025 18:43:03 +0200
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
Subject: Re: [PATCH net-next v6 5/9] vsock/virtio: add netns to virtio
 transport common
Message-ID: <jukftp6dcz7padxxistl6ifuqnfhsd45owv46d2l4755t7vhxa@tbpri2oxyfyp>
References: <20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com>
 <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250916-vsock-vmtest-v6-5-064d2eb0c89d@meta.com>

On Tue, Sep 16, 2025 at 04:43:49PM -0700, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add support to the virtio-vsock common code for passing around net
>namespace pointers (tx and rx). The series still requires vhost/virtio
>transport support to be added by future patches.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 18 ++++++++++++++++--
> 2 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index ea955892488a..165157580cb8 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -196,6 +196,7 @@ struct virtio_vsock_pkt_info {
> 	u32 remote_cid, remote_port;
> 	struct vsock_sock *vsk;
> 	struct msghdr *msg;
>+	struct net *net;
> 	u32 pkt_len;
> 	u16 type;
> 	u16 op;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 1a9129e33d51..8a08a5103e7c 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -316,6 +316,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
> 					 info->flags,
> 					 zcopy);
>
>+	virtio_vsock_skb_set_net(skb, info->net);
>+
>+	if (vsk)
>+		virtio_vsock_skb_set_orig_net_mode(skb, vsk->orig_net_mode);

If `vsk` is NULL we don't set it, is it right?

I'd add a comment to explain that, because it's not clear.

Thanks,
Stefano

>+
> 	return skb;
> out:
> 	kfree_skb(skb);
>@@ -527,6 +532,7 @@ static int virtio_transport_send_credit_update(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_CREDIT_UPDATE,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1067,6 +1073,7 @@ int virtio_transport_connect(struct vsock_sock *vsk)
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_REQUEST,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1082,6 +1089,7 @@ int virtio_transport_shutdown(struct vsock_sock *vsk, int mode)
> 			 (mode & SEND_SHUTDOWN ?
> 			  VIRTIO_VSOCK_SHUTDOWN_SEND : 0),
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1108,6 +1116,7 @@ virtio_transport_stream_enqueue(struct vsock_sock *vsk,
> 		.msg = msg,
> 		.pkt_len = len,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1145,6 +1154,7 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.reply = !!skb,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	/* Send RST only if the original pkt is not a RST pkt */
>@@ -1165,6 +1175,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
>+		.net = virtio_vsock_skb_net(skb),
> 	};
> 	struct sk_buff *reply;
>
>@@ -1465,6 +1476,7 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1578,7 +1590,9 @@ static bool virtio_transport_valid_type(u16 type)
> void virtio_transport_recv_pkt(struct virtio_transport *t,
> 			       struct sk_buff *skb)
> {
>+	enum vsock_net_mode orig_net_mode = virtio_vsock_skb_orig_net_mode(skb);
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
>+	struct net *net = virtio_vsock_skb_net(skb);
> 	struct sockaddr_vm src, dst;
> 	struct vsock_sock *vsk;
> 	struct sock *sk;
>@@ -1606,9 +1620,9 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	/* The socket must be in connected or bound table
> 	 * otherwise send reset back
> 	 */
>-	sk = vsock_find_connected_socket(&src, &dst, vsock_global_dummy_net());
>+	sk = vsock_find_connected_socket(&src, &dst, net, orig_net_mode);
> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst, vsock_global_dummy_net());
>+		sk = vsock_find_bound_socket(&dst, net, orig_net_mode);
> 		if (!sk) {
> 			(void)virtio_transport_reset_no_sock(t, skb);
> 			goto free_pkt;
>
>-- 
>2.47.3
>


