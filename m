Return-Path: <linux-kselftest+bounces-2533-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16FF8203E7
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 08:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71A4B1F21710
	for <lists+linux-kselftest@lfdr.de>; Sat, 30 Dec 2023 07:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE571843;
	Sat, 30 Dec 2023 07:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="pkrlOPfU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F6B23A0;
	Sat, 30 Dec 2023 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703920806;
	bh=J7zOLrgUhExML8R0Y0YXOb52VWcQiWm+mjBPwA42lC0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=pkrlOPfUh4fMJt+EULtNRS8qbjRQckMVGac7yorbHmb8QoF5rhDQ2H/or2ksNqA2Y
	 mM/IPm2hoFegs5xc4OWpu+dxARFziwtOU1XdwV7Pc/8C53JorFfxyBjehNMi+l8Zy0
	 6+aakTAnFuNE+DztuaNS9dxqTf410CcIAc4KtLDONAZBHDe8L3sL+HuX8R1T4G8e0b
	 Zzxka2S6vC2XQbd1r5ZoejeCClAMr64wqypsvLn10hmqgC2irRwwpljjR0smvAN4tJ
	 n6roiaxv36bzrLIGnHKQ9P5AVLS4tBZrruXGlCzyrqRAi6Pkco3xx94KxjHe4izi4z
	 9g2Wq+YWttGPw==
Received: from [100.96.234.34] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4837D37811F1;
	Sat, 30 Dec 2023 07:20:03 +0000 (UTC)
Message-ID: <36eac3a4-bca9-4648-9154-7a0561476f9f@collabora.com>
Date: Sat, 30 Dec 2023 12:20:03 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH] kunit: Fix NULL-dereference in kunit_init_suite() if
 suite->log is NULL
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, brendan.higgins@linux.dev,
 davidgow@google.com, rmoar@google.com
References: <20231218151729.210027-1-rf@opensource.cirrus.com>
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20231218151729.210027-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/23 8:17 PM, Richard Fitzgerald wrote:
> suite->log must be checked for NULL before passing it to
> string_stream_clear(). This was done in kunit_init_test() but was missing
> from kunit_init_suite().
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: 6d696c4695c5 ("kunit: add ability to run tests after boot using debugfs")
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  lib/kunit/test.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> index e803d998e855..ea7f0913e55a 100644
> --- a/lib/kunit/test.c
> +++ b/lib/kunit/test.c
> @@ -658,7 +658,9 @@ static void kunit_init_suite(struct kunit_suite *suite)
>  	kunit_debugfs_create_suite(suite);
>  	suite->status_comment[0] = '\0';
>  	suite->suite_init_err = 0;
> -	string_stream_clear(suite->log);
> +
> +	if (suite->log)
> +		string_stream_clear(suite->log);
>  }
>  
>  bool kunit_enabled(void)

-- 
BR,
Muhammad Usama Anjum

