Return-Path: <linux-kselftest+bounces-3646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 758F283E645
	for <lists+linux-kselftest@lfdr.de>; Sat, 27 Jan 2024 00:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FDF286C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 23:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F556775;
	Fri, 26 Jan 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgKbVv5N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC8A55E57;
	Fri, 26 Jan 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706310645; cv=none; b=siqpfCtFMk5YQp7qUJAkHIdXn7MnWavzRvwd1ZmNndZRD+dWhUB/2A+H/PwSQQSBDMjEcwPDw/lezNgdQyiFhG6a8WaE98kbNXCRUWFeaj+rfW1MkLYZs7pia9bN1dPxUKQKrrQWJwLMAr/jKRK6sBAjRNCqDWlQdtNR2WpYgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706310645; c=relaxed/simple;
	bh=4s5rwQWKuNmfTZ8yy2P8juM8S9siTPP4iA3k+/YAqpw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtoPPHQRBAyYor96N2ano/fXhfpaQgFe5ywV4yGZhdkXlZlbvXWHGCp46Z9PACh6GzBTgVaEQO8HzwaoC4w/XGbGFWC2Duwm8/B9KclJ6wBOlEsqDPhrNGYew5k8WA93FPj4XV0QsmSlBrhmuJLIv3tXZ3J6uvraKd1hYSh5lok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgKbVv5N; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ceb3fe708eso560425a12.3;
        Fri, 26 Jan 2024 15:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706310644; x=1706915444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZFzREQcy01BZIUxaGbT3ihF9K354LZydl6TIjgS5Zc=;
        b=CgKbVv5N3QCzUUIvpR3UXcmGIuHDlB3ixpV7oyyOu4/RfG5VqLRF6H/fIGcAFCNTWB
         ad6wPX/7H45KrSER0k3hP6IhMuIyAF/pxsSj5AmOwbHmbFB9ujAMQV4ncibrSFMIGvzw
         SZx7AMcJzAzg7dEy13OlF6bNbyOVGTVAAg97TPnj+zR0dWOEi5U6/IJHnFcbOa7+6Itn
         /l8gCCShJxqjifRG3YSby8egWipTYBbxwFYMDHJ48ZqkUlUQQRfJXIdr64ZSYGlLQWq7
         yXbPNRgwvrsZ/Org17yLcATNS1NTQYuGBV1GNdp+G0bXeF3zIG6E1GVeFRUnlfEK/iG9
         dZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706310644; x=1706915444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZFzREQcy01BZIUxaGbT3ihF9K354LZydl6TIjgS5Zc=;
        b=J0c87/f7bKY9FEOXRe0NefwI8xdY6fE5Zh11axzBVT167FZwmr1oFLrqFaYjJZCGDF
         V/jH9vMkPidOSOEcK4MIJAAG4RLnzwRxIHJYwmbyshGJjPs2ADBk5h8F/J120QCoqFbq
         MD2NfUrrozO9vwJFVQ3VxtbUqcLOsSkHav8x6vTgK/6VUWSEQiu1JSwd4W7dVYlUkM2a
         5AJvBQuuci4+DFcLl7WjMzeipyXHrmyO3UWFSwESUBraGVc10foEhvka8bKhSeQx0Q36
         LotD9i4322LzRDBzfPQPTTIxDkiCi9hseHPgwDO8IRo1xIAG5cTMCdRJ+NXe72s8+O7x
         lmeg==
X-Gm-Message-State: AOJu0YxloxQqv8yHYQ00HbQPPgEnVO+V8uHKz1HHs6hL2i7mRPDaR/Uh
	cjsZat9qbwHL0G164p9nHvF17iYH3OFMoUTFZR2H4IHJsX59v3h7cxwj3QlLgot9oeVLt7iW6Gb
	2sAcka8JCgot4ExanfqdKP+ST8X0=
X-Google-Smtp-Source: AGHT+IGd7ggcaBb4WHmLbM7WO0m4GsPjD8aXb+dDgLUUC+lgNwa2zahlij40bgEF4XgxghreabZ37VO9upZ9Lp3WSt4=
X-Received: by 2002:a17:902:b10d:b0:1d5:e9bd:7834 with SMTP id
 q13-20020a170902b10d00b001d5e9bd7834mr701837plr.33.1706310643614; Fri, 26 Jan
 2024 15:10:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125160502.1512422-1-bjorn@kernel.org>
In-Reply-To: <20240125160502.1512422-1-bjorn@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 26 Jan 2024 15:10:31 -0800
Message-ID: <CAEf4BzaewwHQn7xBgiuckH3xbRHGc6GxvAq6rXf6Ep+KDWDEFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Include runner extras for
 install target
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 8:05=E2=80=AFAM Bj=C3=B6rn T=C3=B6pel <bjorn@kernel=
.org> wrote:
>
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>
> When using the "install" or targets depending on install, e.g.
> "gen_tar", the "runner extras" weren't included for the BPF machine
> flavors.
>
> Make sure the necessary helper scripts/tools are added to
> corresponding BPF machine flavor.
>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> ---
> v2: Added btf_dump_test_case files
> ---
> tools/testing/selftests/bpf/Makefile | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index fd15017ed3b1..d5cff32997b3 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -744,8 +744,20 @@ EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR)=
 $(HOST_SCRATCH_DIR)     \
>  DEFAULT_INSTALL_RULE :=3D $(INSTALL_RULE)
>  override define INSTALL_RULE
>         $(DEFAULT_INSTALL_RULE)
> -       @for DIR in $(TEST_INST_SUBDIRS); do              \
> -               mkdir -p $(INSTALL_PATH)/$$DIR;   \
> -               rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
> +       @for DIR in $(TEST_INST_SUBDIRS); do                    \
> +               mkdir -p $(INSTALL_PATH)/$$DIR;                 \
> +               rsync -a --copy-unsafe-links                    \
> +                       $(OUTPUT)/$$DIR/bpf_testmod.ko          \
> +                       $(OUTPUT)/$$DIR/bpftool                 \
> +                       $(OUTPUT)/$$DIR/ima_setup.sh            \
> +                       $(OUTPUT)/$$DIR/liburandom_read.so      \
> +                       $(OUTPUT)/$$DIR/sign-file               \
> +                       $(OUTPUT)/$$DIR/uprobe_multi            \
> +                       $(OUTPUT)/$$DIR/urandom_read            \
> +                       $(OUTPUT)/$$DIR/verify_sig_setup.sh     \
> +                       $(OUTPUT)/$$DIR/xdp_synproxy            \
> +                       $(OUTPUT)/$$DIR/btf_dump_test_case_*.c  \
> +                       $(OUTPUT)/$$DIR/*.bpf.o                 \
> +                       $(INSTALL_PATH)/$$DIR;                  \

My concern is that this will get out of sync and will go unnoticed
next time we add another "extra" file. We have TRUNNER_EXTRA_FILES,
should we use that list to keep these extras in fewer places?

>         done
>  endef
>
> base-commit: c8632acf193beac64bbdaebef013368c480bf74f
> --
> 2.40.1
>

