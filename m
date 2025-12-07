Return-Path: <linux-kselftest+bounces-47230-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C93CAB442
	for <lists+linux-kselftest@lfdr.de>; Sun, 07 Dec 2025 13:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8314D3002FE1
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Dec 2025 12:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DE52609EE;
	Sun,  7 Dec 2025 12:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YASaU66R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4FA28726D
	for <linux-kselftest@vger.kernel.org>; Sun,  7 Dec 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765110178; cv=none; b=MoRncefBKzahXZYsOVYYpt55oidtjOOK/02Fkj1ySD9y9Jrxx/M8xoI0528s4ang9pwqxDD9+PyaKHWC630bkZVEf2JBsFFcKtDG6Aak/UmMdWfhPFo+1EyoNqjfg5Ihwx2Nu4/IHBHQIs9SFJmtmmB0KNNlmat4Yjdw4LZzJ2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765110178; c=relaxed/simple;
	bh=4LGk21c49xUtlH4TChNxt6K/DS6iayRUkNm5TGIZEWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=towRqjrx8xvY9z0IB+Ursd5lXz/KQYM1WUxpZQNWngZVB65S4lLR5biVo2EZOdXy5EoH6E5sP9+fWHanndftdLBqtBh9sFhKH+pQAVsBMVqJSyBa43COYs8dr3ic4Mfocw17s315dliCOqz3ExC82CYEXl8fuiEmpWZur0EfvcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YASaU66R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765110175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MfotD+6H+6J4066EQ9hPObSWyDy2leAU4Sg4BgVcv1k=;
	b=YASaU66RVEvMSth+i5o0PfQ4TPgXAHI2CdB4n+i7VK8DZuS6JWsUeFeS+3jR7U3bYRTVmJ
	VoqI9ElmBMWQZ3HdyNA3Pmcr/D1M03S/ygAr0E5SRqC3QFbbefWAQpgZ9i/kszGNhBjbU4
	5pXv+dzhOrHlYfoCOqGOtTNpj1MZMps=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-q4QCS8LQPhqac6KU_IASdg-1; Sun,
 07 Dec 2025 07:22:52 -0500
X-MC-Unique: q4QCS8LQPhqac6KU_IASdg-1
X-Mimecast-MFC-AGG-ID: q4QCS8LQPhqac6KU_IASdg_1765110170
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5FD2A1956052;
	Sun,  7 Dec 2025 12:22:50 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2DD6A1953986;
	Sun,  7 Dec 2025 12:22:43 +0000 (UTC)
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
Subject: [PATCH v1 1/3] selftests/mm: fix va_high_addr_switch.sh return value
Date: Sun,  7 Dec 2025 20:22:37 +0800
Message-ID: <20251207122239.3228920-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Patch series "Fix va_high_addr_switch.sh test failure - again", v1.

There are two issues exist for the  va_high_addr_switch test. One issue is
the test return value is ignored in va_high_addr_switch.sh. The second is
the va_high_addr_switch requires 6 hugepages but it requires 5.

Besides that, the nr_hugepages setup in run_vmtests.sh for arm64 can be
done in va_high_addr_switch.sh too.

This patch: (of 3)

The return value should be return value of va_high_addr_switch, otherwise
a test failure would be silently ignored.

Fixes: d9d957bd7b61 ("selftests/mm: alloc hugepages in va_high_addr_switch test")
CC: Luiz Capitulino <luizcap@redhat.com>
Signed-off-by: Chunyu Hu <chuhu@redhat.com>
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


