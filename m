Return-Path: <linux-kselftest+bounces-12035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B738190A87A
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 10:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D74F283762
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2024 08:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21E319005C;
	Mon, 17 Jun 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bW+xYLl9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A887117F5;
	Mon, 17 Jun 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718613205; cv=none; b=Yj7btoNfqP86j4ePSHAsH4lLZIlNlb7mKgW7rJmpYACTOmTVYxJ/3RVWcpCcTSnRUeLvac+3b/d6Q3biunzHP/um96wBHuqkbSSJPhijbGZRP5iiPPwsJNRoj9O1DYkHxAP4aR4ibNoxFhMvXZCKyFp9/4jH6M/UdvDIbv81SRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718613205; c=relaxed/simple;
	bh=d9Y20zrsKDNBzIeEdP+4dgQOL7qooRHluxM/6mbbWhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UN7aVCVahBFui35UblMQWZsr0w42/cY6CExCpjwxGE30xOXdhUJr9LZpQ66280hESjY4TC434hZglWp+yyqgOE7T+W+CPKWPVL2IYJDJiKTAK3m37xAOIIZLxxZ96Bz/0sIPVASeH8sflInzSKrgbQp+BJztE2zKC9IAeTGMA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bW+xYLl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5AFC3277B;
	Mon, 17 Jun 2024 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718613205;
	bh=d9Y20zrsKDNBzIeEdP+4dgQOL7qooRHluxM/6mbbWhw=;
	h=From:To:Cc:Subject:Date:From;
	b=bW+xYLl9O78anxMvaEw9sMDhDDeD4xRr31+A1adsJ+2yVMcbGIVf26tGh1DJbNgUn
	 1N4PobEJb5JqsHRbhc8ZHed2buoONmoUC1khVUafB1jhRYmfkkfyoVfln87EGVS/TK
	 9CbHZDUDhWbKBwodjuQzgXSlSagysGn1991H5e/espwkWSkEXAemX2f1aDpdiUoNbA
	 NL87mbCMaa39kgY0R/ifNFHn9Bcb0KwyB2mOLE9mgC2Wwg+ipPLD8LGvttaM7vtaUs
	 Y5aC3bAs7JH/i41f1dbFZHHb+sG1LIggzMBXOZcQTgcviHMd281ypvyiLFlt444+aI
	 OA3+xY/MNn/3g==
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
Subject: [PATCH mptcp-next v3 0/6] use network helpers, part 7
Date: Mon, 17 Jun 2024 16:33:05 +0800
Message-ID: <cover.1718612857.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v3:
 - rename start_client to client_socket
 - Use connect_to_addr in connect_to_fd_opt

v2:
 - update patch 2, extract a new helper start_client.
 - drop patch 3, keep must_fail in network_helper_opts.

Drop type and noconnect from network_helper_opts. And use start_server_str
in mptcp and test_tcp_check_syncookie_user.

Patches 1-4 address Martin's comments in the previous series.

Geliang Tang (6):
  selftests/bpf: Drop type from network_helper_opts
  selftests/bpf: Use connect_to_addr in connect_to_fd_opt
  selftests/bpf: Add client_socket helper
  selftests/bpf: Drop noconnect from network_helper_opts
  selftests/bpf: Use start_server_str in mptcp
  selftests/bpf: Use start_server_str in test_tcp_check_syncookie_user

 tools/testing/selftests/bpf/network_helpers.c | 100 ++++++++----------
 tools/testing/selftests/bpf/network_helpers.h |   6 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |   2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    |   4 +-
 .../bpf/prog_tests/ip_check_defrag.c          |  10 +-
 .../testing/selftests/bpf/prog_tests/mptcp.c  |   7 +-
 .../bpf/test_tcp_check_syncookie_user.c       |  29 +----
 7 files changed, 56 insertions(+), 102 deletions(-)

-- 
2.43.0


