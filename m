Return-Path: <linux-kselftest+bounces-47590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FEBCC0723
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 02:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D72B303BE18
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Dec 2025 01:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581F926B955;
	Tue, 16 Dec 2025 01:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E85KftC4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0CB7080E
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Dec 2025 01:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765848131; cv=none; b=kwhbHkvQWr2g2q8RL/hxB4NH463MYSMkYWUmYF3sARKOnC8v86D8Q8K/X9Fwae0pbjh9TCQeCRK+FDwsY6mlRc+d5mfhr3i51q8Jrhn4uLHgG8sTEHVVpNZFmDV93W+p9WOpY/KCpsMUzoKbwzz2a/gpbxRonHa6osikLfh+zNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765848131; c=relaxed/simple;
	bh=KhTpBrq3o1OcDzqZyQ5v6akeq46HasfcRLGJ5YYrEKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpvEg8Rlr6sRsrC2D748az0MCI0mGd3qwz0pdwaxdVFdyxCRA4SLjaI1HRzBrw2Rmx767p685ope0powFaQFfPRFxI5fASUBr2k7512efwaL3pF8v+G3ubNE3YMZvifaNj90Q+8UguF3eRgLnUbuRmRSBZY4v7LNtaZaVYvj6AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E85KftC4; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78e2fe1f568so36222657b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Dec 2025 17:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765848127; x=1766452927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lI4+C9X3I7yvyc2773MJlpz/r2L4renU7eOoChO1rz0=;
        b=E85KftC4BWZfUx89LtZEIH8y7/RxFdxyiOLkF/oGhurra3KCTuuTJmFT29mGuDqhmC
         ekGXhRUT8UCkCdfhC1g+OBDvcWXLE7x4vuiTCBNxq/6/oSLmJxCCudHAeg9dtOwTLhP7
         2zVPhEafOkBq3IsFm0xmc8K0M1DRgZab9KpcWlxKImXXLmk7i5/EZoqvUdSVy3d3keUq
         u09A5L3XTMi7GhosnNUH3ITVQbgUophG9kNdAB/9iUGr5yLfZURBwoHfkZj6DwpuDSOf
         Ox+M5hZD4MSgsMS29AuTiQo4tbX85GGZR9einVh9K+y4ecgUvbTD8aF1JF8NPyJMEC5K
         PiHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765848127; x=1766452927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lI4+C9X3I7yvyc2773MJlpz/r2L4renU7eOoChO1rz0=;
        b=szWRsUIkDUsxGQOsiTtrYKkf8DDHLsnWgoxM62x96iBxlzRHBQaFzh2EkyuesHKKTP
         68cMrsCSYZ5cx2rBh6cZAgMBQPS/uzNty4q2RytJieuk36PlgA9Yv2CsiTNlBLVIZT6y
         lDoGclcGxB828t/kBMwYjboScM3T1LAgiAQfJj/jWsFZCfVW8iyzf0X3AFnLVix8W9dF
         LF0E9iWk1EWpQk99xvZ94S1Z1+02JkTq3LR8dDy992MRapHnU9rrBwcfva38lBXNm08K
         yiRJbNYsP5E8pBlTgUw6WIB8CM7B2BJhPfvi5eHCB9zzNsmNH7RsXmj+hG8pWLhJXrVd
         tKQg==
X-Forwarded-Encrypted: i=1; AJvYcCWTJBUBGCjch7ECA/tXb+tRhCI7+82huMcDG6MZDxO/3FTuulLqTbe0g3rd3eLm30Usnm4BNJFRBSEIpoheAj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVt/3e3N2FLkUkx78oSgbdVfkGH13ooAJPUWPMvtT6REzDC1ei
	sfMJhi7e3fUkKr2KnuhlOTdAIuRx1KPEnlKoIwQvza3F7eD4sUDOm2ny
X-Gm-Gg: AY/fxX730rtwIKhu+H8GDKpy/Jgc+aOmR4ntfobNpt39O2Jz1ktzFA5Bb0Aa6IyJBIk
	fpJemLoeNIfchYn5aT2XUWYPfIB4NG8ySLfIj8dx4N0DxilyzxErd8HKq+Mood8bNQwz/NzSvkZ
	KOT3tc8UdTDc+jKqmXFleow2wkRv+GAlcFQ7rRaV3EVsLIJ6eSiUpE3VjkiAGvl/VhSIzPT2ugP
	x3kx4pSUyMgT3OX+vsBi80HG2unbsgiHxhZ11/wUUVlAzSnHHmL48u1jreJQ77SN8zFRGbd+QeM
	sswHfOXGq74NisPAI6nDJv22WKsVvl1ZL7t0RMwB5wUhm7kVcA9JpVLOg4IbKeES+61DabSKCzT
	pAdkAQrc9sXwViGGNxeSuEHaQh7/WBNFTbDZSbqJQrXXQu8Zl1VO6ZgfxA/pVcq3wC3vzha9wv5
	fIb9lMZ0ZxjEPtDb9pnG4cMC6gddFEejramrxedG5WM+j3oGk=
X-Google-Smtp-Source: AGHT+IHFuEiGcW0GH4lABrKUUSbE6qv7huuMOYC9DtT8UyxlS9XUtUukZA6W5M9Qt9zONS5q8T2xVg==
X-Received: by 2002:a05:690e:128c:b0:63f:ab00:1a07 with SMTP id 956f58d0204a3-64555643a56mr9274950d50.49.1765848124847;
        Mon, 15 Dec 2025 17:22:04 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78e748cecd9sm34175187b3.9.2025.12.15.17.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 17:22:04 -0800 (PST)
Date: Mon, 15 Dec 2025 17:22:02 -0800
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
Message-ID: <aUC0Op2trtt3z405@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
 <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
 <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <uidarlot7opjsuozylevyrlgdpjd32tsi7mwll2lsvce226v24@75sq4jdo5tgv>

On Mon, Dec 15, 2025 at 03:11:22PM +0100, Stefano Garzarella wrote:
> On Fri, Dec 12, 2025 at 07:26:15AM -0800, Bobby Eshleman wrote:
> > On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > > > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > > > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > > > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > > > >>>  		goto out;
> > > > >>>  	}
> > > > >>>
> > > > >>> +	net = current->nsproxy->net_ns;
> > > > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > > > >>> +
> > > > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > > > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > > > >>> +	 * to continue operating normally and not suddenly break. For that
> > > > >>> +	 * reason, we save the mode here and later use it when performing
> > > > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > > > >>> +	 */
> > > > >>> +	vsock->net_mode = vsock_net_mode(net);
> > > > >>
> > > > >> I'm sorry for the very late feedback. I think that at very least the
> > > > >> user-space needs a way to query if the given transport is in local or
> > > > >> global mode, as AFAICS there is no way to tell that when socket creation
> > > > >> races with mode change.
> > > > >
> > > > > Are you thinking something along the lines of sockopt?
> > > >
> > > > I'd like to see a way for the user-space to query the socket 'namespace
> > > > mode'.
> > > >
> > > > sockopt could be an option; a possibly better one could be sock_diag. Or
> > > > you could do both using dumping the info with a shared helper invoked by
> > > > both code paths, alike what TCP is doing.
> > > > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > > > >> may cross netns boundaris and connect to 'local' socket in other netns
> > > > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > > > >> isolation.
> > > > >
> > > > > Local mode sockets are unable to communicate with local mode (and global
> > > > > mode too) sockets that are in other namespaces. The key piece of code
> > > > > for that is vsock_net_check_mode(), where if either modes is local the
> > > > > namespaces must be the same.
> > > >
> > > > Sorry, I likely misread the large comment in patch 2:
> > > >
> > > > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > > >
> > > > >> Have you considered instead a slightly different model, where the
> > > > >> local/global model is set in stone at netns creation time - alike what
> > > > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > > > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > > > >> you will need new transport operations for that)?
> > > > >>
> > > > >> /P
> > > > >>
> > > > >> [1] tcp allows using per-netns established socket lookup tables - as
> > > > >> opposed to the default global lookup table (even if match always takes
> > > > >> in account the netns obviously). The mentioned sysctl specify such
> > > > >> configuration for the children namespaces, if any.
> > > > >
> > > > > I'll save this discussion if the above doesn't resolve your concerns.
> > > > I still have some concern WRT the dynamic mode change after netns
> > > > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > > > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > > > issue, but I understand it would be a significant change over the
> > > > current status.
> > > >
> > > > "Luckily" the merge window is on us and we have some time to discuss. Do
> > > > you have a specific use-case for the ability to change the netns >
> > > mode
> > > > after creation?
> > > >
> > > > /P
> > > 
> > > I don't think there is a hard requirement that the mode be change-able
> > > after creation. Though I'd love to avoid such a big change... or at
> > > least leave unchanged as much of what we've already reviewed as
> > > possible.
> > > 
> > > In the scheme of defining the mode at creation and following the
> > > tcp_child_ehash_entries-ish model, what I'm imagining is:
> > > - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> > > - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
> > >   number of times
> > > 
> > > - when a netns is created, the new netns mode is inherited from
> > >   child_ns_mode, being assigned using something like:
> > > 
> > > 	  net->vsock.ns_mode =
> > > 		get_net_ns_by_pid(current->pid)->child_ns_mode
> > > 
> > > - /proc/sys/net/vsock/ns_mode queries the current mode, returning
> > >   "local" or "global", returning value of net->vsock.ns_mode
> > > - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
> > >   reject writes
> > > 
> > > Does that align with what you have in mind?
> > 
> > Hey Paolo, I just wanted to sync up on this one. Does the above align
> > with what you envision?
> 
> Hi Bobby, AFAIK Paolo was at LPC, so there could be some delay.
> 
> FYI I'll be off from Dec 25 to Jan 6, so if we want to do an RFC in the
> middle, I'll do my best to take a look before my time off.
> 
> Thanks,
> Stefano
> 

Sounds like a plan, thanks!

Best,
Bobby

