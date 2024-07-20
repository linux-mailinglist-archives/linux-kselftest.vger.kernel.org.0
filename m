Return-Path: <linux-kselftest+bounces-13947-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24948937EC5
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 04:57:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6B21C21217
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Jul 2024 02:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8568F4E;
	Sat, 20 Jul 2024 02:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gf/d3Z0b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6257E1;
	Sat, 20 Jul 2024 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721444244; cv=none; b=i7z5DWHRdtJ0IhRUnuv495fl10xNN9pr0IYf+KmyCUzfwdo1fzCi0tziJYtEFUmJ1xBUABq+4FwY8EtUV32uI7PIrRQ9Zr5/4nHxJxajJfYqGfEKikpsz0p+ztCTXI21dZ0cz+l3GWYWwy837Y3Z38IZkpG7VV3lkAnb85RVTYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721444244; c=relaxed/simple;
	bh=mQIEmc2DFMyNtssBIDQR69JocwEhsetWDToUs2QePm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZeL54n3Thu0TbhBEKPhjBePQdQJIg/9NJhQOiZYCoWHyorDmaY63JoX9U7rg4O5geecDyvgHfjPJkbk7rSo6yiteCugDcDO+3dLRETPkZ4PiaBTA7uY87uy59S/L4GCuFByYK9wkkYLGfMbIXphSM12zZ02vBoUR9S/0sa8pnI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gf/d3Z0b; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2cb4b7fef4aso1413533a91.0;
        Fri, 19 Jul 2024 19:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721444242; x=1722049042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bw5Ya8rgw09s6Su5RaHs80Z+d+a79ubPp3fNsa0DV8g=;
        b=gf/d3Z0bCLf8g8VkK626KIdRJVFRf3/y9yisEDY36WjURfPo2bvBiF0V247YAAerhM
         j8cb2hdWKJKZCU19NODxjWcyk2L05UTxzwHoq4SpsDTPcJ/VT/MhvJNklY1bCixh508N
         /5fii4DA+Atu8wtI5D3aAGuxBAWZzlkFV++agRxix6BHI0gjz5o9uTnGG+CdgpQ75RNo
         8+PfeqEIMmYagqzqbLZkMdb6CqhUqAel5XZkFKSgGwBEUgMzsh/jXYjnzpE2pxnqdQn7
         z1KW22c8hMqk2/i8cc1OjJbMhrkJWYOvZepWucisk7whXfZ8vBnMpIFTkgubOW/8gs/S
         sD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721444242; x=1722049042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bw5Ya8rgw09s6Su5RaHs80Z+d+a79ubPp3fNsa0DV8g=;
        b=oWyfxX79OGfYqwwF6GmBR1ZdgeX011CRitsydIxlk9Ne+x0GiSTaT2F2SqJpzTsFqz
         mD0gwTt5nhLTbWax3dzGwC/GiVhVKFQ8uaDBZYBhUfvPpd+aiIB2QHvjbDDGObBsg0Lo
         9seE+pi9N5VRS3hxGSeqI48S0hitLjZ5NFsRKLm0uYIWU/xVOmPyYYXd5f5pMbtRZc0N
         OvzxVGITkVcmX8/DkSvQRRXBkfizsSI61Apm36cYrjr8Nb5DvHTKuhcU4HblM157gT4F
         ygxqu6Vr6wzvm46j2PMVCPKxlRnbzirHyXG1svZXrIP9cf9/VKGpW35oE6bgYUCECQKw
         CY/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBTX12MFcSEGlq4uP1ykBKPME81MZjusTi5LAgEv+JJjYvTp7K+7uTWCy8VoiZ4ITjJm9XeFHKMM54njuffTk6Bcq4cvIiRzFMGKTua7xM
X-Gm-Message-State: AOJu0YzrzOduZmEHUA6xOD7YVL2oPtXohFOvHib4r56mu3fyDRdL8uDD
	2TGShLgRdIcSyEbn202pWw23sOthwXhzgxyZzxxPGs4oPPm7FMLU5UE+STrhyrqNt/Z97DvQyTQ
	lVsYqzBOjSX1rvg3JhuKojgYySUM=
X-Google-Smtp-Source: AGHT+IEwqtfWH0vFaSHbk83pQb+y7Ce+97QEnIt5jBjZvILb5zqLleJNwflktEPjH+0C7ZrKnm9rb2UlJ7kaywGKhso=
X-Received: by 2002:a17:90a:c303:b0:2c9:7e9d:5344 with SMTP id
 98e67ed59e1d1-2cd274a4cf1mr266883a91.32.1721444241796; Fri, 19 Jul 2024
 19:57:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEf4BzarKiUZqNcq1E+6SaeG8oP5+SfSLLoTNKF3_+7MS6CtyQ@mail.gmail.com>
 <20240719232159.2147210-1-tony.ambardar@gmail.com>
In-Reply-To: <20240719232159.2147210-1-tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jul 2024 19:57:09 -0700
Message-ID: <CAEf4BzZ-caZKO_kEqhh930_x3UGVXQ3NJJaG5BZq9NJhaP2xng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] selftests/bpf: Fix wrong binary in Makefile
 log output
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 4:22=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail.=
com> wrote:
>
> Make log output incorrectly shows 'test_maps' as the binary name for ever=
y
> 'CLNG-BPF' build step, apparently picking up the last value defined for t=
he
> $(TRUNNER_BINARY) variable. Update the 'CLANG_BPF_BUILD_RULE' variants to
> fix this confusing output.
>
> Current output:
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_maps] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h
>
> After fix:
>   CLNG-BPF [test_progs] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_progs-no_alu32] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-no_alu32] access_map_in_map.skel.h
>   ...
>   CLNG-BPF [test_progs-cpuv4] access_map_in_map.bpf.o
>   GEN-SKEL [test_progs-cpuv4] access_map_in_map.skel.h
>
> Fixes: a5d0c26a2784 ("selftests/bpf: Add a cpuv4 test runner for cpu=3Dv4=
 testing")
> Fixes: 89ad7420b25c ("selftests/bpf: Drop the need for LLVM's llc")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 0b4bfbc0ef68..67921e3367dd 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -425,27 +425,28 @@ $(OUTPUT)/flow_dissector_load.o: flow_dissector_loa=
d.h
>  $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
>
>  # Build BPF object using Clang
> -# $1 - input .c file
> -# $2 - output .o file
> -# $3 - CFLAGS
> +# $1 - binary name
> +# $2 - input .c file
> +# $3 - output .o file
> +# $4 - CFLAGS
>  define CLANG_BPF_BUILD_RULE
> -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> -       $(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv3 -o $2
> +       $(call msg,CLNG-BPF,$1,$3)
> +       $(Q)$(CLANG) $4 -O2 --target=3Dbpf -c $2 -mcpu=3Dv3 -o $3

this works, but did you have to renumber all parameters? Let's maybe
pass this binary name as the 4th argument?

pw-bot: cr

>  endef
>  # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
>  define CLANG_NOALU32_BPF_BUILD_RULE
> -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> -       $(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv2 -o $2
> +       $(call msg,CLNG-BPF,$1,$3)
> +       $(Q)$(CLANG) $4 -O2 --target=3Dbpf -c $2 -mcpu=3Dv2 -o $3
>  endef
>  # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
>  define CLANG_CPUV4_BPF_BUILD_RULE
> -       $(call msg,CLNG-BPF,$(TRUNNER_BINARY),$2)
> -       $(Q)$(CLANG) $3 -O2 --target=3Dbpf -c $1 -mcpu=3Dv4 -o $2
> +       $(call msg,CLNG-BPF,$1,$3)
> +       $(Q)$(CLANG) $4 -O2 --target=3Dbpf -c $2 -mcpu=3Dv4 -o $3
>  endef
>  # Build BPF object using GCC
>  define GCC_BPF_BUILD_RULE
> -       $(call msg,GCC-BPF,$(TRUNNER_BINARY),$2)
> -       $(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes =
-O2 -c $1 -o $2
> +       $(call msg,GCC-BPF,$1,$3)
> +       $(Q)$(BPF_GCC) $4 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes =
-O2 -c $2 -o $3
>  endef
>
>  SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
> @@ -534,7 +535,7 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:      =
                       \
>                      $(wildcard $(BPFDIR)/bpf_*.h)                      \
>                      $(wildcard $(BPFDIR)/*.bpf.h)                      \
>                      | $(TRUNNER_OUTPUT) $$(BPFOBJ)
> -       $$(call $(TRUNNER_BPF_BUILD_RULE),$$<,$$@,                      \
> +       $$(call $(TRUNNER_BPF_BUILD_RULE),$(TRUNNER_BINARY),$$<,$$@,    \
>                                           $(TRUNNER_BPF_CFLAGS)         \
>                                           $$($$<-CFLAGS)                \
>                                           $$($$<-$2-CFLAGS))
> --
> 2.34.1
>

