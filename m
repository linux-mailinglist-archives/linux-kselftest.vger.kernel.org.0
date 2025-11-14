Return-Path: <linux-kselftest+bounces-45675-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C288C5F7B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 33CA635E122
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7181355051;
	Fri, 14 Nov 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PePrhLLT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12131C56D
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763158444; cv=none; b=aCQy4svxxH7mPE4z+phKqjdvUbNDeRtS2+3dlpq0SfoCwwyi03nX8H/aJE19GkUiVC0G222IeMvgSDrLAnMSbnzuKkuHqjO2wl0cDB6H/wgLhFCBbJE+0Ufdm/m/LIfsZ5GOxGfXQNAVgqWMiyzPAKXqIrfOetjsEJWVqWRpvSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763158444; c=relaxed/simple;
	bh=YFL5fxxxqEKSNlrulASCd7JeiIbvYBc7XWyMFO10QBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkTXPJ2V0G9nK14GuoQThHk/0FnHQtvmxs0bXvUo6huwlSGnJj8k3QATSbsA/uUpYcgfKEaR4GM4aT4/RjvmDmCF5cIAGWgHuLbu4OQbpK0LDLY6QhaUOb4xRCEy9Yvy/KkWO5ILRFgznB4oa/q7CvN2alTsUOOAIZbvWouq5X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PePrhLLT; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-71d60157747so21506267b3.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 14:14:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763158442; x=1763763242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Hykq0AZOv3Mcxta5MvKVi28KK2hR4lRzOujGk7TFas=;
        b=PePrhLLTUfQKtexRSDhq0+vDtTlm8UAtG/uf2zh9cA+PrBKJxVesO866zg8Z2GfUu5
         L9jJ683+mjToHB0dZPr0hHg3CDKtoSRxpelPY11Jf89hueGcpka8XspVLMb26GH8BFxh
         tWyeRoY9KgAXWjfVUJA3mdg+W9PRITh64Txaa2MFr7UyiXy81VLB53P5sZ2Ym4pClIG3
         xrAL5sYYYUvd2I2cEUNGP/g3nmq6KpaXFqCdSiLnClhV3WMT4rW9XJbT9Gnxpo522th0
         vwoZVCrX1PK42Ay8ln8cSZ1MUWgZMPNiIMbMb4KNqxT0h5TVOoFT9sobhP6X7koat3u9
         fNSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763158442; x=1763763242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Hykq0AZOv3Mcxta5MvKVi28KK2hR4lRzOujGk7TFas=;
        b=pCaWdXPFWgK+YtZqzUyiydbd+vwLbRmp+T9zbI781hGC32U5v0ckMa8ASrel3bdkY1
         hAgmne/V0uwqtNjwUzs+K3IRPGV8ESZ5t0q337jHjPTTdP2QtZ/34tlzsn61A9QV2+nk
         z0vxcinxOC0D3XkNiljizeKa+87rsZzKdK37E5MhT/gKtB659hpqANL0qQX4OXva5C3H
         2S6V0cyBEe/BClJiB16Kl0+CN5vDfRVPry4NBdABWXfbe5YJo1TOxK9lvHV1zC4DopQ8
         hnxrYMd1PEitac766wRw2pEZ9U4PWc7BNlHyHvto4CUsOrWyJNT/eyUcGADbdPae9V7G
         wF4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWTd9oXw0aTtyytwXaBka13oWBQEghNVj0Fkko0rmslMWrv1NU+x9306zSwpzzn+vcjgjsJFNpubmXB0FCQrKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhcyDm5r+YtHI4vxzQbN0KFeUhw5U+atrAI2AEbc8xeFrjmxOj
	n2ebAr7+JwKO4UDc1EZ8JRMwmkgdlLDVOsCkMykhaC1sW/w/0QYUci0V
X-Gm-Gg: ASbGncv1PG5uzttHC4/P84x9epL7zP4jGJ5swcxUSlPzgdi7v3C7fqF1PaD4I+hIvkX
	V3qfE5BT35qdna40FTHjcaV3Vrj9QpOrsTlLKva0OW2oDpSurSINT80K01nf393viJzxEt7Xh08
	zjmqajLncfE3pO8dwylinYvLi0wWTt1vqHpdzbGA1KXPM3LD34ioM1tp4hpzC9KUgGbzRRL5mcp
	zGKhLhGhrxk5wbGq1zN4MGPd8grRiYzEjkPDwZJT35qmbORPkwaylv/oFildxILjp/cun/xNoCs
	houltHeJNWTtKaVQzfxP6r70TUPN5NWGcJNkGFHymLW049snTh1y4ar16g2CtuUuo4a144yPM9R
	VCj2NtZukbJ2oHdcVgwYLXgHla5cMaT6s5JSmRnAi6Rf+fz/4uayB+uMKfhR1+teNaQwDbHvokH
	H+MYbRyicQfPIxciwKl1gUnBxmejh2j1gz7eCEH2ue1lSw0g==
X-Google-Smtp-Source: AGHT+IGcJZO4HUiY70v/QCO/xzK+nTyMf7KdDebKqAftSKwEa0NHlBS6WCaAwow7uyA9ZmNwfg0Gcg==
X-Received: by 2002:a05:690c:7603:b0:788:ee99:f125 with SMTP id 00721157ae682-78929e0d4a5mr32556247b3.2.1763158441752;
        Fri, 14 Nov 2025 14:14:01 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78822151d43sm19410627b3.46.2025.11.14.14.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:14:01 -0800 (PST)
Date: Fri, 14 Nov 2025 14:13:59 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <aRepp4Weuhaxgn6W@devvm11784.nha0.facebook.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
 <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
 <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>

On Fri, Nov 14, 2025 at 10:33:42AM +0100, Stefano Garzarella wrote:
> On Thu, Nov 13, 2025 at 10:26:04AM -0800, Bobby Eshleman wrote:
> > On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
> > > On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
> > > > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
> > > > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
> > > > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > > >
> > > > > > Add NS support to vsock loopback. Sockets in a global mode netns
> > > > > > communicate with each other, regardless of namespace. Sockets in a local
> > > > > > mode netns may only communicate with other sockets within the same
> > > > > > namespace.
> > > > > >
> > > > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > [...]
> > 
> > > > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
> > > > > > 		 */
> > > > > > 		virtio_transport_consume_skb_sent(skb, false);
> > > > > > 		virtio_transport_deliver_tap_pkt(skb);
> > > > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
> > > > > > +
> > > > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
> > > > > > +		 * does not hold a reference on the socket, and so does not
> > > > > > +		 * transitively hold a reference on the net.
> > > > > > +		 *
> > > > > > +		 * There is an ABA race condition in this sequence:
> > > > > > +		 * 1. the sender sends a packet
> > > > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
> > > > > > +		 *    sender's net
> > > > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
> > > > > > +		 *    sender's net
> > > > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
> > > > > > +		 *    reference to the socket
> > > > > > +		 * 5. the socket closes, frees its reference to the net
> > > > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
> > > > > > +		 *    processes the skb, and uses the now stale net pointer for
> > > > > > +		 *    socket lookups.
> > > > > > +		 *
> > > > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
> > > > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
> > > > > > +		 *
> > > > > > +		 * Additionally, we must grab a reference on the skb before
> > > > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
> > > > > > +		 * freeing the skb before we have a chance to release the net.
> > > > > > +		 */
> > > > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
> > > > > > +		net = virtio_vsock_skb_net(skb);
> > > > >
> > > > > Wait, we are adding those just for loopback (in theory used only for
> > > > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
> > > > > case?
> > > >
> > > > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
> > > > for vhost-vsock because vhost_vsock holds a net reference, and it
> > > > doesn't exist for non-reset_no_sock calls because after looking up the
> > > > socket we transfer skb ownership to it, which holds down the skb -> sk ->
> > > > net reference chain.
> > > >
> > > > >
> > > > > Honestly I don't like this, do we have any alternative?
> > > > >
> > > > > I'll also try to think something else.
> > > > >
> > > > > Stefano
> > > >
> > > >
> > > > I've been thinking about this all morning... maybe
> > > > we can do something like this:
> > > >
> > > > ```
> > > >
> > > > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
> > > >
> > > > virtio_transport_reset_no_sock(..., reply_sk)
> > > > {
> > > > 	if (reply_sk)
> > > > 		skb_set_owner_sk_safe(reply, reply_sk)
> > > 
> > > Interesting, but what about if we call skb_set_owner_sk_safe() in
> > > vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
> > > skb?
> > 
> > I think the issue with this is that at the time vsock_loopback calls
> > virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
> > virtio_transport_reset_no_sock() and we can't wait for it to return
> > because the original skb may be freed by then.
> 
> Right!
> 
> > 
> > We might be able to keep it all in vsock_loopback if we removed the need
> > to use the original skb or sk by just using the net. But to do that we
> > would need to add a netns_tracker per net somewhere. I guess that would
> > end up in a list or hashmap in struct vsock_loopback.
> > 
> > Another option that does simplify a little, but unfortunately still doesn't keep
> > everything in loopback:
> > 
> > @@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> > 	if (!reply)
> > 		return -ENOMEM;
> > 
> > -	return t->send_pkt(reply, net, net_mode);
> > +	return t->send_pkt(reply, net, net_mode, skb->sk);
> > }
> > 
> > @@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
> > }
> > 
> > static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
> > -				   enum vsock_net_mode net_mode)
> > +				   enum vsock_net_mode net_mode,
> > +				   struct sock *rst_owner)
> > {
> > 	struct vsock_loopback *vsock = &the_vsock_loopback;
> > 	int len = skb->len;
> > 
> > +	if (!skb->sk && rst_owner)
> > +		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
> > +			  "loopback socket has sk_refcnt == 0\n");
> > +
> 
> This doesn't seem too bad IMO, but at this point, why we can't do that
> in virtio_transport_reset_no_sock() for any kind of transport?
> 
> I mean, in any case the RST packet should be handled by the same net of the
> "sender", no?
> 
> At this point, can we just put the `vsk` of the sender in the `info` and
> virtio_transport_alloc_skb() will already do that.
> 
> WDYT?
> Am I missing something?

This is the right answer... I'm pretty sure this works out-of-the-box
for all transports.

I'll implement it and report back with a new rev if all good or come
back to this thread to discuss if any issues arise.

Have a good weekend!

Best,
Bobby

