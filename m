Return-Path: <linux-kselftest+bounces-40381-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D20E3B3D43A
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 17:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951A1177204
	for <lists+linux-kselftest@lfdr.de>; Sun, 31 Aug 2025 15:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894CD212F89;
	Sun, 31 Aug 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OQMuVqZW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2050.outbound.protection.outlook.com [40.107.244.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93764AEE2;
	Sun, 31 Aug 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756655537; cv=fail; b=tZPHu2xB6VWamhZrzg1Wfq7kAvtVsKFTrtjY03HRm8bUvqE+IWile7yWQT3waNSCjDW1vPasVc0p0n/2L7IY2RUsw9OLNhDlsPxOk2yaBFf54Juebbvl7YWD+r8YaQgpeGC8gkTp88WvIed3QrZApQPxfTzeI2/t9ua0FJHdL1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756655537; c=relaxed/simple;
	bh=r+z3Tsa71fdOc9AyJn6Yb1ztyWDNnymnL9zZsgjDilU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=obAE8nvHJjmNXRictIgRsuRtJloXfWNQpHaauxs90ujwxO35sT5Tg9LC6JfcJoVwhnpVuRVdnrym+b0X2PAK7ieWrbhlCpUmI4puJI3hlNs0vIggqq/4tfmyAx2ZexTU8PRfy3NNiTa7nlMxjmAMrmcOLbgpLUQmSZ+aqzbP0Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OQMuVqZW; arc=fail smtp.client-ip=40.107.244.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y3mGVSNArRLk0LzlXEPj+BIGO8+1gNJrWlMRm1/hYerJXyoDaHrAqxX/Uao2tb2L5ULYE/zq0Br1mdl0hcMeT2P3+fNtk/J3im+NHhGEGXWvp/epmrqf8+MIOmEnNhp3BlzPyQlvO3HrUD/ZoC2mnjP42jeHmMEevmfCLcvuA3bjBbn9/M6kVa+yVvqqs06naqJVE7sMC1RGRpd5mPqaUFBM9naK+QOKTbD3+ogw0AP6T+v/zbD7gWLqlaKHntt6ssQtqbGPCi2NIT4RueYRhTaIIhMWts2XWg4teRqbJk1XK/aJlv9Ub8SMO87MohfdIF61oHg/TKOMxRJxW2THOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOgy+ipFZPIMN20d+0mzI5bt31uHbTHphhw05LwIVgk=;
 b=PBqsTlVWjAqKFuKK+Ji7CXTTH5J/WRwNXLzVtIhHwnIwSG9SGKWy6RWjcSBzpUC1Xv2q+oIPeOBQVeoaKn91F9QeUtyIVoC/8mWO61ckBRUWr1wcWxcMLF68bpU8WpXwmjR1NViwEnhn0rwXe3f7XAOniUXAn3kkH51lDNL9u9wJCh5vAGWtNwDYNtIeVeZH3nHEkIJoVk3VEOkXoaP8+03DQ4KSlQzhmF5uilgCK/lLa/+eODkT3RSQr1ze5xobRIu1csm5EZ1BTXKOVUV/pBAF9/2F5MBShi46UTfeDhH34OfijwTYfGGfRpA6AX0K1xMK+wVWSabDpjYbYGoOGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOgy+ipFZPIMN20d+0mzI5bt31uHbTHphhw05LwIVgk=;
 b=OQMuVqZWdtzEeXg/7Y0PKPbOWZop3t/bvLYXa5G2s+LtE9Iq/Sm6u2uQ8yh1KWPIOiFzAVNx54JwP7VodUdUClEU+5lbmJylYrBt/iDk4iK2+Yct+AA8+SVHMYJcvUZCwvblF0yGQyfioInL0n4Y8Ma+7rfbXGaNjdE8FSxDHhLkJHbnDyJb6ADIfF0wOEqhcarhLsvwvSA87rlp7cANL2alFPCwoq1Lg/NS1HSyXb8xXM5w4KXQthQdWcE2UdN/r64aujivEYBhnFmYQQ1sQ+eCHwK35uIjH/DUjUJIAIjqCT72dzDxOcaJwsl/xIoR1xrFkFNFoBzCwppyNo3kkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by IA1PR12MB9529.namprd12.prod.outlook.com (2603:10b6:208:592::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.25; Sun, 31 Aug
 2025 15:52:11 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%6]) with mapi id 15.20.9073.021; Sun, 31 Aug 2025
 15:52:11 +0000
Date: Sun, 31 Aug 2025 18:52:01 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sdubroca@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Shuah Khan <shuah@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	bridge@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] selftests/net: add offload checking test
 for virtual interface
Message-ID: <aLRvoV33kUnzk_68@shredder>
References: <20250829095430.443891-1-liuhangbin@gmail.com>
 <20250829095430.443891-6-liuhangbin@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829095430.443891-6-liuhangbin@gmail.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|IA1PR12MB9529:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe2153b-0ed5-4a7e-e6c5-08dde8a658cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TzppaOfpM8X4QM/IGXFGoTJ+ygyvj2ZJw0W3fUOMxtVGlQ3OfVyCiBkzkJ7T?=
 =?us-ascii?Q?ad9TCANBhWjKkRy6jyn2QodOY0ptYfvp5lgZXyD5IQk9+p+Kudr2AYvfXOsK?=
 =?us-ascii?Q?g6G3kuZgIBv20q/EBFW9pvutRjrq3WwlrAyotPnIwjzxvdEHMOn9dm8FDlV0?=
 =?us-ascii?Q?W9UZUmzcUTIV2s0spx3ITtu73L11crAF1TYMcVRIou8N6W5Fcss9QPB1gmPg?=
 =?us-ascii?Q?iCIiiKkKYRTQPPynHnS8LtcO8vn9X82astH2NYGJexvnMlszU1F0uoIlUHdB?=
 =?us-ascii?Q?gHLWZMIh2czBLAh0f+/Yd4e8mVrcn1voHlY8qwh/ftU+7XEgL2Pt+DRU5Thn?=
 =?us-ascii?Q?8zEQV3Zhp59zqQkzBx8rCDGiS00GCGJPBWpHuRApP/3/+KnWquzlTwCLQ7q/?=
 =?us-ascii?Q?qyGSwjpgR8qpMSfnx9KBRV4HgXLRfox1oUaNG1Ru1F40MhZXD899DBB4On44?=
 =?us-ascii?Q?9+9fhvcWK3qFH15wLJBco0E3MwwH3I7qjCo4t1rTHS+WzneW3udRZn2HPIAG?=
 =?us-ascii?Q?vVQDVn7ggUNdlx62vABfiXj2XvUjYKlOANZeDbpJ8QYQIglxJ+JiEKinVDRf?=
 =?us-ascii?Q?mm30mDrLwkBQW3bkbRmn7/gSZZtiu845bEt+LLIE8DMXYc6KC4dtzZt+R7ca?=
 =?us-ascii?Q?0BwRgMWEmALcrDKoPjmUDkbBaapNj0+cV+DvRoUU3VUSJ3MYF495ljH4kSh+?=
 =?us-ascii?Q?T+LNcemQaLTO/1ITw7JKucsONu8nJjhUnhk4V6/aIZqycNs/nKzYqMsZYRv8?=
 =?us-ascii?Q?J+U5FpfWDp6UkV3TyHY8nMxD8+yhkENjWUqGfWITZlUDUIFaTMrZ4h2GkxyR?=
 =?us-ascii?Q?fcFla8DMLfdKrw6fIfpIyRcjXwBBNwP9EVVgEkHbG50aD8lW5PQEdKZcwSBA?=
 =?us-ascii?Q?BenZeKL5zU8F7sl+nysyf3gBVpX9scXAp3X9F1lIGCgU7ycqS23QjPlk2sXn?=
 =?us-ascii?Q?uaehvbsxuYbBoRbvJEKBCu4NFap1CxyO6KlUiBsEaU5Okrtftgenkz/FLJgL?=
 =?us-ascii?Q?Lxooiurisc2uxGQF0dNVHd2mWI+e80ypgnVbyWDYlGJgiBmPjGydczt05XQ7?=
 =?us-ascii?Q?VUmrzLvFhVLJ0SZHgL0qLnd/pCVYSQgaxuVyyvW+GJny/79rYWTp3i99a3mm?=
 =?us-ascii?Q?5/QPXLDX5kM4uRzQNDE7JsrZAIrgt+6LgpEHG7SnOssmKUO2SbLZI8QP90K+?=
 =?us-ascii?Q?R0YYW2ApmycMvO+jMtcWDrAqIjbongXrfrVbtAE1kzhATtjvv+SlH8dj8Q2z?=
 =?us-ascii?Q?BrDGghhZrjok4auFdY8SvJ3K826qqtq76SUXGaMuppUm0manCb1wLhHgCzBy?=
 =?us-ascii?Q?jfE+sE1KbkRabm8DAuZy74h5HbCl0JeUzb+XQAdytMKKZyNJ99DW9rOdqICg?=
 =?us-ascii?Q?WwPm1hOBpLfF6Sdq2/jVBM8zhVxm2a6yihADArEMBlMdpPcpEUDvcjWhK0x2?=
 =?us-ascii?Q?R6MMmO7vOX4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KL2+5QPSGpnVbSmTzoZ4+lME1FEMjbXVQWXBo60boC7Co8GJTpG7Cnlisv6S?=
 =?us-ascii?Q?e2YzLln8MPml3eaOGlw0NIXyO64x9PgJqzqdRd1KzcuxpimnNJLzQ+9HLc8D?=
 =?us-ascii?Q?0u0KZeOHBo8gpjJVOzDD1nCFsqLQJkmHG8PduwLUjg7mqkHRz9p64ciKXohy?=
 =?us-ascii?Q?KK6PLZbBvl6WS8CzQyFil4TxoTawuqwkRaiFrZObCYiWmCPH73euJPpYwzNa?=
 =?us-ascii?Q?q8p6D9+JD5qLAUI+NkzfR499LwmDUTzbmy9iwnbD1Bp74t/PUgfL+AWTqH7T?=
 =?us-ascii?Q?Uus334ybJo78RJxeqOI4kCfLTfHef9Ea8iYmHQW7vPGexIe9NQV6AheUuisz?=
 =?us-ascii?Q?pC9A9fkZ5xlo4okJOuC0+5j0WwP+/N6hnh5SxPNb/mLHxW/EMStbuYAaF25k?=
 =?us-ascii?Q?gQBTQUaEsM1fzUlBJ6Jea1Yf9Hx0ICTr/DBD+dhkmsJcI3f4hohRMK0Ex2lU?=
 =?us-ascii?Q?bxyX3OsdjW2g4QZcoclTyEyIieh5ybFGPxarCOnkjVYO0rAQJPLs6fhoWEIy?=
 =?us-ascii?Q?KZngoYugJcYGLHj3AJJ7eWizbeA9PuKF/2DYIi/qxPhGJ1mNGsu5IJLxGaEu?=
 =?us-ascii?Q?4SSTU6QGdTDRAbWky7EECMvctIpactz8NPD0U3DJMWlYbNw4V5B9PgdF2EeW?=
 =?us-ascii?Q?TPjCyI1VU7aBuZzvGSb6NMn1JMfl/6o0f+xIKD9L4r6ZvOriwdeHSPT+L0dz?=
 =?us-ascii?Q?g8tZK7uSxu0Np571PmsHIwQBZWw6LYFDLbvhODO4g+4NlzvIadd7aBYT4QCv?=
 =?us-ascii?Q?SAkn8vaCKO92ISSfB4gGvNQDHiCuvLw8aUNMZuggEUD+Cji30YE3RPUFhyJz?=
 =?us-ascii?Q?y4UfeSVmTQ16QjCyP68FwZxwLqHYNwuqcssKtMw+Jc5xhXl8mgMz8fexhKa3?=
 =?us-ascii?Q?27co9MxZDsX/+x8iI/v6HXr4KS6K4dMqtYjoW11g7iBzD9wbIBPFljetEJAc?=
 =?us-ascii?Q?lk7628E53B/L1maoOPi4orn7ohnwYtCxXjaLxSCXtUaCyARx2UK7VUb1qSWU?=
 =?us-ascii?Q?iULo0tCM2CYZK4Ywsv8VnCoOlEs+u5voVLC48w7gSLYBh5oj0wawgIO1zlzL?=
 =?us-ascii?Q?i3vVHdiR+zQHhxQ74XseqyDkT9mZxo7Zeqw77s8ejpvIs/djCcs+11tdg0oF?=
 =?us-ascii?Q?AJtG6G8sJgDf3uIfrlxLEO6XXYhAA7yFQnUQkOBWAp+t3D0kYTpjjb9ltoCA?=
 =?us-ascii?Q?ifPyyYIKZcPTAmQf02IXt6+bXn+cIvT+gWdABxUfiZUypSktI3fgrv2V/pTj?=
 =?us-ascii?Q?djaXMLaE//DQ4yVRLBtkQWWMsWxnZhxOm1pCdLdC6TZ9E7zHJjJVjjuxuVVU?=
 =?us-ascii?Q?tYpdfRP9PdQhQsCjYtVNZOt5JFhdEvDWD6qHyJ5oHfcYwcee2HIfmZ6hRPDl?=
 =?us-ascii?Q?G2sepMQJn3KCPzLLfuVjcB1btY091UbgWAtVfjKcg4cPv6b/nAcUhDyVZage?=
 =?us-ascii?Q?iUCbSxzH8sdub7iMW/K4wPtluOrO6WND9T22kf2359IJnt2esK3tJ3HlmtCq?=
 =?us-ascii?Q?LmKhiX+hg7+bX84p/YfdSggvAJxKOz+vdrESKXWvZV3fkJBuKoSHBB1cloyQ?=
 =?us-ascii?Q?NQw1kcGV8iPgOKD9ZlmOVjxvQzf/gTukIMUl/Ubh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe2153b-0ed5-4a7e-e6c5-08dde8a658cb
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2025 15:52:10.9710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c7bqwpFxsWi2NLRccQ5cPSniRvtzRKCpK9SR7nWDMketADTMJs0GSD+v/87khumv0A5fWg7+T35V5Z9k3MXw0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9529

On Fri, Aug 29, 2025 at 09:54:30AM +0000, Hangbin Liu wrote:
> make sure the virtual interface offload setting is correct after
> changing lower devices.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  tools/testing/selftests/net/config          |   2 +
>  tools/testing/selftests/net/vdev_offload.sh | 174 ++++++++++++++++++++
>  2 files changed, 176 insertions(+)
>  create mode 100755 tools/testing/selftests/net/vdev_offload.sh

Need to add to the Makefile

> 
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index d548611e2698..0f3a64a86474 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -117,6 +117,7 @@ CONFIG_IP_SCTP=m
>  CONFIG_NETFILTER_XT_MATCH_POLICY=m
>  CONFIG_CRYPTO_ARIA=y
>  CONFIG_XFRM_INTERFACE=m
> +CONFIG_XFRM_OFFLOAD=y
>  CONFIG_XFRM_USER=m
>  CONFIG_IP_NF_MATCH_RPFILTER=m
>  CONFIG_IP6_NF_MATCH_RPFILTER=m
> @@ -128,3 +129,4 @@ CONFIG_NETKIT=y
>  CONFIG_NET_PKTGEN=m
>  CONFIG_IPV6_ILA=m
>  CONFIG_IPV6_RPL_LWTUNNEL=y
> +CONFIG_NET_TEAM=m
> diff --git a/tools/testing/selftests/net/vdev_offload.sh b/tools/testing/selftests/net/vdev_offload.sh
> new file mode 100755
> index 000000000000..4926774aef19
> --- /dev/null
> +++ b/tools/testing/selftests/net/vdev_offload.sh
> @@ -0,0 +1,174 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# shellcheck disable=SC1091
> +source lib.sh
> +
> +# Set related offload on lower deivces and check if upper devices re-compute
> +# Some fatures are fixed on veth interface. Just list here in case we have a

s/fatures/features/ (:set spell)

> +# better way to test in future.
> +set_offload()
> +{
> +	local dev="$1"
> +	local state="$2"
> +
> +	# VLAN features
> +	# NETIF_F_FRAGLIST: tx-scatter-gather-fraglist
> +	# shellcheck disable=SC2154
> +	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather-fraglist "$state"
> +
> +	# ENC features
> +	# NETIF_F_RXCSUM: rx-checksum (bond/team/bridge fixed)
> +
> +	# XFRM features (veth fixed, netdevsim supports)
> +	# NETIF_F_HW_ESP: esp-hw-offload
> +	# NETIF_F_GSO_ESP: tx-esp-segmentation
> +
> +	# GSO partial features
> +	# NETIF_F_GSO_PARTIAL: tx-gso-partial (veth/bond fixed)
> +
> +	# Common features
> +	# NETIF_F_SG: tx-scatter-gather
> +	ip netns exec "$ns" ethtool -K "$dev" tx-scatter-gather "$state" &> /dev/null

Why the redirection here? I don't see it in other places

> +	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_ACCECN: tx-tcp-accecn-segmentation
> +	ip netns exec "$ns" ethtool -K "$dev" tx-tcp-accecn-segmentation "$state"
> +	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_SCTP: tx-sctp-segmentation
> +	ip netns exec "$ns" ethtool -K "$dev" tx-sctp-segmentation "$state"
> +	# NETIF_F_GSO_SOFTWARE: NETIF_F_GSO_FRAGLIST: tx-gso-list
> +	ip netns exec "$ns" ethtool -K "$dev" tx-gso-list "$state"
> +}
> +
> +__check_offload()
> +{
> +	local dev=$1
> +	local opt=$2
> +	local expect=$3
> +
> +	ip netns exec "$ns" ethtool --json -k "$dev" | \
> +		jq -r -e ".[].\"$opt\".active == ${expect}" >/dev/null
> +}
> +
> +check_offload()
> +{
> +	local dev=$1
> +	local state=$2
> +	RET=0
> +
> +	__check_offload "$dev" "tx-scatter-gather-fraglist" "$state" || RET=1
> +	__check_offload "$dev" "tx-scatter-gather" "$state" || RET=1
> +	__check_offload "$dev" "tx-tcp-accecn-segmentation" "$state" || RET=1
> +	__check_offload "$dev" "tx-sctp-segmentation" "$state" || RET=1
> +	__check_offload "$dev" "tx-gso-list" "$state" || RET=1
> +}
> +
> +setup_veth()
> +{
> +	# Set up test netns
> +	setup_ns ns switch
> +
> +	# shellcheck disable=SC2154
> +	ip -n "$ns" link add veth0 type veth peer name veth0 netns "$switch"
> +	ip -n "$ns" link add veth1 type veth peer name veth1 netns "$switch"
> +	ip -n "$switch" link set veth0 up
> +	ip -n "$switch" link set veth1 up
> +
> +	link_0=veth0
> +	link_1=veth1
> +}
> +
> +setup_netdevsim()
> +{
> +	setup_ns ns
> +	# The create_netdevsim() function will set the interface up. Later,
> +	# when it is added to bonded, we need to set it down first. And when
> +	# set down, it will have no carrier. So we need to add netdevsim ourselves.
> +	modprobe netdevsim
> +	udevadm settle
> +	echo "0 2" | ip netns exec "$ns" tee /sys/bus/netdevsim/new_device >/dev/null
> +	link_0=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | head -n 1)
> +	link_1=$(ip netns exec "$ns" ls /sys/bus/netdevsim/devices/netdevsim0/net | tail -n 1)
> +}
> +
> +cleanup()
> +{
> +	cleanup_netdevsim 0
> +	cleanup_all_ns
> +}
> +
> +setup_bond()
> +{
> +	ip -n "$ns" link set "$link_0" nomaster
> +	ip -n "$ns" link set "$link_1" nomaster
> +	ip -n "$ns" link add bond0 type bond mode active-backup miimon 100
> +	ip -n "$ns" link set "$link_0" master bond0
> +	ip -n "$ns" link set "$link_1" master bond0
> +	ip -n "$ns" link set bond0 up
> +}
> +
> +setup_team()
> +{
> +	ip -n "$ns" link set "$link_0" nomaster
> +	ip -n "$ns" link set "$link_1" nomaster
> +	ip -n "$ns" link add team0 type team
> +	ip -n "$ns" link set "$link_0" master team0
> +	ip -n "$ns" link set "$link_1" master team0
> +	ip -n "$ns" link set team0 up
> +}
> +
> +setup_bridge()
> +{
> +	ip -n "$ns" link set "$link_0" nomaster
> +	ip -n "$ns" link set "$link_1" nomaster
> +	ip -n "$ns" link add br0 type bridge
> +	ip -n "$ns" link set "$link_0" master br0
> +	ip -n "$ns" link set "$link_1" master br0
> +	ip -n "$ns" link set br0 up
> +}
> +
> +check_xfrm()
> +{
> +	local dev=$1
> +	local src=192.0.2.1
> +	local dst=192.0.2.2
> +	local key="0x3132333435363738393031323334353664636261"
> +
> +	RET=0
> +
> +	ip -n "$ns" xfrm state flush
> +	ip -n "$ns" xfrm state add proto esp src "$src" dst "$dst" spi 9 \
> +		mode transport reqid 42 aead "rfc4106(gcm(aes))" "$key" 128 \
> +		sel src "$src"/24 dst "$dst"/24 offload dev "$dev" dir out
> +
> +	# shellcheck disable=SC2034
> +	ip -n "$ns" xfrm state list | grep -q "crypto offload parameters: dev $dev dir" || RET=1
> +	log_test "$dev" "xfrm offload"
> +}
> +
> +do_test()
> +{
> +	local dev=$1

IMO, it makes more sense to put "RET=0" in the same function that calls
log_test() (like you have it in check_xfrm()), so I would put it here...

> +	set_offload veth0 "on"
> +	set_offload veth1 "on"
> +	check_offload "$dev" "true"
> +	log_test "$dev" "enable offload"
> +

... and here (instead of in check_offload())

> +	set_offload veth0 "off"
> +	set_offload veth1 "off"
> +	check_offload "$dev" "false"
> +	log_test "$dev" "disable offload"
> +}
> +
> +trap cleanup EXIT
> +setup_veth
> +setup_bond
> +do_test bond0
> +setup_team
> +do_test team0
> +setup_bridge
> +do_test br0
> +
> +# Check NETIF_F_HW_ESP
> +# Only test bond as team and bridge haven't implemented xfrm offload
> +setup_netdevsim
> +setup_bond
> +check_xfrm bond0
> -- 
> 2.50.1
> 

