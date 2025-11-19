Return-Path: <linux-kselftest+bounces-45994-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0842BC6FC58
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20F524F6431
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01882E6CB2;
	Wed, 19 Nov 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uq6ah7Bb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672B2D6612;
	Wed, 19 Nov 2025 15:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763566938; cv=none; b=KtLJMfmQnRaBnDoUXycr6RAAn85yx6L1PUmnAdeO9w3QX+3HKhq+wxt+tko3Vfwfhdr9xkxS2+VPbBHXE1FRrY2LHxcYuTYwWK2HxLGy1EREUnV/fuiO6a2w5XNTgICzoxUZkn46F8RyjwRk4sGnCx9sHiGo/z/tWBHKc/7l6Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763566938; c=relaxed/simple;
	bh=ytrC31SzVFXSnjTf0qvd0BBEtuw54RVFHossnCqW1pQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BIuTkQhgopdOF30OWZoeco+H5PKbQo+oiji/NMtEndQdWrxOQ6QEJshOB4ylEU3QOwf/QAhpZ9gs0aDSr3tVMlriSxsGKquZYTVAzBtjUfWmAg4rb8F7/lcL53aTaVTtd6TMdJBUuLkTGaVGxu18bQzjdpfis5QnrnnvsSgUhsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uq6ah7Bb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4975C2BC86;
	Wed, 19 Nov 2025 15:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763566937;
	bh=ytrC31SzVFXSnjTf0qvd0BBEtuw54RVFHossnCqW1pQ=;
	h=Date:From:List-Id:To:cc:Subject:In-Reply-To:References:From;
	b=Uq6ah7BbsL8XTJVVvRb0IDaOFYwVVETuv23G/zI21sj6VxKv0YJtaoTm4xkLzT+JK
	 qjFtNQClKB7k/bsxYg2/s0WnT0Xw/IUGVv5KSfKO/Zv9mqGhv/qKcRdsOcUZ9qBJ7I
	 WZPUqEfYQp+1zgswQOSKGKbg4p2zxBEmW4AQpspD5ObiKYkYoxfbtdkjGQcsEYJ3Jd
	 US5VHWXpSp6nbFvS5VBM4AfYNhEyPPqwGYK95gSSkKGK3ukZXF4yTgRT4IixEKHbPa
	 qRMveG6I2pvHJd0KqcOyYGDBEPM/fF673TI4EO06uVW/6WN38ywOW0b+T08MGDztIc
	 Z/RKzOsFjkCPQ==
Date: Wed, 19 Nov 2025 08:42:09 -0700 (MST)
From: Paul Walmsley <pjw@kernel.org>
To: patchwork-bot+linux-riscv@kernel.org
cc: Xu Lu <luxu.kernel@bytedance.com>, linux-riscv@lists.infradead.org, 
    corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
    aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, 
    conor+dt@kernel.org, will@kernel.org, peterz@infradead.org, 
    boqun.feng@gmail.com, mark.rutland@arm.com, anup@brainfault.org, 
    atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org, 
    parri.andrea@gmail.com, ajones@ventanamicro.com, brs@rivosinc.com, 
    guoren@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
    devicetree@vger.kernel.org, kvm@vger.kernel.org, 
    kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
    apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
In-Reply-To: <176355541475.758643.7685467502830246491.git-patchwork-notify@kernel.org>
Message-ID: <b7dc669e-cc48-f163-0146-0ef37dbd19ec@kernel.org>
References: <20251020042056.30283-1-luxu.kernel@bytedance.com> <176355541475.758643.7685467502830246491.git-patchwork-notify@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Folks,

On Wed, 19 Nov 2025, patchwork-bot+linux-riscv@kernel.org wrote:

> This series was applied to riscv/linux.git (for-next)
> by Paul Walmsley <pjw@kernel.org>:

This actually isn't true; I've only applied the first four patches (see 
below).

> On Mon, 20 Oct 2025 12:20:46 +0800 you wrote:
> > This patch adds support for the Zalasr ISA extension, which supplies the
> > real load acquire/store release instructions.
> > 
> > The specification can be found here:
> > https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc
> > 
> > This patch seires has been tested with ltp on Qemu with Brensan's zalasr
> > support patch[1].
> > 
> > [...]
> 
> Here is the summary with links:
>   - [v4,01/10] riscv: Add ISA extension parsing for Zalasr
>     https://git.kernel.org/riscv/c/0597b9c8627e
>   - [v4,02/10] dt-bindings: riscv: Add Zalasr ISA extension description
>     https://git.kernel.org/riscv/c/6e2a0ff70abe
>   - [v4,03/10] riscv: hwprobe: Export Zalasr extension
>     https://git.kernel.org/riscv/c/d5e20628a882
>   - [v4,04/10] riscv: Introduce Zalasr instructions
>     https://git.kernel.org/riscv/c/c4139ea6717c
>   - [v4,05/10] riscv: Apply Zalasr to smp_load_acquire/smp_store_release
>     (no matching commit)
>   - [v4,06/10] riscv: Apply acquire/release semantics to arch_xchg/arch_cmpxchg operations
>     (no matching commit)
>   - [v4,07/10] riscv: Apply acquire/release semantics to arch_atomic operations
>     (no matching commit)
>   - [v4,08/10] riscv: Remove arch specific __atomic_acquire/release_fence
>     (no matching commit)
>   - [v4,09/10] RISC-V: KVM: Allow Zalasr extensions for Guest/VM
>     (no matching commit)
>   - [v4,10/10] RISC-V: KVM: selftests: Add Zalasr extensions to get-reg-list test
>     (no matching commit)

In terms of patches 5-8, we're still waiting for Xu Lu to update the 
patches based on Andrea's feedback.  Xu Lu, are you still planning to 
update these?


- Paul

