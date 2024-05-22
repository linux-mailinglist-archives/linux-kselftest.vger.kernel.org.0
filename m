Return-Path: <linux-kselftest+bounces-10566-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CA18CBDB6
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 11:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588E81C21D39
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 May 2024 09:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D5A80BE5;
	Wed, 22 May 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6kjoQZ0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CAD80628;
	Wed, 22 May 2024 09:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716369843; cv=none; b=DA3zrqfQs1tx6fUtUCMR1U87VdcukEucVgRBCg5inMiI3vUoUWNOtI5wNYGT0Ve0HSp7WpPodubAxsJY3s5MwqfvIkT/JplMuzKoUmbUlOQU45pdOMRL/TPR3XK9ERuqAKJYdcQiNsZl7WF5gHxEb1pHzuqyHlKuwRbVGEPZPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716369843; c=relaxed/simple;
	bh=c10MwFsAWqGi3KrUe0Zw+uaTdPdzjt8shivE6OoYx78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NIljzyqb2G5tc2UGLeOvzVGwzU95VxZrIpKNmX/3KgHWyTd0DqRUWvE2GG94uG6ihQy40Fr7jpurTrxZQgiLaG3JRSHxAd2aCAsuno89tielEv3JAM12RRkbklfxw3QX1+svy9Ak15C5Dz01dVXBBo2n4f+f0we4h1v/ZjU3i/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6kjoQZ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8E4DC2BD11;
	Wed, 22 May 2024 09:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716369842;
	bh=c10MwFsAWqGi3KrUe0Zw+uaTdPdzjt8shivE6OoYx78=;
	h=From:To:Cc:Subject:Date:From;
	b=T6kjoQZ0Ijjpd2NSIvMMzAIUmEEvXeV/2zt03FCObVDXymoAMlap3VxnqakQ9Yi7o
	 vg8+P6L954yVgolbQobo2vIl9S89CwNvjMA2ifkWqE5dWuTAUkTOEynlPY7mitQ7bl
	 4kVIds/NvAH2ZTpI1oyglF4MEqoWk3GJpYkloDOQmB6DyTinziQOxXLRLvMsaCtCxe
	 +0i3PZFnwy8cHIiKd/Xsk40PM4/wrNBWl+zvSuPROV0IRui8DPSVe4yR3wq1A/Bgle
	 Hj5yjm2yDbNCpBgbXohbtIFwX2GUTZzR+8Px2wt45xHtUYAm9W9tJGKNUS2fVW0BZe
	 OzervvAk7DQxQ==
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
Subject: [PATCH bpf-next v3 0/8] use network helpers, part 5
Date: Wed, 22 May 2024 17:23:42 +0800
Message-ID: <cover.1716369375.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset uses post_socket_cb and post_connect_cb callbacks of struct
network_helper_opts to refactor do_test() in bpf_tcp_ca.c to move dctcp
test dedicated code out of do_test() into test_dctcp().

v3:
 - Add 4 new patches, 1-3 are cleanups. 4 adds a new helper.
 - address Martin's comments in v2.

v2:
 - rebased on commit "selftests/bpf: Add test for the use of new args in
 cong_control"

Geliang Tang (8):
  selftests/bpf: Drop struct post_socket_opts
  selftests/bpf: Drop type parameter of start_server_addr
  selftests/bpf: Drop type parameter of connect_to_addr
  selftests/bpf: Add start_server_str helper
  selftests/bpf: Use post_socket_cb in connect_to_fd_opts
  selftests/bpf: Use start_server_str in bpf_tcp_ca
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add post_connect_cb callback

 tools/testing/selftests/bpf/network_helpers.c |  56 ++++---
 tools/testing/selftests/bpf/network_helpers.h |  13 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 138 +++++++++++++-----
 .../selftests/bpf/prog_tests/cls_redirect.c   |   7 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   2 +-
 .../selftests/bpf/prog_tests/sk_assign.c      |  13 +-
 .../selftests/bpf/prog_tests/sock_addr.c      |  23 ++-
 .../bpf/prog_tests/sockopt_inherit.c          |   4 +-
 .../bpf/test_tcp_check_syncookie_user.c       |  10 +-
 9 files changed, 179 insertions(+), 87 deletions(-)

-- 
2.43.0


