Return-Path: <linux-kselftest+bounces-23454-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF49F9F51B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 18:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E01B2163088
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Dec 2024 17:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4838A1F543C;
	Tue, 17 Dec 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hjpPef0l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D821F6671
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455297; cv=none; b=mMCNQfHGDy1m3TOHJq/CFqOpchwLu/j+7rqHMMrhqzpJCuX6zsfMk1lXJfp9+Jvt3GHv9LZlTf7ZYXLAOBymBgsBy+KRVgbtyTancSHNEsJ02nxPi3JbMhOG8rbsblDEsgHYlLiHB+g7yJAe6B9zTvBO2WaLKipOTN0+YKPAGE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455297; c=relaxed/simple;
	bh=S6v7WSivSjBUez5PTCTh16YSRYv6qadD4q7B0AooY9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LAkrWy1V/mRbaYQR25hH8QjNDCMY+RYDEyluIrLstff9cTOkDwkWWXwcDahBgWoMmkSR5tpgJ7P5j6afG0s/a02AygwoUwWpOjJiqiULKugILYwGq64QpC7d5k9WnONe87vp+XdOXoUZZ05RzESgvgGyGcTB4JZSJpM4oL5xaWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hjpPef0l; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a777958043so18668175ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 17 Dec 2024 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734455294; x=1735060094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KKFj36ds5zWF4MA+dLgI3GSVqGF0UVLm3yTW7/ZJ33o=;
        b=hjpPef0l8a6iq+p/fsxYmAGVhhQkd7+kmCfkv5WliePBYtK8cxo2S5lMrC5WANqpj+
         wQHTPxqj/hmml/q6iN4/ZoQHFbEWcKeKUkf7e8o3/2Y0JDTM/aYg7dOG9ek/Tq9fqPY8
         FXLvU7I09BsSY7np4GSHmS2P1Nhd0+mSlk1w8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734455294; x=1735060094;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KKFj36ds5zWF4MA+dLgI3GSVqGF0UVLm3yTW7/ZJ33o=;
        b=aEyYqhzEwA1KDacRcCZiMG3keeLknDB4/0sS31JhsJtFF8eaMJJi/HAX7i0xwxAZy1
         K/NgsDSdg/SgY7F2BQxzumgdh+CvLQ5zx0QG2nenX+1pY3VY39oAt269zTtYCAGVWdou
         s6CIiN7I+pogQDf4Iau1rzD3pXmusQUKj7tXQr9Ue5RIYgUIiQ9fn+2seVnniF3Vdnr5
         PQqDQfPuXQyOtZzX7DKzT5JoElm3HRHDhMvw0wlZaD9TDVdtiCvZ/cXkzLxsVFqInA0m
         5pjeGIXqpRswEnte7ot2EuETZ9OfxLZg5rsXDuKuT+DxBzUVn6j78C0W7+x7w1s46D6e
         cIIw==
X-Gm-Message-State: AOJu0YxgFRfwgh7KCrWEyHpaHqq20j/aukcTqR8fAJb+AI/gjDSg/8wN
	+Is1Y/mnkp/CftMsRhw3fNiAcQFiaQXWuF8PaU9/oGfh28Pp0DT/wDGwmr7kXGk=
X-Gm-Gg: ASbGnctbRLh8pFYfybba/zL8QNZiD6eonaiG6gRrovXIYyN2IqiuPilMTBxgqeaiZKw
	iI2/zULy2svcuuiWWXsyC8znw/m9AsAkPKAtUz7lSSJTdDa9NmeN/0s/TzAFnp4znatrdnvfII7
	ZHtyf2a7JVOdzpUW4wmExF0V9RnGcyUXPkP23/CE5pwUvN2yb0agnFuvkyklosMceS8JDLSxuFx
	xSkIr4fYiX4WbIRpyGugpWN4HlnvdmafkQsRNl1I2cWA2mLahrCVYQUbfG1Xzgo7VJ8
X-Google-Smtp-Source: AGHT+IHBZO4CyjBa0QSKmLGcO5i/oNBDAGxpfIe8iEXVZ5M5jCAf2CDCco9lHuxZFTxebBDMOz4lDg==
X-Received: by 2002:a05:6e02:1c86:b0:3a7:8270:3e69 with SMTP id e9e14a558f8ab-3aff7f1864dmr159436775ab.15.1734455292884;
        Tue, 17 Dec 2024 09:08:12 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3b24d9d2d5bsm21905325ab.73.2024.12.17.09.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 09:08:12 -0800 (PST)
Message-ID: <a498d632-3ca3-4658-8300-59d2110274f2@linuxfoundation.org>
Date: Tue, 17 Dec 2024 10:08:11 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: acct: Add ksft_exit_skip if not running as
 root
To: Shivam Chaudhary <cvam0000@gmail.com>, shuah@kernel.org,
 abdulrasaqolawani@gmail.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210123212.332050-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241210123212.332050-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/10/24 05:32, Shivam Chaudhary wrote:
> If the selftest is not running as root, it should skip not
> fail and give an appropriate warning to the user. This patch adds
> ksft_exit_skip() if the test is not running as root.
> 
> Logs:
> 
> Before change:
> 
> TAP version 13
> 1..1
> ok 1 # SKIP This test needs root to run!
> 
> After change:
> 
> TAP version 13
> 1..1
> ok 2 # SKIP This test needs root to run!
> Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
> 
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
> 
> v1->v2 : Replace ksft_exit_fail_msg -> ksft_exit_skip
> v1 : https://lore.kernel.org/all/20241115191721.621381-1-cvam0000@gmail.com/
> 
>   tools/testing/selftests/acct/acct_syscall.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/acct/acct_syscall.c b/tools/testing/selftests/acct/acct_syscall.c
> index e44e8fe1f4a3..87c044fb9293 100644
> --- a/tools/testing/selftests/acct/acct_syscall.c
> +++ b/tools/testing/selftests/acct/acct_syscall.c
> @@ -24,7 +24,7 @@ int main(void)
>   
>   	// Check if test is run a root
>   	if (geteuid()) {
> -		ksft_test_result_skip("This test needs root to run!\n");
> +		ksft_exit_skip("This test needs root to run!\n");
>   		return 1;
>   	}
>   

Applied to linux-kselftest next for Linux 6.14-rc1

thanks,
-- Shuah

