Return-Path: <linux-kselftest+bounces-9470-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 991C98BC03B
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 13:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8CA1F21544
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 May 2024 11:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4C175A5;
	Sun,  5 May 2024 11:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtriQHjD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1249114A96;
	Sun,  5 May 2024 11:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714908972; cv=none; b=EtcyBUxuw+IrTdLdE79LieldjYYSQADJ2PDx5q1dU0Nef+Z1mhsm/sS4XYKTqFeSCNO1WSBWXBme3MT5QC/4vbdzHlPzPQAKcLnu7ksISy5Tlu2wu02g1nBMRolk+pwX1SojLce4SlaCkz7VM2PRjIzP7wpcAEwoo3RkPPs2kyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714908972; c=relaxed/simple;
	bh=/AC7+LZJDf+efY3dpVitzKY1KWJsSFb1MpmvhpNE41s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NzBtWUv8iNhEsspHH0YwipGsvVc+fDQqq9THhKwCViZqTcrqafZvS+po971t6CIN1px22AyFk31XP8kcMrPC22vUM4qtdr8BVpNCxmDC+RWMMg6F9AoW9o3wuzZfG/Bp3q2d7vm1IBSvCa4GJ8A2JMdee7n6Pdq7jHdpO58cooA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtriQHjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA28BC113CC;
	Sun,  5 May 2024 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714908971;
	bh=/AC7+LZJDf+efY3dpVitzKY1KWJsSFb1MpmvhpNE41s=;
	h=From:To:Cc:Subject:Date:From;
	b=DtriQHjDjBrWXWXOM3eMFdQqUl3K52aMEA4m/5khziSQITfyJHnUW2pCWHlFRJqsS
	 idKmwsvWAA7AivuFoO3PQqXg1Aqy4ioZP+SWmmTnaLFCSMqiDJk0ETFQq24YxSSqfc
	 Bt7FixTN1/hS4SI7eL8voYtSCwcvZ2tKzLOITIqDCMdi9xoCaiydOkxqCxL2KjxDsO
	 GgGL/8JnWwxF9B9Cu7PUZhYMcixfVKwjnVgAxOMVBH80+Fr/zhL4uIeNBQSM3BL3JJ
	 HmPGXW0Goz9PCuSYV5yqIVAibx8oFVAxMamE0l8VhFwJzgcGMuwJslHvEVHXJhvcAd
	 GeEyYAVsr6AiQ==
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
	Shuah Khan <shuah@kernel.org>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next 0/6] use network helpers, part 4
Date: Sun,  5 May 2024 19:35:07 +0800
Message-ID: <cover.1714907662.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

This patchset adds post_socket_cb pointer together with 'struct
post_socket_opts cb_opts' into struct network_helper_opts to make
start_server_addr() helper more flexible. With these modifications,
many duplicate codes can be dropped.

Patches 1-3 address Martin's comments in the previous series.

Geliang Tang (6):
  selftests/bpf: Add post_socket_cb for network_helper_opts
  selftests/bpf: Use start_server_addr in sockopt_inherit
  selftests/bpf: Use start_server_addr in test_tcp_check_syncookie
  selftests/bpf: Use connect_to_fd in sockopt_inherit
  selftests/bpf: Use connect_to_fd in test_tcp_check_syncookie
  selftests/bpf: Drop get_port in test_tcp_check_syncookie

 tools/testing/selftests/bpf/Makefile          |   1 +
 tools/testing/selftests/bpf/network_helpers.c |  25 ++--
 tools/testing/selftests/bpf/network_helpers.h |   4 +
 .../bpf/prog_tests/sockopt_inherit.c          |  63 ++--------
 .../bpf/test_tcp_check_syncookie_user.c       | 117 ++++--------------
 5 files changed, 61 insertions(+), 149 deletions(-)

-- 
2.43.0


