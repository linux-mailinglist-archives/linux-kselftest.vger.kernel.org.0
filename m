Return-Path: <linux-kselftest+bounces-14180-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD3A93B7CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 22:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C07921F24B4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 20:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAFD15FA76;
	Wed, 24 Jul 2024 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bN3yv4yn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD1F50284
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 20:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721851847; cv=none; b=RoAuJaBigj5/TvlCk318ebwZOadoSkQFT7LokVOv0sCt+j0uHOBJpK2tDrf/q1QxnU5akYpVUkrpa03xae8aeU4qz6fXLLC4/fKQNlyA87M6tfB77ceg9ccsCleYC2rk4K/xQHxAsuWB3BgbAxrMVcmYgte+m8esednGgRKL3xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721851847; c=relaxed/simple;
	bh=jLkje1TMaMcDFZ1isivzibz735Gz2ysL24u90U03b/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aA4yybKrJ7a44SwcO5KHomHOWDbl+ofeqEePZzpwgkepepBluzJYRo6Hy+44JrcrIFcUyLmJLuq8sxEEByy/kDGLBJsHSYx1ohf8Edb9HIWg65LBz9hq5fmU3ytKQq7j7QDZOUFef7elEIWO6eNgJ6zaAQPEZ9P1go7UTCme+5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bN3yv4yn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721851844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B+KGAhlehjnwvrQJqvaNqFPQndDkZyQpii0lamAO9o4=;
	b=bN3yv4yn/URPYRYQAhmFFgF2qSi5q8wqPdMcJ1gH6eBDIk/yu+R9G6+JlJ9fVZ+lDYI+VU
	QdMf9VnmFVUZuAX46WMQLT2Op9OeBSgXRa0vsDPzpcUpLDTw4fIU2JhAhzjUgtIx99/Jy3
	HaeDndRvTC1bKfhCsHmPxtIiu/TYXSs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-PNLVw-IsPMmHl6nqa7JusQ-1; Wed,
 24 Jul 2024 16:10:41 -0400
X-MC-Unique: PNLVw-IsPMmHl6nqa7JusQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32B2119560B3;
	Wed, 24 Jul 2024 20:10:39 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.33.84])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7BDEE1955D42;
	Wed, 24 Jul 2024 20:10:36 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Subject: [PATCH] selftests: mm: add s390 to ARCH check
Date: Wed, 24 Jul 2024 14:09:55 -0600
Message-ID: <20240724200955.14882-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When compiling with ARCH already set, the s390x ARCH is actually s390.
Add s390 to the ARCH check list, so we can properly build selftests for
s390.

Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 901e0d07765b..7b8a5def54a1 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -110,7 +110,7 @@ endif
 
 endif
 
-ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64))
+ifneq (,$(filter $(ARCH),arm64 ia64 mips64 parisc64 powerpc riscv64 s390x sparc64 x86_64 s390))
 TEST_GEN_FILES += va_high_addr_switch
 TEST_GEN_FILES += virtual_address_range
 TEST_GEN_FILES += write_to_hugetlbfs
-- 
2.45.2


