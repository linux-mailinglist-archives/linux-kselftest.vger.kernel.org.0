Return-Path: <linux-kselftest+bounces-15463-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88B5953DFA
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Aug 2024 01:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 514DE1F22101
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Aug 2024 23:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898C7156886;
	Thu, 15 Aug 2024 23:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ND7um/J/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB54156236;
	Thu, 15 Aug 2024 23:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723765070; cv=fail; b=kLDYQUNHg9zOmhAovq95g2J3x+Um/73Z6sm5ec8iqgJR5rUnTP6ChQVIhMNYCy7S1+xz5L6HNBgWQprNLzXGmxcHOxNyM7o4LnVektGKfhpKPH42KDM1zJj4PxQhA6hSb4m1sLrPPH/XrcfnnbhV0bcjSAVY7hfhL5UoLjZwTbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723765070; c=relaxed/simple;
	bh=i/OpstLCGm0UQg7S3O94yNbvVVPmOfpk1wValCpA1Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nq0kU8zK1kfGqLBYgMgoZDtopNmcSb7RTCx7Ay1CB91Z7rm0s9lS5EEFVV33Lmybtwhf9M14G2gdyuzgXpRmvbWMRSw3J5YTJ4o5lWM3Acbr+SlUoiqw9jQ6s5bpFp66hK7qPYaD0VEisktqMl+NczPbRBWx42fxor9snXMY5GE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ND7um/J/; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EHNYtOJg3VKnECcmyd0nyFPrbAFawGw2+IijXbhMtcR5nGxX6YUsQZTTX8zZ9hJsZYO+0RPsKwL0HUfQ8cp78aljoYZQ93p48VFIjQlCacz7adQ43b8pdZ228IwgsZRtTAqKIqxcRmmlC09hFbHjrdmsiCt99nSaP9Rox749htdgL2F7I/euySWdLVw3dsZ7ZhZTw49X0mynh4nNsdmw/cHKoMSWHEexqvA48MbV1R3uY9/fTUv0tu+dFaCW3KTmRwIgjz/aWw1HYcE27L46xkhnm/rCVEeQYa/mog1WDUvVbTU2SeMiWmhxYFrPDoDWrng6Cqcym2WWwWJnBfLwZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8V3NVOnkiZ/Sijldlv6n9tw8qJVSuzzW/RfZjSFMSjQ=;
 b=ZJs32Ga03NLts98nk8wYHtACi7kkUxGFG4BBv6tAWrMgcIGJ+Zk1gnnYCyBRnJF6jXicxTPTBwIk179g3avEOfiMrpAgPF7p4eqKvuczrDShp4Ho1KfrF3WZm3lvz/3WemOzqNBXWoUNHM117AwIoBfSYZTnDrz67+tk5cvMuvC+H022R3B1cg/sw9IyTXytFjidNL8oOOg62K1v3d90ArnkgK5yUfWwfzLLPr8eskEUKdj8U8q7SChzW/ZmFXuLSJw+ndndbz2DxfdjHAMKozsykodk/QDLSJD7b7p12gzypYKXpZjHqFuSCdqUm3NfmmMVPCr7pEh6h0IeMyToUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8V3NVOnkiZ/Sijldlv6n9tw8qJVSuzzW/RfZjSFMSjQ=;
 b=ND7um/J//sFeCI/smROlAe9PVursI3g82kKhQRqSvbYMwo5G1hjR+SYgQ3C6K2Q3ORJqUEnRNqbsdV9+NKI1KNzKSoGCZcrTQHNdYubNXTBr3bL96BtzZb+JxXqhXAoXa3I6mZkhX262OGtW2MOqNR36M4XKfF25DtmXDipBi62WUDCCSas7/64iyMBKxElPFTJfhihkMDiqxr+EBmf+OFHrw7ACerBTL5fi9bJfDP4VuHdTwUm+UichdDGkZPFmnmnUJP7x5DyzeBLivwTqSHsKKCgaLpoYKdoyMUDiLjaahvsT/67R1lS4v3CQmUIXJWPlq+6OWg3bLfu8y3kL5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Thu, 15 Aug
 2024 23:37:45 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 23:37:45 +0000
Date: Thu, 15 Aug 2024 20:37:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 01/16] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <20240815233743.GW2032816@nvidia.com>
References: <cover.1723061377.git.nicolinc@nvidia.com>
 <536c5e908af3847649d1f4b7050af17d77d8b524.1723061378.git.nicolinc@nvidia.com>
 <20240815181117.GN2032816@nvidia.com>
 <Zr5G86A2OwjAl/JI@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr5G86A2OwjAl/JI@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0087.namprd03.prod.outlook.com
 (2603:10b6:208:329::32) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a62417-20c0-468d-bdb6-08dcbd83436a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g0EdQlO5O8NN6GizEHFMc5mwkYiLeEKTmYdXS4MyBo+m4cc3h3zpOgneqgZM?=
 =?us-ascii?Q?Tz1GhkCiAxXznPdtt/FsibVhAAyWum4aQtfhhq/ntC6KEhILdRU4cj5OFuWt?=
 =?us-ascii?Q?rEIicxzoIx3RSuLA/WRlttZJlbGkedaSX7b5L+mCI31MlPfppEDmprlxfgy6?=
 =?us-ascii?Q?Cj4W7xJV7WkcFXVk+aPxtDW0NKup17Qf+nwnL0i++FKv04k2zBQWw5wnEDeY?=
 =?us-ascii?Q?HH6JxpIqHyK9UYoFZWMrDE5bKuIN/Yc74kYkNsqasLfbPAAJodPkkrs1RCc8?=
 =?us-ascii?Q?+xOuQX9CRTLr7vSrDV87S1wNSpjoy0C5fTUFkmKsL2/UOEpbHaMlN4lqtQDC?=
 =?us-ascii?Q?eV3eM40uD+3Qa5+4Dnr4gyZkgWIptBU9KWfU17oEy7+OJ1i4rI6HuJcmsjE8?=
 =?us-ascii?Q?WRhDjqFm6C3hkSaDedpaXXfXIubXwqq+eZe4MDjjGfZ7FEkVKbCml80QFkPo?=
 =?us-ascii?Q?Me64lGqX7nVa5LXGK2fCyiLzSE6NDd1DZMlgU1bd6vLMx2pL4H2ozA/a+t4S?=
 =?us-ascii?Q?L5uOPYHWJaqVdGxknKBCkBcYTdRBNfSKtRzg5TMWfO9EiUscIZT0qJ8GYHVn?=
 =?us-ascii?Q?CI3F0IUjNNnbj0s9knaF2Tr9UQ0SpTkXDeR+Z82l+xJLjYLJrl8GzdZAWiUK?=
 =?us-ascii?Q?L9jzQqyS6bG+IyShQwjzHe8KS2v3uTNte3xv+ABLopb07PgMruMkyAJlrgDi?=
 =?us-ascii?Q?VekNRpF2HE2OEIhUhs/8K1kl8641SvANo286hqaIbDGzYczkSCD4EaRMfhZW?=
 =?us-ascii?Q?ffYr6Keg6m90nfNN6eBM6a6AKU7dJVlFaFNZfHVPJE3CA4G8n/xiXt0w3EGt?=
 =?us-ascii?Q?WNrdCaEJReAgEWKhYtmcM2tY4PbDAP/k+77xV/9zjfMmQ/g11lPfBA5ybQRp?=
 =?us-ascii?Q?9NSDkhihqaSPUBT90tpUN22nu94pH5GklQy/QhefZ6fXOAeImWfgNWEkLH0M?=
 =?us-ascii?Q?3oC7kHRNSH7ed/ecCd8oLT0VXc6l+rNbRaKYkNrrc6WavpE30DLt4H7UwGbg?=
 =?us-ascii?Q?V7/9Zso1uw4+/DjohMfNKxLhboZYSQ/Xy8AH1bM49puXkLSrKDUEFu+PtcKP?=
 =?us-ascii?Q?lcLCv38naWgqQEJXAjrwTXUR1OcyDOl9c5888XaLtJJUNoUCaEhlZuxzX7+W?=
 =?us-ascii?Q?in2oqHHiEN+m9zBxTZfSGnZiZGwic5gkhViEFk8AM1tuH4R67PuUsoBmss9W?=
 =?us-ascii?Q?O4mVBYyTweo5zhX4LnYMoaCpCX2BfusuAXuIfLOGg+jT4re8XXzuFK8wOPla?=
 =?us-ascii?Q?8G5016Q5Xq21N0zt0vf85pjH5nd0YwqgQfnlX8FShOvS11dnWveSGegZs9NI?=
 =?us-ascii?Q?Ha1+YFzlfDz2HUYpUlX2AWGJdXD6t5Txt4ATlJX5VCsLSA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H/jMhD8LtWtyENV9QEHUm/F/syc1v+BhxbNKD8mCjZhmlTiFPZTN/DGzRX60?=
 =?us-ascii?Q?Oq0jFevfdGVVZ5sqaQrrK+LxFNIJ5cPAX0Bigk8uw6fdCPyfAEvDdReV9jFO?=
 =?us-ascii?Q?MtAkLmxDyGeomkA6PDxlQT9jPvrydcbpTC1Z/YQttIvN4jLSK2tilgY/9jnU?=
 =?us-ascii?Q?VAwVdQBClZQDEGG7l+gXhHO5ZjHTobc+ioEoeMJS+6p8/WU83jgEnTjsp+Np?=
 =?us-ascii?Q?pjgwFyOauIxqzDAYOjpy9DUJFN4sCLi5iyzOLGDChAW0+3igS2Qsjc++Xmrn?=
 =?us-ascii?Q?tNFHdXPhZKeC/pUpyIWFdiz6xoUNsVua+fl428qvJ+pghNjG4fBAQgzcpPEm?=
 =?us-ascii?Q?QGGEf/3b4/1JHYLIPgSP3/QlZGMVlzdbLrJiF8JCS7sglOSfBIa1oDBgQQkE?=
 =?us-ascii?Q?Dk+HIWSphX04PMpNuYe4fWr9Am8B/ppBmyBx4cYB8tJ0uV+78cyOVWmnLX7o?=
 =?us-ascii?Q?xKsSro4qLDFSzDozIQggcV0UG2ScmWy8MEItK7Ayifg3ij8OXJoOL8nxuHvg?=
 =?us-ascii?Q?eY2bmZMD+EQj16wKwtwU0aqjra74Kuv1+trRN8EDtQMwJ55x5AzvhiDRPtPd?=
 =?us-ascii?Q?93RE9ivsNKbz6RVd9r/HQCybpboQLngxqCO7jHk0mpRS0qlMhoeohCBXMjcj?=
 =?us-ascii?Q?exE4XN6a3kdNULuw15tGyYguT9d1Y9yrg3D6h0cPdsxVeLaMtcFiBzJXIBxS?=
 =?us-ascii?Q?tOloPeBpNII2e3X4m5C9pogH3iw36XYlrLWhfOU7T8uhB50MWTemNf5Htd4L?=
 =?us-ascii?Q?0Ug+ce7nZwrrvSTBYjOJziXCO507CtisY8F6KnMsPsailACt4B5OxP/2n+0p?=
 =?us-ascii?Q?dne8x7W6XDIL+8gv/tAaa752JZjRoejNw9nKAL/+SZPKLs7bz8MzxDYQsI2r?=
 =?us-ascii?Q?QHLnoz+xREyRaKIoR3bBPk+3hjQ0/Uaa9GP60AzSN+c7DSyxeSwg0QG1CZnV?=
 =?us-ascii?Q?C6vNdQX9K4KK59Q9BameAJxra0rw7w8fhjANIZ+VU87BgmSRCnveQbOI+IcG?=
 =?us-ascii?Q?MlqgB2D7bdMbIoJglu756SMyPAI0dbQNR4G7GMSfaes4JqXd3GSQ57d+igiu?=
 =?us-ascii?Q?nOo35kBkaVN5Uv++5D5KKq2uUrvUljcQqJkwmyLI2cglfMzmuQkpWlzlI2nX?=
 =?us-ascii?Q?4oKIcH2q/NHg5r0Vld/McGx3QhuOoBgAxjXRqFRwYi29QhT6/loKzOY5Wio+?=
 =?us-ascii?Q?vXk8e3DyL2ndFEfh4Aty7W5lcp4Pnl4/f8+Vg0hP6bptuWUf8gFKx8lLJYEK?=
 =?us-ascii?Q?sPvBNGB20IR6fxGYtrEMy2nnXntli21MeFUzUMucsg4p6SxTtCsikeQ/0SJB?=
 =?us-ascii?Q?Wxuupds1oPBIN9mbG6MK/K9WkHJW5/GSnML3vfgVknsZBlrvN++pCywj7Uct?=
 =?us-ascii?Q?qejDrNLinXjIfN2lYAV6nBKOaUFJuZmZJzO6hpbTMbT3UlGM6HGsxGzoMEQn?=
 =?us-ascii?Q?jP+LjsrLWWd09N+GIzI+hfvoqxHxecGQcsaJsinJnQU5PbaZtgFVOgFptm7F?=
 =?us-ascii?Q?c+JruYbFUjJvymM6dy2wGfijPldZouHP93HuvR3bJaECMAw5lKvxDyBdeUwm?=
 =?us-ascii?Q?O/+rnhpljaqqfE0TGu8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a62417-20c0-468d-bdb6-08dcbd83436a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 23:37:45.0547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMGLfDCUCKcvEHxJAiXYjtyjpMuLo4bmdZZDssACrhMMayaPkBk76wEZGxh2G4+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024

On Thu, Aug 15, 2024 at 11:20:35AM -0700, Nicolin Chen wrote:

> > I don't have an easy solution in mind though later as surely we will
> > need this when we start to create more iommu bound objects. I'm pretty
> > sure syzkaller would eventually find such a UAF using the iommufd
> > selftest framework.
> 
> Would adding a user count in struct iommu_device help?

Yeah, maybe something like that. It is a real corner case though.

Jason

