Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557B8720D06
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 03:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbjFCBjn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 21:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235954AbjFCBjm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 21:39:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617AB1B8;
        Fri,  2 Jun 2023 18:39:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OX+bkB07WgFmQtTat02vB8uBZc0Asd4RAOE+zW+0HnP/79nuC/ZjOx+DJs/OQiNZqOWUv8oRHqmRwwRJwHzk0qFkecT2wHOHK7cfWd2Rd3XfGPpcKjHByrzc1jeOf45EQIHLcZoT9BVMMK5Ekp5wlMNuN5fSbX9jFuQhiV0CGWHqB9An5DyspFWU9KmnEE7XTz6d+zzIqqCsLFKtxHtrslzcXqponR2i+d+62NVe/IiJluPbgsvkfY7tWcRiSW/1h0EJID9/O6LdNegyT6vH3ROeaUm6wsZPpbopCKta8i0p1EWzd5nb9iU6NviZWOMZcNx2YAynk8kEDpVvq55iQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+nqC9XDiQDEarDIcKffspZkwLy0g1o77GGl7JRfmW0=;
 b=HMfewJicAnswVfCcavCbns3A2jq6EkIKig5sz/cRLDYMiEReWCLt7Uw5dwVfmyX9LK5TdOcauc/R5xVAxXzuny49cZpk52/AjDqv7uzLDSN/ZszgaJOj76Lcaohr1ys+ZfRCc7PkBNnCkVMs24clnZNawGOqKnRJNs8iVhrm60aJgWLOOaaIPdFOs9yKX/sPJtYAictxl/dplbeMYvXYO2H6nEJtiDFCZ2gTebOj+Foc3TqpszFG8ElsoqXji+CiCCgyIraABV2MpyFz5DtMx25wY9D3RxOINlkVxCZPO8R82f51fC9V/StwXdLUkiq7ilr4BcMqvvrI8tJnJb3h/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+nqC9XDiQDEarDIcKffspZkwLy0g1o77GGl7JRfmW0=;
 b=DFU3ImZyFF9wLdgkAJ9b/NfrJdj+iLkcR9LD0UrINtdmzURtRWIJC3/QIaxmOjXAZW6N2u/7UfqIQT7KEc51mp6vyjNe/eUEevOyRPn1o+qepr44fY/H7qvz2jxVy8YVcanQz5Ea7FF/SFDRE9duExXxQB2c7rm1DWz64uvwgsr4rT87qWxqF1+1Q8jX1AnVjtlmGPQ1JhQhVUQxuF61D1aZBSQO0RjcVe4Q+gh+EY2wE38O28K5BYI37KijHjCwiUcHHRA7zIS7KyIG31kmY8bQINwMbMlMF7+ARxlDDGa+NvVNxbMtdNwrCQmESeTMoL34LGBBqANm973FZQFYkw==
Received: from CY8PR12CA0069.namprd12.prod.outlook.com (2603:10b6:930:4c::14)
 by SN7PR12MB6863.namprd12.prod.outlook.com (2603:10b6:806:264::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Sat, 3 Jun
 2023 01:39:39 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::57) by CY8PR12CA0069.outlook.office365.com
 (2603:10b6:930:4c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28 via Frontend
 Transport; Sat, 3 Jun 2023 01:39:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Sat, 3 Jun 2023 01:39:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 18:39:25 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 18:39:24 -0700
Message-ID: <b67dec68-6648-f73a-cda7-31e3c5fcd65b@nvidia.com>
Date:   Fri, 2 Jun 2023 18:39:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c to
 uffd-common.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-11-jhubbard@nvidia.com> <ZHoR+3v+zUENBhi4@x1n>
 <68549f29-fe41-04d4-f648-245f399c350b@nvidia.com> <ZHpvZcdik7VPsEcL@x1n>
 <990f222f-643c-3b8e-6e5f-84dc98c3f2e8@nvidia.com>
 <fed573c9-2045-e13b-15b5-91df2446ef42@nvidia.com> <ZHqU6j4PAzy7ene0@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHqU6j4PAzy7ene0@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SN7PR12MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: e03ff44b-4497-423f-e77f-08db63d3653d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wRJmAUngIIvzKU50Dbv8l3VvzP9o3UrXzqvV0QS3a0jtOnau6AG2mEKUhrFyLM6XdpnbsUoGnEb0lXMrpKOurm/9z+oXJOa5VqeEqvW+2EW7/krf3vwzh1A/uXTUmCEY8eigGHOMwavu5PGK8wXRe89zCqIcpS8c3MrSLpWBqB0yjIj+DF3dhhgFmfezjeLz2tlOsYn239LucezI/BP6H435B/yqN/LlQXkL0sFGYhZLpNYJ/2RwQAGibNnxTUvEYiplnwLGlvbjLcEnE4ghXer57LFbZ4GlVjyluANtYoIjPeqxWe3MpI7uGIWz0OHWTowU+T3aKThxNfRf3nnaht+uq+2SD+0IYHOQxm/tDwdImbNnLtrUKCU47k1IL/O9CFxXi5/JT3IlEifOm+Rebwo8QCbRkDfmXHmtWrw6MzzMhspW2riagdFg57HJ1JgJnt0v7Xat+QIgbAzuFkPVACsJmk9taLSJE+qPOMWLg/UiDAejCgiAuB6bAGUGEyg1FVo4b0R/Mjx9U4/V8nty0yBMdGhcU7L8RGgjrv+53lCwlTSAvsDem/4BjfAKf5r0mal+pdSE7IyD4XSzBntrJBoK/LSIs8L20KmUkXVNuy9fQFKfZP+KmNtmvbLCZDGPCGu+aghKIWCFa2pjumXkvxB++pG3dZ5yPLWJbQx28HuCnCVvvHySJ9H+5YIYp8iLcH+E/pbvy4drDU6Z8MgfEe2v0dT4wRI/86P7kmQwie/cFLv5rJYxInl8n+nkiH0CE14S+AZpdpuvAAnJVwOvZQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(346002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(41300700001)(426003)(47076005)(82310400005)(36860700001)(336012)(83380400001)(16526019)(186003)(53546011)(2906002)(26005)(31696002)(7636003)(356005)(82740400003)(40480700001)(86362001)(2616005)(8936002)(36756003)(5660300002)(70206006)(70586007)(4326008)(316002)(6916009)(478600001)(54906003)(16576012)(8676002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 01:39:38.9455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03ff44b-4497-423f-e77f-08db63d3653d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6863
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/2/23 18:18, Peter Xu wrote:
...
>> ...whoops, correction, our very own David Hildenbrand recently made
>> changes that contradict the claim that "ksm and uffd selftests are
>> independent". In fact, ksm now *intentionally* depends upon uffd, as of
>> commit 93fb70aa5904c ("selftests/vm: add KSM unmerge tests"), aha!
>>
>> That added commit added a call to test_unmerge_uffd_wp(), to
>> ksm_functional_tests.c .
>>
>> So this needs to stay approximately as-is, it seems.
> 
> So I think it depends on what is "as-is" to me in the above sentence. :)
> 
> test_unmerge_uffd_wp() impled its own uffd ioctls, and it still doesn't use
> any of uffd-common.h of now (e.g. uffd_test_ops).
> 
> IMHO if we want we can let test_unmerge_uffd_wp() reuse either
> uffd_get_features(), uffd_open(), uffd_register() etc., but still all of
> them are provided by vm_util.h not uffd-common.h for now, and that's
> intended (vm_util.h can contain uffd helpers, or whatever helpers as long
> as generic mm/ unit tests need).

ksm_functional_tests.c calls uffd_register(). That's about as clear
as it gets: this file distinctly depends upon uffd test functionality.

The goal here is to put uffd*() routines into uffd-common.[ch], and
everything else into vm_utils.[ch]. Because that's what you do, when you
have such named files.

Putting uffd*() routines somewhere other than uffd-common.* requires
some...reason. And all I've heard so far is, "it was already
scrambled--as intended, don't mess with it!" :)

> 
> We can even move wp_range() from uffd-common.[ch] into vm_utils.[ch], then
> it can also share that (need to replace err(), that's uffd-common
> specific).  Not necessary anything must be done in this series, though.
> 

But wp_range(), despite its generic-sounding name, is another example of
something that remains tightly coupled to the uffd code: it uses
UFFDIO_WRITEPROTECT to get its work done.

So I'd recommend leaving this one in uffd-common.c.


thanks,
-- 
John Hubbard
NVIDIA

