Return-Path: <linux-kselftest+bounces-15072-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B3894D05F
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 14:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979531F220EC
	for <lists+linux-kselftest@lfdr.de>; Fri,  9 Aug 2024 12:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AABD1946B4;
	Fri,  9 Aug 2024 12:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CUw2dkSz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3817717BBF;
	Fri,  9 Aug 2024 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723207323; cv=fail; b=ttMyr3UK0mCMeuW0PveGG6GBQV41PGgApFjQxqRWPnzdJ1uSU5Zr4wAI5JN7xZEopwAAXo8UKh6Q9rFV2nQb0JL+hEz3T8Dy3iMnd+/pDp++Zr8lY8nfD4pgn166LOuqzMauPYKJqxlV5PdhVDtOyfpTiqRk3zjVwVXMmy6G7U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723207323; c=relaxed/simple;
	bh=1Sb2JDa2+GvAjwE5wHptupHvE/b6bFhESbqATNcbNi8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Iddvjg2PjUSDqPWZibYs0a9vmmvtG11LfEZQ5zd+ydUVD6La3PjcXYY2uOC0R33JzJuEmvPdkqm3+mk/QUpIOkx1doHRYnl+V59ttm6IzvrNRs79AYTGRunuL8MjLmRYTj6dRRfDxwOrcM5w9ilrwcfAA8bqh4atNq/aLMrgeOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CUw2dkSz; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Svj2QzklO85WISOvFEA4KlSyodyUeJ6QzJ9IbSCKKTV1MuXQCC3t5A8uBylWdR8t8rKeYbyHTtDMF4HKj2nCYmIZ1IwFSv4+ycu4mio7S6o+QpFljgk6MNuqbqpNj30GVdZRKIHMAe/r3uP7eGsOLURlBKyWNY8ZIsdK54CsxbLBsFe5ryVl0pKXQ4crV3wD5IhPFgSc5Dv+/2O5PyP8SRlHXbLISXo45kvuRO67gzEiw6oJ69PDxrhwbRmcKgwEnHdihg0jVgtnkg2FrUmVulQuedIqbWx7oAWtPrdPawQwY4Hx+q4qWzF2htjM9DGdnkuCj6wmQIY8a71NKMAnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k6U8AnFHhYc5GYUoDDwBAozX7pSH1Q/qlxP6P8+gErQ=;
 b=LYZThu/OhysQDSugQo1pBbynxpqPg9uPrK/LpCXFPWIxUV3IQIhVUErL9xNBkC12Fesd/UK8O/tm0uKzh2anL/zhhNZedE+/vqQme/RV9eHr7pBVXW/GP3vtXPUz4r3Z6YPuv0YOwLGOxAbeEHTOcmzn8Ddu/dCc9cq0bfxNA5SfontIPit67rTjKII4wdz3y8sU2/GxxX3fnbmnCWEME73J8glibT5SFDPzvdrXInWHpcAhoS5Pf604pu0YINifCLBugp6+mT7EAKOaADutOO2MjXxxKUivGbVftieZlaWknhGGAQjlfsfOAm8d8FSAVhFBOyPGJL2YWTQupdLBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k6U8AnFHhYc5GYUoDDwBAozX7pSH1Q/qlxP6P8+gErQ=;
 b=CUw2dkSz1aO/O8CONMLym1MjIDC/zi+fM5K71d6q44JsN0d+lUugoops+WlnCQGAH842+rFDp8Y0LHkNr7IlFc7X0MhnRMeTi5X7xJE6FCkwEFA0vsR1PLQmQZOMnPBMaGdy1JTH/0fxN8TBgHgDnKEQpZvd5M8KFewGA3lkegLb5FylHW6yROqyPnmO+TeTyRfpfgCWT2gr0I9SAc1vo/rDdMMfIWe5pUo3nxzOfo8+eaar0eBunJG4MvLegb6Ltz91fpNSbWbI/Ydneb1KJW28/Y8rC8jc3UulKxLTm1inX4Wi9QeTpV7vw5+PR6U4H6I8kjba9zEJiP0aOjJpcQ==
Received: from BN9PR03CA0793.namprd03.prod.outlook.com (2603:10b6:408:13f::18)
 by PH0PR12MB5679.namprd12.prod.outlook.com (2603:10b6:510:14f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 12:41:57 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::51) by BN9PR03CA0793.outlook.office365.com
 (2603:10b6:408:13f::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31 via Frontend
 Transport; Fri, 9 Aug 2024 12:41:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Fri, 9 Aug 2024 12:41:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 05:41:36 -0700
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 9 Aug 2024
 05:41:31 -0700
References: <20240807002445.3833895-1-mohsin.bashr@gmail.com>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <netdev@vger.kernel.org>, <shuah@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<willemb@google.com>, <petrm@nvidia.com>, <dw@davidwei.uk>,
	<przemyslaw.kitszel@intel.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2] selftests: net: py: support verbose
 printing, display executed commands
Date: Fri, 9 Aug 2024 14:36:17 +0200
In-Reply-To: <20240807002445.3833895-1-mohsin.bashr@gmail.com>
Message-ID: <87jzgpna14.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|PH0PR12MB5679:EE_
X-MS-Office365-Filtering-Correlation-Id: 04da7bc9-0bd2-4b3d-d697-08dcb870a791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIfXBb3sv2u0PCaDr6RJQUCBkltDr/BowXWAj1vcVWgTvcJZEZ0479gUmP2o?=
 =?us-ascii?Q?Xbievy7yIKNjDuh1Z/dLPsztGkludYSepqJmgksK9Ek3x5y+kcEpY0SknUMb?=
 =?us-ascii?Q?n1El4/3FopxEs3FNA5J9vyqZ8K0GBL5cxZ+9cTF2BqtACMtlI/z77uCVWj1L?=
 =?us-ascii?Q?J3bL8ev7Scb2KCLEUXvyezIqhB+TvVEV2ANLsJJgZAHg8n+PakFj0wf27yoc?=
 =?us-ascii?Q?vz4b+bj7gU+nNyoI5aZKB6Fu7JN9/Hyfa+mtD/nJellvfyPFOzYRYk0mFbs0?=
 =?us-ascii?Q?qrTUFlsI2oHNo1qLzQuM/cyTCY4Rj0xjTMtxp2u812rbX7syHKMFxvnj1wAl?=
 =?us-ascii?Q?8So/rDhI0oN2XJ3NB2G0aLHSrqU1/46RkDJ/G6FXB97o4G04T14P2/2tT3ED?=
 =?us-ascii?Q?8T1vb+972JazCOH8BpWzh38u8mYiACJFI69+EJ/ndYOW6n8Yyeeh0uvlj2TV?=
 =?us-ascii?Q?l9BM17j1PzGVouDhWBlK619OxXIOVvxviw8u5f8s+YiTA/Mhd0CX2W5MaJdH?=
 =?us-ascii?Q?arHSMX7yiEZ6oYDu8+18ug27PqiY+An28fGeu7XcEGTgeONw7UDYiLx4o87V?=
 =?us-ascii?Q?8TC8FEh2w+S+jODPfYm/II9/xYUPVjTL77lQ5PGCgXDUMutD0vG+P2WUBQrq?=
 =?us-ascii?Q?PTtRUfmI7A26LhlF0bRmIij6DLUBTi55rzHQPGLHlwRycAM+uiaQpM/1w1PD?=
 =?us-ascii?Q?A3QIv6NATqHx4PtnWZZvr/aajK7Alzo1nrChjvXRWAlKx1oEouB5NxlxaU+c?=
 =?us-ascii?Q?FVbMJjqRTc23TWAVG2ao3VTdIWXdXvvuaThIJd0TIu4U8OmIxiCSWzxZ1SLO?=
 =?us-ascii?Q?23M/LiwFkyKwPwRbXNjjHjiRYCkyZb/+YoJln5pc78nbR4VkacmlzzlErhVO?=
 =?us-ascii?Q?IPUly0PZ66H2d/cU61EBQXTWjciPPdJBQk+tkdDcAmHAx+/XdYQnOZdqNzCT?=
 =?us-ascii?Q?JlUWOTGdWNG3rIkICCAZ6RjgIjdZ3l6utgTNeUqPSEJwhGy5JFRRZmHl8YNQ?=
 =?us-ascii?Q?ncUMcjCDKCaX4H1WUK1HgIlizWHbbulvxrfxESuO9d/SYYMTjxVSJT9IItCy?=
 =?us-ascii?Q?YILYvLIV9TPeoZPdwbuMVsB5JJGq3q/V5hM67L31ZNaqGGbFACsn+goVqHK/?=
 =?us-ascii?Q?wUZIuU3MbVk6fY7comn8Sf+m/+nqjxrDvQkTbkbomQi6SMxXG5FXcWA4Uuev?=
 =?us-ascii?Q?Aeg0wP/x5Wdww66Ofu5KYdxmAMyfEaEgSCflpLFQgvEloJOrlfj6pEg4QYGs?=
 =?us-ascii?Q?VisFnlg7xVlGIFur9a06eO3SeC0/c14IkNivUqtvadQYmotWiNpTs+c+s1PB?=
 =?us-ascii?Q?94VgNBPpnevPs73AjHu/lkyCBoOW2EWHSKtCV7P5Jrz/4Pi2INKOCSEHxzuY?=
 =?us-ascii?Q?peMLrNGgt41sqgwCndOM6htIpQ3z64SWovjBMqTbneDkq05g6xuv6RWbuPPE?=
 =?us-ascii?Q?Sq9l0PWhEe+ZJG7fhMbYWE03KwaQ683j?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 12:41:56.4937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04da7bc9-0bd2-4b3d-d697-08dcb870a791
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5679


Mohsin Bashir <mohsin.bashr@gmail.com> writes:

> Add verbosity support to show the commands executed while
> running tests. Enable verbosity if either an environment
> variable 'VERBOSE' is set to a non-zero number or it is defined
> in a config file under driver tests as discussed here:
> https://github.com/linux-netdev/nipa/wiki/Running-driver-tests.
>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
> Changes in v2:
> - change verbosity_ctl to set_verbosity
> - remove redundency in the code
>
> v1: https://lore.kernel.org/netdev/20240715030723.1768360-1-mohsin.bashr@gmail.com
>
>  .../selftests/drivers/net/lib/py/env.py       |  6 ++++-
>  .../testing/selftests/net/lib/py/__init__.py  |  4 +++
>  tools/testing/selftests/net/lib/py/utils.py   | 26 +++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
> index 1ea9bb695e94..c7cf52d9b988 100644
> --- a/tools/testing/selftests/drivers/net/lib/py/env.py
> +++ b/tools/testing/selftests/drivers/net/lib/py/env.py
> @@ -5,7 +5,7 @@ import time
>  from pathlib import Path
>  from lib.py import KsftSkipEx, KsftXfailEx
>  from lib.py import ksft_setup
> -from lib.py import cmd, ethtool, ip
> +from lib.py import cmd, ethtool, ip, set_verbosity
>  from lib.py import NetNS, NetdevSimDev
>  from .remote import Remote
>  
> @@ -31,6 +31,10 @@ def _load_env_file(src_path):
>              if len(pair) != 2:
>                  raise Exception("Can't parse configuration line:", full_file)
>              env[pair[0]] = pair[1]
> +
> +    env_level = env.get('VERBOSE')
> +    set_verbosity(env_level)
> +

Actually, the ksft_setup() here was merged last week, and I think that
would be a better place to put this stuff. It already handles
DISRUPTIVE, it should IMHO handle VERBOSE as well.

>      return ksft_setup(env)
>  
>  
> diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
> index b6d498d125fe..eb4860dea26a 100644
> --- a/tools/testing/selftests/net/lib/py/__init__.py
> +++ b/tools/testing/selftests/net/lib/py/__init__.py
> @@ -1,8 +1,12 @@
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
> +env_level = os.environ.get('VERBOSE')
> +set_verbosity(env_level)
> diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
> index 72590c3f90f1..d475f131a598 100644
> --- a/tools/testing/selftests/net/lib/py/utils.py
> +++ b/tools/testing/selftests/net/lib/py/utils.py
> @@ -8,11 +8,35 @@ import socket
>  import subprocess
>  import time
>  
> +VERBOSITY_LEVEL = 0
> +
>  
>  class CmdExitFailure(Exception):
>      pass
>  
>  
> +def set_verbosity(level=None):
> +    global VERBOSITY_LEVEL
> +
> +    if level is not None:
> +        try:
> +            level = int(level)
> +        except ValueError as e:
> +            print(f'Ignoring \'VERBOSE\'. Unknown value \'{level}\'')
> +            level = 0
> +
> +        VERBOSITY_LEVEL = level
> +
> +    return VERBOSITY_LEVEL
> +
> +
> +def verbose(*objs, **kwargs):
> +    global VERBOSITY_LEVEL
> +
> +    if VERBOSITY_LEVEL >= 1:
> +        print(*objs, **kwargs)
> +
> +
>  class cmd:
>      def __init__(self, comm, shell=True, fail=True, ns=None, background=False, host=None, timeout=5):
>          if ns:
> @@ -22,6 +46,8 @@ class cmd:
>          self.stderr = None
>          self.ret = None
>  
> +        verbose("#cmd|", comm)
> +
>          self.comm = comm
>          if host:
>              self.proc = host.cmd(comm)


