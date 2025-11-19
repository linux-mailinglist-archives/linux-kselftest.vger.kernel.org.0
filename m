Return-Path: <linux-kselftest+bounces-45999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC56EC6FFC4
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 17:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 01D183A8E42
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F6135C1B1;
	Wed, 19 Nov 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UqQV/M0K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from sg-1-100.ptr.blmpb.com (sg-1-100.ptr.blmpb.com [118.26.132.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F2927280E
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 15:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567983; cv=none; b=TSBhjSHYyQao8VHFzic4JCYbzt6rxPiFZMZ1j3MbPhvrE+HLBWy3vYU/16UTeevZwscr6rIWsWCKqC/kMxbVohYfK9pbNxv1Ul4fMzz+sCaQ0IWVEuRr/h1Ulz62CnHusD+BWzBL/A7HkU4AdtNpPsnK/OzJ/JJROd8nJN3puGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567983; c=relaxed/simple;
	bh=mQ45HxHEz7bEk0U1Kg7KEiKQ1cBt2yG8qBc7T+EeuPs=;
	h=Message-Id:To:Subject:References:Content-Type:Date:Cc:From:
	 Mime-Version:In-Reply-To; b=tHXNdaPtC7fgKFqOlVQYfUFbpCbj8ohQyQP5ZQebnEJo6VtWkLTWf/qwxjq1j24IvjEm6b38MdzQHxe2eUHgxGMl1m4pIWWNY8iVkTEnqGYyzWR4lbp99VMZ2P+HWUduI905WfExDMzwQ2z7rZkGWjfw7hmSvIm3mM0AOKVhW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UqQV/M0K; arc=none smtp.client-ip=118.26.132.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763567861; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mQ45HxHEz7bEk0U1Kg7KEiKQ1cBt2yG8qBc7T+EeuPs=;
 b=UqQV/M0KVnqVIbes+T1VV5SYDQBUho8kznxbAiYsToK+jUa4il3/H/XbholIfk2vhMtJjp
 qBcw52taj1iZnwQoxlvwy6vQyl96TiF5DLpAY/hnB8OKpiyrxr3bxooNrdZddhA7V4FTh5
 cModvja+7QNJsvuYxDrSOrVjKQI+lSnHCBf4TMYmvtLXrpNTTgkaB6Xadywgbtlfw2YI4R
 1HMOwLrt30weNo9TEwQpsV6nTf4bz4Zbwq3Jq/+Ttc+NwLbHFhn89RC5I13WCOSG9aNnOl
 yfod9OGzB8lb4c9K7hvmAD7rJwuVYmdbbk2hWYvfNJf/0OF4eMx4QOpG4cabOQ==
Message-Id: <b0b0f9d727b334fa569c726fc13490dd51d4fe42.7caea664.2799.41de.8705.9603c8f00a51@bytedance.com>
To: "Paul Walmsley" <pjw@kernel.org>
Subject: Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension support
References: <20251020042056.30283-1-luxu.kernel@bytedance.com> <176355541475.758643.7685467502830246491.git-patchwork-notify@kernel.org>
	<b7dc669e-cc48-f163-0146-0ef37dbd19ec@kernel.org>
X-Lms-Return-Path: <lba+1691de8f3+3eb7e6+vger.kernel.org+luxu.kernel@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Nov 2025 23:57:38 +0800
Cc: <patchwork-bot+linux-riscv@kernel.org>, 
	<linux-riscv@lists.infradead.org>, <corbet@lwn.net>, 
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, 
	<aou@eecs.berkeley.edu>, <alex@ghiti.fr>, <robh@kernel.org>, 
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <will@kernel.org>, 
	<peterz@infradead.org>, <boqun.feng@gmail.com>, <mark.rutland@arm.com>, 
	<anup@brainfault.org>, <atish.patra@linux.dev>, <pbonzini@redhat.com>, 
	<shuah@kernel.org>, <parri.andrea@gmail.com>, <ajones@ventanamicro.com>, 
	<brs@rivosinc.com>, <guoren@kernel.org>, <linux-doc@vger.kernel.org>, 
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>, 
	<kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>, 
	<linux-kselftest@vger.kernel.org>, <apw@canonical.com>, 
	<joe@perches.com>, <lukas.bulwahn@gmail.com>
From: =?utf-8?q?=E8=B7=AF=E6=97=AD?= <luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <b7dc669e-cc48-f163-0146-0ef37dbd19ec@kernel.org>
Content-Transfer-Encoding: quoted-printable

Hi Paul,

I will continue with this work. And thanks for Andrea's feedback.

Best Regards,
Xu Lu

> From: "Paul Walmsley"<pjw@kernel.org>
> Date:=C2=A0 Wed, Nov 19, 2025, 23:42
> Subject:=C2=A0 Re: [PATCH v4 00/10] riscv: Add Zalasr ISA extension suppo=
rt
> To: <patchwork-bot+linux-riscv@kernel.org>
> Cc: "Xu Lu"<luxu.kernel@bytedance.com>, <linux-riscv@lists.infradead.org>=
, <corbet@lwn.net>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>, <aou@=
eecs.berkeley.edu>, <alex@ghiti.fr>, <robh@kernel.org>, <krzk+dt@kernel.org=
>, <conor+dt@kernel.org>, <will@kernel.org>, <peterz@infradead.org>, <boqun=
.feng@gmail.com>, <mark.rutland@arm.com>, <anup@brainfault.org>, <atish.pat=
ra@linux.dev>, <pbonzini@redhat.com>, <shuah@kernel.org>, <parri.andrea@gma=
il.com>, <ajones@ventanamicro.com>, <brs@rivosinc.com>, <guoren@kernel.org>=
, <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <devicetree@=
vger.kernel.org>, <kvm@vger.kernel.org>, <kvm-riscv@lists.infradead.org>, <=
linux-kselftest@vger.kernel.org>, <apw@canonical.com>, <joe@perches.com>, <=
lukas.bulwahn@gmail.com>
> Folks,

>=C2=A0
> On Wed, 19 Nov 2025, patchwork-bot+linux-riscv@kernel.org wrote:

>=C2=A0
> > This series was applied to riscv/linux.git (for-next)

> > by Paul Walmsley <pjw@kernel.org>:

>=C2=A0
> This actually isn't true; I've only applied the first four patches (see=
=C2=A0

> below).

>=C2=A0
> > On Mon, 20 Oct 2025 12:20:46 +0800 you wrote:

> > > This patch adds support for the Zalasr ISA extension, which supplies =
the

> > > real load acquire/store release instructions.

> > >=C2=A0

> > > The specification can be found here:

> > > https://github.com/riscv/riscv-zalasr/blob/main/chapter2.adoc

> > >=C2=A0

> > > This patch seires has been tested with ltp on Qemu with Brensan's zal=
asr

> > > support patch[1].

> > >=C2=A0

> > > [...]

> >=C2=A0

> > Here is the summary with links:

> > =C2=A0 - [v4,01/10] riscv: Add ISA extension parsing for Zalasr

> > =C2=A0 =C2=A0 https://git.kernel.org/riscv/c/0597b9c8627e

> > =C2=A0 - [v4,02/10] dt-bindings: riscv: Add Zalasr ISA extension descri=
ption

> > =C2=A0 =C2=A0 https://git.kernel.org/riscv/c/6e2a0ff70abe

> > =C2=A0 - [v4,03/10] riscv: hwprobe: Export Zalasr extension

> > =C2=A0 =C2=A0 https://git.kernel.org/riscv/c/d5e20628a882

> > =C2=A0 - [v4,04/10] riscv: Introduce Zalasr instructions

> > =C2=A0 =C2=A0 https://git.kernel.org/riscv/c/c4139ea6717c

> > =C2=A0 - [v4,05/10] riscv: Apply Zalasr to smp_load_acquire/smp_store_r=
elease

> > =C2=A0 =C2=A0 (no matching commit)

> > =C2=A0 - [v4,06/10] riscv: Apply acquire/release semantics to arch_xchg=
/arch_cmpxchg operations

> > =C2=A0 =C2=A0 (no matching commit)

> > =C2=A0 - [v4,07/10] riscv: Apply acquire/release semantics to arch_atom=
ic operations

> > =C2=A0 =C2=A0 (no matching commit)

> > =C2=A0 - [v4,08/10] riscv: Remove arch specific __atomic_acquire/releas=
e_fence

> > =C2=A0 =C2=A0 (no matching commit)

> > =C2=A0 - [v4,09/10] RISC-V: KVM: Allow Zalasr extensions for Guest/VM

> > =C2=A0 =C2=A0 (no matching commit)

> > =C2=A0 - [v4,10/10] RISC-V: KVM: selftests: Add Zalasr extensions to ge=
t-reg-list test

> > =C2=A0 =C2=A0 (no matching commit)

>=C2=A0
> In terms of patches 5-8, we're still waiting for Xu Lu to update the=C2=
=A0

> patches based on Andrea's feedback. =C2=A0Xu Lu, are you still planning t=
o=C2=A0

> update these?

>=C2=A0
>=C2=A0
> - Paul
>=C2=A0

