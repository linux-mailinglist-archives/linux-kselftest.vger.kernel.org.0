Return-Path: <linux-kselftest+bounces-8685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A058AE252
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 12:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C5A1C218FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA1F433DD;
	Tue, 23 Apr 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHew82RZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796343AA4;
	Tue, 23 Apr 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868549; cv=none; b=bvyzLpYU0HIryiqweoV1WcAbvl6Kq7yEyGDPe+kZuftZGPVtYDQ1lmr6WaUD1ENXc65iV8RrB3qsgseWAkwqUcnJnS2YRILkuaKb/YJkD++xy9C55c6C0dleQejruUla24mAmKXZwKi52GTk5gaYEQdkkuuktAGd/umqH/r1jbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868549; c=relaxed/simple;
	bh=RnU0yw+p+L7lm3tXso2OTfDmGPtvlCK4XIxpxQPqHJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iaqr0qE8EfIg8HRkEvH8/n9Ran0fPbUAUVXM5EjK8mmm/3HJy6qydlSKEGz0S4QYsqh2zVWCJWcOo88K2eGT87UA1eAy11tIhawcoJUjeqn99QBBHU04Ltuoe7iB45I/8FllGHyq3DzjfLhbbUELx4eqa5dtFKuCBWSeOgFVTYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHew82RZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747C7C2BD11;
	Tue, 23 Apr 2024 10:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713868548;
	bh=RnU0yw+p+L7lm3tXso2OTfDmGPtvlCK4XIxpxQPqHJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sHew82RZl4BK1b5Y7tD/SY7HcmdslIg/CPfbuifqexOBFrpKgQ4m5k+yS62jDOqFU
	 V7U/PKV/gZHRpstBPasypckJLd3l5pGXF28otJjdk6DUtLQk/mD9pdRfhif9lla8Wr
	 hoJGVdjRxXCp+TMUsxbxTcnXkVruxd3YJ2zzY0jLbXhkndOBl5ERx5GDR5W13fff0i
	 gHDLsAwwFKKMbs53TT7ZOWwIgFHci8w+D1Vui29SVhytrc4qhl6iZHEnvaDllpg2Xl
	 RakxM3x5cwC+o5zrQ35aS2fRrFjiPcHYz3ep/qNnE7efw5HPcodMJTWmQQ5bs5VixH
	 gaRTw1dUt7gKA==
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
	linux-kselftest@vger.kernel.org,
	Geliang Tang <geliang@kernel.org>
Subject: [PATCH bpf-next v2 1/5] selftests/bpf: Fix a fd leak in error paths in open_netns
Date: Tue, 23 Apr 2024 18:35:27 +0800
Message-Id: <a104040b47c3c34c67f3f125cdfdde244a870d3c.1713868264.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713868264.git.tanggeliang@kylinos.cn>
References: <cover.1713868264.git.tanggeliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Geliang Tang <tanggeliang@kylinos.cn>

As Martin mentioned in review comment, there is an existing bug that
orig_netns_fd will be leaked in the later "goto fail;" case after
open("/proc/self/ns/net") in open_netns() in network_helpers.c. This
patch adds "close(token->orig_netns_fd);" before "free(token);" to
fix it.

Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/network_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 9d63d2ac13d8..b2f531a6a4c7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -478,6 +478,7 @@ struct nstoken *open_netns(const char *name)
 
 	return token;
 fail:
+	close(token->orig_netns_fd);
 	free(token);
 	return NULL;
 }
-- 
2.40.1


