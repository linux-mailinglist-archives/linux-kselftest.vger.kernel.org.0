Return-Path: <linux-kselftest+bounces-22462-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613239D6410
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 19:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 267872820FD
	for <lists+linux-kselftest@lfdr.de>; Fri, 22 Nov 2024 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391091DF756;
	Fri, 22 Nov 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnjwPmmY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EED01DF742;
	Fri, 22 Nov 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299582; cv=none; b=q6OmjrTUsIu4QTJfUnAScMYy68SnnMNysTKiAUc/LAibNLuAHM9N/dIcvACPxiRs63f0MJKyoPNbGGKGd6Q3wEbKJCPTrp66spAUShqkSNhI3IziGqp48RsrXpKKQzCvbKjXsJkElHSP1t08mX/N7OPplJItN/sZotgr+fo8XDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299582; c=relaxed/simple;
	bh=ku+i0HURYtpeTbYirjvl2u16eOV+mdd+EyHBWMFHYyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eFugFDSpc2zRtekzapK7EVfOtEKoR5llvr4uSJGwBT2tlFG8INO9I3CDOMdgK0RncB1pQ8D12YnWJCtywH1wvrvWMxqbpsN8NF4IGxf+DngDg6W6uJNpYSlulnaAvXkw4jsbF17/3m838Pbx2qwy+W1DgEKk6MYheLjaCnNY6XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnjwPmmY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992DAC4CED0;
	Fri, 22 Nov 2024 18:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732299581;
	bh=ku+i0HURYtpeTbYirjvl2u16eOV+mdd+EyHBWMFHYyI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HnjwPmmYQceZQuRYcqq4y/NKGDlKWJwA+B+412YCI0E/7Zl5Ln64Ry4OkhGXu/Wv5
	 7VzV+6gusi0D5aB9Op+G19UAO/nBL4Q7lD8d27qdy3UitxxRWPfkhKe01cSjqjvpQV
	 gx3jvKTNgs6VaFlHzBTGyBUGFA3XuZrS0h7KtKd9KJuVDJtMKCKSpVq5uAFXsYSDXG
	 IKI6nXt0EQl5rDrkBiPEEMwooB0y6N6j44yRsWIvoUgbmRUT7KuKlx53N+M2mzGXiN
	 Pg9S57o1lqz8rx8edxrJnkvjrXlSg4WpJ9PFC7NKMi8J/poyU3wnzR5/90QJs+lQuL
	 swj8MT29WETBQ==
Message-ID: <46dbd308-8af1-4a6d-91ec-82981e867ff4@kernel.org>
Date: Fri, 22 Nov 2024 11:19:41 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests: Warn about skipped tests in result summary
To: Laura Nao <laura.nao@collabora.com>, shuah@kernel.org
Cc: gregkh@linuxfoundation.org, nfraprado@collabora.com,
 usama.anjum@collabora.com, robh@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20241122155548.55495-1-laura.nao@collabora.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <20241122155548.55495-1-laura.nao@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/24 08:55, Laura Nao wrote:
> Update the functions that print the test totals at the end of a selftest
> to include a warning message when skipped tests are detected. The
> message advises users that skipped tests may indicate missing
> configuration options and suggests enabling them to improve coverage.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
> This patch follows up on a previous discussion[1] and aims to highlight
> skipped tests for the user's attention.
> 
> [1] https://lore.kernel.org/lkml/2bb2d338-cd00-4ac2-b8bd-5579eae82637@linuxfoundation.org/
> ---
>   tools/testing/selftests/kselftest.h               | 4 ++++
>   tools/testing/selftests/kselftest/ksft.py         | 3 +++
>   tools/testing/selftests/kselftest/ktap_helpers.sh | 4 ++++
>   3 files changed, 11 insertions(+)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 29fedf609611..d3f64b333acd 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -147,6 +147,10 @@ static inline void ksft_set_plan(unsigned int plan)
>   
>   static inline void ksft_print_cnts(void)
>   {
> +	if (ksft_cnt.ksft_xskip > 0)
> +		printf(
> +			"# Skipped tests detected. Consider enabling relevant config options to improve coverage.\n"

I like this. How about printing the number of skipped tests in this
message also to make it easy to parse.

Same comment on other print messages,

> +		);
>   	if (ksft_plan != ksft_test_num())
>   		printf("# Planned tests != run tests (%u != %u)\n",
>   			ksft_plan, ksft_test_num());
> diff --git a/tools/testing/selftests/kselftest/ksft.py b/tools/testing/selftests/kselftest/ksft.py
> index bf215790a89d..7675a15a1264 100644
> --- a/tools/testing/selftests/kselftest/ksft.py
> +++ b/tools/testing/selftests/kselftest/ksft.py
> @@ -27,6 +27,9 @@ def set_plan(num_tests):
>   
>   
>   def print_cnts():
> +    if ksft_cnt['skip'] > 0:
> +        print("# Skipped tests detected. Consider enabling relevant config options to improve coverage.")
> +
>       print(
>           f"# Totals: pass:{ksft_cnt['pass']} fail:{ksft_cnt['fail']} xfail:0 xpass:0 skip:{ksft_cnt['skip']} error:0"
>       )
> diff --git a/tools/testing/selftests/kselftest/ktap_helpers.sh b/tools/testing/selftests/kselftest/ktap_helpers.sh
> index 79a125eb24c2..a4211221ccd6 100644
> --- a/tools/testing/selftests/kselftest/ktap_helpers.sh
> +++ b/tools/testing/selftests/kselftest/ktap_helpers.sh
> @@ -107,5 +107,9 @@ ktap_finished() {
>   }
>   
>   ktap_print_totals() {
> +	if [ "$KTAP_CNT_SKIP" -gt 0 ]; then
> +		echo "# Skipped tests detected. " \
> +			"Consider enabling relevant config options to improve coverage."
> +	fi
>   	echo "# Totals: pass:$KTAP_CNT_PASS fail:$KTAP_CNT_FAIL xfail:0 xpass:0 skip:$KTAP_CNT_SKIP error:0"
>   }

thanks,
-- Shuah

