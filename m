Return-Path: <linux-kselftest+bounces-33527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5DDAC1697
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 00:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65FE13B9967
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 May 2025 22:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91FA26FD9E;
	Thu, 22 May 2025 22:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLda/JMF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184D26B96F
	for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747952512; cv=none; b=RgfzubMszUDO56nutAkw0tqYOJcJU/3dzZKq9W2UhqIjMpx6LmOG/BP9JWF9sPiYegANv7z3MET9scLfs2SdJx43PXpwPUkzqUXe5Lm150Gkns2qKAiayqfvkbjaRp3dcOzXFl1G/aln32+2UTkSR3L0nMheis9PEQy3HdlDS+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747952512; c=relaxed/simple;
	bh=mNIIiTjvtytH4knIqgAqMbf5Ewmg/ZFc64IhbBi3Vdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2GZMLtAb4ZLDELMkjN/z6KcOvg4k2GyDT1PjidBq+6feKQ3tmBM/UdXzFFO697ofscVAYXtrhqpGSmcsA/KiHY50F3uICFGk83snJlebVwNq7tG9svplBGl97ucSe6kRqYVd2TXNQxxXG/2EOdw0t8cs3weku9RuVO3nDBPWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLda/JMF; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-85dac9728cdso279612639f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 15:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1747952510; x=1748557310; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2WumDBboBbqjKrIFNDMqIj4OU2U2Il7ihCN6R/RgGaE=;
        b=QLda/JMFI3WjBb9KwasMKmMhdHr4BqIxvOc3W8ILUuCwERJIOJTJzVlKSvf+RrY88L
         IN9ub/oy0dFYgHO2BlbiYVRMq56wTRxsBR95RAPfPzzzCsW+h0etcCPztwBRHM8KJHS5
         2SC5k2lheCZtm2asAgL9SGJlXNGBuwkxifkOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747952510; x=1748557310;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2WumDBboBbqjKrIFNDMqIj4OU2U2Il7ihCN6R/RgGaE=;
        b=ci29GgXiz8zU7OxK4qBphiMR/VTToy9VRsfKscHp4bX98520QHgj0Rs+GjYjH7jJHK
         KJQJFa6zhNhY7/2l8efxUkylSWIkfn+zs60Y3eRTEew6vJ/qG7rxMeRHol6jQj/ymRHi
         GXGaiEua8tDG7mKuXhLDH5ydZR25cz1L9d5uI5I9wlPRe7wdxzI8LX1hCJop0bsBHwrq
         j10E3qTGXLz2XZSr/QJTIplxdBT8IcoONbQo7T59XFLzx+mhB1y4UgseuRyC8xrrE1fI
         euk1jyZ2rX6BkXIBM8KO27HzvZlZJzrFwyORiSUZVuDSNxX1iQoeUY1ilMaotyLVKoIN
         YWPw==
X-Gm-Message-State: AOJu0YyUp4xMqznNYLAQncbaXmziy38kYx1HRsOGciMAAtQam7a8zmIL
	rWY+Trux+sQVKoOic0rqwV6FDN2suNN6l7J+7zqyUsSM4dz2GRT629Oc9rMmdhKWpm8=
X-Gm-Gg: ASbGncsV/42JaafNbMdGs++6J5gdCB9ZcDdh5LLmN8tz+AEvi7kb8ueS7Wc6zKgs1oG
	rdu+L8jYI8JqEUWwLX4r6Mu/zkZjppQE3wF1d3HqUWxRwyv6uhbbJskAu+uFvbrGiE5gCUCoSwY
	5hKN+9tuLMmI3/sOsd24GdZpksS8K7qitz2+ziA4H3nq1NPWxNqT6OBiew50Y/6TTDoXVxaJMGL
	y96cdTNYFDA/iJfDS1MYEeB3tWjv4HTq4+yn+I/IvPYPYFEJT0BmIGoZW2WIcS2kgx7IuB4oecC
	ehPA8griBB9LrIYICrc2DkTsWa6+6wayiGuF7SK5iP2KbaLfqYDT1IpXqCX4Dg==
X-Google-Smtp-Source: AGHT+IF6i4zqwY+JBhmaF7DvaOm1r/5AaHpcOaVaT1YyrMVNieZOKZaK6Fd3OhODW0J03U/i8rnFLA==
X-Received: by 2002:a05:6602:c86:b0:86a:25d5:2db0 with SMTP id ca18e2360f4ac-86caf0d4272mr132154039f.4.1747952509713;
        Thu, 22 May 2025 15:21:49 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fbcc3b1aa5sm3462066173.50.2025.05.22.15.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 15:21:49 -0700 (PDT)
Message-ID: <195e5806-df31-4476-bf6e-4c911d261fbb@linuxfoundation.org>
Date: Thu, 22 May 2025 16:21:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH] Change pidns to pid namespace
To: rodgepritesh@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250516164902.91085-1-rodgepritesh@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250516164902.91085-1-rodgepritesh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/16/25 10:49, rodgepritesh@gmail.com wrote:
> From: Pritesh Rodge <rodgepritesh@gmail.com>
> 
> Changed a comment in memfd_test.c , Unabbreviated pidns to pid namespace
> for better understanding .
> 
> Signed-off-by: Pritesh Rodge <rodgepritesh@gmail.com>
> ---
>   tools/testing/selftests/memfd/memfd_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
> index 5b993924cc3f..4e4c46246a4e 100644
> --- a/tools/testing/selftests/memfd/memfd_test.c
> +++ b/tools/testing/selftests/memfd/memfd_test.c
> @@ -1359,7 +1359,7 @@ static int sysctl_nested_child(void *arg)
>   
>   	printf("%s nested sysctl 0\n", memfd_str);
>   	sysctl_assert_write("0");
> -	/* A further nested pidns works the same. */
> +	/* A further nested pid-namespace works the same. */
>   	pid = spawn_thread(CLONE_NEWPID, sysctl_simple_child, NULL);
>   	join_thread(pid);
>   

Please run get_maintainers.pl to find the complete list of recipients
for this patch.

thanks,
-- Shuah

