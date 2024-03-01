Return-Path: <linux-kselftest+bounces-5693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 617D086DC1C
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 08:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1272F1F23ADE
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Mar 2024 07:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E2669952;
	Fri,  1 Mar 2024 07:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bEO7NERD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACFC69317
	for <linux-kselftest@vger.kernel.org>; Fri,  1 Mar 2024 07:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709278395; cv=none; b=IGJ3+ftg89u0p9uSFm5IIk8fNx/Dv2YRbVD/ocLezZzEHfoDHVoOyY5IdPP6aoxgUDoae44kUHmYPhA0UsZpX5EgiuTOVx9dl7/nBvfk1RpIFsD9nIlHjiVFJd7Qe54sHX2EEhUlnkclSIGjUyHLZjo+asxcBkSxpNXToC4cTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709278395; c=relaxed/simple;
	bh=TGr/BP1Gn8/hf8q8u7ex7+naL4H/IsFy7tgVN/sDdjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LFStCqSJZGD0P/hn4eGhs7UgfyDvA5ibXyHcLEyACfy3i17O7npQUeV72E3FoSZpoELQ9mi9tRxMaXYOSt20w7XWjsYpgUqkN7jc8w4KcHQ7z03E1K/KuQvEuS7LxEjChQy+nv3zJVen6hJY/6jvDpwJKcywGFIfSqfH3tGGpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bEO7NERD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709278392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jpPZGV9V3hnUBn8i3CL2d4Yea6dbDC8URH30r2BRw8I=;
	b=bEO7NERD6PbuuFfIoN5v8hXP+BIdtvQPvruTm3TafLc3E0qnk2gWO9qVZkuTINubviO4p7
	KQRNGg9spgbahYUQgw6r2YdfUgQCg/DLC1hYeLIcAWgOI0pqkqqTk3nHZ8b+/0bRd7H3Lm
	qhaFFAbue97iJy1ySoy7PkUV0l6dfX0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-ZhcNaUkXMtWY5njG5DSoPQ-1; Fri,
 01 Mar 2024 02:33:10 -0500
X-MC-Unique: ZhcNaUkXMtWY5njG5DSoPQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA6D228116B8;
	Fri,  1 Mar 2024 07:33:09 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.22.17.153])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7B1492BE2;
	Fri,  1 Mar 2024 07:33:09 +0000 (UTC)
From: Nico Pache <npache@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ben@decadent.org.uk,
	shuah@kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH] selftests/mm: Dont fail testsuite due to a lack of hugepages
Date: Fri,  1 Mar 2024 00:33:00 -0700
Message-ID: <20240301073300.287508-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On systems that have large core counts and large page sizes, but limited
memory, the userfaultfd test hugepage requirement is too large.

Exiting early due to missing one test's requirements is a rather aggressive
strategy, and prevents a lot of other tests from running. Remove the
early exit to prevent this.

Fixes: ee00479d6702 ("selftests: vm: Try harder to allocate huge pages")
Signed-off-by: Nico Pache <npache@redhat.com>
---
 tools/testing/selftests/mm/run_vmtests.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 246d53a5d7f28..727ea22ba408e 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -173,7 +173,6 @@ if [ -n "$freepgs" ] && [ -n "$hpgsize_KB" ]; then
 	if [ "$freepgs" -lt "$needpgs" ]; then
 		printf "Not enough huge pages available (%d < %d)\n" \
 		       "$freepgs" "$needpgs"
-		exit 1
 	fi
 else
 	echo "no hugetlbfs support in kernel?"
-- 
2.43.0


