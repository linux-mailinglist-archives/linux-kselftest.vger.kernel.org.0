Return-Path: <linux-kselftest+bounces-13276-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7697D92941D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 16:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E906282A0D
	for <lists+linux-kselftest@lfdr.de>; Sat,  6 Jul 2024 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4C67764E;
	Sat,  6 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESxIsFaQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7EF1CA9E;
	Sat,  6 Jul 2024 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720277198; cv=none; b=irb91DfIA6s8A2SE0X7eevbqm+B0DYKOIsEkb8qWaaVJ2DgT4ZbIEy5XuzhcjX8O4wL08N9OJgabSEgCDDA7DXiHHFBrIQMZ6TVyClxuk9kmmyKXzpGFN/ShT6lQl+qvN0b61P+FbKsvLXXCbRRTI3gIOm1WVrPFjCCRg2AQLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720277198; c=relaxed/simple;
	bh=VlIrIUhHDQxq8RJifSZbUbFWZMEUAzBp3xmQGe6eib8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGW63rQlZqu/vEX6h47vBBpqpOJE6Yo/PrjVvog7bvuAUefxHg7cPRQ+YZiud90JWsZIEtvutNhShVNv5l+neffcKkYnCZzEsc0Uk6zH3u+LcghSTx/J2DwKiGoLRtWty/iKF/H9uTdOVg/9lPWeB4CBTZtwbJ0G9nQ9JEx5nt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESxIsFaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10E3C2BD10;
	Sat,  6 Jul 2024 14:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720277198;
	bh=VlIrIUhHDQxq8RJifSZbUbFWZMEUAzBp3xmQGe6eib8=;
	h=From:To:Cc:Subject:Date:From;
	b=ESxIsFaQExzLW1MvWcZLwVF7xl0SiEk8Zp+nMtskV4HqbeZFCNI+OSFUBpz4Fbk9H
	 5Ro5B8ITfXHF9qr/avRMyDj1LIsbj7SnsT4p5Fu2sCde8LY+P2RslpFNRhxyq6RAhY
	 O5FjA7Q4kggcYF4xhdoHhJwELUIrpEgouP3VbTCgwNKB8epQmeOYWqSNVWQzLaVSNZ
	 ko7OQhio24TvLfsnRQeYgyXuPqISjZk+/opb7ooeXSluoxrFZBS+S1H0TlvjFgrldz
	 69yngcPd+6c1PjMNckeX92qiXQ6Ksm/pKw5VrNKWk3bAFSl7OB5xlU86lzjCmbdgNM
	 DTHE793g+d/CA==
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
Subject: [PATCH bpf-next v9 00/11] use network helpers, part 8
Date: Sat,  6 Jul 2024 22:45:45 +0800
Message-ID: <cover.1720276189.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (11):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Add network_helper_opts for connect_fd_to_fd
  selftests/bpf: Add expect_errno for network_helper_opts
  selftests/bpf: Set expect_errno for cgroup_skb_sk_lookup
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |  23 ++-
 tools/testing/selftests/bpf/network_helpers.h |   8 +-
 .../testing/selftests/bpf/prog_tests/bpf_nf.c |   5 +-
 .../bpf/prog_tests/cgroup_skb_sk_lookup.c     |   8 +-
 .../selftests/bpf/prog_tests/cgroup_tcp_skb.c |   4 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 152 +++++++-----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  53 ++----
 8 files changed, 106 insertions(+), 148 deletions(-)

-- 
2.43.0


