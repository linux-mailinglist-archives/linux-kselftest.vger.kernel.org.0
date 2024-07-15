Return-Path: <linux-kselftest+bounces-13722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A559312B4
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 13:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5835B216DE
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Jul 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D708187321;
	Mon, 15 Jul 2024 11:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yw1LUnTQ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C05F23B1;
	Mon, 15 Jul 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721041237; cv=fail; b=KmqadARQXZMoL6oxai5RYKN9IsLp1TMo5kkEPEaIRKP3/8GSlj17RoHcUzk2EJxP8OSZJlprQI/bkrx/HzjFERFxZckERFMQr2FAnYMvjVIksIZABxGDelw5eHxhvQlsinrznqTk1MYwnDFyvnFdJ/Wxog8UOZO02nnwQLeooyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721041237; c=relaxed/simple;
	bh=p6Ae4qW+Y2cA5pgaRD7Z86F3kUmhorhlJKSLNXsrAZI=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=fRlkaVNzhyZMi7yehR5JWPNlbMllPYMU8sR1efcI48Q24jHVfgUPTSAeq1Nv1nBDR2aBIFvn4Qda3ahVuu9IaNNmzoL6okRrxkbvS+GroVqfmFJXXlvvyGeVqu31z13UC5Xwqo62OXNQnMM4P+htj57kjSFEJdgINhlRS8jLYw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yw1LUnTQ; arc=fail smtp.client-ip=40.107.237.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b7S6q9UHSlHQ844hkcYsHtik+ENnu1z8v9aDBJBJz8PIT6De1HIGdTga/pKXOK7MmmNOcX01SMIF5GM3bz2AW75BWE/SacgfiK8NuNC2lmvmlV1dl8Y7m/8eyIVfgRwNdrZVdB8BR6h4dtoqp/nvfFcoVNvMndPVYq2EukeSVD9reFrNLwuNW/IPEKZuhD4gu5YVsxOTA1c3DO7Hejx+xojXfHSomPYKf2u3nAJXCVBNYiNXr6seYqc2x5PStSI+Cop3d/1MNbFtQy4PFm40m/7mahCQSv00kW6gyhc+gIQbMhQOHUaf8elhoylv+vgvfcAhdF/M+LmeZR0269Vsbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EHkITvxMp4UUzhc8nyT6G+vGbiWfEMc0El50cZjjPY=;
 b=ydKCHgKvt0NkBRWcNN8VjRF3mzGkZAx0LFs04ZsYhwjQPs4XMRaz0QwQLMc7ctLk5TdDSg80Y604eBdQPSzcbU8RYHd3jkxSsgFExNdG2wW9g817Rw8ofstVhPVSQzucjgHqYT5ETgeOBbUXNCXF34V/RQuucci+ry48wfZzuOD7KjznbOsBIK99R7Nug4MajYXC6ogUhI/QkpNDGnBwizS1JlXSooE5Y4k0LhVEGvjJnQ98YQganj+EcGP9mDkRvHsCN9wXtNw87QHKBi1TU2am47gdTMvztSvmsqIlMktGSiJKCGwkBNQcZyAzvoAOzjGoSvDm+ZpCPl7H6y/yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EHkITvxMp4UUzhc8nyT6G+vGbiWfEMc0El50cZjjPY=;
 b=Yw1LUnTQNwNewvEd4glw5KYi7hv+vdOEqdxsCFVlSyK8Kj2BkX7/mmsmylaPCx/VG39buWLtIWE6dPGxECgHoY39Qgj0Iko8Upfk6RBm9DUjF4wgxQBqWF2h72CvYQFGMq90PRTqulJa4DLxYPX/ehuob01EdWigi9vBAUBr1fNslOpSUBXy8hH3eYW6aTG/4k6jrCYtcXghtaYjsEQ2bKlMaLFRvoXl5z5Dyf0YrGqtqxxqn+yvHXt/IukdhNJEuGdzkYTrx3H1CBGrQn2PnVyX8nyVO2xdr5X50LeHURDOIgIBdNb+nD5sevkNVk28xUwIiQjvNZt7REluEFn6/Q==
Received: from SJ0PR13CA0160.namprd13.prod.outlook.com (2603:10b6:a03:2c7::15)
 by MW3PR12MB4491.namprd12.prod.outlook.com (2603:10b6:303:5c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 11:00:31 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::da) by SJ0PR13CA0160.outlook.office365.com
 (2603:10b6:a03:2c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 11:00:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 11:00:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 15 Jul
 2024 04:00:14 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 15 Jul
 2024 04:00:08 -0700
References: <20240715030723.1768360-1-mohsin.bashr@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <shuah@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <petrm@nvidia.com>, <dw@davidwei.uk>,
	<przemyslaw.kitszel@intel.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: support verbose printing,
 display executed commands
Date: Mon, 15 Jul 2024 12:45:58 +0200
In-Reply-To: <20240715030723.1768360-1-mohsin.bashr@gmail.com>
Message-ID: <87bk2yrkcs.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|MW3PR12MB4491:EE_
X-MS-Office365-Filtering-Correlation-Id: 471e0585-5d14-4565-40aa-08dca4bd57d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zzvi1KlFs3WFF/OL64wVPqBS/gq6KIRDOuRXYrgIZc07C4maPeRYIG9cLDvC?=
 =?us-ascii?Q?7LWS7Xx7xuAKDEfVG2XmWZXk72ofXNlmNFPtQTtPGT9QSJVnuAT+sCuJXQNi?=
 =?us-ascii?Q?VwPMSgDZGmHckPQf8Zqoa3eL1Ayla8tkT6VPJJwkHvEou7sJW3/BruJ1LW1x?=
 =?us-ascii?Q?X47QbL8IRDowMW5c1OeRNw18IulioA8Mh94d2eAK3YuuXyntTiipBEpW+hGf?=
 =?us-ascii?Q?8hq+vZqf2mIAhrzxSvx2BFcYrkylcmmlDUqqao6lb5zasaTwCywUkIP/o+0V?=
 =?us-ascii?Q?X1Yi3hDibiCJjx4p8FgALNAZME/w4mfCOZJo2owGaptdFCIOCajFTkn3Q9z0?=
 =?us-ascii?Q?s2/aeZ7APp5HKuyISrXn87N0+g/okEu49SkbbP5M4AbBw5vuj1AiszFgHbbV?=
 =?us-ascii?Q?dt0XVql7C5tP6oR283riS+UiOOPDh9R3cn5EA8g/iUTNQP6WzqwnaSDIEJ9g?=
 =?us-ascii?Q?dF0oLd+1FbGWul0JzC84/AOH/26PxtqXysaaK2EhegGNslzEZFlPHtbBhJkS?=
 =?us-ascii?Q?jHBjrW/yfY3PWQrQWjcO7XpL9AzMYB8eOJri6logKxRvNIluz3Uz8PPNXnu4?=
 =?us-ascii?Q?XRj7qT5yySBP/msy/Y6/DZdNhhYn+7qvC6abm6tclK266gJqtXdh9eehIPLO?=
 =?us-ascii?Q?HgkHiC8KwsMWIdHYRjZg9Htuv1KgBRYn6GMW7ON6HkPbgSk8/L/HVDO4IYlL?=
 =?us-ascii?Q?4PBc4V45cLAN90TYIMSJlYMrU1hZkiYXZQ4Q0uvvVRiJrZPaQNnw4ey+mYFs?=
 =?us-ascii?Q?BANE2s9gZAXWKr5kogkIIRfrhno7moN0lK8zRR+rZR0v9v4eg7sylS2+9qw8?=
 =?us-ascii?Q?N3nOfOaBCEA73GeqqXg6g1bOjnS+KYbGycHEvN1fP3d4whhePkFhI/jpuHZP?=
 =?us-ascii?Q?e30NZpsIKLD6+6RdkBWNjUeIKvDr0cXMhrknedSTg2VJIzAWNi/EroppeL8a?=
 =?us-ascii?Q?SY/8XkvJKzq/l/kP0WuhsFDouhRqUnWxh1Fkkq1Q4HMMqjlfkPuqN/cWjpLD?=
 =?us-ascii?Q?RN5/yQSWvR3O1KlH2pQcpRtJa7k0eDbvAdKLDs+U1UZMJjqkt2U+YwwE8cu2?=
 =?us-ascii?Q?O5WrZZ75OdPJdQ0b9AM+G7LwgGE0q7GyQ5qeDIZKiv0biKqdrVBeKJYFM1PL?=
 =?us-ascii?Q?2Sud/bbCuD3EiAxXrAXBhEk7vW/RXTsDSZvkwK0Di52lcrkgDO8NgryVcFF9?=
 =?us-ascii?Q?gR3zz1Veke4vUHEUrY84Fbn9Lmur5FUPkOLWgrxhBCf6NIv9Eae5UKqC86AB?=
 =?us-ascii?Q?sgeVyO3S5VNG7mhl+71sSdsORQ7p3zAc8t4/JzTL9iAx2AUxROEyc8PvVxfe?=
 =?us-ascii?Q?XE/Mhk/0NfuVwyb0VpEVBIZhIka/CtEHQiIwemtSdieDub/MaBScnUmWwzDI?=
 =?us-ascii?Q?oEjAmkWCJV8IHbXO7R2J8GQXZYdbOMa/8EsTDQ7xUsI2+bKoO9vePdGZuC95?=
 =?us-ascii?Q?RmvWWqbyFhQJW0kEr7jh8qlh8VH59mdR?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 11:00:30.7688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 471e0585-5d14-4565-40aa-08dca4bd57d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4491


Mohsin Bashir <mohsin.bashr@gmail.com> writes:

> Add verbosity support to show the commands executed while
> running tests. Enable verbosity if either an environment
> variable 'VERBOSE' is set to a non-zero number or it is defined
> in a config file under driver tests as discussed here:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests.
>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>  tools/testing/selftests/drivers/net/lib/py/env.py | 14 +++++++++++++-
>  tools/testing/selftests/net/lib/py/__init__.py    |  7 +++++++
>  tools/testing/selftests/net/lib/py/utils.py       | 14 ++++++++++++++
>  3 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index a5e800b8f103..ec53cf59e104 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -4,7 +4,7 @@ import os
>  import time
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
> -from lib.py import cmd, ethtool, ip
> +from lib.py import cmd, ethtool, ip, verbosity_ctl
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
>  
> @@ -42,6 +42,12 @@ class NetDrvEnv:
>  
>          self.env = _load_env_file(src_path)
>  
> +        try:
> +            verbosity_ctl(level=int(self.env.get('VERBOSE', 0)))
> +        except ValueError as e:
> +            print(f'Ignoring \'VERBOSE\'. Unknown value \'{self.env.get("VERBOSE")}\'')
> +            verbosity_ctl(level=0)
> +

I think you are looking to catch the integer conversion errors here, so
just enclose that bit:

        env_level = self.env.get('VERBOSE', 0)
        try:
            level = int(env_level)
        except ValueError as e:
            print(f'Ignoring \'VERBOSE\'. Unknown value \'{env_level}\'')
	    level = 0
        verbosity_ctl(level=level)

Now instead of cut'n'pasting this twice, shouldn't this be the real
verbosity_ctl()? Call it set_verbosity(self.env) maybe, call from the
three sites that currently open-code the same.

>          if 'NETIF' in self.env:
>              self.dev = ip("link show dev " + self.env['NETIF'], json=True)[0]
>          else:
> @@ -92,6 +98,12 @@ class NetDrvEpEnv:
>          self._ns = None
>          self._ns_peer = None
>  
> +        try:
> +            verbosity_ctl(level=int(self.env.get('VERBOSE', 0)))
> +        except ValueError as e:
> +            print(f'Ignoring \'VERBOSE\'. Unknown value \'{self.env.get("VERBOSE")}\'')
> +            verbosity_ctl(level=0)
> +
>          if "NETIF" in self.env:
>              if nsim_test is True:
>                  raise KsftXfailEx("Test only works on netdevsim")
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> index b6d498d125fe..1541079fadce 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -1,8 +1,15 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> +import os
>  from .consts import KSRC
>  from .ksft import *
>  from .netns import NetNS
>  from .nsim import *
>  from .utils import *
>  from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily
> +
> +try:
> +    verbosity_ctl(level=int(os.environ.get('VERBOSE', 0)))
> +except ValueError as e:
> +    print(f'Ignoring \'VERBOSE\'. Unknown value \'{os.environ.get("VERBOSE")}\'')
> +    verbosity_ctl(level=0)
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 72590c3f90f1..4a59958649be 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -9,6 +9,18 @@ import subprocess
>  import time
>  
>  
> +def verbosity_ctl(level=None):
> +    global VERBOSITY_LEVEL
> +    if level is not None:
> +        VERBOSITY_LEVEL = level
> +    return VERBOSITY_LEVEL

IMHO, have a set_verbosity to just set it, and have verbose() below ask
for the global directly. So if VERBOSITY_LEVEL >= 1.

> +def verbose(*objs, **kwargs):
> +    if verbosity_ctl() >= 1:
> +        print(*objs, **kwargs)
> +
> +
>  class CmdExitFailure(Exception):
>      pass
>  
> @@ -22,6 +34,8 @@ class cmd:
>          self.stderr = None
>          self.ret = None
>  
> +        verbose("#cmd|", comm)
> +
>          self.comm = comm
>          if host:
>              self.proc = host.cmd(comm)


