Return-Path: <linux-kselftest+bounces-7191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E067C8988A5
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 15:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC091C21714
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 13:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84ED1272A6;
	Thu,  4 Apr 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="henlqqgp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2906DEDF
	for <linux-kselftest@vger.kernel.org>; Thu,  4 Apr 2024 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236785; cv=none; b=tA2wXXKMqO5kUVSesBULn3OsHc3iZV+H73fF4eJvsKGMeEPiLIz2eqzejBvxqKyaAT77ZkFNV1DH+7VloakT2QpbkSIteEXwf4QOduV2k17ocKBJ2C0PPwYBsQ8QhqvlOHoKlDAS8LJtF2mywoQ9yCnBqFYDAw1jdV08DjU92A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236785; c=relaxed/simple;
	bh=IeoKAWNWo38K8IL0PVPAWG7KkgiEw6V5EUpqvFfDi+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyURWozH6HkWgpPWaTyXNpBYJKjdM75bm39qkLB/JPJgqJ0GfzBifqxi+Ny9YTNZtAxTITLCPLO3R4WhKOt3GJB9vVH3rrsKzOfEX4vI0lU+xP/fSUo6k3P3n1Dmm5FVv2B0d9y5e4QMHMR0viFzK3XeDjRO7Wk88/K0/1ZiDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=henlqqgp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e1e6e1d01so861459a12.1
        for <linux-kselftest@vger.kernel.org>; Thu, 04 Apr 2024 06:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1712236782; x=1712841582; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GjkWFp3ApOurs5n8Si7/xNCJaddk/YxQVfZe4wLlwY=;
        b=henlqqgpF/2EsTkqPC60/lPuhbF0BZmqmq1p4vG1EN+roSgIxi0ZqGKZBLeNRZHbnZ
         EqfN3Vml7oBtMPD4Cpd1Rl/kff0k68unDQZPU+eNoB8ejHfc4FVZ8+ZqrLtnlP2Vcdr1
         6JnnfUQBtBdYnP0oVasGU2gxaCfzz1RMnHYzXkpxsStFrWPo5DqH52d2snOFwkOZ365D
         3wv02ssH7u3vI909QLNvICUYf+YiklLJc0w1gCUM165WDwjLSMVz2xOJ52TbfU+IzZ4W
         R1kjRRNu99/vIIvVI9KFQEGbEINc/sJcvWteRIxDs5ySsueyKQWp4w8C8HiWxqaMMsST
         JQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712236782; x=1712841582;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GjkWFp3ApOurs5n8Si7/xNCJaddk/YxQVfZe4wLlwY=;
        b=aQJVOuv3qHbUNlYPTmozCt7MWljd9Tu7syN3D0qOHAdvaUrIdQWURedhlZSPXAZJnv
         vOE/W5+Z9WccnwdJQylbnJyhjOaxAKamFbOfb+uF2AX7A6+f9Y5mkV4vv4DTulMEaOG2
         CBi6mlZqS/PH3RXKPjUj/kFYUXshC/YWaFe0dhaUeb47pLsKVJClckRZ/E0SIOPKEooH
         TLv6+0HzqM2LKXkubEB6zY9CnoviZSySkhMrHWH99yvpMtBSKMnxZc/WR1WKj/neSgra
         ySAoYLhRopBDv3JmC4ZdPdn3y1ceD9UUQJ/3ue6OvlnvehpT/4PI5sTgpn/g6NEhFp12
         x/bg==
X-Forwarded-Encrypted: i=1; AJvYcCV1nYie5Fbv0vFMxEP1DMDpE9g5mMi/caHnrXDxiLWFKQVYRppP7o0i4MaFIdkEcd4749y92S63xwTWnFSj1ABCvgxEXnoNaU5nRpefEA5A
X-Gm-Message-State: AOJu0Yw9CPr4ClNizVlr6gWVdNpC7NrmXvOLOiKkZs6FJgfplu5MWPCX
	dG2RGkATdupD1qAW61gKFJ7qs0h96TUubLoJOT8iTVq5tdgxQJzRVh7X5QuYxPEp0bQEKQtz1uS
	1
X-Google-Smtp-Source: AGHT+IGJsfjeRV8JN7BFQhANoFqMbTK9dha2lq1Z2/LpaV5C6zDTl7nzvlfIm+foWwn07Yd8JQ0d1g==
X-Received: by 2002:a17:906:e0da:b0:a4e:9b06:db52 with SMTP id gl26-20020a170906e0da00b00a4e9b06db52mr1574450ejb.45.1712236782551;
        Thu, 04 Apr 2024 06:19:42 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id eb16-20020a170907281000b00a4e0df9e793sm9062928ejc.136.2024.04.04.06.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:19:42 -0700 (PDT)
Date: Thu, 4 Apr 2024 15:19:41 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Atish Patra <atishp@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, linux-kernel@vger.kernel.org, 
	Anup Patel <anup@brainfault.org>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Conor Dooley <conor.dooley@microchip.com>, 
	Guo Ren <guoren@kernel.org>, Icenowy Zheng <uwu@icenowy.me>, kvm-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Rutland <mark.rutland@arm.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Shuah Khan <shuah@kernel.org>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 08/15] RISC-V: KVM: Implement SBI PMU Snapshot feature
Message-ID: <20240404-0eb0261d56c48ac9472dfe5a@orel>
References: <20240229010130.1380926-1-atishp@rivosinc.com>
 <20240229010130.1380926-9-atishp@rivosinc.com>
 <20240302-6ae8fe37b90f127bc9be737f@orel>
 <CAOnJCUKjZWnS_SaR78Fy5AUOxrd+4gBx=_YrA=FQCa20iwifNQ@mail.gmail.com>
 <a75fa96e-2f26-49a7-a7f7-4a397c4a4513@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a75fa96e-2f26-49a7-a7f7-4a397c4a4513@rivosinc.com>

On Wed, Apr 03, 2024 at 12:36:41AM -0700, Atish Patra wrote:
> On 4/1/24 15:36, Atish Patra wrote:
> > On Sat, Mar 2, 2024 at 1:49 AM Andrew Jones <ajones@ventanamicro.com> wrote:
> > > 
> > > On Wed, Feb 28, 2024 at 05:01:23PM -0800, Atish Patra wrote:
...
> > > > +
> > > >                if (flags & SBI_PMU_STOP_FLAG_RESET) {
> > > >                        pmc->event_idx = SBI_PMU_EVENT_IDX_INVALID;
> > > >                        clear_bit(pmc_index, kvpmu->pmc_in_use);
> > > > +                     if (snap_flag_set) {
> > > > +                             /* Clear the snapshot area for the upcoming deletion event */
> > > > +                             kvpmu->sdata->ctr_values[i] = 0;
> > > > +                             kvm_vcpu_write_guest(vcpu, kvpmu->snapshot_addr, kvpmu->sdata,
> > > > +                                                  sizeof(struct riscv_pmu_snapshot_data));
> > > 
> > > The spec isn't clear on this (so we should clarify it), but I'd expect
> > > that a caller who set both the reset and the snapshot flag would want
> > > the snapshot from before the reset when this call completes and then
> > > assume that when they start counting again, and look at the snapshot
> > > again, that those new counts would be from the reset values. Or maybe
> > > not :-) Maybe they want to do a reset and take a snapshot in order to
> > > look at the snapshot and confirm the reset happened? Either way, it
> > > seems we should only do one of the two here. Either update the snapshot
> > > before resetting, and not again after reset, or reset and then update
> > > the snapshot (with no need to update before).
> > > 
> > 
> > The reset call should happen when the event is deleted by the perf
> > framework in supervisor.
> > If we don't clear the values, the shared memory may have stale data of
> > last read counters
> > which is not ideal. That's why, I am clearing it upon resetting.
> 
> Thinking about it more, I think having stale values in the shared memory
> would be similar expected behavior to hardware counters after reset. We
> don't need to clear the shared memory during the reset.
> 
> If both SBI_PMU_STOP_FLAG_TAKE_SNAPSHOT and SBI_PMU_STOP_FLAG_RESET are set,
> may be we should just write it to the shared memory again without assuming
> the intention of the caller ?
>

Either way, we just need to ensure it's clear in the spec.

Thanks,
drew

