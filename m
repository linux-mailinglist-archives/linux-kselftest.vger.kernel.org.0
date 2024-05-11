Return-Path: <linux-kselftest+bounces-10091-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79D88C2F4B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 05:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737C928290B
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 May 2024 03:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9004C24B5B;
	Sat, 11 May 2024 03:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUrsIVWH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6597C21A04;
	Sat, 11 May 2024 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397401; cv=none; b=t0IWiySwoNOWsXsgcx1qimRYSRFcuovCu3Z+UoqOYJFh6WuIk5SBGx4XxKmmhUteHDzq8X2P7ANy4ecaSn2Z6VbEkSwvhC/cyhwNd+KtU6eWfXAH054TIIp+LDxW1i2OhWW0ApWF5oVFVk01eM4TeWgFhBG2nbOQ03+0N2qP/vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397401; c=relaxed/simple;
	bh=VNZWbyB0sPB4GGLEN/TJoCScuWT9X5M8rRhhLEnSAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNnKFMhM2v2+rMUzQb4OKL8Mn+nlyAL40pBIn1kLnFQeKZ27B5nFWOJy8K2avM6fBT8c2KUUOi++UZhJhPSGK7MLQouBIgjFcAM/IaqUT3DEf5+JmiRmPXzDpPyy5ubccAY02wOjq4zMfej1/1rGNsKSOp0dRBv5Be4LBCO+W8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUrsIVWH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDCCDC113CC;
	Sat, 11 May 2024 03:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715397400;
	bh=VNZWbyB0sPB4GGLEN/TJoCScuWT9X5M8rRhhLEnSAt0=;
	h=From:To:Cc:Subject:Date:From;
	b=hUrsIVWHsLrJqkvpCZpp6TkrjoXD3gZHxRq144YavEzF0ed4qHJ66gzW+xJvKApR8
	 19fm5b5rqEr6u1q78fwYvEkKX3hk/qD4i8weJtmGknzILVRYDgqaE73ox0gQg10TYe
	 ZZYWoEmQLoLo4hDANDwkreWCcNe8Vxq8hUqqfwhvXP2aQo2yhc/YFwW1R64oag++lh
	 l7aExx5StYsEUz7X692Qmh5Xs4D17m1epWSWfYjo51+EhiTQboXkuQPqhafJywT7L0
	 T994h/hRiy2pOQGnFCGjv53+HisLYfe+YwczRJWZ1R3M3LhCzW+40LvnUKq7NjcESX
	 CzZmtBx5OpO4g==
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
Subject: [PATCH bpf-next 0/4] use network helpers, part 5
Date: Sat, 11 May 2024 11:16:24 +0800
Message-ID: <cover.1715396405.git.tanggeliang@kylinos.cn>
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

Patch 3 adds a new member in post_socket_opts and patch 4 adds a new
callback in network_helper_opts. I'm not sure if this is going too far.

Geliang Tang (4):
  selftests/bpf: Use post_socket_cb in connect_to_fd_opts
  selftests/bpf: Use start_server_addr in bpf_tcp_ca
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add post_connect_cb callback

 tools/testing/selftests/bpf/network_helpers.c |  13 ++-
 tools/testing/selftests/bpf/network_helpers.h |   8 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 105 +++++++++++-------
 3 files changed, 81 insertions(+), 45 deletions(-)

-- 
2.43.0


