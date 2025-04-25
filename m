Return-Path: <linux-kselftest+bounces-31645-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCBFA9CA7E
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 15:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 975F21BC29C6
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Apr 2025 13:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1A324A06D;
	Fri, 25 Apr 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NBsIj6Xa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5AA381C4;
	Fri, 25 Apr 2025 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745588082; cv=fail; b=qlFpP+W5OXA0hu5sdq672aTpVXofUOkLqr8UlFllggK8ZIKJ8YKzzsiJbeq+2Z5YVxW+hMqzk+NcjPcMu2lsUc+y0i2trInW9f9u2BJK9ipeCNj0zOczWYsQoH6bbh7GbRFEUiy0qjnL4msIaDD/yCvhk+onxuNWGpYKcYAqDCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745588082; c=relaxed/simple;
	bh=ZPZt0iKs2EQrVKwhtMoeZ5CnNHRQTVkB13FO6o06BuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uX7ye0qfdYjD6NBdxXAFqWJIueYaevAj+y+fHhJOYmp0eoRvlg0/rCMrnld5uPXMx1PvogavkjbBolyUAE7sKkE2CP4BMHeujd6hAhEjKP6HR9QLyos9CSZZ4Uy53nUHwK7KefrrTgZqvTT2qbIrp+Gv9TKaSla/rXppybcn8NE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NBsIj6Xa; arc=fail smtp.client-ip=40.107.236.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqILUtsNpAX9sa9JF9z2s6tpF4lM12iw/pqW+cfQQF3zUch0pU9g/QmYmRgCVBuuGu/pyN4WyyRK02aLJS3+KKJEh+GLP8fHR3Ch9ODwvjBKCKvinb0TGY9CbkVa2COxpY/RJ3sA4sdModLxjLxEzLPbkJXO4rktgN3+ot600mMhl7sM6NXDgMpTX1aTf7KpQsU0f10fQBrbQdmZnh2FGmgo5qkY5t74Y6Qt1ov4Ti6eZbMUrzOefH5/JxXH3FpVgrxT44QgugYuS7R1+38UCdLAIqeyQHT+nffOGGVGQEkXg4J6nAx2WrGsrZKeePeZhpn/Vnx+XeLoaNc4envF0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rDt4iiq+wtjiWVHh4NeNrAYW5GEBgabMdXvU4sJVVs=;
 b=CvyOGCPOuAGE/7aS+F0Ifwi5xyhhjxA0OUyJerKpTw9rTXQweJpK6683vgZr4Ng7rm25oDiHFXTRa623oTSZlI6ARUrJ2zbaHz21RTiS2paSlIekhM6mV/vOi9kMj4+XBNAXPn/j1VJLxbQl3nRWzN1ZKXpcvQTM9bpDPt/7sWwmXKo4nrss/Smmey/mTUq9SHLC1ZNwFiH2lJh5sWSovdwlChboAoWZGJNrItM3eO7lHK9kFf8tKODQ5qlXfoHD/hiiHch7Zn3BfyDs0zNWi00wVJzJxMX7qi54muqYa2esJyrCpuEkIZtr7oDZ/r9xz4fHMNJPYB0kg9LGWywtXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rDt4iiq+wtjiWVHh4NeNrAYW5GEBgabMdXvU4sJVVs=;
 b=NBsIj6XaVZb92CHycefrankvhGPDhpAoetFyVK6LdK82oWUa2WhVnk0ydzXvrb6i55QXwviTk9uFE2+ERRTkWwRDowo9agioV3L914TPYEkxu3B0qCZ7V5TR4J/bJjWTmpObWTMKQOvjoZcyh1zo9nnVY7/4oG07dghWppk8EZUteaOnp1D+WtcOvXg5285JR6JGcs1qaWL0Zx/Bcr37Cr3wSFWwzDYuvV7SX3ydx6BmWfM2Qjps+MMQKhawjs13X6oHQ62R2nR32uZWONWYiJIJ7aK0QjJKDHDImrD9qcGYdzGKtygs8p/YiHB92Bt3TTnCwq7v3M/kA51DIC2m1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7900.namprd12.prod.outlook.com (2603:10b6:8:14e::10)
 by BN7PPF7B4E3DFF8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.26; Fri, 25 Apr
 2025 13:34:36 +0000
Received: from DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695]) by DS0PR12MB7900.namprd12.prod.outlook.com
 ([fe80::3a32:fdf9:cf10:e695%4]) with mapi id 15.20.8655.038; Fri, 25 Apr 2025
 13:34:35 +0000
Date: Fri, 25 Apr 2025 16:34:24 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 2/2] selftests: net: bridge_vlan_aware: test
 untagged/8021p-tagged with and without PVID
Message-ID: <aAuPYMhMECYMoNX8@shredder>
References: <20250424223734.3096202-1-vladimir.oltean@nxp.com>
 <20250424223734.3096202-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424223734.3096202-2-vladimir.oltean@nxp.com>
X-ClientProxiedBy: TLZP290CA0008.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::20) To DS0PR12MB7900.namprd12.prod.outlook.com
 (2603:10b6:8:14e::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7900:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ef9b59b-1a13-417d-a128-08dd83fdeb0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rSCIKgofu1bqagqMBTuxwsI2Kg/9dGOgPLCSktpx13RPBWzbQaZo6UZhvtvH?=
 =?us-ascii?Q?K9wKGqB5RXvrTnHlhBf1sJTV4HhJ0Eaobe5Wyq5+3hY8L6GJUT22cEjyw9/i?=
 =?us-ascii?Q?Je39tCt3HjOQ4jApSmev8Wiu1+Z53b1yxvFsqeLovEnVxVIihu0tFFf+x8Nq?=
 =?us-ascii?Q?ZWZs51nHAiQ8qXxqVGzbGqAMTe7nUrFh1U+TuP82l6lcQm/rFTSTt6VkMBVV?=
 =?us-ascii?Q?mUSWJ+/F+vzO7UD5lIuvRlvkfEOaitfnjHzoNrltthtNK02MWl3z9vnjL1NL?=
 =?us-ascii?Q?NG9k+DAeHizlwQogZhJjQ4mtm5lE15yGv1dEZcr3d5xsM68HyELV/ZLgrA+0?=
 =?us-ascii?Q?8ufGYNrCrfvJcakldFEgO+X3vlohtkKbtFsze1rwUuup5CPXj8JOlU6XdTBE?=
 =?us-ascii?Q?BXn3s/mRuX8ydhk+cVNnWbf8TFKnW0Mvh6U7qmGM066eTCGmp73abioDTM/R?=
 =?us-ascii?Q?z1tIQjNeuo5qCaRlldewUPcoaK1daM5xY9aDtsq6cYWqxkp5M7yvord8isRN?=
 =?us-ascii?Q?24pUEhKIvx74syiBJCGKkjHyoUTVGiY3WGnpiqRnIRQVstJ2buDrjKhSB0Ix?=
 =?us-ascii?Q?fAmMOM9J7uU3UORbpfFbmK6BDZwmRgPIyii1c2JayLZKX5eRJv+MLCoqbM2m?=
 =?us-ascii?Q?tARKDUbxA8z7g21xTCJBI58NIJrI7DYFV3oXhuDhVgQLD8LY88vZbHid+BNc?=
 =?us-ascii?Q?yxA4rFJL/GrAzpbA8mrtSsOPXb25bsh8bGVmHgP9HxBTic4V699yY9ZiaBJd?=
 =?us-ascii?Q?D3RBLTKdAIu26R4p4mg9QeyNFrHA3XUxDPOHw2Pbq/6WUkyGOYcU5LvNMnMR?=
 =?us-ascii?Q?vcHPSPKKlxB0QH4opynrGh0X0656GiOyrNTgPdR8ooQ9tKLZecqYhws/vkwj?=
 =?us-ascii?Q?bEOPiswIapGiZrt06n+BdF++aGjop3auDSRB+NbiD+NZcUE/z081S2bNyE4v?=
 =?us-ascii?Q?vB3nyS+4Y/2eTVM/5zCibrG9rFF8GzxowIvSWF/RNgnNTCfcUJNQW/2pMTzH?=
 =?us-ascii?Q?//AeUpH9KledcvnN5XBYEfBhEKfcI6iXDHLAM499RUVLjSMYtyg41X4vPlXt?=
 =?us-ascii?Q?5H8V58KmIr1RwVAhwTXZtqvFbLxCiy3UEMagWZxxD8LNYVRYX/RzNUq+6D/t?=
 =?us-ascii?Q?T5X4hnu5xEy15L1RzJ+TcuVnHQun6IE3MhU9TukXeyrc7wfaXmxM+Qmy4lK5?=
 =?us-ascii?Q?TVMlugjB5G5FBw2XDELCjtaMr/aabMkHk55JoLzdQz8BV92Fda1y8bMtjsR+?=
 =?us-ascii?Q?RdjjOQD8CbtoQiiz8caIN1RRJq38BD/iMucEhf1hxKwLBj0lWZDtmRI+4yYp?=
 =?us-ascii?Q?vCLblzhSqXB4AdLaa694+IiImQI4MHw5Ki0sDcHUhHyt+tGF/fqjIPjEd8iV?=
 =?us-ascii?Q?Mt5YUqnxHcvy8F/C60J1w/vSH1i9TndXhnqS7oGPfaaHOlxSeRdKLVGDYCTZ?=
 =?us-ascii?Q?4ka+CHO72X0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB7900.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/3cWgBwoO6mlq6/NgOixI2ASZwdpGPSxzTfzqVDqWf0uYlXmsEYRJ1GJz2WU?=
 =?us-ascii?Q?cC4bd01S9afg//Dyn0xSE01P+sY2t1ICQgtJR24HSRZusUsFXO+X26oeH2V6?=
 =?us-ascii?Q?l9dxg7AUyHtyBK8DJwo3aqgIcOax7gTwKWX+14UNjPp4rTCmCSWou1to5rS/?=
 =?us-ascii?Q?Jh0PbqlOSCUcLO4IhsN9EHsdnXYCafWKIjScYjBp9HSxR5XV/M5v6ETtkF6I?=
 =?us-ascii?Q?iXatYbffDa/Saou4hbbKUXfhCpsFB6FxXwdiOekVjXEK/xd9K68IguuXAcmA?=
 =?us-ascii?Q?0dghtqe590TFm6kDQfYsEPLT12hpPwqRMoD78G5orxAfqN4vc60kK6mgIvaA?=
 =?us-ascii?Q?cantrdcY0CvYk8/IvHZvBucXSNiHzU+LvB9u6HVmM2L6uJnIEdCvQdf7c0og?=
 =?us-ascii?Q?1H1nwjpIR3WAh+8EfNvBFv3V8lrJlrIis/9jHAwl4n0R9YBua+EzbAKw5azL?=
 =?us-ascii?Q?fRRyWfWhJKwvM0vTu4wJoS/2QYQi/AktEK/icxtNc29KW2sV7UGDrnsSScd+?=
 =?us-ascii?Q?YdpAs6bJAYjNEQv/whNU0hkiIDoDGEVlbn4qTFUms+d/gnrAauqlf3oIPhBY?=
 =?us-ascii?Q?CdgxWGplG/2OkHDsQO1owslt+KKDxEAO8XYJSRkPaG8jqhK33e6RMjfLIuFO?=
 =?us-ascii?Q?M8ZGFkaHWnrX3B/yz7aZH3Lt2IyM+Fr3KweYAzGZSWASqjhV3jQpzw9eJsJU?=
 =?us-ascii?Q?VTvH05L1ywS9Nl4w/TbRW4mLQy1eDaWefPxjRD1/tXhGHuTYlXZcP1Zhga14?=
 =?us-ascii?Q?ECUQX3Ul9BH+ZvmdEqKCCoXiJ/P+OqjCKNtNDletKAYDo4hLy03JcLekt5QK?=
 =?us-ascii?Q?s99cjqJg7e+SMUmRC85mzPp6H1GfVdVhPOUdOpbex34+RlP7GZdEwfCUPNS/?=
 =?us-ascii?Q?WCEsuY+cp10g+saawoQRhJaLiwFqPj/qdcu/H8MYpuu1+aFf6zpZ8Xav4x5e?=
 =?us-ascii?Q?jWcNTIUA5s414oeYerxOUTETtDircEh+9p7wA3iQ9dtM83cwlFR54E5WQ1DN?=
 =?us-ascii?Q?iPx4AJQf9aoQQDaunE0aoUUjnlfCcEZyCpAHEoFX4uQKMRMRNzLwAQJIt/cd?=
 =?us-ascii?Q?HcBhuAIyPltARddTxEVhZsM45gnqQPyBEIhIsYlEljZFHkFG8rj3imCPBpht?=
 =?us-ascii?Q?auE0vPwiYQlKYNLANla+HCKweR1UycTRBCotk8IvJ8RE9WaETVd6I1xPF7iJ?=
 =?us-ascii?Q?qPyeW8Mxnu2a2pFVvxN7BN0LNR3uxKBrlMVzGmpX4l6PQYgLOVLzQLFOD88P?=
 =?us-ascii?Q?o9jA0EfOMw+g5c6KYoDcV1Ns6mqZDp68Vf0+w6W1iB1CfiBXmZamc+Uw7ysG?=
 =?us-ascii?Q?RwsjmrmbfSsrW/bpb1wC3DUiPy4qt09JbAiJIHMWeiV7RlIl2th99YP6246E?=
 =?us-ascii?Q?VEpC7X/TpR9Xp7mZ6bTceyG+QozHmvGbnMi3XdFWQMs/ed6VXNm+/m6qtjC+?=
 =?us-ascii?Q?jTMaXZeHy9Xsma71zIgY+eLkjEDMCdQSeeKVuAW1eenL+461Smryy5miy5Vf?=
 =?us-ascii?Q?lJGd82qmcmO7EAzBrFDt9w+8kjP6Aw+Pov+LjPzGjosiQ+bmVQN6lTsceTN0?=
 =?us-ascii?Q?PVX5xhB53MfMMUsASPcwKSr1wfwzIRK63pJWBPlE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef9b59b-1a13-417d-a128-08dd83fdeb0b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7900.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 13:34:35.3170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wGWLVGUhyW1cpjY+0FHYmygdHm0pPM0jZmRZLbP768SdA0A0pDwAG43mQ7KIoJ0p8BAY6wd7cOz89Fd07bsFpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8

On Fri, Apr 25, 2025 at 01:37:34AM +0300, Vladimir Oltean wrote:
> Recent discussions around commit ad1afb003939 ("vlan_dev: VLAN 0 should
> be treated as "no vlan tag" (802.1p packet)") have sparked the question
> what happens with the DSA (and possibly other switchdev) data path when
> the bridge says that ports should have no PVID VLAN, but the 8021q
> module, as the result of a NETDEV_UP event, decides it should add VID 0
> to the RX filter of those bridge ports. Do those bridge ports receive
> packets tagged with VID 0 or not, now? We don't know, there is no test.
> 
> In the veth realm, this passes trivially, because veth is not VLAN
> filtering and this, the 8021q module lacks the instinct to add VID 0 in
> the first place.
> 
> In the realm of VLAN filtering NICs with no switchdev offload, this
> should also pass, because the VLAN groups of the software bridge are
> consulted, where it can clearly be seen that a PVID is missing, even
> though the packet was initially accepted by the NIC.
> 
> The test only poses a challenge for switchdev drivers, which usually
> have to program to hardware both VLANs from RX filtering, as well as
> from switchdev. Especially when a switchdev port joins a VLAN-aware
> bridge, it is unavoidable that it gains the NETIF_F_HW_VLAN_CTAG_FILTER
> feature, i.e. any 8021q uppers that the bridge port may have must also
> be committed to the RX filtering table of the interface. When a
> VLAN-tagged packet is physically received by the port, it is initially
> indistinguishable whether it will reach the bridge data path or the
> 8021q upper data path.
> 
> That is rather the final step of the new tests that we introduce.
> We need to build context up to that stage, which means the following:
> 
> - we need to test that 802.1p (VID 0) tagged traffic is received in the
>   first place (on bridge ports with a valid PVID). This is the "8021p"
>   test.
> 
> - we need to test that the usual paths of reaching a configuration with
>   no PVID on a bridge port are all covered and they all reach the same
>   state.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

