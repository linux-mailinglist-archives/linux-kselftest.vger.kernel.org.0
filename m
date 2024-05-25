Return-Path: <linux-kselftest+bounces-10690-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C88828CEECD
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 14:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2477D1F21561
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 May 2024 12:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 147F13D967;
	Sat, 25 May 2024 12:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX2MVUlL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF818044;
	Sat, 25 May 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716638912; cv=none; b=Ti6bsEwolDezVUj9VZvCXkykDa2a9hJ+/n8vs52it8PUX+fwLhMIWjX1xp79lofpPpk/e+mgiDNCshhHTPUjfw9ZLRNVrbxA2RhSlM+I0WIja6qbJMabeweD70vzDh01qnnIsfv2k/gGa3fCryV9NwgWVPHzKqUOnQM6UmGR5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716638912; c=relaxed/simple;
	bh=Z6DeYB71VeeBAuOoaimCiM1lovTmgmabsCkf/mJ2Vos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hxw7pB7Yov4WXGQIR4GDkrtwizF9L8BXB/AqjGULC78MtwVjKVttvYTAJshRtHdpu/u98iAncUn3Gdi6FHrqlv4lJ3OxiuzQ1V2/ZxMPV8Kbh8KUw/frqlp8Jx7F3CYzraGRkebO0kqRXVGZEYXPvmJBoGpJvVKjUN9i5XBVuPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX2MVUlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EEC2BD11;
	Sat, 25 May 2024 12:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716638911;
	bh=Z6DeYB71VeeBAuOoaimCiM1lovTmgmabsCkf/mJ2Vos=;
	h=From:To:Cc:Subject:Date:From;
	b=rX2MVUlLgUd4gvH27ucvtNqJKLQ125f48hMcOUItiRrU0o9MplvsoyWVNk42y/kGB
	 lLVQzvcQpHqJ3U0QpAqY8D2DlGGBtfQEfXYoHIuCUj+KdhifiaEQOJ06oYosq7Ma3r
	 uTW4kAT7qBs6ayLcgqYU0N5o7sr3SSJlfyDtIXQhRpNMLucMAQ44U8xhPergLxAfxn
	 1PsOA434/xk88x3Sg1/g4F1w5zihC/Ks+IhB4pnfrkV9T/E6dabi17yMR0sWKKYcXM
	 1P/gNrt54ruJddI5znHam2uaOH9ttMGJqpGge0L3epC5aL2th4Lbp029OMP1Kqu6Dc
	 gBuvHHE1fwOIQ==
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
Subject: [PATCH bpf-next v5 0/7] use network helpers, part 5
Date: Sat, 25 May 2024 20:08:14 +0800
Message-ID: <cover.1716638248.git.tanggeliang@kylinos.cn>
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

v5:
 - address Martin's comments in v4 (thanks)
 - add patch 4, use start_server_str in test_dctcp_fallback too
 - ASSERT_* is already used in settcpca, use this helper in cc_cb (patch 3)
 and stg_post_socket_cb (patch 6)
 - add ASSERT_* in stg_post_socket_cb in patch 6

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

Geliang Tang (7):
  selftests/bpf: Drop struct post_socket_opts
  selftests/bpf: Add start_server_str helper
  selftests/bpf: Use post_socket_cb in connect_to_fd_opts
  selftests/bpf: Use post_socket_cb in start_server_str
  selftests/bpf: Use start_server_str in do_test in bpf_tcp_ca
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add post_connect_cb callback

 tools/testing/selftests/bpf/network_helpers.c |  39 +++--
 tools/testing/selftests/bpf/network_helpers.h |   9 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 153 +++++++++++++-----
 .../bpf/prog_tests/sockopt_inherit.c          |   2 +-
 .../bpf/test_tcp_check_syncookie_user.c       |   4 +-
 5 files changed, 145 insertions(+), 62 deletions(-)

-- 
2.43.0


