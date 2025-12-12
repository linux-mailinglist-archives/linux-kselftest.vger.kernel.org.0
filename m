Return-Path: <linux-kselftest+bounces-47511-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38ACB91C0
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 16:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F3633007E75
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB8C313285;
	Fri, 12 Dec 2025 15:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FnNSwg4J"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069F30F52D
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765553184; cv=none; b=UheYzmrGQXSh87HV0xEA2/m/gC2OFZQ65Z5ODv+R8npXB1tSzcJFqPyy8bu1mwJyy/4hJUnARxx/LYNvhA03SmQg2pIT19KlUDGD2z8o+NLBMkxdOstYG/bkppD982lQjBi+YAP1i5LHtxwpFVdMNix+JoHh5nHS2OXT4MS7tuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765553184; c=relaxed/simple;
	bh=260eGi6QkxDk8QQfOLsKhm09EI+KZGuf0yseurtGq/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ORZP87sZuhNVM8r8eeTUZGZacxeyUKQn5W+s5CAZDV9qcq2sR9C8G9XD8RYfwgl4Rj7vrkoToGG9Cn0O+/LuYvx/DnLY+rb8hfsiBZlPBRu/WpiTbS+X48PRlJmUyExLhY48Nh+Oj7+dGM8g9zPf05b8y3HjZCCXm7e0QON7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FnNSwg4J; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-641e9422473so1192478d50.2
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Dec 2025 07:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765553182; x=1766157982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IK+CEXtkA15N8VNwOIEfZTiLVNxEPNXHwf9eEh9q2mY=;
        b=FnNSwg4JbGsXkFe2tJ+5wJjgau4I9z1jnEAOZjvIh8PXvGDoAjUCWWLmSpFH/N82gY
         ks3SKSB4ltqh8wZT6J060+2vd396uQqB/mO7viVGUwRYaszMJ3Hs6XWWew9C1RTByoDk
         5gAKq9Hcy3WSv2OAoMdqu5h+mhp/7kKMJ+Ot6eKE20kHrCmNFPOOEaRjLiAjdxc4tCKl
         kfbybaS35zpMVppWtd2/nNOPqkFAWdxc0v6WvqBYIbQnAB8I1wYx4DrxpzSR5mjaBMHE
         sNCze75T+kVtEK1ywH0wbBsBhtSfD4w9BT9W/Jsl9MB7+W8JOgLk8x3JKGd0P7qBom7b
         w//g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765553182; x=1766157982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IK+CEXtkA15N8VNwOIEfZTiLVNxEPNXHwf9eEh9q2mY=;
        b=VLTFkCScqEIqLES4kOZw+dENgfC3lP+/YHeX77hhWEApvnU9gks+ofkeZXvqFQxgfI
         O778N/SgQA30eOZLrACS2+Lz637UcuySjWdlPhFM8gCaeHSTeM/sCQdFOwLf4Up/evbx
         9tfnTlM5kuVWz4vs4iFMTNGFahrcspU54i0D2SynaR0UTSNkj0BPXHuhdJpC5IbX3t1n
         RKRC262tWb4k88E37DFodgEJ3syjD6XOPVqTNMQa5OxXMfiUyewD9hW0TlMAn0S23iHm
         ySnvVxFyJX/oI9jPf/Qd9s4XBy7ehTQZZmuiAuuROKKkJ9zH1YeCA35T1l6xAG3rer8a
         Fu2w==
X-Forwarded-Encrypted: i=1; AJvYcCXese4e4krp8MGKo4MWWftlWaQIthUPGIE/XxHMVO8JVzwJZJGxHKvXCu7udbzoC+okOT63tP4a+imf1v9odkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gadvNojRNE2tmJX+cirFNzUL9jsRk7BZCYLyNDZWVC5blwWy
	uIEFPY4UxgBFtd/owQi0pl8gmTMqvaRUMEfsmsibgIXwEv3mbn6SKvzw
X-Gm-Gg: AY/fxX6GNTP++NlmHb/02wX1cQ0W/DgWJ+O7reqNhiQhI0K1OgMIEIBODTVOf8bIaRX
	ha8at77RKQtp5Wgky2aipACtswZz++5Yj7jeR3L+zJSN6QO2sme6rcttJWl9LeG9/MEhxj2kuwj
	ikHF0enkv2/YDKK8FB4i/GWfiLdzaDJibvChpf4nm5aolbsr1EO/VyC1kmEV2+Y2t+gOvydugXc
	V0a1du8dkVs8JjrSon8cxtnOqaJxhI2ZK9urGA1TsIxphD4FDpE25TOQglhaF8cbD6LcOcE9NSs
	EvTCSSs4lthltmOw36LAWkZDfVwPO1VqLDR/0YV5ia9wz+iSj8js8cY0qeaFsNvYNRz/KlQWMeg
	m4hY2GJJRsoyK9ewMTyYggvW0YWUciggYKbd3gA3bZrVzKgQ2AV+azEIOw+Gn7/gqC17iqk2tj5
	7g/zZQlSfg4Xol5zqEAnywS3dh0HLJo3tY864Ouoiqi0TIskUkNU1EKQ8Ye08snJNBZdo=
X-Google-Smtp-Source: AGHT+IHPDxMRz+sSHQa8GJSWOVqErHefuxKsetCMbgKHq77F9IKQFOzGirnG2+UwGG15ipBxTc+SEQ==
X-Received: by 2002:a05:690c:7402:b0:789:61ca:88f6 with SMTP id 00721157ae682-78e66cab887mr39877247b3.4.1765553181789;
        Fri, 12 Dec 2025 07:26:21 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:3::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64477d3a32bsm2613584d50.5.2025.12.12.07.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Dec 2025 07:26:21 -0800 (PST)
Date: Fri, 12 Dec 2025 07:26:15 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
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
Message-ID: <aTw0F6lufR/nT7OY@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>

On Tue, Dec 02, 2025 at 02:01:04PM -0800, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> > On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> > >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> > >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> > >>>  		goto out;
> > >>>  	}
> > >>>  
> > >>> +	net = current->nsproxy->net_ns;
> > >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> > >>> +
> > >>> +	/* Store the mode of the namespace at the time of creation. If this
> > >>> +	 * namespace later changes from "global" to "local", we want this vsock
> > >>> +	 * to continue operating normally and not suddenly break. For that
> > >>> +	 * reason, we save the mode here and later use it when performing
> > >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> > >>> +	 */
> > >>> +	vsock->net_mode = vsock_net_mode(net);
> > >>
> > >> I'm sorry for the very late feedback. I think that at very least the
> > >> user-space needs a way to query if the given transport is in local or
> > >> global mode, as AFAICS there is no way to tell that when socket creation
> > >> races with mode change.
> > > 
> > > Are you thinking something along the lines of sockopt?
> > 
> > I'd like to see a way for the user-space to query the socket 'namespace
> > mode'.
> > 
> > sockopt could be an option; a possibly better one could be sock_diag. Or
> > you could do both using dumping the info with a shared helper invoked by
> > both code paths, alike what TCP is doing.
> > >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> > >> may cross netns boundaris and connect to 'local' socket in other netns
> > >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> > >> isolation.
> > > 
> > > Local mode sockets are unable to communicate with local mode (and global
> > > mode too) sockets that are in other namespaces. The key piece of code
> > > for that is vsock_net_check_mode(), where if either modes is local the
> > > namespaces must be the same.
> > 
> > Sorry, I likely misread the large comment in patch 2:
> > 
> > https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> > 
> > >> Have you considered instead a slightly different model, where the
> > >> local/global model is set in stone at netns creation time - alike what
> > >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> > >> inter-netns connectivity is explicitly granted by the admin (I guess
> > >> you will need new transport operations for that)?
> > >>
> > >> /P
> > >>
> > >> [1] tcp allows using per-netns established socket lookup tables - as
> > >> opposed to the default global lookup table (even if match always takes
> > >> in account the netns obviously). The mentioned sysctl specify such
> > >> configuration for the children namespaces, if any.
> > > 
> > > I'll save this discussion if the above doesn't resolve your concerns.
> > I still have some concern WRT the dynamic mode change after netns
> > creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> > see now. A tcp_child_ehash_entries-like model will avoid completely the
> > issue, but I understand it would be a significant change over the
> > current status.
> > 
> > "Luckily" the merge window is on us and we have some time to discuss. Do
> > you have a specific use-case for the ability to change the netns mode
> > after creation?
> > 
> > /P
> 
> I don't think there is a hard requirement that the mode be change-able
> after creation. Though I'd love to avoid such a big change... or at
> least leave unchanged as much of what we've already reviewed as
> possible.
> 
> In the scheme of defining the mode at creation and following the
> tcp_child_ehash_entries-ish model, what I'm imagining is:
> - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
>   number of times
> 
> - when a netns is created, the new netns mode is inherited from
>   child_ns_mode, being assigned using something like:
> 
> 	  net->vsock.ns_mode =
> 		get_net_ns_by_pid(current->pid)->child_ns_mode
> 
> - /proc/sys/net/vsock/ns_mode queries the current mode, returning
>   "local" or "global", returning value of net->vsock.ns_mode
> - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
>   reject writes
> 
> Does that align with what you have in mind?

Hey Paolo, I just wanted to sync up on this one. Does the above align
with what you envision?

Best,
Bobby

