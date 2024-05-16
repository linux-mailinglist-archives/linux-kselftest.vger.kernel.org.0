Return-Path: <linux-kselftest+bounces-10271-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4838C6FE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 03:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB1EB22294
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2024 01:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2814C10F1;
	Thu, 16 May 2024 01:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUkU2AxM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67901C2D;
	Thu, 16 May 2024 01:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715822014; cv=none; b=A3D2TLT33HqIQ4OFyz9qpL7ijYufJipGfFlXLamzR/QxxrY90VfKPwBRP7cpPEk/KAYsMS+9jytZc7Pcwo6ra1Qh4y3GiId/x1vDRNNbne7/ZUQUIBHW6D7ahxldK+bfRMrbwDXP1l0WLkvR7DkC/ejV3ll3xi2jWatlriM6j5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715822014; c=relaxed/simple;
	bh=Q5Cbjwtbw/8Kx0ebwpTU7N9zcYC0mwVyv7/lA72sn2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bPosiQYyWvhu0wiZ8xfClK+h9Sk5EBE/kwbscWsXf+mRlPL3Uco+LS+vpweTZ9t8rmOJcWyj9FhFkz2t9GyCbHVIFb+xdNbNPApNaHwga81OSLWJWrmqUMQRltWbtTqnVOihGECBXB9IwDymctrMx8/YaDGQaUqsHVQoVhOKQ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUkU2AxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF366C116B1;
	Thu, 16 May 2024 01:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715822013;
	bh=Q5Cbjwtbw/8Kx0ebwpTU7N9zcYC0mwVyv7/lA72sn2M=;
	h=From:To:Cc:Subject:Date:From;
	b=HUkU2AxMAhmAf3RJsHqQjaC8s/ACCtcNWbXaUBjWAjFSZDIgv4BcpmrsZPgJRvZpP
	 r2b3zBAWjM4oeFhs8qeyncfxpzlwsIrTGgqxbQhec8L+S9zV8s92eekJ3U6CFdP6RB
	 bc9OP+On4/oA93HSDkpbjB9yd1h5DY9nClkGl8SdZ7dqu98hW9f37p7BMkcn2ifAYa
	 bYxlUl4eQ7eENrlZts6yx3X5a19i9m81ubrhnlmKxCC4G08KOKv1l/PXnKInP903OB
	 yi5QN5riI+xNbGbMswTBT+noaVJ9j1RXDZX2lbCs+12NhFNwJLIkGbDI30ccM2XXWW
	 CL7euCVEjNN2g==
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
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2 0/8] add netns helpers
Date: Thu, 16 May 2024 09:13:06 +0800
Message-ID: <cover.1715821541.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset addresses Alexei's comment for commit "Handle SIGINT
when creating netns" [1]. Export local helpers create_netns() and
cleanup_netns() defined in mptcp.c into network_helpers.c as generic
ones. For this another helper unshare_netns() is added to replace
the existing local helpers create_netns().

v2:
 - drop patch 9, it breaks CI
 - delete netns first before adding it in patch 4
 - move cleanup_netns behind create_netns in patch 6

[1]
https://patchwork.kernel.org/project/mptcp/patch/20240507-upstream-bpf-next-20240506-mptcp-subflow-test-v1-1-e2bcbdf49857@kernel.org/

Geliang Tang (8):
  selftests/bpf: Add unshare_netns helper
  selftests/bpf: Use unshare_netns helper
  selftests/bpf: Drop duplicate create_netns
  selftests/bpf: Export create_netns helper
  selftests/bpf: Use create_netns helper
  selftests/bpf: Export cleanup_netns helper
  selftests/bpf: Use cleanup_netns helper
  selftests/bpf: Use netns helpers in lwt tests

 tools/testing/selftests/bpf/network_helpers.c | 68 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  3 +
 .../selftests/bpf/prog_tests/assign_reuse.c   | 12 +---
 .../selftests/bpf/prog_tests/bind_perm.c      | 11 +--
 .../bpf/prog_tests/bpf_iter_setsockopt.c      | 13 +---
 .../bpf/prog_tests/btf_skc_cls_ingress.c      |  6 +-
 .../selftests/bpf/prog_tests/crypto_sanity.c  |  3 +-
 .../selftests/bpf/prog_tests/decap_sanity.c   |  6 +-
 .../selftests/bpf/prog_tests/fib_lookup.c     |  8 +--
 .../selftests/bpf/prog_tests/lwt_helpers.h    | 26 ++-----
 .../selftests/bpf/prog_tests/lwt_redirect.c   |  2 -
 .../selftests/bpf/prog_tests/lwt_reroute.c    |  2 -
 .../testing/selftests/bpf/prog_tests/mptcp.c  | 22 +-----
 .../bpf/prog_tests/ns_current_pid_tgid.c      |  9 +--
 .../selftests/bpf/prog_tests/setget_sockopt.c | 10 +--
 .../selftests/bpf/prog_tests/sk_assign.c      |  4 +-
 .../selftests/bpf/prog_tests/sock_destroy.c   |  9 +--
 .../selftests/bpf/prog_tests/sock_fields.c    | 13 +---
 .../bpf/prog_tests/sock_iter_batch.c          |  9 +--
 .../bpf/prog_tests/tcp_custom_syncookie.c     |  5 +-
 .../bpf/prog_tests/tcp_hdr_options.c          | 13 +---
 .../bpf/prog_tests/xdp_dev_bound_only.c       |  3 +-
 .../bpf/prog_tests/xdp_do_redirect.c          |  4 +-
 23 files changed, 106 insertions(+), 155 deletions(-)

-- 
2.43.0


