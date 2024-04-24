Return-Path: <linux-kselftest+bounces-8757-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73248B012A
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 07:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58680B22628
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 05:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A36156872;
	Wed, 24 Apr 2024 05:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WFF4Abbs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACF3156668
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 05:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713937306; cv=none; b=kHW6jIswILQVqZmpdaowTkE39M3onAacpl4HRAN1WRXCjJy3KndjhGaoMAqlmzq6H9XC4D+VrnpCG2EjgY/F7Z36SdaUQHCYgkLKw+Aw5j2ezbjwsuF0/4b/mSvlYkxDkShUSSpWy//H0DgFSSxZq7lywxvxu33EWgbqKPeAaJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713937306; c=relaxed/simple;
	bh=IyElVXqzTyQ3aKo0ohOGapMAuFHTguATuxVWkpi0DWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZdWW2tMdpSTPzKWAMX4QibGAZ3KUaHqvPh202FmEOu9Ljj3+7xu9XSJJdfMA/enqJstEUnuKLOjNW11jLZhX6/+HUm9fdv5Hg7uH6ZKedvZLis3F6k30fgjw3W6pwbhRTTUNN8GJJGEHV71S4NtgxZBSMTqqlKU62LbUTFppL8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WFF4Abbs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-346359c8785so5345464f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Apr 2024 22:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713937302; x=1714542102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UrQ3g5twb3BBJ4fBE47g+swAJMT+h6KnPSpx3YI5X0=;
        b=WFF4Abbs7E16RYrXIM9ggmREHhJbrusKL6X9mFsx14GWvFMiCh6ldWscjhHj8fdzPE
         ywrAb//GYZmmfOFxKjCcb4rlpcQtwaKb0KKI3ByNMMNBm4Vq/USsto3jD+u6F/pu+/sp
         +ZDl7rQ52A/NdiSYOidzNNioSX3BEqtR0h8jWEMMwF0pupvnztvK6eWEM/kAEA1QC+fs
         Jrh5iamokbwh5PEz+p4sxn8eJ3ZFXrGnMxwpw68pzUjWwQOpuRlTdVDvSpwCOlYuabds
         mVRVTxk+bAoro99mgLOoVRAfKZiN+kr22ziT3B3Vp+qEe+MsLGL5XH9+Ndeq6g/8KjAG
         0Wig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713937302; x=1714542102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UrQ3g5twb3BBJ4fBE47g+swAJMT+h6KnPSpx3YI5X0=;
        b=UfjZrX8k7nhxGxLNbBF2IIKFg2eyu2hsl+WHI6u9eSRrYZ+tjcU0AtpdKpyTDQgMQl
         aCuhC9WnTa8KXum+WJ2nRBYsMLuE07ENC6s9TT9xl5Q/OE6XDrRkFykhsm7McfiugzIM
         F93h6A669fkVL9y88DbYaCNQ0qi15oFO38swoQvUpWRu1TzsYfotXRlFjMNVOeh0Yqv8
         +PHQu1bM6slmEjDpgICIO/SuQ2IsLJ0XtluFoDpF69/01RQ+twWrO7mXgRvAIhJecaRh
         4WcYGObHrAv5j69A5Asn/gTl7wjvRtnwgREzFBZmpSWHhXGfiaiqKx/sdei/gwmcsujR
         7x0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAZoPnWrHg2IMpoH0mxUvoaXl9snxfU3AwENS+iagY5XHWw5VLd4Va02qXmh5G5hGVz4zJ2+TBQGSi9ZaR1M+2Lr6cRG0xvj92OTN1a1/Z
X-Gm-Message-State: AOJu0YweHAsL5AGN/x014FBFqO8cUwoVuQTCikhbTEAWeTQZ29B5DFWP
	xmD/zvXCpCxM8truTVenZRgqIAw+dP1BDRQDHW7JslLTjnm5hL+g8QI/0HHlpmY=
X-Google-Smtp-Source: AGHT+IGm3SzufQ8qmVUjMugp1zOSYoDMSOXVbTv38V7zcneIa30Z0wti+n3pHXkYuoPQi5lqYjjsjg==
X-Received: by 2002:a5d:4fc4:0:b0:348:1ee3:48fa with SMTP id h4-20020a5d4fc4000000b003481ee348famr846511wrw.47.1713937301787;
        Tue, 23 Apr 2024 22:41:41 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id l6-20020adfa386000000b00349e2fab2a2sm16376427wrb.12.2024.04.23.22.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 22:41:41 -0700 (PDT)
Date: Wed, 24 Apr 2024 08:41:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sean Christopherson <seanjc@google.com>
Cc: Andrew Jones <ajones@ventanamicro.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Kunwu Chan <chentao@kylinos.cn>, linux-kselftest@vger.kernel.org,
	kvm@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Kunwu Chan <kunwu.chan@hotmail.com>,
	Anup Patel <anup@brainfault.org>, Thomas Huth <thuth@redhat.com>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH] KVM: selftests: Add 'malloc' failure check in
 test_vmx_nested_state
Message-ID: <9f67df9d-ab27-40b9-8849-3069649dc082@moroto.mountain>
References: <20240423073952.2001989-1-chentao@kylinos.cn>
 <878bf83c-cd5b-48d0-8b4e-77223f1806dc@web.de>
 <ZifMAWn32tZBQHs0@google.com>
 <20240423-0db9024011213dcffe815c5c@orel>
 <ZigI48_cI7Twb9gD@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZigI48_cI7Twb9gD@google.com>

On Tue, Apr 23, 2024 at 12:15:47PM -0700, Sean Christopherson wrote:
> On Tue, Apr 23, 2024, Andrew Jones wrote:
> > On Tue, Apr 23, 2024 at 07:56:01AM -0700, Sean Christopherson wrote:
> > > +others
> > > 
> > > On Tue, Apr 23, 2024, Markus Elfring wrote:
> > > > …
> > > > > This patch will add the malloc failure checking
> > > > …
> > > > 
> > > > * Please use a corresponding imperative wording for the change description.
> > > > 
> > > > * Would you like to add the tag “Fixes” accordingly?
> > > 
> > > Nah, don't bother with Fixes.  OOM will cause the test to fail regardless, the
> > > fact that it gets an assert instead a NULL pointer deref is nice to have, but by
> > > no means does it fix a bug.
> > > 
> > > > > +++ b/tools/testing/selftests/kvm/x86_64/vmx_set_nested_state_test.c
> > > > > @@ -91,6 +91,7 @@ void test_vmx_nested_state(struct kvm_vcpu *vcpu)
> > > > >  	const int state_sz = sizeof(struct kvm_nested_state) + getpagesize();
> > > > >  	struct kvm_nested_state *state =
> > > > >  		(struct kvm_nested_state *)malloc(state_sz);
> > > > > +	TEST_ASSERT(state, "-ENOMEM when allocating kvm state");
> > > > …
> > > > 
> > > > Can “errno” be relevant for the error message construction?
> > > 
> > > Probably not, but there's also no reason to assume ENOMEM.  TEST_ASSERT() spits
> > > out the actual errno, and we can just say something like "malloc() failed for
> > > blah blah blah".  
> > > 
> > > But rather than keeping playing whack-a-mole, what if we add macros to perform
> > > allocations and assert on the result?  I have zero interest in chasing down all
> > > of the "unsafe" allocations, and odds are very good that we'll collectively fail
> > > to enforce checking on new code.
> > > 
> > > E.g. something like (obviously won't compile, just for demonstration purposes)
> > > 
> > > #define kvm_malloc(x)
> > > ({
> > > 	void *__ret;
> > > 
> > > 	__ret  = malloc(x);
> > > 	TEST_ASSERT(__ret, "Failed malloc(" #x ")\n");
> > > 	__ret;
> > > })
> > > 
> > > #define kvm_calloc(x, y)
> > > ({
> > > 	void *__ret;
> > > 
> > > 	__ret  = calloc(x, y);
> > > 	TEST_ASSERT(__ret, "Failed calloc(" #x ", " #y ")\n");
> > > 	__ret;
> > > })
> > 
> > Sounds good to me, but I'd call them test_malloc, test_calloc, etc. and
> > put them in include/test_util.h
> 
> Possibly terrible idea: what if we used kmalloc() and kcalloc()?  K is for KVM :-)

That's a legit terrible idea...  It probably would trigger more static
checker warnings because the general policy is kmalloc() is kernel code
and we *have* to test for errors.

To be honest, I would have just rejected the first patch.  You
obviously know this and have said this earlier in the thread but just
for the other people, this is a userspace test that runs for a short
time and then exits.  If it gets killed because we don't have enough
memory that's fine.  It would be better to just fix the static checker
to not print pointless warnings or educate people to ignore warnings
like this.

Creating the test_malloc() to silence the warning also seems like an
okay idea as well.

regards,
dan carpenter


