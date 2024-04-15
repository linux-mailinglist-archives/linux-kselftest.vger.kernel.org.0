Return-Path: <linux-kselftest+bounces-7944-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE368A49C2
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 10:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C5811F243C3
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3162E851;
	Mon, 15 Apr 2024 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cF6kmjYe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1242CCA0
	for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 08:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713168357; cv=none; b=dhEk9gjbZ1NkZHxIRsJ9wKOioUeQb/DHYe+cPXqW6myad/OoQXvMeiDJoqvR6xrEPk+0ETUKE2qGKvIQIdsXZpumz4C4WLjaSK3SRvMKI9WAD1NlqejDmB54vnOcwzSVA+8mPh+GmRvPKMyoZxq9lYiPrK/wTeOoELCVsqxyUMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713168357; c=relaxed/simple;
	bh=rZM9zLd/gJBQJm1KKpYow/zuy2L1p9P1YdXH2k57Sf8=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=grpLsRUZEuusP+2G9u+xxGvf5urhes4Vpt67LQljY12O8vTW2c0Wv+ORIHGSzvvy6bzYpccdTUFGzT80pItdUpuTT3jsqLw//4h6f+AazeCFCwSZknqb+ckGaC+EKOHetnjBD6zm4LRN0Oy9Ain8mEgO3zNC0+BiXwtDuZGuTxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cF6kmjYe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a20c33f06so32880487b3.2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 01:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713168354; x=1713773154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s+QzKS/TBsR0oqS/yx5/asjaA5pGnOo8W0mMCO+D7xM=;
        b=cF6kmjYeIsXgANFA/jU9WKOtZNJ/TlSt/GZ5GPeSEqQ5tRR3o8e6Oj/4nENDF1dWiF
         L3fGKS51kbi4tzcI1f9xhTBqsI/aZYGbzqrHAst5PZAh07S1U5QKxEoTxjR4xvZgi4Aj
         Wd4FVjbXPySUjnbbKkmfemdq8XgVrjRSbGuiCrgXQwU8OtECljegNhAB7Feg5YPuiU9C
         6P+cI2dPYdXkXmy9eik9Iyxiql+UP/9PLUHtRyGCG2iqn0WqN7DbiEddiW30ms5K379D
         HHCjfKuJwROTIm2ZJDRLOnzKUMa0Eaj5gpo+csYmyRSXcTSClS/LQYOcyhQ3kKCsGRL0
         mN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713168354; x=1713773154;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+QzKS/TBsR0oqS/yx5/asjaA5pGnOo8W0mMCO+D7xM=;
        b=hz3gzTQgE0GtHyGAHl7lsncjwmkjeYnWb3a5Lta0Ajj9aCxluV0zLxFOK1bao33xBZ
         Khv9dlHBgBrs/CM/q/8n3C5zqz23eXkGIEb5HnHok2gCYPP0swMO1ca3G+Rx/m+Lgaa0
         JvK5tWuQKOxLT7O/NN+C7LQ9pVg3NXj5VjJcDura5r4LYwF13oVacKYZvaJei2zT7CLU
         pVf/8OYwrLqO0Pnr9L8a3g7mVkCybIAsmZYaPPoasQ0rGbLyDX6XfV6lsvEzbYVSEK+q
         KXosUcuGlJEPksApy3foNpRUq2+V2HySHLWwEmkWxPOblUIhVIkCRlBtDpZidcwK1oKV
         C73A==
X-Forwarded-Encrypted: i=1; AJvYcCUeCOL1TEe3eg1sVIuEVgW/ri28XFFdFgPunXpbTV9VTLbAOv1mtwzC+10rJo3cRorQyjfS4bVchxLgI+D7HEPbsyNt2zbHtaeNQrLTcfUl
X-Gm-Message-State: AOJu0YwMyVvUtA1KxmzTPyFJT2/MtypSudQ53tqonY5663PrgXPekTSz
	WKSEKQjDThKNsodlm+mc/5bRyLBxyabUZXYHMDsHskehnnQRcfrA6T0/Ix6dCWKd/3L7CD2A+yx
	BD7UIPrM3Q9Hky+YRzd14Gw==
X-Google-Smtp-Source: AGHT+IHMikC/U+kmGrGiTb25wJ2Cco4+xgMYwFQUfHjLotNG/XKGpj3Obvk5i4rsrXv7eys5ilLKnnIaps2TET0qpQ==
X-Received: from ctop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:1223])
 (user=ackerleytng job=sendgmr) by 2002:a0d:d183:0:b0:61a:d41d:f969 with SMTP
 id t125-20020a0dd183000000b0061ad41df969mr320681ywd.3.1713168353903; Mon, 15
 Apr 2024 01:05:53 -0700 (PDT)
Date: Mon, 15 Apr 2024 08:05:49 +0000
In-Reply-To: <ZhkhvtijbhxKKAEk@yzhao56-desk.sh.intel.com> (message from Yan
 Zhao on Fri, 12 Apr 2024 19:57:50 +0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzr0f7jbj6.fsf@ctop-sg.c.googlers.com>
Subject: Re: [RFC PATCH v5 09/29] KVM: selftests: TDX: Add report_fatal_error test
From: Ackerley Tng <ackerleytng@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: sagis@google.com, linux-kselftest@vger.kernel.org, afranji@google.com, 
	erdemaktas@google.com, isaku.yamahata@intel.com, seanjc@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, pgonda@google.com, haibo1.xu@intel.com, 
	chao.p.peng@linux.intel.com, vannapurve@google.com, runanwang@google.com, 
	vipinsh@google.com, jmattson@google.com, dmatlack@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Yan Zhao <yan.y.zhao@intel.com> writes:

> On Fri, Apr 12, 2024 at 04:56:36AM +0000, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>> 
>> > ...
>> >> diff --git a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> >> index b570b6d978ff..6d69921136bd 100644
>> >> --- a/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> >> +++ b/tools/testing/selftests/kvm/include/x86_64/tdx/test_util.h
>> >> @@ -49,4 +49,23 @@ bool is_tdx_enabled(void);
>> >>   */
>> >>  void tdx_test_success(void);
>> >>  
>> >> +/**
>> >> + * Report an error with @error_code to userspace.
>> >> + *
>> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
>> >> + * is not expected to continue beyond this point.
>> >> + */
>> >> +void tdx_test_fatal(uint64_t error_code);
>> >> +
>> >> +/**
>> >> + * Report an error with @error_code to userspace.
>> >> + *
>> >> + * @data_gpa may point to an optional shared guest memory holding the error
>> >> + * string.
>> >> + *
>> >> + * Return value from tdg_vp_vmcall_report_fatal_error is ignored since execution
>> >> + * is not expected to continue beyond this point.
>> >> + */
>> >> +void tdx_test_fatal_with_data(uint64_t error_code, uint64_t data_gpa);
>> > I found nowhere is using "data_gpa" as a gpa, even in patch 23, it's
>> > usage is to pass a line number ("tdx_test_fatal_with_data(ret, __LINE__)").
>> >
>> >
>> 
>> This function tdx_test_fatal_with_data() is meant to provide a generic
>> interface for TDX tests to use TDG.VP.VMCALL<ReportFatalError>, and so
>> the parameters of tdx_test_fatal_with_data() generically allow error_code and
>> data_gpa to be specified.
>> 
>> The tests just happen to use the data_gpa parameter to pass __LINE__ to
>> the host VMM, but other tests in future that use the
>> tdx_test_fatal_with_data() function in the TDX testing library could
>> actually pass a GPA through using data_gpa.
>> 
>> >>  #endif // SELFTEST_TDX_TEST_UTIL_H
>> >> diff --git a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
>> >> index c2414523487a..b854c3aa34ff 100644
>> >> --- a/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
>> >> +++ b/tools/testing/selftests/kvm/lib/x86_64/tdx/tdx.c
>> >> @@ -1,8 +1,31 @@
>> >>  // SPDX-License-Identifier: GPL-2.0-only
>> >>  
>> >> +#include <string.h>
>> >> +
>> >>  #include "tdx/tdcall.h"
>> >>  #include "tdx/tdx.h"
>> >>  
>> >> +void handle_userspace_tdg_vp_vmcall_exit(struct kvm_vcpu *vcpu)
>> >> +{
>> >> +	struct kvm_tdx_vmcall *vmcall_info = &vcpu->run->tdx.u.vmcall;
>> >> +	uint64_t vmcall_subfunction = vmcall_info->subfunction;
>> >> +
>> >> +	switch (vmcall_subfunction) {
>> >> +	case TDG_VP_VMCALL_REPORT_FATAL_ERROR:
>> >> +		vcpu->run->exit_reason = KVM_EXIT_SYSTEM_EVENT;
>> >> +		vcpu->run->system_event.ndata = 3;
>> >> +		vcpu->run->system_event.data[0] =
>> >> +			TDG_VP_VMCALL_REPORT_FATAL_ERROR;
>> >> +		vcpu->run->system_event.data[1] = vmcall_info->in_r12;
>> >> +		vcpu->run->system_event.data[2] = vmcall_info->in_r13;
>> >> +		vmcall_info->status_code = 0;
>> >> +		break;
>> >> +	default:
>> >> +		TEST_FAIL("TD VMCALL subfunction %lu is unsupported.\n",
>> >> +			  vmcall_subfunction);
>> >> +	}
>> >> +}
>> >> +
>> >>  uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>> >>  				      uint64_t write, uint64_t *data)
>> >>  {
>> >> @@ -25,3 +48,19 @@ uint64_t tdg_vp_vmcall_instruction_io(uint64_t port, uint64_t size,
>> >>  
>> >>  	return ret;
>> >>  }
>> >> +
>> >> +void tdg_vp_vmcall_report_fatal_error(uint64_t error_code, uint64_t data_gpa)
>> >> +{
>> >> +	struct tdx_hypercall_args args;
>> >> +
>> >> +	memset(&args, 0, sizeof(struct tdx_hypercall_args));
>> >> +
>> >> +	if (data_gpa)
>> >> +		error_code |= 0x8000000000000000;
>> >> 
>> > So, why this error_code needs to set bit 63?
>> >
>> >
>> 
>> The Intel GHCI Spec says in R12, bit 63 is set if the GPA is valid. As a
> But above "__LINE__" is obviously not a valid GPA.
>
> Do you think it's better to check "data_gpa" is with shared bit on and
> aligned in 4K before setting bit 63?
>

I read "valid" in the spec to mean that the value in R13 "should be
considered as useful" or "should be passed on to the host VMM via the
TDX module", and not so much as in "validated".

We could validate the data_gpa as you suggested to check alignment and
shared bit, but perhaps that could be a higher-level function that calls
tdg_vp_vmcall_report_fatal_error()?

If it helps, shall we rename "data_gpa" to "data" for this lower-level,
generic helper function and remove these two lines

if (data_gpa)
	error_code |= 0x8000000000000000;

A higher-level function could perhaps do the validation as you suggested
and then set bit 63.

Are you objecting to the use of R13 to hold extra test information, such
as __LINE__?

I feel that R13 is just another register that could be used to hold
error information, and in the case of this test, we can use it to send
__LINE__ to aid in debugging selftests. On the host side of the
selftest we can printf() :).

>> generic TDX testing library function, this check allows the user to use
>> tdg_vp_vmcall_report_fatal_error() with error_code and data_gpa and not
>> worry about setting bit 63 before calling
>> tdg_vp_vmcall_report_fatal_error(), though if the user set bit 63 before
>> that, there is no issue.
>> 
>> >> +	args.r11 = TDG_VP_VMCALL_REPORT_FATAL_ERROR;
>> >> +	args.r12 = error_code;
>> >> +	args.r13 = data_gpa;
>> >> +
>> >> +	__tdx_hypercall(&args, 0);
>> >> +}
>> 
>> >> <snip>
>> 

