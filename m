Return-Path: <linux-kselftest+bounces-10764-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6A68D139F
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 07:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903E41C224B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 May 2024 05:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0FB3D393;
	Tue, 28 May 2024 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MQqiwmwW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8945024;
	Tue, 28 May 2024 05:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716872764; cv=none; b=FtiyNC4yQAMCDnC91XtZlDwSW9FmOW972qNXKRP3Ghs93MiywqV1Fw8iFfCtE/MlTP/imj5svl7RGqJxOMA3xwhgC4y5ea3Q1/gDfk7Lon+OWRlqOPh7jbpYfBHJJ8tW1yiZUr30QnchOm1zcD3aMLusknM67yoXHd99tb/NaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716872764; c=relaxed/simple;
	bh=QEn037aGR5cXUuVp/2L37AuO0NPPPU2+ZHA3zGxRGqo=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bwaQjaG1BisG8T6NFA4Ao6UyRRTQDjoHsMzOggiDGKi4mSCYYFPXCV/RfMU/oSLHa7bmVcKjMuco7D59Lhtv1lHSHdA8u0BNQ/n+jHqju6MlwuyYBAYcH8orPabmH4X+g73E+pSDc4nzrZ7cP1Tzf9KqtUS6bSTPRjMKoz5Gu6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MQqiwmwW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1716872761;
	bh=QEn037aGR5cXUuVp/2L37AuO0NPPPU2+ZHA3zGxRGqo=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=MQqiwmwWElSXojLLiK1uxGYthfGxhuNK2QNYe7mJOdxUuRP1Fhh6UYIv/8BjlVUL1
	 od9tPTGlQHlhaOf96UK2vGb/7sl0RLEnjIIykUKBvRp07iR5LqeWA3RnrR3E6+1EpS
	 e0Ly9fuZ/+wGZhA84KLAxaNLFI0DiV7fCNJTbS+Ag28M34kKhwhcQ6WLO/CdZvM2J2
	 EHCnwU5tWm+X8izwkM/au9/P3tVBVHpKl1ik8U2My+mX2u44BTT3zcEK60d3X+f5Wx
	 96ZaHJY6yXfmX+g29xH9amndcs123dewRoHiFkQsRCGii8PDtO2rZtz1dSG9Uef4qE
	 h/nUFUpwzs91g==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 385C13782137;
	Tue, 28 May 2024 05:05:57 +0000 (UTC)
Message-ID: <4fb5ad2e-cc9f-4ad6-94a5-7de9f503ab94@collabora.com>
Date: Tue, 28 May 2024 10:05:28 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tpm2: conform test to TAP output
To: Shuah Khan <shuah@kernel.org>
References: <20240426091435.2742024-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240426091435.2742024-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Kind reminder

On 4/26/24 2:14 PM, Muhammad Usama Anjum wrote:
> The python unittest is being used for executing tests. TAP output
> cannot be added in the unittest framework. The python unittest is being
> run from a script. Add the output TAP logs to the script. Add "#"
> prefix to the python unittest output which will mark all output as
> informational TAP messages. Check exit status of the python unittest to
> decide if test passed or failed. Not sure why but python unittest
> outputs logs in stderr. So redirect the logs to stdout and then add
> prefix.
> 
> Specify the bash explicitly instead of sh to run these tests as all of
> the kselftests are shifting towards using bash explicitly. Some
> interpreters have different syntax and cause issues.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/tpm2/test_async.sh | 24 ++++++++++++++++------
>  tools/testing/selftests/tpm2/test_smoke.sh | 19 ++++++++++++++---
>  tools/testing/selftests/tpm2/test_space.sh | 19 ++++++++++++++---
>  3 files changed, 50 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
> index 43bf5bd772fd4..0e6e5d9d649fb 100755
> --- a/tools/testing/selftests/tpm2/test_async.sh
> +++ b/tools/testing/selftests/tpm2/test_async.sh
> @@ -1,10 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
> -# Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
>  
> -[ -e /dev/tpm0 ] || exit $ksft_skip
> -[ -e /dev/tpmrm0 ] || exit $ksft_skip
> +ktap_print_header
>  
> -python3 -m unittest -v tpm2_tests.AsyncTest
> +[ -e /dev/tpm0 ] || ktap_finished
> +[ -e /dev/tpmrm0 ] || ktap_finished
> +
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 58af963e5b55a..2219a180de91d 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
>  # Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
>  
>  [ -e /dev/tpm0 ] || exit $ksft_skip
>  
> -python3 -m unittest -v tpm2_tests.SmokeTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index 04c47b13fe8ac..6a55d13d74983 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -1,9 +1,22 @@
> -#!/bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
>  
>  # Kselftest framework requirement - SKIP code is 4.
> -ksft_skip=4
> +DIR="$(dirname $(readlink -f "$0"))"
> +source "${DIR}"/../kselftest/ktap_helpers.sh
> +
> +ktap_print_header
>  
>  [ -e /dev/tpmrm0 ] || exit $ksft_skip
>  
> -python3 -m unittest -v tpm2_tests.SpaceTest
> +ktap_set_plan 1
> +
> +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1 | sed "s/^/# /"
> +
> +if [ ${PIPESTATUS[0]} -eq $ksft_pass ]; then
> +	ktap_test_pass "tpm2_tests.AsyncTest"
> +else
> +	ktap_test_fail "tpm2_tests.AsyncTest"
> +fi
> +
> +ktap_finished

-- 
BR,
Muhammad Usama Anjum

