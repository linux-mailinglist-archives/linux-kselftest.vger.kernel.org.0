Return-Path: <linux-kselftest+bounces-13209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A86592807A
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 04:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 995E6B221AE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 02:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27076171A4;
	Fri,  5 Jul 2024 02:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKeP2i3Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9643C463;
	Fri,  5 Jul 2024 02:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147115; cv=none; b=l+n5068x3OPLyIyyngoKP0xL+RvNyVpnrXfn/tgZ2nd1RP6SpMt9OWWPa4UciWTccMOAj1LGSUYyO0INQgaTo0gtSyXAGv2iH8UvJNu2W4PrAO9dx5/J+rgPWsWKzecVuOK6jmLgT2tdHqVCJTGPB6bp28vYVXe8ACDWXMIPMHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147115; c=relaxed/simple;
	bh=srbY5+r7jocsIeSVOz2x6LAmfvSb0XIvo/YdI0IlFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EOLbj9pTl5WtAs4etZncEtzNZQbnRgKSO+pjddSwDElmEITn54iFed18CCjwkc0HhtJ0pSw4H2koWkzI2WEQw1877sVqCYfK87ETr5zP8jC/3LFPtTtExoB+dMmDLXqMYaazY+zMv0q1Sv033w/UMmMgIWHlUNboY2YP8xYeDjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKeP2i3Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545C9C3277B;
	Fri,  5 Jul 2024 02:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720147114;
	bh=srbY5+r7jocsIeSVOz2x6LAmfvSb0XIvo/YdI0IlFHI=;
	h=From:To:Cc:Subject:Date:From;
	b=VKeP2i3QowQB6XelL2gfauAQqHrd3CLhw1SEQuBLPguqsuCv4weS3ZIVuOb8Py/8m
	 r5lb79vOj0OUirQrBkip1BKjzcdJoNlRfR5lhu5MYKbgI+pZ1zcTCK/IWsfWkcFbOk
	 dX51n2zS8Xj91OwKpdB/sjzQI/GbmYR8+sBro12GSsunP7TgR+lXlB+0utafEnJflo
	 z9sAvbteV0Ws4maKLuPkov9S70Ly1pHR7aqcnoOLDSdRVTNb0eqEvIb7/ryMS5OdDH
	 JHs/m+hppj5jYR/+/ttoTFFqQTllJhb9DJAOOivOK89gw4MF60BrPFYgivvyXO3eW9
	 A/ISGWF4jnXwg==
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
Subject: [PATCH bpf-next v2 0/6] skip ENOTSUPP BPF selftests
Date: Fri,  5 Jul 2024 10:38:18 +0800
Message-ID: <cover.1720146231.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - Although all CI tests passed on x86_64 "bpf/vmtest-bpf-next-VM_Test-22
Logs for x86_64-gcc / test (test_progs, false, 360) / test_progs on x86_64
with gcc", some unexpect "SKIP"s are showed in the log:

  #29/1    bpf_tcp_ca/dctcp:SKIP
  #29/2    bpf_tcp_ca/cubic:OK
  #29/3    bpf_tcp_ca/invalid_license:OK
  #29/4    bpf_tcp_ca/dctcp_fallback:SKIP
  #29/5    bpf_tcp_ca/rel_setsockopt:OK
  #29/6    bpf_tcp_ca/write_sk_pacing:OK
  #29/7    bpf_tcp_ca/incompl_cong_ops:OK
  #29/8    bpf_tcp_ca/unsupp_cong_op:OK
  #29/9    bpf_tcp_ca/update_ca:OK
  #29/10   bpf_tcp_ca/update_wrong:OK
  #29/11   bpf_tcp_ca/mixed_links:OK
  #29/12   bpf_tcp_ca/multi_links:OK
  #29/13   bpf_tcp_ca/link_replace:OK
  #29/14   bpf_tcp_ca/tcp_ca_kfunc:OK
  #29/15   bpf_tcp_ca/cc_cubic:OK
  #29/16   bpf_tcp_ca/dctcp_autoattach_map:SKIP
  #29      bpf_tcp_ca:OK (SKIP: 3/16)

 Shouldn't skip any tests on X86_64. Fix this in v2.

 - add a new helper test_progs_get_error.

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

 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 20 ++++++-----
 .../testing/selftests/bpf/prog_tests/d_path.c |  2 +-
 .../selftests/bpf/prog_tests/lsm_cgroup.c     | 10 +-----
 .../selftests/bpf/prog_tests/module_attach.c  |  2 +-
 .../selftests/bpf/prog_tests/ringbuf.c        |  2 +-
 .../selftests/bpf/prog_tests/sock_addr.c      |  4 ---
 .../selftests/bpf/prog_tests/test_bprm_opts.c |  2 +-
 .../selftests/bpf/prog_tests/test_ima.c       |  2 +-
 .../selftests/bpf/prog_tests/trace_ext.c      |  2 +-
 tools/testing/selftests/bpf/test_maps.c       |  4 ---
 tools/testing/selftests/bpf/test_progs.h      | 33 +++++++++++++++----
 tools/testing/selftests/bpf/test_verifier.c   |  4 ---
 tools/testing/selftests/bpf/testing_helpers.h |  4 +++
 13 files changed, 50 insertions(+), 41 deletions(-)

-- 
2.43.0


