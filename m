Return-Path: <linux-kselftest+bounces-30714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78375A88314
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A995116733C
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DB229B787;
	Mon, 14 Apr 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1zVCqf4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F63029B781;
	Mon, 14 Apr 2025 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637371; cv=none; b=iUy5PDsXVvjvF7MG80DTlp44POtTLi7I8whwGnXlt7ulfca1dwTeJHGKv0erRwvIuqStVTTcAcZGEVh8Ja8ubtYqQm9lpACHb4XfqW/uZG7SQh5fsqzNUkvwIfpYRk/t05yFPnucYg4mTjd0Yy95IY5DZiB1knZ2iY12IwG9Io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637371; c=relaxed/simple;
	bh=xNnRKoQXxRlOLWE/k0GpBF6IO5Qx9pRJo8np+CxFsKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eNERBSiSbwGz1bzvZ+oJt/Emtq/i2oyX1OfSRi/vf+KwwAJ3j0fYnpYgXpj6cf8drrhxASeMq4FeB7gSTtLT24UalQ1u1bwjVM+hmRplraLoHsRbQMCpl33EAVMqBncWU5iWD6SJZCdFyhiU8LXYlyGbUXGmYlAh/1GmkvWivXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1zVCqf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E779C4CEE9;
	Mon, 14 Apr 2025 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637371;
	bh=xNnRKoQXxRlOLWE/k0GpBF6IO5Qx9pRJo8np+CxFsKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C1zVCqf47iN9PAf4h/PVrtGpY+jqrnVzx/ejeouLrVij6vZZ4HQRbbbFYI4miPAUu
	 y7vON7IP2t0pEWXAjMTYtYjRHlmVW9WBoZhnYocNDt8YckepPqb3AQ5+s58W9W5j6H
	 A2XzCPzwJqwJv0MWdx7efC8sfAGP9bts8BgKYqLsoOyZJfBGeGbTU64A3UGDEk401C
	 3VvXW9NgKb9ihufNkdS76tKQbxhnnCUCroagvJX3lrSvFI/esO4WMZE/LeOvPwFOpn
	 SiIasyIziX3SmTvdAjcztuGfxfc0GlJUYzqotPSehPm5n00Y9V7Ir2SxMMm76bQirr
	 jlQp8qtzzeqVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 18/30] selftests/mincore: Allow read-ahead pages to reach the end of the file
Date: Mon, 14 Apr 2025 09:28:35 -0400
Message-Id: <20250414132848.679855-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132848.679855-1-sashal@kernel.org>
References: <20250414132848.679855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.23
Content-Transfer-Encoding: 8bit

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

[ Upstream commit 197c1eaa7ba633a482ed7588eea6fd4aa57e08d4 ]

When running the mincore_selftest on a system with an XFS file system, it
failed the "check_file_mmap" test case due to the read-ahead pages reaching
the end of the file. The failure log is as below:

   RUN           global.check_file_mmap ...
  mincore_selftest.c:264:check_file_mmap:Expected i (1024) < vec_size (1024)
  mincore_selftest.c:265:check_file_mmap:Read-ahead pages reached the end of the file
  check_file_mmap: Test failed
           FAIL  global.check_file_mmap

This is because the read-ahead window size of the XFS file system on this
machine is 4 MB, which is larger than the size from the #PF address to the
end of the file. As a result, all the pages for this file are populated.

  blockdev --getra /dev/nvme0n1p5
    8192
  blockdev --getbsz /dev/nvme0n1p5
    512

This issue can be fixed by extending the current FILE_SIZE 4MB to a larger
number, but it will still fail if the read-ahead window size of the file
system is larger enough. Additionally, in the real world, read-ahead pages
reaching the end of the file can happen and is an expected behavior.
Therefore, allowing read-ahead pages to reach the end of the file is a
better choice for the "check_file_mmap" test case.

Link: https://lore.kernel.org/r/20250311080940.21413-1-qiuxu.zhuo@intel.com
Reported-by: Yi Lai <yi1.lai@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/mincore/mincore_selftest.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index e949a43a61450..efabfcbe0b498 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -261,9 +261,6 @@ TEST(check_file_mmap)
 		TH_LOG("No read-ahead pages found in memory");
 	}
 
-	EXPECT_LT(i, vec_size) {
-		TH_LOG("Read-ahead pages reached the end of the file");
-	}
 	/*
 	 * End of the readahead window. The rest of the pages shouldn't
 	 * be in memory.
-- 
2.39.5


