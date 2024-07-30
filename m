Return-Path: <linux-kselftest+bounces-14459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D392940BE0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 10:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174BE286C36
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 08:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB2C194132;
	Tue, 30 Jul 2024 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="XelrdWHH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84FD192B92
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722328785; cv=none; b=LAmngPbnicUI8l98QiwzTAh/e+H4zo4RSGdxcmG00rSVbkDNYqINk3byftmtuni3dtZ8Bt8uqomJ7iWhTviyJd5+migi3A5I9xFN8VuhJdWRGmyzbYmlmPHrqDbDx32dZ7Ggf6s/PownKsQcaVsXm1KvfAi1xEWdSSRc8H2PYbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722328785; c=relaxed/simple;
	bh=kTu9doBZt17ufnEj4X2OBn7FIA74WVGbMzi0N6M0EMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QqTUNdkHwETG7MRKMIzHi1FdYpIjNi+2k6F3APzxYgUtXMQTjPxFTJcP8qlc663+dbDmQvS1HxhDh/eu9xAkRrZO15VY04KM2V2j7dmTd28rLWD25YURks+vt9EIfPbfASnqzYS2Wd1hN4i16ltuqTVTUg2yrbe3i2TrlFORB8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=XelrdWHH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-427d71e746aso497725e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 01:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1722328782; x=1722933582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMbXMLPxdHgp8aCQRIwbUSynHwaJsa3HFc5CrwRM3iA=;
        b=XelrdWHH+uYvNHKjZ3MM+99XQNv15LjimBh/N1wgnqqsX51on9OjdL6SFX3ZSR0H04
         g3KmBZ2y7yjuMuhCzpO8V304Vg0XHfuMMSn2bM+x84aUnVZxrtYZQ8lxK28R4nBoEg5b
         ytfoSarRSMErLaubvDEl47NzkKO9inUyUgWtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722328782; x=1722933582;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMbXMLPxdHgp8aCQRIwbUSynHwaJsa3HFc5CrwRM3iA=;
        b=VI7SSdF5b+xIw4+5ok3pezIwAkKQ78uEXLOMlLjOIpAha8VWneh+13u3PAKboUXjon
         jQCcLXwthIRZNengL9dzgNk77IYUEk/3W6mQ5yohVGVT4/q6qkb+2YpYBzJC2gE9lOWt
         vMDvek67hxpReLY0ke5GS4IDLeovyBhtxu0KujSHTU1H1T/a/Tl9VPuoVDoMx+OwxZ/A
         aTfvUtE3N/IiZiz0HVdI7g120ESCLSJ1Rhe9g3sv7ylZUCnP4qXA4zsLE413ttGdmG5w
         kdf6r9MmL7UJ6e5buC3BEiJXbBUYTsxy5D8bIdwx1nIdx6iTGZQack07cy+bzV1H/GiH
         ILjA==
X-Forwarded-Encrypted: i=1; AJvYcCUdy8wUVn8F29SPPs2/qOl1n841yVNJY4Zeib6npqT1AF1R4w1XqsQMccX/ovzmF5AMBjJtFL/H9S2NrCLCXyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAZqggb+3Cr2wMFJCihdn9E76eiZt2K6QVl0/bvWG8ieNzmsNR
	RD3sj+EeJvSlL3HLADuEJlusFPd5IV/JppwLOz1EDoUltNpMQXa+EwiCcG/PnXY=
X-Google-Smtp-Source: AGHT+IGdFjY0cCQvq3hH977T/VIttQHVhMME0vlMsCLSRfvyDCHXoJ2M6IjFVm/zP4wBbIdXQrKJMQ==
X-Received: by 2002:a05:600c:1387:b0:426:6fc0:5910 with SMTP id 5b1f17b1804b1-428054feb50mr74046665e9.1.1722328782058;
        Tue, 30 Jul 2024 01:39:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281a5d10acsm79712725e9.24.2024.07.30.01.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 01:39:41 -0700 (PDT)
Date: Tue, 30 Jul 2024 10:39:39 +0200
From: Daniel Vetter <daniel.vetter@ffwll.ch>
To: Zenghui Yu <yuzenghui@huawei.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	daniel.vetter@ffwll.ch, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] MAINTAINERS: Add selftests to DMA-BUF HEAPS FRAMEWORK
 entry
Message-ID: <Zqimyx_jEi5ne6GB@phenom.ffwll.local>
Mail-Followup-To: Zenghui Yu <yuzenghui@huawei.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, sumit.semwal@linaro.org,
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
	jstultz@google.com, tjmercier@google.com, shuah@kernel.org,
	wanghaibin.wang@huawei.com
References: <20240729081202.937-1-yuzenghui@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729081202.937-1-yuzenghui@huawei.com>
X-Operating-System: Linux phenom 6.9.7-amd64 

On Mon, Jul 29, 2024 at 04:12:02PM +0800, Zenghui Yu wrote:
> Include dmabuf-heaps selftests in the correct entry so that updates to it
> can be sent to the right place.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>

Applied to drm-misc-next, thanks for your patch.
-Sima

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 42decde38320..b7f24c9fb0e2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6660,6 +6660,7 @@ F:	drivers/dma-buf/dma-heap.c
>  F:	drivers/dma-buf/heaps/*
>  F:	include/linux/dma-heap.h
>  F:	include/uapi/linux/dma-heap.h
> +F:	tools/testing/selftests/dmabuf-heaps/
>  
>  DMC FREQUENCY DRIVER FOR SAMSUNG EXYNOS5422
>  M:	Lukasz Luba <lukasz.luba@arm.com>
> -- 
> 2.33.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

