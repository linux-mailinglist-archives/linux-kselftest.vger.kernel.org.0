Return-Path: <linux-kselftest+bounces-32194-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2747AA740E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 793FF189F188
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84B7255E2B;
	Fri,  2 May 2025 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="LhqEgtui"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4505525522C;
	Fri,  2 May 2025 13:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193417; cv=pass; b=VLB7dbL4xBdiGOCjK5j7cOxRdHT+vhA+/V/o6RAPCngzeDSmVeY3BJP5XErDj75AxhrMHQh4AA1AT8IbfXH3rc067IS7ZgO+nI46x7w0wjUDFJr0PvWw8ioRJ+WlfMekHvT/kRxoeNM4ASerM26XboKk4Uu4qHhuG8y6KdBnZ/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193417; c=relaxed/simple;
	bh=z2AP0myLSw11g8ce2q1WXTGMIpb1bo7Up+bpw6XLGgU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BAqDofvLpmAVtNq/VV7wGVhbLlZahLMtVnOh+BsTp5vncJRd/801t2bzKxLSFYHWM+lKL6MYKguiSqrMDm8S/xZSO34W1cd7RL9YMhJ2m+1Y505Xi7SxXaCxSugcpVlI1IkWYBvn9U+npqk5pu9iT0n1uHq0oqqStElXAsMY4ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=LhqEgtui; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193406; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=O+iKH2DNLVLS065VEZRphvBhj8gkKv+XIXxHLbnsi+m8N82cd/S4VHNbRP7i3Q5QkxWXibRT/8v6QS8JgMcGp3PNVIFenWqBKfLlA7o0H5KTai7FozTMS6UK6ZkaUIWt4OtP+tHQo0yEXHlwlVu+lw1QMbP5xxX4veLtGIh5DGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193406; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Pz5xrUgMUPURonFjz/UHywG0LPoopmQOOvrkw0BhJBA=; 
	b=UkKbTKXSqd1ypTdvamas2FCJ1bbZGR3wpd0XOd6nWwd6XCe99tFm5WX9tTGvgl7IwbtcBBuv4zl2UB2GuZo96eRX8TsBaLjGnVR0W2A1hClVqtuEH9JDc6I2XOCO2X5GFfSzJ7uPc98Zvejf07FtYZBALdrUTR1BN0LZv4sVEiE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193406;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Pz5xrUgMUPURonFjz/UHywG0LPoopmQOOvrkw0BhJBA=;
	b=LhqEgtuif1wrhqAEd97CUglZvTwM/ZHuD1OfbL6fnbLwhK3SRAwQonzv05d2S5fA
	KIyxm4vsrYCHEQfpr8DZFRrpfIuvDSMNSraKaRKV8wCythTTaH8DoxOtwmeADHvUKOR
	oGkn4LA3BafFmxI152FiaZ8n0tAiEiC9bpJyApFs=
Received: by mx.zohomail.com with SMTPS id 1746193404870810.7768218555155;
	Fri, 2 May 2025 06:43:24 -0700 (PDT)
Message-ID: <b67e43e5-3b56-4eec-9cae-00042e95e362@collabora.com>
Date: Fri, 2 May 2025 18:43:19 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] selftests: vDSO: clock_getres: Drop unused include of
 err.h
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-2-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-2-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> Nothing from err.h is used.
> 
> Drop the include.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> index 38d46a8bf7cba7a9b4a9b13b5eb17aa207972bd0..b5d5f59f725a703c357dfca91bfe170aaaeb42fa 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
> @@ -13,7 +13,6 @@
>  
>  #define _GNU_SOURCE
>  #include <elf.h>
> -#include <err.h>
>  #include <fcntl.h>
>  #include <stdint.h>
>  #include <stdio.h>
> 


-- 
Regards,
Usama

