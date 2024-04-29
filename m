Return-Path: <linux-kselftest+bounces-9004-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 007EF8B51F8
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEB23280D24
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF88125C7;
	Mon, 29 Apr 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkmcVnXB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EBEAC2;
	Mon, 29 Apr 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374467; cv=none; b=AmCqFGPk8Somn1Pe6/d4m2QXakFw3DSXETxyyFyIYjHqM+lXACAe1vq2JXOwfMjCWYTxdo+arbKx5YZvMI6azYmzvW0TsCcxmRIL+u75CbT5wXla8+rwrmB/lphuVPTqdS6tnW9DWfcV4aTayzWCqp/OSPbgBTr6vhErCZ/kUQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374467; c=relaxed/simple;
	bh=LVrUZuxUgIT+CYnkgICftuNuFWG6dYfuFHCIXSxud5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mMX09tzGAVSLfPB40fN4Fqqgl64i1C4TH+feArGIvYks9EyDKNxtQRR1BygfL+U6wm1QCSwqsyD/JBeE26Ze2iuBpgO0BTdTaqHdMUv5KBXqlero1IQHwxed6O7W+N1TVzb+QPyZ0Wu3Zlt+LSKYVvRI90RmfyyVom5BL1wYEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkmcVnXB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AA10C113CD;
	Mon, 29 Apr 2024 07:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714374466;
	bh=LVrUZuxUgIT+CYnkgICftuNuFWG6dYfuFHCIXSxud5M=;
	h=From:To:Cc:Subject:Date:From;
	b=EkmcVnXB/s2TiVQaNvLjLtzId/VAzLOaOkGognuGN107Q/UENMkgI8KuxK78gbopj
	 7C0dLQeb+h/wmmpBwmEaDVgKx8P9yhLeUArWw9v12NDuYnz2ZtTl+VA7q3/p4fza52
	 yKmWlTeAZUsE7mpNQ54Qu0L7aP4HodKXb9zhjpledyL/ovzeenx979U1hJd69XOV+x
	 KASrBz5vm/J6hHi8PgJYlBjNEvB4d7c0mMyBB7quwCJUr9juZHG63MVPcGFaILdRt/
	 LVnxlWHkefZAACKxRVwYyxhHewYva8HCN91oZ5jiLvQXceCUXS0dMKb1adIaBJJnzS
	 I4uELshn1EpyA==
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
Subject: [PATCH bpf-next 0/2] Free strdup memory in selftests
Date: Mon, 29 Apr 2024 15:07:32 +0800
Message-Id: <cover.1714374022.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Two fixes to free strdup memory in selftests to avoid memory leaks.

Geliang Tang (2):
  selftests/bpf: Free strdup memory in test_sockmap
  selftests/bpf: Free strdup memory in veristat

 tools/testing/selftests/bpf/test_sockmap.c | 10 ++++++++--
 tools/testing/selftests/bpf/veristat.c     |  5 ++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.40.1


