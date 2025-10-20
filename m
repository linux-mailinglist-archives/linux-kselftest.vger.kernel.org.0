Return-Path: <linux-kselftest+bounces-43552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC83BF19F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 15:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B9618A5805
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 13:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71122322A0A;
	Mon, 20 Oct 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ajn8vXuN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C249322523
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968026; cv=none; b=cQd+4vg7uxqz1LQqH4/7VfrWdXKJDIFNs040ekzmQN5irvrwIfqMKzV9Tg4bwoQQJvZH1dqZpNDaT/d9+yDXV7G2b1zXSszYps3mJVjq/xsXAaiYgJHInIAKi2+m18Ji9i5uTrrjxOFQgzqZiixhTIKVbvHgvgbEP7U0TD6waAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968026; c=relaxed/simple;
	bh=ANgSQSPVOIlXoVYbP+I9m5tJ0ZaaqeZGLzdTf42qYbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWAh81ciIZbUzFJQZnMZvfdEOAXC68HAlVB3JdwPV28DUCxYC977YhMPmBYd2PwBYAT3jur8sBRUvsH2B9B7ueyuzgGQDCBhFoBSW57qlUZTYdpetjocEVK1xhcJ3OHZCpfN/o2DHNlqo5R58ZAtQh0LV7qp+gG3dGEXCOV/lA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ajn8vXuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2719C19423
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760968026;
	bh=ANgSQSPVOIlXoVYbP+I9m5tJ0ZaaqeZGLzdTf42qYbc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Ajn8vXuNnKb1LAbPZxFi0K1SpVKYv6BEENBjvz46Sv9caDB7o+XlW10cYl3uLNOIb
	 DV1BMPpT9P2ROVtknynYnMUmuw5Yj98O/adWd41Q9N0z5pm5Yg04Zxb8o1YwEdNRWv
	 /hdbw1ywMjql2m+TwIB/dEWaAe2yJ8HI411QTh7e0dArZNoWSU89ftPtasueR2lic9
	 yKp2jtGn9yJNS8zZF49TO7B+NfQLEouWx04Xrnig/kWBHsxxrvc8hfCoS/74Mnci7a
	 pyrpMcPYhrwFib862EgEwt/zugtG1JtfSbo6ARZERY0E0vHdrPUzMtbIGgjJOamR7i
	 xYKl9K5W5qd0w==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4711f3c386eso19120465e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 06:47:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWrSh6QGwvB9fI26oaLdeB3wM6Eksks2r8AobTodDWzkowrz9iyfrJh1V7IXj3MIQf4Hp8NtSDE7+94KM/8Ba0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5YALGjmTpyRuO9OWCNzg0yS0P16PchrOdNymMwWmgDnmIibcX
	sKGUq3EekuZK2iXnww2GeYjaBGknmIAmRb/e+mmuewvC+Hz4stURUpqBWALjDhq9Kw9rhoA89h6
	Q1UWklcu0elZ565uWZ0zlcoJpE/yng2A=
X-Google-Smtp-Source: AGHT+IGpvHBGOazwRpML7L6p+OasmV1SnRg6q1qXry12cbpNN8zhS8TFOb5uYraKUxj/eNcIvfi0sxzsmTyVox3z8JY=
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id
 5b1f17b1804b1-471178785e1mr97856905e9.8.1760968024377; Mon, 20 Oct 2025
 06:47:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020042056.30283-1-luxu.kernel@bytedance.com> <20251020042056.30283-4-luxu.kernel@bytedance.com>
In-Reply-To: <20251020042056.30283-4-luxu.kernel@bytedance.com>
From: Guo Ren <guoren@kernel.org>
Date: Mon, 20 Oct 2025 21:46:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTREY07Eo0EgB9ew1sd6FkMtoFSTgyC5ny2SQKKd83xEtw@mail.gmail.com>
X-Gm-Features: AS18NWDSEQv09h9pIrv_Q1ibVOSy0wdkcUShHmZExEFgCajrR16Dgx95ctdgozI
Message-ID: <CAJF2gTREY07Eo0EgB9ew1sd6FkMtoFSTgyC5ny2SQKKd83xEtw@mail.gmail.com>
Subject: Re: [PATCH v4 03/10] riscv: hwprobe: Export Zalasr extension
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: corbet@lwn.net, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, will@kernel.org, peterz@infradead.org, 
	boqun.feng@gmail.com, mark.rutland@arm.com, anup@brainfault.org, 
	atish.patra@linux.dev, pbonzini@redhat.com, shuah@kernel.org, 
	parri.andrea@gmail.com, ajones@ventanamicro.com, brs@rivosinc.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
	apw@canonical.com, joe@perches.com, lukas.bulwahn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 20, 2025 at 12:21=E2=80=AFPM Xu Lu <luxu.kernel@bytedance.com> =
wrote:
>
> Export the Zalasr extension to userspace using hwprobe.
>
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
> ---
>  Documentation/arch/riscv/hwprobe.rst  | 5 ++++-
>  arch/riscv/include/uapi/asm/hwprobe.h | 1 +
>  arch/riscv/kernel/sys_hwprobe.c       | 1 +
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/arch/riscv/hwprobe.rst b/Documentation/arch/ri=
scv/hwprobe.rst
> index 2aa9be272d5de..067a3595fb9d5 100644
> --- a/Documentation/arch/riscv/hwprobe.rst
> +++ b/Documentation/arch/riscv/hwprobe.rst
> @@ -249,6 +249,9 @@ The following keys are defined:
>         defined in the in the RISC-V ISA manual starting from commit e874=
12e621f1
>         ("integrate Zaamo and Zalrsc text (#1304)").
>
> +  * :c:macro:`RISCV_HWPROBE_EXT_ZALASR`: The Zalasr extension is support=
ed as
> +       frozen at commit 194f0094 ("Version 0.9 for freeze") of riscv-zal=
asr.
"Frozen Version 0.9" might not be proper; it denotes the current
temporary state, not the goal of the patch.

> +
>    * :c:macro:`RISCV_HWPROBE_EXT_ZALRSC`: The Zalrsc extension is support=
ed as
>         defined in the in the RISC-V ISA manual starting from commit e874=
12e621f1
>         ("integrate Zaamo and Zalrsc text (#1304)").
> @@ -360,4 +363,4 @@ The following keys are defined:
>
>      * :c:macro:`RISCV_HWPROBE_VENDOR_EXT_XSFVFWMACCQQQ`: The Xsfvfwmaccq=
qq
>          vendor extension is supported in version 1.0 of Matrix Multiply =
Accumulate
> -       Instruction Extensions Specification.
> \ No newline at end of file
> +       Instruction Extensions Specification.
> diff --git a/arch/riscv/include/uapi/asm/hwprobe.h b/arch/riscv/include/u=
api/asm/hwprobe.h
> index aaf6ad9704993..d3a65f8ff7da4 100644
> --- a/arch/riscv/include/uapi/asm/hwprobe.h
> +++ b/arch/riscv/include/uapi/asm/hwprobe.h
> @@ -82,6 +82,7 @@ struct riscv_hwprobe {
>  #define                RISCV_HWPROBE_EXT_ZAAMO         (1ULL << 56)
>  #define                RISCV_HWPROBE_EXT_ZALRSC        (1ULL << 57)
>  #define                RISCV_HWPROBE_EXT_ZABHA         (1ULL << 58)
> +#define                RISCV_HWPROBE_EXT_ZALASR        (1ULL << 59)
>  #define RISCV_HWPROBE_KEY_CPUPERF_0    5
>  #define                RISCV_HWPROBE_MISALIGNED_UNKNOWN        (0 << 0)
>  #define                RISCV_HWPROBE_MISALIGNED_EMULATED       (1 << 0)
> diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwpr=
obe.c
> index 0b170e18a2beb..0529e692b1173 100644
> --- a/arch/riscv/kernel/sys_hwprobe.c
> +++ b/arch/riscv/kernel/sys_hwprobe.c
> @@ -99,6 +99,7 @@ static void hwprobe_isa_ext0(struct riscv_hwprobe *pair=
,
>                 EXT_KEY(ZAAMO);
>                 EXT_KEY(ZABHA);
>                 EXT_KEY(ZACAS);
> +               EXT_KEY(ZALASR);
>                 EXT_KEY(ZALRSC);
>                 EXT_KEY(ZAWRS);
>                 EXT_KEY(ZBA);
> --
> 2.20.1
>


--=20
Best Regards
 Guo Ren

