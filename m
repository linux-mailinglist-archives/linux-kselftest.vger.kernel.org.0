Return-Path: <linux-kselftest+bounces-46400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C75BC82185
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 19:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F2B24E6D44
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 18:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDA13195EC;
	Mon, 24 Nov 2025 18:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYs2SJEg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C982BDC01
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 18:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764008760; cv=none; b=GJvKkOVdUrlybvyg8ob6a5GQQ4WfFOZwqb1t9DRAYeFSOKbbw/Kgl/1P/hn5soiamjuW+Edyopx7VKXu+jFw8UKKz4EHNphD0NJ9sKYOHhquL2xtS31jrgzZo3dMN6jQgL6yvYkznx29gb7wNnCLNQNKIwapZYY3q4jEGUV6C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764008760; c=relaxed/simple;
	bh=6AZSCjx0be8QNYc1b9ABiliBH6YVQDDfi0R5FIkWxp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SG3TRu5qJBhyrENZMkdGcx7h/7haaYNfbRK3ssSocdtydwUzPuG9nL0+Wn9m8WbtvrfxYBfyT1yw2cO4CQpFs8Ur+oaepuPXaRveYHJhKCGNaeAqus0MB3AZBmKVtGQuZE19j5M1wojwaO+uw4C5yTnLjFSv7KdoOkMY5hX3eFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYs2SJEg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-789314f0920so40732387b3.1
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Nov 2025 10:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764008758; x=1764613558; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TEB0IVYhYkoeWOmDLi9JAiu4Bvgo6alBDSG0PHHn3mY=;
        b=aYs2SJEgbdLftah9Q6DJVJMu6BeScc9QWlcEvA6WBeSJbZt72ixRMCvqjg49a4U6HS
         po3S4QhcWgXgsItovmDpnS4GN+d8mVirwSlG8YGNP0vaFVWkyxdzsd2fTFjxj/6PwO2x
         PgNvChWqHkDfKQJShotCcbqiWH9aVU/fKVjIYxVGGkEy9GhWqxJgcxt+hKxir0Cj+6fV
         tNmCFMofRG1t1gexRmZtrp1xBZT/uHTzxRphTvnZpTzBa8fqtKaNbuBI+nx+yW5ywjVi
         hk/TEX7d50YeaiRxicbV8xT4sh4zK/bvsPEf/ZUCJKF/AAKx4glQmOPC8JVvsGihApKw
         Ei2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764008758; x=1764613558;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TEB0IVYhYkoeWOmDLi9JAiu4Bvgo6alBDSG0PHHn3mY=;
        b=a6xtEYOXMMh0Tk5rTsc1MetxN5ZsbKdf235se7cSDRcU2SmlI16sOABkt8oohlg33/
         Y5t7lFpyHVFv7dPjAEaU54ytdGTdTg5FNO0H9SU+eG2qx8W6jpvWSnR9u2cA6m+hAJwC
         yeNvnHFS7ZQL4EXoX5RzsUBBQw0THmRpMqm4F3hgYQhO1VoF+ROZkfEugezsYOYNSdL5
         qp/+uXcVdivaH1h/jGsbMFo77y+/5DmIzM29YXiGZxThu92bMOffUMY5+lX5LVXaohww
         illCE0XLl2txZAH4QjY2gPSCmRg2g4Egb/iH8ea5mh97/ncYcj4bljv4II0zORTOMRwS
         AEog==
X-Forwarded-Encrypted: i=1; AJvYcCUGyLyd0X1QQ1STBIl+RgWWs6hPwoLAMzj/0xu9BON3Wvwj1SEzQfOq+aL4qJ0T+iwOSpnnVoW/iuYFy28tMZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0QCse+UOzjxV0jneHele+M4O+uBbOE548CDzxoDhpZQNwFDmU
	MIN43vhMP9vAmPUmYAzwb0BiQ3It3KMOKWfxUkn4RomsYN6DDpjicrDr
X-Gm-Gg: ASbGncsYxQy6BqKHoxmMmOFvLqBDYdlQQyJstJVQwhaLoUWhDLRiAPYvzNzhaYiSi0n
	rYO27mFM3Bs1Tlbf4w1lraGOqGU9u6rEgSUTJHpIc/vtYocQZa0bb06tu0cLzsRSBPlAYxhbmV5
	hJ86emFHKdJGwDkzl+Td0EIbtXiFpOAWP6QMK0EzQ551rE4h+4tHuGxv+1ZXEpGk9KpU7JfunCm
	czcdpJZTirHpOXjRoQvV6WdpRYpTVk/qKtzyYd1luWHEyL8ro5DSCsupD2MTPtE59f7BGylaFwB
	AsdalH1t10bx6Swp94HpQ34yU4RjjQVgcxSzOLeFeusW+or+7l63AdjsmN3z2xyeiaFdX2hglJc
	RKIAcTNL9DMQ3JhgP4WjLprD0eqLyTRkJr37/UWtFhL3Ba+EHB0tAwutpdzOsGTguToXc7BHwDb
	YwHdFJfCHmOu31NyS7+EFaCHQKtLzuHLHZUJBtGkXtYnNiuA==
X-Google-Smtp-Source: AGHT+IE0ZjSbPsIZXUiMdmSARGNpUZsggdBivDiPOdxixaSe4XdXku94FoT+/xG3xq+0F2N/k+75ZA==
X-Received: by 2002:a05:690c:6c0a:b0:787:eca1:50cf with SMTP id 00721157ae682-78a8b55dafemr91578177b3.50.1764008757922;
        Mon, 24 Nov 2025 10:25:57 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78a798a8106sm46963977b3.19.2025.11.24.10.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 10:25:57 -0800 (PST)
Date: Mon, 24 Nov 2025 10:25:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 03/13] vsock: reject bad
 VSOCK_NET_MODE_LOCAL configuration for G2H
Message-ID: <aSSjNLrRmaOLkuBN@devvm11784.nha0.facebook.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-3-55cbc80249a7@meta.com>
 <swa5xpovczqucynffqgfotyx34lziccwpqomnm5a7iwmeyixfv@uehtzbdj53b4>
 <aSC3IX81A3UhtD3N@devvm11784.nha0.facebook.com>
 <g4xir3lupnjybh7fqig6xonp32ubotdf3emmrozdm52tpaxvxn@2t4ueynb7hqr>
 <aSSV4RlRcW+uGy+n@devvm11784.nha0.facebook.com>
 <qvu2mgxs7scbuwcb2ui7eh3qe3l7mlcjq6e2favd4aqcs52r2r@oqbrlp4gxdwl>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <qvu2mgxs7scbuwcb2ui7eh3qe3l7mlcjq6e2favd4aqcs52r2r@oqbrlp4gxdwl>

On Mon, Nov 24, 2025 at 06:54:45PM +0100, Stefano Garzarella wrote:
> On Mon, Nov 24, 2025 at 09:29:05AM -0800, Bobby Eshleman wrote:
> > On Mon, Nov 24, 2025 at 11:10:19AM +0100, Stefano Garzarella wrote:
> > > On Fri, Nov 21, 2025 at 11:01:53AM -0800, Bobby Eshleman wrote:
> > > > On Fri, Nov 21, 2025 at 03:24:25PM +0100, Stefano Garzarella wrote:
> > > > > On Thu, Nov 20, 2025 at 09:44:35PM -0800, Bobby Eshleman wrote:
> 
> [...]
> 
> > > >
> > > > > Since I guess we need another version of this patch, can you check the
> > > > > commit description to see if it reflects what we are doing now
> > > > > (e.g vhost is not enabled)?
> > > > >
> > > > > Also I don't understand why for vhost we will enable it later, but for
> > > > > virtio_transport and vsock_loopback we are enabling it now, also if this
> > > > > patch is before the support on that transports. I'm a bit confused.
> > > > >
> > > > > If something is unclear, let's discuss it before sending a new version.
> > > > >
> > > > >
> > > > > What I had in mind was, add this patch and explain why we need this new
> > > > > callback (like you did), but enable the support in the patches that
> > > > > really enable it for any transport. But maybe what is not clear to me is
> > > > > that we need this only for G2H. But now I'm confused about the discussion
> > > > > around vmci H2G. We decided to discard also that one, but here we are not
> > > > > checking that?
> > > > > I mean here we are calling supports_local_mode() only on G2H IIUC.
> > > >
> > > > Ah right, VMCI broke my original mental model of only needing this check
> > > > for G2H (originally I didn't realize VMCI was H2G too).
> > > >
> > > > I think now, we actually need to do this check for all of the transports
> > > > no? Including h2g, g2h, local, and dgram?
> > > >
> > > > Additionally, the commit description needs to be updated to reflect that.
> > > 
> > > Let's take a step back, though, because I tried to understand the problem
> > > better and I'm confused.
> > > 
> > > For example, in vmci (G2H side), when a packet arrives, we always use
> > > vsock_find_connected_socket(), which only searches in GLOBAL. So connections
> > > originating from the host can only reach global sockets in the guest. In
> > > this direction (host -> guest), we should be fine, right?
> > > 
> > > Now let's consider the other direction, from guest to host, so the
> > > connection should be generated via vsock_connect().
> > > Here I see that we are not doing anything with regard to the source
> > > namespace. At this point, my question is whether we should modify
> > > vsock_assign_transport() or transport->stream_allow() to do this for each
> > > stream, and not prevent loading a G2H module a priori.
> > > 
> > > For example, stream_allow() could check that the socket namespace is
> > > supported by the assigned transport. E.g., vmci can check that if the
> > > namespace mode is not GLOBAL, then it returns false. (Same thing in
> > > virtio-vsock, I mean the G2H driver).
> > > 
> > > This should solve the guest -> host direction, but at this point I wonder if
> > > I'm missing something.
> > 
> > For the G2H connect case that is true, but the situation gets a little
> > fuzzier on the G2H RX side w/ VMADDR_CID_ANY listeners.
> > 
> > Let's say we have a nested system w/ both virtio-vsock and vhost-vsock.
> > We have a listener in namespace local on VMADDR_CID_ANY. So far, no
> > transport is assigned, so we can't call t->stream_allow() yet.
> > virtio-vsock only knows of global mode, so its lookup will fail (unless
> 
> What is the problem of failing in this case?
> I mean, we are documenting that G2H will not be able to reach socket in
> namespaces with "local" mode. Old (and default) behaviour is still allowing
> them, right?
> 
> I don't think it conflicts with the definition of “local” either, because
> these connections are coming from outside, and the user doesn't expect to be
> able to receive them in a “local” namespace, unless there is a way to put
> the device in the namespace (as with net). But this method doesn't exist
> yet, and by documenting it sufficiently, we can say that it will be
> supported in the future, but not for now.
> 
> > we hack in some special case to virtio_transport_recv_pkt() to scan
> > local namespaces). vhost-vsock will work as expected. Letting local mode
> > sockets be silently unreachable by virtio-vsock seems potentially
> > confusing for users. If the system were not nested, we can pre-resolve
> > VMADDR_CID_ANY in bind() and handle things upfront as well. Rejecting
> > local mode outright is just a broad guardrail.
> 
> Okay, but in that case, we are not supporting “local” mode too, but we are
> also preventing “global” from being used on these when we are in a nested
> environment. What is the advantage of this approach?
> 
> > 
> > If we're trying to find a less heavy-handed option, we might be able to
> > do the following:
> > 
> > - change bind(cid) w/ cid != VMADDR_CID_ANY to directly assign the
> > transport
> >  for all socket types (not just SOCK_DGRAM)
> 
> That would be nice, but it wouldn't solve the problem with VMADDR_CID_ANY,
> which I guess is the use case in 99% of cases.
> 
> > 
> > - vsock_assign_transport() can outright fail if !t->supports_local_mode()
> >  and sock_net(sk) has mode local
> 
> But in this case, why not reusing stream_allow() ?
> 
> > 
> > - bind(VMADDR_CID_ANY) can maybe print (once) to dmesg a warning that
> >  only the H2G transport will land on VMADDR_CID_ANY sockets.
> 
> mmm, I'm not sure about that, we should ask net maintainer, but IMO
> documenting that in af_vsock.c and man pages should be fine, till G2H will
> support that.
> 
> > 
> > I'm certainly open to other suggestions.
> 
> IMO we should avoid the failure when loading G2H, which is more confusing
> than just discard connection from the host to a "local" namespace. We should
> try at least to support the "global" namespace.
> 
> Thanks,
> Stefano


I'm 100% fine with that approach. I just wanted to make sure we landed
in the right place for how users may encounter places that there is no
local mode support.

So for next steps, we can drop this patch and add explicit logic in
->stream_allow() to allow local mode for vhost/loopback and reject for
others? Plus, add documentation about what happens for VMADDR_CID_ANY
(will only receive vhost/loopback traffic in local mode)?

Best,
Bobby

