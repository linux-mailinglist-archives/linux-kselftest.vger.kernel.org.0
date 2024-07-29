Return-Path: <linux-kselftest+bounces-14349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3209293EDE2
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 09:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53EEE1C21DA5
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2024 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096C126F2A;
	Mon, 29 Jul 2024 07:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="BSwQEp+y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECB28615A
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 07:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236523; cv=none; b=Ilo2yo/X+M5z92S2jTKGX2KQ6Yc1HD3WM5eNVPCEQ0va4wEx4CtH1pnCicfNEk9PXZN6KM0S3ud1RkOk2H2tkXz6Oa/iOs8/iN1/EPu+RRJYfvKUmUWf5N2dNoil6y22ttDqWeQ55eLzqSWPFjkLB1bdQWsXMyxyg+h/RvYK/ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236523; c=relaxed/simple;
	bh=OfOwg30Kz1gJciOmBHTSSNW3kho05OpZx0+UKqjPXek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P2xHNZkvjEFpZ1K11Qn10/nNgY1SS5Suybjr5gWWA5dip1cI0+36ILGun9aUvLFZ9/QUAHOuhXbL4JTs2amIzZN8ZiJ+chpYXd6G7ALm+aiT2mst1nn7HMcXihlOwx1p6qZyfQYZU1npeqyLkIXNd9yZ6VWBl2/JrYz+v2g1AEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=BSwQEp+y; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42111cf2706so2473195e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Jul 2024 00:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722236520; x=1722841320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jiq86OgV8aN77ZK3gSdcC84nDSEMhthS0/eJkO/i+l0=;
        b=BSwQEp+ySpncpgp63OameFPhiH6ErcJioouSgYkOB6drGXlemsvgB71njPs50gSOZK
         S69kyESkhmfal7dOmYV+iHrPGaAM16liGAqeKR6XH69h8i94HPv2/LRHjkuucbrucdUH
         Jyc8nHam4I7ZqzDlfSFB5tbETd0ooeMq931/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722236520; x=1722841320;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jiq86OgV8aN77ZK3gSdcC84nDSEMhthS0/eJkO/i+l0=;
        b=G7Q+3ZsiHsWr1AgoO2qWKlUY1SA3RviUK5m0yCJb51QVW/aJfAop1aNMku5tXccGcp
         EKJj/tUYhnj8RNsP7F7d9oozE7aeXmzIPAMg4oWukCQ7mjcoYFC/sfi0Zykz4cevwT0w
         qJlFxwolTTAyu6JOsqKaKxmctps0MlAgQJWjlX/nFymjS8XrXKbVCiiXRPswGzvKFbAZ
         bdkQ4ZoxbcBbkH6bIyoWcG9anTSzrUSjPs//U/FNy3Our+K85gGowdkvAuU6A71xw6rv
         0iQhi67TxjcDFVqNaRo0CDGuD6JzONC0WaP9nwkUvlC4esK+rxS6xYZ36re9Q1cPxg6h
         uBAw==
X-Forwarded-Encrypted: i=1; AJvYcCXeE5j3CfspkdMBimo4n4dWy06quxqOI+9uFwwgu+E2nQaySPzTXwDKZFhFD+s3/q9RzdeX6OAl5SP4tLdRYS7qk8M8MmOThlqPsaRMpcNo
X-Gm-Message-State: AOJu0Yxrd98tXx6HLCySHZ41somMUXskl1qrhBgTBOwc9XO11m+laMo4
	ThIwpci0HREgtbwVaXFfr1+IFsn8HRwcRUJOyiAL8w0/rtF6nzi8cjwgeaKSc18=
X-Google-Smtp-Source: AGHT+IEiT+O8ufmV6ZCYKgzAur7uD7ABX1l7m8G+4knDu8SiWra9FtLVycZ8kwh2N41DGIzudaMzfQ==
X-Received: by 2002:a05:600c:4511:b0:425:65b1:abb4 with SMTP id 5b1f17b1804b1-428053beee0mr56974615e9.0.1722236519848;
        Mon, 29 Jul 2024 00:01:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281225141dsm83180525e9.45.2024.07.29.00.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 00:01:59 -0700 (PDT)
Date: Mon, 29 Jul 2024 09:01:57 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	wanghaibin.wang@huawei.com
Subject: Re: [PATCH v2] kselftests: dmabuf-heaps: Ensure the driver name is
 null-terminated
Message-ID: <Zqc-ZWlTYwnKHoQK@phenom.ffwll.local>
Mail-Followup-To: Zenghui Yu <yuzenghui@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	wanghaibin.wang@huawei.com
References: <20240729024604.2046-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729024604.2046-1-yuzenghui@huawei.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 29, 2024 at 10:46:04AM +0800, Zenghui Yu wrote:
> Even if a vgem device is configured in, we will skip the import_vgem_fd()
> test almost every time.
> 
>   TAP version 13
>   1..11
>   # Testing heap: system
>   # =======================================
>   # Testing allocation and importing:
>   ok 1 # SKIP Could not open vgem -1
> 
> The problem is that we use the DRM_IOCTL_VERSION ioctl to query the driver
> version information but leave the name field a non-null-terminated string.
> Terminate it properly to actually test against the vgem device.
> 
> While at it, let's check the length of the driver name is exactly 4 bytes
> and return early otherwise (in case there is a name like "vgemfoo" that
> gets converted to "vgem\0" unexpectedly).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
> * From v1 [1]:
>   - Check version.name_len is exactly 4 bytes and return early otherwise
> 
> [1] https://lore.kernel.org/r/20240708134654.1725-1-yuzenghui@huawei.com

Thanks for your patch, I'll push it to drm-misc-next-fixes.

> P.S., Maybe worth including the kselftests file into "DMA-BUF HEAPS
> FRAMEWORK" MAINTAINERS entry?

Good idea, want to do the patch for that too?

Cheers, Sima


> 
>  tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> index 5f541522364f..5d0a809dc2df 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -29,9 +29,11 @@ static int check_vgem(int fd)
>  	version.name = name;
>  
>  	ret = ioctl(fd, DRM_IOCTL_VERSION, &version);
> -	if (ret)
> +	if (ret || version.name_len != 4)
>  		return 0;
>  
> +	name[4] = '\0';
> +
>  	return !strcmp(name, "vgem");
>  }
>  
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

