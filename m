Return-Path: <linux-kselftest+bounces-8108-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 601778A67F0
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 12:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12CD41F21564
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 10:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C086AFA;
	Tue, 16 Apr 2024 10:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozBVtJC+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCF586AC9;
	Tue, 16 Apr 2024 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713262455; cv=none; b=Hhmr9+sFz2Nt+wbK3ol0EJVm5+/iUmnxREoPWX61266BlWGothV00UHYPCNh+tuGXhV4w7SzScGYjwg5J6l+utatufy8EeUM8QkC1uF/7z1fImLq/zgZjNYFmQxsRNke/jaWj5NuEKHmpsWnRzlRIeKE5dRehFnNbhtTQbYAZ0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713262455; c=relaxed/simple;
	bh=xjZZxI4NzTuC73f3EWUqCsevey+u/dAuVwsZOD2W3xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qMB/3sNUuDhgrfakNDHRUhuzK+DMdCFxEiDSyKsU7oclZUt7afqlHgkQB+Sc6b7finozzGWuzguLVLUx/9BZHihkEeC7h29bNRPykateTO7RrK04yGDvWMBt5F+cilZ3WzUkX3sfA8nvqzh6kv+2dmiu2p/n2qWA9GVGY1SaheA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozBVtJC+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D331C113CE;
	Tue, 16 Apr 2024 10:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713262454;
	bh=xjZZxI4NzTuC73f3EWUqCsevey+u/dAuVwsZOD2W3xE=;
	h=From:To:Cc:Subject:Date:From;
	b=ozBVtJC+24qXFbMBo/iWhBX4HwVlnvKoICe/EVJdwtI2Tg2oGt651u/ysjWCuDyKL
	 /hdKv5/lUgQa1z2Ifa+gfRrAcvZv40jPmU30foDeNG4kX4ARROuCLPg1t7U0m3SI48
	 wdbEw/T6pcRWBMCVNSr57SCxMnN/dwe0u+rdEiz7GSlpfXEyol50w9VvzhPCsMcMJ4
	 H22PptN3pbthwSM6NzFVdz92+vfm9/l26AKFb0FFn+sYfPXwF3oUa9Nw3GtvDCinuF
	 Y7oPQ4fVfWVU6LtTB158/Hnr4jqbCVSqXteJ+smHDljnzCdjx6RwyY83hZ4hpZy4Vc
	 AUmUW2niH2/9Q==
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
Subject: [PATCH bpf-next v4 00/14] use network helpers, part 1
Date: Tue, 16 Apr 2024 18:13:46 +0800
Message-Id: <cover.1713262052.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v4:
 - add more patches using make_sockaddr and get_socket_local_port
   helpers.

v3:
 - address comments of Martin and Eduard in v2. (thanks)
 - move "int type" to the first argument of start_server_addr and
   connect_to_addr.
 - add start_server_addr_opts.
 - using "sockaddr_storage" instead of "sockaddr".
 - move start_server_setsockopt patches out of this series.

v2:
 - update patch 6 only, fix errors reported by CI.

This patchset uses public helpers start_server_* and connect_to_* defined
in network_helpers.c to drop duplicate code.

Geliang Tang (14):
  selftests/bpf: Update arguments of connect_to_addr
  selftests/bpf: Add start_server_addr* helpers
  selftests/bpf: Use start_server_addr in cls_redirect
  selftests/bpf: Use connect_to_addr in cls_redirect
  selftests/bpf: Use start_server_addr in sk_assign
  selftests/bpf: Use connect_to_addr in sk_assign
  selftests/bpf: Use get_socket_local_port in sk_assign
  selftests/bpf: Use make_sockaddr in sk_assign
  selftests/bpf: Use log_err in network_helpers
  selftests/bpf: Use start_server_addr in test_sock_addr
  selftests/bpf: Use connect_to_addr in test_sock_addr
  selftests/bpf: Use make_sockaddr in test_sock_addr
  selftests/bpf: Use make_sockaddr in test_sock
  selftests/bpf: Use make_sockaddr in ip_check_defrag

 tools/testing/selftests/bpf/Makefile          |   4 +-
 tools/testing/selftests/bpf/network_helpers.c |  37 ++++-
 tools/testing/selftests/bpf/network_helpers.h |   6 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   |  38 +----
 .../selftests/bpf/prog_tests/empty_skb.c      |   2 +
 .../bpf/prog_tests/ip_check_defrag.c          |  20 +--
 .../selftests/bpf/prog_tests/sk_assign.c      |  92 ++----------
 .../selftests/bpf/prog_tests/sock_addr.c      |   6 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |   2 +-
 .../selftests/bpf/prog_tests/test_tunnel.c    |   4 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  16 +++
 tools/testing/selftests/bpf/test_sock.c       |  28 +---
 tools/testing/selftests/bpf/test_sock_addr.c  | 136 +++---------------
 13 files changed, 104 insertions(+), 287 deletions(-)

-- 
2.40.1


