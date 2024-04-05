Return-Path: <linux-kselftest+bounces-7293-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6302A89A049
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 16:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EB71F22B58
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Apr 2024 14:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9692316F829;
	Fri,  5 Apr 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O7LpCr7H"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C4716F27A
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Apr 2024 14:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328996; cv=none; b=pQZmcqP2HlCoQz8tXWdz0a4ALK46pPVaBGqx+nZET4zBQ2CeoLFDJ1R0py/7x+LZ20XRTSOam9ybOen2FCVME/QM/XOaMCIAWEDVUOauWXYk06KpEJRqcpaqALa59PA1cdSy8bMnJ7e2zj+xFL16bkgEyuuZqIcYGwEfLxiSER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328996; c=relaxed/simple;
	bh=zTMZhwQ+6oLIfkGA01wNSBzTksqHQBG/2caFP1/JlXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JnQjIi3htwjlUDXsRST9YCFFjiK3BkHicIIdShK3WrB37M4MWEk7dSTsS+OtUegwaawviF9pyrq9cQ+wXcYOapD6DDvx7S+ZeFD8h1cmTktodbshUa1p40lmo91ji5ZFf7mxxNSUGHBavLvLZtulRsnbLH/xb3Lz03vI89xmmsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O7LpCr7H; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c86e6f649aso22129039f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Apr 2024 07:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712328993; x=1712933793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eVVvp+398iheOw5gutAtm6G0zLb/uxNorrWUv4KFnio=;
        b=O7LpCr7HWxXvkHzrM5aMANERAPz/6RjV/hyI1ZZ5SIzoDzonLylgFSBEBKgRkdQ1Zb
         qz4r8jtYdS5Lwj4JwYxW3egougdpAxVQQ0TsPxJyLPXS8womcmcLl4A6e3VbiLXNvhPT
         +WJ5CM6HaAWp+DASAIKSrYqHhZgEMpEzZ1f6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328993; x=1712933793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eVVvp+398iheOw5gutAtm6G0zLb/uxNorrWUv4KFnio=;
        b=nxAd3bybyQ83llfkf3RNdSJP+ZFZpbneFnUOOAkytM8HxHObj15ldNJ23qg25D/Pt6
         3Q6U8lHp5sZKVYoLg0AteZIHU9vuZ6QyOUN5yVRFwP+S/w9c+CbAQe1wOqMGUmQpkAJ+
         A7deJ1DP9kfdt6ZAQFnP0e2NQ4/+4N+NYfQ7zW3vv8MP6DC3gnqAoyjaXHx0n3ttdYCL
         Y5Y6yqZHJj1jH4KZSfiSWN5wiFwh9zHI/+ToR6M+gRRt2a2cDTzn0hMUugzqZa2X/PVx
         8qteCvhgYkK4Y1PNcapptCBLgjy7sOTeh8+EZkE5yiUIbrJRVK7lrScOVhMW61zFYbEz
         nkqA==
X-Forwarded-Encrypted: i=1; AJvYcCWDbuzSGwtXi36HckHeKtLA2nlolE23w8Vt5EUdGNex7ZMy37d1wANP6aCHrrg1ydXbUq3Q3ctf4twKhH3N0sJHaJjExWKSDFEM2WhzpZuU
X-Gm-Message-State: AOJu0Yy5CeOYlaSNnBde3jl8jj1xpnx+Wj2qDNrXckvCziaGz+qT6ZEs
	h6Yn4hVazogD3SGgryVrXxJVvnucbe2E1KMz/ijXfjZFiEuzr9ijoJYpIj0Sx7s=
X-Google-Smtp-Source: AGHT+IEkdy1rdEG+rjc30ywKaQ9qlK6/njmx8r/DcDzK1jQaFuF4ReeRun+a1EcXGR4eE0eknNVLJw==
X-Received: by 2002:a5e:c648:0:b0:7d3:4ff8:7bb1 with SMTP id s8-20020a5ec648000000b007d34ff87bb1mr1694674ioo.1.1712328992992;
        Fri, 05 Apr 2024 07:56:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id j4-20020a05663822c400b0047ad636c705sm601613jat.73.2024.04.05.07.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:56:32 -0700 (PDT)
Message-ID: <2a77adeb-ed22-4a9b-a1d9-ac5d29ae696d@linuxfoundation.org>
Date: Fri, 5 Apr 2024 08:56:31 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] selftests: Replace "Bail out" with "Error" in
 ksft_exit_fail_msg()
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240405131748.1582646-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240405131748.1582646-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 07:17, Muhammad Usama Anjum wrote:
> "Bail out! " is not descriptive. It rather should be: "Failed: " and
> then this added prefix doesn't need to be added everywhere. Usually in
> the logs, we are searching for "Failed" or "Error" instead of "Bail
> out" so it must be replace.
> 
> Remove Error/Failed prefixes from all usages as well.
> 
> Muhammad Usama Anjum (2):
>    selftests: Replace "Bail out" with "Error"
>    selftests: Remove Error/Failed prefix from ksft_exit_fail*() usages
> 
>   tools/testing/selftests/exec/load_address.c   |   8 +-
>   .../testing/selftests/exec/recursion-depth.c  |  10 +-
>   tools/testing/selftests/kselftest.h           |   2 +-
>   .../selftests/mm/map_fixed_noreplace.c        |  24 +--
>   tools/testing/selftests/mm/map_populate.c     |   2 +-
>   tools/testing/selftests/mm/mremap_dontunmap.c |   2 +-
>   tools/testing/selftests/mm/pagemap_ioctl.c    | 166 +++++++++---------
>   .../selftests/mm/split_huge_page_test.c       |   2 +-
>   8 files changed, 108 insertions(+), 108 deletions(-)
> 

Andrew, Kees,

I will apply these to linux-kselftest next as a series since these
changes depend on change to tools/testing/selftests/kselftest.h
and need to go together.

Are you okay with that?

thanks,
-- Shuah


