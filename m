Return-Path: <linux-kselftest+bounces-33485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3D1ABFDA4
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 22:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13FAC189F3A5
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 May 2025 20:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E535A28A1C9;
	Wed, 21 May 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qHwsJb1g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37E222B8B9;
	Wed, 21 May 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857714; cv=none; b=TtJQ25Vzy4pQu5/ni+I9HAu9Jq1V+2in4IRlgzjaGua1MvfhT++bBid3W8tMwOZp4yizPwK7E2RG4APYGPOe3/CM4VbOsY/byFexkOykaoSlyh9dANNYxYhlcGZTLBRCptCdUmwmeb4zpSw09bKNvAlOiT8i4R3L1oYxG5P8ESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857714; c=relaxed/simple;
	bh=8oYbHgi3dSN5sYtlh/M8hB45JGShP32FfZWXEuCKwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpufVu42eo/L/1ceLHwBzvqPKkgKQ+ipgFsy7gopQT7UEqFCtabKtkpLV3ZZgMxnmphlkQWGED96xvZ0IEdnhvUPOWzm5bK25W6GeFaTbEIJab4qty+3/IPnOfCSlyIF1iQQy79dmmkNubjgKg1WIocurrbdmQivpR06TwM9sI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qHwsJb1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E29C4CEE4;
	Wed, 21 May 2025 20:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747857714;
	bh=8oYbHgi3dSN5sYtlh/M8hB45JGShP32FfZWXEuCKwsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qHwsJb1guGYXx1+pNKHsKaypiXjembrKX2sSgoSJ0j7QCGEEdPPUWbBntdksMO/SU
	 fNkU7WW01z68lrC57WN7qyTKJPc/XT4rOUHUi91E541kElQdob7QADDDTjxxCJWFV6
	 Wf68LGqXGj9AfTH9UnvpbwRgoxMnazzv5OYjTPnvkje4QZ3hfviKHfAkR6XMuXy0/B
	 lmA0ikIcLg9UfQlnGciH4+5dSLQVAN0WAQUXv1z9XQYzFCoAYBDWVFcfWM/ZWO4Nz0
	 god95dJdtAkDsSJFcODryRQajeFr2LwhRB4l72jkRSbzXx3xv+z+m/5Ygba584mf9k
	 HqhLf0FEC5Ewg==
Date: Wed, 21 May 2025 13:01:52 -0700
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
Subject: Re: [PATCH v4 09/38] perf: Add switch_guest_ctx() interface
Message-ID: <aC4xMGPUjGHzKcHB@google.com>
References: <20250324173121.1275209-1-mizhang@google.com>
 <20250324173121.1275209-10-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250324173121.1275209-10-mizhang@google.com>

On Mon, Mar 24, 2025 at 05:30:49PM +0000, Mingwei Zhang wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> When entering/exiting a guest, some contexts for a guest have to be
> switched. For examples, there is a dedicated interrupt vector for
> guests on Intel platforms.
> 
> When PMI switch into a new guest vector, guest_lvtpc value need to be
> reflected onto HW, e,g., guest clear PMI mask bit, the HW PMI mask
> bit should be cleared also, then PMI can be generated continuously
> for guest. So guest_lvtpc parameter is added into perf_guest_enter()
> and switch_guest_ctx().
> 
> Add a dedicated list to track all the pmus with the PASSTHROUGH cap, which

s/PASSTHROUGH/MEDIATED_VPMU/ ?

Thanks,
Namhyung


> may require switching the guest context. It can avoid going through the
> huge pmus list.
> 
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> Signed-off-by: Mingwei Zhang <mizhang@google.com>

