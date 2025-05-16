Return-Path: <linux-kselftest+bounces-33171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7450BAB9B8D
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 13:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662623B56B6
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 May 2025 11:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7C23771E;
	Fri, 16 May 2025 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="e8xEICxZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F930227EBF;
	Fri, 16 May 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747396664; cv=fail; b=ks5XQbCR5LskR4PALuSl0MGuiJx8gCVsmgA9cNS6pIcZcORuWqQKq8C6lbwbUyXX0zwZueqVZZL9pXdqpvHGa5oQT96PSpeDzKyur36GHDUEa3PGLjobAyeh0xFga/Tp3KndUESE1ruyiUvxSKZhP4Db/MnvwkVIElWdzbNTLCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747396664; c=relaxed/simple;
	bh=6ZH9LwDHTd+NrKsb3T+HwmFpuZtcg7cNBggV835aUqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bujomGt8Cs2P3E4E5Bq0EWlXmw/c9GWLov+BONAgZ7uFOR70ILxx1y7V9CmYLNe8L5+c6ibFiVxMNBrrB/S4s+MhlcPJXPotS/eUJ87VWQ+7UB1aOlvVt0H5n4jy0dUwVyvP1pf4k7liF1nEDRnzeoGt1+1NdbWricNuG4EbIr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=e8xEICxZ; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ncp3kMkzWXPl1jTptdOm4yiC/jWbDeiboItooqZFtvlLkJzQq2Kpw7tKv43BgZb9VWDCeMf0NcPi0/1H5lY9eH+Y35VFb/2dgE7kZhnHtv1DJn/1rRoV2LDAx7/5u5LTkgi9ol3Qtc8HTv0s4ZUf5S8lQapENH05cBfVx8zIJuaQG4bcxMXWYdpi17zOxpOuSo5nCJuVxEQQJFOv6j6ns+xSu114MC4l7lwrEdey1DLGzPDUtDCdPpz5G7c0NQ8DPsGnyk8ZAdbnr+EPcfK+CTu4qKpKMr20TwVymFzSoJiw9vmlO++cRtK4cX9QEe+IW6OR4Q9b6vcRr5e08nh2Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfzmp9F9q1zyVIkAvYvJ81YHdw4OFtDV5tTpyTn99tQ=;
 b=C3xV8hV/wjLFwmlwpKLfYyvK51djZlNOg+09laND2MykRJs29GbqY9xsgta/4w9MaeHIQaHlMXfPjUo9O7UEZYmTOd15eIgx9YTXrXUyRnJJRD4D4BudZVq1GrQJSlm0AABGQdNwdnLVJf+7SKggUmRYsAnU60SuWg61newTycGI6pYuEwhLRvFg5T29vFujAKC3ek/iwmav5UfK9dk6D2SQEQSdFocCI6XSNxWDwGlNdl52HNgdDhCE4r15EryyoKmCS3FMpMYdMGpgIfzucyUDmhYzOwfmI/VAug8t4xt3BsRJyKmJhti0GNCvH5+q2EYr8vTbxzchclf/k5L/2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfzmp9F9q1zyVIkAvYvJ81YHdw4OFtDV5tTpyTn99tQ=;
 b=e8xEICxZ3mBKBBkjbyU23DhzTfLFWjtyCfhv4jhB2YrW1VHYcogQifX5Pz80Q3242hGztLIgA9RtvFBbU1py3b6lIV4cM0AnJNsNoMLdZf3MXuzyc2WwmYhpk4EvaO64Bv4xNnP7oS+jwD6oNGQku/AoJSexR0tTWrzHHQdqjW1vw2GFcr3rmQ0TGSf/CadbnRQW6/rLDM4dMGLSAuUtbENjiCb15FL0uz5znI9RnZv4KLRdbxxLQ00QquV3R3v/uVyIlERDQ+cZzjaYfEPI/0stqTz5sXq0ghArUBNNNytSoJnt/SAeywlqAio6vyaC8B+SCBr8vhSr3xpcJqorqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8130.namprd12.prod.outlook.com (2603:10b6:806:32e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 11:57:39 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 11:57:38 +0000
Date: Fri, 16 May 2025 08:57:37 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
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
Subject: Re: [PATCH v2 04/15] iommupt: Add the AMD IOMMU v1 page table format
Message-ID: <20250516115737.GC613512@nvidia.com>
References: <4-v2-5c26bde5c22d+58b-iommu_pt_jgg@nvidia.com>
 <792fbcfc-430d-4d3b-aabe-51cfb6d689a2@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <792fbcfc-430d-4d3b-aabe-51cfb6d689a2@intel.com>
X-ClientProxiedBy: BL1PR13CA0339.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::14) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3175d3bc-cf46-40a1-dcd4-08dd9470dac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZVYjWH7YlWdjyL4jN07/qphQR8ehFvuIV2kmUBiC12oSOtsGJb6HebkE4PX2?=
 =?us-ascii?Q?MFHbwZGumvAyJm1LssNE24iElwqI3vn6W07kkTKrH2vpqm9zQpMVCZEvbUIr?=
 =?us-ascii?Q?EkM7lBbmXLdmKlvVC9SFtYldvQp6rHd4h+amALEk+L0XNsvwcmw7IOfDSUJk?=
 =?us-ascii?Q?k3Cx3LFwcbPDknrvYvqF45g9OXHMK6QdDlWnuJoTa39l6jtxI2esZMSrt9c3?=
 =?us-ascii?Q?gw0FNP5p+DhUzddlaPwxWqje/I+O2192EiHGz7BtlPbzBRCmj3KyvOSs21hV?=
 =?us-ascii?Q?ogPOLCAcuvRoE0VUVZE9vm/sbkD6o1wAL+fYte/VkXpG38hZkg03mJPSABEi?=
 =?us-ascii?Q?ohb+NlQncb8EEW3/+cD7vls5oalV7L8l4fbL4K8dWm+a39LBqJDksMc/9LH5?=
 =?us-ascii?Q?coJqhuDW4eXwSze/vu4BdgdwCvYMCEs3PH7OcWRtGn5gyryV8PpGOlHjFKsl?=
 =?us-ascii?Q?VgDoG/6PU4VGhr3fWYS338Qh/LhZSiWgZdjHzQLPWF4EiGIYTSzeQLNfS3WU?=
 =?us-ascii?Q?f6s+3869CKnnMkvVhOtz47aNkp80rep2Ef3X/2vNMsUZ/sA58aF3dq+0XXt0?=
 =?us-ascii?Q?afp4xNXtEZger94cGpxLIWEmUP1YY8V/fBSOmFWhqNnkTBq+5hT9Q5/Um1dM?=
 =?us-ascii?Q?2hcsBa8TVyPq6qZGrKE9Rw9UbHxw73x4YZ1fJiRgr/JdsBYG6LrNDy+1aq0N?=
 =?us-ascii?Q?6s7Vy+H+vWvq8s17RG0UWD7lVOkfn0fckYVVnd+/NblZZ9Cc7dJIDx+KnJ9j?=
 =?us-ascii?Q?/EEpK+qmYQHU1EN9cpWTCtPfenQ1tcF2nWdrYShgOw3TAl3yFnObLSpqrdad?=
 =?us-ascii?Q?O2+lrg8Flb2NR9gPQmfrzFuVCtInrmJ5jnQW9sca/0zFqk1uwPFjVbxEwJTi?=
 =?us-ascii?Q?2ESp50l+KwaHLSbd766U06pk+SpkEmJEFjfmY49xG5OL5F2+unGrz87uYfLP?=
 =?us-ascii?Q?BRLGUZZQuJSnzsK5lPgtN5CatNDeDVl2Xx2HNHZ0L/z9y4HeXOv9qipXR7Cq?=
 =?us-ascii?Q?sZJPdwsGFSNdqq8FyIG4F9iQhlqXiCERQsVKZAddNmTm9Ifu3J9/H+wuuybg?=
 =?us-ascii?Q?K5+IZMjsZLTJRyUeJ6KCecSZM87tpUapsH7iWc7Rb5djW9eAePt0X50Fg4/Q?=
 =?us-ascii?Q?R84BDyAKANMf5Tr1oF88toPQoDFqmHkLGesjLxs6mVwpKOhqSmFFjLGnEGiZ?=
 =?us-ascii?Q?6sa2WXZ8l42SMLAlbkBZ7I1miGG+Kv1TspHC3R9S6sO81t/cNTFtIePIvYD2?=
 =?us-ascii?Q?tVbRuWFfIyHGKnPYtjkhZJs8ij0RjapsusvmJlQ5t0wock8QmyYI372qTxTf?=
 =?us-ascii?Q?0/55g2FKbNLupeF3A70XRk6kGuz9w7iifBFEXgzLJ7a+mLZamwPEJH4Shgw6?=
 =?us-ascii?Q?iHijdv/NqlAJWYV+PUKlt29S1M4ZBN4tA+PDpJTKWyleAJparwNUCpJWG+ZE?=
 =?us-ascii?Q?9LdjzI97m1o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pX6FdpVEcDrSjCE2gEFGp14xC/nDfsrmi+NIIO9B1tNYe9Gx1QjQST0QiyKR?=
 =?us-ascii?Q?USZ86XRwJUKbFhWl2zFmpjHL5oqXZ9j9Y2BCV/N80M6MSYuFdn0cJN7152JK?=
 =?us-ascii?Q?DUTaKXSbwZUN4pGIs7XWo185Ricbj4oG6d5JwkW2m0B/VWltKOywp6yB5lax?=
 =?us-ascii?Q?pnn6T3ol1uR6ZH2gzQJTYmIBsSgE77Vqv4vjzSCvf6cJYh3wLsFufG3sLGNf?=
 =?us-ascii?Q?Y+6w0wCl9YLvxdbB0Io06w/9JoLjL077johOAo9orHsyKvJyhAtB3PnmvDhO?=
 =?us-ascii?Q?jV1d/H9EO8xlR8q4yOPma/97ftz0BQ0XrHi5dyD+fcTcphM+hu8C1513J5hf?=
 =?us-ascii?Q?UiivJ5u4IKQTdcb/SEVBsIwvlNnstIshObEIUO8BajvJRCY9cFCKZ3D/WDrd?=
 =?us-ascii?Q?5ptF/V7pDc4WvoNH0IocBERvQA9QiHhdZW8lhN9gqzjbPf1F/ZGPq99H4kYm?=
 =?us-ascii?Q?rGI3hMA9V0ppUoiRv1X+QSDHzYpUdZIJM9ClBqXEghNUeU+ZcZDv3kX+IhFP?=
 =?us-ascii?Q?wm+4j8VCnYsBd1zXv0zufyLL5ONrRkTJe7vsKOZ0KW+gHO+uSZmyWJEIJQsf?=
 =?us-ascii?Q?ndCvETCuULVTp13B8bs3Bwr0znbo8ckTPA5syM1Mlf/I/BEfXpZATqFz9pBa?=
 =?us-ascii?Q?bCxQL3/pvPS0mhkTK49D4MJpfUc7HD2vi/IS8H7B1wU6qFwseqeXeIon+c7A?=
 =?us-ascii?Q?5mUFDoN09Md/yBIYsxa6azCEk7uh0f+ogO8XH6ReOFofMbn7F+y+ryMsmyTk?=
 =?us-ascii?Q?yvdC2+YdCeiN1cEq3/SiwzY5XVSzI2/r5e8SQL69ZpEWUM+vGMC61m0HpaUL?=
 =?us-ascii?Q?RHM9ohYZ6EUacG/VLnWerWkI2KTTQRa+0J0hYMmcHz/XK7+1n0U5TJjemV4b?=
 =?us-ascii?Q?SqNWBalWlw8V9zxbWHtfhc5Wjx+XTAoFC2SdYbLagfUqPcUrD/TRSWws+p7L?=
 =?us-ascii?Q?qtidSxe24OBn+57JcY1aSeLpYnPxdnmAEpJcmoKoHYWMbNesBWmbU7a07cNC?=
 =?us-ascii?Q?S9y0EaFfIM1NZC9fa/SpD6a+vMiJQ7lkOF2wsWRap0Gnz6H4PvJjBY7sS13T?=
 =?us-ascii?Q?HcrHISmui7/YXve+Xbu5jBDGpD4gYal2HRfRgnQDakPUOOONBaNLZN6WRFTI?=
 =?us-ascii?Q?C1Bn9LOF6ynCeJR0GY5/iKfS+eXBhP836VQhLQi07sdf8xIg8bIOdIF2g+7T?=
 =?us-ascii?Q?Z1cW8TJX66Qgua+LHfbG+VlOF4KoRIgfKGKboVpLK3YEdJGWL2FeJstLVjBK?=
 =?us-ascii?Q?eeB7Bqg3ViVD8XwFPb78/Jk+nEE39I3TfNseXNAuq+lw6c4LMwYP3FpjzWCu?=
 =?us-ascii?Q?LN+E+7maMy9wlyS2Q320f5O8Un+Uu/RvT+xUcuNfXGinF6+NL3d5b64h/Ymf?=
 =?us-ascii?Q?zchQg/4pzW+TK6qGln9JsHOpVxToXUho1VgpoTSi0btq29j5H0RS6GCVXWAh?=
 =?us-ascii?Q?zWedH0OBxcbHJedIABQTP1simk43kjCQ1g0Qh0rHcRDxeUT2bCyJurKpn2gw?=
 =?us-ascii?Q?XaCR6ZYKYPUALepFCCI7ztXE+vqOBLZAj/+vYG15fshzqIXsxFwSxZKHTAiJ?=
 =?us-ascii?Q?fm90e6aWm+9tvcApOLnxXctENP5IAkWnfLC9iVHX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3175d3bc-cf46-40a1-dcd4-08dd9470dac3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 11:57:38.7105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NpHtAMqt8Qil8DWXkyUfXczXcuEd5F6NVdmEJIgphSJAO7L58KyIDr/QGqHSSXC1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8130

On Fri, May 16, 2025 at 04:30:23PM +0800, Yi Liu wrote:
> On 2025/5/5 22:18, Jason Gunthorpe wrote:
> > AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
> > and it can decode the full 64 bit VA space. Unlike other x86 page tables
> > this explicitly does not do sign extension as part of allowing the entire
> > 64 bit VA space to be supported.
> 
> aha, do you mean the canonical requirement on the addresses when talking
> the singn extension?

yes

> Actually, VT-d 2nd-stage page tables does not require it as well.

right

Jason

