Return-Path: <linux-kselftest+bounces-31646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE14CA9CAB7
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:43:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2939A174976
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670452522B5;
	Fri, 25 Apr 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZpdqvbuO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49AF101DE;
	Fri, 25 Apr 2025 13:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588613; cv=none; b=T5j3OdxvZka2Y3e7rf4pELUrFgAo6CVJaKLShWxFkq2kdaLPylIKxhiGCfDO3WGR2yv9/dwYDju3tsPIkJEYzcBPDZ9uxoGkMtUnJ7sIkFmmKHcnAdBxgrj/xXFR50RiOW0FUVc0dwh1Dk6ZwXMKYGVJtuIGBwHJxaL6rQgxPao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588613; c=relaxed/simple;
	bh=KhwXeELsWDYEQCmuxsv+B9NmOYsLV/pEyvPPekakcYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiHbnRqYUvdRN1vvcQxl5FhNjnSqejWYJ3N1nRvBhghIfDnQhE0ufMbLjqQNleyy8IJv7hguUXCsqZciE3TgGRTO7h+9yYHXCRiT8rFyurdib0nfv9meoiGZr5O3wKzYKnpysyadFZYoX07b21ZgyOW3D/F6dAhAEiE0ZhtPeV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZpdqvbuO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tP0vclURKejKrLfHzLq1zJzE82HWQ3VGQ6mvSLSkqbY=; b=ZpdqvbuOz2MyYaepUuvK0xFPb1
	e5eEUNpwPk6ar/8Hx/LSoDZINZLH+8T1eU3EyY0qjSsHiEIEe2PbqsVkdsxwg/x8hCarnzr8lYY2y
	4Xt74KSpw4Lkr71WVqfjQyh2mJx9wzADgPyoL+ctWeWHdDOrPjWPNUUOI8wQLHlrSOAzBoRVzVWrv
	P3ZTpORX9bif5ThQBelxQMIBpkVivIrsPEfzvzGuhRnXxq4Ftalf+wgMSp/2I/bwbDSZ5lpCBL2Kb
	dWdlh5QbNa+w1asMH5qA8gMecNonTP80DNolqG7SR5GeY+9EYC747CcxzUtQvUHMcbZnUynO3m7Km
	I6GC0x+Q==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u8JKu-0000000C3QE-0v5E;
	Fri, 25 Apr 2025 13:43:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5FD483003C4; Fri, 25 Apr 2025 15:43:23 +0200 (CEST)
Date: Fri, 25 Apr 2025 15:43:23 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Mingwei Zhang <mizhang@google.com>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com,
	"H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, Yongwei Ma <yongwei.ma@intel.com>,
	Xiong Zhang <xiong.y.zhang@linux.intel.com>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Jim Mattson <jmattson@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Zide Chen <zide.chen@intel.com>,
	Eranian Stephane <eranian@google.com>,
	Shukla Manali <Manali.Shukla@amd.com>,
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Subject: Re: [PATCH v4 10/38] perf/x86: Support switch_guest_ctx interface
Message-ID: <20250425134323.GA35881@noisy.programming.kicks-ass.net>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-11-mizhang@google.com>
 <20250425111531.GG1166@noisy.programming.kicks-ass.net>
 <e2f3b1d5-ed91-47a1-aead-28675bcca2c8@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2f3b1d5-ed91-47a1-aead-28675bcca2c8@linux.intel.com>

On Fri, Apr 25, 2025 at 09:06:26AM -0400, Liang, Kan wrote:
> 
> 
> On 2025-04-25 7:15 a.m., Peter Zijlstra wrote:
> > On Mon, Mar 24, 2025 at 05:30:50PM +0000, Mingwei Zhang wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> Implement switch_guest_ctx interface for x86 PMU, switch PMI to dedicated
> >> KVM_GUEST_PMI_VECTOR at perf guest enter, and switch PMI back to
> >> NMI at perf guest exit.
> >>
> >> Signed-off-by: Xiong Zhang <xiong.y.zhang@linux.intel.com>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> Tested-by: Yongwei Ma <yongwei.ma@intel.com>
> >> Signed-off-by: Mingwei Zhang <mizhang@google.com>
> >> ---
> >>  arch/x86/events/core.c | 12 ++++++++++++
> >>  1 file changed, 12 insertions(+)
> >>
> >> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> >> index 8f218ac0d445..28161d6ff26d 100644
> >> --- a/arch/x86/events/core.c
> >> +++ b/arch/x86/events/core.c
> >> @@ -2677,6 +2677,16 @@ static bool x86_pmu_filter(struct pmu *pmu, int cpu)
> >>  	return ret;
> >>  }
> >>  
> >> +static void x86_pmu_switch_guest_ctx(bool enter, void *data)
> >> +{
> >> +	u32 guest_lvtpc = *(u32 *)data;
> >> +
> >> +	if (enter)
> >> +		apic_write(APIC_LVTPC, guest_lvtpc);
> >> +	else
> >> +		apic_write(APIC_LVTPC, APIC_DM_NMI);
> >> +}
> > 
> > This, why can't it use x86_pmu.guest_lvtpc here and call it a day? Why
> > is that argument passed around through the generic code only to get back
> > here?
> 
> The vector has to be from the KVM. However, the current interfaces only
> support KVM read perf variables, e.g., perf_get_x86_pmu_capability and
> perf_get_hw_event_config.
> We need to add an new interface to allow the KVM write a perf variable,
> e.g., perf_set_guest_lvtpc.

But all that should remain in x86, there is no reason what so ever to
leak this into generic code.

