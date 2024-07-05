Return-Path: <linux-kselftest+bounces-13223-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3999280C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 05:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9431286D09
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jul 2024 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D26C136995;
	Fri,  5 Jul 2024 02:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlLZixcQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A4A132139;
	Fri,  5 Jul 2024 02:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720148350; cv=none; b=OQGQ2DVzNUOCPbakpOlEK3gsbSNgz+44hBPt9RlvSfW5yweyfSxH9qbvwrAFSEnMI/s4WUxJRWUkmqUxfCD3AGfaiBiv/Eekc4Dpcoy6GXN5dolNYlJHFrlrACxpd1eBLR2rPrJ4683ZNKVUPJfoPOOd/20XncSlotsvg3Sf3ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720148350; c=relaxed/simple;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UZ7TSi6LIlBaN+4UJnA+vivYMgWXl+uU2gIBRSi5HuLplVey3EUc5MWUalU5xSOBSSeppAc1cg9gVETy8lgK9vAEpKhGgNogNcwqEkPng8O2hOrjT54pK2ZN2JQb+aZjVjwdrlezw70wehgx6TkhL3vZTFDkGKNxIAKCBg3MYxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlLZixcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE136C32781;
	Fri,  5 Jul 2024 02:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720148348;
	bh=JAWAcKR7zBXRC50szWd1XFpZsq7hHNsF3ZdFSJ3411U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NlLZixcQhR6BN7yQaXc142HrOusxN2+SP9SGUJOWBkoITjBuOQHWyDL0ZolQ381SR
	 6vxh3PS5ze06baC7N6SJK/8qeb3aJc7mVNZ2tZw1r239Wq51dcSgDEEsj/UYRQa9ZN
	 TZ5O0CT6llFyRhXouIILvwwKHZPddvt1/Os2wt0bdo08327cmYQHfE4lfhX40dV7Wy
	 uY0OBDKRyPYSDOS783VNGWEAtlkfUNVXkbM/j0ob82AcAIKE82x65q/6++3w3YGk3t
	 xE/ALICJDwlYEBdzc8iK7pgNy0gETedPa3d/uyAlvzzTKJYFSHfQBy8ijaC+lrw4zM
	 6FP+Ztw+KI/zA==
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
Subject: [PATCH bpf-next v8 5/9] selftests/bpf: Close fd in error path in drop_on_reuseport
Date: Fri,  5 Jul 2024 10:58:27 +0800
Message-ID: <5104fcc71dd7a7e18716bf468dcbe82d8571af94.1720147953.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720147952.git.tanggeliang@kylinos.cn>
References: <cover.1720147952.git.tanggeliang@kylinos.cn>
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


