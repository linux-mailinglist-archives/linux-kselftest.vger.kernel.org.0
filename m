Return-Path: <linux-kselftest+bounces-9006-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C70E8B51FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 09:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDCA0281415
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2024 07:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE6E12E70;
	Mon, 29 Apr 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RREk1pLM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AC9EAC2;
	Mon, 29 Apr 2024 07:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374482; cv=none; b=Y7mNZ4DnnZSCWPumpaz0Bgy5i4orLFN15dOanv5gs1GdGGaza34CsnfcNvChs4ktJIYeC1D8qKH65OFS00YbWNOQJ+ZxFPrWXwZJ5qICE7HbzkYFTKH/gpzMqrf8Ms3u1MyY8O1h5J6MzFQEEBEiUruDpmRlY7uSwhhQoQiNi3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374482; c=relaxed/simple;
	bh=dhnVFAPJ4fT/RgwNedwviq8FMH2E+fgv4dE/Jpwp0RE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqGJLyl7Cu9DhDPTjJBQ/gSBGgGShR+6IAgHAJLt3hfucp2f5jYByv7OCykqApnewebYhUS0uI2WmMc++MtJLkOYTjmTUK6aWUKGa2W8jPISLZTovybEYBGdRc26rlonRuL5fVqHLxkwT6FA3QAjBp0y8HR3nvEVMZ0Hlaano3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RREk1pLM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F01DC113CD;
	Mon, 29 Apr 2024 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714374481;
	bh=dhnVFAPJ4fT/RgwNedwviq8FMH2E+fgv4dE/Jpwp0RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RREk1pLM2rcJznHtn2TcOa8A/z6rI7RUrbq1iiaC+EBM1P5Tgwvz9M7n5pfFA/aUB
	 wBcwPRB+D7Kqbac4LLKaZ9Gk7EwXa3DRC6DTx3tS8cRv3MFYETJt6xOjw+pUtAzy1D
	 glDvP/a6afUr0gKO33bBkOJ4igdjNcZat4k3M62HYk7dfXEoTfWhQ4kY3apgvZ2LJz
	 T5HpXs8IUjgEVKIjpAqnYdoED4QONbcvoa+v3r6+h6gZPV29/ooXrP1JTPj4FB8OyP
	 yRBkk+btOm+ubaQhBIJ/X3u/RgbveSV7XhvWSsVZ7uM75O8pFtjwANRE8Oy9m2VIjC
	 yxtkrCdnLg0iQ==
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Free strdup memory in veristat
Date: Mon, 29 Apr 2024 15:07:34 +0800
Message-Id: <ded44f8865cd7f337f52fc5fb0a5fbed7d6bd641.1714374022.git.tanggeliang@kylinos.cn>
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
duplicate of the string "input". Memory for the new string is obtained
with malloc(), and need to be freed with free().

This patch adds these missing "free(input)" in parse_stats() to avoid
memory leak in veristat.c.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 tools/testing/selftests/bpf/veristat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 244d4996e06e..b2854238d4a0 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -792,10 +792,13 @@ static int parse_stats(const char *stats_str, struct stat_specs *specs)
 
 	while ((next = strtok_r(state ? NULL : input, ",", &state))) {
 		err = parse_stat(next, specs);
-		if (err)
+		if (err) {
+			free(input);
 			return err;
+		}
 	}
 
+	free(input);
 	return 0;
 }
 
-- 
2.40.1


