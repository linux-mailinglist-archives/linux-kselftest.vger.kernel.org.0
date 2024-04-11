Return-Path: <linux-kselftest+bounces-7646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CB68A0529
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5388F1C20F71
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802205FBB9;
	Thu, 11 Apr 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2jDtHCF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A4C3201;
	Thu, 11 Apr 2024 01:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797413; cv=none; b=M9+utYSLGj8/wVkI9Og7CBo1OKO/ChNx/Z6MX1O+b0+OO2OaHSx/A3hgOU9qTZPbclDMVsnCLa22etwDOTTDZ0AW+bPoTihKY4QJ9P82hFcJPyiTAXct+/xSbUnqLtA5TNBSBPmX4BlDBFSRGRraJruvqZcRGRD8jQcK2IaLDJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797413; c=relaxed/simple;
	bh=q8IrRxuw4+n3BjswybWNxHXs1xvEhWvtFUpvujWJo04=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aYbqHRA2e5AePQDahoxFzk6AaMpFoJzFtyrVLkoOu6uGt5GxhokpZ3r1u5JNdR1dECvopApHHXdYk5ilIYPTvyoZZ/2LRnZloWeWNNAaKhrtT3Bjd+bBUNIXJ/RwzJGAxMqQpbLrx2Uk5TFUdCCYqNOmGQ3yp+CcxXOCQh5i44M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2jDtHCF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0162C433F1;
	Thu, 11 Apr 2024 01:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797412;
	bh=q8IrRxuw4+n3BjswybWNxHXs1xvEhWvtFUpvujWJo04=;
	h=From:To:Cc:Subject:Date:From;
	b=K2jDtHCFtLxlJMXCOGzYHp2+je+Qt3mtFTC75g5B7mna6lXfFZk892Wbj0af87Hfy
	 Yd/aHGozp2EvIjITFgU2gK2UhHM/v1O3VdRZBAnZzUiTL7l1Qg4E55C7istjdTLO0Y
	 KASg9AkgQRJ/wG+UzC4NHhEIPQNm/G+hezpdD2UfJRycQB05UiOvkwLAyP4mmSvr6i
	 SrPWQKRLAFU3mwPumfe7VPGrFbTAzUksiot4mS0fnd/lPONCQxuO+34lInDT4IFPgO
	 10tzOF8K7yv5gfs/hpFshY+t7M8HKL6Wc7NdeGI5F/jVz7kte/KQoVk5Sr/rjVwx6a
	 k7A1EXzgl0vSw==
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
Subject: [PATCH bpf-next v2 00/14] use start_server and connect_to helpers
Date: Thu, 11 Apr 2024 09:03:08 +0800
Message-Id: <cover.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v2:
 - update patch 6 only, fix errors reported by CI.

This patchset uses public helpers start_server_* and connect_to_* defined
in network_helpers.c to drop duplicate code.

Geliang Tang (14):
  selftests/bpf: Add start_server_addr helper
  selftests/bpf: Use start_server_addr in cls_redirect
  selftests/bpf: Use connect_to_addr in cls_redirect
  selftests/bpf: Use start_server_addr in sk_assign
  selftests/bpf: Use connect_to_addr in sk_assign
  selftests/bpf: Use log_err in network_helpers
  selftests/bpf: Use start_server_addr in test_sock_addr
  selftests/bpf: Use connect_to_addr in test_sock_addr
  selftests/bpf: Add function pointer for __start_server
  selftests/bpf: Add start_server_setsockopt helper
  selftests/bpf: Use start_server_setsockopt in sockopt_inherit
  selftests/bpf: Use connect_to_fd in sockopt_inherit
  selftests/bpf: Use start_server_* in test_tcp_check_syncookie
  selftests/bpf: Use connect_to_addr in test_tcp_check_syncookie

 tools/testing/selftests/bpf/Makefile          |  4 +-
 tools/testing/selftests/bpf/network_helpers.c | 50 ++++++++----
 tools/testing/selftests/bpf/network_helpers.h |  4 +
 .../selftests/bpf/prog_tests/cls_redirect.c   | 38 +---------
 .../selftests/bpf/prog_tests/sk_assign.c      | 53 +------------
 .../bpf/prog_tests/sockopt_inherit.c          | 64 ++++------------
 tools/testing/selftests/bpf/test_sock_addr.c  | 74 ++----------------
 .../bpf/test_tcp_check_syncookie_user.c       | 76 +++----------------
 8 files changed, 83 insertions(+), 280 deletions(-)

-- 
2.40.1


