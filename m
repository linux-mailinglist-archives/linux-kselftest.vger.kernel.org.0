Return-Path: <linux-kselftest+bounces-47232-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 61194CAB448
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 13:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 844EA3007CB1
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 12:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAA2EA154;
	Sun,  7 Dec 2025 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2mUyD4f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1049D2BE63A
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Dec 2025 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110195; cv=none; b=eScgYpDhC6tp3y5zKUbPxWtRRA6Aq0LdnJCFwM55oE10/ZpGqVSKxP2WFQv+Oe202g51hSg3nxazlehk4I4SNCxXJE/cjwFsZ8UJdlbCwoYdD4HXAiQhXevootF/vk2xMJ7Ks83UM7DgVWvYxJpqdirhNri0+O5n4OeS1zxojpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110195; c=relaxed/simple;
	bh=YCU2n2fPO9V3/Uv16i3KTBEMSTLLkIki3b0uvoKTBZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgGpVL9asNRWoTXdRg617TY66YVggm8DzN9huQslOsYknq2MMl2RqSrUZ0pRn9EP3yUNK4HBqxBEbiEf+GJtoezRwDqdi/fA7dlkS9xXwDZNXSBMJt72vtg8KZTVgd+7NiI+qARoAIltrItpFZs+F2cUwQyKF2YrnV/qb/v65hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2mUyD4f; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765110192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIr4yWg3c0IlqDRS8WOEFXdZ6WpgTutD/obofZ4OxYE=;
	b=Z2mUyD4fRdjBjW6Fw/+gl/dLYAPFVgAmICk4FutaQ94nncM1Fy3I8Ek3+oik2AF4nCSDj2
	7EULDxvmyVe4pLHrW29hpIgObP9ZWg/oB5HKRbXgykOtATGU8RYN7i+JcA0bDSAAZUsmp/
	ueTYEQxqrpIow0ARP7rwYzdtAZI3EBw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-384-o4fuTUTQP5WdsDxWjSF85A-1; Sun,
 07 Dec 2025 07:23:06 -0500
X-MC-Unique: o4fuTUTQP5WdsDxWjSF85A-1
X-Mimecast-MFC-AGG-ID: o4fuTUTQP5WdsDxWjSF85A_1765110184
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C1911800358;
	Sun,  7 Dec 2025 12:23:04 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2381C1953986;
	Sun,  7 Dec 2025 12:22:57 +0000 (UTC)
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
Subject: [PATCH v1 3/3] selftests/mm: remove arm64 nr_hugepages setup for va_high_addr_switch test
Date: Sun,  7 Dec 2025 20:22:39 +0800
Message-ID: <20251207122239.3228920-3-chuhu@redhat.com>
In-Reply-To: <20251207122239.3228920-2-chuhu@redhat.com>
References: <20251207122239.3228920-1-chuhu@redhat.com>
 <20251207122239.3228920-2-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

arm64 and x86_64 has the same nr_hugepages requriement for running the
va_high_addr_switch test. Since commit d9d957bd7b61 ("selftests/mm: alloc
hugepages in va_high_addr_switch test"), the setup can be done in
va_high_addr_switch.sh. So remove the duplicated setup.

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


