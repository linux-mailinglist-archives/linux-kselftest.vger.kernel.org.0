Return-Path: <linux-kselftest+bounces-18008-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D24C979922
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 23:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6771F21A11
	for <lists+linux-kselftest@lfdr.de>; Sun, 15 Sep 2024 21:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC054644E;
	Sun, 15 Sep 2024 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UcVeJW4o"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454A717C69;
	Sun, 15 Sep 2024 21:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726434621; cv=fail; b=X9t5yxbr/S4n/dWYSOXV+lHh/ojYIrviNF5RMBQLkUPI9rpoYgfKLwrQBgb+hgDfrVX7BpKdCRvbi/LBbxVpWi0MOqijq3tkC78S7wV2vjSuMr2XSND5ekL9h0z6XkHdQ7FtGeXDbtraBlWYtI4c0Uw7ihXVs+X1rm1AtVudfdg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726434621; c=relaxed/simple;
	bh=M8k7/QVdkBgmCKZZJPu5D16XHtPKa0eCCjEA1uCmrzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4Yz9hvmsdcuYjhZ5IQphJyHRk8kjWKLIE77xfbh8QTzolNiHSr0BUYASDtGa2bUAwehblTapCUWjxIr68pXLx8xBS2OXw8OGgHGEpmVl5WBQhwoJ7FD4hWNobLPb82VcuBg4BpRqQ4SVKFT9PUQjKVpGQGmJYAykFySHQ5QjIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UcVeJW4o; arc=fail smtp.client-ip=40.107.236.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uibKAIi7ZDqVDYvUTsUVIxv6Jgf3mqAcDJPlarMxhOHXGzfM/kRZKm0xtKwgtXMcry2hf5Ic0JCJ1OmSHmU7h6d3oanIOhMv2IPISWK/rRyur/9y6RkUbhX9dQnlnHwlLSbUpWf8lZ1v3p8TwypUe5s3Dp1vvexp1df6e1h+2qgAb9UrBCMszdf0UxAzuOkI/BbQQsqQ0RBywmbplU0tsZxVEPcphbUE4MmSgJyzD9L5wM2a1UOKE84meb0bZEt2+g3mdTUgoxW7bggLzBXzGUvWCGLuvZQobg2HeKsF3wHrXnvrrcXWPZmvsOcBeF6FhmkMpahuYXI7SUsr3cEXtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8k7/QVdkBgmCKZZJPu5D16XHtPKa0eCCjEA1uCmrzo=;
 b=Ogv55u/FF/ur4paOri1eHQRVdUA0O6EPuED9pcnfs7MmFn/Af/F40yeRA0iNY2YSUw6HvVlJlrnb8VmId2xxDqf/Y04Az+Ilounb4+/5A/h3brzNOSF3YpM6McJ5S9qmE8GmaEMkChciyQqlGOCt49Qq5s/uedT1P79/zo5fSyW67yg3T9OBQF0TrWYy1a9zMzTwmx27oBhafFzkihMQ4enqsWkeanFHErOj8tOrLxYxaErIoOst70UgbIO4d8j8ulZygBqGJ56ly5rIxeAT+MhPkrDJiKXyLlaFFZTlOA/rw6UY11BaTIQdcu1G/CQOfYBPm0+qdCrXWwAvmvq2ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8k7/QVdkBgmCKZZJPu5D16XHtPKa0eCCjEA1uCmrzo=;
 b=UcVeJW4oUar4ncB4O6WZZzWWMaUniTAjooGJXPp5PlkXEw7ieqLSlRuxpVpF1X97aVay5lL5bzF5Nh2wEntqK6yr+oJMc1Z19wpAeND9+ZML63RFSlVOvrqOXJoRciH664ghqovLRBrGg5i4/OkEVaPC0+mYo6jDhPBzvZ8VlTylKOGFzMtxm0uspYSrsgrWki4JNQOTzFLp/s2yEUzl/PMM3vVVkaA6Gp0MZfqkW+eXKCn3V9Rc1pUzzMmG6I8U7jVOxKglBONPTeD+z6faonbuRCgbbMMQFl1YlAgyoyCgZwjvsQ4ZMcE9vYr1okBGmQGq+Bun704VgYFfLpupjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 by MN6PR12MB8469.namprd12.prod.outlook.com (2603:10b6:208:46e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Sun, 15 Sep
 2024 21:10:17 +0000
Received: from CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8]) by CH3PR12MB7763.namprd12.prod.outlook.com
 ([fe80::8b63:dd80:c182:4ce8%5]) with mapi id 15.20.7962.022; Sun, 15 Sep 2024
 21:10:17 +0000
Date: Sun, 15 Sep 2024 18:10:15 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, kevin.tian@intel.com,
	will@kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 02/19] iommufd/viommu: Add IOMMUFD_OBJ_VIOMMU and
 IOMMU_VIOMMU_ALLOC ioctl
Message-ID: <ZudNNz0O9NMDjHXW@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <c6ac7dc5031e96abb4634db504a0bf4a0c82ca66.1724776335.git.nicolinc@nvidia.com>
 <55918c41-65c4-435c-860b-b2a177b0d364@linux.intel.com>
 <ZtVMrXXESy/RfWVi@Asurada-Nvidia>
 <20240904162621.GN3915968@nvidia.com>
 <ZtiY9gE9YDbgJyRN@Asurada-Nvidia>
 <20240904233707.GA1358970@nvidia.com>
 <ZuJijT8kcAsw3sn9@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuJijT8kcAsw3sn9@nvidia.com>
X-ClientProxiedBy: QB1P288CA0018.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:2d::31) To CH3PR12MB7763.namprd12.prod.outlook.com
 (2603:10b6:610:145::10)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7763:EE_|MN6PR12MB8469:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae44826-d30e-49ad-6051-08dcd5cacc8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5LzhVD1tILTOK2vhteRg2wit64Fecfe2CbExaJST49+nEBqTwJqmqVGKdLmz?=
 =?us-ascii?Q?QqQnPcDMQZFCOgbN0V+4JhR4g7IRCGNp+SbFoo9zO7cYdCIrRD+ORKwS0Xae?=
 =?us-ascii?Q?rUcZPHHfYDwPhdqVQd1QOqIkLCGivH1qr8q0vDuiS8x7CxBWIF9xFw9Q+8pw?=
 =?us-ascii?Q?NcI4XHGKC96CU7w9Iyd6yuC15B7ljCDIROwvKXYQXvCiWw3mFxeg/1YyBEzC?=
 =?us-ascii?Q?ooR76fcfGUvaoEJuyRlx1AhiGFeyQD48dILCtbcPdVCKBMmjU0f9cbN8lyAO?=
 =?us-ascii?Q?AeJgHxo58kDN7YqPAQSXiAyE8zDCPvFQRuOGCw2r/dFlyydqFpYcytT55D9Z?=
 =?us-ascii?Q?mvU34cRekJfflSserYa8Vp2jqig95qQU5l0XTmKjW94wmSuO2xmhkX54hZw/?=
 =?us-ascii?Q?X7OCSe1TXmIL+BgjBNwv4HgC7aD8I2SX0Qj9AiK/YLkQQ8Xx3KeAKOGdWByh?=
 =?us-ascii?Q?/gH5acIDnlnnu1lJHfr/Fr16u6+vlbcRL1FS7oveUYuCGIfUv8XH7r0jFwau?=
 =?us-ascii?Q?srsIcNV9PonpqVf+eGFmf3JjqAWQ7LnCzJRummGxgJ3h1GyzpViwYZ+3Ej8j?=
 =?us-ascii?Q?b1GAb+xC75RauZzYHbF1gElhgSZFpTKOOZrcNBCNNJYWoa/zI/PGEI+fqoET?=
 =?us-ascii?Q?qivmp0OJAoWYvNItRjk2k4GRVzbZXTF6D7BiF/vnwv18UbEIlOPzQlgE2g5k?=
 =?us-ascii?Q?lNumLml/xso2h36A0pwZ78CeHHvApMX8x/puyKsqS02nxmvSiTgrOFxePiyx?=
 =?us-ascii?Q?oY/nWg/flS7WewbhAmThq81UQBghDfcPjYi2KlIMxTo7pRR0Lx3kkGmgwtti?=
 =?us-ascii?Q?JkMk0FwQb6qeuV1ydY2tpbSQBQKnBBys72j4b/uo9cQ4MLBx0/5F/j99ROAE?=
 =?us-ascii?Q?6quoRIWAWZ6Mbog/e4zj8py00uUW8MfWvldUHVh5QiWmQoAqiRIV5wJ54ezO?=
 =?us-ascii?Q?L4kyD47HrtzzucD4eTZuUS6f8oMogURm9n1oTb/FrgpCv/oPhzf32W/RyLUU?=
 =?us-ascii?Q?y/eI80oJ9o2sPSkOyjicLhNfVhCuTylbEFY49SB1CffFKgCDAG2oQoH1qI6M?=
 =?us-ascii?Q?YHtDAiI78shIlZ2So0NanwS+NXe7ZuJOPvZ9lF5KUDVADTEKi/8U5+41DCW8?=
 =?us-ascii?Q?cTaOkRVccD1B0wJgaEcJNqwDmke34AtTgqoVNdbSi4pjkmgOBybtDbamiop2?=
 =?us-ascii?Q?4WGlURgvwqz46b8rIwnGUoSIua2gvUJMMVG/xzoGTR6wtWaoZYWhCocF+29p?=
 =?us-ascii?Q?5Oi9N19wBKjJsT0IHuV3K5apruyx10O6CRo7GUOZ5N3o9kokO4/9MjpZfecn?=
 =?us-ascii?Q?HgobjIhhuzg/MnAHCj4rvnA7WY9XYAQIbdj90bk/ofP1Fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7763.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mj5VVrDaSfeL3ZC/GI07w4uOYAFlZyQ0vapAxJ9md6jkbx8PJ/kNV0NCMJT?=
 =?us-ascii?Q?qKLTp3SVbbXqkz1wxAJkvRHfk69BJs2DboZr+Q0I0TAVlXbfly155+MWdtFl?=
 =?us-ascii?Q?rSYGFsyJADF5ZlscjoOWDD+LmI6Ls1M+bQK9dtlpzblnD6fkjZZuntTbRzMQ?=
 =?us-ascii?Q?h8CXmDI++wk9r3TIiwZBELADb4ptIkG7cRoifLxuN7UZWx3yKodkheqGdCkV?=
 =?us-ascii?Q?HgGPApVz86FMgKz93vl02oHWbe3U+rYEkkpmGLGoHQ3s72wY1bnBjhtMWhOO?=
 =?us-ascii?Q?qoLjUy3KY26MuKcaD/BwkgeumFww6lBQaWV4ZlptiBFORxCcKHiteaKHgqav?=
 =?us-ascii?Q?vBFNLhZ5qwaw7Js1FABDChH4Bxw46NXiKuI0Wy8jeu2nNIKJmYKnY4UBcgWP?=
 =?us-ascii?Q?OWFXfX1I9LxKqrrhrfAxfgUiDJO0ywu+UE1kGauUElUJnimrq6xhGAOPFZd5?=
 =?us-ascii?Q?IB/AiYBejlcsKOs6haPGzpBXRYmFQYsmXUMXYCTm2ttj61CXnLEny/4PPmNa?=
 =?us-ascii?Q?TjxIQiXVPiPorp35qpm8OBAXoBrzr24Lxa/oWIkSVEFlgxFi24EMNHdaZDe2?=
 =?us-ascii?Q?5GHjxLwyT7ov7+1nln3YfVRlbpiaGdjAp/0axYcOO9Qv3VFv0XRDNFPDgD/2?=
 =?us-ascii?Q?IgNCDuqzF5a2s7omavMcTBI08/chBXjIm3MPEalrOgXSsdzGsGy0hvt4L83r?=
 =?us-ascii?Q?BNHOmbNyzcDz0+A09qyqt5I8ac+O0Nmat32ezTggkWtydzSwp2oq8ystIxUk?=
 =?us-ascii?Q?6ECevlls6l77v0f0Q3HvUFpb4DVy5RTiRc1Tre3M02uZtOVkaiYcIDzzmPei?=
 =?us-ascii?Q?58TDyBzdgFMm2qGiGPN5n9T1pycPfbQ2QO0nuMc0rEQkORV+bEHL4LRpN5lM?=
 =?us-ascii?Q?DSebeHZsSu3OVOLTVok1FWf/v91unlzCClgRjgaIRzzWg48u9zPSqcq1bkj1?=
 =?us-ascii?Q?lF1RYBoCyHlXh5JJyp1sFzqESIMT87VsgfltqPWFsUHUx5Bho5QYMbRu5EMY?=
 =?us-ascii?Q?CMa+rnzluZoURzzvqatBTKyP/UwVJcDrYjFxjiPHRNT7XBu3J8X+J09LPwcx?=
 =?us-ascii?Q?Aw5z2/+NxH3DJgBLGHFqHd6nokg+D+CpoIEgjZji1PHz+5bM6vNLCueJGAhn?=
 =?us-ascii?Q?Fu2+UJxNX27/YD4wwwimzWcCq2RrjwJ6CnMgRispoNRiuAiRd298BarwpKpk?=
 =?us-ascii?Q?qZU3NJ6RfSFKVRygnt7KSoRiRlp53zXOcj1xEs+PjfpoE2dWH/n6tj/b1Otu?=
 =?us-ascii?Q?mNnQKYjyjr2wuDcWegray4RiIR+rfp2B3B1koK1//7pRMPfhpnI///X5sv5R?=
 =?us-ascii?Q?nhE+WAR0cnDJm5+d3Q+DYxpsF2n4pjS9r3OGmTQBQLyk+J17sPtWvteCTN/y?=
 =?us-ascii?Q?7EMMpAFyYn5Q3JnqFdm0FUBZZbVy+TZaIm2vzkzV01tB6sZXGAQdbA2ySnbP?=
 =?us-ascii?Q?raAss570H+DvD819Ce2CtTMhyv8bea9mqTICEj/nKASMa0K3vauSQryJoebd?=
 =?us-ascii?Q?6BZgoVUpTiZIAYTzBGIU1+cQd4PllyTb+iPnglI4lCR+Z2YWIx/9+iQ8MPKj?=
 =?us-ascii?Q?TePq6w6kmmOJk6jXjivb/XCDuRqJumSrawGHwH1U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae44826-d30e-49ad-6051-08dcd5cacc8c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 21:10:17.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AVdUZMAfxmhJWa1+Nf7vqOWKRScdeYBTcrzIYivsr+pNKdOJ+K1q20aUYuZMF4py
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8469

On Wed, Sep 11, 2024 at 08:39:57PM -0700, Nicolin Chen wrote:

> You mentioned that actually only the iommufd selftest might hit such
> a corner case, so perhaps we should do something in the selftest code
> v.s. the iommu core. What do you think?

Maybe, if there were viommu allocation callbacks maybe those can pin
the memory in the selftest..

Jason

