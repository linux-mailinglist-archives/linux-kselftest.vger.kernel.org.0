Return-Path: <linux-kselftest+bounces-7652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4394C8A0537
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 03:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D83E11F2374A
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 01:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA44604C8;
	Thu, 11 Apr 2024 01:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2tLgnTO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D4604B3;
	Thu, 11 Apr 2024 01:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712797452; cv=none; b=fL8/Msw90jY8c/KPlXyLkuB7DTC7LRAzlch8KiOOxTehVIuVdQyurdujLk8kOqWzmzFEUrnmX1+ecEYH4w6QPCM1OZHBzvoHhbKnjodvNObvmvhxk6ixTHQoSdeeNmRcgsPj7maCD5a4tcj6IqcCBTvT+gxBbCjIZsn7XgBsJhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712797452; c=relaxed/simple;
	bh=DHoqFzvR8h5e0Ka81U5pi4ylSFr7lfzO4yBmabLLGH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CIj49r1cnTL9PTvWKSYFADsIysxQhUG4MevAFxN49aliKMEtEQGo23ZlwKTwmshLVD/C7jHBfKILcR1GpWwoMfI1MrJSN5F6yOrtuEu8GgCYx/ZiobWeHT9vfcEPOchwexfl8J4VgcWfOkAvhyKI4QCgFkRYpSsejN8WPByH+I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2tLgnTO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C463EC433C7;
	Thu, 11 Apr 2024 01:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712797451;
	bh=DHoqFzvR8h5e0Ka81U5pi4ylSFr7lfzO4yBmabLLGH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2tLgnTOhrXYzLea29+C8wWkjfueJJKh4q00kJJ3aVNXrJsCy3R1r7AFRy7OlFiCE
	 ckjRsvqIyzkk/4Nrw7Pm5BRyeir4BOFvEi3tuLWLmt+K4AhCpf7Gu9rPFbwnplfYqU
	 o2daSFPd5BiIZRRChhEadDOJKHJwPhb/o34n/Y5xxAF41XLo3XkhUv+f4H65Sun6hG
	 7W6yp1r2nh80cwzyXA9c8f5MhruRcOkhCnbZ5mm5uiG9ViL4VBEyV78irhGBWBwyBB
	 IjFUxlAAdCEBVCYu/mFhxkZ9ta6oL5P5b8CraruH//qwTB8x4qDBk7D8+ZaycXb8y3
	 njVqgV+Xm8mcQ==
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
Subject: [PATCH bpf-next v2 06/14] selftests/bpf: Use log_err in network_helpers
Date: Thu, 11 Apr 2024 09:03:14 +0800
Message-Id: <b8b4c185bb87b7bdb170f7ca8ec8960d27d05423.1712796967.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1712796967.git.tanggeliang@kylinos.cn>
References: <cover.1712796967.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The helpers ASSERT_OK/GE/OK_PTR should avoid using in public functions.
This patch uses log_err() to replace them in network_helpers.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 7ddeb6698ec7..91b014784dd9 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -447,22 +447,30 @@ struct nstoken *open_netns(const char *name)
 	struct nstoken *token;
 
 	token = calloc(1, sizeof(struct nstoken));
-	if (!ASSERT_OK_PTR(token, "malloc token"))
+	if (!token) {
+		log_err("malloc token");
 		return NULL;
+	}
 
 	token->orig_netns_fd = open("/proc/self/ns/net", O_RDONLY);
-	if (!ASSERT_GE(token->orig_netns_fd, 0, "open /proc/self/ns/net"))
+	if (token->orig_netns_fd <= 0) {
+		log_err("open /proc/self/ns/net");
 		goto fail;
+	}
 
 	snprintf(nspath, sizeof(nspath), "%s/%s", "/var/run/netns", name);
 	nsfd = open(nspath, O_RDONLY | O_CLOEXEC);
-	if (!ASSERT_GE(nsfd, 0, "open netns fd"))
+	if (nsfd <= 0) {
+		log_err("open netns fd");
 		goto fail;
+	}
 
 	err = setns(nsfd, CLONE_NEWNET);
 	close(nsfd);
-	if (!ASSERT_OK(err, "setns"))
+	if (err) {
+		log_err("setns");
 		goto fail;
+	}
 
 	return token;
 fail:
@@ -475,7 +483,8 @@ void close_netns(struct nstoken *token)
 	if (!token)
 		return;
 
-	ASSERT_OK(setns(token->orig_netns_fd, CLONE_NEWNET), "setns");
+	if (setns(token->orig_netns_fd, CLONE_NEWNET))
+		log_err("setns");
 	close(token->orig_netns_fd);
 	free(token);
 }
-- 
2.40.1


