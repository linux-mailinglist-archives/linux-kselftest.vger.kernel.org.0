Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269485232B3
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 May 2022 14:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242144AbiEKMJh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 May 2022 08:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242526AbiEKMJZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 May 2022 08:09:25 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2102.outbound.protection.outlook.com [40.107.255.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A013313D156;
        Wed, 11 May 2022 05:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiSyKOHwsDu/YmdOVsNGKeXrPVWsbMPxsyvF251GaoJdn/PZg7Cxe40ULxayFAA8gB6F5tUF9v8dhM8r/hODkxVPrdns+mKnlr1GIwhWO5+IAxLJtxWqDvnkAUF+cEaPybKpSkgVAoFYfpdWhKJzsZJkACyU2c2qeX00wDWMp4/5spwoabB+3t8TjHHHm3Mdms7grt8zV/vwTYxM+G/qU7IEb6ojoQSPIGy+cGBT5ZOSFyyE+qUY5kTQhn4i/Lue2JtQKKAtz6YSvhrD3PQBv7Avk6Ar4QTW8PrjJAkqj59Io4Llaoj0yRJQKRto+kWrfg0b+aCE+WXqCSlkrv3K5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/1N/uXk7AEHS2GWXVVt4QbwD+RFIo6K0QOFlm16GZYk=;
 b=YDqWFVAnvWE7OG2HO3HpOXI6HlZuHHCKRkdpRSm8sN8vo5zrE44GkMmGxq8Qs66AXZ+UecWqU3a0Vc9IFHfVlfYe7bwKevooFxkmLHo/zcsSXhR1rH5Axyx6aj0wkviwcd/UcBnbtkEbDO9ugXA9XFCb2kVIGRspgvLMwR01+Z+hnMf26Xo92Hk2Xj4H//r2wox7gezlvOOsi/bb7ZdijoIuOi5LctWsn7PRzZvvtSotMjQ6fGVsccgirmJ05g+Dvv9oJmim5UZn0JXaB1pfEHqX5c3Lwb3/qhm6dlwaNEBgB+AgT+pkRoNaSM/61qcIdxupoSXaXV8VilI9LS4Yfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1N/uXk7AEHS2GWXVVt4QbwD+RFIo6K0QOFlm16GZYk=;
 b=nCrabNMoNUSglMUikYkpPnafJWOc1HFGKTAlhogDg9tk7x3ubmrBo4G/AtejkfqLv5bIJOHzoXtYnvSV/oJOhViDSNTOCInRWZEHDTwYDzY5YT/FRPEdusyXsbBOpgE9GuhlTEUbDwJeYZQyrD2UylIYhzWjKV3aBxe/lBfef+k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by TY0PR06MB4942.apcprd06.prod.outlook.com (2603:1096:400:14f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:08:31 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.023; Wed, 11 May 2022
 12:08:30 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Anup Patel <anup@brainfault.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:KERNEL VIRTUAL
        MACHINE FOR ARM64 (KVM/arm64)),
        kvmarm@lists.cs.columbia.edu (moderated list:KERNEL VIRTUAL MACHINE FOR
        ARM64 (KVM/arm64)),
        kvm@vger.kernel.org (open list:KERNEL VIRTUAL MACHINE (KVM)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] selftests: kvm: replace ternary operator with min()
Date:   Wed, 11 May 2022 20:05:55 +0800
Message-Id: <20220511120621.36956-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0181.apcprd02.prod.outlook.com
 (2603:1096:201:21::17) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e341fa3-6220-4e4c-4860-08da3346f60e
X-MS-TrafficTypeDiagnostic: TY0PR06MB4942:EE_
X-Microsoft-Antispam-PRVS: <TY0PR06MB4942264913223A426B17C610C7C89@TY0PR06MB4942.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xG3L7x0pBsoGkOdwpEn4exJkEIkwyHELIclP7pQwCZKtAI6DTh86EdnZtN3d3iMFbiD688Gd9w+7WHYiNCCqoY/nQhrKp9xo5+fNfJ9vCWGkXkNcJBaYRSWg+yBo1EdeD6mh3VkAb0Ps4csUfhCp0DiU2czJ+WHawpmeXbZLM/f6z3shmf2KwDv24h5T1zO5kVPJn0Qro8GmlZQzccnzDx6tVD4sqGmk21UctTCUjhm540D5GC9ALT1FB8UO1GWnaeHXi7johYkXRCXtAFZt+RQZAooWtiQVQUWZnVbfeQiP17MeVj6DWBOx1ZKpbvqIhzvvCkyC4zaPD4cHsAg7NyFp/OlYWU3lRDzZaVxH5c8aqzgHlUFakg+YS3GoruBHwI6DyxwxNPq8DoVL14H9DNhEfv+0NPKD45zbQdfs6TB02Gw+k/zWMWI0VQxWsuDT//dMQMjiKBRpPf7gyrCYoH1N3KD4eX6XlN2B7Z4WYPcn8aCXaszusJeetO4LFmudlVN5DED5WhRKyhq19vo0vxjMUQ44ygiexjpFBngxRIFkAE/YvbDCiQmJ6eKobBYAnJbnlDG/ZvHiwyTfDBai5kdCC2EmRSmGczB0Fges1CHxBKBoPNT6QHY+/aKfCWtKZpP9TgkGsIGfo/1kX1jtlicoccouLgIdl4/xSIRuBGOYYN2R1BnIVzVEUteWGh4FjKME8vn1CnIrvsivecC1m/soIUsOCfakuWWCbO7Tzdw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66946007)(66476007)(8936002)(66556008)(8676002)(2906002)(1076003)(86362001)(186003)(26005)(6512007)(7416002)(5660300002)(52116002)(6506007)(38350700002)(83380400001)(508600001)(6486002)(36756003)(316002)(110136005)(921005)(38100700002)(2616005)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2/sh6i/2gTxewd+/4kmfbcsxr2TEorVPFqLXss9J20Qvmy0QT7jzcVu6deSY?=
 =?us-ascii?Q?nTUHJi2vkhvX+PSsOa8IuTbbo+9LVXiksYfUEiCWf/ZBf6hhLL8x2Qmzf5sg?=
 =?us-ascii?Q?qdCXbUCB2thxnmya1IgQtul6eEF6H6L2pRogOdlxz2hmVTJBIlwB84KeMBhJ?=
 =?us-ascii?Q?GT1ty0bO4AOOzn2zSsq+zKtfyWqAPVgQ0Kc2Bh47205LvXdJ/ULO474d7NT2?=
 =?us-ascii?Q?eEjWsG6+64UkFFuqz/hHNRdrK1MOQfHzG8RfhTRgwaPdRddC9/s6rL+WpY9+?=
 =?us-ascii?Q?YE7z23lBiw9Fp4PukSuwDvt20+eSBmfO8YGXXM7laLuSYwhohMWJQQXHDE1v?=
 =?us-ascii?Q?KprNP6HDirYnQm1E5uk8Dx5C0p4Vtopee1ZBk1vetG2pm+GbKa5ah965clmV?=
 =?us-ascii?Q?DQbKBVmUy/HwGEZ/pvklWMIyK5LYRJxZjg9exAXEWZCv5+upsmyb4hfA8Gg5?=
 =?us-ascii?Q?5MG8wC5diwUxP3qXsx9/c5LXjTmuyrW7lqpij5Ha+ph8to5a2FcbojgbkJ2r?=
 =?us-ascii?Q?jRgWCFkZDRmzhoAnO/Af/RitmN8/UVDrTE6wtzgjPt9mWVHrq7C1HMRziUue?=
 =?us-ascii?Q?rs8t2gNpl/mkGNxZVZx9dqVXI5KLow2pDGY4Fk9WUYVe3izwxT7O8arhc4Gd?=
 =?us-ascii?Q?WeLBbR7Y23jwL6BmwlLgOTHhI8Z9Vmu881YDOWGy+V6SHrmhdDwsRSafF4YF?=
 =?us-ascii?Q?Spf4QBWaaWZmB1ORz/CMm6W5tWRFe6HkbI0KwluULsa5n2IUhXaKNoLw1nOZ?=
 =?us-ascii?Q?fJs+wLNHvuPOtS6TnB/hxk/oRcINShNZ2KOtbCWY3J6C1Ok4l4CdbxG6UDbX?=
 =?us-ascii?Q?YhDoF8wEGtSo+4BA9PmW3/gEcaT9bCDSu6CYxaWjOYu+a6dstceGUaFxylzn?=
 =?us-ascii?Q?RL0tOL9pxo9oT3XbkasMISjZjWFeGbE5MxAZlU7PJk8VclSLdxy+dhjOQ0Kd?=
 =?us-ascii?Q?hQvehfiTO0jbVCR3kCHyL48sCujXe1YECkmnEvqOY8WSJ/eam2sdFr25Ia7I?=
 =?us-ascii?Q?o90OCRKfiKXvo1LWCD/8zeS7aluNha3dB/yCbHTrwOeXIPkG/PVLtjzYwXP0?=
 =?us-ascii?Q?108rp+nMu7GXiZ9eraygk0q7uCZUem1XZ5dFxXGuHVPz0GBOQBFFUwAWxIZU?=
 =?us-ascii?Q?OqPAkQXLotugGNsXX61Gh4Wif+zeK/YJn7lWC2PK2SJsm3RNxtd/07RLvgJi?=
 =?us-ascii?Q?CyG63YVJ3JheUKnSaRnTmnU+wSZ8yfPeE20UUV5I1tUmG7egBOz+aG7rtNQC?=
 =?us-ascii?Q?E5s9sNYAxiA3l9+JABfwJhQI7WLArEzMdjWb7IC2EeDpWA96HOtKZl5yOxlX?=
 =?us-ascii?Q?7P77jgCD7cyq1pp6BTvs+1P4y/4hyI1XElVwiUBTkvtf2HLFz6ow8ankzQUx?=
 =?us-ascii?Q?jv5V40wyaex1IEvwiLNGtXOwyXmYBRxXxdAQfQpRLbXba9ouRkj2058oBU3V?=
 =?us-ascii?Q?wTuWUf4rBCpPYjSGNornluf/PU6Cq0C2JMkUuWNtbzbrCO3tf+JDIRogI7X7?=
 =?us-ascii?Q?gXWXJx3olmNm6NDYDaubp3NxoAYfThggmeMWTb4oQLncB9Cce3x7eQ/yFtXy?=
 =?us-ascii?Q?CqBGKJP5CqsVgn4h/9lbRdy9GeZh5FRQEHbtQasiHI5N3Pkey/UpOWz9uaC4?=
 =?us-ascii?Q?WqOW82HRFXo6RSNC/5OczB2NQcGxeHNMmEjE00lKYGmbD8ZtltzJeiIloo4C?=
 =?us-ascii?Q?eIpm+Dt1JYTKzs14rCb5nDb7avribrCxpdnSGPlcXOuFSYCAAtGe+fL2rdNu?=
 =?us-ascii?Q?JFjVsoT44g=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e341fa3-6220-4e4c-4860-08da3346f60e
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 12:08:30.4423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: acYqY5f6uV2LeEyaDbvbRBe7ZyQ7xyRtMJaYPHvBkN2qUIwz12q4BER0gCBMDagwsrL/Y01r3G2ZMZrzsS52BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB4942
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix the following coccicheck warnings:

tools/testing/selftests/kvm/lib/s390x/ucall.c:25:15-17: WARNING
opportunity for min()
tools/testing/selftests/kvm/lib/x86_64/ucall.c:27:15-17: WARNING
opportunity for min()
tools/testing/selftests/kvm/lib/riscv/ucall.c:56:15-17: WARNING
opportunity for min()
tools/testing/selftests/kvm/lib/aarch64/ucall.c:82:15-17: WARNING
opportunity for min()
tools/testing/selftests/kvm/lib/aarch64/ucall.c:55:20-21: WARNING
opportunity for min()

min() is defined in tools/include/linux/kernel.h.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 tools/testing/selftests/kvm/lib/aarch64/ucall.c | 4 ++--
 tools/testing/selftests/kvm/lib/riscv/ucall.c   | 2 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c   | 2 +-
 tools/testing/selftests/kvm/lib/x86_64/ucall.c  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/aarch64/ucall.c b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
index e0b0164e9af8..00be3ef195ca 100644
--- a/tools/testing/selftests/kvm/lib/aarch64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/aarch64/ucall.c
@@ -52,7 +52,7 @@ void ucall_init(struct kvm_vm *vm, void *arg)
 	 * lower and won't match physical addresses.
 	 */
 	bits = vm->va_bits - 1;
-	bits = vm->pa_bits < bits ? vm->pa_bits : bits;
+	bits = min(vm->pa_bits, bits);
 	end = 1ul << bits;
 	start = end * 5 / 8;
 	step = end / 16;
@@ -79,7 +79,7 @@ void ucall(uint64_t cmd, int nargs, ...)
 	va_list va;
 	int i;
 
-	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
diff --git a/tools/testing/selftests/kvm/lib/riscv/ucall.c b/tools/testing/selftests/kvm/lib/riscv/ucall.c
index 9e42d8248fa6..34f16fe70ce8 100644
--- a/tools/testing/selftests/kvm/lib/riscv/ucall.c
+++ b/tools/testing/selftests/kvm/lib/riscv/ucall.c
@@ -53,7 +53,7 @@ void ucall(uint64_t cmd, int nargs, ...)
 	va_list va;
 	int i;
 
-	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
index 9d3b0f15249a..665267c1135d 100644
--- a/tools/testing/selftests/kvm/lib/s390x/ucall.c
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -22,7 +22,7 @@ void ucall(uint64_t cmd, int nargs, ...)
 	va_list va;
 	int i;
 
-	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
diff --git a/tools/testing/selftests/kvm/lib/x86_64/ucall.c b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
index a3489973e290..2ea31a0ebe30 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/ucall.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/ucall.c
@@ -24,7 +24,7 @@ void ucall(uint64_t cmd, int nargs, ...)
 	va_list va;
 	int i;
 
-	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+	nargs = min(nargs, UCALL_MAX_ARGS);
 
 	va_start(va, nargs);
 	for (i = 0; i < nargs; ++i)
-- 
2.20.1

