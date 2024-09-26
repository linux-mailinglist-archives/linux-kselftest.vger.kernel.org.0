Return-Path: <linux-kselftest+bounces-18426-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9846D9879E9
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 21:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50E9F286E0F
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381E184554;
	Thu, 26 Sep 2024 19:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fOFwQoSf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB3B17BECD;
	Thu, 26 Sep 2024 19:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727380726; cv=fail; b=hlVtZvRK1jcuj0P6p8LmbRUsbOSlizOWk4c9fOVP8O3G7uHzaBgFh5mED0HXLeg8Uqpdj45D4N8Vdy/KeQRw87svoqvt3GsUsRE3iKS4UeR40porAG0KjR6oX6/Ar8xqqxIGersSJvDn6xyofDCgpnoEU4q3bRPcWqNs068RFaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727380726; c=relaxed/simple;
	bh=oQCPMQawJY52WbJFbS4/KJmFeXvOGHC04KhlsMG0CQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DIj15UExxFSeanPqIOwc9m6IPki93cnroW15Jlf/VAKb4X+SsWWHmMOgiw4gkZjMyMoensIvCkWs+uq9TCyRh7BwpdbI9VhZIyY2AvTdj9zzj1jAOHe28DcuvmYeV6esHpplCqkScFPjeMtcXurfrhjxv0DaaGLYYzLi/xbPxJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fOFwQoSf; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CkYYzMUvc0aal0nA59n8fBqZ/JD1t3RiT8+obiaJdEC3dUid6AIrARDb6E/Ya/cZY9FzmDGmNdutB69Gd2LZC1RL8H55fNQYMSqw63rzE6E9eZ1Y4f6nyJIS8cchPmfRmQJebx2lT/RgPmxNk+VbcYUU3isVoj+utJDC3Y5R0Xfr6/90ubAWAlO1BeR4Zuf2EyCrNhGlcZpKUmGZsCQ2nhrYsvLoFXclLQB6igMuHELX+tS3ee3ghLLwnOyUXbCwWA/5ettHqzjHZY+if060qHjvMur6zJ4XebcWSdX52WAZxm1P74FNM934iQCuqZdMujVtPFQbsZvbnSdp/r+pRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RC6CFWcHP02YPlRQny8dgQZto+WcfIVNpALkOQegwYI=;
 b=AoNGNr8QyQ0WgfQAsqnemnc+fBM8YFcmYL7ygW4vDVotwAXXJTluVQJxQZZSrw7x7GcAQ41TpEBH6B8heYxU3omGDERid2BNh0FbgS2GUMcyKPcp1N30qVnLx8LwCr3SJDYnCIdP7Eo0zt50lP1fEfFGff/jQcNMBHdeNmXbpdFnzr7VPmjsZ7SKvIOR0PU984kZKg9d8heUzeKeJ5Wj97wHBwEyjjnVoP5bwjI6C0I2cxweKtISYRvP7Ohl/m9ziW/Z3+TIF9iUwQG0Rkkjt0QhgBnzt4IIPv1V5w9EVJNucKku0/fsAgXD6zRy674dhGVAuKUf3jRk+sUguFKAMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RC6CFWcHP02YPlRQny8dgQZto+WcfIVNpALkOQegwYI=;
 b=fOFwQoSfyvfPjJLJ5GJW8+/2+2uPcLCazYHkIO3ZWD5CUjYvXFhkVjXlbryl4W+sQ+e8pbILd8eYkvUjIbyauBPLGQNhvVchwSEpyMtar1xxpU0WdTPwcnrxVe45eSAsTKsm55ghdO+R2g+zNQRLrxIk4eXnMKj9Dld08uc8W5qA3vjZTzZJ+X7xUptXAUNHH2okALgudbaw/hWDFXjK/JcawWoKkgJ3v5HMQ7HxAqNTmmwFKfgHuJ1guUNJ/khSMwSBEOMxP5OkUfFSJQFUZ3T9P/snhprEiN3cR3Pbq5Yk36j1u+qOCRGf1JsjwSfPFFJ9KL4aEMKU3cVTfzqrNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by LV2PR12MB5967.namprd12.prod.outlook.com (2603:10b6:408:170::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Thu, 26 Sep
 2024 19:58:41 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.7982.022; Thu, 26 Sep 2024
 19:58:41 +0000
Date: Thu, 26 Sep 2024 16:16:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: joro@8bytes.org, kevin.tian@intel.com, baolu.lu@linux.intel.com,
	alex.williamson@redhat.com, eric.auger@redhat.com,
	nicolinc@nvidia.com, kvm@vger.kernel.org,
	chao.p.peng@linux.intel.com, iommu@lists.linux.dev,
	zhenzhong.duan@intel.com, linux-kselftest@vger.kernel.org,
	vasant.hegde@amd.com
Subject: Re: [PATCH v3 3/4] vfio: Add VFIO_DEVICE_PASID_[AT|DE]TACH_IOMMUFD_PT
Message-ID: <20240926191625.GM9417@nvidia.com>
References: <20240912131729.14951-1-yi.l.liu@intel.com>
 <20240912131729.14951-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240912131729.14951-4-yi.l.liu@intel.com>
X-ClientProxiedBy: LO4P123CA0168.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::11) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|LV2PR12MB5967:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8ff4f8-673f-46ed-aec7-08dcde659e6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FgvbHcDQRmNt5Qz8Onk3E7SkURm3tzd2F/Yw6u+ELge61ItQRe9XkXeRPHjk?=
 =?us-ascii?Q?Eu0OdJ/ZyCOgnHhe9PDObhUiR31q2otQAAKeyN4rSZzdu3o38yGCENCYdMvM?=
 =?us-ascii?Q?QciQxiOFOCo9ufQ/v80+U3pPyA57/hPHLKdO1JyfILBUtUOL1TFWR/ngQcwJ?=
 =?us-ascii?Q?8byQBy5LKm/fu1VzZsqI//eRCTRaEji+jE2lAqXaph4OuX6x3w37nsdiHqRu?=
 =?us-ascii?Q?756A7c7dfYQQzIBKp4UNnnLsQsLuMHaxLReYj3c++0TUz6yJLpq/uTwsuvsm?=
 =?us-ascii?Q?QQNkqd4Hrd8Emhtg0uld6cBZuLyRqQIpKsl8MRo9zSHsf36Arnm7CFTQAs8K?=
 =?us-ascii?Q?FtparrAwLgvJKAkKRYsxROR2KP0MWyegbGsY+TOcQoZEfy2cjaTJ/S6XJbjf?=
 =?us-ascii?Q?yWQWsgMp2MadJxa8jcVGRtaqaNecXShmPmCsnRQqX2PCuSjFzH/+IvwMS80x?=
 =?us-ascii?Q?jzwQsmahUmUzUZWCyehkzR05rEFHZT/nTUR3vCcNh9RdMGjMU392excRuRty?=
 =?us-ascii?Q?wv8RO4Bx/pqgeODMKKyJD0pC8UuE/toTmydRSVRyVUmmvBygy86mpq2xI70e?=
 =?us-ascii?Q?zMGR1V+GcqTmScN/deNpcFOq35Ze60Vv+NIt5BZagYdFOyBQG9OSVPASNZX0?=
 =?us-ascii?Q?qO6qPD9ZFiRMe6locKMU9BO2Gb328ttVVbZtX9M9o3XOIYghDCUKPWoTn5hD?=
 =?us-ascii?Q?DoBjB2Fjlb0Dbmf1dtw9CjH4PR7s/vpUad5sHrpJD5V66KeX3TLBs2W0wX+3?=
 =?us-ascii?Q?TnAVMAvtR9KZY+61OBHAd3Ss7AH6HvcWDtMKMlvUbgg2tRdh5PRiv5m6fsOP?=
 =?us-ascii?Q?WLDTmDP4qOkcuJlezxwxnzONo7h/cEA6VdJvlbZPoGc5gCwWItBMv2Q6Vdy0?=
 =?us-ascii?Q?HjS5V1BwPr4jXYoX3BSfVtOSx8uS2ftdWDkMUykRDs6HGZkYM/CtgNiNuFqu?=
 =?us-ascii?Q?vkKq5bxVowG8LSqH1EpS/jtcIZXa//8pJSjawO3g/8PLvje7joGSMrEYK4Ex?=
 =?us-ascii?Q?3dF3Mp5xvDueSmjFCIyxXmsZzfGeTzOc9LG8JqPv8tFJNBVkwwJrHWtZodPI?=
 =?us-ascii?Q?lLaE5ub1IW4rUHQvIyBisTIitHWX/wyY0Q4XqhDFPhET+oYePb4wXLXz1xFI?=
 =?us-ascii?Q?FNSYuDQ96AtVCBl7k8nNPEYfCHPYQwX40jxA5pIn3t7SdSHNDweNbYqAyaJ8?=
 =?us-ascii?Q?FFyPI/ewoequBURVdKA7H3tyOlJJT7H2KXQUWPDRiPhTiz3Ob8O+CIYYtYk6?=
 =?us-ascii?Q?jEkRUcIqEyW15sQ6UgLuQCNjdFbsPACfHGdjErNyzA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VA6/gr6hWdQPY056+HKp2sHz/aHJVXxjN0pU2mrhBUTPjuURE36iQkBr44Sj?=
 =?us-ascii?Q?85ytudO1QVSWR5v1Tw89qVd7LfW+kRCp176yb1LYI+ZLVy7Pp/2vgT0cRclO?=
 =?us-ascii?Q?kw3rP48rOYOa14gGDgYC3MEntCpwxx9L5yCHO3LslXDjs3EFOY7Va/wor6wp?=
 =?us-ascii?Q?5y+Fp6kKAG7oQbMTumcduTnacZfhxfDe6fCYzoqi1qxqGbVsZVejHfSN+L20?=
 =?us-ascii?Q?HFhpm6IPTaDigtUkDvjp9SUAAclGhp9ga5GJmPpnfJurplABRJ02OXfHVk0I?=
 =?us-ascii?Q?nqrXVixgS1ODKpHpje2sjoR8tcgmL71xfnf1LClgm/z4zvYJthGSNVqETPbJ?=
 =?us-ascii?Q?pXdoek+uXLy6cjgM6fEayjq5brilR1eFVkAL0iy5DoADdHk3bjefogttVoUL?=
 =?us-ascii?Q?3DWYXGLDRMh4IJAv1uNjZCICmfacue+5dmaSi9O56eaITEM5uL1uwC8GxPr6?=
 =?us-ascii?Q?DtLBAOavCEQRTl7OHmSaELZnAfWvDAUzGARVmE90XH4nbmhtEFlwcjTP+ywo?=
 =?us-ascii?Q?J5UPDERnC2mZT0InA8l1t3ODNwAc4hWns2SCL9MxbpZJt3sRpWXtn+IlZ+rd?=
 =?us-ascii?Q?EeKtMMhBa5SC/n4Hz/vVznIPQB2zoqU/WWOs1iW+0bLXvHECK/GBMh3avXVm?=
 =?us-ascii?Q?OPTk5fGj/zn2CPdt0DlycSTj6x4GzkPi2SKz8VUtOqFDRWkphBtm5jXq4N5/?=
 =?us-ascii?Q?UJGQot5YPQdFo2w8hprFdzYSNiKCc1lQY5UAv7f/RMPw8gS/Ot5Xx9r6A8Q8?=
 =?us-ascii?Q?lTQlzOPIzwhSI9tYRUlyG0/EtrzwKS3xvPm72DOwewMMRgAJIl9B6At/yN7r?=
 =?us-ascii?Q?PT9CLE6rD9M/nPbgD9dRfcn7g0RyOzU7In/L1/QO6ltzQ6QVPmbp34nazjau?=
 =?us-ascii?Q?CWDheWofDjykDyxWElKDVmsbPcqoXtjkLNrOdoTOV6x8NgOphvOZF52FE1AI?=
 =?us-ascii?Q?lbigqLLyowqQJ6H8nlBtQjuWtvtIPV0Yes4OKz8qck4AL3i2LLc158HY+snA?=
 =?us-ascii?Q?4e6lluHWWIaumC5tmoH37QbWtkYgCnIRnO8ugfTRzrFKIDnFj6S3IaCEzQ4j?=
 =?us-ascii?Q?GnkH2hAtAzlZOPsce1gPU9A3Tn3uGi40dnEipTl/pe69rW95OL3Qs40l487Q?=
 =?us-ascii?Q?rA4AsIvXQWDq2lEzW79onAKqtfg2VoRblwgSKP3B7mfw1ACSyuQbipWlpBeK?=
 =?us-ascii?Q?LKCfkbX3TsMZzhx0p43qSk+JRJaTM1fjMLimTr77w38pPRamr5KeX3Lb085+?=
 =?us-ascii?Q?05eijeka/1sTHvwrzW52Taq+wsWzadGbivNvu47+rZAFUOJfINrN+ABRkwE7?=
 =?us-ascii?Q?NLtvqkAsaUsnDw757Ph9bhjQO36G72oYAh7nTxUlczD6pFZ1DgiZEp09hflc?=
 =?us-ascii?Q?O8F7MrBjjvTl854GTdQxh9LBIO4NjCd80iMWrg9XPKeS8Qxjy+h21mgetvk9?=
 =?us-ascii?Q?4djJfd7XETFvODAhE3LA3dDp5tktAsSyyXMUOqB7baceF0SIYRuc4uPWleob?=
 =?us-ascii?Q?vjokwflbTl5jSBrkRKjMSyrQ6rPxggkNjnUQ7b9WFSw/R9eD6NXt9mOLDJOP?=
 =?us-ascii?Q?NQtcZLziSzwIlS7+WNmvgwA6FjzXRBF3W9GTkdGe?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8ff4f8-673f-46ed-aec7-08dcde659e6a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 19:58:41.1603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRPEQ+6VIQmUKC+2BDafI7vlEE2kp/7GV77j50LkhLD3Rpczv0I4Pl4EKKbyWKQS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5967

On Thu, Sep 12, 2024 at 06:17:28AM -0700, Yi Liu wrote:
> This adds ioctls for the userspace to attach/detach a given pasid of a
> vfio device to/from an IOAS/HWPT.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/vfio/device_cdev.c | 51 +++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio.h        |  4 +++
>  drivers/vfio/vfio_main.c   |  8 ++++++
>  include/uapi/linux/vfio.h  | 55 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

