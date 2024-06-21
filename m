Return-Path: <linux-kselftest+bounces-12385-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D160911858
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 04:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09852B20F07
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 02:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DBF44C7C;
	Fri, 21 Jun 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F452Djy0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560524B4A;
	Fri, 21 Jun 2024 02:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936179; cv=none; b=KZjSDBda12BHr4ZgonbTJMZiAaX2/7X8al93PcX3/Wchxigc89eVFk7tyq6PlY+ZNU4S4k40cnqMOGvmGqoEC8ygW0OrJPh15qQoKroqpdFcDhzL8OSjf3EXcXrNiCIfEymrusXgo8q/wmcABWEqjIC04oxCCofTm/0Twtx4Quo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936179; c=relaxed/simple;
	bh=Xc9MWeXL6e69rJ1lZoohWld3xjM1XxXqr9k+VitX1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shCARDHw1tsc2Kgb6+SOPxnSq/i6ZoMisFBYIwLG5ssGf64aZLs6cj93nUMNiA5rRxLQSrtQq8ZULLeYbdyYrc+DN+d6DkzGEnVH4RueaDJvCbhoYLKAgDys9DLpHyX9qbGXrfkUjORxoZnLkAvwlXuN7O9zWXaYseQA4vcKw90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F452Djy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B2F1C2BD10;
	Fri, 21 Jun 2024 02:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936179;
	bh=Xc9MWeXL6e69rJ1lZoohWld3xjM1XxXqr9k+VitX1MM=;
	h=From:To:Cc:Subject:Date:From;
	b=F452Djy0nOXJOIiIg0bkR4hdAvminbMFdMUiomYmn4ab9XLLJma9oznjjQkX7vWAO
	 6rNPKLFyUxLdFX18tv2ULHHpAJstcGitwccD+MVGEwdQXkcVdFygSXmDDJkYxV5Cq8
	 WRaOZST4IIgsIyAQyBhfNry5sP30es4L6H5qsQROgIqmAIRP6LtLglzVIpNSpg7QVl
	 5XNPjuCae51j0XCveIN9Z4yWsu6vJzR4XeupkYerqHedzchXIKa98U2erqdcDlSQOP
	 6l4gIeLVP5Ilae+6QwGqaIMAbqC3uDZ/FuFX+8vDTBBLDEzoFJrMZCdFgqUfU6hYCQ
	 BBTgi0aZp2g4g==
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
Subject: [PATCH bpf-next v6 0/6] use network helpers, part 7
Date: Fri, 21 Jun 2024 10:15:57 +0800
Message-ID: <cover.1718932493.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v6:
 - update ASSERT strings in patch 4 as Eduard suggested. (thanks)

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
 .../bpf/prog_tests/ip_check_defrag.c          |  14 ++-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   7 +-
 .../bpf/test_tcp_check_syncookie_user.c       |  29 +----
 7 files changed, 64 insertions(+), 98 deletions(-)

-- 
2.43.0


