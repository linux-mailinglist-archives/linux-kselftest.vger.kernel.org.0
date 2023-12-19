Return-Path: <linux-kselftest+bounces-2172-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F6D817F0F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 01:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6D091F246BA
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Dec 2023 00:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AC615C4;
	Tue, 19 Dec 2023 00:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oweqjOaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBCCBE74
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Dec 2023 00:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuhwP4yNwh1lQB0PO1zyv8n0GZXGP2x5Zkf9HTytYU+U+c8Sdi3PwK0icuD3iW9B/It+nkfjO19XON3mCrxyxIpT+gQlJX4wMmDvMKzBUbr9NxyguUuGIeNnlUPBa5CnYUSBRVRF1md2f2jFXUVTqTllnbgQDCRpSMIw0lkFcf/qXuwMWQYxn6OsDYsoBoXmrlFd1YhHhjenwJFMjFwLPdsw/sZH2H0vW3LJM8NcOIJSys3f9H7GVgct4mu900scrSUZOsfYwdmnK4r07gz9CIwbw7mIfrXEl4sMuCqkQEp82FhlVwL+vlXcp1oc7Rldeapf2ad1nRzxLXqL5Al8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oC6Caeuv845m0g3tc5WUi05p9NHndlFmGGbmFb+Rg8o=;
 b=bchwjbmNK1JsmfPUnKs85tUDmIifCD9t9te6BmWK0VzXPfMvJ1NNOjWzNvUN+hBFntTNsrulthSrlFdKKr/UE+CZu6BA9HwurnKM8Cjk4iTJi+T16feI8VoDTU4UaZpwHcV9/vYNeYj2CDQSuBRudxxZKtlQJLShjHPuziyygImvPm4bBab7gwEMAYez+gvYx+XoneFGp3Ii12eCBRSn/Xc314SJT5Tb1PI6EQtbxuLIlnkkfdSNePVCKDkFcjnY3nnLi7BIBIH4SbApnPhj8FWxYZ852s0kt7beeK5U850qXzk5tfeId6UzxE2PLW/2Ie7+Zfi+y8h9il7lV9Enlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oC6Caeuv845m0g3tc5WUi05p9NHndlFmGGbmFb+Rg8o=;
 b=oweqjOaqArRkXXrMiE9cgZpf/L/sYqzF6WA9F03C1atmPAKgBDRasYXe57zuuvfxAGppOIoHBt4++P5N0e3i5YoxOPIyQqZJEuEUgTs4VTFQfPOMpPnyVUtJkRZnKsBGwYmDhp3nF3SMkzOGgFxmwiRc65CsE5YfenLTZbf/8JZ3abC6tSsAnm61PRHQrdX3p0g2V+Dantt4ProRcpp6jrhg2/VGIxHHntSBUBjqbTt8W0pCUZ28fybFbolrZbnIE9pAz2oK7CnV+KTgLHPvqCB/iLCFJxgdrH/PVA3/l78iwVTeQmCL8MjXh0TlMoRI7CcP2ypGjT4qTVQdCM7Xaw==
Received: from DM6PR18CA0016.namprd18.prod.outlook.com (2603:10b6:5:15b::29)
 by SJ2PR12MB7799.namprd12.prod.outlook.com (2603:10b6:a03:4d3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 00:51:33 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::63) by DM6PR18CA0016.outlook.office365.com
 (2603:10b6:5:15b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 00:51:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 00:51:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 16:51:17 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 18 Dec
 2023 16:51:16 -0800
Message-ID: <7663374f-ed7e-4d86-a07f-e71c6bcef841@nvidia.com>
Date: Mon, 18 Dec 2023 16:51:16 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] selftests/mm: Log run_vmtests.sh results in TAP format
Content-Language: en-US
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
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <c417dabb-d7f5-4757-be4f-26b15c3f2fd2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB7799:EE_
X-MS-Office365-Filtering-Correlation-Id: b1c0d81b-eac6-4d74-7b0e-08dc002ca51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2w6gQbpr1B6wWxm1ZEDsTy9MGQ08zvxZhI64orDbwWSr2+iRyc3SYkPuPI7hQd/sApC/A3q+piNaqlzry1KhXmoqasCxkKgsFbtM1bvN+x5MDYs9T8arAIoaTVQQG9BZrKR7d+70wn5Gsv6jLa4WtyFYQtBU3bKcLv3FW94ugZb519upK/C8Yr7xDJmM2AFHU8TFYr/dR1atMa3qWlSb+URwoTUT4U9VopRZ9c3v+AlsWy/qbva38OT8uKWcobOoE7jEW+IRWYcSp0qxMpkHA9zAM2fwrsOqbhReYnlF4qZ0PajByQTINdsoog5DYWilz+imaMV3o3d0ucxB58j81In9Xc5mxpWt6/zIH62t7uV8vWYDbJBe2tg9DwiPk/CdXWz1qQFlJKyo3asnRXr3C3kcyW7hX3EIZV18BpXZGiPEJv2UV5EGhRvs4AEV8V+80jSY9+WOYmpH1GW1djRuAv37ptHZSA6t2ZuJrATvKzlXvE4oPMBo3BZ+zRCDgaMs/Nq81lgQcswikTf1A0UAu1ech1VVH5zvor+ZUI+7mBw+8WHfIbPI0RxKKeQHxkHM69wM3d8GQCwpFq4iAsXwkGlBJv9Pcty+4zi1Ri2hhTzrbOg72LqitmIHt7cmTCuhju2fK5Z58Y3/wIMecOxpirQEfS6udtx3orkTkJv5MNbOx2cx1UlzHQDr/Ida/cgFAFjcc0XdkV3q+eymxJwhvXexHMMhoKsgca1FcygvEen1uQV4NoMO+Vt07RcFimv9v09bxnd0yZ36Wbqq3Ln3w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(66899024)(31696002)(41300700001)(36756003)(86362001)(356005)(82740400003)(7636003)(16526019)(336012)(426003)(26005)(40480700001)(70586007)(2616005)(36860700001)(70206006)(478600001)(110136005)(54906003)(316002)(16576012)(31686004)(40460700003)(53546011)(4326008)(8676002)(8936002)(47076005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 00:51:32.7029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1c0d81b-eac6-4d74-7b0e-08dc002ca51c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7799

On 12/18/23 03:32, Ryan Roberts wrote:
...
>> I should also point out that some of the subtests already attempt a TAP
>> output. So now we end up with TAP-within-TAP output for those programs.
> 
> It's actually TAP-in-TAP-in-TAP if you're running from run_kselftest.sh :)
> 
>>
>> For example:
>>      # -----------------------
>>      # running ./madv_populate
>>      # -----------------------
>>      # TAP version 13
>>      # 1..21
>>      # # [RUN] test_prot_read
>>      # ok 1 MADV_POPULATE_READ with PROT_READ
>>      # ok 2 MADV_POPULATE_WRITE with PROT_READ
>>      # # [RUN] test_prot_write
>>      # ok 3 MADV_POPULATE_READ with PROT_WRITE
>>      ...etc...
>>
>> Note the double level of leading '#' characters.
>>
>> Again, this is still readable enough for humans. But it should probably
>> be removed in subsequent patches to the subtests.
> 
> I personally don't agree with this. It would be difficult to flatten to a single
> TAP instance because the top level doesn't have a clue how many test cases the

That's not quite what I had in mind...

> child is running. Trying to do this will make things more fragile and less
> modular. LAVA can certainly deal with nested test cases and correctly parses
> everything to test case names that contain the test name at each level of
> nesting. The thing I was trying to solve with this patch was that previously the
> top level (run_kselftest.sh) and the bottom level (individual mm test binaries)
> were using TAP, but the middle level (run_vmtests.sh) wasn't, and this was
> confusing the LAVA parser.
> 

I was thinking more along these lines:

a) For the individual programs (binaries), there is actually neither need nor
desire to create TAP output at that level, because frameworks like LAVA only
care about running a lot of tests and parsing the output.

b) Therefore, just stop specifying TAP output at the leaf level, and let
run_vmtests.sh and run_kselftest.sh do it.

Looking at madv_populate.c, I see that it scatters calls to ksft_*() around.
And I was thinking that this is all just redundant, isn't it?


thanks,
-- 
John Hubbard
NVIDIA


