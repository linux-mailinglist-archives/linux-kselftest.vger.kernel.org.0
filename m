Return-Path: <linux-kselftest+bounces-2750-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B013A828430
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 11:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EBD4287A76
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jan 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6434364CC;
	Tue,  9 Jan 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EallK46W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35A364B9;
	Tue,  9 Jan 2024 10:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 94F6040E01B2;
	Tue,  9 Jan 2024 10:45:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bTZI_qzADFUM; Tue,  9 Jan 2024 10:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704797134; bh=ypRr+iAfvDjfeKwlwq/k5cw5LfYK0leTEqBNJmrJKi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EallK46WDGLi11Jtx7MUajDnzNbDJ8ilnoCJY+03U0LHDS7Mawrg6jY8JEcHNdc+N
	 AOTyK5ddG8fyHDaf63A5Ca6nQ679uXKJDUyOV7tx4RMI8CoUxmdxroSTmtWMnMgBsl
	 q8NcVecvD5ySwYGkttWvEMMrtobS4y7JNL4yZefXEgVOnUhZDQyabtq0QtS9qwY7sa
	 KaOgHQ35HGTZIRmN2XNbGtuPBoTHL9a+yrzuKcKfWKnCPy4vv4AXQEUYKkTxEGqAL6
	 EGVOYZEyX9Pc/6jmP8RYpLSBQ2eoKpBPHDKtuubyjWZ4iIEE7T1cfpJz54zZMMs3r0
	 erLj35VetdhW1k7YWn9fPdOmwYmMge0xKWqflMoSWuSW3ALlxJo7MH8lr7WPjqpOhH
	 uw2KyL0VYUSksJHhP0MHBXsLysc8YjaMG8Gv0l7YZxmzykiJbbNGKX39cIKU0fwLhh
	 SKUvtUN2m3p2xKkC9/jLBUum7y5SzCe7M+RxyrHym6do5x5WZ1nf2KmdKTyNg+cx5j
	 fKl0TTCaRKS+EUTqBg3hs+J3mSUHy7YDz+7TKY1BRkfGc61vGX0gjzC/B/lWWw9Qu1
	 PfmoIbt/J1nbKrsoCyUu/nS2G22fAfmjK98hT7BfSpGwmDku1GB2B1h7TPe1wmInAl
	 FeeNKVliD799m9dEJ4nysViY=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D1BCC40E016C;
	Tue,  9 Jan 2024 10:45:15 +0000 (UTC)
Date: Tue, 9 Jan 2024 11:45:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Meng Li <li.meng@amd.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-acpi@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org,
	Nathan Fontenot <nathan.fontenot@amd.com>,
	Deepak Sharma <deepak.sharma@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Shimmer Huang <shimmer.huang@amd.com>,
	Perry Yuan <Perry.Yuan@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [PATCH V12 1/7] x86: Drop CPU_SUP_INTEL from SCHED_MC_PRIO for
 the expansion.
Message-ID: <20240109104504.GAZZ0jsFrrncZ8Vx8y@fat_crate.local>
References: <20231205063537.872834-1-li.meng@amd.com>
 <20231205063537.872834-2-li.meng@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231205063537.872834-2-li.meng@amd.com>

On Tue, Dec 05, 2023 at 02:35:31PM +0800, Meng Li wrote:
> amd-pstate driver also uses SCHED_MC_PRIO, so decouple the requirement
> of CPU_SUP_INTEL from the dependencies to allow compilation in kernels
> without Intel CPU support.
> 
> Tested-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
> Reviewed-by: Huang Rui <ray.huang@amd.com>
> Reviewed-by: Perry Yuan <perry.yuan@amd.com>
> Signed-off-by: Meng Li <li.meng@amd.com>
> ---
>  arch/x86/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 3762f41bb092..3e57773f946a 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1054,8 +1054,9 @@ config SCHED_MC
>  
>  config SCHED_MC_PRIO
>  	bool "CPU core priorities scheduler support"
> -	depends on SCHED_MC && CPU_SUP_INTEL
> -	select X86_INTEL_PSTATE
> +	depends on SCHED_MC
> +	select X86_INTEL_PSTATE if CPU_SUP_INTEL
> +	select X86_AMD_PSTATE if CPU_SUP_AMD && ACPI
>  	select CPU_FREQ
>  	default y
>  	help
> -- 

I was gonna ask why the selects but apparently mingo wants SCHED_MC_PRIO
to be selectable easier:

0a21fc1214a2 ("sched/x86: Make CONFIG_SCHED_MC_PRIO=y easier to enable")

So,

Acked-by: Borislav Petkov (AMD) <bp@alien8.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

