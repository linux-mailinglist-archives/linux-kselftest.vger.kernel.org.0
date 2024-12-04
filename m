Return-Path: <linux-kselftest+bounces-22822-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C28B9E3899
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 12:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 012A0283C94
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Dec 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17F71BE86E;
	Wed,  4 Dec 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kUJxPmzn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9131B21AE
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Dec 2024 11:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310947; cv=none; b=ilSHNGFmGzxSjDYas38XkYkSIigJBubyAeM4GiYC7tnUvYsj0LGhOWkQCdrxEHK4VXlBEDBHMoFVJcOhgZA07DGpEiKnRZLR4HT+Zw3SQ6iR47kEeZTSKZPZCu4LvFEvMVosVn4IHj6SM/0Yrf4D/zDjFo5VQ2Q8IZCw6F7Ip+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310947; c=relaxed/simple;
	bh=6haO52hbbqb+Ge1gGjrlJIH8GzfdI7zl8el26uthSe8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJbwx/XgvvVJAtIL7/ZgyIWihFs1q5O5leZOkszVG73f+UCBe3W3r+qNfIFyI8azBitphNrotUfGP1A3+OBNGYkcV1p2uX1+ytHgQxN3UUlogijdWDn3/+hbJABRf3PSPRHMiJ1qTvTMs0k08qADmsYWCIjd0Dz/7GFc/VIy2OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kUJxPmzn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-434a766b475so61125425e9.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Dec 2024 03:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733310944; x=1733915744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PyMV4bLyaktItEEO0O2hHQkcftcybGuVejNfsC7KtYY=;
        b=kUJxPmznIU4K3p2se+NkhAPq1cBrN3HosrhIIK3WXXcIl4nN73HcgN9Y8TAbMGFegA
         to8p7Y30n7wZZcP6z0oPhF3GmnrEXzOE9h1qBdYQuHBGmfJTWWbnrAAjUfhMKML861EN
         nu4sisy2eVoQkkkyZJSYyiN6uXLykTdeKP6LFZJgB8SyoCliCozwAO97XmOkXH+YSkI4
         oj78oJyk6TVp8SorlFJ3lsCZ5KDIz8CmAguT40bDaqd4T10DMFRcQsmkbPe+LMaMRqvy
         +IPNNZ5JM+b7wt2TIPRJptMPJleEowlVKRsqf+rfJGolLAT0p5uQQSzp450VkN4lnJTl
         ENhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733310944; x=1733915744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PyMV4bLyaktItEEO0O2hHQkcftcybGuVejNfsC7KtYY=;
        b=w/v8nTIr/Pf/FSqcZGDLV5J2+en6POBOqdP2XD4oRK8r6bt8K1YuoKpxQcrNQyWKlc
         JxSDaTbwE70gNwvBLN6dwsJeVYfahO6Ce6gchfaTG7MKnYzuMo6OeJXi9vrt95o/EgA0
         jbSFWW/1yXLjtpt4Zk+xebB3yyVvwOaxjackXgAQusGopLnqFm8c639ia81j0v5uzwlL
         ZPmbUQe1hbFGYLb65NYd5ejxsOWuK7KGI3ITO0r3uWXcUWBM6jdEH7v3/Engi1QeY+dk
         0JdoxHwdhypCDC2OE4VY/7Ebxm57zi5sSNAILydW5lSF0v0m08MNwHKwzSPbDG+RRZHd
         5MNw==
X-Forwarded-Encrypted: i=1; AJvYcCXVPoewQCCgXmddvGI6O0fso8cM/jmtqus4Vs+Fr8Fa/bs0oRKaiWafCfeeNoMt4PTbzGYukRNOzO5X6kwSMds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEpRss31UROL8mAUXKD06ebv7f+0Mxgu92YKsXqEy87uBjh9jV
	dCEcAfYeURpLkZxnFqR2auWr3V5budHo71SPYb18ZlSQuo13ExLOYFzFcrjzi/U=
X-Gm-Gg: ASbGncuHz6x+0O4ORYznemN/XmeYl/yzIeeJgIjXVXG4B6pJczg1kyAZZqpiqXMUXHd
	FxXb0dGABjqwTCeCo+BUwJD9T8dVW1nUdTPpMB0xponhaFWD90frRI52pd9QWP8LAfwA/cXlnGR
	xG8AQ95Q9kTnGSF2i5Yx8oxqIcXs1hSrfA9tBvxFBVchoLrlegMYk+tHp5JLt4fvqCLSE+XAM3s
	GFVxr/edGLiOU+Y2QeWzqpYPrMIXuS0oB+Avyu45q+lPtfn41HGQDrY2KlBEg==
X-Google-Smtp-Source: AGHT+IGfDnu2hvQw6lAXpCu8yTqKC7sSN3W0dVpbKUu+3ZC2h61wf1xZ9LgnpipofMZ5rmAaVuaEfQ==
X-Received: by 2002:a05:6000:1847:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-385fd3ee334mr5060123f8f.33.1733310943999;
        Wed, 04 Dec 2024 03:15:43 -0800 (PST)
Received: from [192.168.68.163] ([209.198.129.154])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385db37debdsm16833644f8f.2.2024.12.04.03.15.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 03:15:43 -0800 (PST)
Message-ID: <1b7aaa17-48b7-45cd-b468-ef54ca048e31@linaro.org>
Date: Wed, 4 Dec 2024 11:15:42 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: arm coresight: sysfsmode testing
To: Linu Cherian <lcherian@marvell.com>,
 "coresight@lists.linaro.org" <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, sgoutham@marvell.com,
 gcherian@marvell.com, Mike Leach <mike.leach@linaro.org>,
 Suzuki K Poulose <Suzuki.Poulose@arm.com>, Leo Yan <leo.yan@arm.com>
References: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241129083813.3056909-1-lcherian@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 29/11/2024 8:38 am, Linu Cherian wrote:
> Add sysfs mode selftest for ARM Coresight hardware tracer.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>   .../drivers/hwtracing/coresight/Makefile      |   5 +
>   .../hwtracing/coresight/sysfs_test_trace.sh   | 144 ++++++++++++++++++
>   2 files changed, 149 insertions(+)
>   create mode 100644 tools/testing/selftests/drivers/hwtracing/coresight/Makefile

Hi Linu,

You need to add this path into TARGETS for make install to work:

  TARGETS += drivers/dma-buf
+TARGETS += drivers/hwtracing/coresight
  TARGETS += drivers/s390x/uvdevice


>   create mode 100755 tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> 
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/Makefile b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> new file mode 100644
> index 000000000000..7dc68ae1c0a9
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +TEST_PROGS = sysfs_test_trace.sh
> +
> +include ../../../lib.mk
> diff --git a/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> new file mode 100755
> index 000000000000..0d6307fff1d2
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/hwtracing/coresight/sysfs_test_trace.sh
> @@ -0,0 +1,144 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 Marvell.
> +
> +# Test Arm CoreSight trace capture in sysfs mode
> +# Based on tools/perf/tests/shell/test_arm_coresight.sh
> +
> +glb_err=0
> +
> +arm_cs_report() {
> +	if [ $2 != 0 ]; then
> +		echo "$1: FAIL"
> +		glb_err=$2
> +	else
> +		echo "$1: PASS"
> +	fi
> +}
> +
> +is_device_sink() {
> +	# If the node of "enable_sink" is existed under the device path, this
> +	# means the device is a sink device.
> +

Looks like you still need the skip for TPIU here the same as the Perf 
test. It's an external sink and doesn't have a readable file so the test 
fails.

With those changes, looks good. Thanks for adding the first sysfs test. 
Hopefully we can expand them more in the future.

Reviewed-by: James Clark <james.clark@linaro.org>


