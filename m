Return-Path: <linux-kselftest+bounces-39411-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87842B2E84C
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 00:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4477A4228
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Aug 2025 22:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757DA2D63E8;
	Wed, 20 Aug 2025 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2Pcsw1B"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33E92D0C8A;
	Wed, 20 Aug 2025 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755730066; cv=none; b=DjM4d4T733XwtNtck39T55CH/N9SAFiu7O8ay3vW9c5bp4yODOuiQ8rIoNwmAUVp8DtaO7cO8K2B5oav1TGlGUuEo9nuPAzxpqz2fhs7K7lBKyyF8rOQrb0sCIG/AmJkp02PwBYUpJ39qFCx8RtmsGECiwW7uAg9pT0sJ27qHR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755730066; c=relaxed/simple;
	bh=aKHlxeIJj0NhWL5rFj8SAJiHfOeC64OVey16cOjjDKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpyhxQVc5q+FDGpaZq6h5x3SjJk7NHO1ghmNdjHK5B61NfNdZbZSLsdxBiaW4S/X5Yvvnn7PiWyBO9RVBWCX2rXbcpBfPsJxlJffpcCWr1qgXBaANBGLlR6z34XxvOe4LGld70Mjm7qOGd2Us6Z5CR8I0fhPg6VtI675prpvjaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2Pcsw1B; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-24458242b33so3674965ad.3;
        Wed, 20 Aug 2025 15:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755730064; x=1756334864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxmSUEH8XUSKiQrWMIiadQU2ELcXoRKtyFDMxUyNAvc=;
        b=E2Pcsw1BqHvWTEXpS7whBjZ/U9SZLDI6RCDM2qdC2D8zQFHsawh0I6FTheJakR+9PC
         bs+2JA5CkjLH92YVnKFCQlVjUVQnPpMrr5UcGjpblH9TOGLHRQyxKjTNrrdLawHAr3Nu
         q9gD/hwnYq3/bI8oolo7QyJW4bh7Ltc6w3Qwczq2yO4oGq6XFyxz09pcuF6gPh2QzfmZ
         YjH/LICDUabWkb+giyuM5l3q/esLIzFrW6iAe416YjjgoS8HjUktCz+ais5tcTvYn+J9
         ztOOVg9481vZyQwR8lgF6Uablo1Kh52gg5Bs7CZrwRwqQbFMgLjR7qTtA4/ixRE54lQn
         jXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755730064; x=1756334864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CxmSUEH8XUSKiQrWMIiadQU2ELcXoRKtyFDMxUyNAvc=;
        b=jnEINlJg2ii4+roTtTRpdEnE/Q6d7vA8LTyoBe81teLatS8dVVCWwWlIvwsu4hHYXI
         FF2w2KZfEhxto2CPshEBZg45w3eCUG21LUy/qNW512aQT8sbFS5XEMdAtoSle7yxf7Ps
         J4Q+FP5O3YfBkHjuH/fg1wyAYH0qTaITi2/lC8+//s2/d6unBJh/sGSdCnV0VU7M92aG
         YJgU97FyaQ5oe9CLAhm8oPj030sNErQLk291MJ+Iv/G1vB8Uq6TurjITcnLzcpyxsIuW
         HLQNJ3C8rSgljrwzpwdPPLpjUkNC3wAJnr57czqrRpmXjHeBJS0OPb6MgdUGDBb8zIE0
         KCqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7xjjhizhfp6lIvotk0Dx2vC96T9QeQTa8oz+oaB3PDaGL+m/Grs2acbJbgj9UXViN7eygvfb1UhS7BXvku2l@vger.kernel.org, AJvYcCWiYrBs5RrL+i6HMhsrw2VjbWrKURdy+BSzN7OGXUB8tBi5MTWmt/nepiz5i5XIbkE0d8I=@vger.kernel.org, AJvYcCXMVeeK0dTdgr4KkhPdEICnbYnYzidEDOPDFMQRxzT82LkybeRDpHkCbsA+6x2mKSU/f3EHtgydmlci1g38@vger.kernel.org, AJvYcCXbSfyi+9HbkIa+KbMxGrcllKPt8OgSsFuNzPpsXwHawXkkRBPoLe0eJ5f7fzzB9UVeXlgcr/P4@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAAcnn4+YOjzOeX4H0nnxmbTV8BLqUO1z5I6IStiET3L3rr5p
	ergEyhoxuEmz5Rs78ifm1EDJiB0kNCTnov9wh4srtEwH0J/yfAM/4gvyKDUuqsB8zKRFwTgo9az
	wX5Qlba4xt+wUEJCU5N0wGdPd0QAcp3Y=
X-Gm-Gg: ASbGncsg9x7k8yWRpq0nGBkGlm2CatnZQWpBt3vFOX0eGS4CaamMQ97XcV9xUxgZLJ9
	QP/5HdG16rKVuJrjwfnn1Ktf2nPoZW3MdmMNNgQQh9foMIrfUbKK8g38u/yzooNyXX/86+NiW0X
	lSXGgmIPDC2cVZXK0vD+oqskieaGgioaOVNfV2OCOMh78ia7oZf2QL9+fnHbp95a51V2MDQfQOl
	WE8PID7rEARuR5fIXlo05WKxcV8PbYyJePPU3+rZEnN
X-Google-Smtp-Source: AGHT+IGfXE/LPyy5OpwjdvIBYFagxDqu+JLxgJsnoM4MRvNr7cBY/jRWzrvpmvFodOiN1fufMP+/m2v1odbFJOTclS0=
X-Received: by 2002:a17:902:e884:b0:23f:f707:f97e with SMTP id
 d9443c01a7336-245fec04067mr6138445ad.17.1755730063826; Wed, 20 Aug 2025
 15:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819033956.59164-1-dongml2@chinatelecom.cn> <20250819033956.59164-3-dongml2@chinatelecom.cn>
In-Reply-To: <20250819033956.59164-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 15:47:29 -0700
X-Gm-Features: Ac12FXxwNFYx3X1C5Pu9tp-WySpazWQxJmdHRR6C2ikj-hLBBFxY7DT7gZK46Co
Message-ID: <CAEf4BzZBztC69GFDuA4YJHPmWOXuq3+tSNMspPNA3tksGaEi=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] selftests/bpf: skip recursive functions for kprobe_multi
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, mykolal@fb.com, 
	shuah@kernel.org, davem@davemloft.net, kuba@kernel.org, hawk@kernel.org, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, 
	justinstitt@google.com, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 8:40=E2=80=AFPM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> Some functions is recursive for the kprobe_multi and impact the benchmark
> results. So just skip them.
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index d24baf244d1f..9da9da51b132 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -559,6 +559,22 @@ static bool skip_entry(char *name)
>         if (!strncmp(name, "__ftrace_invalid_address__",
>                      sizeof("__ftrace_invalid_address__") - 1))
>                 return true;
> +
> +       if (!strcmp(name, "migrate_disable"))
> +               return true;
> +       if (!strcmp(name, "migrate_enable"))
> +               return true;
> +       if (!strcmp(name, "rcu_read_unlock_strict"))
> +               return true;
> +       if (!strcmp(name, "preempt_count_add"))
> +               return true;
> +       if (!strcmp(name, "preempt_count_sub"))
> +               return true;
> +       if (!strcmp(name, "__rcu_read_lock"))
> +               return true;
> +       if (!strcmp(name, "__rcu_read_unlock"))
> +               return true;
> +

static const char *trace_blacklist[] =3D {
    "migrate_disable",
    "migrate_enable",
    ...
};

it's not like it's one or two functions where copy-pasting strcmp might be =
fine

pw-bot: cr


>         return false;
>  }
>
> --
> 2.50.1
>

