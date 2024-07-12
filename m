Return-Path: <linux-kselftest+bounces-13642-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CB792F5E1
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 09:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C791F22CFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Jul 2024 07:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8E513D510;
	Fri, 12 Jul 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjhd3PED"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C53079CC;
	Fri, 12 Jul 2024 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767909; cv=none; b=aOWc+Dk+3CUeSCmy3wQ9of88kEtPNARjD7Q/iGNM+GMZpQeXzRrbMwBJyq5BD1xX2X5ePjYykKfYwa9FmXYrGKotKy/PmBsdqU5yYQkhFvAuHN/cjG2GqJibfhtuNUg9GS+od3RlqNxF+ExgujWhr5BsHSMWYiHbTMRzld9gvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767909; c=relaxed/simple;
	bh=mmYPed5IYWU8Z1sRw6YL3/h/tM3hIPu+PWVbA9tENVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TT9bDVwSNj+23kOWXJ1I1jaAG5uXT2zcHkzh8+2gwxKKLYc6ZdaSKY1ovf/3oe1zftBkzY5NiZMW2SBl47rYT9DX5V8cjhZnahQR9S9Uj1Y2cq9SVADd4Jlky9YLoAyaZCEMQ2QIDh4pVIvqRgQffRD4pfEmMZ/Mxv3xN6gsBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjhd3PED; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96B4C3277B;
	Fri, 12 Jul 2024 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720767909;
	bh=mmYPed5IYWU8Z1sRw6YL3/h/tM3hIPu+PWVbA9tENVY=;
	h=From:To:Cc:Subject:Date:From;
	b=kjhd3PEDKiBD65kxfelvUzhVk8ZlteRVsbpTd/DJ8/CtlVjaS2d5TAUq51x4Dh1Z1
	 ItozfemXq43f+O9hx3CbSBFOKfoZRAEQZtOJ7zt10SxZRvtLqldKfX+XGU6/DroUHt
	 SdlbQYxoDK4cdnaUnvp2Xb2MvVAwWkIDOJGK8W3xouBisJEMNOXI3VhJDCvCdVRznc
	 y6G3Cub2WeAkaBCOTh278ED6cFhiwsR18YWQCndDkPnvmTPM2+qstxUYQvfqgviYHl
	 JCrnK9NEETqzyHwdAN9QB6LVIlMEzId1Ta2UPbB7togHahcu5roXZF/Uj04SjbOQCF
	 XnsICT6BGYZVw==
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
Subject: [PATCH bpf-next v2 0/5] use network helpers, part 9
Date: Fri, 12 Jul 2024 15:04:47 +0800
Message-ID: <cover.1720767414.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

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

 tools/testing/selftests/bpf/network_helpers.c | 67 +++++++--------
 tools/testing/selftests/bpf/network_helpers.h |  5 +-
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     |  2 +-
 .../selftests/bpf/prog_tests/cgroup_v1v2.c    | 12 +--
 .../selftests/bpf/prog_tests/sk_lookup.c      | 84 ++++---------------
 5 files changed, 53 insertions(+), 117 deletions(-)

-- 
2.43.0


