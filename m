Return-Path: <linux-kselftest+bounces-11898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5A9907BD5
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F7B31F24372
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACAA14B94F;
	Thu, 13 Jun 2024 18:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+ueFLQP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEF814AD22
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718305053; cv=none; b=rFCi+nw9Mh/KwwUZl/3SxE4rwjGIKv/mUmb0E6jreRBbPV3jI6b91z+8jGwSsg1ifYg1x7M5k+zWb8+7X/CrdtUkZKe+K8MuMYweJcXFbp4IjZB9AKgF//rR8C0Oip2PprFt6QEPum8aA/Z0Z7VkOig3QSSqasfe/+02FVrmbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718305053; c=relaxed/simple;
	bh=tSGg8GhzkVKrJZ6e6lZkA8/ZUCa4bAOubkF1I12udL4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CHvsZIAwdcBPSSZUnVSbb1EHwQ02oJDfH4JpKqoBc26nLxfGMisjyPwKoe2bDz1l/5jB0gSFeZ5ryAR0oA8m+3SnjJR8qQhLIbEm9xYrNXh12cepRHRf8NGUt0l+fciej+Ifl1JxZi29lwFmOtqDOLzYkByqxF1CgYqN34VTEEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+ueFLQP; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62f3c5f5bf7so22232827b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718305051; x=1718909851; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Fndbx/eA449NVcOCPdnOjxiUO14w1zakbsrpN7bkY=;
        b=G+ueFLQPrvYGJO1ILHQSKacSbWHY318hzKz/2Cxe6D+AkjO2OisZeOGFNsiXDXX4Hi
         BFR4lTMpdFPcR+PTZzmlBkctfvO6ZCz27Ul1tEP9zu9uEoKvgHhVpL4DwPelKTOyV/Pw
         BUV/I1ZXnnTpSDlVGNwXr8eeAuQI2sl5j4+l1fjU5cm+u9phuTOMjPiMKqUx9TmkiEkm
         rQJon4fE7Uo2hLHbq1H4wAdV2CycVtfkzJYntR64dcbPeWpZwpYupuFJy7BS1KaoVB+T
         GLuXNUNOZCKBq2zT5nFBHZJaGclkxF86ISe0fbIYlkco5+pYasz+H8JOyHFg2ForjwX1
         Qr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718305051; x=1718909851;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C5Fndbx/eA449NVcOCPdnOjxiUO14w1zakbsrpN7bkY=;
        b=I0W5VQsoDRXkOjpD0pKcXDf2DN19pt/cFYIGMwacjfrc4lZEgYQvkNj/xnRVA1o75K
         Ww6i+2cyOZ8aOTQ5gXpUXFXj+RgsK7bfrOBROHU7b+v93A6jpWSSDusTZQqR9AqiVSuW
         V5FHpvvSDgbkpMNIo6wCKuOQ0AT1D30FPaOZ3LE/T2Zr3aRt5+s1LZ750Yi4brUvHeyG
         ITdH/1ADfi+ggMv53o+5ZSga2yLzwclZo2uVjHcW5QtWDOAY7kOrz+ka2ui5AzUgXpAY
         1Tpu+QtkgAFoNKKvz2is8fsErtLKuwq4XH68C5vD0LqokCa1Be+TF6/HNht1zdTsh0SU
         CdfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtWf3u0RodLiMcZONpMtOJ42az8j650m7GFMsFHmXTKKJY7x8be8R4JNpWX6tLBwJDScG1gCwYRcp3BhCOomF/SS/tsITCmsxHRoe4vfE+
X-Gm-Message-State: AOJu0YwrA+V44mBN/FWasCPrhTmcTzw/T4N1Ap3haR3HIqxAlsvjHC0N
	GCQ6SfXjc0DR+773ctocVGrbC/sYJx2Y/0TTQObbkv/c4RCLArF6PLTEz/3AQHvqbGblU7tCs1V
	SgQ==
X-Google-Smtp-Source: AGHT+IEtwzPPtdTb/6r1+Lt3zX+YRN2khdPMq6WUaa3M6+7UwQdtsLyL+FOBLDIaz3NH6he0KFHlOzU1XFo=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:398:b0:61b:e689:7347 with SMTP id
 00721157ae682-6322216bf24mr873747b3.2.1718305051510; Thu, 13 Jun 2024
 11:57:31 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:57:30 -0700
In-Reply-To: <ade2de8f-8f63-45fb-a01a-096d048dd971@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612104500.425012-1-usama.anjum@collabora.com>
 <20240612104500.425012-2-usama.anjum@collabora.com> <Zmnwhx0Y0qh0x03J@google.com>
 <ade2de8f-8f63-45fb-a01a-096d048dd971@collabora.com>
Message-ID: <ZmtBGn1rgFu8tcgl@google.com>
Subject: Re: [PATCH 2/2] selftests: kvm: replace exit() with ksft_exit_fail_msg()
From: Sean Christopherson <seanjc@google.com>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, kernel@collabora.com, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 13, 2024, Muhammad Usama Anjum wrote:
> > As above, AFAICT it comes from Google's internal test infrastructure (KVM selftests
> > came from Google).
> > 
> >> Its even better if we use ksft_exit_fail_msg() which will print out "Bail
> >> out" meaning the test exited without completing. This string is TAP protocol
> >> specific.
> > 
> > This is debatable and not obviously correct.  The documentation says:
> > 
> >   Bail out!
> >   As an emergency measure a test script can decide that further tests are
> >   useless (e.g. missing dependencies) and testing should stop immediately. In
> >   that case the test script prints the magic words
> > 
> > which suggests that a test should only emit "Bail out!" if it wants to stop
> > entirely.  We definitely don't want KVM selftests to bail out if a TEST_ASSERT()
> > fails in one testcase.
> But KVM tests are bailing out if assert fails, exit(254) is being called
> which stops the further execution of the test cases.

Not if the TEST_ASSERT() fires from within a test fixture, in which case the
magic in tools/testing/selftests/kselftest_harness.h captures the failure but
continues on with the next test.

