Return-Path: <linux-kselftest+bounces-3102-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8812482F5B3
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 20:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FCA61C24039
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 19:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373621D691;
	Tue, 16 Jan 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZCDg3bl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601E1DA43;
	Tue, 16 Jan 2024 19:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434169; cv=none; b=B/Ps3pz0summ0pUQNBXvZP+SqvE/SMH+R6i7U3tNUjCW47QkT0abPbi6mOpWb3tTCIbrF3+SUzLdGgNU7YVjmTb98qUpFaIkPpcfSu6vLio5buE0nWgR3eXmrDNyHbEw2BvjwUbxGCszSRMAvHBhUshLO/ggg/JW3jIkc83wnUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434169; c=relaxed/simple;
	bh=DUzS/P1s6JUpApIOBTF2EByCClhf+yjqSxFOFy+6kU0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=AW4CNKkJDaDt2QGRcLTdYjYm44zFab6pbx+J3lEj6BcNaDsXYTANsHWAlIVWHVKnuQc21fgSSt2w2ZVwx2F8M7eBRGF/qO4JqV6KcL+elA+mGsAzgfsCxiGxZlMvWRbpapC6UJ13RNoluym/tbWGum1OeBGAd6BWC93PqRNpNMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZCDg3bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693ACC43394;
	Tue, 16 Jan 2024 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434168;
	bh=DUzS/P1s6JUpApIOBTF2EByCClhf+yjqSxFOFy+6kU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VZCDg3blVV8liEh5NQU/u+yQGqO6oCB/6FTKCl0iFobAdCMyr6Whh4u2dKIjyEQHr
	 BKyG7AJ+AFTx8EGnYqEj0SatXXM9xy0EXl3lvEVeTDkFIuLvL0VszDkQTdnPZYXtVi
	 DsByLHbwOOKBLbS7ZJO9hHdOks6j3wYAPEMccYjeyFaQ27y9750D2cbC/TrMmJlFV0
	 PA57aVz0HQTEtOB36niAN84/xLQvtH7e+1aZ2Kv3zVpPPE1zA3bppBdOwcR8p1VCg2
	 2VC1cp2dUYxJ/ZjFUW44OXjKaKI3fZwFvTdKs03c7zMEW22ssVk/Y9DG/mHs9BI86H
	 JkgAfFNnYqttw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	daniel@iogearbox.net,
	shuah@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@kernel.org,
	iii@linux.ibm.com,
	lorenz.bauer@isovalent.com,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 004/108] selftests/bpf: satisfy compiler by having explicit return in btf test
Date: Tue, 16 Jan 2024 14:38:30 -0500
Message-ID: <20240116194225.250921-4-sashal@kernel.org>
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

[ Upstream commit f4c7e887324f5776eef6e6e47a90e0ac8058a7a8 ]

Some compilers complain about get_pprint_mapv_size() not returning value
in some code paths. Fix with explicit return.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20231102033759.2541186-3-andrii@kernel.org
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 92d51f377fe5..8fb4a04fbbc0 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -5265,6 +5265,7 @@ static size_t get_pprint_mapv_size(enum pprint_mapv_kind_t mapv_kind)
 #endif
 
 	assert(0);
+	return 0;
 }
 
 static void set_pprint_mapv(enum pprint_mapv_kind_t mapv_kind,
-- 
2.43.0


