Return-Path: <linux-kselftest+bounces-14119-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301C093A961
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2BD3283C7A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D817F14600C;
	Tue, 23 Jul 2024 22:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XbiOFfWD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48138288D1
	for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 22:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721774136; cv=none; b=PQf9K4vNy6H0SO2BMOhy7Gxs1PivLseLKNMf+IMRSXhOB8IipxAUrkAC/hLWv3G16SB579qQz1xrN8Du4gUNTs9Zq7Dr+r5VOA3sZTIzil6rp8fcV7E88p0SwokpZdTNGJlUw/XogN2kS0HTwZQdQ8yrY8DKJmWrOUNRRyxD1MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721774136; c=relaxed/simple;
	bh=Bq0LGm7kqltWE6RamFRrFTZETEQtLNr0hZ4SmD0HhkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN+lRekm4kgLRDrTciqsATta+hDEBYmTJKiGCkq6nIRqROm2J9PlhClvdumMaqve60Mhg1XMM3CJdpAgr1DR6u1LlWisc2+SDpVCj2vLVrNk8EHFqahmgVOhlaFKgldBXuMafGLb24Vk+zR0yxZnKwuL2ubmlNsv96Lje8N4kfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XbiOFfWD; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9cc666b1so122903566b.2
        for <linux-kselftest@vger.kernel.org>; Tue, 23 Jul 2024 15:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721774134; x=1722378934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBh9jmyTekte+QvpGQRbc5vXty4hPQS11N7+FKceOaU=;
        b=XbiOFfWDhd8N9YoJ4BiqaQIqEKcrFDJBFpWKpnFrYy0X11x5uBFpm3P5aF9553yo+6
         BWEc3zZFj1/3L+2D1nYD2j7CwL+lmBr/P5RVQs1A84PkeLbMAa296feFBu2G2LrtxTGX
         Hh39rDngo0kMdZ02f+rlk5qgq7b4fM8gO443nBWn6swxiJqyL12mcIRf4A4Y2i44vJSI
         srpeauyMSfxrz8IuW/qh30qwJ+7majDt190/kuNGSzxfPWcdgv/iiMO1H6z00qoK03/n
         faryINpgIFNGij7rxIvrpH6UAaPtTh+WpK1akecE3Bw5rinYptziaJtVG7+QNgPA1roq
         S6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721774134; x=1722378934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBh9jmyTekte+QvpGQRbc5vXty4hPQS11N7+FKceOaU=;
        b=pwqlSvscGjSs6H2ac51yLW5G2b7UW2O9733Ye0tO6KxxN2IxEDESQt/cXL7zItCXK3
         y2u7aySp1bLx/NLJxToJ4T3DPPRfCFh5tXKjMjcJm0pZs6/WZsnDTymOmlBG1iP6b62X
         V8zKyJhwd4A3cd8UY3TdSORVXUaKtRIkqzT4MCljhPT9fkRADeGvpXavlxC6fOfBJTvz
         fbuZHybxcayt86CGU/KLoBaug8/huTWsIs1Owxkv+GO+p8KWeygJGRepQVy9w7EGaxzp
         lq7jGXCJX/u4CW6gqObW8MAozQsVbxEL7bAjAv/n+e8NqgJ+WjUNBEDxKogJOsDwJ2ID
         GJpA==
X-Forwarded-Encrypted: i=1; AJvYcCXbN4pX5CFp87fWqiekDVUepWS3lDFREOJsZSQ5Lt/dshfXRKYOXGanD1CV2BqZV05VjMM/4o86xCBEoc7Is1niKM2nBghJMXUJXeSljdNs
X-Gm-Message-State: AOJu0Yy9nBvlq8wnDz6VI4cpWyxQVFXe9HzJblgoKbq4PKp8gs/jULZm
	Re3cekKDqG5gcRGrPLggS7Fide8XUqkbLx36hqyIdyyQCqmSScTQm6q5qSkXf8u4+alTAO4Ro9P
	LX6OdxCrXzN0eiia1r4jhWwSGcgAj2hC+566Q
X-Google-Smtp-Source: AGHT+IEyVqJvzIuhy6mXH0U45aIDac2Ff/JCBsu+9NCJenoAxeGYarTIMpIDyvdx6qQU6CRnPJV2KaPioxWd2WC+PpI=
X-Received: by 2002:a17:907:3e21:b0:a77:b052:877e with SMTP id
 a640c23a62f3a-a7ab0d91274mr19715066b.19.1721774133116; Tue, 23 Jul 2024
 15:35:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721713597.git.tony.ambardar@gmail.com> <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
In-Reply-To: <4f4702e9f6115b7f84fea01b2326ca24c6df7ba8.1721713597.git.tony.ambardar@gmail.com>
From: YiFei Zhu <zhuyifei@google.com>
Date: Tue, 23 Jul 2024 15:35:22 -0700
Message-ID: <CAA-VZPm-tBOD_vfYeLs57gPkoJmbZTw-4odO05H_UxTvZLvPTg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 19/19] selftests/bpf: Fix errors compiling
 cg_storage_multi.h with musl libc
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Yucong Sun <sunyucong@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.co.jp>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, David Vernet <void@manifault.com>, 
	Carlos Neira <cneirabustos@gmail.com>, Joanne Koong <joannelkoong@gmail.com>, 
	Petar Penkov <ppenkov@google.com>, Willem de Bruijn <willemb@google.com>, Yan Zhai <yan@cloudflare.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 10:56=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Remove a redundant include of '<asm/types.h>', whose needed definitions a=
re
> already included (via '<linux/types.h>') in cg_storage_multi_egress_only.=
c,
> cg_storage_multi_isolated.c, and cg_storage_multi_shared.c. This avoids
> redefinition errors seen compiling for mips64el/musl-libc like:
>
>   In file included from progs/cg_storage_multi_egress_only.c:13:
>   In file included from progs/cg_storage_multi.h:6:
>   In file included from /usr/mips64el-linux-gnuabi64/include/asm/types.h:=
23:
>   /usr/include/asm-generic/int-l64.h:29:25: error: typedef redefinition w=
ith different types ('long' vs 'long long')
>      29 | typedef __signed__ long __s64;
>         |                         ^
>   /usr/include/asm-generic/int-ll64.h:30:44: note: previous definition is=
 here
>      30 | __extension__ typedef __signed__ long long __s64;
>         |                                            ^
>
> Fixes: 9e5bd1f7633b ("selftests/bpf: Test CGROUP_STORAGE map can't be use=
d by multiple progs")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/cg_storage_multi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/progs/cg_storage_multi.h b/tools=
/testing/selftests/bpf/progs/cg_storage_multi.h
> index a0778fe7857a..41d59f0ee606 100644
> --- a/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> +++ b/tools/testing/selftests/bpf/progs/cg_storage_multi.h
> @@ -3,8 +3,6 @@
>  #ifndef __PROGS_CG_STORAGE_MULTI_H
>  #define __PROGS_CG_STORAGE_MULTI_H
>
> -#include <asm/types.h>
> -
>  struct cgroup_value {
>         __u32 egress_pkts;
>         __u32 ingress_pkts;
> --
> 2.34.1
>

Hmm, some linter checks prefer headers themselves include everything
they use. This header uses __u32 and after this patch it would include
no headers. Would it be okay to include <linux/types.h> or we don't
care?

YiFei Zhu

