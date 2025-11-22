Return-Path: <linux-kselftest+bounces-46299-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D08C7C2D5
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 03:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8495B355DD9
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 02:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833D5270ED2;
	Sat, 22 Nov 2025 02:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu3+r+jy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F49200110
	for <linux-kselftest@vger.kernel.org>; Sat, 22 Nov 2025 02:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763778878; cv=none; b=W7yhO3HTp9FOsbNzdEDlUQ8onTSPC7q/kqKiMeabBBHdHeNCip1FEFHWAxH1fsWVm+KZ3/A9u+oXvG8/BgxlqwXPXcwCXLdg56eiUvKNcjzsoVUXwGbGb2YCbBSHVilQ+xq+AMVv45KbYkd1Qb/j4xJqyioqfecCf1cID4mmfmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763778878; c=relaxed/simple;
	bh=gg3inNzqFDLEFM/kWhoOulqPeu8YnqO8bKZm7XCrZc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9xoh5QRrp++A1NyWcBbe5biwLPmBLZmlQAJPyNM6k46uBzbyAaB0X/3pfwAIfwAOct6RZY+FfPsTtERsN4ZS1SoLp30kQfh1K8iqc+KjsOADvyCIZT2N71fDgEo9nb4/MDB9xdvqprNf0HGkmTKMEwUzVeLNyMbj7DjtvjmWis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu3+r+jy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477a1c28778so29260955e9.3
        for <linux-kselftest@vger.kernel.org>; Fri, 21 Nov 2025 18:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763778875; x=1764383675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hok8AGdazJb1+w9joZDPy/FV83MbsH7Pu+Z0JLsw5uQ=;
        b=Mu3+r+jyMMru6r07edIsGaLjNNmGxsxebNjZ0ZRAxsCt/8mDjfPZgHuz7uMDETSIof
         jBzBWl7ZegL+M5WZsxSk8xV0WXpc/Azml0q0iIe5MB4qWxvSXOs24ScN0zfE1pUfi6io
         QMChpJZYoEfiap7WMogliWapIvZY0N8DLj5JzcwxTmkNH3fFSmm+HgK3wUzNPPzm5k8p
         gEmaYLcrWdbPdfmNVUqqXbFsrMqgqDcCUWZfX8Z2SPmsEjPMTjlqLAXBjBcF4xkWBStA
         5wUZjnLCgOVBKAHc6tgxRrP+vt2SVddvw/og4lQpHaWdhibbJZJvhDUJLu0+aBmyBBJM
         ZUkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763778875; x=1764383675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hok8AGdazJb1+w9joZDPy/FV83MbsH7Pu+Z0JLsw5uQ=;
        b=wo3rOIP1qE+pHjRhHTjFVTEcx6Yn7wdoyPklPWX4w/tCm+h0XSmYl6Co9tV0eqXYfL
         31ItJ4QPymZwsGd3igJ3lCjUrBTXo+0zodctFfjlEUcxCfsPlWiDEbs935gyC+n4rMz3
         qBi47XUHcbr+VLY9KeHlIiZTQGAV3zhspmLLMk2oevDHNISOzQg0Y7vZja1mCWxinDlo
         bp2qv5YLWj2nt5eKTSp1BLfcF7BH4Uza+Fjf09iF2R8cAjbbZZYPwcceArjLVOewsipr
         rnS9513gzmXB5mPFfbZP5ZyLc/HqOqXWcamLClY0SKZO0fPHEBEvRN4UrQ2GBg2hCGLj
         ub0g==
X-Forwarded-Encrypted: i=1; AJvYcCUcMgGkOLS34SJexf8tQXjy5JGiGQp9/65ZNaOgLGJ5iXUGZhwFqgM51zSsgBFAx4kTTf+xI/lRZxyxKPipneQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEVDI8xatVJ1hnAXUiVlFwcZpOJhC0U/Gh+cy8bntUlA9x6D6
	C9OWv9IxgdQXNGnXywsb3HmWULJ8Ajxm/ifQvFnvEECXWF610nJeSh2uCaWkVaiBIGMfbCCSvHU
	CuTzDoyMvutv4lMhd3DCey4gMsZUW4sk=
X-Gm-Gg: ASbGncuSh+TvT/1Uv9x2kFTPcBYjw3xuA8zYFjOrX827P707wgC8VYeCGOR74kcF3dw
	ExDd7IRwR4HNv3rMopvHyJORUQvxYjc/Sq30DyDiZG9YUqfpDqQjks1GzINBKk/cdbPcb2SBhnc
	2WnPsAfgOSN6oBdeGTKJHOG/kHr5XjNZj9BJrrz2u6oNPQOELWk3ysp+3PvgEsupmTpuE1R9eDx
	iEpbWcVZ9XeWbaXIoTcNjFz2axAsUXqHoBRebAzrv/LOFYCeFUR0joBcYG37wSCTN2ztuKVRomJ
	Ou6LN/5qhcAgUC2mcvJu9Fcl5TQG
X-Google-Smtp-Source: AGHT+IFgIFbkdCBM0dRi8pm9bBEp4qcc6ceQPj/Lk5cQvVZpn6hTh5Ww5jMT4yDAAD5Jnb5DMblP3nk6CQb8+8UJjes=
X-Received: by 2002:a05:600c:45ce:b0:45d:d1a3:ba6a with SMTP id
 5b1f17b1804b1-477c01f55e5mr40208495e9.33.1763778874640; Fri, 21 Nov 2025
 18:34:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117162033.6296-1-leon.hwang@linux.dev> <20251117162033.6296-9-leon.hwang@linux.dev>
In-Reply-To: <20251117162033.6296-9-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 21 Nov 2025 18:34:23 -0800
X-Gm-Features: AWmQ_bmdqcJ1vlA4UXuQ-I4HU8G-hq3Y4taDV62L2m9v3V4-_e0IkWFi5HrVnPw
Message-ID: <CAADnVQLARr69Qv9EfwWkpudXLZNb21zYd86aPux_Fv3UAsrLGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 8/8] selftests/bpf: Add cases to test
 BPF_F_CPU and BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <jolsa@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Daniel Xu <dxu@dxuuu.xyz>, =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Shuah Khan <shuah@kernel.org>, Jason Xing <kerneljasonxing@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Willem de Bruijn <willemb@google.com>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Anton Protopopov <a.s.protopopov@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
	Tobias Klauser <tklauser@distanz.ch>, kernel-patches-bot@fb.com, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Add test coverage for the new BPF_F_CPU and BPF_F_ALL_CPUS flags support
> in percpu maps. The following APIs are exercised:
>
> * bpf_map_update_batch()
> * bpf_map_lookup_batch()
> * bpf_map_update_elem()
> * bpf_map__update_elem()
> * bpf_map_lookup_elem_flags()
> * bpf_map__lookup_elem()
>
> Add tests to verify that array and hash maps do not support BPF_F_CPU
> and BPF_F_ALL_CPUS flags.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/percpu_alloc.c   | 312 ++++++++++++++++++
>  .../selftests/bpf/progs/percpu_alloc_array.c  |  32 ++
>  2 files changed, 344 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c b/tool=
s/testing/selftests/bpf/prog_tests/percpu_alloc.c
> index 343da65864d6d..b9c3f5f6cd9c3 100644
> --- a/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/percpu_alloc.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <test_progs.h>
> +#include "cgroup_helpers.h"
>  #include "percpu_alloc_array.skel.h"
>  #include "percpu_alloc_cgrp_local_storage.skel.h"
>  #include "percpu_alloc_fail.skel.h"
> @@ -115,6 +116,305 @@ static void test_failure(void) {
>         RUN_TESTS(percpu_alloc_fail);
>  }
>
> +static void test_percpu_map_op_cpu_flag(struct bpf_map *map, void *keys,=
 size_t key_sz,
> +                                       u32 max_entries, bool test_batch)
> +{
> +       size_t value_sz =3D sizeof(u32), value_sz_cpus, value_sz_total;
> +       u32 *values =3D NULL, *values_percpu =3D NULL;
> +       int i, j, cpu, map_fd, nr_cpus, err;
> +       const u32 value =3D 0xDEADC0DE;
> +       u32 count =3D max_entries, v;
> +       u64 batch =3D 0, flags;
> +       void *values_row;
> +       LIBBPF_OPTS(bpf_map_batch_opts, batch_opts);
> +
> +       nr_cpus =3D libbpf_num_possible_cpus();
> +       if (!ASSERT_GT(nr_cpus, 0, "libbpf_num_possible_cpus"))
> +               return;
> +
> +       value_sz_cpus =3D value_sz * nr_cpus;
> +       values =3D calloc(max_entries, value_sz_cpus);
> +       if (!ASSERT_OK_PTR(values, "calloc values"))
> +               return;
> +
> +       values_percpu =3D calloc(max_entries, roundup(value_sz, 8) * nr_c=
pus);
> +       if (!ASSERT_OK_PTR(values_percpu, "calloc values_percpu")) {
> +               free(values);
> +               return;
> +       }
> +
> +       value_sz_total =3D value_sz_cpus * max_entries;
> +       memset(values, 0, value_sz_total);
> +
> +       map_fd =3D bpf_map__fd(map);
> +       flags =3D BPF_F_CPU | BPF_F_ALL_CPUS;
> +       err =3D bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags cpu|all_cpus"))
> +               goto out;
> +
> +       err =3D bpf_map_update_elem(map_fd, keys, values, flags);
> +       if (!ASSERT_ERR(err, "bpf_map_update_elem cpu|all_cpus"))
> +               goto out;
> +
> +       flags =3D BPF_F_ALL_CPUS;
> +       err =3D bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags all_cpus"))
> +               goto out;
> +
> +       flags =3D BPF_F_LOCK | BPF_F_CPU;
> +       err =3D bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
> +       if (!ASSERT_ERR(err, "bpf_map_lookup_elem_flags BPF_F_LOCK"))
> +               goto out;
> +
> +       flags =3D BPF_F_LOCK | BPF_F_ALL_CPUS;
> +       err =3D bpf_map_update_elem(map_fd, keys, values, flags);
> +       if (!ASSERT_ERR(err, "bpf_map_update_elem BPF_F_LOCK"))
> +               goto out;
> +
> +       flags =3D (u64)nr_cpus << 32 | BPF_F_CPU;
> +       err =3D bpf_map_update_elem(map_fd, keys, values, flags);
> +       if (!ASSERT_EQ(err, -ERANGE, "bpf_map_update_elem -ERANGE"))
> +               goto out;
> +
> +       err =3D bpf_map__update_elem(map, keys, key_sz, values, value_sz,=
 flags);
> +       if (!ASSERT_EQ(err, -ERANGE, "bpf_map__update_elem -ERANGE"))
> +               goto out;
> +
> +       err =3D bpf_map_lookup_elem_flags(map_fd, keys, values, flags);
> +       if (!ASSERT_EQ(err, -ERANGE, "bpf_map_lookup_elem_flags -ERANGE")=
)
> +               goto out;
> +
> +       err =3D bpf_map__lookup_elem(map, keys, key_sz, values, value_sz,=
 flags);
> +       if (!ASSERT_EQ(err, -ERANGE, "bpf_map__lookup_elem -ERANGE"))
> +               goto out;
> +
> +       for (cpu =3D 0; cpu < nr_cpus; cpu++) {
> +               /* clear value on all cpus */
> +               values[0] =3D 0;
> +               flags =3D BPF_F_ALL_CPUS;
> +               for (i =3D 0; i < max_entries; i++) {
> +                       err =3D bpf_map__update_elem(map, keys + i * key_=
sz, key_sz, values,
> +                                                  value_sz, flags);
> +                       if (!ASSERT_OK(err, "bpf_map__update_elem all_cpu=
s"))
> +                               goto out;
> +               }
> +
> +               /* update value on specified cpu */
> +               for (i =3D 0; i < max_entries; i++) {
> +                       values[0] =3D value;
> +                       flags =3D (u64)cpu << 32 | BPF_F_CPU;
> +                       err =3D bpf_map__update_elem(map, keys + i * key_=
sz, key_sz, values,
> +                                                  value_sz, flags);
> +                       if (!ASSERT_OK(err, "bpf_map__update_elem specifi=
ed cpu"))
> +                               goto out;
> +
> +                       /* lookup then check value on CPUs */
> +                       for (j =3D 0; j < nr_cpus; j++) {
> +                               flags =3D (u64)j << 32 | BPF_F_CPU;
> +                               err =3D bpf_map__lookup_elem(map, keys + =
i * key_sz, key_sz, values,
> +                                                          value_sz, flag=
s);
> +                               if (!ASSERT_OK(err, "bpf_map__lookup_elem=
 specified cpu"))
> +                                       goto out;
> +                               if (!ASSERT_EQ(values[0], j !=3D cpu ? 0 =
: value,
> +                                              "bpf_map__lookup_elem valu=
e on specified cpu"))
> +                                       goto out;

I was about to apply it, but noticed that the test is unstable.
It fails 1 out of 10 for me in the above line.
test_percpu_map_op_cpu_flag:PASS:bpf_map_lookup_batch value on
specified cpu 0 nsec
test_percpu_map_op_cpu_flag:FAIL:bpf_map_lookup_batch value on
specified cpu unexpected bpf_map_lookup_batch value on specified cpu:
actual 0 !=3D expected 3735929054
#261/15  percpu_alloc/cpu_flag_lru_percpu_hash:FAIL
#261     percpu_alloc:FAIL

Please investigate what is going on.

pw-bot: cr

