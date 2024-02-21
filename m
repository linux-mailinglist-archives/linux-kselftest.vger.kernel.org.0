Return-Path: <linux-kselftest+bounces-5242-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA585E9B1
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 22:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2E1C23BFF
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Feb 2024 21:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EC1292D1;
	Wed, 21 Feb 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJV8EzuQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62472128826;
	Wed, 21 Feb 2024 21:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708549928; cv=none; b=WjnWPiVAkEBovAAK0p0JlQDUEQOg1UdPnQHw9yyj5zev+k4sxyhhLTpS8jjl2xk5p00UX3n6uYYui94hZ5WvzijPyzQNCt0rqPMbkOw8Yl0nutc7DFK4PMvtlxC2CG6MssHaCSeRPeLJoQG1uDDGx6WlGOzlLYpibhQH87xZmsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708549928; c=relaxed/simple;
	bh=9BlBPgb/1NguIw/UJ8/Mo4WKvkfkqSFsJN+5E6ZcO44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSeEcR13INJqVdEMx92oUbfc656od8WUsQl+jKDEYJvl+Y5D8xdwrMrQESfaWSN3xpb2rEDDGweRoQIRrt2B3MrYb07xH4JeWC3Cq77B0Y03iXyoHNwhvYu+bQza356t9Ltwl/L8D+34u8+8szli/I8nFXWUZoAgW47N1QplaNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJV8EzuQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D0CC43390;
	Wed, 21 Feb 2024 21:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708549927;
	bh=9BlBPgb/1NguIw/UJ8/Mo4WKvkfkqSFsJN+5E6ZcO44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BJV8EzuQkcwQ0vqZ++PLUCIAcDW1cjYIPy0NBUhk330uJw3WU1BxY8SiPSfs0dhEM
	 g6nW+RnYhKk3v1H1xkH+IU5xtq4+PUdks3mSUFKh0xLpDZPg6rsJIZiaoyBIc8CwIX
	 8X4JKWbE6ZP8Qm7lfLU+/FE3A/iG8u+AGQbHcw7xQhw4Grvi34wqHWxQeWiWkTbsX1
	 ct+uKKIe7wk9b+y5Jzt8rmVJOCWT/63YqZC3HgLO8Oqt7eXZIotEStmstZvRyPOizC
	 26a5KWqsDj1YYRnZnG7ekVus4cjxGkDzxXw01570jMgHve4bCBFqNSAoEc52bS4fNt
	 WAd6fCsvfJJcw==
From: SeongJae Park <sj@kernel.org>
To: akpm@linux-foundation.org
Cc: vincenzo.mezzela@gmail.com,
	javier.carrasco.cruz@gmail.com,
	bernd.edlinger@hotmail.de,
	shuah@kernel.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/2] selftests: damon: add access_memory to .gitignore
Date: Wed, 21 Feb 2024 13:11:48 -0800
Message-Id: <20240221211148.46522-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240221211148.46522-1-sj@kernel.org>
References: <20240221211148.46522-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

This binary is missing in the .gitignore and stays as an untracked file.

Link: https://lore.kernel.org/r/20240214-damon_selftest_gitignore-v1-1-f517d0f9f783@gmail.com
Reported-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
Closes: https://lore.kernel.org/all/AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM/
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Singed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index d861701f0327..e65ef9d9cedc 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -2,3 +2,4 @@
 huge_count_read_write
 debugfs_target_ids_read_before_terminate_race
 debugfs_target_ids_pid_leak
+access_memory
-- 
2.39.2


