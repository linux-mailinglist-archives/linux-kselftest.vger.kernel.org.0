Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62C8F36DD20
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 18:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhD1QfR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 12:35:17 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:64900
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241085AbhD1QfQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 12:35:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZLWMORLgty753KMH5SObPxXZNvND9s2ebTqeH1dCjSKaOR4cpUGPY/Si5/Mw/aLoxQos6n/UywOPGzcKvLUwSLBcFltf6qALlpMES1uGWiRUDXCpQw5ha4+jFc7Ry0j8XRik+1vS9MnUqYv8vtt4qCX2x8NQ8O3hzkVTYBPauVwd4dmZyuFEAy8Ogwr8dLy9u0OcePCnlfJaAZ+AM6MVqizZHgpInJL27E2nhjcMMKHEVylQ7mFxSjrwZkmup5VlOKCZpE0MpNEEze1pRq1a0QiYllgR+e0bWSdl/OfCSKTMj93n/qninNO6idgf5SfkszEvhZ85ebrH+R3MjnGOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG8b5T/7bC0ajHUAn/zHuE8JnYQTZrQtyB9HkERNm0o=;
 b=k7q9XIBJGltyn5R13wtmxPGYZtiViC+JJvf/B0xZjpuVmdfbQgxULXRpcwWZPxowMk00B8rDlhH37PEGJKZtSfRJgyr2FIX04PPJT9dBiPd95YzFLoKGkuX4i0Sz7YATGYcujlEKexwdOSZh3+ZVz6UQfiOn7Mf51nWrLisn2a5hcGbXo7YfvCUWEDfOCFVe0iooGKwbrV0cnmfi5GF6RwLnFj7GEo1M1Sc7yEWz2NTjMBlYY/zCogpkct9zuJwkHAVSgmaT8gIBc64XDLyvtoWayaIOWTCCCJ8RrOURn9Etjw5JYi3un8OIvIvO3oYNwy1zSWXaH23uGzGO/sS6xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LG8b5T/7bC0ajHUAn/zHuE8JnYQTZrQtyB9HkERNm0o=;
 b=kOtPwjDyyje8Qm917sToNjMU8YM429tEt1czCjzENi9oHCsl5G6YbCE9JN1uy3j1bv9SlbVz3oaeXxkD6p1ACKr2qL2ZMSN8peV/IV9gxKNCURIl+NfxzaOLTX2NlavocW5oThtBHZsERJnsfC61Q1br9kShscHAQoctj6FYtOY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19)
 by AM8PR08MB5714.eurprd08.prod.outlook.com (2603:10a6:20b:1dd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 16:34:29 +0000
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f]) by AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 16:34:29 +0000
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
        Alexander Graf <graf@amazon.com>, Peter Xu <peterx@redhat.com>,
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>,
        Like Xu <like.xu@linux.intel.com>, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid entries count
Date:   Wed, 28 Apr 2021 19:34:05 +0300
Message-Id: <20210428163408.20388-1-valeriy.vdovin@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [176.106.247.78]
X-ClientProxiedBy: AM0PR08CA0034.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::47) To AM9PR08MB5988.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.106.247.78) by AM0PR08CA0034.eurprd08.prod.outlook.com (2603:10a6:208:d2::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 16:34:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a616f68-4c19-4384-d26b-08d90a637e8c
X-MS-TrafficTypeDiagnostic: AM8PR08MB5714:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM8PR08MB5714FA0D46D1353E21F2474187409@AM8PR08MB5714.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uES2wpZekReorgObGKArQfCrFUXckDLxJZqzZ9SEoUmBplb7axNqG/zYAP66XJNROF84i4Oqq0GmQxyuWZRtnCEVsdOADEd0AaWsuu1qztiFcWpYAQ5MsrCSdpM89LrVMrCbT4QJE0YCLBH1g79AiWyfsH95zeDBgloOmykwkq6eeBee5qy6tVNfSxVdGnMztAEvXsWK2dS0T44rg5pAQ9iPx5f3XyNAdQL8iWQAUTuUYYD10UfrPMdOYH/Phs1bv/KSqxldRXR8nm9inLJhetHkto4yTGGyhg+DCLZbhFVNETyez700z6oOIWzYOpjhPXsUQ1h4aDrsEVgKCkHdbq+X/+UuFkUs4prHrMpKZNwR2r8L+ghyL54np0zIiiW1jry+GA2rVS3Utz36BOSUm7rGVVQeHuMVF0KTpTfre8kYVXJubiDBHBd6vn3/+ms7ItKPZxdyW+kEbFgWkc4oeexak02jMKBXUvXyeC3nFdBtBgaaX8sMikjt3EbN15tJ4uL93y6tJLOCeDosb1+5t5JWkmm3EC81e8ZCnYKOBP9MpTYYdseqBdK73rn+neTK4LXnskGQkpjsUJaQARHga9MFCGkgcgXosqdI7RuVLfFumf6aDTlO7VuhBnaKZx8g1lKHeohsZl2ElS6yqTgPmUaK7CA50Zpn4II79nhmyrW8uU715l62Uo6WfFm8JMZy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5988.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(396003)(39830400003)(186003)(16526019)(4326008)(6916009)(26005)(8676002)(1076003)(6666004)(52116002)(5660300002)(6512007)(66556008)(54906003)(66946007)(66476007)(86362001)(36756003)(38350700002)(44832011)(2616005)(478600001)(2906002)(316002)(956004)(7416002)(8936002)(38100700002)(6486002)(83380400001)(6506007)(69590400013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: NCf8nsG+pu2ATYyc9JGuQwxOT5mqZHUMi8+UlidbXJdeyD5/FWsexkaIlzxONHFJUVv019NHNy+80ffW5UsZ5V8jtBGabLmSXOSq5hSTMde8VMrhKhGzN3700CZythoPEUe50+nYzRUNwaRWjdkUHppETWmFp77S+rK489H9aClM0e7Pypucqg7LjQDMn6tl2QU+Y/VJZZri96540UTMGG+F0cLgfOMIdFrUQfvIQQyZonTsj04wGzMOx9+FDz1f2GvdvLceNHVVQxcn6Kjy+OtavghsOmKo6H+34pUJZX6KqTPt720qlnV2TdsY3jl46Jxoxvl8UTSSHTqUvkGmLfRpbDfJiB/iMPt8UDmR7tde2rzBJfzFN20xFnCraO5CBknnjZieOmO/6UhZ54wan/zNFGmF3zLQUzNO25xAiuV5qQbTCr+NQtpavjzpIXhOL8TWE8yTOA/fQL5N2QaCQ0LlT0Sb/bGBOu12657W/iygJm9UyYmWsDfQgJj8gK9q9y+rFG3OwNTnH5qmNTYI3Zm+TIKiSMbrtr5mnDWzhBgzMdtzGs24LqxFEm+PKTN6DaLSvIXoU8RkswZQ2AfTQyLiOGSvN/Gkyqzf6WZ8GxExW290oLTBlB09yVAwK/GrJF4pNZOKQOzVFx7P8yPU/3lwXFkdr3PaIKMZZ+nhQf/D7RsIvP25u04/foT0TMrJIGcfIf1NGMh1YXKP1KUEYrMPSYGGtq7uuzNowpZGHDIiQFKqPyOO2mzgYSHefYpO
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a616f68-4c19-4384-d26b-08d90a637e8c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5988.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 16:34:29.3243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z+QNq1hQ9CFwNA0a1CMBStkQ9y5A2bRsnTYps/1XZh4aFi3ur/vnbeesQW0rIoknFVYbLhwupzac/keBA5qK+IOD4x9J1ZDobuTGk+Z4hPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5714
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
index efc7a82ab140..fa9bb6b751c6 100644
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
+		if (r && r != E2BIG)
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

