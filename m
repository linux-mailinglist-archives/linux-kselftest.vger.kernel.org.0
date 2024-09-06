Return-Path: <linux-kselftest+bounces-17366-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6391896EC0F
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 09:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00989B20C5C
	for <lists+linux-kselftest@lfdr.de>; Fri,  6 Sep 2024 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB1914A604;
	Fri,  6 Sep 2024 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="GcKQXbhy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E5617C9B;
	Fri,  6 Sep 2024 07:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725608131; cv=pass; b=Rsj/yX219dHd6SAUJjjBAuYcAZ3StGIHHoKDoqji95HVM3Z2n435rxLbL7JoxDb0fijEJ/hmcqdtSeeRtvWZfY6dHMcmAYhCYt29FouZwP8RG3PiwhpBb6igY83tiZr/nGbcRSQy+OoCqtI/rTg2ywtCojafRcnynpI9aEN7mrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725608131; c=relaxed/simple;
	bh=5aF5bYiarcRj1XxZVX6A2LZgn96Z1jeWp3pgLJxBIz4=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FuAjon6iELLNTWV7/233fZNQFJ+H2C79H+WOUhVdIzG3owRlAhakmruFjoWv9hPry172jCfeEY7YxBem4YRDDDrGzK6A4E58nhIvFf34gqzIyXvKzF5T1VExetIMP6zX7HFfr808KQvvb/mFJ8WqiGz1qBrzeZb7hQo8G4JUrTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=GcKQXbhy; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: Usama.Anjum@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1725608124; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LndPC0Izogm9avH8SOF9DLPPHI6YIiX2l0cMgdxwSfKPTtxGcL4S2m5M9dCIhDkbgUiKZhRzV0ZKAT+Nel+87Td+pfck0b2LdJnHpJA2kYpPTUTdgFprOHJiAPmJgpCXS/5IOu0jaw+7dd7Jbw2jboJ5YShHLM05ZGTWGfrKCtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1725608124; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pEwUbiM//of1AB1j8Nhr4O0R1ToKKHIhcCiDJdTozOw=; 
	b=G0ZzRWmBoUKEVsPl2UetmuSQPmxv0cmGAxx3WWuTvcDWHn1Rwmb/TLR/UGNuzZQtdj0ZfJl1NcNiKAhpqFA45MlHZvY08I7kI0IxdUfiDzCA3IffcAnNnqdEHtvhhhqBD5Bto1gUDbSqvKJ2MkLxoz3PuxeAO7uYh/dNF1PYnnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1725608124;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=pEwUbiM//of1AB1j8Nhr4O0R1ToKKHIhcCiDJdTozOw=;
	b=GcKQXbhy7OjVca0HMFFhMH+aA1cbhT53K0winv1mMBynQqL7dwsBogjRUURE0xVh
	fTaf48AVSz8eKfvF4fTgO/T/DKv9PcxHOHOgKtpiRQFVmEGrNIdYGmLeayyFqpDKZVX
	kwu+OfBui0eed6WutzjJqSceJPhKT3JN2WTXNi3Y=
Received: by mx.zohomail.com with SMTPS id 1725608121594363.4890217236482;
	Fri, 6 Sep 2024 00:35:21 -0700 (PDT)
Message-ID: <ad3d035e-be82-44c4-a850-a33889fcf717@collabora.com>
Date: Fri, 6 Sep 2024 12:35:14 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests:resctrl: Fix build failure on archs without
 __cpuid_count()
To: Shuah Khan <skhan@linuxfoundation.org>, shuah@kernel.org,
 fenghua.yu@intel.com, reinette.chatre@intel.com,
 ilpo.jarvinen@linux.intel.com
References: <20240905180231.20920-1-skhan@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240905180231.20920-1-skhan@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Shuah,

Thank you for fixing it.

On 9/5/24 11:02 PM, Shuah Khan wrote:
> When resctrl is built on architectures without __cpuid_count()
> support, build fails. resctrl uses __cpuid_count() defined in
> kselftest.h.
> 
> Even though the problem is seen while building resctrl on aarch64,
> this error can be seen on any platform that doesn't support CPUID.
> 
> CPUID is a x86/x86-64 feature and code paths with CPUID asm commands
> will fail to build on all other architectures.
> 
> All others tests call __cpuid_count() do so from x86/x86_64 code paths
> when _i386__ or __x86_64__ are defined. resctrl is an exception.
> 
> Fix the problem by defining __cpuid_count() only when __i386__ or
> __x86_64__ are defined in kselftest.h and changing resctrl to call
> __cpuid_count() only when __i386__ or __x86_64__ are defined.
> 
> In file included from resctrl.h:24,
>                  from cat_test.c:11:
> In function ‘arch_supports_noncont_cat’,
>     inlined from ‘noncont_cat_run_test’ at cat_test.c:326:6:
> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>    74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>       |         ^~~~~~~
> cat_test.c:304:17: note: in expansion of macro ‘__cpuid_count’
>   304 |                 __cpuid_count(0x10, 1, eax, ebx, ecx, edx);
>       |                 ^~~~~~~~~~~~~
> ../kselftest.h:74:9: error: impossible constraint in ‘asm’
>    74 |         __asm__ __volatile__ ("cpuid\n\t"                               \
>       |         ^~~~~~~
> cat_test.c:306:17: note: in expansion of macro ‘__cpuid_count’
>   306 |                 __cpuid_count(0x10, 2, eax, ebx, ecx, edx);
> 
> Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Reported-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
LGTM
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

...
> diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
> index 742782438ca3..ae3f0fa5390b 100644
> --- a/tools/testing/selftests/resctrl/cat_test.c
> +++ b/tools/testing/selftests/resctrl/cat_test.c
> @@ -290,12 +290,12 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
>  
>  static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>  {
> -	unsigned int eax, ebx, ecx, edx;
> -
>  	/* AMD always supports non-contiguous CBM. */
>  	if (get_vendor() == ARCH_AMD)
>  		return true;
>  
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	unsigned int eax, ebx, ecx, edx;
>  	/* Intel support for non-contiguous CBM needs to be discovered. */
>  	if (!strcmp(test->resource, "L3"))
>  		__cpuid_count(0x10, 1, eax, ebx, ecx, edx);
> @@ -305,6 +305,8 @@ static bool arch_supports_noncont_cat(const struct resctrl_test *test)
>  		return false;
>  
>  	return ((ecx >> 3) & 1);
> +#endif /* end arch */
> +	return false;
nit: empty line before return

>  }
>  
>  static int noncont_cat_run_test(const struct resctrl_test *test,

-- 
BR,
Muhammad Usama Anjum


