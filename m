Return-Path: <linux-kselftest+bounces-37175-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7B3B02821
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 02:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B1C5C55FB
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 00:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B662367D0;
	Fri, 11 Jul 2025 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zthKH4Jx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E410237194
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278353; cv=none; b=sD6j6AfbAjH+hRWnj96/hjWHgtZe7rTgFx1OOs9S6Xr3YBQuLNdkoaZciO5rA4EdkjcjZ5lz8yEgw2PKWLR6IkS8fR5ovtJgD49LYtmvqLAjKnwZGghiY3hzfsJHJHqXNxvjlVtdVbYJWCBnHoxI8j72jlB2/vlc0cp4TqTJkOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278353; c=relaxed/simple;
	bh=TQJvcadu4ytpBW1WlcQqcacJL5F7BEX/XlwUQ3jSJG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dwcSRhM+nljodZ8TyoX4gSRP6rhm53g0tpcOqeUXUAIwHDVmbR/Gfbva2KGw4e62kcasmJzL2Xo/5PvSgGEsHX2OrRS8HZkCZqUmN40TxuoG+ilVnVu8wj+GYxSqMZCckZvrDueIxnyW098alsrH8xKhyDjwsaSKkkjcp1b1vWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zthKH4Jx; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-456007cfcd7so25995e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752278350; x=1752883150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0HSRL4HugeXUFVF2xbav3ajCDx1kDmGqq3aBhMDxm4=;
        b=zthKH4JxFu1xNe2htcv1NgFDGPKnovp7R70eC8ROmYf7QZ/JqFoVpuDz/L1ookuLpS
         MFECFKOapQqOx+xFJMDzxmtyzOB6yWo8uaImIvLrS/wrANXJLH2eo8t/zAJA02otAkGS
         Pv4X8O4bWAWOGaRZOaR7lGEP/IFZpko/qJ+svHsXCb79vDMvuxZAtFAWOb6mj+Ip3E4t
         wrKlyeMj5iXNDDBbWkmv9bqikfnLGVrzrDO6fB8lL4CLis87ZocRwwf+9HjzOrDWCCbP
         QHEnUp1acgULJ2KLoHREIxtbUCloIFrLBZMzH35pabb/l19qyDY9HfR5zEggfxwHnMAT
         pxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752278350; x=1752883150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G0HSRL4HugeXUFVF2xbav3ajCDx1kDmGqq3aBhMDxm4=;
        b=Ae8Rqw3TIfuq6B/XIX3h9rktyMFZqAbDdkepWN+z3wOb0KUx6U2PGmR6mbs1vd9TS9
         aWkhMc7FKIZI+b8PlkNzJOvZG+ezk4XslwvzUQNDWloTXDLqFHQKlRvsJypOPum+u8LO
         pUt23aZgRu9Al5iAelZQsvsJap6aAoCt+UWzyjOTYdohWuupzlW8kO1SHfMrndTnVazX
         cKoKt55Peyuh7JfpF3JTrvtiNOltmRaQPK4LIqSWj4l9Y7h7z+UrepQaUHo0BAwrKd2B
         gVVVLq5SJkqtT5yL+UnLaNhAuALidN4N0luEa0SWrA6u/A8JPQTcyDph/5jaqgMNvbI2
         t1QA==
X-Forwarded-Encrypted: i=1; AJvYcCULsogVuq42RYW2o4jgAEAud9KWOTCD1Sz4j6tqDZVOw89q+HZMbnAQAbT+UV9rYy2dS4pkoChxUMqpFLg1CK8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YysQsJUn/D8ztqGoWrZblsCeF7gFmmsRFPzO2eLGQzwxr+p2
	LrLOtmnwv19mdTJVNxyspM3pk32xryTd/tqZqSgzMf7Xwh1nHP/LhLbJXNv2h3dvMDwulrLUo8J
	80X1C9GrvPNDuIXw4W2gcXJW6h6tvy+7DYHWphWvP
X-Gm-Gg: ASbGnctftI6VTV/SynUlvwz0W2dCbH+ljsaWtxi34lFyJOuFD6TuJuCW1dlbLkNw2wo
	LmqJuJQxa/M3MNxoHgacJa2s3AbLBZPbjDM0rKWKJVLGOunFid/pknOTmBHipXHL2mQu3smbwzH
	mMSy3X01j/9n4p4B0n42qv4dWKIBiBtf/oak0FW5hTCdLwC8Su+FercbMLVHAu18S3BHHOu6CMI
	7yEPAVrMYrNrRnSl7w0KiUSVIqhQJdGnkhEQg==
X-Google-Smtp-Source: AGHT+IH0Yb8i1HbshEYkUfB7pKBzNAZY2a47ozdMS6Ea9eu6/2JNmyxFqwJwxTVebnT7h+QOEYO+783uFnTjwj1f5T4=
X-Received: by 2002:a05:600c:4302:b0:442:feea:622d with SMTP id
 5b1f17b1804b1-45604731777mr157355e9.1.1752278349565; Fri, 11 Jul 2025
 16:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-4-jiaqiyan@google.com>
 <aHFpIpIfqVCQZVgG@linux.dev>
In-Reply-To: <aHFpIpIfqVCQZVgG@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Fri, 11 Jul 2025 16:58:57 -0700
X-Gm-Features: Ac12FXws7N7R5NhC74hDyERmsam_JiCP8QqW0Zl8h8Z88cj84PQ3Wo91uK-jnvY
Message-ID: <CACw3F51xRWr5LXz4-JhK+mjizY7D7Oa+GrJ-OZHktfPzFGKeiw@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] KVM: arm64: Allow userspace to inject external
 instruction aborts
To: Oliver Upton <oliver.upton@linux.dev>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, 
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org, kvm@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, duenwen@google.com, rananta@google.com, 
	jthoughton@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 12:42=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Wed, Jun 04, 2025 at 05:08:58AM +0000, Jiaqi Yan wrote:
> > From: Raghavendra Rao Ananta <rananta@google.com>
> >
> > When KVM returns to userspace for KVM_EXIT_ARM_SEA, the userspace is
> > encouraged to inject the abort into the guest via KVM_SET_VCPU_EVENTS.
> >
> > KVM_SET_VCPU_EVENTS currently only allows injecting external data abort=
s.
> > However, the synchronous external abort that caused KVM_EXIT_ARM_SEA
> > is possible to be an instruction abort. Userspace is already able to
> > tell if an abort is due to data or instruction via kvm_run.arm_sea.esr,
> > by checking its Exception Class value.
> >
> > Extend the KVM_SET_VCPU_EVENTS ioctl to allow injecting instruction
> > abort into the guest.
> >
> > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
>
> Hmm. Since we expose an ESR value to userspace I get the feeling that we
> should allow the user to supply an ISS for the external abort, similar
> to what we already do for SErrors.

Oh, I will create something in v3, by extending kvm_vcpu_events to
something like:

struct {
  __u8 serror_pending;
  __u8 serror_has_esr;
  __u8 ext_dabt_pending;
  __u8 ext_iabt_pending;
  __u8 ext_abt_has_esr;  // <=3D new
  /* Align it to 8 bytes */
  __u8 pad[3];
  union {
    __u64 serror_esr;
    __u64 ext_abt_esr;  // <=3D new
  };
} exception;

One question about the naming since we cannot change it once
committed. Taking the existing SError injection as example, although
the name in kvm_vcpu_events is serror_has_esr, it is essentially just
the ISS fields of the ESR (which is also written in virt/kvm/api.rst).
Why named after "esr" instead of "iss"? The only reason I can think of
is, KVM wants to leave the room to accept more fields than ISS from
userspace. Does this reason apply to external aborts? Asking in case
if "iss" is a better name in kvm_vcpu_events, maybe for external
aborts, we should use ext_abt_has_iss?

>
> Thanks,
> Oliver

