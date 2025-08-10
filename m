Return-Path: <linux-kselftest+bounces-38648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0407B1FCB3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 00:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23C6177983
	for <lists+linux-kselftest@lfdr.de>; Sun, 10 Aug 2025 22:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0AC2D6630;
	Sun, 10 Aug 2025 22:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EnwGdK3T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A9513D8A4
	for <linux-kselftest@vger.kernel.org>; Sun, 10 Aug 2025 22:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754864880; cv=none; b=VQLYjU+u0/7HCNawP2OIg38fu/KijcaHYw9THuJshYOeNGxWRtvWgfW8xKHX7RMzzscfFc7uahExxi6eSwvmhF1dkGUBYFWLi3T7xiOaoK1iwQsZgZMyaDdpoFfnYkp2HZ0+tdHZABOeP8tMjbIpJSAWt7lGh7hpFIbVrFzZHHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754864880; c=relaxed/simple;
	bh=wIrlwbnuKnkPYVbgME8ikSpgK/+Ts/tGiac5ibXXP7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsc/wbm1qqt0VZ85P3xtQ2uW8ixcl/Mp6XYDuoKdaGoxRiAVR8ZA2X0FDRnHcMDYrjpWr2DtIAS8/EoFCzfjAB0J9YpkddpwW/JO1EB6as3u9Gq7fAplqXYO2Nv8nuBkbsAKFPntnL5pz1N1bzhdciYpdkxEiUMVnQd7d9rugQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EnwGdK3T; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754864877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1q12txHUQPg0R1RQNr4oGF8yA7IDYgf7jDtfYZA93xY=;
	b=EnwGdK3T8n212w+m64grTMVLx1b360MuxibXCOiy/ykW1F1f0jg3odVeUUlWunUHoqYQeX
	oAqQJmuamDpWG7yoSegR9RngAGaAbzM2ykfoUI7mKeXT4VXC65H7zLB5fI6c/30HMR6Iac
	pPePz/tyH9Woi/d2MmlEDoZoAO175z8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-250-bYpDTESUNLapYYdAG5EtPQ-1; Sun,
 10 Aug 2025 18:27:53 -0400
X-MC-Unique: bYpDTESUNLapYYdAG5EtPQ-1
X-Mimecast-MFC-AGG-ID: bYpDTESUNLapYYdAG5EtPQ_1754864871
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CDDA419560AD;
	Sun, 10 Aug 2025 22:27:49 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.59])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B844D1800280;
	Sun, 10 Aug 2025 22:27:46 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Colin Ian King <colin.i.king@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] selftests/futex: Fix some futex_numa_mpol subtests
Date: Sun, 10 Aug 2025 18:27:42 -0400
Message-ID: <20250810222742.290485-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The "Memory out of range" subtest of futex_numa_mpol assumes that memory
access outside of the mmap'ed area is invalid. That may not be the case
depending on the actual memory layout of the test application. When
that subtest was run on an x86-64 system with latest upstream kernel,
the test passed as an error was returned from futex_wake(). On another
powerpc system, the same subtest failed because futex_wake() returned 0.

  Bail out! futex2_wake(64, 0x86) should fail, but didn't

Looking further into the passed subtest on x86-64, it was found that an
-EINVAL was returned instead of -EFAULT. The -EINVAL error was returned
because the node value test with FLAGS_NUMA set failed with a node value
of 0x7f7f. IOW, the futex memory was accessible and futex_wake() failed
because the supposed node number wasn't valid. If that memory location
happens to have a very small value (e.g. 0), the test will pass and no
error will be returned.

Since this subtest is non-deterministic, it is dropped unless we
explicitly set a guard page beyond the mmap region.

The other problematic test is the "Memory too small" test. The
futex_wake() function returns the -EINVAL error code because the given
futex address isn't 8-byte aligned, not because only 4 of the 8 bytes
are valid and the other 4 bytes are not. So proper name of this subtest
is changed to "Mis-aligned futex" to reflect the reality.

Fixes: 3163369407ba ("selftests/futex: Add futex_numa_mpol")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 tools/testing/selftests/futex/functional/futex_numa_mpol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932..802c15c82190 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -182,12 +182,10 @@ int main(int argc, char *argv[])
 	if (futex_numa->numa == FUTEX_NO_NODE)
 		ksft_exit_fail_msg("NUMA node is left uninitialized\n");
 
-	ksft_print_msg("Memory too small\n");
+	/* FUTEX2_NUMA futex must be 8-byte aligned */
+	ksft_print_msg("Mis-aligned futex\n");
 	test_futex(futex_ptr + mem_size - 4, 1);
 
-	ksft_print_msg("Memory out of range\n");
-	test_futex(futex_ptr + mem_size, 1);
-
 	futex_numa->numa = FUTEX_NO_NODE;
 	mprotect(futex_ptr, mem_size, PROT_READ);
 	ksft_print_msg("Memory, RO\n");
-- 
2.50.1


