Return-Path: <linux-kselftest+bounces-8551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 404608ABB71
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 13:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39DE01C20C90
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC429CEE;
	Sat, 20 Apr 2024 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoUWU2D7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A1C17584;
	Sat, 20 Apr 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713614192; cv=none; b=Nl8ZimXtsc8HgnF4PTLtgJ0J5JgNKE77ORYnusgq6CXvhLVqC773/3/32IlbIUAchWBPrYVR06wKr+7mqjev6Sb4rzmvQIjr792Yh+Bkc6hr1iwaUh1CjUA0ybsXHUUh4A/n7L4Z7ZeeN0rtPJp+Do6Cf+yHf6mArvx1S277DJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713614192; c=relaxed/simple;
	bh=28lcdXUVIa7vPSL2BD9vRp0vMgbfWfb4CAaxid9NwPI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTgSFcQjfUm0NZtFP8K9Kdq80H/yoAhv+GRzyCcykUQKzB2Ip4J6EfENOHgDH63TnU5aeX/CptukDR7fez+BOREVwA7IgrpIBwQ17nR/lHzsKe3VvOp/JRYKza7xemRjXyRusbxPykiWElqCKIEJcVBjzJH696WForlUuB8qAXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoUWU2D7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B197C072AA;
	Sat, 20 Apr 2024 11:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713614191;
	bh=28lcdXUVIa7vPSL2BD9vRp0vMgbfWfb4CAaxid9NwPI=;
	h=From:To:Cc:Subject:Date:From;
	b=FoUWU2D7lf65P4X+NQfhGv5V/Yb+uvhRePzjBEVpVkT/fnjfvj0YIWiS1Q0OAprAI
	 mvcK0csJXGvHicu+eUBX9QwXhRfxw1/5AtOFJGBMsin4G26nNOfApoYKQ3rgD+FC+3
	 Yeq4J5e8PyDB8oAk5pdKiZGsLoaXO7RGjO+prXpkaXGH2FgaWYAy64CAL99xvSc6dv
	 XX8JmynGL3wzWHM5dzZXtN4Xf6K/GTgC4M9CuA9csEtU1jnAUOu5nj/e/w8Fk7SZOF
	 z406jevuxzCaqIiJf1zv6Mq6K2fAqIFmzih0Fn42iY5melNq02U1QRD3EPemh/Ljj3
	 myO7KptMSTtXg==
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
Subject: [PATCH bpf-next 0/5] use network helpers, part 2
Date: Sat, 20 Apr 2024 19:55:38 +0800
Message-Id: <cover.1713613543.git.tanggeliang@kylinos.cn>
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
 .../selftests/bpf/prog_tests/xdp_metadata.c   |  16 +++
 tools/testing/selftests/bpf/test_sock_addr.c  | 136 +++---------------
 9 files changed, 61 insertions(+), 125 deletions(-)

-- 
2.40.1


