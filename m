Return-Path: <linux-kselftest+bounces-47781-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 019ADCD3B28
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 05:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B23CB30080EB
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FE2066F7;
	Sun, 21 Dec 2025 04:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TCSq7f8R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080DA2AEE1
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 04:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766289646; cv=none; b=Y7pauLmLod9si6UspdwYmfC55Mv1YYi6qGLbxHOgXKbdqgvNc7qMF5sqbAtJkVOGs9TOknqFJDQafLA0f+9Ijlt/8yxemOXieWd/ZqE9bxEyiJGP+na6w+8cKaUEvfy848Oo9DwphIG6ePSjHqi0wabsRInWgmQpOqlXshsQL5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766289646; c=relaxed/simple;
	bh=UViuCRCBHIOoztp0xoEZH1YUdfsQd9ztzpx0PlIfBM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvNIeB9kxx1YtbM9/QHcX7qsFVgCApdXKK4hDzYfUynZMqLutjocrbDws8abFdSjIBNZ05+dEB6Fdz03yg4vlHx6dcgjS3NS06YR/VwA5WUk3JytQP0XPuMBUSad0yO3GNfXzx/90kIboizi1Ent9D366V7U56kFNHZQRDfXCIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TCSq7f8R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766289642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RAc9nadAgGb85nuLMIBB9oG6AZY4Tcddq2LTgbVGuLQ=;
	b=TCSq7f8RA5LhLnYj1t4XcMjLcBO93aCzzVrysWofoyGiY8caWkGpF+bwxtPjeSDvmBwHq6
	GqmyjEJ90rvoc3WPS6uN8/x9djo1N3HRKQ6Q5G5tnYHvalsG5wWiMVaB+r5gT4yfTXOsKV
	b7vfHcj2i3RVacDYxBWpJEndCnqXBqU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-LbOpMcg3Of6UFM4JXCRlRA-1; Sat,
 20 Dec 2025 23:00:39 -0500
X-MC-Unique: LbOpMcg3Of6UFM4JXCRlRA-1
X-Mimecast-MFC-AGG-ID: LbOpMcg3Of6UFM4JXCRlRA_1766289637
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A442E1956080;
	Sun, 21 Dec 2025 04:00:36 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5507919560B4;
	Sun, 21 Dec 2025 04:00:29 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	shuah@kernel.org,
	linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	chuhu@redhat.com,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH v2 1/5] selftests/mm: fix va_high_addr_switch.sh return value
Date: Sun, 21 Dec 2025 12:00:21 +0800
Message-ID: <20251221040025.3159990-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Patch series "Fix va_high_addr_switch.sh test failure - again", v2.

The series address several issues exist for the va_high_addr_switch test:
1) the test return value is ignored in va_high_addr_switch.sh.
2) the va_high_addr_switch test requires 6 hugepages not 5.
3) the reurn value of the first test in va_high_addr_switch.c can be
   overridden by the second test.
4) the nr_hugepages setup in run_vmtests.sh for arm64 can be done in
   va_high_addr_switch.sh too.
5) update a comment for check_test_requirements.

Changes in v2:
 - shorten the comment in for hugepages setup in v1
 - add a new patch to fix the return value overridden issue in
   va_high_addr_switch.c
 - fix a code comment for check_test_requirements.
 - update the series summary in patch 1
 - add reviewed-by from Luiz Capitulino on patch 1 and patch 3

This patch: (of 5)

The return value should be return value of va_high_addr_switch, otherwise
a test failure would be silently ignored.

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
CC: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
Chunyu Hu (5):
  selftests/mm: fix va_high_addr_switch.sh return value
  selftests/mm: allocate 6 hugepages in va_high_addr_switch.sh
  selftests/mm: remove arm64 nr_hugepages setup for va_high_addr_switch
    test
  selftests/mm: va_high_addr_switch return fail when either test failed
  selftests/mm: fix comment for check_test_requirements

 tools/testing/selftests/mm/run_vmtests.sh         |  8 --------
 tools/testing/selftests/mm/va_high_addr_switch.c  | 10 +++++++---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 12 +++++++-----
 3 files changed, 14 insertions(+), 16 deletions(-)

According to the doc below, I don't add the cover letter, not sure if cover
letter is preferred, and if that's the case, the doc need an update.
https://www.ozlabs.org/~akpm/stuff/tpp.txt
---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index a7d4b02b21dd..f89fe078a8e6 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -114,4 +114,6 @@ save_nr_hugepages
 # 4 keep_mapped pages, and one for tmp usage
 setup_nr_hugepages 5
 ./va_high_addr_switch --run-hugetlb
+retcode=$?
 restore_nr_hugepages
+exit $retcode
-- 
2.49.0


