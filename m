Return-Path: <linux-kselftest+bounces-23636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56879F8921
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 01:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 374EE16CBCD
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Dec 2024 00:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73362594AB;
	Fri, 20 Dec 2024 00:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CpuCWLfL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386E92594A9
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Dec 2024 00:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734655974; cv=none; b=owhBcYCxstvr8F9Ql6BwB79QmFPP6OaCguSDhQbLGgi309LUe8dgvqgxve6lpTlp8QjKUMjpH7tuuXAyy5LLKtaQOWKbq/knh/IEBKtgBE8BbLRiW+ipHiRHsN4hKfuJ7yhcJiR/VAM2GCTfmZIHO0+Hv3S7xhsRLTi9zRyfpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734655974; c=relaxed/simple;
	bh=RrG9Ssm1ZAjOHE3F6vFIHPlrr9LFrZdQMzcHXRs4/R8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LPJWHSvBGGiV/lwMqsik5HG6ePb0KJUZxmOZ7BPlA74JOa1UEhp75i+voo7W7aiv8239FdbiVcvmj6Y4p7gfFIrTGztCv0znBuHULJ8ZHUb33B4yrxHZZse+JHN1tYHabuYDAt99yvAArtEAlBhTQ+PmGUGuLcax7FfUO2cF5lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CpuCWLfL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7289afa200aso1682845b3a.0
        for <linux-kselftest@vger.kernel.org>; Thu, 19 Dec 2024 16:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734655972; x=1735260772; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihkyfuq3wElMG8pxO8ONTksxyGREtABtMduu+TMvtg0=;
        b=CpuCWLfLCbmNGTbUj97SvGEaObEXM+ycz63BpqnWaUiW6TpGMi9K2QGABkKsHCyWdB
         QB0uAX0sc6pzzzI8eK5gIHYRQ/MmP3e9fYKogZ6l63n1VAyoiRp5sxMCMbm7uHM3nkri
         ke9GugAZm4rbBrciK21EYqdHX5NPT0pvl2pQcCDuOU575008Zaas+2l+QvaiTXkqAPRo
         Lu55I9CxlYrccmLZ4CQl2R00NjbWBEkGA8CIGYuLLLBDHuI3PkfLuPw7nSBbf9iLSpaX
         ygA2oEIFAni0pqUvs1dmCtfhqChQ/F0HIA8o7rLDm2FXiDDxt8XdDbHTdLOwnxzA25pF
         BQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734655972; x=1735260772;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihkyfuq3wElMG8pxO8ONTksxyGREtABtMduu+TMvtg0=;
        b=EeIRrgjoPpW6SjipgkrHBsbXaFEsKUCPDm2NA0XF5WwBffhnu1TfUzs6meYLib7ElN
         /9fyE+uQCKEA7dd7eJMERrqRv9b5JMzIkK9MQ+sva7gN3sFcKdeIlfYHlCyjoT3d16at
         eSTAenj0SahTT4AbIMUJItivigISdeJQw43E10+3FFP54hRTsFZfiYK/kmWSN2hOmlLe
         kbS41O1AYx5rG6peBaDEP2ha6ifIBjp0v4loqa14HFLs9JvpgWbVtG0mCVdILK/fygN0
         PARgeYjOi2GseAlUhYQ8vn9xh2sJBRCm1MJlEt+eNckHH/lJYwK2YoAPx02s3bOGPZl2
         oJWA==
X-Forwarded-Encrypted: i=1; AJvYcCWCeQwJGQ2QX8wkSKWN4iLLWLkyj6Rs/QznYyHulyUNgx/971v81EVcEINmufw/VZEclUCF7ENHzjF2dwE713w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJl8emWKB9dsq7EeLC9XfTaDdhb+ZGdNDsooMowo2OVX5FmeJ
	6jgdiL2hAt/Yv/nm6CO5qMI81hoxEx9ZJMXq+RTrdgCKY7398fqEXjHEHiAbmi+Nd09sddlfhWQ
	2Ag==
X-Google-Smtp-Source: AGHT+IGALSk1HidppKjt7K6MREWQN1zNPGPG5cwm5FqS51kn12/cvSPf29/wWjmFgw0cJl1Q2J1tAjz+HZo=
X-Received: from pfbeb6.prod.google.com ([2002:a05:6a00:4c86:b0:72a:a7a4:9a53])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:430d:b0:725:db34:6a8c
 with SMTP id d2e1a72fcca58-72abddbd4f7mr1196960b3a.13.1734655972548; Thu, 19
 Dec 2024 16:52:52 -0800 (PST)
Date: Thu, 19 Dec 2024 16:52:51 -0800
In-Reply-To: <20241021062226.108657-1-manali.shukla@amd.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241021062226.108657-1-manali.shukla@amd.com>
Message-ID: <Z2S_453UZG7t0TcF@google.com>
Subject: Re: [PATCH v1 0/4] KVM selftests enhancements
From: Sean Christopherson <seanjc@google.com>
To: Manali Shukla <manali.shukla@amd.com>
Cc: kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, pbonzini@redhat.com, 
	shuah@kernel.org, nikunj@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Oct 21, 2024, Manali Shukla wrote:
> This series was prompted by feedback given in [1].
> Patch 1   : Adds safe_hlt() and cli() helpers.
> Patch 2, 3: Adds an interface to read vcpu stat in selftest.  Adds
>             a macro to generate compiler error to detect typos at
>             compile time while parsing vcpu and vm stats.
> Patch 4   : Fix few of the selftests based on newly defined macro.
> 
> This series was split from the Idle HLT intercept support series [2]
> because the series has a few changes in the vm_get_stat() interface
> as suggested in [1] and a few changes in two of the self-tests
> (nx_huge_pages_test.c and dirty_log_page_splitting_test.c) which use
> vm_get_stat() functionality to retrieve specified VM stats. These
> changes are unrelated to the Idle HLT intercept support series [2].
> 
> [1] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m7cd7a110f0fcff9a03176935ed016f49088df6b0
> 
> [2] https://lore.kernel.org/kvm/ZruDweYzQRRcJeTO@google.com/T/#m6c67ca8ccb226e5f357d943da2a2965a4224f69a
> 
> 
> Manali Shukla (4):
>   KVM: selftests: Add safe_halt() and cli() helpers to common code
>   KVM: selftests: Add an interface to read the data of named vcpu stat
>   KVM: selftests: convert vm_get_stat to macro
>   KVM: selftests: Replace previously used vm_get_stat() to macro

Thanks for giving this a shot.  I appreciate the effort, especially on the stats
code.  But unfortunately, very little of the code in this series moves things in
the right direction.  There's too much copy+paste, and too much unnecessary
complexity.

I'll post a patch for the STI/CLI helpers and a series for the stats changes,
and will review the Idle HLT series.  Please plan on posting v5 of that series
on top of kvm-x86/next plus the to-be-posted patches (I highly doubt I will get
them queued before you are ready to post v5).

