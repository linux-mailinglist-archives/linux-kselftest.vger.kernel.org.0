Return-Path: <linux-kselftest+bounces-23406-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F1B9F2ED5
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 12:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E0F01647B0
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8E3203D7A;
	Mon, 16 Dec 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="utvvkf/o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1D0A937;
	Mon, 16 Dec 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734347196; cv=fail; b=m/fFl/okZJ5Ne06RjBD54oOw+U859q+kJC5ghYdi/5Vry+CkvtquPSC/tUNCms6pImyspTs1mUCGqWbKbcZ9DpAgKRnlkh5Vu++HFigG5b6zO1f6TL79XQp3ZU18VuTKOaGvVdV22FRdUJuxUr4cS3KutSBt0VDTZNWBsDZYblE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734347196; c=relaxed/simple;
	bh=I4kQaw3a8LK2WhyzOdN3SM8hWwzRxbjfQ8STkENERJ0=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JnrmOYMZ2PaXpP9eiT1HNWSV3gVyGh12SQj6SKq7OvOeUcthzQFwZt49jLEdelGVk/0pnOq+n/6HLhYBvwy0BvlK5OZa8dptJkvzuOefCgPTqc3fgs6wtdfwMLi/hJOVzFwPWeW/rbxqJMzHeLYhtLhKP1zjW7PZLrwm3ZZnQ1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=utvvkf/o; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hlU9xLUNHbFOd5Kwxm8IFP1hjqQUx50wgrwsXzHNPk071jsW8LB2tY2KqutsM2apadmSE5XgoY82Ij8flOzz5aoeHr7L9URZrH8yh48yEEfS5KJcc8POChd7sBKKPgR/uBrzoDV9VsWo9R93aYAJxQsB67BVXJQ/ZSZfYSKJ41XbZXYcoxhzLhCY1Lhtnzeglzf8BDfaOb+kgBRejI7riB5Otrp/pjDqIXmhcQR+T8mkcPVSILf5k+DVmPNc2tZMF7lear0tRCESGULX9C0WtTkoTTpKU640CfMiyOFwaS0ZoPuuZAOS9t23v5DnwFTJFxkUrpz3vSukSSviba204w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsazjDhQS3m0K80OhpqEguTDU8s2/9ozFIHcD3WqPMo=;
 b=u2VqvU7GaBh0bkY8hOybXuLJowCSYYO0TEMQV6Wsl0+lsxflAMvhy8CfW+VjyzcWkf77TCtHr/VxpOME7JWDcGtZ+XMyZINcB17OytdoeYQM6E36A/4BaEwLEDR/61sZ9j5drabWYe3IeBTxfbrTjtrHlCaiY8Zi7yHsPiob4BjjIQBYJRu80g/0G1yABSdaa6GCWoRaQ+yeBh1+ccE0AOkAVCUJH14L3Vu9jWaL1R89C6WzgvRgjtRYYyM76DX9GCdwEKh0wymEPCIrHbkX4zzgYu7SdkYLRcKtN1AEV52hw4OJb/ysOcGjqFjpN78ujoFKFvx17DJwnGEBCjhk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsazjDhQS3m0K80OhpqEguTDU8s2/9ozFIHcD3WqPMo=;
 b=utvvkf/onGDQFx0VQDAjQ/3USpJ8ovZ3tP+BHbjGlL5ZaFy3GkLQxUtiM83GF3ji67E+CCy8MhWL64S4BT4v8xOS+qlcEHaRUOamqrrk8rN/On3GHAgRI3t3Y0dKzrpvxxmAYMKdOx57JqeFTCDcyLU954CGnn9ePlC1kf+hDC18zTwskVdvtrkCvbsOW/NhEcCydUvG0d5rwoh/tgXLljVedM/RXDlFwMreLvSDeFdS3LIjyUVFd0Q+b5oxBJYxQMLJGX2fzDXGxQjO2DTybE2zX8PovVx9nalXG9Kjnf66w3vKsP8zTBDgr/LpNYDewVxfbFVUja0b7WnF+x7bKA==
Received: from SJ0PR03CA0050.namprd03.prod.outlook.com (2603:10b6:a03:33e::25)
 by BL1PR12MB5897.namprd12.prod.outlook.com (2603:10b6:208:395::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 11:06:31 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::c5) by SJ0PR03CA0050.outlook.office365.com
 (2603:10b6:a03:33e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 11:06:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 11:06:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 03:06:19 -0800
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 03:06:15 -0800
References: <20241213152244.3080955-1-kuba@kernel.org>
 <20241213152244.3080955-6-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net 5/5] selftests: net-drv: stats: sanity check netlink
 dumps
Date: Mon, 16 Dec 2024 11:53:58 +0100
In-Reply-To: <20241213152244.3080955-6-kuba@kernel.org>
Message-ID: <877c7zvqe4.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|BL1PR12MB5897:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b7c1366-d23e-4f01-5a1e-08dd1dc1b1ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EtnLwWCzxCJPnghgYYjHmTNchkIbp4BAdlnZHHoJAH4OZxB9ILoFtNqiPhan?=
 =?us-ascii?Q?RYZWpTKRKbGCAo8vmTm9huxVph+NQM4IdLrmMdW4HWlipaW1406l59JsjGRp?=
 =?us-ascii?Q?fni+IbzqMJ4SLHKYvq8/gIly19Wp3EMUzs3UmTiF5nb5/eoDcynyK6tSBCZJ?=
 =?us-ascii?Q?+VJR4A7zEc6L9vGjHeqmFMqAUojJB/R1Qj6L1JLbEepwr+07854DMX1mkZm1?=
 =?us-ascii?Q?NadyxzfGMbyQYDvUEz04PzelV+tJihe65rLhII07hULKZF8DlN8p67CuXVe2?=
 =?us-ascii?Q?DNAAEodknUHNn9BkZkWYyY8cQLu+8/Y6rKNDSfano+AQfHUTZIAab3fVYML7?=
 =?us-ascii?Q?hGBUrvEtmYJfwmQ6hqAHjZzTrZ7EyuJsXEEjNEq7AcSRWxYQevrjSNbtt71t?=
 =?us-ascii?Q?gJHHT11TG3beCM2uhC19KaizYkmHEnb9DZJ00MYPuxjdXFdc5BldHU/UpHO9?=
 =?us-ascii?Q?XJmheYp+fKGtb9hZGah0WxzReTfulxp+dcd00oDqd8e7+VnANIXutwo+y186?=
 =?us-ascii?Q?sDnb8B6rlJW7QuBnvlZkcLcgAhDhsbgH7QXSAU70a1EGgxx+aj3X+NxhenF6?=
 =?us-ascii?Q?dIxumXOgpuGs1n5e6eqXqX1OPoPADI/W1sDf5IWhQUxfNxsJDEBOtI5/wW6b?=
 =?us-ascii?Q?KcvSQBBjX/IPrmXFqm2GTSWlFQdgy5GT+LZgq3Dr9NGoiBoEoA4g9e3EmAnE?=
 =?us-ascii?Q?xc6ZnDJJL5hut4+/3Gdn3AoEmjSr/OqVCa2s/kXhIZjD/+MWTlIYnV+JeRsc?=
 =?us-ascii?Q?Bp2uwDVD146c986pvRGSvMn5qzG+LiU1NMtiqFawB0laDQ0A+iZ4eZiEKnEQ?=
 =?us-ascii?Q?rAH1pEPnd0NV+IZL1n0+5qH0w1b+W4n8Jylk8gJsBIAmJjYeUAf6r5DNyRQ2?=
 =?us-ascii?Q?MmSorg7NbE+gHxZ/dE578SSG7FdhUa4LzX/QmGuOCSEMe8t1xmwXERmR6x5J?=
 =?us-ascii?Q?ogMNRLjFd5uYDyrTCDpsbXADenxkbMI1KPIllYjeFCja6uT1Ckcn7leBU9av?=
 =?us-ascii?Q?ziuBS8kymTkrBrE76Tpm0rWva81N02Sb3i8MIfJhX443ELLagnr3ONKAIrNL?=
 =?us-ascii?Q?mB7dtRN8LnJomocV68dQSvORmoMmsrwDcEqpbIUu0CwuYJHzWJ4jbG1NVis9?=
 =?us-ascii?Q?M1VadxAtfT39EbZy6BOnQBRf17qXZyVat+V4K9q89ZJXigb1TXp7AdQNJI1I?=
 =?us-ascii?Q?cI1ck8YEEPElPpBJOPd9hrPqDl7oZdT8ut/OhBUJsyzsd0ejL7LhZTOB05y5?=
 =?us-ascii?Q?VgKMr0qIC7nuokmxQMuqGJT08TbHwrWi3nJMW9cl525Ciq5h2I8CWYmPEglq?=
 =?us-ascii?Q?qzGiRG517MnCCcLj7H5Q+O+GN+rv1KMOP0X5UB/T+crWr+6PLtSzk/BibJ4U?=
 =?us-ascii?Q?apwP96K3+8L0Dm5RPL6+LrYULf55ROd7QAqZq/DRlJ5TbdPUkbOaBAFWOaxe?=
 =?us-ascii?Q?aWvmCuKOaJy7h2106j6A6an5knaYd523nFrKzUg/d1uXAJSJQWAc5k4CYZM1?=
 =?us-ascii?Q?v6MqeanbzlrBjBA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 11:06:30.6178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b7c1366-d23e-4f01-5a1e-08dd1dc1b1ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897


Jakub Kicinski <kuba@kernel.org> writes:

> Sanity check netlink dumps, to make sure dumps don't have
> repeated entries or gaps in IDs.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/stats.py | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
> index 63e3c045a3b2..031ac9def6c0 100755
> --- a/tools/testing/selftests/drivers/net/stats.py
> +++ b/tools/testing/selftests/drivers/net/stats.py
> @@ -110,6 +110,23 @@ rtnl = RtnlFamily()
>              ksft_ge(triple[1][key], triple[0][key], comment="bad key: " + key)
>              ksft_ge(triple[2][key], triple[1][key], comment="bad key: " + key)
>  
> +    # Sanity check the dumps
> +    queues = NetdevFamily(recv_size=4096).qstats_get({"scope": "queue"}, dump=True)
> +    # Reformat the output into {ifindex: {rx: [id, id, ...], tx: [id, id, ...]}}
> +    parsed = {}
> +    for entry in queues:
> +        ifindex = entry["ifindex"]
> +        if ifindex not in parsed:
> +            parsed[ifindex] = {"rx":[], "tx": []}
> +        parsed[ifindex][entry["queue-type"]].append(entry['queue-id'])

BTW setdefault() exists for exactly these add-unless-already-exists
scenarios:

        parsed_entry = parsed.setdefault(ifindex, {"rx":[], "tx": []})
        parsed_entry[entry["queue-type"]].append(entry['queue-id'])

Sometimes this can be used to inline the whole expression, such as
mydict.setdefault(key, []).append(value), but that would be unwieldy here.

Anyway, consider rewriting, but it's a nit, it's readable just fine as is.

Reviewed-by: Petr Machata <petrm@nvidia.com>

> +    # Now, validate
> +    for ifindex, queues in parsed.items():
> +        for qtype in ['rx', 'tx']:
> +            ksft_eq(len(queues[qtype]), len(set(queues[qtype])),
> +                    comment="repeated queue keys")
> +            ksft_eq(len(queues[qtype]), max(queues[qtype]) + 1,
> +                    comment="missing queue keys")
> +
>      # Test invalid dumps
>      # 0 is invalid
>      with ksft_raises(NlError) as cm:
> @@ -158,7 +175,7 @@ rtnl = RtnlFamily()
>  
>  
>  def main() -> None:
> -    with NetDrvEnv(__file__) as cfg:
> +    with NetDrvEnv(__file__, queue_count=100) as cfg:
>          ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
>                    check_down],
>                   args=(cfg, ))

