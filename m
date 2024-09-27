Return-Path: <linux-kselftest+bounces-18466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B17DA988416
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D350E1C20AC7
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85C018BC0A;
	Fri, 27 Sep 2024 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="naWUAdMH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BE518BBB6;
	Fri, 27 Sep 2024 12:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439656; cv=fail; b=SVoL8Q1KOXRfdrAVEH9f8cUXx6KjGZlA5kd8uXKNHThnI/9M/oPQmB8UGei93Rdiq9pq/GLIiORS6ujdlkyRRbog+e29VdJckWmlqyFf/XUKAH2/1buOyvNfQkFy4bQq91Ise6pax0FD5KIB1LMdwYNb3H084Op7LV/aveYbta0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439656; c=relaxed/simple;
	bh=V1B2DMkwwsiO/3EIDGaETA2TuEpHLu84KPir3BYjs/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aPM3fZJ6Q1bc5dh09ouHixhZYzPZs5aUwR5dBIiXl03T92mezLNOjGBLFBRhp2ebwYTE2zAn6emY7PmHc13Nu6R/7NxfIcM9CFtNE5i41SRf6h/M/52Vpolp0r5jiXCug5/LxERYDodO3keTQzTDDQSb3Uv58BmQEmYv0XhI9u8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=naWUAdMH; arc=fail smtp.client-ip=40.107.244.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LH04SsoqWzLhQAONV1BLg9rSf7ygxm2pSpIO40uSkVstzq6Jw5hFoYMXVGguwIAaJz27WqNHiuvkyVamtyhKKc/wGzwcw0wyzrovBC/PYajWGNab8na95k0frO56pCv/7ENI20NQSnBqxadXsoun0YlLaCqN9B3j0+0tTFRSNpU+HmEC0CQR//gLsQdUBR9owrS2GaEIbILBTAti7/GjnrW1dI3tzVRbYafltAnhmA5sI4g4U5RA8jM29oxZzyh2dbghRSyI2ppGeisLY6cBfA634zre4cNf4jayFWZM/Zgbhpd9KjpV2rz6u0CC5tsn/iCTVEkA15NtC5JQvFcYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFHyOizOky/nsYwnItR8zaaeemmVKqiiYulZUay63+A=;
 b=BnqP5xlh73Cp/ayKBghXNtva80+Cg7o13t/8y12KvMYMQWIx78wp8R8IQTN3G1Gr5LnDSAFLngSsWxY0NJ0qUGpcrglPeUDOFR4QcWMsY3idCgOWI+Ft1FJGFAbjJ9hG71IrseIKtxphSYgtO9ntd00jcmRJ6steW9hVHwLnXV67U0pvuXRinJfvk9yn4pBowBoxL0/Rcva6W/HqfH3YCVFcdih8XMhxJUIYrVu9byuN4beCUqFD7ytxr4QsywpMSugzrIlYBxRtOKAtvRO7o+CaStV4P8T7DH3atHFmWf4bfgL2HfB93buOGL+On8RJwV9NWPnQ1EetNq1Eb+3AiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFHyOizOky/nsYwnItR8zaaeemmVKqiiYulZUay63+A=;
 b=naWUAdMHI6Wj6n8pl1h6XFaOKNhtDAjHXyhNRnQX5vjFfy9YLVlr6VO/7lF2yQKgh+icLF4/Bglbcz5y5nOSk4sO4l/0n9lTvD6rJiLkdripHGXAeJ7kQOqBpaOulKEbu6lSUmiHlrzSsNE+JWOJgHEPiX8IMGZweLd8qUp83Z43CH5qcAauyuAmThJ/q5CEX66anPQ7OmqLFoLLbjJKjrelfKOcXYVwb/u6neklrkM1GjHaqPHN9rMRlkc2szY9tDqb0DgPx5ATsPlmKDxTYLcJATvcZLPtmMfFVlh4GA1T5XKjbw2PEmdCL2V/1+N2JOkiWSPvF2MMxJLMTRwVNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 12:20:52 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Fri, 27 Sep 2024
 12:20:52 +0000
Date: Fri, 27 Sep 2024 09:20:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, baolu.lu@linux.intel.com,
	shuah@kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com
Subject: Re: [PATCH v2 00/19] iommufd: Add VIOMMU infrastructure (Part-1)
Message-ID: <20240927122051.GY9417@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <bf95f910-e837-4d79-8218-18d234ece730@intel.com>
 <ZvRcskGx2u94Vs+R@Asurada-Nvidia>
 <82632802-c55a-4199-b685-8b594a8e7104@intel.com>
 <ZvW+BoovlyJ/wziX@Asurada-Nvidia>
 <ff35efa5-ba7e-4974-94be-59bf794a14e3@intel.com>
 <ZvZRapZlAsEGDIge@Asurada-Nvidia>
 <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8440cd72-ced6-4887-b724-ce6a1650db13@intel.com>
X-ClientProxiedBy: BLAPR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:208:32e::21) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: 8545d90e-7bed-4b40-8317-08dcdeeed3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BbowH8Z46a8hCvGCl7pWWRj32Tofhs3GjlMfFuF2d9es3i4Iv4ASTJLgDCmq?=
 =?us-ascii?Q?/6sCyHpbTouuJyAZ4ek5U47bvwLp+Edp4Hu8sHaaAOE2csuF0xXFzK6HMR0K?=
 =?us-ascii?Q?Za4NfLpH6cFeS9gF39GdCC1Kr9N9/EP2RR7T1D0YouuBOQb/+BUjfbUvpiuc?=
 =?us-ascii?Q?47bexSUFxoju8Kx+EDXv3RbqspFqZ7LYmFPJzuH4UMq/TVg8OO/WS4UgNA7j?=
 =?us-ascii?Q?mS+LdFTmBxu03lp9ew7J0MKA51PDRBBcTYx4hCeiGaXhvqRikAgXxXWMhqJW?=
 =?us-ascii?Q?92TEYK/qD1LRzapKi+pyq/jrYErbU54dJ82T0frqMKDq78OiwpXXbpZO+5Um?=
 =?us-ascii?Q?JWwpiJGX6qxn+MpVjd/wTieu15AfOD1PGNdsf4466C2qcPlEXqM0N970+0Bc?=
 =?us-ascii?Q?6zXtQktKOzVtKEIJgxuaELcKiwA3RgIb/WiZO3wNKZLIM87/EwoLTUR/q8Lc?=
 =?us-ascii?Q?0o8nSQwC2Si6iemBTjFGnFyCDuRo8CdOATg6atYPzdQn1nL7twuAW2or4NAh?=
 =?us-ascii?Q?dIZaP6/UPU2vhqR8MANtdDQwCHOWcyDD4IZ+hKIoG1rIs0Scm5CZL9P/C/qe?=
 =?us-ascii?Q?rr6uRAk0SmINnX5rM1hTapJXAa3W7H2yvt/X8SLpqPv+6QJlbDQk41oLeS3w?=
 =?us-ascii?Q?T3OdRy4pPAsjxS5kLKiOqQoMcLJDESL+GIyXXBAlBNLT5nkvg9/7Gcy/l/Qf?=
 =?us-ascii?Q?F203wfIi+IVUO7BRYdbmrHr1TYs2BC0CGZzc/IXScns5B+9jmG3TUvHl277l?=
 =?us-ascii?Q?fkU0pt9t791wC9TPFwoXKrflcGidxUT0muTZsGoFGtU1gNrUswiRqwwzh4zb?=
 =?us-ascii?Q?T0JPGKdJKQcIAj9/yKAKBlANEPLPXw4F2VvwfbIRZxCl6I85odCIB6A2zEo3?=
 =?us-ascii?Q?Lbrhc/iYXeARA8vQBDOuipZw5/sSZZvKGwDB4gIBytH/MEogd4aPzjNcRnZe?=
 =?us-ascii?Q?bI2TeSHBenJwfeOJtRRm+k9eQJYQypsNN8xhDRZZvMMAj6GXNEE+0u9l24ZN?=
 =?us-ascii?Q?nsTjo7UmjBV9sOTn6fXbqDCJ94YZ1tW19sx3iHT/PJAQJy6GyNZIMuTnaOK6?=
 =?us-ascii?Q?WRgjFQFv5zwTCWdAGvQM1ySt4LTNYccexeo+5j/uegtYFiuK2JEhd1vluLjg?=
 =?us-ascii?Q?iHS+g1CT2KOxfJCgufqCRLjgs8NPCmoCdRcjj+vcXfO7SLb1QQrm1O9UvwnN?=
 =?us-ascii?Q?NRa2gypKlTESqR1CQur878xaCWXSm3P9EnOmqobAZVWupac4WlRg9lrXhMwF?=
 =?us-ascii?Q?XO4+fNTbj6RZxi5VrhwhNa7bVIYoXhpupQX7FMTln4+4uWFkqQop8wD39qj4?=
 =?us-ascii?Q?7Ybwk0p87U+uOQYKUgBxWnk+cXJSqTMTD06hdIgVtfxQvw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mLWgtUhZ66tyxadTA5NYuI6GUCcQplCXumB4N9HLn1MS+udJqIpaoAOdEMSs?=
 =?us-ascii?Q?ygQMxYHu4BjQ3Iqpz0dkAXiB5r24jQ1WPlQDSgvr0b8eKeFTnsRx9ANR+URa?=
 =?us-ascii?Q?H+ArWBfYV1mmDhZdMGouKSnBwXxOslNZ4HMHihzEw0mG6BeWAm6qg3uQhqIh?=
 =?us-ascii?Q?xaoASK80uI357kM75hUOcJIKl2VWwmWUh6B1MoRWE3PW6CT24o4CGk9g89iy?=
 =?us-ascii?Q?a5q0bnIvoC8N34fw2XIANL7EIWGsNfawSm1wGtjeAOMC9MJ0Rb6c2defcZH1?=
 =?us-ascii?Q?3L9/0638tGqtt1ecPW7VtdwlC1+O43jDoFDfMStItl86lixGPWzP+ZQ8lvEV?=
 =?us-ascii?Q?65sg+EYgjofeVgEp7qpYYDmMGju61iGan/QJXaJ5lptaXiXGxbFw+EojL4/L?=
 =?us-ascii?Q?s6k9XoOanjiG9pj7kcAw9CHKkVr/NxXsR9r0CClXiN2s7lbSX4ZVlOw/MkY1?=
 =?us-ascii?Q?J1IKKu444+e+dByC34HT/mVGyYiWlFVDU3H1cIkm1t+2B0zuvO2DARt6IwbS?=
 =?us-ascii?Q?6tvncKBqV0HK3Mu/pvccK/kIxB6f8/Kx79ex4AyNlPCHfuwFspRYv6XTHb+r?=
 =?us-ascii?Q?7mqOC1P7/rH8e/+haPCQov06lElE5zfQZ4MQyw0X4lg5VjVbO9mqBTEt7f4I?=
 =?us-ascii?Q?/sJK6lqbobWrkBoP0kUiyyCxg+JRrubSHbVKZL2CgiZC6E18Qf78hUy6JPIM?=
 =?us-ascii?Q?L5u/1LcKeE3gkF6LT9xSy4rjW6/QwF5I3lQAuoeJjOQ41ES2fLNS5LhTFbcY?=
 =?us-ascii?Q?vvuU2sypjxbZmziMMBwGKw/tYWwaYTwStyhbYZCaG7FIF4oE0/4BqXtSs5zy?=
 =?us-ascii?Q?5twykS7mVp2ORwz8otdeQM9W50fle4vxpPRVf8mTxSfE3xisWplveVb2RCLa?=
 =?us-ascii?Q?ylb4uuDeemiT9vhannrHIUSFqry4f6Ch7uKa/Iv7fwXXqlJuXAWqMs2XmUz5?=
 =?us-ascii?Q?c/eEzPNaoAWHnfQcKC4PitzEWx+yDY9603Km/vBnpdtdI2cLUzLvXObF2qJV?=
 =?us-ascii?Q?ap0VHrZCK2osWQCCrKnIr37EEYCwTN9a1YmJSqS0ELxtYJ+d5O4c/qcsxqgX?=
 =?us-ascii?Q?LUvDsuQW9zobAEA1dpIOYlQI2BOUQSPps5o18BrWc3qptDfgrcVTlKT0u/Bl?=
 =?us-ascii?Q?vNblhjkcUSdZ26dXJEnB/AMDY5WBMMRfowqmj7+BcqT32w21hF+1zmSlNGBq?=
 =?us-ascii?Q?6b2R4Jk+lhgOS4XT2hhwGXt693+76/JIaCiNHfggL22tnlgdQgQ4aIR40COr?=
 =?us-ascii?Q?4FuE0vy5ARYRZcBgRjMFY6gaB2tI6tTDxfCuSDpyTShYARe5Ods6cXz+/OAS?=
 =?us-ascii?Q?f9skl9RH1tNgfLmMyA0udw+bcdAtluLnkzQkx+wgqIfmYsLYGUHmEuasoYUk?=
 =?us-ascii?Q?BiJDs/5517OqDYN1ZEipNZLav9pDX8usE4a3Jp6sriio/UpndvBZeccsAvyb?=
 =?us-ascii?Q?1PtE9mZQEJk+Wom4ZSJITg7pcOQHQLeBcDNmkmul1wY2v+mGBurXG5csTz8L?=
 =?us-ascii?Q?c5xP6CIpZA8/DKmb55l06SQ1XR+3u75s3oMnR6JA3Cf16dGqMSbkWNXEHRJd?=
 =?us-ascii?Q?YHS5Y4KzfZCtzPwjBhY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8545d90e-7bed-4b40-8317-08dcdeeed3fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 12:20:52.1173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIV7kujKqMvV7o+CiYu+Hzu6UjXJ591lbPIv1Of8W9VAs3OSkHD1I++Zf5xuuL8y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258

On Fri, Sep 27, 2024 at 08:12:20PM +0800, Yi Liu wrote:
> > Perhaps calling it a slice sounds more accurate, as I guess all
> > the confusion comes from the name "vIOMMU" that might be thought
> > to be a user space object/instance that likely holds all virtual
> > stuff like stage-1 HWPT or so?
> 
> yeah. Maybe this confusion partly comes when you start it with the
> cache invalidation as well. I failed to get why a S2 hwpt needs to
> be part of the vIOMMU obj at the first glance.

Both amd and arm have direct to VM queues for the iommu and these
queues have their DMA translated by the S2.

So their viommu HW concepts come along with a requirement that there
be a fixed translation for the VM, which we model by attaching a S2
HWPT to the VIOMMU object which get's linked into the IOMMU HW as
the translation for the queue memory.

Jason

