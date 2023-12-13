Return-Path: <linux-kselftest+bounces-1833-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6B08113C8
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A499B20A42
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E042DF87;
	Wed, 13 Dec 2023 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mokifYqD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C13870;
	Wed, 13 Dec 2023 05:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWnSCPfyA8DhBhQfWqfScZ3ngkZrKm2+yYKfEHFCem3FEqg5tM5Q7WspJM5ch1S6QmhuHuWSk4WK5201vRlWlirsxQJk+xyFWIMAJn8FAiPoOYhnN3AH1fazwRD8rX1vCXArTHWkkW6NPd41UzLO6OPTPSjl4M9AzHs6HBVcWTvgn5raWEwRDGAIFgXPq0G+9MtG7f/phbhNbJbu56tT/4mffb4k/F5P79hLLZpCjuHhFF7o7xC8pZKMQFem1RAhhUAWRQt03wO2+3suZGoOfB93KZyG+zpJCDeZEu4b/J3GJOC+UO8Hrv6JhPP06It6KHV5SgBiNRbEdZaY44ffNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nuA8FNMm4AdMkpSO9/c9JFLI+ZVvRa9lvjiO7nj/3ow=;
 b=a4BUKR1k98YbKDHoyZNGvg3zTsMnS0FV78rY0h2lqolu/ou8/Zb6gPe8/JxxKC3HD6CE51vY03QfHElHEw99HMBJO0rQbF8I8rE9DKOuFvojXc12TTYv9Gk/MJlkWbd+UmJNXw6q8takfPO5nat1hfcSYfVamioIsPWd+RdjfqtpfUDXtSyBSnrAVlrniM1JVQ+UHi4sdfbR7gcOy/F+AdDEE24aTsUez25unZ/cJroQrrMqznTYUo9+CiMocwYM9nZL7M0E1N0F/E7q60wVKfEV7bEcXGdRzxgyxubCxVcbDnUZOqT6Q+SbFZUCPGw+3L22bZbQP/kSV04rPuC0oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nuA8FNMm4AdMkpSO9/c9JFLI+ZVvRa9lvjiO7nj/3ow=;
 b=mokifYqDtv540zB8x1huG5oGMxUBKOj1MOBGPb1QB87fxJ2KhEfIPyIXr4UG4m69+pvI5Mgth6djbRbO22BrSxHshcyk11l5XBBswCrePctZbRgmKVZfY3ug5F+6ndPQiTpVLIvrgZw4ih813CzTUfSb/l4qfMLmTSA8LohgbQlOHt1GfWqI2SfMq+FMjbT+loBpUForBj+mj5JjrcAI0FqAcBGQC6EmVpbO6N5lqj5ZvTb/oXFMqpkVBDdq0YPG1sixY+hM89hgh+70qef1RVE+6URdhbobLxqGhcEUPXsW2CQb/jX1f4V0XlAL9dSyJpI7zXr2ZUFnARIL19TnXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DM6PR12MB4251.namprd12.prod.outlook.com (2603:10b6:5:21e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:54:17 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:54:17 +0000
Date: Wed, 13 Dec 2023 15:54:13 +0200
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
Subject: Re: [PATCHv2 net-next 13/13] selftests/net: convert fdb_flush.sh to
 run it in unique namespace
Message-ID: <ZXm3hegi/IRgQkHy@shredder>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
 <20231213060856.4030084-14-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213060856.4030084-14-liuhangbin@gmail.com>
X-ClientProxiedBy: LO4P123CA0460.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::15) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DM6PR12MB4251:EE_
X-MS-Office365-Filtering-Correlation-Id: 0999c909-5046-4ce6-dd83-08dbfbe2ffda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9Mu6oH2J0YGHggvwaNjxXV4i7QIn1lpr5MDIBP3aVXDeOh+IXRmpAnaMsB7bP/aISyIh7ACxyoGJCZnKv+wjq7m1vSevUDWMbHpLoS3RIOsvRnw9GZEHa1oTao3NDvTNjLufPMqw4FOQkOYZF4+3bW5Hw74MeHam0QemFnf71ZZe11eybGxFCvh2U0xCzDl/NV1p5SffyPCkwcsVzHumefCWoix85M7d68IY7dAGofoT2iP8MHINQHQEplxiUum4VO06GFb7kM+Fm4Yk5VodImvjE/bkim7BkBv4CoRZt6ZykmgH9dYhr/6/jioYDCa/M1Rmhn7peAelKON5XcZNIRNcb8mdfExbJX6E3/irPTqYlnp08zx6nkpnBcX9WGNZZ5zekvzM1SyK45Di65PzeHKtr9Z/TL1dVsNNpb/CkoaIuAN12l0/vun1Zv/vGehtyJy8YhRil09xegdb2xIj1aUl3pRShC+kyGfLQtUoouTLVYwMzPYBnaj9gNqFjMqIB27REnM9CVNYz8N2gSuxm9w0T7zWysV1TDQAEdsgGJwzFR31C52jJYgRnjcnROC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(39860400002)(136003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(26005)(6506007)(107886003)(9686003)(6512007)(38100700002)(5660300002)(4326008)(8936002)(8676002)(7416002)(41300700001)(2906002)(6486002)(478600001)(6666004)(33716001)(316002)(4744005)(86362001)(66556008)(54906003)(6916009)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tzqayW4bG2zibIV/AkXk3LEmX+fmEI2/m1aiYxodgQNH6qu4uctMSa4ShzaT?=
 =?us-ascii?Q?24MikI+2xXzHZJfvm0LL8EXQSCJpNcvWxag/vVMpxdPAVmQyePX7gAv60ebb?=
 =?us-ascii?Q?3Sv5JcqTx9yr/omY5iMzCeTUwhOzzmFUdSMzYN2Tfk3bO7PSftY9bHl3dY7a?=
 =?us-ascii?Q?7ZWC4Hfa321piRMXMdVgRQbM0Yj2JsS9nlCJSEni/tm+LcG/VM86gdxmolGA?=
 =?us-ascii?Q?amddCvfLm5sFQdiovqdfmBxzpLbuP7WDk5SZJhDhXnxZF9/ilktW9GHC+wW+?=
 =?us-ascii?Q?WkmwHGYtIngAju6IbNj+C4vlxpIRz0MpiRl4Uj3nvkBZxyNj3LL0dHlGKr0j?=
 =?us-ascii?Q?svr5lTh9pVOtuJs9+BCw9PjjnF404hLDGGD5P9HCMzmu4bfhQg88/kCG7ejL?=
 =?us-ascii?Q?y3TIKG9ityeucSIekdZkawC/0nuomsp56h9nrfM/Dj/pJJZQzSO1da7Zvyt/?=
 =?us-ascii?Q?Zqn51kXB2SQpp3oLXe5uR8JNrR/cun1/rANf/ThIJWDIm/+94RLja9LhltJy?=
 =?us-ascii?Q?qWlpdYN4E9iE1NzIq6p4PkXrQGI/wNizCE9/a1TF6DUZ9D+B+iOZNn/Ba9Ju?=
 =?us-ascii?Q?IFnPJyX7nX/0YzZ2KblGGb7jD9EB3vWWM5pRV0PV/6buEKvFqw2KD2ryDxdD?=
 =?us-ascii?Q?FUWzWa0Ow9B4I4J1vDgAHXoT3WW9j2PTKhJ0nz1UTcgZJhuHKSGH62tJTGKq?=
 =?us-ascii?Q?K/OpGWMlr4awezoAgF57Kw1bpuNI0GR5aua8srKmyCCj0pCEROqUhcG31bjQ?=
 =?us-ascii?Q?RBaZf4TtlbpvXkFPyw98SYKXTVj5qTRXETLmVwJqFlxPI5pgNT6z8ntfMYMN?=
 =?us-ascii?Q?Pl1f5hOZPul1krEdc1sA5U8sN3BQeHFuGWJQlnZ5OFwhb7cfG7UV7V/ZUTkQ?=
 =?us-ascii?Q?pRVqnfwCs82ufAtMsoQs6lMtKbTuA83mZy2A6QLX1x22FkXPDwex2IAeqoas?=
 =?us-ascii?Q?kBXONmmNpGwssyuW4GkSn6GplU5rvH+Wj6efdCZamXtLujFsdblZ3NIzFiL7?=
 =?us-ascii?Q?omUQmHd0I3acn70Xd0rjVJOZDM6Hy7pFxuE5cpyPj7gOTJKVmYLkTN41y5AQ?=
 =?us-ascii?Q?uvmQ31rosxsBa9fFn4CvjX0DsLQTjzyTK9HmA7b7TmkHOCYmnz/DKbbSCUos?=
 =?us-ascii?Q?J7iiy6s3FiBmq+bqMjWaGHkdABNlPJWf5XnNTYukkpEu5fukplm2uXeFWRtQ?=
 =?us-ascii?Q?9GagaJ7X3THI/RGxFTvxTFAyI9nG/Wt4tPQeLGMZYWoaL30XgYTeGTU1+s7Q?=
 =?us-ascii?Q?MXRmO7pGmjAO8UQNz9rkmI8orlbxvKZkeXPgrNRqVhJmxzF5Jz5g1t1vEL5f?=
 =?us-ascii?Q?thn/2XuoqROG/p1WsTKCiCdn0lhC+yTfxC25p9o8ArkDTo3+VTLHSXqHm4R9?=
 =?us-ascii?Q?YUTTh45snz+C+Xm92rsH2mRg2Dfv+UT7EZyfzLj8eY4xD1x+OjqmBVkJLgMO?=
 =?us-ascii?Q?trGRvy9rQBoahLzkA8uRiXOUWqAJezUyKmbDddKNxeeBJX95h0QbcsM1laUp?=
 =?us-ascii?Q?duXKDBzmbtTNCBJ17PJsh4ooCUfZwQGOSqGmAlBevfZndv7wSw8/WS4/PUzH?=
 =?us-ascii?Q?Sx+EjlcNwtwMETxxyT7IdrlO+LoHC7uEmW46bJ6N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0999c909-5046-4ce6-dd83-08dbfbe2ffda
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:54:17.7759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IyS7YCRKNzsSbwrbqeUCxLqYgLS2j+pWPzR9q2tlhkwGG1ZfQMq3VcjIEHdA+yMDYo/1wlRUR3CUr5FrabcnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4251

On Wed, Dec 13, 2023 at 02:08:56PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
>  # ./fdb_flush.sh
>  TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
>  TEST: vx20: Expected 5 FDB entries, got 5                           [ OK ]
>  ...
>  TEST: vx10: Expected 5 FDB entries, got 5                           [ OK ]
>  TEST: Test entries with dst 192.0.2.1                               [ OK ]
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

