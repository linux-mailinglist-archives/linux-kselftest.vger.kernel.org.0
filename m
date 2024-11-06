Return-Path: <linux-kselftest+bounces-21526-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DA4D9BE59A
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31F3DB237AF
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E191DE3C3;
	Wed,  6 Nov 2024 11:32:42 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14E057333;
	Wed,  6 Nov 2024 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892762; cv=none; b=TNlIJxJ+ra3nODD8bFfs6pV+QNMMD7iEbTB8fbj97JsUWFBbFhmObDli0g1lPy99Ej9zOvMYGEnQnPZgDuUJYcqY3k7SdWpASRGCg31XXDjRjn4LhhK3niY6eDFE/ZUjqYpdT4VVZJQTwF3SGkK90nO8H4vn55jk80o1ol1QBs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892762; c=relaxed/simple;
	bh=RqdrXoKwXBtp9qJcl07LKYQkQFWI1itcw4BcnWNAqmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQQbjD6rbHCEk06TZ5xqsGGOuRWkJBbpHMz9/3tf+mlLWIRI4PSDVi9An+afLlW0ckMJPKdcKMeelD+D9BRLsek/bUaR5w1rK/2OYL32fORwUYZzHcMURkqHsbfjvyOhjMSjoeFMji0OpaXrxwNASYkRXV9Ui7YOcOJ+gX/QtHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3642B1063;
	Wed,  6 Nov 2024 03:33:10 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 391543F6A8;
	Wed,  6 Nov 2024 03:32:39 -0800 (PST)
Date: Wed, 6 Nov 2024 11:32:36 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] kselftest/arm64: Provide a SIGUSR1 handler in the
 kernel mode FP stress test
Message-ID: <ZytT1A5KZnjvyJUt@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-5-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-5-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:33PM +0100, Mark Brown wrote:
> The other stress test programs provide a SIGUSR1 handler which modifies the
> live register state in order to validate that signal context is being
> restored during signal return. While we can't usefully do this when testing
> kernel mode FP usage provide a handler for SIGUSR1 which just counts the
> number of signals like we do for SIGUSR2, allowing fp-stress to treat all
> the test programs uniformly.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/kernel-test.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/arm64/fp/kernel-test.c b/tools/testing/selftests/arm64/fp/kernel-test.c
> index e8da3b4cbd23202c6504ffd8043f8ef351d739f6..859345379044fc287458644309d66cf5f3d8bdf5 100644
> --- a/tools/testing/selftests/arm64/fp/kernel-test.c
> +++ b/tools/testing/selftests/arm64/fp/kernel-test.c
> @@ -267,6 +267,10 @@ int main(void)
>  		       strerror(errno), errno);
>  
>  	sa.sa_sigaction = handle_kick_signal;
> +	ret = sigaction(SIGUSR1, &sa, NULL);
> +	if (ret < 0)
> +		printf("Failed to install SIGUSR1 handler: %s (%d)\n",
> +		       strerror(errno), errno);
>  	ret = sigaction(SIGUSR2, &sa, NULL);
>  	if (ret < 0)
>  		printf("Failed to install SIGUSR2 handler: %s (%d)\n",
> 
> -- 
> 2.39.2
> 

