Return-Path: <linux-kselftest+bounces-13477-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75ACF92D590
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 923F01C2265E
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Jul 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D02FE194AF7;
	Wed, 10 Jul 2024 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nzgwyhwa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA68194AF0
	for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720627129; cv=none; b=sZ54fQe2No5CnZBSAEaEXIMGwzT4Qy6i+62tL38QfZAVVrzJ1pdlGElnodX2d123ko9C/W2bDrzVNyNDJmf70iOTbc2NIEIGMvqkQRRQdYYDc62QH+k93u45uPigFeulESQiGHQxRJ+sat8ikcwEg0ourPfXglFVurzECkdcoNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720627129; c=relaxed/simple;
	bh=glBPvWkFzLQfz8TsVq9rjy/MlGkv6G8RoVIA3mtxWlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1f43Jv5cU85TDzgoZjtUEGma9575SuJKMkHm1StHrjV63oSJ4XWnGKi/RX+RcuN1Hzu0Az01u6StHDtXQUAA8f9TXv34JngyeYHufW+mUtviO57HphS7u+4TIB2IqD7j444IhcuT5h+pVUrkw5aM6bNe0Sb9atbH94jxlzLuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nzgwyhwa; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-375f6841f01so2653095ab.2
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1720627127; x=1721231927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=Nzgwyhwa7F6UlS6mYoiE3ZpGLib3s4vnLgvfhseIV4prncIiVFzPesiP0XAPptQNIq
         zLOSjpZQfaZk28IQgpqR/f5Ww1yxIi3LW6tpwOHB1se1JjpEFcJCmK/8CJsvNELnBv4r
         n4mWrVBf5PWcNX3ARwdVQ+0/flTyeF1aECJMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720627127; x=1721231927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fGy2kaPZRr3hHhlJ6VMkV6cbieMFPeP7bwQHrR7G1rM=;
        b=reOLjuBvNwo3gd8fkiPrmfODZbqXavU5hXb7X96IT6Qh0jgsdqqWQBkWlKctMlMJTy
         CHKHjBm2jwuFBd73+Uobf8q9AxNEEd6R5IMm6Sznsa7GFjMJEYj18axufNQ8D2tlVFDt
         r2xM1GLrJjTXYvpAm7D0ZIO1t9OLu3gMx5Cbe/rGJdcapQ9hg+FqS3EmWunsuru03WOq
         kMyaf9krJW/u6QRvgfuQea7DfIQ7TIpFNiafwSFEKJGLZAqpji9A3Qr7OM//cBxbH38U
         FtpV17FfrWu7Oj5LZu1CdcXf776qn6u9dNciFituhOvKNnVzbH7zGA5LjaO8RRHP4d8R
         dteA==
X-Forwarded-Encrypted: i=1; AJvYcCWNcVG8k2szPMwPY0z4fAQfjr7ZqTY33/nZBFW7hoZzvdU1p7Q0DnSP+o/aVYW284P2PsiAuDSsMJaOW/IB/iWELv9hURNyscFAoZ6xRxSW
X-Gm-Message-State: AOJu0Yyl68kXJQxODGfPwYS0ai3RMd/xMDtMoflvtFkus7HSQ/mGrlQ+
	8Rsnep1USbEsNaYxqv5aZaU0byPy99fjSASsfW/uGItFVhsWYReUYZ8kCP0Fi9k=
X-Google-Smtp-Source: AGHT+IEgwRKV9JwE1SccNSo0JaXpaHOih6A9ET3LUZTOXD99a4Jq1dI6/XLx3p/8L3bMkmdBqFqAHw==
X-Received: by 2002:a05:6e02:1066:b0:382:774e:a820 with SMTP id e9e14a558f8ab-38a54366279mr62388965ab.0.1720627127323;
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-38a4b870e83sm10117595ab.55.2024.07.10.08.58.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 08:58:47 -0700 (PDT)
Message-ID: <a3b43a5b-0e32-4ab0-a387-cf58b76525eb@linuxfoundation.org>
Date: Wed, 10 Jul 2024 09:58:46 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/dma:remove unused variable
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, shuah@kernel.org
Cc: chenxiang66@hisilicon.com, iommu@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240710065759.5988-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/10/24 00:57, Zhu Jun wrote:
> The variable are never referenced in the code, just remove it
> that this problem was discovered by reading code
> 
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>   tools/testing/selftests/dma/dma_map_benchmark.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/dma/dma_map_benchmark.c b/tools/testing/selftests/dma/dma_map_benchmark.c
> index 3fcea00961c0..c91b485ca99a 100644
> --- a/tools/testing/selftests/dma/dma_map_benchmark.c
> +++ b/tools/testing/selftests/dma/dma_map_benchmark.c
> @@ -33,7 +33,6 @@ int main(int argc, char **argv)
>   	int granule = 1;
>   
>   	int cmd = DMA_MAP_BENCHMARK;
> -	char *p;
>   
>   	while ((opt = getopt(argc, argv, "t:s:n:b:d:x:g:")) != -1) {
>   		switch (opt) {

Applied to linux-kselftest next for Linux 6.11-rc1.

thanks,
-- Shuah

