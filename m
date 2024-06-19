Return-Path: <linux-kselftest+bounces-12199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7991F90E1B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93D5284B55
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22B23EA86;
	Wed, 19 Jun 2024 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EiR2E+ck"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B164A38;
	Wed, 19 Jun 2024 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718765483; cv=none; b=XQFAP6+urJ6wJyr6wK6dopYeUpTOpp5L/yDLoA2y5wGweIn64P7LW9mHwLTY1xRc/5xUZTIMATpbh10xd3GbhOvDCOGDd9A5EVLSTaB73mvFLka/aM6SVY5C/zL9teHP4MrVKSdFAvs5cEEaiOSKn2PThTjv6xs81VDfyvPkfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718765483; c=relaxed/simple;
	bh=8Di7/Brd71D0pPvNoS9ZbRqDWVJlhCU4sgA4hsE++Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mP7foMhgvGCpoKXrbkZPLUf1zOw3fEaDjVkEU5MNtpYVcX6xJ74aOV6Y9JFgCnxXQbgbQTYeZYD20BmmnaYoSXaNygWYuZEn6lqwd3hfUaAsfmlmwzFNh0h3vHhrOCi3N+M4M4szmX5dHUyeWNQdzccjWONoLmD5w7YB/ckK+yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EiR2E+ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A659C3277B;
	Wed, 19 Jun 2024 02:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718765483;
	bh=8Di7/Brd71D0pPvNoS9ZbRqDWVJlhCU4sgA4hsE++Ek=;
	h=From:To:Cc:Subject:Date:From;
	b=EiR2E+ckGVMzboSplLN+GCbRZTw8ziJ3g4u3ewzjD1OiB5O6kn0owisjCC0xa/ux2
	 qQ4uVUNhFfaTbSX8ZV3ckU1L9qpFlz7holZAujPlQNlh0OBzJe8P91KLl2X+HD2b0g
	 g+jgr1JO9hZcb4LIyOYmTrIDcZlciL6zsAkKWckGtS+AQ+ZMxoMF5uPq+wJCKXSQdh
	 G7o4cZFEsRyP3GEplqsyujvnDffAoIhzYisRfGdDuCCkzrFLVbJjcGCVzOtkx8b3re
	 DRjVncltKyyacd6DfqaUgFu7BmKL2yipqfIb0Kg8vcQVroapjGOXsTM0qoQJZ0JmmC
	 6nszIxJruc3Tw==
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
Subject: [PATCH bpf-next v5 0/6] use network helpers, part 7
Date: Wed, 19 Jun 2024 10:51:05 +0800
Message-ID: <cover.1718765123.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v5:
 - update patch 1, add getsockopt(SO_PROTOCOL) in connect_to_fd() to
fix errors reported by CI.

v4:
 - fix errors reported by CI.

v3:
 - rename start_client to client_socket
 - Use connect_to_addr in connect_to_fd_opt

v2:
 - update patch 2, extract a new helper start_client.
 - drop patch 3, keep must_fail in network_helper_opts.

Drop type and noconnect from network_helper_opts. And use start_server_str
in mptcp and test_tcp_check_syncookie_user.

Patches 1-4 address Martin's comments in the previous series.

Geliang Tang (6):
  selftests/bpf: Drop type from network_helper_opts
  selftests/bpf: Use connect_to_addr in connect_to_fd_opt
  selftests/bpf: Add client_socket helper
  selftests/bpf: Drop noconnect from network_helper_opts
  selftests/bpf: Use start_server_str in mptcp
  selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user

 tools/testing/selftests/bpf/network_helpers.c | 100 +++++++++---------
 tools/testing/selftests/bpf/network_helpers.h |   6 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   4 +-
 .../bpf/prog_tests/ip_check_defrag.c          |  10 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   7 +-
 .../bpf/test_tcp_check_syncookie_user.c       |  29 +----
 7 files changed, 62 insertions(+), 96 deletions(-)

-- 
2.43.0


