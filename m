Return-Path: <linux-kselftest+bounces-37195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0174CB02E70
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 04:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D423B8779
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 02:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9C145323;
	Sun, 13 Jul 2025 02:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KEllP/8V"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA9C7FBA2
	for <linux-kselftest@vger.kernel.org>; Sun, 13 Jul 2025 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752374550; cv=none; b=ZRPMMIP7H6Nt9UVOamjG0HraaCGqGTWAgvuJoiUoFag2V/IUp1Oss2yIWxPA/Fod+E+UfWuoEWO2xllAN+tNQOPaZCg5B6FWkFo15XWNq5Fp5lORycQWlWi7eG9177aQXIZshK6VQsWOc3Y9qOpVSZCBX69qFrHKm2q2gOIE88Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752374550; c=relaxed/simple;
	bh=5bX1npMW4eRdsgUzazLqr3N4PDD7Cv9Oex66u7+0x44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6D2Me/ktHMeu2ogaZM4O8blPydZUHZ2VMfBq+5WVKamtOC5nlEW42jWemJfMGtZsWs/hurgY+xiuSUCsNtwfGmkxg9xcZ5lYiGMkCiI7uQJ5RHNA5saUYvjZcZVEIgVmg9YnRm6DbARzU0JQKMw5AuxoOlKmCnJSu6s1FXHrbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KEllP/8V; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-453663b7bf1so56815e9.0
        for <linux-kselftest@vger.kernel.org>; Sat, 12 Jul 2025 19:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752374546; x=1752979346; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=30Xr3GjHx9JM48k5qZe/WnzL0VPEvAcLel6Lrxu+plE=;
        b=KEllP/8VJ3NnCOiy3bfiB0NGEdfycr+UqBRPaebbwpKTu0hCLgJRThRzZkZOICrw0t
         b8Blg5h6PJ+Cu0qUntI6NciOx7PKcAbnG4WodzhNLR6pVJ7qi/JKV5KGQREf0wKJK/XQ
         iQg63lAyHMQg9TcRHuyODqljiP+n1mq0Kxzc0Ffa4ql4i6sx37NfRWNiQTa2PLOstfPr
         6KWMCVdboZnM9d7pm1qLd5YskMWzrIPESUMDmeZt/rPgs+tU9BSnMAOckRGchl4PLV7P
         UvLvVpPgOik9aB/pdhJIAZb4UG8bbUzDLDsUmfpf9oNs2vvT9RS9VGWY5llbmRKCDmZs
         +7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752374546; x=1752979346;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=30Xr3GjHx9JM48k5qZe/WnzL0VPEvAcLel6Lrxu+plE=;
        b=f6Zq4MPPFrj/4MUiWPgWOmHMrQ5H1YR8U5IV9+VxxKYVBmDtrYacDdtXks7UHJZLHm
         xcnEXSroGVEUD/HeWawKRfWEz0wRxTBEpN1RC9vS8RNMakU9C5bPeIx6guukYKkSDwgS
         sStJFAIGO9gQ5LBPTKVhs2aeMU2DJTyhCAzoOOz8UqmM/hDBGzR6U26JEf+p4uBMnBhf
         cCUGIwuSeU87yi5hnsoIQLlUwR6KBuOTKZIGdNxpehzADZuSRhapmZFIFo3O1o+Gg+NO
         Fhx8t70OTmA75DoqyRZzFYrH1KlbAYUD20s2NuEjy91PrPzcjTZiym8aToTjzeVTAkhu
         IpTA==
X-Forwarded-Encrypted: i=1; AJvYcCVLOH/GaPmwY+Z2ImHinLUd+pMH7k264mp5d9m/Zure3yhIYWtk1lfry42Xn9CMi2Oqw77ngKBF84RmD2hU5+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZTdoRr1twiqnkncfrQQxgIBtST+PoCCL8w0X0ToYds5T0ysOd
	oCgMKtjDg5ACH1hfmsIfOIbY0kU3Tov3RFs69dFgo34VB4wh6a4qAt6mQ4OXcgBurGfSji5Y6R/
	BszvNNEEInKnpkiBnbb7EvNz31GtNqLMOfPNQM0Ln
X-Gm-Gg: ASbGncvUnodcrTzYcRe14W+WpWE0viJrh+906LeUju66oaeOjaZKXzjSUHgqaHSSFsG
	YF6pkG83hU8r0UZ8Bm6inulwXeiG090Hs7RE6wH+n2/kplYkqS5uOO7qmwZ2BJxmotGY1/mOpAu
	1CAlDHkhpi1JjI+vA1iHTI6npPjGorDo+1suXsLeBZJz9VQYWzlDuFSvvLTaSMRHPXvG6I/7m0q
	zdwLqlwuZTPEo361y6giuf/30dIffLqF5oDX6xF
X-Google-Smtp-Source: AGHT+IEleF8ivksR26XpmTWXy3KCMqLtp7lcXHp94NqMETszAgAyRO8FnYgynO7hXWeiXu6R0Q4pDW3VdH8z0Y3FkYk=
X-Received: by 2002:a05:600c:5023:b0:453:79c3:91d6 with SMTP id
 5b1f17b1804b1-45604733553mr1556035e9.1.1752374546338; Sat, 12 Jul 2025
 19:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com> <20250604050902.3944054-4-jiaqiyan@google.com>
 <aHFpIpIfqVCQZVgG@linux.dev> <CACw3F51xRWr5LXz4-JhK+mjizY7D7Oa+GrJ-OZHktfPzFGKeiw@mail.gmail.com>
 <aHK7w4TTEm7a1mco@linux.dev>
In-Reply-To: <aHK7w4TTEm7a1mco@linux.dev>
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Sat, 12 Jul 2025 19:42:15 -0700
X-Gm-Features: Ac12FXxcNa4e9HwM2rPqBWqAlsG9UDRsiS6fK2kefjn5JOWhY0L8gHWyQHAnvJ0
Message-ID: <CACw3F50mTCB0h4GbdcERz4j=CcnwVCfA0Mc9OL-u0nJCJPEVnA@mail.gmail.com>
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

On Sat, Jul 12, 2025 at 12:47=E2=80=AFPM Oliver Upton <oliver.upton@linux.d=
ev> wrote:
>
> On Fri, Jul 11, 2025 at 04:58:57PM -0700, Jiaqi Yan wrote:
> > On Fri, Jul 11, 2025 at 12:42=E2=80=AFPM Oliver Upton <oliver.upton@lin=
ux.dev> wrote:
> > >
> > > On Wed, Jun 04, 2025 at 05:08:58AM +0000, Jiaqi Yan wrote:
> > > > From: Raghavendra Rao Ananta <rananta@google.com>
> > > >
> > > > When KVM returns to userspace for KVM_EXIT_ARM_SEA, the userspace i=
s
> > > > encouraged to inject the abort into the guest via KVM_SET_VCPU_EVEN=
TS.
> > > >
> > > > KVM_SET_VCPU_EVENTS currently only allows injecting external data a=
borts.
> > > > However, the synchronous external abort that caused KVM_EXIT_ARM_SE=
A
> > > > is possible to be an instruction abort. Userspace is already able t=
o
> > > > tell if an abort is due to data or instruction via kvm_run.arm_sea.=
esr,
> > > > by checking its Exception Class value.
> > > >
> > > > Extend the KVM_SET_VCPU_EVENTS ioctl to allow injecting instruction
> > > > abort into the guest.
> > > >
> > > > Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
> > > > Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> > >
> > > Hmm. Since we expose an ESR value to userspace I get the feeling that=
 we
> > > should allow the user to supply an ISS for the external abort, simila=
r
> > > to what we already do for SErrors.
> >
> > Oh, I will create something in v3, by extending kvm_vcpu_events to
> > something like:
> >
> > struct {
> >   __u8 serror_pending;
> >   __u8 serror_has_esr;
> >   __u8 ext_dabt_pending;
> >   __u8 ext_iabt_pending;
> >   __u8 ext_abt_has_esr;  // <=3D new
> >   /* Align it to 8 bytes */
> >   __u8 pad[3];
> >   union {
> >     __u64 serror_esr;
> >     __u64 ext_abt_esr;  // <=3D new
>
> This doesn't work. The ABI allows userspace to pend both an SError and
> SEA, so we can't use the same storage for the ESR.

You are right, the implementation (__kvm_arm_vcpu_set_events) indeed
continues to inject SError after injecting SEA.

Then we may have to extend the size of exception and meanwhile reduce
the size of reserved, because I believe we want to place ext_abt_esr
into kvm_vcpu_events.exception. Something like:
struct kvm_vcpu_events {
  struct {
    __u8 serror_pending;
    __u8 serror_has_esr;
    __u8 ext_dabt_pending;
    __u8 ext_iabt_pending;
    __u8 ext_abt_has_esr;
    __u8 pad[3];
    __u64 serror_esr;
    __u64 ext_abt_esr;  // <=3D +64 bits
  } exception;
  __u32 reserved[10];  // <=3D -64 bits
};

The offset to kvm_vcpu_events .reserved changes; I don' think
userspace will read/write reserved (so its offset is probably not very
important?), but theoretically this is an ABI break.

Another safer but not very readable way is to add at the end:
struct kvm_vcpu_events {
  struct {
    __u8 serror_pending;
    __u8 serror_has_esr;
    __u8 ext_dabt_pending;
    __u8 ext_iabt_pending;
    __u8 ext_abt_has_esr;
    __u8 pad[3];
    __u64 serror_esr;
  } exception;
  __u32 reserved[10];  // <=3D -64 bits
  __u64 ext_abt_esr;  // <=3D +64 bits
};

Any better suggestions?

>
> >   };
> > } exception;
> >
> > One question about the naming since we cannot change it once
> > committed. Taking the existing SError injection as example, although
> > the name in kvm_vcpu_events is serror_has_esr, it is essentially just
> > the ISS fields of the ESR (which is also written in virt/kvm/api.rst).
> > Why named after "esr" instead of "iss"? The only reason I can think of
> > is, KVM wants to leave the room to accept more fields than ISS from
> > userspace. Does this reason apply to external aborts? Asking in case
> > if "iss" is a better name in kvm_vcpu_events, maybe for external
> > aborts, we should use ext_abt_has_iss?
>
> We will probably need to include more ESR fields in the future, like
> ESR_ELx.ISS2. So let's just keep the existing naming if that's OK with
> you.

Ack to "esr", thanks Oliver!

>
> Thanks,
> Oliver

