Return-Path: <linux-kselftest+bounces-23736-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD27E9FB04B
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 15:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC9B189206E
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Dec 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC3F125D6;
	Mon, 23 Dec 2024 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tX4+7S4N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A402617996
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Dec 2024 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734964713; cv=none; b=orurrNcILTiAHBjdVSOvAAa9kUYaTKdsT/rwSfNcmKhcLfQHgpPBgCvCVcaACRIzX0BQt0ddHSRlN/6ygfoQG0I2oK07I3SecT8iy+cCBq2zQXpHGGdnjiN/+2SYz7ndTrcpwONgQDwFx3Efxeyk4UxuaG9sn+0GYKbJgBq+Ofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734964713; c=relaxed/simple;
	bh=4SatYIj9cPz9LVfOjCFJXJ9WQL+iMK89ubN1hFMB5cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdFImuu8JzlQCdYyj50tJFwY3zDfTt0ODPsMGr9HqVMHpbFOaYP7c6UH0hZ530EhRZJon9bs+PkMDMsVaVNgGnzEvpQz/TLLor3b+1VboirJwv+/Wsi2HmDl93eHP/vpHueh676vZS8Y+oBH6eC0covH5Fw9RsawT9+xVxeQrP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tX4+7S4N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43626213fffso32126575e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Dec 2024 06:38:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734964710; x=1735569510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZ2TiI2Fgy0JywNyy3GepEeOSIh6F/pE/b41mnhIWbg=;
        b=tX4+7S4NGR5cCRE+Pel+DsH5EY7VP2/HIRhaL+h6FFBcc3B57Xr+DysHw1RLMAdklF
         rq38+eppyZnmoN+0WeYRI/1EvILvSUf7DL4QP6Q9NevlzXL0DorjiSFunMIH8PUC3A3H
         ffLHlA0mO/itE3tBk1dTL5dWsv7uPCRavaEklTp5VwkftYyUDbmJrETtKzGUI2ZuJTL7
         2Lb+jbNtGJYb84iRj+lh73urumvuG51onkGgGZCpAbZXNPOYyLushOatLwmXO4yokwCv
         9wEci3W/0CEi5C6h41Hq8BSGr4bmusGKzf4t410E+SWph7Dtt7sc+TzccTrynjmX7IGN
         EqPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734964710; x=1735569510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZ2TiI2Fgy0JywNyy3GepEeOSIh6F/pE/b41mnhIWbg=;
        b=As6HUtGFpLrUKugClpyg7ci/VsuUSQ2gtyAOhC7G3yGIxNAtx508EupFLMayVbuF+j
         TTQ3/x+uYT/Zlq7CQ86wJA5eYcKQMaLvb4R/G6ZUqkllRBwxkAB64cNAbuHrv6ZqkG2b
         P4teLdvnge9oMQnQ7CyNZ6ZM5/f9oicBpP4nKAehe75reaNm7Y9A/ze+8s6VWoOuSbhG
         2ROvwsdLmSgGeiT74SmC6JEaISI4McNvmGz4PNKsjrZFR8xhOFbQJ4AOc091BFbl1vOr
         QmUqF7twgh5A4tARs2bjYs9cGXvjk/Eh8Yb1784RkBeVsBUpSxhuWhkjxMUJEoyvQRh1
         9bvw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3saUSN3F/CFxiDn1uK2lOep8nnQTIp0jBqcdH/MxK3ypGAAIRoKa7Iaoy5iJyLUScUWQN6Va1ISaA5FIo4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNaO9YHfns9HP6Sclo/GfbvNlNWUnQhW/qvjJtz9x09FIHMgr5
	gPVvpGnniaZiGKOJzdzBUoRG/ebVPoMopAUSzvtvOWTVWiWaPDVZ2DdeSiJy4QA=
X-Gm-Gg: ASbGncsXp78pEPHL3XpskC6peOCu9y6imrx+1OqYh/Qm3g/AMkKHPU98hVi0hQ4yg9D
	lTImYiRZ46Xr2lEX1r8UVIqkKDXwLIipSxUYNGM1xpzJ3p6ev8+OCFNO+YHfGHy9DAratwpCQ+d
	wcP7aRysIMOY9E6jdFdxofZcSuphavjwGMWlZrkAtKQz077Bs1BG8jzc4O+xpJTpDzwFM0gS/Hw
	2/4ZB92cO4btQ2lhp+BMeoW528ZdsC+X8RzfyHEMVTO6hlJ9GuPRFydGbyiolen4g==
X-Google-Smtp-Source: AGHT+IFD877ivJh7j6VgtUymsDt077YchjBVTqnwRT73inVbvbhIX3OxTjcJOqsBtVXBf4OyihOyQw==
X-Received: by 2002:a5d:6d0c:0:b0:385:fb40:e571 with SMTP id ffacd0b85a97d-38a229ed1bdmr13402172f8f.6.1734964710020;
        Mon, 23 Dec 2024 06:38:30 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e3d9sm11370101f8f.67.2024.12.23.06.38.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 06:38:29 -0800 (PST)
Message-ID: <b1ffbdda-f5b9-46da-bc78-e90ccfa41344@linaro.org>
Date: Mon, 23 Dec 2024 14:38:28 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests: arm coresight: sysfsmode testing
To: Linu Cherian <lcherian@marvell.com>, suzuki.poulose@arm.com,
 mike.leach@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org, sgoutham@marvell.com, gcherian@marvell.com
References: <20241219142456.3474879-1-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241219142456.3474879-1-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 19/12/2024 2:24 pm, Linu Cherian wrote:
> Add sysfs mode selftest for ARM Coresight hardware tracer.
> 
> The test will run below sequence for all possible sinks for every
> trace source available on the system.
> 1. Enable source and sink device to start tracing in sysfs mode
> 3. Run a standard dd command to be traced
> 4. Stop tracing
> 5. Readback tracedata
> 
> - Test case is pass if the readback of tracedata is success else
> failure.
> - In case of ETR sink, the test is run with both default buffer mode and
> reserved buffer mode(if available).
> 
> Sample output:
> 
>   selftests: drivers/hwtracing/coresight: sysfs_test_trace.sh
>   Running sysfs trace with default settings
>   64+0 records in
>   64+0 records out
>   67108864 bytes (67 MB, 64 MiB) copied, 0.196945 s, 341 MB/s
>   32+0 records in
>   32+0 records out
>   16384 bytes (16 kB, 16 KiB) copied, 0.000805288 s, 20.3 MB/s
>   CoreSight path testing (CPU0 -> tmc_etf0): PASS
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
> Changelog from v1:
> - Added test description in commit message suggested by Shuah
> - Added config dependency file suggested by Shuah
> - Added TARGETS as suggested by James
> - Skipped TPIU as suggested by James
> - Added Reviewed-by tag
> 
> 
>   tools/testing/selftests/Makefile              |   1 +
>   .../drivers/hwtracing/coresight/Makefile      |   5 +
>   .../drivers/hwtracing/coresight/config        |   7 +
>   .../hwtracing/coresight/sysfs_test_trace.sh   | 146 ++++++++++++++++++
>   4 files changed, 159 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile
>   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/config
>   create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> 

Reviewed-by: James Clark <james.clark@linaro.org>


