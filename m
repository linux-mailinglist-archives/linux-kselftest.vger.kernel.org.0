Return-Path: <linux-kselftest+bounces-48891-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1331D1B7DF
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 22:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E753037532
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 21:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D13344055;
	Tue, 13 Jan 2026 21:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwC3e0Gr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7B22DC34E
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 21:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768341409; cv=none; b=CgvO3JntPVdx4F5hN4H4iKlpmp3MV+EiMpOgEIeD3ZrdlkkQRTEhmSxjWLk9d6Hw41JVOUGxobqD2AXXQfTnyRYY9+I49itCgiXtLB8I+8DgAErzyN1Mz61wN8v3Ngq46hq+BnuXy+f60iIR1+7Z9ply1AcCWeSLtJdH32xuTnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768341409; c=relaxed/simple;
	bh=h+UznknjOhsgpxn2WvyaKZdy+E01z3xst2FqiSOZMS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=leKGxJn9bm4+4eFE/LyGpP9WOU+5znjjTm/N+6+p+uZvRQIk9l/e7UM5T+m8Yj4hOwmTWsGfY8TB+afGJ0vXedY/AWDgci0lW7Lr0FWLK9jEsbT28iQ0h771CC1RLVBBCVdZui/6D762qTC9z9UzfO7QVOthbrXIUlxhUIWoVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwC3e0Gr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4f1ab2ea5c1so117834831cf.3
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 13:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768341407; x=1768946207; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=YwC3e0GraTiusnRlyQel0BOD9K3rc/ufCalMnHnKkfrwncll5uge/TCKEFex7iJs2C
         MWz35tI3ZusBFOESEpfamHn4rI1d2RUgOmRXmGgypCb1KApJVJPr7EuQ28ngWiuunBXo
         CeHG8rWDLo/rV0kaV/jyYUSHK9SAwq8AT86N+ziSWGK84UPIcwYZzqZwRb9pPZCvWEsM
         ROIm7CDDEUWn/wydMqNV9PsnwKeGoUC1gg8LLO7tVkW/esh/oQP0377XTzbsbtAlTUok
         /Ulbsx7+951QoNaE7w3uMXpAMd4TBhGrGkVn8Pp1vbJasFbqxWmVr4zwr5SpSIjshemT
         meUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768341407; x=1768946207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzIlW73SYpRCgsFT6C0OFykRPA/kKAr4bQkErotYYOY=;
        b=Hdd5P16U7Bfx7JBOmOuUsHx1qydFOWqgz0y48T86ODeJD//g3sBrnvThIYuPUCYPUu
         y1Ua09+YKJHk5Mb7wKSd7ZqSeVCBYvpZa7CVMgDpf2cBnJR3Q0WMxEOGHVmbm2zhPtnx
         p6JWdEJaQbX+08UYbNQZaGZfOJ3DvqylRaGGfAg0OGNJLd7OrLVV9SzGB+0roAMOLnFS
         avNu1VRtH4D3HneXIVATlYRnb8QScUL7B0uULO+CL8fIDupl6fcQFIDGDW2vzilfEgnD
         M/LvTRrPGnzQkOkTGNCrXghVXakxXB3Vbc/8xyHZoOW3KqhPr75MSSgQJV9DpLm6YReR
         ufOw==
X-Forwarded-Encrypted: i=1; AJvYcCVZqqZEtcRJzBhI6tifzF/eZIE+x+EmLfuzGpFxaEfBA9I7pKFWX7ihnaZGeDoivmJH6gHmGpVv1FZZqP9E6R4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3/JN/HXXDR1b6QQOkAwbSiI8AoxAmyBw9eLx5vvtkCmPu8y4V
	T7YtR1MWaB9nQyWCwaRIk7XsaDVJSbDHu7A+qSl7dbIktZ0ma1/OU7PjNZcz3Q==
X-Gm-Gg: AY/fxX6Q6S6n1KBw4XDsAkp2xr1W07wNHzJhGiMG4sMEDNVLM3CCEp6AWItPrea+xCg
	iz1kYHRB1oVXRNEZHmgZfZtwJdBT/3pwv7mBx477fql5jsylQLE9pQ3u/QtKcI6JbIxbBj44fan
	UUFdPFZ/Xjr3neZIIUVI4KVOSYLibxLJKFHptV72mKL6xXPrgi+TrY671SAqMpEirR2uY+3jZhy
	NuZp9LBge6M63/EO5HX0jXeCkmdNvZrP8+W5WpNys1b9WiUBPNdnsZL7PNwu4+pildnW9wMVNyR
	IwHvdTWPoxayX6wpgBoICwr8c5aHSxd2/QLAOl/AnPOkQVdpDH2kk0vBkvoCBPuZWw1bZ72SwsK
	mEwFnV/dfOzrEKQBEpfptnBC3DYcp35I3UYAeLBcL04FejsTVuDWtZmr5sIx6fognUcczW53cXY
	D5hliB7tF/FWl35cJebT1tzbixtaAaOQVl08Q=
X-Received: by 2002:a05:690c:c85:b0:78f:f3e2:35e0 with SMTP id 00721157ae682-793a1d4bad1mr1649307b3.42.1768336120080;
        Tue, 13 Jan 2026 12:28:40 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm77661627b3.47.2026.01.13.12.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 12:28:39 -0800 (PST)
Date: Tue, 13 Jan 2026 12:28:38 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, kvm@vger.kernel.org,
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org,
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 01/12] vsock: add netns to vsock core
Message-ID: <aWaq9vbBJGqg9+DU@devvm11784.nha0.facebook.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-1-a5c332db3e2b@meta.com>
 <20260113024503-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113024503-mutt-send-email-mst@kernel.org>

On Tue, Jan 13, 2026 at 02:45:32AM -0500, Michael S. Tsirkin wrote:
> On Mon, Jan 12, 2026 at 07:11:10PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add netns logic to vsock core. Additionally, modify transport hook
> > prototypes to be used by later transport-specific patches (e.g.,
> > *_seqpacket_allow()).
> > 
> > Namespaces are supported primarily by changing socket lookup functions
> > (e.g., vsock_find_connected_socket()) to take into account the socket
> > namespace and the namespace mode before considering a candidate socket a
> > "match".
> > 
> > This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
> > report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
> > for new namespaces.
> > 
> > Add netns functionality (initialization, passing to transports, procfs,
> > etc...) to the af_vsock socket layer. Later patches that add netns
> > support to transports depend on this patch.
> > 
> > dgram_allow(), stream_allow(), and seqpacket_allow() callbacks are
> > modified to take a vsk in order to perform logic on namespace modes. In
> > future patches, the net will also be used for socket
> > lookups in these functions.
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v14:
> > - include linux/sysctl.h in af_vsock.c
> > - squash patch 'vsock: add per-net vsock NS mode state' into this patch
> >   (prior version can be found here):
> >   https://lore.kernel.org/all/20251223-vsock-vmtest-v13-1-9d6db8e7c80b@meta.com/)
> 
> So, about the static port, are you going to address it in
> the next version then?

Yes, just wanted to get the rebase out to unblock review of the
child_ns_mode changes.

I should have mentioned the static port was a known issue and still
under discussion.

- Bobby

