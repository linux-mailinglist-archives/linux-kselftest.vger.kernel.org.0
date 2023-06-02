Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A2871F804
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 03:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbjFBBfM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jun 2023 21:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjFBBev (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jun 2023 21:34:51 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6917E19D;
        Thu,  1 Jun 2023 18:34:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVGIelF0HBoANuS+V83zdySgkAEufBq7QwA6DfCQDQV6sl/ytDoyh0IpO0S1OCIBs5+JSOe/z1MNa1TUZHYDSahdyze8c+IUc3JRn3nEtVn85EkC0nFIRQojdADbiairKnG3WnFlXF/5uK3eMQSWAK0aOAnt9myhPRuFzfl8L3cAsTamA1ZrHEUBOFYT/0zd8WDzsZxHiLqvNoLGwSBEGfp1PM8VgdusQ8E0CBkk0eefOOtRwDb/1TqiJVjGAsCuoR7Bk0vICdoqM+Dg/PfkaBJM2nmIRL6NYdAZ1GOMrWZZyIu/2p+XAPEtw9d02zd0VPlDiMqkWCMKrx5BjCQzWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwVcUOMqZLM7gwVoTqIEsDPdbuxXOZ2xBf9Z8mxq38g=;
 b=mVLwpPC2O56O3oY/9K5QB7CSHyKp2ye8yK2dyUC4RNjzbbNaRmyM4mjzACTDh4OIpeKU+gNFhW5fncIGaMwbBZtMiVv5XRb+tWh/BnEUlkTjuTvXdRJT7mAv6QRyMqELs+BaHhEGYzvQnSysmiTxJyD+u7qS4ue3Z2f2l+pGhMk+qsxR8uz8I+eeloy887hw2uY+TAupn9eHH4x1/kB4aLsnUbB9S7nDELuuI+sMNeLo7jJcyd4Pp1rF1BXyUkR8Cr1Fnmr2D+GzBV6PeGdLrYRoWVI+giTTgjSy3rtbvoJoDo2kOLK/fwACe3HFwfufvvmsy4QAGSKemz1M3iKmrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BwVcUOMqZLM7gwVoTqIEsDPdbuxXOZ2xBf9Z8mxq38g=;
 b=fe57i6iGd6XvPpkO/bmz1ideUzkAHfnv+JaqkSTsG+PgydbXRupoksg8bIRMWrC1TgKRVtbj7nl0gUx8FQh56a2jo0g/keIixkF/6lnIubzMvqZ7W5SJioX0RN6bdue5s+kK+yTYpXiQBOOPmTNwgNpnaeOX7boIwmoVXz8E1F6T64L4SXoeldTvt4eXLYJplYpWRrENJk3ePjWOza8L6kD85aIkwpG/pWDQf/xhZpIh6tdLkP0nSOaU2cMcYUvD8pE8T9e9oWRvpNoxSn662Piwl4xSQC+ZeOBilk+U/R9YK5wtZ/qI0ZGwyd9Wr9z2srvq21y5DXBwwQatILIDew==
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by MW4PR12MB7382.namprd12.prod.outlook.com (2603:10b6:303:22b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Fri, 2 Jun
 2023 01:34:42 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a0:cafe::52) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Fri, 2 Jun 2023 01:34:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 01:34:42 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 1 Jun 2023
 18:34:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 1 Jun 2023
 18:34:24 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Thu, 1 Jun 2023 18:34:24 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
Date:   Thu, 1 Jun 2023 18:33:56 -0700
Message-ID: <20230602013358.900637-11-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT022:EE_|MW4PR12MB7382:EE_
X-MS-Office365-Filtering-Correlation-Id: 81779cc5-11c5-4d4a-a888-08db630989ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i/NO7+cycqIntGtCd6g7ClKH86vxHUe1GHVNbPuP+W5hzUjPhZd+aU3Dk+py9DVqGK/MV1kEvV06Zdp2eQIY8YJDbq4NqT5o5+tTo24PvBjBq4XjbqyuhHzabLHZUKskSzYdjNLtOpJTo3BRucmJG6GmWpvuWkMzCAWj+zjxmFS5t8r/jZcNxQR8R2ph87mYAPxwEXjZzhwhvibPYsC1FARAkpRmVj9c/EUW5FKNg8021/rwIx2d7hOagpppCyRvkxcaD88QCikqa/eC8jbQGbhxW34X3QxLvlUiwuAQ7UsJ/sWCwbJZZdR/3fWYLiW+YMqNmYlaICbxFFisHSHbHPzoFAvN1c4wndeBvbqV63ScV9XTnmdunlx2xn12cYzuMyuxgfEV/DwVpTfiPVn2x9z9PpOES53tKkBYHtCRaujWNU3p/pw1k/DW9n/OkX9s+DdQCtmaqzbKXZpWwTQBx1mFhfGx63rQ9TtmuPQNZH9bzeceuQIoEa6y4LELkbThQ8eYk0yqGKlywAOAaOXqTf+ZCf6kvKdx771LjHvhAF17kyw0YvmKrJPTTWFiFN3VZ8cwMAsibgoHfYS71pcISHDrjy+KN6ck1p9Hji/6ujDecLJC981VxCgyFTN/HUtf8aXtfie3iur9d7wz+XFhEdiRhGZ+0lPJhGZzIID5b2f47ZiRxxm40rpvdlMvxXoZWg7kiCRrr4TnFyqCAj4ALmiGUszp4vCm5usqckv5cwJ/fdgHfZDh08iqiOGyIl0R
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(83380400001)(40460700003)(36860700001)(86362001)(47076005)(316002)(7636003)(70206006)(70586007)(5660300002)(107886003)(4326008)(36756003)(6666004)(82310400005)(6916009)(40480700001)(8936002)(82740400003)(356005)(8676002)(7696005)(41300700001)(54906003)(2906002)(2616005)(26005)(186003)(426003)(478600001)(336012)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 01:34:42.2583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81779cc5-11c5-4d4a-a888-08db630989ff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7382
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is where they belong, and this makes it cleaner to apply a
follow-up fix to the uffd builds.

Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/Makefile           |   7 +-
 tools/testing/selftests/mm/hugepage-mremap.c  |   2 +-
 .../selftests/mm/ksm_functional_tests.c       |   2 +-
 tools/testing/selftests/mm/uffd-common.c      | 105 ++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h      |  12 +-
 tools/testing/selftests/mm/vm_util.c          | 104 -----------------
 tools/testing/selftests/mm/vm_util.h          |  10 --
 7 files changed, 122 insertions(+), 120 deletions(-)

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 473bf1811552..9bf3305b7dea 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -109,8 +109,11 @@ include ../lib.mk
 
 $(TEST_GEN_PROGS): vm_util.c
 
-$(OUTPUT)/uffd-stress: uffd-common.c
-$(OUTPUT)/uffd-unit-tests: uffd-common.c
+$(OUTPUT)/uffd-stress:          uffd-common.c
+$(OUTPUT)/uffd-unit-tests:      uffd-common.c
+$(OUTPUT)/hugepage-mremap:      uffd-common.c
+$(OUTPUT)/write_to_hugetlbfs:   uffd-common.c
+$(OUTPUT)/ksm_functional_tests: uffd-common.c
 
 ifeq ($(MACHINE),x86_64)
 BINARIES_32 := $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index cabd0084f57b..8158fe909f5e 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -24,7 +24,7 @@
 #include <sys/ioctl.h>
 #include <string.h>
 #include <stdbool.h>
-#include "vm_util.h"
+#include "uffd-common.h"
 
 #define DEFAULT_LENGTH_MB 10UL
 #define MB_TO_BYTES(x) (x * 1024 * 1024)
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 26853badae70..648188ad73fa 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -22,7 +22,7 @@
 #include <linux/userfaultfd.h>
 
 #include "../kselftest.h"
-#include "vm_util.h"
+#include "uffd-common.h"
 
 #define KiB 1024u
 #define MiB (1024 * KiB)
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 61c6250adf93..e1ad63668a05 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -6,6 +6,7 @@
  */
 
 #include "uffd-common.h"
+#include "vm_util.h"
 
 #define BASE_PMD_ADDR ((void *)(1UL << 30))
 
@@ -616,3 +617,107 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 {
 	return __copy_page(ufd, offset, false, wp);
 }
+
+/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls)
+{
+	struct uffdio_register uffdio_register = { 0 };
+	uint64_t mode = 0;
+	int ret = 0;
+
+	if (miss)
+		mode |= UFFDIO_REGISTER_MODE_MISSING;
+	if (wp)
+		mode |= UFFDIO_REGISTER_MODE_WP;
+	if (minor)
+		mode |= UFFDIO_REGISTER_MODE_MINOR;
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = mode;
+
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
+		ret = -errno;
+	else if (ioctls)
+		*ioctls = uffdio_register.ioctls;
+
+	return ret;
+}
+
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor)
+{
+	return uffd_register_with_ioctls(uffd, addr, len,
+					 miss, wp, minor, NULL);
+}
+
+int uffd_unregister(int uffd, void *addr, uint64_t len)
+{
+	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
+	int ret = 0;
+
+	if (ioctl(uffd, UFFDIO_UNREGISTER, &range) == -1)
+		ret = -errno;
+
+	return ret;
+}
+
+int uffd_open_dev(unsigned int flags)
+{
+	int fd, uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
+	close(fd);
+
+	return uffd;
+}
+
+int uffd_open_sys(unsigned int flags)
+{
+#ifdef __NR_userfaultfd
+	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
+}
+
+int uffd_open(unsigned int flags)
+{
+	int uffd = uffd_open_sys(flags);
+
+	if (uffd < 0)
+		uffd = uffd_open_dev(flags);
+
+	return uffd;
+}
+
+int uffd_get_features(uint64_t *features)
+{
+	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
+	/*
+	 * This should by default work in most kernels; the feature list
+	 * will be the same no matter what we pass in here.
+	 */
+	int fd = uffd_open(UFFD_USER_MODE_ONLY);
+
+	if (fd < 0)
+		/* Maybe the kernel is older than user-only mode? */
+		fd = uffd_open(0);
+
+	if (fd < 0)
+		return fd;
+
+	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
+		close(fd);
+		return -errno;
+	}
+
+	*features = uffdio_api.features;
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 6068f2346b86..a1cdb78c0762 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -19,8 +19,6 @@
 #include <signal.h>
 #include <poll.h>
 #include <string.h>
-#include <linux/mman.h>
-#include <sys/mman.h>
 #include <sys/syscall.h>
 #include <sys/ioctl.h>
 #include <sys/wait.h>
@@ -110,6 +108,16 @@ int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
 
+int uffd_register(int uffd, void *addr, uint64_t len,
+		  bool miss, bool wp, bool minor);
+int uffd_unregister(int uffd, void *addr, uint64_t len);
+int uffd_open_dev(unsigned int flags);
+int uffd_open_sys(unsigned int flags);
+int uffd_open(unsigned int flags);
+int uffd_get_features(uint64_t *features);
+int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
+			      bool miss, bool wp, bool minor, uint64_t *ioctls);
+
 #define TEST_ANON	1
 #define TEST_HUGETLB	2
 #define TEST_SHMEM	3
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 01296c17df02..c64a0134f83c 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -198,110 +198,6 @@ unsigned long default_huge_page_size(void)
 	return hps;
 }
 
-/* If `ioctls' non-NULL, the allowed ioctls will be returned into the var */
-int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
-			      bool miss, bool wp, bool minor, uint64_t *ioctls)
-{
-	struct uffdio_register uffdio_register = { 0 };
-	uint64_t mode = 0;
-	int ret = 0;
-
-	if (miss)
-		mode |= UFFDIO_REGISTER_MODE_MISSING;
-	if (wp)
-		mode |= UFFDIO_REGISTER_MODE_WP;
-	if (minor)
-		mode |= UFFDIO_REGISTER_MODE_MINOR;
-
-	uffdio_register.range.start = (unsigned long)addr;
-	uffdio_register.range.len = len;
-	uffdio_register.mode = mode;
-
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1)
-		ret = -errno;
-	else if (ioctls)
-		*ioctls = uffdio_register.ioctls;
-
-	return ret;
-}
-
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor)
-{
-	return uffd_register_with_ioctls(uffd, addr, len,
-					 miss, wp, minor, NULL);
-}
-
-int uffd_unregister(int uffd, void *addr, uint64_t len)
-{
-	struct uffdio_range range = { .start = (uintptr_t)addr, .len = len };
-	int ret = 0;
-
-	if (ioctl(uffd, UFFDIO_UNREGISTER, &range) == -1)
-		ret = -errno;
-
-	return ret;
-}
-
-int uffd_open_dev(unsigned int flags)
-{
-	int fd, uffd;
-
-	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
-	close(fd);
-
-	return uffd;
-}
-
-int uffd_open_sys(unsigned int flags)
-{
-#ifdef __NR_userfaultfd
-	return syscall(__NR_userfaultfd, flags);
-#else
-	return -1;
-#endif
-}
-
-int uffd_open(unsigned int flags)
-{
-	int uffd = uffd_open_sys(flags);
-
-	if (uffd < 0)
-		uffd = uffd_open_dev(flags);
-
-	return uffd;
-}
-
-int uffd_get_features(uint64_t *features)
-{
-	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
-	/*
-	 * This should by default work in most kernels; the feature list
-	 * will be the same no matter what we pass in here.
-	 */
-	int fd = uffd_open(UFFD_USER_MODE_ONLY);
-
-	if (fd < 0)
-		/* Maybe the kernel is older than user-only mode? */
-		fd = uffd_open(0);
-
-	if (fd < 0)
-		return fd;
-
-	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
-		close(fd);
-		return -errno;
-	}
-
-	*features = uffdio_api.features;
-	close(fd);
-
-	return 0;
-}
-
 unsigned int psize(void)
 {
 	if (!__page_size)
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 232ffeb5805c..7f5aac0ac680 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -33,16 +33,6 @@ bool check_huge_shmem(void *addr, int nr_hpages, uint64_t hpage_size);
 int64_t allocate_transhuge(void *ptr, int pagemap_fd);
 unsigned long default_huge_page_size(void);
 
-int uffd_register(int uffd, void *addr, uint64_t len,
-		  bool miss, bool wp, bool minor);
-int uffd_unregister(int uffd, void *addr, uint64_t len);
-int uffd_open_dev(unsigned int flags);
-int uffd_open_sys(unsigned int flags);
-int uffd_open(unsigned int flags);
-int uffd_get_features(uint64_t *features);
-int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
-			      bool miss, bool wp, bool minor, uint64_t *ioctls);
-
 /*
  * On ppc64 this will only work with radix 2M hugepage size
  */
-- 
2.40.1

