Return-Path: <linux-kselftest+bounces-16773-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C84965DA6
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 11:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2953F1C22F7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 09:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1CC15689B;
	Fri, 30 Aug 2024 09:58:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D38EEB7;
	Fri, 30 Aug 2024 09:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725011888; cv=none; b=FGVjbdrgDiwYDtTJEG8CWXMoD62A/tM2FLi0Fx6MfXVUs00Ap/UtL6lTt1ERw/uVhk5HODnZgFZJIr8R0bvGHwxfymQH7XUvGUTGaPShDB3jyHv9ynCTROVtfgjAMNyEnGR2znSE22E9d0cy4yZHJ5h4ylZlwtys8owp+sk3Eyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725011888; c=relaxed/simple;
	bh=o3aAKAo/Uo0zC6D4o15oa4oyPdGyHv9/ZZ0sRamhuBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JOnQRRmMLpj5ZcFyiVMX0mj5kZe1kXjQLYkqBl+rpGt+Xtw7/TaYhGGy9WxbS09HmMaGH7JJz+UlSFUz7txPNY0KnAzHsVAUNeOLxJbqzPBJfLRUM68FbdulKPr0ZEkNvoOv2MoVY/D7JDYaTkaQQdoPmX5wwjJhxnK5kP/oUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 609BC1063;
	Fri, 30 Aug 2024 02:58:31 -0700 (PDT)
Received: from [10.57.86.160] (unknown [10.57.86.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 49AC63F762;
	Fri, 30 Aug 2024 02:58:03 -0700 (PDT)
Message-ID: <ea224d97-44bb-45d0-b7f1-71e6287d8a8f@arm.com>
Date: Fri, 30 Aug 2024 10:57:56 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest/arm64: Actually test SME vector length changes
 via sigreturn
To: Mark Brown <broonie@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240829-arm64-sme-signal-vl-change-test-v1-1-42d7534cb818@kernel.org>
Content-Language: en-US
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20240829-arm64-sme-signal-vl-change-test-v1-1-42d7534cb818@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29/08/2024 18:20, Mark Brown wrote:
> The test case for SME vector length changes via sigreturn use a bit too
> much cut'n'paste and only actually changed the SVE vector length in the
> test itself. Andre's recent factoring out of the initialisation code caused
> this to be exposed and the test to start failing. Fix the test to actually
> cover the thing it's supposed to test.

Yes, I came to the same conclusion. The device I tested the original 
patch on only had one VL, so the whole test was skipped, and I didn't 
see the problem. Now re-tested on the FVP.

> Fixes: 4963aeb35a9e ("kselftest/arm64: signal: Add SME signal handling tests")
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre.

> ---
>   .../arm64/signal/testcases/fake_sigreturn_sme_change_vl.c  | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> index cb8c051b5c8f..dfd6a2badf9f 100644
> --- a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_sme_change_vl.c
> @@ -35,30 +35,30 @@ static int fake_sigreturn_ssve_change_vl(struct tdescr *td,
>   {
>   	size_t resv_sz, offset;
>   	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
> -	struct sve_context *sve;
> +	struct za_context *za;
>   
>   	/* Get a signal context with a SME ZA frame in it */
>   	if (!get_current_context(td, &sf.uc, sizeof(sf.uc)))
>   		return 1;
>   
>   	resv_sz = GET_SF_RESV_SIZE(sf);
> -	head = get_header(head, SVE_MAGIC, resv_sz, &offset);
> +	head = get_header(head, ZA_MAGIC, resv_sz, &offset);
>   	if (!head) {
> -		fprintf(stderr, "No SVE context\n");
> +		fprintf(stderr, "No ZA context\n");
>   		return 1;
>   	}
>   
> -	if (head->size != sizeof(struct sve_context)) {
> +	if (head->size != sizeof(struct za_context)) {
>   		fprintf(stderr, "Register data present, aborting\n");
>   		return 1;
>   	}
>   
> -	sve = (struct sve_context *)head;
> +	za = (struct za_context *)head;
>   
>   	/* No changes are supported; init left us at minimum VL so go to max */
>   	fprintf(stderr, "Attempting to change VL from %d to %d\n",
> -		sve->vl, vls[0]);
> -	sve->vl = vls[0];
> +		za->vl, vls[0]);
> +	za->vl = vls[0];
>   
>   	fake_sigreturn(&sf, sizeof(sf), 0);
>   
> 
> ---
> base-commit: b18bbfc14a38b5234e09c2adcf713e38063a7e6e
> change-id: 20240829-arm64-sme-signal-vl-change-test-cebe4035856a
> 
> Best regards,

