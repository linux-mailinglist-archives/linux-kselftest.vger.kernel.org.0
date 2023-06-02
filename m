Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A062E720C10
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 00:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236585AbjFBWwZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 18:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjFBWwY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 18:52:24 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2085.outbound.protection.outlook.com [40.107.102.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A0AE40;
        Fri,  2 Jun 2023 15:52:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nL1xvN309FXKdx1MYvZrnlW6dFkt5s34iubwgkugm28ksVNS4WddEeaLZ3cgRi5r3yWQZhVnqxQ4cIa9JxVCnalLgisX+UlTXftwwxoikrunCob4QxZwK/auRa7b6c7Kue/1Ch2Kz+IYnRELL6Icnozjou/6X6jTNMS9lhGipVARHsLKKEyzqcZmxKm/tuh8aKqH92smsilMUtmMAxg6Gdq7txNLLId2CCqBq2aq4Ikd0r/9cMjLLA5XNrDYIAZGb+jRdb1SYhEA4qBn/WX9imb/f26EzQz6UceJ+Q9xwZ160xBZ2WyTUjrhubT7YqSkq8GSRXGMoU0Lu1pzKefbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTCwliSow3kIotnN9Tmg/homyw9UQL6Jx5ImxGxhSRk=;
 b=EkD9YuFDlu15WJMlvYmrD9E9n+N8e1vKYmDIKFcHL3eIu3B75W1LS5y7g4zLPYtHFCMhnYyuw40ettBA0NdooEV1pMLrFElQoct5anAeTtl5gTys9U+2MGXeJYu1f2+oi7pbuLR8iOCrHYOMn+Cx1z370y+2yskaSuYZHepakQfAxJ6TiFl9UOKw9m/7TFpO2LehIvqd18msU4f6iTn2yoOW45IO0wrOFvd4kfke19WEhZAoa2ZC1WDtunYkSOyDg+Niicv89hnbjl+bhn97smpjfO0I79f5y5OoLnrf3Lag7Gjtl9wvoEdacfzBo25lfbtTQbd3cxV9P4C/nru4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTCwliSow3kIotnN9Tmg/homyw9UQL6Jx5ImxGxhSRk=;
 b=FUfVed3zs6AHTXJO7YvqWZjxsOsEXnfruu+j4lTZMRv39lFRo15Pg2FVE1i4gQbiJYLQaokXDqEsOLvTCIIhc4d4LnnKy6xZaHj4djBfO2MhIAuxEdtU8YzXAMF/IY2FTbHkLV6kYZrPC0QBvrMUAJOsGd7raApsFIOqYh0oM2v+aKhxtm1qfyiu8BMbO2Z0UEn7FkpN0MSZ5RoQlK1wb8/4JDP4tTbwfsbf8HHHcgv94fGZfy8+wQGCUETtdx8psunU9exPgzUwf/cRHaHBlIo/6Y1Go8j7RVw2ij1hljdA+UsU6k/QtoqUDJ45Seqmbv0gWHfMQsuHS6wje5BkEA==
Received: from BYAPR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:c0::20)
 by SJ0PR12MB5610.namprd12.prod.outlook.com (2603:10b6:a03:423::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26; Fri, 2 Jun
 2023 22:52:20 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:c0:cafe::34) by BYAPR05CA0007.outlook.office365.com
 (2603:10b6:a03:c0::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.9 via Frontend
 Transport; Fri, 2 Jun 2023 22:52:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Fri, 2 Jun 2023 22:52:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 15:52:06 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 15:52:05 -0700
Message-ID: <990f222f-643c-3b8e-6e5f-84dc98c3f2e8@nvidia.com>
Date:   Fri, 2 Jun 2023 15:52:05 -0700
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
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHpvZcdik7VPsEcL@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT010:EE_|SJ0PR12MB5610:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0ebfeb-6d98-41a7-5a01-08db63bc05b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j5AwVFN2HYFCjjMO+YxcNZpoRGBIYpZ0FNYHOqfDeA2LJeUGOIXKTQZY4Qs1nMBJac/5Og3vz7u1T3Y0+RTyYjNNrGr5RFUsTPY0rSw8R57bBOnHZdsWYbkzby4/QPVFQBtBtW/QiB1A0UskTp/d3ENE6loJKW3lvOkB1YpBB79/wLX7sugWZUgOz8HXBHHXXZiFath5dbLddDeHiGfaDi2R4L/T+quqElFPu50XeXgxUndyRkJoPHkmdKFfjXmvAJUKHOOIR1GjGk3RzI296tURBo87ZXRfhZlSM3AW00GyCAvEpaN/B0Vom1B5r+8SCymLLCgqZviY2yvkd4F1rftaxMH6R3ekimPsfI7KLYR/bqCUuc+61yIi1E/b340Bwutft2wV9E/gmUxvaX7uz3llGPbmIzfCBlTioHJTjr+KgiZ++nnSXA99Na6lwG99TFzZRAi2jDX6V11QAUxxZbzAHZ01q3qE6MZysWM/s4YGEA754M1JPhuNnd7z0UbEce8GQ/GEC50V/WUTJrkc8NqMCC3eqoW6m5cL+2lvjEURy8MFWh9oaUt9KgP+uZjlOArOZhz9UEfzwRaZoQ8DDt1lbtS1l3i099t3jQHoCl7TTAo0ehZk1vsMkRXaufeHBgd97c60KCtwd35pqLDQ8yYyHD68t+5XuN8RdKlJeLFsQh8+DarfNa6NVIKXQM/1NASNZ9ABvJvFLaeUueWVelIn++NI6Mth8IFC3sUE3F2bOdwrJ0LP7TS6DsPu51c/LWK6LenzFdJuXbId7WUK4w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(36860700001)(82310400005)(26005)(40480700001)(41300700001)(36756003)(7636003)(316002)(356005)(82740400003)(40460700003)(54906003)(16576012)(426003)(336012)(2616005)(4326008)(5660300002)(6916009)(83380400001)(53546011)(86362001)(31686004)(16526019)(70586007)(186003)(31696002)(70206006)(2906002)(8936002)(8676002)(47076005)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:52:20.2161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0ebfeb-6d98-41a7-5a01-08db63bc05b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
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

On 6/2/23 15:38, Peter Xu wrote:
...
>>> I'm fine to move it over if you think proper, but just to mention I had
>>> those in vm_utils.h just because I left all uffd specific tests shared code
>>> in uffd-common.h, so my plan was uffd-common.h shouldn't be included in
>>> most test cases except uffd tests.
>>
>> I think we're in agreement that we want to only include uffd-common.h
>> where it's actually required. Likewise with the uffd*() routines. So I
>> would like to still move this over, yes, just to have things in their
>> best-named location.
> 
> Sorry I didn't get it - e.g. I'm confused why we need to export
> uffd_test_ops into ksm unit test, it doesn't make much sense to me..

Oh, I see what you mean, finally. Yes. ksm should not need that.

> 
> If you think vm_util.h is a name too common to contain uffd helpers, shall

Right, given the presence of uffd-common.[chg], I really want to avoid putting
the uffd helpers somewhere else...

> we create another vm_util_uffd.h just to put the uffd helpers?
> 
> Just see what's there in uffd-common.h, which is still ugly (I could look
> into it some other day):

Good point.

> 
> extern unsigned long nr_cpus, nr_pages, nr_pages_per_cpu, page_size;
> extern char *area_src, *area_src_alias, *area_dst, *area_dst_alias, *area_remap;
> extern int uffd, uffd_flags, finished, *pipefd, test_type;
> extern bool map_shared;
> extern bool test_uffdio_wp;
> extern unsigned long long *count_verify;
> extern volatile bool test_uffdio_copy_eexist;
> 
> extern uffd_test_ops_t anon_uffd_test_ops;
> extern uffd_test_ops_t shmem_uffd_test_ops;
> extern uffd_test_ops_t hugetlb_uffd_test_ops;
> extern uffd_test_ops_t *uffd_test_ops;
> 
> and more.
> 
> That's why I think this header should not better be included by anyone else
> besides uffd-stress.c and uffd-unit-tests.c for now.
> 

OK, I think I can arrange things to meet that requirement. Let me
take another shot at it.


thanks,
-- 
John Hubbard
NVIDIA

