Return-Path: <linux-kselftest+bounces-15988-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B1B95ACA6
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 06:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE9662832A8
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Aug 2024 04:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702FD3D38E;
	Thu, 22 Aug 2024 04:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="iifGeQpN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21C23776;
	Thu, 22 Aug 2024 04:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724302147; cv=pass; b=Ly4bDRu16BFB/pGH0/X0uLjjax6iYCqsIszimEXuQ1LEJHhBNbjzRodicjeM5gD4hbzYrahlQFL7t0rCS5xvj60VQepgOxXUSPEMA/uzaSofqceF1yK86FcNqIk/q3U/+2Yq8O/G9KPZ8z33kYt5y+NEAX50ePkxLUqwJZvGU2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724302147; c=relaxed/simple;
	bh=5dBVWyMJFOLY6LczPjuoq+vMAPbe8U9BdHH5gN0bJ8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BPFDYkA/pBlVEX9qrr+/wF1qtUJKhKxhVTNAs3uVXlL7mXkCuldmyK4KFr2pw1thI6UOZ7RzsWIOlH9Dxytn1vc6rVhIg7qRfMskM6XhGgta6vksz19qjGjmLei5PlB1uauQHCWRrRAPOBtmp1yI/lu3tZXIGLRxNkknZJw/dBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=iifGeQpN; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1724302138; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Qrelygl3WYDKCHc4WIQd8rSlbUULgYfR3lBJN679mWPVp06BUG96AepYbBPJSvWXui/yNeMasbms7sl79IUeI+pcdc2oLEvjbLCAGPO8eMIn127V9qMaqZpvHZk3M7sHXd8GoW8AZQtkyr2dYD6fpgSVZAIeCTM8f3sGp4Vw08w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724302138; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MKVnjeNqhOLvl5ZtR4WUgOtRDwUS8L6JXBA6uB/6hIQ=; 
	b=Svp00Vupwf8DCI57if1+ura6/PYRO8Q4hbgzCCrbgDTwnc+PoGSIC1XaiM1hfnxvE2wytgs9zCBkY0BspduEV95Y0UbuQaY9/Xm91JEbw8cIK4vXM1YW68EAqt5Jc4Ife3CZt7dCkBFFOZ+00Vqep62RLm3Z+KQCdD9m7zzaNuI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724302138;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MKVnjeNqhOLvl5ZtR4WUgOtRDwUS8L6JXBA6uB/6hIQ=;
	b=iifGeQpNnVlR8y13E/JPYk+rsmesyYRo4eN1uSFAPxCQp7eAKsUp9h+W3uwXBeYm
	7ddNTjZk1sVcWRKm8p7ADbNoAUTCIQKMvDi/62ADlzm708mA/8Nb0Tl1uVLOYDv/0YV
	XLQHiw5+nn7VEQ17uJ1Fcr0sLUNvXxg0+BNQbujU=
Received: by mx.zohomail.com with SMTPS id 172430213644657.83712784848478;
	Wed, 21 Aug 2024 21:48:56 -0700 (PDT)
Message-ID: <b24092fa-ed99-4373-a23f-a890969adcd8@collabora.com>
Date: Thu, 22 Aug 2024 09:48:47 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kernel@vger.kernel.org,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH 1/3] selftests/resctrl: Generalize non-contiguous CAT
 check
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Shuah Khan <shuah@kernel.org>, Reinette Chatre <reinette.chatre@intel.com>,
 linux-kselftest@vger.kernel.org
References: <20240813104515.19152-1-ilpo.jarvinen@linux.intel.com>
 <20240813104515.19152-2-ilpo.jarvinen@linux.intel.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240813104515.19152-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/13/24 3:45 PM, Ilpo Järvinen wrote:
> arch_supports_noncont_cat() checks if vendor is ARCH_AMD and if that is
> not true, ARCH_INTEL is assumed which might not be true either because
> get_vendor() can also return zero if neither AMD nor Intel is detected.
> 
> Generalize the vendor check using switch/case logic and return false
> for unknown vendors.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/resctrl/cat_test.c | 26 +++++++++++++---------
>  1 file changed, 16 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 742782438ca3..51a1cb6aac34 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -292,19 +292,25 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>  {
>  	unsigned int eax, ebx, ecx, edx;
>  
> -	/* AMD always supports non-contiguous CBM. */
> -	if (get_vendor() == ARCH_AMD)
> +	switch (get_vendor()) {
> +	case ARCH_AMD:
> +		/* AMD always supports non-contiguous CBM. */
>  		return true;
>  
> -	/* Intel support for non-contiguous CBM needs to be discovered. */
> -	if (!strcmp(test->resource, "L3"))
> -		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> -	else if (!strcmp(test->resource, "L2"))
> -		__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> -	else
> -		return false;
> +	case ARCH_INTEL:
> +		/* Intel support for non-contiguous CBM needs to be discovered. */
> +		if (!strcmp(test->resource, "L3"))
> +			__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> +		else if (!strcmp(test->resource, "L2"))
> +			__cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> +		else
> +			return false;
> +
> +		return ((ecx >> 3) & 1);
>  
> -	return ((ecx >> 3) & 1);
> +	default:
> +		return false;
> +	}
>  }
>  
>  static int noncont_cat_run_test(const struct resctrl_test *test,

-- 
BR,
Muhammad Usama Anjum


