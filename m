Return-Path: <linux-kselftest+bounces-1288-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561B8070F1
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75C71F215B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Dec 2023 13:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8996939FD8;
	Wed,  6 Dec 2023 13:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uEQrIz4u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C7490;
	Wed,  6 Dec 2023 05:32:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d53koTP9jBtOD4NaB53K53PvMdsIyODHogrZ87ePkEH/j5s0BAw4NBk40Wn4jL6Mzs5esT+5Ccdxc08jrSSjUvrrG+XOO6B2O5y7ILAAeJHSukCeb/UIyjTDdkBUAZl8IsCfu/zgXm/p3Xp7woaFZh8kd7Eo6Vx7Z8h4gip5GQzcU05VejM0jFO4jeEq4dvMUxYS158NjFVRp826GbsEIZivBwGlS7akmLpEKBJoWcjilT88jhssRD+2qBAepkOVesuDjJjitIphlSHASfzHb0giSkrkSkL2F8tpTB45SkREmRu8H1H3UF3dft1MOlmr12T5p25tXmmXXM3PL+lhCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0uSQD/lPkWspTnCXxeY++O1DGE26uUEFS7p5YB+c3k=;
 b=IUULcaEmqGtun4M0UBMA57a2Z2HKRASr1NAZkbKGgKW5tZYw5WabEuPGRzIzVfFQxOHmd1bx+mWYEllgs04ic9mhNkzhseBdt/bVlMU+jhOmFp6hnSxuFGs3RAUPT8TWM/9G0SAE743SjTlsLkaj3XXvTup7PCVZvo2Lbxd88rANMFYvATOiWGZZ7j6Ay9TY3iHVH6ot3DjqLVBx5ACYzhX+M1SHEXG5DHt4UruBj7gvvauzYQGwvkfDazTH8RPk0IyWH3gjghLoId4QY+VPSVBp1Uy9o3idiXXDSVPbuqePlkOJIiW92UbUazGhfJGUtFcpv2+nhIqP8S2Wy96LTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0uSQD/lPkWspTnCXxeY++O1DGE26uUEFS7p5YB+c3k=;
 b=uEQrIz4uA8Wcukg4akc44W1Akz8Q3F2P1vXyccX5niqw8aUDW5HMO2LRHZDXcDGW7i6J+Tfq9oVONZ7aJfJpsS2raI1/mzGr2yexCBoR5jThcJHSOBQuNA2UGuxNgTU8YImwdNLqukJnmksypgujf3C2bJ8sJKjU5zxaWxoCCrxiNsXdjWr1pZtRVlpyMMhSC8e2561SGwwNA9jTxEbh1myIqbh4oT3MKk9quuB0poBubKSGc2q0SOxAhC7x0+DKDlsAdN+qh4JryvuDJgeinqAOlJfkaY62VDkzSniw4vU+IunZaB7lsBrwaW0jsdwbPQ29HqIuiApI/8i6LsQvrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by CH2PR12MB4231.namprd12.prod.outlook.com (2603:10b6:610:7d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 13:32:14 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::fef2:f63d:326c:f63f%5]) with mapi id 15.20.7025.022; Wed, 6 Dec 2023
 13:32:14 +0000
Date: Wed, 6 Dec 2023 15:32:09 +0200
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, David Ahern <dsahern@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Vladimir Nikishkin <vladimir@nikishkin.pw>,
	Roopa Prabhu <roopa@nvidia.com>
Subject: Re: [PATCH net-next 6/9] selftests/net: convert
 test_vxlan_vnifiltering.sh to run it in unique namespace
Message-ID: <ZXB32Z8FeGoMdAwe@shredder>
References: <20231206070801.1691247-1-liuhangbin@gmail.com>
 <20231206070801.1691247-7-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206070801.1691247-7-liuhangbin@gmail.com>
X-ClientProxiedBy: LO4P265CA0129.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::20) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|CH2PR12MB4231:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0dd1a8-f804-4744-b662-08dbf65fc204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NEVrMOGXijXSnKO9VfxmElB+OzhqN1XNxj+nyhkfn015YkHkXYdBqeJ1wCHoPCQF7VfWAn1RZIEGIsZQdo2tR85ONTDtvGm9ymJMYD3ulqB6gWdo2NZhasljPe/jne4N3zEs6AXhYDIOZRtz/HQWRhaemyRqr6jP779NyDbHnyus3AHO1Lvz1XQKekenL2TW/UrkTs7x0AcZsHGLJ3V4yWMIzPpX/kQbrZq2CTxA6TK4KaK8NLQB4SHKpVVuHqetquxUA6p720fHqIPUuDYegGK0p1Y5O0I70nu6Hr91iPWU2a6EB4EdkLwzPnhFFPDPNh0lk/PbnEmKNtH9iOmfKvUDjyw7j/D/oVW45ydUgpRL5dtMmXtPY/vZJwb6S6a62LWxrYk7CUx+MNRj52Mho9OdQZ1qz8hYViZL2qJyUOr5Qjdj6TvNKiHnuMk068GZUzbjlPb+IhDieqjU70tnuAZqYN2Mwn6QTF6DyJG6CgWJ9BSrWF6pH61sjKQe9TV2/Ylsju0XpH5fnF/MaAOd5SkQUW+1/jaCAgdFb4wng9o3e07/0X+hEilgjxZ7j6T2UugFgqp5ww9EciJmNVs9bEYBORUEFA/r4Oo71sSa49LrGaKo52ISjNClEqpb0On9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(366004)(376002)(396003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(86362001)(4744005)(7416002)(5660300002)(2906002)(41300700001)(33716001)(9686003)(6512007)(6506007)(107886003)(26005)(8936002)(6486002)(6666004)(478600001)(8676002)(4326008)(316002)(6916009)(54906003)(66476007)(66556008)(66946007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Fe3yQVrEJjq4L2WBqy0rlsuLLE93aRDTPJlkaLvkyFRtgw/wgRI6+iL5u1Z?=
 =?us-ascii?Q?Ya89kHnkozxqMsY9usy12rjMs1tBLlxnraVqOxELAl3tpriOt5tFwG5rjycy?=
 =?us-ascii?Q?+Zhb2i/BWLeFtfVzMWirPib9nh+68m5iXOK/wxn8sddKbIG8Sgi3UdYALwaN?=
 =?us-ascii?Q?1FS6zjS29y8HEth8FMm3fMJ9o9qyIXR5K5AsLIAozsIcMMf3ffge6c0SzlpX?=
 =?us-ascii?Q?fh+x46lJ+W8Z1VUz9YdpedYaJ+JSCF+u3Sf9R6axOC6P56NOrCmISdKU7Dv3?=
 =?us-ascii?Q?MCHO2JGuj2QqJ0/1zIJ4z+0Ds2rjHNIOKiDq8zGbqhsSozdmVErxXM4WgdCc?=
 =?us-ascii?Q?KPBxw9S8khlCFKFPOSm/5aqM9ExOMS7unrBuoPk8SRcSB0UsIAuz5yRNYw3S?=
 =?us-ascii?Q?Vu/aMi/0nxoYL5wVmCdxGxlVbEeG3LGBKbRfLEioPe+DO8IGDNKPY5xr06WZ?=
 =?us-ascii?Q?4dT7LfiSZQQ2CLI0gLqpDy0vN2yMQI0nW4JwB1iIkrUymzZxSRSXVgjQuB+p?=
 =?us-ascii?Q?hSv+euz7l/qxro+zOWPZ3YcLFW292zAsI1H0SwkpRzQtQJ1GIPWMV7kxrqfV?=
 =?us-ascii?Q?aK2BiMn/s0UTcYe4SKCJ2JdVMkoC/tuToWR6Bq4OMKFkoe9icJQoWcJjJjTH?=
 =?us-ascii?Q?acXdqq0LCzb6h8eoG+P+czoEBKuxrBwpkKpPPgEDWUFetiINqoq5J6X8/PTE?=
 =?us-ascii?Q?ZrIUMIjVjUy8FfTuNZqKxMzGrtVI/7VVNwT73g6JMrzE3miFoFWx0NsZvJLY?=
 =?us-ascii?Q?WEmsf1XMJ2d/IBGt9jvpr+FDwKWmO7xCNH1YEj1iAI1WnFdJ0nbFjGi8t8St?=
 =?us-ascii?Q?yVrsnt5wc8AWJAFGZMuRyZ+fT4OlsMu7eOS+Wcmb12y+4ytYgw1Ya9o5qgr/?=
 =?us-ascii?Q?zWf0cply95c6fhF3IcgHBx7m+us8mweqnvL4IHgJ8Ky/OlqG16FIPDhv1pau?=
 =?us-ascii?Q?Ak4La8Qmg6zrVr7/UkeRn2tjNLOeg1re3MWAA94GL0V2THHVspHCUgl6ZcGq?=
 =?us-ascii?Q?vMV72ZIMlqwa4xiuQAHk46eDyQmaCT8nDXp1qBSz9S9mi090s1hC4V/8oMm8?=
 =?us-ascii?Q?FgbIGDWEFnpXVWtWxAoTAcppPb8QTYDy8pK6XHhHrcEL3mXiOdjv++x2DrZa?=
 =?us-ascii?Q?VJtTnXirXlE1hLvVY2R2D4amC7vhsckfIH6o1s9dakM+WqqjJ2Er5t0wPBNx?=
 =?us-ascii?Q?29hu0J8qRhCfjE4g2A6OXZbsko/j4pdbw5EIB597XttzlTNvr2PLxbJmbMaC?=
 =?us-ascii?Q?DBkdtjNlq7iTLjTQJkfuygoYaApwvcUNBMWXXOUefUYvikrMfQJ5VoXPYsOF?=
 =?us-ascii?Q?L0u6mlSSZ5+eTJm9DlelT0JEVOv/LsjdsDmfVMNTnhgVl6teRDrBADIqUiy0?=
 =?us-ascii?Q?KBDlFjxPdGb7Iqy19LdtsvaHCE9D0NikxXMKbPPkgp08GiyUvoUhrckRjCRF?=
 =?us-ascii?Q?KB2hAaesIs3AttuLckgoI9Gwi52asMX/WOM6of+NsfvaGWOW/ycl+jBu6I/O?=
 =?us-ascii?Q?tb3Pm7aqMlGnrDXkI+ahINFfKDPPG+ZINAGimk1xPl57VDTGgLgi0pORZEZF?=
 =?us-ascii?Q?4VFYk59B+fHVJF3fyMx+UyL7Kc1DT4IchrTzVGnh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0dd1a8-f804-4744-b662-08dbf65fc204
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 13:32:14.1934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DK9/D43u23j4BnvRvmAAjIpKl6gori+yO7bOYR+24/4MQBdefQAOPEAJFFg85TaJgsANbkDXe03EZTkXgXmvDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4231

On Wed, Dec 06, 2023 at 03:07:58PM +0800, Hangbin Liu wrote:
> Here is the test result after conversion.
> 
> ]# ./test_vxlan_vnifiltering.sh
>     TEST: Create traditional vxlan device                               [ OK ]
>     TEST: Cannot create vnifilter device without external flag          [ OK ]
>     TEST: Creating external vxlan device with vnifilter flag            [ OK ]
> ...
>     TEST: VM connectivity over traditional vxlan (ipv6 default rdst)    [ OK ]
>     TEST: VM connectivity over metadata nonfiltering vxlan (ipv4 default rdst)  [ OK ]
> 
> Tests passed:  27
> Tests failed:   0
> 
> Acked-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

