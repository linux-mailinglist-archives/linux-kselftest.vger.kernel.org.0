Return-Path: <linux-kselftest+bounces-7071-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2D8968BE
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 10:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC721F2B072
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 08:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8B6FE00;
	Wed,  3 Apr 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwS9iZg4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7E26EB44;
	Wed,  3 Apr 2024 08:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712133144; cv=none; b=Izbx9OdlWJ5wk7bYUARMemK6sdc/kLwv57wnp66JXeibaoh+VBZBr5zz/9Va0OG7XYsxw/C8WFPs0U2rkRcMagiwLK+NwhPUtJ4QD6I/te+h/GC6l0Jcz9W/GrC2oivNqF1Cqs6XC4zjVUzeeVL4nWlAA1vtUR01fm46lNoDUnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712133144; c=relaxed/simple;
	bh=a1QM+YXnVizSAScGqWou87zl63DEaL9XVdmkRA97npY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLk/WHV614uCdEiUJcNKD3tISjl8oidqg2LWqUd8HkLS37zhYKBiUbV9pquS41QknSt6+8rNm9+MR+b2ipRrepcJSsdiwc62chDT7tS00MGRDbLv36Ir+2TolOxIpUgfbpt/plt8fccEO+vG1nVbC8ZZpUaimTH0BKcWhmN6BBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwS9iZg4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01FBDC433F1;
	Wed,  3 Apr 2024 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133144;
	bh=a1QM+YXnVizSAScGqWou87zl63DEaL9XVdmkRA97npY=;
	h=From:To:Cc:Subject:Date:From;
	b=TwS9iZg4x/uWYNwypdvrH21teIYr8PkqQX64NYDPE5SXIc2FPibbW50XEcddxbGZj
	 zJ5EMdIaeEzCHHcnZs5RdUpyLup0MLVL3j84/5JpOau6WsS8vUip5WECS2HtNfHnCn
	 xIvGc9FB9OMjYrYeUxEOf9AaVTKyXIt7xh/BjwigkOXTPvW4hOF+YmJrTSjUBWEqXz
	 Tf8jJSlEjFgKLMxs13JycR77lpJYV3wvdy2/yf6lM18M9415S/su48scHAyv7a6hGH
	 8Sm3RCSyIwGuKfnfgASGfrQJVr2X1aNfInYehadfaPZ+S6epyPAfuf9Tg7xi3zw/3E
	 uOweYUwAYy2+Q==
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
Subject: [PATCH bpf-next] selftests/bpf: Add F_SETFL for fcntl
Date: Wed,  3 Apr 2024 16:32:16 +0800
Message-Id: <b67101632c6858d281f105b5d4e1bc62dd6b7d27.1712133039.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
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
---
 tools/testing/selftests/bpf/test_sockmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 024a0faafb3b..34d6a1e6f664 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -603,7 +603,7 @@ static int msg_loop(int fd, int iov_count, int iov_length, int cnt,
 		struct timeval timeout;
 		fd_set w;
 
-		fcntl(fd, fd_flags);
+		fcntl(fd, F_SETFL, fd_flags);
 		/* Account for pop bytes noting each iteration of apply will
 		 * call msg_pop_data helper so we need to account for this
 		 * by calculating the number of apply iterations. Note user
-- 
2.40.1


