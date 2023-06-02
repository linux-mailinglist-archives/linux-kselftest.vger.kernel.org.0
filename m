Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7663572096D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 20:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236965AbjFBS47 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 14:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235724AbjFBS47 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 14:56:59 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA46B4;
        Fri,  2 Jun 2023 11:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfHck1kr6zVTtoU9szrplBrESjHThSoNVwOV2goEEGmg5nQa6QEsm8SUfFiJpZqgrKmM5kZkEE+1wBVfDMzkTIK5ldaKf5uUurY3eyuSZ6iwYFPUBIYPJgmGSUsM5R3/oIGYHijx+kWUR2VzkdEwdWJHing1bnhTQRSth33tNbQnrQAduDPR0NqNi4wQ0FIYWJ1nHy9Wznnkny2caZe2QLfTIXw8wGvSt+CX1TXFHoaGmJ1/burBpVu61198TOmTS5x9ayBxGa7YD88PYvDkGpFOxHJ22fU0QKy4z1t3WJud5ejJvZTRyjl+RqlA6cS7BuuxDuJvAoyq0PswyQSwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQzCx6fdHtt7Dh2M8cGgcYrBG8yKI9NNTwSZDQpUQlk=;
 b=JRIYbyXeztv2YOSA+E2bhsnq2hImOVX9nEY4Uk7BioxtK2p3BD35DwwL3Q03aFzhuBs0GgLnJGyYttzSr3pcM4iwwi8paGCWlQBteBhYfKiuU+w+sbhkSP+7687cwIt5YkwIJ70TZh313yjpjEx7dR534+vZdB8ag6i4ytzpkhx4Ozgf1QOdIFHjBut0yHe3udIFZUURGUcpdaWfSa6RSx+4hqCsToH3nWv7UUw9yWIpef/kBKiFk8Zpjx0oC1TfCaDkw3OHq/ewrpYPrJfGvzMTFdyaWb6hf1Op8cOkNSPnBKqy2a1F9vAr6Q6O7r1I1MnBhYviADXMJzx0VoraYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQzCx6fdHtt7Dh2M8cGgcYrBG8yKI9NNTwSZDQpUQlk=;
 b=ObkFN5NNO5cnLQKvZQzZuiwqdHzN4SpoKgB+wwu2NPwPZM5DlNyVrqV9gI+oK+jx74U87xkZQK/sjbDaoh7JKP1l3+/lljXNJFLwZ8x/lc9GleGu57hzRd8BrbiI8r1dxAa+6/FD0l5mZPihY6tOzaCpbWbhfy0S/OV4mosXDMTnWdK2Rwll2WRPaaya2+F9WIEV/qa+FgIbYUPTWvdGhaJAZGfIPZ9rlkDlgaKV2Hb7kApqM4bd4OYznPTfVoXCo4Ea6TT9TLGockQwsglh4xlZJvdMWBZIh0FI7ES0p8wkr/Hx1EAUw/yJuo63MOb4FEvFVtyEn9V71Fv1V7mCfQ==
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 18:56:49 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33a:cafe::8b) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 18:56:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 18:56:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 11:56:34 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 11:52:42 -0700
Message-ID: <f61fb7c1-64ab-c3c3-bd95-92a962f07226@nvidia.com>
Date:   Fri, 2 Jun 2023 11:52:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
 <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com> <ZHoJxAWtwBo33l6B@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZHoJxAWtwBo33l6B@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT046:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d882acd-2675-4cf0-7f45-08db639b1e16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wq+MkbqT4QsiRqfBRK6IWvZx4u7ADYwsWtDjtFAgy4UwL2GKlO/9EzfTNuzpFoKQVttumBUHj/aBcyQS+0qGFV7IuIDWKkDa2efTShLYDZ9MNbev1eT3iNqddV9n5zROhYDlPREHWHhIaAXxSaHUT0w8CgQ1p2MUwDtySjqLHY1ma/mzneFThMXYV/NtnUlh0VdXfJKQID8+M29dCDv7TBuolEBx54uL4YuzTmtuxq97rAL5Ii2biA19IO8gxV97WpR94B+dqNg1f7k/Fa7v2P5EJQQme+82wpPXcN6FXZkFr1D8QRf0Cc+t3PotXllznQa+XWJ9Uj5MPI1mBFhGumIpv60sqOPK8+1D9osfeyMLofBppMfx6gZLgG0U3KrAp91IL9KpOxfDcbZovItRMLnbKAi/Uo4ZkwB4r2TgRVdzwLom5n+G5UVkvlPBUtC+z+m+nb6gWcsv7hEXGwGBzKlZUbsmjSCN30dkUkTEBTVvk2DuQsu7LytOke8MhJIWtOaYA98rwpGN8H+MwBd4dthfU9fltjzURzWFtBOvxNBpcw/uZX+dz/4sXQbMLl3sRA1s8oIdP21ju0A6TPlmSYWVBNmDcckECh9Xg4OT3KV8lx8GAeaUJEMf+tkLyhUwF4euJ3OvejBy2tgkpvOj1i8PjbSecWRCwiWDz5AEj+pckc3wDRYqWCW8bYM4TkCNxc7T0uXGMaHSgLP+hI4wy4Ll1K5VTIIg+iggx9LkYaD6FtT7KDD2huPNpJGsWqCZSDICbMo9aw0CnLZ9H2O2Qg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(451199021)(36840700001)(40470700004)(46966006)(86362001)(31696002)(31686004)(8936002)(5660300002)(2906002)(316002)(82310400005)(356005)(82740400003)(7636003)(4326008)(70586007)(70206006)(16576012)(8676002)(54906003)(110136005)(478600001)(41300700001)(40460700003)(186003)(53546011)(40480700001)(2616005)(47076005)(426003)(336012)(83380400001)(36860700001)(26005)(36756003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:56:47.7835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d882acd-2675-4cf0-7f45-08db639b1e16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

On 6/2/23 08:24, Peter Xu wrote:
> On Fri, Jun 02, 2023 at 12:04:57PM +0200, David Hildenbrand wrote:
>> On 02.06.23 03:33, John Hubbard wrote:
>>> The stop variable is a char*, so use "\0" when assigning to it, rather
>>> than attempting to assign a character type. This was generating a
>>> warning when compiling with clang.
>>>
>>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>>> ---
>>>    tools/testing/selftests/mm/mlock2-tests.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/mlock2-tests.c b/tools/testing/selftests/mm/mlock2-tests.c
>>> index 11b2301f3aa3..8ee95077dc25 100644
>>> --- a/tools/testing/selftests/mm/mlock2-tests.c
>>> +++ b/tools/testing/selftests/mm/mlock2-tests.c
>>> @@ -50,7 +50,7 @@ static int get_vm_area(unsigned long addr, struct vm_boundaries *area)
>>>    			printf("cannot parse /proc/self/maps\n");
>>>    			goto out;
>>>    		}
>>> -		stop = '\0';
>>> +		stop = "\0";
>>>    		sscanf(line, "%lx", &start);
>>>    		sscanf(end_addr, "%lx", &end);
>>
>>
>> I'm probably missing something, but what is the stop variable supposed to do
>> here? It's completely unused, no?
>>
>> if (!strchr(end_addr, ' ')) {
>> 	printf("cannot parse /proc/self/maps\n");
>> 	goto out;
>> }

Yes it is! I certainly had tunnel vision on that one. I've changed the
patch to simply delete that line, for v2, thanks.

> 
> I guess it wanted to do "*stop = '\0'" but it just didn't matter a lot
> since the sscanf() just worked..
> 

Maybe, yes. Hard to tell the original intent at this point...it might
have been used in an early draft version of the loop that didn't get
posted, perhaps.
thanks,
-- 
John Hubbard
NVIDIA

