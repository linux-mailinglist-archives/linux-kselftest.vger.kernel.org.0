Return-Path: <linux-kselftest+bounces-20872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43C999B3E71
	for <lists+linux-kselftest@lfdr.de>; Tue, 29 Oct 2024 00:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EED1B1F231D3
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Oct 2024 23:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7B21FB8B4;
	Mon, 28 Oct 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpdF1Lj4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8E41FB89D;
	Mon, 28 Oct 2024 23:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730158267; cv=none; b=XsRRjfx3qGO6QcikIgLtMFb2Gwg21pErsObnqu/fJbKvCxYOpgZ7YggeYH1+1/PiCjyOgSuHyiuysmCuPUNDeCQQF8dgmYQE7x9hoc2Pc8L4gmCikSYjLHGjqLv/ubIFbf0xeE4FdvTkgdltGLliXh3BXEIEsjleZsNYsfwaV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730158267; c=relaxed/simple;
	bh=Tz1euKeLhAv1xTDlsiqA1CCZcickPPUxLivT0TlTmQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZDq9cd4ko8jDyKaFFl6i4FwtdOMvmS55tzyn/A+4sBhg2WF0MXOllS3mokyfUEPOcyBmxjSxlNqC9JSEv3exSqh62rlBfMYqkXQk0MOkjvmPFuLybGf69jUYBLxMRTyeF/u3do8u4Haq2ShjZv2t/EkVWQ5SLkqWjcriSs8GXLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpdF1Lj4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE927C4CECD;
	Mon, 28 Oct 2024 23:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730158267;
	bh=Tz1euKeLhAv1xTDlsiqA1CCZcickPPUxLivT0TlTmQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpdF1Lj4Ndp+hvLd7xi9O9qwck4CoX0revSy9cte2xCnHNUe1ndQq+k53JVl+N9YC
	 iQlsh0qgP669v1k3t8TSBWzqVSYNv2QzWjNvJQ/vQ3z3icD/VR/D7/9yZzfguO6rto
	 /XhEgkkgLP/zamw/HeUQw/zeABV0wx5MMgE1YDHNwX2jOMYOvmlzBt5mC8mksgifSv
	 LLT+9Ucj/K6atrw4EwHVMePDuA++CxdfUE16fVkFQ+IobkVW2mb2cXN32zIqR9ZwZM
	 qFKq1BcWI3Qb65I3v7qIP+fRrKPxOzOMyak2P/8C/PjS09SVeRekNydVtQtGsHnan1
	 se12KhQMPjOcQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] selftests/damon/huge_count_read_write: remove unnecessary debugging message
Date: Mon, 28 Oct 2024 16:30:54 -0700
Message-Id: <20241028233058.283381-3-sj@kernel.org>
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

The program prints expected errors from write/read of the files with
invalid huge count, for only debugging purpose.  It is only making the
output noisy.  Remove those.

Fixes: b4a002889d24 ("selftests/damon: test debugfs file reads/writes with huge count")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 tools/testing/selftests/damon/huge_count_read_write.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/damon/huge_count_read_write.c b/tools/testing/selftests/damon/huge_count_read_write.c
index f3c199dc8eba..53e69a669668 100644
--- a/tools/testing/selftests/damon/huge_count_read_write.c
+++ b/tools/testing/selftests/damon/huge_count_read_write.c
@@ -28,9 +28,7 @@ void write_read_with_huge_count(char *file)
 	}
 
 	write(filedesc, "", 0xfffffffful);
-	perror("after write: ");
 	ret = read(filedesc, buf, 0xfffffffful);
-	perror("after read: ");
 	close(filedesc);
 }
 
-- 
2.39.5


