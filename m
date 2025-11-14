Return-Path: <linux-kselftest+bounces-45633-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE02C5C574
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 10:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36CD6362524
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756C3093DE;
	Fri, 14 Nov 2025 09:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yh6vWaYA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ib8hE1aZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B323090FF
	for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112838; cv=none; b=i6xG3nf2ceARIxl8WLcx5jOt9+L1h/kX8SKZ13C/kT944H3HK7hMT3AdihuD5JLLGLGulTJtffaW8jB9sDZEEcS3wKQ64uciM5kBXQ7HuGTfufdEPnbENP8qodDkNdZOxFzgiqKHhbk7rkYCPdA8RSVyd32ipAIw4nxCKR0qCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112838; c=relaxed/simple;
	bh=RCAYjz6vIOf/R1vbx+PtwnV+PTpqHXlUQYFV+h701Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uG81yX4hoXQSRy+/4guWrhWRCJx2ufdn3sFISQ4fasQ+uK+nGUI4uQPcBIEzTw0w4kwpw1GDMc6czpQkMX0Wg2L/t+J2aCA6lguUouiQ94CYVqgwCzEKOdIol+yS8L0ykrjKoGoy0KrVzXnMJfjLyO83CXSGX75iv+knRfPNoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yh6vWaYA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ib8hE1aZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763112835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=36+oyKfeG61oAI4qrJ6KOF+T0ZR3Arugp2HRWWLDhJ4=;
	b=Yh6vWaYAgOX6gLuYTL/VvQhGyEkMzFc8414NKT0RsoFRN3HSAgZmrXpPsBSV+4Vfrc0LTE
	pP76wDcyeGqMk3nFMXA8UFqEWSHUSRv4paTakAapKd9FCzoyDF15oMphl4p7vl7Gyk7NuZ
	VS/WC6A+POeOPG8zHLH80F6W9EnYd/4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141--PD6LClqOd-Sfd6I6_By6g-1; Fri, 14 Nov 2025 04:33:54 -0500
X-MC-Unique: -PD6LClqOd-Sfd6I6_By6g-1
X-Mimecast-MFC-AGG-ID: -PD6LClqOd-Sfd6I6_By6g_1763112834
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8824b00ee8bso25754816d6.0
        for <linux-kselftest@vger.kernel.org>; Fri, 14 Nov 2025 01:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763112834; x=1763717634; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=36+oyKfeG61oAI4qrJ6KOF+T0ZR3Arugp2HRWWLDhJ4=;
        b=Ib8hE1aZXz4zT5Lv37neXp5/gUItI6PeSqWfmrJnjjocU2dUB5lrg8JnqhpOxTDNyE
         H4OR1VS9H9+mDSmGrrMUlu+RyN16z88mCMs0/SNTUIEmwA9vAhTQNDTyDeFRL7hHGQeo
         elmwWhnix7wzYkzbShb/D9o0JAvahh2O0LNSe5J/OJPWXSMqrHuGYqYXEHMhftM3Ukrt
         e7J7/4OHwLoQCXTGzesDeDEaER9BknFsDCR9F7Ss0R1M1lp7ZueWf+yCOtCbNagn6h/4
         6m7jY7rAjn9Cf+d/NxipwqycQ5Yv7H+wVGpydDqh0gFDMZW3FwnjPmH+YOXFwOyjGlkD
         PMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112834; x=1763717634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36+oyKfeG61oAI4qrJ6KOF+T0ZR3Arugp2HRWWLDhJ4=;
        b=vmb14AF5601spCI1qFjcG+/b2NdYi38Wx40txD2mW1ezVCALuYv47Y7xO+Z9H8BYAy
         EJSCDwyOlQgiv2SrvSPozDvGtmcVHNEsObbcX5Ntw6iRbQXRFPk+q5yc8uezJ2AulH2e
         rW5oIiOCXIEqeJyThbNUXR4/jgrCCUwRyxRQ2AAF9Ac8PgEI9uGsy425DLpWhOj3OOEW
         ExqJADlcnN+VL5cYt9410cgIyW+v1kMLpky4BIFN6EMsTT2chO96pS+UIsZ3Zi3ZCbN6
         oipQLKPykJmd2gL4E/DxZAMCxMiGYsyvU9ckeZvtm0vaoRBJCFxoufUj9Gbr1ivOol2h
         s0mQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFx7rhY7iufcDzVuoU+5uzgD1R4kWK8WE7+lS0Z0ejfHWawsPUy78U3sl+jJYBQA+81Y3aOBj9QMz+R8zvK5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOZU/pgu1/EB9J7R2+NST/dX4DppXX6tjw1Zf/m/nEkEsjT/jR
	xNPAx3HJtaxXxoy+TxF9dGat1uFz66Tu07Nm5TsxW1rEqKvL1ejg+YSco6QBXMjiEeJp07JnGEF
	eCEXIwePejWKRVJGknRvshVRfJJZrR8m4Nddtfzct5URiAao3RzyAzlkNc3BdPFazCLIFKw==
X-Gm-Gg: ASbGncsgSNbLZ0a6qN7Sn+xE6QzhgEo+0GvgHpgAKdcVtQTZ2wUDSKwZaIzYi+yIvNE
	yqQ9tbOyPpv1gTtDptBlrM1et1xJgBObspJtXtimTt0jhs2Jwdda/Pt28jyXm66IPXWOO/AYK98
	MOKO1gYZ6Z2LKBIst/cbsbtfzV4LrHjBpoL6P95hTnhrHQjKvcxF/TjtWnUIB7ZTd8gRny3XmB7
	grCw02qOLD4FG/YzlPwrUR+L7030hgJg8oAxiSbnU9B7uUDLeG5IZzBxBxmOXaUoJ3ZOKHFq9wA
	5ED/daoN+IrNGFl3oxg04WIV9vfTbM8HvCRMJHlvIAIiRN79rfOkhQGdsvOFSrhp573MEd3u7YU
	vInLIuSA6XdlZXNFLzHSeLMp9jD9/UtwC+uj71qET6mfqtuIcafA=
X-Received: by 2002:a05:6214:d05:b0:880:48bc:e08f with SMTP id 6a1803df08f44-88292686794mr35504906d6.40.1763112833699;
        Fri, 14 Nov 2025 01:33:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjHrJ9Ml1IttqxcPVYY9SH7uhe2Rph9BOIsWj75UI9bX73556O1rec437jZYFpPhU03rOjlA==
X-Received: by 2002:a05:6214:d05:b0:880:48bc:e08f with SMTP id 6a1803df08f44-88292686794mr35504466d6.40.1763112833200;
        Fri, 14 Nov 2025 01:33:53 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882865342c4sm27689996d6.28.2025.11.14.01.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:33:51 -0800 (PST)
Date: Fri, 14 Nov 2025 10:33:42 +0100
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
Subject: Re: [PATCH net-next v9 06/14] vsock/loopback: add netns support
Message-ID: <kwgjzpxxqpkgwafydp65vlj6jlf7h7kcnhwgtwrrhzp2qtgkkq@z3xfl26ejspl>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-6-852787a37bed@meta.com>
 <g6bxp6hketbjrddzni2ln37gsezqvxbu2orheorzh7fs66roll@hhcrgsos3ui3>
 <aRTRhk/ok06YKTEu@devvm11784.nha0.facebook.com>
 <g5dcyor4aryvtcnqxm5aekldbettetlmog3c7sj7sjx3yp2pgy@hcpxyubied2n>
 <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aRYivEKsa44u5Mh+@devvm11784.nha0.facebook.com>

On Thu, Nov 13, 2025 at 10:26:04AM -0800, Bobby Eshleman wrote:
>On Thu, Nov 13, 2025 at 04:24:44PM +0100, Stefano Garzarella wrote:
>> On Wed, Nov 12, 2025 at 10:27:18AM -0800, Bobby Eshleman wrote:
>> > On Wed, Nov 12, 2025 at 03:19:47PM +0100, Stefano Garzarella wrote:
>> > > On Tue, Nov 11, 2025 at 10:54:48PM -0800, Bobby Eshleman wrote:
>> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
>> > > >
>> > > > Add NS support to vsock loopback. Sockets in a global mode netns
>> > > > communicate with each other, regardless of namespace. Sockets in a local
>> > > > mode netns may only communicate with other sockets within the same
>> > > > namespace.
>> > > >
>> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>
>[...]
>
>> > > > @@ -131,7 +136,41 @@ static void vsock_loopback_work(struct work_struct *work)
>> > > > 		 */
>> > > > 		virtio_transport_consume_skb_sent(skb, false);
>> > > > 		virtio_transport_deliver_tap_pkt(skb);
>> > > > -		virtio_transport_recv_pkt(&loopback_transport, skb, NULL, 0);
>> > > > +
>> > > > +		/* In the case of virtio_transport_reset_no_sock(), the skb
>> > > > +		 * does not hold a reference on the socket, and so does not
>> > > > +		 * transitively hold a reference on the net.
>> > > > +		 *
>> > > > +		 * There is an ABA race condition in this sequence:
>> > > > +		 * 1. the sender sends a packet
>> > > > +		 * 2. worker calls virtio_transport_recv_pkt(), using the
>> > > > +		 *    sender's net
>> > > > +		 * 3. virtio_transport_recv_pkt() uses t->send_pkt() passing the
>> > > > +		 *    sender's net
>> > > > +		 * 4. virtio_transport_recv_pkt() free's the skb, dropping the
>> > > > +		 *    reference to the socket
>> > > > +		 * 5. the socket closes, frees its reference to the net
>> > > > +		 * 6. Finally, the worker for the second t->send_pkt() call
>> > > > +		 *    processes the skb, and uses the now stale net pointer for
>> > > > +		 *    socket lookups.
>> > > > +		 *
>> > > > +		 * To prevent this, we acquire a net reference in vsock_loopback_send_pkt()
>> > > > +		 * and hold it until virtio_transport_recv_pkt() completes.
>> > > > +		 *
>> > > > +		 * Additionally, we must grab a reference on the skb before
>> > > > +		 * calling virtio_transport_recv_pkt() to prevent it from
>> > > > +		 * freeing the skb before we have a chance to release the net.
>> > > > +		 */
>> > > > +		net_mode = virtio_vsock_skb_net_mode(skb);
>> > > > +		net = virtio_vsock_skb_net(skb);
>> > >
>> > > Wait, we are adding those just for loopback (in theory used only for
>> > > testing/debugging)? And only to support virtio_transport_reset_no_sock() use
>> > > case?
>> >
>> > Yes, exactly, only loopback + reset_no_sock(). The issue doesn't exist
>> > for vhost-vsock because vhost_vsock holds a net reference, and it
>> > doesn't exist for non-reset_no_sock calls because after looking up the
>> > socket we transfer skb ownership to it, which holds down the skb -> sk ->
>> > net reference chain.
>> >
>> > >
>> > > Honestly I don't like this, do we have any alternative?
>> > >
>> > > I'll also try to think something else.
>> > >
>> > > Stefano
>> >
>> >
>> > I've been thinking about this all morning... maybe
>> > we can do something like this:
>> >
>> > ```
>> >
>> > virtio_transport_recv_pkt(...,  struct sock *reply_sk) {... }
>> >
>> > virtio_transport_reset_no_sock(..., reply_sk)
>> > {
>> > 	if (reply_sk)
>> > 		skb_set_owner_sk_safe(reply, reply_sk)
>>
>> Interesting, but what about if we call skb_set_owner_sk_safe() in
>> vsock_loopback.c just before calling virtio_transport_recv_pkt() for every
>> skb?
>
>I think the issue with this is that at the time vsock_loopback calls
>virtio_transport_recv_pkt() the reply skb hasn't yet been allocated by
>virtio_transport_reset_no_sock() and we can't wait for it to return
>because the original skb may be freed by then.

Right!

>
>We might be able to keep it all in vsock_loopback if we removed the need
>to use the original skb or sk by just using the net. But to do that we
>would need to add a netns_tracker per net somewhere. I guess that would
>end up in a list or hashmap in struct vsock_loopback.
>
>Another option that does simplify a little, but unfortunately still doesn't keep
>everything in loopback:
>
>@@ -1205,7 +1205,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
> 	if (!reply)
> 		return -ENOMEM;
>
>-	return t->send_pkt(reply, net, net_mode);
>+	return t->send_pkt(reply, net, net_mode, skb->sk);
> }
>
>@@ -27,11 +27,16 @@ static u32 vsock_loopback_get_local_cid(void)
> }
>
> static int vsock_loopback_send_pkt(struct sk_buff *skb, struct net *net,
>-				   enum vsock_net_mode net_mode)
>+				   enum vsock_net_mode net_mode,
>+				   struct sock *rst_owner)
> {
> 	struct vsock_loopback *vsock = &the_vsock_loopback;
> 	int len = skb->len;
>
>+	if (!skb->sk && rst_owner)
>+		WARN_ONCE(!skb_set_owner_sk_safe(skb, rst_owner),
>+			  "loopback socket has sk_refcnt == 0\n");
>+

This doesn't seem too bad IMO, but at this point, why we can't do that
in virtio_transport_reset_no_sock() for any kind of transport?

I mean, in any case the RST packet should be handled by the same net of 
the "sender", no?

At this point, can we just put the `vsk` of the sender in the `info` and 
virtio_transport_alloc_skb() will already do that.

WDYT?
Am I missing something?

> 	virtio_vsock_skb_queue_tail(&vsock->pkt_queue, skb);
> 	queue_work(vsock->workqueue, &vsock->pkt_work);
>
>>
>> Maybe we should refactor a bit virtio_transport_recv_pkt() e.g. moving
>> `skb_set_owner_sk_safe()` to be sure it's called only when we are sure it's
>> the right socket (e.g. after checking SOCK_DONE).
>>
>> WDYT?
>
>I agree, it is called a little prematurely.

Yep, but I'll leave this out for now :-)

Thanks,
Stefano


