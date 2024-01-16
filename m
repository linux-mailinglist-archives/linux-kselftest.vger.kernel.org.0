Return-Path: <linux-kselftest+bounces-3076-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88BDC82F09F
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 15:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0448C284529
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Jan 2024 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498E7475;
	Tue, 16 Jan 2024 14:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qpxtOZP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2045.outbound.protection.outlook.com [40.107.94.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5851BF22;
	Tue, 16 Jan 2024 14:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUyMpwHM/PWY2oBvy9A+58qwhdKeHfNjVDm5kC+RubpWQdtWThFa/0kmfLslyzGQOQfg7czrwSRTPg9mI9MwQG0Wfli2tWZ5gfo7tSXcg5o0XJG6cdUk43T9qiapA/uSaN6G8blfauxhRaS6gAKTcuGkYC/NAAsSLAa639+1Docc721CC2A77HgWxpkDO8+7uQ8pFc3AM8sqIAA8Bv4OWdUXzDgT492GnyPwkzk8FwpHyKieXfVly/dOjgh6lvFMvVUI5CAiUc93L+9ZCZ8R9f+NW+gXfFC45mT1ec40+Kw+77qN2hK72H72bNTrbSielnboRNHfz57jbXuxcY236w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/HLux5DV1PmRucAEgs7MNp+KnDjMIMtYpo1zVsah+c=;
 b=a1kKBzcaf2y7CKaI0z4cCer+JK3RyK6ltymAK8459W5YIduCskQFyC3idNSvLFyKYZAzI7KClEqnVCBckxwYl4NdX8syYVAV8gUC5l1QkMNgYpmYEV8XYlvIej6wKNZfA2GGrdX1qfWOheJeSsWFwUeI5S4brYkWPve1eTVttGVipTAoIDgqm0mV5gbtaZ7O5ZIhsPPhelTDLtVImC1XGnNU/WcE6Sb4QJAMEo31fT67yKtFCuzQwpXdsm7mf1JjjT8uCHdLLVp4qnIU6vHJIxyzJCyT6jiaqlFeAAkZO8fERK34w2A6T7EM/m0krbz9nkh2040OCnUgQK9rzrPdsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/HLux5DV1PmRucAEgs7MNp+KnDjMIMtYpo1zVsah+c=;
 b=qpxtOZP2QqzSx6Gr8PAJ6puH05c4U3UpzP0S80R2/w30e/urY68MQQ9TrG315XxufTeB2CSNjCHiIoG1vmdn24u5cH85RonhyvMj83ttZibnVJpXmfqIWR9or0K+hI7Qd2yWdMzxPXSYsnOBg0JWUA1jfWn9xLhM0ZOz8vdf0hTwfzPL0FjjkxlFobFCtotmJ2kT5+WolPdpp3dm2zEIQl/YVKIjKqNLk1g0r4OoX2jiCnuvqJym+tM4y7xMWviTD0Ma2t3SFSs1AFKFhc4sy6ltr2YEh6nWyM6LTeB9JgQqlnzwbkBP+RnJunDlBhsugOSF8leblODhXocygxglAw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8)
 by BL1PR12MB5364.namprd12.prod.outlook.com (2603:10b6:208:314::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26; Tue, 16 Jan
 2024 14:37:42 +0000
Received: from MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765]) by MN2PR12MB4373.namprd12.prod.outlook.com
 ([fe80::ff68:f81b:d451:9765%4]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 14:37:42 +0000
Date: Tue, 16 Jan 2024 09:37:40 -0500
From: Benjamin Poirier <bpoirier@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
	shuah@kernel.org, jon.toppins+linux@gmail.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net] selftests: bonding: add missing build configs
Message-ID: <ZaaUtIuKBQByp4j4@d3>
References: <20240116020201.1883023-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116020201.1883023-1-kuba@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0232.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::13) To MN2PR12MB4373.namprd12.prod.outlook.com
 (2603:10b6:208:261::8)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4373:EE_|BL1PR12MB5364:EE_
X-MS-Office365-Filtering-Correlation-Id: e5effd5c-d680-4010-260c-08dc16a0b226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IX6y6Rg5udVD32VuD1ZkjhnsAfvdTOvTf0nGzi/0OcJB+RHCNTZdQ83rXoYr+EENNNW+lQaUluJ15ekCXZN9JKuyykvTOaBLwjPktiLvYMt78infh8QYYNqQ6gzAj10XUbNRak6clRnSuuDn9POvUhP6DEhIm+2XVRp7XP/WZZ7l62kXxwglApQ24QHSQFCs0Ao/kpTvZR7s8YtxV0irQbLko9M+jxuXcyHAH/v6LW1/USXD6WChDm5eew83jQYkGxnBah/4yqEz4Bdo5n7sBgoL2lia8wT6EilAE8k/VjnGzFEkhm7Kp8Ehk4kWUthjvWcrRzJm6zjqYrl+0BjEIsLXGe2v0VPxciVHf+KsyhLrrKsrsmsr0l9BIUGhOGztLPd5gZQ/FYWH/CR27+bzI70YyLGuERK3jICj03cr2X03RwdN9StKkPtbGoJRJnB17dlpIdF2sk6ke0YIq8QCWHzASi87TjJ7t2kxjgQKd/kZJwhP/637qc8dmRD+Lb75LFRkCUEKDNPbPCGz2DM/TbukaSuBBN6ou7VQkfLRyIxdCH6iPD6EoOZcgfQ+vlLN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(9686003)(6512007)(38100700002)(6506007)(53546011)(26005)(5660300002)(7416002)(4326008)(8936002)(33716001)(41300700001)(8676002)(6486002)(316002)(478600001)(66556008)(66476007)(6916009)(66946007)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4U0qUsS0nnqZLb/QV6GM9DzXvA2+5w7FdQGkDaOWwhuDxgXPQdJRVXHduUII?=
 =?us-ascii?Q?WEcSfuDkYudu8L8ZHHdnXHHpu4ScvepnFXZExtl16tto4/M8lTXFQpNDH2RW?=
 =?us-ascii?Q?2yZdVwlUxeAde+tT0n61xjAcWo7+6FVh9YHNXpWaROR4FArT8eLaQr6O2iF8?=
 =?us-ascii?Q?Pd+rVJ5Ix4bHjk3kDbyMNcYvNqGjP/vV63Yar734afeuOkSFPOUVQLK5ovY5?=
 =?us-ascii?Q?SnLnQUdOcQzwpSng8FxxrQBdKyuJ10Ne8ochm6pHL0cTBRFiI+fKcCGzVIzO?=
 =?us-ascii?Q?kUbt+PIwhiHfbV0pe0/zwtBbbIkZcj9EjPb4A0vahB0nttkRvJHSR6M25L4o?=
 =?us-ascii?Q?r4hAiXgov06Nh27fGGWWpiFj/I78bR4mXly5OUPizMaHYnUMmAAl/roqz994?=
 =?us-ascii?Q?Bv8SuDiCvJhCikN6P+dVdHPZfESXWSTxPeGKc4cJ+A8hzUSfLW1oalLeno+U?=
 =?us-ascii?Q?ck2pwrh843XBEbdP6iDaH98RJ1oWqvtSAjq7ua10FVCqkOgLw/KNMrlCum9m?=
 =?us-ascii?Q?jdttkssMk1Ogc8XiJFGiCKhl1m6jVTHEMEsOrC0ZaawtYxQGc8cb9pnwXe0w?=
 =?us-ascii?Q?sczXfp7o8D8tdLzjIz08jw0ID9t/ftAM253R9l2zE1LaBhU+HjbclAsR6Cfq?=
 =?us-ascii?Q?JxYt+aDHFHS2Gn2lRaQzmoeTbZ5wCgsIf3Z/L9sOI9muo92jxsl+Vwl72e3S?=
 =?us-ascii?Q?55pLxb/VDVqO808MnVS5dd0fM+6iRwRs+XQ+dXa0EWBdhazVRjUWGMgFykD6?=
 =?us-ascii?Q?MzNZk91RnRvkHkWqXt2dI/wXo0JUpWBeOPW2AlTmBwOL5w6aUGjPxdcEaExC?=
 =?us-ascii?Q?a0hyAdh/usKuD18uQuaTz3UOkYbdkUznHnhxZ8mQLs4rNY5krXN5GgDjqZOl?=
 =?us-ascii?Q?WATTmatcjwD5vE5ceA45BE6se2arNAuRY54uM06Q0tcmXm/8Oi5c4LGT2NYx?=
 =?us-ascii?Q?oTEEpUDZlgxLdujlN+mq5NEm5gtyzHAkHb9373xI82PKBWpP/EpTQ6HhXP7G?=
 =?us-ascii?Q?jnYz+HRKlrte6p1miJ4EiSs9k91s/ji/AIBXQpGd2EKKM4tqvuZPXRqCMwdH?=
 =?us-ascii?Q?gr5bZSML/enSvEvmhkBM5Crv11QoDjYKv3eFHuCLFE2XeeTmKkgBYbPzlMOa?=
 =?us-ascii?Q?W/mDT2cmrSmFIV9kbP/9IPrwnEBk89yNQT27ZLjo780NKR77fmDOawVPTAS9?=
 =?us-ascii?Q?6Qy/ug5UWThV0j+h6SlsAp8ZqFqiyIdTcxi0Fg/+oVSpW0nfhRdZJcW2HRmw?=
 =?us-ascii?Q?nbSctLuNqF1mohpwVcezbvBtrz2qhAYPVKCrzHJ4jyz872NWuH9Mk/8fpDVe?=
 =?us-ascii?Q?cnnkYKnGKff/TUMFDvw1lSmMhb93bSlJq9TDM66w6u6JtCMXaCEAzQcf7CQu?=
 =?us-ascii?Q?gVcogg6Gs/KxmD/AvNgm46EUvTEdjRShQHUXDyvZ5NFTaokR5uhwJvl/TQo9?=
 =?us-ascii?Q?LRNUN15+zaBcDv8lWPtB6CwDbIPziUF+oZYF+9nPy5WsPQluLWTFAHoEdrHf?=
 =?us-ascii?Q?P+dri4REHEKXaS4DHphNchBr7VkKikwDKZEeic6e/0n7yRMIku9DhJZDcwIs?=
 =?us-ascii?Q?780MflvoDHNVcvYJhHq6en47+K1wtqA0tb6velZ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5effd5c-d680-4010-260c-08dc16a0b226
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 14:37:42.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wa6yP86kWX7Z+k3vi51LRA77wbbfgLkumxH2ORwOrwYOrVS00kqj7sG4ybIk3TFPmkoinbS0d4e9n/z0AspI6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5364

On 2024-01-15 18:02 -0800, Jakub Kicinski wrote:
> bonding tests also try to create bridge, veth and dummy
> interfaces. These are not currently listed in config.
> 
> Fixes: bbb774d921e2 ("net: Add tests for bonding and team address list management")
> Fixes: c078290a2b76 ("selftests: include bonding tests into the kselftest infra")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: j.vosburgh@gmail.com
> CC: andy@greyhouse.net
> CC: shuah@kernel.org
> CC: bpoirier@nvidia.com
> CC: jon.toppins+linux@gmail.com
> CC: linux-kselftest@vger.kernel.org
> ---
>  tools/testing/selftests/drivers/net/bonding/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/bonding/config b/tools/testing/selftests/drivers/net/bonding/config
> index 70638fa50b2c..f85b16fc5128 100644
> --- a/tools/testing/selftests/drivers/net/bonding/config
> +++ b/tools/testing/selftests/drivers/net/bonding/config
> @@ -1,2 +1,5 @@
>  CONFIG_BONDING=y
> +CONFIG_BRIDGE=y
> +CONFIG_DUMMY=y
>  CONFIG_MACVLAN=y
> +CONFIG_VETH=y
> -- 

Hi,

I tested using the minimal config generated by virtme-ng and the
following additional config options need to be enabled for bonding
tests:
CONFIG_IPV6=y
CONFIG_NET_ACT_GACT=y
CONFIG_NET_CLS_FLOWER=y
CONFIG_NET_SCH_INGRESS=y
CONFIG_NLMON=y

