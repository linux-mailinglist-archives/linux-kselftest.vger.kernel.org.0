Return-Path: <linux-kselftest+bounces-38030-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CE8B13D3F
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 16:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22843A31B7
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Jul 2025 14:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7FF1E0B91;
	Mon, 28 Jul 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYBSi+d0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9773C1F;
	Mon, 28 Jul 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713307; cv=none; b=Zmvev2yeaFggq81WzSeDPmd3py17EZdWTTmxAAK0PL6vfS+hpV915BAf+xNYs52cE7IGt8OHA2/iVtsTTe6sp0XOmLbZIUPwge5mizRJdYJQyi9kgg6JeECXo2KEfhDisU3bJ4aqxWXrSm4OKYUwTser/hs3Tz/FBpUrWv6AAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713307; c=relaxed/simple;
	bh=JHq3vIkCgHeDKcQiWCYRVWazR4Ah0+AKyi5gR4tgoxg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y9pJuFCVPyTGui/+qqnRQa/45yPCQKlrQlowVHTJ4XpOsfxm2vGKVLfL73NqUz056dGAJyJ/w/X+dZ4DzgzKTL4bqidlhGi+LvLn3gW6JkDbxai777s/rN6AUEZeVytecbqQoYBy5NiwWxiFDIzyW7J5xCRsA1a4AWvJ6AUvuz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYBSi+d0; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b7825e2775so2245046f8f.2;
        Mon, 28 Jul 2025 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753713303; x=1754318103; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zgXOpBnkQ4iZJmI/4i1Fp2jD7StRjynuT5yJOTumF9w=;
        b=fYBSi+d0g7Ko0xYmQ2s0Oz9RbOob7r6FV6tCr6UoqSHypmUe8pjVpHD1pcMc7dEW3H
         0yEJWyi/a6anRa8b9jQ5tuNvnKB4XCqf5JfWMUwptyeGKhyPbKgA1dD6gsVmLCUJNoB7
         uL4Rc8W0lYodHLwx4rKqNUGf7Qumx3s4RSMhpPPzpd8llpdTO+XbgOZfduR9PBjTMEqs
         xROKyDR+qqqK0AqRA43RCa708RGEFO4RvhtROEOqLeABRM/eD5xAGXAMUSWJeBtcEalc
         uN6NkXFWMi0LtO2ajpQeDFCbvD25U7XXcc4FlXdLErVJo0wfgOA9iPrBSyWxL2KIqlBn
         znog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753713303; x=1754318103;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zgXOpBnkQ4iZJmI/4i1Fp2jD7StRjynuT5yJOTumF9w=;
        b=TF1Fxi3u/cwbOgQnSBq8GTgBHi7dlllcxxLWc5lBmca07CSqs2JCeezB6LsvjC7JFt
         ZKJdK51ipuGVOk7Dx04c+t8QtjmELt8u3v2R7dRDIxpznUCJDv1uwujqRLZsa6vPB2cU
         gQyVIZQcZSo2fR8+oe+A2fBnAVMGbO/QAjMUbASs4fglIaQcShDeIB5d7RLn0rI0EYw/
         XrmvGvUghdKWKK2IAI0EfnfP6mDVc4vKudXSgQsgh9FeU9x2TyaETegN4td+D+Q5obxY
         gNFRCiQMEzmXc+plV6Egha397KbrkVP8AXp0VONex17PsGwhOL006QA6bpE5CCQmajfR
         N0Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUe/jY6tiGW6IZXS+xN2/08yLvQopywhXLP28IdFKbv1SKU/HAhVX4rQNBXxtNu3mfrnuPQ2yDXseL+/faQ@vger.kernel.org, AJvYcCVgtnI3bohd4Uzs0dQurUDf0ZddEo10k7Fqi6ywiLVl/zMIvexhBgXGYGNXYy3DdOZ/zTL6F8yE@vger.kernel.org, AJvYcCW7a4IJZp36ft7AU1JXbaMRHqo5vn//c5R+tvrnG2fKZVO/aC3cIO0yfMlMhRI+FHtYJPY=@vger.kernel.org, AJvYcCWcv5IGa5NhgPqURPAs1QuKSOfx7Ey8LMGqr4SJYL58hJV5QvXGjaP5FkXWhjt0aw6BK+TQxS6X8GNhw8VhwWew@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+OsrOwz8Oipx5N2+tT/7qpO75WlXqP0g/TNB970MyoNKyocWh
	b7loekOjClXviUvWXqcDQPmlkDhS3OYXgdiFKWeXZO8OgalZmmTII2u5YYpFuNJXa9cnRZXwq+u
	+UE6QKUBR3jJkoyTxNupsmEcnGAaSUpg=
X-Gm-Gg: ASbGnct6WXBmgybKeWm0ubkfsTTpgf5EIm9qpcGvqJCa9WjHXlYnUd+TPh7gKs5+SnH
	wAmNH+K7HEhNTkn6xybN2FnBMVgyWxLZGPAzmtq6mtWqTahdC2z3hz0q2rgIdHRMkW1L336v5ay
	VB1ikqhVJN8LY2B3YExyXVccEj0AIFHfh147viTrpckUr5v4ShaJfie84dOxaUUfz8Ox5RmQthw
	Yan967d/mC2CVB95GZbKpKXEokJS2yanduNPQ==
X-Google-Smtp-Source: AGHT+IF49YPEE95fSBYP0WhhepSBJkmb39d2hVNN2UJOSESuqjKR5hZoxO3TBuVC60wm1yJhnj4EPS2bae/j2j+7Op4=
X-Received: by 2002:a05:6000:2505:b0:3b7:888d:8d9a with SMTP id
 ffacd0b85a97d-3b7888d90d8mr2544585f8f.29.1753713302783; Mon, 28 Jul 2025
 07:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722150152.1158205-1-matt@readmodwrite.com>
In-Reply-To: <20250722150152.1158205-1-matt@readmodwrite.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 28 Jul 2025 08:34:51 -0600
X-Gm-Features: Ac12FXwiGwnI_7rXroKnYooKuzupIS79D_vRKcUrWjVYmMw-EVie1gpHZqxUgGI
Message-ID: <CAADnVQ+rLJwKVbhd6LyGxDQwGUfg9EANcA5wOpA3C3pjaLdRQw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] selftests/bpf: Add LPM trie microbenchmarks
To: Matt Fleming <matt@readmodwrite.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:02=E2=80=AFAM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> From: Matt Fleming <mfleming@cloudflare.com>
>
> Add benchmarks for the standard set of operations: lookup, update,
> delete. Also, include a benchmark for trie_free() which is known to have
> terrible performance for maps with many entries.
>
> Benchmarks operate on tries without gaps in the key range, i.e. each
> test begins with a trie with valid keys in the range [0, nr_entries).
> This is intended to cause maximum branching when traversing the trie.

Please make a full description of what the test does,
since it's not trivial to decipher from the code.
If I'm reading it correctly, first, the user space
makes the LPM completely full and then lookup/update
use random key-s within range.

But delete looks different. It seems the kernel delete
operation can interleave with user space refilling the LPM,
so ...

>   lookup: throughput    7.423 =C2=B1 0.023 M ops/s (  7.423M ops/prod), l=
atency  134.710 ns/op
>   update: throughput    2.643 =C2=B1 0.015 M ops/s (  2.643M ops/prod), l=
atency  378.310 ns/op
>   delete: throughput    0.712 =C2=B1 0.008 M ops/s (  0.712M ops/prod), l=
atency 1405.152 ns/op

this comparison doesn't look like apples to apples,
since delete will include user space refill time.

>     free: throughput    0.574 =C2=B1 0.003 K ops/s (  0.574K ops/prod), l=
atency    1.743 ms/op

Does this measure the free-ing of full LPM ?

Please explain the benchmark logic in words.
Both in the commit log and the comments.

> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
> ---
>
> Changes in v3:
>
>  - Replace BPF_CORE_READ() with BPF_CORE_READ_STR_INTO() to avoid
>    gcc-bpf CI build failure
>
> Changes in v2:
>
>  - Add Jesper's Tested-by and Revewied-by tags
>  - Remove use of atomic_*() in favour of __sync_add_and_fetch()
>  - Use a file-local 'deleted_entries' in the DELETE op benchmark and add
>    a comment explaining why non-atomic accesses are safe.
>  - Bump 'hits' with the number of bpf_loop() loops actually executed
>
>  tools/testing/selftests/bpf/Makefile          |   2 +
>  tools/testing/selftests/bpf/bench.c           |  10 +
>  tools/testing/selftests/bpf/bench.h           |   1 +
>  .../selftests/bpf/benchs/bench_lpm_trie_map.c | 337 ++++++++++++++++++
>  .../selftests/bpf/progs/lpm_trie_bench.c      | 171 +++++++++
>  .../selftests/bpf/progs/lpm_trie_map.c        |  19 +
>  6 files changed, 540 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/benchs/bench_lpm_trie_map=
.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_bench.c
>  create mode 100644 tools/testing/selftests/bpf/progs/lpm_trie_map.c
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 910d8d6402ef..10a5f1d0fa41 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -815,6 +815,7 @@ $(OUTPUT)/bench_bpf_hashmap_lookup.o: $(OUTPUT)/bpf_h=
ashmap_lookup.skel.h
>  $(OUTPUT)/bench_htab_mem.o: $(OUTPUT)/htab_mem_bench.skel.h
>  $(OUTPUT)/bench_bpf_crypto.o: $(OUTPUT)/crypto_bench.skel.h
>  $(OUTPUT)/bench_sockmap.o: $(OUTPUT)/bench_sockmap_prog.skel.h
> +$(OUTPUT)/bench_lpm_trie_map.o: $(OUTPUT)/lpm_trie_bench.skel.h $(OUTPUT=
)/lpm_trie_map.skel.h
>  $(OUTPUT)/bench.o: bench.h testing_helpers.h $(BPFOBJ)
>  $(OUTPUT)/bench: LDLIBS +=3D -lm
>  $(OUTPUT)/bench: $(OUTPUT)/bench.o \
> @@ -836,6 +837,7 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
>                  $(OUTPUT)/bench_htab_mem.o \
>                  $(OUTPUT)/bench_bpf_crypto.o \
>                  $(OUTPUT)/bench_sockmap.o \
> +                $(OUTPUT)/bench_lpm_trie_map.o \
>                  #
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index ddd73d06a1eb..fd15f60fd5a8 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -284,6 +284,7 @@ extern struct argp bench_htab_mem_argp;
>  extern struct argp bench_trigger_batch_argp;
>  extern struct argp bench_crypto_argp;
>  extern struct argp bench_sockmap_argp;
> +extern struct argp bench_lpm_trie_map_argp;
>
>  static const struct argp_child bench_parsers[] =3D {
>         { &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> @@ -299,6 +300,7 @@ static const struct argp_child bench_parsers[] =3D {
>         { &bench_trigger_batch_argp, 0, "BPF triggering benchmark", 0 },
>         { &bench_crypto_argp, 0, "bpf crypto benchmark", 0 },
>         { &bench_sockmap_argp, 0, "bpf sockmap benchmark", 0 },
> +       { &bench_lpm_trie_map_argp, 0, "LPM trie map benchmark", 0 },
>         {},
>  };
>
> @@ -558,6 +560,10 @@ extern const struct bench bench_htab_mem;
>  extern const struct bench bench_crypto_encrypt;
>  extern const struct bench bench_crypto_decrypt;
>  extern const struct bench bench_sockmap;
> +extern const struct bench bench_lpm_trie_lookup;
> +extern const struct bench bench_lpm_trie_update;
> +extern const struct bench bench_lpm_trie_delete;
> +extern const struct bench bench_lpm_trie_free;
>
>  static const struct bench *benchs[] =3D {
>         &bench_count_global,
> @@ -625,6 +631,10 @@ static const struct bench *benchs[] =3D {
>         &bench_crypto_encrypt,
>         &bench_crypto_decrypt,
>         &bench_sockmap,
> +       &bench_lpm_trie_lookup,
> +       &bench_lpm_trie_update,
> +       &bench_lpm_trie_delete,
> +       &bench_lpm_trie_free,
>  };
>
>  static void find_benchmark(void)
> diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftest=
s/bpf/bench.h
> index 005c401b3e22..bea323820ffb 100644
> --- a/tools/testing/selftests/bpf/bench.h
> +++ b/tools/testing/selftests/bpf/bench.h
> @@ -46,6 +46,7 @@ struct bench_res {
>         unsigned long gp_ns;
>         unsigned long gp_ct;
>         unsigned int stime;
> +       unsigned long duration_ns;
>  };
>
>  struct bench {
> diff --git a/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c b/to=
ols/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
> new file mode 100644
> index 000000000000..435b5c7ceee9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/benchs/bench_lpm_trie_map.c
> @@ -0,0 +1,337 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Cloudflare */
> +
> +/*
> + * All of these benchmarks operate on tries with keys in the range
> + * [0, args.nr_entries), i.e. there are no gaps or partially filled
> + * branches of the trie for any key < args.nr_entries.
> + *
> + * This gives an idea of worst-case behaviour.
> + */
> +
> +#include <argp.h>
> +#include <linux/time64.h>
> +#include <linux/if_ether.h>
> +#include "lpm_trie_bench.skel.h"
> +#include "lpm_trie_map.skel.h"
> +#include "bench.h"
> +#include "testing_helpers.h"
> +
> +static struct ctx {
> +       struct lpm_trie_bench *bench;
> +} ctx;
> +
> +static struct {
> +       __u32 nr_entries;
> +       __u32 prefixlen;
> +} args =3D {
> +       .nr_entries =3D 10000,
> +       .prefixlen =3D 32,
> +};
> +
> +enum {
> +       ARG_NR_ENTRIES =3D 9000,
> +       ARG_PREFIX_LEN,
> +};
> +
> +static const struct argp_option opts[] =3D {
> +       { "nr_entries", ARG_NR_ENTRIES, "NR_ENTRIES", 0,
> +         "Number of unique entries in the LPM trie" },
> +       { "prefix_len", ARG_PREFIX_LEN, "PREFIX_LEN", 0,
> +         "Number of prefix bits to use in the LPM trie" },
> +       {},
> +};
> +
> +static error_t lpm_parse_arg(int key, char *arg, struct argp_state *stat=
e)
> +{
> +       long ret;
> +
> +       switch (key) {
> +       case ARG_NR_ENTRIES:
> +               ret =3D strtol(arg, NULL, 10);
> +               if (ret < 1 || ret > UINT_MAX) {
> +                       fprintf(stderr, "Invalid nr_entries count.");
> +                       argp_usage(state);
> +               }
> +               args.nr_entries =3D ret;
> +               break;
> +       case ARG_PREFIX_LEN:
> +               ret =3D strtol(arg, NULL, 10);
> +               if (ret < 1 || ret > UINT_MAX) {
> +                       fprintf(stderr, "Invalid prefix_len value.");
> +                       argp_usage(state);
> +               }
> +               args.prefixlen =3D ret;
> +               break;
> +       default:
> +               return ARGP_ERR_UNKNOWN;
> +       }
> +       return 0;
> +}
> +
> +const struct argp bench_lpm_trie_map_argp =3D {
> +       .options =3D opts,
> +       .parser =3D lpm_parse_arg,
> +};
> +
> +static void __lpm_validate(void)

why double underscore ?
Just lpm_validate() ?

> +{
> +       if (env.consumer_cnt !=3D 0) {
> +               fprintf(stderr, "benchmark doesn't support consumer!\n");
> +               exit(1);
> +       }
> +
> +       if ((1UL << args.prefixlen) < args.nr_entries) {
> +               fprintf(stderr, "prefix_len value too small for nr_entrie=
s!\n");
> +               exit(1);
> +       };
> +}
> +
> +enum { OP_LOOKUP =3D 1, OP_UPDATE, OP_DELETE, OP_FREE };
> +
> +static void lpm_delete_validate(void)
> +{
> +       __lpm_validate();
> +
> +       if (env.producer_cnt !=3D 1) {
> +               fprintf(stderr,
> +                       "lpm-trie-delete requires a single producer!\n");
> +               exit(1);
> +       }
> +}
> +
> +static void lpm_free_validate(void)
> +{
> +       __lpm_validate();
> +
> +       if (env.producer_cnt !=3D 1) {
> +               fprintf(stderr, "lpm-trie-free requires a single producer=
!\n");
> +               exit(1);
> +       }
> +}
> +
> +static void fill_map(int map_fd)
> +{
> +       int i, err;
> +
> +       for (i =3D 0; i < args.nr_entries; i++) {
> +               struct trie_key {
> +                       __u32 prefixlen;
> +                       __u32 data;
> +               } key =3D { args.prefixlen, i };
> +               __u32 val =3D 1;
> +
> +               err =3D bpf_map_update_elem(map_fd, &key, &val, BPF_NOEXI=
ST);
> +               if (err) {
> +                       fprintf(stderr, "failed to add key %d to map: %d\=
n",
> +                               key.data, -err);
> +                       exit(1);
> +               }
> +       }
> +}
> +
> +static void __lpm_setup(void)
> +{
> +       ctx.bench =3D lpm_trie_bench__open_and_load();
> +       if (!ctx.bench) {
> +               fprintf(stderr, "failed to open skeleton\n");
> +               exit(1);
> +       }
> +
> +       ctx.bench->bss->nr_entries =3D args.nr_entries;
> +       ctx.bench->bss->prefixlen =3D args.prefixlen;
> +
> +       if (lpm_trie_bench__attach(ctx.bench)) {
> +               fprintf(stderr, "failed to attach skeleton\n");
> +               exit(1);
> +       }
> +}
> +
> +static void lpm_setup(void)
> +{
> +       int fd;
> +
> +       __lpm_setup();
> +
> +       fd =3D bpf_map__fd(ctx.bench->maps.trie_map);
> +       fill_map(fd);
> +}

lpm_setup() vs __lpm_setup() are too cryptic.
The name of the function should explain at a high level
what it does.

> +
> +static void lpm_lookup_setup(void)
> +{
> +       lpm_setup();
> +
> +       ctx.bench->bss->op =3D OP_LOOKUP;
> +}
> +
> +static void lpm_update_setup(void)
> +{
> +       lpm_setup();
> +
> +       ctx.bench->bss->op =3D OP_UPDATE;
> +}
> +
> +static void lpm_delete_setup(void)
> +{
> +       lpm_setup();
> +
> +       ctx.bench->bss->op =3D OP_DELETE;
> +}
> +
> +static void lpm_free_setup(void)
> +{
> +       __lpm_setup();

... then the reader won't need to scratch the head
why this one is __ and other don't.

> +       ctx.bench->bss->op =3D OP_FREE;
> +}
> +
> +static void lpm_measure(struct bench_res *res)
> +{
> +       res->hits =3D atomic_swap(&ctx.bench->bss->hits, 0);
> +       res->duration_ns =3D atomic_swap(&ctx.bench->bss->duration_ns, 0)=
;
> +}
> +
> +/* For LOOKUP, UPDATE, and DELETE */
> +static void *lpm_producer(void *unused __always_unused)
> +{
> +       int err;
> +       char in[ETH_HLEN]; /* unused */
> +
> +       LIBBPF_OPTS(bpf_test_run_opts, opts, .data_in =3D in,
> +                   .data_size_in =3D sizeof(in), .repeat =3D 1, );
> +
> +       while (true) {
> +               int fd =3D bpf_program__fd(ctx.bench->progs.run_bench);
> +               err =3D bpf_prog_test_run_opts(fd, &opts);
> +               if (err) {
> +                       fprintf(stderr, "failed to run BPF prog: %d\n", e=
rr);
> +                       exit(1);
> +               }
> +
> +               if (opts.retval < 0) {
> +                       fprintf(stderr, "BPF prog returned error: %d\n",
> +                               opts.retval);
> +                       exit(1);
> +               }
> +
> +               if (ctx.bench->bss->op =3D=3D OP_DELETE && opts.retval =
=3D=3D 1) {
> +                       /* trie_map needs to be refilled */
> +                       fill_map(bpf_map__fd(ctx.bench->maps.trie_map));
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static void *lpm_free_producer(void *unused __always_unused)
> +{
> +       while (true) {
> +               struct lpm_trie_map *skel;
> +
> +               skel =3D lpm_trie_map__open_and_load();
> +               if (!skel) {
> +                       fprintf(stderr, "failed to open skeleton\n");
> +                       exit(1);
> +               }
> +
> +               fill_map(bpf_map__fd(skel->maps.trie_free_map));
> +               lpm_trie_map__destroy(skel);
> +       }
> +
> +       return NULL;
> +}
> +
> +static void free_ops_report_progress(int iter, struct bench_res *res,
> +                                    long delta_ns)
> +{
> +       double hits_per_sec, hits_per_prod;
> +       double rate_divisor =3D 1000.0;
> +       char rate =3D 'K';
> +
> +       hits_per_sec =3D res->hits / (res->duration_ns / (double)NSEC_PER=
_SEC) /
> +                      rate_divisor;
> +       hits_per_prod =3D hits_per_sec / env.producer_cnt;
> +
> +       printf("Iter %3d (%7.3lfus): ", iter,
> +              (delta_ns - NSEC_PER_SEC) / 1000.0);
> +       printf("hits %8.3lf%c/s (%7.3lf%c/prod)\n", hits_per_sec, rate,
> +              hits_per_prod, rate);
> +}
> +
> +static void free_ops_report_final(struct bench_res res[], int res_cnt)
> +{
> +       double hits_mean =3D 0.0, hits_stddev =3D 0.0;
> +       double lat_divisor =3D 1000000.0;
> +       double rate_divisor =3D 1000.0;
> +       const char *unit =3D "ms";
> +       double latency =3D 0.0;
> +       char rate =3D 'K';
> +       int i;
> +
> +       for (i =3D 0; i < res_cnt; i++) {
> +               double val =3D res[i].hits / rate_divisor /
> +                            (res[i].duration_ns / (double)NSEC_PER_SEC);
> +               hits_mean +=3D val / (0.0 + res_cnt);
> +               latency +=3D res[i].duration_ns / res[i].hits / (0.0 + re=
s_cnt);
> +       }
> +
> +       if (res_cnt > 1) {
> +               for (i =3D 0; i < res_cnt; i++) {
> +                       double val =3D
> +                               res[i].hits / rate_divisor /
> +                               (res[i].duration_ns / (double)NSEC_PER_SE=
C);
> +                       hits_stddev +=3D (hits_mean - val) * (hits_mean -=
 val) /
> +                                      (res_cnt - 1.0);
> +               }
> +
> +               hits_stddev =3D sqrt(hits_stddev);
> +       }
> +       printf("Summary: throughput %8.3lf \u00B1 %5.3lf %c ops/s (%7.3lf=
%c ops/prod), ",
> +              hits_mean, hits_stddev, rate, hits_mean / env.producer_cnt=
,
> +              rate);
> +       printf("latency %8.3lf %s/op\n",
> +              latency / lat_divisor / env.producer_cnt, unit);
> +}
> +
> +const struct bench bench_lpm_trie_lookup =3D {
> +       .name =3D "lpm-trie-lookup",
> +       .argp =3D &bench_lpm_trie_map_argp,
> +       .validate =3D __lpm_validate,
> +       .setup =3D lpm_lookup_setup,
> +       .producer_thread =3D lpm_producer,
> +       .measure =3D lpm_measure,
> +       .report_progress =3D ops_report_progress,
> +       .report_final =3D ops_report_final,
> +};
> +
> +const struct bench bench_lpm_trie_update =3D {
> +       .name =3D "lpm-trie-update",
> +       .argp =3D &bench_lpm_trie_map_argp,
> +       .validate =3D __lpm_validate,
> +       .setup =3D lpm_update_setup,
> +       .producer_thread =3D lpm_producer,
> +       .measure =3D lpm_measure,
> +       .report_progress =3D ops_report_progress,
> +       .report_final =3D ops_report_final,
> +};
> +
> +const struct bench bench_lpm_trie_delete =3D {
> +       .name =3D "lpm-trie-delete",
> +       .argp =3D &bench_lpm_trie_map_argp,
> +       .validate =3D lpm_delete_validate,
> +       .setup =3D lpm_delete_setup,
> +       .producer_thread =3D lpm_producer,
> +       .measure =3D lpm_measure,
> +       .report_progress =3D ops_report_progress,
> +       .report_final =3D ops_report_final,
> +};
> +
> +const struct bench bench_lpm_trie_free =3D {
> +       .name =3D "lpm-trie-free",
> +       .argp =3D &bench_lpm_trie_map_argp,
> +       .validate =3D lpm_free_validate,
> +       .setup =3D lpm_free_setup,
> +       .producer_thread =3D lpm_free_producer,
> +       .measure =3D lpm_measure,
> +       .report_progress =3D free_ops_report_progress,
> +       .report_final =3D free_ops_report_final,
> +};
> diff --git a/tools/testing/selftests/bpf/progs/lpm_trie_bench.c b/tools/t=
esting/selftests/bpf/progs/lpm_trie_bench.c
> new file mode 100644
> index 000000000000..522e1cbef490
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/lpm_trie_bench.c
> @@ -0,0 +1,171 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2025 Cloudflare */
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_misc.h"
> +
> +#define BPF_OBJ_NAME_LEN 16U
> +#define MAX_ENTRIES 100000000
> +#define NR_LOOPS 10000
> +
> +struct trie_key {
> +       __u32 prefixlen;
> +       __u32 data;
> +};
> +
> +char _license[] SEC("license") =3D "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_HASH);
> +       __uint(max_entries, 512);
> +       __type(key, struct bpf_map *);
> +       __type(value, __u64);
> +} latency_free_start SEC(".maps");
> +
> +/* Filled by userspace. See fill_map() in bench_lpm_trie_map.c */
> +struct {
> +       __uint(type, BPF_MAP_TYPE_LPM_TRIE);
> +       __type(key, struct trie_key);
> +       __type(value, __u32);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __uint(max_entries, MAX_ENTRIES);
> +} trie_map SEC(".maps");
> +
> +long hits;
> +long duration_ns;
> +
> +/* Configured from userspace */
> +__u32 nr_entries;
> +__u32 prefixlen;
> +__u8 op;
> +
> +SEC("fentry/bpf_map_free_deferred")
> +int BPF_PROG(trie_free_entry, struct work_struct *work)
> +{
> +       struct bpf_map *map =3D container_of(work, struct bpf_map, work);
> +       char name[BPF_OBJ_NAME_LEN];
> +       u32 map_type;
> +       __u64 val;
> +
> +       map_type =3D BPF_CORE_READ(map, map_type);
> +       if (map_type !=3D BPF_MAP_TYPE_LPM_TRIE)
> +               return 0;
> +
> +       /*
> +        * Ideally we'd have access to the map ID but that's already
> +        * freed before we enter trie_free().
> +        */
> +       BPF_CORE_READ_STR_INTO(&name, map, name);
> +       if (bpf_strncmp(name, BPF_OBJ_NAME_LEN, "trie_free_map"))
> +               return 0;
> +
> +       val =3D bpf_ktime_get_ns();
> +       bpf_map_update_elem(&latency_free_start, &map, &val, BPF_ANY);

Looks like there is only one lpm map.
What's the point of that extra map ?
Just have a global var for start time ?

> +       return 0;
> +}
> +
> +SEC("fexit/bpf_map_free_deferred")
> +int BPF_PROG(trie_free_exit, struct work_struct *work)
> +{
> +       struct bpf_map *map =3D container_of(work, struct bpf_map, work);
> +       __u64 *val;
> +
> +       val =3D bpf_map_lookup_elem(&latency_free_start, &map);
> +       if (val) {
> +               __sync_add_and_fetch(&duration_ns, bpf_ktime_get_ns() - *=
val);
> +               __sync_add_and_fetch(&hits, 1);
> +               bpf_map_delete_elem(&latency_free_start, &map);
> +       }
> +
> +       return 0;
> +}
> +
> +static void gen_random_key(struct trie_key *key)
> +{
> +       key->prefixlen =3D prefixlen;
> +       key->data =3D bpf_get_prandom_u32() % nr_entries;

bpf_get_prandom_u32() is not free
and modulo operation isn't free either.
The benchmark includes their time.
It's ok to have it, but add a mode where the bench
tests linear lookup/update too with simple key.data++

> +}
> +
> +static int lookup(__u32 index, __u32 *unused)
> +{
> +       struct trie_key key;
> +
> +       gen_random_key(&key);
> +       bpf_map_lookup_elem(&trie_map, &key);
> +       return 0;
> +}
> +
> +static int update(__u32 index, __u32 *unused)
> +{
> +       struct trie_key key;
> +       u32 val =3D bpf_get_prandom_u32();
> +
> +       gen_random_key(&key);
> +       bpf_map_update_elem(&trie_map, &key, &val, BPF_EXIST);

Since the map suppose to full before we start all keys
should be there, right?
Let's add a sanity check that update() succeeds.

> +       return 0;
> +}
> +
> +static __u32 deleted_entries;
> +
> +static int delete (__u32 index, bool *need_refill)
> +{
> +       struct trie_key key =3D {
> +               .data =3D deleted_entries,
> +               .prefixlen =3D prefixlen,
> +       };
> +
> +       bpf_map_delete_elem(&trie_map, &key);
> +
> +       /* Do we need to refill the map? */
> +       if (++deleted_entries =3D=3D nr_entries) {
> +               /*
> +                * Atomicity isn't required because DELETE only supports
> +                * one producer running concurrently. What we need is a
> +                * way to track how many entries have been deleted from
> +                * the trie between consecutive invocations of the BPF
> +                * prog because a single bpf_loop() call might not
> +                * delete all entries, e.g. when NR_LOOPS < nr_entries.
> +                */
> +               deleted_entries =3D 0;
> +               *need_refill =3D true;
> +               return 1;

This early break is another reason that makes
'delete' op different from 'lookup/update'.
Pls make all 3 consistent, so they can be compared to each other.

--
pw-bot: cr

