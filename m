Return-Path: <linux-kselftest+bounces-13187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B292728B
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 11:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AD261F21718
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Jul 2024 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7041AB518;
	Thu,  4 Jul 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QW8Dy9iM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BF1A38DD;
	Thu,  4 Jul 2024 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720083604; cv=none; b=KjVezGm8pTEd8GO0UWEjrXBsCZaTxr+CtlyWNsKWAsUVUcb/E2SSN5BNTkeN9edYvIjJjq7sLSQIaFYjGNMjbr8ZqUdLGv/sfNKXujlZ1o99ctPw5uZGWZU9GTGigZDtpAS0pG1uRq2AKBf2X/sR1Bmpuq2Vh6y/pbo5c3bic5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720083604; c=relaxed/simple;
	bh=jCWxpcZ8rhkHZJlYflZCnWerPGj31UAA9Mp987bvphk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RsGHiViGPqHH6i7LBCT5v1SlVdvntraX3GWpMNEzedjqOtlJA4U/H7zpIibehAl2mb/ryqPB1bDIGi6xAIHw9K3xu/t/j8wtW0kPp4QqmjjIlxc+K0i4gqzgkD73CQj8FdpTzc1wnoLfPRGVelivXm7PsMsbXY8wHny/OvCwcd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QW8Dy9iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6FFC3277B;
	Thu,  4 Jul 2024 08:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720083604;
	bh=jCWxpcZ8rhkHZJlYflZCnWerPGj31UAA9Mp987bvphk=;
	h=From:To:Cc:Subject:Date:From;
	b=QW8Dy9iMwUfSoCl3nU5G9VNT28ybUhDqiuy7wIPrRPOCFCqFwpOIk/X5qsXpYgwhd
	 CMxQfPJ98/F6orB61dxKQzjv7lts5IhHeoikoVIAQPUJiT5LaEogZsWLo/1sKHN+mM
	 e6vDVcnh2mZl53DrFPjy9E3aBr8kCMB3eGIqfsitXTCHA7GkfebjWWI64Q7qsVozSv
	 NgyRqSz+bCPkxggt7GNPHxtiABUvbBu10NzcrPDyVWA64bCtBa2fHY9MzJpYkL7lyG
	 ZIt1aOoW/HIhkYvODj6ejAmFiFIDN+7U8pX60yYWxNipUjbhKWGjz9K5nD1hobO7KV
	 jCKoFRo3w5bKA==
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
Subject: [PATCH bpf-next v7 0/9] use network helpers, part 8
Date: Thu,  4 Jul 2024 16:59:37 +0800
Message-ID: <cover.1720083019.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (9):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd_opts in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 150 ++++++++----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  53 ++-----
 4 files changed, 77 insertions(+), 132 deletions(-)

-- 
2.43.0


