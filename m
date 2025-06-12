Return-Path: <linux-kselftest+bounces-34786-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF89AD664F
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 05:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1DED7AAE79
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 Jun 2025 03:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EF71E378C;
	Thu, 12 Jun 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fT/qGoJW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09BD1C84A0;
	Thu, 12 Jun 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749700483; cv=none; b=t7T68fTvbjHJWSc9tjxAIu/yqSeAT1b7EpnYt0qglRyHCUQZYeRT6VwPPfhK7qmMbe2zDnkp6KeCzCzk09e38rcHwzGCHpgK5dRdSKOBgxIUl/mgkLAydL++oUDld5Lq9DN0EV70RhWro24tLg4wvI/QGow0affPIwqta7OcUOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749700483; c=relaxed/simple;
	bh=HQTfGqp644/DbTZgll0f9Q/q0wrRjl7DHrkiZw+A0EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eSo5vpjUa0rqgAtx6WoSyTI51uoUpFcAQO2lK7Plt20QF9zoHS5A+8r3+MpgfLJcUUxacFxyvcC8lBNeOMxRDsazQNqF4sc+IJVWtIdy9hRxwv0ycNa9apCV50BQTBqIfu1bz7v+a0+KMWy9D+uTpT4Q2lYLaeZij0bZ6fyow58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fT/qGoJW; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749700472; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4ygfr3n6kQcFBwqsi95CU3w1KA0GBnf9pQKhP3R6ySQ=;
	b=fT/qGoJWhd0bmaLtB1jfSpQIlJ3zx9cJBPlwZ71TlLTMzVbVkvENC4FXhYXjyJd36Ogvl9UtADdKT3S2EvtEny+fc19b/pNS+jFC0vD/PNpPorwrN0lmc+mdudcgw/Zn76Yz47hXs8XIyZqlBzwd5Ppkk/ckYV2kVQLDNr9pg4Q=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdfLUNM_1749700471 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Jun 2025 11:54:31 +0800
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
Subject: [PATCH 2/2] selftests: mm: add shmem collpase as a default test item
Date: Thu, 12 Jun 2025 11:54:21 +0800
Message-ID: <1352b17c513364164f6231ac32283cbb7093b603.1749697399.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
References: <c16d1d452aa876b449324d12df6465677158a711.1749697399.git.baolin.wang@linux.alibaba.com>
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

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
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


