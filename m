Return-Path: <linux-kselftest+bounces-37466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D79C1B0827B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 03:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42763BA1A3
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Jul 2025 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E85143C61;
	Thu, 17 Jul 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h34KecRM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE9A2F509;
	Thu, 17 Jul 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752716240; cv=none; b=Wwd6NYRA3JWaLDrWuFg3yq0aB7tr++vK/MAKSK1NOCHGJcb+wlxpmZ/8PFqh/6QDdCojKD9AKAOI3r/7ASxskB1aMbH3yrcIYOo790zVorPO7mTrMsvaMwMoJVxiotKtPLkWdx8eaTvh2Og07yMAs/gVCUN7Wn5/M034AtjMILQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752716240; c=relaxed/simple;
	bh=fMo1n/FvRV5iyO+K3WHcXIK+6Whi7Zr0qbAPz05a1Ps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e03/rkAbj5SMYTh/+kUiAoefoxG8Lx70Iv90Qw+0ImxdnsaTlf4NPCiyDeHaQC4I8Prr8c4gDTfj3l3kL9GvSwMT7/mvcEXicbVZnBocKFZ7ZBps8tLzIXOfNVegBA/7X3Q04U3KO8woRMrMmYMdBFPy3jvvYa815NVSmtCQxRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h34KecRM; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4561514c7f0so4063535e9.0;
        Wed, 16 Jul 2025 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752716237; x=1753321037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1wYYVCoFZRUOZZtbrCGDeTHy7mPiZt2di/nk1haH1g=;
        b=h34KecRMbZmumcuT3o+rxP3uqE27bRRfMF5xQdeeHuQQo3SbokPnOo3PtuEasg6VTb
         3GeSbk1uA9UDGTDaad+f8c47qBinN321Xd04hfTT6zPrms8oZuEIrZCtLsa0IUVdQF5Z
         IkvmZZ/EbX4WVfe+9caV/bBHWt2TZfyyBVnXO1ojkNC5HSLXLvBQzEYAOe0ALhTkeGcN
         JJj1fhm5/j+VnbaVX28Ox1fyZyxySaWbgFZ69ka/wplvrIMW7BZBaHOsOzMOzzIM4P+g
         Q3IgPllJqXW5ZBVm+z86A6wBYnEOYnEbGX3yfT4daKlHZjYWTeXp1A9k5hj6tLEareGy
         mhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752716237; x=1753321037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1wYYVCoFZRUOZZtbrCGDeTHy7mPiZt2di/nk1haH1g=;
        b=JXRHOxmIlyh/Nr/MjgujLprpcCAmkWxwAfj5ow/rB88tJXlmAXCnExhE2nHj2j55+a
         H+jlgZc/XJdmNn4HXr4WVxFA/5UzIPjhPJ/348RkUl9oE2GIjXgA6E12Ftt/v1lkoTU9
         tmrldJaEkl6p8DzhvMRKKivlVE2u+qvqPqxtkXyAmrewhV3mgYS4P6T3k5Qq9X0hpUGo
         SKSkWgoAv1J03QDMojEdWghTx1LsLR73biF1c478GdlDn2+tAesT+90zmYFnvOrpGfOT
         PTzVlUvnNV5EKNxL6XMIf88432a0gI9Yt+6Ax83/hmwThd4ts4HV7N4byxWUGN4i+SL6
         zr0g==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zyd0AwmwMsMcFj0fEZ4XUkTVio3fQxD0z1WgoQP48gA7InIM5wMCtS/GC62vjZ2tB+H0kxhtgdR0YOe/igM9@vger.kernel.org, AJvYcCUS5AzY1Tx9Ut0aWWzIsff4XGwW07QqjbEax9Co8d693IKQQPs9KvD1yPDGIP8f2Csgr70=@vger.kernel.org, AJvYcCV9nbNAHaf4AfVzfGSrzxbCiWFLRS6kXVlHQ8o9WfX2s+s3Xcy9Iis9b4/wwhIqjU4f/q81JkYCVk6RzBkh@vger.kernel.org
X-Gm-Message-State: AOJu0YwD1T6TtNl7BakN5OG4xGmRySByxAueOw5ZEYFu4UUe/OFqF+Pu
	oW+RpZOMebO24Jo2w0+p/W9pluBlNSpTDDvfpCbS1qe1u1SJ9o6ZbveQEJs/q42WCRFasPlDJtn
	f7bEjxs4VbU8zlRmssOTa4jSBHKnHn7w=
X-Gm-Gg: ASbGncuZwLvgLCdtGi7hKnmEtWu+PS/UjJiTwWJi/V/wPYxHKKudThj2TtJ9B74dRfx
	o5cZ9E1WnIfJj/VtsQ9iNyesuteqWsgi7t5z+87x10UGRD4vzr4iXm7J5l1vR0BwEOiT1icEfvo
	jWernSG5dJlOWcxC+GyLTgyjo1I1EpcE8k8mdtG+/FE0EyGbk27B+tP0xvh97RpvaPMeEVBuy4K
	D+3k5jBFsXmUSIzynv9SThydFeAYkdKIVD4
X-Google-Smtp-Source: AGHT+IGgV6MdxSmi6TQO5PCsDGnID2h2AYYqZv+RgBvrOCAatiFMutwhoHVVe0kXdaQxyhlEINYmbYtkTBm/JZ3X4WI=
X-Received: by 2002:a05:600c:3e09:b0:453:dbe:7574 with SMTP id
 5b1f17b1804b1-4562edaa0b3mr47452695e9.12.1752716236784; Wed, 16 Jul 2025
 18:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714120408.1627128-1-mannkafai@gmail.com> <20250714120408.1627128-4-mannkafai@gmail.com>
In-Reply-To: <20250714120408.1627128-4-mannkafai@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Jul 2025 18:37:05 -0700
X-Gm-Features: Ac12FXx3K0NczfO52DOfjKkMx8MTLQOgGs2G-OeBUYMXF1gUhlhYGLeeOWQSvBk
Message-ID: <CAADnVQ+H6oHMFPvWkXuHv9oanHT57F_HrD_ZpxB0X=37vdAoyw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf: Add selftest for attaching
 tracing programs to functions in deny list
To: KaFai Wan <mannkafai@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, Yafang Shao <laoar.shao@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Leon Hwang <leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 5:04=E2=80=AFAM KaFai Wan <mannkafai@gmail.com> wro=
te:
>
> The reuslt:
>
>   $ tools/testing/selftests/bpf/test_progs --name=3Dtracing_deny
>   #467/1   tracing_deny/migrate_disable:OK
>   #467     tracing_deny:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: KaFai Wan <mannkafai@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/tracing_deny.c       | 11 +++++++++++
>  tools/testing/selftests/bpf/progs/tracing_deny.c  | 15 +++++++++++++++
>  2 files changed, 26 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_deny.c
>  create mode 100644 tools/testing/selftests/bpf/progs/tracing_deny.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_deny.c b/tool=
s/testing/selftests/bpf/prog_tests/tracing_deny.c
> new file mode 100644
> index 000000000000..460c59a9667f
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/tracing_deny.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <test_progs.h>
> +#include "tracing_deny.skel.h"
> +
> +void test_tracing_deny(void)
> +{
> +       /* migrate_disable depends on CONFIG_SMP */
> +       if (libbpf_find_vmlinux_btf_id("migrate_disable", BPF_TRACE_FENTR=
Y) > 0)
> +               RUN_TESTS(tracing_deny);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/tracing_deny.c b/tools/tes=
ting/selftests/bpf/progs/tracing_deny.c
> new file mode 100644
> index 000000000000..98ef834f0b6d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/tracing_deny.c
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +SEC("fentry/migrate_disable")
> +__failure __msg("Attaching tracing programs to function 'migrate_disable=
' is rejected.")
> +int BPF_PROG(migrate_disable)
> +{
> +       return 0;
> +}

Please roll these two tiny files into existing files in progs/ and prog_tes=
ts/
directories.
Every file takes time to compile 4 times, so let's avoid unnecessary overhe=
ad.

--
pw-bot: cr

