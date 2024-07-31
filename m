Return-Path: <linux-kselftest+bounces-14552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6262943129
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 15:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5092C1F2187B
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D083D1B1401;
	Wed, 31 Jul 2024 13:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kHy4e4AX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDF16D4CB;
	Wed, 31 Jul 2024 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722433343; cv=none; b=c8tniKIcDObltzgmRaxs7wCUxixMDeDf4px9F6myAcaOPhaNO7C0jTs2Eftpwapzv1bhz1G0zJNov6JWp6DvtpuhOl3yx2pSR7lK8hKKMoBrAxzfN0kWJMCvgpwO2ftaxLniAiXk3BaZuvS4hQKVLvgNyq7R8eC3y6do5Wl7bdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722433343; c=relaxed/simple;
	bh=jSR1gVsPfCs6z1loLKx23Qx82QXJrkbCyr8DQBQs6ns=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q8nnoe/w90qq/kigavtOrQLRG+UaXHhmLaR3UmyA9sjmreS38JBnqTuIws5qK/dtHCRHW98HsGjNgmmiW3vrv9qpQiPAllXgjyXFnV3ofcMl2SUda8FlCwvN2fAdOpX9LKEmvDvuno7GXHcEnZ08hj5GEvEqDK5/xtntVpZNqWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kHy4e4AX; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722433340;
	bh=jSR1gVsPfCs6z1loLKx23Qx82QXJrkbCyr8DQBQs6ns=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=kHy4e4AXDhoDHro/7d5eh2JSzAGvjxLkSbCd65/WBdPvdlOag7Uz2lfT30wL+G5yp
	 8TWyHm0PDskSSPyGefhUt54aXJbMYGY7XyfUC8qjJca0nHJx7bZo27miV/doGUIEco
	 mLXP6qFYJ0kUmVxznQui5wIIItDWc66tRWKjqZXRCposicVGltPaglrr3xrAN/ZIUj
	 E7Z1Wpyzy4O5t05m+mqNyv8Cm6Vxlfi2L+0HlhOkEdXsSd7vKNMQpvjTPOhdemegDC
	 A/ursKlU/2HClhQBDx6ETKuLhiPvqmbC7GgP/QAd0QMhv1MxTkZCb/O5NTQjPM68vf
	 9JEfwpaGs8Y0w==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A24A937800DE;
	Wed, 31 Jul 2024 13:42:18 +0000 (UTC)
Message-ID: <47ea7423-3aae-4bb3-a41f-1fcb5c07e74b@collabora.com>
Date: Wed, 31 Jul 2024 18:42:10 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: tpm2: redirect python unittest logs to stdout
To: Shuah Khan <shuah@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
References: <20240710081539.1741132-1-usama.anjum@collabora.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240710081539.1741132-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reminder

On 7/10/24 1:15 PM, Muhammad Usama Anjum wrote:
> The python unittest module writes all its output to stderr, even when
> the run is clean. Redirect its output logs to stdout.
> 
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
>  tools/testing/selftests/tpm2/test_async.sh | 2 +-
>  tools/testing/selftests/tpm2/test_smoke.sh | 2 +-
>  tools/testing/selftests/tpm2/test_space.sh | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
> index 43bf5bd772fd4..cf5a9c826097b 100755
> --- a/tools/testing/selftests/tpm2/test_async.sh
> +++ b/tools/testing/selftests/tpm2/test_async.sh
> @@ -7,4 +7,4 @@ ksft_skip=4
>  [ -e /dev/tpm0 ] || exit $ksft_skip
>  [ -e /dev/tpmrm0 ] || exit $ksft_skip
>  
> -python3 -m unittest -v tpm2_tests.AsyncTest
> +python3 -m unittest -v tpm2_tests.AsyncTest 2>&1
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
> index 58af963e5b55a..20fa70f970a9a 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -6,4 +6,4 @@ ksft_skip=4
>  
>  [ -e /dev/tpm0 ] || exit $ksft_skip
>  
> -python3 -m unittest -v tpm2_tests.SmokeTest
> +python3 -m unittest -v tpm2_tests.SmokeTest 2>&1
> diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
> index 04c47b13fe8ac..93894cbc89a80 100755
> --- a/tools/testing/selftests/tpm2/test_space.sh
> +++ b/tools/testing/selftests/tpm2/test_space.sh
> @@ -6,4 +6,4 @@ ksft_skip=4
>  
>  [ -e /dev/tpmrm0 ] || exit $ksft_skip
>  
> -python3 -m unittest -v tpm2_tests.SpaceTest
> +python3 -m unittest -v tpm2_tests.SpaceTest 2>&1

-- 
BR,
Muhammad Usama Anjum

