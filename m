Return-Path: <linux-kselftest+bounces-33683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A476AC2B60
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 23:33:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7A5A40AEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 21:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 526D520B804;
	Fri, 23 May 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJxGER6B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA35204F9C;
	Fri, 23 May 2025 21:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748035994; cv=none; b=UMfv9/+n0FIb1sE5088Z4yWMEJndGeDunhFa6vS74MiwNijf1XoMVQQvKCmFeaze7p+ejSjp1SZIBsqrCUsz7XH+MrIdBP4xo8BGGLysuCB9aqO4Z6Xhi5XVQQNY1CPHenkixEmDTX8aRVbZyta3Ly/wBq2GQn4910atpmjrUcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748035994; c=relaxed/simple;
	bh=t6LBh1erf6q85Lrcs1o3C3ibSfhlLfMbc8dn3fx1GKM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pW6cFL3l1a6HrWbuPIQX2wUx1Jr29Ix2++1nIBEG8LPdMrknezIRRkQvhI+g1isXIPKZCjJ+IlA8Nx3PChKdYnInF5chWMsWUo+sz6uprEx+HusqIkw/7rKBcxy6UOaUf6fFoN1dh/B+hn6bhj/igs8HsH4vO+YAWT1QYujbVvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJxGER6B; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43edecbfb46so1961785e9.0;
        Fri, 23 May 2025 14:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748035991; x=1748640791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpf4Pbv2LaunBeAGYa0hZONpjIJoOeyE288WoeCcc9A=;
        b=KJxGER6BSPF+Lh+hteYdY28LmcMyzzhsey4sbLQCm3d4IGKzKHN9PwwIn0kj6PvYl7
         c+H0B6h60XvEJmZo5XHfbJXQJ49/aE+AopE75vUMQrVjzn24pVPm1ZGRv29nOQpICYWP
         fOeUDShogfNEA5MaNe6tetiaDd2Dbxc/bIH+iK6MDHsuW97/1jhGo7NBZ0t2EwloFsXQ
         T/ogrqjDu0SdMfN3tj6lg5BxeNEartluM7Ph8LOSWRcZlB8FaLoJuosl7BxaY54X6CCl
         eA1VGZ7yZNAJ7r9FT751onDYbRq3ViJ2b+Btp/4x+HXt98qgDKJOXJNrBzVXKZacPNKz
         3p7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748035991; x=1748640791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qpf4Pbv2LaunBeAGYa0hZONpjIJoOeyE288WoeCcc9A=;
        b=nbsqql67yBoLsNlkIoBzKh5jyLlb/MVAdZmxC3kKatqzjF91YR2w5S1evdjgxSzRqn
         qYrImk/svi2LFodDUunX83r6GUCt+gBZ3ECPNMcfUsw/C8Qb5A6Y8b2GRP2hSMFMUYCT
         vfsgp0hDal8aVLpokZjdnlG19+BH6kU63I0ANfyzNZcdrzDAJU61F3KzsJ27Uddj+ScP
         MyFpP1l7wwN9krJuAhNsLaKX8aRdTGH4GxNwvV+gdn4adqDoM8arBUgmKJTrlC/jO/Ll
         ZOkyiO2TJjjAjntRiFa0BWxtgaEgQu6dRR2eiP010CImer0cP9Yx0gxsi0yXyoIEHETl
         uv9w==
X-Forwarded-Encrypted: i=1; AJvYcCU/GrVfulGIvRZG7kEYsRDdb4VrK9CmbOrLtERbWIWe8qq0V5whOMPuOaqCfU1qMwhptgRVdIYmji1dvAQ=@vger.kernel.org, AJvYcCUREFV7q+pMEQ6h814f/+amG6WyEOJfC2rrZ1C9a4PiChnhwg4VHhg8SEYVbQbPjlvySv/0GvCMTgQHfkGvx3vt@vger.kernel.org
X-Gm-Message-State: AOJu0YykzCyBRH8oengIXFlJaLl6vSMiEvB/X6oMQGzJVGl0xZE5gfrP
	WmdZ/Klg8aVvrCPDIeIUnAfWsPOShzGr3ZK6FKxb9uzaGHzRMqwkiQpr
X-Gm-Gg: ASbGncv1HGPy20TmaJB/IV96qIb0+mOH4Uo6B6e2MeQ9gOjcFJ0aiZ35T2pfdhEKidu
	2YIkGVttAPKCSTppW/XL/z6+ejDnqXBYx/zLNGe128p2CUIvmmtIoXSugJiAz33XGRYLk/caOy2
	g1RU0qOR4DFkVABif2qfa3ZfhHpX/Wq00IHq3sdVUfdKFvWsbPeB4u0fqx5pBXoYMuBpetDk9MH
	ETPRJSyMXfNs1wkd3v6k62zE0X4GoWx1XwTw/M8imM/z3M1g0iUU3cTuarUM4WVfezG2H2hxuwz
	vUNjLsmUmhpyoGBbtZ6nH3UrYahnAVACCX6Mb3htGzl1mPog7lBpjBTNBHcwZwVqqI3a
X-Google-Smtp-Source: AGHT+IE3WHr7NkotDT0Tn5O4UHcUPRin9SJD8uSEXI0fanie/Wcubh2smOWrZEWwxNVVsR9JC6NhtQ==
X-Received: by 2002:a05:6000:2285:b0:3a3:ec58:ebf2 with SMTP id ffacd0b85a97d-3a4cb408fb0mr677310f8f.7.1748035990451;
        Fri, 23 May 2025 14:33:10 -0700 (PDT)
Received: from [192.168.1.46] ([154.183.50.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4c8cdc618sm1247221f8f.0.2025.05.23.14.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 May 2025 14:33:10 -0700 (PDT)
Message-ID: <73101285-2854-470e-a3bb-9a363a7c1991@gmail.com>
Date: Sat, 24 May 2025 00:33:08 +0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] selftests/mm: Skip tests dependent on a binary not built
To: Shuah Khan <skhan@linuxfoundation.org>, linux-mm@kvack.org
Cc: linux-kernel-mentees@lists.linux.dev, akpm@linux-foundation.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250523184312.2647781-1-khaledelnaggarlinux@gmail.com>
 <41d3b11b-d269-4ee5-a118-6608c804e068@linuxfoundation.org>
Content-Language: en-US
From: Khaled Elnaggar <khaledelnaggarlinux@gmail.com>
In-Reply-To: <41d3b11b-d269-4ee5-a118-6608c804e068@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/05/2025 12:09 am, Shuah Khan wrote:
> On 5/23/25 12:43, Khaled Elnaggar wrote:
>> Hello.
>>
> 
> The above doesn't belong in change log. Refer to a few change logs
> in the repo to learn  how to write them.
> 
> You can also check the kernel documentation - this change log
> is way too long. It doesn't clearly state what is being fixed.
> 
> In this case, "write_to_hugetlbfs" is missing because the right
> config isn't enabled. Test stalls waiting for write_to_hugetlbfs
> to run.
> 
> You are fixing this by checking if write_to_hugetlbfs exixts
> from /mm/run_vmtests.sh
> 
> Summarize this in short description so people can understand
> the change.
> 
> thanks,
> -- Shuah

Oh, I mistakenly thought since RFC does not get merged into source tree, 
it could have a relaxed tone, hence the much text.

Appreciate your feedback, I will rewrite the patch considering the
points mentioned. Thank you.


