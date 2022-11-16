Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3BD362CC10
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Nov 2022 22:04:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239078AbiKPVDH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 16 Nov 2022 16:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239248AbiKPVCI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 16 Nov 2022 16:02:08 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247586AEC7;
        Wed, 16 Nov 2022 13:01:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljepXMf1Y6yZS6v1TFblXyGuqU8MHAN2z9qVrpSwjM5fnlcQ1KYfIYGmDxmZqrGTPwtISFwwg14Lo7H9W88syEf9+a5QyxHNAqdaP3X/aEGx5CnUv5RHyQ+tyCHPQlB2tp91puil3dNcLCdlKwvH4jy+N0K8Bg+v47rdDBUM4ZHt26THUJn7nfTBl/x6JihWpYq/k5ZNZkqCgrcyufEW8oUmh5uC1oiTnmM6rFaSeqPVsUBW9rzLBbebol0k0EUMogPWs0XdhJ1E7k94kqTOtobVhTqdi/w+qDfY0eXDpIZm3BKN50v7rUxplJutH7m/32ajvSZ36wMZu2k9/3LBYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIMvnlVtfIEaUMfFV2RrbebC0GJ3uR1X+3o2sWc41lk=;
 b=B4g6UvpyFSihtv4/S7nlizYSe3XXAhKTY0HKj/ObGFqMWTGJ+BTwAY1Nt03qMqPOm7f+l1tJiOvPshb6bvSYM9pqKcUL8ddfHVp9UTLOjnjw3dltGdsrOhwdwOFQ0AZpXsr1Qhc80xvekKVXSKmQhRZNPiuqY2RitAevXITj4jRpwwArapVKXiZg3o2+R8PUeULvYxAdJSQqlwDXjhDj6811cWMwDKDy/PxMYZ14wKorWp3L1Vky6+wdh2k9lyqYaFleh1S0bQmvY1ec3+Pg8McHe+8T76D0tudsJT3jURnJOe6tGoFRirgiULXTHjcyQobkTf7lR5ghEMXzSsJ+Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIMvnlVtfIEaUMfFV2RrbebC0GJ3uR1X+3o2sWc41lk=;
 b=dDpoAImLGgjcZMuWtcWIMCW8MwD61AwygwUrAGBVXTk6vmHJxJDfXYlL1kyMOf26Nk8PRCnP4CIlGaRTFdUAGscpOZxqwOHgjOJyGN7rx3//RzbGEAv9miWy1SNN1F8b4pnJhQcft2jADvU504E7imWWgJX91K77m9KvYjtvvVvTjlSrQP1o6m1pZJOueQbV5gb1nrMZRv54czo2JrfICYy7Kk4WVGuDwlG34+y5HAp3kKQFtKvo7Di4NgH8hjF+xyTXudsMcvJRdDcmkOY7jqDkT5iNIGZKmAftpn57LOrMU9Ae4Is9By1Oe+38cVfJHd4ygzUuBnHn15aIeqJ1PQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4936.namprd12.prod.outlook.com (2603:10b6:a03:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 16 Nov
 2022 21:01:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 21:01:00 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: [PATCH v5 19/19] iommufd: Add a selftest
Date:   Wed, 16 Nov 2022 17:00:55 -0400
Message-Id: <19-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
In-Reply-To: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4936:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6dfb44-3bfd-4709-fd29-08dac815a87e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WuGkjW7/bN0pKg9kyEGCK7Z7afph7Hr4DYRgNWaEmYMd5hnY2rXuQyxmNZFKAjGOEVFCtyKLwVxlBJZqITeuvI4ygOwasm8At6JVpyMQro/Z1nfcIoEV/2TjK3N6e6/H4vsv/DurWaEr2xDnh4X5zOfCTjUY+5EN4u/4EMCMAEdcM+Pbh+G8qNzEcjcOi0z0vgvZ1IUt8i6LswsrV/nHrauBICFm47z1+IuZGzLoJ2X7NgQonN8ClQ0Ept/ndMGurBWAZuO8AwvLhbWwZpJBfsPNZq5U2pb7cHvMrhqsfZUXDc5lc1ELZfXJ6yLy4gwULGy4cCPBd03Hg4nHKhNvxOSODIVOrpxFCNrG67f5lZlnjMtoPCUcT6GDWjbNtDDK4ksSpVu/mq3nJOLACTv7hlZgD70SEQGhLEdApHGSWUgZ5kVfgxzP2yeh4D/kiNoOTWBOys9gyTf0A1P19ZDRMjrtp8SM/Fli+9iJZs202adoPeLuawSRIVFe1jFvvB+pm8haH5XJHAoxPSyAQAz2MHeO1OsuQvFhaukMLFRdtVKfvYVY64sCc1KIlUa/QWevJcuyXMSot4v0obA/lR6qw2/jMNKfC4Ys+pows86pDM1AXGfF0cop5fbAUzJHJhvRWKZcyWzBR/6DSoQub2xKC3HeXqfftOApX39YUQET27ycKxn+aBeQ7p5Mywsf9kv9l7WNMTlJLgKweNXOH0xTfc5YsdewjkOP0NMmcrh8DjBO5EggGajR5rFog3oM+o2q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(478600001)(36756003)(38100700002)(6486002)(921005)(83380400001)(86362001)(7416002)(8936002)(6666004)(7406005)(5660300002)(186003)(2906002)(30864003)(66476007)(4326008)(8676002)(66946007)(66556008)(110136005)(6506007)(2616005)(26005)(6512007)(316002)(54906003)(41300700001)(579004)(559001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ko2Lo2hnvXxUMacOyCtRBGLqOKq9YfVaEcv/AkMqDKD5CECPmH85DdgMuHmW?=
 =?us-ascii?Q?tNd5PZ484gjNXkwI+UfJHEXThP4+NZF29lUlh0YQDQbR7eyTgbLj6PfA43LL?=
 =?us-ascii?Q?3u3f6HpN4T1TIeYbWOHybM20ZgYNDubfT5hQeISIi5JKysAOqwNPjNGGWNJ6?=
 =?us-ascii?Q?6bN4wu8CQ292aEyqsjQsT/6G9U1Mt+6Rwfwz5EBeX8WAM+km62jTkSrrmzAh?=
 =?us-ascii?Q?FSvzArzhn/NF5uVMgaS3B44ZjadYOcMWN7nZqC1BDNi91vL24PGif99sapCG?=
 =?us-ascii?Q?tDxv+o1rXb68dxnfdvs7bpNKJXIQhL+OnQbntdANfq9cXl4Kna9qou9eIlZU?=
 =?us-ascii?Q?7f8SYMmPWnB5bld/8G9R3ZCC5Tq4skv3iix1sJVUL1HJzL49iwIkXzaQwm3a?=
 =?us-ascii?Q?ycMnhTYsfrIs7NyYtT9LN2cfs0UbnwX57EOUaz4zFL3XeH3b6QfImKi+Wyl/?=
 =?us-ascii?Q?mRC4vL/fI9s+6H9wZQ1LoPryDIfKqjHvCsRsBRViXdhPOIKBTjKO2rcktbzi?=
 =?us-ascii?Q?K0+PcLK+ta3W3XWFOiS0KcopXO1gfQb8mokbf7v3Pgy8TKly6TgS+NQ7lz6h?=
 =?us-ascii?Q?2gtxsXwQ3hyS7e61mnCoSO8k1X3CQxpDZ/fdeYadNm7+XpNX7Ott+qA/J6xd?=
 =?us-ascii?Q?fPLGtuCW3suckeyxw+xvzgufiV34CrT0fE8cGCY+DQf/KTtj1IEwDMVd3tMr?=
 =?us-ascii?Q?GBnWOoNwmWZAao5QpzxwCzWUx7KW1/0iPxJCPs9EWAvXp0KXdBrQjSHfU5Vk?=
 =?us-ascii?Q?/3cWLUPcIt5ArqpaLvC2kiObM7HVF6MG5wvSKvYttp+kTZxlWSW1c/bKbDCl?=
 =?us-ascii?Q?eU8euf3qAJqKT93uvD5Ax3NFue1ng+jWGeNBDb4/VH+C5z7Su0ktaPiW0tnH?=
 =?us-ascii?Q?EBPSuLiB0JvxefTO21r7q8ihlqbMOATQNeRBEAmXj2X96McwrGOvgk7IrbCc?=
 =?us-ascii?Q?+vLnFNtWPT6LtTCeBWzQys9aSxe4G+6P1s/fBCkcvvfd/r6gNpa7I0WdC7Kr?=
 =?us-ascii?Q?No5O/9g1zGhJAsGPVufPpInFqyaIAbCGbFfjK15eOkGjxQ5zKlgyTP19V4WD?=
 =?us-ascii?Q?7PMgMQ5Ytk2AUpB0mryvinCvMjJCgo5WiJlvRF4K8aqsX9alzW5/oMqIO8M3?=
 =?us-ascii?Q?ggE1tLxilIbDI7G4SrefDQ4BVpmWUFWBW1cThhAl4/pvM3L+wcpGgdCvXSHu?=
 =?us-ascii?Q?kTo32LSYYm0tKr6xqDNQZbqe6v5b8X3VTurMwL7SL3Y/xu4SBNGQt33KL1EK?=
 =?us-ascii?Q?e7AAXar6vmnH7+bhaEIYUlasOMI7ekLAfmDBlACXIIxKgquOmAVHAN16xARd?=
 =?us-ascii?Q?1dqaa2TZhWEEupzSq4q3BHDnvSibr6d+CeRvSpbtlnuwpW9LjXsBcuEjEACL?=
 =?us-ascii?Q?2Gn2t4NkeZRqAA/XSyH7aGYBPcsykf+9nF5BjCCb2RU3LtEG8H69dpg8NXzv?=
 =?us-ascii?Q?by2MgiZ7MhhvnyOmLnvzDK1QK7llX03X+Unb4NDoHJyOSQJedP3XAfgJbTtA?=
 =?us-ascii?Q?H2Rq36JNyDo7Tc5t+wKRKrTWJK6yIeVOcyO0wc4tmaI595SW1Uf3cU/RHnMB?=
 =?us-ascii?Q?zR6q5IcDo0uOBY7pJ2w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6dfb44-3bfd-4709-fd29-08dac815a87e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 21:00:57.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6aQpucpGaWu+xkikFBBY9gjdV4OFvjEHTWU3HsCYfvlteHOUkwrLYvjGN2b/yfKQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4936
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Cover the essential functionality of the iommufd with a directed test from
userspace. This aims to achieve reasonable functional coverage using the
in-kernel self test framework.

A second test does a failure injection sweep of the success paths to study
error unwind behaviors.

This allows achieving high coverage of the corner cases in pages.c.

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com> # s390
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 tools/testing/selftests/Makefile              |    1 +
 tools/testing/selftests/iommu/.gitignore      |    3 +
 tools/testing/selftests/iommu/Makefile        |   12 +
 tools/testing/selftests/iommu/config          |    2 +
 tools/testing/selftests/iommu/iommufd.c       | 1627 +++++++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        |  580 ++++++
 tools/testing/selftests/iommu/iommufd_utils.h |  278 +++
 7 files changed, 2503 insertions(+)
 create mode 100644 tools/testing/selftests/iommu/.gitignore
 create mode 100644 tools/testing/selftests/iommu/Makefile
 create mode 100644 tools/testing/selftests/iommu/config
 create mode 100644 tools/testing/selftests/iommu/iommufd.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_fail_nth.c
 create mode 100644 tools/testing/selftests/iommu/iommufd_utils.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f07aef7c592c2e..d6680af7b2956e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -27,6 +27,7 @@ TARGETS += ftrace
 TARGETS += futex
 TARGETS += gpio
 TARGETS += intel_pstate
+TARGETS += iommu
 TARGETS += ipc
 TARGETS += ir
 TARGETS += kcmp
diff --git a/tools/testing/selftests/iommu/.gitignore b/tools/testing/selftests/iommu/.gitignore
new file mode 100644
index 00000000000000..7d0703049ebaf4
--- /dev/null
+++ b/tools/testing/selftests/iommu/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/iommufd
+/iommufd_fail_nth
diff --git a/tools/testing/selftests/iommu/Makefile b/tools/testing/selftests/iommu/Makefile
new file mode 100644
index 00000000000000..7cb74d26f14171
--- /dev/null
+++ b/tools/testing/selftests/iommu/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -Wall -O2 -Wno-unused-function
+CFLAGS += -I../../../../include/uapi/
+CFLAGS += -I../../../../include/
+
+CFLAGS += -D_GNU_SOURCE
+
+TEST_GEN_PROGS :=
+TEST_GEN_PROGS += iommufd
+TEST_GEN_PROGS += iommufd_fail_nth
+
+include ../lib.mk
diff --git a/tools/testing/selftests/iommu/config b/tools/testing/selftests/iommu/config
new file mode 100644
index 00000000000000..6c4f901d6fed3c
--- /dev/null
+++ b/tools/testing/selftests/iommu/config
@@ -0,0 +1,2 @@
+CONFIG_IOMMUFD
+CONFIG_IOMMUFD_TEST
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
new file mode 100644
index 00000000000000..460454eb24302f
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -0,0 +1,1627 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/eventfd.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/vfio.h>
+
+#include "iommufd_utils.h"
+
+static void *buffer;
+
+static unsigned long PAGE_SIZE;
+static unsigned long HUGEPAGE_SIZE;
+
+#define MOCK_PAGE_SIZE (PAGE_SIZE / 2)
+
+static unsigned long get_huge_page_size(void)
+{
+	char buf[80];
+	int ret;
+	int fd;
+
+	fd = open("/sys/kernel/mm/transparent_hugepage/hpage_pmd_size",
+		  O_RDONLY);
+	if (fd < 0)
+		return 2 * 1024 * 1024;
+
+	ret = read(fd, buf, sizeof(buf));
+	close(fd);
+	if (ret <= 0 || ret == sizeof(buf))
+		return 2 * 1024 * 1024;
+	buf[ret] = 0;
+	return strtoul(buf, NULL, 10);
+}
+
+static __attribute__((constructor)) void setup_sizes(void)
+{
+	void *vrc;
+	int rc;
+
+	PAGE_SIZE = sysconf(_SC_PAGE_SIZE);
+	HUGEPAGE_SIZE = get_huge_page_size();
+
+	BUFFER_SIZE = PAGE_SIZE * 16;
+	rc = posix_memalign(&buffer, HUGEPAGE_SIZE, BUFFER_SIZE);
+	assert(!rc);
+	assert(buffer);
+	assert((uintptr_t)buffer % HUGEPAGE_SIZE == 0);
+	vrc = mmap(buffer, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
+	assert(vrc == buffer);
+}
+
+FIXTURE(iommufd)
+{
+	int fd;
+};
+
+FIXTURE_SETUP(iommufd)
+{
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+}
+
+FIXTURE_TEARDOWN(iommufd)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+TEST_F(iommufd, simple_close)
+{
+}
+
+TEST_F(iommufd, cmd_fail)
+{
+	struct iommu_destroy cmd = { .size = sizeof(cmd), .id = 0 };
+
+	/* object id is invalid */
+	EXPECT_ERRNO(ENOENT, _test_ioctl_destroy(self->fd, 0));
+	/* Bad pointer */
+	EXPECT_ERRNO(EFAULT, ioctl(self->fd, IOMMU_DESTROY, NULL));
+	/* Unknown ioctl */
+	EXPECT_ERRNO(ENOTTY,
+		     ioctl(self->fd, _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE - 1),
+			   &cmd));
+}
+
+TEST_F(iommufd, cmd_length)
+{
+#define TEST_LENGTH(_struct, _ioctl)                                     \
+	{                                                                \
+		struct {                                                 \
+			struct _struct cmd;                              \
+			uint8_t extra;                                   \
+		} cmd = { .cmd = { .size = sizeof(struct _struct) - 1 }, \
+			  .extra = UINT8_MAX };                          \
+		int old_errno;                                           \
+		int rc;                                                  \
+									 \
+		EXPECT_ERRNO(EINVAL, ioctl(self->fd, _ioctl, &cmd));     \
+		cmd.cmd.size = sizeof(struct _struct) + 1;               \
+		EXPECT_ERRNO(E2BIG, ioctl(self->fd, _ioctl, &cmd));      \
+		cmd.cmd.size = sizeof(struct _struct);                   \
+		rc = ioctl(self->fd, _ioctl, &cmd);                      \
+		old_errno = errno;                                       \
+		cmd.cmd.size = sizeof(struct _struct) + 1;               \
+		cmd.extra = 0;                                           \
+		if (rc) {                                                \
+			EXPECT_ERRNO(old_errno,                          \
+				     ioctl(self->fd, _ioctl, &cmd));     \
+		} else {                                                 \
+			ASSERT_EQ(0, ioctl(self->fd, _ioctl, &cmd));     \
+		}                                                        \
+	}
+
+	TEST_LENGTH(iommu_destroy, IOMMU_DESTROY);
+	TEST_LENGTH(iommu_ioas_alloc, IOMMU_IOAS_ALLOC);
+	TEST_LENGTH(iommu_ioas_iova_ranges, IOMMU_IOAS_IOVA_RANGES);
+	TEST_LENGTH(iommu_ioas_allow_iovas, IOMMU_IOAS_ALLOW_IOVAS);
+	TEST_LENGTH(iommu_ioas_map, IOMMU_IOAS_MAP);
+	TEST_LENGTH(iommu_ioas_copy, IOMMU_IOAS_COPY);
+	TEST_LENGTH(iommu_ioas_unmap, IOMMU_IOAS_UNMAP);
+	TEST_LENGTH(iommu_option, IOMMU_OPTION);
+	TEST_LENGTH(iommu_vfio_ioas, IOMMU_VFIO_IOAS);
+#undef TEST_LENGTH
+}
+
+TEST_F(iommufd, cmd_ex_fail)
+{
+	struct {
+		struct iommu_destroy cmd;
+		__u64 future;
+	} cmd = { .cmd = { .size = sizeof(cmd), .id = 0 } };
+
+	/* object id is invalid and command is longer */
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* future area is non-zero */
+	cmd.future = 1;
+	EXPECT_ERRNO(E2BIG, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Original command "works" */
+	cmd.cmd.size = sizeof(cmd.cmd);
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+	/* Short command fails */
+	cmd.cmd.size = sizeof(cmd.cmd) - 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_DESTROY, &cmd));
+}
+
+TEST_F(iommufd, global_options)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_RLIMIT_MODE,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 1,
+	};
+
+	cmd.option_id = IOMMU_OPTION_RLIMIT_MODE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	/* This requires root */
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.option_id = IOMMU_OPTION_HUGE_PAGES;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	cmd.op = IOMMU_OPTION_OP_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+FIXTURE(iommufd_ioas)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint64_t base_iova;
+};
+
+FIXTURE_VARIANT(iommufd_ioas)
+{
+	unsigned int mock_domains;
+	unsigned int memory_limit;
+};
+
+FIXTURE_SETUP(iommufd_ioas)
+{
+	unsigned int i;
+
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	if (!variant->memory_limit) {
+		test_ioctl_set_default_memory_limit();
+	} else {
+		test_ioctl_set_temp_memory_limit(variant->memory_limit);
+	}
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_id);
+		self->base_iova = MOCK_APERTURE_START;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_ioas)
+{
+	test_ioctl_set_default_memory_limit();
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, no_domain)
+{
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain)
+{
+	.mock_domains = 1,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, two_mock_domain)
+{
+	.mock_domains = 2,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_ioas, mock_domain_limit)
+{
+	.mock_domains = 1,
+	.memory_limit = 16,
+};
+
+TEST_F(iommufd_ioas, ioas_auto_destroy)
+{
+}
+
+TEST_F(iommufd_ioas, ioas_destroy)
+{
+	if (self->domain_id) {
+		/* IOAS cannot be freed while a domain is on it */
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	} else {
+		/* Can allocate and manually free an IOAS table */
+		test_ioctl_destroy(self->ioas_id);
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_area_destroy)
+{
+	/* Adding an area does not change ability to destroy */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+	if (self->domain_id)
+		EXPECT_ERRNO(EBUSY,
+			     _test_ioctl_destroy(self->fd, self->ioas_id));
+	else
+		test_ioctl_destroy(self->ioas_id);
+}
+
+TEST_F(iommufd_ioas, ioas_area_auto_destroy)
+{
+	int i;
+
+	/* Can allocate and automatically free an IOAS table with many areas */
+	for (i = 0; i != 10; i++) {
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	}
+}
+
+TEST_F(iommufd_ioas, area)
+{
+	int i;
+
+	/* Unmap fails if nothing is mapped */
+	for (i = 0; i != 10; i++)
+		test_err_ioctl_ioas_unmap(ENOENT, i * PAGE_SIZE, PAGE_SIZE);
+
+	/* Unmap works */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE,
+					  self->base_iova + i * PAGE_SIZE);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(self->base_iova + i * PAGE_SIZE,
+				      PAGE_SIZE);
+
+	/* Split fails */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE * 2,
+				  self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova + 16 * PAGE_SIZE,
+				  PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova + 17 * PAGE_SIZE,
+				  PAGE_SIZE);
+
+	/* Over map fails */
+	test_err_ioctl_ioas_map_fixed(EEXIST, buffer, PAGE_SIZE * 2,
+				      self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EEXIST, buffer, PAGE_SIZE,
+				      self->base_iova + 16 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EEXIST, buffer, PAGE_SIZE,
+				      self->base_iova + 17 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EEXIST, buffer, PAGE_SIZE * 2,
+				      self->base_iova + 15 * PAGE_SIZE);
+	test_err_ioctl_ioas_map_fixed(EEXIST, buffer, PAGE_SIZE * 3,
+				      self->base_iova + 15 * PAGE_SIZE);
+
+	/* unmap all works */
+	test_ioctl_ioas_unmap(0, UINT64_MAX);
+
+	/* Unmap all succeeds on an empty IOAS */
+	test_ioctl_ioas_unmap(0, UINT64_MAX);
+}
+
+TEST_F(iommufd_ioas, unmap_fully_contained_areas)
+{
+	uint64_t unmap_len;
+	int i;
+
+	/* Give no_domain some space to rewind base_iova */
+	self->base_iova += 4 * PAGE_SIZE;
+
+	for (i = 0; i != 4; i++)
+		test_ioctl_ioas_map_fixed(buffer, 8 * PAGE_SIZE,
+					  self->base_iova + i * 16 * PAGE_SIZE);
+
+	/* Unmap not fully contained area doesn't work */
+	test_err_ioctl_ioas_unmap(ENOENT, self->base_iova - 4 * PAGE_SIZE,
+				  8 * PAGE_SIZE);
+	test_err_ioctl_ioas_unmap(ENOENT,
+				  self->base_iova + 3 * 16 * PAGE_SIZE +
+					  8 * PAGE_SIZE - 4 * PAGE_SIZE,
+				  8 * PAGE_SIZE);
+
+	/* Unmap fully contained areas works */
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id,
+					    self->base_iova - 4 * PAGE_SIZE,
+					    3 * 16 * PAGE_SIZE + 8 * PAGE_SIZE +
+						    4 * PAGE_SIZE,
+					    &unmap_len));
+	ASSERT_EQ(32 * PAGE_SIZE, unmap_len);
+}
+
+TEST_F(iommufd_ioas, area_auto_iova)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+	__u64 iovas[10];
+	int i;
+
+	/* Simple 4k pages */
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_map(buffer, PAGE_SIZE, &iovas[i]);
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE);
+
+	/* Kernel automatically aligns IOVAs properly */
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		if (self->domain_id) {
+			test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		} else {
+			test_ioctl_ioas_map((void *)(1UL << 31), length,
+					    &iovas[i]);
+		}
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Avoids a reserved region */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(false,
+			  iovas[i] > test_cmd.add_reserved.start &&
+				  iovas[i] <
+					  test_cmd.add_reserved.start +
+						  test_cmd.add_reserved.length);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+
+	/* Allowed region intersects with a reserved region */
+	ranges[0].start = PAGE_SIZE;
+	ranges[0].last = PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allocate from an allowed region */
+	if (self->domain_id) {
+		ranges[0].start = MOCK_APERTURE_START + PAGE_SIZE;
+		ranges[0].last = MOCK_APERTURE_START + PAGE_SIZE * 600 - 1;
+	} else {
+		ranges[0].start = PAGE_SIZE * 200;
+		ranges[0].last = PAGE_SIZE * 600 - 1;
+	}
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	for (i = 0; i != 10; i++) {
+		size_t length = PAGE_SIZE * (i + 1);
+
+		test_ioctl_ioas_map(buffer, length, &iovas[i]);
+		EXPECT_EQ(0, iovas[i] % (1UL << (ffs(length) - 1)));
+		EXPECT_EQ(true, iovas[i] >= ranges[0].start);
+		EXPECT_EQ(true, iovas[i] <= ranges[0].last);
+		EXPECT_EQ(true, iovas[i] + length > ranges[0].start);
+		EXPECT_EQ(true, iovas[i] + length <= ranges[0].last + 1);
+	}
+	for (i = 0; i != 10; i++)
+		test_ioctl_ioas_unmap(iovas[i], PAGE_SIZE * (i + 1));
+}
+
+TEST_F(iommufd_ioas, area_allowed)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE * 4,
+				  .length = PAGE_SIZE * 100 },
+	};
+	struct iommu_iova_range ranges[1] = {};
+	struct iommu_ioas_allow_iovas allow_cmd = {
+		.size = sizeof(allow_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = 1,
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+
+	/* Reserved intersects an allowed */
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+	test_cmd.add_reserved.start = ranges[0].start + PAGE_SIZE;
+	test_cmd.add_reserved.length = PAGE_SIZE;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd,
+			   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			   &test_cmd));
+	allow_cmd.num_iovas = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+
+	/* Allowed intersects a reserved */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	allow_cmd.num_iovas = 1;
+	ranges[0].start = self->base_iova;
+	ranges[0].last = ranges[0].start + PAGE_SIZE * 600;
+	EXPECT_ERRNO(EADDRINUSE,
+		     ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd));
+}
+
+TEST_F(iommufd_ioas, copy_area)
+{
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.src_ioas_id = self->ioas_id,
+		.length = PAGE_SIZE,
+	};
+
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, self->base_iova);
+
+	/* Copy inside a single IOAS */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = self->base_iova + PAGE_SIZE;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+
+	/* Copy between IOAS's */
+	copy_cmd.src_iova = self->base_iova;
+	copy_cmd.dst_iova = 0;
+	test_ioctl_ioas_alloc(&copy_cmd.dst_ioas_id);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+}
+
+TEST_F(iommufd_ioas, iova_ranges)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_ADD_RESERVED,
+		.id = self->ioas_id,
+		.add_reserved = { .start = PAGE_SIZE, .length = PAGE_SIZE },
+	};
+	struct iommu_iova_range *ranges = buffer;
+	struct iommu_ioas_iova_ranges ranges_cmd = {
+		.size = sizeof(ranges_cmd),
+		.ioas_id = self->ioas_id,
+		.num_iovas = BUFFER_SIZE / sizeof(*ranges),
+		.allowed_iovas = (uintptr_t)ranges,
+	};
+
+	/* Range can be read */
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	if (!self->domain_id) {
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(SIZE_MAX, ranges[0].last);
+		EXPECT_EQ(1, ranges_cmd.out_iova_alignment);
+	} else {
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+		EXPECT_EQ(MOCK_PAGE_SIZE, ranges_cmd.out_iova_alignment);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 0;
+	EXPECT_ERRNO(EMSGSIZE,
+		     ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	EXPECT_EQ(1, ranges_cmd.num_iovas);
+	EXPECT_EQ(0, ranges[0].start);
+	EXPECT_EQ(0, ranges[0].last);
+
+	/* 2 ranges */
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ADD_RESERVED),
+			&test_cmd));
+	ranges_cmd.num_iovas = BUFFER_SIZE / sizeof(*ranges);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+	if (!self->domain_id) {
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+		EXPECT_EQ(PAGE_SIZE * 2, ranges[1].start);
+		EXPECT_EQ(SIZE_MAX, ranges[1].last);
+	} else {
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+
+	/* Buffer too small */
+	memset(ranges, 0, BUFFER_SIZE);
+	ranges_cmd.num_iovas = 1;
+	if (!self->domain_id) {
+		EXPECT_ERRNO(EMSGSIZE, ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES,
+					     &ranges_cmd));
+		EXPECT_EQ(2, ranges_cmd.num_iovas);
+		EXPECT_EQ(0, ranges[0].start);
+		EXPECT_EQ(PAGE_SIZE - 1, ranges[0].last);
+	} else {
+		ASSERT_EQ(0,
+			  ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd));
+		EXPECT_EQ(1, ranges_cmd.num_iovas);
+		EXPECT_EQ(MOCK_APERTURE_START, ranges[0].start);
+		EXPECT_EQ(MOCK_APERTURE_LAST, ranges[0].last);
+	}
+	EXPECT_EQ(0, ranges[1].start);
+	EXPECT_EQ(0, ranges[1].last);
+}
+
+TEST_F(iommufd_ioas, access_pin)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = MOCK_APERTURE_START,
+				  .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_test_cmd check_map_cmd = {
+		.size = sizeof(check_map_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_MAP,
+		.check_map = { .iova = MOCK_APERTURE_START,
+			       .length = BUFFER_SIZE,
+			       .uptr = (uintptr_t)buffer },
+	};
+	uint32_t access_pages_id;
+	unsigned int npages;
+
+	test_cmd_create_access(self->ioas_id, &access_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+
+	for (npages = 1; npages < BUFFER_SIZE / PAGE_SIZE; npages++) {
+		uint32_t mock_device_id;
+		uint32_t mock_hwpt_id;
+
+		access_cmd.access_pages.length = npages * PAGE_SIZE;
+
+		/* Single map/unmap */
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+
+		/* Double user */
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+		test_cmd_destroy_access_pages(access_cmd.id, access_pages_id);
+
+		/* Add/remove a domain with a user */
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+				   &access_cmd));
+		test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+				     &mock_hwpt_id);
+		check_map_cmd.id = mock_hwpt_id;
+		ASSERT_EQ(0, ioctl(self->fd,
+				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
+				   &check_map_cmd));
+
+		test_ioctl_destroy(mock_device_id);
+		test_ioctl_destroy(mock_hwpt_id);
+		test_cmd_destroy_access_pages(
+			access_cmd.id,
+			access_cmd.access_pages.out_access_pages_id);
+
+		test_ioctl_ioas_unmap(MOCK_APERTURE_START, BUFFER_SIZE);
+	}
+	test_cmd_destroy_access(access_cmd.id);
+}
+
+TEST_F(iommufd_ioas, access_pin_unmap)
+{
+	struct iommu_test_cmd access_pages_cmd = {
+		.size = sizeof(access_pages_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .iova = MOCK_APERTURE_START,
+				  .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+
+	test_cmd_create_access(self->ioas_id, &access_pages_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, MOCK_APERTURE_START);
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_pages_cmd));
+
+	/* Trigger the unmap op */
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START, BUFFER_SIZE);
+
+	/* kernel removed the item for us */
+	test_err_destroy_access_pages(
+		ENOENT, access_pages_cmd.id,
+		access_pages_cmd.access_pages.out_access_pages_id);
+}
+
+static void check_access_rw(struct __test_metadata *_metadata, int fd,
+			    unsigned int access_id, uint64_t iova,
+			    unsigned int def_flags)
+{
+	uint16_t tmp[32];
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_RW,
+		.id = access_id,
+		.access_rw = { .uptr = (uintptr_t)tmp },
+	};
+	uint16_t *buffer16 = buffer;
+	unsigned int i;
+	void *tmp2;
+
+	for (i = 0; i != BUFFER_SIZE / sizeof(*buffer16); i++)
+		buffer16[i] = rand();
+
+	for (access_cmd.access_rw.iova = iova + PAGE_SIZE - 50;
+	     access_cmd.access_rw.iova < iova + PAGE_SIZE + 50;
+	     access_cmd.access_rw.iova++) {
+		for (access_cmd.access_rw.length = 1;
+		     access_cmd.access_rw.length < sizeof(tmp);
+		     access_cmd.access_rw.length++) {
+			access_cmd.access_rw.flags = def_flags;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+
+			for (i = 0; i != ARRAY_SIZE(tmp); i++)
+				tmp[i] = rand();
+			access_cmd.access_rw.flags = def_flags |
+						     MOCK_ACCESS_RW_WRITE;
+			ASSERT_EQ(0, ioctl(fd,
+					   _IOMMU_TEST_CMD(
+						   IOMMU_TEST_OP_ACCESS_RW),
+					   &access_cmd));
+			ASSERT_EQ(0,
+				  memcmp(buffer + (access_cmd.access_rw.iova -
+						   iova),
+					 tmp, access_cmd.access_rw.length));
+		}
+	}
+
+	/* Multi-page test */
+	tmp2 = malloc(BUFFER_SIZE);
+	ASSERT_NE(NULL, tmp2);
+	access_cmd.access_rw.iova = iova;
+	access_cmd.access_rw.length = BUFFER_SIZE;
+	access_cmd.access_rw.flags = def_flags;
+	access_cmd.access_rw.uptr = (uintptr_t)tmp2;
+	ASSERT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			   &access_cmd));
+	ASSERT_EQ(0, memcmp(buffer, tmp2, access_cmd.access_rw.length));
+	free(tmp2);
+}
+
+TEST_F(iommufd_ioas, access_rw)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+	test_ioctl_ioas_map(buffer, BUFFER_SIZE, &iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	check_access_rw(_metadata, self->fd, access_id, iova,
+			MOCK_ACCESS_RW_SLOW_PATH);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, access_rw_unaligned)
+{
+	__u32 access_id;
+	__u64 iova;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	/* Unaligned pages */
+	iova = self->base_iova + MOCK_PAGE_SIZE;
+	test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE, iova);
+	check_access_rw(_metadata, self->fd, access_id, iova, 0);
+	test_ioctl_ioas_unmap(iova, BUFFER_SIZE);
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_gone)
+{
+	__u32 access_id;
+	pid_t child;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		exit(0);
+	}
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	if (self->domain_id) {
+		/*
+		 * If a domain already existed then everything was pinned within
+		 * the fork, so this copies from one domain to another.
+		 */
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		check_access_rw(_metadata, self->fd, access_id,
+				MOCK_APERTURE_START, 0);
+
+	} else {
+		/*
+		 * Otherwise we need to actually pin pages which can't happen
+		 * since the fork is gone.
+		 */
+		test_err_mock_domain(EFAULT, self->ioas_id, NULL, NULL);
+	}
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, fork_present)
+{
+	__u32 access_id;
+	int pipefds[2];
+	uint64_t tmp;
+	pid_t child;
+	int efd;
+
+	test_cmd_create_access(self->ioas_id, &access_id, 0);
+
+	ASSERT_EQ(0, pipe2(pipefds, O_CLOEXEC));
+	efd = eventfd(0, EFD_CLOEXEC);
+	ASSERT_NE(-1, efd);
+
+	/* Create a mapping with a different mm */
+	child = fork();
+	if (!child) {
+		__u64 iova;
+		uint64_t one = 1;
+
+		close(pipefds[1]);
+		test_ioctl_ioas_map_fixed(buffer, BUFFER_SIZE,
+					  MOCK_APERTURE_START);
+		if (write(efd, &one, sizeof(one)) != sizeof(one))
+			exit(100);
+		if (read(pipefds[0], &iova, 1) != 1)
+			exit(100);
+		exit(0);
+	}
+	close(pipefds[0]);
+	ASSERT_NE(-1, child);
+	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
+
+	/* Read pages from the remote process */
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
+
+	ASSERT_EQ(0, close(pipefds[1]));
+	ASSERT_EQ(child, waitpid(child, NULL, 0));
+
+	test_cmd_destroy_access(access_id);
+}
+
+TEST_F(iommufd_ioas, ioas_option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(1, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 0;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_GET;
+	cmd.val64 = 3;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	ASSERT_EQ(0, cmd.val64);
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 2;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	cmd.op = IOMMU_OPTION_OP_SET;
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+}
+
+TEST_F(iommufd_ioas, ioas_iova_alloc)
+{
+	unsigned int length;
+	__u64 iova;
+
+	for (length = 1; length != PAGE_SIZE * 2; length++) {
+		if (variant->mock_domains && (length % MOCK_PAGE_SIZE)) {
+			test_err_ioctl_ioas_map(EINVAL, buffer, length, &iova);
+		} else {
+			test_ioctl_ioas_map(buffer, length, &iova);
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+}
+
+TEST_F(iommufd_ioas, ioas_align_change)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_SET,
+		.object_id = self->ioas_id,
+		/* 0 means everything must be aligned to PAGE_SIZE */
+		.val64 = 0,
+	};
+
+	/*
+	 * We cannot upgrade the alignment using OPTION_HUGE_PAGES when a domain
+	 * and map are present.
+	 */
+	if (variant->mock_domains)
+		return;
+
+	/*
+	 * We can upgrade to PAGE_SIZE alignment when things are aligned right
+	 */
+	test_ioctl_ioas_map_fixed(buffer, PAGE_SIZE, MOCK_APERTURE_START);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Misalignment is rejected at map time */
+	test_err_ioctl_ioas_map_fixed(EINVAL, buffer + MOCK_PAGE_SIZE,
+				      PAGE_SIZE,
+				      MOCK_APERTURE_START + PAGE_SIZE);
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Reduce alignment */
+	cmd.val64 = 1;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	/* Confirm misalignment is rejected during alignment upgrade */
+	test_ioctl_ioas_map_fixed(buffer + MOCK_PAGE_SIZE, PAGE_SIZE,
+				  MOCK_APERTURE_START + PAGE_SIZE);
+	cmd.val64 = 0;
+	EXPECT_ERRNO(EADDRINUSE, ioctl(self->fd, IOMMU_OPTION, &cmd));
+
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START + PAGE_SIZE, PAGE_SIZE);
+	test_ioctl_ioas_unmap(MOCK_APERTURE_START, PAGE_SIZE);
+}
+
+TEST_F(iommufd_ioas, copy_sweep)
+{
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.src_ioas_id = self->ioas_id,
+		.dst_iova = MOCK_APERTURE_START,
+		.length = MOCK_PAGE_SIZE,
+	};
+	unsigned int dst_ioas_id;
+	uint64_t last_iova;
+	uint64_t iova;
+
+	test_ioctl_ioas_alloc(&dst_ioas_id);
+	copy_cmd.dst_ioas_id = dst_ioas_id;
+
+	if (variant->mock_domains)
+		last_iova = MOCK_APERTURE_START + BUFFER_SIZE - 1;
+	else
+		last_iova = MOCK_APERTURE_START + BUFFER_SIZE - 2;
+
+	test_ioctl_ioas_map_fixed(buffer, last_iova - MOCK_APERTURE_START + 1,
+				  MOCK_APERTURE_START);
+
+	for (iova = MOCK_APERTURE_START - PAGE_SIZE; iova <= last_iova;
+	     iova += 511) {
+		copy_cmd.src_iova = iova;
+		if (iova < MOCK_APERTURE_START ||
+		    iova + copy_cmd.length - 1 > last_iova) {
+			EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_IOAS_COPY,
+						   &copy_cmd));
+		} else {
+			ASSERT_EQ(0,
+				  ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+			test_ioctl_ioas_unmap_id(dst_ioas_id, copy_cmd.dst_iova,
+						 copy_cmd.length);
+		}
+	}
+
+	test_ioctl_destroy(dst_ioas_id);
+}
+
+FIXTURE(iommufd_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+	uint32_t domain_id;
+	uint32_t domain_ids[2];
+	int mmap_flags;
+	size_t mmap_buf_size;
+};
+
+FIXTURE_VARIANT(iommufd_mock_domain)
+{
+	unsigned int mock_domains;
+	bool hugepages;
+};
+
+FIXTURE_SETUP(iommufd_mock_domain)
+{
+	unsigned int i;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+	test_ioctl_ioas_alloc(&self->ioas_id);
+
+	ASSERT_GE(ARRAY_SIZE(self->domain_ids), variant->mock_domains);
+
+	for (i = 0; i != variant->mock_domains; i++)
+		test_cmd_mock_domain(self->ioas_id, NULL, &self->domain_ids[i]);
+	self->domain_id = self->domain_ids[0];
+
+	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
+	self->mmap_buf_size = PAGE_SIZE * 8;
+	if (variant->hugepages) {
+		/*
+		 * MAP_POPULATE will cause the kernel to fail mmap if THPs are
+		 * not available.
+		 */
+		self->mmap_flags |= MAP_HUGETLB | MAP_POPULATE;
+		self->mmap_buf_size = HUGEPAGE_SIZE * 2;
+	}
+}
+
+FIXTURE_TEARDOWN(iommufd_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain)
+{
+	.mock_domains = 1,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains)
+{
+	.mock_domains = 2,
+	.hugepages = false,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, one_domain_hugepage)
+{
+	.mock_domains = 1,
+	.hugepages = true,
+};
+
+FIXTURE_VARIANT_ADD(iommufd_mock_domain, two_domains_hugepage)
+{
+	.mock_domains = 2,
+	.hugepages = true,
+};
+
+/* Have the kernel check that the user pages made it to the iommu_domain */
+#define check_mock_iova(_ptr, _iova, _length)                                \
+	({                                                                   \
+		struct iommu_test_cmd check_map_cmd = {                      \
+			.size = sizeof(check_map_cmd),                       \
+			.op = IOMMU_TEST_OP_MD_CHECK_MAP,                    \
+			.id = self->domain_id,                               \
+			.check_map = { .iova = _iova,                        \
+				       .length = _length,                    \
+				       .uptr = (uintptr_t)(_ptr) },          \
+		};                                                           \
+		ASSERT_EQ(0,                                                 \
+			  ioctl(self->fd,                                    \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP), \
+				&check_map_cmd));                            \
+		if (self->domain_ids[1]) {                                   \
+			check_map_cmd.id = self->domain_ids[1];              \
+			ASSERT_EQ(0,                                         \
+				  ioctl(self->fd,                            \
+					_IOMMU_TEST_CMD(                     \
+						IOMMU_TEST_OP_MD_CHECK_MAP), \
+					&check_map_cmd));                    \
+		}                                                            \
+	})
+
+TEST_F(iommufd_mock_domain, basic)
+{
+	size_t buf_size = self->mmap_buf_size;
+	uint8_t *buf;
+	__u64 iova;
+
+	/* Simple one page map */
+	test_ioctl_ioas_map(buffer, PAGE_SIZE, &iova);
+	check_mock_iova(buffer, iova, PAGE_SIZE);
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+
+	/* EFAULT half way through mapping */
+	ASSERT_EQ(0, munmap(buf + buf_size / 2, buf_size / 2));
+	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
+
+	/* EFAULT on first page */
+	ASSERT_EQ(0, munmap(buf, buf_size / 2));
+	test_err_ioctl_ioas_map(EFAULT, buf, buf_size, &iova);
+}
+
+TEST_F(iommufd_mock_domain, all_aligns)
+{
+	size_t test_step = variant->hugepages ? (self->mmap_buf_size / 16) :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, all_aligns_copy)
+{
+	size_t test_step = variant->hugepages ? self->mmap_buf_size / 16 :
+						MOCK_PAGE_SIZE;
+	size_t buf_size = self->mmap_buf_size;
+	unsigned int start;
+	unsigned int end;
+	uint8_t *buf;
+
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE, self->mmap_flags, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	check_refs(buf, buf_size, 0);
+
+	/*
+	 * Map every combination of page size and alignment within a big region,
+	 * less for hugepage case as it takes so long to finish.
+	 */
+	for (start = 0; start < buf_size; start += test_step) {
+		if (variant->hugepages)
+			end = buf_size;
+		else
+			end = start + MOCK_PAGE_SIZE;
+		for (; end < buf_size; end += MOCK_PAGE_SIZE) {
+			size_t length = end - start;
+			unsigned int old_id;
+			uint32_t mock_device_id;
+			__u64 iova;
+
+			test_ioctl_ioas_map(buf + start, length, &iova);
+
+			/* Add and destroy a domain while the area exists */
+			old_id = self->domain_ids[1];
+			test_cmd_mock_domain(self->ioas_id, &mock_device_id,
+					     &self->domain_ids[1]);
+
+			check_mock_iova(buf + start, iova, length);
+			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
+				   end / PAGE_SIZE * PAGE_SIZE -
+					   start / PAGE_SIZE * PAGE_SIZE,
+				   1);
+
+			test_ioctl_destroy(mock_device_id);
+			test_ioctl_destroy(self->domain_ids[1]);
+			self->domain_ids[1] = old_id;
+
+			test_ioctl_ioas_unmap(iova, length);
+		}
+	}
+	check_refs(buf, buf_size, 0);
+	ASSERT_EQ(0, munmap(buf, buf_size));
+}
+
+TEST_F(iommufd_mock_domain, user_copy)
+{
+	struct iommu_test_cmd access_cmd = {
+		.size = sizeof(access_cmd),
+		.op = IOMMU_TEST_OP_ACCESS_PAGES,
+		.access_pages = { .length = BUFFER_SIZE,
+				  .uptr = (uintptr_t)buffer },
+	};
+	struct iommu_ioas_copy copy_cmd = {
+		.size = sizeof(copy_cmd),
+		.flags = IOMMU_IOAS_MAP_FIXED_IOVA,
+		.dst_ioas_id = self->ioas_id,
+		.dst_iova = MOCK_APERTURE_START,
+		.length = BUFFER_SIZE,
+	};
+	unsigned int ioas_id;
+
+	/* Pin the pages in an IOAS with no domains then copy to an IOAS with domains */
+	test_ioctl_ioas_alloc(&ioas_id);
+	test_ioctl_ioas_map_id(ioas_id, buffer, BUFFER_SIZE,
+			       &copy_cmd.src_iova);
+
+	test_cmd_create_access(ioas_id, &access_cmd.id,
+			       MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES);
+
+	access_cmd.access_pages.iova = copy_cmd.src_iova;
+	ASSERT_EQ(0,
+		  ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
+			&access_cmd));
+	copy_cmd.src_ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd));
+	check_mock_iova(buffer, MOCK_APERTURE_START, BUFFER_SIZE);
+
+	test_cmd_destroy_access_pages(
+		access_cmd.id, access_cmd.access_pages.out_access_pages_id);
+	test_cmd_destroy_access(access_cmd.id) test_ioctl_destroy(ioas_id);
+
+	test_ioctl_destroy(ioas_id);
+}
+
+/* VFIO compatibility IOCTLs */
+
+TEST_F(iommufd, simple_ioctls)
+{
+	ASSERT_EQ(VFIO_API_VERSION, ioctl(self->fd, VFIO_GET_API_VERSION));
+	ASSERT_EQ(1, ioctl(self->fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1v2_IOMMU));
+}
+
+TEST_F(iommufd, unmap_cmd)
+{
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+	};
+
+	unmap_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.argsz = sizeof(unmap_cmd);
+	unmap_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.flags = 0;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+}
+
+TEST_F(iommufd, map_cmd)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.iova = MOCK_APERTURE_START,
+		.size = PAGE_SIZE,
+		.vaddr = (__u64)buffer,
+	};
+
+	map_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	map_cmd.argsz = sizeof(map_cmd);
+	map_cmd.flags = 1 << 31;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	/* Requires a domain to be attached */
+	map_cmd.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+}
+
+TEST_F(iommufd, info_cmd)
+{
+	struct vfio_iommu_type1_info info_cmd = {};
+
+	/* Invalid argsz */
+	info_cmd.argsz = 1;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+
+	info_cmd.argsz = sizeof(info_cmd);
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_IOMMU_GET_INFO, &info_cmd));
+}
+
+TEST_F(iommufd, set_iommu_cmd)
+{
+	/* Requires a domain to be attached */
+	EXPECT_ERRNO(ENODEV,
+		     ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1v2_IOMMU));
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU));
+}
+
+TEST_F(iommufd, vfio_ioas)
+{
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_GET,
+	};
+	__u32 ioas_id;
+
+	/* ENODEV if there is no compat ioas */
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Invalid id for set */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_SET;
+	EXPECT_ERRNO(ENOENT, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Valid id for set*/
+	test_ioctl_ioas_alloc(&ioas_id);
+	vfio_ioas_cmd.ioas_id = ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+
+	/* Same id comes back from get */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(ioas_id, vfio_ioas_cmd.ioas_id);
+
+	/* Clear works */
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_CLEAR;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	vfio_ioas_cmd.op = IOMMU_VFIO_IOAS_GET;
+	EXPECT_ERRNO(ENODEV, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+}
+
+FIXTURE(vfio_compat_mock_domain)
+{
+	int fd;
+	uint32_t ioas_id;
+};
+
+FIXTURE_VARIANT(vfio_compat_mock_domain)
+{
+	unsigned int version;
+};
+
+FIXTURE_SETUP(vfio_compat_mock_domain)
+{
+	struct iommu_vfio_ioas vfio_ioas_cmd = {
+		.size = sizeof(vfio_ioas_cmd),
+		.op = IOMMU_VFIO_IOAS_SET,
+	};
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	ASSERT_NE(-1, self->fd);
+
+	/* Create what VFIO would consider a group */
+	test_ioctl_ioas_alloc(&self->ioas_id);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+
+	/* Attach it to the vfio compat */
+	vfio_ioas_cmd.ioas_id = self->ioas_id;
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_VFIO_IOAS, &vfio_ioas_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_SET_IOMMU, variant->version));
+}
+
+FIXTURE_TEARDOWN(vfio_compat_mock_domain)
+{
+	teardown_iommufd(self->fd, _metadata);
+}
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v2)
+{
+	.version = VFIO_TYPE1v2_IOMMU,
+};
+
+FIXTURE_VARIANT_ADD(vfio_compat_mock_domain, Ver1v0)
+{
+	.version = VFIO_TYPE1_IOMMU,
+};
+
+TEST_F(vfio_compat_mock_domain, simple_close)
+{
+}
+
+TEST_F(vfio_compat_mock_domain, option_huge_pages)
+{
+	struct iommu_option cmd = {
+		.size = sizeof(cmd),
+		.option_id = IOMMU_OPTION_HUGE_PAGES,
+		.op = IOMMU_OPTION_OP_GET,
+		.val64 = 3,
+		.object_id = self->ioas_id,
+	};
+
+	ASSERT_EQ(0, ioctl(self->fd, IOMMU_OPTION, &cmd));
+	if (variant->version == VFIO_TYPE1_IOMMU) {
+		ASSERT_EQ(0, cmd.val64);
+	} else {
+		ASSERT_EQ(1, cmd.val64);
+	}
+}
+
+/*
+ * Execute an ioctl command stored in buffer and check that the result does not
+ * overflow memory.
+ */
+static bool is_filled(const void *buf, uint8_t c, size_t len)
+{
+	const uint8_t *cbuf = buf;
+
+	for (; len; cbuf++, len--)
+		if (*cbuf != c)
+			return false;
+	return true;
+}
+
+#define ioctl_check_buf(fd, cmd)                                         \
+	({                                                               \
+		size_t _cmd_len = *(__u32 *)buffer;                      \
+									 \
+		memset(buffer + _cmd_len, 0xAA, BUFFER_SIZE - _cmd_len); \
+		ASSERT_EQ(0, ioctl(fd, cmd, buffer));                    \
+		ASSERT_EQ(true, is_filled(buffer + _cmd_len, 0xAA,       \
+					  BUFFER_SIZE - _cmd_len));      \
+	})
+
+static void check_vfio_info_cap_chain(struct __test_metadata *_metadata,
+				      struct vfio_iommu_type1_info *info_cmd)
+{
+	const struct vfio_info_cap_header *cap;
+
+	ASSERT_GE(info_cmd->argsz, info_cmd->cap_offset + sizeof(*cap));
+	cap = buffer + info_cmd->cap_offset;
+	while (true) {
+		size_t cap_size;
+
+		if (cap->next)
+			cap_size = (buffer + cap->next) - (void *)cap;
+		else
+			cap_size = (buffer + info_cmd->argsz) - (void *)cap;
+
+		switch (cap->id) {
+		case VFIO_IOMMU_TYPE1_INFO_CAP_IOVA_RANGE: {
+			struct vfio_iommu_type1_info_cap_iova_range *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(1, data->nr_iovas);
+			EXPECT_EQ(MOCK_APERTURE_START,
+				  data->iova_ranges[0].start);
+			EXPECT_EQ(MOCK_APERTURE_LAST, data->iova_ranges[0].end);
+			break;
+		}
+		case VFIO_IOMMU_TYPE1_INFO_DMA_AVAIL: {
+			struct vfio_iommu_type1_info_dma_avail *data =
+				(void *)cap;
+
+			ASSERT_EQ(1, data->header.version);
+			ASSERT_EQ(sizeof(*data), cap_size);
+			break;
+		}
+		default:
+			ASSERT_EQ(false, true);
+			break;
+		}
+		if (!cap->next)
+			break;
+
+		ASSERT_GE(info_cmd->argsz, cap->next + sizeof(*cap));
+		ASSERT_GE(buffer + cap->next, (void *)cap);
+		cap = buffer + cap->next;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, get_info)
+{
+	struct vfio_iommu_type1_info *info_cmd = buffer;
+	unsigned int i;
+	size_t caplen;
+
+	/* Pre-cap ABI */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = offsetof(struct vfio_iommu_type1_info, cap_offset),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+
+	/* Read the cap chain size */
+	*info_cmd = (struct vfio_iommu_type1_info){
+		.argsz = sizeof(*info_cmd),
+	};
+	ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+	ASSERT_NE(0, info_cmd->iova_pgsizes);
+	ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+		  info_cmd->flags);
+	ASSERT_EQ(0, info_cmd->cap_offset);
+	ASSERT_LT(sizeof(*info_cmd), info_cmd->argsz);
+
+	/* Read the caps, kernel should never create a corrupted caps */
+	caplen = info_cmd->argsz;
+	for (i = sizeof(*info_cmd); i < caplen; i++) {
+		*info_cmd = (struct vfio_iommu_type1_info){
+			.argsz = i,
+		};
+		ioctl_check_buf(self->fd, VFIO_IOMMU_GET_INFO);
+		ASSERT_EQ(VFIO_IOMMU_INFO_PGSIZES | VFIO_IOMMU_INFO_CAPS,
+			  info_cmd->flags);
+		if (!info_cmd->cap_offset)
+			continue;
+		check_vfio_info_cap_chain(_metadata, info_cmd);
+	}
+}
+
+static void shuffle_array(unsigned long *array, size_t nelms)
+{
+	unsigned int i;
+
+	/* Shuffle */
+	for (i = 0; i != nelms; i++) {
+		unsigned long tmp = array[i];
+		unsigned int other = rand() % (nelms - i);
+
+		array[i] = array[other];
+		array[other] = tmp;
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, map)
+{
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = (uintptr_t)buffer,
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+		.size = BUFFER_SIZE,
+		.iova = MOCK_APERTURE_START,
+	};
+	unsigned long pages_iova[BUFFER_SIZE / PAGE_SIZE];
+	unsigned int i;
+
+	/* Simple map/unmap */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* UNMAP_FLAG_ALL requres 0 iova/size */
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	unmap_cmd.flags = VFIO_DMA_UNMAP_FLAG_ALL;
+	EXPECT_ERRNO(EINVAL, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+
+	unmap_cmd.iova = 0;
+	unmap_cmd.size = 0;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	ASSERT_EQ(BUFFER_SIZE, unmap_cmd.size);
+
+	/* Small pages */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		map_cmd.iova = pages_iova[i] =
+			MOCK_APERTURE_START + i * PAGE_SIZE;
+		map_cmd.vaddr = (uintptr_t)buffer + i * PAGE_SIZE;
+		map_cmd.size = PAGE_SIZE;
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+	}
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	unmap_cmd.flags = 0;
+	unmap_cmd.size = PAGE_SIZE;
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA, &unmap_cmd));
+	}
+}
+
+TEST_F(vfio_compat_mock_domain, huge_map)
+{
+	size_t buf_size = HUGEPAGE_SIZE * 2;
+	struct vfio_iommu_type1_dma_map map_cmd = {
+		.argsz = sizeof(map_cmd),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.size = buf_size,
+		.iova = MOCK_APERTURE_START,
+	};
+	struct vfio_iommu_type1_dma_unmap unmap_cmd = {
+		.argsz = sizeof(unmap_cmd),
+	};
+	unsigned long pages_iova[16];
+	unsigned int i;
+	void *buf;
+
+	/* Test huge pages and splitting */
+	buf = mmap(0, buf_size, PROT_READ | PROT_WRITE,
+		   MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB | MAP_POPULATE, -1,
+		   0);
+	ASSERT_NE(MAP_FAILED, buf);
+	map_cmd.vaddr = (uintptr_t)buf;
+	ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_MAP_DMA, &map_cmd));
+
+	unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++)
+		pages_iova[i] = MOCK_APERTURE_START + (i * unmap_cmd.size);
+	shuffle_array(pages_iova, ARRAY_SIZE(pages_iova));
+
+	/* type1 mode can cut up larger mappings, type1v2 always fails */
+	for (i = 0; i != ARRAY_SIZE(pages_iova); i++) {
+		unmap_cmd.iova = pages_iova[i];
+		unmap_cmd.size = buf_size / ARRAY_SIZE(pages_iova);
+		if (variant->version == VFIO_TYPE1_IOMMU) {
+			ASSERT_EQ(0, ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		} else {
+			EXPECT_ERRNO(ENOENT,
+				     ioctl(self->fd, VFIO_IOMMU_UNMAP_DMA,
+					   &unmap_cmd));
+		}
+	}
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
new file mode 100644
index 00000000000000..9713111b820dd7
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -0,0 +1,580 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
+ *
+ * These tests are "kernel integrity" tests. They are looking for kernel
+ * WARN/OOPS/kasn/etc splats triggered by kernel sanitizers & debugging
+ * features. It does not attempt to verify that the system calls are doing what
+ * they are supposed to do.
+ *
+ * The basic philosophy is to run a sequence of calls that will succeed and then
+ * sweep every failure injection point on that call chain to look for
+ * interesting things in error handling.
+ *
+ * This test is best run with:
+ *  echo 1 > /proc/sys/kernel/panic_on_warn
+ * If something is actually going wrong.
+ */
+#include <fcntl.h>
+#include <dirent.h>
+
+#define __EXPORTED_HEADERS__
+#include <linux/vfio.h>
+
+#include "iommufd_utils.h"
+
+static bool have_fault_injection;
+
+static int writeat(int dfd, const char *fn, const char *val)
+{
+	size_t val_len = strlen(val);
+	ssize_t res;
+	int fd;
+
+	fd = openat(dfd, fn, O_WRONLY);
+	if (fd == -1)
+		return -1;
+	res = write(fd, val, val_len);
+	assert(res == val_len);
+	close(fd);
+	return 0;
+}
+
+static __attribute__((constructor)) void setup_buffer(void)
+{
+	BUFFER_SIZE = 2*1024*1024;
+
+	buffer = mmap(0, BUFFER_SIZE, PROT_READ | PROT_WRITE,
+		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+}
+
+/*
+ * This sets up fail_injection in a way that is useful for this test.
+ * It does not attempt to restore things back to how they were.
+ */
+static __attribute__((constructor)) void setup_fault_injection(void)
+{
+	DIR *debugfs = opendir("/sys/kernel/debug/");
+	struct dirent *dent;
+
+	if (!debugfs)
+		return;
+
+	/* Allow any allocation call to be fault injected */
+	if (writeat(dirfd(debugfs), "failslab/ignore-gfp-wait", "N"))
+		return;
+	writeat(dirfd(debugfs), "fail_page_alloc/ignore-gfp-wait", "N");
+	writeat(dirfd(debugfs), "fail_page_alloc/ignore-gfp-highmem", "N");
+
+	while ((dent = readdir(debugfs))) {
+		char fn[300];
+
+		if (strncmp(dent->d_name, "fail", 4) != 0)
+			continue;
+
+		/* We are looking for kernel splats, quiet down the log */
+		snprintf(fn, sizeof(fn), "%s/verbose", dent->d_name);
+		writeat(dirfd(debugfs), fn, "0");
+	}
+	closedir(debugfs);
+	have_fault_injection = true;
+}
+
+struct fail_nth_state {
+	int proc_fd;
+	unsigned int iteration;
+};
+
+static void fail_nth_first(struct __test_metadata *_metadata,
+			   struct fail_nth_state *nth_state)
+{
+	char buf[300];
+
+	snprintf(buf, sizeof(buf), "/proc/self/task/%u/fail-nth", getpid());
+	nth_state->proc_fd = open(buf, O_RDWR);
+	ASSERT_NE(-1, nth_state->proc_fd);
+}
+
+static bool fail_nth_next(struct __test_metadata *_metadata,
+			  struct fail_nth_state *nth_state,
+			  int test_result)
+{
+	static const char disable_nth[] = "0";
+	char buf[300];
+
+	/*
+	 * This is just an arbitrary limit based on the current kernel
+	 * situation. Changes in the kernel can dramtically change the number of
+	 * required fault injection sites, so if this hits it doesn't
+	 * necessarily mean a test failure, just that the limit has to be made
+	 * bigger.
+	 */
+	ASSERT_GT(400, nth_state->iteration);
+	if (nth_state->iteration != 0) {
+		ssize_t res;
+		ssize_t res2;
+
+		buf[0] = 0;
+		/*
+		 * Annoyingly disabling the nth can also fail. This means
+		 * the test passed without triggering failure
+		 */
+		res = pread(nth_state->proc_fd, buf, sizeof(buf), 0);
+		if (res == -1 && errno == EFAULT) {
+			buf[0] = '1';
+			buf[1] = '\n';
+			res = 2;
+		}
+
+		res2 = pwrite(nth_state->proc_fd, disable_nth,
+			      ARRAY_SIZE(disable_nth) - 1, 0);
+		if (res2 == -1 && errno == EFAULT) {
+			res2 = pwrite(nth_state->proc_fd, disable_nth,
+				      ARRAY_SIZE(disable_nth) - 1, 0);
+			buf[0] = '1';
+			buf[1] = '\n';
+		}
+		ASSERT_EQ(ARRAY_SIZE(disable_nth) - 1, res2);
+
+		/* printf("  nth %u result=%d nth=%u\n", nth_state->iteration,
+		       test_result, atoi(buf)); */
+		fflush(stdout);
+		ASSERT_LT(1, res);
+		if (res != 2 || buf[0] != '0' || buf[1] != '\n')
+			return false;
+	} else {
+		/* printf("  nth %u result=%d\n", nth_state->iteration,
+		       test_result); */
+	}
+	nth_state->iteration++;
+	return true;
+}
+
+/*
+ * This is called during the test to start failure injection. It allows the test
+ * to do some setup that has already been swept and thus reduce the required
+ * iterations.
+ */
+void __fail_nth_enable(struct __test_metadata *_metadata,
+		       struct fail_nth_state *nth_state)
+{
+	char buf[300];
+	size_t len;
+
+	if (!nth_state->iteration)
+		return;
+
+	len = snprintf(buf, sizeof(buf), "%u", nth_state->iteration);
+	ASSERT_EQ(len, pwrite(nth_state->proc_fd, buf, len, 0));
+}
+#define fail_nth_enable() __fail_nth_enable(_metadata, _nth_state)
+
+#define TEST_FAIL_NTH(fixture_name, name)                                           \
+	static int test_nth_##name(struct __test_metadata *_metadata,               \
+				   FIXTURE_DATA(fixture_name) *self,                \
+				   const FIXTURE_VARIANT(fixture_name)              \
+					   *variant,                                \
+				   struct fail_nth_state *_nth_state);              \
+	TEST_F(fixture_name, name)                                                  \
+	{                                                                           \
+		struct fail_nth_state nth_state = {};                               \
+		int test_result = 0;                                                \
+										    \
+		if (!have_fault_injection)                                          \
+			SKIP(return,                                                \
+				   "fault injection is not enabled in the kernel"); \
+		fail_nth_first(_metadata, &nth_state);                              \
+		ASSERT_EQ(0, test_nth_##name(_metadata, self, variant,              \
+					     &nth_state));                          \
+		while (fail_nth_next(_metadata, &nth_state, test_result)) {         \
+			fixture_name##_teardown(_metadata, self, variant);          \
+			fixture_name##_setup(_metadata, self, variant);             \
+			test_result = test_nth_##name(_metadata, self,              \
+						      variant, &nth_state);         \
+		};                                                                  \
+		ASSERT_EQ(0, test_result);                                          \
+	}                                                                           \
+	static int test_nth_##name(                                                 \
+		struct __test_metadata __attribute__((unused)) *_metadata,          \
+		FIXTURE_DATA(fixture_name) __attribute__((unused)) *self,           \
+		const FIXTURE_VARIANT(fixture_name) __attribute__((unused))         \
+			*variant,                                                   \
+		struct fail_nth_state *_nth_state)
+
+FIXTURE(basic_fail_nth)
+{
+	int fd;
+	uint32_t access_id;
+};
+
+FIXTURE_SETUP(basic_fail_nth)
+{
+	self->fd = -1;
+	self->access_id = 0;
+}
+
+FIXTURE_TEARDOWN(basic_fail_nth)
+{
+	int rc;
+
+	if (self->access_id) {
+		/* The access FD holds the iommufd open until it closes */
+		rc = _test_cmd_destroy_access(self->access_id);
+		assert(rc == 0);
+	}
+	teardown_iommufd(self->fd, _metadata);
+}
+
+/* Cover ioas.c */
+TEST_FAIL_NTH(basic_fail_nth, basic)
+{
+	struct iommu_iova_range ranges[10];
+	uint32_t ioas_id;
+	__u64 iova;
+
+	fail_nth_enable();
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	{
+		struct iommu_ioas_iova_ranges ranges_cmd = {
+			.size = sizeof(ranges_cmd),
+			.num_iovas = ARRAY_SIZE(ranges),
+			.ioas_id = ioas_id,
+			.allowed_iovas = (uintptr_t)ranges,
+		};
+		if (ioctl(self->fd, IOMMU_IOAS_IOVA_RANGES, &ranges_cmd))
+			return -1;
+	}
+
+	{
+		struct iommu_ioas_allow_iovas allow_cmd = {
+			.size = sizeof(allow_cmd),
+			.ioas_id = ioas_id,
+			.num_iovas = 1,
+			.allowed_iovas = (uintptr_t)ranges,
+		};
+
+		ranges[0].start = 16*1024;
+		ranges[0].last = BUFFER_SIZE + 16 * 1024 * 600 - 1;
+		if (ioctl(self->fd, IOMMU_IOAS_ALLOW_IOVAS, &allow_cmd))
+			return -1;
+	}
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	{
+		struct iommu_ioas_copy copy_cmd = {
+			.size = sizeof(copy_cmd),
+			.flags = IOMMU_IOAS_MAP_WRITEABLE |
+				 IOMMU_IOAS_MAP_READABLE,
+			.dst_ioas_id = ioas_id,
+			.src_ioas_id = ioas_id,
+			.src_iova = iova,
+			.length = sizeof(ranges),
+		};
+
+		if (ioctl(self->fd, IOMMU_IOAS_COPY, &copy_cmd))
+			return -1;
+	}
+
+	if (_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE,
+				   NULL))
+		return -1;
+	/* Failure path of no IOVA to unmap */
+	_test_ioctl_ioas_unmap(self->fd, ioas_id, iova, BUFFER_SIZE, NULL);
+	return 0;
+}
+
+/* iopt_area_fill_domains() and iopt_area_fill_domain() */
+TEST_FAIL_NTH(basic_fail_nth, map_domain)
+{
+	uint32_t ioas_id;
+	__u32 device_id;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+	return 0;
+}
+
+TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
+{
+	uint32_t ioas_id;
+	__u32 device_id2;
+	__u32 device_id;
+	__u32 hwpt_id2;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+
+	if (_test_ioctl_destroy(self->fd, device_id2))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id2))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id2, &hwpt_id2))
+		return -1;
+	return 0;
+}
+
+TEST_FAIL_NTH(basic_fail_nth, access_rw)
+{
+	uint64_t tmp_big[4096];
+	uint32_t ioas_id;
+	uint16_t tmp[32];
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id, 0))
+		return -1;
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_RW,
+			.id = self->access_id,
+			.access_rw = { .iova = iova,
+				       .length = sizeof(tmp),
+				       .uptr = (uintptr_t)tmp },
+		};
+
+		// READ
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_WRITE;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_cmd.access_rw.flags = MOCK_ACCESS_RW_SLOW_PATH |
+					     MOCK_ACCESS_RW_WRITE;
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+	}
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_RW,
+			.id = self->access_id,
+			.access_rw = { .iova = iova,
+				       .flags = MOCK_ACCESS_RW_SLOW_PATH,
+				       .length = sizeof(tmp_big),
+				       .uptr = (uintptr_t)tmp_big },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+	}
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+	return 0;
+}
+
+/* pages.c access functions */
+TEST_FAIL_NTH(basic_fail_nth, access_pin)
+{
+	uint32_t access_pages_id;
+	uint32_t ioas_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
+				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
+		return -1;
+
+	fail_nth_enable();
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_PAGES,
+			.id = self->access_id,
+			.access_pages = { .iova = iova,
+					  .length = BUFFER_SIZE,
+					  .uptr = (uintptr_t)buffer },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+	}
+
+	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
+					   access_pages_id))
+		return -1;
+
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+	return 0;
+}
+
+/* iopt_pages_fill_xarray() */
+TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
+{
+	uint32_t access_pages_id;
+	uint32_t ioas_id;
+	__u32 device_id;
+	__u32 hwpt_id;
+	__u64 iova;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
+		return -1;
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, &hwpt_id))
+		return -1;
+
+	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
+				 IOMMU_IOAS_MAP_WRITEABLE |
+					 IOMMU_IOAS_MAP_READABLE))
+		return -1;
+
+	if (_test_cmd_create_access(self->fd, ioas_id, &self->access_id,
+				    MOCK_FLAGS_ACCESS_CREATE_NEEDS_PIN_PAGES))
+		return -1;
+
+	fail_nth_enable();
+
+	{
+		struct iommu_test_cmd access_cmd = {
+			.size = sizeof(access_cmd),
+			.op = IOMMU_TEST_OP_ACCESS_PAGES,
+			.id = self->access_id,
+			.access_pages = { .iova = iova,
+					  .length = BUFFER_SIZE,
+					  .uptr = (uintptr_t)buffer },
+		};
+
+		if (ioctl(self->fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_RW),
+			  &access_cmd))
+			return -1;
+		access_pages_id = access_cmd.access_pages.out_access_pages_id;
+	}
+
+	if (_test_cmd_destroy_access_pages(self->fd, self->access_id,
+					   access_pages_id))
+		return -1;
+
+	if (_test_cmd_destroy_access(self->access_id))
+		return -1;
+	self->access_id = 0;
+
+	if (_test_ioctl_destroy(self->fd, device_id))
+		return -1;
+	if (_test_ioctl_destroy(self->fd, hwpt_id))
+		return -1;
+	return 0;
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
new file mode 100644
index 00000000000000..0d1f46369c2a30
--- /dev/null
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -0,0 +1,278 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES */
+#ifndef __SELFTEST_IOMMUFD_UTILS
+#define __SELFTEST_IOMMUFD_UTILS
+
+#include <unistd.h>
+#include <stddef.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <stdint.h>
+#include <assert.h>
+
+#include "../kselftest_harness.h"
+#include "../../../../drivers/iommu/iommufd/iommufd_test.h"
+
+/* Hack to make assertions more readable */
+#define _IOMMU_TEST_CMD(x) IOMMU_TEST_CMD
+
+static void *buffer;
+static unsigned long BUFFER_SIZE;
+
+/*
+ * Have the kernel check the refcount on pages. I don't know why a freshly
+ * mmap'd anon non-compound page starts out with a ref of 3
+ */
+#define check_refs(_ptr, _length, _refs)                                      \
+	({                                                                    \
+		struct iommu_test_cmd test_cmd = {                            \
+			.size = sizeof(test_cmd),                             \
+			.op = IOMMU_TEST_OP_MD_CHECK_REFS,                    \
+			.check_refs = { .length = _length,                    \
+					.uptr = (uintptr_t)(_ptr),            \
+					.refs = _refs },                      \
+		};                                                            \
+		ASSERT_EQ(0,                                                  \
+			  ioctl(self->fd,                                     \
+				_IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS), \
+				&test_cmd));                                  \
+	})
+
+static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
+				 __u32 *hwpt_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN,
+		.id = ioas_id,
+		.mock_domain = {},
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	if (device_id)
+		*device_id = cmd.mock_domain.out_device_id;
+	assert(cmd.id != 0);
+	if (hwpt_id)
+		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	return 0;
+}
+#define test_cmd_mock_domain(ioas_id, device_id, hwpt_id)                \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, device_id, \
+					   hwpt_id))
+#define test_err_mock_domain(_errno, ioas_id, device_id, hwpt_id)     \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
+						   device_id, hwpt_id))
+
+static int _test_cmd_create_access(int fd, unsigned int ioas_id,
+				   __u32 *access_id, unsigned int flags)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_CREATE_ACCESS,
+		.id = ioas_id,
+		.create_access = { .flags = flags },
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	*access_id = cmd.create_access.out_access_fd;
+	return 0;
+}
+#define test_cmd_create_access(ioas_id, access_id, flags)                  \
+	ASSERT_EQ(0, _test_cmd_create_access(self->fd, ioas_id, access_id, \
+					     flags))
+
+static int _test_cmd_destroy_access(unsigned int access_id)
+{
+	return close(access_id);
+}
+#define test_cmd_destroy_access(access_id) \
+	ASSERT_EQ(0, _test_cmd_destroy_access(access_id))
+
+static int _test_cmd_destroy_access_pages(int fd, unsigned int access_id,
+					  unsigned int access_pages_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_DESTROY_ACCESS_PAGES,
+		.id = access_id,
+		.destroy_access_pages = { .access_pages_id = access_pages_id },
+	};
+	return ioctl(fd, IOMMU_TEST_CMD, &cmd);
+}
+#define test_cmd_destroy_access_pages(access_id, access_pages_id)        \
+	ASSERT_EQ(0, _test_cmd_destroy_access_pages(self->fd, access_id, \
+						    access_pages_id))
+#define test_err_destroy_access_pages(_errno, access_id, access_pages_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_destroy_access_pages(              \
+				     self->fd, access_id, access_pages_id))
+
+static int _test_ioctl_destroy(int fd, unsigned int id)
+{
+	struct iommu_destroy cmd = {
+		.size = sizeof(cmd),
+		.id = id,
+	};
+	return ioctl(fd, IOMMU_DESTROY, &cmd);
+}
+#define test_ioctl_destroy(id) ASSERT_EQ(0, _test_ioctl_destroy(self->fd, id))
+
+static int _test_ioctl_ioas_alloc(int fd, __u32 *id)
+{
+	struct iommu_ioas_alloc cmd = {
+		.size = sizeof(cmd),
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	*id = cmd.out_ioas_id;
+	return 0;
+}
+#define test_ioctl_ioas_alloc(id)                                   \
+	({                                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_alloc(self->fd, id)); \
+		ASSERT_NE(0, *(id));                                \
+	})
+
+static int _test_ioctl_ioas_map(int fd, unsigned int ioas_id, void *buffer,
+				size_t length, __u64 *iova, unsigned int flags)
+{
+	struct iommu_ioas_map cmd = {
+		.size = sizeof(cmd),
+		.flags = flags,
+		.ioas_id = ioas_id,
+		.user_va = (uintptr_t)buffer,
+		.length = length,
+	};
+	int ret;
+
+	if (flags & IOMMU_IOAS_MAP_FIXED_IOVA)
+		cmd.iova = *iova;
+
+	ret = ioctl(fd, IOMMU_IOAS_MAP, &cmd);
+	*iova = cmd.iova;
+	return ret;
+}
+#define test_ioctl_ioas_map(buffer, length, iova_p)                        \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_err_ioctl_ioas_map(_errno, buffer, length, iova_p)            \
+	EXPECT_ERRNO(_errno,                                               \
+		     _test_ioctl_ioas_map(self->fd, self->ioas_id, buffer, \
+					  length, iova_p,                  \
+					  IOMMU_IOAS_MAP_WRITEABLE |       \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_id(ioas_id, buffer, length, iova_p)              \
+	ASSERT_EQ(0, _test_ioctl_ioas_map(self->fd, ioas_id, buffer, length, \
+					  iova_p,                            \
+					  IOMMU_IOAS_MAP_WRITEABLE |         \
+						  IOMMU_IOAS_MAP_READABLE))
+
+#define test_ioctl_ioas_map_fixed(buffer, length, iova)                       \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		ASSERT_EQ(0, _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+#define test_err_ioctl_ioas_map_fixed(_errno, buffer, length, iova)           \
+	({                                                                    \
+		__u64 __iova = iova;                                          \
+		EXPECT_ERRNO(_errno,                                          \
+			     _test_ioctl_ioas_map(                            \
+				     self->fd, self->ioas_id, buffer, length, \
+				     &__iova,                                 \
+				     IOMMU_IOAS_MAP_FIXED_IOVA |              \
+					     IOMMU_IOAS_MAP_WRITEABLE |       \
+					     IOMMU_IOAS_MAP_READABLE));       \
+	})
+
+static int _test_ioctl_ioas_unmap(int fd, unsigned int ioas_id, uint64_t iova,
+				  size_t length, uint64_t *out_len)
+{
+	struct iommu_ioas_unmap cmd = {
+		.size = sizeof(cmd),
+		.ioas_id = ioas_id,
+		.iova = iova,
+		.length = length,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_IOAS_UNMAP, &cmd);
+	if (out_len)
+		*out_len = cmd.length;
+	return ret;
+}
+#define test_ioctl_ioas_unmap(iova, length)                                \
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, iova, \
+					    length, NULL))
+
+#define test_ioctl_ioas_unmap_id(ioas_id, iova, length)                      \
+	ASSERT_EQ(0, _test_ioctl_ioas_unmap(self->fd, ioas_id, iova, length, \
+					    NULL))
+
+#define test_err_ioctl_ioas_unmap(_errno, iova, length)                      \
+	EXPECT_ERRNO(_errno, _test_ioctl_ioas_unmap(self->fd, self->ioas_id, \
+						    iova, length, NULL))
+
+static int _test_ioctl_set_temp_memory_limit(int fd, unsigned int limit)
+{
+	struct iommu_test_cmd memlimit_cmd = {
+		.size = sizeof(memlimit_cmd),
+		.op = IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+		.memory_limit = { .limit = limit },
+	};
+
+	return ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT),
+		     &memlimit_cmd);
+}
+
+#define test_ioctl_set_temp_memory_limit(limit) \
+	ASSERT_EQ(0, _test_ioctl_set_temp_memory_limit(self->fd, limit))
+
+#define test_ioctl_set_default_memory_limit() \
+	test_ioctl_set_temp_memory_limit(65536)
+
+static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
+{
+	struct iommu_test_cmd test_cmd = {
+		.size = sizeof(test_cmd),
+		.op = IOMMU_TEST_OP_MD_CHECK_REFS,
+		.check_refs = { .length = BUFFER_SIZE,
+				.uptr = (uintptr_t)buffer },
+	};
+
+	if (fd == -1)
+		return;
+
+	EXPECT_EQ(0, close(fd));
+
+	fd = open("/dev/iommu", O_RDWR);
+	EXPECT_NE(-1, fd);
+	EXPECT_EQ(0, ioctl(fd, _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_REFS),
+			   &test_cmd));
+	EXPECT_EQ(0, close(fd));
+}
+
+#define EXPECT_ERRNO(expected_errno, cmd)         \
+	({                                        \
+		ASSERT_EQ(-1, cmd);               \
+		EXPECT_EQ(expected_errno, errno); \
+	})
+
+#endif
-- 
2.38.1

