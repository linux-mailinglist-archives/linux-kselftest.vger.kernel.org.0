Return-Path: <linux-kselftest+bounces-41927-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 189B3B8916B
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 12:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF293B63EAC
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 10:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158F3081D9;
	Fri, 19 Sep 2025 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="c6oNTMa7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B33081B5
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278393; cv=none; b=EBOngNUafSw1VqZMHFC3s8HSCqamILNZBIi2WBhhg4on4HfdOHG4cI9GT4Z8r95jck20F2q+Z9AZtR3egtCiBtWeZYhk3kPW9ugnE+1QUMdc9q1HQCxrme8fGEjBoC+68wiplMkmKN92UsXd8nBFqkJj5dzqI5nRzHu9vkrly7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278393; c=relaxed/simple;
	bh=AT/YpjLtpUPvpZleipGxe9OdCeLb7XHScW6r+4WRl9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eItilznH0nCfrH5h8/hIfLy0Sb3ogpGIeatjVQhxaz8QV7dkNjxezwuOJZgtHEanE1XSJzC5R7eHEg0s3LgPFpiFm1OqZYY+Zm5qFs5tg5xa3rUyzcg1NdR/LQ4+fMqummQBVGz5t5fzgfyBe4UfksNIJgLsrIgMbPzzZZbEeOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=c6oNTMa7; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-24458272c00so21532995ad.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 03:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758278386; x=1758883186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3BqEGx3LZCxTScwUy93GuzHnUr5KjzApGPt4JpjdTo=;
        b=c6oNTMa7uNZ8aC6o5i6D6mUYNcbrI851oNQhzkxcfCGNfn0Y7hbgAGYMKU1Wv1tXMr
         75hXfxLQsVLrVB3FUmw+MbNXsizgT/b2lMV+bTxXDmgEdXfl2+2x8HPhcWJ67/Zv0QlZ
         /1DPgGv+msJU4vH8IHCK8TW0p15LMIUheYUEOx3EPIULASBYaPiAsRqgWUKOBzLDD5PG
         45d/A84OLsyHNov151eZRvvgRwTQ3lvAvxgqzE/zggZuqgX13/zMm72DSzo1BTZAbJaw
         vMW0ysTzNDC7MZRDFOKig/7NBMqOkJevcDbi3EpUtqbOsWqAXSfXB2f+3qr/BsyRk1HP
         rrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758278386; x=1758883186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3BqEGx3LZCxTScwUy93GuzHnUr5KjzApGPt4JpjdTo=;
        b=H8YK6cg0KDBSvRyI+KQTs/L5tISZw0Krq+r7c2/m6fUhe7P7CjRCXskugNKcvkpP2e
         mzc1f4HptVUPL1u5vr7/527ESo42lSexnPFc4+rjHllA89Y8bOPgC/a/xAoZyoLkrNwx
         9kgw+yYyse6F1II8dRmYmOdlzOQ+ICWEiUcE7lpHXmyJ39L6U0/vX9mQlGtjk4prkmS6
         eztgYz8J/etALxrNhI82vlll1UZ21xwN7ngfi5oHVbf1LuVuQGW4afceokfVoaG7kAim
         GpF8phMO5lMw5DC/uvxs4gZtLPf/O2hs5v1oysRvQ+a9jeUq8w8ectyDvQ5K6+n8qyJd
         OBBA==
X-Forwarded-Encrypted: i=1; AJvYcCUcKxxfs/OE1XS+SiUCJt6dJKICoB+chtWhrC1Z2ugotoV2ky/8KZ2cMOj4eloctdoX9S9fv3lXj4oCAXEAvIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq3hxexQK1aQP8kznWGDseYqW4lnY4SXeiW2t4/db4Gn64eKof
	a+OxpY/jcrIV4DdNRqkqUtV4IJ5Qo4llnBcU+PY7R04NRy2/dEDNyDwAqB1iXxPmCl1p4/LtPFp
	SHBdI1c04I1kd/N9YrRg/IIxA4YBZ6NS+1eKEVpyAWg==
X-Gm-Gg: ASbGncvFTjcJ6FQsZ1KY851VjR68jcoQA/WHtByRvRHRIhadxYxFXH1rfuywvsOju88
	VHqB5Be3meEk2seD+/PDSPHyEiRjd39VShmLTZFJxMyozkbd/e1YFWH805dOnwCLDqi1VH3U3k0
	MpqVVzxuk6trhpjDEI3E6iiBphDO46oXpVIftkz8L14z2yNvAh09L3Fv+fVU5VbH14a2d5Im/Yf
	+P4JP6hNvx9+uy0uYKIZG6RKJQ7IiY+yoTodYdMBfnoclzDAegF
X-Google-Smtp-Source: AGHT+IFoPK5eT+xOT+EziB16hnH4PX429eEMbYRejgpp/eimys8JXrVtWPCBLHIY/eRkxEm3X+Q383XHbTelYiczFx8=
X-Received: by 2002:a17:902:c40d:b0:24c:da3b:7379 with SMTP id
 d9443c01a7336-269ba43eed1mr42965405ad.16.1758278386437; Fri, 19 Sep 2025
 03:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919073714.83063-1-luxu.kernel@bytedance.com> <aM0qlTNPiaQRY2Nv@andrea>
In-Reply-To: <aM0qlTNPiaQRY2Nv@andrea>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Fri, 19 Sep 2025 18:39:35 +0800
X-Gm-Features: AS18NWDKwjBG8PdT7j1X6Qe6RxslbaKRfRQ1ZSXXMo0po9lxX_klUvUN6-xGGek
Message-ID: <CAPYmKFsP+=S56Cj2XT0DjdvBT_SY84moM4LVeqxHTVWbtq4EVw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v3 0/8] riscv: Add Zalasr ISA extension support
To: Andrea Parri <parri.andrea@gmail.com>
Cc: corbet@lwn.net, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com, 
	mark.rutland@arm.com, ajones@ventanamicro.com, brs@rivosinc.com, 
	anup@brainfault.org, atish.patra@linux.dev, pbonzini@redhat.com, 
	shuah@kernel.org, devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, apw@canonical.com, joe@perches.com, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

On Fri, Sep 19, 2025 at 6:04=E2=80=AFPM Andrea Parri <parri.andrea@gmail.co=
m> wrote:
>
> On Fri, Sep 19, 2025 at 03:37:06PM +0800, Xu Lu wrote:
> > This patch adds support for the Zalasr ISA extension, which supplies th=
e
> > real load acquire/store release instructions.
> >
> > The specification can be found here:
> > https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> >
> > This patch seires has been tested with ltp on Qemu with Brensan's zalas=
r
> > support patch[1].
> >
> > Some false positive spacing error happens during patch checking. Thus I
> > CCed maintainers of checkpatch.pl as well.
> >
> > [1] https://lore.kernel.org/all/CAGPSXwJEdtqW=3Dnx71oufZp64nK6tK=3D0ryt=
VEcz4F-gfvCOXk2w@mail.gmail.com/
> >
> > v3:
> >  - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
> >  so as to ensure FENCE.TSO ordering between operations which precede th=
e
> >  UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
> >  to Andrea.
> >  - Support hwprobe of Zalasr.
> >  - Allow Zalasr extensions for Guest/VM.
> >
> > v2:
> >  - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
> >  Conor.
> >
> > Xu Lu (8):
> >   riscv: add ISA extension parsing for Zalasr
> >   dt-bindings: riscv: Add Zalasr ISA extension description
> >   riscv: hwprobe: Export Zalasr extension
> >   riscv: Introduce Zalasr instructions
> >   riscv: Use Zalasr for smp_load_acquire/smp_store_release
> >   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
> >     operations
> >   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
> >   KVM: riscv: selftests: Add Zalasr extensions to get-reg-list test
> >
> >  Documentation/arch/riscv/hwprobe.rst          |   5 +-
> >  .../devicetree/bindings/riscv/extensions.yaml |   5 +
> >  arch/riscv/include/asm/atomic.h               |   6 -
> >  arch/riscv/include/asm/barrier.h              |  91 ++++++++++--
> >  arch/riscv/include/asm/cmpxchg.h              | 136 ++++++++----------
> >  arch/riscv/include/asm/hwcap.h                |   1 +
> >  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
> >  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
> >  arch/riscv/include/uapi/asm/kvm.h             |   1 +
> >  arch/riscv/kernel/cpufeature.c                |   1 +
> >  arch/riscv/kernel/sys_hwprobe.c               |   1 +
> >  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
> >  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
> >  13 files changed, 242 insertions(+), 91 deletions(-)
>
> I wouldn't have rushed this submission while the discussion on v2 seems
> so much alive;  IAC, to add and link to that discussion, this version

Thanks. This version is sent out to show my solution to the FENCE.TSO
problem you pointed out before. I will continue to improve it. Look
forward to more suggestions from you.

> (not a review, just looking at this diff stat) is changing the fastpath
>
>   read_unlock()
>   read_lock()
>
> from something like
>
>   fence rw,w
>   amodadd.w
>   amoadd.w
>   fence r,rw
>
> to
>
>   fence rw,rw
>   amoadd.w
>   amoadd.w
>   fence rw,rw
>
> no matter Zalasr or !Zalasr.  Similarly for other atomic operations with
> release or acquire semantics.  I guess the change was not intentional?
> If it was intentional, it should be properly mentioned in the changelog.

Sorry about that. It is intended. The atomic operation before
__atomic_acquire_fence or operation after __atomic_release_fence can
be just a single ld or sd instruction instead of amocas or amoswap. In
such cases, when the store release operation becomes 'sd.rl', the
__atomic_acquire_fence via 'fence r, rw' can not ensure FENCE.TSO
anymore. Thus I replace it with 'fence rw, rw'.

I will make it a separate commit and provide more messages in the
changelog. Maybe alternative mechanism can be applied to accelerate
it.

Best Regards,
Xu Lu

>
>   Andrea

