Return-Path: <linux-kselftest+bounces-16349-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0FD95FCBA
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 00:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 614171C21488
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 Aug 2024 22:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE319D095;
	Mon, 26 Aug 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KdKHPEhe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B958519D8B4
	for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724711248; cv=none; b=kd1kGcLDe2DK+D8HbG8lLnn58D3PpJIpJ1/Q/V+xVSQq76KQ8Tpn70WeG0GgTF1nCa4npO4FGMEALkywqKQLhujUM++MbsyE3swAruBAlhaBbtvd3486NYv1vM4n0n0jA8qZB643e5w/OaIHWcOgJE+P4m4nnztgCviZDKMKuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724711248; c=relaxed/simple;
	bh=tWBI1CEvcAyhociJ69GxLrZa7hka3+t0jWXGhE06iv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eo6ZF8ybgO9wEVu7P1rpNIPzPEovWJoetDt94mswdwAtfPsVfUr5PAWLmQqtlSuKVro9Lir5APb7QjY2x4sNQ2dDeTOkaxzAKAqVR62rdfAgfpPZz14OkxCUjLAKG4J+2Ru/bKz4tla7f7W/Kzn7VTe5t5RPqPtmZhg2wFSU3B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KdKHPEhe; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7141b04e7b5so2949591b3a.2
        for <linux-kselftest@vger.kernel.org>; Mon, 26 Aug 2024 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724711246; x=1725316046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6efL/F1kuzyqYczbG3K6fnVaN6D4LGghnY70VHvVZ5o=;
        b=KdKHPEhed1wfJECckm6wP831qbjDBGQoQqMdnCKQF3VoSf8k8fKpHeDtibNm0M0N+6
         k6Ni9Cc1dZEc86+L17oDO+jXgzjAmMshot8ZucZfe7w7QpMcXt+Zs0/pQaXHK2ANhan/
         XFXom/jy7U/TJAXydK+WZLSXlkQfwfK+9Ych4WTw0GGQyKwSIWEps9QwCzZM6a2iayv1
         Yvf1ZW1h8FhXwOYydlhuOWAFDETWIyulurLgLbKh4gIuj7+FJpiUj1/vRADrI5C8sjGG
         4AIcr9epl2S7WHnlhuLlnvcDsc/qGBAbM+as9yJm5Es7BMLIXHMwRbDSyFbkB1bm+E5z
         Yx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724711246; x=1725316046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6efL/F1kuzyqYczbG3K6fnVaN6D4LGghnY70VHvVZ5o=;
        b=BlskVKlch3zbE5dnStMNHHmEcyuavAsekSkT9CokSzyIU5J6a0fbdRIPuuuhe4IMTM
         +Jd5z76rk954DX0R3baz4H2ioiq9q1tyllklSEkb36GmY1KeIPJTmZQX3N1kcQK+Masf
         Oot0C4C7MH9UNyTIsuEaD+F0AOigFht+1RfCOW8CSTHCHlb/LvyV5boAxAlSmng72GOe
         x3LsXsFaLam8IEbv+th7JbsWe/e6fqOwI2ZYR6mWIVIgqhM0KMXXMWNRhTsw7VyeTG63
         1PFycAqtB8qGU19BFrqU103GHeaYiLPdX9IVCVPo8gHoyVjw+vzX5596+wlc4+f0iLvP
         8bog==
X-Forwarded-Encrypted: i=1; AJvYcCVODGx0L2lD/QGdjAAaPS6xiaec/eF8mYhDkyqRZ17W2S99W9B6NpXgzXwTUVLWobIVXvmo+DH+o6oQouYum/A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0XqRCZPGv5kCRYK1yMk1GK9kpg++cEF+PCE3rPZqOAS6gw6UL
	AiWDxt6WSQ4MJYW1ZE2nI4RknrVF4+KypYFFTrEiFZpWFunKWH8L5jfuvbIysg==
X-Google-Smtp-Source: AGHT+IFXBXnPx9KUJPgGCZuBF2pi6WskFdoQLOqLbWTVKDqZHz2/7M/H+7VpUWRwf7chThrTS0I+iw==
X-Received: by 2002:a05:6a00:2e29:b0:70d:1b17:3c5e with SMTP id d2e1a72fcca58-71445758d3cmr11996200b3a.6.1724711245654;
        Mon, 26 Aug 2024 15:27:25 -0700 (PDT)
Received: from google.com (176.13.105.34.bc.googleusercontent.com. [34.105.13.176])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad55fe9sm7994982a12.60.2024.08.26.15.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 15:27:24 -0700 (PDT)
Date: Mon, 26 Aug 2024 22:27:20 +0000
From: Mingwei Zhang <mizhang@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, Jinrong Liang <ljr.kernel@gmail.com>,
	Jim Mattson <jmattson@google.com>,
	Aaron Lewis <aaronlewis@google.com>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] KVM: x86: selftests: Define AMD PMU CPUID leaves
Message-ID: <Zs0BSCb_Khyxg08x@google.com>
References: <20240813164244.751597-1-coltonlewis@google.com>
 <20240813164244.751597-3-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813164244.751597-3-coltonlewis@google.com>

On Tue, Aug 13, 2024, Colton Lewis wrote:
> This defined the CPUID calls to determine what extensions and
> properties are available. AMD reference manual names listed below.
> 
> * PerfCtrExtCore (six core counters instead of four)
> * PerfCtrExtNB (four counters for northbridge events)
> * PerfCtrExtL2I (four counters for L2 cache events)
> * PerfMonV2 (support for registers to control multiple
>   counters with a single register write)
> * LbrAndPmcFreeze (support for freezing last branch recorded stack on
>   performance counter overflow)
> * NumPerfCtrCore (number of core counters)
> * NumPerfCtrNB (number of northbridge counters)
> 
> Signed-off-by: Colton Lewis <coltonlewis@google.com>
> ---
>  tools/testing/selftests/kvm/include/x86_64/processor.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/include/x86_64/processor.h b/tools/testing/selftests/kvm/include/x86_64/processor.h
> index a0c1440017bb..9d87b5f8974f 100644
> --- a/tools/testing/selftests/kvm/include/x86_64/processor.h
> +++ b/tools/testing/selftests/kvm/include/x86_64/processor.h
> @@ -183,6 +183,9 @@ struct kvm_x86_cpu_feature {
>  #define	X86_FEATURE_GBPAGES		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 26)
>  #define	X86_FEATURE_RDTSCP		KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 27)
>  #define	X86_FEATURE_LM			KVM_X86_CPU_FEATURE(0x80000001, 0, EDX, 29)
> +#define	X86_FEATURE_PERF_CTR_EXT_CORE	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 23)
> +#define	X86_FEATURE_PERF_CTR_EXT_NB	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 24)
> +#define	X86_FEATURE_PERF_CTR_EXT_L2I	KVM_X86_CPU_FEATURE(0x80000001, 0, ECX, 28)

You won't be testing Northbridge counters and L2I counters, so these two
could be optional to the patch.
>  #define	X86_FEATURE_INVTSC		KVM_X86_CPU_FEATURE(0x80000007, 0, EDX, 8)
>  #define	X86_FEATURE_RDPRU		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 4)
>  #define	X86_FEATURE_AMD_IBPB		KVM_X86_CPU_FEATURE(0x80000008, 0, EBX, 12)
> @@ -195,6 +198,8 @@ struct kvm_x86_cpu_feature {
>  #define	X86_FEATURE_VGIF		KVM_X86_CPU_FEATURE(0x8000000A, 0, EDX, 16)
>  #define X86_FEATURE_SEV			KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 1)
>  #define X86_FEATURE_SEV_ES		KVM_X86_CPU_FEATURE(0x8000001F, 0, EAX, 3)
> +#define	X86_FEATURE_PERF_MON_V2		KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 0)

Let's use X86_FEATURE_PERFMON_V2 instead.

> +#define	X86_FEATURE_PERF_LBR_PMC_FREEZE	KVM_X86_CPU_FEATURE(0x80000022, 0, EAX, 2)

You don't use this feature, do you? If not, this can be optional for the
patch.
>  
>  /*
>   * KVM defined paravirt features.
> @@ -281,6 +286,8 @@ struct kvm_x86_cpu_property {
>  #define X86_PROPERTY_GUEST_MAX_PHY_ADDR		KVM_X86_CPU_PROPERTY(0x80000008, 0, EAX, 16, 23)
>  #define X86_PROPERTY_SEV_C_BIT			KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 0, 5)
>  #define X86_PROPERTY_PHYS_ADDR_REDUCTION	KVM_X86_CPU_PROPERTY(0x8000001F, 0, EBX, 6, 11)
> +#define X86_PROPERTY_NUM_PERF_CTR_CORE		KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 0, 3)
> +#define X86_PROPERTY_NUM_PERF_CTR_NB		KVM_X86_CPU_PROPERTY(0x80000022, 0, EBX, 10, 15)
>  

ditto.
>  #define X86_PROPERTY_MAX_CENTAUR_LEAF		KVM_X86_CPU_PROPERTY(0xC0000000, 0, EAX, 0, 31)
>  
> -- 
> 2.46.0.76.ge559c4bf1a-goog
> 

