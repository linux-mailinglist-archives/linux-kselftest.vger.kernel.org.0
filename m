Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFC8754590
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGOAEf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 14 Jul 2023 20:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjGOAEe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 14 Jul 2023 20:04:34 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF903A84;
        Fri, 14 Jul 2023 17:04:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LNWiosKA0nfeYHo8y5JE/MqeYn9DnA1ABXCIBb/I+p2tXIhgtlv/1EKXmZINaIP8Z4f/tZziEQazMA/rk2ZST66iMF17V3nSR1QzNA1+DofiR4w14v5//xO/Dx8ltf+UV5AwrAloWorj1GOw69BNxY5EPTkWNGA09kIM67qI28F7xUpJPoObmKiJc+Hpvv9DB0QGTi78FCjHiNcmNxQfdeSHaTeXv4bZElfYA/E4YYM3gUKZ47yJmVgAe+11vp6ls353saTszHaYMp96zik07U9Bjh721GDP06xCqYyEhj4noP0vgh0P7iOaPaJ3pMvtcOCJqKUpv1Dr3LEBg/4Qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o8+XPvbC9JXK0y4BrnW2ftiMZnYYHjp+vE4T1okv1EU=;
 b=kC5NA5Iie5cPD8SkXIKb2XFjrSIrF8hoZCccdSSvNDwQuGf1b4tNW7HswdXTe6Jtte+O0+Hh8FM5HaHhJqp1Nqa6FAasNX4Syv3/U4qPKGGojy+hcvjntWzxZ9RNUrONYpwSQhJbBB2wkPCz14u3dFZLR17Dm7UKp64rSPTa3ULuw3lGIv2OwkeamjjJ3LTU6OvFvsHH6HYUkg/i39GBJUhAP476P52ou1z4yzOxF+4EMggbs8ys7M6P4Ac6i8GGjsgl2uqAfQSZPtUFqnHf6+vERbvYM8zTor55Xl++/18G7vqUSaT16GE+bfe6qGzsWw9R4+rkgOHbhdb7gV5s9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o8+XPvbC9JXK0y4BrnW2ftiMZnYYHjp+vE4T1okv1EU=;
 b=CKxhcZAE+c/xtei6OlqR5NFZvckpdAJ631kQa0tDnP4H9+sEZw6ta6JCEi+NYuRavJtXfsPj0eAUerodqklwIYDYuDYvBpdXqPmkvAWGtV+PBq/P8iEHJzE//XVCH7gd89xsXE6jz/dylXl3hjeV1C68LoR7t3cLxwvljnaEjh12wltC2M82aQKxTcp5gAzfOD/n0jxkzsUi3xUfKgZyquCdasNdrEQAaBYsMWw8tPgeqk7LmeLaV7SGW9+3NbDmZvvwbiIRA5Ugub8BvQDN5SaHbYR+kmc+i6LwjaedND3bQvswKc1MAcwGs5RY+ghT0GWBTMB5yguAcPesKDGn+A==
Received: from BN9PR03CA0276.namprd03.prod.outlook.com (2603:10b6:408:f5::11)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 00:04:32 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::b8) by BN9PR03CA0276.outlook.office365.com
 (2603:10b6:408:f5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27 via Frontend
 Transport; Sat, 15 Jul 2023 00:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27 via Frontend Transport; Sat, 15 Jul 2023 00:04:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 14 Jul 2023
 17:04:20 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 14 Jul
 2023 17:04:19 -0700
Message-ID: <57995c19-36c5-d868-293a-f03ad507da98@nvidia.com>
Date:   Fri, 14 Jul 2023 17:04:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 3/9] selftests/mm: Skip soft-dirty tests on arm64
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Florent Revest <revest@chromium.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>
References: <20230713135440.3651409-1-ryan.roberts@arm.com>
 <20230713135440.3651409-4-ryan.roberts@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230713135440.3651409-4-ryan.roberts@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT014:EE_|BL1PR12MB5730:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cd9ec1c-6ddc-42f8-8b50-08db84c710dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgItefQStGuKBuQfgrslkgQA5GHiCuddhE/BN86f/sG5P9qxI7NfbwV2dZy2T5tjwOSufy31YIyQwxycAbM5pGogav+r/XvTW5vKAxzTXGQeYw1j7t0KybPLO9Utz1ss1RaKXnIszuDOw2f/9yjaXoKnz3v/w793xUCN1lyKdCZIZSzMjI8aWkUqPfzISQR6U3xpIP+9dEC9/1KF4QNLcRwdCHPhi7kEMvPh13riodJyp+fZQSmbIIHDoVjvAqXG8um//AXAFu2RMifWj6fGIRlYutd2PeG+K956C16kiQPq0Jpg05cKVj1L0+wCyjXa/8D39GT0/QOyniNSzH6zAlILR8bU3aMzJTO6rw8w4aKJ/laqEklaDkgYpfNOUaDURrul+H2vh7szUGnFKfE1il6uxAlNlwKps1jZVXMg2OlNI6E7Pulh/JSK5MmFePMYBrjP/vnfsCQbdFn56UWdSP3AEPEExJww0t5F14utO0p2J9TRcTmkCutyWzP6WPXElj2KnPwKvbLWC80ocp+u9ILBfwFAPsllotuQh1FVuBEJxlR/CTDpV6iN97s4O/RHiXXwnOqUs03av+ATFFGhkrg9HbccocHaDbC8+HLcKuFhDyZb5g/gpY4vUzLriaH/gMLUmZWtV4bvH0GYtBRqs55XGIy7hP1R4YLf96f2G26O0+12XD+07yyqAIJjesvZ/Z1m0UXa+bqAM6CkCWF2N+OubZA6H1ryc0EGbc8qXxW+bm26ifCM9TZaHpxJ5kPFaRZfcPtfILyfe+9/LSDGn4GfiiehndAceUKuKNbrndM=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(356005)(7636003)(31696002)(86362001)(82310400005)(36756003)(31686004)(40480700001)(8676002)(5660300002)(110136005)(54906003)(16576012)(41300700001)(7416002)(26005)(8936002)(53546011)(16526019)(186003)(336012)(2616005)(2906002)(47076005)(40460700003)(83380400001)(426003)(36860700001)(316002)(4326008)(478600001)(70586007)(70206006)(14143004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 00:04:31.7273
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cd9ec1c-6ddc-42f8-8b50-08db84c710dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730
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

On 7/13/23 06:54, Ryan Roberts wrote:
> arm64 does not support the soft-dirty PTE bit. However there are tests
> in `madv_populate` and `soft-dirty` which assume it is supported and
> cause spurious failures to be reported when preferred behaviour would be
> to mark the tests as skipped.
> 
> Unfortunately, the only way to determine if the soft-dirty dirty bit is
> supported is to write to a page, then see if the bit is set in
> /proc/self/pagemap. But the tests that we want to conditionally execute
> are testing precicesly this. So if we introduced this feature check, we
> could accedentally turn a real failure (on a system that claims to
> support soft-dirty) into a skip.

...

> diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
> index cc5f144430d4..8a2cd161ec4d 100644
> --- a/tools/testing/selftests/mm/soft-dirty.c
> +++ b/tools/testing/selftests/mm/soft-dirty.c

Hi Ryan,

Probably very similar to what David is requesting: given that arm64
definitively does not support soft dirty, I'd suggest that we not even
*build* the soft dirty tests on arm64!

There is no need to worry about counting, skipping or waiving such
tests, either. Because it's just a non-issue: one does not care about
test status for something that is documented as "this feature is simply
unavailable here".


thanks,
-- 
John Hubbard
NVIDIA

