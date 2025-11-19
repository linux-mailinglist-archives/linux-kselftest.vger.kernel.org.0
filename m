Return-Path: <linux-kselftest+bounces-45984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51841C6F2EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:15:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 429425047CA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 13:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42FE35E544;
	Wed, 19 Nov 2025 13:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rONf+Lzf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3899436402E;
	Wed, 19 Nov 2025 13:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763560489; cv=fail; b=TkY9/+vvzeiVcDxFHpbdQ3SWENjXWW+fQvKuGNI6XJI2gL49vNY67mypjF1OZnX1xKZzJHj+XKc1vF+bGMBZYFwK+jwFAQYBhuHxfyJ/A+54aFshZHsqC5RD4sKXzQcmDojm48yK+fDYElmU/DLIPvWTGKCHuG2QdUvY+warV7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763560489; c=relaxed/simple;
	bh=jbNGy6UakX4Rih2e44J5M+qQUn4LxjhgBhsQ4Mj1grg=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=iayKhGX8OxAK762buOIO5s8PmgJxYU0prp3QLCiSOJyDbItmQ106bcv+j7wJpaPoXmrbbkJt7D9X+utCNqvLm7wRxoLRVfXeGfw3pqkm4W9czzZl25JQsjkWT/OqEA7X8GJPJ9wmg4LEWSNyQBY8f8Wp3CqNw2nGriamFNyUEAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rONf+Lzf; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9ClZCLd4olvTbc2hTHlIvBsXVN/RSj9nu78D/w7afkV8sSZnBxGPRgMenvNXrUQCNLKb5J6cZChTp+UHslyoAu3q2O5QWO9iVw4q3AyOWoV24eHliLJ4ZwBdtZFuIzvWqqz1bOBLdygtMkqPYlti9EZvOIDFoY8Syt8+PjNayj0XZHVo9oNbLtJd+yiNjebTxd4Zp4oXBF83hDDQXp7gtA+APNldeCeOA0bmX9aemfQALQz6wruMggVL4+4GBQLWHnJHw0tlIiR31fqxnUXV6OzISdDod19Hq6bCjjb4/Wwn0gCE610yTYDuzcoDNEHykxmJpRx172ZKsueawjsVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPf3iFPRWMh6mXpMekFMhn2mCvwcqwRT3yoATXbvMyo=;
 b=xti30/MAfEzO7ts04HN20LUQXA4zXe2T0lSKjz6r6OtHbbl2SRzSp0Mb9SYQYHRiz+vMseCsDRDMdeCwpHUMFsYx3U2nyCpSZIYSftlQ/ZonJ8awl+odRHHwVrc5y1pjRakAG8b0yO0DfyRwrZZbh3HJc2dUvTRLQYtVweCclN9ljdq6fFnkSE5iSUfcnSay6LVdzoN2G/yTJHU0hbBuc+jbSYFpVOLRtMB4nMiHCLGbghGpIHeriGm0LXIWlHa4osc9PVd/znvznkGXgucF0naIqOo5Q22WjpYxQrKDvBGyYwvUIMYD0AFLadSKebgUbU/f3pmXpDTIhrJG9k4t/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPf3iFPRWMh6mXpMekFMhn2mCvwcqwRT3yoATXbvMyo=;
 b=rONf+LzfSc8u2lKcBe1EOhviXcTs2l4r9JmtrAzImbmQaL/Q/zX34ZwWIpATrzFz7dwTZr30XrJ98TSLHTLx1VvnPRKcg9C4qC3zk9zxhRsG3Wve/FDwRT6cLSZufJ3QW+WW++rid5Uoi+y9sBfMvbT5eGyFOWj9AVLTFtM9wQVOL5EpbQo6AG6g0e+3ZMFlRtVnNjVm6EBbtgzscQS94Fl2nEAqDUFgKUd7C/6PCeoTvEL2mlzltQs3NaPATeHmuZY5nd2WrpF/qECVH/I2AStjE6M15CGq3dPqD+luXx9Dh3xssMTwi8FDjZlA8sxUdf9LgIJU3pHhEqYh5sVdGg==
Received: from CY5PR15CA0116.namprd15.prod.outlook.com (2603:10b6:930:68::26)
 by CY3PR12MB9577.namprd12.prod.outlook.com (2603:10b6:930:109::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Wed, 19 Nov
 2025 13:54:44 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:930:68:cafe::de) by CY5PR15CA0116.outlook.office365.com
 (2603:10b6:930:68::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 13:54:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 13:54:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 05:54:26 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 19 Nov
 2025 05:54:20 -0800
References: <20251118215126.2225826-1-kuba@kernel.org>
 <20251118215126.2225826-2-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<willemdebruijn.kernel@gmail.com>, <shuah@kernel.org>, <sdf@fomichev.me>,
	<krakauer@google.com>, <linux-kselftest@vger.kernel.org>, <petrm@nvidia.com>,
	<matttbe@kernel.org>
Subject: Re: [PATCH net-next v2 01/12] selftests: net: py: coding style
 improvements
Date: Wed, 19 Nov 2025 14:40:41 +0100
In-Reply-To: <20251118215126.2225826-2-kuba@kernel.org>
Message-ID: <87ms4icely.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|CY3PR12MB9577:EE_
X-MS-Office365-Filtering-Correlation-Id: 17e5ea2f-9dd6-4bab-50f6-08de277331cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u8U/5zH+qLzWvqNpN7xJ7frCp4ZjeYdjZ31Wjff6xTydFvk1gyibY6uvLByW?=
 =?us-ascii?Q?tnlYxr365YAOPQMTRbPOkIhuaK4kIJJo4CzYPDr3N35u4ar895DTaB/02yFQ?=
 =?us-ascii?Q?CerKTg0FX0Fdv+W8kHs70UobnjR4CRN2nqrkg2bzYvRyC2tUtwJAQYYKNNK5?=
 =?us-ascii?Q?6A2i2RNh0sGaXVefbjXtNXIi/sXCmwgQHtbmpb2Cw5rdKdd9EDvqt8Kt0b2l?=
 =?us-ascii?Q?5moQzU/D2Krso0utHWcla08UjaA5Tfb1BDaKmunlc8DcG/PnCR5AXQGwj4Kc?=
 =?us-ascii?Q?m4J/2ryUHBcGSKfBLpbN9lWm4hAdfzhNDVJ2WTHdgHQHEyrBZ+XU0KQ+JOHm?=
 =?us-ascii?Q?egNO+j3jHaHWKN9X0pXCVD3E91Y0dAxqfmdX2zdMv1kBZfrwDYzoGlPXD+qA?=
 =?us-ascii?Q?cSYjZLNLpAghF+ufsp0xWBmI8hsTvGrdWjA7f+2cuNebb83l27PAVwY8l0FV?=
 =?us-ascii?Q?zLwCZQTs+j4NhWTLapTPuWSxMvww7az6FXLqCoqMK4+oYqkgQsS0zL2wRVEW?=
 =?us-ascii?Q?F3j4lGoVlyejLRgaDrq50C0SwbFunVLXNqpecICHXPfpwIG3kyfWGsDogBdW?=
 =?us-ascii?Q?aB3+yf0ZjfcmhDNRevlzKHX1HiafuElZHlKt8co1z1nPYNlORc6tl8a5pIlv?=
 =?us-ascii?Q?oB5esG3Q5N4wsXUPqF/StW7LECcOYCCEem+22Q60NpPqiwSa5w2y6k15PqS5?=
 =?us-ascii?Q?9cC75VUGg4n2pOsJVqXy+3+qeMOR/Qa+CVva2EWLaQlvg2X6Wh+ax0z2BaXg?=
 =?us-ascii?Q?3fvDHN2RrZmko2fBJv2X+Lckr8CiELIzrbC/3B44MLUJsYSj1obtiHCm3FNC?=
 =?us-ascii?Q?qYjuR9gXYOnsJjCItBFg2Y0sDdgXE5PUgzja1r/C63DSRULZqMeFUAhECn1b?=
 =?us-ascii?Q?1aQTx9SyfG7KeAl3yeTYryeJZdlC5eO2hF9akWCLh2g6VUGmyDhJ/Lxnkz0o?=
 =?us-ascii?Q?vwOzArwLW5tMyI7We1jYWMJPOEb/bMiYml55oLEk3aQ/1ks+FgBJnSXUE53I?=
 =?us-ascii?Q?aF5ojuJotBueRNXDK0hohAfyy2Jl8V2g4eeycRlYixFawv6wnsDrg6Lmgzqe?=
 =?us-ascii?Q?txwG1FIACeRUvhasxc07q3nxc73ux6hqzhQmgYJ6RBoSRTPXCRf2Z1RYBUQ5?=
 =?us-ascii?Q?FCcii1fS6MyQnZjWrFlwm1ObhGpvuxWh6tLScYmS6cnbRM1/+35Df4aa5qR5?=
 =?us-ascii?Q?1muG5coNX8S8n+zVPVA+Le+H6ZG8HIRXPURbrDTast0X/Ah92vyNov6R2v45?=
 =?us-ascii?Q?Qs7E3ThB6gHyLmkK4M2PHigwjmQwZRWU4SmStkP6gsoZBaMcBD/erdafeIu7?=
 =?us-ascii?Q?JKbpEvbejf0GSChHMEtEHGqK8wTU3fsjiS8RxeW4kBiJqsaq03b4V6tZYMtY?=
 =?us-ascii?Q?tfIbWe1zU46VPHWupNzH3bpGpDjk1eRUUDgg45fGns+soTG8gJFHyHCzpVMT?=
 =?us-ascii?Q?U6O3Uq8oeQMf8nFgV2gz3POX4ww7UtlwHnWPzP5XoQbDEWDo8vc5aZQfoogT?=
 =?us-ascii?Q?N9q4UlhHyaVJD5/qb8JkPlC2kzyIrjEWOxbhxNBOLjcabkIaVz5TILez40ES?=
 =?us-ascii?Q?8Z1P7lJUfDdupE+t1C0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:54:44.2394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e5ea2f-9dd6-4bab-50f6-08de277331cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9577


Jakub Kicinski <kuba@kernel.org> writes:

> We're about to add more features here and finding new issues with old
> ones in place is hard. Address ruff checks:
>  - bare exceptions
>  - f-string with no params
>  - unused import
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index 83b1574f7719..56dd9bd060cd 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -1,6 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
> -import builtins
>  import functools
>  import inspect
>  import signal
> @@ -163,7 +162,7 @@ KSFT_DISRUPTIVE = True
>          entry = global_defer_queue.pop()
>          try:
>              entry.exec_only()
> -        except:
> +        except Exception:

This used to catch KsftTerminate, which we use for SIGTERM handling, now
it doesn't anymore. I think it could legitimately appear in that context
if SIGTERM si delivered while exec_only() is running.

IMHO it should catch BaseException, like ksft_run() already does.

>              ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
>              tb = traceback.format_exc()
>              for line in tb.strip().split('\n'):
> @@ -181,7 +180,7 @@ KSFT_DISRUPTIVE = True
>      @functools.wraps(func)
>      def wrapper(*args, **kwargs):
>          if not KSFT_DISRUPTIVE:
> -            raise KsftSkipEx(f"marked as disruptive")
> +            raise KsftSkipEx("marked as disruptive")
>          return func(*args, **kwargs)
>      return wrapper
>  

> @@ -199,7 +198,7 @@ KSFT_DISRUPTIVE = True
>              return False
>          try:
>              return bool(int(value))
> -        except:
> +        except Exception:
>              raise Exception(f"failed to parse {name}")

I think this will end up being called from inside the try/except in
ksft_run() and therefore should be OK like this. It's actually more
correct like this, SIGTERM shouldn't cause "failed to parse" errors.

>  
>      if "DISRUPTIVE" in env:


