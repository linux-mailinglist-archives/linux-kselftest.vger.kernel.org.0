Return-Path: <linux-kselftest+bounces-31635-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE649A9C6FB
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D572D3AD583
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 11:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14DF242D64;
	Fri, 25 Apr 2025 11:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BNdRMrep"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F63D23D2B7;
	Fri, 25 Apr 2025 11:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745579743; cv=none; b=HOhm9kCqCP5D01jmoPa8SjIF2xE+LhgKx6igjIzo2k5e4NocC+k0unCXUMfdIOdAev26O1LRQtKErx7FYcDkNETVYo3fxg6j9u1CiC9qAYmGDfGnimNAAzHcsG0dFbzda41tezQDET9QS5WtyA+F38k1jH7hpIoywXNaS61fbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745579743; c=relaxed/simple;
	bh=6U2fI6S/p8eSAqh4fKVbGSN0dho3Y9sYb0oRuK84aSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cxrH368GHfmx2FlJckPtDW1SdL1HQnzq/XYlIMNBxkz+bOftaQfTZBqzSaFwXZZSufIoKcYlJXLzuNKoMnZkDChkd+IhHBHfo1o7c8ohX72g0esmR3BlM/7WKkD5BGDh48pngw1jaxlS+UQn/kNyJZXiqDmtTP7DHOvttlKhsLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BNdRMrep; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Y2jaLA7bHIH8e1Pz+7udopVwej63Pc20Q11o4bDXZoo=; b=BNdRMrepiS7e1KbyabGblcB3fX
	tJtF3zYaHLY235htNDtRJc3WdQJsXI6D4eF6qsUz9/O0mJGq0By2JeywNrWQgSq6Dtb+hrFbGUBuw
	OhpJMkLHmTkOT7MaeqL8ebjuOKW1CLl2P50TKYAqm0GTtHGgg/LF9UFe6J1kC4OR0htUdLcFP1pJh
	o3K8ZIIb5qWTghMfTv4W4U37Kwu2NC2/lPCZ0FsVAdfGOGcyfJZbwYoxi73lRAbpzxx0c9hOLwtrs
	Fmt3aDTje+UsHRUuUEfqUgIyeFcolu8AEkGeqZiuKNto/cSf4LLkZcdJXms6rlbOmNQKD4WG2uM+C
	Wurzp1hg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8H1o-0000000C1rJ-2BgJ;
	Fri, 25 Apr 2025 11:15:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C9B08300583; Fri, 25 Apr 2025 13:15:31 +0200 (CEST)
Date: Fri, 25 Apr 2025 13:15:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Mingwei Zhang <mizhang@google.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
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
Subject: Re: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
Message-ID: <20250425111531.GG1166@noisy.programming.kicks-ass.net>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-11-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-11-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:50PM +0000, Mingwei Zhang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
> NMI at perf guest exit.
> 
> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> ---
>  arch/x86/events/core.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 8f218ac0d445..28161d6ff26d 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
>  	return ret;
>  }
>  
> +static void x86_pmu_switch_guest_ctx(bool enter, void *data)
> +{
> +	u32 guest_lvtpc = *(u32 *)data;
> +
> +	if (enter)
> +		apic_write(APIC_LVTPC, guest_lvtpc);
> +	else
> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
> +}

This, why can't it use x86_pmu.guest_lvtpc here and call it a day? Why
is that argument passed around through the generic code only to get back
here?

