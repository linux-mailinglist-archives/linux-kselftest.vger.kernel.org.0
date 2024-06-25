Return-Path: <linux-kselftest+bounces-12608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1B2915E40
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CC5B20DC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17B145B00;
	Tue, 25 Jun 2024 05:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egwTP2/2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D094A2D600;
	Tue, 25 Jun 2024 05:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294169; cv=none; b=riVQ18NHmZug9EumM7aSQ0K4iN1e3hpcx/Ih5TMvSahhlPanLTN9qL4trHE41BMP592cxzC/MBeZ7l7bYuhT1d721a+/YfeD/6in1mP5sClD7F5mGcuTuYmEnEc1LYweNngGWp+EZTot9vL/wMIG/6WEYPtofWeU3o9WeoqsmqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294169; c=relaxed/simple;
	bh=YDx8CffeBjbMEH8uNz+jJ2UtHby5+K0/CVVVU1HI0zs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nEQCioxOd2RHq5x5EFng6dbb/fyE505qsZWr8SfK7L3aNcBJ/qZ4v/EMnGVLmy06rNNSL/LCLnkkvCV3dVonhKK3jMJH5kjoC4j3KrKI+0JHBfucs1AbYIPwgNH8cToacUXD6nfPvBfhGHFwmc56DuimvXr1Yh8iBVKDerc+uhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egwTP2/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7EC32782;
	Tue, 25 Jun 2024 05:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294169;
	bh=YDx8CffeBjbMEH8uNz+jJ2UtHby5+K0/CVVVU1HI0zs=;
	h=From:To:Cc:Subject:Date:From;
	b=egwTP2/2qssRXRjOMqvMQSFri3qzSytAjP4oClzwLp92y9P98x3KnJ2TMry/wG2vA
	 992FRxKE96YWDAZrBXYF/kZFLCVU+tuFvWm0aRtKVWNeue8xwq582Ew6Wwj9QbNC02
	 JdCkNjpCNLXqmFuE1dbFLg6d1OJRTenLaaJqcDf83jp0E/s4WLyvt8lxc+ib+1Yg0g
	 Vn7fET+itwLoaOpvX4P0Ap+x2V6Qsq3H472mABfUSg5a+AgLi8/kuGV7w3xK9lyfoh
	 lacRt5A0YueEXUW1y+SPsiRBfFX82IoLi+ndoHjxeyX4Pk6cam2s4tKra8NmpSVWu3
	 gA35RGFNVvqYw==
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
Subject: [PATCH bpf-next v5 0/9] use network helpers, part 8
Date: Tue, 25 Jun 2024 13:42:27 +0800
Message-ID: <cover.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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
  selftests/bpf: Use connect_to_fd in sockmap_ktls
  selftests/bpf: Use make_sockaddr in sockmap_ktls
  selftests/bpf: Close fd in error path in drop_on_reuseport
  selftests/bpf: Use start_server_str in sk_lookup
  selftests/bpf: Use connect_to_fd in sk_lookup
  selftests/bpf: Use connect_to_addr in sk_lookup
  selftests/bpf: Drop make_socket in sk_lookup

 tools/testing/selftests/bpf/network_helpers.c |   2 +-
 tools/testing/selftests/bpf/network_helpers.h |   1 +
 .../selftests/bpf/prog_tests/sk_lookup.c      | 141 +++++++-----------
 .../selftests/bpf/prog_tests/sockmap_ktls.c   |  51 ++-----
 4 files changed, 61 insertions(+), 134 deletions(-)

-- 
2.43.0


