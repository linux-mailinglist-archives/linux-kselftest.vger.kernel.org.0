Return-Path: <linux-kselftest+bounces-1467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2E80B181
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 02:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B8072818A0
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Dec 2023 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0D580E;
	Sat,  9 Dec 2023 01:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A2w0A0k2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1D710F1;
	Fri,  8 Dec 2023 17:39:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZQjMugkUK7nJ2YvGTumJDupXR/9LH/3n7gsKoPs+AhUqaSObbWBrNvcXSfaPF6lInRkRTEr6Jsr2h3ob9dRsWoCEDA+di4Kq2z6BorutOh179AG/fRfthM1K6mr0qWiu2Z6b8FgL8dLjtxCRk+VZAqn/kdkL6kBfLiO6PqJx6jwxoggIZ/qhPBdKtk6XhIJUs/KZcdmRbfvGBfT5fYn4eB1mtBC6UzMGgx24u8SiCmfCHlDKoKCmCectSZlboqOFDA+pIWm+BTxl6x0gptjQcFBwEJmlMJW9JcLmwU/tv9PI7hioCCXl6Uk0+mZfzs65HxniCYMd0J1pbRTcpX5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZNyLHz5EJUWuOm1V7XfwCOTAUHpq0qdi/RVrsASQDM=;
 b=NljH2DaAw/vfMIr4+Spe8CIw4mS2jArEEXupB7U5k0D3TThTK1wodZx1+5TOD0KjC3dZRYBpJHgCOQ6v53t+dPOTLVSoh3t1YoKGGCWvf2wvdNh1OFWxgueyzCSjDu2t+zVXG2lyhCW9CSMawrJnryFtosXUwM+qs1EZQDTTZmAEqIMVx7Kw6lhDg5hKu+A5CqbDlkaxqQaDzvenwZ1MMcbzbfEljBfKF6UY/uT9NmcGI9YaUmWpLlzaCUK9dGfss2PFPgYblErxf5Q+79XXQPFlzFQHJdj0sSx0yp2YPWkXbvVGr+IYAaKKPE64CLKv5gv00r0WmAQjwhjd/QVIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZNyLHz5EJUWuOm1V7XfwCOTAUHpq0qdi/RVrsASQDM=;
 b=A2w0A0k2Q5SmOhxeNm8N/XCTQ2n4WZzjJAMjy0QDCJsdnaVEKky2ORaFMrZlLC3wT0DwIu3efyJIU/TUEDi7/MjfefjkrmRuBcpFj/Zst+SAiTqeuFAG9n/4b4A4H4Hom/lF9bVRu0zh4/hlrvXpQ7ajg95hVaCk4w/6KdN58HweGuPrY7VsSyIB5EXZQz6eEFEdubNz+szqOSMIi8FIffcfZNlFRrSvsFJTI4zTvF7zEVnv+7U52uMs31p4gwUkJOEYeBnZ3X1raZs/9kUTFScKDD6Bkz5EhzqrMdQnzAnWHsMUg6HmI6OmmKov7BtTc4K9DZIW5e2w8706Gv81lg==
Received: from BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26) by
 BL1PR12MB5160.namprd12.prod.outlook.com (2603:10b6:208:311::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 01:39:19 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::38) by BL0PR01CA0013.outlook.office365.com
 (2603:10b6:208:71::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Sat, 9 Dec 2023 01:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Sat, 9 Dec 2023 01:39:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 17:39:07 -0800
Received: from [10.110.48.28] (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 8 Dec 2023
 17:39:07 -0800
Message-ID: <d12dd3ba-8b24-4fcf-8c55-00c765628836@nvidia.com>
Date: Fri, 8 Dec 2023 17:39:06 -0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] selftests: error out if kernel header files are
 not yet built
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
CC: David Hildenbrand <david@redhat.com>, Linus Torvalds
	<torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>, "Nathan
 Chancellor" <nathan@kernel.org>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>, Jonathan Corbet
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
 <20230606071637.267103-12-jhubbard@nvidia.com>
 <20231103121652.GA6217@noisy.programming.kicks-ass.net>
 <a002f903-723f-40ae-8d7a-421ab2e082e2@redhat.com>
 <20231208151401.GG28727@noisy.programming.kicks-ass.net>
 <990feea2-c7a8-4cd9-8a6a-bc4bc1c2ffab@redhat.com>
 <c54b4059-e3a7-40bd-84dc-013dc3b15c65@nvidia.com>
 <20231208221007.GO28727@noisy.programming.kicks-ass.net>
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20231208221007.GO28727@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|BL1PR12MB5160:EE_
X-MS-Office365-Filtering-Correlation-Id: ce06c626-b6ac-4c20-43be-08dbf857a976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XbIWRgtPlpQAajyfESBGgaYjdJ1k+gnposJr1DVtxT0O+EUVlZwx1rhc2ofg7+oKpipvBejOCPjGudwXaILcP5tNtoVZocdsn71BtSwyO/8uyuH8xih/SaWhyVqPv2E81VCreOSJfpWrnNuGRMXnzFeMKA8A50YrPh9nGtoa9xg2Dci8PfKngo2Zr+AozZQD2hjfbb4HRGM8216gWkQk6ez1R2kwNHz9+iP+UOEb1ji2Zfy97ZbIWNV1jMrx+tFM1ngNmB3G5r4+e1w4btfe61zRUMKHo4z95uBhlf/kDXL0OOeWe/0er0ZTctHldFvgwmqL5Qb/zWXEOu13NatcBstbPzhcr1gAqZnOb7nnu3ZKRB0Z+HLN0DugjcrbwfYIAglAFtDYCRi4LNX86RadWFK15UaKn+iary676YfJzYQ42rDy4R1jP9ZQLAgSEo1B6BWGuxCG87tzw6gfN2MIPcwYEY/83vYg007ZOat0nKpKZnTZfTopmQLEGTNJvROu7bdPCmeqz9woKe+t0Sx2r32UR4w5pEtkkKqRNbb0tdF/EbFKDiPbrkImDACpk0EMWEYrtAU4uW+qnVUoU1BTeiJlsxoGETuWKMv6Lke7+4zgLT4VAB78Ks37hkNi6jnJxxe+71gyIt4uwUx1eDeUTjoUu+bhSNgiId3GcAfpQo6He84yfZps3D7qK6/DDRznMxtDukvJDhpPxcni/DvTvSbpTJPI7Lpvz63AUr4mrlrr8rpul7c3rvcYXxqf2LrpwhK54eNY2Kck5fmw2cDfcA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(36840700001)(46966006)(40470700004)(40460700003)(2616005)(26005)(336012)(426003)(16526019)(53546011)(47076005)(36860700001)(478600001)(5660300002)(4744005)(7416002)(41300700001)(2906002)(8936002)(8676002)(4326008)(6916009)(70206006)(70586007)(316002)(54906003)(16576012)(356005)(7636003)(82740400003)(86362001)(31696002)(36756003)(31686004)(40480700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 01:39:18.9969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce06c626-b6ac-4c20-43be-08dbf857a976
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5160

On 12/8/23 14:10, Peter Zijlstra wrote:
> So as David already argued, the current thing does not in fact help with
> b. You just have to install once and the error goes away, then carry
> that tree for a year and you're running old crap again.
> 
> My biggest beef with the whole thing is that I simply do not want to use
> 'make headers', it doesn't work for me.
> 
> I have a ton of output directories and I don't care to build tools into
> the output dirs, in fact some of them flat out refuse to work that way
> (bpf comes to mind).

Going with that, then, I believe it is best to simply revert commit
9fc96c7c19df ("selftests: error out if kernel header files are not
yet built"). And then follow up with a series of (many) changes to
wean the various selftests off of the kernel headers.

I'll post the revert shortly.

thanks,
-- 
John Hubbard
NVIDIA


