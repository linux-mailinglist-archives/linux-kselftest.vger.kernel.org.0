Return-Path: <linux-kselftest+bounces-23403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB3B9F2E93
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:52:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D84F188623E
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA48E203D6D;
	Mon, 16 Dec 2024 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p7481lf9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAB3203D63;
	Mon, 16 Dec 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734346374; cv=fail; b=N7wV9vj8lrTxQ6hUPsY5r76bKyuiYGJeGawy1Omjgy7P0Eg4XWS86//X9NMAIV8+8Ty9xkCrDUSLgzvp/Un3A2QyTxGqzoEof6fz4++oWl0IYUDmITsiUzp7B7+nDTB5u0sPQXJbm0jg25dBcbwFq/ccq6tblW6xB1xqY8kAlm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734346374; c=relaxed/simple;
	bh=NvcK0gI2AFVNg+KF8VGg2sVUqqA6EIyvwutk7M+i9Dk=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Cjzpu7Jt9ekI1I/fJ4grMrAJg38sBMu9a5KdLbEPfBB8+sTQg9aRGbrv3FNgoz3DRHbhNjVOdAXhLXn8gUNK9U24+S0GIg+kUFhObCHNJKL6oIWfd+uu5WSeNgqbBO2cifpVk2fmws+aplThS9xKOkybeh8MVkBHdm6zbDNeItM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p7481lf9; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/B226Qwp+XSMIUm2khklsPq3klDy/31LNa5HKxSClNwM093klS92Hoqjj0y1mgY+//IxorWK3lB2PVm0go8po2JS5n2l3O0nO2Lb8NsG9RlS0o8uPLiK3e1P0iasdQYUbEha6kPc8eySVcRoICHN8Cx/Q4u2ifvPcHXdMRfFpM7ruEiQxEnSVjvzJIG86k8Z+xHpWzeiDKZCLOpuDFn65xg0hiWehqyLUr/OCpzwrXHDgqCd35MwjVdzh7GQ3gAOOdyqeICJORea9gCv3r27597x7u6MZpjR4so6NrDUP6ACoLo7NWs4aFmzY9OS1x+NeSqx1unKhVjwpHxVQRKHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JL2YXs3X9ifybqkm7KPc1Bzl/BPMYJw80pZrgDArg8=;
 b=GKbotoN7xY1vqRCjIqE4REtoic1jHivaoC+ZAVZDKqWrKiqKPNU0zyXu/ehFSEWODk7x0483r17rBEp7iHBNDfxWWF33SFs1ganM9h7ctuE2QkKTgIk5TYC/qBA1QsmHGB/kBnkxS0G74eHsPJufZyBPvHm6MuI3UQSkYCck/DHkgGNLC3Gh4hRbdQFJ+4+lbpGUXWqKht2am5twQ/rGqAh9BqWGMRdZlpy7CuZTHRRNlp5t+9woubF+x7OnefILEQKNEFH3tieyXoAzw3Ij7uklaA6lU4T3Lx/hb0HUkVX83rZ8cZy89FCJbhQtxG3GuhpgqRTzrusW8J4kPe5p3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JL2YXs3X9ifybqkm7KPc1Bzl/BPMYJw80pZrgDArg8=;
 b=p7481lf9PvYczwiF0a2UIz0BsF/g19zY7JVm5h4vrtqr0CuPCOFzYwOIv6T5MNjQ+/kcPfH7zs5cQDD7MB4MBq8a+/mV8+scCKff42edmeNh+0uLOWwK3MtjIwyClCQ1q23BfeUIxLdWvbH4/VVxGxi1r7BGWTpkfdvoVL4lKJivhamerTiuYQgqvDTCK1+eWQvmlQmOuHYatVwKJsb3sohsrhJCdCV/BuWEohYpfTIMJ/ZoTzsRc+Xqt+m1FisCvXPgkXJRyD4mczLJq02RChwZO1H51QN0qXbxGb+1TXD6BoXydfPuCaT5OAKNv9FRB3aDtv2fVUIu7mZcIQk8Sg==
Received: from DS7PR03CA0154.namprd03.prod.outlook.com (2603:10b6:5:3b2::9) by
 SJ2PR12MB8928.namprd12.prod.outlook.com (2603:10b6:a03:53e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 10:52:50 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::5d) by DS7PR03CA0154.outlook.office365.com
 (2603:10b6:5:3b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 10:52:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 10:52:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 02:52:39 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 02:52:35 -0800
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-5-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 4/5] selftests: net-drv: queues: sanity check
 netlink dumps
Date: Mon, 16 Dec 2024 11:46:19 +0100
In-Reply-To: <20241213152244.3080955-5-kuba@kernel.org>
Message-ID: <87bjxbvr0w.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|SJ2PR12MB8928:EE_
X-MS-Office365-Filtering-Correlation-Id: c7861030-4de4-412d-f12a-08dd1dbfc89e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3Ke33mG1iZsesYIbbeGH7y5JnoC7wEH9lwzwrSSuedJcVZ+5aFz+y8SnuBu?=
 =?us-ascii?Q?8/6x0p3xW81qng3tXjg0zdIQcFig1zF+p3Jo9Vhi40EbLiWjWu3p+R9bicxs?=
 =?us-ascii?Q?G8hg2u7ZC8zmga/nhmx4dtTKeBjIkfPCElxYfUwrN2h22G0Z8TotEtXbA5+Y?=
 =?us-ascii?Q?N1lXJk1sbcy9YWnpIsN2BnmGsugaEkNA15m/XzVWTw72HJPh4pBnde7Yax2Y?=
 =?us-ascii?Q?2N78dYDqO8cjWxJFLO+sreTcuCZL1sQX6ScK2VWPHuNftvtE5QckTC0otqhT?=
 =?us-ascii?Q?MTK9bR+vAm4U0GePtSUp/lt7Qf3ADvkOu6d+yv6fYiq94MhzYjyOqgjQRvCk?=
 =?us-ascii?Q?BrDvzhCq8AsAMz+z+BEyLIDlZBDji3PBiWWmEhmJI4RrKSgdga993kMsSluT?=
 =?us-ascii?Q?qwgrQUvJkBm9qm68wnwDeYSWMIybdYWtKe5vLIV5z9pT6XbNIJNdmo3KsUVn?=
 =?us-ascii?Q?QsV+IzafeCx7YAW5bguYX0FHp5YjfcO141Sriub4OG8hodXMd2IlNTgA37rB?=
 =?us-ascii?Q?78zdkQjy11uCSkrSl3Qo47/AJjVDsXkYds4girHut04DZ+KHknpV7LZEJb7O?=
 =?us-ascii?Q?6y030WYpv+ZOpawUvY7aqnNfaZmiCls9P6i03AaOXDhPWdSzZ+99msU6yx5F?=
 =?us-ascii?Q?7cEaFGRHFuzXPNoIr4CGXwjjpkuyiuXOD3W9dxsRA0YoXEgHI2NtAIlZcH0Y?=
 =?us-ascii?Q?/zGC7qtJwPN2eh6hHQ78QKgcAOpkXW47Atq/Oo22rjU8eP72DK2K4QTRE81S?=
 =?us-ascii?Q?F2FTXhI7sZwQnzl2OK+Ta0LwW1k/7om8+1X5Q67ODgMxhIvTRoV+kdIDCuxH?=
 =?us-ascii?Q?wgeYjHYeVWMtxMy8CQdYyRHfpaWnxXajbi/2aDKXh/PotEswa+f+gnBizNM7?=
 =?us-ascii?Q?f6bDvNQeUD4LW9DxHCpMUpAdAHGIlNnqlUcSJlvY8aZZ1hnkhvbdBJSQZO0F?=
 =?us-ascii?Q?fsaxWOFfv6jT2LZLPXtoeETcUXZM5+TUgAGEjh/OQpesXeJRA2pNKEEEpKcs?=
 =?us-ascii?Q?7Sn6s/2Hvn4+lNTAEl+0tOmhCUGxP7HHRqGH97yee+9hhqeAub2u0+GxQ/uv?=
 =?us-ascii?Q?C1ZEIWTjK6VvQ+QxOpZ75LTzKmlxwRV/4hJDqABW5ezWsNVvJu3dH54SAbKR?=
 =?us-ascii?Q?FumD9RbGNypJxU0ZiRgBJa4Qc/6s6cCfcPxfhaOtJOs1a19PSCpZrztZsXou?=
 =?us-ascii?Q?dFoxheQnkxnyFMyJNbOZHROhXexmTIIwL2hDxSPSiVKRXZqEgQiCIB1ljz1h?=
 =?us-ascii?Q?y4D7bkA8ojuriD2go/UF9zNWaNQchCAxPZs2LdG+NK2HfRJt/d+JTQLJWpkJ?=
 =?us-ascii?Q?EFxQXO0LKei8c4QGibgrkzH057kCk0vi0XIDneT1Gk7qye880D3C3KYEsXS0?=
 =?us-ascii?Q?D86fysVw8cS0odDH0FvUT81N0csWkr9tYwZIIo0X+yC9Q62hMQE7Ayo3qDkz?=
 =?us-ascii?Q?f8MpzQNE2nqGUUQEHwNKpgDtA5RQseLAjvMxi87YVN+xgxUPoJLAg9lxR1+7?=
 =?us-ascii?Q?vkKy5YgBz+Vr934=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 10:52:49.6890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7861030-4de4-412d-f12a-08dd1dbfc89e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8928


Jakub Kicinski <kuba@kernel.org> writes:

> This test already catches a netlink bug fixed by this series,
> but only when running on HW with many queues. Make sure the
> netdevsim instance created has a lot of queues, and constrain
> the size of the recv_buffer used by netlink.
>
> While at it test both rx and tx queues.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/queues.py | 23 +++++++++++--------
>  1 file changed, 13 insertions(+), 10 deletions(-)
>
> diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
> index 30f29096e27c..9c5473abbd78 100755
> --- a/tools/testing/selftests/drivers/net/queues.py
> +++ b/tools/testing/selftests/drivers/net/queues.py
> @@ -8,25 +8,28 @@ from lib.py import cmd
>  import glob
>  
>  
> -def sys_get_queues(ifname) -> int:
> -    folders = glob.glob(f'/sys/class/net/{ifname}/queues/rx-*')
> +def sys_get_queues(ifname, qtype='rx') -> int:
> +    folders = glob.glob(f'/sys/class/net/{ifname}/queues/{qtype}-*')
>      return len(folders)
>  
>  
> -def nl_get_queues(cfg, nl):
> +def nl_get_queues(cfg, nl, qtype='rx'):
>      queues = nl.queue_get({'ifindex': cfg.ifindex}, dump=True)
>      if queues:
> -        return len([q for q in queues if q['type'] == 'rx'])
> +        return len([q for q in queues if q['type'] == qtype])
>      return None
>  
>  
>  def get_queues(cfg, nl) -> None:
> -    queues = nl_get_queues(cfg, nl)
> -    if not queues:
> -        raise KsftSkipEx('queue-get not supported by device')
> +    snl = NetdevFamily(recv_size=4096)
>  
> -    expected = sys_get_queues(cfg.dev['ifname'])
> -    ksft_eq(queues, expected)
> +    for qtype in ['rx', 'tx']:
> +        queues = nl_get_queues(cfg, snl, qtype)
> +        if not queues:
> +            raise KsftSkipEx('queue-get not supported by device')

Passing qtype in the message might be helpful here.

> +
> +        expected = sys_get_queues(cfg.dev['ifname'], qtype)
> +        ksft_eq(queues, expected)
>  
>  
>  def addremove_queues(cfg, nl) -> None:
> @@ -57,7 +60,7 @@ import glob
>  
>  
>  def main() -> None:
> -    with NetDrvEnv(__file__, queue_count=3) as cfg:
> +    with NetDrvEnv(__file__, queue_count=100) as cfg:
>          ksft_run([get_queues, addremove_queues], args=(cfg, NetdevFamily()))
>      ksft_exit()

Hmm, get_queues() doesn't use the passed-in NetdevFamily(), but that
gets created anyway for addremove_queues(), so whatever.

Reviewed-by: Petr Machata <petrm@nvidia.com>

