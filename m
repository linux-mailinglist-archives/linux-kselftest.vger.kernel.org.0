Return-Path: <linux-kselftest+bounces-43531-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FEABEF4DD
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 06:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1392349291
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 04:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805E22BEFFD;
	Mon, 20 Oct 2025 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NfAyEKYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDCB286D60
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760934884; cv=none; b=AHADC1xqcWgJuPVAK0X0rhZnyPnKTvzf1tjdQ+7m0W+BVKfgd5l3IKp5sXBReP9/qJKDiDf6IfESvx15jfpUFdRi1s6GShue9bP9CyGEb5U6bF/QPumSl2HKw2bxFL5qWLcFTN73cWNkw4Zcitc99ERUm7uho87eVSbSfWl1Bb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760934884; c=relaxed/simple;
	bh=7ewcKsl4gSix4JTKxm4T8FGk4nC5GRnthKInzNEJlTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aZ+fNXYrZWFSkn6rIzrOq1VWvMCq0ASlU0Y8C7AFB04uPDN4EQQsvopjk3jZvtIUPluK2hXmH8I5Ppd0DEuFLldnHVr0bgg9lLoniZYX+b5dL4/zqmymulbX5szZykHEQyEA7CBe3N6mHPGw7rD/820lBN1hQZFvCS+KOYoFtUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NfAyEKYW; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-33bb090aa78so3262692a91.3
        for <linux-kselftest@vger.kernel.org>; Sun, 19 Oct 2025 21:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760934881; x=1761539681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+onDgxMPyKLOY40mbxy0dXul6lSc7HSME7/BE/rGWAw=;
        b=NfAyEKYWo82OpAZIbTWLx75EMDh5FhuZBaTsW0RAyNMPjXQ+sr+CBlaTAFBZLagSh6
         vggU/q6Zei07093xZj/SDfED2I8Tso9wzBBJC1Z9JgcVtGalglXcY5k0XXgwdnD2ZhM3
         ya6owBHGnr27ZLYfm7peX6Kf78k7CteKOUXKXu+LWz3FNyJw7BTgHi8JiWIJWyDGWKn4
         tnYQL0mAAu7SzBTmUsCIh/C/8SkNM2SQAtpAC7DqJTduRGsNeaC9oIZr3uXpEleK7j4b
         /PAr0/cmDG+Hjl+0Voi0YXcnBdef/n3RKjzje5V1XhCO8E7XaOJOt95ClaTGmFr3f8MC
         s5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760934881; x=1761539681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+onDgxMPyKLOY40mbxy0dXul6lSc7HSME7/BE/rGWAw=;
        b=bzq8sc4XErpyQUcr+kiw3flwnTkULyv77drD9+lxLn8xg/pUFbardxbHF8/lCUi7P5
         i0oPlWVU+XOP2a2F9c/Qvq/FjCAlJyo/4lpRBFBVA9+2cwJkRDLxcsihm5TwbP06lb/M
         W9mUeIiOW5cc7zYnz2RoQ6H05PF5Ck7e1r+CS+fAPIt2V7TIojxlGOjF5kfkHD0pBWuE
         V9Zl3/xlw9uCt788NmAduqLndypZr3cQStr03B8ghzBRWTopoWjsvKZgq1Pe2kEyJQgF
         OT0AznLIIoxNzFkiwLMBFw02JYUOciX3+Fd5Jp6pedgRRDKs5z/oUbi10ekpZ7xCOxU6
         DCkw==
X-Forwarded-Encrypted: i=1; AJvYcCUjzVEJWeYbULQBpg1tcLAkgXXYpdgM/MCarT28sF4CJSd8FTCOb2XqYToSGrQ0eyse4fUXL5sugWhb/QYw6Ok=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXzhrvcp6k9oCXGoyF6Ac7SwVTbLuvhoY35avlnaECV5IYzfKj
	W/LD0eADb+OOMeLLQFBR80LdElpM5D0gr1eI1h4BGhgwIvjYfT3lRcF5JZ/DwExLNQuDFocUXbv
	4TfjoSWtVrs2auG5dkiT/LDvwNElRRKx6kXA2rVuMvQ==
X-Gm-Gg: ASbGncsBKKFcOgD1olv0oO3r3X8TTOceJ/g5gs8m4lDh8UWeuiYyleOUgu8UXqgqibh
	JNbw/5mC0+N+XMMihgwKgl1E3Rc+zO5MixdyeuOGwQ76JtECrRzlLIHabBrrIKJtvS+c55+MC7m
	BLCDJUhsSOSv3ZPbhz8sUDzBw40DNNYtmQGhOcWjiliXc1ybUGMnAhWykU4WosJ3mkuBH6+Za9P
	kppd0Oh0q91ml+WNFveZfJvjcUPvF8IAAfTuIZyzdnuzWM4OjSYG2FhRMjzBjkEtZUevOrqvDk3
	tb+niNoYRCvfhcc+6ZQ=
X-Google-Smtp-Source: AGHT+IH9a1FKrBN3wWlaNuwKbnc7SmqwwgKUv1BbHl2nQXJtIw5nLWAzBwdqnbFCmBJfMi6jc127yHWzB+hEpQgkJLs=
X-Received: by 2002:a17:90b:3510:b0:32c:2cd:4d67 with SMTP id
 98e67ed59e1d1-33bcf892b26mr17239614a91.13.1760934880715; Sun, 19 Oct 2025
 21:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020042056.30283-1-luxu.kernel@bytedance.com>
In-Reply-To: <20251020042056.30283-1-luxu.kernel@bytedance.com>
From: Xu Lu <luxu.kernel@bytedance.com>
Date: Mon, 20 Oct 2025 12:34:29 +0800
X-Gm-Features: AS18NWCAyFau_n9LGvHEY6sx4LEsfPQSzxZhTugNhp11gJ7ivOgOscG6Z4MCNx8
Message-ID: <CAPYmKFs5ATB26ZWtP3vyT=zhJHrafgvBAm6GUw27AM7h5vE9Kw@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
To: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, will@kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, anup@brainfault.org, 
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org, 
	parri.andrea@gmail.com, ajones@ventanamicro.com, brs@rivosinc.com, 
	guoren@kernel.org
Cc: linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This series was automatically blocked by Gmail due to too many
recipients, so I resent it twice, causing the emails to appear
discontinuous. I apologize for any inconvenience this may have caused
to the reviewer.

Best regards,
Xu Lu

On Mon, Oct 20, 2025 at 12:21=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
>
> This patch adds support for the Zalasr ISA extension, which supplies the
> real load acquire/store release instructions.
>
> The specification can be found here:
> https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
>
> This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> support patch[1].
>
> Some false positive spacing error happens during patch checking. Thus I
> CCed maintainers of checkpatch.pl as well.
>
> [1] https://lore.kernel.org/all/CAGPSXwJEdtqW=3Dnx71oufZp64nK6tK=3D0rytVE=
cz4F-gfvCOXk2w@mail.gmail.com/
>
> v4:
>  - Apply acquire/release semantics to arch_atomic operations. Thanks
>  to Andrea.
>
> v3:
>  - Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
>  so as to ensure FENCE.TSO ordering between operations which precede the
>  UNLOCK+LOCK sequence and operations which follow the sequence. Thanks
>  to Andrea.
>  - Support hwprobe of Zalasr.
>  - Allow Zalasr extensions for Guest/VM.
>
> v2:
>  - Adjust the order of Zalasr and Zalrsc in dt-bindings. Thanks to
>  Conor.
>
> Xu Lu (10):
>   riscv: Add ISA extension parsing for Zalasr
>   dt-bindings: riscv: Add Zalasr ISA extension description
>   riscv: hwprobe: Export Zalasr extension
>   riscv: Introduce Zalasr instructions
>   riscv: Apply Zalasr to smp_load_acquire/smp_store_release
>   riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg
>     operations
>   riscv: Apply acquire/release semantics to arch_atomic operations
>   riscv: Remove arch specific __atomic_acquire/release_fence
>   RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>   RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
>
>  Documentation/arch/riscv/hwprobe.rst          |   5 +-
>  .../devicetree/bindings/riscv/extensions.yaml |   5 +
>  arch/riscv/include/asm/atomic.h               |  70 ++++++++-
>  arch/riscv/include/asm/barrier.h              |  91 +++++++++--
>  arch/riscv/include/asm/cmpxchg.h              | 144 +++++++++---------
>  arch/riscv/include/asm/fence.h                |   4 -
>  arch/riscv/include/asm/hwcap.h                |   1 +
>  arch/riscv/include/asm/insn-def.h             |  79 ++++++++++
>  arch/riscv/include/uapi/asm/hwprobe.h         |   1 +
>  arch/riscv/include/uapi/asm/kvm.h             |   1 +
>  arch/riscv/kernel/cpufeature.c                |   1 +
>  arch/riscv/kernel/sys_hwprobe.c               |   1 +
>  arch/riscv/kvm/vcpu_onereg.c                  |   2 +
>  .../selftests/kvm/riscv/get-reg-list.c        |   4 +
>  14 files changed, 314 insertions(+), 95 deletions(-)
>
> --
> 2.20.1
>

