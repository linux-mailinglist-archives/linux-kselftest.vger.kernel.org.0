Return-Path: <linux-kselftest+bounces-8786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE468B0F62
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F5A1F2122C
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0FF15E1EA;
	Wed, 24 Apr 2024 16:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fSQNh+xZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355815FD15
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713974901; cv=none; b=fM/AiUv70rW28mhHHZ3VLf1ZcQQAsanDZ9daR5jyFBx4ytvNHd/OsIRHRJCzr6VTY+PEEtM+SMZw3Szbt6zan2J3jsRp11XHZba2Cuh++siI3ER2ThQYS1bxHkwEwCsKAe9F3y9YdYroTvHURz5Ay+C4RmR9B/o9HkpZIkiJMHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713974901; c=relaxed/simple;
	bh=UX+RSQsTZIoCgA4sTAjvIrhaan3lVSfzg+9u2yHW7fw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g8F25uo5kIl3OqiGzWQ0ujG5nyyLipuQtqXcEJMnJ3EYocsPpeKQIF6+J18tZdyRIHJJwRX3NxDZMP4gIFkKyPT1nCu9Fw145G7VZrsVpjcGEtLpgSLLPYFgDdGfZJVYRCSOKq1EseecivNjC5r8nEKdWgCq6t4Zrpc8oHWxq84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fSQNh+xZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-de54ccab44aso55372276.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 09:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713974899; x=1714579699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3EKgsQGWnjS0MB5E+L5+lH/YRrJ8wTPFpK6fCHC/0=;
        b=fSQNh+xZyICEaLyAYJ9j8B5Dpz9iGvXe9AekGvZfUPSkhGUTKrJ2lWayZW7QAOpQOf
         Q8M9BTKg6GMvNXkaD9RUJ1roLQLTBheXYP90tNemuaJnFJSGeXEHf5U6w/G8ikG57+hX
         W/ZzL5/4l3gLhcXPfwq+bEcEFadq6++lmanCmdo/KIZDV3aU2zV7kIT6eEz9zfIpPkXU
         LjwDPyGXrm6hdmyc3QkSm+PodXwkdjiQ8stX3PaKWkIe2b584IuIkiqHXxhX4rcfzUJe
         HfikG0tr0eilK8dW+/r2DUtDQCvS/X8YSGThyZQo/jrugYDs0TXEhbrObWtF24v19B28
         yj8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713974899; x=1714579699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bk3EKgsQGWnjS0MB5E+L5+lH/YRrJ8wTPFpK6fCHC/0=;
        b=A+Tx8YojafKGXjIOL+Tr5anKfhyF1d3G90K5yRJ5M44PQo0AFi5pKgN8JclqCwT/Cz
         c1hht9pM1pPcWaY+rOOT/B+N/L9+zMB+mlWn0Y5XNy8m+I0Ht0RQzdSo587wEECR1jp8
         VSSFBykrfOHdvvakzDJg6PS6d7wEARGB7gJWM2V3Cd+yZTJhr8LXeU+4FgUxUdEP6yyL
         GXXmLqnAdBR6Sg5u7ppdYJ3CkGLZ1zuWIT0SEhb9fdFj6/R4R/3vhN1K5tMmTOV1YfSs
         87yVSgcdLJQRJgDe/2xAG6J/Xh3qqmBJHlVAY/PoUKDL4g0SAd6aallKLWhKH7m/DuxN
         /S1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3FNhBRKL+nj5Jh7AgRjeyLyUV60vyhsqDpx84SVTUNUyWdh2yANvzw4ElQzDk3PXDvld5Tm3QwRQRTwqgXdFkGEmtOPC8iG2/NYwHG1o/
X-Gm-Message-State: AOJu0YwmaHzmK+pDvYCPslstq5npFMe4+qDo56h8vPmf8CGa9QI66pSv
	nI4zMJUlMknxprmx8DgDUBtPkuGJuLLA5ZbRlAqcmIVCVB9OB5QHMATcGYdMR70iw0ZMwlkJpDA
	sEg==
X-Google-Smtp-Source: AGHT+IHUEHWaTgZwPWeVlQZLsmhgBLdJhdqkgpe+SOVJ7NnX/mE1lLDAZaofyhrlTH6Xy2nYNweVj/XvttU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:706:b0:dcd:3172:7265 with SMTP id
 k6-20020a056902070600b00dcd31727265mr1002573ybt.8.1713974899485; Wed, 24 Apr
 2024 09:08:19 -0700 (PDT)
Date: Wed, 24 Apr 2024 09:08:18 -0700
In-Reply-To: <20240329201854.f24ZDY24JtVE3gfa0i3m1MOFYfXVhCKdkXd0j5c-B6I@z>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-26-xin3.li@intel.com>
 <20240329201854.f24ZDY24JtVE3gfa0i3m1MOFYfXVhCKdkXd0j5c-B6I@z>
Message-ID: <Zikucr6zpwBxOUiy@google.com>
Subject: Re: [PATCH v2 25/25] KVM: selftests: Add fred exception tests
From: Sean Christopherson <seanjc@google.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Xin Li <xin3.li@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	shuah@kernel.org, vkuznets@redhat.com, peterz@infradead.org, 
	ravi.v.shankar@intel.com, xin@zytor.com
Content-Type: text/plain; charset="us-ascii"

On Sat, Mar 30, 2024, Muhammad Usama Anjum wrote:
> On 2/7/24 10:26 PM, Xin Li wrote:
> > Add tests for FRED event data and VMX nested-exception.
> > 
> > FRED is designed to save a complete event context in its stack frame,
> > e.g., FRED saves the faulting linear address of a #PF into a 64-bit
> > event data field defined in FRED stack frame.  As such, FRED VMX adds
> > event data handling during VMX transitions.
> > 
> > Besides, FRED introduces event stack levels to dispatch an event handler
> > onto a stack baesd on current stack level and stack levels defined in
> > IA32_FRED_STKLVLS MSR for each exception vector.  VMX nested-exception
> > support ensures a correct event stack level is chosen when a VM entry
> > injects a nested exception, which is regarded as occurred in ring 0.
> > 
> > To fully test the underlying FRED VMX code, this test should be run one
> > more round with EPT disabled to inject page faults as nested exceptions.
> > 
> > Originally-by: Shan Kang <shan.kang@intel.com>
> > Signed-off-by: Xin Li <xin3.li@intel.com>
> Thank you for the new test patch. We have been trying to ensure TAP
> conformance for tests which cannot be achieved if new tests aren't using
> TAP already.

Who is "we"?

> Please make your test TAP compliant.

This isn't entirely reasonable feedback.  I'm all for getting KVM selftests
TAP-friendly, but the current reality is that the KVM selftests infrastructure
doesn't make it easy to be TAP compliant.  We're working on improving things,
i.e. I do hope/want to get to a state where it's a hard requirement for KVM
selftests to be TAP compliant, but we aren't there yet.

If you have specific feedback on _how_ to make a test TAP compliant, then by all
means provide that feedback.  But a drive-by "make your test TAP compliant" isn't
super helpful.

> > ---
> >  tools/testing/selftests/kvm/Makefile          |   1 +
> >  .../selftests/kvm/include/x86_64/processor.h  |  32 ++
> >  .../testing/selftests/kvm/x86_64/fred_test.c  | 297 ++++++++++++++++++
> Add generated binary object to .gitignore.

This should be unnecessary (though I haven't actually verified by building), as
KVM selftests ignore most everything by default since commit 43e96957e8b8
("KVM: selftests: Use pattern matching in .gitignore").

