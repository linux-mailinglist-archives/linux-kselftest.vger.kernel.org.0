Return-Path: <linux-kselftest+bounces-48288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0481CF81F9
	for <lists+linux-kselftest@lfdr.de>; Tue, 06 Jan 2026 12:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3948300150D
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jan 2026 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857B9329E61;
	Tue,  6 Jan 2026 11:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="kwBy0Gd6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7730C327C19;
	Tue,  6 Jan 2026 11:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767699905; cv=none; b=L/dftE8FlQZWfBY/1MTENxvRTPcI04/a3kLGW9EQHVq6dBncsHUb0xJ5F5M/iDyxN7Qt8QUjOrxJ43S4V790N42YVCV7MrjwThGkrNNrzjNWYG7jmDuIjRLhJQvrs4hWR3NOE1ENcfI3ztjDFYw+dPSDmhRwevZC01Aq7bcuG+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767699905; c=relaxed/simple;
	bh=zb9bN9rbR0iyuS4wR/xd9vkvuSwQkcd8PxRy3TtU9lM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=un1d3xHcc65Lzst4rYv8pxoQfjg4w/EXDZEdryG9rKBSOKGEw/ceHO0Qh4hZzPOTMHwap+A39oTZl5DRy8djDnp6TM+l362gaEI7XrwthCmZSDqRgv5/mnmORyWnfCqd/yF/zy8zJmwnxD9gR4/H62kBBbK3v8w4YZADRf58u1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=kwBy0Gd6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767699898;
	bh=zb9bN9rbR0iyuS4wR/xd9vkvuSwQkcd8PxRy3TtU9lM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kwBy0Gd607rp4Oi48SZZ7vvDiqOVw+Pk0rTD5wI/RVGgXFA5iPDNX9g32hcMNK5Ic
	 Ka7fpBml4v3YvTHFzGCjKJWqIJQW7hZRdqCeJcaOjOaMeazYkBwCsKi+pSpk1OIk1f
	 OOBKbL1IFokq9b6aUf3VkqKIUClecdBGu/o3z2GE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 06 Jan 2026 12:44:57 +0100
Subject: [PATCH 1/3] selftests/nolibc: try to read from stdin in readv_zero
 test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260106-nolibc-selftests-v1-1-f82101c2c505@weissschuh.net>
References: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
In-Reply-To: <20260106-nolibc-selftests-v1-0-f82101c2c505@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767699897; l=1589;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=zb9bN9rbR0iyuS4wR/xd9vkvuSwQkcd8PxRy3TtU9lM=;
 b=I3DNnS/PbkWw8AnzLdnqiurqAVrlw1AzcoJkEdXUan3QxKwxkRm6rxyGmR1aSe1glgIDQxCec
 1KjjUk5me+LDDIAtqQ+Xg2y6crtktkq0dzZM2Yos2iZJOMfMB/cYOiN
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When stdout is redirected to a file this test fails.
This happens when running through the kselftest runner since
commit d9e6269e3303 ("selftests/run_kselftest.sh: exit with
error if tests fail").

For consistency with other tests that read from a file descriptor,
switch to stdin over stdout. The tests are still brittle against
a redirected stdin, but at least they are now consistently so.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3986d55a6ff6..e83c1e7e2beb 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -1404,7 +1404,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
 		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
 		CASE_TEST(readv_badf);        EXPECT_SYSER(1, readv(-1, &iov_one, 1), -1, EBADF); break;
-		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(1, NULL, 0)); break;
+		CASE_TEST(readv_zero);        EXPECT_SYSZR(1, readv(0, NULL, 0)); break;
 		CASE_TEST(writev_badf);       EXPECT_SYSER(1, writev(-1, &iov_one, 1), -1, EBADF); break;
 		CASE_TEST(writev_zero);       EXPECT_SYSZR(1, writev(1, NULL, 0)); break;
 		CASE_TEST(ptrace);            EXPECT_SYSER(1, ptrace(PTRACE_CONT, getpid(), NULL, NULL), -1, ESRCH); break;

-- 
2.52.0


