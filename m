Return-Path: <linux-kselftest+bounces-8176-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B5A8A6FB8
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 17:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819231C20A1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B31311AA;
	Tue, 16 Apr 2024 15:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n0QqIdjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE058130A76;
	Tue, 16 Apr 2024 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281042; cv=none; b=oNYUaTQ/W6hVGFgzo3Od34jPDVoTDxnl6r8sQYNXbpwhd/sWnWXjURrMU/bOrXM6OvT8BqLuZQxIdTp1CccwLsMZeIpNhmah/iQjjF3Yt7ujhvRDWaZLIyyIKCSO1VY7DTZxt0zD90kOqxzMVWZqwIQkkOGY83BULRxPQcknjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281042; c=relaxed/simple;
	bh=2Apvcqo+npWh1kmd85nRE49yYcpp9IRrnNWCH7LYGvc=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CydUxbyX1xAiXdJbVEDKEoh6VaknINgK2A64gLLzLO7LR2fKNpmgOgn892nmNxYO5xWAgO4U/AwiL8dUeQ/hJ7JDYvR5pTD/xwFBGQnODG/EYOeAO1Shj8O7+9OmbZB3tJWycpyGT7pfRenkyCbaCxvudlTyT/exkJpKkiMS5iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n0QqIdjD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713281039;
	bh=2Apvcqo+npWh1kmd85nRE49yYcpp9IRrnNWCH7LYGvc=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=n0QqIdjDQiB1FXr0EtttGGHeNKXeZtHLAleO/pCRthxUbmSVtrizxk4BYcNAKEU2B
	 FL+Lzc69N/Ua7AHimjjANaJIMGMAOEYi5r1DCqIHk/CkwlW1Qv3eP7JZ8YO7WqbKCc
	 e/W2f//K7UXs29HOlpul66kdtaKIBWtKdv1syqWSnPwp16jkpye9U+9DBfJ4kkxQ1R
	 5IkEVdjEXfI8It5xQK6poaFR8PtxgswJzNJmKPUILisjzCaDBgYVruXOttnn/a7WGx
	 do44YksV2OAGykNkgcj3vwbFiwXpH/stC7dpBLlnedeBVUrfzBzo7jW2gLJ93SfU+V
	 20fWLeunP2tAg==
Received: from [10.193.1.1] (broslavsky.collaboradmins.com [68.183.210.73])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CED1337804B2;
	Tue, 16 Apr 2024 15:23:56 +0000 (UTC)
Message-ID: <dffe0854-b242-472f-aaa6-6281721d95d5@collabora.com>
Date: Tue, 16 Apr 2024 20:24:29 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com,
 Sean Christopherson <seanjc@google.com>, shuah@kernel.org,
 keescook@chromium.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net] selftests: kselftest_harness: fix Clang warning about
 zero-length format
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
References: <20240416151048.1682352-1-kuba@kernel.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20240416151048.1682352-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/24 8:10 PM, Jakub Kicinski wrote:
> Apparently it's more legal to pass the format as NULL, than
> it is to use an empty string. Clang complains about empty
> formats:
> 
> ./../kselftest_harness.h:1207:30: warning: format string is empty
> [-Wformat-zero-length]
>  1207 |            diagnostic ? "%s" : "", diagnostic);
>       |                                 ^~
> 1 warning generated.
> 
> Reported-by: Sean Christopherson <seanjc@google.com>
> Link: https://lore.kernel.org/all/20240409224256.1581292-1-seanjc@google.com
> Fixes: 378193eff339 ("selftests: kselftest_harness: let PASS / FAIL provide diagnostic")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
> ---
> CC: shuah@kernel.org
> CC: keescook@chromium.org
> CC: usama.anjum@collabora.com
> CC: linux-kselftest@vger.kernel.org
> CC: llvm@lists.linux.dev
> ---
>  tools/testing/selftests/kselftest.h         | 10 ++++++----
>  tools/testing/selftests/kselftest_harness.h |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
> index 541bf192e30e..4eca3fd1292c 100644
> --- a/tools/testing/selftests/kselftest.h
> +++ b/tools/testing/selftests/kselftest.h
> @@ -288,15 +288,17 @@ void ksft_test_result_code(int exit_code, const char *test_name,
>  	}
>  
>  	/* Docs seem to call for double space if directive is absent */
> -	if (!directive[0] && msg[0])
> +	if (!directive[0] && msg)
>  		directive = " #  ";
>  
> -	va_start(args, msg);
>  	printf("%s %u %s%s", tap_code, ksft_test_num(), test_name, directive);
>  	errno = saved_errno;
> -	vprintf(msg, args);
> +	if (msg) {
> +		va_start(args, msg);
> +		vprintf(msg, args);
> +		va_end(args);
> +	}
>  	printf("\n");
> -	va_end(args);
>  }
>  
>  static inline int ksft_exit_pass(void)
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 4fd735e48ee7..adb15cae79ab 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -1202,7 +1202,7 @@ void __run_test(struct __fixture_metadata *f,
>  		diagnostic = "unknown";
>  
>  	ksft_test_result_code(t->exit_code, test_name,
> -			      diagnostic ? "%s" : "", diagnostic);
> +			      diagnostic ? "%s" : NULL, diagnostic);
>  }
>  
>  static int test_harness_run(int argc, char **argv)

-- 
BR,
Muhammad Usama Anjum

