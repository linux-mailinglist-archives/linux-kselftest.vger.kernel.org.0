Return-Path: <linux-kselftest+bounces-49370-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD424D3ABF3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 706D830211A3
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D0A3644D0;
	Mon, 19 Jan 2026 14:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vLTnVnw4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC7389475
	for <linux-kselftest@vger.kernel.org>; Mon, 19 Jan 2026 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832657; cv=none; b=qBzggoXKrbp4L0zJ8yYW40K2TvfDMtna+WuyTTky4hgo5E0YR4/mQytKJb2//bkrdabefkgz3x1xeG3Agk6IaJRjAGv/Hh1hjTw/BEEI/59pzxUaLX+iqFyqpXzgZ1DqUYI78T08dbTRLjschDKbYdMOt9KaYcFoHfix6D9X40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832657; c=relaxed/simple;
	bh=n9sZEwW8aRs9KO1WTVOCaIs4K7fiu1d+TWNIVzf1MeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=liNz1sFqywSvkdVrtnibcW+x8e1jpK2Pc+tLGDb9T8bJF1Puf5ecE2a+gXTWYm7q4KNtBY3+EO2MOu2nG3aPnvnuzhiHDijL9bCxxupGQbirl7h24reGpyIZz6MOVWJQ1MI8S2EmROsjtQ7QTgPlXfXHNble03eOb+USH0mOzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vLTnVnw4; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768832653;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GtM8pK4JNsrvpwbWfCZ7E1yYuWQlGOAHpNcvj0+XSbY=;
	b=vLTnVnw4hZZv3DMC0cGRCLjxlbxdMh+uIR7+Yqw+yHfZH2+kt6u5tJvWCkObYu2hysHOAZ
	lIITiOxtYG6WyWqLNZ1J8+01O8kMGXTwj1UISpyZy4F0Ng0Ru9yh7hPZ4M6MtC9m0JiEUq
	t7qabj0fl50qqiyco7KvEyhfMDbKDes=
From: Leon Hwang <leon.hwang@linux.dev>
To: bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Leon Hwang <leon.hwang@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-patches-bot@fb.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Allow -ENOMEM on LRU map updates
Date: Mon, 19 Jan 2026 22:21:20 +0800
Message-ID: <20260119142120.28170-4-leon.hwang@linux.dev>
In-Reply-To: <20260119142120.28170-1-leon.hwang@linux.dev>
References: <20260119142120.28170-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

LRU hash map updates may legitimately return -ENOMEM. Relax the percpu
stats selftest to accept that error for LRU map types so it matches the
map's expected behavior.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 tools/testing/selftests/bpf/map_tests/map_percpu_stats.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
index 1c7c04288eff..d510a9c54978 100644
--- a/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
+++ b/tools/testing/selftests/bpf/map_tests/map_percpu_stats.c
@@ -188,7 +188,8 @@ static void *patch_map_thread(void *arg)
 						   40, retry_for_nomem_fn);
 		else
 			ret = bpf_map_update_elem(opts->map_fd, &i, val_ptr, 0);
-		CHECK(ret < 0, "bpf_map_update_elem", "key=%d error: %s\n", i, strerror(errno));
+		CHECK(ret < 0 && (!is_lru(opts->map_type) || ret != -ENOMEM),
+		      "bpf_map_update_elem", "key=%d error: %s\n", i, strerror(errno));
 
 		if (opts->map_type == BPF_MAP_TYPE_HASH_OF_MAPS)
 			close(val);
-- 
2.52.0


