Return-Path: <linux-kselftest+bounces-8552-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3FC8ABB74
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 13:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAB20B20FAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 20 Apr 2024 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78FE364AA;
	Sat, 20 Apr 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epa0cjKI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39629CF0;
	Sat, 20 Apr 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713614196; cv=none; b=mAuvL++MHNWHsM0L6DbWKH5ELFlU+u+rpha9OflYOGy2CII2iXHjEGEDtnHhIjsB6v3+6WMuWvMm3kV/udK4IOmCAb1Wwch7f1m+xx9LQThEU722q8txJvQOkgYDvPB4HZkB3EsJ2LxoLPbiSE2QozG7Z5crS+qL8xoGux1lTkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713614196; c=relaxed/simple;
	bh=RnU0yw+p+L7lm3tXso2OTfDmGPtvlCK4XIxpxQPqHJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rmK3NE2sBA01JTkuc1bSHGEcYP25b+0aTDPxR+2lSlnsS5i3cydIDoyZ1L6UrID+/jnYH45abtBkZSDr2fT9p65civjFaDGPY6hOivQfFDKq/FtyedY1Pc8u7fGTRmY9J0JSXC+o8DMrpJE6+mkB8fmA3Z4rM4p2/LsdtItauYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epa0cjKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FF6C113CC;
	Sat, 20 Apr 2024 11:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713614196;
	bh=RnU0yw+p+L7lm3tXso2OTfDmGPtvlCK4XIxpxQPqHJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=epa0cjKI2wEeIEip8XXw2JkldeIg10sMcpb8AkJAH9llbPgJhkAhcqeDFH+XoIJgy
	 u7ux8ddt3nGK4NVvv2xoOs9Eu9NJV331q3otsT250TYzeR93RHyFCik/eaQyW9roby
	 GYYly8fOvSxzpy0uey/Q5cFRbqgj0RR5nDO7EiabB0zfMplQFUxdTsx2fKw9jK7xpI
	 +aGYbuEXp+Bk4cHn8AE6zv0yIrP5qjL1tD4KHbObO1ZlZsnhg0vVu8bk3u2Zu3UOKI
	 yl2heeF2OhFbvg1ZVe0cfU0gmUYvAqNGw99QHKp6kSth+vtY8kgvpkZZdghpvxuZ2j
	 zmD7Wd0zcmFvg==
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
Subject: [PATCH bpf-next 1/5] selftests/bpf: Fix a fd leak in error paths in open_netns
Date: Sat, 20 Apr 2024 19:55:39 +0800
Message-Id: <bc3aa5ec3d9b91076c40f8356aa0ffcc201c2213.1713613543.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1713613543.git.tanggeliang@kylinos.cn>
References: <cover.1713613543.git.tanggeliang@kylinos.cn>
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


