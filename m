Return-Path: <linux-kselftest+bounces-13362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7472592B599
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6271F23CA6
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D647F153567;
	Tue,  9 Jul 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ6+OLBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF3B66F;
	Tue,  9 Jul 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521932; cv=none; b=q9ZaNgOL84xDG76D5VgS+M/3NS+NAd+3oWPEruMBC41fJwtVqTHUBp4zVdfzIJgszIjqk/TB0qtU3+zRbx5eN7hjWr4XBWTdHlYNeJX3kZU+W0+i+Uh+lHhf3a5LogwyI2rpzzYTtNcwyZOqkiqQS1pxsKD5yEAXK3ekObqI9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521932; c=relaxed/simple;
	bh=GbLkdRWJ7v7Fl0b9H+I+JVXnJoW8GhcNGH7w5g7HMDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QGrvdpPyDrnPjB6FJTnnrMz6ZHXOufZYIQFMNeIZVvGpK9Wtg++n++0CT4DP/nmDZHRkSBmKUy7Vtkhtf/dQrAx9f7uMgj5fQCQ5zIsjs7QlDI/gDUrKGX5RAactFnilMBYs1vHYbuZau6I0CZ+LDbIseUJU2NhNSU0TrrE7eoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ6+OLBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9F0C3277B;
	Tue,  9 Jul 2024 10:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720521932;
	bh=GbLkdRWJ7v7Fl0b9H+I+JVXnJoW8GhcNGH7w5g7HMDk=;
	h=From:To:Cc:Subject:Date:From;
	b=qZ6+OLBKktuKBovnrt+ryIGAyr5Kn710PBAAylAZDENVOxwdBRXqXy9aj79aT5Dxc
	 CyWMmcX6PI+JoED/B7mMk9ZgPjYoB2jwuAVv3nWHweCYlSB9itYjboJvrLHnDIA/bu
	 p4btPqEUgh95jtXfo+iyoWNFP60RCigS271/piRmB2oxylqWG5H5fcbjMaSb95T2w1
	 ao3BMJdWADrqRGsW8AmU9ANFOLs7DuiUzxXKMtdkjdXhvjiidskMARObdTTqCf6fL8
	 7RJ/2m5oVsqePvypKMYimrzRSF9/Ry0v4B8M4OsTIvthGdCHglTMYGulXzl2qlboid
	 zFMDD/kCSMHxg==
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
Subject: [PATCH bpf-next 0/3] BPF selftests misc fixes
Date: Tue,  9 Jul 2024 18:45:05 +0800
Message-ID: <cover.1720521482.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Resend patch 1 out of "skip ENOTSUPP BPF selftests" set as Eduard
suggested. Together with two other cleanups.

Geliang Tang (3):
  selftests/bpf: Null checks for links in bpf_tcp_ca
  selftests/bpf: Check ASSERT_OK(err) in dummy_st_ops
  selftests/bpf: Close obj in error paths in xdp_adjust_tail

 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 21 +++++++++++++------
 .../selftests/bpf/prog_tests/dummy_st_ops.c   |  8 +++++--
 .../bpf/prog_tests/xdp_adjust_tail.c          |  2 +-
 3 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.43.0


