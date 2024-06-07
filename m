Return-Path: <linux-kselftest+bounces-11439-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A0900CC7
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 22:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B83A1F22B2D
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jun 2024 20:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7152214E2F8;
	Fri,  7 Jun 2024 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gLN5hlVU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7AE4D11B
	for <linux-kselftest@vger.kernel.org>; Fri,  7 Jun 2024 20:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717791399; cv=none; b=u++Bcw3Uynp7UWtoHRCT83fjWWbffWXwlHNnjuZbLgfC63z7t6VGe5zhapNccLxFqsurqXtYYrp5cmSiGafWQ9X2w2UfjVNPzN8+dFkilp1fIkZ2cWpSvPqn0xqZ+LXeXUQ84bjQ9voWp3+A3v9qJlvvwkQ0Yt4ccJFa32nez1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717791399; c=relaxed/simple;
	bh=94dQIEaXbShYcCUD2VZwQZfWzDfpId6SaEJtAerUUDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HHVAiXxRY89/7q60nbdNEoAKUAwQTn7Fzb6LO/lL88Qcs+ZR275WvODrp4fb6BfZNVfUObs71p1TC6dRIUH2X+jBehSukmMrOy8eV+G2e2p+uRWaTyTofUtZqDVy+i4QFjUpknA7VHShrB6rrg0t7l6hYE2EJM3xeNMDOsg7wgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gLN5hlVU; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3758686ef2fso535125ab.0
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jun 2024 13:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1717791396; x=1718396196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=96rEQbBFraOtroPGskwQv9wJ6BgYJkFe+xf7ykDOFvM=;
        b=gLN5hlVUsLfYAhKpEQyKwtcsjfdR5CSgnOYfNG7hZ6HC1QEwJwcWQGlXI0fgPYaKSU
         4g0RPRvkyFavddKUYdAYm/yp4FXfyj5Y0YoHWwvj7TRqA6xA9hPhnt1VKj2i0SphXvZi
         3mRgcsTRo/wlIe5BlEdvxtRsXVXUMjXeI/wMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717791396; x=1718396196;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=96rEQbBFraOtroPGskwQv9wJ6BgYJkFe+xf7ykDOFvM=;
        b=lJmtTTH5QUcakmJ/cwifVVZmKFMlcDKocRKox3IhqTxJAkTGpStzkzMx+RSh6qeayN
         DGeLGVUeXeHOPGrmjzwWvI3LvS+TOn+6PQE33E46TKE9zTqzXQe+aaCmncS6OxmpFwwQ
         IyS5ab0IPc0k3peRudxPtpdKTjPVrTfot5ExJw0kaIE577/qaxd+QORdCE2nCZv4oJ8g
         ++hNBlHqZj67rSj/ERrRT/vi7n9fmpM4oQYpCj9zDAQNShaCQlEjlPU/E23CWx7CO2CQ
         b6R5VWQKOBCKv5UtJJQVb3k7evmU6HdKDt0MAqGGaIdeLu8CDqfj7ZRkgEpU44iSYInP
         e9zw==
X-Forwarded-Encrypted: i=1; AJvYcCXNDFitd695KxrgWH4CAwLU3AIbYTHkTNWHVctQVZTs2a/8s5XJGWcoGEJDBm72gxJr8ioMxtM6RiJ1rRdXB65boQiCaPZhbiuD+tlnMjVP
X-Gm-Message-State: AOJu0Ywbi2nBfuqlOTV1JesYJ/Ub0Zxdq+oCALwbxbQULrEKAayU1CMm
	PVCkrH2Ub9y1iwfQ7AXuEof98IdA4xFdTIoOPzKtnMKGEV5nYHi+Nzgt5/haQUY=
X-Google-Smtp-Source: AGHT+IGWuRP8uOeTBdfHQ4EtimpCODHyKWkg57vDi+SJtc+P1tHb2l9ZmD9GDO5yRdRZlSt99OBjFQ==
X-Received: by 2002:a05:6602:256c:b0:7eb:6a6e:c830 with SMTP id ca18e2360f4ac-7eb6a6ec94dmr106967639f.2.1717791396021;
        Fri, 07 Jun 2024 13:16:36 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4b7a224cdd2sm1001756173.57.2024.06.07.13.16.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 13:16:35 -0700 (PDT)
Message-ID: <62de4c57-1296-4fd3-8072-ebbb939bee47@linuxfoundation.org>
Date: Fri, 7 Jun 2024 14:16:34 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] kselftests: vdso: conform tests to TAP output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Colin Ian King <colin.i.king@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20240529072454.2522495-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240529072454.2522495-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/24 01:24, Muhammad Usama Anjum wrote:
> Conform individual tests to TAP output. One patch conform one test. With
> this series, all vDSO tests become TAP conformant.
> 
> Muhammad Usama Anjum (4):
>    kselftests: vdso: vdso_test_clock_getres: conform test to TAP output
>    kselftests: vdso: vdso_test_correctness: conform test to TAP output
>    kselftests: vdso: vdso_test_getcpu: conform test to TAP output
>    kselftests: vdso: vdso_test_gettimeofday: conform test to TAP output
> 
>   .../selftests/vDSO/vdso_test_clock_getres.c   |  68 ++++----
>   .../selftests/vDSO/vdso_test_correctness.c    | 146 +++++++++---------
>   .../testing/selftests/vDSO/vdso_test_getcpu.c |  16 +-
>   .../selftests/vDSO/vdso_test_gettimeofday.c   |  23 +--
>   4 files changed, 126 insertions(+), 127 deletions(-)
> 

Sounds like this series is converting the test to kselftest_harness
and the commit message doesn't mention that.

I like to see the commit message match the change being made.

thanks,
-- Shuah

