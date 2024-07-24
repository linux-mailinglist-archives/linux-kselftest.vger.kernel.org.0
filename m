Return-Path: <linux-kselftest+bounces-14184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CF93B899
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 23:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DA9B2453B
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2024 21:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0658813BAEE;
	Wed, 24 Jul 2024 21:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHs+PuLO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7B139D05
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2024 21:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857005; cv=none; b=T+1TD/pShNVgi2T1ApUhh0DkSOhUfxP2+lpnUJVxN9XNbAc0Airpqxzctoe56S2iJC+WHATChADiAP/2OLZdjzj1Y3oyRLM5wypl0z4L1Tzhq5OIWg7MG1sJiqVaqLrhkXLqeBXzYqLLCcjobI2kkirRZkCeD7/TNzhvTMluNcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857005; c=relaxed/simple;
	bh=UvVOjl0/12oevUPYIpBpoCCzogDnOIpBlZFeYgpr5qg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nyAOHrE7prgOoliT2SXJ/c+sNl+kTOpH/XsyZvTnRHrRMhXo+cLbEtS8/uAzjOWeNbW6xF6m6HEJZh2tzEP0PgeYG5xGIIyqvd2ACwnB/OJAkXvNQs1o+IXDlVdf8NxUhMaFSJPNk6xnu7Mw1AWqo8ThE43UbhSRHEVpJz7QUtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eHs+PuLO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721857002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2y89PNctEzPUc+h76+bt1W01RrcAjwiLgSR3Gn3y5wY=;
	b=eHs+PuLO0zwChi7Xab7cbbEYvjCHfmM0SNgHEfRDbH/8caZ3ZDi3R9WYR0rxQ97LCbOpFQ
	owW8j7aVsz6U198jl/flms9AgfIVWVBCuSIj90goHFztWQYY/tVe16ZtGpUkn33ZVlR83m
	KqsB015prRC2HhDUSRHSdMqhZTOMZsA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-JaGloUhgMZy4TKbLi4QpzA-1; Wed,
 24 Jul 2024 17:36:37 -0400
X-MC-Unique: JaGloUhgMZy4TKbLi4QpzA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB1301955D42;
	Wed, 24 Jul 2024 21:36:35 +0000 (UTC)
Received: from h1.redhat.com (unknown [10.22.33.84])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D210E1955F40;
	Wed, 24 Jul 2024 21:36:32 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Cc: akpm@linux-foundation.org,
	shuah@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	stable@kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] selftests: mm: add s390 to ARCH check
Date: Wed, 24 Jul 2024 15:35:17 -0600
Message-ID: <20240724213517.23918-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

commit 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
changed the env variable for the architecture from MACHINE to ARCH.

This is preventing 3 required TEST_GEN_FILES from being included when
cross compiling s390x and errors when trying to run the test suite.
This is due to the ARCH variable already being set and the arch folder
name being s390.

Add "s390" to the filtered list to cover this case and have the 3 files
included in the build.

Fixes: 0518dbe97fe6 ("selftests/mm: fix cross compilation with LLVM")
Cc: stable@kernel.org
Cc: Mark Brown <broonie@kernel.org>
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


