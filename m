Return-Path: <linux-kselftest+bounces-36783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9044AFDC57
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 02:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB4D93A66CB
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 00:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240D11A285;
	Wed,  9 Jul 2025 00:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSfkMq65"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA30111A8;
	Wed,  9 Jul 2025 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752020990; cv=fail; b=DYeGXmA1EUl7Quoj+y2+ls/3MlMO49qlUpuqluqEAorxYU+0u8R3toFWwVXVmoyrQcTKO2Mxd5lKk0oKy8qSzyrAK0RjU9DJB0rYMs9BAOFbvFp9c/mkKLNEW4C6xw7Hv4kIecwOis1jWAdQJEjxJnyfZbGW6tYFvRQWK9R7Xbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752020990; c=relaxed/simple;
	bh=CoDowlpYqiN1R+bWy3Ax+1zA+9yVkspOg/o/0H4l1v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Trqlu3+t1GOsSnRFwhDIE4824FcB3qOVEJPcV9LT4jR/J4UyuK/vzqpmP7nQQwvryVk79DLu7SRqaagArSfTHF3lbp+Ebi6KtErzbqVTIUsIPd2TLmZohfPO7/nTMkFPlmPT5JamB3H0URN/C42G9WiEscyvyCyS0mo8xw0h5ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSfkMq65; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6PmJ3NFO1tFh3fHGA+r5qFqIVG/O4m1moGWX/1kP3VRQLrofrlKzLpCxuPP6FSGJXr0QBm2LXcahPbo1TVWmpCgRiW33OYu0Y+kU9cHHZT/tC4nteo2falO3puuEUfy4+Y4YDLJLg4FMv9eV+sB1KlOg6sLhLEQ8Pa9BxSLwKBj5xV6JzQZNP74vL+6pS6IZA18sakBct12XhHHzv0IiVlEmo4IpPcZq/soNJgVacl7ZLN7chy3t6ekgvgrkM6hDNrE74UWlAoZX7BO6BBEtmVAm7pA/aiVXvIpj8KVrnXpgwh1QrIA0DaayjYli8Md9cFeGcSAf/vZ1HoVD0t35w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WaKx6tzgMR/CnKn8gB15/oHwhXYKmVOtzbUbwyvnrgw=;
 b=jg2ysyzRgpq/aXr0GZzzl1DJduF/JcW3TsqVE+Vv0EEXt4TbonEVyNuIgzIC6shMbnAAC9+sU+pfe+v6TH27WwOZ/q2XhouEpQ298Zhh2iShZF6htGc83BsoPO3AM3hblemeLACFCZ/9gK+itu/Vykxc57yKVBsTfUEpcemiWcrW/G/CIStvW9VRTu2nUF3h4ZeHQ52/QubIi0QtHEShk8Vou/CNKDBICe5mFsl9GZEhC1Jpo6xWLYq2MuWumpqu/eIPSrAcczpHN6Lfzj/bE+LebU6KAwpo6WSOQm0zAz2/ddOFisRrj1SZXdlFv2ZOVlcmtPN1ILmqKXUzYkUKvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WaKx6tzgMR/CnKn8gB15/oHwhXYKmVOtzbUbwyvnrgw=;
 b=DSfkMq65R2Le4cL7/jKL4s0sSgcN7lItWuHUYao/3GqgJppgZD5Ae21mMP24LrKhOURzMUUGj47nNVXSxTS6+BFK4CQEjb/iQnWAjEpjAS0XIBKc5Iv8SmOztMDxznWCdDr7oY3bU2+miE5UjesXwHYwJ6blHLDW8nzKrlwxPJ31HI0cURAuelfaAgJcPEg1OgaLKgoWpPmZIy6hWIz3S5BWUHiFJoKTSPSsnA6FAFa+eDQiUERu/7NOI/KaUHCTVGRmq1PvOnpBT0sBQo3txf2RENskxlpQncChRy7SIJJ9M/Zvk79t8qFqw0Jajl6/crwpy41RRPwbNiZ6vct4Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6530.namprd12.prod.outlook.com (2603:10b6:208:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.24; Wed, 9 Jul
 2025 00:29:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 00:29:45 +0000
Date: Tue, 8 Jul 2025 21:29:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Justin Stitt <justinstitt@google.com>,
	Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
	Bill Wendling <morbo@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Will Deacon <will@kernel.org>, Alexey Kardashevskiy <aik@amd.com>,
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
	James Gowans <jgowans@amazon.com>,
	Michael Roth <michael.roth@amd.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev
Subject: Re: [PATCH v3 03/15] iommupt: Add the basic structure of the iommu
 implementation
Message-ID: <20250709002943.GC1599700@nvidia.com>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <3-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <i7qlz7ojhs2ja5qnj6gnf6wgsyhcqznprfudlk3tphw6qyhguk@ak4wo7b6rujt>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i7qlz7ojhs2ja5qnj6gnf6wgsyhcqznprfudlk3tphw6qyhguk@ak4wo7b6rujt>
X-ClientProxiedBy: BY3PR10CA0022.namprd10.prod.outlook.com
 (2603:10b6:a03:255::27) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6530:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c01ffe1-c688-4b83-98ff-08ddbe7fb496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRQbXI7+OgBKSP5qXou4Sd1Ze95WJiayRwCUja1+KQ5ecaOzkkKRzypuTtbv?=
 =?us-ascii?Q?dMC+GfSGQAMU6lXbp+Px9bA9aoDbfOh1ywJ5EQllvDRoV7CVkz2cwnPn9C23?=
 =?us-ascii?Q?9IyHfx+/ovhWa7BmSG2zXaEb+6y5WpnUIcz7TXU2+w1I9MywDekhEEiEaaGV?=
 =?us-ascii?Q?hEiuPuuxTy+MjF5e/I9j3VEKdSrRt0TlahXfFWiRLiYr9SlXDlU9x3LCDePw?=
 =?us-ascii?Q?SwBlw+symXx/ImWskUEkFbcj6/eSn/XcF93BiT94YDHaBkxlqxvj2TqJuOzV?=
 =?us-ascii?Q?vdS/vfoGzkqBAnRElhhNp+VPyhlj4tjksokuQtn0yqZiWh0sZEAwPL5AECvk?=
 =?us-ascii?Q?MhqGbeHRp/XITOpbSjrz7vBzEayFkqQ2vIOCPRCpc4uA3uAeWcB7HDXtBHkX?=
 =?us-ascii?Q?wufnPkqeJ6+NBg28YvkYKPTJigWf1h8L/zYYj1Sf2qHfo5STPbm1RnEwgYNj?=
 =?us-ascii?Q?KvtQ8ZY5JcA1NBiS/gvQsozemp46XBr/6KmZcqLXF4z2n30zS6eYqkSPlu0s?=
 =?us-ascii?Q?W/80IBozn3s/JWUn/uK1GlklS+7KlUI2mhT17ZLrvDH7F1DO574rb3ibRphO?=
 =?us-ascii?Q?3Uk1wE1ccrimN0CE7WBHPn09ilQdfZtA2xkwYHW1kW/GdymytRTPjWxPoMA7?=
 =?us-ascii?Q?A/Zn9UNZyr8B1luEbFCD1OvKVBQBaBOVHccQRcxnnLFvos543Cd6p2eIqwhR?=
 =?us-ascii?Q?CcSmwkIE1+hqQrfc3c5wQ1ch2IHym8G8ZU1VhaR7NZoI9tFbUx0vbAqeLsOT?=
 =?us-ascii?Q?uF31LL3pmlrBN07bHA2F1LGQd7DRTc/KTW2NRwWHtkBU+vaEtuC6AoiUmbly?=
 =?us-ascii?Q?Axadqgq6/5KNXSkGQR1VqYPqgIISjr8rtPsHuAAohQ98F8BpOZjGqdlZTEU2?=
 =?us-ascii?Q?Gz262H/zKgoK5H8V+IUCr941U0IWJkZw5LPwZgE2BV6Iq+cBeO3A+ATQG7Ku?=
 =?us-ascii?Q?CVol/cVaVxHpaZKvETwiZaUOmqcd2Vn4wFvfrlGWQic7K1v2WuoqQduX0rGp?=
 =?us-ascii?Q?GoANWIWYHnCN5G/3zsKXKciMSK7puZ1xmZepcVjO9jSv0iB+WHrNG3AoZEoC?=
 =?us-ascii?Q?gGDUvhxaKdzqkx45Zx0g5vDYKZPqv/ZFwmc+s3gZie/SIqPC7w/gNnGzKtwQ?=
 =?us-ascii?Q?zFcLyHNcFrOs3lLxj7V6EKRXDtWm/omT3RF4Y9C+U/DZAPyCmgRmdhg6g5pw?=
 =?us-ascii?Q?0QGsOht5AuLSHRORBSxGSoKzbfGpCxbCf2R9H/WaEP7ZMk9/rmsBVSXxEYB6?=
 =?us-ascii?Q?sy9kW6wyfxyhylzDSMrjMOe9BKGNorq1VPMgWVVamb1OQoAC3dVk739s7TiW?=
 =?us-ascii?Q?Y6KfcbEJIbZHu/gfRvXB38fo7lOiU8fAC3yfbQUR4ywAWm13lYzodF/Gr9Lr?=
 =?us-ascii?Q?7V6CO2zfBhdPZTYs5IUQ5pecqy+PzPTwXwoXAKur8V5scGHwwwd/h959VKcC?=
 =?us-ascii?Q?1AMVFNf3uso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RSKZrB0TvZhf6/b97p8e7mqZD2Y7m9Sx1Zba2n63GKkIJPUxCjvinatkuSLl?=
 =?us-ascii?Q?Xg5WXinSu3AhgQM23feMMKWdFF0WRKys0DqvvTqYbIYf8rxEgxg9DjoGoCp8?=
 =?us-ascii?Q?3cd+lEyjYckWi2IV+xBnzwNydSPq96IAaNM9plnF6McOwH0RRB/FGHc1QihV?=
 =?us-ascii?Q?Q2lSJzgpo6KmeaGxceJ5C0oL2O1f3PqEwZoFNjarp+tq6UJDiyuQkp2AuYYM?=
 =?us-ascii?Q?hUfKbK4HbPymlPP3GpdgQmUwe8OaLJhIg8oREDZo/22yYKIDvCjqUugHzWvl?=
 =?us-ascii?Q?pKKMSAAfj9yq+sij3fkARnv1ESF8XihhDAkA4LIHBl0N0tTwb8mAMeCzdBb6?=
 =?us-ascii?Q?v6zX8BQ5w/nkHgmAqdmGESCwFI/FdRv/Fqf1m/EZSqFWigdGcaAMWohuFdDB?=
 =?us-ascii?Q?vudY6vsxExsT0ZeP3mwgCLB20LB5C9dVU4jwY76BRS5D6JVFHmA9ZeRbCEIF?=
 =?us-ascii?Q?F2HmA6xeWfPnbjO6K18kcaxTdBSQMfjO9lkbnTzVYP72AEgD3MVy1LovVupB?=
 =?us-ascii?Q?cIBoW7jn9cTVJuIqfxHHzlWT42rvkFY2sBOdu8xwH+4Wi5H7/3E3j8BcEALp?=
 =?us-ascii?Q?wMCuiyWlT2fxhEj+D4b00ZON/tw/PliQ9sDiWqT8Evbq/oP/2elft8wUoKmT?=
 =?us-ascii?Q?Bu1byH1K/g8Jr5ucqdtlKHHFtchZFxSipxY3mVeYyR3XdQ1SrQ2wXLDhfUN8?=
 =?us-ascii?Q?4Ocvr2Uzc18Vs+/bqLp7GCJ9dl3JqYZGzHKqwR199d3c+RQUQ4RoslKVWwtO?=
 =?us-ascii?Q?Bh88/ypqk7D2tDr5MyeObyC0MhZdz3vFBzZO+kBrssH39ijiNOoucu3zVJTV?=
 =?us-ascii?Q?VVRWaeDbtxNC0PrwrSV6MyjBdxnJsDpuURpUVYhYiMtLpG+XKqHVak2b/dPt?=
 =?us-ascii?Q?f/AeCE3jyxG7dyZy3W/7H1CdLukN5dgwJ/EVyIEf2GNvOBGRpcfeWvV+RFT3?=
 =?us-ascii?Q?VfiCWAaMQuTal3hKNR1kaTDSsQk2D77nqUFkOBZc2lLVQnMilalvf90TTpaW?=
 =?us-ascii?Q?yYJ/bn4MEq8b+dxNivpHAd7Q2lJe30ZpTEIOqpGRyhfmcE7IHVIfLkMuZkMU?=
 =?us-ascii?Q?S0ok4X7vj1Hx7aKVaEKn335r2lyKBxOm43bsmrAXoR/SOMgPw/LJT4PXmo9f?=
 =?us-ascii?Q?x/w7Tc5Gj2yK29JsI5IjY3Js91mzll4U9tl89Z9fRrcKAEmRhuAMGU9sEAvb?=
 =?us-ascii?Q?3ESef1BP6IlxIh24uJMwKfs8fDihwUBf8l6rY4iAmKNrg9/GrhmscDjDezH7?=
 =?us-ascii?Q?DbwcV8MhTJVjgiYgpPC8ie5TzsDBkBbDKt/4g5ohv9l9gYmVkZL1zooUkIse?=
 =?us-ascii?Q?I8Y2EU87pfjoz89EwWlj3V105AE1sCJbizHCGzBzpeW9kAdZu9fiZ0AP/WgV?=
 =?us-ascii?Q?xWR8LGVVCmOXfQ0qNW/+XA+O/v9W8p6wZtFNkEVNwLYkFVTkIRRSCOJstrqf?=
 =?us-ascii?Q?U7gJPZEQ1DFKjQXZucpVa7hyNKMKMK8MA0eej5V2AP580ohKxqAADPnJOwke?=
 =?us-ascii?Q?tw/ulobj8AeIuGTLQ8BE9wtzi6BU09toaNqni/gPynxEkNjWItPff64dfEb4?=
 =?us-ascii?Q?eVJnVumm/MJNN7Nd3/la30NrGFplomrldcp2vI2U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c01ffe1-c688-4b83-98ff-08ddbe7fb496
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 00:29:45.7965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l0vbxgHiiMnrv1r4fccgJ+PvmzxHd9z7WNf9hDipzq2NblG8VoxhfrpwRLW7O+Rm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6530

On Tue, Jul 08, 2025 at 06:36:35AM +0000, Ankit Soni wrote:
> > Tested-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Tested patch series with multiple command line configurations for amd
> iommu on zen5 machine with 12 NVMe devices.
> 
> Suggested-by: Ankit Soni <Ankit.Soni@amd.com>
> Tested-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks! That's great, just the aperture bug, means the kunits are
doing their job :)

Jason

