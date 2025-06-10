Return-Path: <linux-kselftest+bounces-34618-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D397BAD4048
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 19:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 650973A5973
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jun 2025 17:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F007C244693;
	Tue, 10 Jun 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2zKLg5K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77782B9BF;
	Tue, 10 Jun 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749575775; cv=none; b=VCpCgAvLzeNaWsQgDMUPAPlwSoD2vD6Q3WL2LhoEfbQwpBjj6WTXC1jbxFa3+iapXMof7qeTrKHc0c0PNoS+c/CzVr/FZ+kyJX2b27Rygb18uCi7lhoqd2oaNxAiwmK/zbp1vWcWMKbRLxN0U8/CCDV9UF2b63ZjkkptGPxsgEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749575775; c=relaxed/simple;
	bh=55+RaM6BdEkpfdOTQyijX7TveBZCvrjRknaE/fwutoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfXxpfn9F4Atr9Jb6xYTELt3Qc6x2GcQtFndPP4tMRcNmAA13NymwxXpqM3B09EE07sICQXRDrr6IG0mJOyibiGXQOOqEzatpSzCDzVPHx1CCnVBrn33lXXaKt7oKtu0ehFLkLKRf28X1T5PfDE5pu8u/YCK6RCZF8QLpXAPIqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2zKLg5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30406C4CEED;
	Tue, 10 Jun 2025 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749575775;
	bh=55+RaM6BdEkpfdOTQyijX7TveBZCvrjRknaE/fwutoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c2zKLg5KKQ1hBezRVOupzHaNocG57d803thXInhwPM+26e+OgK+eZ4iZa0c9XGK78
	 xMquwBHKK22kE672T/pEyEtq4Xpt1z8ldkt1+eIUfrMzR6Ev65F9sEwh0QAds4EGyv
	 muXQuxmEHRTA1EjJco8KdUDQOrtG+hzuYQorPGJMOmsznKDZBYOpnKtzsrkydyCVlX
	 r04Uw1P5b07DHiQbKnHnN7gx8u0HsB1drqTR+P2KdnlgZqUoxpcSUgGfQ0JYFz/aP5
	 qTa/ygvxEkhIb+knrCk6S53TB0zQrHvASD+DDVr4siexj/ZF8T6u6Fgjk8qBTxd6t9
	 t2QvhkRD82JpA==
Date: Tue, 10 Jun 2025 20:16:09 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/mm: Check for YAMA ptrace_scope configuraiton
 before modifying it
Message-ID: <aEhoWVH0Ka6jB8QR@kernel.org>
References: <20250610-selftest-mm-enable-yama-v1-1-0097b6713116@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610-selftest-mm-enable-yama-v1-1-0097b6713116@kernel.org>

On Tue, Jun 10, 2025 at 03:07:44PM +0100, Mark Brown wrote:
> When running the memfd_secret test run_vmtests.sh unconditionally tries
> to confgiure the YAMA LSM's ptrace_scope configuration, leading to an error
> if YAMA is not in the running kernel:
> 
> # ./run_vmtests.sh: line 432: /proc/sys/kernel/yama/ptrace_scope: No such file or directory
> # # ----------------------
> # # running ./memfd_secret
> # # ----------------------
> 
> Check that this file is present before trying to write to it.
> 
> The indentation here is a bit odd, and it doesn't seem great that we
> configure but don't restore ptrace_scope.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
> index dddd1dd8af14..33fc7fafa8f9 100755
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -429,7 +429,9 @@ CATEGORY="vma_merge" run_test ./merge
>  
>  if [ -x ./memfd_secret ]
>  then
> -(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
> +if [ -f /proc/sys/kernel/yama/ptrace_scope ]; then
> +	(echo 0 > /proc/sys/kernel/yama/ptrace_scope 2>&1) | tap_prefix
> +fi
>  CATEGORY="memfd_secret" run_test ./memfd_secret
>  fi
>  
> 
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250605-selftest-mm-enable-yama-1541c2d2ddcd
> 
> Best regards,
> -- 
> Mark Brown <broonie@kernel.org>
> 

-- 
Sincerely yours,
Mike.

