Return-Path: <linux-kselftest+bounces-35654-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33772AE54C4
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 00:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20ECD4A5BB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A52223DEF;
	Mon, 23 Jun 2025 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdkluDbA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250782222C2
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750716272; cv=none; b=LloTlb6nHCzxxmRHbWfowGwzq9xR/gyPkLr5Q1pK8+lCsK69sg8PZS1fV2YMSclG/8Qyu5olO0449tMUzmILNgO0+EC306znNYx61Y49ZbPQ3o4ikle/RMvHgilGC4lCGhP0FUHfeZJkY8rOtH9292NIib5PQLZbHdhPIWH57KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750716272; c=relaxed/simple;
	bh=f/UyJP6vQx4TVd+AM6JjhbEHevJGuFxqlVA/YhTlF/s=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=JPbb4DClVRQdPgm25JQIlMV5leiIT1H2BkjW2NVbYyJ46suLMOFlAGijSBFGR9Xen5xdCAOGpt+65ICSr6j+ZN+H4Ykrc+LlqqVMEXaqYzdwv8xAvFxUSd01FYZ/Zt16n7UCQi/aOXfvmDSG6cZqkBGvG5YU15lr3IlF8z3oyRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdkluDbA; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-735a87c1601so3273181a34.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750716270; x=1751321070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XtLVtTxbmHrCBpSNsrNTm3SDGLbs218ttvI0elQ1Q/A=;
        b=kdkluDbArgNgkRJ9UQa0FcY0rvsUfKvnWgKyOKKrgFK+AysFb7/iP6Q6CiA8slKsXA
         5x5eb/bYkegQTMqTkmyrf1NxsekalXIglSISfByGQgouT30DsOJ67VrNN10ZWIIkp91j
         J8BZqg4tdYzzzcVqY1t+D3pImCn+aNRGKhfxixRVyQmtrAdg9zNV1jKPdhyw1G/Jzd84
         NZYKv3XbD2Os8yLpS9iyoJ5hPzRksAt7K32PGfmZAknMje/nFlJYr6YmvHEz8/ljiFYM
         308m+AqQPgYY6/tTogxh4qcf5+GHwZgI9+zxIL5Qk9PW7pYZGg4FatxaIXbLcIw8kCd0
         z4TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750716270; x=1751321070;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XtLVtTxbmHrCBpSNsrNTm3SDGLbs218ttvI0elQ1Q/A=;
        b=qmQ3uBxoNQjxnt3xdUkEyWphpQ0pznpNz1NDw5tDmqgvSRQQp8orvmAtoj7V6XU7gK
         sCQosnEGb/q6MTApBMqfrgKQ0mr1XKST8orhcznbcazyNZyeWSwGrj5gv/pyFyZ5s252
         VLDAgXSZi5nbpyoUfz0Tsa64jzbN7Iwnv8Gopz8DPqVl3Ee6irscLrmth1FHHSKGwcq+
         sG346xanVRjbQwHiR9mYvKUKhQ8UfykMD65BnYhxcPbk6wmNoJ8ghdAiJkj3kX1ikXx9
         Tl8GaK1Wc6EXW88p7b0xQwB2PqqHEFMaPJQLKeVVLxDdN0JUKy0lJxkuWaf/SNbcfrPt
         3Fkg==
X-Forwarded-Encrypted: i=1; AJvYcCUosZawmOx0xW4YipQW5wUSufnhQK9uGNPVpnuPeT2Hjmkm7ckdvS4NpPim93Sp5LB3qDhSPH/EVCMki7+/Q6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/YgrkBJCJrwaQJyqfhMrNduyn6AbUQCJcnXpV7YkC7SJPh6fh
	wEB+pxd7a28VlZMkk2TizIvfsB3mXgsefnilw95Kq+i6L7OB7a6MBUx7B5z+ekFDZMaGhOOo2JF
	i81h8k+d8s/zAhHzzsMmN6CikcQ==
X-Google-Smtp-Source: AGHT+IFkDmfiUvq4ze8ArvjRNaiH+ZXYtlXJVVDDWXvRxwvqUxfAjNMLJj1dksngCu/MtTNVejcjEvPTGswxYjYzFQ==
X-Received: from otbbx10.prod.google.com ([2002:a05:6830:600a:b0:72b:88be:33e6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6830:d8a:b0:73a:8d4d:426f with SMTP id 46e09a7af769-73acbd8e287mr1029204a34.2.1750716270304;
 Mon, 23 Jun 2025 15:04:30 -0700 (PDT)
Date: Mon, 23 Jun 2025 22:04:29 +0000
In-Reply-To: <202506212205.NmAR3sAH-lkp@intel.com> (message from kernel test
 robot on Sat, 21 Jun 2025 22:56:09 +0800)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntjz529ksy.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH v2 05/23] KVM: arm64: Cleanup PMU includes
From: Colton Lewis <coltonlewis@google.com>
To: kernel test robot <lkp@intel.com>
Cc: kvm@vger.kernel.org, oe-kbuild-all@lists.linux.dev, pbonzini@redhat.com, 
	corbet@lwn.net, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	skhan@linuxfoundation.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

>     drivers/perf/arm_pmuv3.c: In function 'armv8pmu_enable_event_counter':
>>> drivers/perf/arm_pmuv3.c:680:2: error: implicit declaration of  
>>> function 'kvm_set_pmu_events' [-Werror=implicit-function-declaration]
>       680 |  kvm_set_pmu_events(mask, attr);
>           |  ^~~~~~~~~~~~~~~~~~
>     drivers/perf/arm_pmuv3.c: In function 'armv8pmu_disable_event_counter':
>>> drivers/perf/arm_pmuv3.c:702:2: error: implicit declaration of  
>>> function 'kvm_clr_pmu_events' [-Werror=implicit-function-declaration]
>       702 |  kvm_clr_pmu_events(mask);
>           |  ^~~~~~~~~~~~~~~~~~
>     drivers/perf/arm_pmuv3.c: In function 'update_pmuserenr':
>>> drivers/perf/arm_pmuv3.c:757:6: error: implicit declaration of  
>>> function 'kvm_set_pmuserenr' [-Werror=implicit-function-declaration]
>       757 |  if (kvm_set_pmuserenr(val))
>           |      ^~~~~~~~~~~~~~~~~
>     cc1: some warnings being treated as errors

Looks like some dummy definitions didn't make it into a non-KVM config.

I fixed this and a similar problem I found with kvm_host_pmu_init().

