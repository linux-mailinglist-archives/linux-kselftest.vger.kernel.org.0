Return-Path: <linux-kselftest+bounces-13164-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C3F926FEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 08:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E20331F240A9
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 06:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D161A0722;
	Thu,  4 Jul 2024 06:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLhGPDzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4FF18637;
	Thu,  4 Jul 2024 06:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720075701; cv=none; b=MRWr75akL2FyWAeOUtt2YW0+BFsgazCjklQqFwdObwLCDuQx0j+pyzPeUPt+RHjbQBN6xvMo/B87/iCe5926QbFUvcg8O06uikjhbJNrvLNybjikG1oY+aVNOMOSHD8S0eSxrXJjD5ZFg9mwAE9lcTvAhWaPohnkkGRaHU0jHyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720075701; c=relaxed/simple;
	bh=gaACC8KL5TcXR94XExnbLBC/mEnsyQ5p/7jxrxWofTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XwsihdMvwn5Z5EsxXbjgkT/xU7aRVRsS/ZcfrlQFKf3Sw5jcoEiNYZspCDjYlc9qHPZdvzchOOdg0Q+TczbK/TpB0+Ej4hxanN66Lh16j35VfUG/EjtTsOI4Xl4vTVfSUpVAS9BCG/vg4bo0uagx/i2lI0okKtphoyTUIxGwwdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLhGPDzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE59BC3277B;
	Thu,  4 Jul 2024 06:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720075700;
	bh=gaACC8KL5TcXR94XExnbLBC/mEnsyQ5p/7jxrxWofTg=;
	h=From:To:Cc:Subject:Date:From;
	b=kLhGPDzbcUVL+6usIp3HgjMvZJl7v0WGFf55F8+llA7ZelwjJXjR7pDzTqa7VhB4k
	 10bMnZiqsdg5CHQMPSKvcBwfU26kC00LFiF6rjuiLUf13W4t2EzLCcQgit8E2oKA24
	 7iJeAwvSfEzbPuPE22aqDM2C+7lvm7w7zorM1jPfHL5pb9xWbkB4c+JIMR0NOlsFAh
	 5RXJDl28QST/ptnSjA4vyjKdWjlgPQJ09LiEpEvS2Y40y3WAlgrACsLc6GSpkI9ABm
	 ho3OWS0HjPbtjcwUSlnVfrGOr7P+KhqT2fipn0IWDGvilF7ZTuPQauAMAaxgasy/Jj
	 Ep68ed4I+A8Ig==
From: Geliang Tang <geliang@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/6] skip ENOTSUPP for BPF selftests
Date: Thu,  4 Jul 2024 14:48:00 +0800
Message-ID: <cover.1720075006.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

BPF selftests seem to have not been fully tested on Loongarch platforms.
There are so many "ENOTSUPP" (-524) errors when running BPF selftests on
them since lacking BPF trampoline on Loongarch.

For these "ENOTSUPP" tests, it's better to skip them, instead of reporting
some "ENOTSUPP" errors. This patchset skips ENOTSUPP in ASSERT_OK/
ASSERT_OK_PTR/ASSERT_GE helpers to fix them. This is useful for running BPF
selftests for other architectures too.

Geliang Tang (6):
  selftests/bpf: Define ENOTSUPP in testing_helpers.h
  selftests/bpf: Skip ENOTSUPP in ASSERT_OK
  selftests/bpf: Use ASSERT_OK to skip ENOTSUPP
  selftests/bpf: Null checks for link in bpf_tcp_ca
  selftests/bpf: Skip ENOTSUPP in ASSERT_OK_PTR
  selftests/bpf: Skip ENOTSUPP in ASSERT_GE

 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 20 +++++++++-------
 .../testing/selftests/bpf/prog_tests/d_path.c |  2 +-
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 10 +-------
 .../selftests/bpf/prog_tests/module_attach.c  |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        |  2 +-
 .../selftests/bpf/prog_tests/sock_addr.c      |  4 ----
 .../selftests/bpf/prog_tests/test_bprm_opts.c |  2 +-
 .../selftests/bpf/prog_tests/test_ima.c       |  2 +-
 .../selftests/bpf/prog_tests/trace_ext.c      |  2 +-
 tools/testing/selftests/bpf/test_maps.c       |  4 ----
 tools/testing/selftests/bpf/test_progs.h      | 24 ++++++++++++++-----
 tools/testing/selftests/bpf/test_verifier.c   |  4 ----
 tools/testing/selftests/bpf/testing_helpers.h |  4 ++++
 13 files changed, 41 insertions(+), 41 deletions(-)

-- 
2.43.0


