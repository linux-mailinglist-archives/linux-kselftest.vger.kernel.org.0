Return-Path: <linux-kselftest+bounces-18452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F10987F3D
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 09:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CF371F23EC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 07:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54187165F19;
	Fri, 27 Sep 2024 07:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b="U2vy34JQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894131D5ADE;
	Fri, 27 Sep 2024 07:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727421527; cv=pass; b=tBHztOVI5XXD+ghQau/gwfKHwUFiQ0MuZI9tYa6onIC2MFZ6PD29EtgV/LpdobCkmbgGCYPqjcNtkruK5ja0glp8Co2NF3G5/9cBos1C07wJA/He/svjkgkfg/7ZBZkHaZI0bSE/TY+IdZ+f1m4Wj8/v2RPjNhtMi3Oq7gPvKvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727421527; c=relaxed/simple;
	bh=a819CRaOlCulO+rVUaGcxpplN5QlQLdWrX1IWAav9SY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ZdOJEC73nkHXgt1Yb7Q0cFvnJVmOz25+FuAnhN1yfEnnuF4EXjFQP3j6mxcURsG9cLdUq2DWtl4aWHfLGP6Ai2VzY8J/Xi5s+Cp6K6H/SiAB9asxfFWChrG9uf19nmqeCLtUK40TMa6pMB57Iz/azvLFrj+Cka6ovz2xWhFHFuU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=Usama.Anjum@collabora.com header.b=U2vy34JQ; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727421513; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nyYys2/SLVe4ILzQ4Z4oARBkJA4twlQ0czZK9OEuKbTI5unw//id4FpyEQiiqInogpFiNRR5q15epQ4tfqc88CBe1p4tkoKRNvH+jVQSgZ2MqQ88+tar8vIqHyKism2sw7x2OmgkADnE7tKs00UE2Qr7l+gI1cM2KpuKDZNGzcw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727421513; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OZoOJ7FFoWBjXTxUkPEkVF50xBuMiQ15qbPQ4pw88b0=; 
	b=hup1fxNXnP/f7CioKOP4EHCCnOzdaBmye5246noA9OmCCTvTxQBv7R002LBf4nmwt0wLyf3UV07jMlK+/JLpMuwKKsvaLMuF82pZYTHgl744p2AJmKUJ0HyPya/jJ1Gy6toHNEGk7DL52kQc1HPgKSVgBTUtKZEury1itfOpdsM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=Usama.Anjum@collabora.com;
	dmarc=pass header.from=<Usama.Anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727421513;
	s=zohomail; d=collabora.com; i=Usama.Anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=OZoOJ7FFoWBjXTxUkPEkVF50xBuMiQ15qbPQ4pw88b0=;
	b=U2vy34JQ4kNMTMXjECSF5m51vperTqgqqFtSIKNFiowHAXI+PnL8CNA4GnUhE8Pa
	hL6o6jBk+VC34FCKmpVgSi4IobU0GrX59l5rpLg0teTUrdI3MJNvSGHtcyhAYwFpU0E
	TbDYzvRG9mouC+Dv7mZAGRd/djXu1JDWpY5dOb3s=
Received: by mx.zohomail.com with SMTPS id 17274215120251.441391906584954;
	Fri, 27 Sep 2024 00:18:32 -0700 (PDT)
Message-ID: <c62ee507-361b-4dc8-b80e-148c914052f1@collabora.com>
Date: Fri, 27 Sep 2024 12:18:24 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Usama.Anjum@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ritesh Harjani <ritesh.list@gmail.com>, Kees Cook <keescook@chromium.org>,
 Mark Brown <broonie@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH] selftests/mm: Fixed incorrect buffer->mirror size in hmm2
 double_map test
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>
References: <20240927050752.51066-1-donettom@linux.ibm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <Usama.Anjum@collabora.com>
In-Reply-To: <20240927050752.51066-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 9/27/24 10:07 AM, Donet Tom wrote:
> The hmm2 double_map test was failing due to an incorrect
> buffer->mirror size. The buffer->mirror size was 6, while buffer->ptr
> size was 6 * PAGE_SIZE. The test failed because the kernel's
> copy_to_user function was attempting to copy a 6 * PAGE_SIZE buffer
> to buffer->mirror. Since the size of buffer->mirror was incorrect,
> copy_to_user failed.
> 
> This patch corrects the buffer->mirror size to 6 * PAGE_SIZE.
> 
> Test Result without this patch
> ==============================
>  #  RUN           hmm2.hmm2_device_private.double_map ...
>  # hmm-tests.c:1680:double_map:Expected ret (-14) == 0 (0)
>  # double_map: Test terminated by assertion
>  #          FAIL  hmm2.hmm2_device_private.double_map
>  not ok 53 hmm2.hmm2_device_private.double_map
> 
> Test Result with this patch
> ===========================
>  #  RUN           hmm2.hmm2_device_private.double_map ...
>  #            OK  hmm2.hmm2_device_private.double_map
>  ok 53 hmm2.hmm2_device_private.double_map
> 
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
Please add Fixes-by tag. Other than this, LGTM

Reviewed-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

> ---
>  tools/testing/selftests/mm/hmm-tests.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index d2cfc9b494a0..141bf63cbe05 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -1657,7 +1657,7 @@ TEST_F(hmm2, double_map)
>  
>  	buffer->fd = -1;
>  	buffer->size = size;
> -	buffer->mirror = malloc(npages);
> +	buffer->mirror = malloc(size);
>  	ASSERT_NE(buffer->mirror, NULL);
>  
>  	/* Reserve a range of addresses. */

-- 
BR,
Muhammad Usama Anjum


