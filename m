Return-Path: <linux-kselftest+bounces-47949-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1107BCDB2DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 03:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 95122300BDBC
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Dec 2025 02:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E992B2765FF;
	Wed, 24 Dec 2025 02:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSRTvEQT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D101F9F7A
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Dec 2025 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766543400; cv=none; b=Z8/xwt6rhRWqbD7wZtdKainSqmKRO1yMUqWb27p/rnHTu++Og1IpT1mY7zQvlWDpAXA63pNG+6YpG1oOLroC+8aPbS7yqkKhX32StFf2sSTu6No6NMeEe9NkS1ewRjgVz9OyTa+Yp/gYBV9N6YSj6tKiaCkzQXOwPSLyQwVpS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766543400; c=relaxed/simple;
	bh=fag3FxlJG3ZXO56Q4uis4IXo7o2vEhpJMwuQCgBCfc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G1mLO6XinJxTqOk3WLd06yOBpaCQj6P2jNvt4nXfGfp2nqpGpIoOm4s+TVti7F3N7qTqODfGVzRgUjBxc3OdspIyWjxyW2e0qXzbUODLXHrbXxS7DOKTUvPZiEiMsY5tANjg79teBNDODU1i35HDHMjwqX47kmTdpgyReWtJfac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSRTvEQT; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-3f0ec55ce57so3805134fac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Dec 2025 18:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766543398; x=1767148198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=MSRTvEQTyNqrZ0qCE0J5ABy2scbUV73XPWASHcFnr2zba2EAjY1uIwUNDzrurRO4J9
         qfhsX0Xo5jKP+VjHT29fC4L/4NRwklxNVXaGDvbpQz4VYxfMS5Xry9O22NYaRBoL4hd1
         hgQlS+M+3M0GfkIXRHQ96MwDlNc1CsV1zNNlw2aXXmWIORhWyoLlR1G1HBG40x25ArAX
         pAs/JxKzhoTPrWQhfncuJrfU5GcajYOsdTsmeDCxPEWfuOUR2dsRXNSDLAyHsJ6/8y/Z
         aP7gr+kKuLwv+SQjG4m8DWb9YpyrBw1eP69X+qvGd86qEaM3r8SJt+nl45H1fZBEjBn+
         1REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766543398; x=1767148198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mn5gdOJNVLCgqxTAZaOj5KghlS4vIZEHYcNf0bwJm28=;
        b=wBeN3X5+SjnKD8UHQC62qzGf0vygBJzvp8lD4T6wgyFEYvnr0/pzx2aHP7WjeaSOE+
         y4t+G/i6Jkt7X8m5WrWWrLDoxOqbdXeQJqOn57QG7riJ7T1TuGA6oXERTJmlNZJ+OZce
         gn/rak7K8vji74B2WXMFnDlRGx5G4Y2zr2yOttbWPM1vj4WYmolAL32Uz0a5ubU4POkw
         m5eknT7X/cIZXeu8y1Oqyl1tEMJ06DqNubf7BepuLYJMD1sL97JO3ZOENQNDlx888TFJ
         V5nlIEYLR6U4JkS/RxjwwGkirMJ41Y5NLh+3F4222UGsNMuqAJPKL4S4TMDtEt7VX+TD
         Uvtw==
X-Forwarded-Encrypted: i=1; AJvYcCVOpJ7OQIIA2ZFsnfsUVBcZppR+1h72PBWkYHYQQ6b3He1odD+mFXE/ZOg2RPjVP1g2Cc6N/7pNMiNikrtBO3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLFu0leYGBIho9p3Y6Mn7iEDHXyNq8/+A9AMzkhnQJqyCPK5+D
	gI2VbMK776VZStXNjJMBM7AMyvObwbPi0QW2E+JSre9dNyRiUjyB8wxoKtP1xQ==
X-Gm-Gg: AY/fxX77I3rT6lkWgmjDf5ICad+9uKNbRzJU26QAxawmJT0lUxIZJMTS5o5mAvKaGoM
	nGGfelCSO4oApGCwvSnxuEWiIMhR2bU4gP8iqCBRWC+IL5ijJnKbQMEXfK28teh1y1kBj44hNvd
	PbLWJBy2w/iU68WJrhexfw7FAsyFgguH4d4ST2BK+KAG5HopZPqen3wQIXxfKyv9HECuZUYCZLj
	umjrkVT9jbvQ9AhUMy9ga8WEhksxDg12OXfx4QtNFKrC/+5KklxQu5sn5SeG9Rjr+OlQm+oOPT6
	yhXSw/v6ogztCd12zjx733o39FGs4S+TtJDgWNFOXW1+zae8qCcQ8T1qzE0dxDY4aYNAonYo+V1
	bWJOVb2kSkoku3tcrddlEpvupV9nzMlfTG1vKFvdAvcM2QaJCASq6YDKh5eBpxsSQzxgnqbbqO1
	YHe6VcfUFo6KlMCMBlBUIae7k8+CYoRtwn9od4qslPdNJLyrs=
X-Google-Smtp-Source: AGHT+IGl4lY3C5uaIhAdAeU51l9QnKvRP/mJp5bbTNMXCgmCDrIGHmPARt/rlh3H/cQnB4TIEc9mUg==
X-Received: by 2002:a05:690c:d96:b0:78f:aa6d:48cd with SMTP id 00721157ae682-78fb3d52b45mr134838347b3.0.1766536355576;
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5f::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb4378372sm59887097b3.12.2025.12.23.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:32:35 -0800 (PST)
Date: Tue, 23 Dec 2025 16:32:30 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
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
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
Message-ID: <aUs0no+ni8/R8/1N@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
 <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>

On Mon, Dec 15, 2025 at 05:22:02PM -0800, Bobby Eshleman wrote:
> On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:
> > On Fri, Dec 12, 2025 at 07:26:15AM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> > > > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > > > > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > > > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > > > > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > > > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > > > > >>>  		goto out;
> > > > > >>>  	}
> > > > > >>>
> > > > > >>> +	net = current->nsproxy->net_ns;
> > > > > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > > > >>> +
> > > > > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > > > > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > > > > >>> +	 * to continue operating normally and not suddenly break. For that
> > > > > >>> +	 * reason, we save the mode here and later use it when performing
> > > > > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > > > >>> +	 */
> > > > > >>> +	vsock->net_mode = vsock_net_mode(net);
> > > > > >>
> > > > > >> I'm sorry for the very late feedback. I think that at very least the
> > > > > >> user-space needs a way to query if the given transport is in local or
> > > > > >> global mode, as AFAICS there is no way to tell that when socket creation
> > > > > >> races with mode change.
> > > > > >
> > > > > > Are you thinking something along the lines of sockopt?
> > > > >
> > > > > I'd like to see a way for the user-space to query the socket 'namespace
> > > > > mode'.
> > > > >
> > > > > sockopt could be an option; a possibly better one could be sock_diag. Or
> > > > > you could do both using dumping the info with a shared helper invoked by
> > > > > both code paths, alike what TCP is doing.
> > > > > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > > > > >> may cross netns boundaris and connect to 'local' socket in other netns
> > > > > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > > > > >> isolation.
> > > > > >
> > > > > > Local mode sockets are unable to communicate with local mode (and global
> > > > > > mode too) sockets that are in other namespaces. The key piece of code
> > > > > > for that is vsock_net_check_mode(), where if either modes is local the
> > > > > > namespaces must be the same.
> > > > >
> > > > > Sorry, I likely misread the large comment in patch 2:
> > > > >
> > > > > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > > > >
> > > > > >> Have you considered instead a slightly different model, where the
> > > > > >> local/global model is set in stone at netns creation time - alike what
> > > > > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > > > > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > > > > >> you will need new transport operations for that)?
> > > > > >>
> > > > > >> /P
> > > > > >>
> > > > > >> [1] tcp allows using per-netns established socket lookup tables - as
> > > > > >> opposed to the default global lookup table (even if match always takes
> > > > > >> in account the netns obviously). The mentioned sysctl specify such
> > > > > >> configuration for the children namespaces, if any.
> > > > > >
> > > > > > I'll save this discussion if the above doesn't resolve your concerns.
> > > > > I still have some concern WRT the dynamic mode change after netns
> > > > > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > > > > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > > > > issue, but I understand it would be a significant change over the
> > > > > current status.
> > > > >
> > > > > "Luckily" the merge window is on us and we have some time to discuss. Do
> > > > > you have a specific use-case for the ability to change the netns >
> > > > mode
> > > > > after creation?
> > > > >
> > > > > /P
> > > > 
> > > > I don't think there is a hard requirement that the mode be change-able
> > > > after creation. Though I'd love to avoid such a big change... or at
> > > > least leave unchanged as much of what we've already reviewed as
> > > > possible.
> > > > 
> > > > In the scheme of defining the mode at creation and following the
> > > > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > > > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > > > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> > > >   number of times
> > > > 
> > > > - when a netns is created, the new netns mode is inherited from
> > > >   child_ns_mode, being assigned using something like:
> > > > 
> > > > 	  net->vsock.ns_mode =
> > > > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > > > 
> > > > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> > > >   "local" or "global", returning value of net->vsock.ns_mode
> > > > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> > > >   reject writes
> > > > 
> > > > Does that align with what you have in mind?
> > > 
> > > Hey Paolo, I just wanted to sync up on this one. Does the above align
> > > with what you envision?
> > 
> > Hi Bobby, AFAIK Paolo was at LPC, so there could be some delay.
> > 
> > FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
> > middle, I'll do my best to take a look before my time off.
> > 
> > Thanks,
> > Stefano

Just sent this out, though I acknowledge its pretty last minute WRT
your time off.

If I don't hear from you before then, have a good holiday!

Best,
Bobby

