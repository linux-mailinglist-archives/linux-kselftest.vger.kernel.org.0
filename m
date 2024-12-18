Return-Path: <linux-kselftest+bounces-23528-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EEF9F6D89
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 19:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8B7166F6D
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Dec 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311DC1FA8E9;
	Wed, 18 Dec 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HNIFORqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAFA1F9F5E
	for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734547451; cv=none; b=BcchCYoQ8GLiv4T2V3AG9Q5+725UL0RXnZG67eNVi8Nq50WK8wKbnsaXhNSuaLKAYb81JIpz+9XkP54SUhE+Pls/r8URNe8CALd998DDmr7UN1vEPkhSoK1bYUoYvZ6wIRhs1JCROBA8VsyLmySp0RFwuTPODApgr00Adcb1cAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734547451; c=relaxed/simple;
	bh=w6VdZk8D12KKSyCgYaCAJHabEXKIGL109NplDledyDM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u04U7/aYiG+YUHHICDN8w5wIp6BVqQKSr8X4zrapdFQRNSEAA0hu3uYrlo3w+ZovgUGSROr19miGBA5WkizYfD9T4KUCKi5Lqd0mAKkQcbwgIKu19ei+av+bT5wYzabdeZ/rMKNbiA2dEhUMVzPzFwcsvfWT1gMZ7lmNWBuZtzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HNIFORqD; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-727c59ecb9fso12564b3a.1
        for <linux-kselftest@vger.kernel.org>; Wed, 18 Dec 2024 10:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734547449; x=1735152249; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7jSic6TIOj3w851bzmdbHRdhUPvd3z/Q4EhEJqzsZcM=;
        b=HNIFORqDglzfLaN2/HFfedbvk2EO5d1/gKkIX/WGiNRD9md6AHGHpqBQYQ5WXllEA8
         gFm42WpPhnDIO+cJDppxFMhd5CkXgkyK2S3yiM6naB6BUF9N83cIRHfqNu4dXLZWWFH5
         kKPzDxrTOekDFKktU6nxq3ved4gc13Bcd7KbYeeXV/hoRr15LlXYEM++hvsbEInHNoYh
         z+zwxLNXS7dP3oHd2BkiaBQMtt5k99z58+xds2bpLbx4z+Y8qyMOkSxq4Zo1OZ60A8bz
         11PvdwJSyt+h97QLue5CGrgehqrvRVNpHrOzoM2xquu4LLjnMefpsGGgqTaLigavdTOE
         VWJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734547449; x=1735152249;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jSic6TIOj3w851bzmdbHRdhUPvd3z/Q4EhEJqzsZcM=;
        b=uWKmXxYFVANLomHlho7bEOt61AHp9xnI0ujxRXF8Ro33EipWDAKjAIahUJqoTYNpMf
         rCVdgEgT8Vh+0NPrlDgaRs/7h7tQnVglBeWz6OZj5TjI6vGDXQWabNz8Bcu1zGRj3J0X
         gWuYSXTW+yUMnNZbJgMHwvfFPIb5fe5ZJgas3o9WvLGGMaj80Ym5Lr5yKJ4pLWOEKpTM
         lWrGlcPMFBZT+dBl1FgXQ/7X0hDS5emLA7SbVm5ljUQTYbEmOjcR1N20uMiy6fw4GN2X
         PbDTJU+YNjNTh4vQYCvN1DhOjzrwGknjw+SQjFgIh6kuYiIeGpIEKWE2uyEkHQ3JcZ3J
         CTEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsrjFQ/miMEjw6SLP3R18A4gopigJ+SiORSULsCvqKt5BCRn5dnqY8h4RZl343qGDmeSA+s8RHkz9MafK2NJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOvsxAaST/Z4UJ9PCmSF9w4SdySZV6Bh9rIo2mq+8W1GC4y6Er
	UraA2DFmESum2170qc5x5r/4LFRg2Q2nN1fY6sXqSupQvURcRMWn2Rx7rgtEUf1qixSryJ1Qpbk
	RAg==
X-Google-Smtp-Source: AGHT+IGLlbGARYjW3VToWr9kgBEQplNywz6RBTD9omsrF56xvNNHVLKbUj2hBvCY+P6Y5w0cv4rhhCyNmcc=
X-Received: from pgbcp7.prod.google.com ([2002:a05:6a02:4007:b0:7fd:342d:a180])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:e85:b0:1e1:c8f5:19ee
 with SMTP id adf61e73a8af0-1e5b482a145mr7124926637.25.1734547449091; Wed, 18
 Dec 2024 10:44:09 -0800 (PST)
Date: Wed, 18 Dec 2024 10:44:07 -0800
In-Reply-To: <20241217181458.68690-8-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241217181458.68690-1-iorlov@amazon.com> <20241217181458.68690-8-iorlov@amazon.com>
Message-ID: <Z2MX9ygvHPgS8rRf@google.com>
Subject: Re: [PATCH v3 7/7] selftests: KVM: Add test case for MMIO during vectoring
From: Sean Christopherson <seanjc@google.com>
To: Ivan Orlov <iorlov@amazon.com>
Cc: bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com, 
	pbonzini@redhat.com, shuah@kernel.org, tglx@linutronix.de, hpa@zytor.com, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, x86@kernel.org, dwmw@amazon.co.uk, 
	pdurrant@amazon.co.uk, jalliste@amazon.co.uk
Content-Type: text/plain; charset="us-ascii"

KVM: selftests:

On Tue, Dec 17, 2024, Ivan Orlov wrote:
> Extend the 'set_memory_region_test' with a test case which covers the
> MMIO during vectoring error handling. The test case

Probably a good idea to explicitly state this is x86-only (hard to see that
from the diff alone).

> 
> 1) Sets an IDT descriptor base to point to an MMIO address
> 2) Generates a #GP in the guest
> 3) Verifies that we got a correct exit reason and suberror code

No "we".  It's very specifically userspace that needs to see the exit.
 
> 4) Verifies that we got a corrent reported GPA in internal.data[3]

s/corrent/correct?

And #4 can be combined with #3:

3) Verifies userspace gets the correct exit reason, suberror code, and
   GPA in internal.data[3]

