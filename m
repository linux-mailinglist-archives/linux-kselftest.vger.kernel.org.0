Return-Path: <linux-kselftest+bounces-34855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913CAD8078
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 03:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE1CD7AA873
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 01:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012091CAA7D;
	Fri, 13 Jun 2025 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FLUNqVcF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222A372636;
	Fri, 13 Jun 2025 01:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779377; cv=none; b=LLgiRYp4GBwlBaIu0w4AA69FsQwggBp3GuQaT+ttB0OwvAwzCXih1U4iBugAy+w1EqhxGEh9zF+JREb+RGzw5pIu8eND0oEVShTIVt4zXE3+2AJ186BO3yd+6JlAENkkmZ3RoIug+9nXMOo60ANeGHAiOKrRdMy+Z17yyzJdfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779377; c=relaxed/simple;
	bh=sM5LQBogj1YqlTMubTmqr5U56exFczyX2txJ3YgHXlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSafzb/10qR1ws578ibrYk6H/1Q3z1GUwKPXm2mDNz1Nhab4N7TET4X2MLgRu7sSMPsWkMMv22SphJt3ecggfVGOCVMcVHTUA4Dcl517eU1CF1t/3XWZYNKAh8uCBxWBGWjFAVM4uEql/osTfRfEjdbm9tLcbJYbhS1GZs1A6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FLUNqVcF; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749779372; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FtipOg0jR+RxbNWbEIuvLEIIRNhaeKYX+tgFf32YOWs=;
	b=FLUNqVcFNfKqNIFKCVkRB7ptQ88o5tBolUGApXZBb3q2lyBk/mOF6xiGGWpv1oCAFsgThCQ+Z2jFrRXHJU/Za4B04qHU1rGb8Nzbm7VZkj0LZJ5hnV01oijMeUZJqLnP1oTChPOdIi5eEdMm9MJJJfuhCdGVgteubWA96aAEQl8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdiYSol_1749779371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Jun 2025 09:49:31 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	shuah@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] selftests: mm: add shmem collapse as a default test item
Date: Fri, 13 Jun 2025 09:49:20 +0800
Message-ID: <a30b1529b399f2e649b5a05c3d352f41a68faeae.1749779183.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
References: <d8502fc50d0304c2afd27ced062b1d636b7a872e.1749779183.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we only test anonymous memory collapse by default. We should also
add shmem collapse as a default test item to catch issues that could break
the test cases.

Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Dev Jain <dev.jain@arm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
Changes from v1:
 - Collect reviewed and acked tags. Thanks.
---
 tools/testing/selftests/mm/run_vmtests.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/selftests/mm/run_vmtests.sh
index 33fc7fafa8f9..a38c984103ce 100755
--- a/tools/testing/selftests/mm/run_vmtests.sh
+++ b/tools/testing/selftests/mm/run_vmtests.sh
@@ -485,6 +485,10 @@ CATEGORY="thp" run_test ./khugepaged
 
 CATEGORY="thp" run_test ./khugepaged -s 2
 
+CATEGORY="thp" run_test ./khugepaged all:shmem
+
+CATEGORY="thp" run_test ./khugepaged -s 4 all:shmem
+
 CATEGORY="thp" run_test ./transhuge-stress -d 20
 
 # Try to create XFS if not provided
-- 
2.43.5


