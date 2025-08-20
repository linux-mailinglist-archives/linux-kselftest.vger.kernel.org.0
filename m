Return-Path: <linux-kselftest+bounces-39416-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB17B2E8A0
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 01:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E93B61896D7F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 23:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6862B2DE1E0;
	Wed, 20 Aug 2025 23:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeuwN5Bg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938F25BEF2;
	Wed, 20 Aug 2025 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755732304; cv=none; b=nVzYn/0VHWWzQrf/KvIzeZwE3E/Vy8MlYVLq4S5jss3v45nD8RijULPmIKgQALyEcJdhcuGWrTCfLNKfyTHAlOIJDS0LnGV50O7W/nGbLkvs5sp3/lykKJNX173ZbX+X81Ij/rS7aZic0ZX1iy6EppsRxDwAZ01Q9yrTXkBG+0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755732304; c=relaxed/simple;
	bh=T6jBLIwuU+Sm1yWDoEVDP9+isASsQtMol3txgwUWbl0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZygERG2cZAk59OzMzLBo/bye+roWK80jHYoD/f5ShknihOSKr3FouMQRddv1EmIt+aaGRJ/u5YOXfSaiai8T4CGrTWUAlhSS1Uq+57VXeRZh6QngUqUD/vr4lgUC/u4cAr2cRZAtEBGrovtsMVwL0JRXMdhaBfuoS0fJJ081caQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeuwN5Bg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32372c05c5dso437541a91.0;
        Wed, 20 Aug 2025 16:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755732302; x=1756337102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9YTJQjG9BTV0KcP0gNEv31gg/a89cvOygqSMFdGUr1g=;
        b=CeuwN5BgHRmS0iW0kcb9E4Nu5iolfr3iM7LoI7var4sikOsdtcRgW5reD3Ivvj3Cer
         hLtvTlICUubi/PH1L1UBUQyfhcKvZLL6A/TEMNoH+UfPjNhmL8ETMat0V/34GQ8LWOGh
         X2O7oMNmvIZ2jYFpM4Ms/batQR3wrmO/AhmvTHFiZD3P5P+ZEwR3lf1bO+tEa291fjcp
         y6krO16q14H6+0npLcEJ1bCeUCkDcmb5iej64MCqxW6p0mkg1jOY+HoyyGvFMNwsOTtZ
         z1WoaCgQUGyA09+I0IlKMYi5tsP39bPP0rP+9qulSg7TfMUH9wR4W3PPyosUiNL0Ur6A
         3bkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755732302; x=1756337102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YTJQjG9BTV0KcP0gNEv31gg/a89cvOygqSMFdGUr1g=;
        b=KiVOTFFjkLGjgOchJbvs+lkjt8wTFAMt1X6rQ+wyVrutSfcjCLs/KFdgr5Iz756raA
         PrhH5zeWXKNJTU08m3CKf6R0f5je8GU5yPZl1m5Rq1XSul+a/1AVQpfcNUIUr9UDkmni
         Vk76w7gi08+EAZCidbReKsr7k837X0sk35Wv/CZLMO09nxaMZwjX2B0StWH+dA7xo2cw
         4e1yCa/v/Am6P7OUa8D1PvwAXwXHibEjJ4jHkZxiEF2LYoQ42OZy7Q823sHINqYAeUZ4
         lZ8Nc0e6WsBVMjGizR5vBA2097gv0DtMZZxT9L1irdpATfMG8T46Ah9V4ILJWrv2SOe+
         D6Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVY0t9kA8IJg7MEUaETG3j5AWx9Ny6KUq42AnS1U7/JgI7HDS3KufoZ+792iaj6KpVo9Tc=@vger.kernel.org, AJvYcCX+PgT+TCMv6vQZXRT/8NjJ6hyWqGkq5SuL9y8SM6EAYeQnu+Y1eApqoOp5YnR1LwCBsuAjREJJClZZqzav@vger.kernel.org, AJvYcCXZikjpVd1Dxc+2DYHoZsUXBvY2WZqkjXgyNLuhm5BYqJBcc1zHlcXgnbSpGfQjLlcwoFRYv4C0AC/vlkTHIjGt@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFTSB5MnzM9tfYhCEdPPud65N176ezw6vTxPapWISlJY4i1Bg
	B4aNa91piaNI9gVkUM8aYnSH7pJ0dJ4byi9USrli/KMSh1GsQKGr97BDP1Lm9k/XOhCuwcvMyQ4
	+yrwqiMSO1Wta19lbjcwjJ0qNFkn/S4g=
X-Gm-Gg: ASbGncvC9cr0FrEUHHOtHSG+aw7/3DDwIeWcOJP0fGXTnnmeqrht4bl/fC3QqoTCL7f
	Gz6d+/MXpvaV35F6eaXQqlFBZBwyeBqq5crUdK6UeEQAIEaDYOQkdy7TB3fKhIcGsEL8HiBlIAt
	0hoGmrzoh9OHKXNFBJ5f67MzuyWTegwRJA1Yq/Ud3ac9ZCHZKEu9gZHuHWOOMk0dI74GmxxQ1pX
	/QdpKN+vr2n99R1JU9fouk=
X-Google-Smtp-Source: AGHT+IF7FIzoT0fqYALPl4emLikuMQJqGcdJ+A55gnNfcMuqvzo6gqGDqyqsKHLKXayNj8FHr8O0w1c71i/O96oATvE=
X-Received: by 2002:a17:90b:314a:b0:2fa:157e:c790 with SMTP id
 98e67ed59e1d1-324ed0cbdc1mr673097a91.5.1755732301859; Wed, 20 Aug 2025
 16:25:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818074632.433008-1-phoenix500526@163.com> <20250818074632.433008-3-phoenix500526@163.com>
In-Reply-To: <20250818074632.433008-3-phoenix500526@163.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 16:24:47 -0700
X-Gm-Features: Ac12FXzrGYh21rKbf-9NRc84R9Quv84v8LjYG_6EY_8ndVDiaNnn7ampj8NX9oo
Message-ID: <CAEf4BzY6vKQ_or+EDq3zKb=HbUu+C6Ti4pTphOeqsNoQhL5m9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v11 2/3] selftests/bpf: Add an usdt_o1 test case
 in selftests to cover SIB handling logic
To: Jiawei Zhao <phoenix500526@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	yonghong.song@linux.dev, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 12:46=E2=80=AFAM Jiawei Zhao <phoenix500526@163.com=
> wrote:
>
> When using GCC on x86-64 to compile an usdt prog with -O1 or higher
> optimization, the compiler will generate SIB addressing mode for global
> array and PC-relative addressing mode for global variable,
> e.g. "1@-96(%rbp,%rax,8)" and "-1@4+t1(%rip)".
>
> In this patch:
> - add usdt_o1 test case to cover SIB addressing usdt argument spec
>   handling logic
>
> Signed-off-by: Jiawei Zhao <phoenix500526@163.com>
> ---
>  .../selftests/bpf/prog_tests/usdt_o1.c        | 70 +++++++++++++++++++
>  .../selftests/bpf/progs/test_usdt_o1.c        | 37 ++++++++++
>  2 files changed, 107 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/usdt_o1.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_usdt_o1.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/usdt_o1.c b/tools/tes=
ting/selftests/bpf/prog_tests/usdt_o1.c
> new file mode 100644
> index 000000000000..706168e804cb
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/usdt_o1.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Jiawei Zhao <phoenix500526@163.com>. */
> +#include <test_progs.h>
> +
> +#include "../sdt.h"
> +#include "test_usdt_o1.skel.h"
> +
> +#if (defined(__GNUC__) && !defined(__clang__))
> +#pragma GCC optimize("O1")

that optimize attribute is a function attribute, while your earlier
version just randomly put it here. Have you tried using that optimize
attribute on a function properly?

One of the points of that attribute suggestion was to avoid the need
to add another file in prog_tests and keeping various USDT test cases
in one test, so can you give that attribute another try and see if it
works?

> +#else
> +#pragma message("non-gcc compiler: the correct probes might not be insta=
lled")

hm... non-gcc is expected, so I don't think we should pollute compiler
output with extra messages

> +#endif
> +
> +
> +#define test_value 0xFEDCBA9876543210ULL
> +#define SEC(name) __attribute__((section(name), used))
> +
> +int lets_test_this(int);
> +static volatile __u64 array[1] =3D {test_value};
> +
> +static __always_inline void trigger_func(void)
> +{
> +       /* Base address + offset + (index * scale) */
> +       for (volatile int i =3D 0; i <=3D 0; i++)
> +               STAP_PROBE1(test, usdt1, array[i]);

I think I saw a bunch of mentions that getting desired SIB form for
USDT arg was a challenge, right? Have you checked STAP_PROBE_ASM from
sdt.h? That will allow to define USDT from inside assembly block,
which should give you a lot of control over the shape of the argument.


[...]

