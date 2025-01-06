Return-Path: <linux-kselftest+bounces-23960-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC666A03069
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 20:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF2BA16480D
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Jan 2025 19:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E294C1DFE14;
	Mon,  6 Jan 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5gEYiRR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E591DFE0E;
	Mon,  6 Jan 2025 19:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736191192; cv=none; b=rH2i7+JGiPYLEIbUOKc6V5A9IZ3z4phc9pQxYXuM3AJ2jSc2rs6yQ9Znw4Tu0kTYhNjhIiB5LyBCqvhpUMiJAdAYM6hhP89zDvEe7fWwr2grDIWXJp1WNHTxt2k8NM/F8Nm1XTCOaHwC6JeQvG5/cUpQYbtN9dJhuURwyGJ3LFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736191192; c=relaxed/simple;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BhZURJiTHAav7sBMRRIhsIjaWMmfD+qvXMizBXF46LmdYRfeFRhuwKXu+EmlbW0KMKRRRnF4n8+2iFNwN2d/amF7YTcaeowYr6saTTk51n0HH/SfmVIr4pdqqXKh2M1ASpE61fDjQ/tmVX3pDuc9yJJCyenUw+gdQ1JX+KQM1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5gEYiRR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1997DC4CEE1;
	Mon,  6 Jan 2025 19:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736191192;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5gEYiRR50AapxrIyUe46ZHAkQwmmYmSvXhQYIo3JgUoANamQtzcHexk0FKRuXxqO
	 s3m+yEkp/4NZTxFor+sBVmhkMedgt8tEqBOGAYoU6JYq+Gt6QA4QCqJoqZ07SmJTQm
	 edPVvPSGaYIFFj7GqS1FNSE9Hl+icaicuI8d5T2gXeQ5hWnWSDvvw7X02wNIStOIyw
	 TkPoGYTL5P+zKNU8IlKYiMJzr0unybHlcbDcgbSJGey2CrsIrzHhuMLCjqW9dCuc9C
	 2g0nlyDwh9MwCMcBo1YAEeLjX7gISW4SwI4Wk8GcRUzba0GZgNV0FVsgzIvnWFiWX1
	 RxHDY8KccKmEQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/8] selftests/damon/config: remove configs for DAMON debugfs interface selftests
Date: Mon,  6 Jan 2025 11:19:37 -0800
Message-Id: <20250106191941.107070-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106191941.107070-1-sj@kernel.org>
References: <20250106191941.107070-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's time to remove DAMON debugfs interface, which has deprecated long
before in February 2023.  Read the cover letter of this patch series for
more details.

Remove configs for selftests of it from DAMON selftests config file, to
prevent unnecessary noises from the tests.

[1] https://lore.kernel.org/20230209192009.7885-1-sj@kernel.org

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/config | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/damon/config b/tools/testing/selftests/damon/config
index 0daf38974eb0..a68a9fead5dc 100644
--- a/tools/testing/selftests/damon/config
+++ b/tools/testing/selftests/damon/config
@@ -1,6 +1,5 @@
 CONFIG_DAMON=y
 CONFIG_DAMON_SYSFS=y
-CONFIG_DAMON_DBGFS=y
 CONFIG_DAMON_PADDR=y
 CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_RECLAIM=y
-- 
2.39.5

