Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A532720BE4
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 00:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbjFBWZG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 18:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjFBWY6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 18:24:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB1F1BB;
        Fri,  2 Jun 2023 15:24:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eS/xG6uCwOSBHlL/rO863TL7nVsdEhMkwZ1Dm0h4F1R0qhHiFW+9Cn31dvz6VssUAG4wVulkDzoJYdKz3vB1wxATXW6hMR+El2Qv0jOJ4cxpbwE85L226TpYSjVrYw07Tb9G7yc5wUhky54vXcyE/9Uc8Om/ZdABGHzA8Rthhd/zgiB2vVrDy/2LugQYd8zn/T8J9TaiJShHY2vhTqyykpywN4B5FMQJd+2WLXpgLxmwix6TsjqEf2wOnIP1/DjKQIBCAI7m60llM6kSOiQKgOKxzlodo56rVbp6EHDxbJvk5Jqm4tOQrf0B1gbejnwQBCAq1BEjacBqKGV39YvesA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K7+TFROStD6vDzWJpNvstoLL93MoarxkLkKODbR8BPU=;
 b=RXfSpd1bDvEgmSMndCbLymYRnRmihTMOKge+hSptECah1NUVcKgtudXcTSrKp70VOfMXtDmub3242pd06JLDzC1gZ6TgTJJqEacI9cQ4nsUcvNErYRI3T3PP88YB0CZJi/sP9YOyY21Z30odMYxRDgMO89bFPJKfJW8lMxpZBl78N0MLstgdTtoWs/1Hfsfnm79XXzNSrk77pi068qoGBHbIIHuAtX/2d8UP1gdi5homkZPmghVF6+E9gUh/+eNhYrqO8N1fwyrcORheAAkQMAlq8SSsbz1whV8EgjdN24Q8b6k9BvWz8vENHesgUzJHlvmEkyZ4sr476Y9bkh889A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=collabora.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K7+TFROStD6vDzWJpNvstoLL93MoarxkLkKODbR8BPU=;
 b=Noo9sKYAMst7g4gcisgfauIK/1M2W6dorTdj82VD+rlqlNtUZ5YMg/SWy9V6GdTduvNRkDVcvW0ZJQKZkbuMdTEatXcWuw8iUOON3o3rcFZTOitoFR5LnkBhYthd+fvsgf59Oq7cH26tbNcQ/WefttjfTw0++5A62q6iZU0A7qno/jxxbSiHehLSewuga5ObpdXmbdiIAirm7PN2Riu5IF6CEWn7ynQ8AQ815YoBcFD6KemAIdmQlvO4xOogPLTgGRlIEgvJ4ipZgOSWaCMQMN/AcwMUBMTWhu5ZbRQvTXeEDrYguiRYe9Y/4xpecY8UtuU3JVD7gAFZEM/mC5JJvg==
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.27; Fri, 2 Jun
 2023 22:24:55 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:41b:cafe::28) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 22:24:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.24 via Frontend Transport; Fri, 2 Jun 2023 22:24:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 15:24:42 -0700
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 15:24:41 -0700
Message-ID: <3300328e-f977-beb5-f373-d0141ef49cf2@nvidia.com>
Date:   Fri, 2 Jun 2023 15:24:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 11/12] selftests/mm: fix missing UFFDIO_CONTINUE_MODE_WP
 and similar build failures
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-12-jhubbard@nvidia.com>
 <bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <bf910fa5-0c96-3707-cce4-5bcc656b6274@collabora.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|MN2PR12MB4437:EE_
X-MS-Office365-Filtering-Correlation-Id: f55cfd21-62ea-403a-d3c8-08db63b83020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iYeuq6bLsLJDy3gAwvxK9wAXNYlfINuGp9LLmypzgVdA+aSCjGdNOH9govWFumE4mrU+iGcl0ZW8uVwp4/u62s0qghLR4wzs44ayZyFEhFaLT9Kl/XbHD68GmhpRq6cGiEAhXG0cYRwpp+ERUwN3c5YdYpyvZXwxcj/OETh2Unb+69sYetZvax6t4v35/QhZ1gmuGPz/ZaTysn9Nvo1n7Dx0bAZGHC+DAfkmFLwvsKZPvTzCeoa8ZdH6Hx0sm4tn0HGSi1ePtJfvmFiVEWXwtk9CJs4+jPLtwcMd5Mb3RQoQgenxLSlSfBtV51WMoIJwkuvRXjpWtl73DYfwMmuyFpItfB5k40HaCZrKdwtGFM5NvjYqDP8lj4ljHu/oQOfSmRGdLRL3MWMMkkPsDwQGzmocQNX2wmac9JNEB0YJBk4dtxWmF42vcNMpCFDhFEJpvB0aT1Au3BJg0pOLSooGPe/aid08traW8ripjgbfEGKcKvK/OjFiQVnn54XDuxPm7aSzfFzd12ypt9zjfDhWJQ7dyxgIe0xTCgWim+YehRAkCDPhDVqg7pMHrcR46bsjp1eTz6JP7uG1mUqYNdaiyT523Kcp5yOy22KZgXIg8K7C+uOSa8YnlBD3wBg9H4sUzHARBKVS/Vam2nqZWZ3k+ea4XC0hqx0QLcM8caOLv29V/gFhsx//Kss7Krg9Y8GQvISsi3hDlv44yGRFXhbYp1hD9KJFTwmny3z1+8lhMcjAYaVGum6kNw9Be71y0Ym+tM1NZ51cQfe2GheyLDSZUQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(31686004)(110136005)(54906003)(16576012)(36756003)(40480700001)(8936002)(8676002)(2906002)(5660300002)(41300700001)(70206006)(70586007)(40460700003)(4326008)(316002)(426003)(336012)(478600001)(82310400005)(31696002)(86362001)(2616005)(356005)(7636003)(16526019)(53546011)(186003)(47076005)(36860700001)(26005)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 22:24:53.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f55cfd21-62ea-403a-d3c8-08db63b83020
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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

On 6/2/23 09:25, Muhammad Usama Anjum wrote:
> On 6/2/23 6:33 AM, John Hubbard wrote:
>> UFFDIO_CONTINUE_MODE_WP, UFFD_FEATURE_WP_UNPOPULATED, USERFAULTFD_IOC,
>> and USERFAULTFD_IOC_NEW are needed lately, but they are not in my host
>> (Arch Linux) distro's userfaultfd.h yet. So put them in here.
> Selftests are never supposed to build with native header files. Build the

Ah yes, I remember that now. Of course, the problem is that few people
know or remember that, and it's undocumented as well.

> headers in kernel source first. Then building the selftests picks up these
> newly built headers by itself. The method to build header files has changed
> to `make headers`. The following command builds the mm selftests
> successfully every time for me.
> 
> make headers && make -C tools/testing/selftests/mm
> 
> Please let me know if this doesn't work for you. I'll try to reproduce and fix.
> 

Yes thanks. That's a pointer to a full solution, which needs to:

a) automatically invoke "make headers", at least for selftests/mm for
now, and

b) Add something to perhaps Documentation/dev-tools/kselftest.rst to
document this requirement.

I'll work on that.

thanks,
-- 
John Hubbard
NVIDIA

