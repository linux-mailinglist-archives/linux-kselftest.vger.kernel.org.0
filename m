Return-Path: <linux-kselftest+bounces-12955-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6694691C9F4
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 03:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D05B1F230DD
	for <lists+linux-kselftest@lfdr.de>; Sat, 29 Jun 2024 01:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF69184F;
	Sat, 29 Jun 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4dYNNz4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9896386;
	Sat, 29 Jun 2024 01:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719624036; cv=none; b=QVW3LMxswVyJBBzhfqNtiNPWZwH333eUxb3zK7oR/OxeJxJRT6P4Gp2RZfEe2ARXq9ZHVZo7mo4DuorcIvv8UKcwDfVKzy8Gq4iWtclGv3/1wHhHByPE8xsbyz2EXjBsAhnbr2G9E9O4C8Umapg5NIbCBBxPorWUqEZunDWy8jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719624036; c=relaxed/simple;
	bh=80hrZdggvw9Deb3WWXxiN3Y4Sr3TbeCHrdXSTuAiccM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=msEwsI99PloH4lk0QmcikdgPLN4LCdoEGb6kH/sVC+Wpy8z8MoFe117CHP/j8r4/TEMdUT7Q6PVgpHmFd+fb+Q81mIhAmc9el4ietm14UbTZBt+Ul+G2TX0IgMKidiB1f5yjnx1ECfNwZyMsWMW+J2qwQ7NRuIFpGZmK691oCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4dYNNz4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4EAC116B1;
	Sat, 29 Jun 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719624036;
	bh=80hrZdggvw9Deb3WWXxiN3Y4Sr3TbeCHrdXSTuAiccM=;
	h=From:To:Cc:Subject:Date:From;
	b=Q4dYNNz48OjqfJOYP+nk4tUIR8kaXSRDWYKQFilDwBI48kzK58HrgmklsovxW27gM
	 RYxBd5mtoM1QZzTTCsOCWOJP2iMTAgRQmnzN4LKRhYjc2I8NDZfREILLYQ0xXu+JkZ
	 BB9PrH8zy0qVyXjI92cPr1veuOLwYShNHrBn5Lu+aChElKbrlGchXaZz8RxF71jBoX
	 GMKEjpxCKyQ6lDasBT64Oc2TUJv1f1XnzfGyYwvFPYvSyLXAFIV1teCz++Bj/dXlOP
	 K30rixw0TEteUms0Ojza5s33Bj1iho3p+/YHBAXNi5gdTTsTrS9eKzUc4lotbqtw3m
	 rE80m4XpsYqJQ==
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
Subject: [PATCH bpf-next v6 0/9] use network helpers, part 8
Date: Sat, 29 Jun 2024 09:20:10 +0800
Message-ID: <cover.1719623708.git.tanggeliang@kylinos.cn>
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
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 141 +++++++-----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  51 ++-----
 4 files changed, 61 insertions(+), 134 deletions(-)

-- 
2.43.0


