Return-Path: <linux-kselftest+bounces-20871-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E889A9B3E6F
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1BCFB21DA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620B91F9ED4;
	Mon, 28 Oct 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sluuL5Qf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354FB1F8918;
	Mon, 28 Oct 2024 23:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158266; cv=none; b=Y/13aaAQsltuP4GxPF3yMsD/NjAxm5UP2XnglhOXnUZnK75M63zKKgYCQeUYthi7m2GQch1eE9EffZaPRmLV1hOHoWRj8oDsfObvk69/cxp5ymaFkZnaDVtcUiBQyWFmc+7egdtob1IhnfwRAlsKSK7mAF7UeHl77Dt8TvvwqfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158266; c=relaxed/simple;
	bh=xqdqcFrJAdIHqtvRzPwvhIaKJQv8dhV6x+KleToE+hw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZeyjqBe229qajlo1Eu+SQ8lzMUP3GyR8OCS7uakB2amFcvnPmH6O8OXfdrw/u7p5dBxjXhuYUSWv88xUG7f15IcUJecnGzgkkDei2gWMMW6tXvpK5dB7GBkdqQO1vgBCpJ/C+VXcF1q7XlbG/Rp+6+AvKAYrxH0W8gvCBqVex0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sluuL5Qf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D40C4CEE7;
	Mon, 28 Oct 2024 23:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158266;
	bh=xqdqcFrJAdIHqtvRzPwvhIaKJQv8dhV6x+KleToE+hw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sluuL5Qfuq8491dKARsQzWeCtUedCMTYGcyGjvxjlRv5WlaXuUh/5QlkYD9CgXlCZ
	 QTkVugJy4hHJGuxbXmKHkCzJfV1HSeIeqOG+0I46pnvhANoxtU0z+fA91AQFi9bgAB
	 hA2br121iIiFL/DihHj36y0zePO0y/8ewlDotbHHO7pnjTKFOKfsWAVXDkgyhsZV1a
	 qP9y8Mrqymaf2EsCdsYQXPKdz8tf4JrFHyaHYLCl4w7tIwA5/UXkDwSrj7W48cX1Os
	 Z1aPgduqXj62mbPP60QuPCviIf/QpxLDJC4vlqTscmP7uvdlzFuEyEa1ZldsyviNi1
	 zrY+2zZWJhBzg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrew Paniakin <apanyaki@amazon.com>,
	SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] selftests/damon/huge_count_read_write: provide sufficiently large buffer for DEPRECATED file read
Date: Mon, 28 Oct 2024 16:30:53 -0700
Message-Id: <20241028233058.283381-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241028233058.283381-1-sj@kernel.org>
References: <20241028233058.283381-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Paniakin <apanyaki@amazon.com>

'huge_count_read_write' crashes with segmentation fault when reading
DEPRECATED file of DAMON debugfs interface.  This is not causing any
problem for users or other tests because the purpose of the test is just
ensuring the read is not causing kernel warning messages.  Nonetheless,
it makes the output unnecessarily noisy, and the DEPRECATED file is not
properly being tested.

It happens because the size of the content of the file is larger than
the size of the buffer for the read.  The file contains about 170
characters.  Increase the buffer size to 256 characters.

Fixes: b4a002889d24 ("selftests/damon: test debugfs file reads/writes with huge count")
Signed-off-by: Andrew Paniakin <apanyaki@amazon.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note that this fix has originally wrote[1] by Andrew for the downstream
version of the same test.  Because the downstream version is hosted on
GitHub, the original patch was posted via GitHub pull request, not to
the mailing list.

[1] https://github.com/damonitor/damon-tests/commit/fec6e1f4559a

 tools/testing/selftests/damon/huge_count_read_write.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index a6fe0689f88d..f3c199dc8eba 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -18,7 +18,7 @@
 void write_read_with_huge_count(char *file)
 {
 	int filedesc = open(file, O_RDWR);
-	char buf[25];
+	char buf[256];
 	int ret;
 
 	printf("%s %s\n", __func__, file);
-- 
2.39.5


