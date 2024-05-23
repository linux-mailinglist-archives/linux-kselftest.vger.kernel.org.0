Return-Path: <linux-kselftest+bounces-10608-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B58CCC7E
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 08:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A7CA282932
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 May 2024 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E37C13C8F3;
	Thu, 23 May 2024 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGq8GO5I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046C613C838;
	Thu, 23 May 2024 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716447052; cv=none; b=JywuqU5Hi98U6M+ertTyhDAAbpez5UGGlFLydfdrsG7i7Wvp0Q6BKtrO4ZpCSppOzWVbvofQ9JoW/Tbf1cJKWyFn/y5ewGj1nPBrV73HyEiEYRs3b84SsMjUyzIOzOsasl8QhhdGWruYfvGDHzoISy8FTYtm0INl2an4Sh7D7TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716447052; c=relaxed/simple;
	bh=XxU76wSm2VGBTgKDwcx/rB1boeVCdpt1MRZ/fiiWAOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vhdnp7ctVBKMPeVI5u4Bk937Hgo+BSfCUnCyTLoUHR6lSFVCm1jnJhXlQ2Q1hgc84QoAw590z0uJnOfuX5XTcBNgGPw7Kph0bqMOcEOG+x+5u6RwY5o82u7ua9t2PDofLo9jRmQ/2ZhCV8DiMF03mj0S1/rlah6hcoSdK7fAy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGq8GO5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED88BC2BD10;
	Thu, 23 May 2024 06:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716447051;
	bh=XxU76wSm2VGBTgKDwcx/rB1boeVCdpt1MRZ/fiiWAOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cGq8GO5I7w/oERSiKjS6JbZ834/uTytnA8GchwA9/Gc4vyJWOyDxkEzZdrEFotFvp
	 iJnFrqVrsnx31KWz3d1FFQ1i6UVJD+6HvGWeVtL64us5uoYwpC80+p0iKGAm6eMBYq
	 kNUKLQzJfm9yLcqSJnNmXpX32oVE6deed0Nx8/JRJ7liz+qEV4xZWrvW4LoBXst9E/
	 IYbtF7kz4FIozfCxJgOS1e4hBD1LJR63k1axZEr+nxnLjvunPsxF0q83rjMKhvrprM
	 OHCeVrqSbBitM9E8zVjUkq6I78ZNASFpbasgbCjI78DuVWFR+VKaEJAunqAA9NmpO1
	 jlZg+iGV/yXCw==
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
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next 5/8] selftests/bpf: Drop prog_fd array in test_sockmap
Date: Thu, 23 May 2024 14:50:01 +0800
Message-ID: <9a6335e4d8dbab23c0d8906074457ceddd61e74b.1716446893.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1716446893.git.tanggeliang@kylinos.cn>
References: <cover.1716446893.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

The program fds can be got by using bpf_program__fd(progs[]), then
prog_fd becomes useless. This patch drops it.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/test_sockmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_sockmap.c b/tools/testing/selftests/bpf/test_sockmap.c
index 8e32d157bac0..e83ca0005721 100644
--- a/tools/testing/selftests/bpf/test_sockmap.c
+++ b/tools/testing/selftests/bpf/test_sockmap.c
@@ -63,7 +63,6 @@ int passed;
 int failed;
 int map_fd[9];
 struct bpf_map *maps[9];
-int prog_fd[9];
 struct bpf_program *progs[9];
 struct bpf_link *links[9];
 
@@ -1000,7 +999,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 	}
 
 	/* Attach to cgroups */
-	err = bpf_prog_attach(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS, 0);
+	err = bpf_prog_attach(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS, 0);
 	if (err) {
 		fprintf(stderr, "ERROR: bpf_prog_attach (groups): %d (%s)\n",
 			err, strerror(errno));
@@ -1279,7 +1278,7 @@ static int run_options(struct sockmap_options *options, int cg_fd,  int test)
 		fprintf(stderr, "unknown test\n");
 out:
 	/* Detatch and zero all the maps */
-	bpf_prog_detach2(prog_fd[3], cg_fd, BPF_CGROUP_SOCK_OPS);
+	bpf_prog_detach2(bpf_program__fd(progs[3]), cg_fd, BPF_CGROUP_SOCK_OPS);
 
 	for (i = 0; i < ARRAY_SIZE(links); i++) {
 		if (links[i])
@@ -1834,7 +1833,6 @@ static int populate_progs(char *bpf_file)
 	i = 0;
 	bpf_object__for_each_program(prog, obj) {
 		progs[i] = prog;
-		prog_fd[i] = bpf_program__fd(prog);
 		i++;
 	}
 
-- 
2.43.0


