Return-Path: <linux-kselftest+bounces-14005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8779939564
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 23:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBAD51C21881
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 21:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D512E646;
	Mon, 22 Jul 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXKfyCS4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D0E1CD37;
	Mon, 22 Jul 2024 21:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721683388; cv=none; b=KNCb1P9Wl+5AdeBokeepwUZFP85pljrAgSgY/mHMLnP7/U5Dp1GVeTQ5BxD1cf+jLlpxlNNUlrLRsQAFG232moWTm3VBwbXQUsh8hWB0K3jEH4GSfwi+cW7iMxDSkGCLbyt9Ro9OtROdwdiB6uTBTTQVbXxy5/9uZJD7CQvdVjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721683388; c=relaxed/simple;
	bh=wgXwqG86nv1CAX2uMaOWe0hu1SrZPOe+KQTSwbNhP7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n2i3tVKQ7QUNfrrbO7U/Pc3fZsMptA6VvdRXo1VrNzPML57rGOAj/AxALU/yn0LQMDEWaSjqsPuIzQbxQzOGFlu6LrVp3cVLmG8gEZfTZa80/gCY7nhcUuQVYKBWDj1Q3icaoy610MBAJ4agwZKVjtslo6j/rdPDVth0gfkmXyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXKfyCS4; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2cb5b783c15so2804135a91.2;
        Mon, 22 Jul 2024 14:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721683386; x=1722288186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOQFh8PaRSEQmdV2YAwOqQKCZAaVGzp4hCRg7dfaZHw=;
        b=DXKfyCS4r9UxIBdNGkWViLYg75rQer5aDrd+7DjZN3aLcsCG0oVaQ8W7a/B/c+CRhz
         vpCbaD1w030njpKcGuoOK8/l6k13sBzEVkNEB5gH/zMZK9eeE0uEGCjCkBG9F4+4vn44
         HK2cP9K4ezC/+I68WSm7R6hKL9+yeI3mxnbXnjDMjs//tg1Q59Q7kYlNrxafGZO5FKhA
         3u1qlG6kTVUd4/5CjAR4ahKN2Uw/wBmTwhYrwhTg4Oy2wFJDkTcbPTm/6nBb0/wDa94h
         zuW+nfEh7BJ3p3nWuJ2ng3Jya4sE7cVlBSdi+vFbmtwjo8SSvUUEjozE2SVW/+m8XROU
         WvVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721683386; x=1722288186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOQFh8PaRSEQmdV2YAwOqQKCZAaVGzp4hCRg7dfaZHw=;
        b=irWzx00colvSYkmZMJ6aXIE8W9t51QOfet2o4pFAEGlhSuBQuvcNM1XjXrjMtSGH2i
         svDzgG1eN1su4C5z00NPHxuRFCZ6C3K7u6rdzFfPH7ptHZAhSvf/FmRcfFZJzKf79qfI
         4s1Etik0G0WKBbjWbR0kb+BKAkwexYOJlcs/Jp9QfaOfEbW3caQz5MHgi8DQr0xqLziJ
         NySXVV62Y32HsmzcLmrdSmAB539Fuo9EHeM11gwo3leNBeWwXkhoIOQ9x+amqP2BGSb/
         MpREG6SosSfBjcig30+smLoS5/FdXbsI4z//9TDi4LzPozgRzqAKSXCppZGPO2bhm47D
         BBlw==
X-Forwarded-Encrypted: i=1; AJvYcCVZzXE+m7jHYdomSaUFvbakEpRmze7UeEkRh0Wjdujm+4q0JQCDmYvS1uzUeSOgzOVb2fRVkyMthWBYfeiLSwt5OyABLXeHM3BYkGhXOPCr
X-Gm-Message-State: AOJu0YydoLoguLzklFJKqYTwhiiXUMzZJwGepCcb4K8wU3oBcLBEaytL
	CkdBbraoY7RbRMxQp9hlNLZ7du/28A+cIag19D9pRHFQOkgQfBeaMv301bphkJ9Qiyv6jCTGkge
	lYLSAoCHNW9+GDSPkfeFG+U6khic=
X-Google-Smtp-Source: AGHT+IE7mqNZlzwnBGYIoMqITg9QfpXq/WY8LeC0Y548L6H+BesuTyQTD3IFAXf3h8TwyqqzmHnkhzvgiqttKQwUJos=
X-Received: by 2002:a17:90a:d791:b0:2c9:7219:1db0 with SMTP id
 98e67ed59e1d1-2cd85c8f3d7mr960411a91.3.1721683386010; Mon, 22 Jul 2024
 14:23:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1721541467.git.tony.ambardar@gmail.com> <7eeb1a1a9910b30782adba9eb5cc47c6ce075223.1721541467.git.tony.ambardar@gmail.com>
In-Reply-To: <7eeb1a1a9910b30782adba9eb5cc47c6ce075223.1721541467.git.tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 22 Jul 2024 14:22:53 -0700
Message-ID: <CAEf4BzY0rt56Zu2J2FOkzB1WuXtjDMgLuApqsKWnxnzbBQ1eKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Fix error linking
 uprobe_multi on mips
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

On Sun, Jul 21, 2024 at 12:51=E2=80=AFAM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Linking uprobe_multi.c on mips64el fails due to relocation overflows, whe=
n
> the GOT entries required exceeds the default maximum. Add a specific CFLA=
GS
> (-mxgot) for uprobe_multi.c on MIPS that allows using a larger GOT and
> avoids errors such as:
>
>   /tmp/ccBTNQzv.o: in function `bench':
>   uprobe_multi.c:49:(.text+0x1d7720): relocation truncated to fit: R_MIPS=
_GOT_DISP against `uprobe_multi_func_08188'
>   uprobe_multi.c:49:(.text+0x1d7730): relocation truncated to fit: R_MIPS=
_GOT_DISP against `uprobe_multi_func_08189'
>   ...
>   collect2: error: ld returned 1 exit status
>
> Fixes: 519dfeaf5119 ("selftests/bpf: Add uprobe_multi test program")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index a9c447c63fee..0b4bfbc0ef68 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -784,9 +784,12 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
>         $(call msg,BINARY,,$@)
>         $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o =
$@
>
> +# Linking uprobe_multi can fail due to relocation overflows on mips.
> +uprobe_multi.c-CFLAGS :=3D $(if $(filter mips, $(ARCH)),-mxgot)
> +
>  $(OUTPUT)/uprobe_multi: uprobe_multi.c
>         $(call msg,BINARY,,$@)
> -       $(Q)$(CC) $(CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $@
> +       $(Q)$(CC) $(CFLAGS) $($<-CFLAGS) -O0 $(LDFLAGS) $^ $(LDLIBS) -o $=
@

this $($<-CFLAGS) approach is fragile, non-obvious and will break. But
there is also no need for this, see:

$(OUTPUT)/bench: LDLIBS +=3D -lm

make allows to override envvars on a per-target basis, so all you
should need is:


$(OUTPUT)/uprobe_multi: CFLAGS +=3D $(if $(filter mips, $(ARCH)),-mxgot)
$(OUTPUT)/uprobe_multi: uprobe_multi.c
   ... the rest is the same with no change whatsoever ...

>
>  EXTRA_CLEAN :=3D $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)                     =
 \
>         prog_tests/tests.h map_tests/tests.h verifier/tests.h           \
> --
> 2.34.1
>

