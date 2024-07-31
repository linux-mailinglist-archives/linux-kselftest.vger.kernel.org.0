Return-Path: <linux-kselftest+bounces-14538-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A620942D73
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 13:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF201C21A33
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 11:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB81AD40E;
	Wed, 31 Jul 2024 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+MpzAOa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C01A8BEF;
	Wed, 31 Jul 2024 11:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426258; cv=fail; b=GG4tq7zNtZvsCTMN/Y0Yqhrx8C0nLnRpiuJVUl5jvHkAOxNmeniGseECA6TZMvLjgYnQLmdIP0QjZMSXK2rIfqsyGxCBNXzqkV9gBmaykjGK3yFz4r5aFIyAmpNMIGtVo7NILVDVlgkOvtptoyDweqD2Ndt5+eX86HZHFb9Cenk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426258; c=relaxed/simple;
	bh=xUGA+N4gYnaRLYU4kSBqB1P0agoFBpfGyRm3XPwQ7EE=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JvaoZIkoPkPVUwyVFMSBUjsJb4GsZtCB+nFt9eFQggL50Jx1IhoNMyIFrzkFGpdK3c4b7Tn7Q8pYcTZZwpsn9kuRy1bxbRoGsGDHWnmR2FEr7RaoTjxYyya2I8Sngp1/CPPtWIr5JL+zMHw/RubEoy2IDfeLanHrJkOaqiWL5u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+MpzAOa; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDI+MMrcaw4m6QRbGElCrWyDGhadbhFlU9v71OKMltUtUp5uPyvIdU2ufkWdR0nA6cmsTD0du5ZC+bQUA3JLXqy7DUaO/bbsbdzY9IxyhlzcO1qyrJJcsSWNd0e+cJrZfJ9vQVYZTB/1YTZHZHkeZdMpcXHcJFsFxMnfFxnAfo9pv/CjrAetuXSqMcueWyjXlGKImxX0XgHd/7eeR0i+CAzavETDbx45TBWtrEF3iZe5Yhr/6On23AViLfMjg9TkemU74bEaSGI1Bfwp8ijpTIRhFiTz/6ar/EqsoxIC/Xn1hSAl0C1wXGCaKMcEihBHJO04OV1QwP9eQQ1swgstMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4zBiJJFwzeBuse6dtW6SPobXdfICQo2rVCpuHc95ew=;
 b=zLKFBeFbaAsE7mydXCsIK0XEfyDUqbo84DNUsoInlp/KnVXcDu8/E6MmgrXJfJyCJ+mZkzPfQ4pPpp3+oTYCamBMf7t4bqtlmu6F02a4spvQHPnlPPx5vMvbSUU71LvLdQh1bGumf3sF4eRTUKqRx2EgEeQlIUv2hCeyMeN2LhiHI2nCVnHufcaJUO8x8z7e1CsoMDCmqKemH4wZ/o58k+H6qPAL7otTXFSYnT2g58Tb1O2eaYsjYpt+y3GZEXSeqUnVwtvJY905WA2ifCRSl2AA31Jv6iiH7LZ6rgvC8c9wGw5/hxryAzzc7PKwdhLp8ZuUKFzER3pDkfxcR8bvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4zBiJJFwzeBuse6dtW6SPobXdfICQo2rVCpuHc95ew=;
 b=b+MpzAOa4ahbKdF9U028HRuc+jakUvK25XlIPOXV9rSxlvztaTJCrKymDZzIQZkW+N3z5DkCOlVT/Q+Eq24CnFQHSnVjKA7xmE6sVGikrUB4C9208gKKNYNCGZM8SoK7/g4rq6tyo0mkjFxnb95ysSegUXTelAmn5sbVeWhapN2aZsxzvDktiBeNjptfT/bl/wrkPJvvHiFtHbnGijhkJfhn6bsC3+acw4quhRIp3L/ojEZso2VNLdZDB9u/+NLudE8W3OtVeGnp8PLkDwW5st+rAJSWzig8O1noxOY6hX8gVo8VsUZGRXnA22+3UvETRqJaHUUWXiuu8g0Kpt6e4w==
Received: from BYAPR02CA0044.namprd02.prod.outlook.com (2603:10b6:a03:54::21)
 by SJ0PR12MB8167.namprd12.prod.outlook.com (2603:10b6:a03:4e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 11:44:13 +0000
Received: from CO1PEPF000066E7.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::66) by BYAPR02CA0044.outlook.office365.com
 (2603:10b6:a03:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Wed, 31 Jul 2024 11:44:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000066E7.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 11:44:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 04:44:02 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 31 Jul
 2024 04:43:57 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "Joe
 Damato" <jdamato@fastly.com>, Petr Machata <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue
 stats when the device is down
Date: Wed, 31 Jul 2024 13:34:58 +0200
In-Reply-To: <20240730223932.3432862-1-sdf@fomichev.me>
Message-ID: <87cymt7pmu.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E7:EE_|SJ0PR12MB8167:EE_
X-MS-Office365-Filtering-Correlation-Id: 084c063a-f7d7-4422-ad48-08dcb156193c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kYUoTNv3NDsd6jsjYqiDARHmKHmU1bNhwhk9a8cyMaI5Ytq/XmHi/ekl8Lc9?=
 =?us-ascii?Q?ukWmigjlBzeuEyzakgzdJV+X5TEXcq/JKYUxI819wyR8pgVkBmy14UCR51sl?=
 =?us-ascii?Q?ZWabn+uGA7QZOJHByl6oeEJ6ic2X1rHiWlZ3aHhiSzEzhUwg4DLK3hDw7CD2?=
 =?us-ascii?Q?f15s+1cwhJLUl5nlRHtzK2l0FOkfeob+I6nwBQtZKatsLZbdTGw7fxzELqu0?=
 =?us-ascii?Q?M+f3PZ3soFa8FZhy2s7QmOHBgYnMBdE7Fy8VZzKRs03EYALznrkG9y5YnNE/?=
 =?us-ascii?Q?GMRJ6fBsb6AVJ56u3MqAYlaTKzWrEFw//176LkwME1TO270vLDxw/Ic68VMd?=
 =?us-ascii?Q?HceASTGP6lbVtB5NUWYcM7PZoyQUVRZZmaOSObCEHcQoFX++y1UNqqZlRJaC?=
 =?us-ascii?Q?IbxoDFgh7SXncvnb6OB60IOITEF1qTlZxeu2QPOUI66+cabs29t6zH+J8gSx?=
 =?us-ascii?Q?bGefVsQZdQLWHKRk+fvy+TMsPgmBBo+dqGptORZGtKzOUtAsUQxrMNLc6TAU?=
 =?us-ascii?Q?I4gksD/BFMRajW4XIDpGTxH+u0dHxdXZzveFKB6XmdqsK/V/7pXqJuQPY311?=
 =?us-ascii?Q?K10qQKKTW5uxcnIK/VH8+Vgd8+S6W/I91sS9mBGIJNgOB3aIfi2GMiICvocP?=
 =?us-ascii?Q?WGr/DZyGPHcgJ8qFbLFwKerHTLvJfM/ZvB62LworOoa+ymvA03p2NdBhkHzC?=
 =?us-ascii?Q?UV/Out0Q9Bg3/oLTFBLxi+GIhNcASZwDSAp/t5uDGwqf7XWs2HHw7QibERtq?=
 =?us-ascii?Q?buEI2Xoc5qLC2b4fISpWlmS2D5GNIu+3PIOgPtmbemzlYu2F9iBX2/O6ndyz?=
 =?us-ascii?Q?KK5skLfDPpmqcirX9V3cODtDkQEpK6cnP69DEeqIJVjtjK/8w2bQiQrKNOI5?=
 =?us-ascii?Q?A72po1wSxqtRQXCKzMXgbgIk+CapOPRaHlOS97NRNIft1lPKUYvqFUgbxRvM?=
 =?us-ascii?Q?uGN6TZPi2pasOP0iicp1tcdDYXoWdKlExquGInVNcPRn321zGKRpafPjkuJF?=
 =?us-ascii?Q?9i7401OP+yb+rO/0VhRzjQiDehZ/zJQC+pNo07eyrWcG/T4Et8aYh15Vu4sB?=
 =?us-ascii?Q?PPXlvscUuP7c+kwv9x6960BkjTHMUba53ErmXUKzyva6rPgp+UhwPZkswgpe?=
 =?us-ascii?Q?C0tyzv+772KnisGVeRAwOgQGUTB0y50b4C6Fc72ibumexKzWCvDJ8igNPPyS?=
 =?us-ascii?Q?lqvh95xLbOx2nlHiasxxJfIQzS8Rm7Qp+L19VhONJFTNasFIAXchMyrqfJPJ?=
 =?us-ascii?Q?D4Hvqhbmsj8L+7RGbcKU4DulLrkPf/V9GT/HMk1hk6mFaw3nn2aVFZBkNNCd?=
 =?us-ascii?Q?Vqk00TVx3v7+kVJfmVDEVH9wTHhZo/IiCNuuCTe4g4HF0IDdIBAQgRqIbIvB?=
 =?us-ascii?Q?7dPwRqZtbl9agEgiea1fnwj4Fpjo64amo8GpSMTylOZcDPbow4PsPBdT59Jy?=
 =?us-ascii?Q?BQbcH4d5XuCvtoJNWPVmaDZAqQBsKfW1?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 11:44:12.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 084c063a-f7d7-4422-ad48-08dcb156193c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8167


Stanislav Fomichev <sdf@fomichev.me> writes:

> Verify that total device stats don't decrease after it has been turned down.
> Also make sure the device doesn't crash when we access per-queue stats
> when it's down (in case it tries to access some pointers that are NULL).
>
>   KTAP version 1
>   1..5
>   ok 1 stats.check_pause
>   ok 2 stats.check_fec
>   ok 3 stats.pkt_byte_sum
>   ok 4 stats.qstat_by_ifindex
>   ok 5 stats.check_down
>   # Totals: pass:5 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> v2:
> - KTAP output formatting (Jakub)
> - defer instead of try/finally (Jakub)
> - disappearing stats is an error (Jakub)
> - ksft_ge instead of open coding (Jakub)
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> --
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Joe Damato <jdamato@fastly.com>
> Cc: Petr Machata <petrm@nvidia.com>
> Cc: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/stats.py | 25 +++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
> index 820b8e0a22c6..93f9204f51c4 100755
> --- a/tools/testing/selftests/drivers/net/stats.py
> +++ b/tools/testing/selftests/drivers/net/stats.py
> @@ -5,6 +5,7 @@ from lib.py import ksft_run, ksft_exit, ksft_pr
>  from lib.py import ksft_ge, ksft_eq, ksft_in, ksft_true, ksft_raises, KsftSkipEx, KsftXfailEx
>  from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
>  from lib.py import NetDrvEnv
> +from lib.py import ip, defer
>  
>  ethnl = EthtoolFamily()
>  netfam = NetdevFamily()
> @@ -133,9 +134,31 @@ rtnl = RtnlFamily()
>      ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
>  
>  
> +def check_down(cfg) -> None:
> +    try:
> +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
> +    except NlError as e:
> +        if e.error == 95:

Could you do this as if e.error == errno.ENOTSUP?

> +            raise KsftSkipEx("qstats not supported by the device")
> +        raise
> +
> +    ip(f"link set dev {cfg.dev['ifname']} down")
> +    defer(ip, f"link set dev {cfg.dev['ifname']} up")
> +
> +    qstat = qstat[0]

Consider moving the [0] inside the try to make the two qstats_get
statements obviously the same.

> +    qstat2 = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)[0]
> +    for k, v in qstat.items():
> +        ksft_ge(qstat2[k], qstat[k], comment=f"{k} went backwards on device down")
> +
> +    # exercise per-queue API to make sure that "device down" state
> +    # is handled correctly and doesn't crash
> +    netfam.qstats_get({"ifindex": cfg.ifindex, "scope": "queue"}, dump=True)
> +
> +
>  def main() -> None:
>      with NetDrvEnv(__file__) as cfg:
> -        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex],
> +        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
> +                  check_down],
>                   args=(cfg, ))
>      ksft_exit()


