Return-Path: <linux-kselftest+bounces-2099-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D373815672
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7299DB22D28
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 02:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612801384;
	Sat, 16 Dec 2023 02:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WhQiqRnw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDEF1852
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Dec 2023 02:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNtj4ToNKM4cRhmVRRxhzLOQQ/DFtoPbp+dqiLNBTAtffYx/G6k3uPEoCDV0W5snI/TIHrwDF8Dr5X9DNfFu9Cc5aBc6pwj1MCD8+5vNPddxgNZHpy6zoxa8eobWxQlwcfJSZeS6lNbyh7D0Y+D4e+ghzzdgq8bKZEOAtRj0iRMxzQhB3yA7IJyeOPeeWm3WOEjuL+XYQ/XnjHxjZxVEVB8ez7+8LEx3Vu+sdP7E6XvmDrEUAw42emljAFpdAeSCQyzK866SKsQLiwHuu9Ux7V+I3yFjYqdl5ZVWoMo8gLXkAYQUvKREQRX/Zee9so3Dxyi2LhyHVMq4GDZLFJ/ADg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RkH534sGLWKnsKdz8DCmjuz2Y8yb/hMs4j+BOZD7M6k=;
 b=Rxu4klVqdpb/eYGXWfYW6oC4Chg31vMB4aWNeAsvwEwiKrwImal/DdNQcOUT2NPT2Rs8oMH5gjLNka1RyB4rInsv5FjqA1/0EVkA53C4RgqCpqnpcf7u/BGjmJBpmGjEH+kXUFR8G2FaVvOt5655dr6IQnQSHHpMqBNmeLe2YLtwIYGZ5XgCkxFvbLx83edKeDCGUGBPlMs2MyCJC+UYI+l1DLQ/O3dsyiHiDXrZjleWK6fElb6l5GL0uQ/ADZ2L25bA5evoKsEg0JhKky4sp1Hrl8qg9ROIMdwHN69cuuRa6hb5e53TjxHBkIKBSTc16GUEq9wyAjzR+z2lHKoQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkH534sGLWKnsKdz8DCmjuz2Y8yb/hMs4j+BOZD7M6k=;
 b=WhQiqRnwk4fOVngJ0sVCvdLZnavahXiAhhw5ORU57YQza3AH8dlR6pqWKHZhcY6IvZW74RS8g2oWnqQDVgjZB3aTKusuIdydQIOJAe5+BuiZfNQ2E86vH3bM7V9v+o3/UEWYub1/32VPvsZrzqd/1lO/De/Z0SyUghuVAKk0lm085IBYUOMGqukqynX2YcILxzaCqOjy1Y0okgVgFB78oOzR9bHfXYenOGMz4pAPyj4x8ESy9q5f6iIcbtoZPjqmWkfkm6bNPoiG9XxqPvO9hPdShqlocX3SVyum2thgdodVZG93w5nIedwhhSGzHE8VaXGF1TLCjsGcgNQETz6W8A==
Received: from BL0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:2d::30)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.32; Sat, 16 Dec
 2023 02:40:20 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2d:cafe::23) by BL0PR03CA0017.outlook.office365.com
 (2603:10b6:208:2d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Sat, 16 Dec 2023 02:40:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sat, 16 Dec 2023 02:40:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Dec
 2023 18:40:06 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Dec
 2023 18:40:05 -0800
Message-ID: <fb91ab59-ab5c-45c4-a413-bd6c060bfcc8@nvidia.com>
Date: Fri, 15 Dec 2023 18:40:05 -0800
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
In-Reply-To: <d99367ef-72e0-48ad-ba83-45e25efdf0fc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 05115621-8d4b-4afb-8307-08dbfde058a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Qkkg1XWF+PFHr7tBiY8nI9AAP5swpS/skzChCNUx6Jensadc2YHJAFJk1K5UMsJY4bem/j3AC6F1CXFfCYJxS3djUtUh9DMq0uCwe10DL0igLSTfr7j2MN6hhgtfVtK+fFTr4JZ+s7T0afTBOzMKpyaxBqrE/J3CxgSAqcR2r1yOOEhoNSlRuOUM1BX5BBGrQZs3MHSIW+GXnQxii7mquiJDfc3nOWeGLtt7AlawVDU1dz9K+TqFnHQ0t9F6/wnhuao22E42cLd8or/wggub254Q9wXnYcguKD5N06Ca9p2epyvnAvQKj4m/gn6VV47CgKChbJGnN7x9+H77pIfucqUOTdB/NYkyVcVDE88KKoBmtilZUb6xBAPMyiG9jH4vTaL0IcFoedsanjKNYiCEOOSlus1ocejLRzR7O2Aj2HyjlG0OLNVwh1cnJcEuyibDD+65Ug2Su8nBuG1X1iRUIV5tM8Xmlr6nJkkTD1vbRwVDdkovw6pffwBAg5QGr4AClnI2Akb+jn4aDjYYhBM0xRVzdWuGrDFiQ3mWzEDNZO0M3r2TXrj1BbrleLOlVbNixUosPZS0iWuHOTDR5vtNkNHOQA/Bp7ThGq+me3I9MlV6uZ5QnNF7vqr9T3eCMPgHQGc8JWAJoet51FNOb6JKShpajQd5yb1DK4uAcyrngw8y1U38h8vzYwSxRigvdEtKjSE6bWmkajN1QqdbEApMGu97w+xkmmEr33PQ49MWzRiqcJXHKXEOScTcBL9hgkoMhwDlnK6bq4FiSJOoj7GhtA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(36756003)(47076005)(36860700001)(4326008)(8676002)(8936002)(7636003)(40480700001)(5660300002)(2906002)(31686004)(478600001)(2616005)(70206006)(70586007)(54906003)(110136005)(316002)(16576012)(16526019)(26005)(426003)(336012)(41300700001)(40460700003)(53546011)(86362001)(31696002)(356005)(82740400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 02:40:20.2598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05115621-8d4b-4afb-8307-08dbfde058a0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

On 12/15/23 18:25, John Hubbard wrote:
> On 12/15/23 06:28, Ryan Roberts wrote:
> ...
>> I've kept all the existing "pretty" output and results summary as is, it just
>> gets a hash in front of it when TAP is enabled.
>>
>> so this:
>>
>> -----------------------
>> running ./hugepage-mmap
>> -----------------------
>> Returned address is 0xffff89e00000
>> First hex is 0
>> First hex is 3020100
>> [PASS]
>> SUMMARY: PASS=1 SKIP=0 FAIL=0
>>
>> becomes this:
>>
>> TAP version 13
>> # -----------------------
>> # running ./hugepage-mmap
>> # -----------------------
>> # Returned address is 0xffff89e00000
>> # First hex is 0
>> # First hex is 3020100
>> # [PASS]
>> ok 1 hugepage-mmap
>> # SUMMARY: PASS=1 SKIP=0 FAIL=0
>> 1..1
>>
>> If you think the latter is ofensive, then I can do the wrapping as you suggest.
> 
> I applied this and ran the tests, all while carefully reminding myself
> to "think like a human". :) And from that perspective, to me, the output
> is effectively the same: the leading '#' characters do not really change
> anything, from a readability point of view.
> 
> So IMHO you're on perfectly solid ground, if you just switch over
> directly to this format.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> 

I should also point out that some of the subtests already attempt a TAP
output. So now we end up with TAP-within-TAP output for those programs.

For example:
     # -----------------------
     # running ./madv_populate
     # -----------------------
     # TAP version 13
     # 1..21
     # # [RUN] test_prot_read
     # ok 1 MADV_POPULATE_READ with PROT_READ
     # ok 2 MADV_POPULATE_WRITE with PROT_READ
     # # [RUN] test_prot_write
     # ok 3 MADV_POPULATE_READ with PROT_WRITE
     ...etc...

Note the double level of leading '#' characters.

Again, this is still readable enough for humans. But it should probably
be removed in subsequent patches to the subtests.


thanks,
-- 
John Hubbard
NVIDIA


