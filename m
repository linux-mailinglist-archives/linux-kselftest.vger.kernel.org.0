Return-Path: <linux-kselftest+bounces-10645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 358C38CDFAF
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 05:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF11281E9F
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 May 2024 03:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05324BE47;
	Fri, 24 May 2024 03:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JHSfCjfR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF7F1DA3D;
	Fri, 24 May 2024 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716520931; cv=none; b=iYYdnyzPk+i122/24q9qQkhNO8fl8iEQ5EMISvTqGCs2iOzsYk8NcGc3f3xKU5D0fmTxmZZ3FCBixtM15nWnCzAJe54Gv3atE6y8LLzsl+XyfR18cF9831ulfRaQ/GYnIXHJz4+KhKxmyiswtG5DNXr5ed/dQesHzy5W+7fm3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716520931; c=relaxed/simple;
	bh=f/pSiFWwfifFDnLEfj8gP9g4c+fzvZS00viiargdTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOr0/W5WQJHbBUI2dLAylOANSRH+uVqvOEA/+0KygJRtEmyJuNlWW/rrfJczEyOj/SXnYA24oI9icBA1tIlYa63evM0WE/RkP5lKQhxnZo2uU3IMCkjbsSVi6pFPEot8qs/LAfI1HN1S56Qh0WX8oPcOlTBjNe34eQ0mBUZt+Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JHSfCjfR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90DAAC2BD10;
	Fri, 24 May 2024 03:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716520931;
	bh=f/pSiFWwfifFDnLEfj8gP9g4c+fzvZS00viiargdTeU=;
	h=From:To:Cc:Subject:Date:From;
	b=JHSfCjfRzeg/ghVFZR6acVm8vulGdYNQCh93acvs3BxVCkzj33Z3ZULCDSgEwImhH
	 hZnpwlxvUl2KR14tQwWPYkTvdd0timq/sdWfJYd8c3FJXAstFpDm1SOITsgmFLyZSj
	 iij94h4vjI1NpyqBwhWhUeZU8A2mKps7UDQf/l8EAp6ECfOJJhRHwakXLugQZnn9Pv
	 i59auSWa9D753VYJueaGcm1HfsMgYCR0iPEQjFaKKDbBDbvZW4QwMwi4x8llwWypgt
	 IS1JoR73GT7jlvEbQgMkDxolXRJDDiewRp6Iy6lTRDenFIyYKNFVY34EZMyALEeaS3
	 UBQYKLkfx615A==
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
Subject: [PATCH bpf-next v4 0/6] use network helpers, part 5
Date: Fri, 24 May 2024 11:21:48 +0800
Message-ID: <cover.1716520609.git.tanggeliang@kylinos.cn>
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

v4:
 - address Martin's comments in v3 (thanks).
 - drop 2 patches, keep "type" as the individual arg to start_server_addr,
   connect_to_addr and start_server_str.

v3:
 - Add 4 new patches, 1-3 are cleanups. 4 adds a new helper.
 - address Martin's comments in v2.

v2:
 - rebased on commit "selftests/bpf: Add test for the use of new args in
 cong_control"

Geliang Tang (6):
  selftests/bpf: Drop struct post_socket_opts
  selftests/bpf: Add start_server_str helper
  selftests/bpf: Use post_socket_cb in connect_to_fd_opts
  selftests/bpf: Use start_server_str in bpf_tcp_ca
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add post_connect_cb callback

 tools/testing/selftests/bpf/network_helpers.c |  39 +++--
 tools/testing/selftests/bpf/network_helpers.h |   9 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 138 +++++++++++++-----
 .../bpf/prog_tests/sockopt_inherit.c          |   2 +-
 .../bpf/test_tcp_check_syncookie_user.c       |   4 +-
 5 files changed, 133 insertions(+), 59 deletions(-)

-- 
2.43.0


