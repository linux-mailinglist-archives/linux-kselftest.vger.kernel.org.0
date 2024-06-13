Return-Path: <linux-kselftest+bounces-11897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C442E907BA2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 20:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 790D11F2741C
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2024 18:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB80314D2B7;
	Thu, 13 Jun 2024 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pa62ppOQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DA414D299
	for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303896; cv=none; b=uzuCFU/w/i7xUa5s0nd+anFFMA/9DJESedWShjd5hVK8xPYBbb/TacYJMMOZinDmzbGnryxHpFB1YLMUrml0+25ZkrSlA+mPLlTd4AXr0m00hLCZZlLdiUC0UwGJYMCVFggCcZ1TZwBqr3byUgiydvbrMGdpF5sL0qtzeSNyjVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303896; c=relaxed/simple;
	bh=L/I0jGSnKvfURjR9QPVZSHNpgzmXSr/7QAs2Yjq/MN4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JcNUWZOEYftR3MRVRZ6Z7TxiQJBIhgXPIN3aX9vcsWwM0sN7j4R7GfJLZ9qIzLIQ6qqNDU3JAhXyCjFRu/imQWWT/V3RU6FrthJeeveDmO8ZOXj3cRPfG1eMrfUTXmQncjc7MEPwvPzoxLI8mJ/o/E8ifk9XNVtLbOrNaAKr1ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pa62ppOQ; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6e79f0ff303so952194a12.2
        for <linux-kselftest@vger.kernel.org>; Thu, 13 Jun 2024 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303895; x=1718908695; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Updc3JmEB9tDfSD6bTK5d81zUhVfnHUf04ep4+BiNE0=;
        b=Pa62ppOQ/dth7kPb21G3Nd8RYVyAjomc/DV4cmyRvKhw6ydKU6UluwZWcJQlRITjC8
         B2UrSUsjKqZKLtan2C4jaxNc4zS+E3jFPZRYscMKFNkW6E/QLEf8suL1dVrPe1d5ocvg
         Oaj1tDKrgUR/S864nOxHPheE9uea2a6mRBREJJkmNYC1y4TNtYtHMHb6TkT298epb87Q
         uQ8yOhSDDHwZGV+nFQXdLc9cIlCnyxdORaXFPlkfKv1+jhuQh3Ky5ZNKmjuDF3KdvoBL
         vjyCXm2GCjp85TXC1cL2SdBZ0pF7fHfb6rReMJxcR+CIs5v4CPkZhREfrxIMYxry+qiM
         v9DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303895; x=1718908695;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Updc3JmEB9tDfSD6bTK5d81zUhVfnHUf04ep4+BiNE0=;
        b=RF4YgHJvhHidB4/kZmXia/FOebA764xjCZOVlLV3s5s1ueDn/NdwQTvXUsCnUtqtb4
         dYyGrdeeyVmLxwJASi1XE61NVJw/fsC8ip6IF0cfu7vFrXBXcA7hkUWUFHB+ybfoTyD1
         i4nJiprz1OxslpByOh3Dx6MzuBMcMWXeuywD8JRvBf+97Z9EmZfAbXqLhTDt9Xgc8pCT
         z6cUUbHDRTl+tiUJ0zOtdiErdhELgFgq83LJw4Mzc5NWoUuVf86qdVvBkDkLTcfpb/eH
         CM6pfOQdJLMOs0kjgkA2/Bj+gUrfxzUHTyUH5YFlN3p9pxn2lNsa+3EcNhOGEmJD+jXs
         rcWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzCwqL+DsTeqskAkEWHxuvD96xJc8R6ZrBsF0BTXRPKIpsImeHuXHaNf4f0vNhUxvqT2DkyWGr5IO03jdLUn9rzLuCgTxAq8u3gIrcsPq2
X-Gm-Message-State: AOJu0YyPL22U+s5j8P4nAMxWtbdqITNmwAH2DiA/2H/nZNS4zHwb7aML
	ztjerXFYbvMPWhXrqkKuhs7mw2GMvkdYFz7pWun4fgqxYMr7935OwHfG1aGUt2Zt2Jbv6W1GxJM
	QLw==
X-Google-Smtp-Source: AGHT+IEoHsoXQ33CoHiGZZlVh3rR+/EUc+z3M2bB9VIq6N8UkxisrbO0XxnhPNgtzkGpaeE61uYDqNygW5Q=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:d2c8:b0:1f6:fbea:7976 with SMTP id
 d9443c01a7336-1f862a17756mr12475ad.10.1718303894500; Thu, 13 Jun 2024
 11:38:14 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:38:13 -0700
In-Reply-To: <608b37dbc59a80d32719c8fde8b6979a2b839e10.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <608b37dbc59a80d32719c8fde8b6979a2b839e10.camel@intel.com>
Message-ID: <Zms8lRn20MGVVN9h@google.com>
Subject: Re: [PATCH v2 00/25] Enable FRED with KVM VMX
From: Sean Christopherson <seanjc@google.com>
To: Shan Kang <shan.kang@intel.com>
Cc: Xin3 Li <xin3.li@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"x86@kernel.org" <x86@kernel.org>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "vkuznets@redhat.com" <vkuznets@redhat.com>, 
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "hpa@zytor.com" <hpa@zytor.com>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	"shuah@kernel.org" <shuah@kernel.org>, Ravi V Shankar <ravi.v.shankar@intel.com>, 
	"xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024, Shan Kang wrote:
> On Wed, 2024-02-07 at 09:26 -0800, Xin Li wrote:
> > This patch set enables the Intel flexible return and event delivery
> > (FRED) architecture with KVM VMX to allow guests to utilize FRED.
> >=20
> We tested this FRED KVM patch set on a 7th Intel(R) Core(TM) CPU and the =
Intel=20
> Simics=C2=AE Simulator with the following four configurations:

That likely provides coverage for the happy cases, but I doubt it provides =
negative
testing, e.g. for VM-Enter consistency checks.  KVM-Unit-Tests are currentl=
y the
best choice for concistency checks (unfortunately).

And given the insanity of event re-injection, KVM selftests needs a dedicat=
ed test
for that, and another for the interactions with nVMX, e.g. a la svm_nested_=
soft_inject_test.c.

I haven't looked too closely at the selftest that's already provided, but m=
y
suspicion is that we'll want multiple tests, or alternatively one test that
uses KVM_ONE_VCPU_TEST_SUITE().

