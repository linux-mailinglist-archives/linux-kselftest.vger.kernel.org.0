Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7D972093D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236725AbjFBSjP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 14:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjFBSjO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 14:39:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE544197;
        Fri,  2 Jun 2023 11:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaB+C8UG5E931Evt4NClc8qctY5GzK6PddFs4gwQO4RjpKWzXw4dkN65VIoPoNkp6eJgxalKFRndavyJlKakl4GPnky98btdEpfV6sd+KqXXNWz9VFQWpELN6S73z2aWVrO3W9CROdkQMvpOSiDBwzA+MiaMOja84X5bw+XW0/0pCxxlKTxcGv9jfL04ZzsDnSnkLUb2G01I/HvW5xdzikYf92k7cYuSZhqu7J0X5HxgqNNIvFEvGQgFI4YcolH/7p/GXPID8D7qlTI7RJhxpluF4r5i4V0hYYPs2be7as2rFFD+gZpq/jZy5Ymf5lU/TVyzb1mWSKw6v8c7f8lLQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsqlgU9U3Arr1OKeQhUZoeQlAfNl/gvZumbSJ6rjad4=;
 b=WqZ6ifVtlvWePeCeUj+3uhfgdJsk0N/c8LcSSrCZZlzcagEeKea16GkFFq7vTMZgwhtsvvBJPSH9Ww0dt4mTSAlo0/93TIYvxCGdQH0cmOX9NCLUQk6rcQqS7ePGahKMj1xWJsvl2X+jnfRo4/O7gMTw9MuqjxLYz1TuURkVF1was4ZrsMYzDAzMLY9SwsuyQ+AvKE3ij5CHQudBCcp9e6c2N58BrEF+1x8w6uAdetoP4jzCoo74a0uWJUL+kzQo9chUKtkO5DUFtMtuBsSllA4MaXmEjTZBmsW5Td0qFqgPsQua13WXslk8dIU8DAtE17M+eQrcScLAkWcIfuuwaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsqlgU9U3Arr1OKeQhUZoeQlAfNl/gvZumbSJ6rjad4=;
 b=AhGWn8qMYPuYHy8uu5M8FWoBPLYsE1pFbWevPNaSk2eknR+FnvjFJlwJBy6Yi+jgB6BBJH16OoJcsYjozRRQpmgJY+jwr3XVNCvIKWlas+wpnf5FfakYA8gUWFspncFEauMps0hR76amWv6ta62tvAmPETu8PRt+SsX5z6qjwGLoz14AKo4ByDDhtQzTAH8f4P5m/aXgMGhefP1l0i/fQ/Ie33jfMOgCKtWR+G814BeicDCAn37jdS8TF04LtbFa+4ao3fKAH2DWcxphWL2ZNraLF3O8IqYi86BIaZ7bOirCkmWRM9sIRnG26KAVSt1sfVyHZlxAtjRARP+KG0vcGw==
Received: from BN9PR03CA0288.namprd03.prod.outlook.com (2603:10b6:408:f5::23)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 18:39:08 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:408:f5:cafe::fa) by BN9PR03CA0288.outlook.office365.com
 (2603:10b6:408:f5::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24 via Frontend
 Transport; Fri, 2 Jun 2023 18:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 2 Jun 2023 18:39:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 11:38:54 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 11:38:53 -0700
Message-ID: <f725839c-4956-b7c6-d532-27f36a9aaf16@nvidia.com>
Date:   Fri, 2 Jun 2023 11:38:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 02/12] selftests/mm: fix unused variable warning in
 hugetlb-madvise.c
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-3-jhubbard@nvidia.com>
 <dd78871f-c95c-6691-9ceb-532271b1f453@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <dd78871f-c95c-6691-9ceb-532271b1f453@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 22feb0c9-115d-4051-83b0-08db6398a68c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZAjAMXewfV9Yx1jvamkCvGAhoeXOnvIDwKmCIJcpSwKEKTajtkvaLaf6zf8eQfZFp6ZNd5r8/rm7eIibm27mu4YZsOP77jlcE0MILjpGXRLFqLSSETHicMrhQc6ySJqX04brgb0sakGnoJIlYSulk6Wpe36GFZeIoNGwgHb+NmtrrfZ8YjigvX2C5276ypThD1nPQeZ4hyEVx81dBUV+pLHwn57AVR3mJwafO2H84l1dzE0ZdtzvJtZ0BMs1NEhq2sdAbjgwP/2WU19hkY3VDMu2vBwJgrU58D9NiyFWK+0Xo8lwI4t4sKKAcwkjQoy8swwCQtCYzGH+ws92FiMQQK3QK1IrR32iUe6zcPU5yy4bFDrAgW0Q/MZyN+AO78xnpJi57DK0YmnrS5AedooM3h1d7w4yCgRdXd+wm93rRh2TsU+wTOPpcDoEQ4eU3shPxIhq+sMXllHB2v4AkF4SZsUbI5o6qFv+LQ+kGWOhBNn3gxRmoM+u1l/F6Z0CuGesYMW+VbbHURXTArylw78hv66pSD2kfbV6UdeBBmCm4cqMO+yoy07wcbrY0hkW0jO7k5vnFlwpB94hHMEpOJUmBgf9kwlX24aNVqTKIrlgEOlKl+ev+FjSQaNlkt5fNS/uIfsUezEaGAeS9RTy8QJ9IvdpuYURcfPl8RKnZvm6tBQ63V2Ga0BwQh6TfZ0KrUgMCsyrMW8s0d6UqW2LOp2cZBZ35XAMLswR18vmeIeYWclVQ5TD+dlSpCNsosTyO/p30YEOj20ZeDevN0LtCZEgVQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(186003)(53546011)(26005)(16526019)(316002)(36860700001)(47076005)(426003)(2616005)(41300700001)(83380400001)(336012)(5660300002)(8936002)(2906002)(8676002)(478600001)(70586007)(70206006)(16576012)(110136005)(54906003)(86362001)(40480700001)(36756003)(31696002)(4326008)(356005)(82740400003)(7636003)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:39:08.1275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22feb0c9-115d-4051-83b0-08db6398a68c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

On 6/2/23 03:01, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
>> The dummy variable is required in order to make this work, so declare it
>> as volatile in order to avoid the clang compiler warning.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/hugetlb-madvise.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/hugetlb-madvise.c b/tools/testing/selftests/mm/hugetlb-madvise.c
>> index 28426e30d9bc..3296ccaf7525 100644
>> --- a/tools/testing/selftests/mm/hugetlb-madvise.c
>> +++ b/tools/testing/selftests/mm/hugetlb-madvise.c
>> @@ -65,7 +65,7 @@ void write_fault_pages(void *addr, unsigned long nr_pages)
>>   void read_fault_pages(void *addr, unsigned long nr_pages)
>>   {
>> -    unsigned long dummy = 0;
>> +    volatile unsigned long dummy = 0;
>>       unsigned long i;
>>       for (i = 0; i < nr_pages; i++)
> 
> The compiler can still decide to optimize it all out, because it's not a global variable.
> 
> 
> Placing a
> 
> asm volatile("" : "+r" (dummy));
> 
> after the write tells the compiler that the value will be read and cannot be optimized out (we use that trick in the cow selftest and I've been using it in QEMU for the same purpose as well).
> 

Done. I will send a v2 with this, thanks!


thanks,
-- 
John Hubbard
NVIDIA

