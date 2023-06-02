Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0F3720BD7
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 00:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjFBWVF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 18:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjFBWVE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 18:21:04 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30021BB;
        Fri,  2 Jun 2023 15:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXSniAdfFm2BZG1XEROk+sO4r2aw+5mWfdPCh/kfB6vRpQDnEqQevI19qijSc7LiAdII37SlbmP7+zAmE1hhWLDSVFk3D5wb+Ri2cBKJgSiwjibyullnDK3Zmfzunx4c7OosUB1v6byx4Wic6iTdKa48Lrpk8Ttzsx6SrMumT1vbKmurc7aTzWBlZGkdStUj8zYiYinn2Ot9lN+Q+S0qytvgdm9F8Ik7p3i7awD4+lZt3Q3jYo15EACNttqADB6f/zvMqBCbucAB/EP18s+gtAUCs8+NEnlIWvJVWl1MavwFFykSjbprLjUnjBI9B7hARVH+yw8ovpaXhVY/6kiCnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bO7y+xUB0Lmsf6mEEOg36K8KO0JvE2WxboPiOsYSMoI=;
 b=GY2tzTL1TKP6mfcG/ch44a6eEfKrhEMKk4dbp/egsyXy5hscF0ZDCl/dQwPL/tyl2eRdk0ilgdVqNmQoim5sscSedPTMqwaSGKWLV5+UO2IIQ2mXYODrEYwt9ixwHTn3C+BJWaO0ymIhpnmv+2gLI7ZDIeTAD0+qRU+yNnqD+gZiHcGCIeOQBWBQtMdYLkBWe4ISwHi9RuGUmP7wB2cz/VPbAXdOoG0D6wA31q6JHZWQzrRdDe/d0fei688LijbY0WtuHzg6fwiAwzSEPbLdoqXHw74zZR5bI4+vW4tUJwlNrJC2/cRH0u2TyEu4wYplFMsse0DTu4lWxF6B6PSMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO7y+xUB0Lmsf6mEEOg36K8KO0JvE2WxboPiOsYSMoI=;
 b=jFEbEzaZwVRe2KFzNhnJCDCFCNLy9mBp6Xf4NdWIEMpePUPxnQcB4YY5RXOb6Ev8HSyce9KDmDSvahnzHb6I1pdhfW6iFl6IHVkoDTT93y68pdes+4xnkarjNq3geZSK3ll/SIrE1AJOB09RON3kaCx8ByRd63CFmcryGTLzWBrEHWWZjb8OlAZMklBjnpVCb7v9ziWKcF4GTpiDOdwpleCvnJruOPWaeA6/Vn1cUCIO6b+dlgmR9v3k3dt6qaiE87ijfgmXC4r00W4TVjTFtJS6qrdiDDYYxHcKvCkZU1fCZ33gkmJa5ElmWHwDYFDNfqUZzuaAvd26ThCncmIZsg==
Received: from BN0PR10CA0010.namprd10.prod.outlook.com (2603:10b6:408:143::14)
 by DM6PR12MB5024.namprd12.prod.outlook.com (2603:10b6:5:20a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 22:20:59 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::84) by BN0PR10CA0010.outlook.office365.com
 (2603:10b6:408:143::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 22:20:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.26 via Frontend Transport; Fri, 2 Jun 2023 22:20:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 15:20:42 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 15:20:41 -0700
Message-ID: <993773ab-7f5b-241f-b532-ee79a03b371f@nvidia.com>
Date:   Fri, 2 Jun 2023 15:20:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
 <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <7a999b80-e266-2b7e-f198-869b1ac7cde7@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DM6PR12MB5024:EE_
X-MS-Office365-Filtering-Correlation-Id: f55f774e-6083-43a2-80e3-08db63b7a491
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdsXCTUYxvEpFuGItO5SHaaUAQxh9WXBC+64hEi2rxE/366x3hddKot5bmqvTYjTs5SD9G9uSqqAp4iwljqCEAUIqIG/jWv5OQvmoiy5lH9SopFAz68FcijGcj/SnmtgX9uEVyb1iG0bmIuDuV98AR8f4iGJ4pOevEiC+FCDEKdRR4egidOpS7LNmPFEv10lo9PfTkM1BDBKAFEEwBj88+mX/visRbuYa0GfSKmC1myxg7bm9DbZRMx/C5ib89qXlYEZYDWGDVrjtRry5SKUMs69M1T8bq38eA+7FrQhrNo6A4ASrB6XTMKFg+s3qig040pfUYdjpvR5qmtXTreuHUDpie4oF2C1DC5BKyD7/SrTtUh2pXXoGzQbunlLiPfsn9BZ2lbOVLM85do16RNT04Km0DmWuR4YW3JfmTytDAm+zXRuYmYHAYSSYKYhtMzUbQDqdXiYDQ3cqW35yQOF/er51sBtEGf4VeUYEpVFKwnW1oI7so7XK//lv/UmTzE3Ug5VKJ7XV6b1w5ygb8Z5U3UqDTHfqYXenacH7lCv3REIvzDrwSsmnRuqgQyBs6o1lOikghsIh9zOHgFP1hBPwoZekVoC9NSeIQTDllhyfK0CAP/sNNOxeyYoKiA7M/in3ptFndwUwg1SAG9YH8xu8deIdELPZc/Vk1V0ZGkf9AHsj4zE7l5suYuVsvpdMbJqNWrlf8nmPPMAVRwUdaBfMO9uTtMXW567McZatoLZMGpR4uG2mffuKUstzZkcJZg9IvIet9V/c3tbbh3MmCjv8w==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2616005)(36860700001)(426003)(47076005)(36756003)(336012)(53546011)(16526019)(40480700001)(186003)(40460700003)(26005)(82310400005)(2906002)(4744005)(16576012)(54906003)(110136005)(316002)(31696002)(5660300002)(31686004)(41300700001)(86362001)(70206006)(70586007)(4326008)(82740400003)(356005)(7636003)(8936002)(8676002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:20:59.2190
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55f774e-6083-43a2-80e3-08db63b7a491
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5024
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

On 6/2/23 03:23, David Hildenbrand wrote:
...
> Unfortunately, that seems to be the ugly way to handle this because
> including the in-tree headers seems to not work and I yet haven't
> figured out why (there were some changes back and forth so I lost track).

Yes, ugly, and based on Muhammad's response, I plan on dropping this patch
entirely, in fact.

> 
> CFLAGS = -Wall -I $(top_srcdir) -I $(top_srcdir)/tools/include/uapi $(EXTRA_CFLAGS) $(KHDR_INCLUDES)
> 
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 

thanks,
-- 
John Hubbard
NVIDIA

