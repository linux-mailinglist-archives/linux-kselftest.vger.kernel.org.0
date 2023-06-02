Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5857720B4D
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235208AbjFBV7E (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjFBV7D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 17:59:03 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625A51A5;
        Fri,  2 Jun 2023 14:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2c1GIhYHxp9rCvNNxjQaOk6Z12jhXkC74elbzeNx4s2e/geM28uhaQTrqbmjSjpfCQpmHSOKxu9BTHdtlt5QDAgeobLOZEZXThHHrTMeUskHw3daLSHJfX8jivjTOdu0w7MalqRorPmCsUbTJgt0K0dlU84Wwl5b6Fd26H1HNKIG3PM/Xnhjv74rXW8X3wKqtkNt7pMQvd/YVppE+UqQpyUZRIJPhiSyer/oeTgqeR0oOs0Pfk6bwLQXXOxfeS1Z2dzaWpENdrj/pISLsrYB4mHPTH/PYC8/J0hyJ4Psvu4fecUUPfxXglEfdEcM2Z+gYhYVLh8qDlmmdj3TwW2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11c7+tKWhd8/Fv/phZfjhUy6nyDLC+Q7uB90UecJnFs=;
 b=OnfGeJuqwcOkCfykdGxyHV129DG13vRJb3r92vOP7HaBV5rGV16Kjy/6IfQ1yS4O2A0YTqx3/EtwZgzxn79Iu8Fa13JTp84V4NsUKywBg7QHI9jLbZU7YXVjnDO3xDMTNN2FZf7lBdSEBHIjZks350rDGIl8mcz/G73tH7PNMC4pVwdShWgp6em/pZIMzQuYY2LclQWOeC+uj5b63VObukAN48nRk/SCgmXsXBvNj7A+smurjEV5i0R5sngtlB2OPgwugwbt6vBRu+oN87Rf4cfh2oM3Yc1ZCBPx2HNDDa64Zi2KyJadISZz67p5XpLVIQ+2NljpyeHxvD5WxTejtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11c7+tKWhd8/Fv/phZfjhUy6nyDLC+Q7uB90UecJnFs=;
 b=T2OjdZdSLLlFOKW6z2ZYZNlz9FEZIm2mYwsBcGUF9JpZwjeoSRSy/+Lx/xfA0INyc9J3GiTAM6CxRMg6rnVOjOaWeTbPvc+Y7i9ubLBycEAoCpwguRjIwQsqQhyitjj+pKphRKpX4ZzH9FXFNifGm1FMQ2veYtkgIAQC6KGSlIhlKCe9o1XjOj1FybtEXFbEDxrXwoK9I+xnkDRfMQWUvmfR1v9UwsM4GmBlTuuj60q95GoBOtv5N42tj2C7kr4wZzmwRIUSkFZU4oJkivmluOvRc4yb8dbhaG8f4U5vZTeYcCLZzvPYgOyGEVdiGvFvSljmURRpn9bIKgTDUzG69A==
Received: from BN9PR03CA0636.namprd03.prod.outlook.com (2603:10b6:408:13b::11)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.24; Fri, 2 Jun
 2023 21:59:00 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b3) by BN9PR03CA0636.outlook.office365.com
 (2603:10b6:408:13b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 21:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.28 via Frontend Transport; Fri, 2 Jun 2023 21:59:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 14:58:51 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 14:58:51 -0700
Message-ID: <bd676097-e4d6-10bc-4ef7-47c939c8cb50@nvidia.com>
Date:   Fri, 2 Jun 2023 14:58:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 09/12] selftests/mm: move psize(), pshift() into
 vm_utils.c
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-10-jhubbard@nvidia.com>
 <0a838454-90d0-9d85-fc2c-8c2571240fb5@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <0a838454-90d0-9d85-fc2c-8c2571240fb5@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d730d5-82d8-4f6b-5640-08db63b49266
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHZPnUWHtrdtQJ6dZS3spGLXnhTY8bShW4wR1S9o1rk5U4Mdy7wqMo5cM00KC6ILH7FRtGzX2BrVtcX4N/IlEr64Kn1HpaaAWob59ebKxsRuJleD0+IFlFDtRF0qMA1wi3A54I1UKUlAhfnH1dlpXrGerZmQUQPRvV2IdpwSeSRdk1dff/JZSjzkS/zAawLIZrHnBWrZwBJ4oDVtZFdfnzT8WZTnWDwZxAS7G3JM8/ysbebqhkvpm1+9mKT0xpU6e5+avor8VCnPkTrP170y9dtUQ5xU/uuQrknbOj4FD8sRzbUlCGGPUCKLN/2NUwROx7snMvFRZnnxJefXyj9ApC+5sNQJQq9HSzoXpUP1bIxnUZR5J0QnpXZfy1+IMTBimrJ5PgyqIuwJkQuccUdAVbt1XV1tKVYAypVHp20n7Mkh/Onf0rHEnUs46MePlZGmlMMJmDfoPjwtpIVT2PcSqEPYRL1YR9zbwlz5Zp/g7js5WUr2DfCed0EwmNvt4yF5vIZfaIia+qivtl65Gip25H1sOSvgzFr3iOvq2EhPNcHIeCQ5XGYdhlTe1PHgNdGE+HxNgVQAeV7W0LemqoHcd85/KWlbp6R/42j1eDDIG6Q3eWhXHqrAXzvgQhfAiBa5BTyI+vqwYYmjJoHG4A/avTp7zeoVSHjgryO4JevozuC31P+2KOzOEk6AJ+EZjlU8PwZzfI3JF82nZpPP4GYzbHopEXdpsHxMrSQ1wMYrpsg5Fsc6yNqrkxuGaQeXwaeN1VKG9l574UWIxLiejJn01w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(53546011)(26005)(186003)(16526019)(316002)(36860700001)(47076005)(83380400001)(2616005)(41300700001)(426003)(336012)(2906002)(8676002)(5660300002)(8936002)(70586007)(16576012)(70206006)(110136005)(40480700001)(86362001)(36756003)(478600001)(54906003)(31696002)(4326008)(82740400003)(356005)(7636003)(82310400005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 21:59:00.2469
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d730d5-82d8-4f6b-5640-08db63b49266
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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

On 6/2/23 03:19, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
>> This is in preparation for linking test programs with both vm_utils.c
>> and uffd-common.c. The static inline routines would prevent that, and
>> there is no particular need for inlining here, so turn these into normal
>> functions that are more flexible to build and link.
> 
> I'm probably missing something important, but isn't it the most common thing to use "static inline" across multiple objects that we then link?

Yes, absolutely. I've just had my confidence in things shaken by some
of the quirks in the selftests framework, but you're right.

> 
> Hope you can enlighten me what the real issue here is.
> 

At this point it looks like a header file inclusion mess. As usual,
including header files from other header files leads to problems,
and in this case I'm now seeing vm_utils.h included from uffd-common.h,
causing multiple definitions of these static inline functions.

If I try to undo that it generates a boatload of new errors, so I'm
thinking to just change the commit message to explain that I'm moving
this to a normal function in order to avoid the above situation.

thanks,
-- 
John Hubbard
NVIDIA

