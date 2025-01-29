Return-Path: <linux-kselftest+bounces-25401-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6FCA225A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 22:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3ED261886C29
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Jan 2025 21:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327DF1E2843;
	Wed, 29 Jan 2025 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2TLc2M6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BC11E285A
	for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186026; cv=none; b=gfdNjZ2SBmNojxrpRdSpg9et11Nx0PBPy18UvtkiGxVDGURaJzwVr7NQXpXgoVtYdv1pZeThE4rtQUlA4igDTlhhbyvw/aunnF1QLnrbdIH3tTPcl5Tx0MzAuF+O65sHquP+wvx8crDV9oRVNsnghq9YZ7hIBdEV8r2ugtYDYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186026; c=relaxed/simple;
	bh=nN9FJWNplkIKmzFXRfsaSEmbobI8sxtet+92PBTyajw=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=KXM1N+9aQ9v5r7YsTX/euOJXHCI2A0x+drub7+0NytI8AfysoFl9xLjH4jFwbpuAZjhqOIoPgWORwCd8QuPxYZRvt2t3lw+t3E4HBaCKRSZKpE4ZdKzh0RY1TK6Ul1fNl7WwM1ogJwHq/X459iRgc6Z9XbzsZoDZ+PGjZyOM+4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j2TLc2M6; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so3516605ab.0
        for <linux-kselftest@vger.kernel.org>; Wed, 29 Jan 2025 13:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738186023; x=1738790823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f5TFKrdlu748ABqlHsuP9NDv0QkMzFjiUtwaLrqTFf0=;
        b=j2TLc2M6wiZkJPGU8C8uY4tI4Z9NJS3opsqH5b73tdH9/aaID2ov46WOKFTWGnSDS9
         7pW82iJdU2kGqOBmvitgQ2H1h4w51wmEEL7xzk9D05lxaXP84sgqzUGXku0rlfHy5v69
         q0Np7iakn8a9BM+eH4m7w47B3mhc5vcTDblsfBGcEhi7Dmh/lSjTEEuwDXK6PegJThUQ
         VvWkZZsIPLM2QuRnZG8JNq1WMZLa4poU4NU8ANNwLs/YK6LK4P5CUwjzUJ337VvOUxsA
         X0GK1TdhYP/8B2BmiAY1Im5f/NDG75K0UTdNCQI+kRdce27XooYIixa48SZzLIzkV+Cm
         cT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738186023; x=1738790823;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5TFKrdlu748ABqlHsuP9NDv0QkMzFjiUtwaLrqTFf0=;
        b=okIBFkmh+QgPLhdmXFbbVI4VS0gAC7XXUCVzEL/egCND8mKCxX/A7WjOHIFZcz+qxb
         tA6f/hZdLwzhVfzwTR45RApcrepMw2Jdi70hb5af5O4L+cBMaLafHgU3ACcLpPPD55zE
         XXBpcSV4854x7eji/ibObkpy5ANuNujKBpUSsyY5DIQsgMV3a/BymwNgdTMWbhKMURX4
         M8vNKx5qmxMH+6gjsWR4ygz8ybR8lqia7ex3EP3fbby+tcs9f3+D8faYGYi2aan0IoBV
         FB5mRzb9zXS4Rww7KgOc1gxXL+5P4A0ZSwBEDppkSaDp+FamV8GMRqN+bJpBre9PwYmC
         7hJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVxhJsvh53+RWU+1moCIeJECb+oOLUn6fs3Ad/7IPKyi648/P4DlzQHSUcAHkmT5kzT3pDnQGsrDB3PpNdz3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8WTH8ssxsCCC3ZicgpkYBWkRkfjUEfrrB0zgEphdV35HuWEL
	+PuS7SMR035uTDucj2MCYj39WZcJPsynZ0IuvyUJpP5K2T6DIsK/u5Om0F+aUwqbKbcks0VVbj+
	ukk0dZynN7nP3fldtuyzwCw==
X-Google-Smtp-Source: AGHT+IEe9UoVLvNSaHlSkXBd6Ho5IN4ChMz7y7gjFQYGYFiTLbvYP7nErowhtJVcYSVDfJu2qMuLzToHlUCNsQ59Ig==
X-Received: from ilbbb15.prod.google.com ([2002:a05:6e02:f:b0:3ce:69d1:ce53])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6e02:20cd:b0:3a7:66e0:a98a with SMTP id e9e14a558f8ab-3cffe3d1e48mr43753655ab.9.1738186023704;
 Wed, 29 Jan 2025 13:27:03 -0800 (PST)
Date: Wed, 29 Jan 2025 21:27:03 +0000
In-Reply-To: <86bjvpvdn5.wl-maz@kernel.org> (message from Marc Zyngier on Wed,
 29 Jan 2025 15:33:02 +0000)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntzfj91fbs.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [RFC PATCH 1/4] perf: arm_pmuv3: Introduce module param to
 partition the PMU
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, linux@armlinux.org.uk, catalin.marinas@arm.com, 
	will@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mark.rutland@arm.com, 
	pbonzini@redhat.com, shuah@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Marc Zyngier <maz@kernel.org> writes:

> On Tue, 28 Jan 2025 22:08:27 +0000,
> Colton Lewis <coltonlewis@google.com> wrote:

>> >> +	bitmap_set(cpu_pmu->cntr_mask, 0, pmcr_n);
>> >> +
>> >> +	if (reserved_guest_counters > 0 && reserved_guest_counters <  
>> pmcr_n) {
>> >> +		cpu_pmu->hpmn = reserved_guest_counters;
>> >> +		cpu_pmu->partitioned = true;

>> > Isn't this going to completely explode on a kernel running at EL1?

>> Trying to access an EL2 register at EL1 can do that. I'll add the
>> appropriate hypercalls.

> But what about a guest that would get passed the magic parameter? I
> think you want to prevent that too.

That doesn't matter because the ARM manual states that when HPMN is set,
reads of PMCR.N from EL1 have that value and I've made sure in the
second patch KVM does that, so a guest believes it has a system where
reserved_guest_counters/HPMN == PMCR.N so there is no partition.


>> > Also, how does it work in an asymmetric configuration where some CPUs
>> > can satisfy the reservation, and some can't?

>> The CPUs that can't read their own value of PMCR.N below what the
>> attempted reservation is and so do not get partitioned. Nothing changes
>> for that CPU if it can't meet the reservation.

> That's not what I meant. The question really is:

> - do we want the reservation to be the number of counters reserved for
>    the host

> - or do we want it to be for the guest?

> On symmetric systems, it doesn't matter. On broken big-little systems,
> this changes everything (it has a direct impact on userspace's ability
> to use the counters).

> I think the design should reflect a decision on the above.

As currently written and reflected in the name reserved_guest_counters
this series is making a reservation for the guest.

After talking with Oliver it probably makes more sense to make a
reservation for the host. This is closer to the semantics of the
underlying CPU feature.

In the limit case it's impossible to leave the host without
counters. All valid values for HPMN leave the host at least 1, but
should we make any guarantees beyond that?

