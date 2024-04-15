Return-Path: <linux-kselftest+bounces-7931-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC918A4808
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 08:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEB831F21D82
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Apr 2024 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2BE6139;
	Mon, 15 Apr 2024 06:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHt4cGFW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62791CF8F;
	Mon, 15 Apr 2024 06:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162690; cv=none; b=dBWA4Jt2g9wBomel2IU35YC63nAGzVqVUHZiFMM6BmKMqLI9tiQ4jW1irbbwvmgyVkXfDwX0I7SejiA8x7My4LCU3lPGZCT9mfMJM8GDrMU3GaEZvIKFIqDTbo/UDPFOJCPNAEfoxCqNoywn4Gw1Yk+rY/MhKJu/M1i5BD/LTKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162690; c=relaxed/simple;
	bh=Qr82hf54e0+PTBcjPAl45tp2231lYnciiHQ5zWyG87A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K06oCx29u+Wxe8uBoPeiVUthTGl3xWt9YfvY0mofDrFpsJF2C8RhZX6FXIcVe9QQKVD87Yg6BHMl0IknxxWiLvdj8tAL+iWYYhizUUMh4QBwYPHoVqugQEzEwpBsmm+arfJ56LzZfsDkZyuQQYsa44z0XJYtUFB8fIsHpD58/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHt4cGFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94426C113CC;
	Mon, 15 Apr 2024 06:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713162689;
	bh=Qr82hf54e0+PTBcjPAl45tp2231lYnciiHQ5zWyG87A=;
	h=From:To:Cc:Subject:Date:From;
	b=gHt4cGFWPqYVW/X569d+x1B6Ay85nZilAAH/J7bLxkX0DNTmFdEl7g3pSlBFBmMwQ
	 fAInwOpI74Y/2utiOZtlOV+wiZEvUkrqixRE/pwEIvdonv64wYZCyoVitdSqwSV8bO
	 zghsxXMJAz+MJeXsLc53neSybZ2ifxOKo+sUt5nH6zj1J+EOuEAofZYzVyq5w0jAgn
	 JDTljEEiHSenicxR+7GV2lJt0P7VPu3WgIbtVsbhz+DO/4mLOlMYQ95ptI4hq7dC7a
	 yB3IUrL4R0s6pIqCS3GvZeqcZY+txaHlumJBBbxYYTZArA7cyHLAYf5bI9iY+7Jqo6
	 RpHru7myywBVg==
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
Subject: [PATCH bpf-next v3 0/9] use start_server_addr/connect_to_addr helpers
Date: Mon, 15 Apr 2024 14:31:09 +0800
Message-Id: <cover.1713161974.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

Geliang Tang (9):
  selftests/bpf: Update arguments of connect_to_addr
  selftests/bpf: Add start_server_addr* helpers
  selftests/bpf: Use start_server_addr in cls_redirect
  selftests/bpf: Use connect_to_addr in cls_redirect
  selftests/bpf: Use start_server_addr in sk_assign
  selftests/bpf: Use connect_to_addr in sk_assign
  selftests/bpf: Use log_err in network_helpers
  selftests/bpf: Use start_server_addr in test_sock_addr
  selftests/bpf: Use connect_to_addr in test_sock_addr

 tools/testing/selftests/bpf/Makefile          |  3 +-
 tools/testing/selftests/bpf/network_helpers.c | 37 ++++++++--
 tools/testing/selftests/bpf/network_helpers.h |  6 +-
 .../selftests/bpf/prog_tests/cls_redirect.c   | 38 +---------
 .../selftests/bpf/prog_tests/empty_skb.c      |  2 +
 .../bpf/prog_tests/ip_check_defrag.c          |  2 +
 .../selftests/bpf/prog_tests/sk_assign.c      | 59 ++-------------
 .../selftests/bpf/prog_tests/sock_addr.c      |  6 +-
 .../selftests/bpf/prog_tests/tc_redirect.c    |  2 +-
 .../selftests/bpf/prog_tests/test_tunnel.c    |  4 +
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 16 ++++
 tools/testing/selftests/bpf/test_sock_addr.c  | 74 ++-----------------
 12 files changed, 81 insertions(+), 168 deletions(-)

-- 
2.40.1


