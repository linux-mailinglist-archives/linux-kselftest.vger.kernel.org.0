Return-Path: <linux-kselftest+bounces-12118-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 896E290C2A8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 06:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F4025B21189
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE80C71742;
	Tue, 18 Jun 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mf6QGm0r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A225C2595;
	Tue, 18 Jun 2024 04:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718683657; cv=none; b=MUd2122nR4yunXJfJbX1MX+jqiOG/0WM4UmYWOoN33/KsQPR5/HTtGL1eM7TAJsMxJv2iMEMynfeDH49sgVBOnoPHVs+8DFQ7J+gBISyPQqVLXW7JR3UgEtgh8TPNCdZ1Lmj+kZSU/o9dVeymDMWS0n6s/+cP1NFRP3HUGm6pNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718683657; c=relaxed/simple;
	bh=TbxIKr6cpGaKDdkd0LQSDMYSeOoabXdZBQBjbOSVYIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l23q1WGP4v098tM5lrTn/Tzo3LR+qF6Uzsfsz9VS5FnZ+/G5OngEGxPkdHLZ6LwJ/NoiqtuMwgJEQJFT5I5NoKNXPnaEz1olJq0US1uNdYqR4rzUVBeN/HFNJWNlODOWLMf5+S9mLcO4rzMdOisZFUwtZPzXFHsYGC6rW/UcX3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mf6QGm0r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87BA0C3277B;
	Tue, 18 Jun 2024 04:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718683657;
	bh=TbxIKr6cpGaKDdkd0LQSDMYSeOoabXdZBQBjbOSVYIc=;
	h=From:To:Cc:Subject:Date:From;
	b=Mf6QGm0rwRbwENFZmvnhFGgKQPKo0pUBgx0USAORY6LVPrNtyfbEsuQND9EZ0Gyqe
	 Cfap1R2o03v5AGYx05FtmKEDIgTCgVWrb7VuviY0TX84D8qklEoeRQqvvPJW66LSRx
	 k5sLWkn0jeN18D0FlMvLh3phaPXsTI/OEQemeo06miH3DYsRlGW6GoW8B2twKBx11O
	 L8tcuGdw2UzWDVBCSuntFyUGu6+So8/C5fgjC0VJ50WNQG7grBbKZkW/rkccMjAgzs
	 F/gMYSYoidOq9Sj+oS2ikDWMFteqWejbyJWTy34a+RsjR5kQSiVrKD6GoIQ/eemvZX
	 3eDAjvqBgkIhA==
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
Subject: [PATCH bpf-next v4 0/6] use network helpers, part 7
Date: Tue, 18 Jun 2024 12:06:50 +0800
Message-ID: <cover.1718683292.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 tools/testing/selftests/bpf/network_helpers.c | 94 +++++++++----------
 tools/testing/selftests/bpf/network_helpers.h |  6 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  4 +-
 .../bpf/prog_tests/ip_check_defrag.c          | 10 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  7 +-
 .../bpf/test_tcp_check_syncookie_user.c       | 29 +-----
 7 files changed, 56 insertions(+), 96 deletions(-)

-- 
2.43.0


