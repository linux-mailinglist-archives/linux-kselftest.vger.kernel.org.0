Return-Path: <linux-kselftest+bounces-23812-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFAAD9FF687
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 08:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931D7161640
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Jan 2025 07:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2173192D68;
	Thu,  2 Jan 2025 07:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="dAv3IxLP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62585192B9D;
	Thu,  2 Jan 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735801207; cv=none; b=f/OPcwdWy4BvrHlWlWBD42Z0/5QntG1jrVigTgpP12RO+rGDHj2Z4rHJ9d+brF2DTSmQtO12rs8VOUvI7YZ4pUZ3Pg3wQs2486A1ywSJiHNH66TS95bBm54ZeZihGTmvwN5b3P++yKJSGEoDVjV3A40AFZxj2ebwbUais63ctqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735801207; c=relaxed/simple;
	bh=M6pe3NRJMBPWd4sKNKXmkEbGSsZUHE0cIoqWXtzPZXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EOGjj/XDG3MaH8BsVFUUkZpAQddaL30AH6uUNvbrVcw9F0NS9Ba9MA0rv3yN/ilZGjkfVi7140b2Xk8e+++pDoYPvmweghbv3pEQyUF7n+WhsW3pN3rOFhHx+bEWjkYUiv7bT0u0d8c0e4FmKyOY5vPrd7gbGGOgBBF6e9WCSf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=dAv3IxLP; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 4619D415AA;
	Thu,  2 Jan 2025 06:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1735800720;
	bh=3mMCLZdvj7eAZbKImM37p5iRcQxwGr5IZnsceE32Oc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=dAv3IxLPeZHXcsoJ05znkqTHVAR7UhYE7VHNQjMRN8DuyOGAiMDSpBEyIO0CftMAt
	 FHv5kGgKsgR0lIjG0mThMBeqTVcAq8eSjznuxIFv5cnfykG+AtidrX1HO4V9vMRRrG
	 SZ134nH+SgFrT/K6uBL5R/3DhcXghUPBPwZWNA3Vspyzb02NMD16iWpbkOuHjZOTJK
	 is9vZ8LzI74KGR6Suo1JEc6U0v0X9vkqylamkmXeJmaVQ2tKLCv0XOcJq6trHF5C+u
	 ZsLtGj5jAkUoYY1lIe2+ig0CkLl+ivQjhd70Eie4nMdcRM4DH+BasXbgpbxzHdJ+4R
	 QthbHX1Jt5gQg==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 1/1] selftests/memfd: skip hugetlbfs test if it's not supported
Date: Thu,  2 Jan 2025 14:48:07 +0800
Message-Id: <20250102064807.404607-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250102064807.404607-1-po-hsu.lin@canonical.com>
References: <20250102064807.404607-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle the case that hugetlbfs is not supported. To make it easier
for debugging.

On a system that does not support hugetlbfs. There will be no such
HugePages_Free entry in /proc/meminfo. And consequently freepgs will
be empty. The huge pages availability check will fail and the test
will be started anyway:
  ./run_hugetlbfs_test.sh: line 47: [: -lt: unary operator expected
  ./run_hugetlbfs_test.sh: line 60: 12577 Aborted
      (core dumped) ./memfd_test hugetlbfs
  Aborted (core dumped)

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
index fb633eeb0290..9bbd30ced9c5 100755
--- a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
+++ b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
@@ -19,10 +19,13 @@ while read name size unit; do
         fi
 done < /proc/meminfo
 
+if [ -z "$freepgs" ]; then
+	echo "hugetlbfs not supported, test skipped."
+	exit $ksft_skip
 #
 # If not enough free huge pages for test, attempt to increase
 #
-if [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
+elif [ -n "$freepgs" ] && [ $freepgs -lt $hpages_test ]; then
 	nr_hugepgs=`cat /proc/sys/vm/nr_hugepages`
 	hpages_needed=`expr $hpages_test - $freepgs`
 
-- 
2.34.1


