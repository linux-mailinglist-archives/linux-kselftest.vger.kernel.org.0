Return-Path: <linux-kselftest+bounces-341-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE4B7F2061
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 23:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27AFA2827F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB813A286;
	Mon, 20 Nov 2023 22:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTvskxP8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA8C97
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Nov 2023 14:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700519384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sLnO8asijaZzMbkZtLITBAUSz4awB/mJCNxRwi1gKfo=;
	b=PTvskxP8OOXIzfvM9IzHPBzNEiKlKgHOXukxK/5DMpFt63zE7OaXzUEjco7fbb2IhM8ZZE
	TQxZkC9ctihPupAvWIoKIGD7EJpFsRqZo0gu0WdmrI9HWZA4Q1llziouIIXX2VZqz/ATaS
	ls4nUnE8YRAuoNExMt3GUhMqfprnGPM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-KPLK3Vn-PRmzq_G3jfoP0Q-1; Mon, 20 Nov 2023 17:29:40 -0500
X-MC-Unique: KPLK3Vn-PRmzq_G3jfoP0Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CFCC85A58C;
	Mon, 20 Nov 2023 22:29:40 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.22.17.11])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A429F492BE0;
	Mon, 20 Nov 2023 22:29:39 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org
Cc: shuah@kernel.org,
	akpm@linux-foundation.org,
	jsavitz@redhat.com
Subject: [PATCH] selftests/mm: prevent duplicate runs caused by TEST_GEN_PROGS
Date: Mon, 20 Nov 2023 15:29:08 -0700
Message-ID: <20231120222908.28559-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

commit 05f1edac8009 ("selftests/mm: run all tests from run_vmtests.sh")
fixed the inconsistancy caused by tests being defined as TEST_GEN_PROGS.
This issue was leading to tests not being executed via run_vmtests.sh and
furthermore some tests running twice due to the kselftests wrapper also
executing them.

Fix the definition of two tests (soft-dirty and pagemap_ioctl)
that are still incorrectly defined.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 78dfec8bc676..dede0bcf97a3 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -60,7 +60,7 @@ TEST_GEN_FILES += mrelease_test
 TEST_GEN_FILES += mremap_dontunmap
 TEST_GEN_FILES += mremap_test
 TEST_GEN_FILES += on-fault-limit
-TEST_GEN_PROGS += pagemap_ioctl
+TEST_GEN_FILES += pagemap_ioctl
 TEST_GEN_FILES += thuge-gen
 TEST_GEN_FILES += transhuge-stress
 TEST_GEN_FILES += uffd-stress
@@ -72,7 +72,7 @@ TEST_GEN_FILES += mdwe_test
 TEST_GEN_FILES += hugetlb_fault_after_madv
 
 ifneq ($(ARCH),arm64)
-TEST_GEN_PROGS += soft-dirty
+TEST_GEN_FILES += soft-dirty
 endif
 
 ifeq ($(ARCH),x86_64)
-- 
2.41.0


