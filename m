Return-Path: <linux-kselftest+bounces-45414-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AAFC52A74
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 15:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44835342A22
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Nov 2025 14:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086828DB71;
	Wed, 12 Nov 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TsuAhbsK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWeTuujf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7DC2877DC
	for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957139; cv=none; b=T82l6RqhGjeNcYhFxWEYoQj44Xj9en5xQo/hPn3wifcdjaDnAugezj3gYWzsHJp8yZRWMCISf7GN9TqDxvgx5u6uNPhyRyRFtzzJg3jzrk2LXjlTb/iDasa7I+wsmZxghw6V2F6Im26QR5j78gy5+HWQR8Vf3671HyC73D3PvFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957139; c=relaxed/simple;
	bh=FAHYMEamPdKLEN+yebqecqKUqL2EMgQbBKiW/POb10I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sgmu0ZhbFAA97ZZ6DoCYG7uprLzQw9e++mao0572ZtYs/GDhldn4WHIXB6v5isZKvtoutwE9Jj2K/+PqfodLlq96n9zTgPrZaXJvSYOJDl/cmWmhAehdwDyao+trVzdRmzXe3AvvdyRVdiELLha+FzZWx/FgKf+DrJFig0BK0J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TsuAhbsK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWeTuujf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762957136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OXUXXq6AHRdf/SEIZ0BvHpiTRxVAW1KipePNtgdeRkY=;
	b=TsuAhbsKCkfRwylMpmbEDKPsHW9tVQhi1RpyiceS1+fuYrc9nYdpYLpzzJYtwOriF34H3w
	avdJME+V6d+GjDU5zLmqKnL5G76kHLMx4g31rqGaurTqaHZF34bIqGcVyqOlPQOZne38Y2
	O7yE0oh2lv9ZLltQV6qFjf4mX72NbV4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-VWk4gWlFM36YoeD18gcrOQ-1; Wed, 12 Nov 2025 09:18:54 -0500
X-MC-Unique: VWk4gWlFM36YoeD18gcrOQ-1
X-Mimecast-MFC-AGG-ID: VWk4gWlFM36YoeD18gcrOQ_1762957134
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b225760181so101617385a.2
        for <linux-kselftest@vger.kernel.org>; Wed, 12 Nov 2025 06:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762957134; x=1763561934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OXUXXq6AHRdf/SEIZ0BvHpiTRxVAW1KipePNtgdeRkY=;
        b=HWeTuujfpUWsw5JqMisG8+Dk0pe6RGYcIYxPqfz2qaA2lFDHOX1MGTinSCeqjw6py9
         VUJc/2XzVtkJdPigSzRzFY93l85H1YBVIRvFJCQXe6Fa7gSFlgY8+TuN4aLN/l2yTyF1
         nRyQeZM9HHdRoCy4fJvg9hjAmoG0l/B+u2hSOTz0LMb1CzZ1s4FM4sUByR+i+IMgR5C4
         ostxUqXlgIpT+WQisU0b+u8kt1XNH7ffOKFN0ro7NnO4Drw3+li5yRHxEufH5PDNEWNw
         xGzwO1A5LlT02Dy0X/82EoqZ0L9i5BRQJLWclC+aNKbt154E/kIXlnpeveQY8R9jvHOQ
         5Opg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762957134; x=1763561934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXUXXq6AHRdf/SEIZ0BvHpiTRxVAW1KipePNtgdeRkY=;
        b=w86Y/uJK7L9Eb40eiMQFyNMcpwUIWhKP3I09x7rfLlwGLXfdWUotbCwO7WtL0PgPe7
         Qkx6YqLhPcy4VC6IcIm8njZ5eDYi1ge++mUET19IbOMZie22NGkdHSvQjIMo4LL/EewQ
         zkmBczo5YhDlzGvUMdwdvGjhllLwKM/MeZUy/4z0EE4ajTR1czm9jrT+Y8gAxn6aoHHW
         kc32izV2cuMOiGFRozMis2vQzMjbZkRVXpqpXs/C9Qj9QQ0R/CMy5jLg2HJTOfiMp2lf
         +uwv7LtVmFEuBWaBh9g1ueubie9lfuA1ynv2L9jMYQX/ymHjnYMNHpjmCWVrApdrgqcn
         T91g==
X-Forwarded-Encrypted: i=1; AJvYcCV8Hzx0vbXkn1uQcqhXTSZkEiaZDp7bUb2FWUnPiTXl3DzhvvXSNFY7MwzPKdxXyevSMmDoM8Z3k6ZLxMAE7+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqFpozeJmAzobx1MnQvlVfyW3p17MU7XGsWQIZoNBlVWGHQqFZ
	AFv+UywXeLuTNfPoZ+DNr7n9Ko9vvWzMEwWmO0eHJTcIYkFrpgV92RZDDc3oTCgS2rpfY+/HbCl
	Z3p9lpyLEJ00bBp7Mk3ozZU/myXngGIA0eVc74eX6pX0Lkow80mpVNjh+RcBat7uP8KaLPw==
X-Gm-Gg: ASbGncvCJsZ2aSMsgoD7fSWQwlXdD+InDBv1GKpD3h6nFOkP4YNqt83v3HEpfFg+EUj
	U1/uh1bzz0b8QiUf4DbMgJ5aVOL0YXJ1BwmD9QBONF3PbXh7uy2S57qD9Nxnkl1SK8qwugX5L70
	ttTCkY9idAG0n+XWpV3Gt02WjlDYIpn7vGiX/9C0ZG9ZX++5OZwrN0VHvUAQ8rRfUoCZP4ojyk4
	gVKpXf2Vc049IQXLctfcSHevplxwOnwXE09HCAgriIykujKEYb99S0gO8g3dmMLnJJYpNpg+MRA
	DzNZXwWuvc8QS4S5voflrQdFc+CLH6DZX/UhyQ8A3C7H5lUG05TzaE7hLb7OCY976+vfTngiNcM
	PQkgEIRCPMCL8TiziD0h0WsQdnIPQmd6SXsDN9EopqqvabF8pUAQ=
X-Received: by 2002:a05:620a:410d:b0:8a1:21a6:e04b with SMTP id af79cd13be357-8b29b766c9cmr400689385a.16.1762957133621;
        Wed, 12 Nov 2025 06:18:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5qIC8ungOlzi2TY7NPt3duyO+wqaxjnQyFOx9VO5DBYZqiyZoi2gf2Y87HHFxVWzfGoLmuw==
X-Received: by 2002:a05:620a:410d:b0:8a1:21a6:e04b with SMTP id af79cd13be357-8b29b766c9cmr400676885a.16.1762957132710;
        Wed, 12 Nov 2025 06:18:52 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29fe5f154sm129439885a.47.2025.11.12.06.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:18:52 -0800 (PST)
Date: Wed, 12 Nov 2025 15:18:42 +0100
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
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 03/14] vsock/virtio: add netns support to
 virtio transport and virtio common
Message-ID: <cah4sqsqbdp52byutxngl3ko44kduesbhan6luhk3ukzml7bs6@hlv4ckunx7jj>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-3-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:45PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Enable network namespace support in the virtio-vsock and common
>transport layer.
>
>The changes include:

This list seems to have been generated by AI. I have nothing against it, 
but I don't think it's important to list all the things that have 
changed, but rather to explain why.

>1. Add a 'net' field to virtio_vsock_pkt_info to carry the namespace
>   pointer for outgoing packets.

Why?

>2. Add 'net' and 'net_mode' to t->send_pkt() and
>   virtio_transport_recv_pkt() functions

Why?

>3. Modify callback functions to accept placeholder values
>   (NULL and 0) for net and net_mode. The placeholders will be

Why 0 ? I mean VSOCK_NET_MODE_GLOBAL is also 0, no?
So I don't understand if you want to specify an invalid value (like 
NULL) or VSOCK_NET_MODE_GLOBAL.

>   replaced when later patches in this series add namespace support
>   to transports.
>4. Set virtio-vsock to global mode unconditionally, instead of using
>   placeholders. This is done in this patch because virtio-vsock won't
>   have any additional changes to choose the net/net_mode, unlike the
>   other transports. Same complexity as placeholders.
>5. Pass net and net_mode to virtio_transport_reset_no_sock() directly.
>   This ensures that the outgoing RST packets are scoped based on the
>   namespace of the receiver of the failed request.

"Receiver" is confusing IMO, see the comment on 
virtio_transport_reset_no_sock().

>6. Pass net and net_mode to socket lookup functions using
>   vsock_find_{bound,connected}_socket_net().

mmmm, are those functions working fine with the placeholders?

If it simplifies, I think we can eventually merge all changes to 
transports that depends on virtio_transport_common in a single commit.
IMO is better to have working commits than better split.

I mean, is this commit working (at runtime) well?

>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- include/virtio_vsock.h: send_pkt() cb takes net and net_mode
>- virtio_transport reset_no_sock() takes net and net_mode
>- vhost-vsock: add placeholders to recv_pkt() for compilation
>- loopback: add placeholders to recv_pkt() for compilation
>- remove skb->cb net/net_mode usage, pass as arguments to
>  t->send_pkt() and virtio_transport_recv_pkt() functions instead.
>  Note that skb->cb will still be used by loopback, but only internal
>  to loopback and never passing it to virtio common.
>- remove virtio_vsock_alloc_rx_skb(), it is not needed after removing
>  skb->cb usage.
>- pass net and net_mode to virtio_transport_reset_no_sock()
>
>Changes in v8:
>- add the virtio_vsock_alloc_rx_skb(), to be in same patch that fields
>are read (Stefano)
>
>Changes in v7:
>- add comment explaining the !vsk case in virtio_transport_alloc_skb()
>---
> drivers/vhost/vsock.c                   |  6 ++--
> include/linux/virtio_vsock.h            |  8 +++--
> net/vmw_vsock/virtio_transport.c        | 10 ++++--
> net/vmw_vsock/virtio_transport_common.c | 57 ++++++++++++++++++++++++---------
> net/vmw_vsock/vsock_loopback.c          |  5 +--
> 5 files changed, 62 insertions(+), 24 deletions(-)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index 34adf0cf9124..0a0e73405532 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -269,7 +269,8 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
> }
>
> static int
>-vhost_transport_send_pkt(struct sk_buff *skb)
>+vhost_transport_send_pkt(struct sk_buff *skb, struct net *net,
>+			 enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct vhost_vsock *vsock;
>@@ -537,7 +538,8 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
> 		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
> 		    le64_to_cpu(hdr->dst_cid) ==
> 		    vhost_transport_get_local_cid())
>-			virtio_transport_recv_pkt(&vhost_transport, skb);
>+			virtio_transport_recv_pkt(&vhost_transport, skb, NULL,
>+						  0);
> 		else
> 			kfree_skb(skb);
>
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
>index f92f23be3f59..9395fd875823 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -231,7 +231,8 @@ static int virtio_transport_send_skb_fast_path(struct virtio_vsock *vsock, struc
> }
>
> static int
>-virtio_transport_send_pkt(struct sk_buff *skb)
>+virtio_transport_send_pkt(struct sk_buff *skb, struct net *net,
>+			  enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr;
> 	struct virtio_vsock *vsock;
>@@ -660,7 +661,12 @@ static void virtio_transport_rx_work(struct work_struct *work)
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
>index dcc8a1d5851e..f4e09cb1567c 100644
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
>@@ -1156,15 +1166,27 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
>
> /* Normally packets are associated with a socket.  There may be no socket if an
>  * attempt was made to connect to a socket that does not exist.
>+ *
>+ * net and net_mode refer to the net and mode of the receiving device (e.g.,
>+ * vhost_vsock). For loopback, they refer to the sending socket net/mode. This
>+ * way the RST packet is sent back to the same namespace as the bad request.

Could this be a problem, should we split this function?

BTW, I'm a bit confused. For vhost-vsock, this is the namespace of the 
device, so the namespace of the guest, so also in that case the 
namespace of the sender, no?

Maybe sender/receiver are confusing. What you want to highlight with 
this comment?

>  */
> static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>-					  struct sk_buff *skb)
>+					  struct sk_buff *skb, struct net *net,
>+					  enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct virtio_vsock_pkt_info info = {
> 		.op = VIRTIO_VSOCK_OP_RST,
> 		.type = le16_to_cpu(hdr->type),
> 		.reply = true,
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
>@@ -1183,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!reply)
> 		return -ENOMEM;
>
>-	return t->send_pkt(reply);
>+	return t->send_pkt(reply, net, net_mode);
> }
>
> /* This function should be called with sk_lock held and SOCK_DONE set */
>@@ -1465,6 +1487,8 @@ virtio_transport_send_response(struct vsock_sock *vsk,
> 		.remote_port = le32_to_cpu(hdr->src_port),
> 		.reply = true,
> 		.vsk = vsk,
>+		.net = sock_net(sk_vsock(vsk)),
>+		.net_mode = vsk->net_mode,
> 	};
>
> 	return virtio_transport_send_pkt_info(vsk, &info);
>@@ -1507,12 +1531,12 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	int ret;
>
> 	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> 		return -EINVAL;
> 	}
>
> 	if (sk_acceptq_is_full(sk)) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> 		return -ENOMEM;
> 	}
>
>@@ -1520,13 +1544,13 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 * Subsequent enqueues would lead to a memory leak.
> 	 */
> 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> 		return -ESHUTDOWN;
> 	}
>
> 	child = vsock_create_connected(sk);
> 	if (!child) {
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> 		return -ENOMEM;
> 	}
>
>@@ -1548,7 +1572,7 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
> 	 */
> 	if (ret || vchild->transport != &t->transport) {
> 		release_sock(child);
>-		virtio_transport_reset_no_sock(t, skb);
>+		virtio_transport_reset_no_sock(t, skb, sock_net(sk), vsk->net_mode);
> 		sock_put(child);
> 		return ret;
> 	}
>@@ -1576,7 +1600,8 @@ static bool virtio_transport_valid_type(u16 type)
>  * lock.
>  */
> void virtio_transport_recv_pkt(struct virtio_transport *t,
>-			       struct sk_buff *skb)
>+			       struct sk_buff *skb, struct net *net,
>+			       enum vsock_net_mode net_mode)
> {
> 	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
> 	struct sockaddr_vm src, dst;
>@@ -1599,24 +1624,24 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
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

Here `net` can be null, right? Is this okay?

> 	if (!sk) {
>-		sk = vsock_find_bound_socket(&dst);
>+		sk = vsock_find_bound_socket_net(&dst, net, net_mode);
> 		if (!sk) {
>-			(void)virtio_transport_reset_no_sock(t, skb);
>+			(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
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
>@@ -1635,7 +1660,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 	 */
> 	if (sock_flag(sk, SOCK_DONE) ||
> 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		release_sock(sk);
> 		sock_put(sk);
> 		goto free_pkt;
>@@ -1667,7 +1692,7 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
> 		kfree_skb(skb);
> 		break;
> 	default:
>-		(void)virtio_transport_reset_no_sock(t, skb);
>+		(void)virtio_transport_reset_no_sock(t, skb, net, net_mode);
> 		kfree_skb(skb);
> 		break;
> 	}
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a8f218f0c5a3..d3ac056663ea 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -26,7 +26,8 @@ static u32 vsock_loopback_get_local_cid(void)
> 	return VMADDR_CID_LOCAL;
> }
>
>-static int vsock_loopback_send_pkt(struct sk_buff *skb)
>+static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>+				   enum vsock_net_mode net_mode)
> {
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>@@ -130,7 +131,7 @@ static void vsock_loopback_work(struct work_struct *work)
> 		 */
> 		virtio_transport_consume_skb_sent(skb, false);
> 		virtio_transport_deliver_tap_pkt(skb);
>-		virtio_transport_recv_pkt(&loopback_transport, skb);
>+		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
> 	}
> }
>
>
>-- 
>2.47.3
>


