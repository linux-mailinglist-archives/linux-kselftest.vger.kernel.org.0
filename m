Return-Path: <linux-kselftest+bounces-7216-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B481B898CF7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65542284D13
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 17:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49924129E88;
	Thu,  4 Apr 2024 17:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OO3lc94R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3F81F922
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 17:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250386; cv=none; b=iJfYIPCeSjSKp8CCHVQ3uZwvyFwXb8Hn+gxJPP9d5HuAGXSizsWQ0x7k8wBE6Gu3DH6xbLywD+A09bS45FeH+pYKFGWWGIIv9ALibL4oMtNMWKFXiD5Sm+9vLF/vkR7t2AYYEC2+aPPgUJHIgduekaMpv+HCa3VBD5DhnLbdoTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250386; c=relaxed/simple;
	bh=OSPqJ91WFQCaW0PJb6559Z/+qaB8INvw9x8X/jLyFgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qTQKXq7ZRWIgfIcG6MSIpg2i0zlfKMozMiQp/bmVrTrLvoLPCE24r6Y2+HlaIon1AcKXQLgM6H8/4XaEuXBB4YQoyGnudtyVtncCttquSGgsASEUVpN3yrul+sHaTllWdEICrZfqdC38Otl7KZLIiPS3i6yeeqapx6VVE8gJJ5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OO3lc94R; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7c8e4c0412dso13096039f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 10:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712250384; x=1712855184; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S4+pPZmfnMRvuzCTlrw9RHK+nPpZuPKzM5pjyBfGGjY=;
        b=OO3lc94R4WR6QoxKazbfb7vIGroC/uHZbbsOqlfRXYpFDB5xw7WMB7hcfHEHxN1yxg
         3+1+aBjXfBobKZ6R/0FOvmh8Rnqgaasfabvl6o6sJ3B8V25/OOm1esH7sHB3aTPSrLKB
         xAJD1xCVezt5HNfz+f2P5KAJJ8tKW8K1Ui3ag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712250384; x=1712855184;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S4+pPZmfnMRvuzCTlrw9RHK+nPpZuPKzM5pjyBfGGjY=;
        b=bXtRSLUf+i84+/7sBTho3Oz9HIGzChXOfIcPR45QL5gjLW8qdHU0YDfepuAfwpW1Ed
         xeqQ8c3GUCIRdCy0s5Iu0mK5hvv9qsdNL0lttnrW3u76D87TvvAWQbyi/q4l6FfeVJwY
         5pqmB9xf8d6FXAA3jwVOcnnjscRg7vBin/uj24X109WTRtGrposmJwGzqzzpX/ihI50Q
         VccPB5EALraPKVcc17ZOissTfRMbh3UWKelqM55YusmgxdDlbDcnG9x65fQca2/0TRVq
         fkjB5d/mCpzmZuFYeuc9OAZjsR9FwFRojEBdjC/PVOGGdFFMHVVrWfs8oHgOADTxnwtv
         Pu3g==
X-Forwarded-Encrypted: i=1; AJvYcCV5IAK2lpMWaZ++E5An+krB4CYY/SwN7TC/JIRkrbKa1ybL122IECvYa8GoPT0FD8thIscuiyP2ZNqnM5vv6yj8TlpEAQl+iz2Z+naG7tfv
X-Gm-Message-State: AOJu0YztXRN59b2xEE5qOL2f46HjyqAVWSUm/SNwAfFDeLex7Au0X2n2
	6gbXkK4lJxv2wJz5/h5zWvAjkET9ljTdxaXS28N69SfADlw/+WIUJGq7hex2hpo=
X-Google-Smtp-Source: AGHT+IGBSo+ofsQpk2L5vpwRRgN7skJmv9Ao+cuVo9Akhk+UCk1M/bFzDJtgrQxmsRVuuo6GDjI0fw==
X-Received: by 2002:a6b:fc1a:0:b0:7d3:4f72:afd with SMTP id r26-20020a6bfc1a000000b007d34f720afdmr3224480ioh.0.1712250383695;
        Thu, 04 Apr 2024 10:06:23 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id g18-20020a05663816d200b00474d6e60dc4sm4679108jat.117.2024.04.04.10.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:06:23 -0700 (PDT)
Message-ID: <7b7447d8-cf99-4a0a-9510-f4d2d9791264@linuxfoundation.org>
Date: Thu, 4 Apr 2024 11:06:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: Add missing signature to the comments
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240404155511.57502-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240404155511.57502-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 09:55, Muhammad Usama Anjum wrote:
> The comment on top of the file is used by many developers to glance over
> all the available functions. Add the recently added ksft_perror() to it.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>   tools/testing/selftests/kselftest.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 7d650a06ca359..159bf8e314fa3 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -16,6 +16,7 @@
>    * For each test, report any progress, debugging, etc with:
>    *
>    *     ksft_print_msg(fmt, ...);
> + *     ksft_perror(msg);
>    *
>    * and finally report the pass/fail/skip/xfail state of the test with one of:
>    *

Thank you. Applied to linux-kselftest next for Linux 6.10-rc1

thanks,
-- Shuah

