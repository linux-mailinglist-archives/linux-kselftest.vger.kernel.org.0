Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC5745F0F2
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378293AbhKZPqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:46:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:26369 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346500AbhKZPoU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:44:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637941267; x=1669477267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Dux3wo0FAozbYqJip+sXv5CE0sOpu9PGfSBNcXtaU2c=;
  b=SHUdYL5auaiE5wwDV4pRutFcIIvx8W18KhdEDmxZ1HbriJTUDq0mb6BP
   FjsR0p+O8fa7dAKXVMepmcx5ZNE80oxGzq9yDBQlVt4xia/a8QwbRVsTd
   9FNowehNYoFc9/65erJGG3K56j/fIBkWC73GR+QUewH3bwsgliQh2emg1
   HMFD2DD2M1j3FJm+a1r+vexLlnYKZ+kJSQlaukTC5nbFgNPF3wJJloVPy
   WpeYcsZ1/Lg5oBhgigNPWgscozt5riwvmMXUaxkLlyqAk/64X4fIQX5Mc
   V9HET2ymgn6gbEtLpVKCelh2ARzJR8+8J9t8RUhKgJz3a/PDOwFBPvEOE
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="186749396"
Received: from mail-mw2nam10lp2100.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.100])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 23:41:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4M4I2MLNX0ZlrnV7mouyFFvRaTdR8TSc+QIlBnOvqGeTAOGFL7++RLLS6BSkW25M3WHSrLkapaOdZDAxXn61GeIBHctgMyGJM8yNlxJpCcZnmgAGZYjcP34m30JhdeK2h0fr1Ab8ehYq0fy51068GMVmZla4kogyI6jrOw1TD+S7rOeQLFnGjMIGyFtwFbvUaO7OnTaru2T4YRDdGizOqgYJaD/bjrcHDTqicxDThFAeBvsWUFZhZXHkJeAlks60qLLer/MOBkEXKrRrwsdSMtb45Aktuqt0Doc4HXywhL5T7qOIY01LpMi6Et6YVMIt+RsTcjeRdZ6FywIuZKChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr7eizanvc1LDHz+mWq1ok6UH6cJxQIacC3czFLZ2j0=;
 b=JoeMqWijNu9dNQQccDKj9VIBuSpI/YsbVeqAC1Imi6SaEyS/ZX+GG96a0hz4t6sBr8z0OGS1TFqNrf7oaQewk+tco5y2H88Y+JBB2nc9vLuFr6FjzWKE0nFfnGT/qji8eAt1V/AGmm9lEb/G/jSu7QOByZCKZz0VQfmpEq+EE1prPjW/4t6psMZy7/iUS0T5yNUVYupZz/W/4hRuZ+tS8ju2A4Xmjau5jhGb5FoHEwiifHImMtOc7u13+Af3I+xVghDBnTdG2q4Z8sotw8eCSWCD9OwbYWRUMxP4OpTdz7527chUKfqVHRU4Cg8aqTELhX8RO3jlpYoqMtrWPmZ06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr7eizanvc1LDHz+mWq1ok6UH6cJxQIacC3czFLZ2j0=;
 b=CjePavTnC0BMry/RTnjRvGXO6V1/3nbSl4Lqcn6bWNwrB8WdB800P3T1R/OkysvJuMTz7oCTO+K88oRvqKq9cpJvI1nIegYAZwHphG3qVAg4uMjN2Ey7s70pSle0mAGsEHrQ+zW3cl2HogRFSB4gNs7s12akfh3K07SCa8U+S1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 15:41:05 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:41:05 +0000
From:   Anup Patel <anup.patel@wdc.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Atish Patra <atishp@atishpatra.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Anup Patel <anup.patel@wdc.com>
Subject: [PATCH 4/4] KVM: selftests: Add initial support for RISC-V 64-bit
Date:   Fri, 26 Nov 2021 21:10:20 +0530
Message-Id: <20211126154020.342924-5-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126154020.342924-1-anup.patel@wdc.com>
References: <20211126154020.342924-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.118.153) by MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:41:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e068b0aa-0dc1-40cd-30ab-08d9b0f3288d
X-MS-TrafficTypeDiagnostic: CO6PR04MB8330:
X-Microsoft-Antispam-PRVS: <CO6PR04MB8330DFC1F85E968D16F3DBB08D639@CO6PR04MB8330.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QwsQa+AtyODjeG9QueWI8M/H7nNGngpfW4cw3Duvwq9egy4cwu5npCw3CBCa/lRVe0hDS7B1u9AvwD/ql5MoAnHaj18CpbHrH4jp5CaeUJbySRTGePs0qKhOGXJoS4KpxU6sekGj3j3iUGFW9dqEgrd50htOuAAjB9H+SSwoXP7MRAJJOQqFrNzZSlQDmbAktWv9QN0KMCe/edz38wr8Nte+e7ZIVoInEMvLIiURE+VXTcBcpzqKmGZf6pR/WptvCD2JW0XuetsUKKFoNJKdZVmaUk2wtuy/n9QvfRkQIEiWVtw+jxCa9jg0h/RNv6qVDsYVNAWK+vLupjKfYdmoPFrISWLLXwhZO9b8HkJBqzGrq2+OAxj7/b0G9em9EG1GbCHA1sH8MvTsUBrzxyyBtY5ODnT+FEzogUd+wQUpusR5dm/fdmY8Pgqjh9fxrIYXK/Fj8Y8enU9F0Nx6Xo3C0VdBgKc2FxRM5q4ls5uapG522468FVYQE1Se8n+UA4KvO5He8idwcxUdv+EM2v7asrWFSc7q582Ek/BjNpBVjSJRybRY9t9Rq5tzdvAb73O4AldTPklDus9pxT18yrFwEgv79iCrzsGg5RtpSuNxtSup59h6NqX2NUF9gsJrI62ZlBzth9zH4r+D6vH7h5jrBStGfbUEjn0d/9qzeIXfCf0PuIZ1QN16GViXKrPCK894wTcuQgEoPtM0xlwiOdzeUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(54906003)(66946007)(110136005)(38350700002)(82960400001)(26005)(66556008)(186003)(30864003)(44832011)(83380400001)(316002)(6666004)(86362001)(7696005)(956004)(2616005)(7416002)(52116002)(508600001)(2906002)(5660300002)(36756003)(55016003)(8886007)(38100700002)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+qQGtwSVsmVPDgrX/imt3oGjcajchWjSJMLgQFFfAo3HANX6dwY6IzrdEvRl?=
 =?us-ascii?Q?1nB48yzzJHeiU0tmiQSKxOKA9zk/hYoENKR5Jd2FTvKsbVaTC3E2taIObc1Y?=
 =?us-ascii?Q?ZW/b1yswy2ed/vRXIZ3b2LWUfqh+v5GpNPYYoTpgSDe2dw9GNQCfiDPf0JD9?=
 =?us-ascii?Q?7WOeDmtckIbWp3Dj1XsWGUwGhhI6S89hJJv5M0sdVjuKu9Zb4HgXKuOzdxpM?=
 =?us-ascii?Q?KCahjc6JoKVCibqSOWycy8u9dV+5NTBwU4HFALjCh0djqkKuxoeYD7us5ahH?=
 =?us-ascii?Q?CVWfTzyjMMfSvb3iP5+NDQAz9ZHMEtTtCeuwXSJGmigGWhpTtL3EZphTi7Zr?=
 =?us-ascii?Q?z98J5Oys6B+Z4a9FQoFRDhpq1agwDKuUeGmntQocMWqoJt60KjGPBkIfZM48?=
 =?us-ascii?Q?fD72uLptTsF3jt+RKKUGiWiCyGxEu9xYD1dNzBdVvHfitPelrGet6whRCwFK?=
 =?us-ascii?Q?28B5I+36jhSIR0YUHZ4itW1o8hEXAaoLQLEASSgQapc9FR1dmcvW8qKn15dW?=
 =?us-ascii?Q?3zMwISruunqD5hBiZvpfSVA6hmDvQmGxe3uUr4E1XWby2Bw02eFaYRife//m?=
 =?us-ascii?Q?MTXCpMlw0iQCCVgbSy/kKx7P7rgXQSA1clTL/WXrn+fMTXh2tZ8170/ja6/Q?=
 =?us-ascii?Q?nUVOHwWQMej3rkv6s6+GvFAnVmsCNLn0kLZV8DvtHVmPf652uiKEMFdoFm/b?=
 =?us-ascii?Q?2lD6TZEQAKd7pXK4SLcCbkiGKFw41fsyl24ER+bRdWWHrPmE3lsMq2zBmSqc?=
 =?us-ascii?Q?jAokHstSIF6986AIwh/DTDvO93hCdhqzzQxLzPReJDOYUbZyMe0rmftXOwNp?=
 =?us-ascii?Q?o9TkTjMy1bmAHEwnZomMZF/19tpzzmJFR7sAhdUfaswMOZ20i9euiLs+gOOb?=
 =?us-ascii?Q?ImIUNg5LWMRBXYm/6rMUYSFm0Yq63ME0gZbEZomWxcpO1rSM4mPgUYeqEk4Z?=
 =?us-ascii?Q?ZrFj5rQh3JMhrQqlXVEztFmXwzhTQqmn1LB7hRUhtzr7Lwitb3UuGzLqsQ6B?=
 =?us-ascii?Q?+j4gbPBnBAKNffrxQWJXeLwAO70ezs312UHdpl84TMd8RIg5uMqpY4JH9zOH?=
 =?us-ascii?Q?LQK/wbCCJMgabghNZ71kcKwtFW2nVzdWTdkfijP9gXuzqZW2MFbx7eMIK6AP?=
 =?us-ascii?Q?RTqUHH9XCkle0MJ/Nagq0tASHx97u668yWBxkkWOmYJz44/lghrkkB1pjCOd?=
 =?us-ascii?Q?vgqGcrAVzBR2FhxF90Wq0IXoUkiptQyLoLg3SgBnZk8JwEpyp8rPlOPBX7ZV?=
 =?us-ascii?Q?hXAPbJ5fv8/KsevTKhYoYBwMar/w5PUvV/yQ+XgM15yaZix7uqcaBB8XS6ss?=
 =?us-ascii?Q?K5y0bzrgau/8UtR0I7kAM6dhr8PCya9be7YREBmUNIdNxg6Ln5fqyrSpgvhL?=
 =?us-ascii?Q?/544eNzB3nSUJT6paQSgBK5mewm+9NLcp34blq/sGqFcmiXW8hYfwQw8C3D7?=
 =?us-ascii?Q?eCJEuny+DhHHLEkZiICrKEl7ymiSFka3i+bfDLa72pU6f5h2yDiDk4lokFWD?=
 =?us-ascii?Q?OGjE4+VSsLd5aJ1XvBTtQX31ArD/oe+XuY2nqkw9UtnMNBnAiXNtc1YX/oWW?=
 =?us-ascii?Q?+ctIbG+D7rNGbGD5ggfKKSdudPwEXjmXR9u+7YM2xUNSQZLul5I423GdWw9+?=
 =?us-ascii?Q?IgdzUAfqknWgJH2uusk9rVo=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e068b0aa-0dc1-40cd-30ab-08d9b0f3288d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:41:05.6615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sm+5+/sSyJJH8XiruoZE0OSrINJBrRHAgeOohaAFtlae5IU77LLxoD77x1/fQV7CUpxA4u8gbwp2/5yRIJCKtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We add initial support for RISC-V 64-bit in KVM selftests using
which we can cross-compile and run arch independent tests such as:
demand_paging_test
dirty_log_test
kvm_create_max_vcpus,
kvm_page_table_test
set_memory_region_test
kvm_binary_stats_test

All VM guest modes defined in kvm_util.h require at least 48-bit
guest virtual address so to use KVM RISC-V selftests hardware
need to support at least Sv48 MMU for guest (i.e. VS-mode).

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 tools/testing/selftests/kvm/Makefile          |  12 +
 .../testing/selftests/kvm/include/kvm_util.h  |  10 +
 .../selftests/kvm/include/riscv/processor.h   | 135 +++++++
 tools/testing/selftests/kvm/lib/guest_modes.c |  10 +
 .../selftests/kvm/lib/riscv/processor.c       | 362 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/riscv/ucall.c |  87 +++++
 6 files changed, 616 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/riscv/processor.h
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/processor.c
 create mode 100644 tools/testing/selftests/kvm/lib/riscv/ucall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ee6740e9ecdb..2d825d1e7ff2 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,11 +32,16 @@ endif
 ifeq ($(ARCH),s390)
 	UNAME_M := s390x
 endif
+# Set UNAME_M riscv compile/install to work
+ifeq ($(ARCH),riscv)
+	UNAME_M := riscv
+endif
 
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/rbtree.c lib/sparsebit.c lib/test_util.c lib/guest_modes.c lib/perf_test_util.c
 LIBKVM_x86_64 = lib/x86_64/apic.c lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c lib/x86_64/handlers.S
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c lib/aarch64/handlers.S lib/aarch64/spinlock.c lib/aarch64/gic.c lib/aarch64/gic_v3.c lib/aarch64/vgic.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
+LIBKVM_riscv = lib/riscv/processor.c lib/riscv/ucall.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
@@ -117,6 +122,13 @@ TEST_GEN_PROGS_s390x += rseq_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
 TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
+TEST_GEN_PROGS_riscv += demand_paging_test
+TEST_GEN_PROGS_riscv += dirty_log_test
+TEST_GEN_PROGS_riscv += kvm_create_max_vcpus
+TEST_GEN_PROGS_riscv += kvm_page_table_test
+TEST_GEN_PROGS_riscv += set_memory_region_test
+TEST_GEN_PROGS_riscv += kvm_binary_stats_test
+
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 6a1a37f30494..c23e5be14862 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -69,6 +69,16 @@ enum vm_guest_mode {
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 16)
 
+#elif defined(__riscv)
+
+#if __riscv_xlen == 32
+#error "RISC-V 32-bit kvm selftests not supported"
+#endif
+
+#define VM_MODE_DEFAULT			VM_MODE_P40V48_4K
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
 #endif
 
 #define MIN_PAGE_SIZE		(1U << MIN_PAGE_SHIFT)
diff --git a/tools/testing/selftests/kvm/include/riscv/processor.h b/tools/testing/selftests/kvm/include/riscv/processor.h
new file mode 100644
index 000000000000..dc284c6bdbc3
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/riscv/processor.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RISC-V processor specific defines
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#include "kvm_util.h"
+#include <linux/stringify.h>
+
+static inline uint64_t __kvm_reg_id(uint64_t type, uint64_t idx,
+				    uint64_t  size)
+{
+	return KVM_REG_RISCV | type | idx | size;
+}
+
+#if __riscv_xlen == 64
+#define KVM_REG_SIZE_ULONG	KVM_REG_SIZE_U64
+#else
+#define KVM_REG_SIZE_ULONG	KVM_REG_SIZE_U32
+#endif
+
+#define RISCV_CONFIG_REG(name)	__kvm_reg_id(KVM_REG_RISCV_CONFIG, \
+					     KVM_REG_RISCV_CONFIG_REG(name), \
+					     KVM_REG_SIZE_ULONG)
+
+#define RISCV_CORE_REG(name)	__kvm_reg_id(KVM_REG_RISCV_CORE, \
+					     KVM_REG_RISCV_CORE_REG(name), \
+					     KVM_REG_SIZE_ULONG)
+
+#define RISCV_CSR_REG(name)	__kvm_reg_id(KVM_REG_RISCV_CSR, \
+					     KVM_REG_RISCV_CSR_REG(name), \
+					     KVM_REG_SIZE_ULONG)
+
+#define RISCV_TIMER_REG(name)	__kvm_reg_id(KVM_REG_RISCV_TIMER, \
+					     KVM_REG_RISCV_TIMER_REG(name), \
+					     KVM_REG_SIZE_U64)
+
+static inline void get_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id,
+			   unsigned long *addr)
+{
+	struct kvm_one_reg reg;
+
+	reg.id = id;
+	reg.addr = (unsigned long)addr;
+	vcpu_get_reg(vm, vcpuid, &reg);
+}
+
+static inline void set_reg(struct kvm_vm *vm, uint32_t vcpuid, uint64_t id,
+			   unsigned long val)
+{
+	struct kvm_one_reg reg;
+
+	reg.id = id;
+	reg.addr = (unsigned long)&val;
+	vcpu_set_reg(vm, vcpuid, &reg);
+}
+
+/* L3 index Bit[47:39] */
+#define PGTBL_L3_INDEX_MASK			0x0000FF8000000000ULL
+#define PGTBL_L3_INDEX_SHIFT			39
+#define PGTBL_L3_BLOCK_SHIFT			39
+#define PGTBL_L3_BLOCK_SIZE			0x0000008000000000ULL
+#define PGTBL_L3_MAP_MASK			(~(PGTBL_L3_BLOCK_SIZE - 1))
+/* L2 index Bit[38:30] */
+#define PGTBL_L2_INDEX_MASK			0x0000007FC0000000ULL
+#define PGTBL_L2_INDEX_SHIFT			30
+#define PGTBL_L2_BLOCK_SHIFT			30
+#define PGTBL_L2_BLOCK_SIZE			0x0000000040000000ULL
+#define PGTBL_L2_MAP_MASK			(~(PGTBL_L2_BLOCK_SIZE - 1))
+/* L1 index Bit[29:21] */
+#define PGTBL_L1_INDEX_MASK			0x000000003FE00000ULL
+#define PGTBL_L1_INDEX_SHIFT			21
+#define PGTBL_L1_BLOCK_SHIFT			21
+#define PGTBL_L1_BLOCK_SIZE			0x0000000000200000ULL
+#define PGTBL_L1_MAP_MASK			(~(PGTBL_L1_BLOCK_SIZE - 1))
+/* L0 index Bit[20:12] */
+#define PGTBL_L0_INDEX_MASK			0x00000000001FF000ULL
+#define PGTBL_L0_INDEX_SHIFT			12
+#define PGTBL_L0_BLOCK_SHIFT			12
+#define PGTBL_L0_BLOCK_SIZE			0x0000000000001000ULL
+#define PGTBL_L0_MAP_MASK			(~(PGTBL_L0_BLOCK_SIZE - 1))
+
+#define PGTBL_PTE_ADDR_MASK			0x003FFFFFFFFFFC00ULL
+#define PGTBL_PTE_ADDR_SHIFT			10
+#define PGTBL_PTE_RSW_MASK			0x0000000000000300ULL
+#define PGTBL_PTE_RSW_SHIFT			8
+#define PGTBL_PTE_DIRTY_MASK			0x0000000000000080ULL
+#define PGTBL_PTE_DIRTY_SHIFT			7
+#define PGTBL_PTE_ACCESSED_MASK			0x0000000000000040ULL
+#define PGTBL_PTE_ACCESSED_SHIFT		6
+#define PGTBL_PTE_GLOBAL_MASK			0x0000000000000020ULL
+#define PGTBL_PTE_GLOBAL_SHIFT			5
+#define PGTBL_PTE_USER_MASK			0x0000000000000010ULL
+#define PGTBL_PTE_USER_SHIFT			4
+#define PGTBL_PTE_EXECUTE_MASK			0x0000000000000008ULL
+#define PGTBL_PTE_EXECUTE_SHIFT			3
+#define PGTBL_PTE_WRITE_MASK			0x0000000000000004ULL
+#define PGTBL_PTE_WRITE_SHIFT			2
+#define PGTBL_PTE_READ_MASK			0x0000000000000002ULL
+#define PGTBL_PTE_READ_SHIFT			1
+#define PGTBL_PTE_PERM_MASK			(PGTBL_PTE_EXECUTE_MASK | \
+						 PGTBL_PTE_WRITE_MASK | \
+						 PGTBL_PTE_READ_MASK)
+#define PGTBL_PTE_VALID_MASK			0x0000000000000001ULL
+#define PGTBL_PTE_VALID_SHIFT			0
+
+#define PGTBL_PAGE_SIZE				PGTBL_L0_BLOCK_SIZE
+#define PGTBL_PAGE_SIZE_SHIFT			PGTBL_L0_BLOCK_SHIFT
+
+#define SATP_PPN				_AC(0x00000FFFFFFFFFFF, UL)
+#define SATP_MODE_39				_AC(0x8000000000000000, UL)
+#define SATP_MODE_48				_AC(0x9000000000000000, UL)
+#define SATP_ASID_BITS				16
+#define SATP_ASID_SHIFT				44
+#define SATP_ASID_MASK				_AC(0xFFFF, UL)
+
+#define SBI_EXT_EXPERIMENTAL_START	0x08000000
+#define SBI_EXT_EXPERIMENTAL_END	0x08FFFFFF
+
+#define KVM_RISCV_SELFTESTS_SBI_EXT	SBI_EXT_EXPERIMENTAL_END
+
+struct sbiret {
+	long error;
+	long value;
+};
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5);
+
+#endif /* SELFTEST_KVM_PROCESSOR_H */
diff --git a/tools/testing/selftests/kvm/lib/guest_modes.c b/tools/testing/selftests/kvm/lib/guest_modes.c
index c330f414ef96..6847f9905ddb 100644
--- a/tools/testing/selftests/kvm/lib/guest_modes.c
+++ b/tools/testing/selftests/kvm/lib/guest_modes.c
@@ -38,6 +38,16 @@ void guest_modes_append_default(void)
 			guest_mode_append(VM_MODE_P47V64_4K, true, true);
 	}
 #endif
+#ifdef __riscv
+	{
+		unsigned int sz = kvm_check_cap(KVM_CAP_RISCV_VM_GPA_SIZE);
+
+		if (sz >= 52)
+			guest_mode_append(VM_MODE_P52V48_4K, true, true);
+		if (sz >= 48)
+			guest_mode_append(VM_MODE_P48V48_4K, true, true);
+	}
+#endif
 }
 
 void for_each_guest_mode(void (*func)(enum vm_guest_mode, void *), void *arg)
diff --git a/tools/testing/selftests/kvm/lib/riscv/processor.c b/tools/testing/selftests/kvm/lib/riscv/processor.c
new file mode 100644
index 000000000000..d377f2603d98
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/riscv/processor.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V code
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/compiler.h>
+#include <assert.h>
+
+#include "kvm_util.h"
+#include "../kvm_util_internal.h"
+#include "processor.h"
+
+#define DEFAULT_RISCV_GUEST_STACK_VADDR_MIN	0xac0000
+
+static uint64_t page_align(struct kvm_vm *vm, uint64_t v)
+{
+	return (v + vm->page_size) & ~(vm->page_size - 1);
+}
+
+static uint64_t pte_addr(struct kvm_vm *vm, uint64_t entry)
+{
+	return ((entry & PGTBL_PTE_ADDR_MASK) >> PGTBL_PTE_ADDR_SHIFT) <<
+		PGTBL_PAGE_SIZE_SHIFT;
+}
+
+static uint64_t ptrs_per_pte(struct kvm_vm *vm)
+{
+	return PGTBL_PAGE_SIZE / sizeof(uint64_t);
+}
+
+static uint64_t pte_index_mask[] = {
+	PGTBL_L0_INDEX_MASK,
+	PGTBL_L1_INDEX_MASK,
+	PGTBL_L2_INDEX_MASK,
+	PGTBL_L3_INDEX_MASK,
+};
+
+static uint32_t pte_index_shift[] = {
+	PGTBL_L0_INDEX_SHIFT,
+	PGTBL_L1_INDEX_SHIFT,
+	PGTBL_L2_INDEX_SHIFT,
+	PGTBL_L3_INDEX_SHIFT,
+};
+
+static uint64_t pte_index(struct kvm_vm *vm, vm_vaddr_t gva, int level)
+{
+	TEST_ASSERT(level > -1,
+		"Negative page table level (%d) not possible", level);
+	TEST_ASSERT(level < vm->pgtable_levels,
+		"Invalid page table level (%d)", level);
+
+	return (gva & pte_index_mask[level]) >> pte_index_shift[level];
+}
+
+void virt_pgd_alloc(struct kvm_vm *vm)
+{
+	if (!vm->pgd_created) {
+		vm_paddr_t paddr = vm_phy_pages_alloc(vm,
+			page_align(vm, ptrs_per_pte(vm) * 8) / vm->page_size,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+		vm->pgd = paddr;
+		vm->pgd_created = true;
+	}
+}
+
+void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
+{
+	uint64_t *ptep, next_ppn;
+	int level = vm->pgtable_levels - 1;
+
+	TEST_ASSERT((vaddr % vm->page_size) == 0,
+		"Virtual address not on page boundary,\n"
+		"  vaddr: 0x%lx vm->page_size: 0x%x", vaddr, vm->page_size);
+	TEST_ASSERT(sparsebit_is_set(vm->vpages_valid,
+		(vaddr >> vm->page_shift)),
+		"Invalid virtual address, vaddr: 0x%lx", vaddr);
+	TEST_ASSERT((paddr % vm->page_size) == 0,
+		"Physical address not on page boundary,\n"
+		"  paddr: 0x%lx vm->page_size: 0x%x", paddr, vm->page_size);
+	TEST_ASSERT((paddr >> vm->page_shift) <= vm->max_gfn,
+		"Physical address beyond maximum supported,\n"
+		"  paddr: 0x%lx vm->max_gfn: 0x%lx vm->page_size: 0x%x",
+		paddr, vm->max_gfn, vm->page_size);
+
+	ptep = addr_gpa2hva(vm, vm->pgd) + pte_index(vm, vaddr, level) * 8;
+	if (!*ptep) {
+		next_ppn = vm_alloc_page_table(vm) >> PGTBL_PAGE_SIZE_SHIFT;
+		*ptep = (next_ppn << PGTBL_PTE_ADDR_SHIFT) |
+			PGTBL_PTE_VALID_MASK;
+	}
+	level--;
+
+	while (level > -1) {
+		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) +
+		       pte_index(vm, vaddr, level) * 8;
+		if (!*ptep && level > 0) {
+			next_ppn = vm_alloc_page_table(vm) >>
+				   PGTBL_PAGE_SIZE_SHIFT;
+			*ptep = (next_ppn << PGTBL_PTE_ADDR_SHIFT) |
+				PGTBL_PTE_VALID_MASK;
+		}
+		level--;
+	}
+
+	paddr = paddr >> PGTBL_PAGE_SIZE_SHIFT;
+	*ptep = (paddr << PGTBL_PTE_ADDR_SHIFT) |
+		PGTBL_PTE_PERM_MASK | PGTBL_PTE_VALID_MASK;
+}
+
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	uint64_t *ptep;
+	int level = vm->pgtable_levels - 1;
+
+	if (!vm->pgd_created)
+		goto unmapped_gva;
+
+	ptep = addr_gpa2hva(vm, vm->pgd) + pte_index(vm, gva, level) * 8;
+	if (!ptep)
+		goto unmapped_gva;
+	level--;
+
+	while (level > -1) {
+		ptep = addr_gpa2hva(vm, pte_addr(vm, *ptep)) +
+		       pte_index(vm, gva, level) * 8;
+		if (!ptep)
+			goto unmapped_gva;
+		level--;
+	}
+
+	return pte_addr(vm, *ptep) + (gva & (vm->page_size - 1));
+
+unmapped_gva:
+	TEST_FAIL("No mapping for vm virtual address gva: 0x%lx level: %d",
+		  gva, level);
+	exit(1);
+}
+
+static void pte_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent,
+		     uint64_t page, int level)
+{
+#ifdef DEBUG
+	static const char *const type[] = { "pte", "pmd", "pud", "p4d"};
+	uint64_t pte, *ptep;
+
+	if (level < 0)
+		return;
+
+	for (pte = page; pte < page + ptrs_per_pte(vm) * 8; pte += 8) {
+		ptep = addr_gpa2hva(vm, pte);
+		if (!*ptep)
+			continue;
+		fprintf(stream, "%*s%s: %lx: %lx at %p\n", indent, "",
+			type[level], pte, *ptep, ptep);
+		pte_dump(stream, vm, indent + 1,
+			 pte_addr(vm, *ptep), level - 1);
+	}
+#endif
+}
+
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	int level = vm->pgtable_levels - 1;
+	uint64_t pgd, *ptep;
+
+	if (!vm->pgd_created)
+		return;
+
+	for (pgd = vm->pgd; pgd < vm->pgd + ptrs_per_pte(vm) * 8; pgd += 8) {
+		ptep = addr_gpa2hva(vm, pgd);
+		if (!*ptep)
+			continue;
+		fprintf(stream, "%*spgd: %lx: %lx at %p\n", indent, "",
+			pgd, *ptep, ptep);
+		pte_dump(stream, vm, indent + 1,
+			 pte_addr(vm, *ptep), level - 1);
+	}
+}
+
+void riscv_vcpu_mmu_setup(struct kvm_vm *vm, int vcpuid)
+{
+	unsigned long satp;
+
+	/*
+	 * The RISC-V Sv48 MMU mode supports 56-bit physical address
+	 * for 48-bit virtual address with 4KB last level page size.
+	 */
+	switch (vm->mode) {
+	case VM_MODE_P52V48_4K:
+	case VM_MODE_P48V48_4K:
+	case VM_MODE_P40V48_4K:
+		break;
+	default:
+		TEST_FAIL("Unknown guest mode, mode: 0x%x", vm->mode);
+	}
+
+	satp = (vm->pgd >> PGTBL_PAGE_SIZE_SHIFT) & SATP_PPN;
+	satp |= SATP_MODE_48;
+
+	set_reg(vm, vcpuid, RISCV_CSR_REG(satp), satp);
+}
+
+void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+{
+	struct kvm_riscv_core core;
+
+	get_reg(vm, vcpuid, RISCV_CORE_REG(mode), &core.mode);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.pc), &core.regs.pc);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.ra), &core.regs.ra);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.sp), &core.regs.sp);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.gp), &core.regs.gp);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.tp), &core.regs.tp);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t0), &core.regs.t0);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t1), &core.regs.t1);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t2), &core.regs.t2);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s0), &core.regs.s0);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s1), &core.regs.s1);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a0), &core.regs.a0);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a1), &core.regs.a1);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a2), &core.regs.a2);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a3), &core.regs.a3);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a4), &core.regs.a4);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a5), &core.regs.a5);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a6), &core.regs.a6);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.a7), &core.regs.a7);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s2), &core.regs.s2);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s3), &core.regs.s3);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s4), &core.regs.s4);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s5), &core.regs.s5);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s6), &core.regs.s6);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s7), &core.regs.s7);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s8), &core.regs.s8);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s9), &core.regs.s9);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s10), &core.regs.s10);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.s11), &core.regs.s11);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t3), &core.regs.t3);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t4), &core.regs.t4);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t5), &core.regs.t5);
+	get_reg(vm, vcpuid, RISCV_CORE_REG(regs.t6), &core.regs.t6);
+
+	fprintf(stream,
+		" MODE:  0x%lx\n", core.mode);
+	fprintf(stream,
+		" PC: 0x%016lx   RA: 0x%016lx SP: 0x%016lx GP: 0x%016lx\n",
+		core.regs.pc, core.regs.ra, core.regs.sp, core.regs.gp);
+	fprintf(stream,
+		" TP: 0x%016lx   T0: 0x%016lx T1: 0x%016lx T2: 0x%016lx\n",
+		core.regs.tp, core.regs.t0, core.regs.t1, core.regs.t2);
+	fprintf(stream,
+		" S0: 0x%016lx   S1: 0x%016lx A0: 0x%016lx A1: 0x%016lx\n",
+		core.regs.s0, core.regs.s1, core.regs.a0, core.regs.a1);
+	fprintf(stream,
+		" A2: 0x%016lx   A3: 0x%016lx A4: 0x%016lx A5: 0x%016lx\n",
+		core.regs.a2, core.regs.a3, core.regs.a4, core.regs.a5);
+	fprintf(stream,
+		" A6: 0x%016lx   A7: 0x%016lx S2: 0x%016lx S3: 0x%016lx\n",
+		core.regs.a6, core.regs.a7, core.regs.s2, core.regs.s3);
+	fprintf(stream,
+		" S4: 0x%016lx   S5: 0x%016lx S6: 0x%016lx S7: 0x%016lx\n",
+		core.regs.s4, core.regs.s5, core.regs.s6, core.regs.s7);
+	fprintf(stream,
+		" S8: 0x%016lx   S9: 0x%016lx S10: 0x%016lx S11: 0x%016lx\n",
+		core.regs.s8, core.regs.s9, core.regs.s10, core.regs.s11);
+	fprintf(stream,
+		" T3: 0x%016lx   T4: 0x%016lx T5: 0x%016lx T6: 0x%016lx\n",
+		core.regs.t3, core.regs.t4, core.regs.t5, core.regs.t6);
+}
+
+static void guest_hang(void)
+{
+	while (1)
+		;
+}
+
+void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
+{
+	int r;
+	size_t stack_size = vm->page_size == 4096 ?
+					DEFAULT_STACK_PGS * vm->page_size :
+					vm->page_size;
+	unsigned long stack_vaddr = vm_vaddr_alloc(vm, stack_size,
+					DEFAULT_RISCV_GUEST_STACK_VADDR_MIN);
+	unsigned long current_gp = 0;
+	struct kvm_mp_state mps;
+
+	vm_vcpu_add(vm, vcpuid);
+	riscv_vcpu_mmu_setup(vm, vcpuid);
+
+	/*
+	 * With SBI HSM support in KVM RISC-V, all secondary VCPUs are
+	 * powered-off by default so we ensure that all secondary VCPUs
+	 * are powered-on using KVM_SET_MP_STATE ioctl().
+	 */
+	mps.mp_state = KVM_MP_STATE_RUNNABLE;
+	r = _vcpu_ioctl(vm, vcpuid, KVM_SET_MP_STATE, &mps);
+	TEST_ASSERT(!r, "IOCTL KVM_SET_MP_STATE failed (error %d)", r);
+
+	/* Setup global pointer of guest to be same as the host */
+	asm volatile (
+		"add %0, gp, zero" : "=r" (current_gp) : : "memory");
+	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.gp), current_gp);
+
+	/* Setup stack pointer and program counter of guest */
+	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.sp),
+		stack_vaddr + stack_size);
+	set_reg(vm, vcpuid, RISCV_CORE_REG(regs.pc),
+		(unsigned long)guest_code);
+
+	/* Setup default exception vector of guest */
+	set_reg(vm, vcpuid, RISCV_CSR_REG(stvec),
+		(unsigned long)guest_hang);
+}
+
+void vcpu_args_set(struct kvm_vm *vm, uint32_t vcpuid, unsigned int num, ...)
+{
+	va_list ap;
+	uint64_t id = RISCV_CORE_REG(regs.a0);
+	int i;
+
+	TEST_ASSERT(num >= 1 && num <= 8, "Unsupported number of args,\n"
+		    "  num: %u\n", num);
+
+	va_start(ap, num);
+
+	for (i = 0; i < num; i++) {
+		switch (i) {
+		case 0:
+			id = RISCV_CORE_REG(regs.a0);
+			break;
+		case 1:
+			id = RISCV_CORE_REG(regs.a1);
+			break;
+		case 2:
+			id = RISCV_CORE_REG(regs.a2);
+			break;
+		case 3:
+			id = RISCV_CORE_REG(regs.a3);
+			break;
+		case 4:
+			id = RISCV_CORE_REG(regs.a4);
+			break;
+		case 5:
+			id = RISCV_CORE_REG(regs.a5);
+			break;
+		case 6:
+			id = RISCV_CORE_REG(regs.a6);
+			break;
+		case 7:
+			id = RISCV_CORE_REG(regs.a7);
+			break;
+		};
+		set_reg(vm, vcpuid, id, va_arg(ap, uint64_t));
+	}
+
+	va_end(ap);
+}
+
+void assert_on_unhandled_exception(struct kvm_vm *vm, uint32_t vcpuid)
+{
+}
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
new file mode 100644
index 000000000000..9e42d8248fa6
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to userspace".
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ */
+
+#include <linux/kvm.h>
+
+#include "kvm_util.h"
+#include "../kvm_util_internal.h"
+#include "processor.h"
+
+void ucall_init(struct kvm_vm *vm, void *arg)
+{
+}
+
+void ucall_uninit(struct kvm_vm *vm)
+{
+}
+
+struct sbiret sbi_ecall(int ext, int fid, unsigned long arg0,
+			unsigned long arg1, unsigned long arg2,
+			unsigned long arg3, unsigned long arg4,
+			unsigned long arg5)
+{
+	register uintptr_t a0 asm ("a0") = (uintptr_t)(arg0);
+	register uintptr_t a1 asm ("a1") = (uintptr_t)(arg1);
+	register uintptr_t a2 asm ("a2") = (uintptr_t)(arg2);
+	register uintptr_t a3 asm ("a3") = (uintptr_t)(arg3);
+	register uintptr_t a4 asm ("a4") = (uintptr_t)(arg4);
+	register uintptr_t a5 asm ("a5") = (uintptr_t)(arg5);
+	register uintptr_t a6 asm ("a6") = (uintptr_t)(fid);
+	register uintptr_t a7 asm ("a7") = (uintptr_t)(ext);
+	struct sbiret ret;
+
+	asm volatile (
+		"ecall"
+		: "+r" (a0), "+r" (a1)
+		: "r" (a2), "r" (a3), "r" (a4), "r" (a5), "r" (a6), "r" (a7)
+		: "memory");
+	ret.error = a0;
+	ret.value = a1;
+
+	return ret;
+}
+
+void ucall(uint64_t cmd, int nargs, ...)
+{
+	struct ucall uc = {
+		.cmd = cmd,
+	};
+	va_list va;
+	int i;
+
+	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+
+	va_start(va, nargs);
+	for (i = 0; i < nargs; ++i)
+		uc.args[i] = va_arg(va, uint64_t);
+	va_end(va);
+
+	sbi_ecall(KVM_RISCV_SELFTESTS_SBI_EXT, 0, (vm_vaddr_t)&uc,
+		  0, 0, 0, 0, 0);
+}
+
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+{
+	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct ucall ucall = {};
+
+	if (uc)
+		memset(uc, 0, sizeof(*uc));
+
+	if (run->exit_reason == KVM_EXIT_RISCV_SBI &&
+	    run->riscv_sbi.extension_id == KVM_RISCV_SELFTESTS_SBI_EXT &&
+	    run->riscv_sbi.function_id == 0) {
+		memcpy(&ucall, addr_gva2hva(vm, run->riscv_sbi.args[0]),
+			sizeof(ucall));
+
+		vcpu_run_complete_io(vm, vcpu_id);
+		if (uc)
+			memcpy(uc, &ucall, sizeof(ucall));
+	}
+
+	return ucall.cmd;
+}
-- 
2.25.1

