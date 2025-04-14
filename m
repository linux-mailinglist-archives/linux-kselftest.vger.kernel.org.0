Return-Path: <linux-kselftest+bounces-30716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD49A88378
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 15:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132305600F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Apr 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE912C1E1A;
	Mon, 14 Apr 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vN2ctiwI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A7227A119;
	Mon, 14 Apr 2025 13:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637426; cv=none; b=JY5FHarvA6xXUjtQBS3OGQRxbHhXJCzOEt/tO0zPym/wCjZu+s/9oBsLgAZpbmUMG2f7Xk69wAgPG+2J+vQjzHNKgv9ozeustoNqco7FMJpqlniQ/nbIMva7Wr0clFWkoQkxpaEzNnUvY2/pYtKLmPgGRqPhyjIk9Qwdhsh05hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637426; c=relaxed/simple;
	bh=xNnRKoQXxRlOLWE/k0GpBF6IO5Qx9pRJo8np+CxFsKM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m373dGfi2Ipd6p3ovj2qXZk/4nBw4xAu1NnFXhxVTHOrxLJ+lTK1KCq0Z0HxD1OwBVG2z3/87o+BYcZj4iJXH19wUiwxpMXCExtHQxRLWtg9lRYXgZA5tUugStyVUCvAVDjXeFRFSKObIAmC3b5x1yep0lRegOzZROYXkjrGQzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vN2ctiwI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B86C4CEEF;
	Mon, 14 Apr 2025 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637426;
	bh=xNnRKoQXxRlOLWE/k0GpBF6IO5Qx9pRJo8np+CxFsKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vN2ctiwIMyj4LFAnYVRaGKMaIUK19tFx33fk3wxNE8aeZ5dJtPO5gtEk2Vmcvqx5l
	 MT2CZaoHT0ER7uwmbj4oUhITIh71ZHa033wUKwfmPDHCsG8APjS1RZqTOTte8r7TAl
	 /iOUy6gpOJ/QeuaHcF1rormbiXyn20BS1MfxcY2FE6rmr1W5vYFt3Pl/ftArU46hUY
	 Agonywtqo/h4Dqw4dzCkswrch8xnax31G6zHbVgzl3P6CUUskJ6ut78lu7Bwd1fS5G
	 8Eot4MvRnp5e3YT8VXOBEmOtrj98zSvvnc0BWG9azD298TDDw8Ko3NHSEvbjFC4Q+V
	 nGNCYe73RPsaA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
	Yi Lai <yi1.lai@intel.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 14/24] selftests/mincore: Allow read-ahead pages to reach the end of the file
Date: Mon, 14 Apr 2025 09:29:47 -0400
Message-Id: <20250414132957.680250-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132957.680250-1-sashal@kernel.org>
References: <20250414132957.680250-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.87
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


