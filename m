Return-Path: <linux-kselftest+bounces-27180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 158C6A3F974
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB25A860D18
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Feb 2025 15:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF7B1E47A6;
	Fri, 21 Feb 2025 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtPhxIaQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887C21E1C36
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740152796; cv=none; b=uYix2yQKD4ScSyAX9ypUZaUaxrE5EtgUvMfAtqYtPKAKZ1O5XJhqIU61FYZIy9K6pLRoy9Ydx0UqMrpSC6Dycd9xGE76iq1MxXrNatH9KDaIi2DuokBF68GlG+/hkMEtPU7cmOuGtqhyfGsqdyb24wHybDaYv60p06MPlAtcOSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740152796; c=relaxed/simple;
	bh=WBcmWGrMeB4GHMlv6u5IaHPt74W6BHCLh+gX5YUMXik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSBBqD6uswuzgPUOaI5TgJnFORgrhU+gIeEfmMmlmK8Npa8rEYx/7/R7AGBJG9xHIxf6YNooCbQGf9WkyPiZg6hgs4oEWYa3XZRmwOwM/nhW4Dw6NWvOAoHRrZs1T+zR8P94aWefWqqK9+AIfA7FCEta1OslYX9bfmhxC/UdclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtPhxIaQ; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-855bb9fa914so61282339f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Feb 2025 07:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1740152792; x=1740757592; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NBiYF95UsjyWdAhHtcE9LoaRvojgCkUDYAXBAvVvRiE=;
        b=gtPhxIaQu+jO8yh2mJqNJRuxkLw1LHsQQMQ57D/lMBLDh31CcfzeUXm1smB35JVIUd
         sY4kwcRbygz5D87nD6q7NRro8wnZRQZqOgjC0GekDy3F33o3uSyWvTnbCW6cPCARSAYd
         zKDq3oE55+HGBGOAiq+692u21DNFgv9HiWyb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740152792; x=1740757592;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NBiYF95UsjyWdAhHtcE9LoaRvojgCkUDYAXBAvVvRiE=;
        b=WZZSGHs2UGS1UNcJSyYQDghkxYS2APBU2QIp3wGlDMi9CNF0F84uyCFiQouuLTE3Tt
         NP9spSCEls3s7PSCHV22HOrPC46hQX2NuOr200XTqAn7ACPUvh9RWEwNOWVbltiKnHLw
         2/fCdrK7ZGQTYU0hlZRE1B2QaK+qqjRZj8fnB9sqVI4hH44Cm6IuRfEklGL3iEGBggoj
         ZVy1CKhpdpH4BdBe5ajngsbHNp+032sOp75LJoVH/PyRLWXxw5fmk9IzMIzz7FkwcMxj
         xTCJipXL10JLci2ttD7qAqvuQ4VfpK/uv9sijyWC0t5+pGE3JCb/sfa7sTjTHl/XRdt+
         QpwQ==
X-Gm-Message-State: AOJu0YwA9hu80wZkCY1yGAqjL2GBD7trtLpeOopxXkjpOs9UY234xUPY
	VD7Yq4C+hGaxFIxvXetA1sRca1IFjh1bHa3kXYOvoSMRdk1Ovn6YWTuHVGnjfC4ZS7goo1mU7WR
	7
X-Gm-Gg: ASbGncsc/Qn/7CgaH4vZPTBg0vBQd6xF137WfA8Kyy6efQoWFzIdloXCAKyTagY0A7C
	3AUY5JItL4YkeJhBZ89zljFSC84U0sExlebRV0c4LnYanA5xiJpjkVZG01tbBZrgjG+p7BcpJvW
	pC3rjgwYrzcUTL0500FTsjW1UdTKBbu4IjJZLWVC57KwBkTvDzrmmvZdqsDM86cHz/waatahZgw
	3hdxRtcmnAS8IyGqepOEufJdL7BRvPb4S/WL/qySrUGQ0/w5UE5Xp6jHQG1Y3FfH3ar4/c9LsPW
	agM7g7mNMS+DRtIBZHTiilpHKFxwadv27+FX
X-Google-Smtp-Source: AGHT+IEga5vn53JmlL3d8Oi0yyIj7dh/m2xR1iBFPscuiMuFWIE4D6fI6Y3cq/aGDee5PHEi6Nlu6A==
X-Received: by 2002:a05:6602:6004:b0:855:8f17:cd8d with SMTP id ca18e2360f4ac-855dac41ffamr424960539f.14.1740152792517;
        Fri, 21 Feb 2025 07:46:32 -0800 (PST)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4eea5b25cafsm2158929173.118.2025.02.21.07.46.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 07:46:32 -0800 (PST)
Message-ID: <b62b6dbf-eeb1-495d-a86b-38f05a17d60e@linuxfoundation.org>
Date: Fri, 21 Feb 2025 08:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/user_events: Fix failures caused by test
 code
To: realxxyq@163.com, shuah@kernel.org, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yiqian Xun <xunyiqian@kylinos.cn>, Shuah Khan <skhan@linuxfoundation.org>
References: <20250221033555.326716-1-realxxyq@163.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250221033555.326716-1-realxxyq@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/20/25 20:35, realxxyq@163.com wrote:
> From: Yiqian Xun <xunyiqian@kylinos.cn>
> 
> In parse_abi function,the dyn_test fails because the
> enable_file isn’t closed after successfully registering an event.
> By adding wait_for_delete(), the dyn_test now passes as expected.
> 
> Signed-off-by: Yiqian Xun <xunyiqian@kylinos.cn>
> ---
>   tools/testing/selftests/user_events/dyn_test.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/dyn_test.c b/tools/testing/selftests/user_events/dyn_test.c
> index bdf9ab127488..54c9412f8dee 100644
> --- a/tools/testing/selftests/user_events/dyn_test.c
> +++ b/tools/testing/selftests/user_events/dyn_test.c
> @@ -127,6 +127,8 @@ static int parse_abi(int *check, const char *value)
>   
>   	close(fd);
>   
> +	wait_for_delete();
> +
>   	return ret;
>   }
>   

Adding Steve for review.

Steve, please review the patch. If you are happy with it
give me Ack or Reviewed-by if you want to take this through
my tree.

thanks,
-- Shuah



