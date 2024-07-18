Return-Path: <linux-kselftest+bounces-13866-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 750319347FD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 08:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 360E8282B14
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 06:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BE357C9F;
	Thu, 18 Jul 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaevmqAU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9126ACF;
	Thu, 18 Jul 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721283790; cv=none; b=Ioneme2E6JVtnBU3+TriONxr45I/EamkQmOed2onYQUa5Rr2tldf3FRdwOoc8S9QTqFeYluzzm0HcH7wzAnNUMWY3jeZsyQ/tIACFbs+s5yLQI44NIowz6RVNu5e0WMbtD0tTDP48NEVxbNZTGJ2VOHjW7SUNykYkKsziaUDyVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721283790; c=relaxed/simple;
	bh=oVvBLP4FuzZ4fge8dJsc1RYkwheJwzxL2oB+9HtHhbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mwcKed2r+uOT88iwieHsQ++PP9ES3HQxkVjJbNZrMEb46QUhmEkHxfcDhoNqXxCSqLpygRgKrP31n1CgW1/FYECGn/jdqZ9OI7RYZ/iWU2FLSs0zBH0p5vmMWIn3+hoXE7pa5SsOwy0ZkKT9jYFf4x4dfrLKO81LMoZg3fhFQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaevmqAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98FF7C116B1;
	Thu, 18 Jul 2024 06:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721283790;
	bh=oVvBLP4FuzZ4fge8dJsc1RYkwheJwzxL2oB+9HtHhbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=HaevmqAUpsdukYOsKJOTHBfxuQjEsjks4WUepDM7ws00V7YIFW1C8s5PcCsCyn7WX
	 ayHFpQB4FLjoc+1tYk9jEKnIxX7sxEPJFa+AGiJ0zsi7IxAWOTi2PsE2eihFuROppp
	 6xZK2UIeHB+JVQlE4I3YO5bnmn2bQNS/Z8OXufm/GK/HvV7RZWUQT6yoAVAimSF9fY
	 mKjmwdZ8whQwLnjGSUucS1ggvuNqs3oA1JaiN91Na1Zg4x9tZQkbTbOBdTUrMRlGTj
	 n71zPlbNm/FVXgLa6XDDh98NesShEvEXGR9kg0IrtSTOjpnW5MZ0dUHQSTwq2GQTN9
	 cbplGqYM3Cjkg==
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
Subject: [PATCH bpf-next v3 0/5] use network helpers, part 9
Date: Thu, 18 Jul 2024 14:22:28 +0800
Message-ID: <cover.1721282219.git.tanggeliang@kylinos.cn>
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
 - patch 2:
   - clear errno before connect_to_fd_opts.
   - print err logs in run_test.
   - set err to -1 when fd >= 0.
 - patch 3:
   - drop "int err".

v2:
 - update patch 2 as Martin suggested.

This is the 9th part of series "use network helpers" all BPF selftests
wide.

Patches 1-2 update network helpers interfaces suggested by Martin.
Patch 3 adds a new helper connect_to_addr_str() as Martin suggested
instead of adding connect_fd_to_addr_str().
Patch 4 uses this newly added helper in make_client().
Patch 5 uses make_client() in sk_lookup and drop make_socket().

Geliang Tang (5):
  selftests/bpf: Drop type of connect_to_fd_opts
  selftests/bpf: Drop must_fail from network_helper_opts
  selftests/bpf: Add connect_to_addr_str helper
  selftests/bpf: Use connect_to_addr_str in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c | 65 ++++++--------
 tools/testing/selftests/bpf/network_helpers.h |  5 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    | 16 ++--
 .../selftests/bpf/prog_tests/sk_lookup.c      | 84 ++++---------------
 5 files changed, 56 insertions(+), 116 deletions(-)

-- 
2.43.0


