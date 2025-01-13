Return-Path: <linux-kselftest+bounces-24399-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19777A0C12D
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 20:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24BCC167DE6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99BE1C54AF;
	Mon, 13 Jan 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jwUM2wZF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488BE84A2F;
	Mon, 13 Jan 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736795903; cv=fail; b=RWYrINHcCY1jMrB8DvAOBAOwij1WPZOSEDFk4DCQQVB0sCSlpX1EgoVl7+0hC/pOhDEQVtaltAavXxe+OzD4WSaW7jPTNGAHwPZtTN6gvEFB78zpM+xGZS5Nc6e0KAAaT0Tcqp5UZZEegbXSX0EHW8EiC3Ze9HRvgCLaz3ke784=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736795903; c=relaxed/simple;
	bh=y1a22GJjB6Y1eNJsNdVKRQolyhdf5jml+Has+KKul6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AdmHp9bXzj0Zhp51zrQiMGdpPlbzRnA9HtHFhd5mR/clGEemAUFunrmHRuR6IH8BCEC0LBlEhwlPk3QuCpuSz9SXGgys0GRtkcaru9tOkZSkZAtQACCb/H73RB0GCwdRb0Wu6u9vO5N5wWqfbJIMKd5srXHSM9VERHUAleZV+FQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jwUM2wZF; arc=fail smtp.client-ip=40.107.212.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lzx4T/h9s31pOk2qRiRoWA1F2QVUAlWLQ69nRG+j7klgN/haCDMJKVNglZAaMtBo+62mwp2G6qMhzO8xaQmEY/t682wyHAXUOIz1rVkSJnCx5PMp0vqEh2VqVEb+cTy7EQkvAcT+TWVK4iKIFypTEpbLTJpmUM0skORP/VxLiNRC55P5lwXh/ImDnKd3OPAFutLg0+FLKUu6ow86RPniJ1WL9VAgCgBe6FMmkOgy4+11X9BwIgKM1Exu++MroudV698hkIFCvvx/GWcmI3hJqZQ9/CQD6/HY+lZ8qpWc5ASsv7L8+/jfOqZynUtqNZkZhAjiOYyAbRiAODivsSsVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gkkx2oy1c+EKwRUASgngzGic2tqFWtNxseH28JSlWQQ=;
 b=im3R7e/ArltkJCCYLk2M2L0wW34DTw+OXJUZRbil1M40R4hIVoqP2DvksVqE2rJdm4ju9sENt3LvcqFd+oxwM3f9SnSRfJmgc2VI3Hs034L89sNQSFsLD/Dlqlm2izgIBL2XSExiZv4ywjMLJ6LM3Nl0Wuc8GANCQid5ZlhQScyCPGYEKBw7ZUuOW3rB+s26aVWMnb7AmHy+xLD+NJyaDnPjBrr+h37CW2N7dMM1e0jp5vCYZqIUo0pqFOJkckVj5ZUwzFN9BM3cZvnVHFa3VUdEJu2usEMDgTLFw50glxdr8v6mctWgJ+W+w2ZPa6T36koi8x6KpigAOJcPqTau7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gkkx2oy1c+EKwRUASgngzGic2tqFWtNxseH28JSlWQQ=;
 b=jwUM2wZF51MBkTOoAcP8CC3ubNR7fkD5wkK4UZYAz2EJQjXOufLOROSATWY0dum0WffDq51URrcIE9OevIePS/YrYTFamIZCbOE8CtMlFZlFWYwbrdL+20lTQcboI+3iv1Q+IiyUw5Lhc16u/SvQxFf33aGg/8Pyhc4/FWbMb1s5xz4A05H1A02TII6V4Jss4SYUrVFm+mx7PCMIWRVSR3Kp2zGLJN+wrkpccxty6f7lo9+cxz5RXGHK9uYPVr4jk8VtzRQM1UQNbyQ6AbjPQ/pWvL01bvIJOkl7MgWVuLNqZrkXdjjS2DN/qKlLreCE/QbNN7S0sFNBL2ypnpVyVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6091.namprd12.prod.outlook.com (2603:10b6:208:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 19:18:19 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8314.022; Mon, 13 Jan 2025
 19:18:19 +0000
Date: Mon, 13 Jan 2025 15:18:17 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, kevin.tian@intel.com, corbet@lwn.net,
	oe-kbuild-all@lists.linux.dev, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	eric.auger@redhat.com, jean-philippe@linaro.org, mdf@kernel.org,
	mshavit@google.com, shameerali.kolothum.thodi@huawei.com,
	smostafa@google.com, ddutile@redhat.com, yi.l.liu@intel.com,
	patches@lists.linux.dev
Subject: Re: [PATCH v5 14/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <20250113191817.GA540878@nvidia.com>
References: <03c01be90e53f743a91b6c1376c408404b891867.1736237481.git.nicolinc@nvidia.com>
 <202501091822.4ocbIobQ-lkp@intel.com>
 <Z4Vi9raM/lOot/SQ@Asurada-Nvidia>
 <20250113190641.GQ5556@nvidia.com>
 <Z4VmST8xyAluL858@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4VmST8xyAluL858@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR10CA0020.namprd10.prod.outlook.com
 (2603:10b6:208:120::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e26ff1f-bfd7-469a-09ca-08dd340709dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rCzmnPmIX8Bh+lH2MsvMuHIXsyQfmVsb5vZLn+c7OLAB8Jkstt/5b2HqIAk0?=
 =?us-ascii?Q?1pg9cx4WZIVtk1MKIJVaKJPIlM3DjbHq3KgwSFOdwYI5+uw/Lb179XheGVL1?=
 =?us-ascii?Q?Gv0dkSfRBvsFo5yrbBXqQegptXx0oobmTKhmWuJaClWJMAvG1gdzwjagt1k1?=
 =?us-ascii?Q?vc1nVy/7vovI0n6IsdZQK9QEPy28qRPin/a9xPMEeofxeT5gtgB+/AXhRNlg?=
 =?us-ascii?Q?NtFH/NIu8TZxZfLOLA251kcF3ZNYshf/lNKrt98n4OaiaG31VDKSCL8ayHqk?=
 =?us-ascii?Q?KE/58PZfjZGtiD6dwjSFXKBEdpXoLWfVNCFymCnJ1xlQID4wxQ4lpxhHYBoh?=
 =?us-ascii?Q?6yMV7wYXVlNysdrkD6aotREQGqoajvosL/hfWYy52uPJyLyxsZtSfcMpVVYK?=
 =?us-ascii?Q?DTEnNPaDJVST99skNuOf9QSxvsZ8j2FRUgGwf4tH0sASv31Em467pqdM+Kmj?=
 =?us-ascii?Q?GASsK3TXrNp8SERgP06uvMgw2LUpeLA2V2UctoscFh+qWvppGHajbLXx2QBz?=
 =?us-ascii?Q?wUmTuYFwDuHQ9rQ14QFIfw8a1GZrAid585FjmNQfK4PkpwoSTGOeBHWczuf7?=
 =?us-ascii?Q?9CPLciDNOi+CfazbY0CsV7GEJPmU7ESURJDjMPm9V3p6+xKISq5pns/IgGcB?=
 =?us-ascii?Q?rWPKTWedgg2szcAmnoZDhm9tOSORDsYqcodxA+jQT0PYmVsG3/mdFdwUe4IZ?=
 =?us-ascii?Q?iPFvRZ07mM7B33vREDewUw+sphpCUDFYdCtlFei5QPvWgWcymE308z/7hg2X?=
 =?us-ascii?Q?gWSqQpifDl2msXRVHfTkkgAgXoU3Fyf8OOpiOr4SoFjCtJFQgI27A8uEpC9r?=
 =?us-ascii?Q?rqQCOkZggyWa8iMYM+DHEeDK5/VlBujBP+cQrJCnsJuuMgjrzqmko32IBRJE?=
 =?us-ascii?Q?Em4PvM/qmf5KwBKsEI81gWYf08YkjKJNOsKrs0E+MhmC2PmnXTR8Cj7k+sF7?=
 =?us-ascii?Q?SpCsdOoFdz+SzulZlOO6UMt1CZU21RGTv5npFbfNY71LLLaUmoaeUlxKGPVq?=
 =?us-ascii?Q?jwJM1OP3RZV3Ar/KCrka869eJFxrUZBbP/4YM9Pl0k1+OQc1QwnDJVfXJSHq?=
 =?us-ascii?Q?oRP/plWYjtDhWUrP2XyZsvzrjRlDxw/57v1uR3d/5ch1n/JMfIEeKfBaHVlQ?=
 =?us-ascii?Q?gyB7Bvwbtq+JS14YsqlAsOy8omcfdaqJLyAFVKe1tga4DSmRQQesxvuQ9qp5?=
 =?us-ascii?Q?rksp4jK+xfVVdlrlSELcQRKXGYYt2HTD7O8UtdEqJzLQccTZcG+N8Pv1nP8e?=
 =?us-ascii?Q?+pinQF6kJsTO+P6IAJ4kMRyqNy8S3f20os0csI9KgTbW7SUn1+tkYOeSQVbv?=
 =?us-ascii?Q?f6VDScRlME2I64JIEEIevzKFodXPhd52f/dUyCaBbpbC/Ktc2FDExbcr7Il7?=
 =?us-ascii?Q?GdV6M3iNIgs7Q/ectETrz7eqmfuh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jGOrOmnBJq2aPWWeKB2/TlWk5WBOs9D7PvJkHU1YEpZwrPPPXGKWSFSevkdC?=
 =?us-ascii?Q?lv+7lQ49duZG9UPCtQ7VOGnBtFYXLbnkf/zAX+1nmvV5gVp3QaqKNOw/HCu8?=
 =?us-ascii?Q?nBE9Xlqqhvjfj4U2yFMO8KdVY50d5R0Uh6ke9xWV7vgXMl9SGqmO3khqs/Z/?=
 =?us-ascii?Q?F6oY5w8yqVyLtikdTtpgiKpu95HIQ01dwH2RmNKsemSUwqLjbdO3e354LgGB?=
 =?us-ascii?Q?ePQmd8UWLbqdfJwbq+nOxJ4yeit1ThOAD/TtyNX9JzX1G/mWmpHhec6CZGqa?=
 =?us-ascii?Q?otYfwWGisyRvW/X6PR5nI1vmJbiwohEcmHPX5/jJZK6vFjnM7gWWnon+LJb/?=
 =?us-ascii?Q?zjkRUcWowRtp1CZjgVDxMExHoWMDYCX7rOVRsnYyhgOhaiWjBNPrM8ybu6Wy?=
 =?us-ascii?Q?PoDGIJz1r6Bo6fSWIGkYLBN1Fk+47RDCBu/o4FiaZbCN2sJF0uqVdEUHe5AP?=
 =?us-ascii?Q?rwW2Ot0hySiLRLZjNLG5wzNAU8YJTjD+IExfcdKPJzMhlQ5xlYxsblILVYad?=
 =?us-ascii?Q?bsCMVAB70l0Q0Q7OuOD9lnRM0apZ806J5khBQRkQYjcZ/wWEtZXuhDTlLOHT?=
 =?us-ascii?Q?OqLgXQASyyWPHZTZyOzM9a3u5rSOzaDb+uqva+j/la6VkpRkD3GicljN1p3E?=
 =?us-ascii?Q?+8pEJ+brWczpd97pq8PdnJY3TpjVM5H++cZGKkZihCTEieCazx68jadWo3dH?=
 =?us-ascii?Q?bSb0h05Kk1AFWS04Ko5r2kyobQFkEqV2LeQpRSZ76ho+PiMvLSVKPVq1bMXY?=
 =?us-ascii?Q?SEVT5Eq7TjYyXAITbIZ+NL0DfiHVT5QCf6rm0Z/Oyjc2n7JsDadPycmrVsY/?=
 =?us-ascii?Q?hPC+ndv9O/rlJRMz/+sqE18NwAn+um9jY67PYie9EX6emezTXjgKI0lx239q?=
 =?us-ascii?Q?EvpH9VB0YG8tx4t3sij38K+YS3OSdpEsz+hjkz8OjguhvFYNc/6lJlHWwFut?=
 =?us-ascii?Q?Kv9SU8bXN8NLegmh2j6sIR++dZ+S/61AytIgfwVkOxkClbPxuQZ5chWt7cy2?=
 =?us-ascii?Q?sqhCQwFRP9opoLw9JKXYUNKfoLm41bubzYIKhsOVi0USjn0fND+/S10Wu37n?=
 =?us-ascii?Q?y6ewhm2rTZRMaMzVgMA5Y3YKJ8ZmLxzYgNXi9rjZ2rQ1dITY8vK8wMSdDUAc?=
 =?us-ascii?Q?a95mecUxrgnGNH9rnkq0K7SiLKfoB2NxjgN7nkIHqJqexfGlo5EqNKHAzJPq?=
 =?us-ascii?Q?mgHjHOULnIaKss8GAIZXx10qVjgZ7omC/1XnGTDmdnDXKF4K99ojSPUMNyX8?=
 =?us-ascii?Q?AWQckiR9kdRvaiPhlrpHKYuI/LaqeM+Pe9gOTmHarXLX2W8qQlqf+uHk1HWm?=
 =?us-ascii?Q?xqX//iqpDc2sDpw19yzjOuFKlO0QsmOLAresFzNLhrUwjst5xGTNMlsSQRnf?=
 =?us-ascii?Q?ku6WRELQQEj8kL5rze4XMRY/56CfMgY1oehilR+1El1c1RDMbN3LkmN5zh3Z?=
 =?us-ascii?Q?IzKMTi8hXqhWndSnEYgwQ15VBToWwXl7tcQIky3j4KtlXZW9virEfku3DmbY?=
 =?us-ascii?Q?1XaH2AaAES1G8KFIkY59Qn2M5OMZmCrZA3mZXVKSmlhtx+2Xobq+W7gj5iVn?=
 =?us-ascii?Q?0ivafjoRPIjdwlAN3JTuT2lW0g3BEnJARLITFZRj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e26ff1f-bfd7-469a-09ca-08dd340709dd
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 19:18:19.2661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xe0eYyHTPxzV7n5zAfz1dU1NDQhtZdAdX9qZFsv48VGM+mJV9/yfEJYNqsdHkiiI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6091

On Mon, Jan 13, 2025 at 11:15:21AM -0800, Nicolin Chen wrote:
> On Mon, Jan 13, 2025 at 03:06:41PM -0400, Jason Gunthorpe wrote:
> > On Mon, Jan 13, 2025 at 11:01:10AM -0800, Nicolin Chen wrote:
> > 
> > > +/* This is basically iommu_vevent_arm_smmuv3 in u64 for conversion */
> > > +struct arm_vsmmu_evt {
> > > +	union {
> > > +		u64 evt[EVTQ_ENT_DWORDS];
> > > +		struct iommu_vevent_arm_smmuv3 uevt;
> > > +	};
> > > +};
> > 
> > This doesn't seem right, don't make unions like this
> 
> This is copied from the invalidate union though... Any reason why
> this is no longer good for evt v.s. cmd?

In that case it was trying to be really optimal and copy in place,
here we don't care so much..

Jason

