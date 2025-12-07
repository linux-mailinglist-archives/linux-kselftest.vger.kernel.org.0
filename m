Return-Path: <linux-kselftest+bounces-47231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6ECAB445
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 13:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 754C430047A9
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 12:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4722E92A2;
	Sun,  7 Dec 2025 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HE85b2L0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD653B8D45
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Dec 2025 12:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110186; cv=none; b=RuBWEGN1OMKo/1aaINYPR1vdC+97rqjd8Fn+/05icSHEtSTkxBVtand0m2imaOKm3vehC5w85XMF0f35wLsgME16E3cQLUs7ckW0lxlwUt42gfBU8UYGxifqnXgizVhOOiFekfEXxKuxz5pzkW8NSbzNuDGCfM5Bp6rcR9TMDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110186; c=relaxed/simple;
	bh=J6JvUvIj67/D4hXVRM9kazekBECH7xYtVFJw1ZtCPV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J+e6fp3exzfLHcUHZc412Y2a3/fnb3fsNnYYhrS+PzKrDdhg7OpqYomHo1MsC4VGtteBgpqRwmVGY1YO2p872IHYXMgIrlj0FNHlU2rbNmv2W6OugUFrckoofk7ciQw4Su1lfpdRO5IpphNWF5G10ApK1JBVohkAXH3xRFDgL10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HE85b2L0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765110183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M/mYwJm8Tzi+N8+xqADIyDadr0oGOzUDKk5/OARZkss=;
	b=HE85b2L080lQ6lXjuRvtJxSZ5nP2l+n3ojaKSqal1a1mnemcKMUcA3Qao68Pm4RqrAMM1Y
	k4omWQ47UGfyxbkcb7z4c0Y6h3vsag1TPGe8Q/Rp2tWJfPJg8pPi8IEhUB91KRYnFjI+w5
	ZbLJZaN/2ZLo5v4oBYuFFynLaa7j3uk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-p6xBXNGZOMy9_ueZddf24A-1; Sun,
 07 Dec 2025 07:22:59 -0500
X-MC-Unique: p6xBXNGZOMy9_ueZddf24A-1
X-Mimecast-MFC-AGG-ID: p6xBXNGZOMy9_ueZddf24A_1765110177
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 394E9180028B;
	Sun,  7 Dec 2025 12:22:57 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 294FB196B8E2;
	Sun,  7 Dec 2025 12:22:50 +0000 (UTC)
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
Subject: [PATCH v1 2/3] selftests/mm: allocate 6 hugepages in va_high_addr_switch.sh
Date: Sun,  7 Dec 2025 20:22:38 +0800
Message-ID: <20251207122239.3228920-2-chuhu@redhat.com>
In-Reply-To: <20251207122239.3228920-1-chuhu@redhat.com>
References: <20251207122239.3228920-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

The va_high_addr_switch test requires 6 hugepages, not 5. If running the
test directly by: ./va_high_addr_switch.sh, the test will hit a mmap 'FAIL'
caused by not enough hugepages:
  ```
  mmap(addr_switch_hint - hugepagesize, 2*hugepagesize, MAP_HUGETLB): 0x7f330f800000 - OK
  mmap(addr_switch_hint , 2*hugepagesize, MAP_FIXED | MAP_HUGETLB): 0xffffffffffffffff - FAILED
  ```
The failure can't be hit if run the tests by running 'run_vmtests.sh -t
hugevm' because the nr_hugepages is set to 128 at the beginning of
run_vmtests.sh and va_high_addr_switch.sh skip the setup of nr_hugepages
because already enough.

CC: Luiz Capitulino <luizcap@redhat.com>
Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/va_high_addr_switch.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index f89fe078a8e6..98f3dfab62c5 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -111,8 +111,10 @@ setup_nr_hugepages()
 
 check_test_requirements
 save_nr_hugepages
-# 4 keep_mapped pages, and one for tmp usage
-setup_nr_hugepages 5
+# 5 keep_mapped hugepages are reserved in the first testings, and the last test
+# requires two hugepages, with one verlaped with the last second test, so one
+# extra, totally 6 hugepages
+setup_nr_hugepages 6
 ./va_high_addr_switch --run-hugetlb
 retcode=$?
 restore_nr_hugepages
-- 
2.49.0


