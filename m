Return-Path: <linux-kselftest+bounces-40629-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5D7B40B3B
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 18:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25AF83BEE67
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 16:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26B933EB0F;
	Tue,  2 Sep 2025 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AFEF74jY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B7C2F6594
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 16:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756832121; cv=none; b=bpI6iixo3GnWNS2O8eaGDml2a9lc9KOgC8UrFOS0NKOESmW589Hwts0kbaCLehXl+IOpWFqUPJLN/Jownk7cgK2tF96ufMWEiv/W/YWoXftFwoY3p8KtO4B7iHjbBL6E2fSTJaEB6QXGcQNMTmxgjEJ+LW+lEQWdwaeq/etGqjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756832121; c=relaxed/simple;
	bh=dUzqaLLsvlk+kHmoFCR7c9Yn4zMIi9+At7mA5hjlXVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MBoBhnj3AuNEq3W7OjhkjSwLfr38OdZ6tPp3Tdwg0kHPE2YxTU6iqn/wM+3Gv52hnTIJL9jAW1qNrX1EAYQLmn7O4qEXURA8bxi44eQUnsmNwfZs+5T4Pu5G7hW4sjDHL6QiAcNVbNdJz4aZQeNWDReNqNnqncvyjf5mPsvSsWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AFEF74jY; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e960900d-3811-4b8b-b4b3-bb23048ef5d6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756832105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDmFle6NNRHHxvk9SFX7P01CsUfGYQB8JSdA3p8i0w4=;
	b=AFEF74jY87dxIniW/EuXY7tPRDaxdUOHDklysZdySYCT7Rmui0QN2XWgPC435v1gJyxvRw
	976FU1oNrsvWB/BVoG9sYG/8Qe1ERdgKRbB0LDqKkgKqJSUafovOJHulLL4doCDXGaUDqz
	immszZilaVgVhgf8lxPTf5PBL4GHRjc=
Date: Tue, 2 Sep 2025 09:54:54 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_strcasecmp kfunc
Content-Language: en-GB
To: Rong Tao <rtoax@foxmail.com>, andrii@kernel.org, ast@kernel.org,
 vmalik@redhat.com
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1756804522.git.rtoax@foxmail.com>
 <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <tencent_0E0C830021A02CBCCB6D95AE57CFD100C407@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 9/2/25 2:19 AM, Rong Tao wrote:
> From: Rong Tao <rongtao@cestc.cn>
>
> bpf_strcasecmp() function performs same like bpf_strcmp() except ignoring
> the case of the characters.
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>   kernel/bpf/helpers.c | 68 +++++++++++++++++++++++++++++++-------------
>   1 file changed, 48 insertions(+), 20 deletions(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 401b4932cc49..238fd992c786 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3349,45 +3349,72 @@ __bpf_kfunc void __bpf_trap(void)
>    * __get_kernel_nofault instead of plain dereference to make them safe.
>    */
>   
> -/**
> - * bpf_strcmp - Compare two strings
> - * @s1__ign: One string
> - * @s2__ign: Another string
> - *
> - * Return:
> - * * %0       - Strings are equal
> - * * %-1      - @s1__ign is smaller
> - * * %1       - @s2__ign is smaller
> - * * %-EFAULT - Cannot read one of the strings
> - * * %-E2BIG  - One of strings is too large
> - * * %-ERANGE - One of strings is outside of kernel address space
> - */
> -__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)

The function __bpf_strcasecmp should be a static function.

>   {
>   	char c1, c2;
>   	int i;
>   
> -	if (!copy_from_kernel_nofault_allowed(s1__ign, 1) ||
> -	    !copy_from_kernel_nofault_allowed(s2__ign, 1)) {
> +	if (!copy_from_kernel_nofault_allowed(s1, 1) ||
> +	    !copy_from_kernel_nofault_allowed(s2, 1)) {
>   		return -ERANGE;
>   	}
>   
>   	guard(pagefault)();
>   	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> -		__get_kernel_nofault(&c1, s1__ign, char, err_out);
> -		__get_kernel_nofault(&c2, s2__ign, char, err_out);
> +		__get_kernel_nofault(&c1, s1, char, err_out);
> +		__get_kernel_nofault(&c2, s2, char, err_out);
> +		if (ignore_case) {
> +			c1 = tolower(c1);
> +			c2 = tolower(c2);
> +		}
>   		if (c1 != c2)
>   			return c1 < c2 ? -1 : 1;
>   		if (c1 == '\0')
>   			return 0;
> -		s1__ign++;
> -		s2__ign++;
> +		s1++;
> +		s2++;
>   	}
>   	return -E2BIG;
>   err_out:
>   	return -EFAULT;
>   }
>   
> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +}
> +
> +/**
> + * bpf_strcasecmp - Compare two strings, ignoring the case of the characters
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
> +{
> +	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +}
> +
>   /**
>    * bpf_strnchr - Find a character in a length limited string
>    * @s__ign: The string to be searched
> @@ -3832,6 +3859,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>   #endif
>   BTF_ID_FLAGS(func, __bpf_trap)
>   BTF_ID_FLAGS(func, bpf_strcmp);
> +BTF_ID_FLAGS(func, bpf_strcasecmp);
>   BTF_ID_FLAGS(func, bpf_strchr);
>   BTF_ID_FLAGS(func, bpf_strchrnul);
>   BTF_ID_FLAGS(func, bpf_strnchr);


