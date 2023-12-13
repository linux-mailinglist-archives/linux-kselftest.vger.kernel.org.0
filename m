Return-Path: <linux-kselftest+bounces-1828-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF9E81134B
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708CE1C20E4D
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4CC2D631;
	Wed, 13 Dec 2023 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TzYwqQaD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E700DD;
	Wed, 13 Dec 2023 05:47:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8U22ObFZ3Cne0bt4SgstZQga3g38u/eXUQiMQa05gY/dOrjLuZDfPcybYoJk8t7SpMdgqTb+VjBye2ND28U2asDTb7wNB6GgAvPjtMCYRh+ZejE8E9BS5VCiivaq0Kb3R7IUH/l98Z1In3JBgdSXKsNmfOZxkoU/F9hPqkkDylkPDXVF3DofKwHvpzaQiMBIb5QEK2xNUJtvbDljm3hJQqJ7W7gl8ENV4BYpp6tHykoACczXQUHr4DAWEPvlwXmlLc0rlMQmfxkrRWNzevA9vgkHzkCoqnv5OlP16cQLowXuUepFW/VoobaGF9YjkOiONhCU7MgFbOoXbHtjL0XlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfo01Q7fExgITOSbYKW22aYYPN4gtml9ESgzGbrT2Cs=;
 b=cJJcNC4BU5f8rLCufH6lLmj7koyHTwII2h+PySvqhXGx5g5R/UNCBkxMOHPtr2MztdcYVgf9iJo93mHkYb659Gc0WBr9BNKbB+xlnzGVNXPdcTs/ARum3F+MKDxjxo/fGAn0Tqc20tulZa9kzHwSCyJBVyghR1vHaasLn9p+k1WmmnKaOe7W+04in2AOI1BD8j35L4NSYSx1LvvLl2/6XRg9xR5WE56HXTqRg5OCozPPUm4ZNb/momm3Tar5Jirk9Fa+Z9N1OoQvGkrh9Dv0DjNEFW1Z70OHbiKe5E1KCAhP6G8KI7H2HM7XlElQbtHO7p7eTwA05UXAw/VWicdZ6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfo01Q7fExgITOSbYKW22aYYPN4gtml9ESgzGbrT2Cs=;
 b=TzYwqQaDVCJGe+RRhmLdc9zgLTcFsSduLnAZZUzlq3P6AhuXvBMwtCfGdOYu5AJXygdWikj+mmaXL4PQxKbR7XJX9sOvD113OwlOdUaZjED3Zwy4V028yjdxurmmylLhlC4P6b17EPGWHCK+o/YIXnV7Wgtn4m8OJE/UPv9xqzaXuQy3ceTYYCh65Vu29mZMoeKU6vyuR21gml/RGTfBkZS4c+rW+OSdwgF+nvegCE1APTabDW4d13N7apIjHavddN7dWC7vQCaW0XcXJYrQ9DVXOrXIGVu4WfBnqFUKuYkrJyxKVCQwGCqkVpWwKTatp6keHO+GyfGDGITLWCIklg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:47:41 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:47:41 +0000
Date: Wed, 13 Dec 2023 15:47:36 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Andrea Mayer <andrea.mayer@uniroma2.it>,
	Amit Cohen <amcohen@nvidia.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCHv2 net-next 09/13] selftests/net: convert fib_nexthops.sh
 to run it in unique namespace
Message-ID: <ZXm1+Dw2gWZ1vJle@shredder>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
 <20231213060856.4030084-10-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213060856.4030084-10-liuhangbin@gmail.com>
X-ClientProxiedBy: LO2P265CA0019.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::31) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b272a9f-e196-4609-e837-08dbfbe21371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zoDrBiNDDGK+V3/owfWZqQmer5MUTXThqEecZawtVnQD9Qln8OKnPHUSPOfGlKwaXC3tm/BxAOoe2EvIXZ15Nb7n07NJleJGkhJvDES54JQ/FAfO6dCcwWtpmVf1yj+BD45086LPHub8DNiMy5dNoqkELBVO8y0uUvuPdmEboXCEBHTuifw5ZXJLgg3N3RbtIGCDSeJ9EiVfpZrQhwZYEoaJnV2Mp6lgpV5wBOxS65bFBJQP0J1ygBbPcf+THy6Wow+7k3XU74tWxHAygXTDouzfeEc5kftwA/m3iO8+923Cb9seFFDDIGlv6eUyvxChxcWHG2FRL/gYy2m22nXjJl5XGnRFV2fsUWowq12zOHp+WZ+cDppLZE0Kv5dwKx27FPgh7xZkTwq/V5plct/iyxC2ijawxlWUmhv5NRpkcQ1LrwtkNTqDh7Dpciyi9y2rGRwnTZO4gwur9xawv6bRWwIZPY9H1R+NnqVkGIf45T3FvtuN4kjeI6JGL5sUy+HpWfVtSLI7PinDXwtbWwzGkP3AK40r7zZd3Z936UCjbe0lyvjiV7dJUT+HmLd6dGbb5sky+jklatSqrTH/XfzDmhlf5I4v0LCpk7zCuHBitw8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(346002)(366004)(396003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(8676002)(4326008)(316002)(6916009)(8936002)(478600001)(66946007)(66556008)(54906003)(66476007)(86362001)(6486002)(4744005)(2906002)(5660300002)(7416002)(41300700001)(38100700002)(26005)(9686003)(6512007)(107886003)(6666004)(6506007)(33716001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mB8UaznaOM/IwnTtUYDmlMWh5D2/2kID/737A/7VjfEaMUmOEcQW01n2qhGU?=
 =?us-ascii?Q?HU0a8GpG01br5bYs6RFcPZN16W04hDLEbb7ENU1c6vGaG9FrYoYhtNTS3WdQ?=
 =?us-ascii?Q?OFNJnedts0y+s8FJXlthcb2NvGtWMhuy/VU2hw4i4yae6Yhyo8wWgrdW5yjW?=
 =?us-ascii?Q?YQtSwh30DXr2Hb4dNWLSqEWKdvShv3MGtO56gMKInhZHMB1WU22T58Gt6G09?=
 =?us-ascii?Q?f/H500hDzLMvRlayWIIRGFQ/HKgoUW82VlsdONrq/EsnfVDw3gnB+I/ymRjI?=
 =?us-ascii?Q?oXRQe36XzN+Lpg/cAl6W6Vfser79PLWR2XnRkPJ/eMLzYsMAVnZMSgm1m9Ga?=
 =?us-ascii?Q?VdizRyhn9zpNkb6/jGMH6kbPTPfVMTAXUhI4yIV+utNG+rgK+ElAhyQDwZrO?=
 =?us-ascii?Q?h5vNW7Isw3pbnRVvc3/v7b117WJ0hceU/Xq5ge6htwT5S+UqaHIHIla81RdJ?=
 =?us-ascii?Q?uoEm8wwaCXvVNz4w6ugDF6x9hjjulVpRyHqQdiOfvoCQldNTz6SB4XT65iJl?=
 =?us-ascii?Q?M2wc0wyfrie/lzXK1hnLtiwdMGLOAODJQRoBdFNcD9LaqFf3x6h1+CXtHMtx?=
 =?us-ascii?Q?8kwAoye1H09qW0/tuYLsqAw3StJbpumit2aYzdUfQdI7ELM2DIxvr9scdhWs?=
 =?us-ascii?Q?P74qUYdH0qJku7I/WklaFxcWpeRWz3weMq5XqO6bSEKAtnUOCYscZ6exPp6I?=
 =?us-ascii?Q?7ycY2UccapRvULKajoYDl2EUEyKpiZJ8BIUUsh58jj6ol+HqTl15vwkf6yQ7?=
 =?us-ascii?Q?Q1xYE1jYHZfVi4jrVA+TTf0lCb+PKOESI2QRnatJDvwvqTKXqfjtAFeZQBtR?=
 =?us-ascii?Q?hxPQZq6r7gDjAXvEOb7S6ImMufZZ3jtOi8H44s62ppCImGWfQw0rGmdcHSvs?=
 =?us-ascii?Q?y8U812ZQDgOlblVi1iaKMcXNozF1DdYlWBpJGKggu8MwlfzWNbeC4ySTC0AV?=
 =?us-ascii?Q?EChVmrcHqZSuoAY36vsMbQtV9D/FrrE/zT5Y5FA9AWilyoWYD/kRbjmy+s8g?=
 =?us-ascii?Q?zDH4ASMnus9agFJwM7GQxJ+cqpwAo4oRTmBy7rlh1lq0qGK3iSCZLJikKUWX?=
 =?us-ascii?Q?ZWGFO1xq5tNzzjCT1s57Jq/hHk4UG/Vs5JT4g9DCrab2xlCwrHTd6bsP2OIT?=
 =?us-ascii?Q?asKMpuUOlEABHiYGlN2+DzVCLznxISC9AprntRXZHg1eH2zW1bg06LLCl/4g?=
 =?us-ascii?Q?rdqvd8LS0ToUtQu03WeGcNqJoNw2BWrzoWnVNHvMhqhbjSLpMqBK3qnSFBLe?=
 =?us-ascii?Q?CU/kZ7uULuZT2oDKq1hSDUDWgwXACxMviYImWvY7sIz8dIAj3cPR7ThkKTs2?=
 =?us-ascii?Q?P19p52dRkuPpYSvrl87XHslOj+xFgX8A2pQ6sGnPB+AQuzuTADvGrcoTv/E4?=
 =?us-ascii?Q?5F3dj54Uigf2GORskdZlJflYEztMWBKgyUk7ZhtVA0AlzVQ6vticlp5DQ1FI?=
 =?us-ascii?Q?Pm550TzYC8rXz3t7JoKmS3o/hqBOmrnUqQb01EUyuYmTvKXiRwTwhm0hOT6i?=
 =?us-ascii?Q?q2/4fPGou7PjNtY53ggFtE0dXwJZmncTd9BGWAwrigC/4aZcQ/b2EdsJe5Le?=
 =?us-ascii?Q?T/SBk4NeWaTBq71oiKPfEeOyIcT8mF5bdZtDlIxr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b272a9f-e196-4609-e837-08dbfbe21371
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:47:41.2223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d7uJ8wy2s/E7xEDHRTT6YKHHrziVofW6FDC04bJaZCOQ89RhnbQMjf4dgIqcjEgbFfYckWsUJnW55MxgLDW1EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645

On Wed, Dec 13, 2023 at 02:08:52PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
>  ]# ./fib_nexthops.sh
> 
>  Basic functional tests
>  ----------------------
>  TEST: List with nothing defined                                     [ OK ]
>  TEST: Nexthop get on non-existent id                                [ OK ]
> 
>  ...
> 
>  TEST: IPv6 resilient nexthop group torture test                     [ OK ]
> 
>  Tests passed: 234
>  Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

