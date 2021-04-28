Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1465E36DE42
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 19:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbhD1R2b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 13:28:31 -0400
Received: from mail-db8eur05on2105.outbound.protection.outlook.com ([40.107.20.105]:27009
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239542AbhD1R2a (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 13:28:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAjk/UTmV2P7QAJbbV1INKU/gh/5isidjr8xQ185EM76MxcxNBQVRcPca1bAtYdlCOquxrGP+SNiePJ45k8H/NPqcvD0MtvXheQZVGifl1QPC3Qbhqa6zB+dVGukyNKTtbcjQow7WasOkNB3nnDUmu3epNOJMz3s+Hx1MzP0w11BYZgKdQkKmZSWEdjmTHrOTBW+wR3lXO2lPNB2+J8XuJKmj4Dwxux7MvcA15W1RGizOke3uBnQi56YHRJvFUhhADy6Fsm0Pef4jC+aQiYXDdukExGLsPbPQ4kAbOpcwg5M+UGnM2Rwm+oe0LIAzOMX4/a4Q9eHjDj5f1y1dAO7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBAM+oCKw/wuVHiDDW8O+AEHuIABJVQaq+DedHMME9I=;
 b=BEdv9KUHkK2JBpYSmjeTMGVnK6nkG32WMTNACDqHbE1grA3gE9pnVZKNJR4tfv51rqbk4DiDgSDEPdkjcXbRcHYAWTVzyFSy84xApyuJg3ZV8kY4HkpzVfINxbnVwsKJAoWLzuH8cZvq3f2UszdTaZAg+4DhXE0ym41+N13kD0Qz3n08r66lyvwqwg4QmwGJixfNDfpFufRO1k4SbUJmYdIV+a/whXz4uJbZ5ptc4kljxfY/CkI31XkgW0X+nBRnT11C5HTFKUwLSenoNXACSeiUU10jP0QwKI/PzAH9pGCO6eLxdAuGOGgbnwHVSuc0bCth8ES92dilKDtxF6eX5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBAM+oCKw/wuVHiDDW8O+AEHuIABJVQaq+DedHMME9I=;
 b=NZgnuovdr5fMBNLkLSiaLsXpiZGAFVHGmE7zOMqAvVyviTrWJJvddDKGQnhRvY0csGDfxN8wkknPCmewLT3X4JYHV71Kt3/XrkOmPGvXN8cgslr2+m/rxnL1S+uE3N+gqcxKrNlo3097B9EZSGYAPEw+BsDftPd4Cr0VAyc8nIA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19)
 by AM9PR08MB6753.eurprd08.prod.outlook.com (2603:10a6:20b:309::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 17:27:42 +0000
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f]) by AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 17:27:42 +0000
From:   Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>,
        Denis Lunev <den@openvz.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v4] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid entries count
Date:   Wed, 28 Apr 2021 20:27:26 +0300
Message-Id: <20210428172729.3551-1-valeriy.vdovin@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [176.106.247.78]
X-ClientProxiedBy: AM0PR07CA0006.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::19) To AM9PR08MB5988.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.106.247.78) by AM0PR07CA0006.eurprd07.prod.outlook.com (2603:10a6:208:ac::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Wed, 28 Apr 2021 17:27:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a65aef8-1d41-45cb-50b8-08d90a6aedc1
X-MS-TrafficTypeDiagnostic: AM9PR08MB6753:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR08MB675317A85C5ECCD3418346AE87409@AM9PR08MB6753.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wravgZJiDH8noZn0wqCWGm1qbnsKeAQ0mB+VVRKmhLnVyazw5wPDn27f+rhhfPNnYpabyAk48xcsb9o2KyWDgfYLY6bDKY+elufH3LJKWPdt1DYdFnK6j0fTT5SJMfIOW/jDsz7bF7jRxysik/ISdiswVjZUtdMc8VfATFWQ5Euhu1rUZJhmJx+jjoCAtqBlouiELfkkEANzLhUvEmRY8sOV/qLw1zO09WsbnvHtvet43+AZGbIeyQLBF297UiNmcj9C7oyATPF3i7JmI5NX78pw+FjPMqx0N0gvOKBhSWJkhLWuWWXXl3dwDUIl7f7nubo7v3G4F8hXjBJNFKtEA7N1plXhAnWFIm6vOo8N3jNq9IagPtuMupIGqtAu/Yha+cbrA5FuaeZACquhMaJ8cMhKMNDWI7OK15dzMPgNTOFxHt0GCj8ZHoZlxswStLUKOHboCJG+3gJcsFaCCf8PhA1//nPF6gNjZ4KvEVi5PiqBQ/0viDRkNwdNAuQwmeJq/UdMWki3oDvVXaW1Gegqu0sjaNbKM9I0idTSIyzfYFkuFAypTMMKty23QqrvVIjwuRVYXlbeZiExhO63rKWBsKvYYRO/ww9gAnxvati9779ve8vyfq6RMGTXLl5o72hYOl1C2bNhP9lhk8SK3KYkzEB1sEpp7nJBLdA8DTt70i9mNs5Sxwa0tMnvC70fjrWj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5988.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39840400004)(396003)(346002)(136003)(376002)(44832011)(54906003)(4326008)(16526019)(52116002)(186003)(38350700002)(38100700002)(2616005)(6666004)(956004)(316002)(6916009)(1076003)(36756003)(2906002)(6512007)(7416002)(6506007)(26005)(86362001)(8936002)(30864003)(66476007)(66946007)(8676002)(6486002)(66556008)(478600001)(5660300002)(83380400001)(69590400013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?RfL51SEtYHPB9wegSQ2If+N4bmZkSlYIj6FLlTnLsK5OB+u+9dlaQ+ewH491?=
 =?us-ascii?Q?XBuDAx1JhFhIDIFFCbTa4td+ZUX1454QxscdIq8LinV7W7gVOoZpB+5ZGmAe?=
 =?us-ascii?Q?Gx+i3UX8zxVvCUSlgKWtmic3ZwHzqpk0ZGwKmhhCGNlhec7A65L0dmh+yoZX?=
 =?us-ascii?Q?LCu32A7FQcP0gbbdZVp5OHtmNPcsZ/Jz9BkSMuaIxfO8vG+OFtqQv2Oz2/GY?=
 =?us-ascii?Q?A0aS2OOrlgT2wplp/LVPL8MP2LnCJUf2+srO7B/6C/W4Syn9oF5alZbmCHA0?=
 =?us-ascii?Q?nWmG/p2+r2KPwQfhFxpESWJ2pq+FQZ9aRK1f8lUQSHoqcH9lSSM8QDZsz03h?=
 =?us-ascii?Q?WZrI5pqlSE90mSFCFnX3cb4FWrfloiyLiIuV/NIinXNsRJNcMbargwVeq01A?=
 =?us-ascii?Q?BtPKONeQFEglGlPL4FvBtuepAdRUINkICgO6eHWHSLKYmsPQmGle1LNWWDcz?=
 =?us-ascii?Q?C0kb1oc9k2KS+f5Ms7nmos9zB6W/b6W9yd93H9KiCb2d095ERUCK/ZgaDhew?=
 =?us-ascii?Q?wLZul3sa6WTBfaf5jojW8C9dn2E9itnpXMLiCTNzey8IafU9ymXKXkzpQlo0?=
 =?us-ascii?Q?6vsCJlbVJh19A+Cma2KuVbO2lkDQNgchoVi2oe8WpL9hAihlmjocmCEgHJ9R?=
 =?us-ascii?Q?8u6XLDTChV4rTmTpp5wCAgX6mQTrTmdXm1R5AbmCixFp81dgkyzLU9sd9sVN?=
 =?us-ascii?Q?cBthFHGTgdltlqXzR5FX/4iL4wkdaE+c7oIpnkJCAHmhr2hswqxWCI0JDnE3?=
 =?us-ascii?Q?S3aTGsReL3debwKtojEm+RkRcPSplK5PYeN9yOys5UjDHmRGkhdXMkzATK3c?=
 =?us-ascii?Q?ZJIqBeP/FSgliYsUsiu0TEX+jSakmjUOik3t4ij0COWBsSez+7r/jN4JeMD7?=
 =?us-ascii?Q?qFTEmYIAM8Qr1iUwfVILDm+jsLH4v49JJwKctuqVfOMRddbngecqTkqevgez?=
 =?us-ascii?Q?PQ0GE9hsJaUxbbIjF1sZ68+XtX7MnRHrA5MA69TbGvka1NghGbERmNDGZXO1?=
 =?us-ascii?Q?YOKvpinjMUT37nGAT6wGby65qTptSQvdPktqWHO2+WvI7oK5U80ImzGdhfl3?=
 =?us-ascii?Q?e85qpe1/xqa5yo1ApUeb5SjflZ1UBL+eKAYWQuc6M6Q8ybsMqS0mBtayFm4Q?=
 =?us-ascii?Q?wBlvEmgnrMtzu/Ob7sHA66xdUIFYl0tbWndDEuwWfMAN7ECqTMaS+5R8s8zX?=
 =?us-ascii?Q?7SXRDEd322URes9nAN81p0kTv18R38StKKJH0snD2yeMbq4G91CQjJ8CvzKb?=
 =?us-ascii?Q?UfCLvxoDxq3XfYeAaxNIU/8xX5LD1ac7slllfKX3lBNpJ4nvTeelZk4T1Cy2?=
 =?us-ascii?Q?fJAG7mNnbkGXUju5xT0p0hhG?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a65aef8-1d41-45cb-50b8-08d90a6aedc1
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5988.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 17:27:42.2909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5H2pRoLqG7lRComFt96ZnvZPNS2SQfu0qYqSRpb3kZgs79kG2XCV0GJGcG8rYT5vYZv1qweNnrhNajS8JhtskYtVNg7NDRAGD0j6lpsdHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6753
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

KVM_GET_CPUID2 kvm ioctl is not very well documented, but the way it is
implemented in function kvm_vcpu_ioctl_get_cpuid2 suggests that even at
error path it will try to return number of entries to the caller. But
The dispatcher kvm vcpu ioctl dispatcher code in kvm_arch_vcpu_ioctl
ignores any output from this function if it sees the error return code.

It's very explicit by the code that it was designed to receive some
small number of entries to return E2BIG along with the corrected number.

This lost logic in the dispatcher code has been restored by removing the
lines that check for function return code and skip if error is found.
Without it, the ioctl caller will see both the number of entries and the
correct error.

In selftests relevant function vcpu_get_cpuid has also been modified to
utilize the number of cpuid entries returned along with errno E2BIG.

Signed-off-by: Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
---
v4:
  - Added description to documentation of KVM_GET_CPUID2.
  - Copy back nent only if E2BIG is returned.
  - Fixed error code sign. 
  - Corrected version message

 Documentation/virt/kvm/api.rst                | 81 ++++++++++++-------
 arch/x86/kvm/x86.c                            | 11 ++-
 .../selftests/kvm/lib/x86_64/processor.c      | 20 +++--
 3 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 245d80581f15..c7cfe4b9614e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -711,7 +711,34 @@ resulting CPUID configuration through KVM_GET_CPUID2 in case.
   };
 
 
-4.21 KVM_SET_SIGNAL_MASK
+4.21 KVM_GET_CPUID2
+------------------
+
+:Capability: basic
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_cpuid (in/out)
+:Returns: 0 on success, -1 on error
+
+Returns a full list of cpuid entries that are supported by this vcpu and were
+previously set by KVM_SET_CPUID/KVM_SET_CPUID2.
+
+The userspace must specify the number of cpuid entries it is ready to accept
+from the kernel in the 'nent' field of 'struct kmv_cpuid'.
+
+The kernel will try to return all the cpuid entries it has in the response.
+If the userspace nent value is too small for the full response, the kernel will
+set the error code to -E2BIG, set the same 'nent' field to the actual number of
+cpuid_entries and return without writing back any entries to the userspace.
+The userspace can thus implement a two-call sequence, where the first call is
+made with nent set to 0 to read the number of entries from the kernel and
+use this response to allocate enough memory for a full response for the second
+call.
+
+The call cal also return with error code -EFAULT in case of other errors.
+
+
+4.22 KVM_SET_SIGNAL_MASK
 ------------------------
 
 :Capability: basic
@@ -737,7 +764,7 @@ signal mask.
   };
 
 
-4.22 KVM_GET_FPU
+4.23 KVM_GET_FPU
 ----------------
 
 :Capability: basic
@@ -766,7 +793,7 @@ Reads the floating point state from the vcpu.
   };
 
 
-4.23 KVM_SET_FPU
+4.24 KVM_SET_FPU
 ----------------
 
 :Capability: basic
@@ -795,7 +822,7 @@ Writes the floating point state to the vcpu.
   };
 
 
-4.24 KVM_CREATE_IRQCHIP
+4.25 KVM_CREATE_IRQCHIP
 -----------------------
 
 :Capability: KVM_CAP_IRQCHIP, KVM_CAP_S390_IRQCHIP (s390)
@@ -817,7 +844,7 @@ Note that on s390 the KVM_CAP_S390_IRQCHIP vm capability needs to be enabled
 before KVM_CREATE_IRQCHIP can be used.
 
 
-4.25 KVM_IRQ_LINE
+4.26 KVM_IRQ_LINE
 -----------------
 
 :Capability: KVM_CAP_IRQCHIP
@@ -886,7 +913,7 @@ be used for a userspace interrupt controller.
   };
 
 
-4.26 KVM_GET_IRQCHIP
+4.27 KVM_GET_IRQCHIP
 --------------------
 
 :Capability: KVM_CAP_IRQCHIP
@@ -911,7 +938,7 @@ KVM_CREATE_IRQCHIP into a buffer provided by the caller.
   };
 
 
-4.27 KVM_SET_IRQCHIP
+4.28 KVM_SET_IRQCHIP
 --------------------
 
 :Capability: KVM_CAP_IRQCHIP
@@ -936,7 +963,7 @@ KVM_CREATE_IRQCHIP from a buffer provided by the caller.
   };
 
 
-4.28 KVM_XEN_HVM_CONFIG
+4.29 KVM_XEN_HVM_CONFIG
 -----------------------
 
 :Capability: KVM_CAP_XEN_HVM
@@ -972,7 +999,7 @@ fields must be zero.
 
 No other flags are currently valid in the struct kvm_xen_hvm_config.
 
-4.29 KVM_GET_CLOCK
+4.30 KVM_GET_CLOCK
 ------------------
 
 :Capability: KVM_CAP_ADJUST_CLOCK
@@ -1005,7 +1032,7 @@ TSC is not stable.
   };
 
 
-4.30 KVM_SET_CLOCK
+4.31 KVM_SET_CLOCK
 ------------------
 
 :Capability: KVM_CAP_ADJUST_CLOCK
@@ -1027,7 +1054,7 @@ such as migration.
   };
 
 
-4.31 KVM_GET_VCPU_EVENTS
+4.32 KVM_GET_VCPU_EVENTS
 ------------------------
 
 :Capability: KVM_CAP_VCPU_EVENTS
@@ -1146,7 +1173,7 @@ directly to the virtual CPU).
 	__u32 reserved[12];
   };
 
-4.32 KVM_SET_VCPU_EVENTS
+4.33 KVM_SET_VCPU_EVENTS
 ------------------------
 
 :Capability: KVM_CAP_VCPU_EVENTS
@@ -1209,7 +1236,7 @@ exceptions by manipulating individual registers using the KVM_SET_ONE_REG API.
 See KVM_GET_VCPU_EVENTS for the data structure.
 
 
-4.33 KVM_GET_DEBUGREGS
+4.34 KVM_GET_DEBUGREGS
 ----------------------
 
 :Capability: KVM_CAP_DEBUGREGS
@@ -1231,7 +1258,7 @@ Reads debug registers from the vcpu.
   };
 
 
-4.34 KVM_SET_DEBUGREGS
+4.35 KVM_SET_DEBUGREGS
 ----------------------
 
 :Capability: KVM_CAP_DEBUGREGS
@@ -1246,7 +1273,7 @@ See KVM_GET_DEBUGREGS for the data structure. The flags field is unused
 yet and must be cleared on entry.
 
 
-4.35 KVM_SET_USER_MEMORY_REGION
+4.36 KVM_SET_USER_MEMORY_REGION
 -------------------------------
 
 :Capability: KVM_CAP_USER_MEMORY
@@ -1315,7 +1342,7 @@ The KVM_SET_MEMORY_REGION does not allow fine grained control over memory
 allocation and is deprecated.
 
 
-4.36 KVM_SET_TSS_ADDR
+4.37 KVM_SET_TSS_ADDR
 ---------------------
 
 :Capability: KVM_CAP_SET_TSS_ADDR
@@ -1335,7 +1362,7 @@ because of a quirk in the virtualization implementation (see the internals
 documentation when it pops into existence).
 
 
-4.37 KVM_ENABLE_CAP
+4.38 KVM_ENABLE_CAP
 -------------------
 
 :Capability: KVM_CAP_ENABLE_CAP
@@ -1390,7 +1417,7 @@ function properly, this is the place to put them.
 The vcpu ioctl should be used for vcpu-specific capabilities, the vm ioctl
 for vm-wide capabilities.
 
-4.38 KVM_GET_MP_STATE
+4.39 KVM_GET_MP_STATE
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
@@ -1438,7 +1465,7 @@ For arm/arm64:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu is paused or not.
 
-4.39 KVM_SET_MP_STATE
+4.40 KVM_SET_MP_STATE
 ---------------------
 
 :Capability: KVM_CAP_MP_STATE
@@ -1460,7 +1487,7 @@ For arm/arm64:
 The only states that are valid are KVM_MP_STATE_STOPPED and
 KVM_MP_STATE_RUNNABLE which reflect if the vcpu should be paused or not.
 
-4.40 KVM_SET_IDENTITY_MAP_ADDR
+4.41 KVM_SET_IDENTITY_MAP_ADDR
 ------------------------------
 
 :Capability: KVM_CAP_SET_IDENTITY_MAP_ADDR
@@ -1484,7 +1511,7 @@ documentation when it pops into existence).
 
 Fails if any VCPU has already been created.
 
-4.41 KVM_SET_BOOT_CPU_ID
+4.42 KVM_SET_BOOT_CPU_ID
 ------------------------
 
 :Capability: KVM_CAP_SET_BOOT_CPU_ID
@@ -1499,7 +1526,7 @@ is vcpu 0. This ioctl has to be called before vcpu creation,
 otherwise it will return EBUSY error.
 
 
-4.42 KVM_GET_XSAVE
+4.43 KVM_GET_XSAVE
 ------------------
 
 :Capability: KVM_CAP_XSAVE
@@ -1518,7 +1545,7 @@ otherwise it will return EBUSY error.
 This ioctl would copy current vcpu's xsave struct to the userspace.
 
 
-4.43 KVM_SET_XSAVE
+4.44 KVM_SET_XSAVE
 ------------------
 
 :Capability: KVM_CAP_XSAVE
@@ -1537,7 +1564,7 @@ This ioctl would copy current vcpu's xsave struct to the userspace.
 This ioctl would copy userspace's xsave struct to the kernel.
 
 
-4.44 KVM_GET_XCRS
+4.45 KVM_GET_XCRS
 -----------------
 
 :Capability: KVM_CAP_XCRS
@@ -1564,7 +1591,7 @@ This ioctl would copy userspace's xsave struct to the kernel.
 This ioctl would copy current vcpu's xcrs to the userspace.
 
 
-4.45 KVM_SET_XCRS
+4.46 KVM_SET_XCRS
 -----------------
 
 :Capability: KVM_CAP_XCRS
@@ -1591,7 +1618,7 @@ This ioctl would copy current vcpu's xcrs to the userspace.
 This ioctl would set vcpu's xcr to the value userspace specified.
 
 
-4.46 KVM_GET_SUPPORTED_CPUID
+4.47 KVM_GET_SUPPORTED_CPUID
 ----------------------------
 
 :Capability: KVM_CAP_EXT_CPUID
@@ -1676,7 +1703,7 @@ if that returns true and you use KVM_CREATE_IRQCHIP, or if you emulate the
 feature in userspace, then you can enable the feature for KVM_SET_CPUID2.
 
 
-4.47 KVM_PPC_GET_PVINFO
+4.48 KVM_PPC_GET_PVINFO
 -----------------------
 
 :Capability: KVM_CAP_PPC_GET_PVINFO
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index efc7a82ab140..3f941b1f4e78 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4773,14 +4773,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
+
 		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
 					      cpuid_arg->entries);
-		if (r)
+
+		if (r && r != -E2BIG)
 			goto out;
-		r = -EFAULT;
-		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
+
+		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
+			r = -EFAULT;
 			goto out;
-		r = 0;
+		}
 		break;
 	}
 	case KVM_GET_MSRS: {
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index a8906e60a108..a412b39ad791 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -727,17 +727,21 @@ struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
 
 	cpuid = allocate_kvm_cpuid2();
 	max_ent = cpuid->nent;
+	cpuid->nent = 0;
 
-	for (cpuid->nent = 1; cpuid->nent <= max_ent; cpuid->nent++) {
-		rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
-		if (!rc)
-			break;
+	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
+	TEST_ASSERT(rc == -1 && errno == E2BIG,
+		    "KVM_GET_CPUID2 should return E2BIG: %d %d",
+		    rc, errno);
 
-		TEST_ASSERT(rc == -1 && errno == E2BIG,
-			    "KVM_GET_CPUID2 should either succeed or give E2BIG: %d %d",
-			    rc, errno);
-	}
+	TEST_ASSERT(cpuid->nent,
+		    "KVM_GET_CPUID2 failed to set cpuid->nent with E2BIG");
+
+	TEST_ASSERT(cpuid->nent < max_ent,
+		"KVM_GET_CPUID2 has %d entries, expected maximum: %d",
+		cpuid->nent, max_ent);
 
+	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
 	TEST_ASSERT(rc == 0, "KVM_GET_CPUID2 failed, rc: %i errno: %i",
 		    rc, errno);
 
-- 
2.17.1

