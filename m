Return-Path: <linux-kselftest+bounces-13218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2239280BE
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF561F25013
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC751219ED;
	Fri,  5 Jul 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OE/FHDCJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17681BC4B;
	Fri,  5 Jul 2024 02:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148326; cv=none; b=alP5tqjm6GLkszSJMTNjd6EYkKHBNQB5gRsfBAMza581wv1OdtV3vBamVR7yIcvCHWcN2CnargZjG/9PGx+Wr6gWPiAr5II2s793d3vbjIWOwLu9hbUrAaYTG3lJZGivA8kkl5zuVEeTO8jZAtDctf19BMbkSAn34i9d6LZOzmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148326; c=relaxed/simple;
	bh=89eMq5ZQcrcGurIA8RdxDHuaLm5+nRGhgftIxO8Zca4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tyZz9LjPuT3z/LO5HvLl/VdUTYGYCVnu3WeaJvWY1aeeilM2UcnlSKisU0CeiOPeZU83ruYSDhhJtglOFN2NZeVeYRurDJReb2RD1ILA/Wya91XSldPRnttr+VZbBnQ5N8SSZeLSenpDG0b736MpEQrLgWtsGivv1/KXwp2c8uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OE/FHDCJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44632C3277B;
	Fri,  5 Jul 2024 02:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148326;
	bh=89eMq5ZQcrcGurIA8RdxDHuaLm5+nRGhgftIxO8Zca4=;
	h=From:To:Cc:Subject:Date:From;
	b=OE/FHDCJiYjKyxnZIdNHPDgMUvKlNuErAZLx0Uks9/L9Q1em+u8mfODB6zIr+/IYd
	 AVOEQVecF5aSrxdUmjl1cuMTRuIYppdrLjV+WBCvAJ/ICpeoDI6+WF9KKKXdgUMQmY
	 N0r3sjJJgXRD30/0z85EoLWh2fHNkM5gYwaC7mhWox2heWi5Dj/DotPnf3ySOuzBPS
	 OWaxsfmIHV/5yZtYOIc9mRW4/bEpg/63OVCXgg20xW8JFUy2SW9rYxi2INiPjihPO5
	 07W7wHr+ofpUat87Fzt6jmI0MHJZQNZ/11Cz4luAmE4plez4/6zbmzbrxOoBiZXcYE
	 UTKKCPqQ2MC9A==
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
Subject: [PATCH bpf-next v8 0/9] use network helpers, part 8
Date: Fri,  5 Jul 2024 10:58:22 +0800
Message-ID: <cover.1720147952.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

This patch set uses network helpers in sockmap_ktls and sk_lookup, and
drop three local helpers tcp_server(), inetaddr_len() and make_socket()
in them.

Geliang Tang (9):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd_opts in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd_opts in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 152 +++++++-----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  53 ++----
 4 files changed, 76 insertions(+), 135 deletions(-)

-- 
2.43.0


