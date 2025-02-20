Return-Path: <linux-kselftest+bounces-27049-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 118E6A3D38A
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 09:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57EEF17C61E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 08:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999A21EBA0B;
	Thu, 20 Feb 2025 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDKSYMxr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E881B4247
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 08:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041122; cv=none; b=b6cikfXLR7KImlq24+dnNU2ibotvQ0UPilYOpIUsn7+VTEV7+DgOFZZt6kWmSrB5J5FBxHfGoJ7DJYq6m69DPzVIi5TW6vIw8JJq4heeDV8zFpFt+4pLXe2pTPt1Tm2vovtmNdl8/R0YPH3bzv273YRRfgiCz08Pafnxe8JWTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041122; c=relaxed/simple;
	bh=0SHhfqD/vA4cGXP3SZz7IhYLrGj9qnR4GeFeMVjfvsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR4wZpA62qajJNRVyzYFdFAznx2RL2GO9i+8NgHHnckdkLkK6662d7oDDgrowUs7f/qMlfWmCf/RhYxSwjOjIAEeuRU30jgSTllqywn1m6dYEvN96zG4U4Rq44qFGbFBkxx3AlzL3mb1oF/ASiaZEh5O9p+9aT8shwsiE/KTbz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HDKSYMxr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740041119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QowQNzpCtCsCtxr+X2Hdu42nsXJZ78IqGs75xqGcCm4=;
	b=HDKSYMxrL8zXxl/Ph5nORd77ppKkIQX5WuXnf7idofE1RO7wFTKfRWyK/1qiMNu0M/auzj
	R2SX5X9PMHqYakbhVf2C8AgL3rYTqZfxaEERvQCxgJmyPjsXrsjmjCeTJW2IExefwQYHZi
	L9eEJNrdn+NpxAVhWkWmfqKLNuBNPNA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-2FTAbtOMPyWMziNWFjks2g-1; Thu, 20 Feb 2025 03:45:17 -0500
X-MC-Unique: 2FTAbtOMPyWMziNWFjks2g-1
X-Mimecast-MFC-AGG-ID: 2FTAbtOMPyWMziNWFjks2g_1740041117
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abb8e0944bfso84096266b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 00:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041117; x=1740645917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QowQNzpCtCsCtxr+X2Hdu42nsXJZ78IqGs75xqGcCm4=;
        b=o+JkTxGRfa6F8pNKJwdXsZH7fMHOIwOJBBemz95JU+nM7eDN1JDNnRiA7bA3dBZR1Q
         UW8iCOextGzglz7IoPNPCfgqowsrchArwAb2IDhFTSnDetCcU8oJATBKMbOcjCobKUfd
         P+KhtPh7Xe+1F2r1TU9DmUr4/n5eu6Yugewyb74E7XovoWE9a3DtPyI/nps13zVCWwB4
         G8YEkHPug5cc3/wU2gWRDR7HPHXdGatP/4Gt3m6Q3GFmDZABUc9TgZCBV39eJNma/E3S
         NzGynwic6h2quG/lUkjATkmSPnW+BHR7648xTPvtwnFU/T1roa7PORuyGtYy6j+Z5xVM
         oQeA==
X-Forwarded-Encrypted: i=1; AJvYcCVdWcPy9Riv2/R8gj159BN1Z4V+HJTWPiJSU3DEITU9Lqc1PvXnt7Sy6amQWAcjbyI6gA8l2+dENJk6PFLYU9c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8PzfzlOBe0FF+y8a9qLBWlNfGOZfu771F9vTzCIZ0pmqAUsq
	xhUWT2ccvPnagZvfQKmJa7TAlTA8KiYGj0N5Yw/TjAiVIcN08Nkxrz4Ec/FiZ6yWeEi5XoNoUpT
	tYEn8ixmK6/AgvWXVcFAACsIIZt9jjqFs6eQ4A0ap2lvYkhb6lC3J54to8SICtaKRTw==
X-Gm-Gg: ASbGncvMp1YDIlP6LPabXezHkdNfjnIIfJUsLQDQQG920/opOYFEtyocdPv/2dzc3/R
	A6yO7jLDJln/YFk2329omXIGxLv/EJdZSXVTJq+jrHTIDJl58zpFQBeeY+U7E4KT5m1OKUWhnm3
	4+cX4my9+dxkrBOxDlXsW/gZiFTrU8qg5+rm0bNyzL+A8q7mn5SCqlP7l0JryO2v7jIS/nw5dAZ
	wegGPpVljkQlfrGTRWAg12rurj/nNQyupbAez8JG5QhmJLVMGhBe9RAyP0fYNqexaoXig==
X-Received: by 2002:a17:906:f5a2:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abbcce2dce7mr658330266b.30.1740041116679;
        Thu, 20 Feb 2025 00:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3dogKAU3XJfB97xx6QDkV7Yj2gPqLTO6qgUQYyB3pQmxLIK3jEJkScPsnctuvKKAeoojJDg==
X-Received: by 2002:a17:906:f5a2:b0:ab7:e3cb:ca81 with SMTP id a640c23a62f3a-abbcce2dce7mr658325866b.30.1740041116195;
        Thu, 20 Feb 2025 00:45:16 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb9bc1c667sm731938266b.131.2025.02.20.00.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:45:15 -0800 (PST)
Date: Thu, 20 Feb 2025 03:45:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
	linux-kselftest@vger.kernel.org,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Andrew Melnychenko <andrew@daynix.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	gur.stavi@huawei.com, devel@daynix.com
Subject: Re: [PATCH net-next v2] tun: Pad virtio headers
Message-ID: <20250220034042-mutt-send-email-mst@kernel.org>
References: <20250215-buffers-v2-1-1fbc6aaf8ad6@daynix.com>
 <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4b7f8a0-db50-4b48-b5a3-f60eab76e96b@redhat.com>

On Thu, Feb 20, 2025 at 08:58:38AM +0100, Paolo Abeni wrote:
> Hi,
> 
> On 2/15/25 7:04 AM, Akihiko Odaki wrote:
> > tun simply advances iov_iter when it needs to pad virtio header,
> > which leaves the garbage in the buffer as is. This will become
> > especially problematic when tun starts to allow enabling the hash
> > reporting feature; even if the feature is enabled, the packet may lack a
> > hash value and may contain a hole in the virtio header because the
> > packet arrived before the feature gets enabled or does not contain the
> > header fields to be hashed. If the hole is not filled with zero, it is
> > impossible to tell if the packet lacks a hash value.
> 
> Should virtio starting sending packets only after feature negotiation?
> In other words, can the above happen without another bug somewhere else?


Not if this is connected with a guest with the standard virtio driver, no.
The issue is that tun has no concept of feature negotiation,
and we don't know who uses the vnet header feature, or why.

> I guess the following question is mostly for Jason and Michael: could be
> possible (/would it make any sense) to use a virtio_net_hdr `flags` bit
> to explicitly signal the hash fields presence? i.e. making the actual
> virtio_net_hdr size 'dynamic'.

But it is dynamic - that is why we have TUNSETVNETHDRSZ.



> > In theory, a user of tun can fill the buffer with zero before calling
> > read() to avoid such a problem, but leaving the garbage in the buffer is
> > awkward anyway so replace advancing the iterator with writing zeros.
> > 
> > A user might have initialized the buffer to some non-zero value,
> > expecting tun to skip writing it. As this was never a documented
> > feature, this seems unlikely.
> > 
> > The overhead of filling the hole in the header is negligible when the
> > header size is specified according to the specification as doing so will
> > not make another cache line dirty under a reasonable assumption. Below
> > is a proof of this statement:
> > 
> > The first 10 bytes of the header is always written and tun also writes
> > the packet itself immediately after the 
> > packet unless the packet is
> 
>  ^^^^^ this possibly should be 'virtio header'. Otherwise the sentence
> is hard to follow for me.
> 
> > empty. This makes a hole between these writes whose size is: sz - 10
> > where sz is the specified header size.
> > 
> > Therefore, we will never make another cache line dirty when:
> > sz < L1_CACHE_BYTES + 10
> > where L1_CACHE_BYTES is the cache line size. Assuming
> > L1_CACHE_BYTES >= 16, this inequation holds when: sz < 26.
> > 
> > sz <= 20 according to the current specification so we even have a
> > margin of 5 bytes in case that the header size grows in a future version
> > of the specification.
> 
> FTR, the upcoming GSO over UDP tunnel support will add other 4 bytes to
> the header. but that will still fit the given boundary.
> 
> /P


