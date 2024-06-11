Return-Path: <linux-kselftest+bounces-11626-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE449902E1E
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 03:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C69E41C2142D
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Jun 2024 01:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF58D9475;
	Tue, 11 Jun 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1eJClju"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867DD63CB;
	Tue, 11 Jun 2024 01:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071195; cv=none; b=QVP6LoA38TvwMbIy/fcH1RnsKBkE1hdKZSM/Ouye6bk1QP37PHW5ntHUsCWqHyHioHgNkjO9xnjGfj8R0Y5+qNcFvCS6Efv4VeEXdEHTbF4f976/SreJD0itvVGkQxv2napXCpgC7LF0GcSJfqXjexcM3r+VPvxAjskMKmgD5pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071195; c=relaxed/simple;
	bh=qE7+rU9j/Eq441VUHf1ZTUMFnLKkgmM/B9hiLemg/xs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aGNNPdp6moBd0snC5LPUzw8Rgt7Cc7NuiIWsDsypOoKfM+Nd2BzAAj8JAwd20ROxbGqCgGLMep8rjRQFuE+uUacmL2PFA25JNLCqg6NJ+Pi/CyduxpZws/vkU/1F/kE+c+cWrLD1OxVESw5nW++fbjjmn5tE3VO0QP2owxqk4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1eJClju; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDF6C2BBFC;
	Tue, 11 Jun 2024 01:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718071194;
	bh=qE7+rU9j/Eq441VUHf1ZTUMFnLKkgmM/B9hiLemg/xs=;
	h=From:To:Cc:Subject:Date:From;
	b=T1eJCljut30WhMsTIjRZnjYYTJnWNZ+KcI08ddTlCwRokgLyIEXD7xRvMmB+WJWZ+
	 s9/SqTJuMWrnxstXuNNSLyXkjWFccXcA1U7nbDGQU2SZ+Ke+oKHyA2DuXLaFuzd6zK
	 waQF5FHycsA+g+xbUtvZqSxXesotqKYG5WI1q9ZONTOi3Mx6/fj0qiu7nVciTP47cM
	 KDv8pp9FOfg/LnLOh2Vxb2FG/5d3lonA+SAipD+JGV5IhvH1OMNj4gUM58hmeKI9wM
	 Pss4Q5bgKfWGiQIr7iratO998v5+1s7kouRtrKnv6f9ynzmn9ZRZ4ZJ29HxtXFqscj
	 2iIu4aL8KBWtw==
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
Subject: [PATCH bpf-next 0/5] use network helpers, part 7
Date: Tue, 11 Jun 2024 09:59:33 +0800
Message-ID: <cover.1718070939.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Drop type, noconnect and must_fail from network_helper_opts. And use
start_server_str in mptcp and test_tcp_check_syncookie_user.

Patches 1-3 address Martin's comments in the previous series.

Geliang Tang (5):
  selftests/bpf: Drop type from network_helper_opts
  selftests/bpf: Drop noconnect from network_helper_opts
  selftests/bpf: Drop must_fail from network_helper_opts
  selftests/bpf: Use start_server_str in mptcp
  selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user

 tools/testing/selftests/bpf/network_helpers.c | 20 ++++++++-----
 tools/testing/selftests/bpf/network_helpers.h |  5 ++--
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  5 +---
 .../bpf/prog_tests/ip_check_defrag.c          |  7 ++---
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  7 +----
 .../bpf/test_tcp_check_syncookie_user.c       | 29 ++-----------------
 6 files changed, 21 insertions(+), 52 deletions(-)

-- 
2.43.0


