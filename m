Return-Path: <linux-kselftest+bounces-30329-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CAFA7F649
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 09:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62423BBE63
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Apr 2025 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C74262813;
	Tue,  8 Apr 2025 07:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NS3OqxXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33292620E5
	for <linux-kselftest@vger.kernel.org>; Tue,  8 Apr 2025 07:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744097478; cv=none; b=HGNoP9yzcOM0R07kOSxOiOzd2YhRlliUKTOVQ8wKKnqIdNmNWx8VUeX+8Rznv0AwtuG7uZnOFeKWHtIZWOONcmXu6cECrcfpMvnOBl767wz6ziolWsOxkxPCKmUAC4icYNUD4uGI/ng4JRkZv9zdFweIFgekhP/hMAHjf3FLLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744097478; c=relaxed/simple;
	bh=oa5ieiX2ScLX7V1FecBkrR6NbigcGJLTwyxXUxrNrFM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXySsPA8ahMAurY46mp682TfRXpo9TQQUXPEHtfFMVfSVY70WUhluJp8NhJ5rsVylYndhIkru6r/e8nTa7Q3BMPNpTE3LzxKLP/olhuylZFW+tm20leWyvE7cCQ5ICGR4uq4rpxnNfIKSMC75YV3fPGyrGCY2SLya6/kZeqORCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NS3OqxXD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744097463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=idfjo4chKagnHcXhzu8hjWU86/xZSxtihw5RQG6gUIk=;
	b=NS3OqxXDEuAm876PlF5euDllQASYqICToxPrdqxMBNdS1iWHQfTZJDIlviL6WoICP5pWow
	LqJ5k3UY6gDKGX86QCAgDd3PPYs9ejtfqrtKusIVATJYj+27DFDvy43WTXfSl68ilzZ0rN
	nRqRfQKRhNZ1/+lGeSsEj/EC4tp20+Y=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: bpf@vger.kernel.org
Cc: mrpre@163.com,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykola Lysenko <mykolal@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Michal Luczaj <mhal@rbox.co>,
	Cong Wang <cong.wang@bytedance.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v4 0/3] bpf: Fix use-after-free of sockmap
Date: Tue,  8 Apr 2025 15:29:51 +0800
Message-ID: <20250408073033.60377-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Syzkaller reported this issue [1].

The current sockmap has a dependency on sk_socket in both read and write
stages, but there is a possibility that sk->sk_socket is released during
the process, leading to panic situations. For a detailed reproduction,
please refer to the description in the v2:
https://lore.kernel.org/bpf/20250228055106.58071-1-jiayuan.chen@linux.dev/

The corresponding fix approaches are described in the commit messages of
each patch.

By the way, the current sockmap lacks statistical information, especially
global statistics, such as the number of successful or failed rx and tx
operations. These statistics cannot be obtained from the socket interface
itself.

These data will be of great help in troubleshooting issues and observing
sockmap behavior.

If the maintainer/reviewer does not object, I think we can provide these
statistical information in the future, either through proc/trace/bpftool.

[1] https://syzkaller.appspot.com/bug?extid=dd90a702f518e0eac072

---
v3 -> v4:
1. Rebase on -rc.
2. Incorporated valuable feedback from the v3 thread into the commit
   message, making it easier to review.
https://lore.kernel.org/all/20250317092257.68760-3-jiayuan.chen@linux.dev/

v2 -> v3:
1. Michal Luczaj reported similar race issue under sockmap sending path.
2. Rcu lock is conflict with mutex_lock in unix socket read implementation.
https://lore.kernel.org/bpf/20250228055106.58071-1-jiayuan.chen@linux.dev/

v1 -> v2:
1. Add Fixes tag.
2. Extend selftest of edge case for TCP/UDP sockets.
3. Add Reviewed-by and Acked-by tag.
https://lore.kernel.org/bpf/20250226132242.52663-1-jiayuan.chen@linux.dev/T/#t

Jiayuan Chen (3):
  bpf, sockmap: avoid using sk_socket after free when sending
  bpf, sockmap: avoid using sk_socket after free when reading
  selftests/bpf: Add edge case tests for sockmap

 net/core/skmsg.c                              | 22 ++++++-
 .../selftests/bpf/prog_tests/socket_helpers.h | 13 +++-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 60 +++++++++++++++++++
 3 files changed, 91 insertions(+), 4 deletions(-)

-- 
2.47.1


