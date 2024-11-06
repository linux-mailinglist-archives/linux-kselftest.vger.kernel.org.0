Return-Path: <linux-kselftest+bounces-21527-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B68B9BE59C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 12:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF20B21386
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2024 11:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0F61DED46;
	Wed,  6 Nov 2024 11:33:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE161DE3C3;
	Wed,  6 Nov 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730892789; cv=none; b=m0/xvnMWuegp8ciYkJF+zqWdxvfTIOClJFwdtnvY6cYTvrfYrIPgSDeyO8K2UUDWWF6o0l8HHPKgyDnfL5LT1VsinNnWRxo7NYDyAqI4c78sQ1f2JKBFSdo8Y5+GkraY44CI+KVneKeOLfKBCu+rinLXepsLEpXWrZJPpkN2gf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730892789; c=relaxed/simple;
	bh=pJqFEAM4twHz8nbJW752qWoXDyPJ+vUAguY3TiqCcCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX8tyD/fTweZQS3x/+b+doYNyoJuWkbZOHJSNmIUu/w9dX8ay6LBhxrD3/Tnr/CMSCUbmySejYzNRlHtdg68SOARtP+TNWilGFP548CV4/pWBL7GyHNX8m4WbDy5R9Xb9BUWpF+NjOKA4MK/DlPDCuVPPTOyd6P8x5uEJqAjE8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 695BB1063;
	Wed,  6 Nov 2024 03:33:36 -0800 (PST)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 692493F6A8;
	Wed,  6 Nov 2024 03:33:05 -0800 (PST)
Date: Wed, 6 Nov 2024 11:33:03 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] kselftest/arm64: Test signal handler state
 modification in fp-stress
Message-ID: <ZytT7z1EN97RaKmo@J2N7QTR9R3>
References: <20241023-arm64-fp-stress-irritator-v1-0-a51af298d449@kernel.org>
 <20241023-arm64-fp-stress-irritator-v1-6-a51af298d449@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023-arm64-fp-stress-irritator-v1-6-a51af298d449@kernel.org>

On Wed, Oct 23, 2024 at 09:38:34PM +0100, Mark Brown wrote:
> Currently in fp-stress we test signal delivery to the test threads by
> sending SIGUSR2 which simply counts how many signals are delivered. The
> test programs now also all have a SIGUSR1 handler which for the threads
> doing userspace testing additionally modifies the floating point register
> state in the signal handler, verifying that when we return the saved
> register state is restored from the signal context as expected. Switch over
> to triggering that to validate that we are restoring as expected.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  tools/testing/selftests/arm64/fp/fp-stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/arm64/fp/fp-stress.c b/tools/testing/selftests/arm64/fp/fp-stress.c
> index faac24bdefeb9436e2daf20b7250d0ae25ca23a7..3d477249dee0632b662b48582433d39323d18e18 100644
> --- a/tools/testing/selftests/arm64/fp/fp-stress.c
> +++ b/tools/testing/selftests/arm64/fp/fp-stress.c
> @@ -221,7 +221,7 @@ static void child_output(struct child_data *child, uint32_t events,
>  static void child_tickle(struct child_data *child)
>  {
>  	if (child->output_seen && !child->exited)
> -		kill(child->pid, SIGUSR2);
> +		kill(child->pid, SIGUSR1);
>  }
>  
>  static void child_stop(struct child_data *child)
> 
> -- 
> 2.39.2
> 

