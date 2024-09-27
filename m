Return-Path: <linux-kselftest+bounces-18515-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7CF988BA2
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 22:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 476811F21A83
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 20:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166B51C2DCB;
	Fri, 27 Sep 2024 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwAHd66r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E36E1C2317;
	Fri, 27 Sep 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727470750; cv=none; b=qVLc3o4VeSBJLDJvD5mxizu7Lyv6Mw3UtOYDMUxb/lcwm7tk7Speg37WE1kZUQOCICAr/oh1KUD0fEr3BcN37e+0Y95Hs2fPNKC/c6XfbKsWb8Xe62hdTGzww2JepBrGCQkPz8oiWNnBw9RC/TM4STs8uvGvI4Hozc/E+siFbvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727470750; c=relaxed/simple;
	bh=fnM3H4wnBAXCZbJ0HEWaAgPxQS9Y1e52aZrt0e5s9/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XmT6MjEkjllQlLxAgCXsM8qkMEC462yuUNHeDEXu/kki6coQR9DZkL/FI5GxL8aNqi9u3ATcDl/Y5j2L0usu7P7IHKveJknr/cE0jaesuTx0YDF6eEniuGe6rUSAzEoYQ6IargTlM0f1BX3sqsubUIa5AJk1DcEC4yP4NNGokbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwAHd66r; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2e0b93157caso1110206a91.0;
        Fri, 27 Sep 2024 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727470748; x=1728075548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yS9H3DUqSh4+1N7AkOP+SYlaTHqv5UhoSoo/j5k+2k=;
        b=cwAHd66r7Uit5MTQL2Si/ZFE7TSP5Ij93iglgK4HYaP/QphgldhgPT+FH1h+8t+nld
         YH0e9hOUx+SG/bOPxofmeo2i4JckdSRjIJVj7Vd1wG5IXOrMhXYvhlZyAV9hPf48/Fl6
         I2UMDjd5VYHpK8U1D7IiWpahgWnKKYB4aEleWUvBGIu3RWO5as3ruzNWAbfFdZCqpr+0
         IwF8hMJNHLCJE0yPZxwdQAhDhWUmJLQxr1JctaUK9LnBcbz7BqRasaqPj1KVyc2eN4qk
         eQW+Ot81auZGX+8mPKEO5WNB00Bsv3Dv0+hZ04x6BsxeefwguA+rdmcj8ZZVEJQxRzlF
         uxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727470748; x=1728075548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yS9H3DUqSh4+1N7AkOP+SYlaTHqv5UhoSoo/j5k+2k=;
        b=exQl6tTEp6+HduD/n9sMmoOxXFUh76x0KpUsWVWTQSt0/PjL6JZdb2PxiMkLFOWpJu
         FqM2JFcl3pMvF8t6Q3fO5rOh93gLGvtH5f9Ea0sEdVPksF7pV08keb64ZnTgrTAX2d9Q
         htAWs3S8yCTy3gl5vzA7duIDyUa8yDyrEgF2uFwenskqkn6k4evijUu4vUzoAE0x9p3I
         D0yARjLm05+Un94dJP70p6A5fLQa5yMZTJnPqFX2a/qEWFmbam4sdCQX1+9r4BJG9qIQ
         5n4mNMAC8iesp//hcFMaX8zXAMoLQ4lfNQDLRwTM+GNsH0utahxt/VkqVNK65WsQbM45
         Oexw==
X-Forwarded-Encrypted: i=1; AJvYcCVcS8DqFJzY79rVm8sLXBhUBeUiPuxEhe6cfbxG0wAQyxEWYZzygXGGb5zjnchWWS5871gucB7prjJd76i+@vger.kernel.org, AJvYcCWnIqbwB0aWgsY2YEcW8iPZkT9pRv8ExHyWOx5ZHQDlGXbXuHDipRrPbxFSCTwcrZOI6r2vdLrOlVX/5DqZ9mEb@vger.kernel.org, AJvYcCXQ7ZgDl02tKdQZC9BOYxW3dSZ946JrQlbYlWZ/O3cNxXFNSOglpm2p36NY9m3N4U9S2gw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6Q27jZO3oP7dhbVf7VeVuL7hxeNlcGmqhP+WLS+tz54hwQiS1
	yJKO+rw83bJEc51FtbKPmXN1owctiXLfoSc6IRXJC4oQJmUM1sbOouRgJTNDTpbjdvoN2sMi3ra
	dJKbYOv/b9p9ztfREjTOWGB7djo0=
X-Google-Smtp-Source: AGHT+IHVGYzkg7zX+Li8+rcjjNN8BeB6X2hawaJlDm3sLNTdoAo66nKXyEGUiagb4SKdZzOPC/h3R/OfDsTpnKk/284=
X-Received: by 2002:a17:90a:4747:b0:2c9:90fa:b9f8 with SMTP id
 98e67ed59e1d1-2e0b71cae48mr7464837a91.10.1727470747867; Fri, 27 Sep 2024
 13:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240927082313.116139-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240927082313.116139-1-jiapeng.chong@linux.alibaba.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 27 Sep 2024 13:58:55 -0700
Message-ID: <CAEf4Bzaau0apKBM75BedphVUA9EHXfzC7wr4ugVZqohWZbLxRg@mail.gmail.com>
Subject: Re: [PATCH -next] selftests/bpf: Use ARRAY_SIZE for array length
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, mykolal@fb.com, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 27, 2024 at 1:23=E2=80=AFAM Jiapeng Chong
<jiapeng.chong@linux.alibaba.com> wrote:
>
> Use of macro ARRAY_SIZE to calculate array size minimizes
> the redundant code and improves code reusability.
>
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:98:34-35: WARNI=
NG: Use ARRAY_SIZE.
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:93:29-30: WARNI=
NG: Use ARRAY_SIZE.
> ./tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c:101:34-35: WARN=
ING: Use ARRAY_SIZE.
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D11167
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c b/to=
ols/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> index a18d3680fb16..5e576c6cecca 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc_raw.c
> @@ -7,7 +7,7 @@
>  #include <sys/syscall.h>
>  #include <bpf/libbpf.h>
>  #include <bpf/btf.h>
> -
> +#include "kselftest.h"

this doesn't compile, and I don't think you need this include

pw-bot: cr

>  #include "test_progs.h"
>  #include "test_btf.h"
>  #include "bpf/libbpf_internal.h"
> @@ -90,15 +90,15 @@ static void test_bad_local_id(void)
>         attr.prog_type =3D BPF_TRACE_RAW_TP;
>         attr.license =3D (__u64)"GPL";
>         attr.insns =3D (__u64)&insns;
> -       attr.insn_cnt =3D sizeof(insns) / sizeof(*insns);
> +       attr.insn_cnt =3D ARRAY_SIZE(insns);
>         attr.log_buf =3D (__u64)log;
>         attr.log_size =3D sizeof(log);
>         attr.log_level =3D log_level;
>         attr.func_info =3D (__u64)funcs;
> -       attr.func_info_cnt =3D sizeof(funcs) / sizeof(*funcs);
> +       attr.func_info_cnt =3D ARRAY_SIZE(funcs);
>         attr.func_info_rec_size =3D sizeof(*funcs);
>         attr.core_relos =3D (__u64)relos;
> -       attr.core_relo_cnt =3D sizeof(relos) / sizeof(*relos);
> +       attr.core_relo_cnt =3D ARRAY_SIZE(relos);
>         attr.core_relo_rec_size =3D sizeof(*relos);
>         prog_fd =3D sys_bpf_prog_load(&attr, sizeof(attr), 1);
>         saved_errno =3D errno;
> --
> 2.32.0.3.g01195cf9f
>

