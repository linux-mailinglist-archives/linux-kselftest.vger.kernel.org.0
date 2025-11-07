Return-Path: <linux-kselftest+bounces-45046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 32075C3E122
	for <lists+linux-kselftest@lfdr.de>; Fri, 07 Nov 2025 02:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 250AC4EA9FB
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Nov 2025 01:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6EB2F12DF;
	Fri,  7 Nov 2025 01:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UahQDDQx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99F2EFD80
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Nov 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477251; cv=none; b=BBYqXsYR2KBOCjVZOFN+j+HdVOn0E2Oy/3XYVW+f0o+dP/Bkm47JfRQuQIo/p8LYmaUYWUpwoPf3DEPx/D0JlcLVWt1M02ltlfIeY0ixL5Yi8DNfuhByQUmWOVc+7wGOLhpb8J3IozNeImE0bakKgVEmkw5xx7SlsAknuZoM7i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477251; c=relaxed/simple;
	bh=NZ4x6TEl3CJtkTGi+wP+m0cvmfYI0RmaIhfXqjufJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5d3WUa4EZMN3m6UHyGL3cSAwUf00ow2qMhrVDNzbLHO9kQ2d0S2k16cQWWCf5jrHgYnp7jZ6bXKSSr+A1Jgnsw6UY5kzLaWPln6ruStyEM+Vn++Ifhio2oiSyCdHyZKOm+Ye6k/8R2j/ijyj8EY1tYZB8PWZyj579u/JYprhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UahQDDQx; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-780fe76f457so2611037b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 17:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477246; x=1763082046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=UahQDDQx2S/1+zIWEWiVhNo003fauqOQy5AgYuvhKeQE8tNtjf8bOQ5y+Fbu+luyQL
         /OIS8kOez8tLa5sC16jyzoYGdFn0H0g7ADg+OQv5rlbIDv6y+c8nT/mwsG4dqcsBVg2+
         Zd9J0FFDwC3yPL/myUA66ilAJp9QFkUzFpFse2pJfl0CGuA8BVmCmgivwtOmRexrgaXq
         thw+FHED6lMejoj3tTeRJjXPPdHGR/q71Ca7fIyC+8N0/P2tYQ9pWJ4WmtpaqYZqGFLi
         w/X4b9xDIu3VVJ7oELkLmb79HdkYAwV1XciG777JgLDOwH6lJP265XwVLwv4ncpqRjhG
         7XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477246; x=1763082046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=tjVIyKXPwtP+g4kZ6A5fWNfy6UpHyz3Z7dJWe4gmsowZDIYWI9WCZhkx4ArOuEvsyk
         egA9x5ShrF3wJA4BIvx94+RDsrX4hq0nb9e3/TFYVl1+8AJgeZFGEJeZLSq6341rGUD3
         6zqlS90ie2wFP6wfvBuITYuW7JfAwqcW5+uudSlPaeGXXISwpdYPoWIHWVQu+3U4legx
         Vt41GqQgAGz2zer2s7fhGf1qtGMBXuBHLqW2QhRA9tKItvP1aK9ZaYd/Vi26mWx6b2iF
         XvrI60l1mnJPDDTOv/LbnLT0x0wvls2or1b0i5ZdK2GjFzPp9vWDMTQngeTJVgFg/VmH
         G3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ/kkLqTZ0eDMnZHRFyvreuIvZb6P/r6SYrVTO6UoN1+2qvF3Fc+hBbxDyvJFYFk97POdhYXaIrvq7nUYQ9Kk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4VWfkqIAdfgWKrZ8m1VwiTqOkyLYHWOQzk900yP1pu+SI1ibN
	SzzzhGiSggaKFiyB8hWY9/mQNQ3KptyBqd/eRV/jHi4wCoGI6X9C7Z4G
X-Gm-Gg: ASbGncvaF4eJh91ynFNS0EONng3Hz6AzOy4WyidFmcdRnSSfYPMtqHvP70PUPEBNhPn
	fgfU+1l7T3jrYYuSe9sR/VFxwx+A6so8STkJbwMcqSG8vc4rBiQW0lDMK+r8wkHO3g5XWJMCYGa
	yBxmDJ0zWPqWhJLCvcTFdAckb7o0xAJt4loarPUlXYr8RQWAQuNPE4k3YnUO1ZAGjBhGiPxDUXH
	lAEI3BzrtfIDCn5i6R6eie6cgyhxCT7c5cvOntB/wyTpDTcKoiuXR7aDJaQQCYvg2PfBUbBWG60
	goAXr4zRBCO41bJxiE+kNsEyqGzfV/ejSvBdgJARGnZSMCL7s3vINA9Ysnz1ZpSkuho5vptNqrA
	bOm3tVRd9+mX84k1ucdxGquEh726bQSdTVMC9nuT1daWXgHgnutj95EVvYHsKxzfNcUvoZtCRJ6
	sdMlmpjja8rNoIeQvGUWLJ3K4mQsoKYb1VR/mu
X-Google-Smtp-Source: AGHT+IGXlZDS/7AIW+f4SW9AQZ+mYsEsFZB3pq1/mcaIGtLtZbgr70tzGom2CV/dzdZ26+pnChUzJQ==
X-Received: by 2002:a05:690c:360b:b0:786:6076:e8d6 with SMTP id 00721157ae682-787c542e985mr22214027b3.57.1762477246594;
        Thu, 06 Nov 2025 17:00:46 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b15ffc52sm12984557b3.54.2025.11.06.17.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:00:45 -0800 (PST)
Date: Thu, 6 Nov 2025 17:00:44 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aQ1EvN3q90v3r3RD@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
 <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>

On Thu, Nov 06, 2025 at 05:23:53PM +0100, Stefano Garzarella wrote:
> On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:

[...]

> 
> I just reviewed the code changes. I skipped the selftest, since we are still
> discussing the other series (indeed I can't apply this anymore on top of
> that), so I'll check the rest later.
> 
> Thanks for the great work!
> 
> Stefano
> 

I appreciate it! Thanks again for the work on your side reviewing.

I'll address your feedback and rebase onto that other series shortly.

Best,
Bobby

