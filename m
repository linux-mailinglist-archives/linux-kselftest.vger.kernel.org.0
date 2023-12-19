Return-Path: <linux-kselftest+bounces-2173-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C82D0817F18
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 01:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532A01F24D39
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 00:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B02620;
	Tue, 19 Dec 2023 00:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="awDnjkzb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B125863AC
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 00:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K9gTIiiG5eaNtpiypYopLf7mOBY+ggoBtBW1pEKOYYBP2FrZvOcFMxjJO+mhgXNIZD1mq1Izg1azX/NmU1kCziWkKBuMreSN4P9omF0OCvE9L/qM660bF4zDpFA9zeEmJeX+x2gaIrjcdNbefbiBbyO4Lx33QfKQAGWe59ShxQRbPLy1XiOdt3L63NUznSjN3RKN8N4aNUoj245p7OGAcFfCkdZIYFTIgS9kmMEYVJaJUQK1Km/0HrPROKLIcNXIDk3HHzR8GFEpmXIKcvTBVhraZe+mksqLjqMTJpsbeAmmBd8CJT+179kOj93szHZkXjRtqKP3J8ddlOl8mBgycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Uy4jeHer/VGh0uS36ZXUQfs5QCoK4AmPyey/aZ06tI=;
 b=GzDLlT6tPAEBjsfmbe0UXs9UPnRQuJIcRCcMw0fn5PRR+D9Ud3ma+aoarwaB/S5BNLuA58gOTMs2r+Ku6irGM9DhiCTYrSuL6bBl9Lpl/eW6iE37En3RwhYBvpwPLVrk3z04XvHwGdUQYIWvekIYBeFXPT4cHAywiSNOHY2tfsB5hrdmttGUMGLwEOYkMx5FdmjD+TUF//I1mhfMbmbQzxqvceKEuRysUAsRTsw1t7j6eZBJQGEc/JxdCIFMvb5/9CBbOMxSS29oHV4xTwAtR7VSSdhgUn1ceqI4tvi2qKadimcR0iXuZ5QaNB30B2zM1WCFLDsRvckQhQx/R1hssw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Uy4jeHer/VGh0uS36ZXUQfs5QCoK4AmPyey/aZ06tI=;
 b=awDnjkzbKly/n1wXbL9QpIjeVTw5a+ynyRwgD4UscwRct6FivSt/xqgATve2fQmdJxPyH93ZOO5yfLG1FRLaHE7ETsYGVarDmrx2gAJNsJSVq43WXKh1PVAWno6TYggcTVhm9HwFrEaibITmHkmbcasTQ5A/gGN20agC7IhoFa2DIZ3+cim4xlJbrFMgI8H98OFGN7k/R1fVFvJOuYPJcDgbxD3sA71hMv2cLv7Lw+jAsGV8wUxlvQijMI8whgboh2aCdMdZTvcxCkFp2y7mgsbvFA07OxH4PsSJ86DKTH2OB2UZhSJT6+43Gv7Tr8Wp3kKreBuhXq93M1HO/mqRuA==
Received: from BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::28)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 00:55:24 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:32c:cafe::cd) by BLAP220CA0023.outlook.office365.com
 (2603:10b6:208:32c::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 00:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 00:55:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 16:55:07 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 16:55:06 -0800
Message-ID: <cbcdce88-def8-49e2-aad4-d510fb82208f@nvidia.com>
Date: Mon, 18 Dec 2023 16:55:01 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Mark Brown <broonie@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>, Aishwarya TCV <Aishwarya.TCV@arm.com>,
	<linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
References: <20231214162434.3580009-1-ryan.roberts@arm.com>
 <e2296501-e9c9-4bc6-88ba-1e43ea083d4a@sirena.org.uk>
 <71228821-cbd3-4a3c-9ed5-18f6d5ebcfc0@arm.com>
 <07193932-941d-46f6-b152-d6c5fe09b26b@sirena.org.uk>
 <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
 <d99367ef-72e0-48ad-ba83-45e25efdf0fc@nvidia.com>
 <fb91ab59-ab5c-45c4-a413-bd6c060bfcc8@nvidia.com>
 <c417dabb-d7f5-4757-be4f-26b15c3f2fd2@arm.com>
 <7663374f-ed7e-4d86-a07f-e71c6bcef841@nvidia.com>
In-Reply-To: <7663374f-ed7e-4d86-a07f-e71c6bcef841@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4b60ff-8fc7-4e57-50e3-08dc002d2f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AwOUNTSoUm7ZuxPHj5eYxM/HVD3T+vvfogbdF5kov5YXCdTgSbaPKR0ikfG8Fdy9CDv0KHe5TWXNHuhor9Ka+Vm0PYHEEXvfQZvZeST6vMppJVWUh5ONktBwbMzUPRHIMCRpvLZ60H7UUXH9D+2ozIfDfASU/a+un2qBkPoNORIj7gG8Oe80DQce8xrJS8zPOsWu+2JIODOIP+zjcIedGZYspV3M9HkWWGYWVfwHJddJoscenAOuXOjvw2BCRrzeLJwbuh3Lm/OGnwS1cioOJ//cGzfOdnP6V92rLqAVJSjhX2Em0CPWsNe8OJY0nGc69OOTxoX4hHNnkdNZSvUgN3AKpFtdcutPZr+QsAzvwxtQnj5WE3qNPEiPN9V2Ub/WNP9L2Aj2wa8aQ8fPo5/49p86DrofRD4nq3evIxTO/LPhrybE9tHKrzRO7/Ng0oQ7chIK2kO7KU+bjfPJEqQuyVPdAnmP1zXx387C3S/inTkydnsHL5ckfCMzkRGHZ0ed6nViVzreIFu4meN/P+Yr59lnmVWZsZsYaLDDUsDrYlmPOwTaTEIuz3o35bfxlEvAd2r86gyRk5yjL8t92A8V6yQXCWnnpTs9eHIwFcHZEprY8tztT2Eyz60iEoYxczTmHTWih6s4GYYvam4EoDR5bUVuLUNillZaOskLCziSbCj1r+lSBekQwBMveSCF7UCOjfSUHC4ziSBCUyyS1szwdNdpazgtWZK+33jzcMtR6a9UYwO/4hLf1KRY8hHH/YhA7Nw5JXUqjuCqLRJg3LTYyg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(66899024)(31696002)(41300700001)(36756003)(86362001)(356005)(82740400003)(7636003)(16526019)(336012)(426003)(26005)(40480700001)(54906003)(2616005)(36860700001)(70206006)(16576012)(70586007)(110136005)(478600001)(53546011)(31686004)(40460700003)(6666004)(4326008)(8936002)(8676002)(316002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 00:55:24.3485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4b60ff-8fc7-4e57-50e3-08dc002d2f38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798

On 12/18/23 16:51, John Hubbard wrote:
> On 12/18/23 03:32, Ryan Roberts wrote:
> ...
>>> I should also point out that some of the subtests already attempt a TAP
>>> output. So now we end up with TAP-within-TAP output for those programs.
>>
>> It's actually TAP-in-TAP-in-TAP if you're running from run_kselftest.sh :)
>>
>>>
>>> For example:
>>>      # -----------------------
>>>      # running ./madv_populate
>>>      # -----------------------
>>>      # TAP version 13
>>>      # 1..21
>>>      # # [RUN] test_prot_read
>>>      # ok 1 MADV_POPULATE_READ with PROT_READ
>>>      # ok 2 MADV_POPULATE_WRITE with PROT_READ
>>>      # # [RUN] test_prot_write
>>>      # ok 3 MADV_POPULATE_READ with PROT_WRITE
>>>      ...etc...
>>>
>>> Note the double level of leading '#' characters.
>>>
>>> Again, this is still readable enough for humans. But it should probably
>>> be removed in subsequent patches to the subtests.
>>
>> I personally don't agree with this. It would be difficult to flatten to a single
>> TAP instance because the top level doesn't have a clue how many test cases the
> 
> That's not quite what I had in mind...
> 
>> child is running. Trying to do this will make things more fragile and less
>> modular. LAVA can certainly deal with nested test cases and correctly parses
>> everything to test case names that contain the test name at each level of
>> nesting. The thing I was trying to solve with this patch was that previously the
>> top level (run_kselftest.sh) and the bottom level (individual mm test binaries)
>> were using TAP, but the middle level (run_vmtests.sh) wasn't, and this was
>> confusing the LAVA parser.
>>
> 
> I was thinking more along these lines:
> 
> a) For the individual programs (binaries), there is actually neither need nor
> desire to create TAP output at that level, because frameworks like LAVA only
> care about running a lot of tests and parsing the output.
> 
> b) Therefore, just stop specifying TAP output at the leaf level, and let
> run_vmtests.sh and run_kselftest.sh do it.
> 
> Looking at madv_populate.c, I see that it scatters calls to ksft_*() around.
> And I was thinking that this is all just redundant, isn't it?
> 

Although I suppose that the counter argument is that the subtests in
madv_populate.c really *do* want to be specifically printed in TAP
format.

arggh, I guess this is just not worth fooling around with after all.
  

thanks,
-- 
John Hubbard
NVIDIA


