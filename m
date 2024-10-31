Return-Path: <linux-kselftest+bounces-21261-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DED2F9B8431
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 21:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2461F23EF6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2024 20:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA201CB9F9;
	Thu, 31 Oct 2024 20:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fWHuCx5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277841C7B62
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730405390; cv=none; b=ox6do/NGlZAX2HVo96vLKn/IHLZVcAG5D4moqLlqTuOKOqsqEIl4dAdiZ7Ha8Tg2VTluNGcXGpthf/fAdsjUC5tIuhS5kKyxproFKWMlfGDS4u2p7XPdGPXl9c2N5nVaQlWP/IysBSWDqYkr9sMrMhApxNhXzKljlRhdp1LxwxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730405390; c=relaxed/simple;
	bh=Udpm6RI+vAu4DeQK4HRqdmPK9pOT5qP8mLEQJwd46mE=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=kTEbVmR4HG5GcOCxDqG6GJ1FXd2U/7VTncxjOXS02FJZVJMZkzF/94GQz+YD2NMgAqD6JA/P9JPd+udnZW5E/yALHl8yriq9hkcv6TrALrqyrDUvRwLdUtpvZGIA/wDRGaclJbk1qAztUaTg9JfbnFWYb/MlEHpPjOXrOrYw/Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fWHuCx5c; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e38fabff35so25094107b3.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Oct 2024 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730405387; x=1731010187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YYJVMBm1bZbfZ8BXA7U0ACFO0AHr0DoTfzETRNw+mrQ=;
        b=fWHuCx5cDIIHZelGrsgLNx3xD+DnQeNFUTgNS8W1QPsGNgJcnIsA3fsViyrnxkxkpe
         HW6xUxtayRY+3g1jiHnEG19m9fJ14qghiibOSvdwBv3BEDU/fyqkJen5D2JxFuKehIC8
         vxivbQiAEbR+PWnzhVzKXtdm+heBGrQV1yRjl8I64AopbBXOrc/k3nBsAnGPN+Edu0CG
         WabkXHum7FNXq8uayR6SrMo/U9gYMT/LOTEN0TgXqp0PoRBLDNAKVBp3pvumzQjmSvGN
         NwL3BQN3Dp0D6AMCpjq7qLTpTOROFhrZFerBU/B1AmsSFSsabSYPgPnhvmEBin2/CbbL
         2e9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730405387; x=1731010187;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYJVMBm1bZbfZ8BXA7U0ACFO0AHr0DoTfzETRNw+mrQ=;
        b=l13GHxnqtnumJxd17U3T+pLxG/i9toSiDSDbTZlyIJchnF6zDP/r8Oxv1PHivkS0RQ
         WPqcA0GAqFNjjtqiQYU/dg5xClGKs4lh4nqLxoBgD/MfCEK9bxwcUN9NCa7NK2nUXBTq
         gQQFttxaoVHbsCp0Nkci1xBUUZNn8CDqfJAGJfwcx7XI8YG5vVAplIEzJ5IxyVlGkzem
         rvYUvzOKgSl4INeFRvEldxLnxXF0RDqAAJvRkAPabvYg98YylqjiMEd/0OA/qVadqlz7
         GLoI+5BRyim8oSsys+FcQEYffdkqax+dLAN3DdJnYfoqYN8TDaGQmQRN6Mb0SIGj8fmm
         8MdA==
X-Forwarded-Encrypted: i=1; AJvYcCU47LwaWLq3LeV1JeYWoqzjp2Nn8yjaLWFme8c8ZS0/pGD6B6mjnRWSrOzvto3CPp+lJNIpJ1ukfQrGw2dN9EY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZJ3mTRkBdXDxPbD7HdNQjyylk7ErtjHmj9UOAAGejC7tHCZH
	NRePEx+WneZSWwmg4bKyJv4IBuWKLV7qqqVyXoTbknld82LIeVJCAoOS8LJcmpAKCk9KPAn5awU
	ARrquMOfuLwrNf5QJVQ96DQ==
X-Google-Smtp-Source: AGHT+IEpU/nsqHw2HNdrnKe90ZcgMwiw8711EjVnoYy7bqvyFHs6zt8GYUXoJCH86l1eGdVB7BBA9qy0Bkl/MtaP4g==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:690c:6407:b0:6e3:8562:ffa with
 SMTP id 00721157ae682-6e9d8b5f046mr14345247b3.5.1730405387276; Thu, 31 Oct
 2024 13:09:47 -0700 (PDT)
Date: Thu, 31 Oct 2024 20:09:45 +0000
In-Reply-To: <20240918205319.3517569-1-coltonlewis@google.com> (message from
 Colton Lewis on Wed, 18 Sep 2024 20:53:13 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsnth68sf306.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 0/6] Extend pmu_counters_test to AMD CPUs
From: Colton Lewis <coltonlewis@google.com>
To: Colton Lewis <coltonlewis@google.com>
Cc: kvm@vger.kernel.org, mizhang@google.com, ljr.kernel@gmail.com, 
	jmattson@google.com, aaronlewis@google.com, seanjc@google.com, 
	pbonzini@redhat.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Bumping this for Mingwei

Colton Lewis <coltonlewis@google.com> writes:

> Extend pmu_counters_test to AMD CPUs.

> As the AMD PMU is quite different from Intel with different events and
> feature sets, this series introduces a new code path to test it,
> specifically focusing on the core counters including the
> PerfCtrExtCore and PerfMonV2 features. Northbridge counters and cache
> counters exist, but are not as important and can be deferred to a
> later series.

> The first patch is a bug fix that could be submitted separately.

> The series has been tested on both Intel and AMD machines, but I have
> not found an AMD machine old enough to lack PerfCtrExtCore. I have
> made efforts that no part of the code has any dependency on its
> presence.

> I am aware of similar work in this direction done by Jinrong Liang
> [1]. He told me he is not working on it currently and I am not
> intruding by making my own submission.

> [1]  
> https://lore.kernel.org/kvm/20231121115457.76269-1-cloudliang@tencent.com/

> v2:
> * Test all combinations of VM setup rather than only the maximum
>    allowed by hardware
> * Add fixes tag to bug fix in patch 1
> * Refine some names

> v1:
> https://lore.kernel.org/kvm/20240813164244.751597-1-coltonlewis@google.com/

> Colton Lewis (6):
>    KVM: x86: selftests: Fix typos in macro variable use
>    KVM: x86: selftests: Define AMD PMU CPUID leaves
>    KVM: x86: selftests: Set up AMD VM in pmu_counters_test
>    KVM: x86: selftests: Test read/write core counters
>    KVM: x86: selftests: Test core events
>    KVM: x86: selftests: Test PerfMonV2

>   .../selftests/kvm/include/x86_64/processor.h  |   7 +
>   .../selftests/kvm/x86_64/pmu_counters_test.c  | 304 ++++++++++++++++--
>   2 files changed, 277 insertions(+), 34 deletions(-)


> base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
> --
> 2.46.0.662.g92d0881bb0-goog

