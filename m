Return-Path: <linux-kselftest+bounces-16856-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF16966B40
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 23:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95663281335
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 21:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAA1C1732;
	Fri, 30 Aug 2024 21:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRviLfYW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149431AF4ED;
	Fri, 30 Aug 2024 21:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053168; cv=none; b=gr3LccxrMo7kbJPmEWukzls+LCCYjYnTf1S4IPGrCXCgLQ+oAAb5vggHIt4Oi2xFWGGMqcOUhFY0HFmazDtt57Qq2RzB/tOoqbqorl8rutcXGkesLzjA+RcSEXKJE6AUg4bX/RIkAkq4VNwwOfTx0cWvO5ryfbB9CRzgdE7jdV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053168; c=relaxed/simple;
	bh=BcBK4VqjgOFiE+o9CHaxi+65Z5AwmgBF2zf1/UxMz4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HDH2dpzQZxw05y0aWmPNhAeKzHoLGKoO//1HMGMCQn8Fx2wxVmTgYmVyJC15FZxvcVS5fUngeipG/wFfNASl/AgtWxrkDdCMuJA5rEW55/rYVnfei+VBvuli+n9ntJykUqF/jTraZVLoC7P2CAEVvlnRi1koJFm73v7K3Q6d718=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRviLfYW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2d885019558so519712a91.2;
        Fri, 30 Aug 2024 14:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725053166; x=1725657966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dj3rNbBFBokVtTjuF5ZA+YLNv+tpanInJIY6TlqH+lI=;
        b=kRviLfYW/C0U/TPKYfDs3akOi8iJEaCzntJMg5kr7HTgeATonYR0zIlQxMWzWOygF7
         T4FqCWnmxdzNUapwuGXteRjNIBmGPTsEpkBSxLukn0Y/+i+qJaj6gykvJGcB1ToILa0A
         PWs+9r66EqVZhAOSN1mPFF/wN02IssX26trHwbygkQblPoe+AA1/6g4UoLiP2+AcwPmu
         ee92JppboxNfwRyCykmMqMzocu6H0nWu5uO1ywIN3UhpGh8ehzH/WzI4G2hf4aUu2zRa
         ln9tqnAiVtLj3UjNMnQ5r2cjGaDb30W5+l4lE0KgBSQA0ebrREoFGVH7rkCg+Kp3a8wH
         G7vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725053166; x=1725657966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dj3rNbBFBokVtTjuF5ZA+YLNv+tpanInJIY6TlqH+lI=;
        b=JGhlQp/v96YSk0GEdTzxA8/1gXQfaT1At2WeMkj35V2sjNJGfGq6g8TT8Ettc9LuHC
         8mA8UeyE6pQ5uKVRkSI9h8vWdGcAFKJyNQs+1IbWgaQzugZg4T54YvvYOUrTeLQD99mt
         V5wuBwFYIOSwiHGPIeFmE51oR+weXDLPwx3ak3wIJKoYgd4Wk0L0sGlSUaSEWy/4ddUr
         8ftiW+lJqpXs86RZJ29m7+yiQSuGkP6KTvUuMxJUzkkizsVgEzRFxoYgTkL5gETuETdu
         qqKPwBTElsm5YxYSiSNLtbQUcSGKOMLNqRPLXbKerW7iqpS3Dus4sYw/PY0wEq4B6ZCp
         yXYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUu/VkhJLQ0PkKN6kZER0wMfot7iJtnMrdYHqBXE5F39tG60tw+hJxuKTpjap8FAOCNIO7N7QdBk8+aVOZUNZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHN4It+TV1EfosJG4q32iWDUFFcPhL+5EvUwmqEHKUtI62SMiM
	jAxXzq0fm2jX3QxEZ5lguIswWpEXNXn+ZilLqef/SjD3us5CkfmU+pWqtCObkWK+obeo9hYeRKT
	lkHE/6eEePTStO6+tU0igoKalySw=
X-Google-Smtp-Source: AGHT+IHBoRYN1veml0VdO+Xnjp8Wa3J4XFDdH5amR1oA6fZY/gVecKW+oadtO4FqPyuWWsPT6cqb3kcE4tUXRF4FX6w=
X-Received: by 2002:a17:90b:390a:b0:2d3:d398:3c1e with SMTP id
 98e67ed59e1d1-2d89467a4bbmr335375a91.36.1725053166067; Fri, 30 Aug 2024
 14:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1724976539.git.tony.ambardar@gmail.com> <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
In-Reply-To: <a12e83308e11b15501aa3b9e927bc94139418ce3.1724976539.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 30 Aug 2024 14:25:54 -0700
Message-ID: <CAEf4BzbXD0M0Zfgih-7Rght_zSkTsZY3AmOpYxX5iaYimROaRg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Support opening bpf objects of
 either endianness
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Quentin Monnet <qmo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 12:30=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Allow bpf_object__open() to access files of either endianness, and conver=
t
> included BPF programs to native byte-order in-memory for introspection.
> Loading BPF objects of non-native byte-order is still disallowed however.
>
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c          | 49 +++++++++++++++++++++++++++------
>  tools/lib/bpf/libbpf_internal.h | 11 ++++++++
>  2 files changed, 52 insertions(+), 8 deletions(-)
>

[...]

>
> +       /* Validate ELF object endianness... */
> +       if (ehdr->e_ident[EI_DATA] !=3D ELFDATA2LSB &&
> +           ehdr->e_ident[EI_DATA] !=3D ELFDATA2MSB) {
> +               err =3D -LIBBPF_ERRNO__ENDIAN;
> +               pr_warn("elf: '%s' has unknown byte order\n", obj->path);
> +               goto errout;
> +       }
> +       /* and preserve outside lifetime of bpf_object_open() */

what does it mean "preserve outside lifetime" ?

> +       obj->byteorder =3D ehdr->e_ident[EI_DATA];
> +
> +
> +

why so many empty lines?..

>         if (elf_getshdrstrndx(elf, &obj->efile.shstrndx)) {
>                 pr_warn("elf: failed to get section names section index f=
or %s: %s\n",
>                         obj->path, elf_errmsg(-1));

[...]

>         err =3D bpf_object__elf_init(obj);
> -       err =3D err ? : bpf_object__check_endianness(obj);
>         err =3D err ? : bpf_object__elf_collect(obj);
>         err =3D err ? : bpf_object__collect_externs(obj);
>         err =3D err ? : bpf_object_fixup_btf(obj);
> @@ -8500,6 +8529,10 @@ static int bpf_object_load(struct bpf_object *obj,=
 int extra_log_level, const ch
>
>         if (obj->gen_loader)
>                 bpf_gen__init(obj->gen_loader, extra_log_level, obj->nr_p=
rograms, obj->nr_maps);

nit: add {} around if, both sides should either have or not have {}

> +       else if (!is_native_endianness(obj)) {
> +               pr_warn("object '%s' is not native endianness\n", obj->na=
me);

"object '%s': load is not supported in non-native endianness\n"


> +               return libbpf_err(-LIBBPF_ERRNO__ENDIAN);
> +       }
>
>         err =3D bpf_object_prepare_token(obj);
>         err =3D err ? : bpf_object__probe_loading(obj);

[...]

