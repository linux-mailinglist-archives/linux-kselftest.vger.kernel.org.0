Return-Path: <linux-kselftest+bounces-30452-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F34A0A83489
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Apr 2025 01:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16888A6C62
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 23:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF26821C165;
	Wed,  9 Apr 2025 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9Ygnobu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B80215783;
	Wed,  9 Apr 2025 23:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744241293; cv=none; b=dyZPhMHZVc3/CAR+EJlKyd08g8ZLMRHqdEkoUooirU3/uy6wBpfSlIwslJsjsri/CQviH6WTVCBA0DqpwpLh7V9L/1JI9BFE/HqAbY7QX9nn8nOzQZ38xSiilVigOYDB5uSlQOCGxm6l+Cs4wxcyz8B1eZU2qBQyTnBtt7Xxsi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744241293; c=relaxed/simple;
	bh=xlm6kiPa9gZS62ly2Zmr0mdf2klt/0HVdruyqifUSIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxOenO8jSgB30jYJxFwPZqcSMXjjepkqY0GL717m3KXZgLEvzPeTxYofjbzk6joiud8jNcIoqYY/xfwKG3v1Vfb5d1dbjaVXOV203Kji/c1SfD+/9eufzyw6uBfCk7g171EK/NiQ5GdjDtKMYBEPWCNavF75wfuNasiix4idOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9Ygnobu; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so148764b3a.0;
        Wed, 09 Apr 2025 16:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744241291; x=1744846091; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d43q8Ohc0VtlpAm85od0FJeon95Qrpfa6YdtOn0hGQk=;
        b=K9YgnobuJn3RrkiPP+GVgLPAYXl1oayW3hY7nfDNjm/6qHS/AABIbNe6Jmbix2BSuN
         m0telt7BTAke/fj4PZ8l6f4euBmRSbnu2misQZVcxtnuXu58miDlJ/c/kcM9Mxm7MqUJ
         dA1V3rV25u9FhweXWFL6nh+IyC08UbGYEP/EYq2fip55neA94gQnTY9Mw63uj4LjLYIj
         vVWgJlPr7hWuHBxZ5RdHfBxqp8A2s7lGjLXy3WTw6GKw3W8MDV6OK4UINS/Hvgl/Hm2F
         a8jaObXMCobXjupI9SqOz6BHFpp0yBGVZg163mI8bXwvHeGq/w3iHB7qw2dDmRwmFt8R
         sWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744241291; x=1744846091;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d43q8Ohc0VtlpAm85od0FJeon95Qrpfa6YdtOn0hGQk=;
        b=bMXjQEXjd0kwYpdQVDfVcCl/dvBXvcNDtcr/OvFCpnGXtob6dhSZ3YqbEEsrVjGh1f
         s8D1105waDMrekZ0Emv9fK2aR0Q3IX6ROB5+v1KFHm+h7/RPDPeX3sx4dWy41Sk7Owt+
         7ME2QeMIaBRI5JsP+EcEdE6nL3SFkh0GbTsXx7EuoQgStuzfaalqbADSD7ShS8raPuB6
         EcwkkEGC5WUdrNRRPr9rg2YGKEhvLvuzUT+xNkxYaJ5LJkrbGZC8hrgGTUjlsMAY91VH
         ziJ2PVBjPJf91SbLXHLgX9P4kqjI6P3AlczVS97CvTdq+ng/16uGPQNYC0v9T7C01jdU
         oOpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/vbRildI5I1l2zjoDsUIBiNJnmw2zwTc1V5n2lKu/O9I2qe2btwLoDzn/vYFrXiRSkxfutpmkBZeD2F/czWJM@vger.kernel.org, AJvYcCU9pi6XWVPShcWKjzkw2gleaVh70zIwB/3InPsqEX9cbyzlzTDTTqw33DNsjqE9rQ4JTDU=@vger.kernel.org, AJvYcCVDSSqGZIV9vBJ/K0ASbSGSYuLsrBt54U/tQz6I6a8V+cqEQg7qbEd82p9OXLCue5xlHj7ouuwrALs4cT+j@vger.kernel.org
X-Gm-Message-State: AOJu0YxjVtCoVBXFQ7p1xnVk5dq08kl7Q93+UKh6sd8cbEHnTDBteEXJ
	hVqrPMBfDonRBnPSVsuuucEDRSG560i/6OGEPrPyCJrdsoLqB083Knl+CsHMPo8c1oesAkwn6HB
	alVAwQma6e4xIJtssWlMPLFiJPGs=
X-Gm-Gg: ASbGncs9uAK6fpO7CLR+/vCdx6lAIBTtwb09Lt+pz/HrQImElTNnAKKr7ST/etib/7e
	VJ6j6HyuVnqX4sWx0qg+W0YM2L4XB3JtfQfTBEVWGbubXN4GzPB39TLtyPTeHkI/myGxojaNTzE
	wKN8RVASvRmlqBb57jYLD+I53r8E7Gb4G49KRR0CE/SjAsFGj/
X-Google-Smtp-Source: AGHT+IFPTMthJzc9qgSu5WElBjhpy3BWr2IJ4YUsMiebdcxKoeeld8qXZFbGEBK+KjtjnF+gAHeiF1rm8LdQ3ZprH+s=
X-Received: by 2002:a05:6a00:4602:b0:736:476b:fcd3 with SMTP id
 d2e1a72fcca58-73bbefc1c66mr993763b3a.24.1744241291411; Wed, 09 Apr 2025
 16:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <92596c82-4a12-3afc-6cb2-21a11bef3739@huaweicloud.com> <20250408183214.6437-1-malayarout91@gmail.com>
In-Reply-To: <20250408183214.6437-1-malayarout91@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 16:27:59 -0700
X-Gm-Features: ATxdqUEZZ2SE8CIAtin4otsZSXEzzkJO0vgoIJfiyw_FGcgtj5SKQquZGhr-0J0
Message-ID: <CAEf4BzaD63etPL6EYW5Ct2Z_RMEXXc_puLUCm8S9Dth0y6r6SQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next v2] selftests/bpf: close the file
 descriptor to avoid resource leaks
To: Malaya Kumar Rout <malayarout91@gmail.com>
Cc: houtao@huaweicloud.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 11:33=E2=80=AFAM Malaya Kumar Rout
<malayarout91@gmail.com> wrote:
>
> Static Analyis for bench_htab_mem.c with cppcheck:error

typo: analysis (lower case and typo)

you can also make into a bit more human-readable sentence:

"Static analysis found an issue in bench_htab_mem.c:


> tools/testing/selftests/bpf/benchs/bench_htab_mem.c:284:3:
> error: Resource leak: fd [resourceLeak]
> tools/testing/selftests/bpf/prog_tests/sk_assign.c:41:3:
> error: Resource leak: tc [resourceLeak]
>
> fix the issue  by closing the file descriptor (fd & tc) when
> read & fgets operation fails.

"Fix the issue by closing" (capitalization, single space between words

>
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  tools/testing/selftests/bpf/benchs/bench_htab_mem.c | 3 +--
>  tools/testing/selftests/bpf/prog_tests/sk_assign.c  | 4 +++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
>

For some reason this patch didn't make it into our Patchworks system,
so we can't easily apply it. Please fix the above commit issues and
resubmit, hopefully this time it goes through just fine.

> diff --git a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c b/tools/=
testing/selftests/bpf/benchs/bench_htab_mem.c
> index 926ee822143e..297e32390cd1 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_htab_mem.c
> @@ -279,6 +279,7 @@ static void htab_mem_read_mem_cgrp_file(const char *n=
ame, unsigned long *value)
>         }
>
>         got =3D read(fd, buf, sizeof(buf) - 1);
> +       close(fd);
>         if (got <=3D 0) {
>                 *value =3D 0;
>                 return;
> @@ -286,8 +287,6 @@ static void htab_mem_read_mem_cgrp_file(const char *n=
ame, unsigned long *value)
>         buf[got] =3D 0;
>
>         *value =3D strtoull(buf, NULL, 0);
> -
> -       close(fd);
>  }
>
>  static void htab_mem_measure(struct bench_res *res)
> diff --git a/tools/testing/selftests/bpf/prog_tests/sk_assign.c b/tools/t=
esting/selftests/bpf/prog_tests/sk_assign.c
> index 0b9bd1d6f7cc..10a0ab954b8a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sk_assign.c
> @@ -37,8 +37,10 @@ configure_stack(void)
>         tc =3D popen("tc -V", "r");
>         if (CHECK_FAIL(!tc))
>                 return false;
> -       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc)))
> +       if (CHECK_FAIL(!fgets(tc_version, sizeof(tc_version), tc))) {
> +               pclose(tc);
>                 return false;
> +       }
>         if (strstr(tc_version, ", libbpf "))
>                 prog =3D "test_sk_assign_libbpf.bpf.o";
>         else
> --
> 2.43.0
>

