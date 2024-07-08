Return-Path: <linux-kselftest+bounces-13292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65238929AC7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 04:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2262811F2
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Jul 2024 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18E42FB6;
	Mon,  8 Jul 2024 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blajTWWj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9324E1C17;
	Mon,  8 Jul 2024 02:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720405805; cv=none; b=pssMfULmEYwfE0wEccOm/loOEOEqi71wNLhMiX83JLVuNGhcsmk06HGtSmD4NjB+PN5267ulB2Bw8TGBaafpfNiranNXnsnCtSMM7bJghKPX+RdxB43IgATe7Uqjifj/IxU+v5hlnQJkCmfXUPDk1Wcr5ODeAfIPXqHqkXXfkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720405805; c=relaxed/simple;
	bh=P/e+3D1/aaKxamTQAhuY70Q6zqK+kYyv9hdxidL0c0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pt5M7sUFH87ypBqfB1ckFchdk867tmEQtBe4U3gvfqgMQFpXrSSfySy/o1w3cnNwODHmAMOvszAi31r/NQhF0GCwvGdhXdbowsQrhBxCl3nUQ5OTkX4oVMahE+Ocrhr98NM1rjC2UGyV8EzbdKTgWQlMmt9mhCr7li2AtnTTsco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blajTWWj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D5EC3277B;
	Mon,  8 Jul 2024 02:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720405805;
	bh=P/e+3D1/aaKxamTQAhuY70Q6zqK+kYyv9hdxidL0c0E=;
	h=From:To:Cc:Subject:Date:From;
	b=blajTWWjecV0tcTpdSmnzFx4AZJxO1oTfam7doJetmgbd0sMG16qmJU29ckfyh3pL
	 ktiURLg0GTDt1dZQaznHZA2VAFuIodWKBNZHopJe7I8xQQnWXU0Hppo+4ym52+OcGb
	 EfyR41snvk3l3kFtqfUeF0m2g/FmYc0dr+WQHq1o17z/BbG7dDRwxsai5GUSDMKJsF
	 u8dtS7AagdV51McL7VWIEMKmhPpqJBxBZOXFlivwfUvkmAJL3qqGGpL48a56jbwFk/
	 0Q35n1jUEv7z3fPge5TVV6xb9fo0wQ73uKuCDo5iVNpIuSwwvHRlGGKwwOjydbtCxy
	 JI+uU6i2LvA/g==
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
Subject: [PATCH bpf-next v10 00/12] use network helpers, part 8
Date: Mon,  8 Jul 2024 10:29:38 +0800
Message-ID: <cover.1720405046.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v10:
 - a new patch 10 is added.
 - patches 1-6, 8-9 unchanged, only commit logs updated.
 - "err = -errno" is used in patches 7, 11, 12 to get the real error
   number before checking value of "err".

v9:
 - new patches 5-7, new struct member expect_errno for network_helper_opts.
 - patches 1-4, 8-9 unchanged.
 - update patches 10-11 to make sure all tests pass.

v8:
 - only patch 8 updated, to fix errors reported by CI.

v7:
 - address Martin's comments in v6. (thanks)
 - use MAX(opts->backlog, 0) instead of opts->backlog.
 - use connect_to_fd_opts instead connect_to_fd.
 - more ASSERT_* to check errors.

v6:
 - update patch 6 as Daniel suggested. (thanks)

v5:
 - keep make_server and make_client as Eduard suggested.

v4:
 - a new patch to use make_sockaddr in sockmap_ktls.
 - a new patch to close fd in error path in drop_on_reuseport.
 - drop make_server() in patch 7.
 - drop make_client() too in patch 9.

v3:
 - a new patch to add backlog for network_helper_opts.
 - use start_server_str in sockmap_ktls now, not start_server.

v2:
 - address Eduard's comments in v1. (thanks)
 - fix errors reported by CI.

This patch set uses network helpers in sockmap_ktls and sk_lookup, and
drop three local helpers tcp_server(), inetaddr_len() and make_socket()
in them.

Geliang Tang (12):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Add network_helper_opts for connect_fd_to_fd
  selftests/bpf: Add expect_errno for network_helper_opts
  selftests/bpf: Set expect_errno for cgroup_skb_sk_lookup
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_fd_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |  23 ++-
 tools/testing/selftests/bpf/network_helpers.h |   8 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   5 +-
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     |   8 +-
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c |   4 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 162 +++++++-----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  53 ++----
 8 files changed, 108 insertions(+), 156 deletions(-)

-- 
2.43.0


