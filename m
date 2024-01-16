Return-Path: <linux-kselftest+bounces-3107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B630382F693
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 21:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD60F1C20D1C
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8722441A90;
	Tue, 16 Jan 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GIoP1hMU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B2241778;
	Tue, 16 Jan 2024 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434340; cv=none; b=tIeihrqOzby3Hi1d8DVpH0UQVq2IJ8b2CZAXnIo0MgY3Iwkn23imZxHO/TNkgYP4FD9zftlOZjKJT8K3UbaqqIPteHppHxm+QFCxoE6gazobEdm74jHXy5Ub/Ulp73OvCIbStM93LvQ34/96gT/K5qi5ZlJ2ZnRGbhwdJw/dNww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434340; c=relaxed/simple;
	bh=UJjrdwgJB6dEm9810nwT8dcuk2xsksgaiGtYCpqtQOE=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=dKVHaAQJkD3OXrnqP5E4Ayf6dsq3VvpD6hCCzhFRf9I3RXt1ib3QACgyYyooDzFRjKN0JjdrJm91lFobU+QaPj4Yo0ZBeNC3gCSod3upqKlrb4VcGDWMmRtAkhvxTOX0lSCrIFDDRsbBHOaUMhokrve7iwHg0H+f11rlmn/Lc+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GIoP1hMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E40C433C7;
	Tue, 16 Jan 2024 19:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434340;
	bh=UJjrdwgJB6dEm9810nwT8dcuk2xsksgaiGtYCpqtQOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GIoP1hMUxml6v0ahcMDfLKO3hN7LQrZ8zh6tS52+ulHI9iZhPLU5idAAUqR0kJEgL
	 bEIDkWoC5bmqgFpolxmJGK4zIN3uDWDyU/GJKZ6Ugtz5bNuf0opApTZQxrRLpFUWj0
	 ukc2u69E1uDrHjlaox3TTR+4taY53QD1QELChXwuY9JudnTpde/Uhg7WDuTTlAT/J6
	 AWM66aFNxznqu5N47hSvc6GnAWZjar8e36awurX4XvwYJ1fWOH5JQ/N+WU0GBTVPoa
	 fCRTNqhhA3sJ6OmfsA17Z7cVHIDcyg5SeUfENaVHOktVqEVNVSUBUed2CiDZYS+3zZ
	 bbDoV3jvDswVg==
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
Subject: [PATCH AUTOSEL 6.7 066/108] selftests/bpf: fix compiler warnings in RELEASE=1 mode
Date: Tue, 16 Jan 2024 14:39:32 -0500
Message-ID: <20240116194225.250921-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
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
index c3ba40d0b9de..c5e7937d7f63 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -70,7 +70,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
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


