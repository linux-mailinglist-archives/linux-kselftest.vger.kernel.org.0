Return-Path: <linux-kselftest+bounces-7478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41E489D765
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 12:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E7F9281EB4
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Apr 2024 10:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3084D03;
	Tue,  9 Apr 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JeF6v419"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1AD84A38;
	Tue,  9 Apr 2024 10:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712660281; cv=none; b=MhMmdZ/5JC6ZtjMKZfTA/mLqzZb0bcZUDJatb68p8ImFP8etrxXFEoOynwFOdryyWpB8S0v5DSOKqW6CWoOso4bKD6UaE3YMAqVSksQ8aupd+RSqY4vXaTyeE5ZXYAND3teEwtXEHPEPKE90bWp48qdo80EWWRiRWI2ACF5eTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712660281; c=relaxed/simple;
	bh=1Bbg6ZrbPLTUeYX11KUhFLpnFmjl2oTsXv7zRjBuY9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MB7nQpydSJHhozUuJx73R94e3if69FZEojkSQ7jUouf+2ZmG1pUd1FA8JDGYubzIqzneTXrnbN6rjWn04Yn6hWA6916Ys7wUYhvRNISuKz5C6Lf+oiIq34GZbDrxLER7KvzL2l52xZBczHTm8EqNKLH/lJY1hc+rOzjgYhoUQf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JeF6v419; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49C9EC433F1;
	Tue,  9 Apr 2024 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712660281;
	bh=1Bbg6ZrbPLTUeYX11KUhFLpnFmjl2oTsXv7zRjBuY9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JeF6v419YMBNTzV04DRcgUtNVC73ajSpWumSJU/As2R/ZT8Mv/dfF8xc8pWv07q2J
	 rne3m3GMVmYDn+FtE5dPfOuS8+Gx/FNfMCo+C41WOnnqReQPWSlB+/z5Y/0Zk8tVcP
	 8KkFV8YJIB9y/lrkWZFzS37QjZQEE50z+GDm0fWx6YP1vQ3f6OJbYZDF0/RZ09oClC
	 pVGKbo3MGCFt06oKGe0kIuiW/YkovXjkGbKfCKQ4WsJnNMn3Ux33+LKUHjIb9BxhJ+
	 ET8ZyOd+kqA174VsbQrADgpHNp9EXLss8mHQLXGFgogSX6OVPiGTFjqDcVkwqzDBUe
	 1vWAu0vZyBYiA==
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
Subject: [PATCH bpf-next v3 4/4] selftests/bpf: Support nonblock for send_recv_data
Date: Tue,  9 Apr 2024 18:57:25 +0800
Message-Id: <ff4076db2676a89fadea5187480cd49e767a337a.1712659575.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712659575.git.tanggeliang@kylinos.cn>
References: <cover.1712659575.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Some tests, such as the MPTCP bpf tests, require send_recv_data helper
to run in nonblock mode.

This patch adds nonblock support for send_recv_data(). Check if it is
currently in nonblock mode, and if so, ignore EWOULDBLOCK to continue
sending and receiving.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 55d41508fe1f..08a204828ded 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -565,6 +565,7 @@ struct send_recv_arg {
 static void *send_recv_server(void *arg)
 {
 	struct send_recv_arg *a = (struct send_recv_arg *)arg;
+	int flags = fcntl(a->fd, F_GETFL);
 	ssize_t nr_sent = 0, bytes = 0;
 	char batch[1500];
 	int err = 0, fd;
@@ -588,6 +589,8 @@ static void *send_recv_server(void *arg)
 		if (nr_sent == -1 && errno == EINTR)
 			continue;
 		if (nr_sent == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			err = -errno;
 			break;
 		}
@@ -609,6 +612,7 @@ static void *send_recv_server(void *arg)
 
 int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 {
+	int flags = fcntl(lfd, F_GETFL);
 	ssize_t nr_recv = 0, bytes = 0;
 	struct send_recv_arg arg = {
 		.fd	= lfd,
@@ -632,8 +636,11 @@ int send_recv_data(int lfd, int fd, uint32_t total_bytes)
 			       MIN(total_bytes - bytes, sizeof(batch)), 0);
 		if (nr_recv == -1 && errno == EINTR)
 			continue;
-		if (nr_recv == -1)
+		if (nr_recv == -1) {
+			if (flags & O_NONBLOCK && errno == EWOULDBLOCK)
+				continue;
 			break;
+		}
 		bytes += nr_recv;
 	}
 
-- 
2.40.1


