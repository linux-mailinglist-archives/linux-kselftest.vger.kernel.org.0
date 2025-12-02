Return-Path: <linux-kselftest+bounces-46919-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941CC9D21D
	for <lists+linux-kselftest@lfdr.de>; Tue, 02 Dec 2025 23:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B8C03499B7
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Dec 2025 22:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA672FAC17;
	Tue,  2 Dec 2025 22:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZdwtHGo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF552E8B9C
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Dec 2025 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764712870; cv=none; b=fk7JOTNnLkdX1X6sYzcoeqPiYVdLr+DcOM63ZfFchQsN8Rxkoz06GgGTPEgot2zhm/7MrjsAJbaRRqJDGIRfvdUE0q0BudGqvIe0nzI0gr1lvKtwHkVgiUYxPifdIAruscZEfJFSv/g6mK0YsJNwA4wG+WBx5Y/Lj3A4pdnpC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764712870; c=relaxed/simple;
	bh=Mqnyzq/dHBpiYdG/Xt/TKvJXJMP8zWCEKc3fUG6Hw0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN6R0q2Swx819ddCqFixNwJwHLsTl9wi8lpPydX+saZAFgAd4Ryz9u5RAqOgI6LP7GhZpmUR4vsGVEKF3AhFVeeu4ogJ68aH8rttZd85YMIgIlbgvIB6fEyFC8cYe1XFUq+/ipn+RjChjgavZ2r691LmEvwqVJ+vwN5AiFIQFKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZdwtHGo; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6420c08f886so7699068d50.3
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Dec 2025 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764712867; x=1765317667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNqIfgM/6Ycxql9GvTaW4xpHm2HTdtIqMIBvJdvraLU=;
        b=OZdwtHGonB3nfffkr6VAZVqTIoL0VKHhfYC1cJqS0rCeHHRluRmORfZVjQF/E0Bl8B
         juTo9aHbJQD6Z6xYYDtXvIrZ1KnlWq+hwurM/QVZXIwILYNpOJ+RnjyUQPZ9pKT2VG8j
         q3i1E6ktebX+xrSHYTvMS8kiIXOjRBmOfrAsVoyRy4Uoz/Gcf+HV4+pv5WGZb7w/rIZh
         Z7WhLAzWkGHmsY+zruBZ3j23y8vxHGrsKrz5C9z5I5sjtlWzZRXIDXqUKsurQftDMKMo
         wRufIxC/i/+ldxbYSsAv9iyUCNXvLjDXXN12gqkqHSnnA6tbI8z6kFBr8ctD5V7bleYF
         BUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764712867; x=1765317667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNqIfgM/6Ycxql9GvTaW4xpHm2HTdtIqMIBvJdvraLU=;
        b=RMK24tt2TVAaNrUFx3ehM8CN9pQORbneynCCT0C20LlSBXSiLrn++fD6we8k4Tg77y
         8oPxGI//cx6iQB1fbhMv72729MbfwFtz8v8RY/7+e+Qw/EJWwH3GCvXgblE9oMr1qhCp
         tKWPJR45DSzRR3SAJITytbHERGgnGRPbyCM21o5sR9tvGHvgjPAmqgk4GzR0qZp1Tj3K
         Am5udkSEj2NBrxqKlHycfGkva6IKiE8O6AO1U/N5cWbwL/6YdJodENGgUsWGwC3wmYuV
         axT4HeE+EisXOvDBVG0HGQ12e1RxXgG2YdWBowaOUuwXwPJp7TCEvnUwI+bFiTr523Ml
         Ohkg==
X-Forwarded-Encrypted: i=1; AJvYcCVIZNl92cJDzKBV8XygQpleFj9b54mjwi6kZaielDv4QXK8DU8PzEXT+vx7G5Cy1CY6Dos7LF/J7501AgAQRuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfrfazRvGkqx6uWImXABG3Ogb4cWERlXLm4sJRZFmLDEJ/lJuk
	2VXXU+6nSbizbpeOHx1gP8ws1N55csm+Fphk8Ppr6iXP49yrkrd5BRfK
X-Gm-Gg: ASbGncuUGi9mF6vIAQH0YBUfTugOQDRYYvpSYvxroBC6ctN1PNusEhVdPh6Asrw7BDG
	l1Z+7hBMN+LbiltB49Zw9sACWAF6DfZVQZ1nxjusDSV/bSGy6CDHQwzW3pkn2Og41zU9Zk06ZtC
	1hxQBcOfFW3cZFk9MoEej5Tt0BvK+r+nTwY0km9Ihe3esU5Q/zRkOOg32Duq9B0J/ZdvgjQw8Ul
	Px31tSkQG0PuFUQ2f2/wPSVr6Cgei2BOW/9Zs9lWCump1ypWgCgOIOonGJAZuc9gRYABK+OhPVL
	s4APTngJ9C0+krW+urkAEECv+8G4Fnh0GUikqHJ+QpuhEIwJ1XqZKBp4KWBIQeGQmRh9s+UAcGV
	vWPxeg52uRfpa7Hqjdee0gqNPvuWDhWNneRkVVc3ScN9NE8RagldlYGQthgd4YMZIltXMmHQI01
	+8RUffN0kbImrZPLr35AmEaEMdwKmMAMrwF+ORDeiRNsqP0pQ=
X-Google-Smtp-Source: AGHT+IFKkR9nJxuAswYbUkRmscuBgN9zjQIp6HaO2rufMd5Ab/1ylKT04Hn5ts4J77BDYWjQzLjRWg==
X-Received: by 2002:a05:690c:6206:b0:788:e74:b281 with SMTP id 00721157ae682-78c0beafabamr1238977b3.13.1764712866608;
        Tue, 02 Dec 2025 14:01:06 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0d3f5a1sm67446487b3.12.2025.12.02.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 14:01:06 -0800 (PST)
Date: Tue, 2 Dec 2025 14:01:04 -0800
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
Message-ID: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>

On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
> On 12/2/25 6:56 PM, Bobby Eshleman wrote:
> > On Tue, Dec 02, 2025 at 11:18:14AM +0100, Paolo Abeni wrote:
> >> On 11/27/25 8:47 AM, Bobby Eshleman wrote:
> >>> @@ -674,6 +689,17 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
> >>>  		goto out;
> >>>  	}
> >>>  
> >>> +	net = current->nsproxy->net_ns;
> >>> +	vsock->net = get_net_track(net, &vsock->ns_tracker, GFP_KERNEL);
> >>> +
> >>> +	/* Store the mode of the namespace at the time of creation. If this
> >>> +	 * namespace later changes from "global" to "local", we want this vsock
> >>> +	 * to continue operating normally and not suddenly break. For that
> >>> +	 * reason, we save the mode here and later use it when performing
> >>> +	 * socket lookups with vsock_net_check_mode() (see vhost_vsock_get()).
> >>> +	 */
> >>> +	vsock->net_mode = vsock_net_mode(net);
> >>
> >> I'm sorry for the very late feedback. I think that at very least the
> >> user-space needs a way to query if the given transport is in local or
> >> global mode, as AFAICS there is no way to tell that when socket creation
> >> races with mode change.
> > 
> > Are you thinking something along the lines of sockopt?
> 
> I'd like to see a way for the user-space to query the socket 'namespace
> mode'.
> 
> sockopt could be an option; a possibly better one could be sock_diag. Or
> you could do both using dumping the info with a shared helper invoked by
> both code paths, alike what TCP is doing.
> >> Also I'm a bit uneasy with the model implemented here, as 'local' socket
> >> may cross netns boundaris and connect to 'local' socket in other netns
> >> (if I read correctly patch 2/12). That in turns AFAICS break the netns
> >> isolation.
> > 
> > Local mode sockets are unable to communicate with local mode (and global
> > mode too) sockets that are in other namespaces. The key piece of code
> > for that is vsock_net_check_mode(), where if either modes is local the
> > namespaces must be the same.
> 
> Sorry, I likely misread the large comment in patch 2:
> 
> https://lore.kernel.org/netdev/20251126-vsock-vmtest-v12-2-257ee21cd5de@meta.com/
> 
> >> Have you considered instead a slightly different model, where the
> >> local/global model is set in stone at netns creation time - alike what
> >> /proc/sys/net/ipv4/tcp_child_ehash_entries is doing[1] - and
> >> inter-netns connectivity is explicitly granted by the admin (I guess
> >> you will need new transport operations for that)?
> >>
> >> /P
> >>
> >> [1] tcp allows using per-netns established socket lookup tables - as
> >> opposed to the default global lookup table (even if match always takes
> >> in account the netns obviously). The mentioned sysctl specify such
> >> configuration for the children namespaces, if any.
> > 
> > I'll save this discussion if the above doesn't resolve your concerns.
> I still have some concern WRT the dynamic mode change after netns
> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
> see now. A tcp_child_ehash_entries-like model will avoid completely the
> issue, but I understand it would be a significant change over the
> current status.
> 
> "Luckily" the merge window is on us and we have some time to discuss. Do
> you have a specific use-case for the ability to change the netns mode
> after creation?
> 
> /P

I don't think there is a hard requirement that the mode be change-able
after creation. Though I'd love to avoid such a big change... or at
least leave unchanged as much of what we've already reviewed as
possible.

In the scheme of defining the mode at creation and following the
tcp_child_ehash_entries-ish model, what I'm imagining is:
- /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
- /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
  number of times

- when a netns is created, the new netns mode is inherited from
  child_ns_mode, being assigned using something like:

	  net->vsock.ns_mode =
		get_net_ns_by_pid(current->pid)->child_ns_mode

- /proc/sys/net/vsock/ns_mode queries the current mode, returning
  "local" or "global", returning value of net->vsock.ns_mode
- /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
  reject writes

Does that align with what you have in mind?

Stefano, what are your thoughts?

Best,
Bobby

