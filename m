Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B240A679072
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jan 2023 06:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbjAXFuz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Jan 2023 00:50:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbjAXFuk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Jan 2023 00:50:40 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F923C28C;
        Mon, 23 Jan 2023 21:50:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSm/3kHBRU0tM8XeZYx+hSJdYgI46Gn/Vi0v09qYJZYLroCZl64ypeiS+1+jp5Ji2V00wkqLceGJxxmoYY30NkS23/tSC2GMHmIfSflJZlgMN9lkEzpqaeQR1RTIkEnSH1HZRmPvK4RuPXLJUrTU1kTW9wbm6teH/Xf/aA10tFpqUV0iUBwLy586Icn0qH6DnygCwZzusIDHbxKQeGLtWC4j70JSF+fxC1C6XiGBHxGtH2O1Yid2G7k1KL7oBi+LEmy4nWbst80olTmwLxmtFMfxPKTVGDft/WGcjvpbqfHyB2SVyxglffmOD8OsF+U63o3IRIAGBbOStT9PMeUp6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGKTTJbiu7jo+yKcPAlQKTQIKt8ia+61r7AgkXzDJs4=;
 b=apamvDn7VYzIigPlZIGjVuHuDL3/R9Z1TRxdP/Z/Ev0qzDRZaIKsg5F8VZxU+KDTQFNjz+3EWLKeUwD6gqlHRWdPUWARaEv3ThF24EeoPxCcx2QqG8lAZQOrEDHmsCcxGQWXrN8YI2sC0nJjOcdleiNRFKxg39CBLhKhp2qAMwQIudisidDE3rahs04qc+GYBdRlS/1HbYl92MyBYQ7Zj2Yehorgd73iEc2w/la50wllNo/vc4mMgIJ4SqL2KG4wDC7PMGfHgH98GbzpuyfpwV7uiednnRuxXSPjsC13/nuDK5jivrHSAM+PxMLMaQvk1oSAGJAvgsq8VBFl/J3C9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGKTTJbiu7jo+yKcPAlQKTQIKt8ia+61r7AgkXzDJs4=;
 b=L9m5dbqSXd5PZ1FXIMuhCAMwXcfHhBscfWWGOTrz7txmi80DMBxphaqvJ6fNZdyb/zMXzHEqHsaH7/w5R2oXo2LCD5Qpm2ozj+4k+TuMQcmO4gZ6JlyFb5OBaT1aEmLqJZEsIjfgEd2+PAUIiXscE9HB7iKGzHOs5b6W2Rvcl6DUY7LJNrnYQlvWC0/P2pBFx5dtCQ0RaCo/rNiTwHFSdKJrQuTKiQUCooU+sJc2hvG7Dv2V+fSHUC7/Z/wVVNbPYm/0Gt/eYNftxiPhheaXJt73FlPdQ0RKV3QmFwpAeXaaEZC9vdaQ9kJbzZrAQNXzR80yVGyOGbPmm3E+2TlYig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by PH7PR12MB7793.namprd12.prod.outlook.com (2603:10b6:510:270::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Tue, 24 Jan
 2023 05:49:01 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::465a:6564:6198:2f4e%4]) with mapi id 15.20.6002.033; Tue, 24 Jan 2023
 05:49:01 +0000
From:   Alistair Popple <apopple@nvidia.com>
To:     linux-mm@kvack.org, cgroups@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jgg@nvidia.com, jhubbard@nvidia.com,
        tjmercier@google.com, hannes@cmpxchg.org, surenb@google.com,
        mkoutny@suse.com, daniel@ffwll.ch,
        Alistair Popple <apopple@nvidia.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 19/19] selftests/vm: Add pins-cgroup selftest for mlock/mmap
Date:   Tue, 24 Jan 2023 16:42:48 +1100
Message-Id: <9e24fb108c8fae43c18e0189d86cbb978848fbb0.1674538665.git-series.apopple@nvidia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
References: <cover.f52b9eb2792bccb8a9ecd6bc95055705cfe2ae03.1674538665.git-series.apopple@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYBPR01CA0014.ausprd01.prod.outlook.com (2603:10c6:10::26)
 To BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3176:EE_|PH7PR12MB7793:EE_
X-MS-Office365-Filtering-Correlation-Id: c9337a78-f259-4c02-d6a4-08dafdceb1cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZW9EVtfJPRnVQsBgUe+SteJC94dgJXjoUvDNPu/QQ+arMxKSzuu42xU6yQFBXsUN9FRqd6n2bz9Hkto7HdQxbbrn2w+EIlvJkF4CF2ieHnLTD7p8EVGsh9oecrXI+bQqwIVfSD3NzkpuLDhbcPydQ6oGn5w1JmzuGRCOpHyKEVoVgmfo4aLIz968XbyZAQqhhNbx3dNgpOKpwIIsuBhxsy11U4k4xT0y6hHo74zWkjYP6gSHbQRz0//e54MsBWfOuT5QlFJqQdxv50zZpyjHFoQT5+G0etKmG2nWjAaC/1aiFzO+NOiSn71PozGXcIf4F180B7ny5HsiUGp8yBq3Ez4Uic1OLdpE5iz1LSDJ7jjARtJXFwr+T2DB1cKITE2hpGpKFsyDgIiKqrBJYwas0wbGsFIUg18aBWU9TDGWBLRxyPEfa4633lLqLSaNd3xgvq3Qhv/3xAs2rREqsHwx1bNmos9iN01lFZgBnCZ0gh/pqO+3rN5QkShHUnDy74GPPkZ8VjbEv3hKy4sr4I2RybuiZB9z0p+wGOok8kkmqR0wnx0yuTiWhQw+ftszDsMJ7yRTwoByR6R+Qj3DnINVVBh0JyGmWD3EW18d1Rp0n+RYFbteYsAQFfIVJ3Y5YRD/OlGfyYFw7xHMfWxoJwMsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(36756003)(316002)(4326008)(66556008)(66476007)(8676002)(86362001)(66946007)(186003)(54906003)(26005)(6512007)(6506007)(6666004)(83380400001)(6486002)(478600001)(2616005)(7416002)(5660300002)(8936002)(41300700001)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WPY+GKUJpF9Y0AnpULiDqZkxL9fEGlflMj2N9kpAorwkvBHXgeupmoy3KTTO?=
 =?us-ascii?Q?bF5bPE00ymFDCmrtr7v6MwFc/OCWb7g3GGxhWc13XvWaETUs699gIOIrj5bB?=
 =?us-ascii?Q?OKGaBZ+0UrkjcJYTFtp+ANM9RdGm8AWcqA9C4T3Az2MjViioXDZl7ArzSnMu?=
 =?us-ascii?Q?v0QmJ21gs4YVnX/ahMTIXLzkQuFiNYKGx6OMcEIzvgQaodR8zyxcjRTOlg7/?=
 =?us-ascii?Q?i+pGKlKWKanPJ6f/GVJb8buyuS5kpAB4r1IIKV6SBaTLumcbT6wVaFBcVZOu?=
 =?us-ascii?Q?UWnkT9k6XUf6ehFWfW8uAj/lncQCw77ucv1S1OWbjYkh3tPI0czSM7+5fhOI?=
 =?us-ascii?Q?SiTJkegqropnn2bxsvBEUgoXm/RQeVGptV+0faOtMfx6GDqrU5sDzaoLEgIW?=
 =?us-ascii?Q?ylM2GHLW6m2CWvojnOeLq4dxDj+IHluIUaOvS8sgWNH/KHud6yX1nMZObNHv?=
 =?us-ascii?Q?sX6IIUmyeiEdKr4QT4PpDruaWT/jptQyXgrmI9j9OycqXqo94g9XD9dNFhKP?=
 =?us-ascii?Q?tsWIws/Bf0OpeNAGrrHUqDcc8RA8EQ6bB+Q78vUHb0tFXpPkpBrN/HAm4KNb?=
 =?us-ascii?Q?KJkWTaijhDVeCcfcUAP5pBwr4qwqf6UE6/bAOnIMPQLs2ij2og9o4fERqgg+?=
 =?us-ascii?Q?tx1KN9mMCTJ8IQ+aYCd+s6sGhBrPJfI/fzAoCORnRaXHPyhz6OE5K70mBRmw?=
 =?us-ascii?Q?1DiYG4kN30OaS/WUj3a7fMjabxYJFYpbX54BIi2BbgJxEQ2jy2jPctAiAizC?=
 =?us-ascii?Q?aw3xX+zvgyvARWB6HSKORxzeQhxWMCDx/Z5WXut/ECOUq8DcrMeRqy3plcna?=
 =?us-ascii?Q?UZKYWVvB1dsxvsL8Y63QOj802W219a8DKMPvBZIWwjRNRc5kNUjJ0v6XtSDm?=
 =?us-ascii?Q?zYn+p1osdjQz/a4tEk9eyDYOyQKJNV92y9cR4sLSEInugPVwSPIDd3q277fV?=
 =?us-ascii?Q?jZjCaDlQZEfv4/0+ndwDxS6Ynq+VjJAz3aZk3F1PRZCfzssDmXi62zCkxeZ0?=
 =?us-ascii?Q?irPWtxQaVAsSlyBkZ5ydpTOBDuICSqM04uBm4cx8cQ0yr2tJm7V6jprvd7na?=
 =?us-ascii?Q?Dp06BE6THrkpSYMqtDi9uKmXz8aPFGsMInssrNNKV7GA1MIrsgYcYXxbRZ0d?=
 =?us-ascii?Q?YrJRSSkOu6WFG3wi3INzByAWhfeHjNgsNztHAAVwAFWsomSUup4PB9R7dnHR?=
 =?us-ascii?Q?w8okvwxlVeNLdVyz5eIQTfRwOrxeTM+tI/CUgPzG8isWUzwH8JagEjlPVdm4?=
 =?us-ascii?Q?NY3BHhcZ9zuWTnkexKdWUzIYOn3pYeO5thf5lkYHuW7uowhNd8Yno05EHfCz?=
 =?us-ascii?Q?CJvxoesVK/8mE9Fl/38ktnFy73/OdJrDuMxYLWrIUQvZ/RXVev9+WFy24rKc?=
 =?us-ascii?Q?+Ll/FtRFCyOuQBYC/kH6InLZTJtvebw5YZzevCPUoA83aiMXO6oTQCmFbpxM?=
 =?us-ascii?Q?r/LZxYEXU8stOQMMDcV198aBaernGD+O6F5bBfIs2upvwTV5ST/gGwChYhP2?=
 =?us-ascii?Q?RRy3MJ1U0zK/qMJp7XCMLs3RNewuYpN6MDkZgRnbUwvI39pyZjOb7Wbm78NT?=
 =?us-ascii?Q?KrYBDGZfyCXKrQ1M9x8aE8ms8kfMbxPCLBdPV/Z1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9337a78-f259-4c02-d6a4-08dafdceb1cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2023 05:49:01.7331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiK5/ZfAfZsxtXsuiINaaaXjWE7hysh0hrsnuQQ4ocrW2fQxsZCoSysuoOPBUCDeJ7DQUYM1n/JX3OpGOc96vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7793
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
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
