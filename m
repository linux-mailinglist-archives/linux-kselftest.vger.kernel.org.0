Return-Path: <linux-kselftest+bounces-45092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C000C40358
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 14:55:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D17B54F2487
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B5A319875;
	Fri,  7 Nov 2025 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9mkUW5R";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bunX0VON"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC08319603
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 13:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523654; cv=none; b=gXHYZB8YppwW7z1jfFi3mChHs/ZrgnknphFCV5NnnweMfficgGH+sOMcrrUV2Xr8Fz6yQ4RQa8+Hl0oa9g9oe/lz+8MFxAvgilokRTQ2HOfr8PCxyzfRDC/NIno23UZJ7J1KKyD1mpWbJzySKml8L/7b0sbR1mVTu2vAZwBEcJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523654; c=relaxed/simple;
	bh=E14IezpC06bozES2UpXxS2wwzQ9Qirf+gMnM88tjbms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRFr7Ubl02x2sxRXLJbY9+QybF9qyhd/PD2ICQRkJ4v7/ASKBrGpkI/QL6NX6IkKf20Wk3Hdrlt+PH9708pIQQA5fF0sCbrjH+vPc+28gapOucuf2smoTDD3kG8ffC+z4/s+G3rPZ2ckNmR9rWdlX8jmIAbeq/05SSR2d9woGwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9mkUW5R; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bunX0VON; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762523651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QTpKPy13RMZO36DAikV4BfOXCjD/6H+oEEf0w/pf88o=;
	b=a9mkUW5RyhHNEueVQTzwJmW7tzv0xmitAaxmDo+RfKFih69Dn+MBs6vN+f15NkgnYt4ufu
	XtXdKqPldRIJosLbJcGdRWL5eeKWKqw9hLihtHOBVXEEW602ZKkEp5znAmq3J3fAd8W6uT
	Gu3oJOjG2NV682gv8rMCPSgfKl+UWXs=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-SsWStBF1M1at3tKorY0SsA-1; Fri, 07 Nov 2025 08:54:10 -0500
X-MC-Unique: SsWStBF1M1at3tKorY0SsA-1
X-Mimecast-MFC-AGG-ID: SsWStBF1M1at3tKorY0SsA_1762523648
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6411d877fbfso938682a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Nov 2025 05:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762523648; x=1763128448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QTpKPy13RMZO36DAikV4BfOXCjD/6H+oEEf0w/pf88o=;
        b=bunX0VONl+Yl3Y28bBwd0ViwsGV+y02UWJOpdaRsvW0I0YxrOFsiGfTAx2Xc3r/e+A
         dNiKg6pX4GxDcf4upzbK1elqe73BoVf4dWjbIhM1tbMUUpENGGixlvt2KOwooFW27WZi
         3vqps+yzSRQPWJgrp01diggAUsePf81Sqw35CMGiunXbEojxh0jY+2xYF3i9NVfP7pyO
         CYDhdpkXZ+tU4StZr3EFRyKwB0CNS8fEA0r2dAiGKKF2KFg/UfS1BmB93JqjAHV+euH/
         er5kNvsPLPR93LLPlPnjv61Yz9Rfm3Kp36rMwORw6lEL1fCwbWjGiIURaV5oKbAwMQCk
         qBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523648; x=1763128448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTpKPy13RMZO36DAikV4BfOXCjD/6H+oEEf0w/pf88o=;
        b=VGpj6aDRImUdpp1j6hcn0X9N1wtBbwyW0gppou8QVro4krviETmMru+UplCBH98duZ
         0BPB7DY+aclB7ucGvEY3YJd22i2qy2uMRF+gacHQ3EEm6nWIQemjNi+n8DjuCJLlYqmE
         opk3h0/p+IVZEJMV85T7hY+B2bI968i2JlaV06Dz03i1WqSkJPGUrQco8EXZkwtNPoAj
         9pMdtza9E09zSBu1nFdu0XTsWL0jY48n/12uiu7Yq48SG8aeKR2rOqSSvqsiLpBBYuKJ
         ifivfwIIQKWJx9RRe2jzGXc+2y5EL6xomEKloaKmAbSMPRfr9dqO7rROoIW0aZh+1EiK
         vLPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6D60+pkmhTqRj8DJ+AU9+/vHuOmV457JDXhGsRQnro+2pe2IfqjiNvNzUQmtew+o5Pp15WaaYx2igtV1ZjFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWJTNrI2/3u5VYWgglyFp0+BM+An3ITdQVV7aV8v9acUX0Mpmj
	XVLJuG56nTK3bGRtRrkm3p2aGSBgnj7U4Dp3l2QxjZP3wpyqAFSixsVzLAetS7mp/s4GeMwrrwV
	BKOCIjlRLpoPFehOTm3oTddGok1rpCgSH0YEUCP/YOGnWi45MYBWFybI2BHxeNSYClQKIdQ==
X-Gm-Gg: ASbGncv89qV4+Q4SpvT9jBXpG4X9tbFbJ6vdociVt38m0qwvdFE2zUTieXfJa8uOJ+j
	39v4wvYuypWz7vxD1tvR7hOp36ABQ9K46Tik0NAw/hlfehz0jB2tG+HPk+kLrFFdt4YX7GppJ8t
	ObtSsjgppr3GuOP2L9lpnSIbeVz0Cb75hAZJQ0lKX0fsy7T+03NrO6I2p+2x5QErsKyzg+DtNef
	HVecO2DTPGlaLEu+DluGMngihuIhq8TkNKfy05pw9qpEvCwh5M8ib2P6UlhiTsCJG2JWfKCCahU
	lmO2BYtR6XOtjbzlJOT4F/r//Uwm2oecJS7Fmjh3mz3JdJYlJMrf1s1YAUiQOXrcSXdYC/yPRta
	qQdbaljz0IlwhEsv6plRYFNoTiMLk5FbhRUO+fWVexUkxsTefZ6M=
X-Received: by 2002:a05:6402:20d2:20b0:640:bce5:77a9 with SMTP id 4fb4d7f45d1cf-6413f070315mr2790181a12.32.1762523647773;
        Fri, 07 Nov 2025 05:54:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPBnKz6/VPxLTQ77JDwVmANubEoFCRnIC6yzVJFSSR3npksqZxhrXKE1ZmuNlEg+WLoqaVoA==
X-Received: by 2002:a05:6402:20d2:20b0:640:bce5:77a9 with SMTP id 4fb4d7f45d1cf-6413f070315mr2790133a12.32.1762523647203;
        Fri, 07 Nov 2025 05:54:07 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6412a27d68dsm3299465a12.9.2025.11.07.05.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:54:06 -0800 (PST)
Date: Fri, 7 Nov 2025 14:53:28 +0100
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
Subject: Re: [PATCH net-next v8 04/14] vsock: add netns to vsock core
Message-ID: <767jcion4jrguxsbshfap6dgncuhlgts2a5ybka5vdyos4x57d@ezkx72irws2h>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <20251023-vsock-vmtest-v8-4-dea984d02bb0@meta.com>
 <zxy7e4xihxujtlcnqjdgfxaqckfurop77eukbose74nzaxyv64@7djyz3gv4eys>
 <aQ1TXjb8AWIzgAu4@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aQ1TXjb8AWIzgAu4@devvm11784.nha0.facebook.com>

On Thu, Nov 06, 2025 at 06:03:10PM -0800, Bobby Eshleman wrote:
>On Thu, Nov 06, 2025 at 05:18:00PM +0100, Stefano Garzarella wrote:
>> On Thu, Oct 23, 2025 at 11:27:43AM -0700, Bobby Eshleman wrote:
>> > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> >
>> > Add netns logic to vsock core. Additionally, modify transport hook
>> > prototypes to be used by later transport-specific patches (e.g.,
>> > *_seqpacket_allow()).
>> >
>> > Namespaces are supported primarily by changing socket lookup functions
>> > (e.g., vsock_find_connected_socket()) to take into account the socket
>> > namespace and the namespace mode before considering a candidate socket a
>> > "match".
>> >
>> > Introduce a dummy namespace struct, __vsock_global_dummy_net, to be
>> > used by transports that do not support namespacing. This dummy always
>> > has mode "global" to preserve previous CID behavior.
>> >
>> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode that
>> > accepts the "global" or "local" mode strings.
>> >
>> > The transports (besides vhost) are modified to use the global dummy,
>> > which makes them behave as if always in the global namespace. Vhost is
>> > an exception because it inherits its namespace from the process that
>> > opens the vhost device.
>> >
>> > Add netns functionality (initialization, passing to transports, procfs,
>> > etc...) to the af_vsock socket layer. Later patches that add netns
>> > support to transports depend on this patch.
>> >
>> > seqpacket_allow() callbacks are modified to take a vsk so that transport
>> > implementations can inspect sock_net(sk) and vsk->net_mode when performing
>> > lookups (e.g., vhost does this in its future netns patch). Because the
>> > API change affects all transports, it seemed more appropriate to make
>> > this internal API change in the "vsock core" patch then in the "vhost"
>> > patch.
>> >
>> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>> > ---
>> > Changes in v7:
>> > - hv_sock: fix hyperv build error
>> > - explain why vhost does not use the dummy
>> > - explain usage of __vsock_global_dummy_net
>> > - explain why VSOCK_NET_MODE_STR_MAX is 8 characters
>> > - use switch-case in vsock_net_mode_string()
>> > - avoid changing transports as much as possible
>> > - add vsock_find_{bound,connected}_socket_net()
>> > - rename `vsock_hdr` to `sysctl_hdr`
>> > - add virtio_vsock_alloc_linear_skb() wrapper for setting dummy net and
>> >  global mode for virtio-vsock, move skb->cb zero-ing into wrapper
>> > - explain seqpacket_allow() change
>> > - move net setting to __vsock_create() instead of vsock_create() so
>> >  that child sockets also have their net assigned upon accept()
>> >
>> > Changes in v6:
>> > - unregister sysctl ops in vsock_exit()
>> > - af_vsock: clarify description of CID behavior
>> > - af_vsock: fix buf vs buffer naming, and length checking
>> > - af_vsock: fix length checking w/ correct ctl_table->maxlen
>> >
>> > Changes in v5:
>> > - vsock_global_net() -> vsock_global_dummy_net()
>> > - update comments for new uAPI
>> > - use /proc/sys/net/vsock/ns_mode instead of /proc/net/vsock_ns_mode
>> > - add prototype changes so patch remains compilable
>> > ---
>> > drivers/vhost/vsock.c            |   4 +-
>> > include/linux/virtio_vsock.h     |  21 ++++
>> > include/net/af_vsock.h           |  14 ++-
>> > net/vmw_vsock/af_vsock.c         | 264 ++++++++++++++++++++++++++++++++++++---
>> > net/vmw_vsock/virtio_transport.c |   7 +-
>> > net/vmw_vsock/vsock_loopback.c   |   4 +-
>> > 6 files changed, 288 insertions(+), 26 deletions(-)
>> >
>> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>> > index ae01457ea2cd..34adf0cf9124 100644
>> > --- a/drivers/vhost/vsock.c
>> > +++ b/drivers/vhost/vsock.c
>> > @@ -404,7 +404,7 @@ static bool vhost_transport_msgzerocopy_allow(void)
>> > 	return true;
>> > }
>> >
>> > -static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>> > +static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid);
>> >
>> > static struct virtio_transport vhost_transport = {
>> > 	.transport = {
>> > @@ -460,7 +460,7 @@ static struct virtio_transport vhost_transport = {
>> > 	.send_pkt = vhost_transport_send_pkt,
>> > };
>> >
>> > -static bool vhost_transport_seqpacket_allow(u32 remote_cid)
>> > +static bool vhost_transport_seqpacket_allow(struct vsock_sock *vsk, u32 remote_cid)
>> > {
>> > 	struct vhost_vsock *vsock;
>> > 	bool seqpacket_allow = false;
>> > diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>> > index 7f334a32133c..29290395054c 100644
>> > --- a/include/linux/virtio_vsock.h
>> > +++ b/include/linux/virtio_vsock.h
>> > @@ -153,6 +153,27 @@ static inline void virtio_vsock_skb_set_net_mode(struct sk_buff *skb,
>> > 	VIRTIO_VSOCK_SKB_CB(skb)->net_mode = net_mode;
>> > }
>> >
>> > +static inline struct sk_buff *
>> > +virtio_vsock_alloc_rx_skb(unsigned int size, gfp_t mask)
>> > +{
>> > +	struct sk_buff *skb;
>> > +
>> > +	skb = virtio_vsock_alloc_linear_skb(size, mask);
>> > +	if (!skb)
>> > +		return NULL;
>> > +
>> > +	memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
>> > +
>> > +	/* virtio-vsock does not yet support namespaces, so on receive
>> > +	 * we force legacy namespace behavior using the global dummy net
>> > +	 * and global net mode.
>> > +	 */
>> > +	virtio_vsock_skb_set_net(skb, vsock_global_dummy_net());
>> > +	virtio_vsock_skb_set_net_mode(skb, VSOCK_NET_MODE_GLOBAL);
>> > +
>> > +	return skb;
>> > +}
>>
>> Why we are introducing this change in this patch?
>>
>> Where the net of the virtio's skb is read?
>>
>
>Oh good point, this is a weird place for this. I'll move this to where
>it is actually used.
>
>[...]
>
>> >
>> > +static int vsock_net_mode_string(const struct ctl_table *table, int write,
>> > +				 void *buffer, size_t *lenp, loff_t *ppos)
>> > +{
>> > +	char data[VSOCK_NET_MODE_STR_MAX] = {0};
>> > +	enum vsock_net_mode mode;
>> > +	struct ctl_table tmp;
>> > +	struct net *net;
>> > +	int ret;
>> > +
>> > +	if (!table->data || !table->maxlen || !*lenp) {
>> > +		*lenp = 0;
>> > +		return 0;
>> > +	}
>> > +
>> > +	net = current->nsproxy->net_ns;
>> > +	tmp = *table;
>> > +	tmp.data = data;
>> > +
>> > +	if (!write) {
>> > +		const char *p;
>> > +
>> > +		mode = vsock_net_mode(net);
>> > +
>> > +		switch (mode) {
>> > +		case VSOCK_NET_MODE_GLOBAL:
>> > +			p = VSOCK_NET_MODE_STR_GLOBAL;
>> > +			break;
>> > +		case VSOCK_NET_MODE_LOCAL:
>> > +			p = VSOCK_NET_MODE_STR_LOCAL;
>> > +			break;
>> > +		default:
>> > +			WARN_ONCE(true, "netns has invalid vsock mode");
>> > +			*lenp = 0;
>> > +			return 0;
>> > +		}
>> > +
>> > +		strscpy(data, p, sizeof(data));
>> > +		tmp.maxlen = strlen(p);
>> > +	}
>> > +
>> > +	ret = proc_dostring(&tmp, write, buffer, lenp, ppos);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	if (write) {
>>
>> Do we need to check some capability, e.g. CAP_NET_ADMIN ?
>>
>
>We get that for free via the sysctl_net registration, through this path
>on open (CAP_NET_ADMIN is checked in net_ctl_permissions):
>
>	net_ctl_permissions+1
>	sysctl_perm+24
>	proc_sys_permission+117
>	inode_permission+217
>	link_path_walk+162
>	path_openat+152
>	do_filp_open+171
>	do_sys_openat2+98
>	__x64_sys_openat+69
>	do_syscall_64+93
>
>Verified with:
>
>cp /bin/echo /tmp/echo_netadmin
>setcap cap_net_admin+ep /tmp/echo_netadmin
>
>(non-root user fails with regular echo, succeeds with
>/tmp/echo_netadmin)

Thanks for checking!

Stefano


