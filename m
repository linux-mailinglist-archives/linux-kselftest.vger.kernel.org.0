Return-Path: <linux-kselftest+bounces-14247-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7F993C957
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 22:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C674E28200B
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2024 20:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8799876036;
	Thu, 25 Jul 2024 20:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iU+DwArH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920211711;
	Thu, 25 Jul 2024 20:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721938182; cv=none; b=STA24xxQ8JLURhGWbzLcqdusmHheambgkSXgQTmlWCcToeWoViy+Y3zxwVzRwLA1dWdapLOUyULHn/ULypBYOfoM8q1IrPuJk/+pZqGJ1ytwWDhf23lnnvBkAOHbkwwH1jjMln1SpOhLiW/vQAhH+Mr9KEZqYNPFo+Zqh9wEjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721938182; c=relaxed/simple;
	bh=VPziO8mEhGzn726UbCSc+TCV2Yiq+ssTJcD3MLV7t8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f/zaP7zIaC/SUXtxXhewYnaQZfDdxaHAdmEgS5VL6KYzfYVieU6wJpU6mv6RRu/2x/NlCSlbfmF8Totpv0YFhiNomhWykFRb21dzmLha4Ln2UXXyeN4k1TAFAxqTecdqqEqGRztvrdfUAI1bbj2d+t0yyL4NUA0xpzsDHPBjkQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iU+DwArH; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a167b9df7eso1859882a12.3;
        Thu, 25 Jul 2024 13:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721938179; x=1722542979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCKlI/GWAeCRE4lJ3t0pMeCjIhjkcftFDxOfrprZe7c=;
        b=iU+DwArHtJMUn/hrZaQL87Z8WTiPoPkiackFXVlwKzNUWR9xJ29upMbx5PriC50m0o
         YBCSaz29mnx5xzrp6HL4Ms63BsnhndCCev8ToDXhYQWgKVJ8P95BoWCHQKvEOPo8vUsM
         A4aOUf1Nkg3U1+VO6Bi1P8b6PpWtGZSrHKt02GAYrAdrjED/AOKeO060SjAVxduEe4Sh
         ALbPKe3pzSA78YvwLLYQI9TYKRT+U/0vIiuTDaE5/UolZCaj5UoXT64iCWpOLns0DeNC
         MoAlqWi8/NJiGOMeqhZwkDcti1tQCWjgBq/nXW3+1b/rPeO9IgfaxbhWCPkZDypqoyS8
         G4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721938179; x=1722542979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCKlI/GWAeCRE4lJ3t0pMeCjIhjkcftFDxOfrprZe7c=;
        b=um9X9a4fq6HfmJ/5cE3Pmt1/RzUyiMgKNCUkpc1DVoA+NqdcP7lfbrBQvwnSxkSY/n
         whjZyZqzq5kgJTcVed+0yQqNQJ2Ehvny3qmTuq+inGwLN92gtWTndOgGpJ+ohKHQ/VbE
         KA9AeULf9jTr4jxxTxQ4h6BKU17wq4Z78runCcUaiTv+88sqYHQbQ0vIKSwos0xFldOJ
         Xp7K5QStmnbq077lvyI/TDadlm5nYcdbwKwDEZzJtrp05Axzps7pKVowOyjOlfoI8xi+
         meNQyfsR1MOxHaHdNzI/GVFNZTTvfqK6IUWbbrltKBdKGwpTbjSDR+N4J7qGN57rrL7m
         AlSQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHZZKbjhGtoCMWLu+DsVK/5W4jwwqw+0/DqT8eLTnc56JoaiNh46Am3Vc5M98K7sfWXJjla2A8FpUlbetfuQwDTD+jzxQIXRkvwx8fkqebqDA7CB5qgd3Kk+oDY9Ra8Qt0njbqlwSw
X-Gm-Message-State: AOJu0YzO1b65mNF+HtaTH7IDN2Du2c+s6Uothtdcild9wCHMx5nC6sP9
	CTjyaNMcpVJeutM0J+FZVlFBUvCVD9i4972N81NUtDszkg4o8USg7u0PS8bdcEZYY9Y3heBIA8+
	JKIBoqT1F+C56SMI8N1WCt7w7gfA=
X-Google-Smtp-Source: AGHT+IEuJKdMSByanA+5ZVKD+IS3VA37sPTZqmxRUuhzqJ6s3UxeMZjten0Pq2l9EAInLY404dLMJr2tF2vvrpMn7t0=
X-Received: by 2002:a17:906:ee82:b0:a77:cf9d:f49b with SMTP id
 a640c23a62f3a-a7ac52e10f2mr295796366b.54.1721938178512; Thu, 25 Jul 2024
 13:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721903630.git.tony.ambardar@gmail.com> <b488b997e1b966f6d35a2767da738fc9a44023a8.1721903630.git.tony.ambardar@gmail.com>
In-Reply-To: <b488b997e1b966f6d35a2767da738fc9a44023a8.1721903630.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 Jul 2024 13:09:24 -0700
Message-ID: <CAEf4Bzbb3hPzKN2-wEg24JNMaJsUDiwpx9=xjvOK7TnAaSk4wQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/8] selftests/bpf: Fix arg parsing in
 veristat, test_progs
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
> Current code parses arguments with strtok_r() using a construct like
>
>     char *state =3D NULL;
>     while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
>         ...
>     }
>
> where logic assumes the 'state' var can distinguish between first and
> subsequent strtok_r() calls, and adjusts parameters accordingly. However,
> 'state' is strictly internal context for strtok_r() and no such assumptio=
ns
> are supported in the man page. Moreover, the exact behaviour of 'state'
> depends on the libc implementation, making the above code fragile.
>
> Indeed, invoking "./test_progs -t <test_name>" on mips64el/musl will hang=
,
> with the above code in an infinite loop.
>
> Similarly, we see strange behaviour running 'veristat' on mips64el/musl:
>
>     $ ./veristat -e file,prog,verdict,insns -C two-ok add-failure
>     Can't specify more than 9 stats
>
> Rewrite code using a 'for' loop without logic dependent on var 'state', t=
he
> same approach already used in cgroup_helpers.c.
>
> Fixes: 61ddff373ffa ("selftests/bpf: Improve by-name subtest selection lo=
gic in prog_tests")
> Fixes: 394169b079b5 ("selftests/bpf: add comparison mode to veristat")
> Fixes: c8bc5e050976 ("selftests/bpf: Add veristat tool for mass-verifying=
 BPF object files")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/testing_helpers.c | 2 +-
>  tools/testing/selftests/bpf/veristat.c        | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testin=
g/selftests/bpf/testing_helpers.c
> index ac7c66f4fc7b..2a73b72feb18 100644
> --- a/tools/testing/selftests/bpf/testing_helpers.c
> +++ b/tools/testing/selftests/bpf/testing_helpers.c
> @@ -227,7 +227,7 @@ int parse_test_list(const char *s,
>         if (!input)
>                 return -ENOMEM;
>
> -       while ((test_spec =3D strtok_r(state ? NULL : input, ",", &state)=
)) {
> +       for (test_spec =3D strtok_r(input, ",", &state); test_spec; test_=
spec =3D strtok_r(NULL, ",", &state)) {

oh, this is so long and verbose, let's just add a counter and use that
to determine whether to pass NULL or input, ok?

>                 err =3D insert_test(set, test_spec, is_glob_pattern);
>                 if (err)
>                         break;
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 11ec1190d582..6808679827ac 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -791,7 +791,7 @@ static int parse_stats(const char *stats_str, struct =
stat_specs *specs)
>         if (!input)
>                 return -ENOMEM;
>
> -       while ((next =3D strtok_r(state ? NULL : input, ",", &state))) {
> +       for (next =3D strtok_r(input, ",", &state); next; next =3D strtok=
_r(NULL, ",", &state)) {

ditto, let's not duplicate strtok_r() calls

>                 err =3D parse_stat(next, specs);
>                 if (err) {
>                         free(input);
> @@ -1513,7 +1513,7 @@ static int parse_stats_csv(const char *filename, st=
ruct stat_specs *specs,
>                         *stat_cntp +=3D 1;
>                 }
>
> -               while ((next =3D strtok_r(state ? NULL : input, ",\n", &s=
tate))) {
> +               for (next =3D strtok_r(input, ",\n", &state); next; next =
=3D strtok_r(NULL, ",\n", &state)) {
>                         if (header) {
>                                 /* for the first line, set up spec stats =
*/
>                                 err =3D parse_stat(next, specs);
> --
> 2.34.1
>

