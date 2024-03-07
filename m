Return-Path: <linux-kselftest+bounces-6062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E32087560C
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 19:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CE91F23DDE
	for <lists+linux-kselftest@lfdr.de>; Thu,  7 Mar 2024 18:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35853134759;
	Thu,  7 Mar 2024 18:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zq8Wt8St"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A739913340F
	for <linux-kselftest@vger.kernel.org>; Thu,  7 Mar 2024 18:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709835886; cv=none; b=cdKyx8Z27gRCQ5Hi8PnAUN5G9hPxcz2rO6OHIv4y6zWtzc/lV7qTcvngbHuIxC3U3PMRuaV4KFNZltFdGWxyWgCpLem3i6armVhChflNJDTagXBiK5hZBOdKHZAZbw+emq6e9goOSkOhQ2kr7n+fiWVdqXGB/wZk3DFZ7ODglAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709835886; c=relaxed/simple;
	bh=o5cNRugZZzIdyCSXKjEvmt2jqbDFCbmVxFG4IAatR2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iEsXY1pxxpb9yaJiMeSaFb6PtAs5ZrSvwmTtrPVjXK4onG7/L0mHuTTevfqVAmsIb8x5qZgnt84wfwI/ZjOp2m+7mNvzWdK0nqqqg7wpJMdI18kIisfZz3W/0hFl64yMCfBP+jDYWtalkNNGTOk/1l9v+G9fKqqHBiBJ+Gg7dN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zq8Wt8St; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26eef6cso1765855276.3
        for <linux-kselftest@vger.kernel.org>; Thu, 07 Mar 2024 10:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709835884; x=1710440684; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tmf20qquXCm5BgDJjOs0QNTSjGXizLhNZTJUFBFz11s=;
        b=Zq8Wt8St+xF2cyam9YwfVwe4x3CobSKF5I5wtvcErbEU3ZZrx5ribcXs44RHRfOyt6
         YU1wPDXuxJyPDnJTbgDixUsEDPUSYv4aUAJZilMZBXhnWcivw3dbMjLZx7rnv+2nX5jK
         YZ2fDP1cUT0xjj/iyDRMFd/Rb5k9DvMZhg7+wiRHkjla7vK2sr8hdvtP/Nz7P0P3aHqN
         f84Nv+xT5HBtb239pRslSoCSdyUAriMrgQ28nsPTNfHkRKgKGz9HGTqeHLBbit1Wf3Uq
         2UKytWYkJVbkOpmCTzCvH2jBC4dysn6yw6WiPek/BRkSTlqytIQGunXtCAx7B9MAvxue
         i0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709835884; x=1710440684;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tmf20qquXCm5BgDJjOs0QNTSjGXizLhNZTJUFBFz11s=;
        b=XAZhxOtCRU8jjVm+RqlgF10qvlQBxskfUMfb6vw3NXzsfElaRD4wpO4qZKLZXLLnmj
         NSIUgw14nqTpQD+zQ3pLelt3tUyNM5QR0LC9vRJ+G0FqHnoFU4jAT0JeRN3ElPy/vhRz
         tJM1zbvtm/lOLvqGv8HodaJgs092xxzZJkxMC6vs5UMK95nLEkaFSgOSlEUkPn/hFaK0
         CCrhk0+f8mCYMjIYVVHvr3Af4kRYXXQ1yZxkVQ0KcfeKChbcXqh409eOE5VsCJ2LMCo5
         FHOLB16NSZrij+OOWj78NpftyOXJCnBH1fs6iDbvMyuA7samdTeqgtsfXjP3iVdTPda8
         tMzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCHkX+/iq9x4qIEtQNV139k487HmhheZdku4HVV6MjGfhqK1+Td/4yDOsSLZFE5udyyZeLBLQq0txx1UgrBXA2ySm+U/pqgHP21pzWR7bB
X-Gm-Message-State: AOJu0Yxce0df1RFefIqHGECZdjvaU2IJwIQKNwlpTq391Km19R/pd1CG
	Hf5LWn51dS9H9SfClby2ZsOJukbMemxLRIFzS9QzzD1xwCoh4OsuO55BJ0pLTxzEd01dIrv+UoK
	2tA==
X-Google-Smtp-Source: AGHT+IGBNywGbWe053DjXxN00I9scAq0pLzYUHamC39E63b0Ie62RJr8RSL5xpW1+UKIKkf9I0pzPARRwWU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:865b:22c6 with SMTP id
 ck19-20020a05690218d300b00dc7865b22c6mr771085ybb.8.1709835883899; Thu, 07 Mar
 2024 10:24:43 -0800 (PST)
Date: Thu, 7 Mar 2024 10:24:42 -0800
In-Reply-To: <ZeoF2vfrUMCja0x7@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240307054623.13632-1-manali.shukla@amd.com> <20240307054623.13632-6-manali.shukla@amd.com>
 <ZeoF2vfrUMCja0x7@google.com>
Message-ID: <ZeoGaujrJHGe5IsN@google.com>
Subject: Re: [PATCH v1 5/5] selftests: KVM: SVM: Add Idle HLT intercept test
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com, thomas.lendacky@amd.com, 
	vkuznets@redhat.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"

On Thu, Mar 07, 2024, Sean Christopherson wrote:
> On Thu, Mar 07, 2024, Manali Shukla wrote: From: Manali Shukla <Manali.Shukla@amd.com>
> > +	xapic_enable();
> > +
> > +	icr_val = (APIC_DEST_SELF | APIC_INT_ASSERT | VINTR_VECTOR);
> > +
> > +	for (i = 0; i < NUM_ITERATIONS; i++) {
> > +		xapic_write_reg(APIC_ICR, icr_val);
> > +		asm volatile("sti; hlt; cli");
> 
> Please add safe_halt() and cli() helpers in processor.h.  And then do:

Doh, saw something shiny and forgot to finish my though.  For safe_halt(), copy
the thing verbatim from KVM-Unit-Tests, as not everyone is familiar with the
sti=>hlt trick.

/*
 * Execute HLT in an STI interrupt shadow to ensure that a pending IRQ that's
 * intended to be a wake event arrives *after* HLT is executed.  Modern CPUs,
 * except for a few oddballs that KVM is unlikely to run on, block IRQs for one
 * instruction after STI, *if* RFLAGS.IF=0 before STI.  Note, Intel CPUs may
 * block other events beyond regular IRQs, e.g. may block NMIs and SMIs too.
 */
static inline void safe_halt(void)
{
	asm volatile("sti; hlt");
}

