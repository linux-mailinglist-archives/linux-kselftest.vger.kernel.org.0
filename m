Return-Path: <linux-kselftest+bounces-29863-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF461A7310B
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 12:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6A573ABC9A
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Mar 2025 11:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C927213254;
	Thu, 27 Mar 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DZK3KoUp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D01F94A
	for <linux-kselftest@vger.kernel.org>; Thu, 27 Mar 2025 11:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743076136; cv=none; b=IOxXOh3pjyhY24wbBmKfa4cPswMrBGVgIIpMwmkD6P4RwsSy9jdmxl1Ol9wlmxwgfMb5lK56U3XRxy0y1s1R/9uOiO7H2/fyf38MMWFMkj7Ng+pDAP2ihNed4K/A31zDV94h5ezPeNuAEDl6YnhnPkY61TyZZWXuwuOH074vgpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743076136; c=relaxed/simple;
	bh=4S7F/d9su9LzjlR5dj2aL2tJ/+5xonvREXzs/WKvQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qcaVmTXvSZPuWD6NsIfoxcekMcvakvV95trNU/4AwwilZhIbDUl57Uzx5wIXggcCrkiNk5SD2/ZuzaK8n4GO5Q+f0JKOPcVCG37IbqnVx2a/5UOPukAtz0Bi7Sz+b5oI03Qe51yMUMXfEkWdgvKaj8gB5qCFi7kM6N62P7Z8zp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DZK3KoUp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743076129;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6Vn8ptHkbVBgcEoRHm+SOkDwT5dKBmy9TUadNzB62es=;
	b=DZK3KoUpyd85rWVzehtcnX7Iy+6PgO3wcOb67CaMjEEMcJbse9N5sWMTHsn0+LyzC6q4sg
	vfs1YK+baohbpPGeyxl11+Y1qyIEzjcOp3z1QZRFtXl/lWuqFD17Ba1vp+mQ3Sa/vCScbr
	AJWcjZolgxaa+9TkmVYvpcKWCyYRb4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-1XMZTIR4MwCv_GrpO4ut1w-1; Thu,
 27 Mar 2025 07:48:24 -0400
X-MC-Unique: 1XMZTIR4MwCv_GrpO4ut1w-1
X-Mimecast-MFC-AGG-ID: 1XMZTIR4MwCv_GrpO4ut1w_1743076103
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 44D97195E92A;
	Thu, 27 Mar 2025 11:48:23 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6F78319541A5;
	Thu, 27 Mar 2025 11:48:17 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	shuah@kernel.org
Cc: dev.jain@arm.com,
	anshuman.khandual@arm.com,
	kirill.shutemov@linux.intel.com
Subject: [PATCH] selftest/mm: va_high_addr_switch: add ppc64 support check
Date: Thu, 27 Mar 2025 19:48:13 +0800
Message-ID: <20250327114813.25980-1-liwang@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This patch adds PPC64 Radix MMU support to the va_high_addr_switch.sh
by introducing check_supported_ppc64(). The function verifies:

  - 5-level paging (PGTABLE_LEVELS >= 5) enable in kernel config
  - Radix MMU (required for PPC64 5-level translation)
  - HugePages availability (needed for some tests)

If any check fails, the test is skipped (ksft_skip). This ensures
compatibility with Power9/Power10 systems running in Radix MMU mode.

Avoid failures on 4-level paging system:

  # mmap(NULL, MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(LOW_ADDR, MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(HIGH_ADDR, MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(HIGH_ADDR, MAP_HUGETLB) again: 0xffffffffffffffff - FAILED
  # mmap(HIGH_ADDR, MAP_FIXED | MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(-1, MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(-1, MAP_HUGETLB) again: 0xffffffffffffffff - FAILED
  # mmap(ADDR_SWITCH_HINT - PAGE_SIZE, 2*HUGETLB_SIZE, MAP_HUGETLB): 0xffffffffffffffff - FAILED
  # mmap(ADDR_SWITCH_HINT , 2*HUGETLB_SIZE, MAP_FIXED | MAP_HUGETLB): 0xffffffffffffffff - FAILED

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../selftests/mm/va_high_addr_switch.sh       | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/testing/selftests/mm/va_high_addr_switch.sh b/tools/testing/selftests/mm/va_high_addr_switch.sh
index 2c725773cd79..1f92e8caceac 100755
--- a/tools/testing/selftests/mm/va_high_addr_switch.sh
+++ b/tools/testing/selftests/mm/va_high_addr_switch.sh
@@ -41,6 +41,31 @@ check_supported_x86_64()
 	fi
 }
 
+check_supported_ppc64()
+{
+	local config="/proc/config.gz"
+	[[ -f "${config}" ]] || config="/boot/config-$(uname -r)"
+	[[ -f "${config}" ]] || fail "Cannot find kernel config in /proc or /boot"
+
+	local pg_table_levels=$(gzip -dcfq "${config}" | grep PGTABLE_LEVELS | cut -d'=' -f 2)
+	if [[ "${pg_table_levels}" -lt 5 ]]; then
+		echo "$0: PGTABLE_LEVELS=${pg_table_levels}, must be >= 5 to run this test"
+		exit $ksft_skip
+	fi
+
+	local mmu_support=$(grep -m1 "mmu" /proc/cpuinfo | awk '{print $3}')
+	if [[ "$mmu_support" != "radix" ]]; then
+		echo "$0: System does not use Radix MMU, required for 5-level paging"
+		exit $ksft_skip
+	fi
+
+	local hugepages_total=$(awk '/HugePages_Total/ {print $2}' /proc/meminfo)
+	if [[ "${hugepages_total}" -eq 0 ]]; then
+		echo "$0: HugePages are not enabled, required for some tests"
+		exit $ksft_skip
+	fi
+}
+
 check_test_requirements()
 {
 	# The test supports x86_64 and powerpc64. We currently have no useful
@@ -50,6 +75,9 @@ check_test_requirements()
 		"x86_64")
 			check_supported_x86_64
 		;;
+		"ppc64le"|"ppc64")
+			check_supported_ppc64
+		;;
 		*)
 			return 0
 		;;
-- 
2.48.1


