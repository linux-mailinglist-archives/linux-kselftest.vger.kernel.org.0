Return-Path: <linux-kselftest+bounces-45989-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAB9C6F81C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACFF04F86CE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 14:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1752E2765F5;
	Wed, 19 Nov 2025 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="djcYSUtE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013062.outbound.protection.outlook.com [40.107.201.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61624C133;
	Wed, 19 Nov 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763564126; cv=fail; b=cbPTTXta6n4GY+xTByHRGz+G6z6QKP1taVZY4/IpOJBgQwQOHXGMSZScAZyxEfLF1yrNlfKgspREv+rXCl3btvaK03Dz5LtcGRv05wlAxGRE3jbtmq3t9EFCqP1NW8iX1elX4y98LTsXmAibMQeDi6OEZxMsgEYwb1ECZh60yfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763564126; c=relaxed/simple;
	bh=pihqpKIY6b9vFD/Tsfho/JszANUmp4BWZFq/SBhi7t4=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Mpiq6gl2pp4KLvbH9FNJg4FNHvltK9eZKvRJsnxJuJfNOgZxr4FlQGDXV0JapNkb+T3xJBH0ey+aeUYCOHPs/1NenEoMMQWfCgzvkJQqNAMVziyL8DWQCMyMFlbK8EikUECAnZj6ECkCJMSNRCH1bftRM5kQFSJh0psZU0MM+dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=djcYSUtE; arc=fail smtp.client-ip=40.107.201.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wclMEuTJmZ2yy8aFkJ4ihgCJuUyL8jnIgsKNj485iVKefer9EU6tc1LU2+AoWOtUNlP2ti21fjVpzAf5Z9VubYRJ2bstd7NvnSgqPsPTCNEf2AY5wM4DLtfvEmvVJ+GEHLkdqc/1riSU7u8ZexTIZHQ3V/Wt4k0wdXCdCdPDKVEoqzVRFXFCwj9HYZmgsxO27bRg/RpnG1pHRDs6nXgCyNTQsbdMV9tyfIFylSK3mZZwuFf8qeiix3WgUe9yqqFVFtdkv8qUoUMYwa6b9l5VrFL64D2xTd3yXiTPxqX2evcyTvEAocwdtax91k7R53Y2lx5P69LK4gox3COh1PzVOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+tT70b5AfeRzKX/vo5NhxFKbaZRejQ8p7yVbqWLy0OI=;
 b=XbtosCZU0HRBltX6h3MPIFojowsTnMBK9U7Ek15NqwuzR0+P6GiV0b3UFXIugfJGjVCHxRY1fgsdyxZvQwBd66zZ+CEPK+SEZbqH7Veqhxclf0dJXGWW54mixBEXmYVQjgoUOgLR1whzdTqxnLs4zLdkPR0HXH8IRz5wbYhyYhzd4xQcdj/Hl17fbzk7+wfI1k2TPSF9hVCSivZBgTy75Vfckf9YufSBIYNJrjdandfK8H8ai6dnw/ANbVwjO+V/KF/keuLb7lc/+NrkhOpqMHhkhXjUNDSgbszt/fdkx5eMIbORgs0hTl4/5QgsYDk56kXQYQ2sfHwfTnhn6Tdk2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+tT70b5AfeRzKX/vo5NhxFKbaZRejQ8p7yVbqWLy0OI=;
 b=djcYSUtEWBRNEOA8QzJMM4LAHFG5QFjP89q+1SCSPueIli/3iE4YNGDhcJ0GG7gvuQjaE6MREXJmkMRR5gPOnrUf3bquEJHVw4xOwJJQ/k1ZAcU4LSNCNS/NMWzgiaXLY4qaNGG9mg9CL04LtrfdEuqSMDMsvT9R/eO77ZDm+xN2yrllTo1xuOslzVbqvr1wGQEjX6tllQWxB9wAByiqNDiYXwStGmFGA3O9HUZ9pCliGYN3/CJ8HlDbrfc80XwTy3qVVjEXnkounLCDCapdAEAKm2OGIGGCKnADW5fN9XrSiSGUvRa4epzQXJeOJ0/wFkmsmddTzZNBfvxSYveYDA==
Received: from MN2PR08CA0017.namprd08.prod.outlook.com (2603:10b6:208:239::22)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:55:17 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:239:cafe::c5) by MN2PR08CA0017.outlook.office365.com
 (2603:10b6:208:239::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 14:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 19 Nov 2025 14:55:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:54:59 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 06:54:53 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-4-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 03/12] selftests: net: py: add test variants
Date: Wed, 19 Nov 2025 15:42:39 +0100
In-Reply-To: <20251118215126.2225826-4-kuba@kernel.org>
Message-ID: <87ecpucbt7.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb7fd3e-8e98-4ccf-dc6c-08de277ba786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Edso0fMe9qn0tA3VxL6YUhAk6FghKYYdCUgr6IacK+Xx+GbYFXu6/jO9yhxE?=
 =?us-ascii?Q?kRemynqKXSt6XOhEroRE4s7NfhSpZUTkPePB/e/s3KLkxFia8kG1m42of3Fz?=
 =?us-ascii?Q?ZJ8iG5im4fNxP3RXMsCw/YJsSjcWZ7R3/sAe1GX3KPGjaWtZWOWLXKWRujei?=
 =?us-ascii?Q?MiZr7usEOTs7mKRB0qFHUTriR+lRtym5KoDvTXx5oJXQMnLS2pHJf+IgJdgw?=
 =?us-ascii?Q?Qw4GFyB9sAXTG8Ih2KSb+GtA2Oqomy8+JIG18sZf7FPTc7OxF91QOTRi6uU3?=
 =?us-ascii?Q?fqy88SvmCRAGu1YwZaJBFlycYXBrwDhnRJrS31uc7orrkYFUu5rPCR+hUf/I?=
 =?us-ascii?Q?u70KtxFbQJt4DF2pQWAmpH1hDRbKItD8SCaG95JHBYYJBk2/6FOJvVCoQFOy?=
 =?us-ascii?Q?ThwBO1rNGJOydMiyPU7im3Wdt46IP+7beDE7y5rji+EeafiE9w/f55FHZciM?=
 =?us-ascii?Q?evmus1qZmlbdnZLp+cNeX6c/HFyqRr0fdsTqp+Ae+TfT8p8u44tyozokE1Rn?=
 =?us-ascii?Q?JWtF0UaFXboNxXj6FU4LFOdZbIAAI/llfOt8fZswuVI84/Du//UMwxaJBsNC?=
 =?us-ascii?Q?uceyY9Pahz1NwVUPi0gDOU3cb5nxkx6vdFNG0IEkDK65Ks3SpeTUw67WPdZU?=
 =?us-ascii?Q?jrrTgcVTgaTcwBpzyGWOvlNqofgWsm3fHsxdh4VmoEdXUWDomKWh7pgkTTMT?=
 =?us-ascii?Q?FFCvqRSUNp+hKYUEVy+btK/7yryGawJuP/5e2se7WTIqn0LPWxd2q7myZ/Hy?=
 =?us-ascii?Q?SYsCBa6azXi/B566vLbkBBQB1dlchHWuoh2FyYuIRiXC8kec0GbruTWloJ/Z?=
 =?us-ascii?Q?tpSnBfn0qFIipta3V3CuKLeut+3UoWm29JBFtZNf5Q24rr0Khfztg2pXgBAY?=
 =?us-ascii?Q?CrQGMWuXgvtthJUHtFS59Oda3AdQPlV5PthOCz/KHhs4zoI+d69q0nIE7iPH?=
 =?us-ascii?Q?/2Ja2OXaLABK8NKGBNBYC+/ID4dGt8MDaaF16edUBoacGiwMfbwSD4vO/XGm?=
 =?us-ascii?Q?VrCZWwpXvs+flE8gdIXGUCQq4xM7P1EuPZpnnJC91aIsPASdd5wxHCzQvKV+?=
 =?us-ascii?Q?cE6PmawxrKYW/5B87FYIKWzNHqnVQRqOLHVWDwk7WgCHzuWyH+YM557WbRGU?=
 =?us-ascii?Q?wp7xkObE2UME3sWChnyFwola/hunEsagpIVDm0NL7qbsWDydA9ZbGEign9Rh?=
 =?us-ascii?Q?C/hu6jGEVkzkHuR9vq//rIza/FKsG/PylUo5v0nlpq59pIiAnbRjwDWhiiv7?=
 =?us-ascii?Q?t6iKJOS+185elV0jDPOMJ+mfnduGC4RuvTFMSroBdZOfOfk83p7QX7glLdZa?=
 =?us-ascii?Q?cshWoLYCEbZT+JBuoUAffqWBiT7VN4lVFKKytRXDuOcNeIN+EOft7r9Liuv0?=
 =?us-ascii?Q?r7JZkCcq+fmfuo7X1u6v6VwlgrYNPebc1FAC/40TN7x2OXfjWGY8t8rJ3auH?=
 =?us-ascii?Q?J2ngaNsS+aqGrS3OI3EUxeXoDwq8MjgFVI3TIUMCY1GrdBZ2F8pyTqCrw+Fb?=
 =?us-ascii?Q?+jK+XEHz1f3+1kkm16wvcYBrhvSf0GnVnzkFOKyi9ukzQsP6S+LGmqDa1aRc?=
 =?us-ascii?Q?NoBNnd0AnAvg/7r0cKs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:55:17.6448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb7fd3e-8e98-4ccf-dc6c-08de277ba786
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140


Jakub Kicinski <kuba@kernel.org> writes:

> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 52c42c313cf2..47e0af210bee 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -185,6 +185,49 @@ KSFT_DISRUPTIVE = True
>      return wrapper
>  
>  
> +class KsftNamedVariant:
> +    """ Named string name + argument list tuple for @ksft_variants """
> +
> +    def __init__(self, name, *params):
> +        self.params = params
> +        self.name = name or "_".join([str(x) for x in self.params])
> +
> +
> +def ksft_variants(params):
> +    """
> +    Decorator defining the sets of inputs for a test.
> +    The parameters will be included in the name of the resulting sub-case.
> +    Parameters can be either single object, tuple or a KsftNamedVariant.
> +    The argument can be a list or a generator.
> +
> +    Example:
> +
> +    @ksft_variants([
> +        (1, "a"),
> +        (2, "b"),
> +        KsftNamedVariant("three", 3, "c"),
> +    ])
> +    def my_case(cfg, a, b):
> +        pass # ...
> +
> +    ksft_run(cases=[my_case], args=(cfg, ))
> +
> +    Will generate cases:
> +        my_case.1_a
> +        my_case.2_b
> +        my_case.three
> +    """
> +
> +    def decorator(func):
> +        @functools.wraps(func)
> +        def wrapper():
> +            return func
> +        wrapper.ksft_variants = params
> +        wrapper.original_func = func
> +        return wrapper
> +    return decorator

This uses the wrapper() merely as a vessel to carry the three
attributes. I think the idea would be better expressed as a namedtupple

    from collections import namedtuple

    KsftCaseFunction = namedtuple("KsftCaseFunction",
                                  ['name', 'original_func', 'variants'])

    def ksft_variants(params):
        return lambda func: KsftCaseFunction(func.__name__, func, params)

> +
> +
>  def ksft_setup(env):
>      """
>      Setup test framework global state from the environment.
> @@ -236,7 +279,19 @@ KSFT_DISRUPTIVE = True
>                      break
>  
>      for func in cases:
> -        test_cases.append((func, args, func.__name__))
> +        if hasattr(func, 'ksft_variants'):

Then this could just be if callable(func) just call it, else the complex
processing.

I'm not married to the namedtuple idea, but I consider using a function
as essentially a struct wrong. It should be a general object.

> +            # Parametrized test - create case for each param
> +            for param in func.ksft_variants:
> +                if not isinstance(param, KsftNamedVariant):
> +                    if not isinstance(param, tuple):
> +                        param = (param, )
> +                    param = KsftNamedVariant(None, *param)
> +
> +                test_cases.append((func.original_func,
> +                                   (*args, *param.params),
> +                                   func.__name__ + "." + param.name))
> +        else:
> +            test_cases.append((func, args, func.__name__))
>  
>      return test_cases


