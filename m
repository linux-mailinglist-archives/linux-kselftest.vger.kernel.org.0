Return-Path: <linux-kselftest+bounces-33290-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5490DABB06E
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 16:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0839171F88
	for <lists+linux-kselftest@lfdr.de>; Sun, 18 May 2025 14:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60A21C4A24;
	Sun, 18 May 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDi1PwEe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF872CA6;
	Sun, 18 May 2025 14:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747577088; cv=none; b=tb6+SjR3sM5NvUHe7FXrBuQtWoaMChSzPKQfpVsOq11Wm8llvzWmfCO2cGFlZUNXQkekrrorMxUpXi2AspxdRqZr6PRH1/yA2TxOqmvt4B7iPmZHJUhgiazriiDCA9UA5vxcSp3orC3/nSFHor2qMxgrgJZmqZYBcKrOwKDdSKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747577088; c=relaxed/simple;
	bh=dvIHQWvFCf/Xw3NTmrSMM4jQbP3T5ZdNH0BF7nYqLzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uqG7GSe1zXgLZfogzhehaX8hOjH10ty87p+Ybil3927Tbf2/bJ1/AQ1t3ZeVeSRw2S6A8TeNQ8m+18bVDlidYI78ArRzfGrrAEqwLgvj39bksz465ZvaKKHz0X9EgjauZNiMB0WSL88MxqvRycvgQb0nGqP5lgSZLLEdIBCAo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDi1PwEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA9DDC4CEEB;
	Sun, 18 May 2025 14:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747577088;
	bh=dvIHQWvFCf/Xw3NTmrSMM4jQbP3T5ZdNH0BF7nYqLzc=;
	h=From:Date:Subject:To:Cc:From;
	b=VDi1PwEeQE1qtuntPvDmU7eIZIgSCqg7ON9GvwfX1UNG8gtUxrhCbeKt6y+BJKKex
	 jIKxcMy3sUrcVhj7JEzSQlYVzkBavap8XkN8ZnzdGcRHioAARsXEXGcKwz5YrRq1hS
	 M5pjUm/INpdd0w/5qk/tjKqe8LRyjShNYOe01Pp/W8h1Wrqm8hqyiaLcjzJxvkfVvy
	 PE8AzRCgHSxHIOyOlTkj/aODv5j8qAe8Q3TIRHeDO5Jzo0vsd9vjlKbtYmBq4K3gUB
	 111sxyBTwQdNgDJeSEKe+OXrG9osjPzSfGpyEhRayXB6JpLaTx6go1/DGeqZOjSa/V
	 PSGsVcBSoM46A==
From: Mark Brown <broonie@kernel.org>
Date: Sun, 18 May 2025 15:04:42 +0100
Subject: [PATCH] selftests/mm: Deduplicate second mmap() of 5*PAGE_SIZE at
 base
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-selftests-mm-map-fixed-noreplace-dup-v1-1-1a11a62c5e9f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPnoKWgC/xWNwQqDMBAFf0X23AWTNkX6K6WHaF7aBRNDVktB/
 PfG48Aws5OiCpQe3U4VX1FZcgNz6Wj6+PwGS2hMtreud+bGijmu0FU5JU6+cJQfAuelosx+Aoe
 tsHVxuMa7GcbRUkuVilM7N8/XcfwBhslvVHYAAAA=
X-Change-ID: 20250514-selftests-mm-map-fixed-noreplace-dup-25f83f618bb2
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1342; i=broonie@kernel.org;
 h=from:subject:message-id; bh=dvIHQWvFCf/Xw3NTmrSMM4jQbP3T5ZdNH0BF7nYqLzc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoKej9hjqg8jkgAQkO4cJwOPfI03xIYCUEAlqhS
 HWNOQ3LwoaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaCno/QAKCRAk1otyXVSH
 0I1EB/sEYsr1ilG59iZJ8+y3tuM9CLgqK1XPD2ou8/BPpVax6d1f4xfc3inAtYF8+ekrwLlpf9y
 Vs45r7LGkgXccp2lEde0PwiT4XCMpGJTJajnOoN5bxyMVwILcwPLTykFr47z5l4ECSz0Fewndzb
 iila9jKij0PaJpa8H5FMdcW3pjKTGmfB05l4v+Mw4RLR2kPAl0HkS613U1ACW6jWXOxEfgeVKE4
 BHhttNt+XepUbr19iHrX4E+tLz4KCoepqqrK2zP2G/agnsX6Of3LM3jJDTXTAWKFfyWoho70Bws
 FEtTy4EbJv0gzOC9VGojWO7/LNNP95Wnr6C6Agvb1Ol0vcL6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

The map_fixed_noreplace test does two blocks of test starting from a
mapping of 5 pages at the base address, logging a test result for each
initial mapping. These are logged with the same test name, causing test
automation software to see two reports for the same test in a single run.
Tweak the log message for the second one to deduplicate.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/mm/map_fixed_noreplace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/map_fixed_noreplace.c b/tools/testing/selftests/mm/map_fixed_noreplace.c
index d53de2486080..1e9980b8993c 100644
--- a/tools/testing/selftests/mm/map_fixed_noreplace.c
+++ b/tools/testing/selftests/mm/map_fixed_noreplace.c
@@ -96,7 +96,7 @@ int main(void)
 		ksft_exit_fail_msg("Error:1: mmap() succeeded when it shouldn't have\n");
 	}
 	ksft_print_msg("mmap() @ 0x%lx-0x%lx p=%p result=%m\n", addr, addr + size, p);
-	ksft_test_result_pass("mmap() 5*PAGE_SIZE at base\n");
+	ksft_test_result_pass("Second mmap() 5*PAGE_SIZE at base\n");
 
 	/*
 	 * Second mapping contained within first:

---
base-commit: 82f2b0b97b36ee3fcddf0f0780a9a0825d52fec3
change-id: 20250514-selftests-mm-map-fixed-noreplace-dup-25f83f618bb2

Best regards,
-- 
Mark Brown <broonie@kernel.org>


