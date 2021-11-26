Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A528B45F0EC
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Nov 2021 16:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378235AbhKZPqL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 26 Nov 2021 10:46:11 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58046 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbhKZPoL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 26 Nov 2021 10:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637941257; x=1669477257;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=UvMhmajLI2xKJt61vOJnJU10E+9HbwYJfu96S4+MsQA=;
  b=CoEky+EXlBSO6nQry/+qi4P59BG0v90Co5BGWCzzhlyf/bEwJz8SBPsY
   9X92yU108KFeI9vFniFcgALH2VtR2jkzxjn1JhFBrs4IfNcTA7hFYwjRu
   9U015tmEEtc9Cr7wWRowBl/LjhssPbs6c9uMlUW0WQ0Gi1ULTQqbvdqJp
   5WnsLyC18doua46cm00ECxQ71XeYBvYLnOL+iONRzJm6WICShdOVL27uC
   8BPID67cyzsIzSUHRIcn6KAYjXkbqlCtBMqnUPwGROd/MdMSI4nSOXMyJ
   sH+DPSp7D7e4r54M3UiFf2Aanigbc59SMVXrr5deKxB1mvFIAX76vmqk6
   w==;
X-IronPort-AV: E=Sophos;i="5.87,266,1631548800"; 
   d="scan'208";a="191541507"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2021 23:40:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n23agR7kwNMbZJFu2UYNmNRUhnR28OC2GnTmBljOd1rdO2KrdbMx7NG+rKgCzcGEnqbajSQfpMOnp8gxh04F36Nm6TK9Ma6pOj27fLmFeqPdPF+zJRj2Tx/dNj6H3BOkgHGzdP8dI5p9QfiS7fV+wLa36SBcCMK66uUX6exTvfcno1UJr1xPjpVBppj2vQXCGzWxb7Voxq2ERAVp8Ih46OOnpvGBSalW5QeOMPFfhIw3I35+zYV2nOAr4l20/MI+8sOwWsaO7G8LUWeGKIX10O8wDG60t5Wd89BjCgARMDO+4mB4CJEHuyQkGXfQZdVqdz0hGmkzVsiUwV0aoCfgVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd9MbxmTph6FKRePFQlLrz8Xb9yNl9hX8XE8rQyPpO4=;
 b=btPMDwVH18pGNK41yLkKck1BLf60s4+Pb3cmSrGa2HebNV3xZmowel12ISUmE+BAeWBy3qDO4Bsnb6vUU0qWNWk6ePFaQMqtRCkbhQ+viBCAjiMV9TJZ2f2tm8zbVtWOGwQGNaQblrIJ/nJydRLS1tqPFdquLoHZCMsv4qE0jGEgYxt7v3l7DJgQFD0Pg9kId4219S8O2Xamg+GNx6bxNZC6FVuVWD0PPvMMuclexgc+gPWBZ0K4BTJga5w9u4iXHXrlXpDbVS+WuJP7LSGO9BtaUzx7LwWeryjqmBmiTsioybkSpeBj0IMIKBwHj2/nlEKJISqfDF8D5CiLFv3rRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd9MbxmTph6FKRePFQlLrz8Xb9yNl9hX8XE8rQyPpO4=;
 b=lbXdm6MVHaEgChlVm+SOm371P+IuoYUUz81XwVoxZvYmOHvlSTssUShDWa8/wS0wOQqVHcUSI8EhJKp3UVpqKqICfk43NosDYxd/VhWXLajc6Zj7DvFk6q9AgSLEEWcX5PdPEwybkUhQH5Rx9nXYSfpi//wEQZL21v80r5M7KUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from CO6PR04MB7812.namprd04.prod.outlook.com (2603:10b6:303:138::6)
 by CO6PR04MB8330.namprd04.prod.outlook.com (2603:10b6:303:135::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.19; Fri, 26 Nov
 2021 15:40:57 +0000
Received: from CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97]) by CO6PR04MB7812.namprd04.prod.outlook.com
 ([fe80::8100:4308:5b21:8d97%9]) with mapi id 15.20.4734.023; Fri, 26 Nov 2021
 15:40:57 +0000
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
Subject: [PATCH 2/4] RISC-V: KVM: Add VM capability to allow userspace get GPA size
Date:   Fri, 26 Nov 2021 21:10:18 +0530
Message-Id: <20211126154020.342924-3-anup.patel@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126154020.342924-1-anup.patel@wdc.com>
References: <20211126154020.342924-1-anup.patel@wdc.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::25) To CO6PR04MB7812.namprd04.prod.outlook.com
 (2603:10b6:303:138::6)
MIME-Version: 1.0
Received: from wdc.com (122.179.118.153) by MAXPR01CA0107.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:5d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Fri, 26 Nov 2021 15:40:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 095abe3d-d703-41dc-5f2f-08d9b0f3235a
X-MS-TrafficTypeDiagnostic: CO6PR04MB8330:
X-Microsoft-Antispam-PRVS: <CO6PR04MB83302BEEF72839B951BC768E8D639@CO6PR04MB8330.namprd04.prod.outlook.com>
WDCIPOUTBOUND: EOP-TRUE
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQyrjq01RPcqLxDt23o1AejKQcfAdPUcSz1nBzUlqm0WCIbYDXMZ1TWsyfyPDPpjn5RTs50rN+1gCMTMOk0p6azveTKIWMoy5IgbwK7ndwnDULVaMv7iulMRhMocuCdgDoFCWfhoMxq3W+NUE0milNoQG0rbN/kgPm3gc0NKk+nORTYfsGeyl0bJStIhdX2/8UyzY3G+suLlovNv1Z9yJhECCon7VqhtnuLicwek+kBcplKnYrUq2ZRYnVMqFfohY8moTWTazA2oIlf9eQ8pqj0TbShXuECTAzkAIZUBedZV56OPIkFdrbU5XPQKr8/XKmfkyldyjloSG25GxR2voQzDVejm51lYfuxDFBqyWFqG/CUVEOeYisH75g1jMWkKMPzGve+1YuBx0DtgOdR2QEGQzG+qSB5d7rOncpICH8eYhqVKy0vR6fsTZxulaDz4oQvGofoKJ9GML2vN1Lj6v6VVoZnzjr8dS0+q1V14o3mOzxkEzjIFS7DMSUZVahHMQ3qPlY0xvswt1fIdb/S2U6/gzG5LR4VKpfA4oWOdeIFeCGH0tUjzwp0APQCdH3S9+CTxloOOg4+P4/HHCJmo9Vw5QgCjGSNWX9jB2iWlBodAjbDUO+6CES9Pl6aB9VRvVzKZzSMsBpCjUfU/iM5EZLeo3ZgHA2ezW4KZyYvQEGsNGbZV/ZK/gU4FP/wSohWuHU0/13dssamg9WZA5Pw+fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR04MB7812.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(1076003)(54906003)(66946007)(110136005)(38350700002)(82960400001)(26005)(66556008)(186003)(44832011)(83380400001)(316002)(6666004)(86362001)(7696005)(956004)(2616005)(7416002)(52116002)(508600001)(2906002)(5660300002)(36756003)(55016003)(8886007)(38100700002)(66476007)(4326008)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2iVhKPFs4g3NfSwX5xUciiTT7T8KPLb8Zo8TRPaCZ1oAuI0QKLLyiIESo/0p?=
 =?us-ascii?Q?o01nXff0jX+eECAwyc56Jtj3AwFNeuLsGkOnGDZv4LIieNrpkUOPHZBkE402?=
 =?us-ascii?Q?8F8LjIwzPnZ+BWGNMfi1swzU9tJdSI1vvF+XHw0FSTDe4yz9zImbQoqRFBDV?=
 =?us-ascii?Q?ACEY6z4pS24CLICm5V9tDj0aBdsLwUZkc2w28EyrlnyQzLUfwruDxuDxDzxb?=
 =?us-ascii?Q?ivn4dbSnxuF+P2EJXPzDl3+DjMQfuOSWQfEINNjytRSV1E7M1pth8n8WRgDQ?=
 =?us-ascii?Q?8sp2lB6zeyK830/xR1nK5UY5fJcU9L5X7npGe4HmqDjSJsB+wsOpOjHqNTui?=
 =?us-ascii?Q?LsaiOSfe9UMfbBcpGv29pF0ioeNEPavv+QrJ9E05uEKCcfBrV0ChJFlnKi/W?=
 =?us-ascii?Q?qTywDY6QMOHs2nMd3CXAWejJ7e5FMBw8kk20ZokOgDHVrKH56NrHwTbFadTU?=
 =?us-ascii?Q?yskZ8ffcziPvN2p83dj63wsq1DkF7pM7wzomx3MDrMctObwWvNlkaXb5hyb4?=
 =?us-ascii?Q?XurKsaU/ztwuEzg66IwpidupWHOIh5mMV4KjqfBGlZVZRqJ98U3omSz2dg5M?=
 =?us-ascii?Q?n40xxTb+qaYGOtjibPD9pUHulbCayLnuRkNijS5injTyFfzxvvjDPmVuzgtw?=
 =?us-ascii?Q?0r5egxCvG27iHXvJBOsUJXaMO8kgFV6unRgcdUSkqoQ0C82XFh0V1r3TZPtB?=
 =?us-ascii?Q?94/pAra+UFDTVj48/hOwZ3hJHoEwScpLkiD+yTkjY9oRbvthhDFMJBnB4DGW?=
 =?us-ascii?Q?W1LMEaKNmE9LlaNIhLDlOYsQk7bXQeZ56dJTwTYho+yU6g/t7BMnVs2x6Cjn?=
 =?us-ascii?Q?SXDrGJNt5MN8FXSfZQOsQD7hTaQESZbdKfafnWGKFEYhMRATSg1JQR9qzpPy?=
 =?us-ascii?Q?5zKH/nt6Z07RnnukB8fzx1l980sLMP7Fk1M9G2Zaw27m021KjIf+wB0+9tXg?=
 =?us-ascii?Q?SsCZfomcfRMcuxO5GVOgQFnzM7nMuM/kJ4DEN3Eqc0xpHwekcnaDsLVrdWf5?=
 =?us-ascii?Q?ungveuvkLaKZyCfSofu7r8jbGAQ651fISP4nyOJAv79Zox1udCBYDHG1pilg?=
 =?us-ascii?Q?0wb3BP7TIwKfFU3iQvVRGbtM6KrH/b8g9HBp9N49Ft2w50uprmLrA18IjCxJ?=
 =?us-ascii?Q?6hYhIRbktmPYLlIhR0+VBxIuDr1VN8gAlXNwTFZ+BXjpIeKuvJLW5qOhWB/D?=
 =?us-ascii?Q?c2+PrYfn0Ej5cK6Z/l9Hl97WShf04Y/T2HPpq+nXYIK4Z//c5R/pafjymQ3w?=
 =?us-ascii?Q?St24cMfgY75H8HmkDthvF5pfn4tJNVLMT9vYXtrxunVeq2XyAfWza49H6Gpp?=
 =?us-ascii?Q?A0tjd2ODd64rAq5Bmtt+vv2ymowGtm7vtblbJHdeI5+iittchwjUI6f7x29m?=
 =?us-ascii?Q?JtFCuyoEfQUNRfJIn/zdFkP1r5daDyBq62b+LcO7zu9reYPsUbZPKE2HfLZz?=
 =?us-ascii?Q?8g4oOyrvDMrsNCKyAdYJIxlw2C49Rh3Lc7itc6sV6q3Qskf87bHKqjen28M4?=
 =?us-ascii?Q?havhNqxtwLS0rJKPZL3Df1aCD8d5A/VHZ4EDB4oL98+OQfghoa0QHs1x7tnA?=
 =?us-ascii?Q?XVllWAZqygxOkCGFNxr7X0D9shXYAc4v8T1t9hCv/3MkmcsyyjtDqUS9HWeZ?=
 =?us-ascii?Q?swZlR/64tq0p+sR4E4TPriw=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095abe3d-d703-41dc-5f2f-08d9b0f3235a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR04MB7812.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2021 15:40:56.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0QGzurF1kkvDAI3JxTYM1eqRQN9S9B2+ddKcWrbd/cD0fVt+6VpHJm1BKabQ1Uya/+vr0DYY1uT+H8W9aDkGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8330
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The GPA size supported for a RISC-V Guest/VM is based on the MMU mode
used by G-stage translation. The KVM RISC-V will detect and use the
best possible MMU mode for the G-stage in kvm_arch_init().

We add a RISC-V specific VM capability KVM_CAP_RISCV_VM_GPA_SIZE which
can be used by KVM userspace to get guest physical address (GPA) size
(i.e. number of GPA bits) supported for a Guest/VM.

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
index fb18af34a4b5..ae97f6929897 100644
--- a/arch/riscv/kvm/vm.c
+++ b/arch/riscv/kvm/vm.c
@@ -82,6 +82,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_NR_MEMSLOTS:
 		r = KVM_USER_MEM_SLOTS;
 		break;
+	case KVM_CAP_RISCV_VM_GPA_SIZE:
+		r = kvm_riscv_stage2_gpa_size();
+		break;
 	default:
 		r = 0;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 1daa45268de2..dac98df3101d 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1131,6 +1131,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_EXIT_ON_EMULATION_FAILURE 204
 #define KVM_CAP_ARM_MTE 205
 #define KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM 206
+#define KVM_CAP_RISCV_VM_GPA_SIZE 207
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.25.1

