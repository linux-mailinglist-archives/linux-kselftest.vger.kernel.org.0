Return-Path: <linux-kselftest+bounces-18673-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADFFB98AB4D
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 19:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 644ED2821DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2024 17:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F16B198E77;
	Mon, 30 Sep 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bTxSPuhM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA2519307F
	for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 17:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727718313; cv=none; b=bI9rfp+a7UqDygNRXhQnbn60FrSDEeJEnGjrdkfQvX9rkrsqXHdtjoDC59pM4GpxwU8JzIkobjMw/GbkyvUUBTJdM/BQHkBeFsJClfahz03IvTw2HyakaUlkLrhboxdnyuuXabOnYN9MuI20sV+xJ6kqZjdO5PsqqMyRD5C5n10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727718313; c=relaxed/simple;
	bh=mGBqYCS7OyQuPHlB2Flvv7OeI94eJbr+qBuIwMcRANc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5ObMpbOop7ApwM19RZTbTco6dV2czWUPwLBbqNdqUH9X7nq1aYQJj4OoYPHbD0dqyAXoMGaeyqo+RbBuJNtdA9eGkI/BspkSewyEUPsaDs5pgiRfMYljkjdTgP3NIbpRhfgK4UfMFuduXTOD1mes4tAoFTIiNoB3DH9hGSQr1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bTxSPuhM; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-831e62bfa98so204386439f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2024 10:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727718309; x=1728323109; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+2u7e3lgoKeeK6xXxcH6uku/5N9HbEKShSq8Rkyr34=;
        b=bTxSPuhMHSQq/CfRIq7kvFb/NkAsFNxjV7l0TBxlVXV3qKFxeToQK7IhE2e/7Y+3eA
         oO65Vhs2crzG7BN1jMawbmqX/vxFF9cfcOkxNYh1qs4BzWCEDPN+fB8gJhxis4lBacWr
         uPmVc/WFYlIuybbU33zv/lDFJE+UnU7xBPIBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727718309; x=1728323109;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+2u7e3lgoKeeK6xXxcH6uku/5N9HbEKShSq8Rkyr34=;
        b=o1e5fPnGqIP563dm/GG8PGLh9OmBPzMpLe3GvITxQc2092iyWQflAzMW/s8h97kVsQ
         r538U+ZIIxm/zV/y18pX59/gSoWMyX8ZiYZC+qu5DS6Q6NoCKAIVwRn2eqsgFS/lFXxD
         1h3Y+sYYd2YzfTiTi7T36Xj4sd1KKo8gQ5OAL2ieEMihHdAIq515osKCybiPw+2LaMTa
         juS8bZG0xswczn121QuPiWqcRB8KL2PlIblM+YQazN0vG2V3bl3AnrcmStJqotHO+hZp
         +19lFo4SD4TanN6NUncxAbwog9CXRIv7apsVmYmXTYDGgSB9UzD4CKqaDIczrdaO8skB
         f7Iw==
X-Gm-Message-State: AOJu0Yy+jqVgEYMJ3kZDYqqrQiqQK35DGOwm318hn2yfJ5EEA9LAHKfm
	nU4Oit2XNbj+CwTLHdPPF9wG72ZOeKwXUz3IPgXSgDbz/HGa0eefkwogyfVO9EI=
X-Google-Smtp-Source: AGHT+IHX9flJ54CPbiETthHWCw7a+a5jQws30YqyYfderS7xWBh+2BV2BeVoCoBRp6NoYbo0i6fPnA==
X-Received: by 2002:a05:6602:6d19:b0:82c:fb31:2340 with SMTP id ca18e2360f4ac-834931e26a3mr863782539f.7.1727718309550;
        Mon, 30 Sep 2024 10:45:09 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888f9d1dsm2216258173.167.2024.09.30.10.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:45:08 -0700 (PDT)
Message-ID: <b1b6a246-8c5a-400e-b085-4ab7ad0c3f5e@linuxfoundation.org>
Date: Mon, 30 Sep 2024 11:45:07 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] selftests: core: add unshare_test to gitignore
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Allison Henderson <allison.henderson@oracle.com>,
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 rds-devel@oss.oracle.com, linux-mm@kvack.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240925-selftests-gitignore-v3-0-9db896474170@gmail.com>
 <20240925-selftests-gitignore-v3-1-9db896474170@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240925-selftests-gitignore-v3-1-9db896474170@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/25/24 15:55, Javier Carrasco wrote:
> This executable is missing from the corresponding gitignore file.
> Add unshare_test to the core gitignore list.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
>   tools/testing/selftests/core/.gitignore | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/core/.gitignore b/tools/testing/selftests/core/.gitignore
> index 6e6712ce5817..7999361992aa 100644
> --- a/tools/testing/selftests/core/.gitignore
> +++ b/tools/testing/selftests/core/.gitignore
> @@ -1 +1,2 @@
>   close_range_test
> +unshare_test
> 

Applied to linux-kselftest fixes for next rc.

thanks,
-- Shuah

