Return-Path: <linux-kselftest+bounces-13348-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2881B92B36E
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54D11F2322C
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C866153BC3;
	Tue,  9 Jul 2024 09:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndda7rHC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B131DA2F;
	Tue,  9 Jul 2024 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516601; cv=none; b=lDTYELmuRbL4LYAaP1gHtbWCD/w3GaIge+zCvgr60MO72Q39hGG6/vkSjXNnqsh3P1WTqRzlFQYwmhbJw00dkrO3arMmZkI7kgqzZ+fpcIw5SRsyEEdU+YtKA0XPLDLl9XOhxH4YZyDKcINedqQ0H36fN+Ta2sySZWHa7MkINAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516601; c=relaxed/simple;
	bh=SnX1roRgKsQVsjvhPePXM2S7Q9eBsNAc2vArlwMWct4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZUeg8k95/7oBxMVsBLHLGswcUgOmFCkaAtJXKtELY4jTw7Lv4AfP9+UFyirqXE4H0RJQh3BX4OXbEXZr4mvoZj9QkyHGyl5KWJ8h0aR4x1ibi/CpIVS2mEnfflw0dDk+llsLQ98OvSJgYe3F1DZB4R1W6NHbDOt8wf/7ZcVcVF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndda7rHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB68EC3277B;
	Tue,  9 Jul 2024 09:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516600;
	bh=SnX1roRgKsQVsjvhPePXM2S7Q9eBsNAc2vArlwMWct4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ndda7rHCEb9n/FfDaAW2dbWApSZkO5ChX1M09prtN3O29PmcApVtPaYxMnc/dfr3Z
	 xM/8MH9pxJu9npbwlcoVo03W9JQxNVZhvNNQzzSheggWTqcWiDqt6JoXyrbx9hameA
	 V/Zj/cVieNP/Txjgf3HjHP64A6UHXgmmHNrNQGiICnsprZHCMhsOLllO30qEtO3pGm
	 nqtLRxOJUNaLCOnmxj563Gv/UdUX7DhcA2cPqqVyfHEQeF6CvL+FTV1mckUuiHsy2a
	 KhQgiRKQ4RsgIfqTRHqmPErWbgofMJaLcy2Djrv1ZA9PXXWJRTUBqrXraE1bJ3wz3x
	 xNr9+VYW8IQqA==
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
Subject: [PATCH bpf-next v11 0/9] use network helpers, part 8
Date: Tue,  9 Jul 2024 17:16:16 +0800
Message-ID: <cover.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

v11:
 - new patches 2, 4, 6.
 - drop expect_errno from network_helper_opts as Eduard and Martin
   suggested.
 - drop sockmap_ktls patches from this set.
 - add a new helper connect_fd_to_addr_str.

v10:
 - a new patch 10 is added.
 - patches 1-6, 8-9 unchanged, only commit logs updated.
 - "err = -errno" is used in patches 7, 11, 12 to get the real error
   number before checking value of "err".

v9:
 - new patches 5-7, new struct member expect_errno for network_helper_opts.
 - patches 1-4, 8-9 unchanged.
 - update patches 10-11 to make sure all tests pass.

v8:
 - only patch 8 updated, to fix errors reported by CI.

v7:
 - address Martin's comments in v6. (thanks)
 - use MAX(opts->backlog, 0) instead of opts->backlog.
 - use connect_to_fd_opts instead connect_to_fd.
 - more ASSERT_* to check errors.

v6:
 - update patch 6 as Daniel suggested. (thanks)

v5:
 - keep make_server and make_client as Eduard suggested.

v4:
 - a new patch to use make_sockaddr in sockmap_ktls.
 - a new patch to close fd in error path in drop_on_reuseport.
 - drop make_server() in patch 7.
 - drop make_client() too in patch 9.

v3:
 - a new patch to add backlog for network_helper_opts.
 - use start_server_str in sockmap_ktls now, not start_server.

v2:
 - address Eduard's comments in v1. (thanks)
 - fix errors reported by CI.

This patch set uses network helpers in sk_lookup, and drop the local
helpers inetaddr_len() and make_socket().

Geliang Tang (9):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Add ASSERT_OK_FD macro
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use start_server_addr in sk_lookup
  selftests/bpf: Use connect_fd_to_fd in sk_lookup
  selftests/bpf: Add connect_fd_to_addr_str helper
  selftests/bpf: Use connect_fd_to_addr_str in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |  23 ++-
 tools/testing/selftests/bpf/network_helpers.h |   7 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 156 ++++++------------
 tools/testing/selftests/bpf/test_progs.h      |   8 +
 4 files changed, 92 insertions(+), 102 deletions(-)

-- 
2.43.0


