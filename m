Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9020B390B93
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 May 2021 23:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhEYVio (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 25 May 2021 17:38:44 -0400
Received: from mail-bn8nam11on2043.outbound.protection.outlook.com ([40.107.236.43]:43232
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231210AbhEYVio (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 25 May 2021 17:38:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4xZSTO/IqP0dYXf6D7wVS/G88v8YG6FJk8Gp07zxYfcrgX4P/2t/EZONvfoDFMaFMqSuOTGKRnsPwHyjnBNeda4sjH4koDNbiGDjpTQzSS7NplWBiN3OJ/ZifWeTnLTbqBxsPWlmqKicYu69dOJU3Ym4u2HD5oVX269qHFQ0evrNWQ6RmVmgPfqJhVNiET1mpZav8LRXY8EKdZ+69EnCSNYJ1F/L8ZAjefyI7FPN1CGcpjE9nmZc6zDfBN4DkYUVMAKpqw4HHqDglXsIqYg/nh4I2EVq7Uy+oJ3qJkS/ql9qhfhQioMIMkdLQjufftklQmf4PKfLXB7nfhzjJwnFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6AlTODtzg5DhtddqmYceIgHopsfMOMLxohL2IYrgPI=;
 b=FIQMXNP+gI3AFA3BN9vFe8t32Q4iZVPqQj/yExo6qlb8I6P4T4cbPLWALOmNDm4HBYEJFk35xMbjtZTBqnPMT8dAZ2pxBP+IbT1Ru9KlQq74kayWhJNC0u0eozCGM7tnY2PG7apZyWmT2oJMINr/S45oPtxYmca/6woTefup6aFBtPth+521VHyu69JnZVuPcgNxrbs3Th4GFKMnn5TToEj8ppzNSuplkq2qCjGhmdpI2rmnlYwmwO75lPpr/SpIatoGwKJnyrkMDX2rMcCZ904Sj5xXYXu/3LRMq8YKfFaD9+ymV1ncWG4O0RcoE4S5e80yfzUdvhvdSBKpQ5cWAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6AlTODtzg5DhtddqmYceIgHopsfMOMLxohL2IYrgPI=;
 b=Lemv4b7j5cZLVS073HKUI7yYdATqRcBNg/PQhFLnohZmrh1ZGSggTsEiF4wTpJOhJr/t3Hq02dwbtmDpBxEvQGquHmF0+dyDHKq8Y6bPAv6fSVyGvgiFXvLg9r0+/IiimlX4yUbF5qhog3KeJo68Yn/xwBoikx8EMmzhtQzbDP8=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1759.namprd12.prod.outlook.com (2603:10b6:300:113::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.25; Tue, 25 May
 2021 21:37:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%8]) with mapi id 15.20.4150.027; Tue, 25 May 2021
 21:37:08 +0000
From:   Babu Moger <babu.moger@amd.com>
Subject: x86/fpu/xsave: protection key test failures
To:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, shuah@kernel.org, jroedel@suse.de,
        ubizjak@gmail.com, viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
        fenghua.yu@intel.com, kan.liang@linux.intel.com,
        akpm@linux-foundation.org, rppt@kernel.org, Fan_Yang@sjtu.edu.cn,
        anshuman.khandual@arm.com, b.thiel@posteo.de, jgross@suse.com,
        keescook@chromium.org, seanjc@google.com, mh@glandium.org,
        sashal@kernel.org, krisman@collabora.com, chang.seok.bae@intel.com,
        0x7f454c46@gmail.com, jhubbard@nvidia.com, sandipan@linux.ibm.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        suxingxing@loongson.cn, harish@linux.ibm.com,
        rong.a.chen@intel.com, linuxram@us.ibm.com, bauerman@linux.ibm.com,
        dave.kleikamp@oracle.com
Message-ID: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
Date:   Tue, 25 May 2021 16:37:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN2PR01CA0052.prod.exchangelabs.com (2603:10b6:800::20) To
 MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN2PR01CA0052.prod.exchangelabs.com (2603:10b6:800::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Tue, 25 May 2021 21:37:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc3efd4c-3a2e-4e7f-e125-08d91fc53f69
X-MS-TrafficTypeDiagnostic: MWHPR12MB1759:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1759C3609C9D7E878CA3A3EF95259@MWHPR12MB1759.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hUggTIYbpi+t4eOAihfwqkrFrwcr3/MOypBjbruC8Ps6Rc99brDI7xd2Cj1j3+p3oIVYCB7wCJ1zM5cnLkIBLJXp92w3UGQE0uUS87fmnvCjlMEeeVuDDDtPVEudrU7oug4+Wo+C1rN4xQypQfTwuaEZqWzy6gpMHsFsm0qzlpp0l4cjWlUcWmvgGY6A52jO7j1YUz/7lSwC+j6pLKersWIC4DGkOOOw6BEVp9sBpwPLEkZhB8GoHXN/n8cEUD8f1vCrgj1GaR6PFK2ftgWGmPmxos0EueB8+BSr62G1FCUSLdwhCQpjJ/83wVdONuSIgD75QzXFP7q2cXUnbxV50JaND/c8LJW6DA7MgYb9YzgmSfk7ay1FQeJY2ivrr//hLFTq8q8IXmZdJMM8w+hSd/uJ/lLlpV2P05resvqTy/Hpr8kPNqqP2DKxWD7Ev15bk9tYf/KiWQ45bhaRu/1X8x+ryZLbZgQkszgvucq8zdpZXJIdMLg1OnidhIynb8svZKdjAQwYS23NEcAi7jYwQTQ53cr7d5vnxJdp2INJmoj6euJ8xXbTbKAo4XqrX6/on/3pz4sewbMU7KVM2Us4wi4nBn8uCeaDRRxq+V6TRS+q3JkzsV/ZtTEv+HoM2qRS2VAKcZTtn4Ivww/3ZeUuD7rIGurl++oJBymGgR+xpA2wRXyRftXlCmjVqwJk9Wet
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(956004)(7416002)(7406005)(2616005)(44832011)(36756003)(8936002)(5660300002)(52116002)(38350700002)(6486002)(38100700002)(2906002)(186003)(4326008)(8676002)(83380400001)(316002)(16526019)(31696002)(66946007)(31686004)(66476007)(66556008)(478600001)(26005)(86362001)(16576012)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?qw66DeUMmSe50BeQDqR9aGSEvyNulu5UYUqFtuCXMAj7OkRM0CBUe19N?=
 =?Windows-1252?Q?uWSOleNWmGJB8aS8VewoaW6N+Iq43tSBONf2HRI74CoXqLhQWpn1cLEq?=
 =?Windows-1252?Q?fSyavpq3EmexlfuegX487seNA2fIRZ5R/+5qgI5qVxOKp42Xd9Dbc3Ts?=
 =?Windows-1252?Q?UpVabQA44OemPDJnTkZRG7m00T3qTzILC2NW2cCeNithk8oOGtIsM6Zi?=
 =?Windows-1252?Q?YSxwZwmkRrgNlsI5lVPvqu7rM6EzXle0D05YxpFtXXvVeCIKJrdFRl9s?=
 =?Windows-1252?Q?njDxrr3g8XMsQ4g4hl7jsLyXbHsqUuwbVwMIjYtqPtbjgSf5rZIgjEOr?=
 =?Windows-1252?Q?Aiz2iRHsUKMmGLQBMVxTCql0N0wrk3+VPaQeCkJjeCGvf1ZtgULPEYaq?=
 =?Windows-1252?Q?40rKhg1XYXWZ5rUs+2QXgQog1lNI69kFKAalQs2voyPV52C1klpMI4ch?=
 =?Windows-1252?Q?hR7NH2VOfBJl6XavTBFojPUgrLqXXQ0Ub+QYipb4aMl7jz/saLCeCtwr?=
 =?Windows-1252?Q?FTCasttwAW9sUoi6Ju1eCNoN9bJGUtLmZymEfR2NtD+oK3lXkhDrJ46V?=
 =?Windows-1252?Q?sB3pRA3EYJ+w7bmnIZUjoI5KxDGgaj5ZXW/vrr7kyGnsWJot5XxLIRaK?=
 =?Windows-1252?Q?Oa6miyMxUdAqHFiNpt2jnJDyOY+vQ9U6U19+EmJP3cCgzPh65EZcjh48?=
 =?Windows-1252?Q?TlQiDTY440Dv0OCPNU5uiYNgNRYbaImSl3nVzRRA8ZzJviM8Bs1Os+ZS?=
 =?Windows-1252?Q?VBM+YGBfGtFfKrgVrvR7WzTjvYPI3E+XnmiRDKP1btVNaQDtoXlbINC9?=
 =?Windows-1252?Q?DJnSp1Qy3WqL0o9Ir6hGpPclFGCdeu2e0provOgcX5iMZL4M/vb+gMv/?=
 =?Windows-1252?Q?wiNQt5PxLQahWyQVe8wdjlY5aCMKZnkCanRejp8PXQywVtFMsCaVcpJ2?=
 =?Windows-1252?Q?83sodPOuP9Lic71tHReQWt2L67TZHb5B6mVNRjGNa+6isUfa/8EWrIU8?=
 =?Windows-1252?Q?0QovJqdfAfvCny85AvPiYwmTwiwLh4UBpwtyVDwjYePHf3ijy7HlzKiy?=
 =?Windows-1252?Q?xCFy9tTayJzYwmfAGhANEMg0mKVr4PZQTozug5REITZjcW1hTx2Hnm8C?=
 =?Windows-1252?Q?LYFZCsc8YDhlC4kHTm/foBT69OY78QyndgUCik02QfQ66eEg5+GHL/o4?=
 =?Windows-1252?Q?bnbcAIHC/vq+g/64+3uRWztmU80oZa3ilCGk4tDu2NkKxBCXoHL8709R?=
 =?Windows-1252?Q?WS0ggjXA5w6hvpWtlTkcDTDsVki8nyQVe/qF0WYZTQwQ/o20QA/58V+G?=
 =?Windows-1252?Q?uR93QKciKbV6QHveWpHionP5bFcklszZ+2r0CvcmTmn7x/ATBUCtsJIY?=
 =?Windows-1252?Q?v/Kht+n+20Qnfde/N98leQX5Q02Zy5jWYJny30Pcg7GMIv/HmemXxsFJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3efd4c-3a2e-4e7f-e125-08d91fc53f69
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2021 21:37:08.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0DLqeRyfNBSW46lXX1RaV62a4ooImpfHUYZeF1s1Y5r9Q+LjIRjDHAmmGayd0wc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1759
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi All,
We have been noticing protection key test failures on our systems here.
Shggy(Dave Kleikamp) from oracle reported to this problem couple of weeks
ago. Here the is the failure.

# ./protection_keys_64
has pkeys: 1
startup pkey_reg: 0000000055555550
test  0 PASSED (iteration 1)
test  1 PASSED (iteration 1)
test  2 PASSED (iteration 1)
test  3 PASSED (iteration 1)
test  4 PASSED (iteration 1)
test  5 PASSED (iteration 1)
test  6 PASSED (iteration 1)
test  7 PASSED (iteration 1)
test  8 PASSED (iteration 1)
test  9 PASSED (iteration 1)
test 10 PASSED (iteration 1)
test 11 PASSED (iteration 1)
test 12 PASSED (iteration 1)
test 13 PASSED (iteration 1)
protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
`pkey_reg == shadow_pkey_reg' failed.
Aborted (core dumped)

The test that is failing is "test_ptrace_of_child".

Sometimes it fails even earlier also. Sometimes(very rarely) it
passes when I insert few printfs. Most probably it fails with
test_ptrace_of_child.


In the test "test_ptrace_of_child", the parent thread attaches to the
child and modifies the data structure associated with protection key.
Verifies the access results based on the key permissions. While running
the test, the tool finds the key permission changes out of nowhere. The
test fails with assert  "assert(pkey_reg == shadow_pkey_reg);"


Investigation so far.
1. The test fails on AMD(Milan) systems. Test appears to pass on Intel
systems. Tested on old Intel system available here.

2. I was trying to see if the hardware(or firmware) is corrupting the pkru
register value.  At this point, it does not appear that way. I was able to
trace all the MSR writes to the application or kernel. At this point, it
does not appear to me as an hardware issue. I see that kernel appears to
do save/restore properly during the context switch. This value stays
default(value 0x55555554) in most cases unless the application changes the
default permissions. Only application that changes here is
"protection_keys".

3. I played with the test tool little bit. The behavior changes
drastically when I make minor changes.
For example, in the following code.

   void setup_handlers(void)
{
       signal(SIGCHLD, &sig_chld);
       setup_sigsegv_handler();
}

Just commenting the first line "signal(SIGCHLD, &sig_chld);" changes the
behavior drastically. I see some tests PASS after this change. The first
line appear to not do anything except some printing.

I still have not figured out completely what is going on with
setup_sigsegv_handler();. It seems very odd modifying some structures in
the signal handler. I am not sure about some of the offsets it is trying
to modify. I feel it may be messing up something there. I am not sure
though. Will have to investigate.

4. I took the traces(x86_fpu) while running test. It appears to show some
of the feature headers are not copied during the test. But I could not
figure out why it was happening. It appears to show not all the feature
headers are copied when the new child is created. When I printed the
feature bits, they all appear to be intact. Here is the trace.

 protection_keys-17350 [035] 59275.833511: x86_fpu_regs_activated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834197: x86_fpu_copy_src:     x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834197: x86_fpu_copy_dst:     x86/fpu:
0xffff93d722877800 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17351 [040] 59275.834274: x86_fpu_regs_activated:
x86/fpu: 0xffff93d722877800 load: 1 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834283: x86_fpu_regs_deactivated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17351 [040] 59275.834289: x86_fpu_regs_deactivated:
x86/fpu: 0xffff93d722877800 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834296: x86_fpu_regs_activated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834298: x86_fpu_regs_activated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834406: x86_fpu_before_save:  x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 2 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834406: x86_fpu_after_save:   x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834408: x86_fpu_before_save:  x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834408: x86_fpu_after_save:   x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834654: x86_fpu_regs_deactivated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834654: x86_fpu_dropped:      x86/fpu:
0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
                    auditd-1834  [036] 59275.834655:
x86_fpu_regs_activated: x86/fpu: 0xffff93d713fef800 load: 1 xfeatures: 202
xcomp_bv: 8000000000000207
 protection_keys-17350 [035] 59275.834665: x86_fpu_regs_deactivated:
x86/fpu: 0xffff93d7595e2dc0 load: 0 xfeatures: 202 xcomp_bv: 8000000000000207
           <...>-17285 [041] 59275.834679: x86_fpu_regs_activated:
x86/fpu: 0xffff93d716d0df40 load: 1 xfeatures: 202 xcomp_bv: 8000000000000207
   5. I instrumented parent child interactions using a separate standalone
application(without the signal handler), it appears to work just fine.  I
see PRKU register staying intact swiching from parent to child.


My suspicion at this point is towards the selftest tool protection_keys.c.
I will keep looking. Any feedback would be much appreciated to debug further.

Shaggy, Feel free to add if I missed something.

Thanks
Babu
