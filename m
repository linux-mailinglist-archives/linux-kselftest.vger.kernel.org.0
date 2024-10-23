Return-Path: <linux-kselftest+bounces-20459-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3819A9ACC93
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 16:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE1AA284F8C
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 14:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C131D0790;
	Wed, 23 Oct 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZf0PML8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862501D04A2;
	Wed, 23 Oct 2024 14:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729693847; cv=none; b=YEF4gziFfcaWW/OhCKICDyOw1lcRLYpOu8kl3BpJx+xlcLpEaN05zg1UFeqKEo8TCPetU5EG3P7SKG65oIMZNfyZPD4QNA2DKSm9cGMq5z0acALh4DSYHqZ+ZWNIUtiE1RvpnKKh7zX9DvdWfIFO43NKiFcPtF8bT6X8HxLdeuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729693847; c=relaxed/simple;
	bh=g+S1LBgUVa6rlTJhe1tTXZdwl/UXXR/T2NKcJRxZ11c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1YCaU726GZz0agmPWcDr2ilP+Adul7cHSAUmXVea31QCcfKN/T77PSpj7Q4sZtc9KubpYRnMog0+br0q3dR5aA68gyBXUBoQ+bNYeXxEOefoucdBRF4z9ALqJYD+PVLF5Nyc5FisbAM2cRlSZn4IqMayCfUFdxKqvnWBwRfOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZf0PML8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE74C4CEE5;
	Wed, 23 Oct 2024 14:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729693847;
	bh=g+S1LBgUVa6rlTJhe1tTXZdwl/UXXR/T2NKcJRxZ11c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iZf0PML8VCrKGud4TiDLWTwk4mW756VpqGXlcgYQsQsL9vjsfzqyQXzS9JwEPWuzz
	 IjVbofasDBiWDk56p318TWhRGpSIfOwhv83j/EM/wir62OavDixCdbqMTtJnJ9HorO
	 xfSzsDL20eM2bQcuAlceyzoX7ndWSEyn0Mc7sAE1llBkaVqunYNLVCG637UfZXvokc
	 gHm3EG9n2gpjEASYFBzOuzexu9hZJpJAsaz8gOiGazyCGolvvNpX7yDueXK/S2qiqD
	 i3NARvAUQTvk1u4Lny1sjCnfxRQ7EAc9v2UVyVhbVVYK2QDvgYNkUsJIqDrY3Zs1pN
	 hCyjWOKDWKM/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Tyrone Wu <wudevelops@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	shuah@kernel.org,
	jolsa@kernel.org,
	song@kernel.org,
	laoar.shao@gmail.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 20/30] selftests/bpf: Assert link info uprobe_multi count & path_size if unset
Date: Wed, 23 Oct 2024 10:29:45 -0400
Message-ID: <20241023143012.2980728-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023143012.2980728-1-sashal@kernel.org>
References: <20241023143012.2980728-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.5
Content-Transfer-Encoding: 8bit

From: Tyrone Wu <wudevelops@gmail.com>

[ Upstream commit b836cbdf3b81a4a22b3452186efa2e5105a77e10 ]

Add assertions in `bpf_link_info.uprobe_multi` test to verify that
`count` and `path_size` fields are correctly populated when the fields
are unset.

This tests a previous bug where the `path_size` field was not populated
when `path` and `path_size` were unset.

Signed-off-by: Tyrone Wu <wudevelops@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20241011000803.681190-2-wudevelops@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/fill_link_info.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index f3932941bbaaf..59ef57145b63c 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -417,6 +417,15 @@ verify_umulti_link_info(int fd, bool retprobe, __u64 *offsets,
 	if (!ASSERT_NEQ(err, -1, "readlink"))
 		return -1;
 
+	memset(&info, 0, sizeof(info));
+	err = bpf_link_get_info_by_fd(fd, &info, &len);
+	if (!ASSERT_OK(err, "bpf_link_get_info_by_fd"))
+		return -1;
+
+	ASSERT_EQ(info.uprobe_multi.count, 3, "info.uprobe_multi.count");
+	ASSERT_EQ(info.uprobe_multi.path_size, strlen(path) + 1,
+		  "info.uprobe_multi.path_size");
+
 	for (bit = 0; bit < 8; bit++) {
 		memset(&info, 0, sizeof(info));
 		info.uprobe_multi.path = ptr_to_u64(path_buf);
-- 
2.43.0


