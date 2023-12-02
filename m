Return-Path: <linux-kselftest+bounces-999-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130C8018BC
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 01:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0B351F2108A
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Dec 2023 00:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68A663B;
	Sat,  2 Dec 2023 00:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WP7q2qW1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED03830F9;
	Fri,  1 Dec 2023 16:10:31 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3331752d2b9so1900687f8f.3;
        Fri, 01 Dec 2023 16:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701475830; x=1702080630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy+N5d1sKzj7I4P1vs4/0wYYWCdSwATy3bQ5v3nl6OA=;
        b=WP7q2qW1NmijZu9TDdUHVQ2+PXdrdGIva85EC8TskC+4NQ+etjhNXPahFELL5p+qhE
         1NpQvMUq+RB/KodXFgNHCmyT8NWicHl/u1OQl5RSS6KMdR75nwBFBy9AQnk5NcuWsE0p
         +snmnhlYM7Ch7AO8fMT9irlBtUpbTfP5ps0ohaNh2p15yPP8qXOhlk3hVL8pWvos/5NW
         waDl92cLCNwuao9rgxloma4ipPaBwe3ZDs+UZYu4x88mfg8NIDTDuHMfinTkMRXCBnER
         ipy5wzx8cB3kJ14ex4sDOgQ7cPw4ef3mgJ3buk35zGpyMRyGDUI2MQkYIbORj0ptz8st
         /YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475830; x=1702080630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy+N5d1sKzj7I4P1vs4/0wYYWCdSwATy3bQ5v3nl6OA=;
        b=m2NjHrgUwMEUJ7FuIPaSrhMgGOsbgA4/YUdN7AKfeKjqhG4j5n8M5JR6lvWBUP2MJi
         s772JGThVllQLXVIrpo7vK6kEBopB9zStiCi2rC73CMtJABVzPuAxzSJwk+vccAgtOTO
         bHldPhafYAn5W2VwxWTEVxibudC1jbGLMOsjHJNPopNCZSnXmqrAfnKU0VtrGstYCgcW
         YTI8nWW2EwXC/Vcv67DerhDt5rCBv37z+iN+0KndzE9GT3YiDRzsAZQCom9cIdmdpUZP
         W1g+uE30bEIn0cSawcMbiHa6GA+Wx2OAy3+BoGxpeZANPG0NOs5V7yYi2fbZGoX4M54Y
         zIWQ==
X-Gm-Message-State: AOJu0YxbNY9P9CGaIEdKMbZfXyeGe4cxtkGSLt/BIOrCpbIvnmwzTtbU
	qnnsxiCDg7Uf0pmTUKNhGLR2BVC2XLZgN8D7dK0McZhh
X-Google-Smtp-Source: AGHT+IFAOMmgvWu3DQQ28rpPVUzjYgXwP1BC01OgX29gy1bHVz0AvsDA74t0tlgKWpBBV01cV96gd+OIS9DHf6mJv8E=
X-Received: by 2002:a05:6000:bc2:b0:32d:9df1:6f68 with SMTP id
 dm2-20020a0560000bc200b0032d9df16f68mr1430697wrb.22.1701475830145; Fri, 01
 Dec 2023 16:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1701462010.git.dxu@dxuuu.xyz>
In-Reply-To: <cover.1701462010.git.dxu@dxuuu.xyz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Dec 2023 16:10:18 -0800
Message-ID: <CAADnVQKWrvec6ap_7O0Z5uAJe-pdrhuJk8LRkmWvGMM4iF9Frg@mail.gmail.com>
Subject: Re: [PATCH ipsec-next v3 0/9] Add bpf_xdp_get_xfrm_state() kfunc
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, clang-built-linux <llvm@lists.linux.dev>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, antony.antony@secunet.com, 
	Yonghong Song <yonghong.song@linux.dev>, Eddy Z <eddyz87@gmail.com>, devel@linux-ipsec.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 12:23=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This patchset adds two kfunc helpers, bpf_xdp_get_xfrm_state() and
> bpf_xdp_xfrm_state_release() that wrap xfrm_state_lookup() and
> xfrm_state_put(). The intent is to support software RSS (via XDP) for
> the ongoing/upcoming ipsec pcpu work [0]. Recent experiments performed
> on (hopefully) reproducible AWS testbeds indicate that single tunnel
> pcpu ipsec can reach line rate on 100G ENA nics.
>
> Note this patchset only tests/shows generic xfrm_state access. The
> "secret sauce" (if you can really even call it that) involves accessing
> a soon-to-be-upstreamed pcpu_num field in xfrm_state. Early example is
> available here [1].
>
> [0]: https://datatracker.ietf.org/doc/draft-ietf-ipsecme-multi-sa-perform=
ance/03/
> [1]: https://github.com/danobi/xdp-tools/blob/e89a1c617aba3b50d990f779357=
d6ce2863ecb27/xdp-bench/xdp_redirect_cpumap.bpf.c#L385-L406
>
> Changes from v2:
> * Fix/simplify BPF_CORE_WRITE_BITFIELD() algorithm
> * Added verifier tests for bitfield writes
> * Fix state leakage across test_tunnel subtests
>
> Changes from v1:
> * Move xfrm tunnel tests to test_progs
> * Fix writing to opts->error when opts is invalid
> * Use __bpf_kfunc_start_defs()
> * Remove unused vxlanhdr definition
> * Add and use BPF_CORE_WRITE_BITFIELD() macro
> * Make series bisect clean
>
> Changes from RFCv2:
> * Rebased to ipsec-next
> * Fix netns leak
>
> Changes from RFCv1:
> * Add Antony's commit tags
> * Add KF_ACQUIRE and KF_RELEASE semantics
>
> Daniel Xu (9):
>   bpf: xfrm: Add bpf_xdp_get_xfrm_state() kfunc
>   bpf: xfrm: Add bpf_xdp_xfrm_state_release() kfunc
>   libbpf: Add BPF_CORE_WRITE_BITFIELD() macro
>   bpf: selftests: test_loader: Support __btf_path() annotation
>   libbpf: selftests: Add verifier tests for CO-RE bitfield writes
>   bpf: selftests: test_tunnel: Setup fresh topology for each subtest
>   bpf: selftests: test_tunnel: Use vmlinux.h declarations
>   bpf: selftests: Move xfrm tunnel test to test_progs
>   bpf: xfrm: Add selftest for bpf_xdp_get_xfrm_state()
>
>  include/net/xfrm.h                            |   9 +
>  net/xfrm/Makefile                             |   1 +
>  net/xfrm/xfrm_policy.c                        |   2 +
>  net/xfrm/xfrm_state_bpf.c                     | 128 ++++++++++++++
>  tools/lib/bpf/bpf_core_read.h                 |  34 ++++
>  .../selftests/bpf/prog_tests/test_tunnel.c    | 162 +++++++++++++++++-
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |   1 +
>  .../selftests/bpf/progs/bpf_tracing_net.h     |   1 +
>  .../selftests/bpf/progs/test_tunnel_kern.c    | 138 ++++++++-------
>  .../bpf/progs/verifier_bitfield_write.c       | 100 +++++++++++
>  tools/testing/selftests/bpf/test_loader.c     |   7 +
>  tools/testing/selftests/bpf/test_tunnel.sh    |  92 ----------
>  13 files changed, 522 insertions(+), 155 deletions(-)

I really think this should go via bpf-next tree.
The bpf changes are much bigger than ipsec.

