Return-Path: <linux-kselftest+bounces-35085-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10567ADB460
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 16:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A63D7166D7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jun 2025 14:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE7E1F8676;
	Mon, 16 Jun 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ViByxyLm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9325E1D90DD;
	Mon, 16 Jun 2025 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750085419; cv=none; b=Dk9uB3lsoVuvQfxQTu4lMgqrg68gS4fhSuT2ixhLsew2PAhhfjQURJzqWkkFYtVB7oAPyObqE/ZUDCadHDsUdngYmEOoKIvvbMg5dqoKLwQiHPW7a9sH6rvcqgbQqhBtVPifCZPsQnzKv2IcL27xBPSsSJ0rovN2v2oJBhRvSyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750085419; c=relaxed/simple;
	bh=CJbgTCTx8qarV17MPocFFxuPdcwMpLk3HX0Ll4s7Os8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QsEWpympwJ+ddN5T7k0uNJ1X7iAuFPlmuhDfcusJ3AmOC1HL1f4zPsPq+go7QxphzfwrndgJYGp1+j9EH2zFKQs0L/NFWD0yK9fw1PswWQ858dGBNkRsbx8A87hHTr91scDslH9ZMRSzOI6eujyO5sLfYEymN9S6lwChxXHm4rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ViByxyLm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3627EC4AF0B;
	Mon, 16 Jun 2025 14:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750085419;
	bh=CJbgTCTx8qarV17MPocFFxuPdcwMpLk3HX0Ll4s7Os8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ViByxyLm8vI8JkFEr2IkJH2wr/QHKmSez9OI7m1J42BqvP6fFcyeQkTYdGa/XM+7v
	 7+h34Fayfsqa8RWGCjGoFW8tXZb9byrVXB39gLB1oJFYbCGbeDcs8O7F/+RUuvMEKZ
	 yFkcLBBQAO037JtspQIqyIhEnGZiRU+f1nZPIbCRJkqJ3OPCSrhQnmpUIprm6HDaRs
	 /iobmUlkxpRXJBYgVMoBfWZqPcrz/K9M7QwXBLxwdaAKEKrMweSlkuiMRBfDfZ+4uY
	 /kR4oc2GJaBC6emS+JZp3vAeXDIEkm2JtoW+cvu0v9AkveLcWzE5ZTJxE5tjGo5VC2
	 DAkkRdmJx8xoQ==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-553b5165cf5so2905772e87.0;
        Mon, 16 Jun 2025 07:50:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/wcWFYyd+FCdYAqImpbEa6/Em/qqDIqcV0eeXcnGOVDyMUHA+P+6Yp2PR3XlXrwzXBgeIJc889HY=@vger.kernel.org, AJvYcCUMc04i/kPeCgw1BT7IZhsm11g28Jzeic2jDOlpwINNBaikw6aArOVHsE16g98HwyrOMyvEqyY/MYxYHZZB@vger.kernel.org, AJvYcCUrCfFz23GAmjR3hsAX6a5wZxt2uAemCprxr7pj3Zw3xhg5DgbxK/EaGCdeh3LdPdqblZOyN34EAX3d@vger.kernel.org, AJvYcCWVNoWdLzDO6l+QFC0lvRN6yfrEOnJ5MGGP2IoZd0hyBY807tZ9JBmU4GOAkmv82pvK4A2drg++DJg5PWwS@vger.kernel.org, AJvYcCWp7HL/vp7887alWGkNr5S4BNv59v+CXES9CYzC/WDQi7+5/f3jvY2YDBBpwrzjPUqG5d4WfXyUHvRfzanXp79u@vger.kernel.org
X-Gm-Message-State: AOJu0YyG1UXGxaFrhMRZRPjynxV1K1JNKKtYp+Y/H7irtpLAPRmPqfEe
	It8/ITlZjEB1bkQrkmWIsb3+zEykTokBehc3xyQzSoJucYUdTeMakcTEolPq5zWi1LuUFskMchg
	BCM3tc79Nm2Du4o6u+9RNNa6Qu5m9sJM=
X-Google-Smtp-Source: AGHT+IH4/5g9uzTm/KdVR9mD4Ksdt/b1gVZr6h0kIW5h/9MLI04ytE0/bOqcr7hXY+TIcHvDH+Pq4AOgGxSOJSvWxBs=
X-Received: by 2002:a05:6512:39ca:b0:549:8f10:ec25 with SMTP id
 2adb3069b0e04-553b6f1a0d6mr2694465e87.31.1750085417817; Mon, 16 Jun 2025
 07:50:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611-kunit-kselftests-v3-0-55e3d148cbc6@linutronix.de> <20250611-kunit-kselftests-v3-2-55e3d148cbc6@linutronix.de>
In-Reply-To: <20250611-kunit-kselftests-v3-2-55e3d148cbc6@linutronix.de>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 16 Jun 2025 23:49:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATuk_tpDAq07e5oSU4FptRO_88Oxh2=W=3YmBotbGuU5g@mail.gmail.com>
X-Gm-Features: AX0GCFudTxJzfYzvyir9-nqwoqXgGH13IYC-ZyKhFKJ-XhxgZlrofwO8PDGWIb8
Message-ID: <CAK7LNATuk_tpDAq07e5oSU4FptRO_88Oxh2=W=3YmBotbGuU5g@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] kbuild: userprogs: also inherit byte order and
 ABI from kernel
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Brendan Higgins <brendan.higgins@linux.dev>, David Gow <davidgow@google.com>, 
	Rae Moar <rmoar@google.com>, Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	workflows@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 4:38=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> Make sure the byte order and ABI of the userprogs matches the one of the
> kernel, similar to how the bit size is handled.
> Otherwise the userprogs may not be executable.
> This happens for example on powerpc little endian, or riscv32.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index c4293cf91e968ca8ee64452841fb266e24df63f6..b9aa1058321dabd3b3dd5610e=
45a2807dfa257f4 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1129,8 +1129,8 @@ ifneq ($(CONFIG_ARCH_VMLINUX_NEEDS_RELOCS),)
>  LDFLAGS_vmlinux        +=3D --emit-relocs --discard-none
>  endif
>
> -# Align the bit size of userspace programs with the kernel
> -USERFLAGS_FROM_KERNEL :=3D -m32 -m64 --target=3D%
> +# Align the bit size, byte order and architecture of userspace programs =
with the kernel
> +USERFLAGS_FROM_KERNEL :=3D -m32 -m64 -mlittle-endian -mbig-endian --targ=
et=3D% -march=3D% -mabi=3D%
>  KBUILD_USERCFLAGS  +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))
>  KBUILD_USERLDFLAGS +=3D $(filter $(USERFLAGS_FROM_KERNEL), $(KBUILD_CPPF=
LAGS) $(KBUILD_CFLAGS))


Why didn't you do like this?

USERFLAGS_FROM_KERNEL :=3D $(filter -m32 -m64 -mlittle-endian
-mbig-endian --target=3D% -march=3D% -mabi=3D%, $(KBUILD_CPPFLAGS)
$(KBUILD_CFLAGS))
KBUILD_USERCFLAGS  +=3D $(USERFLAGS_FROM_KERNEL)
KBUILD_USERLDFLAGS +=3D $(USERFLAGS_FROM_KERNEL)



--
Best Regards
Masahiro Yamada

