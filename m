Return-Path: <linux-kselftest+bounces-19259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6AB9957AA
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCAF1F268BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Oct 2024 19:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6B1213EC7;
	Tue,  8 Oct 2024 19:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghjmA6bn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED9820CCFD
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Oct 2024 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728415989; cv=none; b=cfj72z3GlIBXKbRQvoz/C3uH2yND6TUqiWB8e7pq398+hdCGxBnuqB7ohU0t4tpcAT5uRWyOoa681HLRoY3SI/RZOo3EZlMSubwTqlr6me5iOyudvdpyqVfr7n74HpCdvlG/Nh0DCHd9MW7kSxL66WZpFu1F9JqZeWHGgbfgiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728415989; c=relaxed/simple;
	bh=ZWjiWX2PYow7IFF+icnGCEcVzFP7KxAoECdaQ7XIMZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GEGfceqvpcHvPafeQ3HO9XI78WoBG38tVmEcS+JGBLNbon5mc9xcMohYrUSH8kac/l5s2lRyka+mXcmXQO/y1+2+Oy9lfwfPSWnIangwZ8hbGYx/9FKOT7QrmOGWQvPskyu3HpwAxE+ayTeVI5hfxEJeofoVoYiazRIn9x13l9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghjmA6bn; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82cdada0f21so221004039f.3
        for <linux-kselftest@vger.kernel.org>; Tue, 08 Oct 2024 12:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728415986; x=1729020786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=igeyFC/Kp5wyyTrbzqjY53d0DZThT6N1c1YSK8tDcXQ=;
        b=ghjmA6bnep2bZryJgktuBxMALgNC83mtXOyUuH9YA4bxBLx8vR+GP+qoFrMkOcWCl6
         djq4WCQFA5+C0GS542nhO6gWG48EmhhpCgBo/oXd+1L9HFb4v6ngmpqtRvciuxi/XrNs
         ypUILIbnoqsZ2JOlQG0pQ2TSuOAfJcCP7DLmo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728415986; x=1729020786;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=igeyFC/Kp5wyyTrbzqjY53d0DZThT6N1c1YSK8tDcXQ=;
        b=JkDuPfvvURba32/HXcsAQJe1kMVbtx0fLNZwx96KxrzBAG5G3kvo1nw9bHYbZLXvQ/
         UeJfYmT0jQ+4mXwu2hllFVaqdSa93Njaw6yrTwH71J2Fau7eueupIOit6u7f36+q2EM4
         ZFmTFGDoggpyemeL0YyL11CMjFlT4pwut3U+RIio0Vj+sEDiZT/8f6stVhTAq+09i80G
         M9+R61u3illJKz6HBgAN5Rw5yB/4SFz3rVbRcmrSny97JP+hACBmTErO4OazxD9P5Ocg
         Rq/zA0Ww64h9oEnPJX8ZY3iRZs9FvXhtwpD/XzFS1OzSo8NU4LUHM1MZtBpKTOabA6kL
         kwaQ==
X-Gm-Message-State: AOJu0YwvjWwxdQLxMsT7twa9OJu3MzZY5IQuu28a8z3MktQp/j6Bzehv
	uvWpQfg2/W+fQ09DAek+x6EOLiVPyTxj+c6GYFEK1cloYZrY86BP183La9c/aFU=
X-Google-Smtp-Source: AGHT+IExoHge3ikoQI3mxSRfDzAdKfxp8Xxvr98miHmNy06vYEkpSOJyjh75gjwCWYFN1muiNtcY3g==
X-Received: by 2002:a92:ca05:0:b0:3a0:a71b:75e5 with SMTP id e9e14a558f8ab-3a375999710mr142135035ab.7.1728415986588;
        Tue, 08 Oct 2024 12:33:06 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a39644f0c5sm947165ab.17.2024.10.08.12.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 12:33:05 -0700 (PDT)
Message-ID: <e54c70db-a14d-43e6-b221-0c0712893ee7@linuxfoundation.org>
Date: Tue, 8 Oct 2024 13:33:05 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftest: hid: add the missing tests directory
To: Yun Lu <luyun@kylinos.cn>, jikos@kernel.org, bentiss@kernel.org,
 shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008093120.3081899-1-luyun@kylinos.cn>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20241008093120.3081899-1-luyun@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/8/24 03:31, Yun Lu wrote:
> Commit 160c826b4dd0 ("selftest: hid: add missing run-hid-tools-tests.sh")
> has added the run-hid-tools-tests.sh script for it to be installed, but
> I forgot to add the tests directory together.
> 
> In fact, the run-hid-tools-tests.sh script uses the scripts in the tests
> directory to run tests. The tests directory also needs to be added to be
> installed
Include the error you are seeing in here.

> 
> Fixes: ffb85d5c9e80 ("selftests: hid: import hid-tools hid-core tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yun Lu <luyun@kylinos.cn>
> ---
>   tools/testing/selftests/hid/Makefile | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/testing/selftests/hid/Makefile b/tools/testing/selftests/hid/Makefile
> index 38ae31bb07b5..662209f5fabc 100644
> --- a/tools/testing/selftests/hid/Makefile
> +++ b/tools/testing/selftests/hid/Makefile
> @@ -18,6 +18,7 @@ TEST_PROGS += hid-usb_crash.sh
>   TEST_PROGS += hid-wacom.sh
>   
>   TEST_FILES := run-hid-tools-tests.sh
> +TEST_FILES += tests

What about the files if any under the tests directory?
The install rule would handle the case, however, did
you verify that those are copied as well?

>   
>   CXX ?= $(CROSS_COMPILE)g++
>   

thanks,
-- Shuah


