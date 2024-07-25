Return-Path: <linux-kselftest+bounces-14249-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AEC93C97C
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 22:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45F3F1F21A80
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 20:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BCA757F3;
	Thu, 25 Jul 2024 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9rgBZMY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6644C7B;
	Thu, 25 Jul 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938975; cv=none; b=UCn0E3DcMwuqwQK5Cik7jc9W/3r5QH4Oid8U8I2kf8oOyi0PoqyhYYVrzJpIWTOpfgUjHgCUUrS0zw3dznXwbKI63McYs8dy13EAq/w6GeqS59XUE+jC3xaxLeOgaQBt/HMQzMfnU13qfXo+KeO7wEm2njjJf6L2Rf8BsF2qLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938975; c=relaxed/simple;
	bh=KgPkVCYtUGieLNbWNWi5wAxbvfggcceRqL5Zsa58GOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BW4yPdxil+OkLBwJfMWviYUkdO7zDfMcODQC9tIIvBUJn0m9gxuVvHlhvyp5LjW+aRvdUFgOwX3quSRQXmXg/x6HuCvlgOoaEv3149J8mAs41PUtu4HmmKloOqm15+kZNs1Od8pvP1BcZUWFpCTdewoSTz7J9cpXlWHepOGIMEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X9rgBZMY; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7aada2358fso165494266b.0;
        Thu, 25 Jul 2024 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721938973; x=1722543773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dSRZDThVfM2lJBp2TPiybCMAfJriDNXBT2O0tOt140=;
        b=X9rgBZMYdkp/o73Wi9upGBCEGgswFeJNOo3KTHAuhCOkxGjvzYKWxZCUdVqY+laYRx
         Ltq9WxxrobV5C6yyhyo1GYZw9tfW3ebgGakZZMi/UexGjBeAVrGiFGICOCrgCqwciQWr
         EnJOK52l5YhfehBZEGwA1sY4k4zPU5neAeXkdQYN7QaFxV891v72JqWY+swOt8COc6N2
         QB0YwgxG/x1AU9x+wCFGOsowYzxVmxVBsFgKGD8XzkZrv3JPH95R0SzI4E5yl1hfCfiG
         jnJ7LTFTJLq19TPtxcz1ssosnhLqt+na98ELT09xon4cXyfpGonxYzzBpHkb+IYYzl0m
         aT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938973; x=1722543773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dSRZDThVfM2lJBp2TPiybCMAfJriDNXBT2O0tOt140=;
        b=f7uJXlTBgnYl2saIzD2T/ROTk6kZek3eoqDgtoE9JjJLOKjEPLSDNpVW29Y42ZpI8t
         mPL3EBjuRCKQfKs6tJ3XHZmE0sXJ8cXfLRjOF2qKX/LmZKKpR+X05rEiRguap5j+3h8i
         tQEa/acTXH313lBAs7IPWDGD/8If6rwvyR3Muq2pLTewtygom5kYRTX8HLCo2iGCi4OJ
         dnxbU+WBFbB1NoV3xQVw+WHkH8UO14c0suk4yp34kH9hqYnkB+JR+UDw6OFpXRG/WNn4
         T2nQrD5CG/SclSb35+JpppszHl+J5rpm8FTCt6XRin9AE6151MoTqdtxuhUqx8SH0Mbe
         +q6A==
X-Forwarded-Encrypted: i=1; AJvYcCUsppkLuplAeoYn53yDW+IPwYan0oDYwyjqvl/dAQ4ciqrTP+PE9rOaDAuVx0/bB6vlfwBQ/YIAlfxJ/5JfdjsVmEZrmBSuHJFpIWltP8gFWJRchZQ0YR9kuB3vJySvZjj0cQGW8AKY
X-Gm-Message-State: AOJu0YzdWpLl6Z98L9zmG36QgMqzd7vzMSgXWFZSqU3marJD2igSYmzm
	UlfIHUzl/RHai5927Qadt8ZVJyNziGQV7SoxCVQM2cu4iVYBbF9ivAOS0O5fv+E8QKlu8dZdLBa
	vypn8wRt913N5M36E+SnDc2Cr9So=
X-Google-Smtp-Source: AGHT+IFUFcp9jHwtKXl649dnDmJ2ewK4+2LrgKVulaalof7ghyT4F8l1pO+0c4/p1Fdn0eXekhHzZf3YS0wKRF4GLvo=
X-Received: by 2002:a17:907:1c16:b0:a72:7ede:4d12 with SMTP id
 a640c23a62f3a-a7ac4483a9emr452930066b.5.1721938972497; Thu, 25 Jul 2024
 13:22:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721903630.git.tony.ambardar@gmail.com> <472c94bd42cda20154a26ef384b73488abf026c0.1721903630.git.tony.ambardar@gmail.com>
In-Reply-To: <472c94bd42cda20154a26ef384b73488abf026c0.1721903630.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:22:37 -0700
Message-ID: <CAEf4Bza_y15T4gU=Kiu2d+RbWpxEzrLe6T71bCpK383xHD8JMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 6/8] selftests/bpf: Fix compile if backtrace
 support missing in libc
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Yan Zhai <yan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 3:39=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> From: Tony Ambardar <tony.ambardar@gmail.com>
>
> Use backtrace functions only with glibc and otherwise provide stubs in
> test_progs.c. This avoids compile errors (e.g. with musl libc) like:
>
>   test_progs.c:13:10: fatal error: execinfo.h: No such file or directory
>      13 | #include <execinfo.h> /* backtrace */
>         |          ^~~~~~~~~~~~
>   test_progs.c: In function 'crash_handler':
>   test_progs.c:1034:14: error: implicit declaration of function 'backtrac=
e' [-Werror=3Dimplicit-function-declaration]
>    1034 |         sz =3D backtrace(bt, ARRAY_SIZE(bt));
>         |              ^~~~~~~~~
>   test_progs.c:1045:9: error: implicit declaration of function 'backtrace=
_symbols_fd' [-Werror=3Dimplicit-function-declaration]
>    1045 |         backtrace_symbols_fd(bt, sz, STDERR_FILENO);
>         |         ^~~~~~~~~~~~~~~~~~~~
>
> Fixes: 9fb156bb82a3 ("selftests/bpf: Print backtrace on SIGSEGV in test_p=
rogs")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/test_progs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/sel=
ftests/bpf/test_progs.c
> index 60c5ec0f6abf..f6cfc6a8e8f0 100644
> --- a/tools/testing/selftests/bpf/test_progs.c
> +++ b/tools/testing/selftests/bpf/test_progs.c
> @@ -10,7 +10,6 @@
>  #include <sched.h>
>  #include <signal.h>
>  #include <string.h>
> -#include <execinfo.h> /* backtrace */
>  #include <sys/sysinfo.h> /* get_nprocs */
>  #include <netinet/in.h>
>  #include <sys/select.h>
> @@ -19,6 +18,14 @@
>  #include <bpf/btf.h>
>  #include "json_writer.h"
>
> +#ifdef __GLIBC__
> +#include <execinfo.h> /* backtrace */
> +#else
> +#define backtrace(...) (0)
> +#define backtrace_symbols_fd(bt, sz, fd) \
> +       dprintf(fd, "<backtrace not supported>\n", bt, sz)
> +#endif

First, let's define backtrace() and backtrace_symbols_fd() as proper
functions, not a macro?

And second, what if we then make those functions __weak, so they
provide default implementations if libc doesn't provide those
functions?

This parts seems unavoidable, though:

#ifdef __GLIBC__
#include <execinfo.h>
#endif


> +
>  static bool verbose(void)
>  {
>         return env.verbosity > VERBOSE_NONE;
> --
> 2.34.1
>

