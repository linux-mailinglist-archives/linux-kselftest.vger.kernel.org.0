Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A358722FCD
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 21:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbjFET2v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjFET2u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 15:28:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D79EEA;
        Mon,  5 Jun 2023 12:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2IO5qKUwNIv6KmUOtIiXi/RUK1/aSGw5+Q8IRhCiKKVXVW4jeCkgDIKkKzS7ZKxicSnZQFzEXs5cVK7HBXX/pKbGX14Xtepvg/iqX5rK3d/iHn52Xe9KCBIDfcNldrfcCUXnVr3RgjCCa6k4Irc/ME+yklERZTntbZ7MnIbdX4lpES+3M6h0teWxKURB7p2Ce+ZMug1mK8LEC8bQ9MtFoxo/QkK2H2aexqTeWXt7tBEuEonSz5SzmayWGKE1wSPWPFUzjfSNOrIPPk9dtx5yYRy8cAhKd8huVIxxdyGOHTTEk4YnoXSsaREqpwGUD4wjVBhfwSg2KJn/SJ4OWrPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PwPLbsqr3KMQG4NVweX7qy1c034czk6DpFYWKXM+RNo=;
 b=euxH3oHyucTtKibJfcq9ll8rACHqYbMtsXbDyp+dEqTXPLy7THE+32meycdbyZ+3TMqGNXcPR2Z6DKgt67gxXxIi7t7ZR8q2NsxdH2qUObyFY/gmboLlcsrs/hrt7juAiCCpR7VJDZ719ekJTuVSKOmN0pdncmiNyfOJ99QFV/ScUx39ovIZJgaE5/WrMBY80MrzdRn7t2tmWtS7NYOOn1AzJarYRLmzXbhL9GX4DB7bRMjHbwfg+K/wh3xCBClc9g+k9DjCYHdc2qibh/3vkNG/D/0tjVg9j93pt2Ga9n1hhGf/0t3gUQZJ9BBcj9SP2+ieVt8QblLsjzRoesg4Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwPLbsqr3KMQG4NVweX7qy1c034czk6DpFYWKXM+RNo=;
 b=JfPGMRJWyWue1PTY+J9+v+Gul2IEUIr3Zo0KiYwdiYHvY0g7PGiNWEy6L+lR1Wt5pS1n/Zp0zsObF4r8AtrIA0CTQKkJV9pSfWYmS6aw3d8BC4St+gZ1coAuL6XOlT0yqtJaeAhQ0MtP11a75yUUnL1QVO+WybNByRD0edzYgy2YBgl9Vbw0V6D5xHTCOMb6nTUYHtejHOHsqnOi/yyLyzpJUOX8438k0/CtWYo9j1b1hap4GBO2CxH0ItYYnAGxQHBN6nla9g9vGH4svzYmkg2gZ6ulDkMpPKvfnxPpjYLQCv4xwqWNcQ5skow33xMF5f8GzbGs0vYnt4aO8UsPlw==
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by SJ1PR12MB6196.namprd12.prod.outlook.com (2603:10b6:a03:456::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 19:28:44 +0000
Received: from DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::ca) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Mon, 5 Jun 2023 19:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT015.mail.protection.outlook.com (10.13.172.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.33 via Frontend Transport; Mon, 5 Jun 2023 19:28:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 5 Jun 2023
 12:28:31 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 5 Jun 2023
 12:28:31 -0700
Message-ID: <9d69977d-c384-aa4b-c09a-43ffd1f8ec76@nvidia.com>
Date:   Mon, 5 Jun 2023 12:28:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 10/11] selftests/mm: move uffd* routines from vm_util.c
 to uffd-common.c
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230603021558.95299-1-jhubbard@nvidia.com>
 <20230603021558.95299-11-jhubbard@nvidia.com> <ZH4GUODwj9L9paey@x1n>
 <64e21a2c-1bbe-4ab6-e67a-29b2d1d1978e@nvidia.com> <ZH42gkoHIsgMbvHn@x1n>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <ZH42gkoHIsgMbvHn@x1n>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT015:EE_|SJ1PR12MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 352db347-2c8c-4bc6-3f35-08db65fb1356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLmP/uw1jGPVwhO8wM8WHCmrIdzcIMIRC1LhakvpsNztQyBauSsU2C7gjPj12UK9aQomAf+b2ZFpHypxQpJKtC2Ft8OBNtWyIzSiCDsAMOAbs7fyAoQgCoR5LC3HE+LlHlO3CJolmugjDwQTqVnzcD+WxPQQw3XlRwzryxvIo2kcMlQzor/easY+hv/RJ2lxTGOSNc3JnvJ1Vo1Kxscaf9eLNCBV6Ct35lcKAqYhxse+WXSb5gBB6s3MZu7wQmvPfCEe4HqIu2Q3oEAr6284ZBTBzCrv8H371PWYW+yuWWWEOW7UB7zIYoxbIfzd64qLh6gnZsV6xRSLqnKxa2MEB28fm1LJw8LGnaLrApW14Puax0I68e51xsPlHkdgx0DHUvW9LHpqc6qP0iyUjqdYiQnOGT3exGBuYuf7Nu3c+zt0uupzwJLyH4f+qQvcvL9fdpdXWkyszoQiRRSSn8u/YVlyAJ/0sk/UwtA0fXVG7DkyJGZNY5vIM6ZsDiZJjaa9k8tFKF/gdFfb44CXvAbQW38s9CmKLrl2cufr4Z7oiocuFZ1wiO2oKeCHI8PxsBgOnKqXTYfg3rLjrNMKdsPv5TYYnncQQvONrDo7iSQzdQNJsxM1SlcAf8ONSsGnMHt+3PrN0qj2ynxfOQ+YqDTZqL+Ajz44ndEJ6EWlL9g6ETJeq8+7+4uXMiaWgogp2C4AtMNRKaULF2VPQl/WkwvzYOvj8XGN2UAlGeK+KpNwtfj1a+C3eHdt4OzjIxBx25MfLk6RV9br6yL2Cj9WEEIBQg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(47076005)(426003)(336012)(82740400003)(54906003)(40480700001)(478600001)(8676002)(8936002)(41300700001)(316002)(40460700003)(70586007)(70206006)(356005)(7636003)(31696002)(4326008)(6916009)(5660300002)(86362001)(16576012)(36756003)(2906002)(4744005)(36860700001)(82310400005)(31686004)(26005)(53546011)(16526019)(186003)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 19:28:43.7267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 352db347-2c8c-4bc6-3f35-08db65fb1356
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6196
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

On 6/5/23 12:24, Peter Xu wrote:
...
>> It sounds like you are suggesting this:
>>
>> $(OUTPUT)/uffd-stress:          uffd-common.c uffd-test-common.c
>> $(OUTPUT)/uffd-unit-tests:      uffd-common.c uffd-test-common.c
>> $(OUTPUT)/hugepage-mremap:      uffd-test-common.c
>> $(OUTPUT)/write_to_hugetlbfs:   uffd-test-common.c
>> $(OUTPUT)/ksm_functional_tests: uffd-test-common.c
>>
>> ...approximately. Do I have that correct? I can arrange it that way
>> if you feel it's a better end result. (And it's better than leaving
>> uffd*() helpers in vm_utils, imho.)
> 
> Yes, as long as we don't link (especially) the uffd test specific globals
> into non-uffd test programs I'll have no issue.  Thanks.
> 

OK very good. I'll put that together.


thanks,
-- 
John Hubbard
NVIDIA

