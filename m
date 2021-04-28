Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416F536D69B
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 13:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbhD1Lh5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 07:37:57 -0400
Received: from mail-eopbgr60102.outbound.protection.outlook.com ([40.107.6.102]:25651
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234158AbhD1Lh5 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 07:37:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3PgaT8MU+bJOFltItTfOEXQlnq1loGT2L6dz2QWNGqq1ki0makfqjOG8w1hjbJ2lRaRud3hIWOFQs23sUCFwXpATrWCnI9g6Ma/qvW3fckrY+fy2NhCbgXDe1bYL79O9Ob2n7cQR4lcQ9faWg/pjjhO6ngLxLIRFUUqqUcje/Peur/KVrffZAErSUpIDXAowks+Ni6eUaTsw/N47pvgCtElkXAFJIDJqR91z33RZMyKlpSXlXIAkPzaunbrfjdNsJ++yBmZ7S0hiJW1pW3ysqpNxOB1OAtSvC720PQbDwsaJ1n0W+ygi894EJhXEg5HyXDdZBAboWgDlrhR9egQnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0db4OClljsDs15qUYvQR9/uVd9LLVF0JZzUbGI9oD4=;
 b=h6bR2EPIiqmJE0vjdhBSEJOvEYWUGLYGkC4Wpy6pEHkBEigv8rnDGw8iK3vvVB9bJf+nMVXtmn2eADXbI/tSC7OmZAW2Jxidbw5/u8p+LwR4WHBhx5rVoUDDvJ5b+uNAOzsKdmgaIzfB1SCnfg9IZWSJcs/z2MPSA/RP2L3OF4b2kmragLz/qkCb2lBnWunmK0GDudKeLohgKpqpe0qK2miva2HYFPaqSyhIWIi1oWB93dzFqfLlacElLfo2oPOEVO+Vm2XPShyzmyo8RsEImaYlnd40GbhIptmJ9VgnNfMtWvLGWMRPE1zpudU633NWOP7TMrIvzXnvRj+xfcx9Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w0db4OClljsDs15qUYvQR9/uVd9LLVF0JZzUbGI9oD4=;
 b=UzEVulf4KKv3wdfZvJh9S19ruh3PXIM0ErW1sM8BLc3XxVFzVKxVB9Xedcpkp9KEEdvKQXIeztPwSHGbZLlHvHI21ycpceHuXtpOqpxYHs4BLzMDbylPFoHdTGHEYLm9gqH7CrCi6Pq1BTsHhohymbjdMGdB1fMiogAE+uYgQoU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com (2603:10a6:20b:283::19)
 by AM0PR08MB5539.eurprd08.prod.outlook.com (2603:10a6:208:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Wed, 28 Apr
 2021 11:37:10 +0000
Received: from AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f]) by AM9PR08MB5988.eurprd08.prod.outlook.com
 ([fe80::7d3f:e291:9411:c50f%7]) with mapi id 15.20.4065.028; Wed, 28 Apr 2021
 11:37:10 +0000
From:   Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>,
        Denis Lunev <den@openvz.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid entries count
Date:   Wed, 28 Apr 2021 14:36:52 +0300
Message-Id: <20210428113655.26282-1-valeriy.vdovin@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [176.106.247.78]
X-ClientProxiedBy: AM0PR10CA0104.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::21) To AM9PR08MB5988.eurprd08.prod.outlook.com
 (2603:10a6:20b:283::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (176.106.247.78) by AM0PR10CA0104.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Wed, 28 Apr 2021 11:37:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b60e6f-7204-4d1d-f717-08d90a39f58d
X-MS-TrafficTypeDiagnostic: AM0PR08MB5539:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB55399D01439102B8FA6DBCB487409@AM0PR08MB5539.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3oiYFwACeI/L9kz90AKbQJbmN2GOb7tA7sp3dwI8hBiCKjCRrqIeTvBBkvE4aFGqgT70ZQ7dfJFIuM7dfi3y25nLm+rL1+1XtGuXvuOLGiImhe6DfdVMpTmVBN1To4i7itXnHZgsJSTuSE4Xxlsgyu64ccDEFOLUYN7mpYW2I32gsmqCz5nByV2Xcv8XtfJIz7ThlRT8rRsMzgk9oO96fXhuDk2z6byDKpvdOd/Y/HuIPjsPzqe8HGVM34vnxlgX+MMM9VMnJOFt1Rfqmxe1tUc7Mnmn6Jean/EgKkZQgSvp6J1mGDM5oyjLRWho2aUObaGNP7jOVdaP3CPy0Pb2Aabvxz1h7wVT8wj6+9q9n2uPoXq7EUVqrfjpP8PTNYKt+yoHZP1Sf3vPzUTfT4B1j0ZVrwyc0+HPS1tJXzqbBMJEuOljf/mhOVPGg63u8A/Xk2CBOonZhx66Wjl59pIWpiizPqI2rjTe9YBptmFTCM8C55OrhpsaEW+xV7x1OI9ofBzR6+sbW0saSrxKxc+xpp4+mABy09lguFVy9iZGZBioU+K1evXEj6HNq9dY3CR5WzU4ByH+k33EOk0MO1KSCv8P48bE2Rf6nrrYDrSvTdaKXMt0mSLlx+ExS9Q1eZ1Zl94iMGsFoKZyAUAl6mEv/Zy0aH0OEL0JRKWAwCqXhbGfc8SOe6MOGV9EIgIqGCqZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB5988.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39840400004)(8676002)(6486002)(38350700002)(66476007)(38100700002)(4326008)(36756003)(54906003)(2616005)(6666004)(16526019)(478600001)(186003)(5660300002)(8936002)(86362001)(7416002)(44832011)(2906002)(316002)(26005)(956004)(6506007)(66556008)(1076003)(52116002)(6916009)(66946007)(83380400001)(6512007)(69590400013);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?B52IVhnHobvkWeHQdmAI5jsb/ja6X4D0NsM1TnI1ylLn5ASdK4rdTuaCTdO8?=
 =?us-ascii?Q?xx391enXO8p0QR9Fx/XJSEMVLwmYtcQs/r9UDPphgg2NwBzMUxf2GBD+4iGd?=
 =?us-ascii?Q?O/QLEcudUcrBWukLYMEEtzpu4/cQLy50QovQ/V/XWDtf5Fk0hnGDDY1Yq5d4?=
 =?us-ascii?Q?RLcyHL2RijB9++iUkbF7gV5tFqG8txshGrR0zvUKuAEYcnlJOyZlAfMNtpas?=
 =?us-ascii?Q?WGR1+n3jeFlyGCcMJIUQreR2UIeEEsEH9VVgy5fWhoDrF7X7fVwNIzuMFBqp?=
 =?us-ascii?Q?gxTT77CZ92fpseooensdUy3Zixa+fJwShFod/rLtE0YSurOR9lDVZb7/UKfm?=
 =?us-ascii?Q?Alnex8QsyGyRDEf1Z88CCim85jqQZurntCfWi2PvlvyOfvNu/2484j8cyfF1?=
 =?us-ascii?Q?GuXP9Bypmq74NX95rYn82I4gME7/b+LNc1VXpOIXHKHf+Fr3U8UGqzOWwI0I?=
 =?us-ascii?Q?t8BbW+Rh4iYbyeTpDmnn2Xx62Z9NFdENU1wxcyrJzsOqyrardye39pSp6+NW?=
 =?us-ascii?Q?2+rojYWjoGVBE6Yj4rGLZKsJAnBn7O7R3k0FtkdvQpPsJUfWPoFY0bH9OfoE?=
 =?us-ascii?Q?kKZMPLPWTjiOH/dEZJ6q4g96bhPoUCpGsJWjv4TNCOlw7QvEToDWGWwpMVqq?=
 =?us-ascii?Q?RCzLFqHHiHn6xrV5mj7kGl+BpzKHZG4gPIy2eZgvM6dZJC2gj89V9Gbc5Nxe?=
 =?us-ascii?Q?jc/mXZPoXEomd9EjI61PVY0A/kVy98OoODklLYg/V4RygS1ZsjExJ5o0u8FT?=
 =?us-ascii?Q?KMrkeo/W9B8OpXhQ8rogM3vopOc0S25QrbqO4lzu9UdWiil47K02oyW9vJhM?=
 =?us-ascii?Q?xvbN4rQYMOEuJ8DZaFgBtjpUrzLLMy2py0TURPy1orvFiq/hGPfW7pjUq/XO?=
 =?us-ascii?Q?iaixN1LPbAWP9eEp4UQyXHZjb8mrL17nGprL1fg3YfoI/QkPjvzVBXm0AMam?=
 =?us-ascii?Q?sPzZYBxPLrd9Z+JwGFB41h4fomlqFB55XBhPJbxedEdrw36FKyKQTHWGmlzN?=
 =?us-ascii?Q?O/sqU4PXQAOLhUNSYAegJqGnvOEDym0M1JEJVuCQLzcsDjUmK3cJi4INcEnU?=
 =?us-ascii?Q?nAxNdbJ7AxbsNTJQyT/CAVZj3OFGhnwplAEPZq6Xt3HBQLwBxb6EBKIYTDOT?=
 =?us-ascii?Q?L862E0/+8XvwqoG9CfSisovnGIy1FyMyJKAP5XSMSwDMTc90yf2T1OgA95hr?=
 =?us-ascii?Q?RoHDlR4/9OPfXmhYx46h6LTl3m+1PTZZG7kgWSTqYyuzZ/9Q4hjyJnInl1s6?=
 =?us-ascii?Q?MAYXs7AOD0OWgGOUICbsPeZmHGnuAUxTizy0zriwu5eXNomPywUTR01gjN5y?=
 =?us-ascii?Q?m8vVgflt3CBFIpoWZ8FFu3Bu?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b60e6f-7204-4d1d-f717-08d90a39f58d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5988.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2021 11:37:10.2345
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6+xV6dZzeUeeOhjLcvZ8CKFz0zVAha2PSh6Ta3ahuwL6bSuOVZaQr8G+K5MwV8yW03RNABpAAVT9vvCYmvPziIKbEhGBk7pZU8UUjeodNFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5539
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
 arch/x86/kvm/x86.c                            | 10 +++++-----
 .../selftests/kvm/lib/x86_64/processor.c      | 20 +++++++++++--------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index efc7a82ab140..df8a3e44e722 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4773,14 +4773,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
 			goto out;
+
 		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
 					      cpuid_arg->entries);
-		if (r)
-			goto out;
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

