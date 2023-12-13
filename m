Return-Path: <linux-kselftest+bounces-1831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7E8113B0
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 14:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEC3B213D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Dec 2023 13:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 068552DF95;
	Wed, 13 Dec 2023 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g/rj5xtC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3568D19AB;
	Wed, 13 Dec 2023 05:51:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDLN8Ne+iySoDdA8SAWI7fK69TesaxMnTqDqMzW3AMptVddndun/E29BP1FPhyguhixMLtkVwMuuJ/DGWvZa5+qCKYvXERNvxwW91lqHuCpbpL2pSGMe3giOJpUY4VsIoYXYGA/tDhbMM8ElWVHfEKDnXRFdHPwWeYUC9ZPQQk1VqJHGYYqrUBlp9NzeduBNZjmSROObiZYTiExtpPsTLehNnW76nyURmrEILIzfw2VUPr3MdhB6zntVR7ozrWxDVBnYMYqUqu9CcUDZDLsMXNpKvDsduLLQn18OV4ZtX1K1vwY0z+zApr2btB6X7y1vFOyci3ahz274SknhOOJwBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXCDvMEWa7DiJAR15m4rmPXBmjaPHqh9/YLM4FmsvJM=;
 b=cAJvGrrhDsLppTqYzEfrx4pDu0YExTXzIJa83GaBp1vQZssihL2XpA2+WhPpAaW4TvikpAmN8RE1QohFrhEiQ8NwWlEgcVfq6S86IJSK/bnsIKz2NfgqA3jg9LqUAcl51OP+FQeNlA+4PDMgSOrQyb6Uni6Rmhm67eTSX07Lg7P0cLHLlwR3AgFOop/txzsMVw4XOyv6bNcYqSUOgEscuYMFiuj04Gju584wlND2rWUUpMJbK3fhcLg8vTt3P96Q62OexFOZc+0ugpDtrMZvCBadvyVRGm/4aEK0Bmep0VkzCbXPcTLRx99QCXv4e44tppnV5b7wuYsH8NwDpcDwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXCDvMEWa7DiJAR15m4rmPXBmjaPHqh9/YLM4FmsvJM=;
 b=g/rj5xtC8T7w/wSjFokUyCK+4bKSIOb0UIoSOC05uXrH3yruuF8sa3Hd1uLPk9yvpbzNHZCKBKNOphjovAiBiojJLlxj4GC38b7jm4fk23CwHyxKh6d3MGK1c32uky5amb+LPi1e3Py3PGkx1bLQe2eoGzcEcT3izybU+cYaleduImg57hqOWzq+cKmDu8PPdMQRx2INcmQKobvgVch9bEA01holBz48rV7qGDGAIueZDqTH7Jp67lfH1J/FlcYRL/lhzwfuEO5RQpse3vrHhyr2634XRTYudleTzmTB+aa1xzz0vbMa8AsvgXqaQOLIfYqFX9R1zNmlCRfMXmrVXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by SA1PR12MB8723.namprd12.prod.outlook.com (2603:10b6:806:385::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 13:51:36 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 13:51:36 +0000
Date: Wed, 13 Dec 2023 15:51:31 +0200
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
Subject: Re: [PATCHv2 net-next 12/13] selftests/net: convert fib_tests.sh to
 run it in unique namespace
Message-ID: <ZXm24x1eA1vPv1AX@shredder>
References: <20231213060856.4030084-1-liuhangbin@gmail.com>
 <20231213060856.4030084-13-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213060856.4030084-13-liuhangbin@gmail.com>
X-ClientProxiedBy: LO4P123CA0501.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1ab::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|SA1PR12MB8723:EE_
X-MS-Office365-Filtering-Correlation-Id: f40dbfe3-7071-459f-9d20-08dbfbe29fa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BrZgmnqazRhUxTydezs0ZicqZJAmqvtBUw1ju/Ke91FUwtI/y9AZRQZIc7WanCNOpmFwrjZFlGEicsTOHU9Qr32xz0J36feZup4K05KRmp1zeIEhzVPNQs1a1NMhKlAAd+D2kC1XYsgEMbB2nWEYz0P1TNFxIghaDPqcr656MGAARXJ99JO3F68PxI2ERXAkVjc3aIfhIsQ93V+yAxtlD7a1NRLjTF2pbUIOJiRZITEexYDmue3XkEpf1/b4q9k8pZUquJ2wof4xNfGAHqZPxs/rey0x6Z/r02MKLQR3fqQqDXT+0aZqiy9AMniyA/yn+Z244j8L43VnMeTh4BoQZgw1oMtsBtxVFJBN/P3HM4lUc4ltHvLJo0DCQ6FzJe3ncVxc2i134WNcBRmBTVZDZNb7J070KF9CJ3y1laJFjBqzB2ozr44GOoyNvpDk/2Goymf1y93+3z6U5JeY1M5vyNP54cvQO0vHcJjoFaO7kpQxpPnoEvMEflSY0cYYu8KG794iyrZSjBp2qLZkTnSpklV5ApWoAA/Y30jGFyzhqiAI8SpwQJONEj1EZTL08dyI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(366004)(39860400002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66556008)(66946007)(66476007)(38100700002)(86362001)(26005)(107886003)(6506007)(9686003)(6512007)(2906002)(4744005)(7416002)(6486002)(54906003)(6916009)(316002)(478600001)(33716001)(6666004)(5660300002)(8936002)(8676002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/d90y9coABi6lVQP6dc5VmiLSSaRJYZ6kPyjHGuXwRXH0l6aDK+Zs1FUSw3?=
 =?us-ascii?Q?rZGU4A4Xzp7oMa9hlaBxgutpB7MfEbjiFn3MVv9OC8l6mlPz6uM7r1qEvKrs?=
 =?us-ascii?Q?CXs7dea5Ytj7idpHTrVM3teTwsmhvc9G8/osSd5XqIKO3RH2qU2PMTB9V6BS?=
 =?us-ascii?Q?ToAGKRbYPuhRKg//UbNC4p09YJJek6Y4lN2jKXk2yWFEj04ZJwH5ewODEnqT?=
 =?us-ascii?Q?RLPjS4KAQVqD1ItEdH84dlzWjQj2zUojODgbeHJYElzVg+xesIgJMawfUqHG?=
 =?us-ascii?Q?rR4Dh+pZI65aZKthJccaEcQy6pxmjT9xxcsZQBloc4Xvc0xKg/Un5LLeJqKR?=
 =?us-ascii?Q?Utoxj+QYkfIbJXbwUxaD7pAhEmZZNkJYZg5+nOjHjBzHPvFnFFeoBhfy1sV+?=
 =?us-ascii?Q?JElcEVEFvYu1bRZq/PmtwfY1Y8TqYU/QqnB7vlVscUrZ1kx6wf47AV3Q9BgF?=
 =?us-ascii?Q?OS8GnsSKy92Ny6/XDwMrJu5CLBDTlby+ihZtJYDYocfr210fwTX8hXEsqT+w?=
 =?us-ascii?Q?HFEjO8U/UrLiSAGitX7ZGxNQpEdiRy40+mquXC6EVsEH0fTYKHbIKmACesvK?=
 =?us-ascii?Q?lNNdpmk5qiV/T0C2MeooVkdfPwFUAD9ZrESN/3RWdx9zElO0UYiEjC28OfPK?=
 =?us-ascii?Q?lYtJj5Z9tz2aw3s4q2mZmyIPdoKywFZFPxAm6LR1O6k+gKLTqibYeouQf5js?=
 =?us-ascii?Q?Y1kK4888NxxhIjX+5BydtyhoRj9YskAKQINPX31TQL7WADmYZTg9/lSMAUQ1?=
 =?us-ascii?Q?UYhf0olekhxTmv6ZEAkL3wgwRzJshfYmwQLnZasXZysx/PILMWxtnZ0URHZz?=
 =?us-ascii?Q?cDXnm3cWXXaWmY3VEAxq9N2x38ehEqltAT8HXw6yvEgxgHB7BiJ4IRhPAKrU?=
 =?us-ascii?Q?hDa34ke+mJ5Z2NL7R7gjRg/UAnndMs2EN0mNz1Ik0Tlv79IJ+P5J37atyXYu?=
 =?us-ascii?Q?aMIZhRWEdWjkVRtiNoV9B9ZWIzRikBNNwZ95v4ABVURURBHARZ9A6+3skZzL?=
 =?us-ascii?Q?NMMQTYcxPY+fOm9dpgj//0HJMeWXHdo/c350aT21lB6aW6mEgAWtf3w7bZgv?=
 =?us-ascii?Q?SB8+oH62Ccf5ft0FCe0o2CtpRMXqlgEA5zDMMcg53HG7wGYHG72AHe/M5sXH?=
 =?us-ascii?Q?Y04xf1k4G+nbsgUKJHdFU331nfl6df0nuyiUXV1e8q9qb+DH81dDFPgXNsjg?=
 =?us-ascii?Q?9ib9MMg/W6pyDHWSlg1OmJrVh4WVbBdGQFKDtcAUfox7RYfrdNmkRTMWhxtj?=
 =?us-ascii?Q?q9Rg8phG54NbyI+u9+DK0edhdQ4E/6xSr1FzDlrE41xK6JvIp6kZGQpvCsv+?=
 =?us-ascii?Q?o61x1sJK6Mg2PtUfJTB5QSuwCsSPOuHcEsjTVx53Nl/Oc3Cj+YR493cbw5sv?=
 =?us-ascii?Q?08M2nG4tKbASKyOKepoZpo359bP1Efh1nQz+nJVxnPwgvQfu3MOqN2L8DtKp?=
 =?us-ascii?Q?uaiZ8o8GXp95Dk2VQRMb7n3T+HQncnVkxuDzoJ7+PMhV5iNOOmJdHJwGSeFF?=
 =?us-ascii?Q?iffyAS1R5+NjZPlvh9h3nZaIINSv4AuSRM6g0V64ibM5wGhb7UdkSoaTLVmS?=
 =?us-ascii?Q?BVBatKLyW1Nu6RjJcCyREqyfrh3wtQpOYH6biOI4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f40dbfe3-7071-459f-9d20-08dbfbe29fa3
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 13:51:36.4037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4a8kAMsROYqpvp30KBrLcZLNULcmnuwZcdWil0Xj33Dl8IDRrpmwYbo+Idqf4aX7k+Egd+1hxX6BaG9+OjbdsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8723

On Wed, Dec 13, 2023 at 02:08:55PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
>  # ./fib_tests.sh
> 
>  Single path route test
>      Start point
>      TEST: IPv4 fibmatch                                                 [ OK ]
> 
>  ...
> 
>  Fib6 garbage collection test
>      TEST: ipv6 route garbage collection                                 [ OK ]
> 
>  IPv4 multipath list receive tests
>      TEST: Multipath route hit ratio (1.00)                              [ OK ]
> 
>  IPv6 multipath list receive tests
>      TEST: Multipath route hit ratio (1.00)                              [ OK ]
> 
>  Tests passed: 225
>  Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

