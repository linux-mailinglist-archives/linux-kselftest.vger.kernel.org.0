Return-Path: <linux-kselftest+bounces-15035-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CC894BFAA
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 16:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28EDA1F281FC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Aug 2024 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE8518E038;
	Thu,  8 Aug 2024 14:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UoAMabvl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BDF18DF6E;
	Thu,  8 Aug 2024 14:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723127175; cv=fail; b=IWE+osITAb10F0dJciKe15peYrYjx393uFwwHx18O7PLVuaJoKF4g138jDwtJJJ1mqpR43QX2qjhR+FZ+o5Fa9zGQIQSg1fP27HYixvN3kIUAq71JRNUIQmtjkHWXII6x5/veXGxdIPGDjGF4c4Kva+lI4zMGgbekyBJne+809U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723127175; c=relaxed/simple;
	bh=s/MJRzl//4DMlwaTVzyBchOpKijhNJJgGJqL/i2v1Os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M8PBbuubvMqI/4fIbaFvexxvGpmX5ncFTB4UdbTRIcbU0nVHzqDMz41rKi9nJlcfMt5jTAqstiQrtTN+R8SLrp+CsWI8qjfDLVsk9QL0XSR/NQSSTyjcvjD5DKxEYa6p/JfqleHR1Uo+mo16SnIxNr2n7IGW0iOn8UJKpTRCToI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UoAMabvl; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v6lZJ22c6vqHAH+YsxIm0SmxFuyrcwSP2u5BzGngOxQjW49WwNi8imMDS2tyDj8pgy5KSfvyTtPQ6uKxZG05pk1iDHRo1TX3i1lubOauMzGS0X9SASmhuJF1H68xEb8XdM4swMaBGZMog3O9lLbTA4aJJiTgprTYOvS+ekktuaZtm/7HwL2/swVrw/Js4gzUeNksSKIw7QGeUmwfV5XxCYgviLKR+BBb428qrkaUeCxP0DCzH4BejKQIAQXel3uWuP1V9Wf6laRPVw0PtbDeA+rrYlUMaHzs/sPACZcLPP7kwaE0TQlMWJGKihoB96I52fKFAez3dyLTDVqoR7JeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/MJRzl//4DMlwaTVzyBchOpKijhNJJgGJqL/i2v1Os=;
 b=s5v64n6YqH9rjgFw1X920kR6ClRZLFryM4duixaU69wjv0wfhDFtSIqplhvvKaClZd4Ky0gCt+60lOTT4MMAxvyF23G8Om/vP7B9kxOkhd+4FmEDQUu3BoKz5UkCVuPIIQ7TUPamnuDNjIBm2av/hIbNOTS7AVobu0RDMLtiFDGE02E+eSQmDGubYqPhe0yWNp8k1hY3z9Px7t3CpvgcsgvL3gBc115ax5RSTpb/FUCw+OOhsokG9gPW7IO6I84hTEG7MEOiQ/IJ8WHUBjPsiZAfz5FhYlA6cpRaSrETbw/O9dvVkNMUD7fYHi41xLvPLSFQoRew8HA011DRZT+idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/MJRzl//4DMlwaTVzyBchOpKijhNJJgGJqL/i2v1Os=;
 b=UoAMabvlIpXrD0vQ4kEkGtDh9LHVMn49tohh02I3VM3+GM2zzXa/DF7nRMmkCmCweqtYdWb3l3lnYigsA/gX+qzxu4OCrUxYCIeoQeY2qgPKSAfjhbXDR1NteeBzxW9skH1495g5xap+prn8J3l2Qnl1JEmS8vG/yZKNuwz/DaRBhbGFjsrdVsHSBYmVGJ3ygg5/ktE71C8FA+3Iuw4+lnU8ww2q6q4RQg/ZixP3kN6nL1TBJnLS5JL4pcUtlqjQPlL1aiMmyb93kFRqzvMpfxqy9QcFHnq+csZ85LsN6HeftHU92gqzyRoW1BxtwFzc+OhIiUfv1OozvANpEDaNxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22)
 by DS0PR12MB7512.namprd12.prod.outlook.com (2603:10b6:8:13a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Thu, 8 Aug
 2024 14:26:09 +0000
Received: from CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f]) by CY5PR12MB6179.namprd12.prod.outlook.com
 ([fe80::9ec8:2099:689a:b41f%5]) with mapi id 15.20.7849.013; Thu, 8 Aug 2024
 14:26:09 +0000
Date: Thu, 8 Aug 2024 17:25:57 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Geliang Tang <geliang@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Geliang Tang <tanggeliang@kylinos.cn>, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: lib.sh: ignore "Address
 not found"
Message-ID: <ZrTVdWrf2irWK7Fr@shredder.mtl.com>
References: <764585b6852537a93c6fba3260e311b79280267a.1722917654.git.tanggeliang@kylinos.cn>
 <ZrHTafNilRs6dx6E@shredder.mtl.com>
 <a22d9e0eb835e40000bc1955b57ae115ae44353c.camel@kernel.org>
 <ZrMbbIrNpCISI63I@shredder.lan>
 <95b6f3afa55f607c4328b686144a9005f954dc80.camel@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b6f3afa55f607c4328b686144a9005f954dc80.camel@kernel.org>
X-ClientProxiedBy: TL2P290CA0015.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::18) To CY5PR12MB6179.namprd12.prod.outlook.com
 (2603:10b6:930:24::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6179:EE_|DS0PR12MB7512:EE_
X-MS-Office365-Filtering-Correlation-Id: 5026f4ca-1c2d-462d-f96a-08dcb7b60c2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2BeqkXpbDoQrd750RfQcQIVDHYj+qRr9ovj6CKEHSlapeflRbrRa4OnUSe57?=
 =?us-ascii?Q?fiiWMUU9Q5WJUhapmobnfUVZTZEvZBg9dsb4YHaa+i8dVWD7s7F2QH/JEqvc?=
 =?us-ascii?Q?78Ietp3pp0RKlcM+kHZKiKLgg9PS+F1bQcSWD719giRXFZ2RnpdO943u3kr3?=
 =?us-ascii?Q?81+BDeGiG43GhSmHcc0CwJB3Fb95ddkWp97aPFLbiNUAu+mCGnDLnEiO3hh4?=
 =?us-ascii?Q?iIhZEBY1YvgW5T7GXwgCeNIFJUubtDN/XK2APN4wmhCrM3uIclkd0lZ6AGuO?=
 =?us-ascii?Q?yqoifWyDGLQ3B65yPy/a41pYMZRFZhjLJlcKyVdA3SbF4fjrERFgXopy+5t4?=
 =?us-ascii?Q?rRgens+FRms+zq/XTPTCZ0ytcZn3yrXnrSxpAYAT52hU77xyoSFreBWPQ6KE?=
 =?us-ascii?Q?/Mm4xb/kMzgltMQst2zDN9kc4vRzCD7UdczljIRJR+f2CvqpJpEaoSjjAgE/?=
 =?us-ascii?Q?jFxnMxIkOLyR2NGnIUkCAJkJkNCyu2+ueBSvpruIqKt2q3o1iCF+Vi4J37uK?=
 =?us-ascii?Q?jECFCbYHh422ywruJ8cHIVFNb9Ym1kXygVi5fy3cJMZ1Npckwvm50wEVZHkg?=
 =?us-ascii?Q?634Wg22WYkvfnKtitTwc7BaQ7wK/1uS6hjWrF96kjDvNGqqDqOZ2uX5GbT5v?=
 =?us-ascii?Q?gTQUWdgUqIhFMtusk4CO79mWLnyu7DJ65lBPMGvFpjnUjJkPBreXwOKrPply?=
 =?us-ascii?Q?Nki7GEjYbGAaDZQIOMj8rS6+CWSDBjSvEX9ZU3226c+ZuJKPHG/cz52fzqyB?=
 =?us-ascii?Q?uCgO85tAoAcC/+j9Ki8R/G4EVTWGbkuCgTErlEIl4NfQQpCo6BeB1N8e9pQ3?=
 =?us-ascii?Q?XqrC7paIHlWdCyCTCBOn0Szb4Mei2MyAFHC12ZNpAmEQ00HSB39ZGVUeFd+6?=
 =?us-ascii?Q?5xW5ZYIOI1YrzM+sseufxvHQQ17HuiRaE15tnBzSgNOQNuX2Lkehp8hscRb7?=
 =?us-ascii?Q?GVPeM2wzEi8204/VEZIZpDNFBopoZR0pfh7bbKqTLn8pSmw+yphI2nV1quzr?=
 =?us-ascii?Q?7SvgonTXmZp1kQcQDFHUYq/g7mWGu+Nqxuy10r6RPwZ2d9MY7XUTpZE2Bgdr?=
 =?us-ascii?Q?COA7PV8gsSQP4RrpHQinHSui48RXY4PBSGUnFk387DtW+ULHuPKyKwuJaViG?=
 =?us-ascii?Q?btI2Rgiof+ogLt6zPeGpXaEncIch0RPK4oZBmXaEOk4nDgJWxfo3sySyqNRt?=
 =?us-ascii?Q?DDGv5YeqJxcH/Xn1prRvkdjOydvVGA/NOEf2A2h8LSk+11nIrJa6Gy611MnH?=
 =?us-ascii?Q?Yjk63SHMrEJ5jpj7qCpOHDhpPCW3DgtMOw+9H3CEaoJSmgZfEcxKfKKer48n?=
 =?us-ascii?Q?cbMUFSSGKnFsENEq6TvBGhGU7BpO/x9tAwXMP4uEtTK5JQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsauK/NwYa4sWdOVkT7XIuMhcYjGiScH6osijsA4RBJyA4KTM3TVCXKpaSVs?=
 =?us-ascii?Q?F7ZrRwHhsRCE8sdMR6FUzcwJkb6yR4IUotqbtoN3zR+Dhf1d0kJkt0H87Ap8?=
 =?us-ascii?Q?szLTFgWyEfp8Of20ufhj83+RhywCqDGLO0vDIjr41Let8ceKP0L74jEdWRUD?=
 =?us-ascii?Q?Xi+IEaWyYZD16fE0kpUvx1r3coN0uaW+LrYdAAi9GssvbhWfqxbvq1LA/vhQ?=
 =?us-ascii?Q?tp9zQ3HMtBLud3P551catUhyYRUUSvMghpJk+LQ/GzcdShPRCvvlkJ2ZRRmL?=
 =?us-ascii?Q?MCmZQQ5t7PGZgRIrtisSUKTJ/elbBNFT0WYoCXlBDNQ1x2hJGHlQ4XDZ/HmO?=
 =?us-ascii?Q?SIAHksCZScJW8PVcCLIhZF4uxcgcsOMQp3ZAMjTbZX70sXmClGpxuIRyWta/?=
 =?us-ascii?Q?z4qWjL8RMhsj6ZXtqWfCNuMyePvjzPJIBYusLDVFw+nZoMKyeuFMGaPODHZh?=
 =?us-ascii?Q?92tySVLtSxu/mse7/9JgH/tGf9N4wVHLlbbys5VJ51D20GtQXEeX5DQ9z8Wh?=
 =?us-ascii?Q?QpDQseK5HwG3MlXbC5MF6fuLpt1ZX6JZB2GLMdVzDfBNLFUFsociRDLCiw9S?=
 =?us-ascii?Q?xRVB46lMbXjYnX4C8VPkXy3OSgiEY7ETie8+vgRwgrbBd+QRtoiV9wKK4MSy?=
 =?us-ascii?Q?gyokmR+21eKxgopMjx7XJvjx7u7eoUKLmxVGTmt9teC+seX9NHL4tvHVULFS?=
 =?us-ascii?Q?EdCrYRWHvNCGaPQRntI6F2jXCUy55+sWHvSut8gfdc59isywM+3Dsjdm5/eq?=
 =?us-ascii?Q?fEbAvvsuwugj50GkEf7xrevtSNLUX4DC35JhqbSiX+mD66EJM5vHQdd140UX?=
 =?us-ascii?Q?g34M11o51XZKnmzYKf3fPib9orQwq6fRHdonC+4Qfc4A15jkiGOaZU50s0J2?=
 =?us-ascii?Q?0lraobN5bgRT6PSuy5Od1cmTS2XMGM4w8TiNKZugmyytnS8vvlD7bymzUjWk?=
 =?us-ascii?Q?ksEyytkzVWXT/OyTNMtyBRBAU7v79LSnfXyHsGcHMJ8dbjcmi1fwXTVwziaI?=
 =?us-ascii?Q?1GW2cOpRgQ2wU5CvSpOfRoDGnSagI0aaRSAT88WMESqjZJ/uxgSath3MAdkE?=
 =?us-ascii?Q?xUzso+6k7Uo5vwRIQHQcpGhNusiotzLgowo6TBnuQ7uOJHPD6Fm5GjxrcwQi?=
 =?us-ascii?Q?NN0pumEpITbxCPYeQpZeZXt/+JGCm3jU+z47RfBU3NHdlP51oujtTrsYPHCi?=
 =?us-ascii?Q?zrcBADc/EFmHYh8NQw1TM9N6hNAKBmOfox+eg4H2l0Cc4Gfpen97LTDSqwqO?=
 =?us-ascii?Q?AWuFN1u2b6igu1DleYgokNZkwgJ0E26Jllk1bE/NCR1WMLsSw+awV0dp0FGR?=
 =?us-ascii?Q?s6lbVkn4BMEvXI8IapsYJQEEhnH7hB61gEjzDN47OwkdHehk6sBsWIHhvII9?=
 =?us-ascii?Q?s2h205d9GHEPgvVx9YWRf2CtyjHLZCbpUXM5Pfny8Gi8S+N5nfrsiBEjtLds?=
 =?us-ascii?Q?86pukBnt8XLDlSOKM9TSTgCDqFpo7yet8tj09nL2A9pLRM1mtN5TzjyO1M/8?=
 =?us-ascii?Q?24C3MHHOW9bNCWJoUtTJU+enlS+DIFohSlIF9CdQFjpXAXqoZXsLLdJ7V+WS?=
 =?us-ascii?Q?TmpKXS0CPKCxqjVtwwyXsEmGoGxpPtkaOjLcgupH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5026f4ca-1c2d-462d-f96a-08dcb7b60c2c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:26:09.7586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gumr08Wp8yqGBm2A2q0WC923EkbSFBgfX6sfo8JJN0zqypypgjmrtLFc7mjI5dyoeBeLHuAYFxNg0N0rBG9ZpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7512

On Thu, Aug 08, 2024 at 04:53:51PM +0800, Geliang Tang wrote:
> Yes indeed, the addresses are deleted by NetworkManager. Does this mean
> that this test will be affected by the network environment in which it
> is running? Is it necessary to run this test in a new network
> namespace?

No. See tools/testing/selftests/net/forwarding/README for the motivation
for using VRFs instead of namespaces. Why NetworkManager is deleting
addresses it did not add from interfaces it did not create?

