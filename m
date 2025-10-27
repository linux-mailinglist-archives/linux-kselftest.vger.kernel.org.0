Return-Path: <linux-kselftest+bounces-44121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B55C0F9E8
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B28934E63E9
	for <lists+linux-kselftest@lfdr.de>; Mon, 27 Oct 2025 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5006E315D24;
	Mon, 27 Oct 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UypOm19P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAF53115B1
	for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585937; cv=none; b=IX9z5Jmil3Uaq4BqVl8hV0io9P8YqeYXYKq4De8VD0RZTiCzevUujGBLdVZ3Kftg3r5wx63q5XOTmBVhTYgjLzuDfprbCL5fOO5Zut69mrKLN+wbokpPrxz+hrlrPpvjYtRPrNaLhxqRD7nmldyujQDtR3tuSK1nzWfpXulSAaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585937; c=relaxed/simple;
	bh=HAqDcgGMjKKzyDltuxO03NIXefnszZjB7wdrs046Gys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjWQOrppTZTeYTVn3IFUCpE5gBHQf952YmY7+NDNJ/JHHxu6aVCz7A/DWuHFjmUjX3nDq6YSqohWz7TWid0c5ckSw+HL2CBVNQ7WzIh7Vn/+4vJjmOme7Wr16+Lh81GyWCRGpt8sQUu+Mzsiph2SR3fgrcpFB4aFi2spuw8hYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UypOm19P; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-784826b775aso54939387b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 27 Oct 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761585934; x=1762190734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=UypOm19PIaJXT77Hrr6pWAUNTOqddsoLus5KTq1conazITUnHnyPeEubbTWMTL5CEZ
         oZgZQZYcB7xEbAVXGmD7ci7W6P1F69Bv9w+uC53x8yXeB2z0ecWnIp+3UI5DWCwKr5bQ
         z66vb99ZeW2530AG0GGcastxAQ0Fr/AoQ7Qr4z+fmpX7ixscRod1ZP2/6UPM0PUXk2Og
         BpEAeSZI1kBQXMPcKX3fRGep94r0IQjhp6L4Prj3FvdparUhGQUjwp1W+PrMZm6zEAzT
         5RQx0Qy1G/1HT2Sg/atd5PsL6srvd/VGxqvZWz0h4xWYOEm53Wbz333h1eKbaO///0si
         mv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585934; x=1762190734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=Z9U3ehmtlnhO4GxO2jCkCtz5W8dwkZ88c49Wc2oJWlTN1dc5SAeFkyTT4lv3IoCxo1
         iTB3/eqSBOeHQoccojJHt7V6MUAZi1Om8InRrrBEYPK0GVy2zvFgny61q+QTeTBenRt9
         gPl66IvcW8kZm6494vYw2Wq+gpFH7jVGg5pNYvi2+ixk3s/QTMRtYpHnAGaSNKFc4Nyi
         oRVr/B8r3SMjCuiKXYCJ2UelxL2U4Vu8CoCYOT2Cs456+ludDQlsDrx+6vByCS4nX9bf
         eWTJzw8omonZqdqvalBjj7IiAA3MBw6CbmhMDoHYEIVCKhAzHg12GCkI9XQnCmqIBNzT
         nFZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/dhmbO9d40N2qeYK+sgJV5co/HPDoMOfx508aeN5ya4DbxU3RGLjf/30T6jmC+9c/JOMHolGb7e85NnRXcdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNTykdHK8imazklcf77E3bdpEDCKy4YCQTMY2kxxKd0g1bAjOZ
	K0i3C1zd+GlVV7gL3sSjkQEy+XwA49ueNekSyJPtR1dOJivgwmHWn3sm
X-Gm-Gg: ASbGncsc+xKNee6FORWZu+87anM4KMzSKmsxOfW+aE64hJIV2zww8Yj+NZUUAvoYhfk
	oy+3PzTiC5GS43VWRn5pJXMB3lPEfJZ4CJvrAi0d8zh5BaTTkOg1G8SDu472ZuBo5EVm+IrpH8y
	J9vLysy0OrOQIXMYTvePzldjW12vT6d3q/A+ARGMwuMnPE36YVVMoZqruNIxJfOJPfUlctn0/kM
	pa4iJm7AiOt5sIFrf3TkA5nO/igyiQKLaCzFh9IqQ3b5AMXkG7bocyyEXWDl/K0vGG3392kh45F
	Wv2SrEWuf7UvCnQn1nQqA7A7Wzhs8tO235gC/ueSjR3QW4VbjKgJb7mO0SBRi0P0Gw/lqSAmFto
	m8M+a0GYUtr4ysWX9WYAvaUwszdhpp1ZPyaSlTxRUVA6C10ROIxq6NveiO7TjoslA/BVJMXKF8H
	bKnRU5OdMWCDJ6TDAuXtbxdbSwnhCp/BwVklM=
X-Google-Smtp-Source: AGHT+IGHTF9vBtn+seygObOHlL96iKi+OVb+7MtjlE9jx6wEi+MY/OkA96sVfPPxkYnPfsaXOqXkAw==
X-Received: by 2002:a05:690c:338b:b0:723:bf47:96f8 with SMTP id 00721157ae682-786183ab057mr5505517b3.53.1761585934504;
        Mon, 27 Oct 2025 10:25:34 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1423f5sm20564397b3.5.2025.10.27.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:25:33 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:25:29 -0700
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
Message-ID: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>

On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
> Hi Bobby,
> 
> > 
> > Changes in v8:
> > - Break generic cleanup/refactoring patches into standalone series,
> >  remove those from this series
> 
> Yep, thanks for splitting the series. I'll review it ASAP since it's a
> dependency.
> 
> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
> I'll do my best to review both series this week.
> 
> Thanks,
> Stefano
> 

Thanks for the heads up!

Best,
Bobby

