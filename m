Return-Path: <linux-kselftest+bounces-32193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4415AAA740C
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 15:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA91F4A4832
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 May 2025 13:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECEF255E2F;
	Fri,  2 May 2025 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="JUJcRSbI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EF725522D;
	Fri,  2 May 2025 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746193397; cv=pass; b=KygzZwa01i0uX1ot4Av/H3tYgbu7WBvoSFqHoEL4diJAqR94UBA8pNz1LVKRqXFs+jPLGGatanjIc5zzv6iXOZfXWOFfd+W0V5J/CHAdV9tKGmzsRzBD7eSUlnjTsrdBubLhTpmhJAHrvK/tCSMtIlQYux20/PmPtuwqY33iwM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746193397; c=relaxed/simple;
	bh=fu+TW10DD8fGAjrtNifUxuSSmnNqdY8dpSFjihb3fDk=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=dC4GWHt7gOF19gjXrF+mGGmEfuTosA2OqbqSVioh0OS8h04LxF9GQEsY9yQDdm/BoAxw20vC2AcOxQmIB82yCk+OXC5iH+Fql8XEMZthJ3PZVtYh/uRBb1r2mEbBlL4s/P0QjT1m8/WAYTIBbkWPR7EoUjuTApOxE6cUk1xf2RQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=JUJcRSbI; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746193384; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=W9JzYJTnQXG1d6Zt3zRv8WjbHCGls4hTVI8DA+Wo14oT790LvUe9V75A8+8ilRBle9Joy7xLNkUWGNfKOauXgzxKkfudD4CL3o8yvphcPSpotOpyiup+rLAit0mK2LIf3WQB7DeFk03gsoMO2V/+td1XkrdBhd3p5jzqVuMBFkU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746193384; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6Zmuc615J6mbppoDVFz1aqh4r+4ECOigtCQVSe13+SM=; 
	b=CIr5pLuzky+1lm3ck+5mDDyUtYWZL9l5SkXYo+gn8CzaK2PtfhmZ8WU0uSFG5/7eDI2pNT3uDd3jMPBh1m212xFkyxodHdPK1ux5RxNXH1VGEiyLIWiVUZYcxdgtLO/AWjEGn7TCwDVMcWTOsneK9wOQyEyKFkYhYEy420z7M8U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746193384;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6Zmuc615J6mbppoDVFz1aqh4r+4ECOigtCQVSe13+SM=;
	b=JUJcRSbIDw/IgZM69BKzw5EecEmEtvqxdXuvvcrvrzrNFaooN5xkwCHv1V5eDspw
	cxAE424q/v927dIRxh73QhBKjlJEgI3fJBkzTE2Bmmm8drEbyjdvYP7v4sH3M20JT4x
	1rukZlhvB0cOC7eVpo4fcPAQXXsNvZ2JJsVofmjY=
Received: by mx.zohomail.com with SMTPS id 174619338158373.28545445771317;
	Fri, 2 May 2025 06:43:01 -0700 (PDT)
Message-ID: <c01d8c7e-bac7-4d4d-872d-14f0ac0c6ec2@collabora.com>
Date: Fri, 2 May 2025 18:42:55 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, Shuah Khan <skhan@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/7] selftests: vDSO: chacha: Correctly skip test if
 necessary
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Shuah Khan
 <shuah@kernel.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
References: <20250502-selftests-vdso-fixes-v1-0-fb5d640a4f78@linutronix.de>
 <20250502-selftests-vdso-fixes-v1-1-fb5d640a4f78@linutronix.de>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <20250502-selftests-vdso-fixes-v1-1-fb5d640a4f78@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/2/25 5:40 PM, Thomas Weißschuh wrote:
> According to kselftest.h ksft_exit_skip() is not meant to be called when
> a plan has already been printed.
Agreed

> 
> Use the recommended function ksft_test_result_skip().
> 
> This fixes a bug, where the TAP output would be invalid when skipping:
> 
> 	TAP version 13
> 	1..1
> 	ok 2 # SKIP Not implemented on architecture
> 
> The SKIP line should start with "ok 1" as the plan only contains one test.
> 
> Fixes: 3b5992eaf730 ("selftests: vDSO: unconditionally build chacha test")
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> 
> ---
> I'm not sure if this is not a general bug in ksft_exit_skip().
> First ksft_xskip is incremented then read back through ksft_test_num() and
> then that result is incremented again.
> 
> In any case, using the correct function is better.
> ---
>  tools/testing/selftests/vDSO/vdso_test_chacha.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> index 8757f738b0b1a76a48c83c5e5df79925a30c1bc7..0aad682b12c8836efabb49a65a47cf87466891a3 100644
> --- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
> +++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
> @@ -76,7 +76,8 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, u
>  
>  void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
>  {
> -	ksft_exit_skip("Not implemented on architecture\n");
> +	ksft_test_result_skip("Not implemented on architecture\n");
> +	ksft_finished();
>  }
>  
>  int main(int argc, char *argv[])
> 


-- 
Regards,
Usama

