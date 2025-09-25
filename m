Return-Path: <linux-kselftest+bounces-42364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D844CBA0B02
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 18:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E8031C24EEE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Sep 2025 16:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29693296BAB;
	Thu, 25 Sep 2025 16:46:52 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029841EDA2C;
	Thu, 25 Sep 2025 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758818812; cv=none; b=Cv9kBx35BR8cXKQi9LbFkLHG1DtjyMFwv4eIFKhJZst79L9vtNJlk+2iFBO2fhx7eTuR6s8jehWqyCZ+f6k7FS/J4ROWwB6mYCGubkfimvtpZ7uti1yXZwAfRsJBtAW18cSeGoTnidrFhXa6c36yTV169ZfnOA9lW2e5rwuBwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758818812; c=relaxed/simple;
	bh=6fkevfSmf6zufjkPBjzEV3QjsS/B0cIomEmCX3T5Oqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yl7X2Wmg56WDtUjQlIAzge1Nu6BVafG12xvoNZ+Y3Xc471X4fan0wjdauVPq3kv0xeB2+VutZQhD+ntbSI2TgnxUZJOf6zVcJC3Nf6L1XuT69Da3xs/sX2GWGXY+U9wDA+WJEPqMUr5vXJXhG9ueqVbuXQ6huBkVvEAHbsHwWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE0C4CEF0;
	Thu, 25 Sep 2025 16:46:48 +0000 (UTC)
Date: Thu, 25 Sep 2025 17:46:46 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Shuah Khan <shuah@kernel.org>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Wilco Dijkstra <wilco.dijkstra@arm.com>,
	Carlos O'Donell <codonell@redhat.com>,
	Florian Weimer <fweimer@redhat.com>, Szabolcs Nagy <nsz@port70.net>,
	Rich Felker <dalias@libc.org>, libc-alpha@sourceware.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC 1/3] arm64/gcs: Support reuse of GCS for exited
 threads
Message-ID: <aNVx9vlgi8t81V6Y@arm.com>
References: <20250921-arm64-gcs-exit-token-v1-0-45cf64e648d5@kernel.org>
 <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921-arm64-gcs-exit-token-v1-1-45cf64e648d5@kernel.org>

On Sun, Sep 21, 2025 at 02:21:35PM +0100, Mark Brown wrote:
> diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
> index fd1d5a6655de..4649c2b107a7 100644
> --- a/arch/arm64/mm/gcs.c
> +++ b/arch/arm64/mm/gcs.c
> @@ -199,14 +199,37 @@ void gcs_set_el0_mode(struct task_struct *task)
>  
>  void gcs_free(struct task_struct *task)
>  {
> +	unsigned long __user *cap_ptr;
> +	unsigned long cap_val;
> +	int ret;
> +
>  	if (!system_supports_gcs())
>  		return;
>  
>  	if (!task->mm || task->mm != current->mm)
>  		return;
> -	if (task->thread.gcs_base)
> +	if (task->thread.gcs_base) {
>  		vm_munmap(task->thread.gcs_base, task->thread.gcs_size);
> +	} else if (task == current &&
> +		   task->thread.gcs_el0_mode & PR_SHADOW_STACK_EXIT_TOKEN) {

I checked the code paths leading here and task is always current. But
better to keep the test in case the core code ever changes.

> +		cap_ptr = (unsigned long __user *)read_sysreg_s(SYS_GCSPR_EL0);
> +		cap_ptr--;
> +		cap_val = GCS_CAP(cap_ptr);
> +
> +		/*
> +		 * We can't do anything constructive if this fails,
> +		 * and the thread might be exiting due to being in a
> +		 * bad state anyway.
> +		 */
> +		put_user_gcs(cap_val, cap_ptr, &ret);
> +
> +		/*
> +		 * Ensure the new cap is ordered before standard
> +		 * memory accesses to the same location.
> +		 */
> +		gcsb_dsync();
> +	}

The only downside is that, if the thread did not unwind properly, we
don't write the token where it was initially. We could save the token
address from clone3() and restore it there instead.

-- 
Catalin

