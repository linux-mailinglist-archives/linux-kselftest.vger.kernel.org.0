Return-Path: <linux-kselftest+bounces-41984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B63B8B756
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Sep 2025 00:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80BB917FFC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Sep 2025 22:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757CA29E112;
	Fri, 19 Sep 2025 22:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3BERBnF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8381DDC1B
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 22:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758320156; cv=none; b=fYCAorgmJf7UXSas+0VkUM7iQJqAAe9eVhjC1CfXjYUyKpHAn7GQ/fb/ek3QI/IeR1QIDysEACf6dyJPEPpW7CL9HoDo4jRVq4r3s6r5FmTyWv40sEsvl49YtMFfUjvtr6tgRScdvYIgnHdGqK7EGri0EoY5UocpZa38vcDpAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758320156; c=relaxed/simple;
	bh=XyootmgLv94+Gy6k5KdIOn9j4pUkYBifYt9ZDg77pwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U/FyyLvNCnWdapDWo+6NUR+t/928fH20faZbCLmZp9f5Nsj4lW1ofb331fWCJrRsvr35IHa0Un0ROQAXn+z3nFWQi26quFe8i/AtjKKPo5L5qkPDMAEOOjW7YAjWLvxa5icVRtdvuWqVpq7TTk1wqoxy8mspfil/1GAFHN66Q/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3BERBnF; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso619915a12.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Sep 2025 15:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758320154; x=1758924954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujx1Ir738tmFjVSQJD/txn3QAD2H99LyLRg03qE+w+U=;
        b=S3BERBnFB+Mai/CBOA0BzqplZPuGeJGBtYcXWtPSdt23T8ppFTHavgZYrhnqITD9g9
         ywfcXjGAb+XBNyuGGvdAd0kw2HMv0YRfewn3dSeHn4Y6BPgXxQhanZP32ytINiYh+bA9
         bHSA29IAWekqhW1DgtmYw0uD8CSQ/NP5QlN++VZfuIXkurSGhGq635ThFmUFnLsyatT/
         YZShP8drfPouVX2oOHtPgstu+3CKL2fo4j8CKHv1H6qJI6Lc7CpW63cD90wA9Ngh8Cln
         ED8+j7xdh2NHs7p43Xh1WhzADCuo8DviIFUxmAQnhsGOl+jSGeVmRIm+UDVCaAay35+Y
         7hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758320154; x=1758924954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujx1Ir738tmFjVSQJD/txn3QAD2H99LyLRg03qE+w+U=;
        b=FpvkXSmQOHAjkMJ4RhozIs1HSDWeunRGuWmBrZMfFdf/aW0hoo6IUPMzeMvcE19JmW
         916OWMErFvFImsnf6vj3Ym40bzge9BCeQWQL+Tgy2FQYfuiLohEsBW6F63oCoFX0c5hS
         PIZOswLh7wuvn4hLzXydsW/FDnLLyhnmPlEqUMljSlRmscrVZ1S/xtY3LK4nAja/VRJh
         t4ODLHf6MZP3QgnW7f9Pw6UZRUy+Cv11fTAn7KFhJdunlIl3rbl34UmwWwNeBJq3tF9j
         EdMwRCRPaLSQlFTVTgtP4BUNykMQReGCLRr31Il7cTywn3Sd0dwYchR9wjHL0DSu8LJL
         FAzA==
X-Forwarded-Encrypted: i=1; AJvYcCU6k3DFhp23hyOGW/ebrrno09zyeOV+fhe0vsmH5ZMebPNZdWYU2F4PCiNyYtoDuJPlxfiSawCMHod+F+R5ASo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KDFSJ1TfpD/xP+Ir4DLv1D+H4g25z7opAjit9i8Hk6+KgALI
	yi3ZaEGsUEjkY4jm2HndnGsQXUGSa8o+slF6R/BwxYis2hSk/uLqVBVdUVZ3EvREy/ZzZ9hyOz8
	N46zAS0XCkNW0frPYm3M8NMg21ko90kQmQw==
X-Gm-Gg: ASbGncuCFeulKibBt8lfSilb6JqvSDsqJKYkgjZgKVBoo8nNnia4jary9RSxhJekaKV
	FD9OAqf1g25SZ3+k7rv6EuoqSAT2Y2sUrm1vWdenWZdaR1VAYkSMSCtrC8wDQwrR4BGxMS+ii4O
	h19gZzO4h3tMrjJ70FFuquHD6tHbnMBQQTwpAb03UB3BsOaU/y4mjrwSOyLbZFbyIGGRtTAPy+C
	8uvpV8Lx0pCV/51wJveXNytmJRfFCek1A==
X-Google-Smtp-Source: AGHT+IECKd/GHWseyORxZ91dOYPAhKL/+IkDewnJuGx1GuQxt/3H3AcpfQSdLAzIhOcZAXVXX8xVdzmgPU4zHvgW1Rk=
X-Received: by 2002:a17:90b:3905:b0:32e:9da9:3e6c with SMTP id
 98e67ed59e1d1-3309834b4f7mr5723487a91.23.1758320153934; Fri, 19 Sep 2025
 15:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905150641.2078838-1-xukuohai@huaweicloud.com> <20250905150641.2078838-4-xukuohai@huaweicloud.com>
In-Reply-To: <20250905150641.2078838-4-xukuohai@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Sep 2025 15:15:38 -0700
X-Gm-Features: AS18NWBOa3kRS4CIxnhQ1iKphnhHAfhyMXzVDLE5JDbhoX6cwJq4muyT3qZ6bWw
Message-ID: <CAEf4Bzb65VnL5nESxkGGZCgW0Ow+apwTsqzpFv2s+rd3Y6YkAQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] selftests/bpf/benchs: Add producer and
 overwrite bench for ring buffer
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
> Add rb-prod test for bpf ring buffer to bench producer performance
> without counsumer thread. And add --rb-overwrite option to bench
> ring buffer in overwrite mode.
>
> For reference, below are bench numbers collected from x86_64 and
> arm64 CPUs.
>
> - AMD EPYC 9654 (x86_64)
>
>   Ringbuf, overwrite mode with multi-producer contention, no consumer
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-prod nr_prod 1    32.295 =C2=B1 0.004M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-prod nr_prod 2    9.591 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 3    8.895 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 4    9.206 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 8    9.220 =C2=B1 0.002M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 12   4.595 =C2=B1 0.022M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 16   4.348 =C2=B1 0.016M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 20   3.957 =C2=B1 0.017M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 24   3.787 =C2=B1 0.014M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 28   3.603 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 32   3.707 =C2=B1 0.011M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 36   3.562 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 40   3.616 =C2=B1 0.012M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 44   3.598 =C2=B1 0.016M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 48   3.555 =C2=B1 0.014M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 52   3.463 =C2=B1 0.020M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> - HiSilicon Kunpeng 920 (arm64)
>
>   Ringbuf, overwrite mode with multi-producer contention, no consumer
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   rb-prod nr_prod 1    14.687 =C2=B1 0.058M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-prod nr_prod 2    22.263 =C2=B1 0.007M/s (drops 0.000 =C2=B1 0.000M/=
s)
>   rb-prod nr_prod 3    5.736 =C2=B1 0.003M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 4    4.934 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 8    4.661 =C2=B1 0.001M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 12   3.753 =C2=B1 0.013M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 16   3.706 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 20   3.660 =C2=B1 0.015M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 24   3.610 =C2=B1 0.016M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 28   3.238 =C2=B1 0.010M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 32   3.270 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 36   2.892 =C2=B1 0.021M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 40   2.995 =C2=B1 0.018M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 44   2.830 =C2=B1 0.019M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 48   2.877 =C2=B1 0.015M/s (drops 0.000 =C2=B1 0.000M/s=
)
>   rb-prod nr_prod 52   2.814 =C2=B1 0.015M/s (drops 0.000 =C2=B1 0.000M/s=
)
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  tools/testing/selftests/bpf/bench.c           |  2 +
>  .../selftests/bpf/benchs/bench_ringbufs.c     | 95 +++++++++++++++++--
>  .../bpf/benchs/run_bench_ringbufs.sh          |  4 +
>  .../selftests/bpf/progs/ringbuf_bench.c       | 10 ++
>  4 files changed, 103 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index bd29bb2e6cb5..a98063f6436a 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -541,6 +541,7 @@ extern const struct bench bench_trig_uretprobe_multi_=
nop5;
>
>  extern const struct bench bench_rb_libbpf;
>  extern const struct bench bench_rb_custom;
> +extern const struct bench bench_rb_prod;
>  extern const struct bench bench_pb_libbpf;
>  extern const struct bench bench_pb_custom;
>  extern const struct bench bench_bloom_lookup;
> @@ -617,6 +618,7 @@ static const struct bench *benchs[] =3D {
>         /* ringbuf/perfbuf benchmarks */
>         &bench_rb_libbpf,
>         &bench_rb_custom,
> +       &bench_rb_prod,
>         &bench_pb_libbpf,
>         &bench_pb_custom,
>         &bench_bloom_lookup,
> diff --git a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c b/tools/=
testing/selftests/bpf/benchs/bench_ringbufs.c
> index e1ee979e6acc..6d58479fac91 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_ringbufs.c
> @@ -19,6 +19,7 @@ static struct {
>         int ringbuf_sz; /* per-ringbuf, in bytes */
>         bool ringbuf_use_output; /* use slower output API */
>         int perfbuf_sz; /* per-CPU size, in pages */
> +       bool overwrite;
>  } args =3D {
>         .back2back =3D false,
>         .batch_cnt =3D 500,
> @@ -27,6 +28,7 @@ static struct {
>         .ringbuf_sz =3D 512 * 1024,
>         .ringbuf_use_output =3D false,
>         .perfbuf_sz =3D 128,
> +       .overwrite =3D false,
>  };
>
>  enum {
> @@ -35,6 +37,7 @@ enum {
>         ARG_RB_BATCH_CNT =3D 2002,
>         ARG_RB_SAMPLED =3D 2003,
>         ARG_RB_SAMPLE_RATE =3D 2004,
> +       ARG_RB_OVERWRITE =3D 2005,
>  };
>
>  static const struct argp_option opts[] =3D {
> @@ -43,6 +46,7 @@ static const struct argp_option opts[] =3D {
>         { "rb-batch-cnt", ARG_RB_BATCH_CNT, "CNT", 0, "Set BPF-side recor=
d batch count"},
>         { "rb-sampled", ARG_RB_SAMPLED, NULL, 0, "Notification sampling"}=
,
>         { "rb-sample-rate", ARG_RB_SAMPLE_RATE, "RATE", 0, "Notification =
sample rate"},
> +       { "rb-overwrite", ARG_RB_OVERWRITE, NULL, 0, "Overwrite mode"},
>         {},
>  };
>
> @@ -72,6 +76,9 @@ static error_t parse_arg(int key, char *arg, struct arg=
p_state *state)
>                         argp_usage(state);
>                 }
>                 break;
> +       case ARG_RB_OVERWRITE:
> +               args.overwrite =3D true;
> +               break;
>         default:
>                 return ARGP_ERR_UNKNOWN;
>         }
> @@ -95,8 +102,30 @@ static inline void bufs_trigger_batch(void)
>
>  static void bufs_validate(void)
>  {
> -       if (env.consumer_cnt !=3D 1) {
> -               fprintf(stderr, "rb-libbpf benchmark needs one consumer!\=
n");
> +       bool bench_prod =3D !strcmp(env.bench_name, "rb-prod");
> +
> +       if (args.overwrite && !bench_prod) {
> +               fprintf(stderr, "overwite mode only works with benchmakr =
rb-prod!\n");
> +               exit(1);
> +       }
> +
> +       if (bench_prod && env.consumer_cnt !=3D 0) {
> +               fprintf(stderr, "rb-prod benchmark does not need consumer=
!\n");
> +               exit(1);
> +       }
> +
> +       if (bench_prod && args.back2back) {
> +               fprintf(stderr, "back-to-back mode makes no sense for rb-=
prod!\n");
> +               exit(1);
> +       }
> +
> +       if (bench_prod && args.sampled) {
> +               fprintf(stderr, "sampling mode makes no sense for rb-prod=
!\n");
> +               exit(1);
> +       }
> +
> +       if (!bench_prod && env.consumer_cnt !=3D 1) {
> +               fprintf(stderr, "benchmarks excluding rb-prod need one co=
nsumer!\n");
>                 exit(1);
>         }
>
> @@ -132,8 +161,10 @@ static void ringbuf_libbpf_measure(struct bench_res =
*res)
>         res->drops =3D atomic_swap(&ctx->skel->bss->dropped, 0);
>  }
>
> -static struct ringbuf_bench *ringbuf_setup_skeleton(void)
> +static struct ringbuf_bench *ringbuf_setup_skeleton(int bench_prod)

int because C doesn't support bool?...

but really, do we need another benchmark just to set overwritable
mode?... can't you adapt existing benchmarks to optionally set
overwritable mode?


(and please drop sdf@google.com from CC for the next revision, that
email doesn't exist anymore)

[...]

