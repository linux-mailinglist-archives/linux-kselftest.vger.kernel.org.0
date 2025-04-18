Return-Path: <linux-kselftest+bounces-31157-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657D6A93B9A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 19:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 370D38A5C90
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Apr 2025 17:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EEF21A457;
	Fri, 18 Apr 2025 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="AbRcBNBH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35D221A43D;
	Fri, 18 Apr 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744995703; cv=pass; b=F+4l8IJjkKQSLIdW8v8ythAQbMORhVnYBUGqPQlMFdVRlxVj6wGUVBz/T8v7LG5SWptf2Ad8ism/830CoIiy38N8ZuOjaTEa0n5nET9gnGtKZJoARdNV1h+dSTWuTVXgZc/42XpZvq5GcHFyUCRoo0fQbkHN06ArhUTsBJESeeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744995703; c=relaxed/simple;
	bh=acKeuEYRQlP9fZhfZf7ovti3rK3Hpmy1lIjyi3a+Me0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R0ZIUjp5LMtZcDrYRYC+XgtGLB2kU3yDMnoyyeGoFP3eCBpaffnL8opek8HOVhR8xUF9Fsh7nmEVgmcsd3LpJwjqOD7bb9iGHRmgsVVk0lqSgJ9REAojetABJLY1dFmcVBGAYXykLFHvPZnG2Flc1qU4UZY6v7ao02lTubgg9KY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=AbRcBNBH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744995668; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mNqvsJIV4jp04Jvj7dGEQOYwKXb+tbrByLE7Srh+r1yBHVZvPe/QjNFjHo9EZp3qvxxtJbWwA0sbDeryv5Kk6NSqWNf9c8Sut+nSftxwxNjtRGtVs07Kg9wdebga1s6a+c71e1WdR6tzMbmDLYjDOKwsIsp95ADaimi/F5KSmBg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744995668; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=w2aPdjKz5lGmhA4ac7WZyVYSfIQHzkE0P21tdEqps0s=; 
	b=KhD1YjzYPiU+boHpdIoCAyfNqLHi7qz1zlBqqeW7u33u6ktsAz0XBfH/qaur4H3hML5VEKyNAG7GkqichLVRlNyqQgXtrMuLqN5Nu+IKbCYlnbzYDKqOeKkn0XMm3cY8ddvKdqtUl4xxqCywsOUxCQ80iBLTAlmpskswxrMuPZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744995668;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=w2aPdjKz5lGmhA4ac7WZyVYSfIQHzkE0P21tdEqps0s=;
	b=AbRcBNBHgS8GcEE4MC0tEkZYQJzIyCYPgz5yYFqNwz+jLs93meK9+q2COWCkU0RH
	f/rx2tPVIP/HVzYg5uFcAaQDDZxP2WENTU0PD3PP4xv7g0y5qsVFrM7xjqOI+XA4iO8
	uvOJ9Eue2SY3oA88lbppS/7GLrgoGM7fTgzUZLJE=
Received: by mx.zohomail.com with SMTPS id 1744995665226730.3558457461216;
	Fri, 18 Apr 2025 10:01:05 -0700 (PDT)
Message-ID: <8204b57b-45c8-40e6-a936-915e8c45f3e4@collabora.com>
Date: Fri, 18 Apr 2025 22:00:59 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/32] selftests: harness: Remove inline qualifier for
 wrappers
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250411-nolibc-kselftest-harness-v3-0-4d9c0295893f@linutronix.de>
 <20250411-nolibc-kselftest-harness-v3-5-4d9c0295893f@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250411-nolibc-kselftest-harness-v3-5-4d9c0295893f@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 4/11/25 2:00 PM, Thomas Weißschuh wrote:
> The pointers to the wrappers are stored in function pointers,
> preventing them from actually being inlined.
> Remove the inline qualifier, aligning these wrappers with the other
> functions defined through macros.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/kselftest_harness.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 5822bc0b86a3c623fd34830fb8b541b27672a00b..222a4f51a8d704c41597e09a241ad887ef787139 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -172,7 +172,7 @@
>  
>  #define __TEST_IMPL(test_name, _signal) \
>  	static void test_name(struct __test_metadata *_metadata); \
> -	static inline void wrapper_##test_name( \
> +	static void wrapper_##test_name( \
>  		struct __test_metadata *_metadata, \
>  		struct __fixture_variant_metadata __attribute__((unused)) *variant) \
>  	{ \
> @@ -401,7 +401,7 @@
>  		struct __test_metadata *_metadata, \
>  		FIXTURE_DATA(fixture_name) *self, \
>  		const FIXTURE_VARIANT(fixture_name) *variant); \
> -	static inline void wrapper_##fixture_name##_##test_name( \
> +	static void wrapper_##fixture_name##_##test_name( \
>  		struct __test_metadata *_metadata, \
>  		struct __fixture_variant_metadata *variant) \
>  	{ \
> 


-- 
Regards,
Usama

