Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8831B754351
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Jul 2023 21:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjGNTjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 15:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235609AbjGNTjp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 15:39:45 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F350612D;
        Fri, 14 Jul 2023 12:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpZ0PTr9upjpudu+yd6BY2VNMaGxKmzfEdUON2p5ra7duYvLxt9r3nAGbOlnIDIij8cTYlABa4EvZrCXbySiIcAli20wRmVYiN8N/pvN9OWI0HLf9d5dyBLPjjTu4JYsJ59MnQKPLH5tt6+CJxFU4w69FgRWY9zilQfiuv9v+cFAjhf4+MzP1iy1xoXj2PFqHBK17M9NQ+MvR9pz4cGWaesJuKVZN45uqu1xC1KdBYO8XnqrHghe1dr9gRiHafhhIZjLThcve+9wKRqiHmiKiVbj+Lnr5r2lSsGpq2tcvisQn6nqn507eJcspVFLa6mp/5paULcIPzdFfsotkHHasQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x56ws1yb3vQZ/QvJoAxNWeUh90a63thf/HeGWzQao8s=;
 b=Uu4hRK+NhyTY1t4RAatQ9G1mtmnYVxJ22TbxGrxxrNYskro2oT/2RSOJnGnyh9iX8MTF8pI7bw7kmywu1kxaGpO9k4v/m25R5fPRbVM+dxH4y/QYExflQn3BiIPNpMn/pzAQqupUtuhwPCSZWPuIF7vSnZlqyyXN50vyCg+vBS/rWj7xWyd1vAb2DMSa/RXg9VHgFxg00lu5vB2HQPQP0LuD4zehrW3U/bjOB8k1i+aPwPOuRf2Ed1td3vXfVXtRc8cYY+edcVDwcjXDatqIXjDK0JovqmEmo1siwfmzi6uLWS3OT8gApjoKpudlG4jWDd37WTDBXIlG5nh/7XCj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x56ws1yb3vQZ/QvJoAxNWeUh90a63thf/HeGWzQao8s=;
 b=m6QR6vVWGvd+r+xRIhnd22p15I5ThkbKbJtGwByosXbZ3pq5wHVnEfM5pzgejvNYMm2uYH/YyDYaLTQ+TnFxZm+uSmKz/NotfNZu+n2l3stK9p71rvpREo4EzKXpJ7X/YmNogpu1mZmhJsYWQJPtw/XFFohbs10Pj2cIH6IgHWzDbv3LCN78c4uf7v9XVzRLDy6PnItfj6Ig56ezIhm46AM0xoAxFUMenTgOBSTTUcP/to8HuuXKw6B7I2SKu1R+oJNo3UpS0PJKA8JL4HvQb05SB0bzT1+1halQJwLasJ/UGhnMA/F5Aa+5KJws6nGRTWgJ/qAWC1v9weInRUYgAg==
Received: from BN0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:408:e5::16)
 by CY8PR12MB8214.namprd12.prod.outlook.com (2603:10b6:930:76::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Fri, 14 Jul
 2023 19:39:43 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::1f) by BN0PR02CA0041.outlook.office365.com
 (2603:10b6:408:e5::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Fri, 14 Jul 2023 19:39:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27 via Frontend Transport; Fri, 14 Jul 2023 19:39:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 14 Jul 2023
 12:39:25 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 14 Jul
 2023 12:39:25 -0700
Message-ID: <78861bf4-649f-5cd5-e2be-89f5d19a42d2@nvidia.com>
Date:   Fri, 14 Jul 2023 12:39:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests: Fix arm64 test installation
Content-Language: en-US
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        "Anders Roxell" <anders.roxell@linaro.org>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alexandre Ghiti <alex@ghiti.fr>
References: <20230710-kselftest-fix-arm64-v1-1-48e872844f25@kernel.org>
 <8d944238-1a9a-e93e-fdab-54e74fa12e11@linuxfoundation.org>
 <785e1c1c-84d8-e87d-f22f-9a53d27f30f6@nvidia.com>
 <620a5b91-9715-ee28-423c-851506b10832@linuxfoundation.org>
 <421bebb3-19e9-47a7-8b2b-f69f125df22f@sirena.org.uk>
 <f479b731-7782-0417-2d4c-31a7c3c9491c@nvidia.com>
 <20230714112653.0b42d3c9818b038d219b5e41@linux-foundation.org>
 <68ccfd77-ce2f-857a-37a7-e9b3edcd495d@linuxfoundation.org>
 <5e5bf5c0-bcda-ec2a-ba4c-5f35dcfbc373@nvidia.com>
 <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <d03af9cc-c72e-d23f-73ad-ca0e079c3187@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT056:EE_|CY8PR12MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b6b029-d22f-4ccc-b13c-08db84a21240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: trIDqlBMdTZlO1GvbnWZOZDar1dYkQwv2vfzKx0jvn8yCwMVP2EmdqlFQwIvDvLyZzQqVvUY0b+IDoGO83tZxCmHkGy1ZGFljlmdOrori9BmjjwKQeLiaTqTNTyi/wPdKYO6g79WvnrhjQ3Qu7KEsMa8nPTfxPPYghyZEoIbMgs+t3uk3Z7nmF2xyrXDEnqD72A9GqiRnHXRMNSQBvY4wftLiLqNyxCC7d4acPunM+3SFK9Oi839hQk1bDx6lV+oKyckX10upfcWxrf3Iyuir0cZh1ndPo5A0kR+PKCsmJePuDkD/nzk13K0ry51rOonJaICQqQ/HYApqOcY9apa7kazAMojy3TwQdbBrqO90E2muzwGaeq0HrNiii52QbFXt+JVGY1xwhQQPqTaCJWVYXibQu5e2wkyREPxq6brgWhG79YOwdCjt5ooYajGnKm0gHO4+77Y9KrXysaQyeSr2vyk1d0DOGZZH07kQMt6uRhEaxaHLPAJz74GguCReX1RaQKMWL8ELlowSQfE9GCX5xq/GSA4iJ5y/SF+e72nz5gfizF+Ezoyk2yomVWbx3kICdQxQ/zl29Q0XFfHp/3EhfZAGAjWsJDHr5hDf6ibZoYtCQLR+1Q+X1LxrNQMXRwuosc494U5zaFaDR6+ByGC27P8Cv0EnbT7LzgKaCrt1Qkl9W8awfSovshDIYyk8BRbOCrOuxGQNlTZNGjxkyKYubaRsWzaQY4v96CYrjeAjz8BcP0eg2jzORRW2LN7ACsjQyAmK95EquHE5TSp5tgvjHFLJWMXHhF+6lp/5CHMjRbvRAkl1gFbezYESRs4bZcuBl8SKt+bAZbJtX5zGYjkT/k5PEGrqs/yi9sxhEtBxVk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(8676002)(5660300002)(8936002)(316002)(16576012)(31686004)(70586007)(70206006)(4326008)(41300700001)(54906003)(110136005)(4744005)(2906002)(478600001)(966005)(26005)(53546011)(2616005)(16526019)(186003)(336012)(7416002)(426003)(83380400001)(47076005)(40480700001)(82310400005)(36860700001)(36756003)(86362001)(356005)(40460700003)(82740400003)(31696002)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 19:39:42.6980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b6b029-d22f-4ccc-b13c-08db84a21240
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8214
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/14/23 12:11, Shuah Khan wrote:
...
>> Just to be clear, when you say you're applying "both", I'm hoping you mean
>> both of these:
>>
>>
>> [1] https://lore.kernel.org/all/20230711005629.2547838-1-jhubbard@nvidia.com/
>> [2] https://lore.kernel.org/all/20230712193514.740033-1-jhubbard@nvidia.com/
>>
> 
> Right. The ones you have links to:
> 
> Please check the latest fixes to see if we are all squared away:
> https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/log/?h=fixes
> 

Yes, the patches have made it into your tree safely, looks good!


thanks,
-- 
John Hubbard
NVIDIA

