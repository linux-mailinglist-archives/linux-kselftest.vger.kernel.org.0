Return-Path: <linux-kselftest+bounces-46780-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D19C96103
	for <lists+linux-kselftest@lfdr.de>; Mon, 01 Dec 2025 08:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8550D3A2692
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Dec 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ADF22D73B0;
	Mon,  1 Dec 2025 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEhg779g"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012026.outbound.protection.outlook.com [52.101.43.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881822D3EF2;
	Mon,  1 Dec 2025 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575954; cv=fail; b=R53VwIE6+jU4DZ+HhdUPKZybgrCjAj6n5efvGuUV0yD1qDFO2HBQr8xE8hpoi1eFLT8SBM8zftvBXiXVTo0kYeEl36ZNGzlCh5UvKzYEYxUv1amtcVfhKKFyKOy6nj+erhjDed7EA7FK0HPLvQTL9BdSRhU8/p6cI+2AJGzauPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575954; c=relaxed/simple;
	bh=iksaNFs69nCJn0LOQSKlXMB0oVDFNkqt0kk6P2X7Jh8=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=I9eyTIk8aqW6Rp+MptkuRLX7t9Eq2wlAmdF0frBX1JEOAqhslsztTFtmT4k0ghiFny5m0JpWddpP0VWLjSYGu1Vpv5V/y+kz/rm+dhurdg8fu2XAu52AH2mo3u648D74wdwuYd8qXj0ovVTowmgDlubwvgSuFUMrVnpi2O4dYfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEhg779g; arc=fail smtp.client-ip=52.101.43.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jg21LB3jpAqflzuvWPHVZhco2duE4oZ/2Jxt0qUYoDrMZfxV+Xc3XKiS/xyV8HuWOzbOc5L3W9d7uFmV1hzoEG7FUbv96kBFGRRRRkYN3dRW31J4lvFnV1b+y+eWQbnZPwAm9j+iYpuNvKr72kbMeRBBq/38aYAa6dl+ssNLsDl+bu0UovEzl6Jd+fD4N2T/ZIOvscs9QL8zw6t1z2BOLeoVn6ylrAblQdEw9fkOX0Bt78zgkB0owq6sKi3qjpMJlXn5Lj3RfUk9Df+QjKocK04YptKkkgFXh5iLEBQNG1J2gmp1E/bgIxB37NEzaLW2MGHyBYcOdWZIbp2Df241dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMDbAPQZZMA0ZMxD1HR3r31jI5hut6Zh8Z4IRiWumAk=;
 b=hI+vQEKOWzXM1uhHYyjZzR2rkg5yW+WGhPkniLBB/VOs9NVfAJsYIR5q8eUdF92kSy8D5owuYYfIz+bIiM0UEsDy8tiySebBt8gqaIQs9MXj/sFWXR0C51yfbDo2UySgFIoS9rUppXPhqyCSNHu1WKQ2IykS0sRgpIr1OxlJn5FRVG73yKuheXaaci4buRq5yi5rGzTiqVnes9HQrdTdFVWzhmULNj+kpF/ItSw5S8SLLLvcO/Zg2m1v93ea6VZ4TTQ8tsNJN1DQsAaOscXm7jZ0mXyD08Gmn8eYL8LwwL9z1BsIW9+iaZRWMN1kpgQ8HZc37shsG1cNNkgGnztDKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMDbAPQZZMA0ZMxD1HR3r31jI5hut6Zh8Z4IRiWumAk=;
 b=mEhg779gMVbMhXpXU8xfc6/XeOq6fEBQ91V8gre6td3DQSZjmc7b6ylo2xEae1nHvrMIhRAT3TuVX1IAjdS8YpqxJ4NvxiAG/Uxzdz5W91K2xY6Yih6LOCDeSYDwDLVBX4cEaiTgBOr1zZ5JJ5Ae98/ogw/JuB4Teg9ITF4o6t+9LIrVp71qtJCGXPMaZMqw+BwvAWjiyLEcNAHg93x0IP1G3BnZcebYUKiUe2PBJscxHOV3LMKHpH/K6sN7YpGPK5kPDRXhp/fzVCh5uj3goVxJl4XDsBwg4Ins8nYOkIOXPbBymqZ7KQpQps2zuQChRec8/vHVdSv6vFiCXyY5tA==
Received: from MN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:208:530::25)
 by IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 07:59:08 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:530:cafe::7e) by MN0PR02CA0022.outlook.office365.com
 (2603:10b6:208:530::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 07:59:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.0 via Frontend Transport; Mon, 1 Dec 2025 07:59:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 23:58:52 -0800
Received: from fedora (10.126.230.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 30 Nov
 2025 23:58:42 -0800
References: <20251128004846.2602687-1-kuba@kernel.org>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>,
	<shuah@kernel.org>, <willemb@google.com>, <petrm@nvidia.com>,
	<linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next] selftests: net: py: handle interrupt during
 cleanup
Date: Mon, 1 Dec 2025 08:57:24 +0100
In-Reply-To: <20251128004846.2602687-1-kuba@kernel.org>
Message-ID: <87fr9uy6oq.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|IA1PR12MB6411:EE_
X-MS-Office365-Filtering-Correlation-Id: f87b1d47-8288-4c84-57e0-08de30af8199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X0XHidCv4Fw/8fDKBdgPYpt1qHYJbkQzmORdsCNSveXP7KW+ZjZLNVKW4nWL?=
 =?us-ascii?Q?/aUcASiz1Y0er8IktmcUx3Jrk5+8MccDmBUgmgIl1Ri90zsjFAtjaB40oxeH?=
 =?us-ascii?Q?yrg8PGYARvkOCYNCFJiBCyMsxjAU9EXRNrzIrx/7392vvIwd87sYmCJqs7gC?=
 =?us-ascii?Q?xTSkCESI81BUhBMguOXL3M1hxCAgYNtDMDEVZW9ULhhzwaqED0C+8pEekCTG?=
 =?us-ascii?Q?uEkKE1brjz4I0uHvJtjYXGXYqUy6bMucHulX2GeJud7PIqml5J4ZuMw+yjPC?=
 =?us-ascii?Q?HRo14L6cknd7Fxoawo67gkeMDAOnZoWkrKDj1reYav6lpNv/T+n6WEQYZHI4?=
 =?us-ascii?Q?V+GnUji3vk78WEPAdUv0X/VatS1GVWGECEhgKJSvWnRpon0bwvnVqBDZUiaj?=
 =?us-ascii?Q?ZJsCJaRZTcJnYzaSy2vAOzTn4UCl9vrsv02KwbfmOeS007ummdGE7npqE3EX?=
 =?us-ascii?Q?oT3oYtgUwAcEKYhcD/Vmcu42S6a5WmUqVLcyXrDi3oS+xeR6L4XfnsAEgoPU?=
 =?us-ascii?Q?Xb62oM4/QXxliYdpFV2xgN1uqSBa+xW210FIosNblvufD3OE6TWheZlrj2Va?=
 =?us-ascii?Q?m205jFylloGeeVTp2yLzPCJ98d8Hc8ALFP4GGK1g2Hb7Vn7z3VQRsadTdI3L?=
 =?us-ascii?Q?SQJLg6xO6BnGCiZyUq6DE0n71AP9slrnFEI1GsR99L5G1I58W0IdAEveTkIT?=
 =?us-ascii?Q?l2ZbgYPFxSVephCu77/xDowYISKTzMQeBK8BzkGbFxPelNA05F0ur40DURp+?=
 =?us-ascii?Q?sXXThmw5bMWJiItyGQ82PN8ve8Fy1689zXhXGFUfIkcOqBQby2OyzJ3oGsB8?=
 =?us-ascii?Q?nwY9G/bh71SKUh3VEdqftOx2E2KLbuF2vC9MuBP7o1/MTy6twpvWHTYmQEjI?=
 =?us-ascii?Q?H7tZNNYijTGqfeRto2OmBrulCAY5Gm/wabB0O7PKFabReIx+W5KQlWnzlVAv?=
 =?us-ascii?Q?KuLJ0MDsFnK12YMSJQfoVpP1MfPub0eDwn7N6mqByK1RC/iOs60hLuc8li7H?=
 =?us-ascii?Q?Pm8CZiVftTSVCvOCUQWGk/brdThJQ3ceTRyYvtlvpIuah88KwYiaiq9DC2w7?=
 =?us-ascii?Q?l476Jr65Tjpic+TY206O+T5qpmrW99trwf8T+muVW1OvWan5G9yQuiAyVNA+?=
 =?us-ascii?Q?SXla/ISTd44Z2MEdQYlRdwuUr2KnRJipkJlUctELf6EOIXASIwYlcxo27RbL?=
 =?us-ascii?Q?/TeBQ9/kmgVxCW9R8yVFka4ZAmV+ZtDDpi/0LPZVgJzJorDZZgy5th/vEnmS?=
 =?us-ascii?Q?k0yLO5MWzrpOdDxpqzb9wAz6LcXnNV8Y4vES6cwe4ZmysaOd+ExPE3jSqSgo?=
 =?us-ascii?Q?srvqo+q8D4k9mF2+zFO5mWTg0bMVUkqa/9w68+PfeQfzKx7TFjbVY+arehNF?=
 =?us-ascii?Q?oRi28ccYPGakHpozxjLa6s0MY8xP6pSl0seDmSiMa8zrsSgHWwcO/ADPgnG8?=
 =?us-ascii?Q?rk87byTzl5LUvpViplipcua+Ps9D78Pa+6rjxL3y0uXEUduFqsNVoeseRBF6?=
 =?us-ascii?Q?HKLxo7BT2W2paBSynZksTNfHsRBuyzkdvb+IoV2N7ZAs/4+F6WRUGZYZHOON?=
 =?us-ascii?Q?d2LtNxZ2/fWfDX0xRbI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 07:59:08.3006
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87b1d47-8288-4c84-57e0-08de30af8199
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6411


Jakub Kicinski <kuba@kernel.org> writes:

> Following up on the old discussion [1]. Let the BaseExceptions out of
> defer()'ed cleanup. And handle it in the main loop. This allows us to
> exit the tests if user hit Ctrl-C during defer().
>
> Link: https://lore.kernel.org/20251119063228.3adfd743@kernel.org # [1]
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: willemb@google.com
> CC: petrm@nvidia.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/net/lib/py/ksft.py | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
> index ebd82940ee50..531e7fa1b3ea 100644
> --- a/tools/testing/selftests/net/lib/py/ksft.py
> +++ b/tools/testing/selftests/net/lib/py/ksft.py
> @@ -163,7 +163,7 @@ KSFT_DISRUPTIVE = True
>          entry = global_defer_queue.pop()
>          try:
>              entry.exec_only()
> -        except BaseException:
> +        except Exception:
>              ksft_pr(f"Exception while handling defer / cleanup (callback {i} of {qlen_start})!")
>              tb = traceback.format_exc()
>              for line in tb.strip().split('\n'):
> @@ -333,7 +333,21 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
>              KSFT_RESULT = False
>              cnt_key = 'fail'
>  
> -        ksft_flush_defer()
> +        try:
> +            ksft_flush_defer()
> +        except BaseException as e:
> +            tb = traceback.format_exc()
> +            for line in tb.strip().split('\n'):
> +                ksft_pr("Exception|", line)
> +            if isinstance(e, KeyboardInterrupt):
> +                ksft_pr()
> +                ksft_pr("WARN: defer() interrupted, cleanup may be incomplete.")
> +                ksft_pr("      Attempting to finish cleanup before exiting.")
> +                ksft_pr("      Interrupt again to exit immediately.")
> +                ksft_pr()
> +                stop = True
> +            # Flush was interrupted, try to finish the job best we can
> +            ksft_flush_defer()
>  
>          if not cnt_key:
>              cnt_key = 'pass' if KSFT_RESULT else 'fail'

Nice.

Reviewed-by: Petr Machata <petrm@nvidia.com>

