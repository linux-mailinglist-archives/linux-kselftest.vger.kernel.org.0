Return-Path: <linux-kselftest+bounces-30484-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 567C0A84772
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 17:12:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3471F188E373
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 15:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0431DED52;
	Thu, 10 Apr 2025 15:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTN4dxpn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7BD1624D0
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744297851; cv=none; b=qi3mKwy/3fRMf8USplaE83A6mBX4HIOtetntC9sToUOtsR0rmMpllXte1SA8kzen8KUA1QIHVzh4TN27d6dLAbNvKDRdFMXjuxwixEn8c2hTHIkmydtpmIbwoEurw/95VrFj9+EhwoXBo0u2ZD0oaTYCysCaJnM26C60Z4gwdFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744297851; c=relaxed/simple;
	bh=ng9xh/PG1LUIBqUCqRBp1J3efi6ls83MH75OfUbQ4+4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=s8FUhNo4PBy8WenuU09LcYPIrTYBfSQ2EcRM+M9+fjRxHifeed+VMGl0O+oQTUjkJJxKJIPQlCzWW3+3YNDBfx5OptDMcPW4HlTwlW4XDueVaFL9ODXHDpimvBk3hwX4AhvtBXPt6I1ecZR7CbD50umwEzSL+7egnyOkhZ1y0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTN4dxpn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744297848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EXKgyYog58kyfqHQcoNTtvL08JiFX/6XLrBhO7Ve8ts=;
	b=KTN4dxpndtc7uw1Xg1FlmFSV/ktvhDpf2DIA4bzaoO/KR41oG+PQgVBhNkHlgCBDHNXZY9
	Bnv73xEEm+MUojQ+ww3yqEmqdfsa9xo/1aHiEP2zL3NyQsZuTh+jIYFw6q2C80OdKfI4n1
	doqubiTOdjGwAjSJCOnUCCo3X9xstiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-oyYSBwflPJ2Jjt-x04f9kA-1; Thu, 10 Apr 2025 11:10:47 -0400
X-MC-Unique: oyYSBwflPJ2Jjt-x04f9kA-1
X-Mimecast-MFC-AGG-ID: oyYSBwflPJ2Jjt-x04f9kA_1744297846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d5ca7c86aso6423385e9.0
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Apr 2025 08:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744297846; x=1744902646;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXKgyYog58kyfqHQcoNTtvL08JiFX/6XLrBhO7Ve8ts=;
        b=ALuAi9L7UcYq8KOyX8fOChsXK0NZg7mJ1BHFuN50ltT+yHtJJTylyb+qqElq5hatUQ
         qNOA4CcFmWl5AY2uF1L9VsB5qyFaEJVlhHrWT7HvG7Z5YBIgMJv+kIasw0+f0w1i6NJ0
         6c8Iwq4lZouVgS8rDM/JYRDKdm4LrvoRm/xhE1rOs+0LydKcoNPnxBNmSddFEWakVgke
         iDcgPFLZVIQxm6Y91MIsODXIccHevH9XLM25rix1OGSZq5w49Qwum2EtL3A36+szIY8t
         /DYiLhYSGcfmCBXXPCwLrEiz1DRFr9aDVrGc9+yCmmYDoLxQ8Cd1pF3E3mme/k3EIbfw
         vhEg==
X-Forwarded-Encrypted: i=1; AJvYcCXzOpd0/7bfRb0wckVfMBsy629owoGAZ069yVtBMpht+4aaHvBZY9GUnmHqyyq/qfToVn81nvfVCzgmnkBZfv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX0OLPd4wFkWSpVA3whTdpNIe1v7YdphLUkRfFqwkQ6n8m/BG4
	ROWY1MyQz2EeDS5eNvBOWGxKISVpI773qtYyep/PTWTjbANZ6coPVCZraXeucd01Jy3tIxdx5ve
	OB19j5I3lf7I0jCaoNWB5JwJLyLnU89fq6cWSYSJhqNPS/FZ1TIgezti7OgoL+lhPUA==
X-Gm-Gg: ASbGncu/7Zc0O3vfIem5wT+k1WxzI1VIxOuk88BEB7HyTCHIwrFQijw5fHVHXk1Yb0b
	IjYPvBLr8JgYrw5bWy06+jAX98eK1b0AoTU6TVjTKUcOuLBI/9qv+dHMjT9Y/bfipKFeJniMabT
	aAk+joJQ07BJiwR3PeZYUuQzTiJreMBZ9dfk9JhngjxI2AnCVt+KPHrBwxhZv5aHDfFPD3KIWTE
	hySU0Cn0/F9V81dC1qQj73XRmMAa6GS6azlhMtfCMY3wIDLN9XcLdFIsPpgOP8ifjDy4esPoQ1w
	yduNB195oqW3/IZllXM16pjzmNDJrWOeiusqilm5VcQjINDuBQeq6osBYaOJ
X-Received: by 2002:a05:600c:c19:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43f2d96d12bmr27394505e9.20.1744297846040;
        Thu, 10 Apr 2025 08:10:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxwdlqvMr0+eJqJHcy2sApkT2sXjxRivRro1I+Xe8jUjWmS3HlK9o9rH1isaEbTm3IHTMmxg==
X-Received: by 2002:a05:600c:c19:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-43f2d96d12bmr27394165e9.20.1744297845618;
        Thu, 10 Apr 2025 08:10:45 -0700 (PDT)
Received: from rh (p200300f6af1bce00e6fe5f11c0a7f4a1.dip0.t-ipconnect.de. [2003:f6:af1b:ce00:e6fe:5f11:c0a7:f4a1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39d8938a860sm5156906f8f.54.2025.04.10.08.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 08:10:45 -0700 (PDT)
Date: Thu, 10 Apr 2025 17:10:43 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
    Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
    Zenghui Yu <yuzenghui@huawei.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: arch_timer_edge_cases failures on ampere-one
Message-ID: <ac1de1d2-ef2b-d439-dc48-8615e121b07b@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII

Hey,

I'm seeing consistent failures for the arch_timer_edge_cases
selftest one ampere-one(x):
==== Test Assertion Failure ====
   arm64/arch_timer_edge_cases.c:170: timer_condition == istatus
   pid=6277 tid=6277 errno=4 - Interrupted system call
      1  0x0000000000403bcf: test_run at arch_timer_edge_cases.c:962
      2  0x0000000000401f1f: main at arch_timer_edge_cases.c:1083
      3  0x0000ffffa8b2625b: ?? ??:0
      4  0x0000ffffa8b2633b: ?? ??:0
      5  0x000000000040202f: _start at ??:?
   0x1 != 0x0 (timer_condition != istatus)

The (first) test that's failing is from test_timers_in_the_past():
     /* Set a timer to counter=0 (in the past) */
     test_timer_cval(timer, 0, wm, true, DEF_CNT);

If I understand this correctly then the timer condition is met, an
irq should be raised with the istatus bit from SYS_CNTV_CTL_EL0 set.

What the guest gets for SYS_CNTV_CTL_EL0 is 1 (only the enable bit
set). KVM also reads 1 in timer_save_state() via
read_sysreg_el0(SYS_CNTV_CTL). Is this a HW/FW issue?

These machines have FEAT_ECV (as a test I disabled that in the kernel
but with the same result).

As a hack I set ARCH_TIMER_CTRL_IT_STAT in timer_save_state() when
the timer condition is met and set up traps for the register - this
lets the testcase succeed.

All with the current upstream kernel - but this is not new, I saw
this a couple of months ago but lost access to the machine before
I could debug..

Any hints what to do here?

Sebastian


