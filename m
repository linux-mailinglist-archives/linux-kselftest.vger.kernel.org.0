Return-Path: <linux-kselftest+bounces-31156-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD75FA93B8A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A622B4615AC
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46796213244;
	Fri, 18 Apr 2025 17:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="PVpSCnLC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733CE2144D6;
	Fri, 18 Apr 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995633; cv=pass; b=btAxbycRqp47k+8QecoMh+tbAvm219Wu56HHs3StwHgz+QGIh+s+9CK577hVxM1v7omqFup+pWc/YiFUowZg9frESuSGbmTrAj37YJoIveA2BAo+Mxv0xTesYVDay/2Qw1H5K4YyQkbC2UARXxEZQlx3WS1aWI41x8JgI5DjXGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995633; c=relaxed/simple;
	bh=xktUs2v9KD5eUgHu2Ln2vol8RxOCZC31KIr4DrmFaxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnS5mKnd5cTv6xm7BYBoJl/FPbBHDOyi59zdfBC3lOaczkJVbrhCKozCjFGwa5QiG6faEPgNg80uI6u55v9yZsyivFBu2AKvlXBNxyIyyf4ba7yGZGkqbem/gfpdgEPHrAVNtHMIK4avwngm/hlVvyIURw8p0TBhnRED3I/kzlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=PVpSCnLC; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744995597; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TABNMTXczUmypmLF5NI67Ehx4FufK3RoCt4eVfLNWK8KWcTIN3pUIbjMpZlhwi8Q+TZaJJXC6l6GbOW+BV5HNaFRclRV5xPCD6+/2TwTFU+k6MaJeVjddWtN3rItcPn2S7Fq1rb0kUtbeyYz7TjeRIBs0aVols0CSnStSROTlI8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744995597; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nBJdsehFovjFuaNlwazdQn8NDRTSTC5soMPWxmppM74=; 
	b=ZrFeDomAugSxCyeOh3buIy9rELiYe2//jiRWwXVCRIkFcLJeHvSNuVXVCiA6Yv3lsL7vTqLEtKuXYgMB+trgAtzpz9JhQjf82UIi8qezkK7edVrwHCFN6keMExVhfilbjjAWvTSts2NO4AhNzeD3Uq7n4vTDkQZmNsrQUYB2BfY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744995597;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nBJdsehFovjFuaNlwazdQn8NDRTSTC5soMPWxmppM74=;
	b=PVpSCnLCpGAYmE0cUUbclP9VIF8Hb+JwYQa6yoz+zaTho4g9WorRVqNUXCfiJJwu
	0pYr0ObS+qMGwBXWW8GdZeh03O228fXcyI+nWS1JNkUr4q/Prj+uQ1LSPfWMgwxFKfD
	OkQW6UFOQ508BCfdTop5Sn2aGYZZYNCCffrNL24w=
Received: by mx.zohomail.com with SMTPS id 1744995594398563.499854046974;
	Fri, 18 Apr 2025 09:59:54 -0700 (PDT)
Message-ID: <941334a9-a438-4b0f-a439-bd8cc1e847b3@collabora.com>
Date: Fri, 18 Apr 2025 21:59:46 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/32] selftests: harness: Mark functions without
 prototypes static
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-4-4d9c0295893f@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-4-4d9c0295893f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 2:00 PM, Thomas Weißschuh wrote:
> With -Wmissing-prototypes the compiler will warn about non-static
> functions which don't have a prototype defined.
> As they are not used from a different compilation unit they don't need to
> be defined globally.
> 
> Avoid the issue by marking the functions static.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest_harness.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 2b350ed60b2bf1cbede8e3a9b4ac5fe716900144..5822bc0b86a3c623fd34830fb8b541b27672a00b 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -258,7 +258,7 @@
>   * A bare "return;" statement may be used to return early.
>   */
>  #define FIXTURE_SETUP(fixture_name) \
> -	void fixture_name##_setup( \
> +	static void fixture_name##_setup( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
>  		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
>  		const FIXTURE_VARIANT(fixture_name) \
> @@ -307,7 +307,7 @@
>  	__FIXTURE_TEARDOWN(fixture_name)
>  
>  #define __FIXTURE_TEARDOWN(fixture_name) \
> -	void fixture_name##_teardown( \
> +	static void fixture_name##_teardown( \
>  		struct __test_metadata __attribute__((unused)) *_metadata, \
>  		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self, \
>  		const FIXTURE_VARIANT(fixture_name) \
> @@ -987,7 +987,7 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
>  	kill(-(t->pid), SIGKILL);
>  }
>  
> -void __wait_for_test(struct __test_metadata *t)
> +static void __wait_for_test(struct __test_metadata *t)
>  {
>  	struct sigaction action = {
>  		.sa_sigaction = __timeout_handler,
> @@ -1205,9 +1205,9 @@ static bool test_enabled(int argc, char **argv,
>  	return !has_positive;
>  }
>  
> -void __run_test(struct __fixture_metadata *f,
> -		struct __fixture_variant_metadata *variant,
> -		struct __test_metadata *t)
> +static void __run_test(struct __fixture_metadata *f,
> +		       struct __fixture_variant_metadata *variant,
> +		       struct __test_metadata *t)
>  {
>  	struct __test_xfail *xfail;
>  	char test_name[1024];
> 


-- 
Regards,
Usama

