Return-Path: <linux-kselftest+bounces-47783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38787CD3B37
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 05:01:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7749A300D48F
	for <lists+linux-kselftest@lfdr.de>; Sun, 21 Dec 2025 04:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3C6219A79;
	Sun, 21 Dec 2025 04:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i42Kym5c"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D1D1F4190
	for <linux-kselftest@vger.kernel.org>; Sun, 21 Dec 2025 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766289657; cv=none; b=ciqwe2rHYlomvfcq36YF3k5L3uyWOWBnb/fQY+ny7xQdDLgxkW1GZ/cerKYePOveABIOx7sdfp0S5PLi9kCv5gqo693Pm7R2WYqgZEBKDQAK/U09yjwKNNcbMHXfvxY0YHS03jthPo12JXYqS9Ju7AqW4dTIFjPkUEHSJEpPpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766289657; c=relaxed/simple;
	bh=CS64CQgygM7RdZBIYUWv2Cw2O2YWgcaKhWgAIYvm8K0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CF8YG5B8u2AonmiJ7cl+EfYtmISrJc2asAVxgANwnquZD6FBRR4J9HwfCq5Ta8dkmR8JIbWY3Hu8iH8KqriSeSQIQR5kibsIUgCjmcqMRtgukmdTIYJpY14zlV5dbcH53rIoA10PvOe+lfGaYaG7bhBWhfwRHOMWgcshIg1WJg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i42Kym5c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766289654;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OuTqlXVm7Xbaoka1UUOwUzXkQyIXMABwtwnWJk5BYmc=;
	b=i42Kym5c4I7u4MR1DzW6e4XoXzqGUj/+VYkQZTaP/TryxR9f8sXwQ3lOgADMyTr+g421dq
	y5P7ap9/HhnBaKDBNaI/KljyOZ8WwnqwexSNavrlZ6XVw5Luza530Su2g4XTGtXKXyg3d/
	pFvZkfnYaSeEXzluLzDxF/s72GZC7yo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-EzY6I9wwP4KywXe6B8qxeg-1; Sat,
 20 Dec 2025 23:00:51 -0500
X-MC-Unique: EzY6I9wwP4KywXe6B8qxeg-1
X-Mimecast-MFC-AGG-ID: EzY6I9wwP4KywXe6B8qxeg_1766289649
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6EBFD1956088;
	Sun, 21 Dec 2025 04:00:49 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA32019560B4;
	Sun, 21 Dec 2025 04:00:43 +0000 (UTC)
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
Subject: [PATCH v2 3/5] selftests/mm: remove arm64 nr_hugepages setup for va_high_addr_switch test
Date: Sun, 21 Dec 2025 12:00:23 +0800
Message-ID: <20251221040025.3159990-3-chuhu@redhat.com>
In-Reply-To: <20251221040025.3159990-2-chuhu@redhat.com>
References: <20251221040025.3159990-1-chuhu@redhat.com>
 <20251221040025.3159990-2-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

arm64 and x86_64 has the same nr_hugepages requriement for running the
va_high_addr_switch test. Since commit d9d957bd7b61 ("selftests/mm: alloc
hugepages in va_high_addr_switch test"), the setup can be done in
va_high_addr_switch.sh. So remove the duplicated setup.

Reviewed-by: Luiz Capitulino <luizcap@redhat.com>
CC: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index d9173f2312b7..2dadbfc6e535 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -412,15 +412,7 @@ if [ $VADDR64 -ne 0 ]; then
 	fi
 
 	# va high address boundary switch test
-	ARCH_ARM64="arm64"
-	prev_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
-	if [ "$ARCH" == "$ARCH_ARM64" ]; then
-		echo 6 > /proc/sys/vm/nr_hugepages
-	fi
 	CATEGORY="hugevm" run_test bash ./va_high_addr_switch.sh
-	if [ "$ARCH" == "$ARCH_ARM64" ]; then
-		echo $prev_nr_hugepages > /proc/sys/vm/nr_hugepages
-	fi
 fi # VADDR64
 
 # vmalloc stability smoke test
-- 
2.49.0


