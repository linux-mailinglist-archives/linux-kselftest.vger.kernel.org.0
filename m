Return-Path: <linux-kselftest+bounces-2098-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3C281565D
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 03:25:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8149B23558
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Dec 2023 02:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B2715C6;
	Sat, 16 Dec 2023 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MyTPGEqo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97523567B
	for <linux-kselftest@vger.kernel.org>; Sat, 16 Dec 2023 02:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rdgoj/fWiw7F+h463gL+S2Zy9YtInm8lHxaHR9RlXBv1hYaW4+3Q7eefm8yzdlY0kuSTFhc65AE1jTfoFPwnTav1YfOjbw5UO2xC1qe2NjRNbXUEcL+BQkUFbMuQm/zPuSfjkhePNBr/6ny4uOPUc8U3PtxborEEoFOb7r7LBrgMqAqZ+er4TdpJA5ccJlJcUlo+IVP4ENHacV2/V+7c7fej6GCU56Dluz/BkBuRBbpiIy7+kHihiqCuannHIdYs+B1tzPoPMlLE8IqIw0ejRmLC12jXqbZj4Eo38+X0UXq8saaJ6Z5vEwOM3h0etpYgJBFZQabhzvYk58gZH/OEOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wp8yeYBD/Wzjhc1X5kPOZ0WPmSZLadNriOX9cVTko6I=;
 b=dMLmTJDTG7FjavBYSI0CRrReyVekxFfWnG4w76BeayNtGEDGZe7aOLF0ZVv1QO0xPUjD9DpuKgU/HhEXo+E4mRMAk3kIw7Pd/g8/y9Shbn7Xq3BrKEgpfZWGwTOJ4cy+S4PVcG877Axo0YSeSYGmcRyM5tF7BgXtteQECHYv5lRKVkPp0EN4rFG4Rzr+2s3u1/zF8/xGaJCJBuEA//RUCr48xf4IS5sNTp5rKNv95dDOzXXyjmAOW3fI/xTvfDDLxrzJOmpN0ka2b+IG8ca+2++Qbehk7dhXSoAoczZgnUPi7RmMrF7K2l0tHfrtHaIZVevDxr9HWV5nuMqvdYcmfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=arm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wp8yeYBD/Wzjhc1X5kPOZ0WPmSZLadNriOX9cVTko6I=;
 b=MyTPGEqoznwL3HICuvZhqYc726kYMQgjTL4Tk6m9wJRUaVRoEXLduSK+5D0sXOWu5QRcCtXgnqFdjM2ldEY9xnBJwqDaFY3Y+7SaKcJZjA8eFRGJT1B9xogjUHA982sdo5w2g8qnKdf11Sqo/U7bUbyWkDbd3LqshY4VgNq2tgKWOS/g0PcVhe6BDSyhDL87rjLayrRpi8nApA4Znz9WLrK4tLPZyA/tDOurZ+g2Q9caV2RA4w5tt+QbefjZSuBQ8SAqP2JhXJJuLDZkoDYpWBU2XtRWTSTi0ChPEg/0yRQqcYltWni4nJBlEgwNOCG3gJe1wvOwSonh1HJi43NFjg==
Received: from MW4P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::24)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 02:25:41 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:115:cafe::e9) by MW4P220CA0019.outlook.office365.com
 (2603:10b6:303:115::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Sat, 16 Dec 2023 02:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7113.14 via Frontend Transport; Sat, 16 Dec 2023 02:25:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Dec
 2023 18:25:20 -0800
Received: from [10.110.48.28] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 15 Dec
 2023 18:25:20 -0800
Message-ID: <d99367ef-72e0-48ad-ba83-45e25efdf0fc@nvidia.com>
Date: Fri, 15 Dec 2023 18:25:19 -0800
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
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <76abe3b9-3f66-4336-b09d-d5c137ff6582@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 403c4332-3c20-4dad-5c0a-08dbfdde4c5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	CtQ+9CwAk5f44zzhiP6acRp4ChNEG08x32DePnkRS+BFT/MTAKPdeTfTD2u20AEdDktXqt3FpqqKiuIft2fzO0YpeM41qyukA/mBLOWumw1IXsfclw2PdScsKPDVxf9l9hL5GcbQoB9y/sNym7tkcZUjCly06xE8ZDEyoj4W9QftPygI0k8/1dKvJuWuaCmpwBsyuyZHtR6vEe0jZRuqV8HiFL58lSIrhv00rFg8bX3YlVYfKV9KDzGZs9WymqmE/KSjuqIpTIwmL8uZs1/Kf/oKb3QDBESiMAMYSORT+9zIGtQw4tXxOlwfFsDon0ILNo2cjH6yVfTkcKkTgEm4AIDYFhxR/7LD81NVH1ScMP345gCEV7ofYWKaXw9/eIm/szZFFDJZsBnXJqKp7Kpu/N524oBg3R1nNE/DhNeLvuzxuVbNZWyfIY8a+xmW6gOnseKlGgtaWctWBPve9vNhuuQuT1UE8qnMIWNiqFZAUmiXy49vH8YWWx828LfMo7yTq142sGP/ZLmiefDUaP6lPu7MqsT9dIz13e9kkXOKStCaXiY7M5e2OWSyEpGE/BNjRDGVg+LV2L5LLl01GmSvUca41qEl38pe2Rg9kRHkuKNNeRL3QGEWYm0q1bBQQMX0E5FBY6wyHyRFFxD5ZT+h41Bxal4tlzLjlD/w0Nd0/mX+dxTbjRpNpQOmX3a0aRhQNkOFY/1Y8hr78sCnaxwENvWYclakaPRIE6rdeOEMF1/+R5HNVOVcacdmAcMI8z0rgJue36WSRQNZV2s6lZGqbQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(46966006)(40470700004)(36840700001)(26005)(426003)(2616005)(16526019)(336012)(53546011)(36860700001)(47076005)(478600001)(5660300002)(2906002)(8676002)(8936002)(4326008)(41300700001)(110136005)(70586007)(70206006)(16576012)(54906003)(316002)(7636003)(356005)(82740400003)(36756003)(31696002)(86362001)(40460700003)(40480700001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 02:25:40.7314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 403c4332-3c20-4dad-5c0a-08dbfdde4c5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

On 12/15/23 06:28, Ryan Roberts wrote:
...
> I've kept all the existing "pretty" output and results summary as is, it just
> gets a hash in front of it when TAP is enabled.
> 
> so this:
> 
> -----------------------
> running ./hugepage-mmap
> -----------------------
> Returned address is 0xffff89e00000
> First hex is 0
> First hex is 3020100
> [PASS]
> SUMMARY: PASS=1 SKIP=0 FAIL=0
> 
> becomes this:
> 
> TAP version 13
> # -----------------------
> # running ./hugepage-mmap
> # -----------------------
> # Returned address is 0xffff89e00000
> # First hex is 0
> # First hex is 3020100
> # [PASS]
> ok 1 hugepage-mmap
> # SUMMARY: PASS=1 SKIP=0 FAIL=0
> 1..1
> 
> If you think the latter is ofensive, then I can do the wrapping as you suggest.

I applied this and ran the tests, all while carefully reminding myself
to "think like a human". :) And from that perspective, to me, the output
is effectively the same: the leading '#' characters do not really change
anything, from a readability point of view.

So IMHO you're on perfectly solid ground, if you just switch over
directly to this format.

Tested-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA


