Return-Path: <linux-kselftest+bounces-7364-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9F689B68C
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 05:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 955ECB21CBD
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Apr 2024 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604E71C3E;
	Mon,  8 Apr 2024 03:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jFXaOCIL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CC1877;
	Mon,  8 Apr 2024 03:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547941; cv=none; b=ahyzyuTpY6XKKt1dkOYVVU8uqCHymSdy7quoycVR3L6MaHxsODoIyb9/GYUaElUQO957RmpQ2fnDL+FbqDDkrbhrkdtVpuSHEYsZVee79w43KjJb/CKHg9vlGlvNbJXau4QqXzJet6F6MOK4oj1lb/5L9bQinjMlN7wYrsU7nrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547941; c=relaxed/simple;
	bh=5cmshOX7UaN3lKb5QiC0cYkkPxcECgpeXktdJuIer1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xg92cYNjCDmeYdLzvelTnA0LcbHBO/ulbYQJ++PNxEbC+6lp2m8UE8ZkABB00JfeH+CNs3NAGh15DqIQwxCXeLdaYhrLxHdiKN74vduB3eQMxHOp8CVwzh8cmy2mHlm4YRwAWwJJrLFj6VaAWiPBP7MDw5yWuYJTHno5awvOqsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jFXaOCIL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4DCDC433F1;
	Mon,  8 Apr 2024 03:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712547940;
	bh=5cmshOX7UaN3lKb5QiC0cYkkPxcECgpeXktdJuIer1M=;
	h=From:To:Cc:Subject:Date:From;
	b=jFXaOCILRY4/og5XKK5FHZap4elY2yuKLfww99Z7lBarUlGxCOtqMx7ifzpUwdv0N
	 vncwYl8xkDB7XBjBrpM+aSJ8vHD7MVinT5zJPDhtmRnHyEz4XTJxNzWDvxyaLgDaBR
	 yhsYODq7+d5mutbVqr6t/auUMIY6HgF/uau+4o0gw7e46caxR6xpijO550uBtrn6U8
	 7dkVlief+dHz/6eB3o8uoAysoUG9UsQWpTGkb2sGaVYcx6gaaNnwEKT7qqCl0BSI/y
	 nqXz5gqhIGZKDErFZAJL1j+Jlc1Tb5ORMkYKzJJnVLguGOw2thn6E3mzgoyXVIYki2
	 UJURaavqH9qVA==
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
Subject: [PATCH bpf-next v2 0/2] export send_byte and send_recv_data
Date: Mon,  8 Apr 2024 11:45:29 +0800
Message-Id: <cover.1712547287.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Address Martin's comments for v1 (thanks.)
 - drop patch 1, "export send_byte helper".
 - drop "WRITE_ONCE(arg.stop, 0)".
 - rebased.

send_recv_data will be re-used in MPTCP bpf tests, but not included
in this set because it depends on other patches that have not been
in the bpf-next yet. It will be sent as another set soon.

Geliang Tang (2):
  selftests/bpf: Add struct send_recv_arg
  selftests/bpf: Export send_recv_data helper

 tools/testing/selftests/bpf/network_helpers.c | 85 +++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |  1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 71 +---------------
 3 files changed, 87 insertions(+), 70 deletions(-)

-- 
2.40.1


