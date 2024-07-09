Return-Path: <linux-kselftest+bounces-13351-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DE392B377
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 11:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E29291F23166
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 09:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CE7153BC1;
	Tue,  9 Jul 2024 09:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFKixkb2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2324014E2FA;
	Tue,  9 Jul 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516622; cv=none; b=pExjvqTjTJZH1KjJKqWoWltRdlX/Od51Lma/DSp8gzL7R1awlXfabDgYgQ/hAkkLch4yRcM0Y0a0uMSwyQFunsIkFT6tnRIIJZSVu5YE7bETPqmQ7ZNlCPoD4I+FwNnMMzuaNobzD/02obPeino8F6LQ0zsXWkyXCxUPwZpwee4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516622; c=relaxed/simple;
	bh=fM+Fvp9zNJCCiGYWxrP8nEmg3zhc+E1Yb8AOlDJckXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0JAWP+poguDcfhzZjhYAIHoOwghnXX708aevwKADd5q3NPeMxMJV05tHHHSaUNqZrSLWKxsyQgGgU8LexXyfFyE/Qw2NgMnv/EDMieo5e5FjvlsPt3BULqgXJIwB4Fib+6ZdJ7HXW8nkVXPOmcIkLT4g3u8KgB3i63EgEkYtAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFKixkb2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DCDC3277B;
	Tue,  9 Jul 2024 09:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720516621;
	bh=fM+Fvp9zNJCCiGYWxrP8nEmg3zhc+E1Yb8AOlDJckXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bFKixkb26ydQkxEYkcFOI1F0oFPz4quWlu+sjKO6jR1cSjLVqhi92VG7mhva8eisB
	 GlR2UsDKI/pFk6hP9zlipQ22DRzlTxLOo59uYHBa7Y9VVdi03a5Su+6XKDo2veHa5S
	 3HJLdH/6+yIDf8ueYY9TBUMdVj6aGxWkaGjc6cllFaUBFfb9SSfmBJIQQ80n71kcCU
	 IlE9kBjWyIQrvT8heiI6Ifg+a19BFrfWr04n50EQWKHGco0LLwmbqEQ5o6MwyJrx3C
	 M1cCQKpYODwLmodHTo3bnF4sWcmKQeC2ONaiIUIZRQY97LIlW3as74PZEV81xBHvDJ
	 YLNPgr9duwBiw==
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
Subject: [PATCH bpf-next v11 3/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Tue,  9 Jul 2024 17:16:19 +0800
Message-ID: <86aed33b4b0ea3f04497c757845cff7e8e621a2d.1720515893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720515893.git.tanggeliang@kylinos.cn>
References: <cover.1720515893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

In the error path when update_lookup_map() fails in drop_on_reuseport in
prog_tests/sk_lookup.c, "server1", the fd of server 1, should be closed.
This patch fixes this by using "goto close_srv1" lable instead of "detach"
to close "server1" in this case.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/sk_lookup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
index 597d0467a926..de2466547efe 100644
--- a/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
+++ b/tools/testing/selftests/bpf/prog_tests/sk_lookup.c
@@ -994,7 +994,7 @@ static void drop_on_reuseport(const struct test *t)
 
 	err = update_lookup_map(t->sock_map, SERVER_A, server1);
 	if (err)
-		goto detach;
+		goto close_srv1;
 
 	/* second server on destination address we should never reach */
 	server2 = make_server(t->sotype, t->connect_to.ip, t->connect_to.port,
-- 
2.43.0


