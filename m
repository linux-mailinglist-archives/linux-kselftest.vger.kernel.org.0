Return-Path: <linux-kselftest+bounces-36855-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0799AFF206
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 21:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55B647A2720
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Jul 2025 19:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58223F40F;
	Wed,  9 Jul 2025 19:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oTNxiz40"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02AB111A8;
	Wed,  9 Jul 2025 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752090600; cv=fail; b=p2GHE0PObXD4FI+TaFCo12cKaU1mS4u6vT5w3E+wEOMt5NlF5dGK5KcaaMhtyVk/484+6td7YnQhNEwAkkoP/Wi7dp7pa0Pafs2kUeVaBt3gybVon1+64FAUITKQHb99OByFWoc/BdTK0LoxPM0pXFh8x7cUB5Wzc1SkZc808c0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752090600; c=relaxed/simple;
	bh=7cSwVfXZZIsaSw1b84LAtUc5dM+RJwpNQ2DdM1aV2dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVWkTfoXCHGmxLn1wyDq4GIakJKD81wjkfwHTQ5EqHzA4KCFfsud4/3CzV+BlZUwfovMykW0m9dyIV+d+FQQYB1Zbzd4h2ka7dJUFvC4Wk/WKqoaBaqKmS05+JQfLGZXBJEyIsz0vraoz6XjkuVLF6MKiz29Gr+1ziPLTUZWmeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oTNxiz40; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtDqanHErC7O/7vUkOF2rjfUhOVeump5in6U7KDTEuWBdbb6i400HxjGoj4o1V+JxGr6DvaO7maTAKjfm+iv2FVT3sOhyRMfOJDJ+N/I8xQ1ty76JoYFL5SIQ3BFV09yuIBuwszXKmdfFWRCWoFv2C9d1kUGOjJaYFM2fvmZAk3amlKOYhOgYQc3vQdn4AkEhinlmOdiC/1UNosSc5eNwfKfc2cqXSYq47j8iGzzQKo+iL+Y396gBk54G1aExTlwihnL3uhSZiCSp6FP4YofwNsFtNiQSIRXVvLk6dyL/4wUgRdAfeSU/89tORWUGEKdujkQylSZnlSa8/V+K2mm1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lamj4lHEgWpaEAKNMeRflbxkMhkPb8NxZTNRh8UXF/Y=;
 b=w3Hu1pl5YEMRRUPDwCoGyFNTf6gJCav+m9LTWgSFrOo20lDwq1nZUuZ3+s8crjoCFgWMGPQzFocXAujOpnH1axYSERPD4ua6xJpuaMahBtRDUPAYBt4YQGJiQglXimnAYMzpaabTlnEzQpUSlp1qdgf3Nh8xymoOn7B/mActA3Q1AG5mkiJthgvbjwldzzKLlzSKiMLpCjDhkGDQ5wbIsLAin/Q6L8AOnlOaun5lwmZJjOFn5f3tys8gDIXI+ri7FmZzWITd73mIjSZT7QUq7x+sRaJvq0IxdzOWfE41Q44RZVqTE0/r9zCoBC0eay90Lo0nWL+32szBwVn22V08rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lamj4lHEgWpaEAKNMeRflbxkMhkPb8NxZTNRh8UXF/Y=;
 b=oTNxiz40GBhgifHBvtzS8qN62j8viZHAOFYfgqsyVbaogQ0Cj/0qYBL6YuymC9uxJEFYJktl68q6dfrPwFkLuIKGUvKXMtuYywOiuBu3Iapir+c8GRmQ0aVexUS6T+26v9reiDDOrUZtfzaa/df0KD2yqbc01oBmK99bzEOBazYW4fhmcj372IfZ1rwFaLvdfFf867Eugcg17WpL0Zcu7Hfa7DYX7g4pw85fjOdLrj/cMbeF1AQUVcRlQyeBwy+lJtcCUlutNjiV9gkwN27o5vtWg2/Ss3+Myzz6v7BtqAgRhhL6kc7Cz5j5Ytgm6VD3KidLvadIZw19EL6BOwM2lA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by CY5PR12MB6384.namprd12.prod.outlook.com (2603:10b6:930:3c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Wed, 9 Jul
 2025 19:49:56 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 19:49:56 +0000
Date: Wed, 9 Jul 2025 16:49:54 -0300
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
Subject: Re: [PATCH v3 15/15] iommupt: Add a kunit test for the IOMMU
 implementation
Message-ID: <20250709194954.GK1599700@nvidia.com>
References: <0-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <15-v3-a93aab628dbc+521-iommu_pt_jgg@nvidia.com>
 <6onfcdqxaeq55fd6csdyovudfbx2f3baimonejkmgisab23os3@fzj3mjelpcob>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6onfcdqxaeq55fd6csdyovudfbx2f3baimonejkmgisab23os3@fzj3mjelpcob>
X-ClientProxiedBy: BYAPR11CA0065.namprd11.prod.outlook.com
 (2603:10b6:a03:80::42) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|CY5PR12MB6384:EE_
X-MS-Office365-Filtering-Correlation-Id: 04b381af-3e93-42fb-d9e2-08ddbf21c7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ubKIQBgXu1N2ZTKhvDcEqrExk6/XgNKwac+DXTimbMJ7rPH7K40hUi1c0SkT?=
 =?us-ascii?Q?a3aB8hxj3eUTPjkaXAgh3GAzQv1ytVIb+tGo6GI8G3bIAJWdTiMf737I3KFt?=
 =?us-ascii?Q?XOT4jsPOwpgc1wJ+uCDC1FplbDgnmQv2WETQ6N6wK5kt03mOkhUeMBLPJXRB?=
 =?us-ascii?Q?QUafJXmTnKtyQwZ3eJlIYI1LZyZbHJEhcIF2tbc201rlgbOOuhG2ebltyiSC?=
 =?us-ascii?Q?1hAd3drBStgrZLuy5/nJcQJuc3P9yahnSvxV4s/bWxtaC9Qef8ecavrakCmt?=
 =?us-ascii?Q?1hcrfFDvHul4xm0jVeB/PkM/0XkIl1vgEUgnGEMIBIAauBMkE94WaqURT+cg?=
 =?us-ascii?Q?L9myutD0UPg5MJT6ST9t0BHOkBkqEU9ceFFACu1SEgRE4oV2fsBpJtuMjCAG?=
 =?us-ascii?Q?VMmC2p25jCiBzED0kysWIfCSoXyyxXIUrB0n+GXqTLCfy3R1Uh0K8eB8zKVF?=
 =?us-ascii?Q?KBlp9x2UYJt0RSFqY1AtSMXr05OVTfVXI1ul8DCGmtow4Hp6tV5P41JzLicN?=
 =?us-ascii?Q?yU+4vnFM6r+m9pf+Vf9qbdFoxwwB07d+BGXu7IrDgnRd/pzdlm494IS8ntUL?=
 =?us-ascii?Q?Bn8WX9/WLFDeeEws+PXGk7ZvoScaaTdM1ZFcv/inJnIf3BX+aIv2mxeN8aor?=
 =?us-ascii?Q?BpW4BTamt4gpP8LG/vf5MroqFYTL2INZ2S1tiUitC/lnWYIjqht41hAi7ziW?=
 =?us-ascii?Q?h5zw2rpsRv8CC8XT83RXStw8hVfpJkgJEyOqesTPESfNzITqYZ7CvVrbIANE?=
 =?us-ascii?Q?RdPD5s2XegoiodX4CBbWcPe4WNdesXOAWaThSQfMWZJTJagm0JxJlpxSPNaQ?=
 =?us-ascii?Q?83bMUn4qzISDFHvcQPP7qSCydMz6SKmu0Klt2TCVfiinljrHcnH92SVZ9qMU?=
 =?us-ascii?Q?lDj2HhgkjQkggKSLxy5JWv9Aypq/0yWzQ7l2gDFQc1TKp/+AZm8WG4Qn3s1H?=
 =?us-ascii?Q?w6In85IbfEXw7Yq7uc0+OlleozL0QxvegrLKFR0XkhV/TGsddoUTtiS39HxD?=
 =?us-ascii?Q?GDHS22AFSOSp94Ywk8QB1ADvug1xas6ODFZItMq2bIZl6IM9rnzzbmRzQWLb?=
 =?us-ascii?Q?zenRYJZtCtHoN6haMM16njK58ZfDeUa2IGVvnRwb7X4RzrMnTgtt2S+RhU1a?=
 =?us-ascii?Q?t9UwqBygTCnc9IPEQZpL48+lkMLknqPBC9cTi4dKuwWREmnvvTARZjPCiPLL?=
 =?us-ascii?Q?h0hDNC98CUA8hNLa3EqoPAvLwan45L7x+xxk6xdGnxSiZbhzMMI0LM96b23q?=
 =?us-ascii?Q?JnZ1OKeHjeP1rPLKSzGgGrU5ohF5ZbLOEacqjRUg91MYzNLp7rYQ125Qi2t7?=
 =?us-ascii?Q?Kb00pCPTOoon1S19tBVpIqDo1YQn4YdI2dM1tqm6Al93S2HAo9Sjw+s1VBJS?=
 =?us-ascii?Q?vahrVadv2ZcRIf2FAhHLRe6BiPCAGrEgY917a7LBTolyNU1WOjcHfPbWclNF?=
 =?us-ascii?Q?iP6iRFmjRnU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?blL956b5kNtr6G1ib8oxVY7ITOKVpWKW0DGKcalC6qqn4GEAEqON7COxDqvc?=
 =?us-ascii?Q?K3CJD1jGNohTZQoQfaLqDlKtBc2JBEEQXUQ+EVdK3Gd+rsUajvk5kKGGg4Sj?=
 =?us-ascii?Q?SZxmbTfBr9PbqJpx+ETjB3GvnlgYzFX8lEFfLWFLUt0vVn5+G/JLZUGoqi2n?=
 =?us-ascii?Q?9OTMCBUhpRfl2fBLidN5qtKuJQNt1VFpGYp90mNQ3HhvWwtQ6RilxQceGtuS?=
 =?us-ascii?Q?TbmtP1q+TSdjNAPA7V+JfIJoTlvGq8hCedKQsZHrlxV1LevJ/0DKVZqw6Jw4?=
 =?us-ascii?Q?bxWQsDm/InLIgr3tU8NKe30tnp4AhhCya/OublHzjQRFy5bhBCn5vZdbcF+B?=
 =?us-ascii?Q?RJ1iabzv1De3tpUNYv0HpuUlCMtNOFAR0ZS5SSE+OMLZXayc7yfG6vD8LvO4?=
 =?us-ascii?Q?U1GUqQH9pf83k62juq2IeVvW0IT/dS39Ku3tFONqhioPQxx9Lryvkf41cVFz?=
 =?us-ascii?Q?usFJpZoryC/osAzuVE4+tJaRiH69PMAW+8tZxO2R9aClsi9zNOuMUr6fJ7bx?=
 =?us-ascii?Q?hqWG18ylxQUiIr2bgtTNA8Y+PPVjFSpLoQQ4IwMOafoDK9kyun/+SPqpHuve?=
 =?us-ascii?Q?1y/6Ndmde7zFohDsgNkWFvePMd/KYTtD0X3mR7mfINiHxll1u1SK90I3tiEV?=
 =?us-ascii?Q?oiQyfOyTDkpagrlc62hHAXh4t4VaK0eDpZwC9kjc8TrSDMH5RFT0HQUJHqIr?=
 =?us-ascii?Q?dr01zwB0wDa9KrqQgN+6IzaOwyvhDAu+SM9B9c3wDpE8KR6pRg3QSPFRpCts?=
 =?us-ascii?Q?MVJQYohdo0x+LvL5/2wHSTvbAXHikAVnWaQd9hIeDtV3rPnr2mOewGPv0Cdi?=
 =?us-ascii?Q?/QGGRExEjqn6Wrx5ZvajoxEz3/N5yn3NHr9rorzoYGu8mYdolPh0o3dSGHvy?=
 =?us-ascii?Q?32IwXARn2mX+/aeyA9Jj+8xeCZ9wi6iEQaP24dt4Gji8I4j3xZYR8H7YW9f+?=
 =?us-ascii?Q?UZQ0GNJNVr4iP8/I8+g+B0ywO2QeAA7px8RUMbCN1Zrme5TgkjumlJ5Y1QDD?=
 =?us-ascii?Q?RtORi+qjMnI3yPprxYPaRW3YDv7jMW7SSpPf917WJGVAYsBPHP+6VL0bqpdq?=
 =?us-ascii?Q?4F0b0KNTVZj9W45KWtlLHpfuZidmOkEyYqaWID3QC1R3UlXinIsVYpUnRk2l?=
 =?us-ascii?Q?ohWPydWBnpCSCVX1a3a9VykgbOEMUg8DwnnBQNETk01GAQ6ro9fUdlSGmwbp?=
 =?us-ascii?Q?CwB2Sx2ZV862StE2IA62vuYrIdBuj5z9teXLyO53WsiF8NYAUeeX1Xz39Ivo?=
 =?us-ascii?Q?CYWTdy9W+PnRk9Ux/Wn1lKdDFmSseXXVLGmXPMxpO/CrlYFg35DdqMCKRqT6?=
 =?us-ascii?Q?OczY4WW94Ky1T5mvQs3RrsLn/K8gbqbmh3GHe8l+daQdps5dQbajVDggsxFR?=
 =?us-ascii?Q?k7SDcpJoxDDmJQKBM7VINcSfSMW9leL2zaJHLXgcow8NSLtjirazDhbDG8v3?=
 =?us-ascii?Q?X5EWdJofv1K2C7VMEdOCNCTdIucpzyYqiXhwwfm/NG/jYfl28Sw4xelMlcVd?=
 =?us-ascii?Q?A/mX8vIRU+8gnkWPhm3TQbC0rg2zf7ndoxFribiPLjxkWUwiDLJ1/i11XrqU?=
 =?us-ascii?Q?Z9WcI2NSYUmq/RjPN49CC3RLPqmXOLM8cdMGZz4w?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b381af-3e93-42fb-d9e2-08ddbf21c7c3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 19:49:56.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1n1y5gam431Z0PlINWGf76dAne1rRZElKF8OgM6Kyzxif3y7rE7IRBtSbMaPxrnV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6384

On Wed, Jul 09, 2025 at 08:56:19AM +0000, Ankit Soni wrote:
> 
> Hi Jason,
> I noticed a few minor nits that might be worth addressing in a future revision.

Got them all thanks

Jason

