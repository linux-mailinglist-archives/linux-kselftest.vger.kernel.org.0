Return-Path: <linux-kselftest+bounces-26876-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C5A3A382
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 18:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F9E3AE9B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F626F462;
	Tue, 18 Feb 2025 17:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qGq1CitW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AD226BDBD;
	Tue, 18 Feb 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898170; cv=fail; b=aMEOSZl951hU/g1demCscAK2HIce9fgJ7hyTi1O54rUEo2TjfsBuuU+LIsBI3nJl2xv+ACAtHjwc2qN8GCeXv4t1bnShBWYuP+X1Zs3FdFWomy+HE8MUq5igVvUE6gJM9542XDnufwdlaWJGJkYqskzEDsJv9qBI1xOzxk7+M84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898170; c=relaxed/simple;
	bh=EQOCMUYxsH9sI3vHHKdGONN/MDRI2Ex3BdaKLMdkmuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lOhK9Op9FVfx5ugMme9CfOgtwwov9L0dIFTIT6L/4ENeFjGMEB2q/BdwF5eeSpNTxGxuTvVaseDZI6GqbchqV4aloUjqMq4LvS2OfNgBU4O6xtCXcB2HxqMlzw5jwoEaHSbRm7Txu7mgXvvCVdOtmL6U84gKY2XoKqBJv4nB9E8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qGq1CitW; arc=fail smtp.client-ip=40.107.236.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxq90dyD/bu89pV3B5GASOXkQSR8bZBh7q48uFvopyQau08p5pxzyqW28dS3wsXtodd6eHf6ehZ0PliWIi2qQDKwZaK9nBZaLEc6NDe744LD7PrYqtb0Ewfyrcq/i4MR2Bs/1aeqFruAlK3QPkawRujeu40odtV2N8x/Zfmwbq7c46m4eiaNgECb2Qxpnp0RCAJnGFRjjdVix390e1SGoR8qEIWQzp3untpC/5XbWqlcmssqDW0mJlCe7ctvE4bT+H/rIERLgwugdXL1O5GuaMq4sd9IFLdvQapTO0mdf/wlPtybr+OSEY2vIC7pWqrJLHSOcSM53kJTcMPoFWuCfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40GWVhZbZOSSz6vlLWQhlGNjb30Ttyp1/Q9SFBLrscw=;
 b=cpY74EVbZ8n0dQ/Kg7WetyDtaPxk8ZHIN8SOz1Sy0UYqxPQWF7oL1QIDH6WPvKujgpzIJQzSW1cn6nDhYXEZgF59avEjOL9ZiCu4sVe5pDXY/kKG+tcRruDx3shgwa9NFZ2VX+MkZl374ig5ncrhJATCvuoIXHf+WTzjMHfuPoyVtTatlil12p/73p8gf2I12hkoMa5OeiyFiX1MExcpABHzar7+t2GZoPXF0EdaAB/CNMjO1pJBA2OsgjBzQrBPbdaRdj8UVz4mkd12+ZTUQuzG6tLYae+PcY6c/8SYOuL+UlvOHDZEmsLRBb5nS2I1zJj7TOk6SKMT09TdxrhjPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=40GWVhZbZOSSz6vlLWQhlGNjb30Ttyp1/Q9SFBLrscw=;
 b=qGq1CitWUDHz6/0Ii9v2XEydMJqDy4A0zh+ZSeiQscrK8TunUCua+lAPa/jkQ0L3PyeUjoSOb59LRg2gAOF0IVsff0x9Q2/kFOsimgiUaG+Kc1sOZoxTx3uH/vmt71+crEvgmJk0rBVIoQKdcssbj5NUfvvAy//xcQyeEaG0HmAaCRtT9iFJPJH3fLxwNElMZR5bkUG7CkM9nlbnDU7Vp8MbOzyHxL0/LMXgeqNU9ftBr2q178hJab3h3iXM5Lp3v6ocNtNdM0R20raESutRdWM+B+HoREcMquAds7K1bbda+4fQLwS0jornbTikG3mRvAYsGHawyKHux1DlvKVqKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW5PR12MB5682.namprd12.prod.outlook.com (2603:10b6:303:19f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 17:02:44 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8445.019; Tue, 18 Feb 2025
 17:02:42 +0000
Date: Tue, 18 Feb 2025 13:02:41 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, corbet@lwn.net, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v6 11/14] Documentation: userspace-api: iommufd: Update
 FAULT and VEVENTQ
Message-ID: <20250218170241.GE4099685@nvidia.com>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <300d03449b9420d756c1589e1c24bb8b4d508293.1737754129.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300d03449b9420d756c1589e1c24bb8b4d508293.1737754129.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL0PR02CA0072.namprd02.prod.outlook.com
 (2603:10b6:207:3d::49) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW5PR12MB5682:EE_
X-MS-Office365-Filtering-Correlation-Id: 81fa1cf1-8b05-4c54-f087-08dd503e0ec7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CBHJWmKVGjlhb+j7uaoua5iP8iHa4WlWidwhTGOmIpOQOEN75WCwKZevRmf8?=
 =?us-ascii?Q?q+abarcmIMm0Yckz+n31HG6nRlKp7Sc6mgLKbwGk3wvsRpdfmFYveDpbTnGr?=
 =?us-ascii?Q?hF4g6iZUi3XRi41bh51g5mDXXSImtkd7G8VMMK9560NazpPVIFG4lPdFpM6Z?=
 =?us-ascii?Q?ezUX/cYRS4aH4yBYSHBgz4W6+e3Z3fPiNM5kmtqfmvSQbEiyTE98T1M4hm6L?=
 =?us-ascii?Q?slZ+eyPv45r6FXUau3ef66WGOoLWqgn2J2FXck/X3uO28ZrqyXd2MrhQro0F?=
 =?us-ascii?Q?QfqsazRSHmEHOTCvHjlx9r9/J6J1qhT3bWIPfA0B41nstLjLP6AI3xeL4SFs?=
 =?us-ascii?Q?S9nbd+ORqHuBwt43jg9KvZiBR7mmX5neDbzt/guu9PN2KHayvhOZhqQ+i190?=
 =?us-ascii?Q?Kr1hzQSsRGWA/0MoxI3AblIVVrraa2ODXa14kIWj4+eY7rkOl6qojRTdyi46?=
 =?us-ascii?Q?U5lHxrUQvi2nqTAbg5uVHfpXD2lPi/2jI3GraA6qcu8jLSBN6NZ5oSUlj2Nv?=
 =?us-ascii?Q?KsdS1hLJ73MDGOgk/wAIewsyDKk+9b9J82ynI1eDvornMKLw4HQ7kp2pBCE4?=
 =?us-ascii?Q?+WNgxfmzgiPZdiLS0MRPqw6CiIUaDea+FHEAKHrmRVr/intM9NxSA0f74IR4?=
 =?us-ascii?Q?Wz5RfSYHaWDaCWqRzJ0MDxGN4khyWvC3oFDQtsCEhYjORFWC1MDENgTYk/9V?=
 =?us-ascii?Q?g2xtQVIuJyrkwcclc/AMh5YP6J1H2GkXlljmo0mB2kSm77ApObIDxn8Gtvdr?=
 =?us-ascii?Q?mXHc5hOvkOm9IXVKQ5QtyfQqAjnywpQ98nSv7dDAVu++ynuMkLRu81GY9zOv?=
 =?us-ascii?Q?tDevR0N3+N5oODhRmj5GGpW9Dx/DHxV+1cdAGhuWpKAQUJUjeKbNuRySJjrk?=
 =?us-ascii?Q?WGNGvBodQldbPCZLyQP3qM+0KZ09sDv26Tq+6HLq5Ovhce+i1cYD85+Y1XaC?=
 =?us-ascii?Q?50eai04WgyTumehSYw2D6LW8Yf2UrIulY/9SvujbyYup7dpWwj1L1fdEh3eT?=
 =?us-ascii?Q?jhRLAWEmnCN2bd3wWVXOQNN7/K5LuvCCHQOEZx8X69SVQ1DzdPjjUBRKV6U6?=
 =?us-ascii?Q?7EgY/9xgMgKH3p4txn3nG608rhNGCM2VrGYJg2IBtuH5CC2qjl27TLSTNCXb?=
 =?us-ascii?Q?WEDFcOxZrjM6Igzl0g2V8Ri6qKJXu7/J79x30DAcgoKFo7jeC/OcRVc+2p7z?=
 =?us-ascii?Q?B79HE1Od5a0ZOauoK/Q33IiESYKfFGEuUZxjBRQxvlBT85dAkHuJaBLSeKQQ?=
 =?us-ascii?Q?CV2q7paGfqxtIXjAxru5njDCK+ON2VGgWomnPNjBFCGJmMaRRJ2wZvw27fNB?=
 =?us-ascii?Q?F03Ii9fTLo2fcLhrEEt5xglVujLuNOPdfg0MWc3rO2eE3a70KNZt56wJXECw?=
 =?us-ascii?Q?ET32KHwpwTjiqB7e2vNneS+27ad+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DgagrtsmXu0G0dcnHr782/waeOoQ1mKQWgJTCJsnGqsFAvLZIiRB+GH7/ONr?=
 =?us-ascii?Q?aqEvUOl6UHxM3VnnONNT57f8kHYw9jnrcmnR+2ExLp6b/QEUDCq+3shPw52F?=
 =?us-ascii?Q?rJ0zD9nWUNvoHxVJB6NJwstK6JWctoJiEP83K4pwvT17XlYXMfwZ0y4TGQJT?=
 =?us-ascii?Q?3UQyCmGt9n+YDsDWuY1fjz/VSYbqtQpX8Q86QKEuRxIDtQnqoArynYH2HvJx?=
 =?us-ascii?Q?8jyfthDGKnoakI17HVXwKNYrvBNI5+pybY+cZuGRn/kZV7es/jbzxIuaZwSP?=
 =?us-ascii?Q?5wptoYMCSMqrMnXm/2uJDOng+KUxJzs9KpkcQa0822rGwr+6z4cB7tDVPHWr?=
 =?us-ascii?Q?hZ+KZaJ2zPMLLZWgbczNoivArSRrernhd/4b7IkigUXvf7WvHjmBJV3w/dVi?=
 =?us-ascii?Q?Wy9eMweHw0WQ3TUNqRJ7uhAsUjMuoIfSzlX903wsk+ScAeP/iE8r8xkqC+Pj?=
 =?us-ascii?Q?pd4AsfckH1HW4yrNLDCpMzbLSA8AuU+ZKdeqfcD4ztIeygv9lBdHUnsf5/46?=
 =?us-ascii?Q?ztGxghErzlJoRYLV0nfleDhiAbsPiJueSldWZy3eewAH5HcR6dZCLSEbBVC1?=
 =?us-ascii?Q?oLwHB/P6qbGBi1VUr6nWkTIGPkT9RWwC5lx3mziiI589hBmRxXqdkTBB4FRw?=
 =?us-ascii?Q?vXZjCc9mmJUCqmkaTSDHDwzvqj1jgUu4tBxLSybOw+/hnFHYFPAh6vIiXMNb?=
 =?us-ascii?Q?vG/7ZkCS5SQM96gkA/zPxgcHnGlKaKmdl1/UBapbh1EZdmtxJH8FCK2tixA0?=
 =?us-ascii?Q?4qYb2nbBDjdUjX73tVaBFQQXbUOVI34loluwwXoyjaIGSbqrwVRIPK2r2EsO?=
 =?us-ascii?Q?lLQqzsGodmI3T1ZM/kCEWWn5pkP7ur5KZynmR8vMCsUQNVsPuj+SfRuif6at?=
 =?us-ascii?Q?wH0JGi+KzvIZOnLwp8jJ2eWRH4lnOL+R6N1LJxzMg/yB7rPbGxARD58TRciS?=
 =?us-ascii?Q?3WGy76guH6vwGmu406AOhUJonXaQkyLcbm4WOoYWW3kNIxD7NPDr08QRYxSH?=
 =?us-ascii?Q?fu+y1s0WpQCe1YMuaU1diFxS0IZgSMHpMs/WgCR5LMtCI6lUUxqFoMBgbp/o?=
 =?us-ascii?Q?A+eD0feimuUJUimcP5Ddn9zMINf8EsB2Epxy5QLez6LI00Ri9LQH8w7sv4lG?=
 =?us-ascii?Q?ZLsQ592E9thVLa16MypYHsnOX/vRB5mdriFOh4kkSwdEPO0ZybFSMKGzsurz?=
 =?us-ascii?Q?LKobdxGbkI2fPQ+ZLebkVB/pTWyFxOdzQc6QHfEwGkKFpeCCQy4RFYHjgShc?=
 =?us-ascii?Q?H/4c+ja8rl5hkmJf0leeNX1chMD1Tmf2qhSxMvmUna135BLN1Lo/4LPLhmj1?=
 =?us-ascii?Q?aSS2gJOVoKseZQkzt++Zu/gDzg0xaNEuVhfxL6nnQHPy2bLheKujmAUt2ZXd?=
 =?us-ascii?Q?ReoqAixCXzONEBznap/tTzSuc7z//KLcC4XX+Zgmq9MNjLvv1lykL+vTaKKa?=
 =?us-ascii?Q?w8pnlnPauV9EuNSIuglHcZ6CaOSg03mYIPLaxB3YFSqvPumR/5PCgwsmV3mr?=
 =?us-ascii?Q?jX4gTLMoPU3jJZRXkYgASl6zb3A/GGb90KD+cwt/DqpVw5DtH34g/t/wAcpj?=
 =?us-ascii?Q?/KSgfg1Rgqu9aRMLWL4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81fa1cf1-8b05-4c54-f087-08dd503e0ec7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 17:02:42.5372
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +zIzkAxCk6q/+IYhCLSVCMveXoHcP+sDjAHCExr+Ow48nzVMOhO4uuoSI6rAURfb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5682

On Fri, Jan 24, 2025 at 04:30:40PM -0800, Nicolin Chen wrote:
> With the introduction of the new objects, update the doc to reflect that.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  Documentation/userspace-api/iommufd.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

