Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD1720942
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 20:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237027AbjFBSkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 14:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237030AbjFBSkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 14:40:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4551A5;
        Fri,  2 Jun 2023 11:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnC4AAQLrlkbNilH03ik2RanMp7tJUtXjuPwGTq5guiqbQDloq2Fs8kJgqGcfcpeUljqYRXoGCy7JIyd22SsGuSvhDvluPXc+EbOq68Su3P4C9rS96R0Z0lVc6sHy+nCyRITsFM1ZnGndeh95DYn2rtBIqJSrEd2utkGcATd1Kv1x9VmklOtxeFeg/AkDTJ8GBLsm/68SBMSwneUTyVZXfG+RyTryOJf/a5MugMKPHB1IvgNdfr1zk7kHXYs1swaob713bZYGM05lAd/mOE0OnUy0rTIKwiyZeZQ4AqwutqIln2jz1W1U5fpBcT5RiHolFYGx0lQSm4oHbJnOleCUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnqWFh71uGK5Q1ZychGDCvIDYbyHc7OUVjpiBoUdO/U=;
 b=Or7J+Mu/yZyqZ/heJAMe7RKKY45V4qxAc7/mtjt1BuW4t6bbw59V6HbEjxygzEeyKJq420Zs2F+hWga62PZC1b/6x+Zfdkm/dhWjV13W/jdgJaZS8GKvwfXofkp8r4hlJb1CWrgmz5zUtCf9jxFSoiaOcrNvnGtJIpc1V5lnbU3CU4gxmT09ddSZlg7pBqTkCtJoVBF0G4C1weFCshCOSpkkcimO4r7wmDa9AUuYO8aLwPD5b1jmk38oVLRQY3GyBSShEJ/fCXsBH1dInWIMRAlZaWTMfSh6t1sVoWnp4rFN4q7mFCheB7HXylLLmsRGr9WNE3cGLvErj2bO/I85/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnqWFh71uGK5Q1ZychGDCvIDYbyHc7OUVjpiBoUdO/U=;
 b=UsEVci9VxhbuKZ5qi9YtnCmQpw2sTQT3Zxwja+74W5cZM1jiRd9191rlDvg4fvkAza9gm6bfc82JbNlboB3c+iUPbI6yuKkzQpImAKEHnmpoarLR/Q2wr4YE1MBpllDh2aTMJH1RV4Sd+/TpIiHY/kZmunvqtzPPeBWXWA7fxauus0ULDjVSsKuVjkgC9024rBUhMYTB2ZnWlDENQymBcyXlefT6EqJpCBcrxgnuAKrg0gerlhqJjpSh7zqDkH2kpRhdGtTsIRuDStJoSYLaINg7vooJ+VzPLV298Rm9vZkCNWH8JiPRjHW/8iqjdelXINDfgAGH7wVJ+NwM16Ghng==
Received: from BL0PR05CA0020.namprd05.prod.outlook.com (2603:10b6:208:91::30)
 by DS0PR12MB7557.namprd12.prod.outlook.com (2603:10b6:8:130::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 18:40:05 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:208:91:cafe::33) by BL0PR05CA0020.outlook.office365.com
 (2603:10b6:208:91::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.10 via Frontend
 Transport; Fri, 2 Jun 2023 18:40:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Fri, 2 Jun 2023 18:40:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 11:39:51 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 11:39:51 -0700
Message-ID: <b6c8a92f-dd4b-436f-9eea-8d24ba491e6c@nvidia.com>
Date:   Fri, 2 Jun 2023 11:39:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 03/12] selftests/mm: fix unused variable warning in
 migration.c
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-4-jhubbard@nvidia.com>
 <075c6a32-3829-b7fe-685e-0c19851788eb@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <075c6a32-3829-b7fe-685e-0c19851788eb@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|DS0PR12MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: 172761b3-1175-4c45-0059-08db6398c84c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQKap9y0i80FwSj8B0uJzlYT5JfccwZUVdTMBezdF5Wq/O/GvniKv9ELwWU9RO8ptOmUgpatiSUVq+ZHQWczp+3TdJ/O5aWSR4JLJNTG5FkxqUgGbg9mJC+DGRN7C6fjmiMNx3miCVMICj8jMWYlFtIPgLkJBEk3Oje5bpXGzPTJv9VthJ3jv4PEmvnntUNIBs6WoKcMcKGtxF0LJECHqFNZhfsHXi2wtq2O5MPiNd6K0eVnWm+x5CMwnrgfPsyh1mj6hw1sF794b2MON1oJqsFePJgATR4Mv8RBImcKzRDwAW9Xgl8fkSWJZ2R6YddigiZAEQYuzZ+l4PTfWoXSJuyYG4aDRIsi+CGpllyTIeOAIHlrxMwP0k/skfrB9siqTzOwDTuwMGF/RD5VRnn9n7pPsZ1fEYeQggGn+cDjNyVbyYblDBN8iFKZQhcLFRMKmSKOvWkZVf7W5rwuGqxEOFGmloq6STYAphWZojiPXKl5MZapv/kLh/1T37Js8AdRKU+Zj1azDr0zMBEw3kh5hOcP1iJqW9Yuhmb9ilFfQzzime31t43GI7HQtQ+J37dQXIAT50o0fNuOWLUQGSXvpCnJfjkpzDss7nnPqkV0x64uwiESN3CxXxhhBRpsU4DtDo3eqJ67SF0WvYo3cV8j3N92h2ZY1SMFjdaRsqnCczx6yLJlpHChf1lTd7oUC93Ee/oGC9ODvbHzrlKC6HTnH7Yo4fMn2ZWujoFDZKCmbys6A5LGsELUuQoj4kyMsaM5d8y6PRj3mEePNlCTSk3nKw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(41300700001)(5660300002)(16526019)(186003)(82310400005)(40480700001)(8936002)(8676002)(36756003)(53546011)(36860700001)(26005)(7636003)(4326008)(356005)(16576012)(110136005)(40460700003)(316002)(70206006)(2906002)(4744005)(54906003)(83380400001)(70586007)(31686004)(47076005)(336012)(2616005)(478600001)(82740400003)(31696002)(426003)(86362001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 18:40:04.7472
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 172761b3-1175-4c45-0059-08db6398c84c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7557
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

On 6/2/23 03:02, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
>> Declare the variable as volatile, in order to avoid the clang compiler
>> warning.
>>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>   tools/testing/selftests/mm/migration.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/migration.c b/tools/testing/selftests/mm/migration.c
>> index 1cec8425e3ca..2dede662ff43 100644
>> --- a/tools/testing/selftests/mm/migration.c
>> +++ b/tools/testing/selftests/mm/migration.c
>> @@ -95,7 +95,7 @@ int migrate(uint64_t *ptr, int n1, int n2)
>>   void *access_mem(void *ptr)
>>   {
>> -    uint64_t y = 0;
>> +    volatile uint64_t y = 0;
>>       volatile uint64_t *x = ptr;
>>       while (1) {
> 
> Same comment as for previous patch.
> 

Yes. In fact I'll merge this one into the previous patch, since
they are so similar and small, and have the same fix approach.

thanks,
-- 
John Hubbard
NVIDIA

