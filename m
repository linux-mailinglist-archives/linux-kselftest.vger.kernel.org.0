Return-Path: <linux-kselftest+bounces-15580-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC6D955621
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 09:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2092E1F22129
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Aug 2024 07:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B8513E043;
	Sat, 17 Aug 2024 07:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SO8MazQF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3813CFA3;
	Sat, 17 Aug 2024 07:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879338; cv=none; b=pKzg2jvRYILSgCbGPvvkQZzBEkGKsgwwD3wvl8qj5BBdX5TwC1fAZH2rJ9/CHUEb0XZkeTRa8VxlnkxJXCY9eYv88dXUmMS2sQBkDCtOOQz7KaqVN7iZIGxaZk2DmvMzGkcFiIfcwn0kmCzbrGHtdUR9HB6nQHGZc4IGDFDd9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879338; c=relaxed/simple;
	bh=7cnVUeChjgu+H9+YLNcBRYkwu+eWF6JojTp+Wk1c2NE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJwXNgH4TgeXgYCeF8hM+gTQoaacsoAcyvZMBxK3LW54hrlSo/OoZBHt82hyVe5tZdAuFPtY9bpvh+MqMMLcrOiOEed5PefMlYixvqd23lUlvQkFtHqwmElHIYeEYobNHYx8ZDOQyDfX62teSTJ/Reu8Wpjq2M/P8vC1q6xNZ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SO8MazQF; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3718eaf4046so1335954f8f.3;
        Sat, 17 Aug 2024 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723879334; x=1724484134; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qv//cMXlZMFtqNbjMe4oj82em7Hd3JuMo8tNEDaIu4c=;
        b=SO8MazQFX5LAfiZoFAIi1Y2AFqW1yhZle51xaUC9sEOMBR66by4SYC0xxpwJfVSgNN
         ipnf3vudq6Tw1OxNfvbZT+q8K2pmWJevP3T4HcS0/o6JxGImXzJ6RdVYE9/rDr3U+62G
         dzc5IuR4Ntrt9ojtoZQ3uOUN/RDDhHqfwiOkKYmWVA3DjEry6mo7dGTyVePN5Y3jth60
         dRNe59EfG76eA0y7kPox2n1+9xRApCPi56a0BJtITSrD2qWZtX/iED67dDiY7W6/kgmM
         +No+8A0A3nnXjbNTLzT7eDEBQ8ejx2GC0C6p+NQEomim5k637KT77MEMJW5IamvKledN
         lj0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723879334; x=1724484134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qv//cMXlZMFtqNbjMe4oj82em7Hd3JuMo8tNEDaIu4c=;
        b=QyaFUz7YRXw+rgrS3fwKtV8S3NKyTCQJAnh4zz66W5OFfEcw4qb32pLvI+NA+E3Dqf
         XNqcubvvs3nexAHV9ZyuEV1eegTMfvoTOP3o30XcoATJ6CefxWZgJVJnYXWSfDxeeta8
         qyQcdBypWH9WfLuzMXPdOQTv50XF9NOq0c/PVZh7Fq71J71Ufr4ozaqCV7VqL8Ck6/Bd
         wSCwrn6vlIywLgaDEagCx8OzdyGpvZhIv24IF5A4enLqscw5mps1RrmZEya/rRpykkSP
         arSN5IlyP+SFZGshczzk9VCEJadGR5BgtnxQ463W5CBwdX6jcgyJRYNK6uRRK9WDSVU7
         vW9g==
X-Forwarded-Encrypted: i=1; AJvYcCWg2tBth2ZOga0/sDMVJS2pjP4mU8VVbj4s6flxoI+B8QEqSOvkUurGbQsBnv4YXh6AVPYl+v6hL0cvHnnU/5sGxK6EleAFzpT1A+qsmUlfaTdSP8Nbp5953mNqXZEvNGqx9vJO80jI9E0MhZQlGKjZkVawg/a9DPzvwNcR005efP0TXhOzUcka4cruizjGViQx+6nH9PbhZYJ1
X-Gm-Message-State: AOJu0YyF4pH8WdtmNMJE14/6JB/4sMlVyBLDxHmLTpgUpfR8VYdH6V/Y
	qn6hglWMORIHmZyTLfnBd3GL9sreRB5bza0OzBS8y6PAgMf3Dj3pKAOLh6cM59F4YexT1Zfle99
	mnLiPuEJxznmZUKXTzC6APiccyOQ=
X-Google-Smtp-Source: AGHT+IGYPED+EDMmtWlfqZ30mThja6VK8NtB6YP/LLvy3rtLIhdo6cjAoEMDY3Rrqz+oI/iTzfyvpN6uMxgGM1b65vA=
X-Received: by 2002:adf:facf:0:b0:368:4b9d:ee2c with SMTP id
 ffacd0b85a97d-3719443d206mr3972273f8f.19.1723879333453; Sat, 17 Aug 2024
 00:22:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816-ups-bpf-next-selftests-use-khdr-v1-0-1e19f3d5b17a@kernel.org>
 <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
In-Reply-To: <20240816-ups-bpf-next-selftests-use-khdr-v1-1-1e19f3d5b17a@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 17 Aug 2024 09:22:02 +0200
Message-ID: <CAADnVQ+JBq8-6Rhi_LHX470uj2_2xxJAhgdUfg_abUxEDqpdJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] selftests: bpf: use KHDR_INCLUDES for the
 UAPI headers
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Mykola Lysenko <mykolal@fb.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf <bpf@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 7:56=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> Instead of duplicating UAPI header files in 'tools/include/uapi', the
> BPF selftests can also look at the header files inside the kernel
> source.
>
> To do that, the kernel selftests infrastructure provides the
> 'KHDR_INCLUDES' variable. This is what is being used in most selftests,
> because it is what is recommended in the documentation [1]. If the
> selftests are not executed from the kernel sources, it is possible to
> override the variable, e.g.
>
>   make KHDR_INCLUDES=3D"-I${HDR_DIR}/include" -C "${KSFT_DIR}"
>
> ... where ${HDR_DIR} has been generated by this command:
>
>   make headers_install INSTALL_HDR_PATH=3D"${HDR_DIR}"
>
> Thanks to 'KHDR_INCLUDES', it is no longer needed to duplicate header
> files for userspace test programs, and these programs can include UAPI
> header files without the 'uapi' prefix.
>
> Note that it is still required to use 'tools/include/uapi' -- APIDIR,
> which corresponds to TOOLS_INCLUDES from lib.mk -- for the BPF programs,
> not to conflict with what is already defined in vmlinux.h.
>
> Link: https://docs.kernel.org/dev-tools/kselftest.html#contributing-new-t=
ests-details [1]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> ---
>  tools/testing/selftests/bpf/Makefile                       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/assign_reuse.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tc_links.c          | 4 ++--
>  tools/testing/selftests/bpf/prog_tests/tc_netkit.c         | 2 +-
>  tools/testing/selftests/bpf/prog_tests/tc_opts.c           | 2 +-
>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c      | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_bonding.c       | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_cpumap_attach.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_devmap_attach.c | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_do_redirect.c   | 2 +-
>  tools/testing/selftests/bpf/prog_tests/xdp_link.c          | 2 +-
>  tools/testing/selftests/bpf/xdp_features.c                 | 4 ++--
>  12 files changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftes=
ts/bpf/Makefile
> index 4eceb491a8ae..6a7aeae7e206 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -37,7 +37,7 @@ CFLAGS +=3D -g $(OPT_FLAGS) -rdynamic                  =
                 \
>           -Wall -Werror -fno-omit-frame-pointer                         \
>           $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)                    \
>           -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)          \
> -         -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> +         -I$(TOOLSINCDIR) $(KHDR_INCLUDES) -I$(OUTPUT)
>  LDFLAGS +=3D $(SAN_LDFLAGS)
>  LDLIBS +=3D $(LIBELF_LIBS) -lz -lrt -lpthread
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tool=
s/testing/selftests/bpf/prog_tests/assign_reuse.c
> index 989ee4d9785b..3d06bf5a1ba4 100644
> --- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> +++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /* Copyright (c) 2023 Isovalent */
> -#include <uapi/linux/if_link.h>
> +#include <linux/if_link.h>

No. This is not an option.
User space shouldn't include kernel headers like this.
Long ago tools/include directory was specifically
created to break such dependency.
Back then it was done for perf.

pw-bot: cr

