Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3927750F3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 04:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjHICcP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 22:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjHICcO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 22:32:14 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B31198A;
        Tue,  8 Aug 2023 19:32:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=obDRgcmNq8BmfSmMr8+hAKiyB/JOKtn2IPCQ0jjmMgp+Uow48gRK7363xWQ10Wz1rd2Y+CdZY2b7+XpcJxNugZlWzumTshIfWUCWooKBkyFNuxC9mzwpYpsXx19dbzLGN0v+gwjxXz7uGP41RdAn+p62wzJR3OBVwCaogG4FHiKnoFPz/bf3elbcLkAP2heY/k00gHc+1pRYMV6o1l2R9lw+JaQcNTFJiw1wWQu+1Wmu3ZufK7alzf80P89pGVex/D9IFNmalhbIUUuZ4aEsNR1yaHOdt0hANPao2Umg/CI3UGgJXd6QZftbDhBA10STcyc4xs1Oz9zR/Gs+CVyLuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ar7Ve3Hr+DhVl9pPMkro5sLxbkFxoDGq+tMtFYS9sGo=;
 b=bPZV1T1/lfxyeaw0+gca/QkwYTYkr7jQSAK96KbL8v6hb6edUUC75TX4JyW4S+dNLkcQ/SoDf/PpHUNucSb0eNxKGfp2jGuhJviAVz8qPG+pQY+KixHOAlHOb+kpI6mjyWSDPDO/MvVS6Ov+c1aaHNqHl2KFP422sFGV6t5UusxMAU8zuwVrNDozpk3rOwBH/EaGxojjiPNcoFFj+5hR9eI+C6utmfY9AXIozA0G7KlOdI/eJBqwdQwK6GeUWq3hF0XIAEP5MfVqQOSBGYR5BYTlZYyKfea0Xwz8H1AIRCjLQjRwOowD0qGqMQQAJuwCxRMkg1IBwVd6uK8iCW1hGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ar7Ve3Hr+DhVl9pPMkro5sLxbkFxoDGq+tMtFYS9sGo=;
 b=LSjlTfo2DzD6VMty9y++21mZ7wVN0DspH41tOx+AxWBf8LXiYWSsgX9PBGSiO6MXSWERQCwVp5ymTj8M4oTg9kmA+MCl/l1IQOjP/8BSCPB+o/V+mApV+9RpsTx/Ee0nuvaMF3RU80ThEV5B65muouUUX6BTaoTGWHlqFMxwvS8bLPdX6fYuNDnEuG9/kN/tomo1OAQn+i6FbKuyBAFYysrMZ/96zNgYQKMI/uog9OcNFJXCJTDSZs4TN6TN8+VFfIIxq2nrPZwLV4QeFDb+4bKTRletswd1Lom6fgK5zktU3RtT4CNWCQykUyL5pPndCbq5spxZLqOMRLoArz55bg==
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 02:32:11 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:330:cafe::c2) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Wed, 9 Aug 2023 02:32:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42 via Frontend Transport; Wed, 9 Aug 2023 02:32:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 19:31:56 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 19:31:55 -0700
Message-ID: <18ed929a-ab19-4bcc-a871-1c74c8b2d559@nvidia.com>
Date:   Tue, 8 Aug 2023 19:31:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: FOLL_LONGTERM need to be updated to 0x100
To:     Ayush Jain <ayush.jain3@amd.com>, <jglisse@redhat.com>,
        <akpm@linux-foundation.org>, <shuah@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bharata@amd.com>,
        <kalpana.shetty@amd.com>, <santosh.shukla@amd.com>,
        Raghavendra K T <raghavendra.kt@amd.com>
References: <20230808124347.79163-1-ayush.jain3@amd.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20230808124347.79163-1-ayush.jain3@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: add18a82-8714-4d9f-3cd7-08db9880d5a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VSw6RD9EogtyoJo98njNaJod3L0uUHSCYsWW15ZieuJIxAAB/bc/I+0XJuOTqtoEVX8VoyIg2yVFBoI2XXLr9f4w+TqVfGpvpq6wGKD5uUCgL/H8Nb/Hkg9MnGRqw7IiC0/a8LqU1mqjrCq8tuRmi1NSju1xx0AaYNJyTDCe/8tuxZW93XHPdiQLUa5jYEqLIM0PrBy5HJPXo9rrbujUwUXcY0GNpeTfpiVgr3YQItq1on1ozjQr14NFnPCXnl9CYViZqMNQaX8jImqKhIIsvURiOII8nljVg8usuCUqc14VatfTEm4dWrZX2U9YaijXUwq8HxAtWud1TtjrPx98i51JAdZzZ6OyyXfaX4iNs/r4wTgfMPz/gr5bya+Q1hAeGqKGlfsArrS5O+FdyjwO3UeQ9WUWToGPwa2C/g5waV0RUwETF+a2NPNI59jfG+b+ecz7kQFaSZa4fqFXf++DuZGg4xuP950HoGOJwF2aN5qsUtVN98ETfr8lgxcGB2RWnOXGWpvR6e6xERAtat0N9XcWmvKuEhyJf0nnThYoE9F3q7mk9GexIISzUhLTPm2pPsvodc8FqhQwGrk2ARpq2r7imzkW/8tAuvtfmUkyQGPR7gaCCk1st1w5twttBn/QNv8IR9ea/uxGzmaIYV5itS4uH5Eo0t30zEfmuRQNfAF2umH/HRLJr+NWMK+r691/0SWPSUr3XoLl0jsDd9OgK+28nfoIPJdCfXqKVmnC/5a0TQpWUvW30wMWrvOmLTNozFCWRYy/lid2hrAdKA6FUA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400008)(1800799006)(186006)(451199021)(40470700004)(36840700001)(46966006)(4744005)(2906002)(40480700001)(47076005)(426003)(40460700003)(41300700001)(5660300002)(8676002)(8936002)(7416002)(36756003)(31696002)(36860700001)(86362001)(54906003)(31686004)(110136005)(7636003)(16526019)(356005)(336012)(478600001)(82740400003)(26005)(53546011)(16576012)(316002)(4326008)(70586007)(70206006)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 02:32:10.8778
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: add18a82-8714-4d9f-3cd7-08db9880d5a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/8/23 05:43, Ayush Jain wrote:
...
> diff --git a/tools/testing/selftests/mm/hmm-tests.c b/tools/testing/selftests/mm/hmm-tests.c
> index 4adaad1b822f..20294553a5dd 100644
> --- a/tools/testing/selftests/mm/hmm-tests.c
> +++ b/tools/testing/selftests/mm/hmm-tests.c
> @@ -57,9 +57,14 @@ enum {
>   
>   #define ALIGN(x, a) (((x) + (a - 1)) & (~((a) - 1)))
>   /* Just the flags we need, copied from mm.h: */
> +
> +#ifndef FOLL_WRITE
>   #define FOLL_WRITE	0x01	/* check pte is writable */
> -#define FOLL_LONGTERM   0x10000 /* mapping lifetime is indefinite */
> +#endif
>   
> +#ifndef FOLL_LONGTERM
> +#define FOLL_LONGTERM   0x100 /* mapping lifetime is indefinite */
> +#endif
>   FIXTURE(hmm)
>   {
>   	int		fd;


Yes, it's unfortunate that this selftest framework prevents easily
including those FOLL_* flags directly.

Anyway, thanks for fixing this,

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA

