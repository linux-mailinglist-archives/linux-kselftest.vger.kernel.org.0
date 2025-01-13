Return-Path: <linux-kselftest+bounces-24305-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D8BA0ADEC
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 04:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7533A6D8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 03:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7471420DD;
	Mon, 13 Jan 2025 03:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E32UpTCP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1714373F
	for <linux-kselftest@vger.kernel.org>; Mon, 13 Jan 2025 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736739001; cv=none; b=quNFyVgCAg1r7hHDekmsrSBtid9gB0nlIFIQaxa1NxCwObBmZjeoNRU2QObu0S5/rN0h8cQBdQ7GfV6x8FgwoDCeXKV2xJW/G9/pvnztezvZrZeaVCnEeI0EmLg7Vsu7xRg6rOd7FhInjBdK0RMB22tIBqXdVhsx5IGUtABovYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736739001; c=relaxed/simple;
	bh=Ewqwnd+/ah5GoAMn2GSz9F/fLFjVA9NDczmnTpzbEiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j+NjStsjXJOc72/fqDVssueHqhBcJAAD/k2RxP1ec37ubtE5/G9x7p9AotSZbH9v64RpBwh2DlWaU68WY0RNwju/NfIewTq5j6mSLlp3q2ZHR7e6VICyjiwu+fYpjRwFlX1jaRCqiIHSmDk69rAsXZpyeuUdC3afY4T0dLyNn8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E32UpTCP; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736738989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X2PZYMbjMztwng0pKClJp1s6F1vIoijyzdKqPaUaI2U=;
	b=E32UpTCPu46MD9WsZcIMek+xEFu8oOaY8IFMzMtaWDaAB2ik9KdUinv06+zpnLPhLG/Pia
	z43BrmCLRffY7nVF13Ul0ebfdqvcFZPOsQGBqAYhZa01BNy7SAMNBCY3FYtuExaWHsO1pJ
	iA70r9qLG4gpWkBcMr6yJNa9joPHnW8=
From: Hao Ge <hao.ge@linux.dev>
To: akpm@linux-foundation.org,
	shuah@kernel.org
Cc: sj@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hao.ge@linux.dev,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH] selftests/mm/cow: Modify the incorrect checking parameters
Date: Mon, 13 Jan 2025 11:28:58 +0800
Message-Id: <20250113032858.63670-1-hao.ge@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

In the run_with_memfd_hugetlb function, some error handle
have passed incorrect parameters.
It should be "smem", but it was mistakenly written as "mem".

Let's fix it.

Fixes: baa489fabd01 ("selftests/vm: rename selftests/vm to selftests/mm")
Signed-off-by: Hao Ge <gehao@kylinos.cn>
---
 tools/testing/selftests/mm/cow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 32c6ccc2a6be..7a89680d1566 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1684,7 +1684,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 		goto close;
 	}
 	smem = mmap(NULL, hugetlbsize, PROT_READ, MAP_SHARED, fd, 0);
-	if (mem == MAP_FAILED) {
+	if (smem == MAP_FAILED) {
 		ksft_test_result_fail("mmap() failed\n");
 		goto munmap;
 	}
@@ -1696,7 +1696,7 @@ static void run_with_memfd_hugetlb(non_anon_test_fn fn, const char *desc,
 	fn(mem, smem, hugetlbsize);
 munmap:
 	munmap(mem, hugetlbsize);
-	if (mem != MAP_FAILED)
+	if (smem != MAP_FAILED)
 		munmap(smem, hugetlbsize);
 close:
 	close(fd);
-- 
2.25.1


