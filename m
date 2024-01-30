Return-Path: <linux-kselftest+bounces-3723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DECA68417F5
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 01:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95AD42846D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jan 2024 00:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC552C857;
	Tue, 30 Jan 2024 00:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3jNGCLw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4840A22075;
	Tue, 30 Jan 2024 00:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706576371; cv=none; b=DrHnsoFxJt2b9n4nY3moxclqo5gV39YaCscN8bW6o+CCd9YPKQHEFr+ATqJVhegzTuDerEG6G52BtIr2g3XmAQilS4gknbNSGtw3I3k0O1d/dBD+qNcysFlv82a7GMWH17CLlZvOHpYlV61BWNbiscbbsqe63cXsuUMeEQ0jB0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706576371; c=relaxed/simple;
	bh=MDG4Wdys0yj3AcD7z7ZjSveb79AyvT+W4mrPfehQvV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZpI9EPp56dmV3m2uVJ90mbrsAiRatsG1KernVVA0ukpp6zizU6D7UJ+nVDqpArkcc7Lxoz1OZiSCPR53SjILZNjgQNMlYG8FBK/MZY7lh9tknaKo6rUzx/+Rjz6NYKuotyvm3E76IGAZ9+gT4AyWroKcEdYX9AbSRhUCVC2nCo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3jNGCLw; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59612e4a21eso1276157eaf.3;
        Mon, 29 Jan 2024 16:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706576369; x=1707181169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E52GG0uHYg/rR2g8o6ITgMu78S4JP8FRXI0A7N7JZ+s=;
        b=c3jNGCLw/PQnmzTPUdgTa/B0h0m0JV20QziDSVbX6NJvsr7tcuEGLjShggKDImZFmB
         0HKY8ryOb+9/AQj5fHTEYKiJ+0PTC8XDEdMAp0wwlb7dCXFMzhCzXJXsqs09aCmA6ssS
         5FqhtwgVk/mEAkkHuh0TxIghbCK9zWlYpMAwVdRbn2zJd/+nWi9nEZxWdO2Xpg0gMmv5
         ctrsfw8EYjjqEcg6BQGfqFuKxWJ+Wm8i5EPtIy1i4F73Ag7ZeMR3HCfrdHUmvuQLmGBY
         6Q7vthoyHJJBYHIA9Q1VWMlOdR0sO2IgWXqPV7nncpiLL4LESvss1+ERA6satO3BpC7M
         PDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706576369; x=1707181169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E52GG0uHYg/rR2g8o6ITgMu78S4JP8FRXI0A7N7JZ+s=;
        b=SCIa/q/gqefpYJgNA6fLDzmTnK7GRa4lba/BfYVZxLkhTrKCyIG+6JZOb+wCKi+Pp3
         gPXHRXqQxYDfGAg9EgkIDJCdAu+Md70gVp3ITegysfmnHjErishXV3/WlkqMEyLvULS7
         ZkXN1n05Y8tp5Hh6O915e6MjYlqlOAgs2vv0piVw12GHy8KFsT2mVKLjw2o5iLyYXtoO
         gQbwhBelGQS6ScqFgHL43JsXIt8QkL5KehIRG3i0Ez3nn1E+/qKrylR4g1OFWpaQR2fO
         D5ucRf9x7YyBDm45dXqMY/xg1MwOXQnRQGYTIlmx3CDl4frGGTx99Ns21mi1MkW+eGvn
         Nciw==
X-Gm-Message-State: AOJu0Yy9O8dqyOEuHHPDGkyq1AHMYX9JF9gjz9GYb1nCQuwgYDC9kO4G
	f2+PEeLd4VBg7vmimz319Y06FtvmnozsnOXb8gyX9r5LplSVd2yiB+S8K294xO5S9WKciWnkAcI
	cYqds26OGmqUNuBUSq4Je5O22aYs=
X-Google-Smtp-Source: AGHT+IHZL4mEJB0WKIkpNFe2LHln2n8RS4Jlpugo6fA5db/zwfSuiMAzWN/n7+cyzeQigVk+RJ9o8QYPX8G7vv3NwVE=
X-Received: by 2002:a05:6358:e4a0:b0:178:7033:2d7a with SMTP id
 by32-20020a056358e4a000b0017870332d7amr2609611rwb.6.1706576369131; Mon, 29
 Jan 2024 16:59:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129070916.1639008-1-bjorn@kernel.org> <20240129070916.1639008-3-bjorn@kernel.org>
In-Reply-To: <20240129070916.1639008-3-bjorn@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Jan 2024 16:59:17 -0800
Message-ID: <CAEf4BzZwbfqY15=f6uGLgJ3aaPCDqjFk_DTbpzRnWJfr+jckGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: Make install target copy
 test_progs extra files
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 11:09=E2=80=AFPM Bj=C3=B6rn T=C3=B6pel <bjorn@kerne=
l.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> Currently, "make install" does not install the required test_progs
> "extra files" (e.g. kernel modules, helper shell scripts, etc.) for
> the BPF machine flavors (e.g. cpuv4).
>
> Add the missing "extra files" dependencies to rsync, called from the
> install target.
>
> Unfortunately, kselftest does not use bash as the default shell, so
> the globbering is limited. Blindly enabling "SHELL:=3D/bin/bash" for the
> Makefile breaks in other places. Workaround by explicitly call
> "/bin/bash" to expand the file globbing.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
>  tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 830a34f0aa37..c3c5b85f7dae 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -605,14 +605,15 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c            =
 \
>                          json_writer.c          \
>                          flow_dissector_load.h  \
>                          ip_check_defrag_frags.h
> -TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko=
 \
> -                      $(OUTPUT)/liburandom_read.so                     \
> -                      $(OUTPUT)/xdp_synproxy                           \
> -                      $(OUTPUT)/sign-file                              \
> -                      $(OUTPUT)/uprobe_multi                           \
> -                      ima_setup.sh                                     \
> -                      verify_sig_setup.sh                              \
> -                      $(wildcard progs/btf_dump_test_case_*.c)
> +TRUNNER_PROGS_EXTRA_FILES:=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testm=
od.ko    \
> +                           $(OUTPUT)/liburandom_read.so                 =
       \
> +                           $(OUTPUT)/xdp_synproxy                       =
       \
> +                           $(OUTPUT)/sign-file                          =
       \
> +                           $(OUTPUT)/uprobe_multi                       =
       \
> +                           ima_setup.sh                                 =
       \
> +                           verify_sig_setup.sh                          =
       \
> +                           $(wildcard progs/btf_dump_test_case_*.c)
> +TRUNNER_EXTRA_FILES :=3D $(TRUNNER_PROGS_EXTRA_FILES)
>  TRUNNER_BPF_BUILD_RULE :=3D CLANG_BPF_BUILD_RULE
>  TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_T=
ESTS
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> @@ -740,11 +741,17 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR=
) $(HOST_SCRATCH_DIR)    \
>  # Delete partially updated (corrupted) files on error
>  .DELETE_ON_ERROR:
>
> +space :=3D $(subst ,, )
> +comma :=3D ,
> +EXTRA_FILES_GLOB :=3D {$(subst $(space),$(comma),$(notdir $(TRUNNER_PROG=
S_EXTRA_FILES)))}
>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>  override define INSTALL_RULE
>         $(DEFAULT_INSTALL_RULE)
> -       @for DIR in $(TEST_INST_SUBDIRS); do              \
> -               mkdir -p $(INSTALL_PATH)/$$DIR;   \
> -               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
> +       @for DIR in $(TEST_INST_SUBDIRS); do                             =
               \
> +               mkdir -p $(INSTALL_PATH)/$$DIR;                          =
               \
> +               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;  =
               \
> +               rsync -a --copy-unsafe-links                             =
               \
> +                       $$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FIL=
ES_GLOB)")     \

this feels quite hacky... have you tried using $(foreach) to go over
each element of TRUNNER_PROGS_EXTRA_FILES and append $(OUTPUT)/$$DIR/
to each one? Hopefully that will allow us to get rid of space and
comma hacks?

I'm also wondering if it would be ok to just combine two rsync calls
into one, so that $(INSTALL_PATH)/$$DIR is specified once?


> +                       $(INSTALL_PATH)/$$DIR;                           =
               \
>         done
>  endef
> --
> 2.40.1
>

