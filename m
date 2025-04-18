Return-Path: <linux-kselftest+bounces-31155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB77A93B80
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 18:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514C01B62FAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 16:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673C0217654;
	Fri, 18 Apr 2025 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="XZzV/m7D"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F5F421764B;
	Fri, 18 Apr 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995492; cv=pass; b=UoYKmZXDeG1Jw0rfSbR5lSEZMVmDJBD+/9pHTirFsE9eGGFj6SoBbiLwmlci26SGEr4/z6JpoSRBl1w8NQBIrMCFUOdQ9G1RTr22tOhRsavca2uF/xEksXnWF68knUCTs1VUII4aAIksWYPOEGRHb1A2GaY9GAVkCJYYVohjLhI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995492; c=relaxed/simple;
	bh=wjXubvx8JdOcTVPixIIdePGjVK2RbRf8Og/Dj3+hU8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o5P7OFz+7gC/vqDJJExAN5v0R987NAdlUGLddKfXPtYKcv0pXNVeA1IzfIvYBGLfKtFLnYX0DB1Cn4OP9nTOrvkvmXzJF6t/anKBeI/kN9q1Vaf7mpuwu9S457trLqgKm8UuI58R4HqI/VtQB4mk1+Oufiuj7CI+uCbpZsOZQLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=XZzV/m7D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744995453; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=USiBPdEpIaKO0CbACHG6igaTEaDKjvYXvQ0hlvgU3wFZeRZw/gW9wVGyfjJVx8CXbhBW7U7FQpFlCbEpWo+nop85X7ci5ZnioPneF21FiX2+g+pUtGkt5bd3ir57UmGHz0EIJWD0ZK50xCo27gRIL6/6hZ3NSJXdtEZSmwiD0+o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744995453; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sJKFImHbw53BXlav6D+YRkt/sKudnU5/GTTAs3xOorc=; 
	b=jQYb2zQXf5xpAgdByb+D24KpdVkBod13UI56ONYAF01f1sL5Aar9CJaqUzkheQHJYaYZXYH78EMOucVgYTxHK+6i9yb4evpRMxPuqyFQYad/K8xuVyBrxqLtiY9hjBSioiWuv3Msa/mNPZl0NtvmBq2no6UjUW4mWuJRf5HkaOo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744995453;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=sJKFImHbw53BXlav6D+YRkt/sKudnU5/GTTAs3xOorc=;
	b=XZzV/m7DpHsxsJMpWL1ySqTDbJUfSWhmkB/oBsAo00vi4jQHoOOrqaNgMVDrrtkJ
	da1hqv4I59zZfMSnJz6Ish0DV9TFBtAoh+O7zXC5F4rq2F1kd4iuBcdsJB53kWTVJ4H
	8HfklXZ4CaUC7NX7AJhcg+/9fGRumikEYIl3L0pI=
Received: by mx.zohomail.com with SMTPS id 1744995452055136.0748644471705;
	Fri, 18 Apr 2025 09:57:32 -0700 (PDT)
Message-ID: <746df70d-b8de-465a-86a5-44a23486af40@collabora.com>
Date: Fri, 18 Apr 2025 21:57:26 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/32] selftests: harness: Ignore unused variant
 argument warning
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-3-4d9c0295893f@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-3-4d9c0295893f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 2:00 PM, Thomas Weißschuh wrote:
> For tests without fixtures the variant argument is unused.
> This is intentional, prevent to compiler from complaining.
> 
> Example warning:
> 
>     harness-selftest.c: In function 'wrapper_standalone_pass':
>     ../kselftest_harness.h:181:52: error: unused parameter 'variant' [-Werror=unused-parameter]
>       181 |                 struct __fixture_variant_metadata *variant) \
>           |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>     ../kselftest_harness.h:156:25: note: in expansion of macro '__TEST_IMPL'
>       156 | #define TEST(test_name) __TEST_IMPL(test_name, -1)
>           |                         ^~~~~~~~~~~
>     harness-selftest.c:15:1: note: in expansion of macro 'TEST'
>        15 | TEST(standalone_pass) {
>           | ^~~~
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest_harness.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index bac4327775ea65dbe977e9b22ee548bedcbd33ff..2b350ed60b2bf1cbede8e3a9b4ac5fe716900144 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -174,7 +174,7 @@
>  	static void test_name(struct __test_metadata *_metadata); \
>  	static inline void wrapper_##test_name( \
>  		struct __test_metadata *_metadata, \
> -		struct __fixture_variant_metadata *variant) \
> +		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
>  	{ \
>  		_metadata->setup_completed = true; \
>  		if (setjmp(_metadata->env) == 0) \
> 


-- 
Regards,
Usama

