Return-Path: <linux-kselftest+bounces-32992-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 729C5AB7A60
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 02:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 409D817BA96
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 May 2025 00:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC5E10E3;
	Thu, 15 May 2025 00:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XXDpBpx2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3934525761
	for <linux-kselftest@vger.kernel.org>; Thu, 15 May 2025 00:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747267959; cv=none; b=bOWF/x3+4ViBLrcylZiy6aCaHwwlNe35JBGLl/09QOsB5k8/qnTknRQzrqLy9J9EndnXzfzsnDjjjfqrJKxn/s3YdNFmClaF5gfYzkR6a6npKlqCPhOg7dgN2Ua40F7F5YtC51UWaJknbsb4i4fuorZlrULtL2XKATkZEObV68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747267959; c=relaxed/simple;
	bh=WWTAljqGjigzo2ahsVS5AW4s5xTXB+6gUo7V2DIDeDo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Uo3s9c7dPvElRBX2kJV+IBubYUGgpxZM/xN1Zk14m1hLiMgCSCgYuE8BcDnLdxcmaNmLJWjF309Txl/KCnwi/FXI9eW42nxGHlbDv0jTSqmqH9THdGE2bp/SfIZBPZLRwQUu1D6tib39zAIIPgJnEUaJBEkV1dt07wnqajo1//U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XXDpBpx2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-30a96aca21eso427967a91.2
        for <linux-kselftest@vger.kernel.org>; Wed, 14 May 2025 17:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747267957; x=1747872757; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y0rWjnJEgSkZ5EEuFzNdJ+XGOmuhTpZYLseo2eQ7Pw=;
        b=XXDpBpx2s4ZF+Jc8qejaTMDOHbfIXxG1SomRxNvPln2/SqEAdLEndHNakPaBUWrchE
         FqDjsmpiY4UVzdjjACYZc9XZH07DXtmS9ogWG1F2Ek/8SoNEzjLsY9KgHK/C/yU89ZRm
         HhhC5uh9QdgkdAfKbt581fA0C6owzzq9R+Sl3YemiLJW5AOdoCkGDKjKVVV6pFKkS6+y
         rKnmcAuieyN3UszYrz6jj/ujDwogpA4CvlsoM4MCBa8+xv7TLVhGGa7YfSeBxt9NjsOP
         z9vW75KO2U49c0aQVZNSkmZiu9kUu34ydDQlnhca8B2BfJHQupz4dJG1KWUGylgURCXp
         5Icg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747267957; x=1747872757;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Y0rWjnJEgSkZ5EEuFzNdJ+XGOmuhTpZYLseo2eQ7Pw=;
        b=B38+arLNbGgc/tCi6XT5j3cHUvBmsA7jjNA66gy42dnpKuK6TckDIR7aEJSD/e3ovj
         6bbjLyUnlsCBEaCTupY4nDVM8BF8bANWogVX5WegJ84JyvB7+bUVWxyzEIF8jkbqyuo9
         NRIzVPHpFV93JaGIJEyyANHD46u+juGRxcc/Mi7XR2NaL/gXnbzK1uQymDAU+fDQpt0h
         B1hyVrMvB7RXtyH/yCMfr3YENPnqj8uRgeJM13slBsS4Tm6PNMMDIYJjeXlKfbaXqchc
         PrOthe8NS9lEHN49YUjWN8N8lg4YNZHgS7C5HZ3RmuGk/14WPAR5HsjbQVlN+os4wimv
         4jSw==
X-Forwarded-Encrypted: i=1; AJvYcCWbPJvEN/rSumr9Z1rQsYsR6cc+6EIFl1PaeBcnjE7qUv4I3ut2uD+j0KcIIdVAv7Vhr3iMeZFRZF8qa0dkSNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwvCap9CvujMMay/YyFcsyrmDvpWQdX49Se7xPoNumRmrVCmkJ
	ospUXdeMYTg4fexHjn5z6p6b31c3y+3+HLhwkSfRgKC0Hn1DlyZzAyzsBcrW7zuUGFx/EPsvzYe
	XZg==
X-Google-Smtp-Source: AGHT+IGuKZaiP7uhLwBXtbhrYaWam3Xnydy1XbmyTTmLh8aez6vEjqSYtDXffsuY+hhQJSHyM5jNP3mfQHk=
X-Received: from pjbpb18.prod.google.com ([2002:a17:90b:3c12:b0:2f5:63a:4513])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:510d:b0:2ff:6488:e01c
 with SMTP id 98e67ed59e1d1-30e2e641e96mr7850147a91.29.1747267957562; Wed, 14
 May 2025 17:12:37 -0700 (PDT)
Date: Wed, 14 May 2025 17:12:35 -0700
In-Reply-To: <20250324173121.1275209-18-mizhang@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-18-mizhang@google.com>
Message-ID: <aCUxc3c6Tt6yVmqi@google.com>
Subject: Re: [PATCH v4 17/38] KVM: x86/pmu: Add perf_capabilities field in
 struct kvm_host_values{}
From: Sean Christopherson <seanjc@google.com>
To: Mingwei Zhang <mizhang@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Jim Mattson <jmattson@google.com>, 
	Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 24, 2025, Mingwei Zhang wrote:
> From: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Add perf_capabilities in kvm_host_values{} structure to record host perf
> capabilities. KVM needs to know if host supports some PMU capabilities
> and then decide if passthrough or intercept some PMU MSRs or instruction
> like rdpmc, e.g. If host supports PERF_METRICES, but guest is configured
> not to support it, then rdpmc instruction needs to be intercepted.

This is wrong (spoiler alert).  This patch can be dropped.

