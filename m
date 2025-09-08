Return-Path: <linux-kselftest+bounces-40942-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D61D0B48E08
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 14:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB42D4405B7
	for <lists+linux-kselftest@lfdr.de>; Mon,  8 Sep 2025 12:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A8A305952;
	Mon,  8 Sep 2025 12:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bllL3NWk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D443054E4
	for <linux-kselftest@vger.kernel.org>; Mon,  8 Sep 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335693; cv=none; b=P9v4LoZfs+NGi/D+HjSV3/Fgpzjl2IrqBHruWMIAQOmKgLQi5vTRqYwbXMgL0u5kRpb+UegKyksaDQA3VPJnkjl6uEM0ti9vzCEeVYn573Fw1a3wpwlecnRMUyjX0s89W3323u5jz48wyEJ0tl2j8BwiyZt+J+GIyLl4joyOyi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335693; c=relaxed/simple;
	bh=N9mFsWGpGpgtUDJPGGCUdGpUVqBE6PiXz/A3ozR2vCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKbAgDgQRODkDKvVEJGd841rMoIkPaEC9Q8//b9bmP/KVfPktkVJ0dVq1cCi96eU+ZA0jdsdtyVkTVXieiJPXjK5n84e78qtmEsLiAXxiAyE10kBOYf6QQlk3O8esUHhQ2O6I6rHz10KdKl7d9BOe5JVWlEGSYm6n+gEkGcx0GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bllL3NWk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757335690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MLbuXhCNUOaSCGuiLR8P48OXtpr7aN3m52JVUEWvATc=;
	b=bllL3NWkWwCqYizNTaxbBt7at6TfEUQLzXVZt6R2vtiurwloc80RkfrR929mU+pclWFgBM
	IZLD9aHYcdV7yB8rnw4+xnxviKT/WyLALJGRW3sYpGcrLuGirPa5wDN8rMKA8vxG85REsl
	9fn3xhCVME8z8XCNXKQBZJRwX7CNuvg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-Mj6eiP3BNKKdj_HKkAuYjA-1; Mon,
 08 Sep 2025 08:48:05 -0400
X-MC-Unique: Mj6eiP3BNKKdj_HKkAuYjA-1
X-Mimecast-MFC-AGG-ID: Mj6eiP3BNKKdj_HKkAuYjA_1757335684
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05677180057E;
	Mon,  8 Sep 2025 12:48:04 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 31F3830001B5;
	Mon,  8 Sep 2025 12:47:57 +0000 (UTC)
From: Chunyu Hu <chuhu@redhat.com>
To: akpm@linux-foundation.org,
	david@redhat.com,
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
	chuhu@redhat.com
Subject: [PATCH v2 2/3] selftests/mm: alloc hugepages in va_high_addr_switch test
Date: Mon,  8 Sep 2025 20:47:38 +0800
Message-ID: <20250908124740.2946005-3-chuhu@redhat.com>
In-Reply-To: <20250908124740.2946005-2-chuhu@redhat.com>
References: <20250908124740.2946005-1-chuhu@redhat.com>
 <20250908124740.2946005-2-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Alloc hugepages in the test internally, so we don't fully rely on the
run_vmtests.sh. If run_vmtests.sh does that great, free hugepages is
enough for being used to run the test, leave it as it is, otherwise setup
the hugepages in the test.

Save the original nr_hugepages value and restore it after test finish, so
leave a stable test envronment.

Signed-off-by: Chunyu Hu <chuhu@redhat.com>
---
 .../selftests/mm/va_high_addr_switch.sh       | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index 325de53966b6..a7d4b02b21dd 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -9,6 +9,7 @@
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
+orig_nr_hugepages=0
 
 skip()
 {
@@ -76,5 +77,41 @@ check_test_requirements()
 	esac
 }
 
+save_nr_hugepages()
+{
+	orig_nr_hugepages=$(cat /proc/sys/vm/nr_hugepages)
+}
+
+restore_nr_hugepages()
+{
+	echo "$orig_nr_hugepages" > /proc/sys/vm/nr_hugepages
+}
+
+setup_nr_hugepages()
+{
+	local needpgs=$1
+	while read -r name size unit; do
+		if [ "$name" = "HugePages_Free:" ]; then
+			freepgs="$size"
+			break
+		fi
+	done < /proc/meminfo
+	if [ "$freepgs" -ge "$needpgs" ]; then
+		return
+	fi
+	local hpgs=$((orig_nr_hugepages + needpgs))
+	echo $hpgs > /proc/sys/vm/nr_hugepages
+
+	local nr_hugepgs=$(cat /proc/sys/vm/nr_hugepages)
+	if [ "$nr_hugepgs" != "$hpgs" ]; then
+		restore_nr_hugepages
+		skip "$0: no enough hugepages for testing"
+	fi
+}
+
 check_test_requirements
+save_nr_hugepages
+# 4 keep_mapped pages, and one for tmp usage
+setup_nr_hugepages 5
 ./va_high_addr_switch --run-hugetlb
+restore_nr_hugepages
-- 
2.49.0


