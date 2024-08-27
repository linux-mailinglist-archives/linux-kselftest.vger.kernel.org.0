Return-Path: <linux-kselftest+bounces-16474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604B9961A21
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2024 00:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91F911C22BB4
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Aug 2024 22:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD211D365B;
	Tue, 27 Aug 2024 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0t9UAo2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405C64A;
	Tue, 27 Aug 2024 22:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724798972; cv=none; b=tP7PnK77meL2lIDRAIFOT9BsrStG3HpNaUlKlWFYXHxZL57rWzkjN64fJbVQSQDqRyPF4AlUyWOZ5DOfRxPaYI/yqxQFzmYRt9U8vHOe4vATR52IH5kKON9f/LzgxGezZ0Yzg5Jy/+oGH6Zcqm2hv7UCncu9wzBeYAh82ffVYF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724798972; c=relaxed/simple;
	bh=ZCsx4XBxZszRLALGFHsW8Srd/rR17PluQWFhIcWOekQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oo1LpF9yrPwwTZAdq0/jSaUg7ljNjdSg7oWhxurtUM8BcVhVl2Z2MIt6zJcC9oPOWKYFOiv4V/Ib82ANNIIA4x3i8HpVmzr93akzvKPz9nh+DRc3UhSCZlEUoeZfUGXCxO7UzMOKvAmG6rwfQuqUaL5A9bWndOtJeAEDDXHSzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c0t9UAo2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20223b5c1c0so55271615ad.2;
        Tue, 27 Aug 2024 15:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724798970; x=1725403770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDrZ+EjYF19PvJC+i6jehJt+sfVjodbjYXEq8nEjBfw=;
        b=c0t9UAo2cwN5FprNQsyQH2oA2gIUy+2/WpT06Rlk7YvH9cVP7HPg573El7gO1hpaI+
         JdoWm/0erFnKOSqWgoCXv7Au/Y9+Skge3T1kH4APrN4z1CANUlIMotHiGhI4fLH6nrEG
         n41Fd2dGcm1iK5ZDgQtcabZR4Rkb67OTuIl8bZr73ldUo4kYtwPY0IbiL8ndWB+ACPqV
         mOwBcr4qi1yf5eoQLpSgbk765Qwxpl1NcoHFI2V/TeLqscV+y6H+3wJQOhF+OvaupX72
         V3hdb7BIO1BHS0O9Q0UsD0cfyxS7JeBosQZ82TrRNQQyLLGfqxibdPhY6KTPCbNB1GZA
         1+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724798970; x=1725403770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDrZ+EjYF19PvJC+i6jehJt+sfVjodbjYXEq8nEjBfw=;
        b=FPrQ6m865Pb4M7s9YGckP4NSlB/MLHUFBIk6H5A+JCk+qnijq2VdxC+yNAByWqJOYu
         iLjHQq/C/VQE/3hWoQXnGkm70/BX62HbU5Nk/jdlZaGT6SxOVq0uGsbLiyTpDp/x79ck
         R0fP4Reo62TLkBXu7WWgt2zTFGqm4auM0Ms5cddzsSxlD2QoH/EyKF86Qzlll8hL1CyB
         HndqFTQWRuEHUZ90dfvgWUXViXUoIet8f3yZpg2hwbS0U3M3bL7FPvE/KDIywwEOZRyx
         kDUU8IIVhIacLrxSEnHk4SdOiIiYhCJCUel/zy76QKeRDpjCaRyWAiPV8sEvwiVRcXAq
         uWlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgAdgd9A5G2RCJ8knp+4LhAJEO4K3z16sGJYv92qy/99bRrWC15yprqCciWbMXxrYvdVo/Pv0pRmmRYUxeTMlf@vger.kernel.org, AJvYcCWgBRi7vzDhp0891ilZqKSF0rhKfM7XBlH1RlvEiHVxz4Z23bUiWyVqxidYMY240+MpuxU=@vger.kernel.org, AJvYcCWgrUIRMbcLyowanmahlA4B+cIAoOVEE/BmcQjSynwoDlzWeO+Yquob1ufAMX4tsG5EnPkwtsMr5GxFjakg@vger.kernel.org
X-Gm-Message-State: AOJu0YwXAsVl3BQg0cib0yY5z9jO/jcyDLbH5+cgJMi3KXwhmIKW/Wup
	uFafh5I+5PeVi8FHI6rcJkL34oSqKeJ6xKRnOuy1YD/z0ijPabmaUF5XqLI4Duns/6qSFbdPOcC
	0WLfdTGJKNfxLWciQ7W8skjIsReE=
X-Google-Smtp-Source: AGHT+IEwBtby9TuFKewToNcAgGmssYT1IQ4FwnBLenBDL+7cmMy1RtU0QYGENMASBUl5BodCYDZ7bMyL99TsSkTiM0A=
X-Received: by 2002:a17:90b:4f8b:b0:2c9:e24d:bbaa with SMTP id
 98e67ed59e1d1-2d8441a247fmr197238a91.27.1724798970365; Tue, 27 Aug 2024
 15:49:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827133959.1269178-1-yikai.lin@vivo.com> <20240827133959.1269178-3-yikai.lin@vivo.com>
In-Reply-To: <20240827133959.1269178-3-yikai.lin@vivo.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 Aug 2024 15:49:18 -0700
Message-ID: <CAEf4BzZXL9=pOkt=GbrYG2DpDGtXNLS7AHH5rL3adHd50zMKmQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Fix cross-compile issue
 for some files and a static compile issue for "-lzstd"
To: Lin Yikai <yikai.lin@vivo.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Nick Terrell <terrelln@fb.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 6:40=E2=80=AFAM Lin Yikai <yikai.lin@vivo.com> wrot=
e:
>
> 1. Fix cross-compile issue for some files:
> [Issue]
> When cross-compiling bpf selftests for arm64 on x86_64 host, the followin=
g error occurs:
> progs/loop2.c:20:7: error: incomplete definition of type 'struct user_pt_=
regs'
>    20 |                 if (PT_REGS_RC(ctx) & 1)
>       |                     ^~~~~~~~~~~~~~~
>
> There are same error in files: loop1.c, loop2.c, loop3.c, loop6.c ???
>
> [Reason]
> On arm64, in file bpf_tracing.h, we use userspace's user_pt_regs,
> which is defined in "linux/ptrace.h".
> We include the header file by adding "-idirafter /usr/include" for "CLANG=
_CFLAGS".
>
> However, during cross-compiling, "linux/ptrace.h" is based on x86_64
> and has no definition of "struct user_pt_regs".
>
> [Fix]
> Thus, to fix this issue, we include the Linux source tree's header file d=
irectory.
>

Hm.. Not sure that's the right fix. Note -D__TARGET_ARCH_$(SRCARCH) in
BPF_CFLAGS, that __TARGET_ARCH has to match actual target
architecture, so please check that first.

pw-bot: cr

> 2. Fix static compile issue for "-lzstd":
> [Issue]
> By running the command "LDLIBS=3D-static LDFLAGS=3D--sysroot=3D/aarch64-l=
inux-gnu/libc ./vmtest.sh -s -- ./test_progs",
> during static cross-compiling, an error occurs:
> /aarch64-linux-gnu/bin/ld: aarch64-linux-gnu/libc/usr/lib/libelf.a(elf_co=
mpress.o): in function `__libelf_compress':
> (.text+0xec): undefined reference to `ZSTD_createCCtx'
> /aarch64-linux-gnu/bin/ld: (.text+0xf0): undefined reference to `ZSTD_cre=
ateCCtx'
> ...
>
> [Fix]
> For static compile, add "LDLIBS +=3D -lzstd".

we can probably just add it unconditionally, no? But please send it as
a separate change in its own patch

>
> Signed-off-by: Lin Yikai <yikai.lin@vivo.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index ec7d425c4022..5b725bc890d2 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -48,6 +48,10 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                 =
                 \
>  LDFLAGS +=3D $(SAN_LDFLAGS)
>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
>
> +ifneq (,$(findstring -static,$(LDLIBS)))
> +LDLIBS +=3D -lzstd
> +endif
> +
>  LDLIBS +=3D $(shell $(PKG_CONFIG) --libs libpcap 2>/dev/null)
>  CFLAGS +=3D $(shell $(PKG_CONFIG) --cflags libpcap 2>/dev/null)
>  CFLAGS +=3D $(shell $(PKG_CONFIG) --exists libpcap 2>/dev/null && echo "=
-DTRAFFIC_MONITOR=3D1")
> @@ -443,13 +447,19 @@ CLANG_TARGET_ARCH =3D --target=3D$(notdir $(CROSS_C=
OMPILE:%-=3D%))
>  endif
>
>  CLANG_SYS_INCLUDES =3D $(call get_sys_includes,$(CLANG),$(CLANG_TARGET_A=
RCH))
> +CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> +
>  BPF_CFLAGS =3D -g -Wall -Werror -D__TARGET_ARCH_$(SRCARCH) $(MENDIAN)   =
 \
>              -I$(INCLUDE_DIR) -I$(CURDIR) -I$(APIDIR)                   \
>              -I$(abspath $(OUTPUT)/../usr/include)                      \
>              -Wno-compare-distinct-pointer-types
>  # TODO: enable me -Wsign-compare
>
> -CLANG_CFLAGS =3D $(CLANG_SYS_INCLUDES)
> +#"make headers_install" at first
> +ifneq ($(CROSS_COMPILE),)
> +src_uapi_dir :=3D $(srctree)/usr/include
> +BPF_CFLAGS +=3D -I$(src_uapi_dir)
> +endif
>
>  $(OUTPUT)/test_l4lb_noinline.o: BPF_CFLAGS +=3D -fno-inline
>  $(OUTPUT)/test_xdp_noinline.o: BPF_CFLAGS +=3D -fno-inline
> --
> 2.34.1
>

