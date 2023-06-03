Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 648D2720D41
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 04:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235954AbjFCCQ0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 22:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236891AbjFCCQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 22:16:22 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF412E51;
        Fri,  2 Jun 2023 19:16:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9Ear+/SCRaCx+W+EfXa3zK3+7ueA6SEbXdMi8Wi8IxJ633NMeM5x8/VG++bj8XV9RHOud8LTrF0osXqbe7WJlqjOBK/btp1Yv21gV6blMYpR9W+h+JO8KxrcFycHbQRyHJjiBXqBwtYnSS//NYEHRB1aiu5re5KRupcpnEEYKv4AV9matG1CtbNAMOes062XaWfUZBADfBjfJAx6jOzoPFT+RzGN6yfNSFzhxan73HNC/HcVWnq3f0nE36Tzw/mUdwcsPFW8tQofXaJo/AXrIrtpTKivLqbQUBf4Z/UDRks61n1JgTGjYuZA2n6gI1QfY/Jg68S0WmWJdOWZBLy/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcAlKHerk5VQh9Nf0GPXXyu2H5vBR4yo7s+VUgObnFs=;
 b=hYcYjI7iDVb46vrq1eDMlu91xrFM2ZYsG07XVurPydy0gMBa/wXDs5T3oBRxBJhmyJ57aVWPbLPkA6FWqLEtRcmMO3lX3bTMEOvXibH0MyMxigBl3tFEDb06uRGktFcTfV+UIxT8svyGb5tdKLAk8Zuv8a/M+LZlzTjj1vtWBsiDJ/NmJ0ankNcnAG74W6UaGtq9VxofBpA76KfXgJlG9OurvE0AlSM1rMeNYaFGY8JXlri0mw1GXq/hmPv8PswbhgxJ8kMbVkqgz2wHNr4fnIEwS51bSlbCGwjn5tLuMDeLczuE8OlVNS0AjZteqhHgz4Cu5QrUa3XftiHBN+ywrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcAlKHerk5VQh9Nf0GPXXyu2H5vBR4yo7s+VUgObnFs=;
 b=YDp7oB/QOhbid8330Q6LrtGivQpWHJdS7P56IEXHRRjlZKG5b4cUTHyYTKElgN5/34JwKEEHhu0eKSmchjm+9Yo6TF2iBzHE/InheRe8UXVA7U9SgGqjIhZefvtPw/MiIUEF79tH4iT+9lCQ0JL9X3x8tvmjO2lNhuQplb39c+qPnbIS/Expq6brT8QA//Wq/nH92zDd3Kr6JgZO86OpKfFcfUOfUg0Icj3lvoCk/EVgu4Ehdi+SX0HpP4xFeUrcRzPDpnbqLoqZYwCtPmBjYvnl5GsjvRHZbJUVeM2F454Sugox7O/2Lp7UKysd3+viEiYsDHPGWpTbA6rIOHEUxQ==
Received: from DM6PR07CA0101.namprd07.prod.outlook.com (2603:10b6:5:337::34)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 02:16:17 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::71) by DM6PR07CA0101.outlook.office365.com
 (2603:10b6:5:337::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 02:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Sat, 3 Jun 2023 02:16:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 19:16:09 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 19:16:09 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 2 Jun 2023 19:16:09 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 10/11] selftests/mm: move uffd* routines from vm_util.c to uffd-common.c
Date:   Fri, 2 Jun 2023 19:15:57 -0700
Message-ID: <20230603021558.95299-11-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230603021558.95299-1-jhubbard@nvidia.com>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT053:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: f3e5c188-8562-4b8c-27fc-08db63d8839e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRH4Lziu2uTMYsjOoQoDaOxP3aJd7SS784tyb/lUqgHSXf/rpQEiTUeSiAPMNx3oUnrMvPlYR2x0LYwVgqKQh/bLD+mfW6aesDUpyasMF6YbBXJyLEN7gcVFYkXT+4D8MgP8GVc2hjdKwvE+GW3HylY+h+agrObp7diDLIEVj6iQm2WPItKo7ySygFc2e74NUDv+LJ19zhvT92on+srvDXk6IyLTmn0pgHWVnjuqCSUkt0wVF2Luo2RrDNul0S7LPhX5HfRcKwZumKqaIWRfifCreNkGB7FLb5fmG6TT1z39e72WUadmGLmASU63zvleoKU90UeJZfoOezktgNZjqwt4zW/Mazsqr4XOFSu49oAsJzhDgnKDuaoaO9UbCbMRYb+AVA9pdJNGeyHpqjAPrEV6r/p29jz1u5PT1mbJMYPfSMpFAdthsgfNtYbFr5sFQwYPRiT1U2h2uQMCobrIRqqoKps356hEj57amXaRN/b00oeRdardsrgNUsSd3TZ02117Q/oFgsZkchokOG/5ROgJIr3UKt5OfA29Lcds1J4GY5DhStoLOaSBLEgD6sBJsh1KdJto1cVjop12NUF4hNaIgecyhoadwkt5FR2xsb6UFY/QzFuSYuTfGGJQzuld9YOlrbxnN7efKu1B8lycK/2JKEF2fJIoAabGaicNrsBXi3NteodDyfxsVWxj67I+oGEn5pwHv4qXh1x/uvyHSGmp/9LXq74DWoa0Td2s45E=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199021)(46966006)(36840700001)(40470700004)(8676002)(8936002)(5660300002)(316002)(41300700001)(2906002)(4326008)(70206006)(70586007)(6916009)(54906003)(6666004)(7696005)(426003)(26005)(1076003)(336012)(186003)(36756003)(107886003)(2616005)(47076005)(83380400001)(36860700001)(7636003)(356005)(478600001)(82310400005)(40460700003)(82740400003)(40480700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 02:16:17.3760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e5c188-8562-4b8c-27fc-08db63d8839e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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

Move the uffd*() routines to their natural home. Note that
ksm_functional_tests.c also depend, intentionally (due to a recent
commit [1]), upon uffd-common.[ch].

Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
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
index 23af4633f0f4..a15572758954 100644
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
index 8aa543a3678b..f04f82771cd0 100644
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

