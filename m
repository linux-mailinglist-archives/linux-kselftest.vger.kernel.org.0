Return-Path: <linux-kselftest+bounces-41983-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AEAB8B72B
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 00:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C3F7AE5F6
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 22:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BD82D46B5;
	Fri, 19 Sep 2025 22:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzwIjfsM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD762874FF
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758319870; cv=none; b=YpdN+ShGPkzBlSIWFeACPk1320LU7zRlrieemGirbLfMxCK62JZpUbpS8Rr9DuTcdYGg1rbW2DeG1eI74HdbYJMZ6dQZo5W/A6tKJZ0Ti3R1aE1gfQDhPtiw1mvpnJekxJ65sbb6k7wF2r52sD3IM1X/QTuxV3IQi4Cgc+Wj4v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758319870; c=relaxed/simple;
	bh=u4/5wClwlRIAxlq8oJt6JyYj/C5VFUsaOsFjICJiOWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BOXE3KS+f6+RAeByeMyO4Z7torcYqVwAe4AfUAb6O5zvUGvVk7DsImog3joWpOzOPG/sc/L3vi7fs1+kHU8BerkkkAG+CwbsTB0QWoAsHxnMZJ8SmjcWwcoDBz3mbaDBEGQNFj9gWsSyOh3WzAwPNZaU/GuPEfw+U5zkb9/8OLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzwIjfsM; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-330b4739538so848596a91.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 15:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758319868; x=1758924668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf02vc4mDImutCw4wGwF0XTBIX75I6KI/d6Y0Uy3kgU=;
        b=WzwIjfsM5NAzKJ/PG+I0Pga8VFFquwI2gG2rcp+K/F5VEkkZO1ANu/6zNLeKa7K3c+
         umr/CvOGRkXB5lW9iWLVbRmY0TSed/lTFCHQWy7yUVKxZQiUWIhck+X3wrsZCeA+ePMD
         NAm7BUnjBxN6+0OWpOVMH4ZAEu/o+CGUDLGjuVEGinuUvaPhgfJvbj9rMhpmyAZcgypY
         qPlitcOYrD2JcarcSUJw/pPZV760+y6T3v3ed0cZdZX0s25I2hGdt34kGAGBZ2IPrGhB
         Jtt9U5qAsPMC+oHijeZ7/g+vfLAorFp3kn1QeSZcHkPeG5Bxw7ELNL//bI282ADqBc1U
         stVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758319868; x=1758924668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf02vc4mDImutCw4wGwF0XTBIX75I6KI/d6Y0Uy3kgU=;
        b=RwSr56fosISnBkB9x0li8EwqaLTU+M4vg8uapmzr70MajUHjKJlEDcG5cmRntoMycJ
         xI2/QfanfgyJP4kt9TBRzsoKyubIEBtv50EWURyRKofk3dE+X/xEaHk4hcWDDsBm+jLD
         6YlCwxCbHoq864K5jXaoQsO0/PGVOcBQE2TWwZu5rEQbiOjArdAiDom/qYZXoTrZgdIl
         LOpoXTGyHxk3UgIANWUlz3X/gMvNZi9tNEMXhOABe1MA3FZ1tNS4KYcgdt23o9V2n2+k
         02k2326klWl4L8+dARnDYl4DqJoStyZjhx7+jch3YaeS+NAdxlWsUmkLuwcXjiyQiHxB
         j6FA==
X-Forwarded-Encrypted: i=1; AJvYcCVQuSK3qFICIwCUfpKZGHAcGFSp0Lu2z2LQjUyt1lWab0epj/7t91N6kUbpRy04BlyOlqzR5NzIJpUrRNm/h8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqNr8/Hs/jaoso3GGeJYmC2/q8iCXwQznPTYlTdvNjwsGeSoeQ
	mKrjcpYcb84+1RgFSU6CBd2T2X+Yk+RWwbQDLQIYTNAVkawYZKxfzLMNoOvyZyU0WDr/2aEieB7
	wmYJmc2BvSMg5Mkztmcs0lTDOu+UPKCs=
X-Gm-Gg: ASbGncuIlbXnc1LiJFEjHsCrPPyNFRbOCpVE3QWjWVYiaWAMNGQxafIB0T2DfLB2PGe
	w8PmluxC4P3y6WLNXvG3MC59UtXy8DDgczgik4dEIHKRvEZEMA9M46EsHkxO5UxLOZTiYRVnLG+
	Nfd0NGlHUIdy/3+HJC5H3yuvf8qgYpxd1He++coHzg3hyssZmYb/sPq9W++rAlRPQkKR6M5exIH
	Aq2V1c+HwErG/9dgQ1hc+Y=
X-Google-Smtp-Source: AGHT+IHEnLGLDqjhSrbuMQuvE7LSnHEsBSE6cBfR+eWyM3YlHu+t5gLe1jyeFifT+ICxhrQ3TgYdoP65tPHyd/JOM1Q=
X-Received: by 2002:a17:90b:4d81:b0:32e:36f4:6fdc with SMTP id
 98e67ed59e1d1-33097fdc41amr5588363a91.4.1758319868284; Fri, 19 Sep 2025
 15:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com> <20250905150641.2078838-3-xukuohai@huaweicloud.com>
In-Reply-To: <20250905150641.2078838-3-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:10:53 -0700
X-Gm-Features: AS18NWBNUJTRTz6rSsMcsMaaPBLxQQDp9-lbx_eso0kzyMWMi4x2wmW-pUAi6xE
Message-ID: <CAEf4Bzbdg9MXDEz1fNXDPZfhe=_NAdLa6hT3M-EkLkycVdrW9w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] selftests/bpf: Add test for overwrite
 ring buffer
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>, 
	Song Liu <song@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Tao Chen <chen.dylane@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin Kelly <martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 8:13=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com>=
 wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add test for overwiret mode ring buffer. The test creates a bpf ring
> buffer in overwrite mode, then repeatlly reserves and commits data
> to check if the ring buffer works as expected both before and after
> overwrite happens.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |  3 +-
>  .../selftests/bpf/prog_tests/ringbuf.c        | 74 ++++++++++++++
>  .../bpf/progs/test_ringbuf_overwrite.c        | 98 +++++++++++++++++++
>  3 files changed, 174 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_ringbuf_overwr=
ite.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 11d2a368db3e..e6c18e201555 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -499,7 +499,8 @@ LINKED_SKELS :=3D test_static_linked.skel.h linked_fu=
ncs.skel.h               \
>  LSKELS :=3D fentry_test.c fexit_test.c fexit_sleep.c atomics.c          =
 \
>         trace_printk.c trace_vprintk.c map_ptr_kern.c                   \
>         core_kern.c core_kern_overflow.c test_ringbuf.c                 \
> -       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c
> +       test_ringbuf_n.c test_ringbuf_map_key.c test_ringbuf_write.c    \
> +       test_ringbuf_overwrite.c
>
>  # Generate both light skeleton and libbpf skeleton for these
>  LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test.=
c \
> diff --git a/tools/testing/selftests/bpf/prog_tests/ringbuf.c b/tools/tes=
ting/selftests/bpf/prog_tests/ringbuf.c
> index d1e4cb28a72c..205a51c725a7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ringbuf.c
> @@ -17,6 +17,7 @@
>  #include "test_ringbuf_n.lskel.h"
>  #include "test_ringbuf_map_key.lskel.h"
>  #include "test_ringbuf_write.lskel.h"
> +#include "test_ringbuf_overwrite.lskel.h"
>
>  #define EDONE 7777
>
> @@ -497,6 +498,77 @@ static void ringbuf_map_key_subtest(void)
>         test_ringbuf_map_key_lskel__destroy(skel_map_key);
>  }
>
> +static void ringbuf_overwrite_mode_subtest(void)
> +{
> +       unsigned long size, len1, len2, len3, len4, len5;
> +       unsigned long expect_avail_data, expect_prod_pos, expect_over_pos=
;
> +       struct test_ringbuf_overwrite_lskel *skel;
> +       int err;
> +
> +       skel =3D test_ringbuf_overwrite_lskel__open();
> +       if (!ASSERT_OK_PTR(skel, "skel_open"))
> +               return;
> +
> +       size =3D 0x1000;
> +       len1 =3D 0x800;
> +       len2 =3D 0x400;
> +       len3 =3D size - len1 - len2 - BPF_RINGBUF_HDR_SZ * 3; /* 0x3e8 */
> +       len4 =3D len3 - 8; /* 0x3e0 */
> +       len5 =3D len3; /* retry with len3 */
> +
> +       skel->maps.ringbuf.max_entries =3D size;
> +       skel->rodata->LEN1 =3D len1;
> +       skel->rodata->LEN2 =3D len2;
> +       skel->rodata->LEN3 =3D len3;
> +       skel->rodata->LEN4 =3D len4;
> +       skel->rodata->LEN5 =3D len5;
> +
> +       skel->bss->pid =3D getpid();
> +
> +       err =3D test_ringbuf_overwrite_lskel__load(skel);
> +       if (!ASSERT_OK(err, "skel_load"))
> +               goto cleanup;
> +
> +       err =3D test_ringbuf_overwrite_lskel__attach(skel);
> +       if (!ASSERT_OK(err, "skel_attach"))
> +               goto cleanup;
> +
> +       syscall(__NR_getpgid);
> +
> +       ASSERT_EQ(skel->bss->reserve1_fail, 0, "reserve 1");
> +       ASSERT_EQ(skel->bss->reserve2_fail, 0, "reserve 2");
> +       ASSERT_EQ(skel->bss->reserve3_fail, 1, "reserve 3");
> +       ASSERT_EQ(skel->bss->reserve4_fail, 0, "reserve 4");
> +       ASSERT_EQ(skel->bss->reserve5_fail, 0, "reserve 5");
> +
> +       CHECK(skel->bss->ring_size !=3D size,
> +             "check_ring_size", "exp %lu, got %lu\n",
> +             size, skel->bss->ring_size);

we don't use legacy CHECK() macros anymore, please use only ASSERT_xxx

> +
> +       expect_avail_data =3D len2 + len4 + len5 + 3 * BPF_RINGBUF_HDR_SZ=
;
> +       CHECK(skel->bss->avail_data !=3D expect_avail_data,
> +             "check_avail_size", "exp %lu, got %lu\n",
> +             expect_avail_data, skel->bss->avail_data);
> +
> +       CHECK(skel->bss->cons_pos !=3D 0,
> +             "check_cons_pos", "exp 0, got %lu\n",
> +             skel->bss->cons_pos);
> +
> +       expect_prod_pos =3D len1 + len2 + len4 + len5 + 4 * BPF_RINGBUF_H=
DR_SZ;
> +       CHECK(skel->bss->prod_pos !=3D expect_prod_pos,
> +             "check_prod_pos", "exp %lu, got %lu\n",
> +             expect_prod_pos, skel->bss->prod_pos);
> +
> +       expect_over_pos =3D len1 + BPF_RINGBUF_HDR_SZ;
> +       CHECK(skel->bss->over_pos !=3D expect_over_pos,
> +             "check_over_pos", "exp %lu, got %lu\n",
> +             (unsigned long)expect_over_pos, skel->bss->over_pos);
> +
> +       test_ringbuf_overwrite_lskel__detach(skel);
> +cleanup:
> +       test_ringbuf_overwrite_lskel__destroy(skel);
> +}
> +
>  void test_ringbuf(void)
>  {
>         if (test__start_subtest("ringbuf"))
> @@ -507,4 +579,6 @@ void test_ringbuf(void)
>                 ringbuf_map_key_subtest();
>         if (test__start_subtest("ringbuf_write"))
>                 ringbuf_write_subtest();
> +       if (test__start_subtest("ringbuf_overwrite_mode"))
> +               ringbuf_overwrite_mode_subtest();
>  }
> diff --git a/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c b=
/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
> new file mode 100644
> index 000000000000..da89ba12a75c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/test_ringbuf_overwrite.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (C) 2025. Huawei Technologies Co., Ltd */
> +
> +#include <linux/bpf.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_RINGBUF);
> +       __uint(map_flags, BPF_F_OVERWRITE);
> +} ringbuf SEC(".maps");
> +
> +int pid;
> +
> +const volatile unsigned long LEN1;
> +const volatile unsigned long LEN2;
> +const volatile unsigned long LEN3;
> +const volatile unsigned long LEN4;
> +const volatile unsigned long LEN5;
> +
> +long reserve1_fail =3D 0;
> +long reserve2_fail =3D 0;
> +long reserve3_fail =3D 0;
> +long reserve4_fail =3D 0;
> +long reserve5_fail =3D 0;
> +
> +unsigned long avail_data =3D 0;
> +unsigned long ring_size =3D 0;
> +unsigned long cons_pos =3D 0;
> +unsigned long prod_pos =3D 0;
> +unsigned long over_pos =3D 0;
> +
> +SEC("fentry/" SYS_PREFIX "sys_getpgid")
> +int test_overwrite_ringbuf(void *ctx)
> +{
> +       char *rec1, *rec2, *rec3, *rec4, *rec5;
> +       int cur_pid =3D bpf_get_current_pid_tgid() >> 32;
> +
> +       if (cur_pid !=3D pid)
> +               return 0;
> +
> +       rec1 =3D bpf_ringbuf_reserve(&ringbuf, LEN1, 0);
> +       if (!rec1) {
> +               reserve1_fail =3D 1;
> +               return 0;
> +       }
> +
> +       rec2 =3D bpf_ringbuf_reserve(&ringbuf, LEN2, 0);
> +       if (!rec2) {
> +               bpf_ringbuf_discard(rec1, 0);
> +               reserve2_fail =3D 1;
> +               return 0;
> +       }
> +
> +       rec3 =3D bpf_ringbuf_reserve(&ringbuf, LEN3, 0);
> +       /* expect failure */
> +       if (!rec3) {
> +               reserve3_fail =3D 1;
> +       } else {
> +               bpf_ringbuf_discard(rec1, 0);
> +               bpf_ringbuf_discard(rec2, 0);
> +               bpf_ringbuf_discard(rec3, 0);
> +               return 0;
> +       }
> +
> +       rec4 =3D bpf_ringbuf_reserve(&ringbuf, LEN4, 0);
> +       if (!rec4) {
> +               reserve4_fail =3D 1;
> +               bpf_ringbuf_discard(rec1, 0);
> +               bpf_ringbuf_discard(rec2, 0);
> +               return 0;
> +       }
> +
> +       bpf_ringbuf_submit(rec1, 0);
> +       bpf_ringbuf_submit(rec2, 0);
> +       bpf_ringbuf_submit(rec4, 0);
> +
> +       rec5 =3D bpf_ringbuf_reserve(&ringbuf, LEN5, 0);
> +       if (!rec5) {
> +               reserve5_fail =3D 1;
> +               return 0;
> +       }
> +
> +       for (int i =3D 0; i < LEN3; i++)
> +               rec5[i] =3D 0xdd;
> +
> +       bpf_ringbuf_submit(rec5, 0);
> +
> +       ring_size =3D bpf_ringbuf_query(&ringbuf, BPF_RB_RING_SIZE);
> +       avail_data =3D bpf_ringbuf_query(&ringbuf, BPF_RB_AVAIL_DATA);
> +       cons_pos =3D bpf_ringbuf_query(&ringbuf, BPF_RB_CONS_POS);
> +       prod_pos =3D bpf_ringbuf_query(&ringbuf, BPF_RB_PROD_POS);
> +       over_pos =3D bpf_ringbuf_query(&ringbuf, BPF_RB_OVER_POS);
> +
> +       return 0;
> +}
> --
> 2.43.0
>

