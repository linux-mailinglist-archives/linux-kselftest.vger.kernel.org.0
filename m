Return-Path: <linux-kselftest+bounces-7782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C649B8A2A28
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 11:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B91B28A087
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 09:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551D457321;
	Fri, 12 Apr 2024 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UhLAeCNW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6664B51026;
	Fri, 12 Apr 2024 08:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911837; cv=fail; b=jP6+WmRSRaFcLG+MvdCj2GgWqYo+kZeXIqIQIWat4b/Cud2Hy4oGmD7p9b06LmdHY6O5Mm3Yl/txJCHC24BftcxriigBptaV4IxulsoY8gz70ktW/hxKhDRHm1wyHX3KP0SpcKbdQ4ZeZ/iCOQTu2ys4GtC+bY56I5GwwXfgCd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911837; c=relaxed/simple;
	bh=uj15AfbBAGycICIV0h6zxWRZThhucQVInIq4YTcIIko=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oMNvory90Ddta9WNqvgNB15tfnjnkbl3dfMszBy9+LPBjAbTblDumxFGSSES3K/dDmmkplVMHyTJ/0BFyzgk1D2Akf2pLjW9dkbEEFcmsvMWwocT4T1QBLvrVkcr6ybck5KCyJJTwv7FUINqlly+BIoDDT1YNBcZqcN08FuUCxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UhLAeCNW; arc=fail smtp.client-ip=40.107.223.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIZGKL4YL4PFrJZqvpcIRCRYUlvXKGqjQSvM2rn4XXzfsQ2SH/QVccOSyZFl56Aa0d10/eNeDoLwMRO7be2vdv8nTMWAxfYZF8BJ6wcTiQJjzGo6c6sz4ME4Owv8uyOy3HewIKkYfO1H9MFbdDA3jtW7l6zASpRNMOuh0Qn05UbcYfqcnQ3nFlpI/1m5zx8T028XTSe/W28O/1qvwRqzh3USbgFSJJlR1u5VJEJH9pycbkrAV5VnDswXys2+RRxWuj1voZOAwwsD1jMAFIR6Cyh2OHt1nFyjcD9B+HFFWvk+EXLiiKxjLrbykqLWws/Hd9NTiuZ9nx/SOa0iQk9oyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xQBpBWWkeH9RS7oWNhvBXgt/RxKGiqPP8KDaAFHvZ8=;
 b=kmC82AMn9HWsp9Ygtjx1kKjkX1ijFmWFTkO/6Ut1JhOs6a3Dd5LF1xbXrf1JIqUfYTQNjzLzwEVDa9aTfTDhHyyvxtD6V5VZnt58GpXUNI0rKzSaHgR9s9z8H7kFZYIT4cw7w/Io3HfrooPusaiG6ZI3iO0QvvRGSCXwPvzeti1i9qT9L0FUN/dKq9LRR3tAHtBXlUje2iNJybigDwO4np+og0Sb8yOSJh0EhPwSPnVmbGvgmDbMUUVkO5IVK1Gm0n3I3e0Jr5FHiZreNXjhUbWdG1jWb8NwNh7j0f48CDhzrvNt39v4T+ROw+LMctanlju/z5fTP2WVPyTtSM6M7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xQBpBWWkeH9RS7oWNhvBXgt/RxKGiqPP8KDaAFHvZ8=;
 b=UhLAeCNWRSg90Me5W/7+Y+mBBluICagucKSc0qU7iGEsUrN811BJAH47aU0DehqQ+S1n04rjPOtE4hUsOrCUYEoTLFVCIjuQYFef++Bc6S776obmsRVhHFOgtMn5apmKsc0RsNLNJtgAC71P+y0i/heiwATRArlhTlrs+av9TB5goqzBeo0uUh1yBkFO6xSH8QrbUKGRVI3y03ScT7RNno2qAOUFWisyjtfzQ55BnPRxK181UqdYREe/hlX8hpbvEWFYv69zrMZGNS75yJlYyMmg8xrJgzrPtgRfb1pFrxjJp9/9z8+nNfIMdkQRN1BVM5a7upPNx+Hlx0bo+vSd6Q==
Received: from BYAPR05CA0066.namprd05.prod.outlook.com (2603:10b6:a03:74::43)
 by DM4PR12MB6589.namprd12.prod.outlook.com (2603:10b6:8:b4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 08:50:32 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::5a) by BYAPR05CA0066.outlook.office365.com
 (2603:10b6:a03:74::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.12 via Frontend
 Transport; Fri, 12 Apr 2024 08:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 08:50:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 12 Apr
 2024 01:50:12 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 12 Apr
 2024 01:50:08 -0700
References: <20240411012815.174400-1-kuba@kernel.org>
 <20240411012815.174400-7-kuba@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.3
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next 6/6] selftests: net: exercise page pool
 reporting via netlink
Date: Fri, 12 Apr 2024 10:20:47 +0200
In-Reply-To: <20240411012815.174400-7-kuba@kernel.org>
Message-ID: <874jc7ezia.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|DM4PR12MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2632bb-25bf-4945-f3de-08dc5acd9c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cWStyo/Vmt+lqQz4IXJDMY5Vh2nQGEPa6BKIZZlQholpQYR9TTYQsZnQqNpfGpPi3I0tibp25l4xiU9ViboJAbaCfFV6UEA7SjOyK5UJzF+oOtvcpCKvld0iGiVU5YKpUsZi3ZbVmUVR0vuXu5HeNqBL0wrY4pxU819Lqfj2oeu7plJe/zIAwS+CplLO2LxIz1pxNsz8Y+OyMFgFb6j7gWIPD37cnSjwWRHI2uNr3X4u+UypnyXR9npH4/fIMc0YMvCJMnLP+5hdGdY5sAEtY0rkEzVFTccxs+DkYRRneLdbKW7QTDSMyd2tB24xAXVn0khmZT7ezZrp07EJws3aFL/WQuHVHtu8ssWuYO902Dry/8OT47btOjYGZak8k2I33bX1+gHLTDgbViaGnH11gik4VmO4hTkceJ5ucTbaIALStFbxjDsCtjXaPDkfDuMJO8EVUvoz1nPzINeI2doi1RIJWco8OgrMaZ9bPzLG8JH5gCK30vWuVK2I8hhHMlalZt4Yw0NEiaJERtjcguSWWh6tismsOXE6rPXYBE5nVAV6RcZz0P1uIV4P4nYLe6GgWUFglu7RUUi0MycOW1Oam9Eg3LRVe1EK9Yo784TfvMU188EziR7HxFDbp6TkTWiqiTMRIVxNNJUAh0hsPCGgVQ5ng1xGYgUqRwozGJGSVZrjRHxbHXQzXlCBG5/v1YX3edxAfwPnaVJVM+w+I42hePeYP5DICI1WH4meZ2D1Z0Otoad9Eu/rFa6hqb6gAx27
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 08:50:31.4079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2632bb-25bf-4945-f3de-08dc5acd9c30
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6589


Jakub Kicinski <kuba@kernel.org> writes:

> Add a Python test for the basic ops.
>
>   # ./net/nl_netdev.py
>   KTAP version 1
>   1..3
>   ok 1 nl_netdev.empty_check
>   ok 2 nl_netdev.lo_check
>   ok 3 nl_netdev.page_pool_check
>   # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/net/lib/py/nsim.py |  7 ++
>  tools/testing/selftests/net/nl_netdev.py   | 79 +++++++++++++++++++++-
>  2 files changed, 84 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/lib/py/nsim.py b/tools/testing/selftests/net/lib/py/nsim.py
> index 94aa32f59fdb..1fd50a308408 100644
> --- a/tools/testing/selftests/net/lib/py/nsim.py
> +++ b/tools/testing/selftests/net/lib/py/nsim.py
> @@ -28,6 +28,13 @@ from .utils import cmd, ip
>          self.dfs_dir = "%s/ports/%u/" % (nsimdev.dfs_dir, port_index)
>          ret = ip("-j link show dev %s" % ifname, ns=ns)
>          self.dev = json.loads(ret.stdout)[0]
> +        self.ifindex = self.dev["ifindex"]
> +
> +    def up(self):
> +        ip("link set dev {} up".format(self.ifname))
> +
> +    def down(self):
> +        ip("link set dev {} down".format(self.ifname))

Yeah, what I meant by integration pain with LNST the other day was
basically this. You end up rewriting the iproute2 API in Python.
But it is what it is.

>      def dfs_write(self, path, val):
>          self.nsimdev.dfs_write(f'ports/{self.port_index}/' + path, val)
> diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
> index 2b8b488fb419..afc510c044ce 100755
> --- a/tools/testing/selftests/net/nl_netdev.py
> +++ b/tools/testing/selftests/net/nl_netdev.py
> @@ -1,7 +1,8 @@
>  #!/usr/bin/env python3
>  # SPDX-License-Identifier: GPL-2.0
>  
> -from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
> +import time
> +from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily, NetdevSimDev, ip
>  
>  
>  def empty_check(nf) -> None:
> @@ -15,9 +16,83 @@ from lib.py import ksft_run, ksft_pr, ksft_eq, ksft_ge, NetdevFamily
>      ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
>  
>  
> +def page_pool_check(nf) -> None:
> +    with NetdevSimDev() as nsimdev:
> +        nsim = nsimdev.nsims[0]
> +
> +        # No page pools when down
> +        nsim.down()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]

This combo of page_pool_get / filter looks like it should be in a helper.

> +        ksft_eq(len(pp_list), 0)
> +
> +        # Up, empty page pool appears
> +        nsim.up()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +        ksft_ge(len(pp_list), 0)
> +        refs = sum([pp["inflight"] for pp in pp_list])
> +        ksft_eq(refs, 0)
> +
> +        # Down, it disappears, again
> +        nsim.down()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +        ksft_eq(len(pp_list), 0)
> +
> +        # Up, allocate a page
> +        nsim.up()
> +        nsim.dfs_write("pp_hold", "y")
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        refs = sum([pp["inflight"] for pp in pp_list if pp.get("ifindex") == nsim.ifindex])
> +        ksft_ge(refs, 1)
> +
> +        # Now let's leak a page
> +        nsim.down()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +        ksft_eq(len(pp_list), 1)
> +        refs = sum([pp["inflight"] for pp in pp_list if pp.get("ifindex") == nsim.ifindex])

The second filtering is unnecessary.

> +        ksft_eq(refs, 1)
> +        undetached = [pp for pp in pp_list if "detach-time" not in pp]

Maybe call this attached to be in sync with the next hunk?

> +        ksft_eq(len(undetached), 0)
> +
> +        # New pp can get created, and we'll have two
> +        nsim.up()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +        attached = [pp for pp in pp_list if "detach-time" not in pp]
> +        undetached = [pp for pp in pp_list if "detach-time" in pp]

detached.

> +        ksft_eq(len(attached), 1)
> +        ksft_eq(len(undetached), 1)
> +
> +        # Free the old page and the old pp is gone
> +        nsim.dfs_write("pp_hold", "n")
> +        # Freeing check is once a second so we may need to retry
> +        for i in range(50):
> +            pp_list = nf.page_pool_get({}, dump=True)
> +            pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +            if len(pp_list) == 1:
> +                break
> +            time.sleep(0.05)
> +        ksft_eq(len(pp_list), 1)

Yeah, I don't know if busywait / slowwait sort of a helper is practical
to write in Python. No idea how to go about it. But the bash experience
shows it would useful fairly often.

> +        # And down...
> +        nsim.down()
> +        pp_list = nf.page_pool_get({}, dump=True)
> +        pp_list = [pp for pp in pp_list if pp.get("ifindex") == nsim.ifindex]
> +        ksft_eq(len(pp_list), 0)
> +
> +        # Last, leave the page hanging for destroy, nothing to check
> +        # we're trying to exercise the orphaning path in the kernel
> +        nsim.up()
> +        nsim.dfs_write("pp_hold", "y")
> +
> +
>  def main() -> None:
>      nf = NetdevFamily()
> -    ksft_run([empty_check, lo_check], args=(nf, ))
> +    ksft_run([empty_check, lo_check, page_pool_check],
> +             args=(nf, ))
>  
>  
>  if __name__ == "__main__":


