Return-Path: <linux-kselftest+bounces-29189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D1A64722
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F4167A58A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Mar 2025 09:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBD2226888;
	Mon, 17 Mar 2025 09:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="b2QALQon"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93151156230;
	Mon, 17 Mar 2025 09:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203406; cv=none; b=g3Wpz+WhVVFOIc5Td9sPP/Uw/iJM3ClWxjnP9uD79s9PNaqOdnWqpC5v1LFsU1hxkVygTyVRC3HjX4Oup0g5YVXiVf4gbjQEGtlbRBrlS13h6QnmJ2Cd/S1TeEsTrJnpXRwbz0cdQWJAe0CZx8kartCMFfr5tNarSJoC/phTsYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203406; c=relaxed/simple;
	bh=Mb+VgaKm8ivxxe76CDFQAgmn9l/OziEXUXi1fWj9XjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TRu/eRTYYskhdAffgNP1maN/QJFCnOnjdgmXQlCrgOduBAK8tloyhrA/4gx6c5/T7R2LOSmdtpxDGNCutR+teFpUNWHEq9kP+fQiDNfjP/h8CbMGCkZOKAuXwjy30o5tHxeOI4vQdJkj/m1qKQzNi2Vx3FUXlkbZnQhK9NEBbLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=b2QALQon; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742203390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KquXK1TpLM2XmJHXcnCYTlyZgnHIxPXdI8vQnH71mNA=;
	b=b2QALQon8MOddzk0m4fpkNMP0165GyN7u+ahlifTUVPAdZkyMBNVDsV5e2/BAzrSlZfH0V
	8mtN3heQ/oMBw6Bgv/x34HKBXQFdBFiIctfPrQICFpCNIF3L+yzrZIZ9xr7PYAOiu5DI0g
	fq31WNO9OneS+ccqqbJNf1bKrvXjkps=
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: xiyou.wangcong@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	mhal@rbox.co,
	jiayuan.chen@linux.dev,
	sgarzare@redhat.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] bpf: Fix use-after-free of sockmap
Date: Mon, 17 Mar 2025 17:22:53 +0800
Message-ID: <20250317092257.68760-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi all, this is the v3 version.
===
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


