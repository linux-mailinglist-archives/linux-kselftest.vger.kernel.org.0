Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC37720CAA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 02:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbjFCAng (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 20:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjFCAnf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 20:43:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D242E41;
        Fri,  2 Jun 2023 17:43:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvduP2omH6QW8gUAzkR2315cBQPgQvFlSuKdNnCRX0LvXCaNshuyoo8VWEnz8+qRKqEqSREAQFOm9tyK/uk4GkONnPMiN/1OFla/fZPW2jL0ImeOreguSuYq5eg0uORm0xmMkuHBxaoNkCX75DmqM3yRo3PC2XBVj+8mXiJUZX2CnxV0nx/qA3pXuSrw6IqO6qR0654wH986E5MeDUTksiEDpcfmYEF34sEUzC3EOEauKE/tRJNeletPEwacbuX0fckZ+9yHKZ8VVzi6FjlZ0HoXW7gp4UV0kOzBiddQweohvtI3jMTmTJmgeFLIA6ONEoI4i5QHuefteJRD/CyPiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ozwz4Jq3BHkK6lIsFgJYhHvHuDOmiA840KQwRollF2o=;
 b=fCf70WbLX7zolizxnGdXTiUbbi02cEA0dJv3xNK77TNQhKbVAwO5KbIJbYzz6RoFGXp5BYz1dOCUlV+wKv3wiNLh3czw+ar/2nmuS3BPuDjmRzyP7NhF/kx2iJg2W+Vcs8/wl4cG5beI3ZKleahJGMCnP551LGudTTvRIserYFeTxYY6rXuOOYVH7nXCS7w4+yUvMFL2+HdTwqj0c1et2+FP78lF2kIzQ7fsI6dFzH+QKzyd6ZBjiM90rnJYMzUCMnlpg+K3c8mmwpluAPDA9EmoXSzL2UpfFWEFXw5dzrLi8wiIlQtjPaXJXjmk9iwNJkmnYDhxuPZhTlQ4GXv3sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ozwz4Jq3BHkK6lIsFgJYhHvHuDOmiA840KQwRollF2o=;
 b=jURGhyn1c0jdzd8M8yoIqkfMCp7j5dCZINBAAhBbF84v9GklEeUEUIg7uGlVgGFLuPHjHgSiLWBLN7Rf1kL1QzF9r/+orEL6iYnYeM+1lX1BOBP2HOAh0oNALcK3QiZqg3dQ89tFx27ubEFnSsonXZMfoyatxedUNPKsxnqKbJdPyrt6aFw2K0kyiXkOn6tlfYKfXrUFz9N+1b0k5WpUaSmb6z2k7wqa3AhUBNnx7ex7Cg4WrH+ScQnmQW+RGE8+q1NzwwS/whMuRBgMOEJuB1XSHRlbiX/e1BcK8VoHSJI5hlufDr/3QxdB6jmUrZjnjx1XeeMycb6kVXRppuluBA==
Received: from BN8PR15CA0055.namprd15.prod.outlook.com (2603:10b6:408:80::32)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.28; Sat, 3 Jun
 2023 00:43:32 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::e2) by BN8PR15CA0055.outlook.office365.com
 (2603:10b6:408:80::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Sat, 3 Jun 2023 00:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Sat, 3 Jun 2023 00:43:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 17:43:20 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 17:43:20 -0700
Message-ID: <fed573c9-2045-e13b-15b5-91df2446ef42@nvidia.com>
Date:   Fri, 2 Jun 2023 17:43:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 10/12] selftests/mm: move uffd* routines from vm_util.c to
 uffd-common.c
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
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
In-Reply-To: <990f222f-643c-3b8e-6e5f-84dc98c3f2e8@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: 53d91769-49b7-40b2-7526-08db63cb8e8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhZnzMTyhIMPgXuHujL1oFg/EVNGG3rIIz+Xf5LDPHsO4Yon6F2oHAoDvrqTzQbyRNoOZ+kfuhlCtcKn/bRoE0vHXbOmMeRL0SX/kPvn6zihJAQpJTzkglguK+EDWCs11WZzoLrPvxWo3GAtxvYWfR+O4Dlo9Ba+/Zdt1EOZM2ra+0ctVyMMMuapJgWiQ33lECdMOpc9q1y1eupHiqLlelBVDKDCsqnBsy+1GEWjaKZe4bYdTmhm1Eb1JlWnDKI+J3IkvXvGOm/yRtUGETZrM7n5UwwSTI8CRp6pKhF/aIylM4NVOgZ1eh5epHRk0/qWYx2Sn/Ybv1DkVA4yoNWPDr1/8mUjRfS4sGj8ZKkedDgszDNyb5NnG/NAuBfIjn9qlEcA2N1rEVACFidgeqGpDtKg0oP1uo9NljcsiYEr7L1mWcBWNdjzecKw/GnyYfImT92lwDtbXj/1KFFj13QZDslup2vh+2ZkeSprmYJ6pbqdl0wwkc62apaBJhjMcypXyokoOQPIXCQBI+GRB4OF33tk3DHTSPQqMstRj/LLlQ3eFo0BnbTGUQ8rZHNKpjjht+uXUv5lLMh8xoNOMSauTlw6uNqn2yBNDItm9R1smIqiXvX3aOCV2F+M3FblPXrZB8kzjB1iJHABed3dkR7pcitZMo2cGPjTrTi3c6NwXJmIGgXOoPKbQhcGv+KEqVvA9bYnwegKgEtIzfY12DJFoZ5mDc6E5RznDuXh1Q7bT/zMwzQhQm/hIKRUq/wHOUGRcEqIksyMi/AK0RTrzSLnQA==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(16576012)(40460700003)(478600001)(5660300002)(8936002)(8676002)(36756003)(2906002)(4744005)(86362001)(31696002)(82310400005)(4326008)(6916009)(70586007)(316002)(82740400003)(40480700001)(356005)(7636003)(70206006)(41300700001)(31686004)(83380400001)(47076005)(2616005)(53546011)(26005)(186003)(16526019)(336012)(36860700001)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2023 00:43:32.2041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d91769-49b7-40b2-7526-08db63cb8e8b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
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

On 6/2/23 15:52, John Hubbard wrote:
> On 6/2/23 15:38, Peter Xu wrote:
> ...
>>> I think we're in agreement that we want to only include uffd-common.h
>>> where it's actually required. Likewise with the uffd*() routines. So I
>>> would like to still move this over, yes, just to have things in their
>>> best-named location.
>>
>> Sorry I didn't get it - e.g. I'm confused why we need to export
>> uffd_test_ops into ksm unit test, it doesn't make much sense to me..
> 
> Oh, I see what you mean, finally. Yes. ksm should not need that.
> 

...whoops, correction, our very own David Hildenbrand recently made
changes that contradict the claim that "ksm and uffd selftests are
independent". In fact, ksm now *intentionally* depends upon uffd, as of
commit 93fb70aa5904c ("selftests/vm: add KSM unmerge tests"), aha!

That added commit added a call to test_unmerge_uffd_wp(), to
ksm_functional_tests.c .

So this needs to stay approximately as-is, it seems.


thanks,
-- 
John Hubbard
NVIDIA

