Return-Path: <linux-kselftest+bounces-10183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4578C59DD
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 18:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E8A2826B4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 May 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC78179647;
	Tue, 14 May 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SwLFwFBk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0EF501
	for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715705112; cv=none; b=BklTSGUrKsVN+6OPD1JDffOJSjhCn3wFgyPz4R+NLJRXvSbjOX2Xq9E3qD9nJ7Gg1fSI8yZMghv6UtJK9I/qa65/EeoVDTtixSf8qHynHLtNFYRTGHePLyTHyFmDTdlcXQn/su6lY4n8jlM4m+UjBlNptunT4SeGY056+P0rqWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715705112; c=relaxed/simple;
	bh=diyKllqobKbeGJc5R1CZjCecj8JwIgAdEMhvC1ZOIPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmiLffuqSSLLnjeCz+ZZHwuadm1vxhS5I/JqFh1wWB828Jo/rGIaxqq3u2UpOyhzZvT2xqhqhAwKRS/tgqvgAFf66GX3X9IC1nY9iHytptDYuOpSFQdLEbTv276/jtMDfX10w7USvtypKFX0TNt9c+5VzjCB5iKlM2sS8KxmWo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SwLFwFBk; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d9ef422859so45721539f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 May 2024 09:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715705110; x=1716309910; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OqKNcj7j0AZZaaEg2IE4Ch533Q1LfRJ1nDU5mEA1FkI=;
        b=SwLFwFBkbB0nbUxeqedwjU/lTmquVv67N+Wv80U2rttrPYQJ4WLoNDAoIU5h0PT52R
         KN6j+gVQQkMe2j9WNJUF7kgNsCe41WdrAEusWLx5PG4T3Twy5QmOGGEdwobuKR85SkVz
         mCf+ttokVOLfUc64RWCziJn33FXRq8Ak5wTmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715705110; x=1716309910;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OqKNcj7j0AZZaaEg2IE4Ch533Q1LfRJ1nDU5mEA1FkI=;
        b=osAKygqm32IYZ8zn2Y8pkKWN6pFw0wsqLLIAL7m14qtj/0cV1Ofp6nmNANQ1jZRMgH
         PpFmBM6c5h5nG8S173ukm00KTxwj6CWDFt1WRmF3FgDqB7lvOIuRggZ258EHa7/zPR5O
         iRyDS300g+sW/VHYlnAP/SBhfkWygjgmkmq2ZW289gLhLTzTwqKp9tWuAi29zPwL9N7m
         2L9ffnVwO51SDg56aHUvGD6x012iwaAPET1Ylh1an/Fc6EaqVH5f9zJy/ZN5za8LH/RI
         2QSoqvZriFoaclCxc+PEdmIFjIcx10fx+jwLfIZRJZcmG6d+JTZXeIBNuwmDnMjxGEdI
         X8JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuIGV6qn9bLRtahlOKUDMoEPfgH4cEMIhFxe+ltOQwRSzvlpoI4SqKVLrt4FI/mdIsVLWT5FWf5D/GIAo7wqOjTTNqgJO8ptf5EIpP3iNV
X-Gm-Message-State: AOJu0YwSsMsS42hM5QGWSpbuzWrDHop/W0mJwdtJFXRS6H7VqXj5fuDE
	3OAcJu9QLsFzulbTouiU+29YFMBswG3jTJR9rRLk6iQvpvOsMmPHjzLrq66D8Ho=
X-Google-Smtp-Source: AGHT+IHJWsjymJ9pgm9nI2xMNo2ER37wCeFcVuOst5E9tYnvhx2Gbm+LFuCTw3kM22zofhBtRP8VSg==
X-Received: by 2002:a92:608:0:b0:36c:3856:4386 with SMTP id e9e14a558f8ab-36cc14e921amr138441975ab.3.1715705110440;
        Tue, 14 May 2024 09:45:10 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-36cc9473003sm19088335ab.79.2024.05.14.09.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 09:45:10 -0700 (PDT)
Message-ID: <58fd25ea-c444-45cf-a41d-c3022e9d5f80@linuxfoundation.org>
Date: Tue, 14 May 2024 10:45:09 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] add tests to verify IFS (In Field Scan) driver
 functionality
To: Pengfei Xu <pengfei.xu@intel.com>, shuah@kernel.org,
 linux-kselftest <linux-kselftest@vger.kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, jithu.joseph@intel.com,
 ashok.raj@intel.com, sathyanarayanan.kuppuswamy@intel.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <cover.1714447026.git.pengfei.xu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 21:31, Pengfei Xu wrote:
> To verify IFS (In Field Scan [1]) driver functionality, add the following 6
> test cases:
>    1. Verify that IFS sysfs entries are created after loading the IFS module
>    2. Check if loading an invalid IFS test image fails and loading a valid
>       one succeeds
>    3. Perform IFS scan test on each CPU using all the available image files
>    4. Perform IFS scan with first test image file on a random CPU for 3
>       rounds
>    5. Perform IFS ARRAY BIST(Board Integrated System Test) test on each CPU
>    6. Perform IFS ARRAY BIST test on a random CPU for 3 rounds
> 
> These are not exhaustive, but some minimal test runs to check various
> parts of the driver. Some negative tests are also included.
> 
> [1] https://docs.kernel.org/arch/x86/ifs.html
> 
> Pengfei Xu (4):
>    selftests: ifs: verify test interfaces are created by the driver
>    selftests: ifs: verify test image loading functionality
>    selftests: ifs: verify IFS scan test functionality
>    selftests: ifs: verify IFS ARRAY BIST functionality
> 
>   MAINTAINERS                                   |   1 +
>   tools/testing/selftests/Makefile              |   1 +
>   .../drivers/platform/x86/intel/ifs/Makefile   |   6 +
>   .../platform/x86/intel/ifs/test_ifs.sh        | 496 ++++++++++++++++++
>   4 files changed, 504 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/platform/x86/intel/ifs/Makefile
>   create mode 100755 tools/testing/selftests/drivers/platform/x86/intel/ifs/test_ifs.sh
> 

I am fine with adding a test. I would need ifs ack or reviewed-by.
I don't see ifs maintainer on on this thread.

thanks,
-- Shuah

