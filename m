Return-Path: <linux-kselftest+bounces-14102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBF93A921
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 00:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07B69B20A8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 22:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C6148FFC;
	Tue, 23 Jul 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FC2a+PAT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842571DDD6;
	Tue, 23 Jul 2024 22:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721773357; cv=none; b=pgLVzrG5mqVX+nZTi34gNI0y/HiaZ1jeTeU5Euy74fUTY7hUfSechmCA8WJGxVe+uvfZ5s1C0CaetNvb8AGlXnLJpkorT0gDzOmxEAm1WGYGNJWtusEVcou/1wWJ5j631TzYdL0GKhVv2WL73HV6NBSLou71tOYrbkvlq9gyw5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721773357; c=relaxed/simple;
	bh=8AG77D3n5CWMHDJDUO6ZhHQW2VE53h/6GVDcfmp2lsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i0IHgvk5UWH1ZqMCVj01X927p5cNYyWFk/Gh5UbQ9SyDjz+B90/HpC/UKybqPi1QEfY8jSxpgcZVdKOOPHwgPHFflTctG0UM+Un+dzCbUytzvj7AeUkXuAAJQzxJbtrNIG5umMVjSKZrvYEB+eFV1rf+bQqBZ01FG1sKhagl9Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FC2a+PAT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E207C4AF0E;
	Tue, 23 Jul 2024 22:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721773357;
	bh=8AG77D3n5CWMHDJDUO6ZhHQW2VE53h/6GVDcfmp2lsQ=;
	h=From:To:Cc:Subject:Date:From;
	b=FC2a+PATbVQhl5s2Luq8r3DxtCovLBfSwBGhb2JiSmhIzn+3zJoYxIiHABurwt9P/
	 InmIrhXmh1Q8uBIsVHe3SsYkuXVwXpExLbkaAuGmBa2oQ81ux63zWI/zchA/s1l699
	 LYP/9p2310GeXnGAxlDf3omAgPVgGvru5AyG/u02fwaIg4cu+p6Kz3fN9PVVp8c5QQ
	 jFzje2uYsvjkVlACadGtaZ3BpNAPmUSo1disNtUk3MExIaEo9ItrA54V1BCHUmz0Pc
	 xN24b1ogVBFdvj7Di4vsUDIV/nif77Ua80dmYhdwZynXzbEjKqlFveTztzpvAca1tj
	 8WfWlnMqBoDGA==
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
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 00/15] use network helpers, part 11
Date: Wed, 24 Jul 2024 06:22:06 +0800
Message-ID: <cover.1721771340.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This set is part 11 of series "use network helpers" all BPF selftests
wide.

Finally something new in this set.

The helper make_sockaddr is extended to support sockets of AF_PACKET,
AF_ALG and AF_VSOCK families. Then these types of sockets can be used
to start_server_str() helper too.

Imitating connect_to_* interfaces, send_to_* interfaces are added to
support sendto() with given FD or the address string.

Add more conditions to control listen: nolisten flag, listen_support()
helper and clear "type" bits for listen.

Patch 1 for AF_UNIX socket:
    Patch 1 uses start_server_str for a AF_UNIX socket.

Patches 2-6 for AF_PACKET sockets:
    Patch 2 adds AF_PACKET support for make_sockaddr.
    Patch 3 uses start_server_str for a AF_PACKET socket.
    Patches 4-5 adds send_to_fd_opts/send_to_addr_str helpers.
    Patch 6 uses send_to_addr_str for a AF_PACKET socket.

Patches 7-9 for AF_ALG sockets:
    Patch 7 adds AF_ALG support for make_sockaddr.
    Patch 8 add nolisten flag, needed by patch 9.
    Patch 9 uses send_to_addr_str for a AF_ALG socket.

Patches 10-15 for AF_VSOCK sockets:
    Patch 10 adds AF_VSOCK support for make_sockaddr.
    Patches 11-12 uses make_sockaddr for AF_VSOCK sockets.
    Patches 13-14 adds more conditions to control listen.
    Patch 15 uses start_server_str for AF_VSOCK sockets.

Geliang Tang (15):
  selftests/bpf: Use start_server_str in skc_to_unix_sock
  selftests/bpf: AF_PACKET support for make_sockaddr
  selftests/bpf: Use start_server_str in lwt_redirect
  selftests/bpf: Add send_to_fd_opts helper
  selftests/bpf: Add send_to_addr_str helper
  selftests/bpf: Use send_to_addr_str in xdp_bonding
  selftests/bpf: AF_ALG support for make_sockaddr
  selftests/bpf: Add nolisten for network_helper_opts
  selftests/bpf: Use start_server_str in crypto_sanity
  selftests/bpf: AF_VSOCK support for make_sockaddr
  selftests/bpf: Add loopback_addr_str helper
  selftests/bpf: Use make_sockaddr in sockmap_helpers
  selftests/bpf: Check listen support for start_server_addr
  selftests/bpf: Clear type bits for start_server_addr
  selftests/bpf: Use start_server_str in sockmap_helpers

 tools/testing/selftests/bpf/network_helpers.c | 144 +++++++++++++++---
 tools/testing/selftests/bpf/network_helpers.h |  21 +++
 .../selftests/bpf/prog_tests/crypto_sanity.c  |  12 +-
 .../selftests/bpf/prog_tests/lwt_redirect.c   |  21 +--
 .../bpf/prog_tests/migrate_reuseport.c        |   2 +-
 .../bpf/prog_tests/skc_to_unix_sock.c         |  22 +--
 .../bpf/prog_tests/sockmap_helpers.h          | 101 +++---------
 .../selftests/bpf/prog_tests/xdp_bonding.c    |  20 +--
 8 files changed, 186 insertions(+), 157 deletions(-)

-- 
2.43.0


