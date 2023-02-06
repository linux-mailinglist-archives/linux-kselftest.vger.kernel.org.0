Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795BF68B6E5
	for <lists+linux-kselftest@lfdr.de>; Mon,  6 Feb 2023 08:52:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjBFHwb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 6 Feb 2023 02:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjBFHwX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 6 Feb 2023 02:52:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20603.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::603])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C333D18AA0;
        Sun,  5 Feb 2023 23:51:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Im7MEEVN4FWEx3zCb+jxDxt6oqesrmj8wEvyNhB6xZWYLmNr8YJXfqXWgxp0JvAIIXXdUnrO96MGX7+XrY25hIfkVOGBVsn2Figp5RwnKVNY70RpHmDwh8BhJCEQSoJDTvh9pWSRLJa9mJrdPdI3/timqioSJ2uD8tURUPv571Hfev7ZeKatRw7XEZcFN+Dfl08r4F0Uq+fqLnHaEKJnUOuE4ZGF8WR1sYqFACWL5xks82FH9i91x063H+8KsIGxTQVt0s+3RP9+X2Y+p8t8tPaFR4t/2KDfOMNGR3J+apzlJOvC2Uw8dS2ggut5XjsdygdkpqL6aIKTsa2gpiAu1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGKTTJbiu7jo+yKcPAlQKTQIKt8ia+61r7AgkXzDJs4=;
 b=S3LRHDSF95Tx4J6VA9J6urDze9zWFzHyWsmZiwRPG8JJEaOQOgkPWyZ5TuEI+DHP5JB5ZZfiLSynKg9QXeRz8TyTGWmKjNNGQUdIIiMYxeVZ1rzPnTc6JYwghRZ2SJnqTaP/389fVUpnOhQO1l2UPFGisARyo2Lciofjl+XgzaAJ5k8NSgb/lkKZPNk1RoGyA+h1u8RQklqn3wTZqKzzB5iJ1NFS9ulU19AwzNJZ2p7UQI3DVv48+ewMlfv5bmRLtjhxtXIoQztM8uw2VDRC9ISCSrT8i5KMThjR49aeeUXL6LItBPZ6225fYLdJqNy5OzmqcSmToAQHw65KtyHO5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGKTTJbiu7jo+yKcPAlQKTQIKt8ia+61r7AgkXzDJs4=;
 b=kVvPNwBixSEKdOtpAfVIoKMGsQdXxYk24fgyI253NvLsXcQWCV9659gz3zqc7aYzWX6DrVJfCdezr5YAvVyZt8PlxpG2J5KbszClhFSkw8xAeADMD1gLKJGkafXE9BeTlOAp+Zxs1R6FuJ2t35g4NfxRBbK9CSX9qjPG/A1wkbHG4LJTYm26ACVEBwi/Zx2Co+3SluiTDJTpDHFJv9nk6iX+beV3QuD32Ls4HdQUj33P7Ug/q0oOHp0GypmRt3kaJM57nIfalsiCFYqHdotasEmSHOdlQoYneLf21VI0x26SYY3JMnc58Xfv9QOUq3r3EdpgI4/5wnxUBYQyd69aZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.32; Mon, 6 Feb
 2023 07:50:20 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::4bd4:de67:b676:67df%6]) with mapi id 15.20.6064.032; Mon, 6 Feb 2023
 07:50:20 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        "Daniel P . Berrange" <berrange@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [PATCH 19/19] selftests/vm: Add pins-cgroup selftest for mlock/mmap
Date:   Mon,  6 Feb 2023 18:47:56 +1100
Message-Id: <2bd6038b4a1571631e7797ce0f47a133f52acd9c.1675669136.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
References: <cover.c238416f0e82377b449846dbb2459ae9d7030c8e.1675669136.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0045.ausprd01.prod.outlook.com
 (2603:10c6:10:e::33) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: d11c3ca0-e577-4cea-9a76-08db0816cb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9dWZD2t/+Z7V9QOIUUWaxrSGi0KuhVSIbQ77D2ROgVKVnwxGP52AevErTClN4BqAy21B5fx21j6tBiYlt8u35F60dW8g90c/XKmkVbPhuynbVr6O+4Xghv14ztWgD/29bEkInSoVrxBkn/08YV1MUq9x4RChn3IkP6M+jIQLrUT1scnll48P/ztTwbl0IDBav8icxKqw3/RCPT+PO3kX4NT2mc7s04u7e7KLHTOhOIRxPsusGcYsL6+w1r3dUct98mhm++I1+CKwtb6dFisPWefIHJTICoX53HpZ2KoOnR7lz1J6Kw1jx/cAlLFdzoiygI++gsSkhWTSxui/Jq2ERMn/UjhQYNc3jWXKcgrbJmVfemrw0U84V3963AxNslhkPWNvP3VePQFbPXj+jpugf+QzEUMAZfDn5Uk989t65iJJpKzGdK5zckXmd99UeXwsRYPQXni1J8zzETrAWXnrF4mu2rGw7OHG+AUg4/v0QVWVildJ07/HpedRKRKNeZlmwp2KU+lQBys3n/Bkfu8X/mM/uCdM5GzA5C99yWLxorPDW4JhXFApebCvHSrCvJiQ19m6bFejTrOciu3q1zeRzrRIBNA7BHN+u3vu0JBMwY+JCVbXPHThQ70b+I8B6TaT9LxCml/0t/fhHwHV+NssoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(39860400002)(366004)(346002)(451199018)(54906003)(316002)(86362001)(6666004)(6486002)(38100700002)(186003)(2616005)(6506007)(26005)(478600001)(6512007)(7416002)(5660300002)(83380400001)(2906002)(36756003)(66946007)(8936002)(4326008)(41300700001)(66476007)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3j3ry8KiLXLZp8Riv1ALQgPDVgFrUuvNKw26OWlhJphF7+Hc8o5BbQbqnuN/?=
 =?us-ascii?Q?Nw3ZHBrpWrui2J+NXfFlizPM9vjj8Gkk8/nsxRcdCKXUPkmgg0o4NXntKMUj?=
 =?us-ascii?Q?VdiKtZDSUM7DVOfDJuzX++7b42gLeXteGJCy0kG5kM7z3oXOO++mXFnJ6ii5?=
 =?us-ascii?Q?BDy3tLAhDpWmXTz2ZQDLsDK6+xsmS9o4ZklXY9TxRAIn+bIc8tv8SXNFT/ed?=
 =?us-ascii?Q?9QCyK9PMb1t6a9AfxxeybPrD3Uii//c2x5XJBqhrgs64FkXT6WRwJauYz0Pa?=
 =?us-ascii?Q?PIe5k/PHr5DRpyyXagjbFWiQQXpIQP7jshIefUMXio4CnV1gNyFVfkuhYqAW?=
 =?us-ascii?Q?D/kcukf/vhibTuhuATZCdiJqPGD/ANt+tvqLMRy68GIE3JmimGZOsZPF/iVW?=
 =?us-ascii?Q?wLQAmhGJbzDAp4hDYsPqIyZs6lxGLj6kB6W3AsdFkJoDOcPmAmQtTYsoKZb5?=
 =?us-ascii?Q?DHKF4AGgM+PYmKrl93CqnaQGuuzFwHVNjiZeC1jmTwhdyTnZf4dY3XtV9l+6?=
 =?us-ascii?Q?39GAL/aeIYNjcTjtWDmiPjx/bxvLgQ9WpBc+xwx7dE1C8idBrHUWgr8fBqDY?=
 =?us-ascii?Q?5uFmcPBbvRZRs5HkBCMV7rSDfP6VoEENuNzqOZFoHcTrDBrCySdemrERJHMp?=
 =?us-ascii?Q?14VFyjPf3CoCfDRS9/B0ysJNz9yzSYy/OD0YeXupBzrQ+kuEY/c3alFStwFF?=
 =?us-ascii?Q?6UXLDiugpc2lJ4GotWmF2ANGl1WcCmD6oFbOXZ9Q4O8q6Y95ESbw7YCm5o0w?=
 =?us-ascii?Q?4ymlzSTtu5EitAYdGMIdGgLN725Mkl/D9Is60IXpS0+4GEwnN2tqwD9AzYDU?=
 =?us-ascii?Q?iXaetdkm+Nkd7z/YhkUs+wFMGXJDa27r7b/DPj32HyB8/r8mojOpUQzmZ7on?=
 =?us-ascii?Q?BYXMAC3cqh9KL4DjanR2idx1m3rZMlgP9+Lw/Trucb/WuwIh7SX6gUEZRqd0?=
 =?us-ascii?Q?qnUdwWJjpmt/AF5OkWoFp5F4cW8y4SsQYh5Igw+fN06vC36QFQyRvfkTfE0D?=
 =?us-ascii?Q?ABMGB/C+80//St3vH5q9oezb7vFYz2IQ1DIW8wt39149HssNvsH8iiIPh9eU?=
 =?us-ascii?Q?8KQc8eu9ixy+h1mrcjgNIk3mFI143yXkOwNCP98hh9o5R89QmczzB22Z9rRr?=
 =?us-ascii?Q?j3JQ1JIYTD3xVspAB92wOVC1J2mMc7eK+18NzVOq4I8cNdro+7fmvMnSD5ZA?=
 =?us-ascii?Q?RXPjWA4QkgIBxepfzCncVnjjXMka/EdSrtidSZSbzBDnjNMejFy3+ATZpC4v?=
 =?us-ascii?Q?r0j8/qxN9oc331BV6BUfbWengLNIjpcIq00lNuNsHqPqBg0xJfrjhOzbAILu?=
 =?us-ascii?Q?XT/pDp+V0+rY4mnIJ1er7y/HBolYTQevQz8MowdOUs6g0GSr9bzaOMnNI8ql?=
 =?us-ascii?Q?mADJFoRv50tYLDcfza44pzces2sluUAsK3NnRId7WaB8emV/AFIgHj1ITn4X?=
 =?us-ascii?Q?ornfziLewz5vPTuVaJBEYELm+dHxWkLvCdOt5Tc3gzv6VJg4zcuFKm8xJkag?=
 =?us-ascii?Q?wI2oYfvVuYw2xAuTF3s8AjlPTz3l/PVaWmw1kMtSC1O1S1z3eiQAuzB1e+Xq?=
 =?us-ascii?Q?4C3GcdolcN9UyabSP79S7wsrNNGC09EU0HhObYU9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11c3ca0-e577-4cea-9a76-08db0816cb58
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 07:50:19.9753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KClDenTLQ/TczAn7Sbd3dGzzwGDXykfOgI4zkvGApKdmx3a7WPKSSGaevP2sFCVTgUe7bCPuUu4K9rn6fFxZFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add some basic tests of mlock/mmap cgroup accounting for pinned
memory.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: linux-kselftest@vger.kernel.org
Cc: cgroups@vger.kernel.org
---
 MAINTAINERS                              |   1 +-
 tools/testing/selftests/vm/Makefile      |   1 +-
 tools/testing/selftests/vm/pins-cgroup.c | 271 ++++++++++++++++++++++++-
 3 files changed, 273 insertions(+)
 create mode 100644 tools/testing/selftests/vm/pins-cgroup.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f8526e2..4c4eed9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5387,6 +5387,7 @@ L:	cgroups@vger.kernel.org
 L:	linux-mm@kvack.org
 S:	Maintained
 F:	mm/pins_cgroup.c
+F:	tools/testing/selftests/vm/pins-cgroup.c
 
 CORETEMP HARDWARE MONITORING DRIVER
 M:	Fenghua Yu <fenghua.yu@intel.com>
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 89c14e4..0653720 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -56,6 +56,7 @@ TEST_GEN_PROGS += soft-dirty
 TEST_GEN_PROGS += split_huge_page_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_PROGS += ksm_functional_tests
+TEST_GEN_FILES += pins-cgroup
 
 ifeq ($(MACHINE),x86_64)
 CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
diff --git a/tools/testing/selftests/vm/pins-cgroup.c b/tools/testing/selftests/vm/pins-cgroup.c
new file mode 100644
index 0000000..c2eabc2
--- /dev/null
+++ b/tools/testing/selftests/vm/pins-cgroup.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "../kselftest_harness.h"
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <sys/prctl.h>
+#include <sys/resource.h>
+#include <sys/capability.h>
+#include <unistd.h>
+
+#define CGROUP_TEMP "/sys/fs/cgroup/pins_XXXXXX"
+#define PINS_MAX (-1UL)
+
+FIXTURE(pins_cg)
+{
+	char *cg_path;
+	long page_size;
+};
+
+static char *cgroup_new(void)
+{
+	char *cg;
+
+	cg = malloc(sizeof(CGROUP_TEMP));
+	strcpy(cg, CGROUP_TEMP);
+	if (!mkdtemp(cg)) {
+		perror("Failed to create cgroup");
+		return NULL;
+	}
+
+	return cg;
+}
+
+static int cgroup_add_proc(char *cg, pid_t pid)
+{
+	char *cg_proc;
+	FILE *f;
+	int ret = 0;
+
+	if (asprintf(&cg_proc, "%s/cgroup.procs", cg) < 0)
+		return -1;
+
+	f = fopen(cg_proc, "w");
+	free(cg_proc);
+	if (!f)
+		return -1;
+
+	if (fprintf(f, "%ld\n", (long) pid) < 0)
+		ret = -1;
+
+	fclose(f);
+	return ret;
+}
+
+static int cgroup_set_limit(char *cg, unsigned long limit)
+{
+	char *cg_pins_max;
+	FILE *f;
+	int ret = 0;
+
+	if (asprintf(&cg_pins_max, "%s/pins.max", cg) < 0)
+		return -1;
+
+	f = fopen(cg_pins_max, "w");
+	free(cg_pins_max);
+	if (!f)
+		return -1;
+
+	if (limit != PINS_MAX) {
+		if (fprintf(f, "%ld\n", limit) < 0)
+			ret = -1;
+	} else {
+		if (fprintf(f, "max\n") < 0)
+			ret = -1;
+	}
+
+	fclose(f);
+	return ret;
+}
+
+FIXTURE_SETUP(pins_cg)
+{
+	char *cg_subtree_control;
+	FILE *f;
+
+	if (asprintf(&cg_subtree_control,
+			"/sys/fs/cgroup/cgroup.subtree_control") < 0)
+		return;
+
+	f = fopen(cg_subtree_control, "w");
+	free(cg_subtree_control);
+	if (!f)
+		return;
+
+	fprintf(f, "+pins\n");
+	fclose(f);
+
+	self->cg_path = cgroup_new();
+	self->page_size = sysconf(_SC_PAGE_SIZE);
+}
+
+FIXTURE_TEARDOWN(pins_cg)
+{
+	cgroup_add_proc("/sys/fs/cgroup", getpid());
+
+	rmdir(self->cg_path);
+	free(self->cg_path);
+}
+
+static long cgroup_pins(char *cg)
+{
+	long pin_count;
+	char *cg_pins_current;
+	FILE *f;
+	int ret;
+
+	if (asprintf(&cg_pins_current, "%s/pins.current", cg) < 0)
+		return -1;
+
+	f = fopen(cg_pins_current, "r");
+	if (!f) {
+		printf("Can't open %s\n", cg_pins_current);
+		getchar();
+		free(cg_pins_current);
+		return -2;
+	}
+
+	free(cg_pins_current);
+
+	if (fscanf(f, "%ld", &pin_count) == EOF)
+		ret = -3;
+	else
+		ret = pin_count;
+
+	fclose(f);
+	return ret;
+}
+
+static int set_rlim_memlock(unsigned long size)
+{
+	struct rlimit rlim_memlock = {
+		.rlim_cur = size,
+		.rlim_max = size,
+	};
+	cap_t cap;
+	cap_value_t capability[1] = { CAP_IPC_LOCK };
+
+	/*
+	 * Many of the rlimit checks are skipped if a process has
+	 * CAP_IP_LOCK. As this test should be run as root we need to
+	 * explicitly drop it.
+	 */
+	cap = cap_get_proc();
+	if (!cap)
+		return -1;
+	if (cap_set_flag(cap, CAP_EFFECTIVE, 1, capability, CAP_CLEAR))
+		return -1;
+	if (cap_set_proc(cap))
+		return -1;
+	return setrlimit(RLIMIT_MEMLOCK, &rlim_memlock);
+}
+
+TEST_F(pins_cg, basic)
+{
+	pid_t child_pid;
+	long page_size = self->page_size;
+	char *p;
+
+	ASSERT_EQ(cgroup_add_proc(self->cg_path, getpid()), 0);
+	p = mmap(NULL, 32*page_size, PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(p, MAP_FAILED);
+
+	ASSERT_EQ(cgroup_pins(self->cg_path), 0);
+	memset(p, 0, 16*page_size);
+	ASSERT_EQ(mlock(p, page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 1);
+	ASSERT_EQ(mlock(p + page_size, page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 2);
+	ASSERT_EQ(mlock(p, page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 2);
+	ASSERT_EQ(mlock(p, 4*page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 4);
+	ASSERT_EQ(munlock(p + 2*page_size, 2*page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 2);
+	ASSERT_EQ(cgroup_set_limit(self->cg_path, 8), 0);
+	ASSERT_EQ(mlock(p, 16*page_size), -1);
+	ASSERT_EQ(errno, ENOMEM);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 2);
+	ASSERT_EQ(cgroup_set_limit(self->cg_path, PINS_MAX), 0);
+
+	/* check mremap() a locked region correctly accounts locked pages */
+	ASSERT_EQ(mlock(p, 32*page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 32);
+	p = mremap(p, 32*page_size, 64*page_size, MREMAP_MAYMOVE);
+	ASSERT_NE(p, MAP_FAILED);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 64);
+	ASSERT_EQ(munmap(p + 32*page_size, 32*page_size), 0)
+	ASSERT_EQ(cgroup_pins(self->cg_path), 32);
+	p = mremap(p, 32*page_size, 32*page_size, MREMAP_MAYMOVE | MREMAP_DONTUNMAP);
+	ASSERT_NE(p, MAP_FAILED);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 32);
+	ASSERT_EQ(munlock(p, 32*page_size), 0);
+
+	/* mremap() a locked region should fail if limit exceeded */
+	ASSERT_EQ(set_rlim_memlock(32*page_size), 0);
+	ASSERT_EQ(mlock(p, 32*page_size), 0);
+	ASSERT_EQ(mremap(p, 32*page_size, 64*page_size, 0), MAP_FAILED);
+	ASSERT_EQ(munlock(p, 32*page_size), 0);
+
+	/* Exceeds rlimit, expected to fail */
+	ASSERT_EQ(set_rlim_memlock(16*page_size), 0);
+	ASSERT_EQ(mlock(p, 32*page_size), -1);
+	ASSERT_EQ(errno, ENOMEM);
+
+	/* memory in the child isn't locked so shouldn't increase pin_cg count */
+	ASSERT_EQ(mlock(p, 16*page_size), 0);
+	child_pid = fork();
+	if (!child_pid) {
+		ASSERT_EQ(cgroup_pins(self->cg_path), 16);
+		ASSERT_EQ(mlock(p, 16*page_size), 0);
+		ASSERT_EQ(cgroup_pins(self->cg_path), 32);
+		return;
+
+	}
+	waitpid(child_pid, NULL, 0);
+
+	/* check that child exit uncharged the pins */
+	ASSERT_EQ(cgroup_pins(self->cg_path), 16);
+}
+
+TEST_F(pins_cg, mmap)
+{
+	char *p;
+
+	ASSERT_EQ(cgroup_add_proc(self->cg_path, getpid()), 0);
+	p = mmap(NULL, 4*self->page_size, PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE | MAP_LOCKED, -1, 0);
+	ASSERT_NE(p, MAP_FAILED);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 4);
+}
+
+/*
+ * Test moving to a different cgroup.
+ */
+TEST_F(pins_cg, move_cg)
+{
+	char *p, *new_cg;
+
+	ASSERT_EQ(cgroup_add_proc(self->cg_path, getpid()), 0);
+	p = mmap(NULL, 16*self->page_size, PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	ASSERT_NE(p, MAP_FAILED);
+	memset(p, 0, 16*self->page_size);
+	ASSERT_EQ(mlock(p, 16*self->page_size), 0);
+	ASSERT_EQ(cgroup_pins(self->cg_path), 16);
+	ASSERT_NE(new_cg = cgroup_new(), NULL);
+	ASSERT_EQ(cgroup_add_proc(new_cg, getpid()), 0);
+	ASSERT_EQ(cgroup_pins(new_cg), 16);
+	ASSERT_EQ(cgroup_add_proc(self->cg_path, getpid()), 0);
+	rmdir(new_cg);
+}
+TEST_HARNESS_MAIN
-- 
git-series 0.9.1
