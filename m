Return-Path: <linux-kselftest+bounces-23998-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB0EA043F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 16:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A9B18815B1
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2025 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610151F3D20;
	Tue,  7 Jan 2025 15:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xEDYdNyQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvC+B3rW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD91F239C;
	Tue,  7 Jan 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262900; cv=none; b=XzhJ3/ypkNV/80e98shoASDzaO6BHt0S1kgfw7iHlXFgW/U6nO4R6IKGjEYxd51tzTGXvI7+YZphMrvw9kdBF9Yxmtx0M2IyTMlMakBsoS7qeglVKaV9varOat1pFObnjCsOb2pzBN1Y/vPQ3cw7Z2Dm44JnTJwlh42cILyrplw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262900; c=relaxed/simple;
	bh=pkeSpzoPWHY8BsliSFSfbcQRoHvGqOoQKWjNi/5v8ic=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m/CKF42VP7LyFyk6sfYZ+LzSGFmqOw842TSOA6ECOm3NKo4QwIej8N81psELJe7yulsP1fmDT2OUdOiO+9vZBoNyktcnBfm7w+3HTuHIIsi6pUaAk7MOHGDdvMo41pxtJPetqqrg39+0chGC/k7cDNaEnv1+y+873z9WlrYwxy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xEDYdNyQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gvC+B3rW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736262894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MKnoaEM2eqbdSEIwek8NUSxcpZg/joWFCsMXcOwV8g=;
	b=xEDYdNyQFc4yS3PKefVEYJImsRrGchl4NLvK5u9X9qhOqvFW0G8VLPI78Rjead8YUOib7I
	Cp8hXOE3hKfi3pGrlSwNvoMarO0cVNB/hlBoNDcidAlhPn8zfBVPZMEumYRVKnJG6v7r69
	/sbhJ9/tTdWWjHy1D9E9Z67acXtbk0Vkpa6xtZwN35JQF/OTHRjXiLsszzHJrESKwQFzPA
	q+diYTEMhS26YnqaIgw+K0ZgP+4dbsJ68AuO0J5YuIfuwT7Qw6M6ifzRdko4FroLMVxl0n
	vGVrRQt5L8ZAA1neAL/nD3gHTMdNEWDFagGE5zt1sgYCSdOluSJtGwYEODQd4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736262894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8MKnoaEM2eqbdSEIwek8NUSxcpZg/joWFCsMXcOwV8g=;
	b=gvC+B3rWXyc/qxMwaqaSZObNNe1xvWwv3/CKHVVFYl2ybnP1xfbZCjm2f7hlL4ynU0ItoI
	bCMQv5vsaVEyHVBw==
Date: Tue, 07 Jan 2025 16:14:45 +0100
Subject: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
In-Reply-To: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Shuah Khan <shuah@kernel.org>, Dev Jain <dev.jain@arm.com>, 
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736262892; l=1691;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=pkeSpzoPWHY8BsliSFSfbcQRoHvGqOoQKWjNi/5v8ic=;
 b=Q7U4tGUxDzcEKeBChx8jtgkcq7Wge8kBvCoqMUZT2oi/Qti7jPY0onQ2kqHsunfb2jqdfU1hz
 sAu/mvAzojZDkvqBTlCrLkZo2WWSwciE2YoG/u+CTP/BwDRiXqX58/F
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

If not enough physical memory is available the kernel may fail mmap();
see __vm_enough_memory() and vm_commit_limit().
In that case the logic in validate_complete_va_space() does not make
sense and will even incorrectly fail.
Instead skip the test if no mmap() succeeded.

Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

---
The logic in __vm_enough_memory() seems weird.
It describes itself as "Check that a process has enough memory to
allocate a new virtual mapping", however it never checks the current
memory usage of the process.
So it only disallows large mappings. But many small mappings taking the
same amount of memory are allowed; and then even automatically merged
into one big mapping.
---
 tools/testing/selftests/mm/virtual_address_range.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
index 2a2b69e91950a37999f606847c9c8328d79890c2..d7bf8094d8bcd4bc96e2db4dc3fcb41968def859 100644
--- a/tools/testing/selftests/mm/virtual_address_range.c
+++ b/tools/testing/selftests/mm/virtual_address_range.c
@@ -178,6 +178,12 @@ int main(int argc, char *argv[])
 		validate_addr(ptr[i], 0);
 	}
 	lchunks = i;
+
+	if (!lchunks) {
+		ksft_test_result_skip("Not enough memory for a single chunk\n");
+		ksft_finished();
+	}
+
 	hptr = (char **) calloc(NR_CHUNKS_HIGH, sizeof(char *));
 	if (hptr == NULL) {
 		ksft_test_result_skip("Memory constraint not fulfilled\n");

-- 
2.47.1


