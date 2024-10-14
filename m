Return-Path: <linux-kselftest+bounces-19639-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 987C699C85D
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 13:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE5128E74B
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Oct 2024 11:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3841A7079;
	Mon, 14 Oct 2024 11:10:38 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AAF12C475;
	Mon, 14 Oct 2024 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904238; cv=none; b=HwgCwW3IR28urISkJtUhFb1Ey/1T8hrEVEWLuXd7Ez8fQAXOdd/OKQlY2Aoi0mzMHcAZ58KvSX+a/DU3UgDPjz3ViyehvNJvIWtl7Ke1XrRdLrlhO5Z9L2V2bRiT0P0o+K6fkmsL6eFtstQXcrnO4vftsfBx/OOJxRN0P25iOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904238; c=relaxed/simple;
	bh=PojU6kypepWIWq7RgQl7oNjMigZv2wfzBGIf4mzcW6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJfb62EovKJNDacKEKnZ0dtWazJvhlnRZ5QrRM9eieuYjgtx8JV1b5gyF1F4ZrA/VeL+v6bWiYrJ0BeX5n5anEOO5y9qvMYqIYUcGC9Vg2TxoJMKJeru9PjqvGjs5Q1HUUBF7TzoG4NzY3Rqeeplrotfw6aWV4Y8I9S8ed3ThOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 49AFC1007;
	Mon, 14 Oct 2024 04:11:06 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E88E13F51B;
	Mon, 14 Oct 2024 04:10:31 -0700 (PDT)
Message-ID: <b3b77c4a-67fe-4052-92db-fd2aabfa2ba3@arm.com>
Date: Mon, 14 Oct 2024 12:10:30 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V13 11/14] perf tools: Add missing_features for
 aux_start_paused, aux_pause, aux_resume
To: Adrian Hunter <adrian.hunter@intel.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Heiko Carstens <hca@linux.ibm.com>, Thomas Richter <tmricht@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>, James Clark <james.clark@arm.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Will Deacon
 <will@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 H Peter Anvin <hpa@zytor.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhenyu Wang <zhenyuw@linux.intel.com>, mizhang@google.com,
 kvm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
References: <20241014105124.24473-1-adrian.hunter@intel.com>
 <20241014105124.24473-12-adrian.hunter@intel.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <20241014105124.24473-12-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/14/24 11:51, Adrian Hunter wrote:
> 
> 
> Display "feature is not supported" error message if aux_start_paused,
> aux_pause or aux_resume result in a perf_event_open() error.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Acked-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

Reviewed-by: Leo Yan <leo.yan@arm.com>

> ---
> 
> 
> Changes in V13:
>          Add error message also in EOPNOTSUPP case (Leo)
> 
> 
>   tools/perf/util/evsel.c | 12 ++++++++++++
>   tools/perf/util/evsel.h |  1 +
>   2 files changed, 13 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 9621c8c12406..fd28ff5437b5 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2177,6 +2177,12 @@ bool evsel__detect_missing_features(struct evsel *evsel)
>                  perf_missing_features.inherit_sample_read = true;
>                  pr_debug2("Using PERF_SAMPLE_READ / :S modifier is not compatible with inherit, falling back to no-inherit.\n");
>                  return true;
> +       } else if (!perf_missing_features.aux_pause_resume &&
> +           (evsel->core.attr.aux_pause || evsel->core.attr.aux_resume ||
> +            evsel->core.attr.aux_start_paused)) {
> +               perf_missing_features.aux_pause_resume = true;
> +               pr_debug2_peo("Kernel has no aux_pause/aux_resume support, bailing out\n");
> +               return false;
>          } else if (!perf_missing_features.branch_counters &&
>              (evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_COUNTERS)) {
>                  perf_missing_features.branch_counters = true;
> @@ -3397,6 +3403,10 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                          return scnprintf(msg, size,
>          "%s: PMU Hardware doesn't support 'aux_output' feature",
>                                           evsel__name(evsel));
> +               if (evsel->core.attr.aux_action)
> +                       return scnprintf(msg, size,
> +       "%s: PMU Hardware doesn't support 'aux_action' feature",
> +                                       evsel__name(evsel));
>                  if (evsel->core.attr.sample_period != 0)
>                          return scnprintf(msg, size,
>          "%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
> @@ -3427,6 +3437,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>                          return scnprintf(msg, size, "clockid feature not supported.");
>                  if (perf_missing_features.clockid_wrong)
>                          return scnprintf(msg, size, "wrong clockid (%d).", clockid);
> +               if (perf_missing_features.aux_pause_resume)
> +                       return scnprintf(msg, size, "The 'aux_pause / aux_resume' feature is not supported, update the kernel.");
>                  if (perf_missing_features.aux_output)
>                          return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
>                  if (!target__has_cpu(target))
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index bd08d94d3f8a..d40df2051718 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -221,6 +221,7 @@ struct perf_missing_features {
>          bool weight_struct;
>          bool read_lost;
>          bool branch_counters;
> +       bool aux_pause_resume;
>          bool inherit_sample_read;
>   };
> 
> --
> 2.43.0
> 
> 

