Return-Path: <linux-kselftest+bounces-9385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E888BB19B
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 19:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C7E1F228C5
	for <lists+linux-kselftest@lfdr.de>; Fri,  3 May 2024 17:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D44C15821E;
	Fri,  3 May 2024 17:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JYGJZo0Y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651F1581FC;
	Fri,  3 May 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756749; cv=none; b=V6oKKlROdVOUyd//nR6N4uJNAzcYIFTB+Ib76Wn2AZbSSvjhvTeVZM6NH6c7+blK7e5c64oIljVIiLoWsF+waOeo8Dt8ETIm9KqpYJY8L68gWZhjd1da18XGGelidLAtwGGZyX4dxIkEgdMRKvO/x1md9rIKKUPm3hH5WFx8dNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756749; c=relaxed/simple;
	bh=zzz3iQzBIvo8oUdtkf8MNajD0FsADq1mc2by6A/+yhU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PhljdO6kXMfdAR2PvV9p2Y09AsuP4eplfmnWQXf9WySaAnGJbrgTCwr2yPk4fG4LFcbr7B6CcGewUo+7UiY+kwnxSRtK4wxGdyH8C1Xqx5p/gDQFpMNNM3efMxVg2Pxv91EfhlwNG7UbTS6qhEuSlk5H+vRWjBS0Kh+FvIlGvgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JYGJZo0Y; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714756744;
	bh=zzz3iQzBIvo8oUdtkf8MNajD0FsADq1mc2by6A/+yhU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=JYGJZo0YzUeV50Bvr4IIJXocSMwDl6JCLzxyx1OrR3Z2jZGsCHesxkyHS+xQENh0D
	 /zN46oR4GzxL6xjYN2N8I2zYIIcCH51WrxMBJtGFP6yyNBmiD+1eD5OM4b0AHMlH3b
	 ImqTVlJCFQTzkBvi2DfeaBb5NBV2oZVM//YvN8TL1jaKkbrE1hOCNQxuTzAR/QL5j0
	 S7mrI1HrbixRo2UsbFLwQf7PC1WK3acwBN1i4xvSmB3zMIGexuJMuusXxZCTsa5VTV
	 lIAT8ezvcw4zf2ibWyOLEq+9oSEeto3dBJwgqksrmiVtvN9Qi5bE6PJ8VMl8gz6ydL
	 z57Mu+bBWDC7Q==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 435B3378148F;
	Fri,  3 May 2024 17:19:00 +0000 (UTC)
Message-ID: <99096ca9-f43b-471e-9a8f-cdd4adf93fba@collabora.com>
Date: Fri, 3 May 2024 22:18:18 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Andrei Vagin <avagin@openvz.org>, Andrei Vagin <avagin@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Obst <kernel@valentinobst.de>, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
Subject: Re: [PATCH] selftest/timerns: fix clang build failures for abs()
 calls
To: John Hubbard <jhubbard@nvidia.com>, Shuah Khan <shuah@kernel.org>
References: <20240503032956.89290-1-jhubbard@nvidia.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240503032956.89290-1-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/24 8:29 AM, John Hubbard wrote:
> First of all, in order to build with clang at all, one must first apply
> Valentin Obst's build fix for LLVM [1]. Once that is done, then when
> building with clang, via:
> 
>     make LLVM=1 -C tools/testing/selftests
> 
> ...then clang warns about mismatches between the expected and required
> integer length being supplied to abs(3).
> 
> Fix this by using the correct variant of abs(3): labs(3) or llabs(3), in
> these cases.
> 
> [1] https://lore.kernel.org/all/20240329-selftests-libmk-llvm-rfc-v1-1-2f9ed7d1c49f@valentinobst.de/
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Thanks for fixing!
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/timens/exec.c       | 6 +++---
>  tools/testing/selftests/timens/timer.c      | 2 +-
>  tools/testing/selftests/timens/timerfd.c    | 2 +-
>  tools/testing/selftests/timens/vfork_exec.c | 4 ++--
>  4 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> index e40dc5be2f66..d12ff955de0d 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -30,7 +30,7 @@ int main(int argc, char *argv[])
>  
>  		for (i = 0; i < 2; i++) {
>  			_gettime(CLOCK_MONOTONIC, &tst, i);
> -			if (abs(tst.tv_sec - now.tv_sec) > 5)
> +			if (labs(tst.tv_sec - now.tv_sec) > 5)
>  				return pr_fail("%ld %ld\n", now.tv_sec, tst.tv_sec);
>  		}
>  		return 0;
> @@ -50,7 +50,7 @@ int main(int argc, char *argv[])
>  
>  	for (i = 0; i < 2; i++) {
>  		_gettime(CLOCK_MONOTONIC, &tst, i);
> -		if (abs(tst.tv_sec - now.tv_sec) > 5)
> +		if (labs(tst.tv_sec - now.tv_sec) > 5)
>  			return pr_fail("%ld %ld\n",
>  					now.tv_sec, tst.tv_sec);
>  	}
> @@ -70,7 +70,7 @@ int main(int argc, char *argv[])
>  		/* Check that a child process is in the new timens. */
>  		for (i = 0; i < 2; i++) {
>  			_gettime(CLOCK_MONOTONIC, &tst, i);
> -			if (abs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
> +			if (labs(tst.tv_sec - now.tv_sec - OFFSET) > 5)
>  				return pr_fail("%ld %ld\n",
>  						now.tv_sec + OFFSET, tst.tv_sec);
>  		}
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 5e7f0051bd7b..5b939f59dfa4 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -56,7 +56,7 @@ int run_test(int clockid, struct timespec now)
>  			return pr_perror("timerfd_gettime");
>  
>  		elapsed = new_value.it_value.tv_sec;
> -		if (abs(elapsed - 3600) > 60) {
> +		if (llabs(elapsed - 3600) > 60) {
>  			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>  					      clockid, elapsed);
>  			return 1;
> diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
> index 9edd43d6b2c1..a4196bbd6e33 100644
> --- a/tools/testing/selftests/timens/timerfd.c
> +++ b/tools/testing/selftests/timens/timerfd.c
> @@ -61,7 +61,7 @@ int run_test(int clockid, struct timespec now)
>  			return pr_perror("timerfd_gettime(%d)", clockid);
>  
>  		elapsed = new_value.it_value.tv_sec;
> -		if (abs(elapsed - 3600) > 60) {
> +		if (llabs(elapsed - 3600) > 60) {
>  			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
>  					      clockid, elapsed);
>  			return 1;
> diff --git a/tools/testing/selftests/timens/vfork_exec.c b/tools/testing/selftests/timens/vfork_exec.c
> index beb7614941fb..5b8907bf451d 100644
> --- a/tools/testing/selftests/timens/vfork_exec.c
> +++ b/tools/testing/selftests/timens/vfork_exec.c
> @@ -32,7 +32,7 @@ static void *tcheck(void *_args)
>  
>  	for (i = 0; i < 2; i++) {
>  		_gettime(CLOCK_MONOTONIC, &tst, i);
> -		if (abs(tst.tv_sec - now->tv_sec) > 5) {
> +		if (labs(tst.tv_sec - now->tv_sec) > 5) {
>  			pr_fail("%s: in-thread: unexpected value: %ld (%ld)\n",
>  				args->tst_name, tst.tv_sec, now->tv_sec);
>  			return (void *)1UL;
> @@ -64,7 +64,7 @@ static int check(char *tst_name, struct timespec *now)
>  
>  	for (i = 0; i < 2; i++) {
>  		_gettime(CLOCK_MONOTONIC, &tst, i);
> -		if (abs(tst.tv_sec - now->tv_sec) > 5)
> +		if (labs(tst.tv_sec - now->tv_sec) > 5)
>  			return pr_fail("%s: unexpected value: %ld (%ld)\n",
>  					tst_name, tst.tv_sec, now->tv_sec);
>  	}
> 
> base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
> prerequisite-patch-id: b901ece2a5b78503e2fb5480f20e304d36a0ea27

-- 
BR,
Muhammad Usama Anjum

