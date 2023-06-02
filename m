Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABFD572089B
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Jun 2023 19:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236678AbjFBRvo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 2 Jun 2023 13:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjFBRvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 2 Jun 2023 13:51:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DA1A8;
        Fri,  2 Jun 2023 10:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n2eoj55633ReNzJe0eQ4GPWiAYD5uIeA1arVHcxPqj5MPA2JDWQKD3H9tzXnXu63XHWBGTx/24/ctzzHUpNoctnGgMzoQwKJvexrGyeDyI8KrCbOAGsTn4VWouY8wNXy1apBPM+9FFco9G7Qg+rLjIsoBGQ/HovmuXZwBT4pD2zc6oOPn14PGwr3hYBPjGNbQ2/QRjwGWVxCdTIs3RUlPeODkkJUtlw4kyesL/B44Ci+w0BXQGSbbh/PYWxFeoGtzDcVVBlnHpsUsai/cswBtB65Gr0bVqHONanXI2HZ0uB1/4ZFE+kNMUD59Oo5lKqpygKuvPPNdvmneEibs/4bxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArlhBNWfrfYLvdDT6FH5+CuEOoZGmmwVcCeIvrcZbH8=;
 b=kT+3IC+FliQWe8HgzIvFJn+xZvFakGQg2MjmyHWpc6eoVGsMHREGZbOCdgxy++klAF1covrFWh2OWRdV9bisHCUrAFIsVFa3mbkjC8p3KOKr2rlDb0FalImthP70ynUi+ISnRinPlKeksnUqyD1sRfjSmx+A1D3CKvTOr+eqatzjn9MP1QDlfGpbXhsigefa4mOloYAU0Sizq4bALy33ZLlPfnPmt7q9cqXDpAFAUwIy3N78oDa52HJNUpJdKsg+a4bm7BbHSPM88TT/UjRDucV+2BTOcDchXX/5HdbXcSGdh7L2i5EiGJeQo0bA25XQuBnus2h5sG+F+3/rqkZXQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArlhBNWfrfYLvdDT6FH5+CuEOoZGmmwVcCeIvrcZbH8=;
 b=UpXZ901Urg5Sq8tZfwKuYFuSHWSTwigOYE3UjFbGqzwR38WNxr33VRn1rh4qB6OAUhjBVxgRAXH4c+hlZktag7zDLJsnatlfM71+8WWxim1LKP5SZjtlLMFklcLVFznsADnogR2/iCqTZ7VZACGtA9B5Qsx2PaZM1RqApJAyVE9AW/7w8+wVXz/5HGS60Apii6zwWp3xMtY3xML8KdYbaDcJ8e9xuFfaJ+aBG4BgJ/WyqhUPS/6XjK0ufjSUnKSM6Ro4KzsapseddRpiL/QPjn6nStpfp3FNruW1029I1gaQ67vwsLMLSUSpUebD0EkzO6STs5Kdta31+dlv9jYgbw==
Received: from CYXPR02CA0029.namprd02.prod.outlook.com (2603:10b6:930:cc::27)
 by DM4PR12MB5747.namprd12.prod.outlook.com (2603:10b6:8:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Fri, 2 Jun
 2023 17:51:39 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:cc:cafe::4d) by CYXPR02CA0029.outlook.office365.com
 (2603:10b6:930:cc::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 2 Jun 2023 17:51:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.18 via Frontend Transport; Fri, 2 Jun 2023 17:51:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 2 Jun 2023
 10:51:22 -0700
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 2 Jun 2023
 10:51:21 -0700
Message-ID: <2a826310-f948-66a7-2003-dcbf36e16caf@nvidia.com>
Date:   Fri, 2 Jun 2023 10:51:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 00/12] A minor flurry of selftest/mm fixes
To:     David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        "Nathan Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <78c0b444-8a95-396e-5f5e-8175f94a49cc@redhat.com>
Content-Language: en-US
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <78c0b444-8a95-396e-5f5e-8175f94a49cc@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|DM4PR12MB5747:EE_
X-MS-Office365-Filtering-Correlation-Id: aee756e1-1af3-4899-1301-08db6392047e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dm2nSvV9bJQBcOpP0YpoaRNFs/YJvHL95jrlI547bhEzJF9VAeI7eM95HlDt+XctkEH6OMzGqA3B5T7sxypIh4ErefTj+XseE4g1a4pvdwFvtvkezaeDbUbMMHzvcPN5anDp8RZheKDhs62Rv28B/v/fooCXyWYJFzvpkK5WsStlVkzH3Vq9KX0Ydq5XPSV32MRjbw2Bw+V5Ldg0hVARIvdlIYEaSMGtn7MZpbR8C4sisCFLQN1Np0RcE9KuMoyqSHmp372m3V1rD28qLD0FSe0WYO4PcQ0Air/C2sB0urx2yCgI/6EWKD9drK/DeDv7r6SA3j0wTOuV1EO8hjUjOfmiQA/dZhtk0gZTmds9N1ZFcpE1v3pv+wJIQyg+wHN/5gFIVPncY55Mz0mV+EzNKrxHwvBB6N4yLF+wCmyptKnHPwlJKbFenAtDw2O1d9Dm4HiepAuk3AtqUdrllPSsvkxqnM6jhyitroPFT3/2ybhzjhOnQlJbObyr1kDm91FevWar2qk1uenNcfFzLjxGUHX8RLheX78uMjREMfdwi5Q3zurNXCk5CITJsxh2oRwT3tvG1axPqyRlh7OfzteaK8h3ppKja6cUcXvpLz/NqD5JK+0fvtTRngRNTEAAmin3XewgrOo9mbuA6yuipZxAEBvGQV/KPwPzfpS9f+fV3fOt1YUqnlr3zyrkJi9AA+G5WTfTWZY0iYtqfeD/yv2xMabRX9c7Mxmjs+bkcD11NUBQaRfpjrviQI7IklheeT2WnQaMO1LEjPLOWCMSgLQcPA==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(31696002)(36860700001)(2616005)(426003)(356005)(86362001)(336012)(26005)(40460700003)(83380400001)(7636003)(40480700001)(47076005)(4326008)(316002)(70206006)(8936002)(41300700001)(16526019)(8676002)(70586007)(36756003)(186003)(16576012)(478600001)(53546011)(110136005)(54906003)(82740400003)(5660300002)(82310400005)(31686004)(2906002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 17:51:39.3709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aee756e1-1af3-4899-1301-08db6392047e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5747
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

On 6/2/23 02:32, David Hildenbrand wrote:
> On 02.06.23 03:33, John Hubbard wrote:
>> It turned out that an even dozen patches were required in order to get the
>> selftests building cleanly, and all running, once again. I made it worse on
>> myself by insisting on using clang, which seems to uncover a few more warnings
>> than gcc these days.
>>
>> So I still haven't gotten to my original goal of running a new HMM test that
>> Alistair handed me (it's not here yet), but at least this fixes everything I ran
>> into just now.
> 
> Thanks, now I can stop commenting out some (IIRC primarily uffd-related) tests when just wanting to run some specific tests on some of odd installations :D

aha! :)

> 
> I assume this round you only consideres 64bit builds, right? My last attempts with 32bit revealed a lot of issues, and I only fixed what I really wanted to test (COW).
> 

Yes, that's correct. I only tested on 64-bit. I've drifted into a
"32 bit is mostly just for embedded systems" sort of mindset lately,
and don't have anything set up for testing those locally.


thanks,
-- 
John Hubbard
NVIDIA

