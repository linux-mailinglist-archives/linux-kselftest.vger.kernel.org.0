Return-Path: <linux-kselftest+bounces-12534-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4788914110
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 06:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2609A2837E0
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jun 2024 04:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220318C13;
	Mon, 24 Jun 2024 04:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkgdQeRB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE102563;
	Mon, 24 Jun 2024 04:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719203673; cv=none; b=d1Otq1wtAjYkmSvRRKBIkWDz1qipks8L/iTC6wX8ECLsF70ouJo7gh2c0WhiLIjaDt9MyxwfD/1ke4hcEzwa1fqDkDDc6a9+u4PpcxerPgL9IsRhwvwudNQB9UJGJCk6v12n24++WD44USZpMvhRhkZa5Kkj2BLPgYhunG6kCew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719203673; c=relaxed/simple;
	bh=jEowzjqp3iA4h7760o3ABQ/ao1BvbmgY4PW+UyUD/VQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IskpamN3YUIBVYKe8TzJCyik9/gBoEmyhX5ixk58s6D+DMmf8nPAWT7Nqoe0+22KcTswZ2zQ554etVlFk1WFJ8QW1Y5hfZkUvALKy7BZPuuHSXPxiwrKnkMP5O+kmww+HrBszwoZjiJRH3ldMsiYeSkSwX/22LBmeWy8mHXEQ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkgdQeRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417E3C2BBFC;
	Mon, 24 Jun 2024 04:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719203672;
	bh=jEowzjqp3iA4h7760o3ABQ/ao1BvbmgY4PW+UyUD/VQ=;
	h=From:To:Cc:Subject:Date:From;
	b=BkgdQeRB0vF6933hJ9Wip3oEtO0bBtxFqtDNFMt3ewjcQMYj1wInpu1urK3FRemAP
	 aikgnKGKdx9PqUS+QNvGVTr+7EAw6ivmUHnUU6Et46huvb4FxhwDBSOrUsCjb5J2rL
	 TFTqD4tQpSqz2ema31cIu2E5GC5FFJQzX6N1HyDsAPu8idNGZWB3F3gAP/0b/S0cWL
	 WwhumthroYDaFfRn0sX1aV4HbAPdJZ9IGaSOrhCTmFP6og+U4Tc2lf2VlglcA6VYso
	 0TvtsqXG/p4BKi0Dt/Rd/YbT5biYnECOW8gvRksHpSyZ/xoQkTqlJof+XZmKNiXs+V
	 ApKbzO3qZ6f8A==
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
Subject: [PATCH bpf-next v4 0/9] use network helpers, part 8
Date: Mon, 24 Jun 2024 12:33:47 +0800
Message-ID: <cover.1719203293.git.tanggeliang@kylinos.cn>
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
drop three local helpers tcp_server(), inetaddr_len(), make_socket(),
make_server() and make_client() in them.

Geliang Tang (9):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Invoke attach_reuseport out of make_server
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 263 +++++++++---------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  51 +---
 4 files changed, 140 insertions(+), 177 deletions(-)

-- 
2.43.0


