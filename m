Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7AA147ECBC
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Dec 2021 08:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351865AbhLXHgv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Dec 2021 02:36:51 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:38711 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351862AbhLXHgp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Dec 2021 02:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640331405; x=1671867405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=6IVuN8fMfTgKUxJ+G6/ulPX5w+2v0oz2A8DPleTJ8E0=;
  b=pbZtbTOEmlUcPlGWua0FFiV3fZAZHdKmSYMHRjPMpjNpoiFezHsLAZZf
   GsHYZ/FRgO10IRNgzXmmRImkd0FkyckNcux18N0+z/+T7P/NNDD60TUCq
   lQIteKLnoyv5MVS2IHhcX57RjzOPZxaizVDwQ91TGifVrrVTR2KXI6E6h
   lIig/emunYjCrOk+0gaPPMdFapAsw1ZvnQWC3XHq8C9e7KaCb0IYlYppq
   Wj7/WCTqwZkrMB0tnuHrjez/Wi9YJX3U8AICV0kKZK5sm1l5b2pA+cR7h
   zLYm34aZcQXEmlebk/ybCE/JBw0oKCfIWSBKlEjbMNnOSkkHA/VGROi3r
   A==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="293035153"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 15:36:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqUItnxjoVOLQJDmxB3YYvjIZoOMTR/owmZ9g/aHAD/3eg15ypfdrFXTSzBZGa68boewp+xLrMm8yo2HWbn52GMRMbY+1T0V83G6We9IkIpvjsIfgPaylSztQCRuERjbuvGMDu30UnaWpvN5aTP1wZExharevrMhdy0pIN5q/QF936zWhUFj8D/gk5/xdDZppz1MALa97BiD1StZwK31oxanj7y16XGf1yYqzvohG6eEYFSCCDkTDh5tLqVX2j4IlWXlbEh2NnT8aW5/2LqKmh31Aev42/Ig1FMMp1msJlzf6EzsV6hsyIh8H/BJEo1e70u4NkfL+oEdHkcy+Rq/Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4jzQudXJSjPM/lzJNkVj24n3Uo3rbWmg9VgQIQeQFI=;
 b=N4kDUnDGwuJhqJCGXi4KYNpGT9u+w+RcA+rMTtxY6xQVfzX4LHEOqdhg+JUWKkGnsxauvyPO7KctDvkqXzN+p6Rn203FTOv4lydziRi4weuH6OxkabSvLHWPh9RGj5n8VCOiN3PHzfHdrv4Wnxssjaj5+7WAT7UDKIXO0ACOF8GYCdCX7Tc0tG8GprMmF/fAA+3nvoi2HCLqD/v+YlfC77Epygctuhtg00W4ffBw44aUeF7jcjVORkZssgpiGslhAO439cxYddDsC6Bya/An3ZR/rB/Wm9yy4HysniASq8SW9eD2OnZiv2+cNGwCr8+wctGZsLbRBtZFh5pttT0a3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4jzQudXJSjPM/lzJNkVj24n3Uo3rbWmg9VgQIQeQFI=;
 b=Hk89JzrIKSg9Ednx3XyLwoZa2TU3JXFOs2/C5xBT6Ouz7Wtx4RacW6R7Q8RGSeUZDulaWtps/pgjDyzP/IKnXOedQkhm/fCMbHgQ96a1EttCgVp9eExL0CU9XYEBIXhKX0eH1MNrxFnRk7pYHpRi/emp2FyJySV7Bn1eo/j+hho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB7859.namprd04.prod.outlook.com (2603:10b6:5:35e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.17; Fri, 24 Dec
 2021 07:36:44 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::f14c:5516:7743:932c%4]) with mapi id 15.20.4823.021; Fri, 24 Dec 2021
 07:36:44 +0000
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
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 2/4] RISC-V: KVM: Add VM capability to allow userspace get GPA bits
Date:   Fri, 24 Dec 2021 13:06:02 +0530
Message-Id: <20211224073604.1085464-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211224073604.1085464-1-anup.patel@wdc.com>
References: <20211224073604.1085464-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0117.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::35) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 83781c94-bd30-4eae-ffac-08d9c6b021ea
X-MS-TrafficTypeDiagnostic: CO6PR04MB7859:EE_
X-Microsoft-Antispam-PRVS: <CO6PR04MB7859A1267BC530F53C24E14C8D7F9@CO6PR04MB7859.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUxJREFNIfVRt+HckuoX1Ap11EkGkxAqlJvBC9cEHVZ/TekmkOfrk+/iiCOZWCE7RbzyQDHdhmQCs6KupqPT5SxVh4nw8/ilBDy/NFqJI/QO02xD2SGAcrbKU/htaDcNXIVMJreqHVtf2Js3lSqLZh/naN+CEnePvjBOTlxq6FT3KDBMk5znq1VjwBemy86uLY9EPIk2Dz1Wx7AxiIKZYtpiAwwpt7TWwDDI2wWQyB4tD1Tp8mDdkP0c/2JiCbdQPQLvODaDMNwAe+dQTPpTQkpUqba7wkMnSfLrlmyRk+dUSaeR2WI/HM9CmJ8HUWkloJtGHLBMTkPqvHwxcHXAE27s1zTrButJ8P/6fUhwO+7MM+7bAg6dPjXGBM51e47lK5x9DXfx4v6+fmUWJaYgfcFjJW5buIviOa+x1A1SmrbiY84Abgj8xfOY4mHbTXBYKKNiQ7p5lNBBBmhTTlVxaYR8zAA7V7hyyBsZbDjUllxGjHJdRFwkGT1VwblU7WkDdD90+KF2p2a36g6UOUbdH8h2ZW1iENcBy1HO0CUyGnqERzGhm7obR6HfVyDtC7+E9F9/ZY3BEb/qQxatsuO03aDcKVStG+tG8n789GtSXhenJ4/nTTcLMLyELKPSE9YvUb3+GkbK2EKDDe9tz9b4LF1vqkhtgSY3Nay0ptB4PSEMH5cqjPgXKhwOujnzPlK7In8wycF00m6KNIZRC5DyOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(6512007)(7416002)(86362001)(186003)(5660300002)(2616005)(4326008)(82960400001)(8676002)(26005)(44832011)(2906002)(8936002)(6506007)(508600001)(316002)(83380400001)(38100700002)(110136005)(38350700002)(54906003)(6666004)(66946007)(6486002)(66476007)(1076003)(66556008)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Rwa2vbuv+9zJbex3njGwgRDpXuHYbJee/12zW5vF2dQ6BQPHGSCB67CFm6q?=
 =?us-ascii?Q?6m9gPToXc/uYrx2VJmdm5sZWssxIrh1uPe45Gus8xF/2csc7xw/e08J3ayml?=
 =?us-ascii?Q?IyxB+wYV4R7er1gIeWV9rGtLz2IiJCfx6m/WvXL8lJZSsTBotTnQE2LnE3R6?=
 =?us-ascii?Q?WYdw/RlDIXH7RLqdAw9/sSakcq4ltDbkIcdG6KXqLVB/razTdYJ9HFlq7IfU?=
 =?us-ascii?Q?GdcW6sBGSktgersLQEJxDtlo+X1xtLZ8xLkR8bmYWee4TW48KmiELiWbbbas?=
 =?us-ascii?Q?Vsnep+5YQb9nlibG4446mnY+6ty1QAHEeoq50iOaCW5a7B7OBZhFMkfJe8vI?=
 =?us-ascii?Q?aLYrB84CpeuE1dJoauK7COnwfrSpDqxxRtLjOinPLxUr/ZwjoyVXEFRknE8T?=
 =?us-ascii?Q?lcj7HZVKEIB0LytZBu+8hN/AF91AKtskoApPcJBUAuLfmvxXFlIdqv+pF+Pp?=
 =?us-ascii?Q?jqO75DIej/E6TNhPCh+gJ08f8Hi8qw8nPFqo29jZJRLvJJLsT3LAv3BH8wCV?=
 =?us-ascii?Q?+MHXThBCaYnvUh7tsT61e2DDAm9heYQkYdWSHUpNzzQYaXlC6mj1ugRslPPL?=
 =?us-ascii?Q?w+G9K09S94R2jeoJ48fxny1A7awsHOEzVcel12vmqHs3TAfRs7M/VEAtFfdE?=
 =?us-ascii?Q?H57Qb0wuBjKhD+9E0mf6qBJ156zEvXr3sg/oIuaU4G2HnTWso/d8P+0TRYDT?=
 =?us-ascii?Q?zPbPTfjmF36gNfg0h38U4cXQz7jdxeh0X1UzlbZSjInonXnqF4LYlszIUrrY?=
 =?us-ascii?Q?FDx9wdX95mMMnVl/gfIRSFKAVZWISzknrmScUo3HAZwG7wdB/asrBaLSWP3l?=
 =?us-ascii?Q?ivVrgZ8DO0kJR2d5HfUljdsBchD48i1Z/yiu4M9QxnVtFDoyWe8zk5N1xyOc?=
 =?us-ascii?Q?LSjR7Y+R2yX8GqQ79oCw+nVih7NoAXz/FDREQ2TG8fTd1YBFdnYSd2Udisj7?=
 =?us-ascii?Q?kXlvDaszLqO5Ty3wJCJiyQToRX8G9Tr6+ynTnZF6sfsbpHHiFZNflb4FuNvK?=
 =?us-ascii?Q?RSF1gA5uFLpw3xlZNcQHYRc7XRqfYVgR41s1voVdZH7caagmbCiUtW4X5Fbu?=
 =?us-ascii?Q?q3S8Go74g8O1uGzBoa+N3AIDlye+wNcw2j++IeIeHq+VQueC7k2P8MwAoZGC?=
 =?us-ascii?Q?W+/H2EAmac40OekbrfaZvV4cnpZbRCDvvsvFVvbo4eIJcMX+3tj2hZ9UaVYE?=
 =?us-ascii?Q?kekXdsOqcyCHzqxby2dPT/QwF0ZDP91htYSlb1ltToqRurG0+QhM4Fgh6vvZ?=
 =?us-ascii?Q?IJOdegTCy/1EaBwIbzrdjTddCChpr66/buvtLQDRraiH9pD21ScmF1B9B8LH?=
 =?us-ascii?Q?NNyRI4HC2sv4Hv9J4kyF4waXVZPtFJBhdENWn471aqmFfNBuCy59od4QY9m9?=
 =?us-ascii?Q?9eQUL+KDKWrCst0JgrlIB/oze/Hz2mPZSQjhcu4KjUgTwhfncmI8cb/MGeGo?=
 =?us-ascii?Q?M9vQGfJsJVgJYs/yQFcQDJqxPB3SK3V4Rn72OhG/DX/zmBJu+a/A+9y4YF1/?=
 =?us-ascii?Q?8fHrwJ9ExC5WePWIABeTr4aH4Wmthph1zeeB8F2UEaUgVfSNuAuKRb9Tfe2X?=
 =?us-ascii?Q?c3xkuM2n7IO43OE4ooCRQEv4oH3Hrk7FC2POAM/F+pwIEeAh9PnN9R/F+JVj?=
 =?us-ascii?Q?Qrup1NVz2Sz/34rhvvia7nY=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83781c94-bd30-4eae-ffac-08d9c6b021ea
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2021 07:36:43.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n7j6rLaWr2cQXjyLyRQreberIIudGVXtSFvyaoMp/c5R1TRdNsDTpKmVz9WVw/RVNPKyg8APfIdIPL2s64KpVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7859
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
Reviewed-and-tested-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/kvm_host.h | 1 +
 arch/riscv/kvm/mmu.c              | 5 +++++
 arch/riscv/kvm/vm.c               | 3 +++
 include/uapi/linux/kvm.h          | 1 +
 4 files changed, 10 insertions(+)

diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index 247b761c72fd..ac38696abedf 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -219,6 +219,7 @@ void kvm_riscv_stage2_free_pgd(struct kvm *kvm);
 void kvm_riscv_stage2_update_hgatp(struct kvm_vcpu *vcpu);
 void kvm_riscv_stage2_mode_detect(void);
 unsigned long kvm_riscv_stage2_mode(void);
+int kvm_riscv_stage2_gpa_bits(void);
 
 void kvm_riscv_stage2_vmid_detect(void);
 unsigned long kvm_riscv_stage2_vmid_bits(void);
diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
index d0efdc2259dc..58a47c93e5f9 100644
--- a/arch/riscv/kvm/mmu.c
+++ b/arch/riscv/kvm/mmu.c
@@ -766,3 +766,8 @@ unsigned long kvm_riscv_stage2_mode(void)
 {
 	return stage2_mode >> HGATP_MODE_SHIFT;
 }
+
+int kvm_riscv_stage2_gpa_bits(void)
+{
+	return stage2_gpa_bits;
+}
diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
index fb18af34a4b5..1e12c19a7c6a 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
 		break;
+	case KVM_CAP_VM_GPA_BITS:
+		r = kvm_riscv_stage2_gpa_bits();
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

