Return-Path: <linux-kselftest+bounces-32195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56928AA7415
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 129891BC050C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF205255E55;
	Fri,  2 May 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="BdCZommH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A709255E2B;
	Fri,  2 May 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193500; cv=pass; b=VJbwLfsAzGNtYc8CH8MlmkDhKf+6GGFvMp1HDh2WbNbAalgnUkZ7Zd7OyzC7nq2CyHgV20a0is0GA7zK91n+t/DFnW1vDdDo4IKkSNrUuiVRMRZJVoC2tck4AwG3LqyGhumxb0GXnYcPKAEQJiMAK0r9u4z1RKAB+mlMdFQouAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193500; c=relaxed/simple;
	bh=hlMTXh8Sb5JBp2Hi28m9ieB78infImEPVVJT8s+zO/Y=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bk+kglwGF3fgRIJbtpXBVMY+d9clWg/1Cy9JOGzGmHNX/rrNhfGkn3hxFeabWsJo1XQARzdMYtnEgw1D2naYbkvAOq0JNbeTz8qsR7liYb9VQyTuuYbpc1LkhCdMMAMQzNTxMfPdNYcszRFaxmTlmBEXrBvmALrcyDIzTDVnbZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=BdCZommH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193489; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aFTs1LYlszuwZSqjPlyTpl+G/oiov+KLlpSv33V1bejHw+1G+hajCDOdfZ4aBnYqAGNUOcb96fTCH4PiESlVl4MtjsUuACjjjtmpsEFCTvxvhGEheKqhttLOt0n0SFZJ3RiCi6UiLbdgzdSvr+nS61PjEq8OP6Q15Ydvm2lPTmM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193489; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tcIrRIN3loF/w+Qza67n1XAiigXUU/UsKhmU0+IWq9w=; 
	b=SYNrg8wgIlCKtmutSwhQOCrsfwziiMbg0N+b9SI+8IjsRshYqHuqCM8QkmXjMIp4WLLb/KzrBeEBcpA4lJ0pk6Y7u7Puv9SuqmvRhYJWQKk8wK6vk3m7RRhAZ4iPrXXUA9NlYqASmf/X6PJCKdHUb1hVuUr9STexqoqm3l382cQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193489;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tcIrRIN3loF/w+Qza67n1XAiigXUU/UsKhmU0+IWq9w=;
	b=BdCZommHKFniJ3BbYD3YDaLVazKRfyHeMVN0l0r7uYv6mLVvaGoz7pcCjWgI6N5Q
	9Ahbd8ubYJGUasJ6AYc5oLC6IWUG+S6pyrYF5Dny/HoGQr23pT5acI2EZZDJF5GKJjS
	CwLc/1SINEDOxwv8AusT6jXXqQeUwtX8HFSgfDSs=
Received: by mx.zohomail.com with SMTPS id 1746193487126290.6967342499622;
	Fri, 2 May 2025 06:44:47 -0700 (PDT)
Message-ID: <1f2288d9-6829-4af2-9b58-4c68eecbb777@collabora.com>
Date: Fri, 2 May 2025 18:44:41 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 3/7] selftests: vDSO: vdso_test_correctness: Fix
 -Wold-style-definitions
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-3-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-3-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> Functions definitions without any argument list produce a warning with
> -Wold-style-definition:
> 
> vdso_test_correctness.c:111:13: warning: old-style function definition [-Wold-style-definition]
>   111 | static void fill_function_pointers()
>       |             ^~~~~~~~~~~~~~~~~~~~~~
This warning doesn't appear on my side. Are you using extra compiler
flags? If yes, please add them to the Makefile.

> 
> Explicitly use an empty argument list.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  tools/testing/selftests/vDSO/vdso_test_correctness.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_correctness.c b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> index 5fb97ad67eeaf17b6cfa4f82783c57894f03e5c5..da651cf53c6ca4242085de109c7fc57bd807297c 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_correctness.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_correctness.c
> @@ -108,7 +108,7 @@ static void *vsyscall_getcpu(void)
>  }
>  
>  
> -static void fill_function_pointers()
> +static void fill_function_pointers(void)
>  {
>  	void *vdso = dlopen("linux-vdso.so.1",
>  			    RTLD_LAZY | RTLD_LOCAL | RTLD_NOLOAD);
> 


-- 
Regards,
Usama

