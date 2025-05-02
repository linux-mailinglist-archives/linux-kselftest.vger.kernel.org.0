Return-Path: <linux-kselftest+bounces-32197-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB274AA7425
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B11461BC0BD4
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678AF225779;
	Fri,  2 May 2025 13:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="fKKwh67T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956D01474DA;
	Fri,  2 May 2025 13:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193704; cv=pass; b=DfoEJxX9+1mre5YSTJtaNEzmfgEc8GXh4z/AYJD+C/bUaVOjq7tJo8xlQJ2k+a4nwbzLqxRwnbHyXd569GNSjihY/A4UAsYC7giL7LnXe1W1diTdquiQ4Jw3B6YIIXEf7anLHFYDr4GZRbhMQHsvPBDKBAMmhxh+ttdAehPLkTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193704; c=relaxed/simple;
	bh=9Ov9bFT8WBiC1HOucRoC3NGXXZYwaxxlf4b0Le+wBtM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jqtO9yLf6AqkjHTLXgTILbX/EsdYaPnUc9fJl8g8nHZad1yB46f4iNwk4l8x3wNhPkCeQNoK79rwpzB3y3kRzxNGKIC/Q63fKJvhGcpMlOzd8dDYFH2Z7aQ6cB2yxQ9FuBWozTxFFrL34RksRGuNrD1u3y3iRvk7p7RX23tvvFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=fKKwh67T; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193691; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WXFtziDNmYzvKr1OOO2vdXXJeXhOvQTjDETkGcnHp+isiV++suUDKXqBRfnzLzaN5uOUdDXv6f6LU4fsf5EejBCX9JDHhWewIMZ8cxuvLtsN7yJ3vydeMw1sfi8dVBGxH/F3R7R0Xty1yM3wEfGJF9LMTT+PU+SXeSgu1VO78t4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193691; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+ghhvBMBj35cdnVypJnvXisCWHPKfiKGsf04CiNP4U0=; 
	b=NX51ttl8wb3ZNmvE/sjtyL7dAhN4uB8gce+sXQE2WfOXKr83weBjCzpb0QUNPMMbbK+IweFYy6XTs+zq/EFC5v4an/QL4QyDqdnPniOkWOmQJVaVgqm/2NIAL4mDTe5pN9a4x6nJwvC8tWpbSCCLfcGe52A3cn5L7b6mdIEfE+M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193691;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+ghhvBMBj35cdnVypJnvXisCWHPKfiKGsf04CiNP4U0=;
	b=fKKwh67THd3qza/5qKFOqJobAMb8SDOyT2H4CR3ZvrxS340uA/ZFo6RL/EEs48Cq
	6a9/QFu5ZiMASOcQpGWWJFxxjPTW6jyFl0MrAHJebZaC+M2d+wspCJISk4qQMVX/smk
	BlKyMiKWoNE3sWZ+bqJZQvF3lj+6GP1Y7XrSNfOE=
Received: by mx.zohomail.com with SMTPS id 1746193689115908.4390295289863;
	Fri, 2 May 2025 06:48:09 -0700 (PDT)
Message-ID: <36bb6e78-1db9-4dad-a2ef-7e860ead30e4@collabora.com>
Date: Fri, 2 May 2025 18:48:03 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 6/7] selftests: vDSO: vdso_test_getrandom: Always print
 TAP header
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-6-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-6-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> The TAP specification requires that the output begins with a header line.
> If vgetrandom_init() fails and skips the test, that header line is missing.
> 
> Call vgetrandom_init() after ksft_print_header().
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/vdso_test_getrandom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_getrandom.c b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> index b0e0d664508a38d6dde9df0a61ec8198ee928a17..01892d8e65d754d0353f7df2b63910d5be8cd1bc 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_getrandom.c
> @@ -232,6 +232,7 @@ static void kselftest(void)
>  	pid_t child;
>  
>  	ksft_print_header();
> +	vgetrandom_init();
>  	ksft_set_plan(2);
>  
>  	for (size_t i = 0; i < 1000; ++i) {
> @@ -285,8 +286,6 @@ static void usage(const char *argv0)
>  
>  int main(int argc, char *argv[])
>  {
> -	vgetrandom_init();
> -
>  	if (argc == 1) {
>  		kselftest();
>  		return 0;
> @@ -296,6 +295,9 @@ int main(int argc, char *argv[])
>  		usage(argv[0]);
>  		return 1;
>  	}
> +
> +	vgetrandom_init();
> +
>  	if (!strcmp(argv[1], "bench-single"))
>  		bench_single();
>  	else if (!strcmp(argv[1], "bench-multi"))
> 


-- 
Regards,
Usama

