Return-Path: <linux-kselftest+bounces-45028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB14C3D8CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 06 Nov 2025 23:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4E98188ACEF
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Nov 2025 22:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B0C30ACF5;
	Thu,  6 Nov 2025 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S8g1w3Zw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB43261B65
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Nov 2025 22:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467108; cv=none; b=tMhNF03/medzn2ULqmXzeFOTVg+lXP0TXvir83tgKcYimVwOni7waJreQfMzlRB7k+JzDoVFlNJWB51xDPdMoeKuHqVxS6oqhW6AaiICd4DolzeAARpukW9Ok7ZXd9lWr6NhCxHiVht2a9lJO16ihswbkvSBt7OlrAjpaPWQsjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467108; c=relaxed/simple;
	bh=Bi2Yt4Ngg6ixxYQSJNuK/iEuLrWfWoQ6o15OZw1g1Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G2/DvFKhYpRD1T09CbNMNRTM8gI8XKZKJ/vtLofmcOfb1EStrcUDoTSSLSRAcTbwVz/75UATHVyRjKkZgzvkNmqziNdrr1flIcek6AuU/9GUjn5068PdUv4npblb7SzckioCHwf1xMDruwnM4hORjJzT57tIFlcectl/+Ai7wqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S8g1w3Zw; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-92b92e4b078so5110639f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Nov 2025 14:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1762467105; x=1763071905; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ABbZOPBq1dfxtSa36L+4dZcBVwYdc+U8A9iGTSp5qas=;
        b=S8g1w3Zw3f6cPXiNKO7r1dH+gLKZmTn6D4FCi9rqXmmJluN3YppE/fUlcUPvrP47sx
         OzHZ86auVoFSMzgBZ8wAYZxqxaDZPZK6xSd0CHdlWKmDhvw5UiZsOypVJh534GQ65Jhn
         GWU/RNUB0h8Sgcd+1To3Ni0kM9AO3HEG1/Z64=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762467105; x=1763071905;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ABbZOPBq1dfxtSa36L+4dZcBVwYdc+U8A9iGTSp5qas=;
        b=cJewigSaAS4CNjYiP4DhdoxSUIeiHM0gwBSOiGijLbsAR9H7XmL59qQl1nD4/ufQgk
         7aPylfho/LZXafcvN4GEIxPxnt/KKSt29NtC+XLXuBsNkul4BG+AhstuqOn+pIL85ShP
         un4i0KMyzP1sX6udsyZwHDG6ZXKhHkym3NpLhC6ZtSpmFf2JKFJ2gC13UNv0/FOQWWCd
         OyVo53QnyMSgGFOb6ULyVT6G/Qo7GLu6uj/A+SGRqwRYCDXPQ1WRN1+/nmo4QDJ4HXvM
         myK0IEi/dXqHrD/pTgQ2uoYXJdbPv5tWNTp0HXJUzRUBSE59Kd+z8cXfiJHzNEHg+Skt
         +XFw==
X-Forwarded-Encrypted: i=1; AJvYcCXrfBfd+qYG4Q1aiXF8bvGlxyS8NIo0ffiEPZWFnjLCst9fov0c1T7vpmnUatwikeXljdtqJ0vzkgM9IjjXCls=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTkyFoG9hEc1NHsbXK9wxr7PAuo8ImVgirDA64Pc8iyOsCVmyQ
	31eM6G7hFBMQg1TllUxGdqlMZIwLL/hnd4RfpVfP9NdE1DQiuq+Rv14arZkeW0sHRMQ=
X-Gm-Gg: ASbGncvi44UHuaigiJ8BZfEtt0fQ252wGCHarA/yKqCYo1FlIsWlrdZzGLDHuhXadEv
	vKI5S+OcgSnN0gKE/XYU10+Jcmk84ef7OTpz08u2OdV8F9Bvc+fQ+M9UX1c+UGxevMp2yj9KrjE
	Fz0OP7+1snkTso1GeF9Q3VlNoR39J6qGddSuBAOfkKHSU1v6asz33Y7ST9mDlm/b3XQFnGjwEVX
	IvnJEwLmQDuQ7QTpeJ76X/mYYxG3nf5FkomOz/tOQG4vpc4NC0/1zfBnQkjyVCAQRRrd+25NB3P
	UpeE2SZ2YLXGI7NeZhIoPAAWE3uYqrjCdckAeqNfP3WVKfQ/crEtuSK8nFnKnnq7bhmVmcTB3UC
	LrjVFlFjg3+mO1ooyF1IguATIM3bfdp3k6TVMqOvOt6vFtsHqw8A1DLcvzaOuWWw3Q8u2lZy3Rp
	goylhf70Klqo0n
X-Google-Smtp-Source: AGHT+IGkxzH4f9BKMCWmQ5xEz4PiUURagXcKMgKwkO27ppVtMljJUXfPmqbiwiBOR5OWXl+uA2Cgtg==
X-Received: by 2002:a05:6e02:1947:b0:433:5ad1:6c69 with SMTP id e9e14a558f8ab-4335f42e51fmr20094685ab.17.1762467105571;
        Thu, 06 Nov 2025 14:11:45 -0800 (PST)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4334f45c7d9sm15509785ab.16.2025.11.06.14.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 14:11:45 -0800 (PST)
Message-ID: <787bb77f-4271-43bc-96bd-4e22895d761b@linuxfoundation.org>
Date: Thu, 6 Nov 2025 15:11:43 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma: fix invalid array access in printf
To: Zhang Chujun <zhangchujun@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251104025234.2363-1-zhangchujun@cmss.chinamobile.com>
Content-Language: en-US
Cc: Shuah Khan <skhan@linuxfoundation.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20251104025234.2363-1-zhangchujun@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/25 19:52, Zhang Chujun wrote:
> The printf statement attempts to print the DMA direction string using
> the syntax 'dir[directions]', which is an invalid array access. The
> variable 'dir' is an integer, and 'directions' is a char pointer array.
> This incorrect syntax should be 'directions[dir]', using 'dir' as the
> index into the 'directions' array. Fix this by correcting the array
> access from 'dir[directions]' to 'directions[dir]'.

How did you find this problem? The patch looks good to me, but
I do want to know how you found this because compiler doesn't
complain and I can build this fine.> 
> Signed-off-by: Zhang Chujun <zhangchujun@cmss.chinamobile.com>
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index b12f1f9babf8..b925756373ce 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -118,7 +118,7 @@ int main(int argc, char **argv)
>   	}
>   
>   	printf("dma mapping benchmark: threads:%d seconds:%d node:%d dir:%s granule: %d\n",
> -			threads, seconds, node, dir[directions], granule);
> +			threads, seconds, node, directions[dir], granule);
>   	printf("average map latency(us):%.1f standard deviation:%.1f\n",
>   			map.avg_map_100ns/10.0, map.map_stddev/10.0);
>   	printf("average unmap latency(us):%.1f standard deviation:%.1f\n",
thanks,
-- Shuah


