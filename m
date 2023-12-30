Return-Path: <linux-kselftest+bounces-2528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B668203D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8CF328216F
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 06:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5526D6CA;
	Sat, 30 Dec 2023 06:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ZDLtXxlm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB9723A5;
	Sat, 30 Dec 2023 06:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703919411;
	bh=+OElTmrrmq2Aav7SM2X6Q9NUonp7GhK6Fak4brj5YJg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ZDLtXxlm6j7aJmqrzS3QlTM79Lts9zj0b8khTg6rB4LxhBNx5gW28K5JL3DemJEG2
	 obC6EXDrvuTxXvBfbc6ciprVvtNXmK9/vN0cWG8yiWmwq5z8aSiiKLQxMpZC6oMFRR
	 IyB24SstN/7WRFn1OEyT0U4z+VvF60STVPsej/UxBlCgnAmCW5BrMwqYQl93sR91RL
	 n01/pA/sAn/QKI/0ixLGyJcefz4Z6B0O5cf5FmZGWiuV/gQL69ARonS4laCiKELnON
	 J8O4C30mqTw506ge6o//k716tfTpAlM3/nVoJqtsWhbLf6U/mqo4z1XTp6+IT46ktZ
	 SxAjgjCXVH5fA==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4A1D378045F;
	Sat, 30 Dec 2023 06:56:47 +0000 (UTC)
Message-ID: <b9bfa260-779a-493c-814e-13295203a5c4@collabora.com>
Date: Sat, 30 Dec 2023 11:56:45 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] selftests/vDSO: Fix building errors on LoongArch
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231213012300.5640-1-yangtiezhu@loongson.cn>
 <20231213012300.5640-2-yangtiezhu@loongson.cn>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231213012300.5640-2-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/13/23 6:22 AM, Tiezhu Yang wrote:
> There exist the following errors when build vDSO selftests on LoongArch:
> 
>   # make headers && cd tools/testing/selftests/vDSO && make
>   ...
>   error: 'VDSO_VERSION' undeclared (first use in this function)
>   ...
>   error: 'VDSO_NAMES' undeclared (first use in this function)
> 
> We can see the following code in arch/loongarch/vdso/vdso.lds.S:
> 
> VERSION
> {
>         LINUX_5.10 {
>         global:
>                 __vdso_getcpu;
>                 __vdso_clock_getres;
>                 __vdso_clock_gettime;
>                 __vdso_gettimeofday;
>                 __vdso_rt_sigreturn;
>         local: *;
>         };
> }
> 
> so VDSO_VERSION should be 6 and VDSO_NAMES should be 1 for LoongArch,
> add them to fix the building errors on LoongArch.
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/vdso_config.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_config.h b/tools/testing/selftests/vDSO/vdso_config.h
> index cdfed403ba13..7b543e7f04d7 100644
> --- a/tools/testing/selftests/vDSO/vdso_config.h
> +++ b/tools/testing/selftests/vDSO/vdso_config.h
> @@ -53,15 +53,19 @@
>  #if __riscv_xlen == 32
>  #define VDSO_32BIT		1
>  #endif
> +#elif defined(__loongarch__)
> +#define VDSO_VERSION		6
> +#define VDSO_NAMES		1
>  #endif
>  
> -static const char *versions[6] = {
> +static const char *versions[7] = {
>  	"LINUX_2.6",
>  	"LINUX_2.6.15",
>  	"LINUX_2.6.29",
>  	"LINUX_2.6.39",
>  	"LINUX_4",
>  	"LINUX_4.15",
> +	"LINUX_5.10"
>  };
>  
>  static const char *names[2][6] = {

-- 
BR,
Muhammad Usama Anjum

