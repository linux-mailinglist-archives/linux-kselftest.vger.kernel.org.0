Return-Path: <linux-kselftest+bounces-48474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E1B70D03B2C
	for <lists+linux-kselftest@lfdr.de>; Thu, 08 Jan 2026 16:14:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 828DC32C22D3
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Jan 2026 15:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748953033D7;
	Thu,  8 Jan 2026 09:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="AxXI2Drc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0153B3BF30B;
	Thu,  8 Jan 2026 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767863716; cv=none; b=loC7uaRDKD3ekMHQxKnFYca/Qqwun0MdYq/EO+ZR8z+Qnl+lM09U25GVK3sfT9q4oh4/k4L7yuy4ok6WUri5YQVmD6FIhyzaLjyWjAR+HZUIdQi864sw2geJ4OVlUNBdC/wEwkWZfEKTfClU8RL1swG7DbDLdrbUEEXcPhcLWEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767863716; c=relaxed/simple;
	bh=GrvmQPNNjyubjGAPChLZuS1LIBty/8AGFBvYXCFrPss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h/QAkwsbjJFIgBTCE38j/kTggCX9BvG7P0tpCHFtzY7WlhT7Qu75CqtgpElTDHEaNboWmSe61BHXtJpz+eJI9ubs3ikrrNGn09BmRYK+yZHQbSXm6ei7n2OeHh3Ir2zjnDdt1CzjB0WjU6yNs2zkvtRIM6obzVELrgTDCvSWSb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=AxXI2Drc; arc=none smtp.client-ip=185.125.188.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 48D1F409F0;
	Thu,  8 Jan 2026 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1767863220;
	bh=t2nEF9Md+jwIu8sobxZsbUxrKxqWsrp7AVFfJIDoUZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=AxXI2Drcf4D3KtkBBfEu/GGBmDNVMa2hGqlsbRb0Oz0+IXm3i5vr8ur8tECrmYqoQ
	 mjAt1YIO+eEaZkb95Iv6V/7ZQ9gftRw/DFIyLjxdU1S7xBrEfuOFie8Z3lGio0zJ9q
	 jdCDaAFk2qhBFGqV3iajWqh9lPaO7h9XPDyrVIIdU6gORQ+4/CmdiVvsIuWjMVxbUI
	 RfmCrotHQmJoDN7k4JT/E/0tU50U70E+xOzDXFw6AISzJDU6BitWuyY3MvO0UFU46D
	 UH16wE9ndjYwz/feJMpKp6bKj9cQ5Y65b681Yde0FiY1Yzx8ovPjJNcbVE/YCRsre4
	 X32/5je+fBNLY8e7fL15UZhm3fBzyxf8Dc9TdwFK+LewO2nbv2+zSDWPqz6V6VW9qN
	 IRMZqzOqnAZf+pmCGXQqfWIpF2PeHqkDf37gmhxICIhZID6bv+JbU5/02JcxvqZPgT
	 sRhXYXa2RifmQ1n0LyQ913e3mbMmcjcm1RBd0qTMwKUX1Rk4E6My8GzLoCNhlC9pdS
	 Ok3ed3B/7hNKwJ9AP50k0rG3ZaBfXCiqgHJflyNOxG8o8kVzmJfI1IBSWD4byHXHQG
	 xSBOHzoOcmqYqT1OFvmB4IYv4aKJh/Tfm/UhQwe3iaE8DDn+7hj4fKVlYIDyqzhej1
	 Yct/aHrf1jpsLeJHz/LAnqPA=
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: po-hsu.lin@canonical.com,
	shuah@kernel.org,
	mike.kravetz@oracle.com
Subject: [PATCH 1/1] selftests/memfd: fix return value override issue in run_hugetlbfs_test.sh
Date: Thu,  8 Jan 2026 17:06:06 +0800
Message-ID: <20260108090606.20660-2-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108090606.20660-1-po-hsu.lin@canonical.com>
References: <20260108090606.20660-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clean up task in the end of this script has successed, this
test will be considered as passed regardless the sub tests results.

$ sudo ./run_hugetlbfs_test.sh
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-EXEC
memfd-hugetlb:  Apply SEAL_EXEC
fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected
./run_hugetlbfs_test.sh: line 60: 16833 Aborted                 (core dumped) ./memfd_test hugetlbfs
opening: ./mnt/memfd
ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
8 != 0 = GET_SEALS(4)
Aborted (core dumped)
$ echo $?
0

Fix this by checking the return value of each sub-test.

With this patch, the return value of this test will be reflected
correctly and we can avoid a false-negative result:
$ sudo ./run_hugetlbfs_test.sh
memfd-hugetlb: CREATE
memfd-hugetlb: BASIC
memfd-hugetlb: SEAL-EXEC
memfd-hugetlb:	Apply SEAL_EXEC
fchmod(/memfd:kern_memfd_seal_exec (deleted), 00777) didn't fail as expected
./run_hugetlbfs_test.sh: line 68: 16688 Aborted                 (core dumped) ./memfd_test hugetlbfs
opening: ./mnt/memfd
ADD_SEALS(4, 0 -> 8) failed: Device or resource busy
8 != 0 = GET_SEALS(4)
Aborted (core dumped)
$ echo $?
134

Fixes: 8eecdd4d04 ("selftests: memfd: split regular and hugetlbfs tests")
Cc: stable@vger.kernel.org
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/memfd/run_hugetlbfs_test.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
index fb633eeb0290..48f701983604 100755
--- a/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
+++ b/tools/testing/selftests/memfd/run_hugetlbfs_test.sh
@@ -4,12 +4,21 @@
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
+ret=0
 #
 # To test memfd_create with hugetlbfs, there needs to be hpages_test
 # huge pages free.  Attempt to allocate enough pages to test.
 #
 hpages_test=8
 
+# set global exit status, but never reset nonzero one.
+check_err()
+{
+	if [ $ret -eq 0 ]; then
+		ret=$1
+	fi
+}
+
 #
 # Get count of free huge pages from /proc/meminfo
 #
@@ -58,7 +67,9 @@ fi
 # Run the hugetlbfs test
 #
 ./memfd_test hugetlbfs
+check_err $?
 ./run_fuse_test.sh hugetlbfs
+check_err $?
 
 #
 # Give back any huge pages allocated for the test
@@ -66,3 +77,4 @@ fi
 if [ -n "$nr_hugepgs" ]; then
 	echo $nr_hugepgs > /proc/sys/vm/nr_hugepages
 fi
+exit $ret
-- 
2.34.1


