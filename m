Return-Path: <linux-kselftest+bounces-10223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9A8C5FAC
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 06:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8801C28300F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 May 2024 04:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB3E383A0;
	Wed, 15 May 2024 04:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcjUPqu4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B1839879;
	Wed, 15 May 2024 04:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715746838; cv=none; b=OqnFDRd+VCqVpI5fQz5crXFcBC2kpbgOEqFXJKv2GMRa3mVP9JM9jpuG+jK4fTAOcNKG7DY+ci83PkZ5uKLp9alb7hnz2VRhl4vdr0Zs2V2bjEHBdSCYfJtrVsPPs58VianvUMHjzXVslbJEay7D2Ctryy3A4vR1xKyPUpYc940=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715746838; c=relaxed/simple;
	bh=+3q2Llji2NZyoiPtz+uvf+DHFDrJ3CfZL/ZB9yqvYfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ogtzrZ/G9knmlahiXERGQRq87Beew+KwwmAzpTTDTQVQUawnw9omu4jO5k9mFSw68VRDDf29R6prWwv1b1DHtv55iYs1adlBGIy4hFiOV5ffr70wJ5qkIeFSEpA2Nh/7gqirUIcqKq9VjvfZ8NoJkfe75jzKtGw49Q38RdEXL+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcjUPqu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8F28C4AF10;
	Wed, 15 May 2024 04:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715746837;
	bh=+3q2Llji2NZyoiPtz+uvf+DHFDrJ3CfZL/ZB9yqvYfw=;
	h=From:To:Cc:Subject:Date:From;
	b=qcjUPqu413NocNEhv0OIoMo/KWYwFqj/pDqQJqhtzRf56DDBNvUa3U6F2CYPs2tKF
	 J7rXW6NyfcTb4VsRhG/OtpRJjB+UlvANqsVz7iH5glKRlGocFttP8N5DL5sACppVpo
	 kwSDLjfRC+bUidzW8M6H8JiVJ81WxeAIm66aQEyPMDbRkJvL9pH1+hBPIRiS5XXUNg
	 p7m93IDQjMXGbNcAmugFbSCGf6D+vZN/B+sMkQZkUUujkaPDgn+1mqS6bVqgrDX4oh
	 6klXrGA9tvDNyB6E2uvdEtqk21y9Jg22vOeOsuqKhyfRySljAnKNsPS7qs65BXRQBW
	 wVewYwyK3nsnQ==
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
Subject: [PATCH bpf-next v2 0/4] use network helpers, part 5
Date: Wed, 15 May 2024 12:20:20 +0800
Message-ID: <cover.1715745588.git.tanggeliang@kylinos.cn>
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

v2:
 - rebased on commit "selftests/bpf: Add test for the use of new args in
 cong_control"

Geliang Tang (4):
  selftests/bpf: Use post_socket_cb in connect_to_fd_opts
  selftests/bpf: Use start_server_addr in bpf_tcp_ca
  selftests/bpf: Use connect_to_fd_opts in do_test in bpf_tcp_ca
  selftests/bpf: Add post_connect_cb callback

 tools/testing/selftests/bpf/network_helpers.c |  13 +-
 tools/testing/selftests/bpf/network_helpers.h |   8 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 111 ++++++++++++------
 3 files changed, 86 insertions(+), 46 deletions(-)

-- 
2.43.0


