Return-Path: <linux-kselftest+bounces-3114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8333B82F891
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C401F26730
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBA1350EA;
	Tue, 16 Jan 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7hIVzAM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EE825571;
	Tue, 16 Jan 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434737; cv=none; b=kgOpoU9dTRon91+G6HsZn2F1434ywGSMVS55tRJWgnlqG46Gj7d4uiKSpVs0JG8d+FiuSTx9TKQzyS1YmF5oX1fFagalqhangc8jAHKs+53HrYRmM3P11FDJkqG5YZd/6nT2LT2s/qaLFsbUkzErdprrA6HZsT2gute0Y3cnGcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434737; c=relaxed/simple;
	bh=05L/uzPbJ7wRSbnpKAg1qZm8m6Vca+gadFeO8ZPGfJM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ALMshZ702x7IxKz+ZwW61m5NBWzgDHShphjaroKjIkkAv9X7w0puTh9f029IbcSvC9Xudv0JfrD96hk2kEnwb6y+FGirfq1fpFVXfB2yUl3o+iUewoD69uRaWgEcv8bp/0HRIIbvev2wdKpscSpMz888TfrTosjZgB1LLK2Yqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7hIVzAM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F03C433A6;
	Tue, 16 Jan 2024 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434736;
	bh=05L/uzPbJ7wRSbnpKAg1qZm8m6Vca+gadFeO8ZPGfJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J7hIVzAMluV840uHW1cAxJfgTPuSAU5P0+dGRRXf55aP50T4qiJWRFS3r4EizMNiM
	 f+KtUEm5DSPlcAfIXjzXNGkmbVkQg/16fn4qvYXU7eb3yw8+VXsUPyDgFcwd+JuEuB
	 otVcYVuVTfIDbsifKTY50KuETSqP/GKqT2QPs2ZRlQjxbH9ttTsHqa+WCktZPTyImr
	 JGR7hAL20HEw4B0NEkJp68xvsguDhnrLw2DavjBoCdmbSbv1RjT82mzClWE3ZHsrm9
	 x1/ni2hjmVbKGZrHc0F22D+D29cePoXiCmPeuF/82QK/sGBZp40qo2+uAeqtr8PPXJ
	 tgR5fNvhKb6gw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 065/104] selftests/bpf: fix compiler warnings in RELEASE=1 mode
Date: Tue, 16 Jan 2024 14:46:31 -0500
Message-ID: <20240116194908.253437-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Andrii Nakryiko <andrii@kernel.org>

[ Upstream commit 62d9a969f4a95219c757831e9ad66cd4dd9edee5 ]

When compiling BPF selftests with RELEASE=1, we get two new
warnings, which are treated as errors. Fix them.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/r/20231212225343.1723081-1-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c        | 2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 655095810d4a..0ad98b6a8e6e 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1214,7 +1214,7 @@ static int cmp_join_stat(const struct verif_stats_join *s1,
 			 enum stat_id id, enum stat_variant var, bool asc)
 {
 	const char *str1 = NULL, *str2 = NULL;
-	double v1, v2;
+	double v1 = 0.0, v2 = 0.0;
 	int cmp = 0;
 
 	fetch_join_stat_value(s1, id, var, &str1, &v1);
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 613321eb84c1..adb77c1a6a74 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -68,7 +68,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
 		.frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE,
 		.flags = XDP_UMEM_UNALIGNED_CHUNK_FLAG,
 	};
-	__u32 idx;
+	__u32 idx = 0;
 	u64 addr;
 	int ret;
 	int i;
-- 
2.43.0


