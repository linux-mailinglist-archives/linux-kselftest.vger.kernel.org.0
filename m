Return-Path: <linux-kselftest+bounces-23806-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78D9FF4FD
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 22:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9AE161898
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Jan 2025 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186081E3DE0;
	Wed,  1 Jan 2025 21:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWyWn14f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECAE1E3DD1;
	Wed,  1 Jan 2025 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735767339; cv=none; b=Pk+zRFNhYHI2r2ro1siDiHRJU4399vtbHeAMUVXDhmlHt8WHjMv16fc4J7d9Lw9KEOQ9ewg1Te8BsronloihDAobw5slMExvNF/4hINTbsLqTTJ42ra2a/tFcsURVjslo8NFxi/9sAxk9nyL64qdt77SE9qJc4/KQLplnE1B2pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735767339; c=relaxed/simple;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tMsfxEV3rx4/I5vIcQUtPMwL6lbQCfj1dBckl4Yd3R0ZScFjlaMRI1ebRocuPQy4E8tjyeejv6GOsyR4+46TJ61T6MH9GqfQihc0xp6rDDxQt6Qof4A19Xm54R2OtVYWj1G9vJ0w/gqy5uDZ7AWc4l1DMV5xzDd0cNdMj5GlxBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWyWn14f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9142CC4CECE;
	Wed,  1 Jan 2025 21:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735767338;
	bh=7oF79jn9lmm7ZWBErpi45JOkdTnxIklx6KgFpgZJtWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XWyWn14fdjnB2w1VbSxqAN4I+d9JuHVyTKwAfWOYcGDNVlIOtmmCs8uqjEjBvbtbg
	 pxQoeK47haNvLqPUq5ZFMFXPxSTlk1eGmONoLnq5O7N+QGcP0arkhwEWpG9lqqJnEw
	 4tE281qVcmuDnfD4M4FcUdSS1Q1cfDXzpCAMY8kEso7a8mQ4wuPBIrEUv3b5K2l+jY
	 2a7Mrb1D5ef2Mincx5y1fOJL3vlQ19cWKlwRNDZ67VsQbbZGfCt+lLb23oPC7CdCjp
	 QcYD8/KJWF8PMLnX9k4TaY+HWFDyB+pfS/+CY9mOSRQvrRvrOtb56QblUrbTdHrAg2
	 aK4RUFsuSbxSg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/7] selftests/damon/config: remove configs for DAMON debugfs interface selftests
Date: Wed,  1 Jan 2025 13:35:23 -0800
Message-Id: <20250101213527.74203-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250101213527.74203-1-sj@kernel.org>
References: <20250101213527.74203-1-sj@kernel.org>
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

