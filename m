Return-Path: <linux-kselftest+bounces-8684-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026EF8AE253
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D16AB21C1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B1565194;
	Tue, 23 Apr 2024 10:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO+sEYic"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C738366;
	Tue, 23 Apr 2024 10:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868542; cv=none; b=AXIpuN1BO/xJRvXJ4Hd6PW2LihPf/xXcZK4rxOZ3bLegNzTkLfY4iEi1eXI0x2GBjdn6sdj0XgWAgtXvxgiOtj2cdrp48KFCRH/GM36bPFomajD6FsF2msvbrTLhuNcpBnDzn3zx8SGWV5HYycucfvaF/z6AQ2wX8q/Tf1ah45g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868542; c=relaxed/simple;
	bh=927GFhMfXfYMLNk8yOCLs07K8ZIVRkvX1yZMSNtPvws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fQQjDlRd3XHKoO4Ml09BqapDL2PhbWhgfC9VY0+S7HFLgPTOdfvAV40ADPQn5tuzIy4KdNwD5oYghKJrjr59991q6HbmU/BeT0rRtxOmgDuATNavF49C2DPjjcTTVmlO0mOl07YmMnGqdPlL6I9FRlgpKoKOVMqwmb3DexLKdDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO+sEYic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBB2C116B1;
	Tue, 23 Apr 2024 10:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868541;
	bh=927GFhMfXfYMLNk8yOCLs07K8ZIVRkvX1yZMSNtPvws=;
	h=From:To:Cc:Subject:Date:From;
	b=PO+sEYicL5QEcnvszlRUvtw3GUAVmOYpKsmwOI/isSBENCuZJKZwil696KwTVz4th
	 Xye1UItw99OduKqTHpfYn/pT4SpiwXZIGtDHGDX02VR/Me4YXm2Ws3AKCrdzr+R06B
	 x7ytVSnRAvSI6/Z7qSOKibFCc90U6OAHPQf9K2id3pAZbYcj5bIEOgbIbNMfvRWrRp
	 3KN24mks9An7duCumXiPL6b7kj6Lo2SF/Rlf/VvmJ9GiTfM9gO+TrxGTGOV+dN6otb
	 ISSFOJAfwANsZcj3nhxgdJrGlPafWxy7ENVe2HOk3FxrmF+zyy6swxpwektbsSkfvZ
	 lX2+CDPgJ8ywQ==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v2 0/5] use network helpers, part 2
Date: Tue, 23 Apr 2024 18:35:26 +0800
Message-Id: <cover.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset uses more network helpers in test_sock_addr.c, but
first of all, patch 2 is needed to make network_helpers.c independent
of test_progs.c. Then network_helpers.h can be included into
test_sock_addr.c without compile errors.

Patch 1 and patch 2 address Martin's comments for the previous series
too.

v2:
 - Only a few minor cleanups to patch 5.

Geliang Tang (5):
  selftests/bpf: Fix a fd leak in error paths in open_netns
  selftests/bpf: Use log_err in open_netns/close_netns
  selftests/bpf: Use start_server_addr in test_sock_addr
  selftests/bpf: Use connect_to_addr in test_sock_addr
  selftests/bpf: Use make_sockaddr in test_sock_addr

 tools/testing/selftests/bpf/Makefile          |   3 +-
 tools/testing/selftests/bpf/network_helpers.c |  20 ++-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/empty_skb.c      |   2 +
 .../bpf/prog_tests/ip_check_defrag.c          |   2 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |   2 +-
 .../selftests/bpf/prog_tests/test_tunnel.c    |   4 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  16 ++
 tools/testing/selftests/bpf/test_sock_addr.c  | 138 +++---------------
 9 files changed, 63 insertions(+), 125 deletions(-)

-- 
2.40.1


