Return-Path: <linux-kselftest+bounces-8151-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC748A6DBB
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 16:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6591C22938
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 14:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D220B12FB10;
	Tue, 16 Apr 2024 14:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xvyadDZY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709B12D757;
	Tue, 16 Apr 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713276678; cv=none; b=sIcCj9WLWSmYi+f50oqGFS1hekBqBiylc5ncQJhk6U3BDAIsXmH3mSRzaffqxzk+VQFRjt+sPqQsSTXBlGS7NSmwCr7iNWcpKSaBlJpBFK9SV7xlTdMPYCMkWwcQVMZND3oZ353yvHfXuIWIjauvukiVmZuPR97SrraMw4cMmUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713276678; c=relaxed/simple;
	bh=lBX4NJaGUPxlRyv+fZ66xHNmQuwj7oNNQtO+Tn+dwxA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZLkW0Kf9WoLQOf9qWBKQP5o8yE1WyhMr4ycXfGC0MPjydtp74eauqetTPN2WWpICEArAUu8o6c5qPvamPc3DU0RPHPpI1lmHAwjyya9VnSysf/7mDYkecI1xFMaPZzJPF98ZjvCOfGTvY8JcyC/3GHD+axFJsvC1lHWP2VfVF5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xvyadDZY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713276671;
	bh=lBX4NJaGUPxlRyv+fZ66xHNmQuwj7oNNQtO+Tn+dwxA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=xvyadDZY5lUYMI/GC2dN0DkBZBWOJcvsVVlZp6hG7Rg+M2yMrd6TudCv1/nxeJO4I
	 w8ZYNQFpWfJTOWEf1923bAHobmO5UiJrlkREPMS8iWJOgbd10eJnxaMLeiTC3DHWk6
	 LOOLeRd/v6/gPecdh5Wfps+nDY9zqHsSbTV0Twg3pazLNsLl1Y89v+zrca6Jl96jPk
	 yFugCgEQA83V576p0NiEqQzrAMBwM12H7o2ACuS7RV2c2O17mpnYlxuJKPwnnPzrrv
	 o9VpV5dGreXzWIcVCLx0KqFJ8BI4UYdxIqasKzXfbioTDhQj/q3nYHzzCHG+8gUpqU
	 COKlk+mHqZ5Kw==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 33F313782141;
	Tue, 16 Apr 2024 14:11:07 +0000 (UTC)
Message-ID: <8859fafe-2df1-42ba-b9de-2ba1c0e75d14@collabora.com>
Date: Tue, 16 Apr 2024 19:11:39 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, linux-kselftest@vger.kernel.org,
 mic@digikod.net, linux-security-module@vger.kernel.org,
 jakub@cloudflare.com, davem@davemloft.net
Subject: Re: [PATCH v4 10/12] selftests: kselftest_harness: let PASS / FAIL
 provide diagnostic
To: Jakub Kicinski <kuba@kernel.org>, keescook@chromium.org,
 shuah@kernel.org, Nathan Chancellor <nathan@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
References: <20240229005920.2407409-1-kuba@kernel.org>
 <20240229005920.2407409-11-kuba@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240229005920.2407409-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/29/24 5:59 AM, Jakub Kicinski wrote:
> Switch to printing KTAP line for PASS / FAIL with ksft_test_result_code(),
> this gives us the ability to report diagnostic messages.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5b0592e4b7a4..b643a577f9e1 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1143,14 +1143,13 @@ void __run_test(struct __fixture_metadata *f,
>  
>  	if (t->results->reason[0])
>  		diagnostic = t->results->reason;
> +	else if (t->exit_code == KSFT_PASS || t->exit_code == KSFT_FAIL)
> +		diagnostic = NULL;
>  	else
>  		diagnostic = "unknown";
>  
> -	if (t->exit_code == KSFT_SKIP)
> -		ksft_test_result_code(t->exit_code, test_name,
> -				      "%s", diagnostic);
> -	else
> -		ksft_test_result(__test_passed(t), "%s\n", test_name);
> +	ksft_test_result_code(t->exit_code, test_name,
> +			      diagnostic ? "%s" : "", diagnostic);
We are getting the following annoying warning while using clang:

./../kselftest_harness.h:1207:30: warning: format string is empty
[-Wformat-zero-length]
 1207 |            diagnostic ? "%s" : "", diagnostic);
      |                                 ^~
1 warning generated.

I've tried to look for solution. In my opinion, the best solution would be
to just revert this patch. Any thoughts?

>  }
>  
>  static int test_harness_run(int argc, char **argv)

-- 
BR,
Muhammad Usama Anjum

