Return-Path: <linux-kselftest+bounces-17850-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE02976E72
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B7A2B234DE
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Sep 2024 16:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713FF13DBBE;
	Thu, 12 Sep 2024 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hhpZfSVm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15FA1EB2A
	for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 16:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726157409; cv=none; b=PpLM44K10IlmQQsy00Vzemd12kDVBkr+gn5hlPps0qCH2IRDnNb6NF/1zvyKbrAP8qIHjCp78ozr/GAUYpJ0RvhEbrHLcrWmXe+c8mZIMlqID+SnUPbgTbbOpJrlvXAqOTHxrgrRlJGU/bW+NPZsgx2fqcVb5AmSul+acGEIe2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726157409; c=relaxed/simple;
	bh=HsACV9qkTEWC0gpHuRxcM67abJHmPCw5KrKY8TCaUHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gZ4cp7X0aJEvM80VCUOy4RxWrKdXrwfWvSi/bIOey4tUMiCWhdX2o3i6L9KQBZDoGYoSrL7dJvKw2aKmki0v7yzjukvUHGopYBXudSYqaQc2rTE9CwIbb/fjwHEuSQwxoV7o1/h8zU4Bmgqgm8I+FyMfT6ArRpFYaraIGYPjH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hhpZfSVm; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-39f54ab8e69so7628015ab.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 Sep 2024 09:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726157406; x=1726762206; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X4YRLuNUgSWopISY8++0gxqGMIlZgrgvlLfTtwvHiqc=;
        b=hhpZfSVmYUXHMzSN1lmeEpCLBx5KUudwLyoou+y1JwY3n8kt2niR3lbHwyxLlfle+c
         Nk9HRIO9/UKdUaidROpmLEynDDQDYJ6D0zI+y2XnWAdpGFhR833w7yYBHYhs9Atrj4R1
         LIN+hV55flSPTl093dSbfBmHWoXQweHDCeVQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726157406; x=1726762206;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X4YRLuNUgSWopISY8++0gxqGMIlZgrgvlLfTtwvHiqc=;
        b=mtUDGLfndA5VH0iai99B/oFnfn23klGcYdSZ3sNbVutVS9LJQgw+OddFPwd/cd9PNu
         at6/mbGKhRvLppa1r3e7p1yUCvzInWkLg49mAM1bsViAuRjtE2QTxM14dckQs8GL+BMr
         iTQswsuIVFiCXnufkYauZNImPV0HPvuYhIo44uGoiq0ZVsyyBL9CnUK7lCXDwTnzDGDL
         1krzQcm0PeU516NPg0v9w7Sc13VwM1FUxRy+qPHekK8ej/UBhnFsCLGesmNiqvZmoob7
         quoAJjU8S4DrrlDcHtUKsTsbVArUka5E1Ah0i2uKeDzAtbRMH/q7941/SolGZGqs70Z2
         muew==
X-Forwarded-Encrypted: i=1; AJvYcCW/tpGZA90A4VG3Qzr+T6KvooieqN++8+LDmxTDx3zS6PKd026tT4aaNxHyaCV5/ppX+8bH1iz3k3dSLHgQL80=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxkj/MinteodjfWiiMqpOw74W6ZKCoEc7geQjfbQbAXzn1GE4C
	0Qk89d7bBl3h9s5Zg9hQvp3PsLrQbqufCWBYTsJ8qyAkri3gR/tRJEXwu/LV4iM=
X-Google-Smtp-Source: AGHT+IGnS9TE/OydSI4yqMHXeq5iZE4Pmnu5pLtOOIdRRqk2ravQJ1hGZCVSj5FbU4ycOavc1l8rFA==
X-Received: by 2002:a05:6e02:1565:b0:39f:5783:fbbb with SMTP id e9e14a558f8ab-3a084611adamr24909165ab.3.1726157405966;
        Thu, 12 Sep 2024 09:10:05 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a059016161sm32481005ab.73.2024.09.12.09.10.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 09:10:05 -0700 (PDT)
Message-ID: <3b700650-159d-45ad-91a3-59fca3019766@linuxfoundation.org>
Date: Thu, 12 Sep 2024 10:10:04 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] kselftests: mm: Fail the test if userfaultfd syscall
 isn't found
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <20240912103151.1520254-2-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240912103151.1520254-2-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/24 04:31, Muhammad Usama Anjum wrote:
> The userfaultfd is enabled in the config fragment of mm selftest suite.
> It must always be present. If it isn't present, we should throw error
> and not just skip. This would have helped us catch the test breakage.

Please elaborate on this to help understand the what breakage was
missed.

Also this commit log doesn't look right to me. syscall() could
fail for any reason. Do you mean to see skip is incorrect in this
error leg? Please see comments below.

> Adding this now to catch the future breakages.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/mm/pagemap_ioctl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
> index bcc73b4e805c6..d83dda8edf62c 100644
> --- a/tools/testing/selftests/mm/pagemap_ioctl.c
> +++ b/tools/testing/selftests/mm/pagemap_ioctl.c
> @@ -95,7 +95,7 @@ int init_uffd(void)
>   
>   	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK | UFFD_USER_MODE_ONLY);
>   	if (uffd == -1)
> -		return uffd;
> +		ksft_exit_fail_perror("Userfaultfd syscall failed");

This looks wrong to me - Is missing config the only reason this syscall
would fail?

>   
>   	uffdio_api.api = UFFD_API;
>   	uffdio_api.features = UFFD_FEATURE_WP_UNPOPULATED | UFFD_FEATURE_WP_ASYNC |

thanks,
-- Shuah

