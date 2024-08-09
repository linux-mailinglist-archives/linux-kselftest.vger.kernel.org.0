Return-Path: <linux-kselftest+bounces-15087-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C27E94D551
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 19:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3A31B20BBE
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71947F69;
	Fri,  9 Aug 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UNzLhwPm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250828689
	for <linux-kselftest@vger.kernel.org>; Fri,  9 Aug 2024 17:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723224052; cv=none; b=MnBt8c22+f7IbITLIheqFskP12y7xL2eYzwY9QonPBAdGv+vlqzGwOjWTsQHcfgpa0mNzRIm2KCrLY+WAsGU3ZkVzv89q9Pv05DRWCGDCzN5SF8wdnzqBYVrLIdkdXYqkHAVFoqdpTkkQy5faGxUxj9GIwESIep5inM9i/57sWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723224052; c=relaxed/simple;
	bh=VX0GHmStDkrYMdFhonCa5iBMpED55dhUQufG4AGVFbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hCJ0xZSd3MeIUNLiOt1W7stL0y+dR0VnNMUJr/i8tApVTPUl3OPtckYCAgFiSbQVontn8teC5vYl5wOxMJhQ/s0vMOSFtSQZMs3nHLMBJIruZ4rPOB141HWBfrvQL44tMoweLdQj08Bw3Asb8rdzAkE4f1ZbduUyoVe5ldJyOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UNzLhwPm; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-812796ac793so8430239f.3
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Aug 2024 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1723224050; x=1723828850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0VlmBrSrKPI0nvLOBL3lacDzUDCnPoKiOWhQVarU+s=;
        b=UNzLhwPmbH71csQ4hTt2BRT2yjrbaD2HoXPdX911ai05lPTjOpkIiex212lLVMRTtv
         9XrODhQfbY1qETG1anDW5GVgQdNcpDliw465t8D1+n3qmmHHGdC8foXVLmxA3dR6/VtI
         4EWsDLe6OSlbYFvWXASZOuUDqL912ab9ce9nU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723224050; x=1723828850;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0VlmBrSrKPI0nvLOBL3lacDzUDCnPoKiOWhQVarU+s=;
        b=wy7J4o16hhAdtYJQrcMt99qg1WT14wefCCFegGTMsCcZOJE+0McaEkFKecSL7D0eUp
         bF2HFj0yZh7Ptuvs8BQUkRekwwEREl3nLi5k3inFGv9yEGLhDO7P8CA/TxeyPQhfx4OI
         GqDMebeX3CL3fqp81THSaTk5ZPg6ZTcwNqf5KkIYUNh/ss2GptolKKdRltbT9yCVch6r
         bVDshvpqrLf1rY2oY9iAaIkHQZF6tnHYYFeXzDVxbtZansEj1ssrJVGV7cXULV62UHVL
         j+Y6eBzEXIpoRW8Ln1Ma59RSscICukiWnUISH3XsPmdQyz2PHTY2ZBvsh5vNbk5CgyJr
         kKEw==
X-Forwarded-Encrypted: i=1; AJvYcCVDnFS+pXDlyPZtA63zRGmELp3NqaMc8/bj/3ONN+1O0dr3KbAzHIr8Qjb4ZE19u8JBVh1T4S0Pi/4GNEENTTA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywaew1ZEkA0bejJppu8A9CAhhIWy/Y4Ku9CUNrQtaBihGw3uyxS
	6H/YlOOzeHTfqnP4YINTjStHoD14TAUIxccc+SKOQ+8KNJpyjIVcwjkd+7rrV4s=
X-Google-Smtp-Source: AGHT+IFCIxawOy6BLCebkOf6m3SU/t1bf8oP/2bn7t0rnS01Eibjkom6BbLknNPEfkJ4Vfow8JDQhw==
X-Received: by 2002:a5d:97ce:0:b0:81f:8f3a:5689 with SMTP id ca18e2360f4ac-8225ecc63d8mr174936339f.0.1723224049926;
        Fri, 09 Aug 2024 10:20:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ca769102e2sm19814173.10.2024.08.09.10.20.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 10:20:49 -0700 (PDT)
Message-ID: <4c709253-50de-45ee-9cbf-8bed65eff857@linuxfoundation.org>
Date: Fri, 9 Aug 2024 11:20:48 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: compaction_test: Fix off by one in
 check_compaction()
To: Dan Carpenter <dan.carpenter@linaro.org>, Dev Jain <dev.jain@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <87470c06-b45a-4e83-92ff-aac2e7b9c6ba@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/9/24 06:32, Dan Carpenter wrote:
> The "initial_nr_hugepages" variable is unsigned long so it takes up to
> 20 characters to print, plus 1 more character for the NUL terminator.
> Unfortunately, this buffer is not quite large enough for the terminator
> to fit.  Also use snprintf() for a belt and suspenders approach.
> 
> Fixes: fb9293b6b015 ("selftests/mm: compaction_test: fix bogus test success and reduce probability of OOM-killer invocation")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   tools/testing/selftests/mm/compaction_test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
> index e140558e6f53..2c3a0eb6b22d 100644
> --- a/tools/testing/selftests/mm/compaction_test.c
> +++ b/tools/testing/selftests/mm/compaction_test.c
> @@ -89,9 +89,10 @@ int check_compaction(unsigned long mem_free, unsigned long hugepage_size,
>   	int fd, ret = -1;
>   	int compaction_index = 0;
>   	char nr_hugepages[20] = {0};
> -	char init_nr_hugepages[20] = {0};
> +	char init_nr_hugepages[24] = {0};

Can we exceed this limit too? Can you make this a define?

>   
> -	sprintf(init_nr_hugepages, "%lu", initial_nr_hugepages);
> +	snprintf(init_nr_hugepages, sizeof(init_nr_hugepages),
> +		 "%lu", initial_nr_hugepages);
>   
>   	/* We want to test with 80% of available memory. Else, OOM killer comes
>   	   in to play */

With that change:

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

