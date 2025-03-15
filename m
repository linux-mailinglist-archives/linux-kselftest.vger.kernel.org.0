Return-Path: <linux-kselftest+bounces-29142-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16706A63207
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 20:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C18E03ADCBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Mar 2025 19:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E4219995B;
	Sat, 15 Mar 2025 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="UDJ0hDJp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6F518FDB2;
	Sat, 15 Mar 2025 19:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742065598; cv=pass; b=AtEle/Fk7PqTdqwOcJtTvG3SbGGEAEU+Gw1liygsd5QFZKKUKhpsXwb6LBHJ84cNqsQlfIHO1nJ9xrOSCOrKph5sNloviQ4/sBhhEtS61sOkoKSjAFFFpn4TepwuvhJ+oMPGHFC2zs7R+GCZE5oYD1qUi+FOapfjzX81Em0QCso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742065598; c=relaxed/simple;
	bh=/UwzJoOrxEA4vDMJaFmetAr9/EwvtfqHDJ8LSEnL6cA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P05LXFioJZTTv4ZMcAqvj2kMplFJpE5wN7jnslzIXakZLOObDjnkccu2JIbxIR8aUJju5YULR9PkY4Yx6G3xpViN+bwWN/O0JsAuBpOERGQ0uQQgN6HQxADTVQqPXS/TkGmFi576YWyxPpSqeAzhZXxcRzYbwsJaMgnCEtGa580=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=UDJ0hDJp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742065586; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SjpP6CRC5xu7FyuOWi0g6+ifnKax6W5qAo/RQ6kFOe5KbxIl53iBx4+9YKiDEptPJyfAgn1w64AwQIJZPvPHddy8CGW687yBGu4WTG7hjxjXxFPGlAuTAJgTYZBSQYSl2wbAsh6FukBqZBuP7zysIv/6ZXQE8JxosaGkTXhH9wU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742065586; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZblKv4IQw64v1PDzgd71geTnnQ5uwzrFEJFZZF1Utjg=; 
	b=EOsVwgzSJ93kNyLXXwmGMutycUIdNmb4eCdtuWLzZAauL432t/KGATyF/CzbBV8qi10oIz9ldme+JV9cZcW0giQ0LJNDyO/2A+7D0W7ObS8FLr8oGhLZh8FV2xHMUaTXe/zZm9V4pOOZ7Q0HvS6Pg3I3//XUHxYTDRskl30ZJBw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742065586;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ZblKv4IQw64v1PDzgd71geTnnQ5uwzrFEJFZZF1Utjg=;
	b=UDJ0hDJpedHI9I79CZXUQS6XzbMIABCxng45SVy+bkHOVfWNOKOuZD5WKOyY84eA
	yyxKTrexi8YJuVQF1tj6h6DrYQOKn/q4e+TyOULdZ07UWbJCx5UV/eftJRFR76cBFRf
	D+uEN0isoGk5XCotqhOomThrkkzO++8BC32XODuI=
Received: by mx.zohomail.com with SMTPS id 1742065584214935.7661587110175;
	Sat, 15 Mar 2025 12:06:24 -0700 (PDT)
Message-ID: <1e79b5d1-5d11-4157-a7f8-1e691e91af2a@collabora.com>
Date: Sun, 16 Mar 2025 00:06:16 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm/cow: Fix the incorrect error handling
To: Cyan Yang <cyan.yang@sifive.com>, akpm@linux-foundation.org,
 shuah@kernel.org, david@redhat.com
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250312043840.71799-1-cyan.yang@sifive.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250312043840.71799-1-cyan.yang@sifive.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/12/25 9:38 AM, Cyan Yang wrote:
> There is an error handling did not check the correct return value.
> This patch will fix it.
> 
> Fixes: f4b5fd6946e244cdedc3bbb9a1f24c8133b2077a ("selftests/vm: anon_cow: THP tests")
> Signed-off-by: Cyan Yang <cyan.yang@sifive.com>
After improving the description:
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/cow.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
> index 9446673645eb..f0cb14ea8608 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -876,7 +876,7 @@ static void do_run_with_thp(test_fn fn, enum thp_run thp_run, size_t thpsize)
>  		mremap_size = thpsize / 2;
>  		mremap_mem = mmap(NULL, mremap_size, PROT_NONE,
>  				  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> -		if (mem == MAP_FAILED) {
> +		if (mremap_mem == MAP_FAILED) {
>  			ksft_test_result_fail("mmap() failed\n");
>  			goto munmap;
>  		}


-- 
Regards,
Usama

