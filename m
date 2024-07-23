Return-Path: <linux-kselftest+bounces-14086-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F9993A436
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 18:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D50B21C1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF552157A7C;
	Tue, 23 Jul 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="INgrZ5G3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CA7155A47
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 16:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751476; cv=none; b=rmX6EEIkAaCDuSgViFpgq8zD8JQbBmm9dHP4a7d0gqUN1AumkQiELuM0Y9k/55wrWPaZGo1qI6MhYPuOEXvpP0AIOOsUIbWjPmPbc7UvfmZSYYGE9WdrKcF63ZfLnHYP8B/vw7icSQnho0iT5GQkYGMP8+R2vKq8h+TMG2fiv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751476; c=relaxed/simple;
	bh=pRoaIDicTrBMV9Y8Wv8cr1leg4UK4r11oJkILZ4HRMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i+2kxmGR0DARu2g4+2PmwdzTsIQuSiIiXV0s0cG+JOkNT/qjoj6YR9VqwDpFHzunddzeOj7tjpk6CltVKE7c2Ss1jqIjT/3bc9BwSHPGOaOM5oBW/9PMrN5R+WSAS69jDffWmTt8w1ggLtm8BHu0M/Vz/B5FvwuG+90Zm8TmNb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=INgrZ5G3; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-8045e14c32bso28839439f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 09:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1721751473; x=1722356273; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WckdgsdVKcnunHrXHx3KQ06hIGXGwaXg2AXB5/rozpI=;
        b=INgrZ5G3MlqZPolW3fZmc/ZD8lCzUs19XEKaW3sLba54zG6u+NZL/LOlGoky5nTiXi
         BEpx6C3Mns+v9WNkksY5Rwb0u0H5YQxVbmQc+dNM8Gf99NcZ5W0ugmQ5tKT4iT//Bzkk
         oi78Xto9/eajIXQRWUX+kXOtGnb0WZ7y9cpPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721751473; x=1722356273;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WckdgsdVKcnunHrXHx3KQ06hIGXGwaXg2AXB5/rozpI=;
        b=EpkDIm5iTMmW9oup2y9eDdpx/6kWbEu/JfEIU96s8mUrv4Vu6HdyktzluM+WmXYoe7
         pl6hAMnu6gz43FNNkK7p6v8COvDN5K1oaAeIW3vfj8U4qLLbaH/rCEixgW7XkO9zz9fz
         2dx00TZt3RD7axDCjOmzkpBXBmP27EFexHS0yFSMsPWpmPVGy5eMAyhjK4fr7FjB14uc
         2bi2NlOfZBBOwgTTZ80d4u+Wn+RaZ026dkZ+wIOg2WdQulbBviBhWcoaH/kXSUMQlSvA
         V/lQhCLjNdu48RRs8jbUmm3HxEli0yTd7gyAirtsaQnhCqk7lAAb5tx4rTDT2BpSw6zQ
         tFWw==
X-Forwarded-Encrypted: i=1; AJvYcCWLsRgfR4+3Ve+VXH12y/ilxlTy5uP5HARhOI2FNAP2lDRsFePo9KQmGyGVY7ZPXDKYFpeQY1OKh3OLx1BTJfGHo6LgncyKsg0pwbLIHAae
X-Gm-Message-State: AOJu0YwvqnpxXGNFyQMiwonLANuMutzEfwyV9xo+VVoa6gJpMeAyF3D5
	Bg2gx7BYRCjRP5SfE6CQGHZ28zcnsbPlnZNH/yD4WEO/P/GJoeuJ/7uSUmVci0A=
X-Google-Smtp-Source: AGHT+IHBJf66ztYfZNCfxnbGx4Z5m41bRmi5L58frY1Jq39oLN0lrAUqTLUc3qwaGE+1ZaBYXDKjOA==
X-Received: by 2002:a5e:c746:0:b0:7eb:2c45:4688 with SMTP id ca18e2360f4ac-81aa70732d9mr633081739f.2.1721751472896;
        Tue, 23 Jul 2024 09:17:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c276c03bb6sm447490173.93.2024.07.23.09.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 09:17:52 -0700 (PDT)
Message-ID: <9009f4df-ca7e-4961-97e4-446afc4e87d2@linuxfoundation.org>
Date: Tue, 23 Jul 2024 10:17:51 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: ksft: Track skipped tests when finishing the
 test suite
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org,
 nfraprado@collabora.com
Cc: gregkh@linuxfoundation.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240722154319.619944-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/22/24 09:43, Laura Nao wrote:
> Consider skipped tests in addition to passed tests when evaluating the
> overall result of the test suite in the finished() helper.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   tools/testing/selftests/kselftest/ksft.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index cd89fb2bc10e..bf215790a89d 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -70,7 +70,7 @@ def test_result(condition, description=""):
>   
>   
>   def finished():
> -    if ksft_cnt["pass"] == ksft_num_tests:
> +    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>           exit_code = KSFT_PASS

Laura and Nícolas,

I saw both your emails explaining how this fixes the problem in
a previous patch.

However looks like you haven't see my response about the implications
of the exit_code = KSFT_PASS when tests are skipped.

if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:
>           exit_code = KSFT_PASS

Let me reiterate in case you missed it:

There is a reason why you don't want to mark all tests passed
when there are several skips.Skips are an indication that
there are several tests and/or test cases that couldn't not
be run because of unmet dependencies. This condition needs
to be investigated to see if there are any config options
that could be enabled to get a better coverage.

Including skips to determine pass gives a false sense security
that all is well when it isn't.

So it is incorrect to set the exit code to KSFT_PASS when there
are skipped tests.

+    if ksft_cnt["pass"] + ksft_cnt["skip"] == ksft_num_tests:


>       else:
>           exit_code = KSFT_FAIL

The logic here seems to not take into account when you have a
conditions where you have a mixed results of passed tests,
skipped tests, and failed tests.

Please revisit and figure out how to address this and report
the status correctly.

thanks,
-- Shuah



