Return-Path: <linux-kselftest+bounces-24190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58430A08A40
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 09:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A213A924B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 08:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BC7207E16;
	Fri, 10 Jan 2025 08:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ftEv9mTY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9FC207DFD
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 08:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498021; cv=none; b=h3IgipgtuZBEXge+FhmAtYczqvlM8MDx8qz+9y0Z2Qard9FZi4TE4QTH+ASxSBSBAB+Fvm/ERADWPSmXPU7Cm9PWjlSnVnjPl5PBKpJsLOSfePzLWgfwVXSwVDTTnFTwy0nTagqmTeIiv5W052lE9sBPLcq/mRQsdqLkEKBjX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498021; c=relaxed/simple;
	bh=jHWzqnciWVxWixyPQhRuC+28OpV2V/bBQGrWzPx3hbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u3Cw+UwzKLeZNmRO82qR394TvOgeBWqennfYFcGbj49sHWI2HYUkIqxogAV0IV2uZwhgYVu9NAoFWOhUewXrucMSY2FOy+LYGcdYLrWQ/93pldvqEgTJEE4LmxPfOjx0evcGAvU/3KRHx6Zw9ZJdnOsCPbNwHaex+ps5NmDcZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ftEv9mTY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736498018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v3AxsQKFkY0E+0MZ060gdGU5E31S3yG/jY+mnuNkfgk=;
	b=ftEv9mTYws7LJlI9kXr3WgbR/ZoLzAJhKF4SxzUUXANmsfrmAAa6uCPAatbgLgW8N1YZDB
	xGKpSvFKCvXvwHiophkL8IAyCRe4wtzSzmQ4rWeGUGsEC1uGvAsg6e9ZpZci48vtuhazJT
	7JnD3i7fTJ1cgmJ9+rx1UH8VXWXUXwI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-JL8J6XwKODyWAFfFKbYKFA-1; Fri, 10 Jan 2025 03:33:37 -0500
X-MC-Unique: JL8J6XwKODyWAFfFKbYKFA-1
X-Mimecast-MFC-AGG-ID: JL8J6XwKODyWAFfFKbYKFA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862e986d17so725856f8f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 00:33:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736498016; x=1737102816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v3AxsQKFkY0E+0MZ060gdGU5E31S3yG/jY+mnuNkfgk=;
        b=wOgHvZEbwvqiu9ySThRnoK4nmAQfTnSb7AQMwoFRwfAkirLs919+FbCcp9Hkogl7zQ
         Bk4e1biGzCdx8gS05UO2GCEz6aH70yK1Cn0/Ru1BDaDkImDC/RPTGXe5u1RX2KAstkld
         Vtv334uPPP1ak9OniRm7lHufNNia1oU3vLRTvF1xw3B9qdmncRmbLheDZACJslvAubYZ
         xXqb5FT9RGS0jueGjygRDG1uFl+sm6XURM8Bxhi8GvVlvKt4VQj4ooMQ18eVDXiyW1QO
         SY5FWN+TdFU6+IFiOKsn6jgR+iCrDTE/b7GIWpR92QxV70+MxcrJ2bx5SPYwvrNwqJg9
         SwxA==
X-Forwarded-Encrypted: i=1; AJvYcCVF6BThIQo1RxfbQy1ZzFdagpIFjUTmBATwx0410lzjFAQJTljchFyDSdLjDXDc+kw0FoGCkLVPnY9OCpfmPDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOhvX0ngF280RwrJktCrJS/Es0OU2W2WFYy7bUPKP9Dv24yihK
	9WMrDitAS3EMuP2MEkdG7dhL7kOwbN9EMSopuCp1MX8zFBfCYesOeIbl96ISrqaC24nkCe4zatN
	de6qYNdVS8I+SxQsnx/l5Gb6qW2mO64QP2c3gufr+ktlxDHvthbMAd9C5EyvUCje/Wg==
X-Gm-Gg: ASbGncsBikhs1xcXgeNSJvd5/KGl3rrLse2/UZi+t/T5zImOvLrQC7AWPFNvKUoqOil
	+pIjbQGUPKXb4SLYMqlg+3nrFvI2tnh2Mh0Ho3tvTKD6N+8v0fde12HNLpYyVLtcFfM/ihWKvNp
	NloD72RsBx28rdtCslZ6PLLb24E3CacJZfNZR+THr9MTBvRsYivkm7xq/BqvnkFvH47Mn55BauM
	3YGfCxln5UJ0EFyX//mUacy4MKByEW19f+Zxc7zhuBHnn3l3Uxl
X-Received: by 2002:a05:6000:704:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a8730af1emr7361850f8f.28.1736498016257;
        Fri, 10 Jan 2025 00:33:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHDkmvAzVbQy4Z1oN4ubuGOtq8JEjPwlHX/LMcj/lU9WejRkYESinAg0MOkridrYlqI4G3XFw==
X-Received: by 2002:a05:6000:704:b0:386:3272:ee68 with SMTP id ffacd0b85a97d-38a8730af1emr7361814f8f.28.1736498015919;
        Fri, 10 Jan 2025 00:33:35 -0800 (PST)
Received: from redhat.com ([2a06:c701:740d:3500:7f3a:4e66:9c0d:1416])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b82ddsm3883422f8f.71.2025.01.10.00.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 00:33:35 -0800 (PST)
Date: Fri, 10 Jan 2025 03:33:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH v2 2/3] tun: Pad virtio header with zero
Message-ID: <20250110033306-mutt-send-email-mst@kernel.org>
References: <20250109-tun-v2-0-388d7d5a287a@daynix.com>
 <20250109-tun-v2-2-388d7d5a287a@daynix.com>
 <20250109023056-mutt-send-email-mst@kernel.org>
 <571a2d61-5fbe-4e49-b4d1-6bf0c7604a57@daynix.com>
 <677fc517b7b6e_362bc12945@willemb.c.googlers.com.notmuch>
 <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e193a94-8f5a-4a2a-b4c4-3206c21c0b63@daynix.com>

On Fri, Jan 10, 2025 at 01:38:06PM +0900, Akihiko Odaki wrote:
> On 2025/01/09 21:46, Willem de Bruijn wrote:
> > Akihiko Odaki wrote:
> > > On 2025/01/09 16:31, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 09, 2025 at 03:58:44PM +0900, Akihiko Odaki wrote:
> > > > > tun used to simply advance iov_iter when it needs to pad virtio header,
> > > > > which leaves the garbage in the buffer as is. This is especially
> > > > > problematic when tun starts to allow enabling the hash reporting
> > > > > feature; even if the feature is enabled, the packet may lack a hash
> > > > > value and may contain a hole in the virtio header because the packet
> > > > > arrived before the feature gets enabled or does not contain the
> > > > > header fields to be hashed. If the hole is not filled with zero, it is
> > > > > impossible to tell if the packet lacks a hash value.
> > 
> > Zero is a valid hash value, so cannot be used as an indication that
> > hashing is inactive.
> 
> Zeroing will initialize the hash_report field to
> VIRTIO_NET_HASH_REPORT_NONE, which tells it does not have a hash value.
> 
> > 
> > > > > In theory, a user of tun can fill the buffer with zero before calling
> > > > > read() to avoid such a problem, but leaving the garbage in the buffer is
> > > > > awkward anyway so fill the buffer in tun.
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > 
> > > > But if the user did it, you have just overwritten his value,
> > > > did you not?
> > > 
> > > Yes. but that means the user expects some part of buffer is not filled
> > > after read() or recvmsg(). I'm a bit worried that not filling the buffer
> > > may break assumptions others (especially the filesystem and socket
> > > infrastructures in the kernel) may have.
> > 
> > If this is user memory that is ignored by the kernel, just reflected
> > back, then there is no need in general to zero it. There are many such
> > instances, also in msg_control.
> 
> More specifically, is there any instance of recvmsg() implementation which
> returns N and does not fill the complete N bytes of msg_iter?

The one in tun. It was a silly idea but it has been here for years now.


> > 
> > If not zeroing leads to ambiguity with the new feature, that would be
> > a reason to add it -- it is always safe to do so.
> > > If we are really confident that it will not cause problems, this
> > > behavior can be opt-in based on a flag or we can just write some
> > > documentation warning userspace programmers to initialize the buffer.


