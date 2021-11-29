Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 448DF460FCC
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Nov 2021 09:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242728AbhK2IPd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Nov 2021 03:15:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2075 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbhK2INc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Nov 2021 03:13:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638173414; x=1669709414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=2wKRtDDaL4xMXqcVU7VTHDHzG4UxJ7OGcH5csq8DXFc=;
  b=qRidRn428YYiY7nSiswhTvMAH3VDWeq/jUk0ByO4STEwD4vor74Y4XCp
   ypirGwMatyVc+Duz9MjEXqXl5kTG0wlTXcknRVoQTKjaM3LNW1gXSEaRn
   9FiciHuqhiHo2jWl0g/E6kJ5YWvAGytDJKd0gSdsXviTBqpfNecIoU+sL
   //NC0Nw8fDxfLMEHbWxT/w1xet4zLceIR3djo6E6HeuQ4eOxil9tiDvr9
   kZsYZJwlIfVzS78ilxdMIOWiDQ8iNC6yGIYZlcwC71pvRpSp5StwtTVtM
   tJrki518MFzSlg6JqwXMpbS0iOXyVDAv867YxJwnUivEnaJSsVXhu3jOt
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,272,1631548800"; 
   d="scan'208";a="290889295"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2021 16:10:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W1syER0dTjUNO8+UCCiexmmKUqvOgk+QE7vZsyz1tyyNz+l+Qlao8AhHOKW/k65bHWzceWKi95aPIZShs2QJsZP66SRRy2kPxzHSPjlocfNDuqIPHWBkHhXbl4i3htOqP7R6uBHkdiZbQ4AtA4gIvNyKIhGTSf+63bfsOVGSy1XVi5sY9lg8a710msj9W5xwgnH49wbZirl27hj8ylUabsZWLb+nS1wEYY9FLOzht1wF1mWgYzNgkn857iOXcMkER2pyyxjEjypzFzybIQHnFwQnDngsBFzZMDNXjE6UDXouIck3qEAF818Z4ND3617Hl2g3UcZrbtuibj8AhegYDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2MUbDArdgy5dyqWyYTJKMDcx9Dby54rAztOOScLDZI=;
 b=CVuM1A9oUg57nGnTo9RY+2fO1vxLZG3AQB3xSChuejTCYW07ci3t/O8nTZy1acWjV1w6U2SKzR43d50uB6vDRaXMTFsU4UXWei7u89p+dF8tgZ/5fYMQe/Z3Euj0kuxz45Kas2bF1BE2wmIm3u+C33kc7P3g46R/vnt7uhUmgABVaG6Gd0ul614Vg8ZmdrT5tpFcMDFCPj99Xv0XEhTBR2ES8xIYTE7GywOTjEsZtIuNZNURKmi5+VpzgCQ4h0Up9ohvHS13eJ8wkfuPjMmP12L9I4Ird9pE6POx6M6Sv+XfIi31IwaLNMW+KWVAIFUY7hIe6tjqrDLoxupLpz1uWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2MUbDArdgy5dyqWyYTJKMDcx9Dby54rAztOOScLDZI=;
 b=B/bjWkLCXPFOW0YkvIODWy665dgQisLPgn8Pm7pbBk73swAP5KTZx6ltmZDHIvQX/v5baKtGmGi766PhE64B0biEmTeRz9X3ZcADDDDU1fnCWukbKsRQeLJ6lcvX6kXEgt8W+7XdIarvrM39+M0NHOF8x3efxtvaDQn2aOx2QBA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7796.namprd04.prod.outlook.com (2603:10b6:303:13b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20; Mon, 29 Nov
 2021 08:10:11 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 08:10:11 +0000
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
Subject: [PATCH v2 2/4] RISC-V: KVM: Add VM capability to allow userspace get GPA bits
Date:   Mon, 29 Nov 2021 13:24:49 +0530
Message-Id: <20211129075451.418122-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129075451.418122-1-anup.patel@wdc.com>
References: <20211129075451.418122-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::34) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.167.150.114) by MA1PR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend Transport; Mon, 29 Nov 2021 08:10:07 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 16035733-035a-49c5-f27a-08d9b30faa42
X-MS-TrafficTypeDiagnostic: CO6PR04MB7796:
X-Microsoft-Antispam-PRVS: <CO6PR04MB779637D487CB990A0767CE238D669@CO6PR04MB7796.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IKrdldY2tOtq7DW09WlHqPJCIaczp71OICQGmaQnj2jzxxFmOiVizMP45mg/GBqi9jB833H5aSNa2K+jBVQtK2OdSkFeo8SJp4rYFHHibeNGCkv+ugty8H7atO/Gta9Zq5AyUglg/xJQcffLAg6cJSuSSim6xVN9rdXve22RSNAuXHlmD2Lw1k0VHvBlJxSpCpaOJR3t3CHyCg/N4NmtO6PMjg9y94JBsix25of+YkdqP/6ZUqMWh9kQSAKKFydZ+9p4VJ87Jr8gYsim7FrrcdJOrec+0IY8fo8aJCAdIZDgRSrS8fozrMnumlnCINxytC4iSTIMMp7eKuiHWQPRXHOB2WcOVe1lCGHC4oYITUKfWb5yPxhc5ZprdRjSQ3RUlYgS0g5xcB3qJ8q+H5a9wJ8MULS/VFyEOOe/CIGmzYLJxpZCeTbr25tDoLx8Pn3FSkTqF50yN3mc2yNUAXdoBjWJKTJox/Wflu3qjiknemBxcWQKYP1sMpb7uz8GrulBRCiJEFHV0n5yTvYBrG6dQT6VV0gR7zRf4tfZnWHy1yhsh+A568k+uuJEgitth6wYcz3poh9AtcJy8i0P4fThy+wG62XIXS7oVvXOMpUs2d2ssUqZ4Zr4iYzDotJIowq1d38J83lMo+dDBl/GZipcQrd1nFHsuWwF4V2Pr4kPfhhgQpaIclaWHMwTCX8kztYSB/xITM976r2nKfF5AODdgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(2906002)(52116002)(66946007)(7416002)(508600001)(54906003)(55016003)(4326008)(36756003)(1076003)(44832011)(956004)(2616005)(8936002)(8676002)(7696005)(186003)(110136005)(316002)(8886007)(66556008)(66476007)(5660300002)(38350700002)(38100700002)(6666004)(82960400001)(83380400001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wMb294k72vQ+84Ktv81Y3Pv1uP+DrXDfnm7tfbPLfu626PRMqLSLPulR7eG?=
 =?us-ascii?Q?hGIz7uAx5iVWKDp5tvKkddGCuG6JFABYh0tKJM3XEUGOremkNr/olmTYlvbH?=
 =?us-ascii?Q?EVb8mybZbSGfJpGwn311A24X0wJL2WpVwtaM613SksUK0iuDnwjXxOK5T0ji?=
 =?us-ascii?Q?qXAPWEW8OJxXQZbwX/xElfXjjqXLcu4OPju0cAv36uRzIWHhHRMhzioiRmhg?=
 =?us-ascii?Q?Nq8Askclh+pFlWpf/+4UXFBUUuCw7kz5LJbcVdDElLL8HTArYRfOr2HIpXGh?=
 =?us-ascii?Q?uVoQDIN8roeBFhbEEoclHsaLlKfD/XTx/b7EIKn8k4BUeKRZ+YVy3d8BOEqc?=
 =?us-ascii?Q?/Rm10VAnSyuti/WGUuYwXnwdwhMa9PysSPuh0ZNHjSd49EwBCXvb5HPlNvvU?=
 =?us-ascii?Q?T4lEXg2swfluINvOj9Dyag+MTFh2VqgFrNNJADLZONEgXIUSInCwMN++oOIh?=
 =?us-ascii?Q?nWoJW0a4TjXOgNkIrnRgb2PEMfFuTw+0bAozv6R4bBvqiCCD4Lr0DFdnKbxK?=
 =?us-ascii?Q?2jaJC/Vlfe+gKg/8+yQvzFTYT0PILdbhUmLnQRKy5elosyNn2d0bXpDY5Z4T?=
 =?us-ascii?Q?G44OwPsBlfseueEBT8pGuo92J8BtbkOWEpur4a7Hn1cxAfjEhJyKSVZoatbj?=
 =?us-ascii?Q?9ma1tQw+FodgY5DzrQLgzthK2QAotXy5z3/ehXnQr49Hf5NwICLkHkHq0oP6?=
 =?us-ascii?Q?S92e4srwoFZzCioWzwTDJ1FyQXDwwfPg1Svw5m5lkZfAfyH9Wn1NletcajoX?=
 =?us-ascii?Q?iqapeA24m4RubpRrK6C4Rl9hOJvkxvw8F4ceE4yfUEanVvBMmcK3Whp6qwIN?=
 =?us-ascii?Q?Wu+Lk6B58CTZ94i8HVfMfv11aN6mYupLGHDd2DMrcg9QZB8iLK3cq4NeZIHw?=
 =?us-ascii?Q?b9wiAJf2JpJ3zV7XuWDVaRC8Y2X83J+M8zsx7Eg8wELZB7vRnLOsOaTQSQGM?=
 =?us-ascii?Q?RZzwciFMprzCUZDEZsr19Y55MpBvMHPqoE1U8Q+YGrOG6NU7CzbELWEgJ9fC?=
 =?us-ascii?Q?9Dr7srwu4fXij36RyIrAYgOXQfwBXPIawJnmvsX+KLLk7yI+HsZRLVHY3j4w?=
 =?us-ascii?Q?b/jPNRZk5gPnHAJU2uOlL7Vsc3mCs29BzdJj7RGDIZwYrMPLOw0EkCgkyQY/?=
 =?us-ascii?Q?JukD+A2jdKagAx4hSgQS5H93/XbKesweTheToeojGkZL4R9rGhvuoEzK+VQF?=
 =?us-ascii?Q?2c1tanYaHcPs5ZXkZpN0EXdwOWuWIhoHzZJB0zHWCOWhOsherpWrMwS3yQMj?=
 =?us-ascii?Q?a9Trr+i2MEcc+52oSvgWxbBl3OTB2rjCXhuFq4vPqwZCRBzoqwoL4pJoYkbs?=
 =?us-ascii?Q?HJlUwY1gJbVYDUf9SEBDnHInyAr8UtEcDu9l2fhVxlETCJCl7VAy8ySbWReL?=
 =?us-ascii?Q?O/7fOtizcnugrOn+OpPHojeaTu8O3RKA9N/ihtqDEtujNfVdlfO3j4JEO7cw?=
 =?us-ascii?Q?IwwUousvDVQz8mBfHpiG/+4mHRoatwBrjFIWWu+X6c/u/9rbCI1xC4W7RXg7?=
 =?us-ascii?Q?vcf+mGM4XWCRg/RVeUEOvEIXc4xlABLfVVqOWw5r78Xf7v+606x/MZ+FQQYh?=
 =?us-ascii?Q?d1qrZzHJ+bpnzBGnWkuDjb3K1ZFQajZ+gn5pKFgFQNX40ynYPmIAbgKkakeu?=
 =?us-ascii?Q?0PDGRXA99kdtOJdLbih6d8M=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16035733-035a-49c5-f27a-08d9b30faa42
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 08:10:11.3295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LHFiFx5XFd6aTTflaQWdCqhrAp6VlNlWfYC9CF9LlWB15DBhuInxp5eIDlyQMGoAAnX+Hc0QhBhkZRuTTdkDmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7796
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The number of GPA bits supported for a RISC-V Guest/VM is based on the
MMU mode used by the G-stage translation. The KVM RISC-V will detect and
use the best possible MMU mode for the G-stage in kvm_arch_init().

We add a generic VM capability KVM_CAP_VM_GPA_BITS which can be used by
the KVM userspace to get the number of GPA (guest physical address) bits
supported for a Guest/VM.

Signed-off-by: Anup Patel <anup.patel@wdc.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 5 +++++
 arch/riscv/kvm/vm.c               | 3 +++
 include/uapi/linux/kvm.h          | 1 +
 4 files changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 37589b953bcb..ae5d238607fe 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -221,6 +221,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
 void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
 void kvm_riscv_stage2_mode_detect(void);
 unsigned long kvm_riscv_stage2_mode(void);
+int kvm_riscv_stage2_gpa_size(void);
 
 void kvm_riscv_stage2_vmid_detect(void);
 unsigned long kvm_riscv_stage2_vmid_bits(void);
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index 9ffd0255af43..9b6d6465094f 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -760,3 +760,8 @@ unsigned long kvm_riscv_stage2_mode(void)
 {
 	return stage2_mode >> HGATP_MODE_SHIFT;
 }
+
+int kvm_riscv_stage2_gpa_size(void)
+{
+	return stage2_gpa_bits;
+}
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index fb18af34a4b5..6f959639ec45 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
 		break;
+	case KVM_CAP_VM_GPA_BITS:
+		r = kvm_riscv_stage2_gpa_size();
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1daa45268de2..469f05d69c8d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
 #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
+#define KVM_CAP_VM_GPA_BITS 207
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.25.1

