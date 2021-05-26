Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC40E3921D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 23:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbhEZVQQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 17:16:16 -0400
Received: from mail-dm6nam11on2065.outbound.protection.outlook.com ([40.107.223.65]:15329
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230499AbhEZVQP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 17:16:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+o49EafQwZWV5LunVXkK2XbIVzKot9zrCHXQWjt1Qs5l5olN8zcVahNX7xOlaeFhGeCl4uP7B2qFXURwUxpm4BOfF9g5jx36TO1BayTymSV8Zof1aSkj8uttHz9ceatLAKIfeipdSS+FiKOJ/onWegMzFWjWJ8iMKXV5Bf3h5YLVxwZWjLODLgdwY22nYVnIN8pxpA40gPLdiZGYhlGWWqU7/APR+0bS+/KPquNhYZB2WSRluX54jP2aW3xkT6WQumebdjYJ2nBBlmbzTBTqF4sCvht11avztPcpVi69uhI8Wpgl20QKUByD9rpuZKlI1z9sER/QNI1bmSOvt2wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msOgvZQM/okuFKalNNRFwNEjfL1vxrLFe8zKt57w+qw=;
 b=EyuvJWBMp2JejFHnECdCGjXZAimqV54LYlj2Lgat4JnOns33OfQq3I8vcJGt+qDmwYlayJlbIzHusLxwKj0O78fc5H0dOdOngyKccNgr1F8WVX8suyVYS8MgxEXwvUVHsQcZn4iwWOg1nrTzy/NqxIwjgXw/ZjA8VdE5dvNY25JJMgC7dksVdeaVfDUsHXi//ck3eqbHHX10dI9ichZ74iu3ORPbYhZ+k4zrxi5NPUTeo3wOYoD1xa2ZGvoQAQTRPqxcDuuY0P8QIVhnKurZUVsQhyv90exCjWOJ1lolQhJa5KnJMY2lPPHKdSqi9ZcEGC56qUW/8nnR78DnW4yTpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msOgvZQM/okuFKalNNRFwNEjfL1vxrLFe8zKt57w+qw=;
 b=LygJlPssUCTdEMdxypQXiWns8ZwqTbpTY92n5t991jXcNdEatMcNntYvTt/BiIHfT5NQbjRpPYXMTc9U1yP+QFZ3LV8J3gkTmvjMaEwwhJAzeutIQR8SWM70J4lpPGr8fSv4Xa90US2hmBQkNYvNpxCK3EfvlE/8foKyQV8bXKQ=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR12MB1231.namprd12.prod.outlook.com (2603:10b6:300:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Wed, 26 May
 2021 21:14:40 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%7]) with mapi id 15.20.4173.021; Wed, 26 May 2021
 21:14:39 +0000
Subject: Re: x86/fpu/xsave: protection key test failures
To:     Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, peterz@infradead.org,
        shuah@kernel.org, jroedel@suse.de, ubizjak@gmail.com,
        viro@zeniv.linux.org.uk, jpa@git.mail.kapsi.fi,
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
 <a08f2575-af91-8b08-6286-be5ac80c67e5@kernel.org>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <718755e9-065e-c427-8821-228cdf8dd581@amd.com>
Date:   Wed, 26 May 2021 16:14:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <a08f2575-af91-8b08-6286-be5ac80c67e5@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:805:de::39) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.31.136] (165.204.77.1) by SN6PR05CA0026.namprd05.prod.outlook.com (2603:10b6:805:de::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Wed, 26 May 2021 21:14:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbb65ed7-1e49-4846-1a28-08d9208b45df
X-MS-TrafficTypeDiagnostic: MWHPR12MB1231:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1231E4C87F5390FCBA97A07995249@MWHPR12MB1231.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33Mn9uWH4/6Bl5Mmb3hxto1tM86V5GTMexGFk0LakdoQD23j9I5mhX10HNZcbMRJoRW4jJFHdhe60KwP/6KCFhqrK71C0W3hYZfcoOB3YOd1QTevvweQ5+jAuzv9Sz0d+FecRByKOGV02jXG+Sk0qW5/EIFhWbKpBkITwASyC1/ZSSZIjZm0ExZJDHEKoRar69NbsROogmYef0liZgoYwmFcy+qUCWiKlh1ero6XaAThdPPr+yi2l4HwpffrXfxTzZuhJWJ+LgffwWIoydVEvRAPsHQXILgk1koNSZlWkkaL9gI3FJC/bGqrA7AI4bU9RnMaBij63XYNLUup15Z7rAmmtx1oXZM4vu9LWHlXLsXWrdZNMCWJIdinceJleIkZBI9BnokteHr4X/KNMFmD4OQuYMkyyAvZt/npzJlkcYqsJy5qGps71JhjSRDck6EcuxmvflIM90ZrzCTk8FkuGUwKiD6AoBvKotf9NWaWMJ4x9nFknc8rBgpleyI3dsBHVRB+ZG+XH9JVVXqx+LGeuEru6+bQcr4mStecQNNL9cz+djnNKY8ljvC+X4MXr5LtCGf68pvQWYxanhY4pRZ6gcv6w1Mp7b+hAli+PtJEGyhzRU9/HRxAplcUoo2eL0yLAF5+92wrnVY0wivFKUQQvhDIJFZEaSKZr6ihR075IRowFE/wZCOFAWmP1AJG51BfD8r/Mmm9AHIV9zaSw3pDHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(26005)(44832011)(5660300002)(4326008)(2906002)(38350700002)(316002)(6486002)(38100700002)(53546011)(2616005)(16576012)(956004)(31686004)(66946007)(186003)(31696002)(7416002)(66476007)(83380400001)(86362001)(478600001)(16526019)(66556008)(8676002)(8936002)(36756003)(52116002)(7406005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?9A6p4nundEAuRsyQA3Flws5FkpIy5uAsEvKRRF6Jmn3wgnJNBCPGaETJ?=
 =?Windows-1252?Q?0W6CWy3xSAsA8JNM9GLLkXvRPksg6y9ZD/yPdDuu3jCRhTACfGTzvMoz?=
 =?Windows-1252?Q?8Vu0iFft1ZncJZQXiR/YBe2VyZpkiYhuATd9erhRMTCOaeznKorjoIUE?=
 =?Windows-1252?Q?jnYgEzCyOjdX2K+Lud1BWFNnZoiWeWU1Zs23W1j4WUHUE8zaojTTsPzV?=
 =?Windows-1252?Q?iZ3s57qRzGKvmYixZPhunjQQ8mTerga0FkDjBQFrhNPpuA1JzxRnw7JP?=
 =?Windows-1252?Q?KnNmH4AWpyz1W2nFYQy+Cp73QBzRrIloPdyY1EpXOarTDKh0u3/ezpUH?=
 =?Windows-1252?Q?NxTC3bdF2SLYLIJpiox+EW9loHdx3P0QWJLPiwLGYWdoc6ga4ECWcYS7?=
 =?Windows-1252?Q?Uuh4lGViQQeKx7E9bGPY5Y1zKVsxwhLbPLTM7K7vfwtH8tphVpQUVHD3?=
 =?Windows-1252?Q?+lpEXdgFzv8OKlXuRoI1PDPWMlYORs2d0lUBOVEe3xo1srFNIFP7LYXX?=
 =?Windows-1252?Q?eHWcsRhOakrbd5wa4cvDp7JqYB8+Vn6ashEmJpNkePnBwLi3gV84Wj/5?=
 =?Windows-1252?Q?hY7OJKmsrxuc13xOQM6f388UYMacUVsXVOgRJ67txDthGkyfpxxmTLzL?=
 =?Windows-1252?Q?X968o+RGJQlWx6R9uRwYfDds7GekVdQS6P6E8ed3JoM7mwI1dA+B72MC?=
 =?Windows-1252?Q?Ey8/zrgSYn/ZcpY+Optp+NeYMhCXlNe9H3XfR0gp1AzWjfMGKGXNMPcC?=
 =?Windows-1252?Q?MqkdGCqXLz8+VEfaiCUldG0ZxvmWBi819Qb/AguX31Vrou+wEzA3o270?=
 =?Windows-1252?Q?kP7tmQx4QdKmHDwGaAcOmF3LKUIqVLKBx7WsqyZ79X4kffn1rM0Cid3q?=
 =?Windows-1252?Q?/lTancXnHVgimbKtXJOv2htwXfE5U5k6bCOsf2qJC9JQmntR/djYK8fw?=
 =?Windows-1252?Q?4EdFlPtfb8DlZhvZy9NmpLuPIOIwZobxghYBz6bDoqlok+yHVGFyEyCT?=
 =?Windows-1252?Q?RaETcjZnDpslZm4bXjExqOp2t2JfJc9sKLl1rOJRA1fSA1+s0p2uqdLY?=
 =?Windows-1252?Q?GtLKLoYZMsmDGQt9EZe+VnSok7wJ9DKAmqJD/SVopbTKBSNjHzUntqzR?=
 =?Windows-1252?Q?UhNfhgE1EmmzLAlKExvp9jvQzgu4o065tRLOd1x17s7hElbdCmNE3iUQ?=
 =?Windows-1252?Q?VRwQdM7QBJZIpzNBtFc4WiUslfrF4kvL1+vklNZs4X5sp/jTzbfzpp/h?=
 =?Windows-1252?Q?GOGBf30hJRW2Jgm3wBIDMZmwDWVQinIbPgjdxLMT1oUPDMw6vaLrQ+UM?=
 =?Windows-1252?Q?sMaBYKvVcnhCH5aVO0AoyRBeF5v2O/qtSjX3wGNq136thcQnetjxikZp?=
 =?Windows-1252?Q?pQRv98VkZHw3eaxS0xq7efgz2pZ+HlllFcPEjYq8VZq6avBPZLLqh1vG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb65ed7-1e49-4846-1a28-08d9208b45df
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 21:14:39.7613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLe4dcXQwn6xxFwll0iLf79d5eAsU7A7TboDq19pDXEMdp/tyK4M/HSHTeWgd9uF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1231
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 5/25/21 7:36 PM, Andy Lutomirski wrote:
> On 5/25/21 2:37 PM, Babu Moger wrote:
> 
>> Investigation so far.
>> 1. The test fails on AMD(Milan) systems. Test appears to pass on Intel
>> systems. Tested on old Intel system available here.
> 
> Ten cents says that you have discovered that AMD returns a synthesized
> value for XINUSE[PKRU] and that write_pkru() is buggy.
> 
> Any volunteers to fix the if (!pk) case in write_pkru() and see if the
> problem goes away?  (Or at least to print something for the if (!pk)
> case and seee if it gets printed?)

I inserted this patch to test this path.


diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2d9800..a0bca917f864 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -151,6 +160,8 @@ static inline void write_pkru(u32 pkru)
        fpregs_lock();
        if (pk)
                pk->pkru = pkru;
+       else
+               printk_once("%s read_pkru 0x%x\n",__FUNCTION__, read_pkru());
        __write_pkru(pkru);
        fpregs_unlock();
 }


Yes. The pk value is sometimes NULL and the value in the pkru register is
0 at that time. Here is the dmesg output.

[    1.700889] write_pkru read_pkru 0x0
