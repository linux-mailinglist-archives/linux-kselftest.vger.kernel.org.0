Return-Path: <linux-kselftest+bounces-13046-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12E2923B1F
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3945DB22CFD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2024 10:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB615533B;
	Tue,  2 Jul 2024 10:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="HQeva751"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72275171AF;
	Tue,  2 Jul 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719915245; cv=none; b=erF0oMJfzgD5ffXbK8ahuiy5JzVfBY3DLuVcEOPsO/SrGN69bnazMZ3Wq0sAz+aJvbzN9QTv8y3g5EtFtHlAmGYzeX4KH4qypqVpbrTrrR/kDIxEQ71rSnTT4upRJg0sQzXiDeQUQYjvNaaHleti40t28TQKDw08V7auaIYQJA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719915245; c=relaxed/simple;
	bh=RdaDMwtBry3dv/k6kCaMLKLJmJHp8aKId2FySROmlm0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B/1rsOu1Hw3yMHpCmtyDPFJWH6410dxCmhL/zNbE4+O+tGZrWdD5gEmQDxWOhoX+bJ7H9pP5bYsWyfiNmhgdem3xBPuW17waj1Iq6sx7FPSJUm+qra0uMTXzBg6/2rjJzA+NxER2AqrwQQmfi6kB3wsNuzGaXOh1c8dsrTzmIj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=HQeva751; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719915241;
	bh=RdaDMwtBry3dv/k6kCaMLKLJmJHp8aKId2FySROmlm0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HQeva751i6otgYJNWitxE7n/6022ioRqPAVLpM1wCDzYo+6eeytt40XtUjBlHgp1L
	 GRdR/rqYU+JQ2DWNqEDRtB4PWCAF6Os/dJC+YLHrZKcDjxKHI9hTkpzWUImx/0un3A
	 QbNPWdnVJrMT0jvhx5OiT5eLvJxCT915NbaknudgGkR1aMb6LUbVujg7AX7yYcHUon
	 ONxUDg9e6Q8QDD9c2P5F/JbUQMUPwQV9UlT7O/GOLshjZra1DGyR2Jm+o7jCW9CI0b
	 mgTLZhV7fP7YWca1kMiNAjjL8qRbohUnlHMS1r7NTi3eJEFlWAM9/QmsXjKpBuV7Tj
	 qcewwU4YiSgCg==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D25343782139;
	Tue,  2 Jul 2024 10:13:57 +0000 (UTC)
Message-ID: <3be33950-0b7f-439c-823b-ad69ac669919@collabora.com>
Date: Tue, 2 Jul 2024 15:13:51 +0500
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
To: Jarkko Sakkinen <jarkko@kernel.org>, Shuah Khan <shuah@kernel.org>
References: <20240702065559.772855-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240702065559.772855-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This is PATCH v2. I missed updating the version number in the subject.

On 7/2/24 11:55 AM, Muhammad Usama Anjum wrote:
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
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - CC more people which were missing earlier
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

