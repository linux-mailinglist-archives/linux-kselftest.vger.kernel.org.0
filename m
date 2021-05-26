Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAF91391BF6
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 17:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235462AbhEZP1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 11:27:43 -0400
Received: from mail-dm6nam08on2053.outbound.protection.outlook.com ([40.107.102.53]:4928
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235417AbhEZP13 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 11:27:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E2pwo3Us3lLlYaRuUMYtnKnwl3aLDq9ikdk/2eFK1KyetIrvOFRgMvhdRXFGP1+NUSVoCVl3wbjfLf1l15409cWg5sY4OXBaw1W996ngEE5DrARGGky4MyxOPXtQoYKwFiCXE/U5s2gZcXpUnSyCNJUGaFDW+gIsYBrh/K0K/PWmnHPBs6JD4fdqOY7fhvCieLsQQtxToDVSfcC6nnSox7ViQRHwYPNROCZ/DGWZUNiGdZbo06l32cgGytf8nHrqYGtZhXrXAucu0sWUYCa/wStHNiwfUZ24Gwkc7CYMI0WBUqWur49CrSCACAegKAbBMAZ8kBV3kFInirph/fNTeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRI3+QhsYtyMFc09mYfKA7QtkJcG+OVjx64iTtv9hi0=;
 b=f5cQa3MGunKknQGtEY1t2BCga0qr/9vF57IBIZNHBKG4eAvk8dZQyrUF216w6dvL9xRwhWzaqXirnAW+ZNtNFX0oLAplrvWotU5Ex/vhHI4nRQa+fXatOqoBaY938dLWesgmUTqIvkc+zAaE8I4xuvW3SoZBDLGmyhLeFxjrlZhb3OR/Vg9X10Cepk1RvXh8uIAeA2I8oxnaBrlA3BAGa2gTDWQHlpV84QlYaAEEipDDlTBks/tnxVooyBlahYbTcnSjuHtVezzpJTQqoTPx68YvbuSwFztMTXbsOkvhPH/2oSr504MoEIFD6TESwtGwN7KpItkvq0nNzn22FC8LJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GRI3+QhsYtyMFc09mYfKA7QtkJcG+OVjx64iTtv9hi0=;
 b=sDiIP+3TLBwDOg2xRP3FF6JYiPPy6OpW1SwbnnpHAK2ZS1+CZSe7jXyJrS1JwIdULmMAqjpzV0fbRvNlUeEJefGgSrmAjTfcJrijYcFes3VxUKYiL2RoLXUS8YS7WbHYMznnypPW2KrPfy/SOEKTXAXbQOBVBXb1qxb2vVxvVQg=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1549.namprd12.prod.outlook.com (2603:10b6:301:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Wed, 26 May
 2021 15:25:55 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%7]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 15:25:55 +0000
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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
References: <b2e0324a-9125-bb34-9e76-81817df27c48@amd.com>
 <7a407363-e074-aa84-3ca1-909b497122aa@intel.com>
 <a4f6b80d-8546-09dc-7435-25b3d890aace@amd.com>
 <e0dbd490-0209-9f74-36b7-c55992060b44@intel.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <ab564da6-1029-1dab-d54e-a266a623974f@amd.com>
Date:   Wed, 26 May 2021 10:25:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e0dbd490-0209-9f74-36b7-c55992060b44@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0501CA0061.namprd05.prod.outlook.com
 (2603:10b6:803:41::38) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN4PR0501CA0061.namprd05.prod.outlook.com (2603:10b6:803:41::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 15:25:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ef8e688-080e-4913-28e2-08d9205a8d9e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1549:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1549DDCCA4F27382A57B735495249@MWHPR12MB1549.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tQ3HGYRK7SBmusw1ExnO9DznYvT3NeH1jvPeMPPjUIpUnT0C4Qy64OqFnzc0+VFxAXXVF6AZB0OuB5nbnH4gh+LqXVIhfoGXagzHxIHXURhh+p8UwibKLYYGCwWZYxSUjT+yYUwUOYbA9EQbFEWHjoA3IeAmjWjkzujAr292xNJv9daaSht2n5FCTKEQOey/c+dRjmzu/hEzHeoz5uZ4YZHiXosk2pdhFXBOTU4+27dVnQlGPJXCJepzYDNWzaOdv1HPSOhtNgPVxTGPaPLzsc/rUj3hoOSni2EQwXXaNZDdwhimf3MUUwOGnAXrMFBYRUfGZ8mPvPn43OHY7USgx+G05B7p7vnFC5NLvRye54P5uOA0LWIa1EOsut65t5w2TMOnU1nQlHSq7jsW/apOQHSy1JUmZNSkThM0xrqPtz6K3Fn6nMmwF+XiBPUNS7eceTQiK1+jbajVBj2F5tct4q4LJtxdekE2VPR76eYU9wTr4MuxkDDeLofavclbtv8KXxOzqlTccTtBOC4SvnyxK2ep5Ky7yUbj+KVV5RCQW3iPTkME6D/TsNvPJK90edOn9veNlrqobEbGWyeSwF1Z0mJBFvI3KYMXsL0HqnSyei3Hf9QLMBG5vPcr444hHGPy3E1PeDyMULoE8mqGJf/2C9EM52vhERGhrK8NNVllVsSNH4O2+9OO4l1XxCtRoFpYfIF7hd61mkJ992M8/1tAmATxGb4x5wHzvUINzizAkcP7Hy9oMwfYeGdIduymEJX1w63Wdle5MxSFgc3TTUgBYux1QiJqIDyRUxbzFDh19BzhjWbAUZxbFuFpr1nooG+JtFFSFHNuvo8+YFrX8BXUFtzUhwu/ZcEulA+lq+np19M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(966005)(38100700002)(5660300002)(478600001)(2906002)(38350700002)(186003)(7416002)(7406005)(36756003)(4744005)(16526019)(52116002)(26005)(44832011)(66556008)(2616005)(66946007)(66476007)(53546011)(16576012)(316002)(956004)(6486002)(86362001)(8936002)(8676002)(31686004)(31696002)(4326008)(10126625002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?GYkqnJ9ipCKGqlBLS4JOJnsykbWCmm1DUgwflTCziyNLtnuEIWxpwcja?=
 =?Windows-1252?Q?Ewneezm2HV4WA2jvV9HmelcmV/Jvs0aeOi/xQDhDkCW09KztHwQ6wa/o?=
 =?Windows-1252?Q?OeCj27mpgL2yqaN1lFoT9zPGh9qoMaMr3hsTD8LmKJUyGTXNlf9lyzeT?=
 =?Windows-1252?Q?Qaf3pdKwuqcfiA7vwGtuWGNEyiqF5pQ5P+1YlckgXemcYgTT0wWSNxG/?=
 =?Windows-1252?Q?JqQ2Y2BF4ffYGn2v978X3Fvn6yGRBX93OYKyRWVefcME9qb3EiMGHbr4?=
 =?Windows-1252?Q?IAzIbCXIZvjGAhBw5/BVeS3S9JHV7GGyQ04MvWkXDlNCsz7w0XUtXGQY?=
 =?Windows-1252?Q?4mYGobzg4MByTjCJae6omqd0UcWFm3h/l++3EapzSfSL8t5LL/pnO00K?=
 =?Windows-1252?Q?tHQRGS7t0TGIVF3jQ7ZADD29HkIuqvmJjQ7rm3nYDTI028ozl2Q7/FkM?=
 =?Windows-1252?Q?mbrt7OSKaPDfI5/Q1BX4D7ao6fgUTG+M83eaztXw4EMJwke/jd4QZeU9?=
 =?Windows-1252?Q?mZD13+BP93HqGfpw2w28fJX/Mk5QOtyFEDD8H0C/niTktE6zTgFzPmVP?=
 =?Windows-1252?Q?JsJYBU+AtkMdb50fpXCHyxAUydJ+q+vxNDx/PQwdB/Sm/MpA+cW+6cgZ?=
 =?Windows-1252?Q?aOl/fqkMFlQGJrea+aTSeKQ7ewb94yFeTbFQ/lQ2QiFP9g6G3PJmSlWn?=
 =?Windows-1252?Q?Yw2zbvfbaYI0sOBrN38elpvEc4fqV20RXastvyuQPtxx3AE5dndIAR0t?=
 =?Windows-1252?Q?wsUm5YlWDhFjFO+HzTWJP6ItDYHNWW1jF7Q01q6GCDKKcimhF5G1HlNd?=
 =?Windows-1252?Q?S+mzr58TV1GoO4kP1Np24OwhkeuCXrj02bq0l1USkOHuOU+GPCXBz9vm?=
 =?Windows-1252?Q?AP0L6qN72aPBsBjyYNX9yGbk372B+1PSlqUsgf34VSdHiDoGhRVM7R9Y?=
 =?Windows-1252?Q?F6UJTMDXeigshxzJh8uLg2QpUSr8wAu6/LeiAWxlh1ZXbJ0dNWJ/SKkS?=
 =?Windows-1252?Q?33YJsTHE+l2SuncUOPLlg0FxtuZQMeNRNTiuKJY2Z+uWIowm2xfuw9AA?=
 =?Windows-1252?Q?h/YW6di3+bGfCCTlG1Mf8v+TG4vzdZvIk81xO1m3GBXPZWOZfVbknFRl?=
 =?Windows-1252?Q?7Kio5y5FgJUktthx20DwVOh8vX3VYVSO/hN+ZFyWRMQUnnjlGAA4z8qK?=
 =?Windows-1252?Q?w/XDbiRcBxdb8srCngPgWUd/cjdnIwf+tqzHf8SKprBeZ1etSv3BbDOX?=
 =?Windows-1252?Q?xH08VxTtVKQ94EJuUa4GmNf7lvXZGE54qkZnLp3kHLua8+ubcWhj2B7e?=
 =?Windows-1252?Q?lgJiYNFT0nSwaNBhMl2HZVxDICMtl92ZYXtMrHjqWv0mChjKSPtGJAu+?=
 =?Windows-1252?Q?LDSlrTnclTzSHlDTBJq8XBGrtIDPYqvHsXzoujF82M01SFn+g3QD1pw4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ef8e688-080e-4913-28e2-08d9205a8d9e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 15:25:54.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpByRGWvfeubza0VCogBZgKezyI5lyHnlB+b2kw/Ag3C1QVkdw2yzQGAuCKcstum
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1549
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/25/21 7:20 PM, Dave Hansen wrote:
> On 5/25/21 5:03 PM, Babu Moger wrote:
>>> What values do PKRU and the shadow have when the test fails?  Is PKRU 0?
>> It goes back to default value 0x55555554. The test is expecting it to be
>> 0. Printed them below.
>>
>> test_ptrace_of_child()::1346, pkey_reg: 0x0000000055555554 shadow:
>> 0000000000000000
>> protection_keys_64: pkey-helpers.h:127: _read_pkey_reg: Assertion
>> `pkey_reg == shadow_pkey_reg' failed.
> 
> That's backwards (shadow vs pkru) from what I was expecting.
> 
> Can you turn on all the debuging?
> 
> Just compile with -DDEBUG_LEVEL=5
> 


Copied the logs at https://pastebin.com/gtQiHg8Q
