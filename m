Return-Path: <linux-kselftest+bounces-21068-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD649B58F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 02:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80B51F240CB
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Oct 2024 01:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A42712F5A5;
	Wed, 30 Oct 2024 01:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmSbb+mK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01F8770F5
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Oct 2024 01:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250725; cv=none; b=Uof/eEA26SR+QjHseYTgUi5GLgCJN7ib0Ykr9ohbQ3xZ+lsQgehFpVeL0tZaiKGcHV5HOUNz9fkl41LzYWV1SUQNRR4ZVnUfOytw5suOwin+/vRoGqAux20nAA8ZghteHmd9We/Dg/Sa+AjgPqVXhUWMEzX19/4xKReuTmZm1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250725; c=relaxed/simple;
	bh=rkWMe+q7YE91JJSH14RGk9u52F5soEQs+wqZBxWnc0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeluTgFCQReEFvo2Kxagw8/dbbWcjnEWKBMTQNONUHOIgLT0vMo0OWUBslsE3mSl2hgc9rPTWv1/RsRrXUhhB1TQ6N38LclgYaWEyVHUnmiN/TvgIn59meBX7auIXquS3VXFXgmpgoOsCQyy0Sq0NcNWKiGb8LSz8EYubVFykwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmSbb+mK; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71ec997ad06so4413653b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Oct 2024 18:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1730250722; x=1730855522; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQeSwxz5uUvTcfuWV7iXLr/jIgrx+m1N8dA8FAnJTIU=;
        b=SmSbb+mKEY6lOKL2LCn625i1usRBq/OjIy/UL8a7bT2wYgHElgWzK2uPdqM8wDrBBz
         1o+9GvrxydMA/LoFZseIN76Dh0ASf6z22tWtySHX4xZqN5YZKEH/4oW/Wz8oOeamU6mW
         Qdrv1UoUq2PIpObFpO2X0Uie3BNCpbwAt7plw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730250722; x=1730855522;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQeSwxz5uUvTcfuWV7iXLr/jIgrx+m1N8dA8FAnJTIU=;
        b=BdiCd6dQVaJWmeGztHJjeIc+gwuD739DatGUPipnTFcaI2AEidisZg0wZbDgttWsCQ
         MWFhMrswW+2l3v3yAefrM6KOfi8le6TL+zNU9NckJvjzAQUBcida8NgNqtJeLhZPtYoV
         fi4cdGDVnJxAvfdt0YA5AeOoUunLRVcsk1zM+rV2sO2nRNB42mJQadAo9nqmPzeeWzmC
         AMuJONVAC2gEouj6umXsCAhbNtDRxRkty5qtPBxuIsEamNOEBDM2T6JFeVGKASBjkB8g
         sGcq4tN8GweZVJ+vV1yddGUdRu+gkLoJQHQ51sObPAgf3xk0dZ5AIjpRkla66d9D8svt
         AlsQ==
X-Gm-Message-State: AOJu0YzNYiu5mD3wlVjluDhuxKTeG8L4lyhZuCp+nYq2ylkDCv8jQNEw
	c9FI6GXPSZ1ExFGUzsinWmjD6ncaaiBs97cT4Ca/M6n1QqLyoG2WeUplF7eIpYc=
X-Google-Smtp-Source: AGHT+IHMrbF8CoVpGDbrSwiNAoCRtHBAraPF1XTqZ20q8hnPphvyiRNL01Y5zDxxgb0Xh7+6RUHp5A==
X-Received: by 2002:a05:6a00:3ccb:b0:71e:4ee1:6d78 with SMTP id d2e1a72fcca58-720ab39e56emr1862518b3a.1.1730250722137;
        Tue, 29 Oct 2024 18:12:02 -0700 (PDT)
Received: from [192.168.3.101] (p8535228-ipngn42701marunouchi.tokyo.ocn.ne.jp. [180.15.75.228])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a44ad0sm8165893b3a.220.2024.10.29.18.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 18:12:01 -0700 (PDT)
Message-ID: <85570e57-1af3-4d17-8a21-58c75e6bac9c@linuxfoundation.org>
Date: Tue, 29 Oct 2024 19:11:58 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest/hid: increase timeout to 10 min
To: Yun Lu <luyun@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241029090746.179108-1-luyun@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241029090746.179108-1-luyun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/29/24 03:07, Yun Lu wrote:
> If running hid testcases with command "./run_kselftest.sh -c hid",

NIT - When inestead of "If"
> the following tests will take longer than the kselftest framework
> timeout (now 200 seconds) to run and thus got terminated with TIMEOUT
> error:
> 
>    hid-multitouch.sh - took about 6min41s
>    hid-tablet.sh - took about 6min30s
> 
> Increase the timeout setting to 10 minutes to allow them have a chance
> to finish.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>   tools/testing/selftests/hid/settings | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/hid/settings b/tools/testing/selftests/hid/settings
> index b3cbfc521b10..dff0d947f9c2 100644
> --- a/tools/testing/selftests/hid/settings
> +++ b/tools/testing/selftests/hid/settings
> @@ -1,3 +1,3 @@
>   # HID tests can be long, so give a little bit more time
>   # to them
> -timeout=200
> +timeout=600

Okay - maybe this test shouldn't be part of the default run if it needs
600 seconds to run?

thanks,
-- Shuah

