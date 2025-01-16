Return-Path: <linux-kselftest+bounces-24634-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC88A13512
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 09:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F1887A1FD9
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 Jan 2025 08:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5AB1CEEBB;
	Thu, 16 Jan 2025 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fTRgc7kE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815C2198A38
	for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015269; cv=none; b=fv6KeEY37rgl4eVLW5HLye2dvC3nFlTjnbixB5Ufcpoixz63FMDkobF1nPXTQFDXUTYphjz3lWRtOuAYaFaRbUN9n/l/y0nA/1N/ovvW4t28cmlaxWK6HR13K1FLEPX+4x2n+2EQp7MhnwdRCIRKKxzFqg+oIwKhpdAUb8K9mCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015269; c=relaxed/simple;
	bh=fort1JpzFCk9aJtnmJGBE2dcNxsiha4izVe2Fx5p3d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KnUugfJhEBEEwMP7LmKniv5Htx9JSG+lvn8I/X8fQJOYrg6cU1AAl3awhqWDKp0Ru6hH7n0ahUPVhrI+27SBCU5Pv4jbnNqouJl86AFtJd8FZ0VPqOmovctjgrJfNyaxWtwIDyH3HD1Gzjjd2AexkGoTxetJ808og1sRt8XEhM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fTRgc7kE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737015266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
	b=fTRgc7kE8hh4l7jRuyDI5GItj6qh5RMHvzOX+QXmPgNF98xK0daWm6wjHWrgPH3FuqW7Q/
	N9j8NJ9fEVzuPTjcpKNCe2c/1Oa2CA5umSGwRTcctsDSR6SfenPb1oyQsi/s65tlk5BeBr
	g24vsliaYeVF5OYMqlwW688Ow1pFYz8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-WKCsH0sYMLav-bejWJKO1A-1; Thu, 16 Jan 2025 03:14:24 -0500
X-MC-Unique: WKCsH0sYMLav-bejWJKO1A-1
X-Mimecast-MFC-AGG-ID: WKCsH0sYMLav-bejWJKO1A
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385ded5e92aso265190f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Jan 2025 00:14:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737015264; x=1737620064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERbJSuqsAOXaaj6eB/CkwpIU16l9eEjJ8jUx0oPfO3Y=;
        b=hGM1Y5cQceD0Oc25AT5RdgUp2bH1sH4eI1pfvw01En9No8oRzH+J9OBKXvrmb2LJ53
         WfA+2fleZrIJ6Yg2Ax5TK0WuXzbfIL2ZCspreS4nyUDbk0Falv8gUpqE0JnCNYqFzdIn
         Zwkn4mbK0phkpr4oqFdNqoiUUhFMKR498w+TOBhpNAaP8pko5cupVkBOBQKbBHCprlz6
         5YFOSIIkje5ShJrGx1Py73s/cpTpXUKK7rGq/JNKKTBr3obU56Lw+KpqM1jSc3Y8/V7K
         h4t4PX3Nv+kbkhJ/oknnz/jeK92df2Ks8PfwMqLFeqLt0WFFnmuK2SZzKNwONd8L+7NZ
         E8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWbeC7if+/4LadT3S1GRqJ1ybjOOrt5gonVP1Gpf0+rJMh2gV7hJR2/kX9hmhbS6WRx+C2xR/VOCvWsGizOEDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxALEMlhqI4uZ/Hs2mSaml6edfgx72RsI/TknkIwjwciBrHiyCq
	rJqd7lLBwcDkVZ3b9B0J0ShVir3n95v0cjB2F9rsWnSaNvLwdMhaldyUSOP5rQNe4ItlF1fSI+s
	hSW/OBZOamQKYT9ePMVD3lGFgvMMjsqw4NdIGj6bsDK7KAGkcflk2FLsr9avOQbyxGw==
X-Gm-Gg: ASbGncuYNJNRP5Wp9jCF2m/gLMsfuAZyySTGsfPryRg9IcydrYpS/TcZ9iPGhyh+Kc4
	imOpI8C7AIO79u4qVCGPSRWZ7EWtFohkaAxMnTHSdDxQ7EhBOPFhkdxaX6A3+B7tNujHVmytWIG
	UwPZ/lUtTd+F3ypUDjfkz8DtBLPmuyrnmQdSIdpNbZLSyA9z64Xu2sjEBmo4JDTBIFKXtwAP6No
	WwMIDPm6sA3HAoF5d4F9JzpUt584KhC7gLfAnKtNucaLHK8nnJC
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7142028f8f.39.1737015263723;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVuBvar1zeSUO961UzYaw/R6lkjncjPewk3IhqyjOPRMXTTO5yWHL+JU+PeFfMlECdyG2zMA==
X-Received: by 2002:a05:6000:2ad:b0:385:f5c4:b30d with SMTP id ffacd0b85a97d-38a8730dd17mr7141999f8f.39.1737015263364;
        Thu, 16 Jan 2025 00:14:23 -0800 (PST)
Received: from redhat.com ([2a0d:6fc7:342:db8c:4ec4:322b:a6a8:f411])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d0bdsm19629001f8f.3.2025.01.16.00.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 00:14:22 -0800 (PST)
Date: Thu, 16 Jan 2025 03:14:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
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
Subject: Re: [PATCH net v3 0/9] tun: Unify vnet implementation
Message-ID: <20250116031331-mutt-send-email-mst@kernel.org>
References: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116-tun-v3-0-c6b2871e97f7@daynix.com>

On Thu, Jan 16, 2025 at 05:08:03PM +0900, Akihiko Odaki wrote:
> When I implemented virtio's hash-related features to tun/tap [1],
> I found tun/tap does not fill the entire region reserved for the virtio
> header, leaving some uninitialized hole in the middle of the buffer
> after read()/recvmesg().
> 
> This series fills the uninitialized hole. More concretely, the
> num_buffers field will be initialized with 1, and the other fields will
> be inialized with 0. Setting the num_buffers field to 1 is mandated by
> virtio 1.0 [2].
> 
> The change to virtio header is preceded by another change that refactors
> tun and tap to unify their virtio-related code.
> 
> [1]: https://lore.kernel.org/r/20241008-rss-v5-0-f3cf68df005d@daynix.com
> [2]: https://lore.kernel.org/r/20241227084256-mutt-send-email-mst@kernel.org/
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Will review. But this does not look like net material to me.
Not really a bugfix. More like net-next.

> ---
> Changes in v3:
> - Dropped changes to fill the vnet header.
> - Splitted patch "tun: Unify vnet implementation".
> - Reverted spurious changes in patch "tun: Unify vnet implementation".
> - Merged tun_vnet.c into TAP.
> - Link to v2: https://lore.kernel.org/r/20250109-tun-v2-0-388d7d5a287a@daynix.com
> 
> Changes in v2:
> - Fixed num_buffers endian.
> - Link to v1: https://lore.kernel.org/r/20250108-tun-v1-0-67d784b34374@daynix.com
> 
> ---
> Akihiko Odaki (9):
>       tun: Refactor CONFIG_TUN_VNET_CROSS_LE
>       tun: Avoid double-tracking iov_iter length changes
>       tun: Keep hdr_len in tun_get_user()
>       tun: Decouple vnet from tun_struct
>       tun: Decouple vnet handling
>       tun: Extract the vnet handling code
>       tap: Avoid double-tracking iov_iter length changes
>       tap: Keep hdr_len in tap_get_user()
>       tap: Use tun's vnet-related code
> 
>  MAINTAINERS            |   2 +-
>  drivers/net/Kconfig    |   1 +
>  drivers/net/Makefile   |   3 +-
>  drivers/net/tap.c      | 172 ++++++------------------------------------
>  drivers/net/tun.c      | 200 +++++++------------------------------------------
>  drivers/net/tun_vnet.c | 180 ++++++++++++++++++++++++++++++++++++++++++++
>  drivers/net/tun_vnet.h |  25 +++++++
>  7 files changed, 260 insertions(+), 323 deletions(-)
> ---
> base-commit: a32e14f8aef69b42826cf0998b068a43d486a9e9
> change-id: 20241230-tun-66e10a49b0c7
> 
> Best regards,
> -- 
> Akihiko Odaki <akihiko.odaki@daynix.com>


