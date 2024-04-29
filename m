Return-Path: <linux-kselftest+bounces-9005-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBDA8B51FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 09:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAFB2813CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 07:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F50812E70;
	Mon, 29 Apr 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLMt7s9g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6703C125C7;
	Mon, 29 Apr 2024 07:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374474; cv=none; b=Qi9L1en4xyGLdNLCtWSgJK2pGJEP/7qka1eCkoLQ4pdMIFJKRrahijB+X88rEwMfujnqWaYkLxE+4COPWCjpK5P3rvHWLtLejZKzXjn/VHmlJ1cZf255nq4LDCyUSNbaRy5I2wn9YcX1XtvFButP1a+VoN1dJM4qxadWhUgyJRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374474; c=relaxed/simple;
	bh=DXr2pMZh7BTOmXSIeZOIVP06BS3XnB4krkOXdDtC3zM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ieHpW4IyHjSoRgUjHKeWi9dmzwQdQ/SnrYB/aayeQ/4kV47W9+1lEGHxx/vxQFS/cJjWQXxfo0Y+1c0uHHcG9sjIC7MUClOwxoyKw2LZqYJMI6M1nu6wm1OR81DEWBz8r8PsPDCSVlIW9oYPlBBDctMT7nNvpNI1vFwKEFRj2Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLMt7s9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBF1C4AF1C;
	Mon, 29 Apr 2024 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714374474;
	bh=DXr2pMZh7BTOmXSIeZOIVP06BS3XnB4krkOXdDtC3zM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eLMt7s9gnGcSAg6lUy583TSGw/+8hkYjfuSpyVaSgK/d7yUXKwbJcUFyZSHWKLFo4
	 OtgGLxWSJnGZPuf0NRLJHYyGz4JM0GU79BgtlkangSEp4MoBqnjcLotKrDOCyekKo8
	 EOiaeCsLVRFNuEAnoht/HuHFRe2/5/9msQNiSbZC8hrY2+fuPwR50cgQ0cDlzFkJ5v
	 pHY+dSQcSlLe+B6ZMgegNMkGfYff4AImglJyscPF4DSy7GGdY5RLwFONlXN35U1XMf
	 bFjNAcmHUbg2tcesxITDRTX/H5Q2DNskyXew9mQGevw6D+Kl0LC2wSizVr8h5Yw2Pf
	 GONa77GuJRbYA==
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
Subject: [PATCH bpf-next 1/2] selftests/bpf: Free strdup memory in test_sockmap
Date: Mon, 29 Apr 2024 15:07:33 +0800
Message-Id: <b76f2f4c550aebe4ab8ea73d23c4cbe4f06ea996.1714374022.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1714374022.git.tanggeliang@kylinos.cn>
References: <cover.1714374022.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The strdup() function returns a pointer to a new string which is a
duplicate of the string "ptr". Memory for the new string is obtained
with malloc(), and need to be freed with free().

This patch adds these missing "free(ptr)" in check_whitelist() and
check_blacklist() to avoid memory leaks in test_sockmap.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 43612de44fbf..92752f5eeded 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -1887,10 +1887,13 @@ static int check_whitelist(struct _test *t, struct sockmap_options *opt)
 	while (entry) {
 		if ((opt->prepend && strstr(opt->prepend, entry) != 0) ||
 		    strstr(opt->map, entry) != 0 ||
-		    strstr(t->title, entry) != 0)
+		    strstr(t->title, entry) != 0) {
+			free(ptr);
 			return 0;
+		}
 		entry = strtok(NULL, ",");
 	}
+	free(ptr);
 	return -EINVAL;
 }
 
@@ -1907,10 +1910,13 @@ static int check_blacklist(struct _test *t, struct sockmap_options *opt)
 	while (entry) {
 		if ((opt->prepend && strstr(opt->prepend, entry) != 0) ||
 		    strstr(opt->map, entry) != 0 ||
-		    strstr(t->title, entry) != 0)
+		    strstr(t->title, entry) != 0) {
+			free(ptr);
 			return 0;
+		}
 		entry = strtok(NULL, ",");
 	}
+	free(ptr);
 	return -EINVAL;
 }
 
-- 
2.40.1


