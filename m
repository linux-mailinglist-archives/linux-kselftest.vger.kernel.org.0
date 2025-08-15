Return-Path: <linux-kselftest+bounces-39053-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D786CB2789E
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 07:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBDCD3B4BD5
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Aug 2025 05:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940C1288C81;
	Fri, 15 Aug 2025 05:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="ABxCVxS3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ECB253F00;
	Fri, 15 Aug 2025 05:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755236552; cv=none; b=oZ/ZwF6ViVGRgRS5+T9VW5vk1puUsqzsK7oh2WQ6MCDdhfIokmUxiEYUGwps2qZitqjK6kdTtgBiqrjbezOF3MP0ReZAhz7yvLZ39VOBOrWsm/Di0I0H0mGgoy33yPx9O1oZ7lDX8K+drd7+HwP2LQ49n/QG3ZRij+i3JBSuqmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755236552; c=relaxed/simple;
	bh=Ks40N5tXrBbzyWwTiZYVBvNXCKL6TfUycUcyTgffazg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpgzO9jnIN+RUgblU9X75Qk8TllRo8w2N408tH8HScy/hbND00FXHWfXFs/kk5OjKuVwUlvx+hhCSD8XgWs9XPKSDsJM3iUVhl35wossXcMK7ynzOMlBkzVr4x5i+oZNQstlF9u4sCbLQdwbBp1EYu2fzVuyeF3Je3uZ9yOxDrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au; spf=pass smtp.mailfrom=gmail.com; dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b=ABxCVxS3; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7ae31caso290924466b.3;
        Thu, 14 Aug 2025 22:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google; t=1755236548; x=1755841348; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ao0nHqySVR1z1mkQWgkIv+zrEyClYUPdZ2AVw92mKw4=;
        b=ABxCVxS3Pm11eoXkLyl7eij3bAdWXrGjL1z/PP8pqmYC2v2vDiXivn8DxwWf+8rOSn
         DaGSFP93wecypGZyCzzDg0CJSi0MeQRWA0xNmvda8frH+qgDAQStyFzlDGxler1Tx6O/
         4kXzql82hisLlvX2z+AxXOL2T8nshh3i28P/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755236548; x=1755841348;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ao0nHqySVR1z1mkQWgkIv+zrEyClYUPdZ2AVw92mKw4=;
        b=NNsDETCL6TuahFBChTYX9v2tS3dtdpxR8oGRJXjPEHEz0IKzAkYL/AcmaK4/lJqC2O
         wUeYyyYZJKcUKqRXqepMi3ArDjcc64/vXU8MCQQ/gdHHdTSEsamHo6rpM/nOEE9TPcYQ
         M3jUzNpTPhpeYxrWCri/kT8gIcufeaOKxI2Gs71GhqFQS+iBhAI/hBwjzHH1AfhXhiXX
         bmK1Syrm8I9P81Qx7BsATon9DqWV9dW/E4Zy6FDzN96BwUsq89nKFNN7AOXsHlTSfml7
         49OmQanR2KxKvC5eJH1sz5YVdPOzXR7oeYKmt+4nEyxw3weL/DQe+zTli+wgmO8sOsHc
         FwgQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8/goXDi1VN4SNpvaqhR6xZcpxQtQi7lI+2V8f0LFO27c1Pg+bJCxVPbVpOj1kACsJnZCaL5i4ENNfnCCgRmWa0g==@vger.kernel.org, AJvYcCUFc2GTMOeFZNDcGRI579z+KD0vzapoLLZEqN0gE+o3/8eXb3Qa2Tc++3Wp7Vkn1yNZkwp1AgGXsehOGR8=@vger.kernel.org, AJvYcCWiltz5Iy9Zj6LUgpLr3FiZCl/kM+dyNMchtkKGyWANbgXh3izXdnsxV3BUQEpQlQ5bML+kffnymb0vS/j3VbLs@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0p/nI/lK0X8zcB/qFmMPFHzXUn4Eos2wbD0a6oWEo1qnyqe6S
	gxCZnpi2QAN1U9adulivuYPyf8PqrjdwUORWck0OPPqIvLB13MXKrXuYL2fbD3quoao6MOnhwmb
	v+rYBdVrmXn74O13lp3MZ5XSv9SCGu4I=
X-Gm-Gg: ASbGncv6Sb9l2SeXa6bTwwuZhOjyGWCQkLDl0o72Ewe7T9jzFQd2TwcUYxp4PL9lrRM
	N4T8dxGLrLcDFYT3O0DOeoMKOoCHGIGRWpI/XCt0PmT6jgnzeNpQm/i242YxcL0KZ+reS63X6Jg
	JS77wuXdm2QjRriXvHylGmSE1/L8fJ2N3dKRoJu0OdYASOZqhSF5EcyeAHi9B4p8cT5jqrgwpY7
	/SOnhGGM3YaBxiVVLBu+kCQWayTWEyWxF8=
X-Google-Smtp-Source: AGHT+IHfJpD0Y3cKBjtoKB/TD0jiobIEw7Qext8zDoq1Qo4cR9mUtcGGxBbzZHvlUvY1u2ZejaJkKgOvEKCU+6YsJSs=
X-Received: by 2002:a17:906:6a0e:b0:afc:d209:37f2 with SMTP id
 a640c23a62f3a-afcdc359d12mr55071366b.61.1755236548083; Thu, 14 Aug 2025
 22:42:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250805193955.798277-1-jesse@rivosinc.com> <20250805193955.798277-9-jesse@rivosinc.com>
In-Reply-To: <20250805193955.798277-9-jesse@rivosinc.com>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 15 Aug 2025 15:42:16 +1000
X-Gm-Features: Ac12FXw8XUjBVkZPAHSLVno0uMPz2dM9vKDf4fisVFB6fiah4HK821c7ZHoR6ik
Message-ID: <CACPK8Xd2QfL460LY2T0ia7Akb79fEXKF2+=B27M8q5j7jUoouQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] selftests: riscv: Add test for hardware breakpoints
To: Jesse Taube <jesse@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jesse,

We had a pretty huge cc list on the thread, I've trimmed it right
back. Feel free to add some people back but keep it focused.

On Wed, 6 Aug 2025 at 05:42, Jesse Taube <jesse@rivosinc.com> wrote:
>
> Add riscv specific selftest for hardhardware breakpoints.

nit: double hardware

> These tests are based on:
> tools/testing/selftests/breakpoints/breakpoint_test_arm64.c

The sefltest didn't build for me. There's a few suggested fixes below.

> Signed-off-by: Jesse Taube <jesse@rivosinc.com>
> ---
> The selftest fails as register_user_hw_breakpoint seemingly does not
> call arch_install_hw_breakpoint. The test also seems to fail on arm64
> in the same way when I tested it.

Is this still a problem with your patchset?

Do you test in qemu? Can you share your version, command line, etc?

> --- /dev/null
> +++ b/tools/testing/selftests/riscv/breakpoints/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2021 ARM Limited
> +# Originally tools/testing/arm64/abi/Makefile

CFLAGS += $(KHDR_INCLUDES)

This adds -isystem to include local headers for the up to date
ptrace.h and elf.h definitions.

 $ make headers
 $ make -C tools/testing/selftests CROSS_COMPILE=riscv64-linux-gnu-
ARCH=riscv TARGETS=riscv/breakpoints
     make: Entering directory 'tools/testing/selftests'
     riscv64-linux-gnu-gcc -static
-otools/testing/selftests/riscv/breakpoints/breakpoint_test
     -isystem usr/include -Itools/testing/selftests/../../../tools/include
     -D_GNU_SOURCE=   breakpoint_test.c

> +
> +CFLAGS += -I$(top_srcdir)/tools/include
> +
> +TEST_GEN_PROGS := breakpoint_test
> +
> +include ../../lib.mk
> +
> +$(OUTPUT)/breakpoint_test: breakpoint_test.c
> +       $(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
> diff --git a/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> new file mode 100644
> index 000000000000..faeecc72da12
> --- /dev/null
> +++ b/tools/testing/selftests/riscv/breakpoints/breakpoint_test.c
> @@ -0,0 +1,246 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2016 Google, Inc.
> + *
> + * Original Code by Pavel Labath <labath@google.com>
> + *
> + * Code modified by Pratyush Anand <panand@redhat.com>
> + * for testing different byte select for each access size.
> + * Originally tools/testing/selftests/breakpoints/breakpoint_test_arm64.c
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <asm/ptrace.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/ptrace.h>
> +#include <sys/param.h>
> +#include <sys/uio.h>
> +#include <stdint.h>
> +#include <stdbool.h>
> +#include <stddef.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <elf.h>

This is the wrong elf.h, we want the one with NT_RISCV_HW_BREAK.

-#include <elf.h>
+#include <linux/elf.h>


> +#include <errno.h>
> +#include <signal.h>
> +
> +#include "../../kselftest.h"
> +
> +#define MAX_BP_SIZE 8
> +

