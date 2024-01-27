Return-Path: <linux-kselftest+bounces-3661-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6A183ED67
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 14:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A31EEB2318E
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A13425620;
	Sat, 27 Jan 2024 13:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkd/UVY7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52DD28DA0;
	Sat, 27 Jan 2024 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706363229; cv=none; b=LiNfRm3Yhq0Gimf1BcmdrhTj0w8k8k+W6g8ZhwQdkAUlb435TFPvnlFij0ns2tasAbdnvbtxFN8PCnQh7qsOtr0mU4ivagexrx5V6Ij/qs2v3v+kty+AkEpFgKGj3S2+4rMNLJI8zRn4P/LNc8qw/36SlXuQ/RCp1QiqA1I3CSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706363229; c=relaxed/simple;
	bh=tqr/MJPFM3xP9xKf9IifJQCHwrhiOME8NrbdPmROiNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QnvGKhSZuBRmlghdT+tILWjt5OE0rafBXkhSe4lfG1BJfi44UcY44e2D1Z/XAuFILq2Rh5FX5jjo4Y+QOLsWGEVb8QzF2ERWilhQ1YtbTrhqd37E9Ak/8Qc18N8Zel7C/lTy0E/y+/T4HJU0Dwj/NvH92QN2BD6LXk0Lsr6WcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkd/UVY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F86C43394;
	Sat, 27 Jan 2024 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706363228;
	bh=tqr/MJPFM3xP9xKf9IifJQCHwrhiOME8NrbdPmROiNg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lkd/UVY7RIef143IcP6Yf+1Q6+eFRyvQbSm6L0qgM5D0ieJRX05BnTUHjHLcfcwZF
	 EvFsv7riEgNvpI96sDGnWDS3HDoGY7V6gTcxq+lAVxMBfadH+FrReTKlig1CUmetri
	 VrcRzSTHtXZZeVBp3FbK+FhbblbxxIEggJRsiYdTT4Teux/UvC6kT+tpCTOJgf/xMv
	 Y0kGgA7QLvtfRvrBubSwLeKD9BKi5NyRNfSwNceU8kP4ENFTaz0cKIBxaXtU/60ggA
	 tVwVy6rsL5v0Jx0mpx1mlV4g8lp0wYLksIIGuHf65kgVM5tXIUFO0xT9YkTJxLcsla
	 Hcj25pGjkQfzA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Mykola
 Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Make install target copy
 test_progs extra files
In-Reply-To: <20240127133327.1594026-2-bjorn@kernel.org>
References: <20240127133327.1594026-1-bjorn@kernel.org>
 <20240127133327.1594026-2-bjorn@kernel.org>
Date: Sat, 27 Jan 2024 14:47:05 +0100
Message-ID: <875xzex50m.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

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
> v3: Do not use hardcoded file names (Andrii)
> v2: Added btf_dump_test_case files
> ---
>  tools/testing/selftests/bpf/Makefile | 29 +++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 830a34f0aa37..d66c689f0f3c 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -605,14 +605,15 @@ TRUNNER_EXTRA_SOURCES :=3D test_progs.c		\
>  			 json_writer.c 		\
>  			 flow_dissector_load.h	\
>  			 ip_check_defrag_frags.h
> -TRUNNER_EXTRA_FILES :=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testmod.ko=
	\
> -		       $(OUTPUT)/liburandom_read.so			\
> -		       $(OUTPUT)/xdp_synproxy				\
> -		       $(OUTPUT)/sign-file				\
> -		       $(OUTPUT)/uprobe_multi				\
> -		       ima_setup.sh 					\
> -		       verify_sig_setup.sh				\
> -		       $(wildcard progs/btf_dump_test_case_*.c)
> +TRUNNER_PROGS_EXTRA_FILES:=3D $(OUTPUT)/urandom_read $(OUTPUT)/bpf_testm=
od.ko	\
> +			    $(OUTPUT)/liburandom_read.so			\
> +			    $(OUTPUT)/xdp_synproxy				\
> +			    $(OUTPUT)/sign-file					\
> +			    $(OUTPUT)/uprobe_multi				\
> +			    ima_setup.sh					\
> +			    verify_sig_setup.sh					\
> +			    $(wildcard progs/btf_dump_test_case_*.c)
> +TRUNNER_EXTRA_FILES :=3D $(TRUNNER_PROGS_EXTRA_FILES)
>  TRUNNER_BPF_BUILD_RULE :=3D CLANG_BPF_BUILD_RULE
>  TRUNNER_BPF_CFLAGS :=3D $(BPF_CFLAGS) $(CLANG_CFLAGS) -DENABLE_ATOMICS_T=
ESTS
>  $(eval $(call DEFINE_TEST_RUNNER,test_progs))
> @@ -740,11 +741,17 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR=
) $(HOST_SCRATCH_DIR)	\
>  # Delete partially updated (corrupted) files on error
>  .DELETE_ON_ERROR:
>=20=20
> +space :=3D $(subst ,, )
> +comma :=3D ,
> +EXTRA_FILES_GLOB :=3D {$(subst $(space),$(comma),$(notdir $(TRUNNER_PROG=
S_EXTRA_FILES)))}
>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>  override define INSTALL_RULE
>  	$(DEFAULT_INSTALL_RULE)
> -	@for DIR in $(TEST_INST_SUBDIRS); do		  \
> -		mkdir -p $(INSTALL_PATH)/$$DIR;   \
> -		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
> +	@for DIR in $(TEST_INST_SUBDIRS); do						\
> +		mkdir -p $(INSTALL_PATH)/$$DIR;						\
> +		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;			\
> +		rsync -a --copy-unsafe-links						\
> +			$$(/bin/bash -c "echo $(OUTPUT)/$$DIR/$(EXTRA_FILE_GLOB)")	\

Argh! Bad commit. EXTRA_FILE_GLOB should be EXTRA_FILES_GLOB. :-(

LMK if you can fix it up, or if you want me to resubmit.


Bj=C3=B6rn

