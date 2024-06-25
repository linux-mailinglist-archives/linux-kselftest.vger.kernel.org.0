Return-Path: <linux-kselftest+bounces-12613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28581915E4A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 07:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6891C225F8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 05:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD770145B14;
	Tue, 25 Jun 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWbEUXJT"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7259145A0A;
	Tue, 25 Jun 2024 05:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719294193; cv=none; b=MzUhmFVBrFIVRl7hf+lRfe/98FZeiVOz0xAT08vyLNJqQih3fmxHzEe3a+lEuoWysSQPy6kZzjfet/UIr24xQgEl7ZpYUQLbo8jxqs41cSzl/XVHSzoaFvsyDqhKVGcAQab+iEjH31P6s6tE5voW/GgZna6I7Emzl46NkfvXQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719294193; c=relaxed/simple;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZYdhiMewgtRf/5WoHZQzpBm89J22dJ7fZvUqp34WvkYInDcQ7wtvpEBWIT41mE2Xqc22uK60cZ7uo1ysJnXjwKlZEGj+g6/7ExD+nYtZdH20U1M7h1VKBe/vrkSFzb1yjlvRneHh4CXWhMdw6KfPKFyE/jvqXfaycqW/xE/XVu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWbEUXJT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547FEC4AF0A;
	Tue, 25 Jun 2024 05:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719294193;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eWbEUXJTFYAD2tN/88OP9qj8KsPWIoYtu2hbFPZfcGkUNiUi1yOhcDPhNIlW2hKfc
	 ZQhPzPCsFGrjgMppKYmlCkAXU/LhM/EAfGl5uOWhwmtx4EKgNpES4367xpZj2Uu7cT
	 wLIfHd1LpRwEWzHCSj0vECtAIQzWGNHIDkehHkhqzGtR8WdCKqVw0LXkeYnNJ5MxWi
	 DhXRM+AYLRXAo6+yVcyQs4g3lXBrOlu783DjBE+TDCqtkAi6oZeNtBgEGlliXrnRME
	 +Y5DhM1FjxaQ+wSUI4umovAnpbI28VFCBmJXTfb0tWAGHqvryW1S12cqbP1MCX9a3A
	 fhq0iCiqvgacA==
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
Subject: [PATCH bpf-next v5 5/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Tue, 25 Jun 2024 13:42:32 +0800
Message-ID: <b5011a1564fdfca0a84136cf28fd2f0f376a31f7.1719293738.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1719293738.git.tanggeliang@kylinos.cn>
References: <cover.1719293738.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

Server 1 fd should be closed in the error path when update_lookup_map()
fails. This patch fixes it by goto "close_srv1" instead of "detach"
lable in that case.

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


