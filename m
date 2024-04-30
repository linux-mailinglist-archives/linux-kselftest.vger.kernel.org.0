Return-Path: <linux-kselftest+bounces-9138-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA5C8B76B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 15:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182F3280EA0
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2024 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2BF171662;
	Tue, 30 Apr 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lo+J2P6E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2396817164B
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2024 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482918; cv=none; b=fx+90UuUQcV6U8WBnZXSA6rdwUAZgc0TpZRc0iNlp22VzSV06G/1w+YtVOTrfYDrF1oUhlGoejmUkSsjsbW4bQUIQINHa5oCIcXXmr/GDChbRr1KYKfNZS2j+kJ0Qvo6kVewEpKrn8wIVd/tPmWMGOfdjRoLUn4lwpodk+Po1dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482918; c=relaxed/simple;
	bh=/W2LaG4ED1NPUdu4j9585eVlZDNybe47gsOfhZdMXCs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sagjB4WkmAgYgxiK8FfZlYKKnEadHVmBLyOMIS7jeH2AwPAp9AceMDwnMkyS8vReJRXTPIb+OTglsBtvnw3Yfe7VK03tUl4I4Yu2biKMUgPmOIYy3ePwdj/fADmKh2YpChUj8ymnvLeFbBSeZDNLsG+i+VQX6Pc9Neg4Q15Knv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lo+J2P6E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714482916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TvN/vaqOiemb3kV8gzUJWpBwRA+WO8kvTTbX/5Cqx18=;
	b=Lo+J2P6EOYGrNECDTm42BuLFZLQVEBfFNK3cInWBiy1sOM5w2zuK4JbCkErO8S5QZcd7yM
	VIYZOD21gU5yztX1wXsXd9EJRwjc6vZJvNqE+myQQ48AbIWbyvjzJ8bFVED7cmmeQ9T8a9
	C3cqNHpdPIL5V9LCoCYfjinxMG+1VUQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-OjnytbWMMWekGDOxme0w2g-1; Tue, 30 Apr 2024 09:15:12 -0400
X-MC-Unique: OjnytbWMMWekGDOxme0w2g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B6C4812C56;
	Tue, 30 Apr 2024 13:15:12 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.39.194.166])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EFBFC1121306;
	Tue, 30 Apr 2024 13:15:09 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1] selftests: mm: gup_longterm: test unsharing logic when R/O pinning
Date: Tue, 30 Apr 2024 15:15:08 +0200
Message-ID: <20240430131508.86924-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In our FOLL_LONGTERM tests, we prefault the page tables for the GUP-fast
test cases to be able to find a PTE and exercise the "longterm pinning
allowed" logic on the GUP-fast path where possible.

For now, we always prefault the page tables writable, resulting in PTEs
that are writable.

Let's cover more cases to also test if our unsharing logic works as
expected (and is able to make progress when there is nothing to unshare)
by mprotect'ing the range R/O when R/O-pinning, so we don't get PTEs
that are writable.

This change would have found an issue introduced by commit a12083d721d7
("mm/gup: handle hugepd for follow_page()"), whereby R/O pinning was not
able to make progress in all cases, because unsharing logic was not
provided with the VMA to decide at some point that long-term R/O pinning
a !anon page is fine.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Follow-up to [1].

Tested only on x86-64, to make sure the tests are still passing.

[1] https://lkml.kernel.org/r/20240428190151.201002-3-peterx@redhat.com

---
 tools/testing/selftests/mm/gup_longterm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index ad168d35b23b7..6c6d99c1dc765 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -118,15 +118,22 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		return;
 	}
 
-	/*
-	 * Fault in the page writable such that GUP-fast can eventually pin
-	 * it immediately.
-	 */
+	/* Fault in the page such that GUP-fast can pin it directly. */
 	memset(mem, 0, size);
 
 	switch (type) {
 	case TEST_TYPE_RO:
 	case TEST_TYPE_RO_FAST:
+		/*
+		 * Cover more cases regarding unsharing decisions when
+		 * long-term R/O pinning by mapping the page R/O.
+		 */
+		ret = mprotect(mem, size, PROT_READ);
+		if (ret) {
+			ksft_test_result_fail("mprotect() failed\n");
+			goto munmap;
+		}
+		/* FALLTHROUGH */
 	case TEST_TYPE_RW:
 	case TEST_TYPE_RW_FAST: {
 		struct pin_longterm_test args;
@@ -228,6 +235,7 @@ static void do_test(int fd, size_t size, enum test_type type, bool shared)
 		assert(false);
 	}
 
+munmap:
 	munmap(mem, size);
 }
 
-- 
2.44.0


