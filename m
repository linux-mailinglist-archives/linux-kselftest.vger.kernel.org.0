Return-Path: <linux-kselftest+bounces-38918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1DB25808
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 02:05:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C686A724E2B
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Aug 2025 00:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEE223B0;
	Thu, 14 Aug 2025 00:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJl8b8S"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066C10FD;
	Thu, 14 Aug 2025 00:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755129892; cv=none; b=CNfbugXRHxqw5G5Fa7pcZZJMv/yXnQwmeN6NPYM42IbfhzSBFPJ3oSLPYQbY5nHHta3CKfakXdPnKlipHPaCvNr39WoAdhLNxbnwLdPpA65MTpl7IdVnebrtRXEClf8IDgkntAOfqbdcGWmdtPXOZ+ky9bwgPWTjfuYkhMB0llI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755129892; c=relaxed/simple;
	bh=eyiOaRZMaPlo1kIticKUpdzJroUfNMG5EOtHUB+peAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7wc7cj5n03xcH87ou4Fsa0J6z8SGtoTSNAUPc2pNZA3C0RdQjMTnWGycrI9lsKpptyOneEmYF/aEiqRRcsTgm6DUJBuaga9YM5kn1Ntl4cSommeNoA4BE7Jcpgrg4vTOTRkUBvcN5YLrwP1v/zvhhq3+onNwqSt0tXQ/4Bwkeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJl8b8S; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-323266baa22so379948a91.0;
        Wed, 13 Aug 2025 17:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755129890; x=1755734690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oc4qoI/UHlG9m/Oy8Ch7qVFS2LZ/r4kxmzgqxzma2fk=;
        b=XbJl8b8ScHbOAWjaXuwjeAnpcGvkBNkE+zwdY7bwK2HTfBWcjIx6Q0cN/1/nXgZy0C
         HgGK1ZbweDGBInCeGxw5HeWxDha+Bzk/3abliacI/Q7dQhJzz1VsOipqwq9p7oOau1VS
         hyBfyElCwfbfghVawtg/1eIOTNYDB4oJOxy8Yi2HMiE9PurhE+To+HclojdiURyhD4CN
         s3X01p8gFFzpAZeR/oQaVAZoUo7yVMSVFD6AuWsEZSCZuyMKu3cxcUDAysyIyCc6eLuz
         +g/FBsw1Ev0QYsrLHMLmhIzDxiVmR+CO+mL4wSgt2kzEjl333ldPVpLHgb+7Hu8uDlzS
         sKPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755129890; x=1755734690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oc4qoI/UHlG9m/Oy8Ch7qVFS2LZ/r4kxmzgqxzma2fk=;
        b=UbJLe/+RRr3AhoJs/yIpyVPVIace5nFuQ2f+SzHYoZJK1Or14/1e1Yea1pChK717gY
         rCl1YPDvd9oRXlWk/xktOt7nKsvjD6tC8z+k3e6DddA0xilnuWnOZAI+zXvep6rGwWwi
         nIZ4/ktNnS0/xBgB7UZ16JSaWGnmMAwEzgY4UzfTTGXVNFU+1BdBH0qpky6zKqx4IUjV
         Cqw2Web79tqL6OtjsmdVfiV4YXAbYLE2GxpMc1/S9LZ4eFd1uIWIW7fosYxG/EMbFCgh
         a6k/M+WS//tfnYNttgHDdDTJNAyQowepdDO2g4Qkd2MSHdKVNQKecuMbHzw5/ursw1+L
         ud6w==
X-Forwarded-Encrypted: i=1; AJvYcCUgqDJ9yEyucMppJsn6xlrditGAXyC+Sd9JWibXcpCi2Q0YClwBcKhPnphl1fGmH1UN8Ufxygq4W0DxRBBx@vger.kernel.org, AJvYcCV/QbvOmo0NrNP1iJxwBEelPGt+hwy5qm0Xt3Va6O2qE4m119urbnsI5vwt7AUkP00dKlgJeq4Oz2UAZtN0rtWu@vger.kernel.org, AJvYcCWAkzy7CPxctJrYfRRPlh3ybjHedKZ2hqG9K3RO96SJg5iDtMg7OwvWPbjp31Y0Peo2Gk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRO8B31CJIXLhlbr4X3nV4b8iq5A31HS8bkexMaONkbDV3vnlD
	6++kqBm/pUEQqAhY+a2zeRedEmjpTABE/Shg0RYc4pVPoqojEEccGwVTkkaO+qmLXbfk2asDt/P
	9uP1aZAxOoQdH1w/qt2ehLbk0lTA3+wk=
X-Gm-Gg: ASbGncsh3ZrXgIAd29QXb9QwUce9w+AznuHagZHMbY8QCvMwpDl7M0mK1yl2/GfSHMp
	uJa+g02J0apKujKbf7b2jDEA5Gq7GK2VnMSic3HR8O5WjHDy49wmNP7xkef+neXpYhGgP5WTv2L
	+juTAEa7Iy8kZax2Y90UyEo+/1aT4kYYjjL8P9TKXNAOLF5Rsbh8reIxpyZni4MZgHuT/jDLZd7
	rKtPmR3BaOhfCF5If98CQrflcZn66pMwA==
X-Google-Smtp-Source: AGHT+IF9xS9zIPLVd9mdq7/JMQybGy8Xgz+q9bbofIy+73DmOLi0jPPcTP0oKWLA/uWg+rwJjrrYRhOjvk2YFE279pY=
X-Received: by 2002:a17:90a:dfcd:b0:311:d05c:936 with SMTP id
 98e67ed59e1d1-32327b30c22mr1878474a91.17.1755129889875; Wed, 13 Aug 2025
 17:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250807023430.4566-1-phoenix500526@163.com> <20250807023430.4566-3-phoenix500526@163.com>
In-Reply-To: <20250807023430.4566-3-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 17:04:35 -0700
X-Gm-Features: Ac12FXxJ2K6yApet6kDGXukuzPSe5D-s-BU63JZocGB_cjnyo8xhnOBFW7R8JPU
Message-ID: <CAEf4BzbQ00YtbSqRotMEN4eBJC7aYNy9fFRO-Q_=Z0uS6O06mg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 2/2] selftests/bpf: Add an usdt_o2 test case
 in selftests to cover SIB handling logic
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 7:35=E2=80=AFPM Jiawei Zhao <phoenix500526@163.com> =
wrote:
>
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - add usdt_o2 test case to cover SIB addressing usdt argument spec
>   handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  8 +++
>  .../selftests/bpf/prog_tests/usdt_o2.c        | 71 +++++++++++++++++++
>  .../selftests/bpf/progs/test_usdt_o2.c        | 37 ++++++++++
>  3 files changed, 116 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o2.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o2.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 910d8d6402ef..68cf6a9cf05f 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -759,6 +759,14 @@ TRUNNER_BPF_BUILD_RULE :=3D $$(error no BPF objects =
should be built)
>  TRUNNER_BPF_CFLAGS :=3D
>  $(eval $(call DEFINE_TEST_RUNNER,test_maps))
>
> +# Use -O2 optimization to generate SIB addressing usdt argument spec
> +# Only apply on x86 architecture where SIB addressing is relevant
> +ifeq ($(ARCH), x86)
> +$(OUTPUT)/usdt_o2.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/cpuv4/usdt_o2.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +$(OUTPUT)/no_alu32/usdt_o2.test.o: CFLAGS:=3D$(subst O0,O2,$(CFLAGS))
> +endif
> +

Have you considered using GCC's __attribute__((optimize("O2")))
attribute. It seems like Clang doesn't have support for something like
that, but we'll still have this covered in BPF CI for GCC-built
selftests. Then I'd just add this as another subtest to existing usdt
tests.

Can you please try that?

>  # Define test_verifier test runner.
>  # It is much simpler than test_maps/test_progs and sufficiently differen=
t from
>  # them (e.g., test.h is using completely pattern), that it's worth just
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o2.c b/tools/tes=
ting/selftests/bpf/prog_tests/usdt_o2.c
> new file mode 100644
> index 000000000000..f04b756b3640
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o2.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
> +#include <test_progs.h>
> +
> +#define _SDT_HAS_SEMAPHORES 1
> +#include "../sdt.h"
> +#include "test_usdt_o2.skel.h"
> +
> +int lets_test_this(int);
> +
> +#define test_value 0xFEDCBA9876543210ULL
> +#define SEC(name) __attribute__((section(name), used))
> +
> +
> +static volatile __u64 array[1] =3D {test_value};
> +unsigned short test_usdt1_semaphore SEC(".probes");
> +

Is semaphore essential to this test?

> +static __always_inline void trigger_func(void)
> +{
> +       /* Base address + offset + (index * scale) */
> +       if (test_usdt1_semaphore) {
> +               for (volatile int i =3D 0; i <=3D 0; i++)
> +                       STAP_PROBE1(test, usdt1, array[i]);
> +       }
> +}
> +

[...]

