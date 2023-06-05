Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319C8722EDC
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFESp7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFESp6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:45:58 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2063.outbound.protection.outlook.com [40.107.212.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85DBCD;
        Mon,  5 Jun 2023 11:45:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QM/+Qa/JZgVQ9hQD7L007metcDkf5MIGgZSYH815d5TZC25PRh1ChCf1rpLeiemIGE49jywAy1lmNwb8yybiaatJiZg1M9sIA4Y93FI3n4cm7aiCAwCxV9DucSMDzVDavMAEC1Tl71Gjk+SKSsTjvYXy2woKerpau4l2lUvpLiUxWgk1vq3IID2QsLFe4C9tM4lYixsvbJKe0C23K+aGeaYaSnM9T8X8CWOgO4No9/9W8/AnlxeNeelspwwPr9tj7UAYz0bFr8UauVaZ8COmh+SDr3U6sa3aP/6A7q8xvZ429LybxqNZmJgcqgAeKTn4LkQwOlrFT+pOQxD4j40hgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScM44XN/sTIIV8+HD+uJL/SUy+T4f338lVor4+vf5aU=;
 b=ldc/7gMfdMX9+grA0EpyP2+P62D0w0F/5uSOdkvmTEWT20kfSF0iJaQjkUyvDa4seIkbKbtUYONkC40ND6bMKEZEC7h2Md64fK9dQBwII5Gm3i/8iAkKZj7JPaxeRSUdVUN4fWkAVEHEfv+Ql9ihg9jeVv8ywSih2lU8wE6TKw6477ZuOvO+g8x7id8AeN381ZgKlnbl9wPyDfRi6gHqOSTZiRyLp4ZfkZMokdPPlTak/jLNrtwBTPtLbDovD+UdgbTXETgdTB4pKxVydmZzWZSOLNdyyeAxzttAqkS2b3SGRb4YC+QUoRq85XymIZE6AGdKuCddYbdIKcwK2QPdew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScM44XN/sTIIV8+HD+uJL/SUy+T4f338lVor4+vf5aU=;
 b=j+PWzaB4ZL/Dw2+dXe+moiklob1q2pG5Gpq4iBgiojOfy+mFDsOJW/O/7KloVhMLxSsgYnA71HYiPhO9oCzZw1uLQRx301a/E3RtUXxCPS79slF0MuDZbYVH0yd7iOs6KOdJAuLhpjtUbsvJ/zqXJIUw2l9lEISslqUWP5NcPw74HVXwQs0oLesLHS7F2z+YwviWrW25ndsdfJbWToyIHx/6lwVCvNpIjZps2VxfjBlwlmu1Y6vCzlGrrOv9G1HJqsfwz85fNXE/Hf7m68KwWsNvTkDKhF2qLsoIIwDR5LhcIYrjsM9KOUVhClLhYcI5x910EfkA1fV+/a4rPsFagw==
Received: from SN1PR12CA0044.namprd12.prod.outlook.com (2603:10b6:802:20::15)
 by PH8PR12MB6745.namprd12.prod.outlook.com (2603:10b6:510:1c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 18:45:55 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:802:20:cafe::7a) by SN1PR12CA0044.outlook.office365.com
 (2603:10b6:802:20::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 18:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Mon, 5 Jun 2023 18:45:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 11:45:36 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 11:45:35 -0700
Message-ID: <58ff372c-a917-e580-80ff-f1118f82320a@nvidia.com>
Date:   Mon, 5 Jun 2023 11:45:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 04/12] selftests/mm: fix a char* assignment in
 mlock2-tests.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-5-jhubbard@nvidia.com>
 <18e69073-1007-07d8-bf0d-5f400ecab8ea@redhat.com> <ZHoJxAWtwBo33l6B@x1n>
 <f61fb7c1-64ab-c3c3-bd95-92a962f07226@nvidia.com> <ZH4BkqDh0MXqx8ae@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZH4BkqDh0MXqx8ae@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH8PR12MB6745:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e7776cf-433e-4508-e042-08db65f5186d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FBanSuRMnoKzYlEwYvgBq573IXfYiW28QvRv534LzG6GwJ0z3xNDP4Fvp1n1i79u94zfGD21IZcvrO48Ks6UOPvAUiV95U9PP3zw7RehgwJXl8bGxYYY/j2B6RWsgxvPTXm92LqHcLSE3XNYW72rlV+u1pyRPOaBGCy4wr2+lUGERnaBX7c9nU+uetsnfGls3Xl/3zrvjssMdSLCBTQWQ8p9+cVQv1+DqDZLJibtgTwTNGE4vTI9hCyby73r59dtU4iT4rybm61ElSZgfgXPccxssrDC0MhiDLwc8R0Kjn0aLXKxMNYMLfOfRUBbZlAN7niotMDzRjhKe62P5MijsjGyOhVuLGJmsgYXnvQGmvS/hklYsYN7dRtg4AyB80xUDuy2tbZh7gL+Sw01hycTwECAbl4WY35yVYoYQ/FPf9ba4eThzKx09Z+10Pvknv5v2lErRXq6qM4C17ulA7RsGiWfDCaT/YSHOyEro2ojoJjkp9CZqCsqDg8AaLFWEY+yg9vVb6GHPGGOk2kBqzY8k01BTJC2cXcMVD3CXiDshW2JVOf+cjVAaWJflD+sgdpxkBb/UgGZliEgcAwAzMk36vMk/Gsc4Bj97+g+iPoMBorBOHNnl5PiEXbgI8/SwY+ZQDes419FsskweKZLvAQBSCex0vWlwSrPKqS5uGbv+fwUI90ZVkdDLU2Mn6/PI5A0YDx25ZCeSTaONe4ghEAj6jNYv1ndJoW4LOoAvph+riak9SfYC+27wfrASGABRLW5YJwTSoDFWzFWaC///ZWDog==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199021)(46966006)(36840700001)(40470700004)(36756003)(2906002)(86362001)(31696002)(82310400005)(5660300002)(31686004)(40480700001)(47076005)(83380400001)(16526019)(426003)(336012)(186003)(36860700001)(26005)(53546011)(356005)(7636003)(478600001)(82740400003)(16576012)(40460700003)(54906003)(70586007)(70206006)(6916009)(316002)(4326008)(2616005)(41300700001)(8936002)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 18:45:55.3054
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7776cf-433e-4508-e042-08db65f5186d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6745
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 08:38, Peter Xu wrote:
...
>>>> I'm probably missing something, but what is the stop variable supposed to do
>>>> here? It's completely unused, no?
>>>>
>>>> if (!strchr(end_addr, ' ')) {
>>>> 	printf("cannot parse /proc/self/maps\n");
>>>> 	goto out;
>>>> }
>>
>> Yes it is! I certainly had tunnel vision on that one. I've changed the
>> patch to simply delete that line, for v2, thanks.
>>
>>>
>>> I guess it wanted to do "*stop = '\0'" but it just didn't matter a lot
>>> since the sscanf() just worked..
>>>
>>
>> Maybe, yes. Hard to tell the original intent at this point...it might
>> have been used in an early draft version of the loop that didn't get
>> posted, perhaps.
> 
> I'm pretty sure of it.. see the pattern:
> 
> 		end_addr = strchr(line, '-');
> 		if (!end_addr) {
> 			printf("cannot parse /proc/self/maps\n");
> 			goto out;
> 		}
> 		*end_addr = '\0';
> 
> And...
> 
> 		stop = strchr(end_addr, ' ');
> 		if (!stop) {
> 			printf("cannot parse /proc/self/maps\n");
> 			goto out;
> 		}
> 		stop = '\0';    <------------------- only diff here
> 

Yes, and that pattern shows why it wants to be "*stop = '\0';", but
it doesn't show why the author wasted a line of code in the first
place, setting a variable that is not used afterwards.

In other words, changing this to "*stop = '\0';" would make it
look pretty, but it's a non-functional line of code to add. Which
is why I think it should just be deleted at this point.

thanks,
-- 
John Hubbard
NVIDIA

