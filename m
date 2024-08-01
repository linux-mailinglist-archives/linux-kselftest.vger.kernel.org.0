Return-Path: <linux-kselftest+bounces-14683-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CB194542A
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 23:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750CD1F24849
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Aug 2024 21:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664B314AD2C;
	Thu,  1 Aug 2024 21:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B3zTKK9m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0D213E04C;
	Thu,  1 Aug 2024 21:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722548375; cv=fail; b=MvWZHF080Wof9n4VVPnhgZeBfInIYl5ZMxfXxD+yxzp0VJFGyJx04/sx9yLR/ucnRQoCSfQyJM9GmS5KcI/Pi8Z3khnf4ted6UUUt3D2oQpUoiYBAo5UZdOIa5jVpLvE4381TzfgDspiOZOu46GKe2p7IV4GCq+C6e489fKquBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722548375; c=relaxed/simple;
	bh=Y3sswxglqHAWMxZ5KsY9JtoivUBBTGIwCHxVJgiga0c=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=QFSJfIb/myWIGkq7zMie5iVxhskbdz5ce+718VOgFV/t00nK1u72XSt0J9oU0SMaUlqaGhdXjJEP7L0NwzN9JAm9vcWWCjL/0JOhmv+RVvRGc84dHSvd8Tpe7ymBHVC+fzxZM2qD/nMkSKK07v83cQ60UZBTqE6e+6boz3hGh60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B3zTKK9m; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwLCr2zO4AaLrbsy3580WswR9Knl8ZMj2BIz2INw+bT7Kg8JBDr5VGFpNIxQ4q+58vSTfhBEtLdQ8GqeVRwCQERcb8s5VIdMoENtj0FkOCzkbsEhFL9/195GWrswmmHt/yvUaZGwD23lVmcc+uHZrlgpSG27fKycejl3A+Yw+8kMNb5VcD2casat6gJySglnMp7MiB15od3SrGlN/oSOP44SukVzcW51+ywJyAz0S9zY9ko/ME14ZWZYlYp12nQrq7Xq5rOlx2nHMpOpRRto6CK7dXyl8b90LqHElSwwKlbYKaBUAiG4leBchNfl8k94tfJfYg11R7xpWPoXwbUUfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUgaRsFfA6BAKVhF+uPH3HZOOu6sVlMEwbTJxnmPLgY=;
 b=maDlHT9UjyR9QGvaZsD/e6NQ03c1ViNyPxmQLNwe0gwuHWAHvRieqd8nN/dxI69sm9ZYvn+2yaqMFOWOJuqoXSmQ3qQ2lUQ7wKSG4q72DlMp2NgwUB8LoR74s9XV1Y3CGD/9+xi3UBn1UuHuGuQMVZux4sSAyh4OLygjMvXHjCE7BwNjG441hOOkW/yUCMe/0oMuxQdHmjO+YMpvDiv5GD0LiGTziFe9+VzyTJbasTwv6z5Ix96u3eYdBXPA2MQl75gTPs6JVPSJ1hCdDqqLlgiDCx+NfMkRsEBReoNQuy8iSxsEDAl3odDS7OkC99Wu22cwXDjuYlnW0m1N7jBqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUgaRsFfA6BAKVhF+uPH3HZOOu6sVlMEwbTJxnmPLgY=;
 b=B3zTKK9mI0UQBMkTp8K8qoFWce49s8a2B+YdWEFAWU1QXrPMyWPWyK/3GoXb4W8xMOyCttl51EKYvmw1yfTeUCHiQT+Q5q9H6zAqrtHmcUrXvOoThRAUPzz8VthyNfo+LLqUupRE3Y+2uUlpQYEEhSeV/ILTlQysy5FMQhn0HaAsaj7awKbBJPZzaVDrll1RqW+0vSflkO8v7U34EtwrChqrt4U79OsQavJFQCG8ADyow4tRYES5n6NA7awOtHXWpNOmhpCwm+b++eW3xEmJFVLtcZiVNZelgjb5+WE1JChswqO/GCwIH5PV1oMFSSyUqpbzJCNqI+auFf/SeG4j1A==
Received: from CH3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::19)
 by CH3PR12MB8709.namprd12.prod.outlook.com (2603:10b6:610:17c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Thu, 1 Aug
 2024 21:39:30 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::81) by CH3P220CA0008.outlook.office365.com
 (2603:10b6:610:1e8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22 via Frontend
 Transport; Thu, 1 Aug 2024 21:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 21:39:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 14:39:23 -0700
Received: from fedora (10.126.231.35) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 14:39:18 -0700
References: <20240730223932.3432862-1-sdf@fomichev.me>
 <87cymt7pmu.fsf@nvidia.com> <20240731173245.2968988d@kernel.org>
 <ZqrjqpKJRgMhlvr2@mini-arch> <874j847hfy.fsf@nvidia.com>
 <ZqurACK6FdrxiISt@mini-arch>
User-agent: mu4e 1.8.14; emacs 29.4
From: Petr Machata <petrm@nvidia.com>
To: Stanislav Fomichev <sdf@fomichev.me>
CC: Petr Machata <petrm@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Joe Damato
	<jdamato@fastly.com>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/2] selftests: net-drv: exercise queue
 stats when the device is down
Date: Thu, 1 Aug 2024 23:38:37 +0200
In-Reply-To: <ZqurACK6FdrxiISt@mini-arch>
Message-ID: <87frrn6hz2.fsf@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|CH3PR12MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 924b92be-94e4-49f8-4199-08dcb2726cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PBVs4J3ZbLqPSAMWnSNPjK6UlC9XApUlKLFYAlEJJ3UPfa7GlbjpDvKpBuL0?=
 =?us-ascii?Q?8dcF+n17L1jKvJRREZQl/X26FrcWbpKinHVh51EIdDDIzWYcUp/H4elN3Lyu?=
 =?us-ascii?Q?OlVAjju9JFNLsTDzE6vzHPmVkR9nH9fseeP8h4dPYDAS6OGjTHOGcZzG/95m?=
 =?us-ascii?Q?YzKzJ4dIUz2GE9cdH5E9R7gYt9ucEVHb5X6okr9vzbdmiR2makE8k5bAekOu?=
 =?us-ascii?Q?9phmSkCDdlrpFQ+DZP17aQNpvuW2yb+k2SUA+UJ/oruCgW5E28q6ccbWWXh+?=
 =?us-ascii?Q?hIZNmag9AY7OsmOzQcEeDoDnUODvOiUOwoDCqMnteN/UEGCzv/vPzBlibWGm?=
 =?us-ascii?Q?bxp6GXAZanAoh7iEzyHs4TBVbpJ2KcYPY2LkUhdOS5/dXyb6tMB8yK8h7Q8P?=
 =?us-ascii?Q?2wBqHSVuukRfkUNjHgba4DrYwCI5VUxDEu7xroK1I9/3LOUHcUm+rT228f1i?=
 =?us-ascii?Q?NHLRNk0G+e7UeZA3tj2zeo1IkgSLDbusTBEnNVLdDr8Fqptwvxw816wq/1ap?=
 =?us-ascii?Q?GDxxv/MKH+qwrunc7VfK1wGJ9+vLGaITkyTu2uti6vcqDxzFdPI0bMFjNk4D?=
 =?us-ascii?Q?I3A+Sve6i7rP72laobHNDc/TxiL3aru9pahUIpo3AkVrO/gWTIt79NQpniEY?=
 =?us-ascii?Q?88lv9ZSbb3PK82YqyluUo56qWFTqrdBQUDnBmzNM/XXI3jBcpeV7hvcineAc?=
 =?us-ascii?Q?ySs2DSlPGUPTJN/juhy+Wc1jALA96g40roDbYc+mR6YmuhuU2tdHj8M+cEef?=
 =?us-ascii?Q?2m08uimIFHnzvTtIHF7HIHceaiBp7xhKyR+uvD6GHCtPEOPv24hws9xpAVPH?=
 =?us-ascii?Q?DFg6yIPsoIR/Afg5MCFYL3p7MlBwTBeRc7q/GRIGsH9+DXniE5A7BDh/Diaq?=
 =?us-ascii?Q?Awr+jZmZCqIVwZwgbWi6OnL+jTZwcURy2Ey4WGzIcXLv2GQ+RsAnVQyGYKXs?=
 =?us-ascii?Q?MVJKGc965rZhWwBmBcWoGtJbf13XbdL+2f7yww2Gf/ygQvlOKUF8b0a9rIFW?=
 =?us-ascii?Q?L+f2eLQYaR/whaH/UDp7OPfmzmH++4bap+jGbWx7d6SXwDPtN/DYCvi9Vut2?=
 =?us-ascii?Q?D0ZJjh04/F9HcPqEly4rToYhSXl7EIYeLmCkrm63oM+Muz2HDtHhgT5XM1Iy?=
 =?us-ascii?Q?Uf5e2ikS0TU8+Uv1vTOHNXwW/6Hf8FZ6Fx/fB0QyRE0786wwpYi6J6AkhVP/?=
 =?us-ascii?Q?6jxIkc5umb70S3BSSXGGM/SBo36ium05Wn5SDOfPayhpCu2qYh041HYSoRTN?=
 =?us-ascii?Q?v+hDvgTmNi6xnx7Fd2eTWnQjBm2Z9GPQdGxlmHSluGVtdpoSZRDGG7MJaUn9?=
 =?us-ascii?Q?4/z9069f2Zt+OtzZnJ98JiWCSzCfBUEdpEPSMKbuCBlxGH/JLZqW+7q3yQ5f?=
 =?us-ascii?Q?AfWlpqS1FwL5tlKC11mi0t7t9XUXUqEGnHNY1Qf7Vp2Vz6pCNq9fzXnG9jCV?=
 =?us-ascii?Q?+YOZW+VJQ4lnbwGqP/YOTb1ra0VtmrIk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 21:39:29.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924b92be-94e4-49f8-4199-08dcb2726cbf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8709


Stanislav Fomichev <sdf@fomichev.me> writes:

> On 08/01, Petr Machata wrote:
>> 
>> Stanislav Fomichev <sdf@fomichev.me> writes:
>> 
>> > On 07/31, Jakub Kicinski wrote:
>> >> On Wed, 31 Jul 2024 13:34:58 +0200 Petr Machata wrote:
>> >> > > +        qstat = netfam.qstats_get({"ifindex": cfg.ifindex}, dump=True)
>> >> > > +    except NlError as e:
>> >> > > +        if e.error == 95:  
>> >> > 
>> >> > Could you do this as if e.error == errno.ENOTSUP?
>> >> 
>> >> just to be clear EOPNOTSUPP ..
>> >
>> > That might be the reason it's coded explicitly as 95? :-D
>> 
>> Both exist, I just didn't notice the latter.
>> 
>> >>> import errno
>> >>> errno.ENOTSUP
>> 95
>> >>> errno.EOPNOTSUPP
>> 95
>
> I believe Jakub was talking about kernel's ENOTSUPP (524) vs EOPNOTSUPP (95):
>
> $ grep ENOTSUPP include/linux/errno.h
> #define ENOTSUPP        524     /* Operation is not supported */
>
> $ grep EOPNOTSUPP include/uapi/asm-generic/errno.h
> #define EOPNOTSUPP      95      /* Operation not supported on transport endpoint */
>
> These two are frequently confused.
>
> OTOH, ENOTSUP looks like a userspace/libc invention:
>
> $ grep -w ENOTSUP /usr/include/bits/errno.h
> # ifndef ENOTSUP
> #  define ENOTSUP               EOPNOTSUPP
>
> I'm gonna stick to kernel's EOPNOTSUPP to make it look similar to what
> we have on the kernel side.

Yep, sounds good.

