Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A4536DE1F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 19:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241578AbhD1RWK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 13:22:10 -0400
Received: from mail-db8eur05on2097.outbound.protection.outlook.com ([40.107.20.97]:14048
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229931AbhD1RWH (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 13:22:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kx5/TxnzHeu0zOsD+DitZxofzPt5Th+NY5TLtJcPM92MS8BLlUbHn+922uy7iceZk7PH0HU0YVFyhoy7o7QV85QZX/rf6j2qgSryzPv6PTkJohz4SBDCwPoQfJNHV3IRdETYRFLspvs0WH5er39fhSLpMSXuKDFJzN02hbEkTp+XugHIBt8TmUCW2fci84Eh6IYBKMgSgCRctwdOrUM3/9KfBzu0guxehUxF7prFeLPoQ5F9uD6S4nYE0n9tQTeINqlrqHJlIizVpr/N8eLORX+RYa28AiGwg+AHB9IS4TJMyIccN0XtFOB+TpMSW8ht5yudQoQ43EPn84dP9zVidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUsOmLQns1Jh8tj/9v4ddUPkij8uQ5cVgynwE8coHFc=;
 b=HugwTxAge+Pc6XaEE9MoRgOBYsDq8nUysi/c5oCxEuwuZHiUzN8x1imN8iKfI3Zj9mHt35w5B+9H+I4l2PLCarL5GgboPh7EYK65wIRAMj/O81F1GWUWusGM/6BqVjk0dPgOY8uC30LcI2xGsI7OQliSQO9CiyQdR/Z4AJCpVkJL9GxMb/A0p5dCrxezqsKEkqBtViIRAwEd9yunX6xFVhQRJO/HGziwcJ4JluMMnKs4KqCT/zHVjbURkl1ohybzfdqQEj0tcGWDABLvzVSWgKQA+ezZJNizsiDqU9g1H5byxyDtH3F2VSO1sHbuwdC9Vk7p4VO1x9Ql+PErNLikNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUsOmLQns1Jh8tj/9v4ddUPkij8uQ5cVgynwE8coHFc=;
 b=X5LZNL1SggDTQnE651Ggb1pQTQnlYHbSdpS3N8it65lQqJH27GIzGTLdFIda6AVh8U+m2a2ntAZfq0idS1j2kZmh0a+MQ2XzEAA4lrqndfGs7ng/PYjQ23Uyl1X04NERgkacPEnx8FrZ3zGVmd5/QTUf+Hp5eQ0bTZwHZKuWkiY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19)
 by AM4PR0802MB2193.eurprd08.prod.outlook.com (2603:10a6:200:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Wed, 28 Apr
 2021 17:21:19 +0000
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f]) by AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 17:21:19 +0000
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
        Like Xu <like.xu@linux.intel.com>,
        Andrew Jones <drjones@redhat.com>,
        Oliver Upton <oupton@google.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid entries count
Date:   Wed, 28 Apr 2021 20:20:26 +0300
Message-Id: <20210428172028.3339-1-valeriy.vdovin@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [176.106.247.78]
X-ClientProxiedBy: AM4PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:200:89::24) To AM9PR08MB5988.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.106.247.78) by AM4PR0202CA0014.eurprd02.prod.outlook.com (2603:10a6:200:89::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Wed, 28 Apr 2021 17:21:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acb01369-2e0e-4e6b-2fc8-08d90a6a09b3
X-MS-TrafficTypeDiagnostic: AM4PR0802MB2193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB21933DF2E652459B49E8F32787409@AM4PR0802MB2193.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ov8LYXyE4eM5ICoHWhlPBdVDJYayzybW4+TOnFJuRPAVVt0YoZjPRFljQEu7qXgm4xBxTb/9ZM+7JubuL/umFHNVLAu3C5pasijy/hp0BM1zADaWslbWR8AgsBzGySW82K6v6ge/1aJMH4cUvrbVFBmHbz9uJ7lJmEMu5wUKy4viKkByHJ9YLzNBMZZLMlUDM9tMFVh4i/5N2KXMJZoU3v/KD1KjrHbrTU7Y4Nk35b2EeD5VBrZ8+uYnWscEPmyd83GbxD2BNwiCcfagK9R7oHa7jA74P4nN4lbxZwc+0KA8kUMdcSZwgoJ9rFjQGMOR/cCeeCrQeE5ZHxGEtXu+RENaFgeVgrIcUcqHP+xxGaL0IFc0LjtRSwsWIaNmOFlQA4tfpkm+lmUwKReb+7kOZXtQ8pWAJvasSUGGbZmQCpYlNfJYhZXmP6fzDnvrLVI3B5CF8sVrZaRTtXCHd09ePcdXM7+Kb+MopjQi3vyLGMa8FhhuXHKfMZFdjJKezPNz+26pE5dS+xWyd0I+2aiBQwaBGtAC7+tc5Mjb7Oi1vsIA/i9O1iHY6BcgLpHBsazlGLHQSJgQPIJFkvgEav8oPY+/kldduIm6Wo6ov3/ZmRTZlLE6hlRKYAQWoB7POUUtnlQi+RL/tfZZ3g7cEqb0bxNBJKwXXT5OZ0Vy2RwZwZ857yvy4avi7adLpXRmJzOH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5988.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39830400003)(346002)(396003)(376002)(366004)(136003)(6506007)(2616005)(6486002)(66556008)(6512007)(1076003)(956004)(5660300002)(36756003)(66946007)(86362001)(2906002)(8676002)(8936002)(6916009)(44832011)(83380400001)(186003)(6666004)(16526019)(26005)(38350700002)(54906003)(52116002)(38100700002)(316002)(4326008)(478600001)(66476007)(7416002)(69590400013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?KGzQUabDtWV35YzNymhXifc+zPo8tn5+AkpjlpeBofxssE1HBksU+ainvN9/?=
 =?us-ascii?Q?fM2uh0Zb2nnB9RBwVNNttngk8Ps0NJcrCHSOzzmqaAHXiniPrOojtefJ+7cE?=
 =?us-ascii?Q?QDpYU8qoxPrHPhEE9fz44gzW147eoSTMktANa+MLHQvYze4Oerls5mYN4N9y?=
 =?us-ascii?Q?ySvWm7FFu59iWJVgEe+NOrUbhONetJojnnoYbPTMz/EduOruFBbEWlTbtTPb?=
 =?us-ascii?Q?B3Zs5pDRMDuFeqOdfloIQdfzGFkGr5GAbNJiPEDaZ/+ob5qLa9eIXIe8rdGf?=
 =?us-ascii?Q?BBzRBqQCbzejLEuhY0nJk34din0sRWaCwZXyiawC7vByia+2SfK7Sx42YgY4?=
 =?us-ascii?Q?73SpXdave4aE3ATNe7nrlYTZJil8GL+BRqryry6ENBhhhr93cNm6ic0KChyK?=
 =?us-ascii?Q?XCii8DnMOiTw1GS/M/QcX5Xe5Q7G9o3CgIT4SdkX/Rn3h5Iqbl0vM1XeUce/?=
 =?us-ascii?Q?xGH4rb23vlEU6q7wx8JBco5krabt4+YPwtcXp1YnMvz41cSHOVoxoc15U38V?=
 =?us-ascii?Q?cNY0xIXfNzVVTrBT1HkanJtE3S0Nu7jN7UsOyY1ksYvAm+Ioy3iTTPFEJBMg?=
 =?us-ascii?Q?GWbtzL5hkmM6eq6Ch8i/jdOjs4WWPpXDQCpvmQWnPyXmKwEf2XzVMCG00cgV?=
 =?us-ascii?Q?PjF0KMjezEaFVe9in2YNSjU8yfMXYHPF3SLQsM4WG2nNc3TT3ZevLNAXkltG?=
 =?us-ascii?Q?UNzt1BCRz45dzBDqhdtd5DAsAxs6IdB8GE+WKdcdD8Z4KbpGN5tDoymBijKd?=
 =?us-ascii?Q?HBY/yH4pDXWj2Rko+o5PvNkfH8uWLtlfsY+klCbGLVZklQOc1Wr/Mje4rGAB?=
 =?us-ascii?Q?cNLTrPIwA0iin/w8UIKBA6rQ+iN6pVg9JFQFbkIlVO65vnNiOEUx991uYH7O?=
 =?us-ascii?Q?VaxIrdb2bkdMDA3XueFTeX/SicVsupAEWC3BoN2W/Q4Hut20AzddLJCdMA2O?=
 =?us-ascii?Q?SY28oKko+xlklhgb33ExfJznLYqNs4I9lMlXxZZGmL6DN/zOL5vNt2r/BFG5?=
 =?us-ascii?Q?3CMnRPKh9ur8wEN/oPdyRttaI7i98w5M7IKC2ljroSkcXjCE1XqVJeFR7zpi?=
 =?us-ascii?Q?C3uA5o9CckXkSLbRSw+/WIQMC5DIDxIElX1LzLfhAWGP5J6PmL+hSJD2U+ce?=
 =?us-ascii?Q?B82+NAC7a1WUjNqjF5potpaBHfZUYuXzHnqaVuNcffRTsj4rieSSU1/emAZA?=
 =?us-ascii?Q?8LeqMiwDPVHA1lqP5NAP2PS0y4eYn/zf1TQ1Z79RQV8cBaKNeG0zA/Bg19eH?=
 =?us-ascii?Q?YO6s1WQBo6jjfg+Yll6OG/opVQrhDTlYONU4CviXBu9pP1TZIMuN5CALvFOc?=
 =?us-ascii?Q?+fl4oDNzXzcXJcaVnZ7STOMl?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acb01369-2e0e-4e6b-2fc8-08d90a6a09b3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5988.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 17:21:19.7365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LANXsNw4gxRe4ORUAGiLLqWcmAzjwJJ8u7hOaZBP4lwNrAJJw91iQn0GoH9/wezerNXrwwjPRfi9uAtPxj16FGmZucvcVcY3wyYZKkalbic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2193
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
v2:
  - Added description to documentation of KVM_GET_CPUID2.
  - Copy back nent only if E2BIG is returned.
	- Fixed error code sign. 

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

