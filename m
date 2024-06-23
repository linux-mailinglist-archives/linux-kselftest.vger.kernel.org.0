Return-Path: <linux-kselftest+bounces-12502-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A757913724
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 03:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AD131C20E1D
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Jun 2024 01:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9CB4653;
	Sun, 23 Jun 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ2ALq0I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E34263B;
	Sun, 23 Jun 2024 01:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719105638; cv=none; b=h4KzOs9tF5kCwmnDsawcSOQI0UMylaIIJcjODdUqsMWEUbyjiIF/VyGlH5aG+99Ymrpxc9M97bJl/5dMM/Yqc0fl56n16Vh1lgVDbwpuwQnX/jiKh0FJl9u9MsACtUjlg232lYE1/OcA96ilrgL2zgO72uKbUhpYN8a8viZwIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719105638; c=relaxed/simple;
	bh=bE0Qba7Qylsq1p7b9ME9fMuPEnZj03DQE7Fnal4t9v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RR3iKT9/4/hb1QuMop71FzMdf6XJhzVfEJJkpZLLWfEWuNkiCoo8vsGHd8VTkjGxr6x7ZL0cJUQSnqOF2uzyXJWnduRLk5KQk6+KVjHfNBuT/WhRWDKdLWvIVX8yrLU6k2KSFf06WQXqU0Zf4XRvfkYNG5oQYyS3gcHbA/dp964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ2ALq0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A668C3277B;
	Sun, 23 Jun 2024 01:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719105638;
	bh=bE0Qba7Qylsq1p7b9ME9fMuPEnZj03DQE7Fnal4t9v8=;
	h=From:To:Cc:Subject:Date:From;
	b=GZ2ALq0ILbclpqKPE2ADFVcRwZLBpgsYemNSplsvSHv5jfU/vVHYOeVoSwE0zuciB
	 RFlMDumZ9B+g21kuqFo56EihC4XNvgpW2G13hPP5OQm/2mtKSWrCPdgvErHI1omxeG
	 /JyxVg/piHbuNTiO08ly+ruUboWsJvs4d8jP9UDcIqzQRixfv0ky2eSrSbTbyALT6m
	 TnwEltU5Zrqs7OQDj/0ZGLYIxVR5TeX/54VVUBIZaneH79FuHb/YsnGYpzw6jErqb4
	 4dXp5QypoyD4l/7g/kJS61btTm3H4/4UaoysmLVZkaJh1zuU12mqxjMfm3lBoZGKEE
	 +ZmsIpoJ65JPQ==
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
Subject: [PATCH bpf-next v3 0/8] use network helpers, part 8
Date: Sun, 23 Jun 2024 09:19:54 +0800
Message-ID: <cover.1719105178.git.tanggeliang@kylinos.cn>
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
 - a new patch to add backlog for network_helper_opts.
 - use start_server_str in sockmap_ktls now, not start_server.

v2:
 - address Eduard's comments in v1. (thanks)
 - fix errors reported by CI.

This patch set uses network helpers in sockmap_ktls and sk_lookup, and drop
three local helpers tcp_server(), inetaddr_len() and make_socket() in them.

Geliang Tang (8):
  selftests/bpf: Add backlog for network_helper_opts
  selftests/bpf: Use start_server_str in sockmap_ktls
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop inetaddr_len in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 138 ++++++------------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  35 +----
 4 files changed, 57 insertions(+), 119 deletions(-)

-- 
2.43.0


