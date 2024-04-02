Return-Path: <linux-kselftest+bounces-6995-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9771D895A89
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 19:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C146CB2AD46
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Apr 2024 17:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42CD159912;
	Tue,  2 Apr 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KYeyfyN/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF1132C38;
	Tue,  2 Apr 2024 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077999; cv=fail; b=qWc00eqqGD2KEZfWtGGBgwASLSzFLLYd/Qt/+PBof6sAeCo8HZY53ZkHfl0AVstZhdxcZlB4tNm9TKfpu6UquOOLWp4r+2BMrAHL57OrHM8zH/DODiMXVYXsaKORjFezxGdbiLdQtq5uldXpT/wwS8HVYWcwWso4ylb0pkouf7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077999; c=relaxed/simple;
	bh=1OuzzTtxSMBqpGwexdzfsw4hl2xVjfWDzwV5y/4Dylo=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=qZPTODLLwyKlaH/9Ex3GULNpP2ef/f8x9zzYAmZG/STuvUFB+8Pf3jSkeXESKM5Qa9oc/vMSFK/PKfI1UtLjsnMiDh79wZV/2CMS9jdzxc8ARut3Ca/XIXsHr1aNtzoAXHTJDQiYz6dYVay1H1VTI7i9PIOW6wRqeel9+2desDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KYeyfyN/; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rp9heHB2uODa/1/rxxRBVVdTo7Uk8biyDVtGLXkwMLg8FwTMo1ruMbvIuKHaVCqn503lIoPT+ioSIvpbc7Hv+n+WLQrb2aDCY3L2aDEcrDuXEfPygCos+xwDIapdVdrMiqWatOinAkCkRgBY2PdAWzazezNdTVxAvmxxlr0P2q35vpLhe61UNg5Z99BFUcKc1mC+MGDUkCnb+gswZF+t0eOaYDzZBOGB8xI6UT696Ud3ukQhlRun1gO5GCyqQiMBFyaavpMEI5Vv4zV5DfSfDofDg1+DEKvZWKy5L4i10f2uSPObd8Q0mPwNiQyGvnYWXYSkoBGPLOfSjVpsb+toLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIia0A8SAWIVXlTCLuJplzx4JBbjBxINphAW3trDDAg=;
 b=CNpYhYEqaFa4VupZoS6KIFTXVQoNspgpcoCyRMdFQF6pK0OdL09hsDtvSpHtitsx3DzIjAvuIWfzmq/iQa8JS2IsEP7TXkJL7LDGXVfIjd1C7hMpCnzWVdnkuZ75idTHy+qU2GX4N175T/IoGcnYHXWrAMHy67MZSYW0DPa8xSI589kdP6E0lYvJ5wvqhtz11hPH4+mdDj4n+ezZa/yhaKHfLIflKaqlBGzxcbtqZ0gmPNYSx9uQK13hj5YV0s8oylElWDtEKnhqd2wn9UZWdGQ4DFV3zUXkl+0T+BDdk5iK3vcb4YzHTi9sg8HU7p1hflfLF+Wt4zXENaSvJNcmWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIia0A8SAWIVXlTCLuJplzx4JBbjBxINphAW3trDDAg=;
 b=KYeyfyN/0DSoA0sD0GsypOwsABFjLNB660EF6g2S4GvfhDArKJ8vFnEa5tbUuKExvzwk/ToVcSmbFSr5Rj3K6+rTJ8wYgyxPWxZcezeZakR/NUxxfP9F+NeAWpszJWz5+31TNpc6dmFFrA4wfTqm3ckLm8tqPkSndQ7XKFJh3Aiu+3YTs3iHDYibDbDz5WFnvQnGJJG/jSgkzkE7mSInkZkB3TLse3++E3Cd9Icv3mHRUnQJEdvB9SC0GYrb/w+wVC7RkzAR38b4oDIWfxt5vdlwXGl0NBA+ch29OfFjfyFfkrHxwHB2pIF90krs8HB3LHnd9HQRDeZt2W9lNQHKXA==
Received: from PH8PR21CA0002.namprd21.prod.outlook.com (2603:10b6:510:2ce::16)
 by PH0PR12MB7080.namprd12.prod.outlook.com (2603:10b6:510:21d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 17:13:11 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:510:2ce:cafe::4e) by PH8PR21CA0002.outlook.office365.com
 (2603:10b6:510:2ce::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.9 via Frontend
 Transport; Tue, 2 Apr 2024 17:13:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 17:13:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 10:12:40 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 2 Apr
 2024 10:12:35 -0700
References: <20240402010520.1209517-1-kuba@kernel.org>
 <20240402010520.1209517-8-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <sdf@google.com>,
	<donald.hunter@gmail.com>, <linux-kselftest@vger.kernel.org>,
	<petrm@nvidia.com>
Subject: Re: [PATCH net-next 7/7] testing: net-drv: add a driver test for
 stats reporting
Date: Tue, 2 Apr 2024 18:37:44 +0200
In-Reply-To: <20240402010520.1209517-8-kuba@kernel.org>
Message-ID: <87bk6rit8f.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|PH0PR12MB7080:EE_
X-MS-Office365-Filtering-Correlation-Id: 264f0cf5-08cf-4038-63fd-08dc533828b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VF9lCG4w9orVGS6DMegRFcKG0+N1cAnYezBUIpx8VTgpVdLHdHSy289oYCM+CPqRh33/MsOUR3YOGrokgkMPkNWqcj1uqI6IWDbGyeuO+vhP/gCFgUVNpiiJ6JhyiIO89vlWxNadQeS6YwGC8ki27o2bzQ9qdF4kAwF5ocFwzqxVi1tgk+unTdHDKau69geRWBt2V6fid3cbKbIcolAaaIWMgciyQ5slE7WHVD1nC/ExpAT2m1pQr6TMxod+VhCwc4lCdZcMbK242jO/hn/WVMedsshLi/mAESUZt3F6PhcdR5Nxfp+/3EoIzSnYsVCUkOiGpZb60LBgCWFmOiBcketlrsLZ3qOKvz7ekDCQ2Wr2K2koK1dPA7JXJ/sd7Am0SQCyEWUnWEVrqajtpOOOw4wwrgVo3im7K74XKSG/fcAkaPwlxBtJvDePOzv7fgHLdOg3OKuGIHt5NKI5WOtX0TbdJggFclXTkUr3wdK7UnzBCYxwbTF8e3AmZ6MrQYD8SyqD2FDypjVBXSkxmmW2eGhft50ToozYXv/nkJXLQdgKP/JSkh+zG0jUQLTHWpJs0U1BOXJZBCBzOA3s/O9l+klyayuHGR3bY21ixJyhJkPDe5i8HPkEd9Hm1lMt/zk2B0xqfP9o4dykDSYn6yfDy3JkYrFNnUxt4BBSjTYe3hrWitYnoTjfemhuP734/7IgwzAGDkj1le3OE9N13beAPm+lbyRu04vfke6hO62BkkHNLubpx0b1DHuvRBVAPdEt
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 17:13:04.5030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 264f0cf5-08cf-4038-63fd-08dc533828b9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7080


Jakub Kicinski <kuba@kernel.org> writes:

> Add a very simple test to make sure drivers report expected
> stats. Drivers which implement FEC or pause configuration
> should report relevant stats. Qstats must be reported,
> at least packet and byte counts, and they must match
> total device stats.
>
> Tested with netdevsim, bnxt, in-tree and installed.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/stats.py | 85 ++++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100755 tools/testing/selftests/drivers/net/stats.py
>
> diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
> new file mode 100755
> index 000000000000..751cca2869b8
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/stats.py
> @@ -0,0 +1,85 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +
> +from lib.py import ksft_run, ksft_in, ksft_true, KsftSkipEx, KsftXfailEx
> +from lib.py import EthtoolFamily, NetdevFamily, RtnlFamily, NlError
> +from lib.py import NetDrvEnv
> +
> +cfg = None
> +ethnl = EthtoolFamily()
> +netfam = NetdevFamily()
> +rtnl = RtnlFamily()
> +
> +
> +def check_pause() -> None:
> +    global cfg, ethnl
> +
> +    try:
> +        ethnl.pause_get({"header": {"dev-index": cfg.ifindex}})
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftXfailEx("pause not supported by the device")
> +        raise
> +
> +    data = ethnl.pause_get({"header": {"dev-index": cfg.ifindex,
> +                                       "flags": {'stats'}}})
> +    ksft_true(data['stats'], "driver does not report stats")
> +
> +
> +def check_fec() -> None:
> +    global ethnl
> +
> +    try:
> +        ethnl.fec_get({"header": {"dev-index": cfg.ifindex}})
> +    except NlError as e:
> +        if e.error == 95:
> +            raise KsftXfailEx("FEC not supported by the device")
> +        raise
> +
> +    data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
> +                                     "flags": {'stats'}}})
> +    ksft_true(data['stats'], "driver does not report stats")
> +
> +
> +def pkt_byte_sum() -> None:
> +    global cfg, netfam, rtnl
> +
> +    def get_qstat(test):
> +        global netfam
> +        stats = netfam.qstats_get({}, dump=True)
> +        if stats:
> +            for qs in stats:
> +                if qs["ifindex"]== test.ifindex:
> +                    return qs
> +
> +    qstat = get_qstat(cfg)
> +    if qstat is None:
> +        raise KsftSkipEx("qstats not supported by the device")
> +
> +    for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
> +        ksft_in(key, qstat, "Drivers should always report basic keys")
> +
> +    # Compare stats, rtnl stats and qstats must match,
> +    # but the interface may be up, so do a series of dumps
> +    # each time the more "recent" stats must be higher or same.
> +    def stat_cmp(rstat, qstat):
> +        for key in ['tx-packets', 'tx-bytes', 'rx-packets', 'rx-bytes']:
> +            if rstat[key] != qstat[key]:
> +                return rstat[key] - qstat[key]
> +        return 0
> +
> +    for _ in range(10):
> +        rtstat = rtnl.getlink({"ifi-index": cfg.ifindex})['stats']
> +        if stat_cmp(rtstat, qstat) < 0:
> +            raise Exception("RTNL stats are lower, fetched later")
> +        qstat = get_qstat(cfg)
> +        if stat_cmp(rtstat, qstat) > 0:
> +            raise Exception("Qstats are lower, fetched later")
> +
> +
> +if __name__ == "__main__":
> +    cfg = NetDrvEnv(__file__)
> +    try:
> +        ksft_run([check_pause, check_fec, pkt_byte_sum])
> +    finally:
> +        del cfg

Yeah, this would be usually done through context managers, as I mention
in the other e-mail. But then cfg would be lexically scoped, which IMHO
is a good thing, but then it needs to be passed around as an argument,
and that makes the ksft_run() invocation a bit messy:

    with NetDrvEnv(__file__) as cfg:
        ksft_run([lambda: check_pause(cfg),
                  lambda: check_fec(cfg),
                  lambda: pkt_byte_sum(cfg)])

Dunno, maybe it could forward *args **kwargs to the cases? But then it
loses some of the readability again.

