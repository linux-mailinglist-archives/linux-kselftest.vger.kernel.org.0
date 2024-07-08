Return-Path: <linux-kselftest+bounces-13327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7937692A95A
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 20:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97431F22653
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 18:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE5714B975;
	Mon,  8 Jul 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KzIZ+NVQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F091DFEB;
	Mon,  8 Jul 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720464993; cv=none; b=JTn+C2SRgrQSfjHzqheNpvJxET92jIVoQ3dNTBE3S6Z9z690xelCAuMepwWZNoHUOMteR1aRBjaCELCfpkhptX73YhBaPx6eUYcZckBeRufrq6kFChzcIuxaT7/fAQgk7j0fMCZYbd/EZIJbKcBXkvJyu0+rw5/d5kOO64Y8p0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720464993; c=relaxed/simple;
	bh=vz38mGqIA29q9GiA30HaH0rdSyRlUPWZ55JRA/7mC3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tMGS11l7uphhrPXWgElr5gQuJiPb7JgBPQKpwxLublzOOngXM49hK68t6i8BWpKteZh7zmxWnH6MvqjAg/D9NZv0VOYWA+rSayoN2z5kd8vFzB80Pd5Bkd+BIoF2/QNuAdO6+BLmhcVi3/glM+tf+1OtgM1yHDVXU6yvldoc7uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KzIZ+NVQ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b0013cf33so2858140b3a.2;
        Mon, 08 Jul 2024 11:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720464991; x=1721069791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JjT5Q6oK0mVLOBCrAOVlZjz7hxr/1Kaj+JdCup4jRzE=;
        b=KzIZ+NVQfCi3NevzHKm6+fa7kl7hPNV7pRy0+zBzIJuw319YHqUXPtPILISalUdsU/
         0GFM6p5d5X6ec07uRPJn71mP8fVpbxiQsqnAJ9CCkht4bZYJ7Uww19L03EgrxSmR8kQY
         FyC4HtPkbJKS+76JwH+UoZie8ixJ/eiy96vLzgCPwfnr7K2g0WNwlPNqV6mRoTX7uXx6
         Zj0kWOMeHDem3IJrEvi1ufINjPS/eC8dzf/eC2N7bdG/nO6OVrzvEWR/dEEVO4qqbXaO
         M70I1/PYDkRNk7WUm6Qp3m5WHbgX1Z07rkyEGU2eSXcMgXRw4DyA3lLyNHgqr3/8eu+e
         k10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720464991; x=1721069791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JjT5Q6oK0mVLOBCrAOVlZjz7hxr/1Kaj+JdCup4jRzE=;
        b=xPlSa2MLN072BKCIn4/HPnlxzRhtlqhddMiZ907qT4Y4LqTk9kCeVq59dpmWTgh1Nq
         zLTmpgkCVhN3bCH7jryUxr4jwo1M3pCsxOelM2jmaFSngRWqikv7jN4tphS/x5mdbykq
         SGy3NfHcS0iIdhH5dLeNSMZ5Hx2DIoOz56AuW39fjrqpVcuMBr/H+CDjutmcwf7rn240
         iVdlZwqcvi6hwifu/tIplwQv4RskBBIVuGT5YWtYf6DXeEQuQzMeBTLYfF9VPQEylffo
         sM4LYC8Fkc/mauM1wKeC0bIzYOp4/pnXK1R4HxDbaYlVLwHJ0u8UPnFN2snnAvQ0zJNu
         G1IA==
X-Forwarded-Encrypted: i=1; AJvYcCWAenjBdHcuXEcnJUqgKm0l0GJXwKpVQnRQYNKhQu/gAoqGCYnrjnjf88zg9sWbt4hyYweCxKoDhn9COCvS3LOIkhW8jbIjSFZqcVlfugAQ7Stejxo3iZOTGqRwOPHnK0TGgh9Y
X-Gm-Message-State: AOJu0YyPlt31KLCkfPweFygG96GZyHRbdFfxoTDrEYyy6z68NCTWHNOB
	s5Q/mgRawh/36D31nCMZut0CT6EO7TENN/fucwR5G1rKEZBkgXA/DzwnkoSBywOD5ukGvQDtGNH
	cC/rdHPWH1uTlw5NK5bvrz0jy8Xk=
X-Google-Smtp-Source: AGHT+IFHrUUI7k/upOCoOOUnnFbOIJROKAbdNQFhJGqyFVEyVoX8dll+V41aXxvZuT3JyfIBrkzmoEzEjsrYLJFoq28=
X-Received: by 2002:a05:6a20:2455:b0:1c0:e42e:8508 with SMTP id
 adf61e73a8af0-1c298220a50mr329636637.23.1720464990763; Mon, 08 Jul 2024
 11:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720075006.git.tanggeliang@kylinos.cn> <a4e9f830d9e10de3ce5c56d0e15fcc0f209aa089.1720075006.git.tanggeliang@kylinos.cn>
In-Reply-To: <a4e9f830d9e10de3ce5c56d0e15fcc0f209aa089.1720075006.git.tanggeliang@kylinos.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 11:56:19 -0700
Message-ID: <CAEf4BzbfFD6knXG+oV3wqx_qJcJ=gGOOmpOZur79J13zoRbmkA@mail.gmail.com>
Subject: Re: [PATCH 6/6] selftests/bpf: Skip ENOTSUPP in ASSERT_GE
To: Geliang Tang <geliang@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 11:48=E2=80=AFPM Geliang Tang <geliang@kernel.org> w=
rote:
>
> From: Geliang Tang <tanggeliang@kylinos.cn>
>
> There are still some "ENOTSUPP" (-524) errors left when running BPF
> selftests on a Loongarch platform since ASSERT_GE() are used there to
> check the return values, not ASSERT_OK():
>
> '''
>  test_bpf_cookie:PASS:skel_open 0 nsec
>  #17/1    bpf_cookie/kprobe:OK
>  #17/2    bpf_cookie/multi_kprobe_link_api:OK
>  #17/3    bpf_cookie/multi_kprobe_attach_api:OK
>  #17/4    bpf_cookie/uprobe:OK
>  #17/5    bpf_cookie/multi_uprobe_attach_api:OK
>  #17/6    bpf_cookie/tracepoint:OK
>  #17/7    bpf_cookie/perf_event:OK
>  tracing_subtest:FAIL:fentry.link_create unexpected fentry.link_create: \
>                                                 actual -524 < expected 0
>  #17/8    bpf_cookie/trampoline:FAIL
>  lsm_subtest:FAIL:lsm.link_create unexpected lsm.link_create: \
>                                                 actual -524 < expected 0
>  #17/9    bpf_cookie/lsm:FAIL
>  #17/10   bpf_cookie/tp_btf:OK
>  #17/11   bpf_cookie/raw_tp:OK
>  #17      bpf_cookie:FAIL
>  ... ...
>  test_module_fentry_shadow:PASS:load_vmlinux_btf 0 nsec
>  test_module_fentry_shadow:PASS:get_bpf_testmod_btf_fd 0 nsec
>  test_module_fentry_shadow:PASS:btf_get_from_fd 0 nsec
>  test_module_fentry_shadow:PASS:btf_find_by_name 0 nsec
>  test_module_fentry_shadow:PASS:btf_find_by_name 0 nsec
>  test_module_fentry_shadow:PASS:bpf_prog_load 0 nsec
>  test_module_fentry_shadow:FAIL:bpf_link_create unexpected \
>                                 bpf_link_create: actual -524 < expected 0
>  #168     module_fentry_shadow:FAIL
> '''
>
> Just like in ASSERT_OK(), this patch skips ENOTSUPP (524) and ENOTSUP (95=
)
> in ASSERT_GT() too. With this change, the new output of these selftests
> look like:
>
> '''
>  #17/1    bpf_cookie/kprobe:OK
>  #17/2    bpf_cookie/multi_kprobe_link_api:OK
>  #17/3    bpf_cookie/multi_kprobe_attach_api:OK
>  #17/4    bpf_cookie/uprobe:OK
>  #17/5    bpf_cookie/multi_uprobe_attach_api:OK
>  #17/6    bpf_cookie/tracepoint:OK
>  #17/7    bpf_cookie/perf_event:OK
>  #17/8    bpf_cookie/trampoline:SKIP
>  #17/9    bpf_cookie/lsm:SKIP
>  #17/10   bpf_cookie/tp_btf:SKIP
>  #17/11   bpf_cookie/raw_tp:SKIP
>  #17      bpf_cookie:OK (SKIP: 4/11)
>  ... ...
>  #168     module_fentry_shadow:SKIP
> '''
>
> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> ---
>  tools/testing/selftests/bpf/test_progs.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/test_progs.h b/tools/testing/sel=
ftests/bpf/test_progs.h
> index 464aa12feada..8a5ce360aa1c 100644
> --- a/tools/testing/selftests/bpf/test_progs.h
> +++ b/tools/testing/selftests/bpf/test_progs.h
> @@ -294,9 +294,13 @@ int test__join_cgroup(const char *path);
>         typeof(actual) ___act =3D (actual);                              =
 \
>         typeof(expected) ___exp =3D (expected);                          =
 \
>         bool ___ok =3D ___act >=3D ___exp;                               =
   \
> -       CHECK(!___ok, (name),                                           \
> -             "unexpected %s: actual %lld < expected %lld\n",           \
> -             (name), (long long)(___act), (long long)(___exp));        \
> +       if (___act =3D=3D -ENOTSUPP || ___act =3D=3D -ENOTSUP ||         =
       \
> +           errno =3D=3D ENOTSUPP || errno =3D=3D ENOTSUP)               =
       \
> +               test__skip();                                           \

absolutely not, if ENOTSUP or ENOTSUPP is special for some tests, that
should be handled explicitly. This is not correct in general and we
should not just silently skip some test on such errors.

> +       else                                                            \
> +               CHECK(!___ok, (name),                                   \
> +                     "unexpected %s: actual %lld < expected %lld\n",   \
> +                     (name), (long long)(___act), (long long)(___exp));\
>         ___ok;                                                          \
>  })
>
> --
> 2.43.0
>

