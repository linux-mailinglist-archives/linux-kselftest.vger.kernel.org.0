Return-Path: <linux-kselftest+bounces-41273-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE48B53FEC
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 03:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B121E1BC7192
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 01:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0097F16D4EF;
	Fri, 12 Sep 2025 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gnc1dqm9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B911970814
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757641050; cv=none; b=K47ddOA6p+SR4PkxWBqWtLfgQq27quHytrTyzkFRbDczKIrLfX/PhBAOmTyCkRVI+aPqSNSu10jDHqwj2olWJBjLe0hG11TxxWulyvxO7GRZYTRHlrT0P9VQ+wx7hCVPXPK59tLskt4ZQZVD+5YpsAoYxKxjbr+TpFikVpNuOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757641050; c=relaxed/simple;
	bh=6sK5HUW/H8rlwHZXXyX/JX8tlQSdTSHrFJ7BUqSDvDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cq2l4q05X4SncrWjc5DvXuH2lohbOWjMB+D1eu244SJgyGSqkvQFHiuDend0YfmSHyWbTaJiTVadyaHEXDfi2ZKAxAGx6E8ZKhEKY+4lsn0fqrAlhdsgkuQAo/cgVnowIhk051gyAiFpevJO3Cai3KSnz6klpXw88jZlByCxhVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gnc1dqm9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757641047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Kg4Tx3pIqmU1F8r3Q0oIkJJVosGS8R4dAci1tkAis/w=;
	b=Gnc1dqm9pYrqDKb6KFqczytRkYjK/2LG6rICMLFns3uZop61Qh3o+PYZex70cYzTfnQozI
	dEunqEKn9P9MuWya6NN5vCxv+15/L+NWpnlsSr6BnWgoPF0wdyEWeOfSzEdAdbkGHpefE8
	EXBQalxqvvOkOh01Jvvru3fo1T3gwD4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-XC26rgaoOHCdTMtdQ90mHA-1; Thu,
 11 Sep 2025 21:37:24 -0400
X-MC-Unique: XC26rgaoOHCdTMtdQ90mHA-1
X-Mimecast-MFC-AGG-ID: XC26rgaoOHCdTMtdQ90mHA_1757641042
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E5AB1800378;
	Fri, 12 Sep 2025 01:37:22 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F699180035E;
	Fri, 12 Sep 2025 01:37:15 +0000 (UTC)
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
Subject: [PATCH v3 0/3] Fix va_high_addr_switch.sh test failure
Date: Fri, 12 Sep 2025 09:37:08 +0800
Message-ID: <20250912013711.3002969-1-chuhu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

The three patches fix the va_high_addr_switch.sh test failure on x86_64.

Patch 1 fixes the hugepage setup issue that nr_hugepages is reset too
early in run_vmtests.sh and break the later va_high_addr_switch testing.

Patch 2 adds hugepage setup in va_high_addr_switch test, so that it can
still work if vm_runtests.sh changes the hugepage setup someday.

Patch 3 fixes the test failure caused by the hint addr align method change
in hugetlb_get_unmapped_area().

Changes in v3:
 - patch 1 adds the Acked-by from David
 - patch 3 changes the mmap hint addr to hugepage aligned from page aligned

Changes in v2:
 - patch 1 renames nr_hugepgs_origin to orig_nr_hugepgs
 - add a patch 2 to setup hugeapges in va_high_addr_switch test

Chunyu Hu (3):
  selftests/mm: fix hugepages cleanup too early
  selftests/mm: alloc hugepages in va_high_addr_switch test
  selftests/mm: fix va_high_addr_switch.sh failure on x86_64

 tools/testing/selftests/mm/run_vmtests.sh     |  9 ++++-
 .../selftests/mm/va_high_addr_switch.c        |  4 +-
 .../selftests/mm/va_high_addr_switch.sh       | 37 +++++++++++++++++++
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.49.0


