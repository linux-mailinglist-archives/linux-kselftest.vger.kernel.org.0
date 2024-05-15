Return-Path: <linux-kselftest+bounces-10232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC098C6077
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 08:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4211C21E4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6FB3A29C;
	Wed, 15 May 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxmBmR1I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABE3D541;
	Wed, 15 May 2024 06:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752808; cv=none; b=hMqsszsQ/Wn+XUSz6FF8DkMPYTScHzpeltGPCY0RjYDnYYsnJMXlVY7cnpVAyUquMu5EorhDXv3uBq0siJkcUnEWtjEAk+0gFWGUhyvwWzX5k88+J8WhlOslvVZoi+p5J0HoKGIHfcn7Gkme2utmaDXXzRf6iq7MPK6+UHeUHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752808; c=relaxed/simple;
	bh=AQ3tkiONemRilHkmlqquV+TjmIQLfUDgsuuM0Tf2bCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QuhQ9GXdmCBvrOvjLxxOoiU06KBrswLxWMJAljDW+DN6ysWTTmGfCyRmbE9tp09EyUi87UJxKGJtK1G1satno1aiiyFe8F3wWtIA4hIPNcpp3cukdnmU4dfIVlAV+gARHZr69UzOjAAB99DGh80CTzzOHLXCZl4wwAq9ropI3xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxmBmR1I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1FBC116B1;
	Wed, 15 May 2024 06:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715752808;
	bh=AQ3tkiONemRilHkmlqquV+TjmIQLfUDgsuuM0Tf2bCk=;
	h=From:To:Cc:Subject:Date:From;
	b=fxmBmR1IJ80bdF0JfJhMKEigeOYplQSs1LMYxRQ3XHy/7ttki/1fYBwhrEkADErP7
	 x/lriRh0i41gL1HjzK/KL+MuCqF4l/+Yz0GdRlJ6UPTI7JRAY1qLOR06WXYgnnUwMq
	 hw9pcEJMYKgZUHx58Z5PeqY4cBEwOtFYiA6NtAs8WsTfa9Fgsw9WkEU1Ab6CCm5OkA
	 wK7Tz8wmXlIEypkePJpiaaGCyy+weRmRzukKUoo9yOVLFFi2oEz7WI3sYx4h1uLpSF
	 eQBMJiA8H84DG20Y9F0yqnhhZGu50lz4aClVGeZn93orjlXEUHyHd2Z0VLAGOFKTMB
	 AWqlNFGsFYBjg==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 0/9] add netns helpers
Date: Wed, 15 May 2024 13:59:27 +0800
Message-ID: <cover.1715751995.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset addresses Alexei's comment for commit "Handle SIGINT
when creating netns" [1]. Export local helpers create_netns() and
cleanup_netns() defined in mptcp.c into network_helpers.c as generic
ones. For this another helper unshare_netns() is added to replace
the existing local helpers create_netns().

[1]
https://patchwork.kernel.org/project/mptcp/patch/20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org/

Geliang Tang (9):
  selftests/bpf: Add unshare_netns helper
  selftests/bpf: Use unshare_netns helper
  selftests/bpf: Drop duplicate create_netns
  selftests/bpf: Export create_netns helper
  selftests/bpf: Use create_netns helper
  selftests/bpf: Export cleanup_netns helper
  selftests/bpf: Use cleanup_netns helper
  selftests/bpf: Use netns helpers in lwt tests
  selftests/bpf: Use netns helpers in test_tunnel

 tools/testing/selftests/bpf/network_helpers.c | 67 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +
 .../selftests/bpf/prog_tests/assign_reuse.c   | 12 +---
 .../selftests/bpf/prog_tests/bind_perm.c      | 11 +--
 .../bpf/prog_tests/bpf_iter_setsockopt.c      | 13 +---
 .../bpf/prog_tests/btf_skc_cls_ingress.c      |  6 +-
 .../selftests/bpf/prog_tests/crypto_sanity.c  |  3 +-
 .../selftests/bpf/prog_tests/decap_sanity.c   |  6 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     |  8 +--
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 26 ++-----
 .../selftests/bpf/prog_tests/lwt_redirect.c   |  2 -
 .../selftests/bpf/prog_tests/lwt_reroute.c    |  2 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +-----
 .../bpf/prog_tests/ns_current_pid_tgid.c      |  9 +--
 .../selftests/bpf/prog_tests/setget_sockopt.c | 10 +--
 .../selftests/bpf/prog_tests/sk_assign.c      |  4 +-
 .../selftests/bpf/prog_tests/sock_destroy.c   |  9 +--
 .../selftests/bpf/prog_tests/sock_fields.c    | 13 +---
 .../bpf/prog_tests/sock_iter_batch.c          |  7 +-
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  5 +-
 .../bpf/prog_tests/tcp_hdr_options.c          | 13 +---
 .../selftests/bpf/prog_tests/test_tunnel.c    | 19 +++---
 .../bpf/prog_tests/xdp_dev_bound_only.c       |  3 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |  4 +-
 24 files changed, 114 insertions(+), 163 deletions(-)

-- 
2.43.0


