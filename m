Return-Path: <linux-kselftest+bounces-38072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 665F3B1569D
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 02:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903AD3BE93C
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Jul 2025 00:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D441369B4;
	Wed, 30 Jul 2025 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mcyuKJcO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED467E0E4
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Jul 2025 00:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753835884; cv=none; b=c0P1HIk8Jfu0BH43R8YDBlbyL4e9BhiXMn8L62mbNOx+FP/JIyRBd9Wmr5n6Gh/k5qOcTAXppZPkpCMsRxytRr/IagBWm9+fVPUl3d8NS7SZ6XtF+71sldaWsqTFpE2SAZGdkQG6V7kxQY6ISiMrwhSVTm6h5jPPxiSTaxMvb1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753835884; c=relaxed/simple;
	bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uEyGKMntZcmDomPZbflreTuG/zeTKXo1kT3At1yIAiZL922l87xPi5bzDdQzK84u2UbuCdpCIU73mxtku7JnQ96q043eVNohEeAW3np++b3odzPtvj/pHon4WNgiBmOn7FJIw7Zzj+d5uVde3lUlxP/+lk7gGOT2mCYuKhrR3vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mcyuKJcO; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b421b03d498so118531a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Jul 2025 17:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753835883; x=1754440683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=mcyuKJcOLvd4KWcA6XbGTOORwXL7XY2Bymde0/RtCaPOAYnsibjcnompPYeGvyqiBR
         sew8Ad6fOZq3KnLvmMOAK5GwJdtYUuK9nhreVb+xC4wVVwrTKSrCOUl/UZ3ihGFTBLvt
         uNwk/fjxG0yw7vRVNCUtVnW4DKVirBEdJsLUXAh90tXkP0h6BWB6OHO0qlQ2PHs7pnKl
         Hw+3KNmxLdyORTrz9RqYF+1BJKGHqLuQEf6xHNRtMpD5IE+BPcQ1wMh2jtqqow3efMOv
         kLw45fT//yUtqmL7O2ZtwgqSgSvV6oDEEPMqlNeY73Jx2lekTPB88zgjhmnmS1HxFm3L
         E3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753835883; x=1754440683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PoyA0CcW92FoQ3I73ytTZfPzdZaHEfO3pw0xz04Rz34=;
        b=KkRTxAInfUf/xrIOwRbgMXBZeu2vemTl1YMa20WIEXrJJKkRk1SzTWhr4wGhd3AHFy
         FnKTotmaKR4/a1Kg/D3rZC0EkeRlDrHR84tS0eNfd1ylZ3B+EiaFhzTMlxOlmxg/JI5t
         5OlbGX5HU0PGRvHYB9t+4lQWqwFql/BIWBUduchgjcIez5adIegKinsRYng/Ta7MxA+s
         Xd3L+jYCrqDUeFsBPRF837o4UPPFss+AcWFDmuPG/JliWWpDe/0fnHxgKnvXjbZHOP10
         nejgnQ1IhixFUbKp/XghwBUvT4sKTUMXkB0PwF1HvSda7F7hRQC4SywA91NZJ6m04J4S
         XorA==
X-Forwarded-Encrypted: i=1; AJvYcCU+HfwNXCDKV05d8q9noqOdjFdQxQVEhzwwOHP2cV+v6TzxZ823MceLMGTdYAGyB2fUVoCdZZVQOJwfKdGGRG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV73tHa2jB7roip7gzUjmML4RyskGyhuiAngYfwhe8JUxwavuY
	mWODm9frTm0V/vU3H4HnK595hPRUbVJm7Ft06lPAEtEEYFX3KMBarZuGgL1cKWmweuhRgvVxfPB
	mn6k6sw==
X-Google-Smtp-Source: AGHT+IFmEOk3LVUVJNWYxzRPuTmK+e+GHYpOt6lQopxXicjjLZ69T+VUxxaSfay3rEISbglMLxNY+x5v644=
X-Received: from pjbcz8.prod.google.com ([2002:a17:90a:d448:b0:31f:d4f:b20d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384e:b0:31f:2bd7:a4d2
 with SMTP id 98e67ed59e1d1-31f5de69998mr1735098a91.35.1753835882538; Tue, 29
 Jul 2025 17:38:02 -0700 (PDT)
Date: Tue, 29 Jul 2025 17:38:00 -0700
In-Reply-To: <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324173121.1275209-1-mizhang@google.com> <20250324173121.1275209-21-mizhang@google.com>
 <a700ab4c-0e8d-499d-be71-f24c4a6439cf@amd.com> <aG6QeTXrd7Can8PK@google.com> <7dc97db7-5eea-4b65-aed3-4fc2846e13a6@linux.intel.com>
Message-ID: <aIlpaL-yEU_0kgrD@google.com>
Subject: Re: [PATCH v4 20/38] KVM: x86/pmu: Check if mediated vPMU can
 intercept rdpmc
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Liang@google.com, 
	Kan <kan.liang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Yongwei Ma <yongwei.ma@intel.com>, Xiong Zhang <xiong.y.zhang@linux.intel.com>, 
	Jim Mattson <jmattson@google.com>, Zide Chen <zide.chen@intel.com>, 
	Eranian Stephane <eranian@google.com>, Shukla Manali <Manali.Shukla@amd.com>, 
	Nikunj Dadhania <nikunj.dadhania@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, Jul 29, 2025, Dapeng Mi wrote:
> BTW, Sean, may I know your plan about the mediated vPMU v5 patch set? Thanks.

I'll get it out this week (hopefully tomorrow).

