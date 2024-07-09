Return-Path: <linux-kselftest+bounces-13365-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DE092B5B9
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48B0282C60
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Jul 2024 10:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447C2157461;
	Tue,  9 Jul 2024 10:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BOF41gxn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E99815699E;
	Tue,  9 Jul 2024 10:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720521952; cv=none; b=imzwn/LqXjjtDWgctrZbyiUocic9tN4kHyYqaoAuBku0VAPbXNYUhrR9One+07QRQhyuXbKkmiQ7B4CXyIo9/B5HksSL2FexBYX2AOojd2oi/aKraUUgmCGW/ayKH9Ti3V8ImWl/1mKkqAbjg5tAsPMKTQw/Jo8PIlXZUeo7QoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720521952; c=relaxed/simple;
	bh=w6ec2huPARUWSaFkMfBkaPiPU+YqLo6r7sO4dLoGjRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I2r2Oifwn9EYmvMAcWIc5L75oNjjKGGo3F+Ur3Vpt9st7yPZWlDrHMOq+9+owU2zSpaHFs4OL9c+fDRmFRKQnUCGHzevdx8QIaAaYnqP3H+OLP+iQjWJGsKv4TBGLYTuxWoNJJQMKUarm38W2khNNcdmAak79ZrZPQ5IWEKdSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BOF41gxn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38CBC4AF0A;
	Tue,  9 Jul 2024 10:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720521951;
	bh=w6ec2huPARUWSaFkMfBkaPiPU+YqLo6r7sO4dLoGjRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BOF41gxnjgDHMXhHkN7b2GqHPlatafR5kwojlj5+1XBoEC/ceBYtOtBJoU9cB7Tqk
	 Z5rCkzIq/GthiMu+hP3Rcym6EFHzKE3gwTXccbPdz8Kdq5WTwOF67XxP+vPiPua+cF
	 7Ix1WM0C1vM5cdfsKH17Tcr0OS5Df/OeROkSEWuMmiQtxZ7OKovB9Lw64VJHTDzOB7
	 l2Xc3rV6jb6k+zWX3nNZHArAOL8XPMx6tbLKcB6Zpxk2Wig0zOhO/HgbZZD6Tk42BZ
	 9yUpHrEBPXC6rU6OqZgtsjAAFtFinasQ4UoBFb6QEn8eJRwKci03EOU4bpChh6Bz6t
	 sMSBYGwkS72Tg==
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Close obj in error paths in xdp_adjust_tail
Date: Tue,  9 Jul 2024 18:45:08 +0800
Message-ID: <3e55e7dc99f0331566cc3bb140fc189a0f8943e9.1720521482.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720521482.git.tanggeliang@kylinos.cn>
References: <cover.1720521482.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

If bpf_object__load() fails in test_xdp_adjust_frags_tail_grow(), "obj"
opened before this should be closed. So use "goto out" to close it instead
of using "return" here.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
index f09505f8b038..53d6ad8c2257 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_adjust_tail.c
@@ -222,7 +222,7 @@ static void test_xdp_adjust_frags_tail_grow(void)
 
 	prog = bpf_object__next_program(obj, NULL);
 	if (bpf_object__load(obj))
-		return;
+		goto out;
 
 	prog_fd = bpf_program__fd(prog);
 
-- 
2.43.0


