Return-Path: <linux-kselftest+bounces-8683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80BB8AE21F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:26:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB09B22818
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373D362178;
	Tue, 23 Apr 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HUdLp2va"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D033481D1;
	Tue, 23 Apr 2024 10:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868001; cv=none; b=bw40MsIfDrnTyuiAP1CyOEB+Votsfqilw/jWcQAn4nsKIcKJAxO8rHdhfW4cmL0DnGVq0sj+ku3JEwhl/VjaUQYTm+W3DXR3Rfo38jKb+0JJnTEOJtuNfO/cisRCN8OciXXk5B1gCA1LckdffmEoKs9zMU4jLKmwwBimiouvc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868001; c=relaxed/simple;
	bh=9HXfbycHwqXmAKZDBEaimP6Gs01ML6b9Mr8ArWmc5sQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ihDPcAgaJw4cjsCldSd3vUjZdERQi/YeZxy28FN+Ni8uO3+qKe/Q8QIuee5Sk47Ue9jwIlSD4q5aEd9if9w11lk1dhxNE5QEapP1xL2/kt0oj3WFC9EAHqTGZ2GayX56K8aea33agHF9uDpoIbrV77mXgbGQlDHX2+j758cRzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HUdLp2va; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774B8C4AF07;
	Tue, 23 Apr 2024 10:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868000;
	bh=9HXfbycHwqXmAKZDBEaimP6Gs01ML6b9Mr8ArWmc5sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HUdLp2vaosudp7Vptnmtwg5Ie6CPqqDyiXrxwr4ei1WvKFkt/KHpebM0ko69cABJ/
	 14pO38LaEWhNxj1IDyIfM0hRrVvbZ4FzTsT8aBGznxVkcFJrseCtaZASBtvdKJIlUq
	 ZQjvmftlADtj98EDR3b7y07R38pE35wEopy2T11KoIYWhLbgaZ2iN56B0LJZlEyjoJ
	 NSOUZYMfXWV1yqkDHGHlXEn6PTrPV9uK211ysKehmlUwxt+m5lTO5Q6Hy3y8Al5d++
	 Fd4Hd4+e+e/QlGjXoJ0UWDl/BSqPyWORQ2qUTJckNZWoiFsnA24a7BV5+w6v5/9c7/
	 JR5xuPtGF+pCA==
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add F_SETFL for fcntl in test_sockmap
Date: Tue, 23 Apr 2024 18:26:15 +0800
Message-Id: <c6c796dd0b32f2b6d6b2e70b54847a18b77bc275.1713867615.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713867615.git.tanggeliang@kylinos.cn>
References: <cover.1713867615.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Incorrect arguments are passed to fcntl() in test_sockmap.c when invoking
it to set file status flags. If O_NONBLOCK is used as 2nd argument and
passed into fcntl, -EINVAL will be returned (See do_fcntl() in fs/fcntl.c).
The correct approach is to use F_SETFL as 2nd argument, and O_NONBLOCK as
3rd one.

Fixes: 16962b2404ac ("bpf: sockmap, add selftests")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/test_sockmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 24b55da9d4af..74a2c6e74fae 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -603,7 +603,9 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		if (fcntl(fd, F_SETFL, fd_flags))
+			goto out_errno;
+
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
-- 
2.40.1


