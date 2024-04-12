Return-Path: <linux-kselftest+bounces-7859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A668A3606
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2430D2848D9
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF814F12A;
	Fri, 12 Apr 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="34ITugh9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B4014F120
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947936; cv=none; b=khGJ5O9hJXanAMCY3vh7PnLSHfdQu9Ec6/QltVdSKxqSFDOMkp5HrFRkeiHhxqisZ5UO0zrrJb7112wkkfQaVoeMk4s6TAFL/196HFmas9BHFRckjcSOwMV8RlsAKHtNWmuGPHFwdRii40pbLYTaeCV8eq5lf6nghmgXnBAWF2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947936; c=relaxed/simple;
	bh=OyrP4TVWNsr72SJzygQcNpcL4PlM53A2VcvjVO/eZhk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MmA9AfVFITDOy6u+CcC5tDq7StTZo/8T1QKsGZcjwgVsSxg+iczu2gC1Eb6N72StOpK8FJ42qHDKcJagG1tdfdMU0oc2tngANebbHmMRNIjAB5w41oqaznsw8dMMCVeMi3v6PeFyoUDFo5bK9GKFaf7fhIada79R0g3g/gfxtuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=34ITugh9; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2a49440f7b5so1139615a91.1
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 11:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712947934; x=1713552734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SyQF6Zi4eRkAq1X13L/9PEbNKEusnz+wu9E7jYgcU3o=;
        b=34ITugh9TG5LamaTU852JQezJaSqWa3jQAikAqaAWANX+KtlF97UzadfpDOvt2coIg
         eFGSHtWqfJKrYCRXrrS0XaU8iKgcFBeRoNLYZxwILsc+k6lfJDX+Zs5DVX9ZqF7Otz5/
         gsEn7gyISVaMc2dAov5ffhUzGRdFR6H8MzkvQRCrXJcfRFkj1T2GZ2LVoVAEf2njeDC2
         qlrYB/v+aLpZHf3VWI59HoZQN9SufR9S/Rq+y7qtbGVwzeCQWQderxhnNk2ec/pTHqkI
         3iHaIuDwbFz/kEJG8/fk25/8Yun44ZXvXTmOxiy1sf3zpuuIq1htKS5W4GCU6Re2LUKP
         WAeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712947934; x=1713552734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SyQF6Zi4eRkAq1X13L/9PEbNKEusnz+wu9E7jYgcU3o=;
        b=jl+dNTqPNycIDHRI8M3IJFVWTVu+eoOVYAHAW2uvh1zBCTpnb/zze8mZ1KRTZyhcBS
         /jElK+4SvRSvQ9ZwA9TCrU5VslEMZI2G8zlxLwjzG/jrQvOIHohiZ9OMVl/pZVdpTfPf
         2bjzMdY1EetLhCzkshtwzrJ0yYK7/DVsbCgrJK003Jr735gBYz/lQOOLGg7G49eFTc4Q
         5lDauJ9QhDsJnqzkQXYS7sPQmpdSclNzxMOniOuryIeI3ebSzn7vXsoWcze8wZvrbwhn
         mzXeGBmsxw0wYunkvRVa9RPX3G8MMNiExD6gtgMqdJxpJ0SDZTLnydnFg9wARLW4tGr2
         0ndQ==
X-Gm-Message-State: AOJu0YzDY6F12+YZv3xGMI/T68EQYmPgIvWeQI9sli29jp7klFVXMtRz
	Y856IR0lCMQAV7npmBMsJRNXI845EMJEVr/Wv4aUSc93xIpVtE4wxHM7ts/1JMMvXYBFLPyou50
	LBw==
X-Google-Smtp-Source: AGHT+IH/DlhV/yE3OZLMgufqxrATefoUtIDwFGAReeza6owVpNTXpXXxGPYWycSNjN5WSVNzaIq1/C+dsig=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:180d:b0:2a5:22cd:25f3 with SMTP id
 lw13-20020a17090b180d00b002a522cd25f3mr9381pjb.2.1712947933824; Fri, 12 Apr
 2024 11:52:13 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:12 -0700
In-Reply-To: <0d366f20-e332-45a9-8545-4513fdce6e21@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322163351.150673-1-zide.chen@intel.com> <ZhCCub4ajIvpvrBk@google.com>
 <0d366f20-e332-45a9-8545-4513fdce6e21@intel.com>
Message-ID: <ZhmC3PbYQlChDg-t@google.com>
Subject: Re: [PATCH] selftests/rseq: take large C-state exit latency into consideration
From: Sean Christopherson <seanjc@google.com>
To: Zide Chen <zide.chen@intel.com>
Cc: linux-kselftest@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 12, 2024, Zide Chen wrote:
> On 4/5/2024 4:01 PM, Sean Christopherson wrote:
> > On Fri, Mar 22, 2024, Zide Chen wrote:
> >> Currently, the migration worker delays 1-10 us, assuming that one
> >> KVM_RUN iteration only takes a few microseconds.  But if C-state exit
> >> latencies are large enough, for example, hundreds or even thousands
> >> of microseconds on server CPUs, it may happen that it's not able to
> >> bring the target CPU out of C-state before the migration worker starts
> >> to migrate it to the next CPU.
> >>
> >> If the system workload is light, most CPUs could be at a certain level
> >> of C-state, and the vCPU thread may waste milliseconds before it can
> >> actually migrate to a new CPU.
> > 
> > Well fudge.  That's definitely not on my bingo sheet.
> > 
> >> Thus, the tests may be inefficient in such systems, and in some cases
> >> it may fail the migration/KVM_RUN ratio sanity check.
> >>
> >> Since we are not able to turn off the cpuidle sub-system in run time,
> >> this patch creates an idle thread on every CPU to prevent them from
> >> entering C-states.
> > 
> > First off, huge thanks for debugging this!  That must have been quite the task
> > (no pun intended).
> > 
> > While spinning up threads on every CPU is a clever way to ensure they don't go
> > into a deep sleep state, I'm not exactly excited about the idea of putting every
> > reachable CPU into a busy loop.  And while this doesn't add _that_ much complexity,
> > I'm not sure the benefit (preserving the assert for all systems) is worth it.  I
> > also don't want to arbitrarily prevent idle task (as in, the kernel's idle task)
> > interactions.  E.g. it's highly (highly) unlikely, but not impossible for there
> > to be a bug that's unique to idle tasks, or C-states, or other edge case.
> > 
> > Are there any metrics/stats that can be (easily) checked to grant an exception
> > to the sanity check?  That's a very hand-wavy question, as I'm not even sure what
> > type of stat we'd want to look at.  Actual runtime of a task, maybe?
> > 
> > If that's not easy, what if we add an off-by-default command line option to skip
> > the sanity check?  I was resistant to simply deleting the assert in the past, but
> > that was mainly because I didn't want to delete it without understanding what was
> > causing problems.  That would allow CI environments to opt-out as needed, while
> > still keeping the sanity check alive for enough systems to make it useful.
> 
> Sorry for not replying earlier. I overlooked your email from my inbox. :)
> 
> Alternative to the busy loop, how about using the /dev/cpu_dma_latency
> interface to disable c-states (I wish I had learned this before writing
> the initial patch)? The good thing is it can do automatic cleanup when
> it closes the fd.

It's probably not practical to touch /dev/cpu_dma_latency in code, e.g. on my
system it's fully root-only.  And forcing rseq_test to run as root, or be bookended
with script commands to toggle /dev/cpu_dma_latency, is not a net positive.
Lastly, fiddling with a system-wide knob in a KVM selftests is opening a can of
worms I don't want to open.

However, we could have the failing TEST_ASSERT() explicitly call out
/dev/cpu_dma_latency as a knob to try changing if the assert is failing.  If we
do that *and* add a command line option to skip the sanity check, that seems like
it would give users sufficient flexibility to avoid false positives, while still
maintaining good coverage.

> The reason why I still think of disabling c-states is, even in the low
> c-states exit latency setup, it can still increase the chances of
> successful migration.
> 
> Otherwise, I can implement a command line option to skip the sanity
> check, as I was not able to find out a metrics/stats that is easy and
> reliable to indicate that the scheduler is not able to wake up the
> target CPU before the task is scheduled to another CPU.

