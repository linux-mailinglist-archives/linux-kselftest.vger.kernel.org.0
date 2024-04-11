Return-Path: <linux-kselftest+bounces-7729-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712D78A209F
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 23:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ECBA1C21244
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F6128DCA;
	Thu, 11 Apr 2024 21:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DccNodpL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDD23D57A
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712869420; cv=none; b=f2y7+GZYhWu4DMvqZBECZ/u4N8XM/LjVXw107O4wxf+taGAFDGvz9ph9Sdj3nRayq+D+z2xIP/7IRbB1pN6u8kklFWm7gu8evYUnykX0NACvnxIK4n7xMJgdMGzUvVVgOHBRy6EeRS7N1vpLaRanoRQuQjz61lH9NTTzTyfWJFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712869420; c=relaxed/simple;
	bh=USS40zQsBMhtx3Ma6IF6kBjkQLS4UZzF4Q8diqd0fBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvLndY0b1v1M9NSGETNlA1kKcH+RKIvSxamUSUgaZD6uhbksluS71vGHtuGUQtEzrmtuHnjkDuWZSL6EAxFAJlJE3TBFbhsp+yS3MTRhr8ZLdJ3DcuxoN01tHjdDz+1ywSx9Kzt8JGtsyUh31uuSZehyXYfhEuGra/H/gK+RwYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DccNodpL; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso2869139f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 14:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712869418; x=1713474218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKSNhAEAUoGr18OfXzKlJNw9tSZ1pFsX9+MsxZurOGo=;
        b=DccNodpL1nCZSZFcDj776zauWCm3gS/MmS9z49DddHaoIKA0Gam85vX4B3Bqgb+3i0
         UD0CbvB39icRexDOmASqdhPu6gOrd3WDUdaHqt7+EL8kc5ih7a6OhTPLTdtYxooyovmo
         2nZaHK39Y/jGe9nLP0r3dsRfUCHIJLkZw/X5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712869418; x=1713474218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xKSNhAEAUoGr18OfXzKlJNw9tSZ1pFsX9+MsxZurOGo=;
        b=Jtog3tY1F9dMB4Gr9cZqZB6JQU4fI5zsa/N9dB6TPkg+kLMQGCe+uieFXrjHpQxT+H
         /2dVlTRZtEKkzbuYect/Gcv+cvP+EbhL/lu/Lp/YZbUirRaYEWATTnXId7xCb+IjpZWS
         EdR2cPN+O/sLACic0zL0AZdtIH8Dq4sDueM5q1oCkfadcvrnLg/6LMel7R9HZqAwR6XR
         05hHDOBfbQGbvg5QLaKoUctGaomctskudRjMh9gF7U4sq9ihUjwFQeJrHX53VrHm8i2/
         ILmXmnIa4D9pQPrnlA1oQPSAJktBxhVMpZxOWW06QfjH9MTkMWxlOt2MYZwCUnejv0AI
         /6iw==
X-Forwarded-Encrypted: i=1; AJvYcCVUVHrQd19inXjRumS9q1PCH6scE2i1m947tZqs4ZTHkH3wY80RdALKA4Nj9pFjb4Se63MNHOMwWmsjbKqFQjhGEFndsVU6dSdIdpPlVHoQ
X-Gm-Message-State: AOJu0Ywj6ut/d+6EvTZ7XF/qIgG7OHshvOuh+6VjeJrJ9G1fYCovmimT
	tpWeJIdoflxQgJi9p6i20dAho0syqO7RLb6zMOK5Bfpst+FGkx4oWI9F/tMCerA=
X-Google-Smtp-Source: AGHT+IELOp/nPA0gReoI7Px7Grz+6hiKdJvkUw6ZPqxXx9mOXozDS0Pedvh3eAFaEzum78aI8MgSSw==
X-Received: by 2002:a92:4b01:0:b0:368:80b8:36fa with SMTP id m1-20020a924b01000000b0036880b836famr657225ilg.2.1712869418258;
        Thu, 11 Apr 2024 14:03:38 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a18-20020a927f12000000b0036a3636ec23sm582207ild.10.2024.04.11.14.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 14:03:37 -0700 (PDT)
Message-ID: <c7063a50-4981-4431-af32-07b955abc776@linuxfoundation.org>
Date: Thu, 11 Apr 2024 15:03:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/clone3: Correct log message for waitpid()
 failures
To: Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240409-kselftest-clone3-waitpid-v1-1-2b31e4aaac16@kernel.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240409-kselftest-clone3-waitpid-v1-1-2b31e4aaac16@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 14:40, Mark Brown wrote:
> When logging an error from calling waitpid() on the child we print a
> misleading error message saying that the error we report was returned by
> the chilld. Fix this to say the error is from waitpid().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   tools/testing/selftests/clone3/clone3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 3c9bf0cd82a8..eb108727c35c 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -95,7 +95,7 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
>   			getpid(), pid);
>   
>   	if (waitpid(-1, &status, __WALL) < 0) {
> -		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		ksft_print_msg("waitpid() returned %s\n", strerror(errno));
>   		return -errno;
>   	}
>   	if (WEXITSTATUS(status))
> 
> ---
> base-commit: 8cb4a9a82b21623dbb4b3051dd30d98356cf95bc
> change-id: 20240405-kselftest-clone3-waitpid-68c4833cf5ff
> 
> Best regards,

Applied to linux-kselftest next for Linux 6.10-rc1.

thanks,
-- Shuah

