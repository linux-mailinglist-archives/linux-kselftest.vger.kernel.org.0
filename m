Return-Path: <linux-kselftest+bounces-33484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA470ABFD9E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1DC4A1FD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8E1280CE3;
	Wed, 21 May 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3P9xT4e"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6AE22154A;
	Wed, 21 May 2025 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857636; cv=none; b=OY6XLCAyTmo7/kUcc00dZ31mPC/jsPmVoyHeAxXPxOHBZdiRB5epX2eBkh1w9ubkLnsAdVMK7fG3qxJ3mpgCzOiJMJa5mnwtL7tC9hCAM+xllCRYRjmu62LK2LnF3S+4zXIOwUeu75+QBQgm+CVwDBf4osol9+7bAaG28WXQxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857636; c=relaxed/simple;
	bh=nAUzpcXK1h/ubGnw28aVMwC2X90t/BjKy6cJTAqX1sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GaeMRV4rRNvIgERcmTwV03SOygRJO8zE/mraEdg3mv89xcn6LiVhhErkpeCPtm5gP9yu3oN/OSecT4zY1Y6a+tN+w+nOZhh1n8Qh0YqZY1+XV2Y3wcT0XbEEZJtNf/eZPCYKOXIGTmS1cOorDO60luKQscsWgLbm0NWtQ0XhYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3P9xT4e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0867EC4CEE4;
	Wed, 21 May 2025 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747857635;
	bh=nAUzpcXK1h/ubGnw28aVMwC2X90t/BjKy6cJTAqX1sw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3P9xT4eR+7x+5B+FMY2h+aRLEqBVVHwuZu7W+ijQlSP56P+RfHhEzc0Gu4e1vKN1
	 iETpNA00s2Wc+Z7uXyEofa7M4+XKAN951L03R+sRxOVB885hxVAno3rn3aa9I1IwlI
	 8y3y9Go0NKf4aRmZ/u1VLHUMYHGJaFnqZe3mALKPtIu7EqDMzWWIGx0scJjtiQcw7y
	 O8vavB/57XukdYSq87NIE7mN0CmDFWiJ7Bqhk/JtGPyOAsE2hWKpOojJaMFiDmH5HS
	 gUFT+LMiUt1SndlLXKFX4nxFvzRZS05nX0scNS74uHHFNR6p7rosn3E2Da6nB9CPic
	 olw1BB7RG/oLg==
Date: Wed, 21 May 2025 13:00:33 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 34/38] perf/x86/amd: Support
 PERF_PMU_CAP_MEDIATED_VPMU for AMD host
Message-ID: <aC4w4WmPywIEsMwk@google.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-35-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-35-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:31:14PM +0000, Mingwei Zhang wrote:
> From: Sandipan Das <sandipan.das@amd.com>
> 
> Apply the PERF_PMU_CAP_MEDIATED_VPMU flag for version 2 and later
> implementations of the core PMU. Aside from having Global Control and
> Status registers, virtualizing the PMU using the passthrough model
> requires an interface to set or clear the overflow bits in the Global
> Status MSRs while restoring or saving the PMU context of a vCPU.
> 
> PerfMonV2-capable hardware has additional MSRs for this purpose namely,
> PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
> suitable for use with mediated vPMU.

So IBS cannot be used in the guest (with MEDIATED_VPMU) and host can
profile guests with it, right?

Thanks,
Namhyung

> 
> Signed-off-by: Sandipan Das <sandipan.das@amd.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/amd/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 30d6ceb4c8ad..a8b537dd2ddb 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1433,6 +1433,8 @@ static int __init amd_core_pmu_init(void)
>  
>  		amd_pmu_global_cntr_mask = x86_pmu.cntr_mask64;
>  
> +		x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_MEDIATED_VPMU;
> +
>  		/* Update PMC handling functions */
>  		x86_pmu.enable_all = amd_pmu_v2_enable_all;
>  		x86_pmu.disable_all = amd_pmu_v2_disable_all;
> -- 
> 2.49.0.395.g12beb8f557-goog
> 

