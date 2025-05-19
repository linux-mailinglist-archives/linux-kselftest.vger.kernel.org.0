Return-Path: <linux-kselftest+bounces-33316-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADBAABB6A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 09:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF203189596E
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 May 2025 07:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 060DF26981F;
	Mon, 19 May 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjqEAHZP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC641C700D
	for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641539; cv=none; b=UEOMOLMxuazlGMDXTMw9GlpjLZiAD4AySzDDOMhh1Lkx5rdh0gtpVIMOf7snXjRMbvzlo5bBkHCkSfE5jxAu1Ayr3avkkT536nNVtOnIG6h3voiROO18DLcMqgP/lrBBGkzs/XC8WJ037WR4ROwkvDujne/6SsIIu0JhrJqmSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641539; c=relaxed/simple;
	bh=EbuXgYNC3YkFJf7lalZRaDMyCovxN1m7vKdcLXMkKvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXUMYnGqRD3i7i/YD6qg+VDvME0Azs5fEVKjZgFMpAiMqYFD/vLatdZqw62PXVX2gmhfW19GrgX5GL4Fgh7znyeInj6MJLGAt4wxpx9ElkhTVD6fMZ38JXgSZeIV9iY8s1G73xkoFBqDRIt0z84lEHVbp4U4JZxaQZ+H6jWMKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjqEAHZP; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-30e93977f7cso2401536a91.3
        for <linux-kselftest@vger.kernel.org>; Mon, 19 May 2025 00:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747641537; x=1748246337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RpvLkghwnQ67hxohbUA8tW0bPeYjdTkXfUPxTmszPjA=;
        b=pjqEAHZPFWVHNAdv6FMGmafDTy0xGenR1ALVWIGz3hfVOX4XNHdR5eyUahQXHvd5g4
         58S+U/8/OBBelhoagMieZkTN11U+0m50AVttxp6BIUkKmM2U+fuxsFYsLCr0cS9kP8yA
         R0TT7y1HobZvWqhGbA/nunq+uhD2FU9rt6VEP/KK5RI/Rewu37kykoY/mFU8FqT593z9
         PspSiXr7m7gyCjkjfu8dhVJH8GSKZ4TpBvu+zbDPzoTsgy/8QSwjehDszDik0qz6biYG
         k8JGdleMV5+nmS38Ya48/Y3Jug/S4vQFM7nDCToHleRQas3ejDgraHFwxKkH+t4dWGcn
         ZW6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747641537; x=1748246337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpvLkghwnQ67hxohbUA8tW0bPeYjdTkXfUPxTmszPjA=;
        b=uVSizg19XvI//2/cBrx0TZKQEJrThuM6bW8z0uRwaVa5hNMJN5D3i3mS+yQz5u3nbc
         k155opvX74/M5v9fFgw4Et1fFw99gw5eZ2lvnuZlJRpWbgJi2TApcfPAogKXnVmnh+aD
         OeR92ejjyCfWdBEXmF1nJ80K5xrZNcwnWoS3CTpJjC+j6jSV2Qqav70diUjb/+lpCr9L
         AxDEz1S9ggUDvcbGFiERzjFpbe39uBtYVlHtFA+gTgRtOMvICwvVqWc1KloSkIAo7fI/
         t2V51vhK2z9SnWm1beTkpLHe1oijPWNVY8XjBxD5o4wWjUZAVPPGeJvE91s9pnixaxJF
         J28g==
X-Forwarded-Encrypted: i=1; AJvYcCXNn8xZJgS7f0Co1NGkn84EAEa/Nx5EK1PrD+f6+XGOhLXx5BhbgRXt2AP8Si5qs4lE191/d+cg/WyRgoN6CgI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNw0e5xVz7KZKv0uhPcZeXoP62fBJQu0itYmYRtg7Tzkm3wOSR
	omm5r9c1UD6c2YATTWKLVmUxjQo5kLkkBjdmUP9EP36pT5Wq/t12DwhPPmPsf1dU0kY=
X-Gm-Gg: ASbGncsinrXHGMROJwntwMjlMwh7eA29MkJbkBhEuL4xQh5vXjl+cH05wQgmCU1Iroa
	C2NzdLxJM/RmgI3Wu8C4jj+TNPrY2m5vR3TBeC5akiMO1zEbqT43a7BuRcW6qe2CU/F8SPtc7M3
	RjhsfPqfG8u3Eavisi5wupgQlM3rtbJVfEXa7+rUG2+P6FoJWlCtEoq/fpG3FNMSGa/UcOJluUm
	i7ofok12ZCHfkxXHNoYlmNGkO014xxThZZC/OlIH8QyfPw3H8W1YJjkLHjAfAUq+nzan4JyWF3i
	nKmv/+uF9iMiQGHTQzjDMlZCJZJTnNxmoSlJrZpVmaozd74QZ6jg
X-Google-Smtp-Source: AGHT+IEZ6YoOJYJfcEn2EhDcAyO09w38EVkyVoz32suEBq8tkoBJ0tXmq87v02CJgG3P6opbs6/Fyw==
X-Received: by 2002:a17:90b:4c08:b0:30e:ee6:6745 with SMTP id 98e67ed59e1d1-30e7d51f9f0mr20343707a91.10.1747641537491;
        Mon, 19 May 2025 00:58:57 -0700 (PDT)
Received: from localhost ([122.172.81.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e33451984sm9685833a91.23.2025.05.19.00.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 00:58:56 -0700 (PDT)
Date: Mon, 19 May 2025 13:28:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Swapnil Sapkal <swapnil.sapkal@amd.com>
Cc: rafael@kernel.org, shuah@kernel.org, gautham.shenoy@amd.com,
	narasimhan.v@amd.com, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/cpufreq: Fix cpufreq basic read and update
 testcases
Message-ID: <20250519075854.opnlhjlbybrkvd2k@vireshk-i7>
References: <20250430171433.10866-1-swapnil.sapkal@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430171433.10866-1-swapnil.sapkal@amd.com>

On 30-04-25, 17:14, Swapnil Sapkal wrote:
> In cpufreq basic selftests, one of the testcases is to read all cpufreq
> sysfs files and print the values. This testcase assumes all the cpufreq
> sysfs files have read permissions. However certain cpufreq sysfs files
> (eg. stats/reset) are write only files and this testcase errors out
> when it is not able to read the file.
> Similarily, there is one more testcase which reads the cpufreq sysfs
> file data and write it back to same file. This testcase also errors out
> for sysfs files without read permission.
> Fix these testcases by adding proper read permission checks.
> 
> Reported-by: Narasimhan V <narasimhan.v@amd.com>
> Signed-off-by: Swapnil Sapkal <swapnil.sapkal@amd.com>
> ---
>  tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/cpufreq/cpufreq.sh b/tools/testing/selftests/cpufreq/cpufreq.sh
> index e350c521b467..3484fa34e8d8 100755
> --- a/tools/testing/selftests/cpufreq/cpufreq.sh
> +++ b/tools/testing/selftests/cpufreq/cpufreq.sh
> @@ -52,7 +52,14 @@ read_cpufreq_files_in_dir()
>  	for file in $files; do
>  		if [ -f $1/$file ]; then
>  			printf "$file:"
> -			cat $1/$file
> +			#file is readable ?
> +			local rfile=$(ls -l $1/$file | awk '$1 ~ /^.*r.*/ { print $NF; }')
> +
> +			if [ ! -z $rfile ]; then
> +				cat $1/$file
> +			else
> +				printf "$file is not readable\n"
> +			fi

What about:

if [ -r $1/$file ]; then
    cat $1/$file
else
    printf "$file is not readable\n"
fi


-- 
viresh

