Return-Path: <linux-kselftest+bounces-11762-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E9E905564
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 16:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1321B22BB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jun 2024 14:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4C617E47A;
	Wed, 12 Jun 2024 14:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rALHJXwU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426F917DE39;
	Wed, 12 Jun 2024 14:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203276; cv=none; b=OpH+XBJVBF6qqgRJr4GUt8d2kDwHDgQDJqHuO9PZGfUXhrqqqbuQ4ZW6dnZScIGYbQcBNvPBIAIyh/16cQ5eL9rIrIX+hrWtpX9xZTMdY50fijdMgGPZPjxOInDggiddXur0oQDfsatCRkMPu6+lMzZ1SjAYZiIJbDfS4XFCgqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203276; c=relaxed/simple;
	bh=NUaYbNltb6RDzO1opIZ+dAvvrh92tjYiV8X2KV18uKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGMVElnZ1WNSHtLqmT4+MDWhVnSDCK/2mRWvcfRHw/7XBwFNzk6IMVAlTsB6DjH++VEXz6Sw4TaJfXwjPGq4efzFjMVkaNiH6QBKkDps1pNCIpWNQTTab3SaLJ+9+bxNhIbFlMroqod0GNxzfc185y7Uj+B/RHKJjY2hpYEpCbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rALHJXwU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39787C116B1;
	Wed, 12 Jun 2024 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718203275;
	bh=NUaYbNltb6RDzO1opIZ+dAvvrh92tjYiV8X2KV18uKk=;
	h=From:To:Cc:Subject:Date:From;
	b=rALHJXwUxkHV0OxeZsvl+IG22aGM+/vYcvoMw9hx5XV+Z524XNZQgFR10OhAnxnuk
	 AyGH+ihGgC0Bsfn3Ic+uHXqGr+p0fxy7CeBOrHZ5loohNEeedAvOxvMGdw83mYB91g
	 NF3w2luEVJYLDQEwh67N2hsblBjDu2VKL5x7ikS8UqaqawNgMid3+ZkpzHGJdTpwzb
	 GhTbvEKBqwS0dQp+tvgYDRqzePQFtNWQMMUfuL3ctebpfxOui+GSmwDkck6R1j7vd/
	 QaQcVLrfsQie55LrtSsFgJ7PT7iwtMf7pAf65y1l/fILlj13UuHRBgf0RHQDmBbZ1h
	 H0ZA98hnxE7Ag==
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
Subject: [PATCH bpf-next v2 0/4] use network helpers, part 7
Date: Wed, 12 Jun 2024 22:41:02 +0800
Message-ID: <cover.1718202986.git.tanggeliang@kylinos.cn>
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
 - update patch 2, extract a new helper start_client.
 - drop patch 3, keep must_fail in network_helper_opts.

Drop type and noconnect from network_helper_opts. And use start_server_str
in mptcp and test_tcp_check_syncookie_user.

Patches 1-2 address Martin's comments in the previous series.

Geliang Tang (4):
  selftests/bpf: Drop type from network_helper_opts
  selftests/bpf: Drop noconnect from network_helper_opts
  selftests/bpf: Use start_server_str in mptcp
  selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user

 tools/testing/selftests/bpf/network_helpers.c | 45 +++++++++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  7 +--
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |  4 +-
 .../bpf/prog_tests/ip_check_defrag.c          |  7 +--
 .../testing/selftests/bpf/prog_tests/mptcp.c  |  7 +--
 .../bpf/test_tcp_check_syncookie_user.c       | 29 ++----------
 7 files changed, 49 insertions(+), 52 deletions(-)

-- 
2.43.0


