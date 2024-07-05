Return-Path: <linux-kselftest+bounces-13217-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5655F928094
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 077C428492A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D1F39FFB;
	Fri,  5 Jul 2024 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTXee3V1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FA11D559
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Jul 2024 02:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147715; cv=none; b=C4kHjUuY8014HDcAypsCz730BSzd++IxA7Wpom+lLbX0h/3hyBvU9F0IIY3/Ee4sllCELfagmbDSASQLh4EDVhjxkMSoCpmOrRW09gScSNf6bhN74msgv9/s2InKGN9D35JlSB+PWdLt15Zcy0KupXXuoVPvEZGoMxQBOoj+Hrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147715; c=relaxed/simple;
	bh=3l/nDkTEuLQCAmReuSFbK+H5QoQlegddQFe774aFXiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M9I/FFVmpi1pdwBmz0NCOv8G3alG8sOiqdTHDG2MIEQHhO/llTrix4KoQPFJAeLE4zOz13ogdWEBQwFi17MEdglpHKMvc3CQ+QP39DCW6n98S0VY7w/Q3CJeqC70bFywxEHBB7jwDQVFcNw+Q5EprwlI/U7h12ERKqKnOSfQYVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTXee3V1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720147712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2PIztTC41X3SqpITk7EO4e8WG4gHXfiYx/21IOkrtDk=;
	b=NTXee3V1xjZRrGNBtwQ4TlZoZuUgt0mUemSIZIRgG49O4FpIOldit0rkP/CxBjoVhtaO6f
	dHGqXTv29FXUzLWWFOhKfmoRY6AgVV5eq0LdnNOBWN5HCaLmsHjTSFzrbFaN/HAzJJQmcF
	OlaPxO5jH3o0yPf0sV+Ewyjnhg2XzrY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-g8O8ZabqOPiI0MQO10pJZA-1; Thu, 04 Jul 2024 22:48:28 -0400
X-MC-Unique: g8O8ZabqOPiI0MQO10pJZA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b22e2dfa6cso17582536d6.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Jul 2024 19:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147708; x=1720752508;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PIztTC41X3SqpITk7EO4e8WG4gHXfiYx/21IOkrtDk=;
        b=b9sYf9cIQ93Ih7RE2U3o9qi2I8QTTY2ynhX/KGfN/46+f2UTR5+68eeeaz4tilBnD1
         VGLey6TIRRsfsMmto3v8tIH3dRfHj5++iNpa/mAF9wUpLOjNM2vSx2+UiSCSyrGmoXL8
         4hh3Ad/1klDQqBjvYPlggrxxyeJ1kzPOTvflJ1sLZKc/XUMTMyfcIp/K4PWdv4fziuXD
         LIa7cQ66tUPjbCo+vtywWDt3NdDbornLVgd7nBjF1rappFK4RF8S4I/l6+NtbUiopu+D
         ZBCUnTVJpWr/2fOzV7c07TtyHujNdlJJhcD7/YD3MCJNKf7CH3Pxbvw85u4704KJtV3n
         rU/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVifrQCyn+IcDLQVgW10gtZY41bNwlIeVgYlVNYK/+Y7I/Ds0DafOuh1MTv3CdfZudgKuN3iBJyJXp5TG+dezvD8/IltvjYqnqeD5ncx1o4
X-Gm-Message-State: AOJu0Yy6RPJfGp8eyq2+XeHPDwgZHNdThd9Z2oNQg2fBtt4Q/eWqBSCh
	zIRL3u8BWyTY0fQN3KegScIp+kyk8zOTJ1vgUYlmOoUsoliKqT4e1Zd2HEr6RnjpmmBNnHzi8r2
	jpaLzdJJxBFQzDUcQh41R3sygH8KxzehGo2Fw4W+em4MQx2AR4S+RmieV2C6g+VLElg==
X-Received: by 2002:a05:6214:1bc7:b0:6b5:9439:f048 with SMTP id 6a1803df08f44-6b5ecf8ac28mr37106676d6.19.1720147708001;
        Thu, 04 Jul 2024 19:48:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQ/S6tPBwjVySOrVqy0W45xFpjJZKhw/JesQX4ihyGag/zigRZaDY6AUleexB2pxZ5dZtR5A==
X-Received: by 2002:a05:6214:1bc7:b0:6b5:9439:f048 with SMTP id 6a1803df08f44-6b5ecf8ac28mr37106526d6.19.1720147707696;
        Thu, 04 Jul 2024 19:48:27 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5f9d42de5sm705516d6.15.2024.07.04.19.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:48:27 -0700 (PDT)
Message-ID: <73ab1d49f1dfffe42ab2a8625ca6c2de0f06d3ad.camel@redhat.com>
Subject: Re: [PATCH 1/1] KVM: selftests: pmu_counters_test: increase
 robustness of LLC cache misses
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org
Date: Thu, 04 Jul 2024 22:48:26 -0400
In-Reply-To: <Zn2ker_KZ7Fk-7W1@google.com>
References: <20240621204305.1730677-1-mlevitsk@redhat.com>
	 <20240621204305.1730677-2-mlevitsk@redhat.com>
	 <Zn2ker_KZ7Fk-7W1@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2024-06-27 at 10:42 -0700, Sean Christopherson wrote:
> On Fri, Jun 21, 2024, Maxim Levitsky wrote:
> > Currently this test does a single CLFLUSH on its memory location
> > but due to speculative execution this might not cause LLC misses.
> > 
> > Instead, do a cache flush on each loop iteration to confuse the prediction
> > and make sure that cache misses always occur.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  .../selftests/kvm/x86_64/pmu_counters_test.c  | 20 +++++++++----------
> >  1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > index 96446134c00b7..ddc0b7e4a888e 100644
> > --- a/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > +++ b/tools/testing/selftests/kvm/x86_64/pmu_counters_test.c
> > @@ -14,8 +14,8 @@
> >   * instructions that are needed to set up the loop and then disabled the
> >   * counter.  1 CLFLUSH/CLFLUSHOPT/NOP, 1 MFENCE, 2 MOV, 2 XOR, 1 WRMSR.
> >   */
> > -#define NUM_EXTRA_INSNS		7
> > -#define NUM_INSNS_RETIRED	(NUM_BRANCHES + NUM_EXTRA_INSNS)
> > +#define NUM_EXTRA_INSNS		5
> > +#define NUM_INSNS_RETIRED	(NUM_BRANCHES * 2 + NUM_EXTRA_INSNS)
> 
> The comment above is stale.  I also think it's worth adding a macro to capture
> that the '2' comes from having two instructions in the loop body (three, if we
> keep the MFENCE).

True, my mistake.

> 
> >  static uint8_t kvm_pmu_version;
> >  static bool kvm_has_perf_caps;
> > @@ -133,9 +133,8 @@ static void guest_assert_event_count(uint8_t idx,
> >   * doesn't need to be clobbered as the input value, @pmc_msr, is restored
> >   * before the end of the sequence.
> >   *
> > - * If CLFUSH{,OPT} is supported, flush the cacheline containing (at least) the
> > - * start of the loop to force LLC references and misses, i.e. to allow testing
> > - * that those events actually count.
> > + * If CLFUSH{,OPT} is supported, flush the cacheline containing the CLFUSH{,OPT}
> > + * instruction on each loop iteration to ensure that LLC cache misses happen.
> >   *
> >   * If forced emulation is enabled (and specified), force emulation on a subset
> >   * of the measured code to verify that KVM correctly emulates instructions and
> > @@ -145,10 +144,9 @@ static void guest_assert_event_count(uint8_t idx,
> >  #define GUEST_MEASURE_EVENT(_msr, _value, clflush, FEP)				\
> >  do {										\
> >  	__asm__ __volatile__("wrmsr\n\t"					\
> > -			     clflush "\n\t"					\
> > -			     "mfence\n\t"					\
> 
> Based on your testing, it's probably ok to drop the mfence, but I don't see any
> reason to do so.  It's not like that mfence meaningfully affects the runtime, and
> anything easy/free we can do to avoid flaky tests is worth doing.

Hi,

I just didn't want to add another instruction to the loop, since in theory
that will slow the test down.


From PRM:

"Executions of the CLFLUSH instruction are ordered with respect to each other and with respect to writes, locked
read-modify-write instructions, and fence instructions. 1 They are not ordered with respect to executions of
CLFLUSHOPT and CLWB. Software can use the SFENCE instruction to order an execution of CLFLUSH relative to one
of those operations."

Plus there is note that:

"Earlier versions of this manual specified that executions of the CLFLUSH instruction were ordered only by the MFENCE instruction.
All processors implementing the CLFLUSH instruction also order it relative to the other operations enumerated above."

Here we have an instruction fetch and cache flush, and it is not clear if MFENCE orders two operations.
Thus it is not clear if MFENCE helps or not.

I honestly would have preferred a cache flush on data memory, followed by a read from it, except
that this also sometimes doesn't work (maybe I made some mistake, maybe it is possible to make it work, don't know)

But overall I don't object keeping it.


> 
> I'll post and apply a v2, with a prep patch to add a NUM_INSNS_PER_LOOP macro and
> keep the MFENCE (I'll be offline all of next week, and don't want to push anything
> to -next tomorrow, even though the risk of breaking anything is minimal).

Sounds good.

Best regards,
	Maxim Levitsky


> 
> > -			     "1: mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> > -			     FEP "loop .\n\t"					\
> > +			     " mov $" __stringify(NUM_BRANCHES) ", %%ecx\n\t"	\
> > +			     "1: " clflush "\n\t"				\
> > +			     FEP "loop 1b\n\t"					\
> >  			     FEP "mov %%edi, %%ecx\n\t"				\
> >  			     FEP "xor %%eax, %%eax\n\t"				\
> >  			     FEP "xor %%edx, %%edx\n\t"				\
> > @@ -163,9 +161,9 @@ do {										\
> >  	wrmsr(pmc_msr, 0);							\
> >  										\
> >  	if (this_cpu_has(X86_FEATURE_CLFLUSHOPT))				\
> > -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt 1f", FEP);	\
> > +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflushopt .", FEP);	\
> >  	else if (this_cpu_has(X86_FEATURE_CLFLUSH))				\
> > -		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush 1f", FEP);	\
> > +		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "clflush .", FEP);	\
> >  	else									\
> >  		GUEST_MEASURE_EVENT(_ctrl_msr, _value, "nop", FEP);		\
> >  										\
> > -- 
> > 2.26.3
> > 



