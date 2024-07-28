Return-Path: <linux-kselftest+bounces-14344-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A1393E4FB
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 13:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59CF31F219C8
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 11:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ED13B78D;
	Sun, 28 Jul 2024 11:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exCTy/SZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC318EAD0;
	Sun, 28 Jul 2024 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722167701; cv=none; b=DrQpiMcJPq9Ar/deB4n7AyQ61iYf/mQzizx42mRO9VkvLg/ZD5lX+zGsG8Yl3GQOOA+3dHJxiL6R4n+Hjvyc9s2p4140YJ+CtB16EdEQyIAs7YfZF5M0T32z0B3hmyzGh3Tsvq8iPVIFSkuNN6eN74m3SSOtE+k9MhHU7hHa7eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722167701; c=relaxed/simple;
	bh=ebEmE6yxa72kDlnAPNumxA/Rzcxn7AaMkp24552T6fw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s8tOT9YUPYWKqcDkl3WOHHhxzlhTXrM6D6psefmhFWLhYaNHKIIXCJJ8gLYV9TBuRhtHmDFHA67hILRrJpFt6KrFO1DET1vEJTT72nXDu8sX4wlpkvXYVC71ZVWKO280tCyKDC3WnoysOinKxV4MTfNWIvd/VNsx0OCRy3SqvP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=exCTy/SZ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-36874d7f70bso196314f8f.1;
        Sun, 28 Jul 2024 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722167698; x=1722772498; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8xmpSOBK68vpqOxcO8IAsD8IIZwNUgCDMrjM2ilo6Vo=;
        b=exCTy/SZZwCcq43wzF+bWPFz6OI4duQ1LX8byf8gQDA3JkghLuU1iIzB1GuZhAhDGI
         zNNAkjMC85JfXtWa7env/R8fO3YXv14XqtmKlVWAz41V/sdNFUszIAT76NxYA3H5NKCR
         yqbGt0ZxJXy2poch/H49L6TL9hMkBSyjhEGjGDLcS36z2EMYQjtke4eukFVSY2JzFU2J
         nhPNuOSipEPiVRjJENRC0zxzBVRVSlLccBWufEPgg3/BB22JY/XpfmCXpxLlwJBUadoC
         d84MRnCralpW+3nmHmUsyufrNuGxACpbnWfQX9pXFhSD0LotHQ5HcmyuR94LegEKgGUK
         RQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722167698; x=1722772498;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8xmpSOBK68vpqOxcO8IAsD8IIZwNUgCDMrjM2ilo6Vo=;
        b=FGJ3NAvTdCJrYRa57U++c4n72gy4oIKHoqsfwvaK4yNFRiwKTiLv6nSAPFn+uBre0C
         P59Y4ac8gcYJuMs7paizHjhQD3N1aosahbi5FTmGDpqdf5uvK2CcwbbkYgHJMfKZOb4O
         Emc5LS84G1oeDoarkuqbP/QNNweQJaKykjs6CpAjKy+sHAPGtUu4yp3f6JIVOgYkxsRN
         z/od/gYLTpV6+BXHh84PsYCgwgX8nZaSeEvb+njg6434Lf1hQUivwNhdSc/vBvkqK+sX
         HnV/+E6FSPOtU3HvYwgNw3lvsOsnCsFPQ7+RP9x2jbXhDyWCtN5PFmyeXpBRvAAWzhd5
         5/+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU5j8B+jL2j6tGgmnYBctiTqapQrHQo/lCbq1cVT8wmFbWJu92MyFmz9RZTunvBDLldAeMnrsJk9m/HIIdM@vger.kernel.org, AJvYcCVmLqExAcxul6peAzdURLhhNffNUfq2oCzyZvrJJiGRssSxl3Nv9oiwxiSd66l/DtQv48FjqB1ZxQE=@vger.kernel.org, AJvYcCWL28nHjdKHKSKqhjc9uQDeq6dnXhxaK1rJHkpi9Yu+U/Zki55HIOaWxWjdsjUPhLWSLpWo2AGXfGcrN4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTj5prkQCkXLo9V7i7Cv+dDCGa5e7bVjwXTsqnYb8aM4yh8ffS
	9peUjtEkyb2BGL1egBkt/ob+Axz1ADWYKzAXyF/wTOJSVHVP6pPD
X-Google-Smtp-Source: AGHT+IGVymRTomVtW5etCRWyLm9nm566X+zs1ZwGWNnf1O596eq4IbUw3D6Gl+lQ4o8znDqETUm+TA==
X-Received: by 2002:a5d:64c4:0:b0:366:ea51:be79 with SMTP id ffacd0b85a97d-36b34e4dbdemr4718187f8f.6.1722167697727;
        Sun, 28 Jul 2024 04:54:57 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:d20e:7300:1d00:5943:7f74:2af0? ([2a01:4b00:d20e:7300:1d00:5943:7f74:2af0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36863d87sm9643407f8f.110.2024.07.28.04.54.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jul 2024 04:54:57 -0700 (PDT)
Message-ID: <b9ac0ee3-18af-459d-958e-3b8122e7bb9d@gmail.com>
Date: Sun, 28 Jul 2024 12:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] ALSA: timer: Introduce virtual userspace-driven
 timers
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, perex@perex.cz,
 tiwai@suse.com, corbet@lwn.net, broonie@kernel.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, aholzinger@gmx.de
References: <20240726074750.626671-1-ivan.orlov0322@gmail.com>
 <20240726074750.626671-4-ivan.orlov0322@gmail.com>
 <0576f5dd-656b-4085-8c8d-b0f845875f0f@wanadoo.fr>
 <3ab0aa72-4f89-4911-8546-ce17f362c981@gmail.com>
 <42ba79ad-3354-448d-ae03-6f68d51f46c5@wanadoo.fr>
 <08bdc510-da39-42d4-a104-9c7119d082ea@gmail.com>
 <c73da5fd-51a9-4744-9687-0ebc56c34fca@wanadoo.fr>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <c73da5fd-51a9-4744-9687-0ebc56c34fca@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/28/24 11:29, Christophe JAILLET wrote:
> 
> I may be wrong but I think that ida allocates hunks for 1024 bits (128 
> bytes * 8) at a time. (see [1])
> 
> So with this extra sape and the sapce for the xarray, it would waste a 
> few bytes of memory, yes.
> 
> With ida, there is also some locking that may be unnecessary (but harmless)
> 
> 
> Hoping, I got it right, here are a few numbers:
> 
> On a x86_64, with allmodconfig:
> 
> Your initial patch:
>     text       data        bss        dec        hex    filename
>    55020       1783        268      57071       deef    sound/core/timer.o
> 
> With ida:
>    54763       1631        116      56510       dcbe    sound/core/timer.o
> + 128 bytes of runtime memory allocation
> 
> With bitmap:
>    54805       1535        132      56472       dc98    sound/core/timer.o
> 
> 
> I think that the code would be slightly more elegant with ida, but 
> implementing it with a bitmap does not add that much complexity.
> 

Ah, alright, I agree that the code would be cleaner when using IDA, and 
such a small memory overhead won't be significant/noticeable. I'm going 
to use IDA in the V2 instead of bitmap API, thank you so much for 
pointing me to it (I was wondering if the Kernel has a generic ID 
allocator and now I finally know it does :) ).

Thank you!

-- 
Kind regards,
Ivan Orlov


