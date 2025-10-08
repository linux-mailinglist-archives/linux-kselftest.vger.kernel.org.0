Return-Path: <linux-kselftest+bounces-42874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DF942BC5229
	for <lists+linux-kselftest@lfdr.de>; Wed, 08 Oct 2025 15:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B26734ED54A
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Oct 2025 13:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0720A2820DB;
	Wed,  8 Oct 2025 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LY9Pbgln"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010032.outbound.protection.outlook.com [52.101.46.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576422765DF;
	Wed,  8 Oct 2025 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759928904; cv=fail; b=OqlRraJV2WfIg9byzRzISCGQYfIAPZrSLsF4Tlb/QAuYpDp2WsgQG5hwqa2W5r9GfaMabcDbbGK3XaMMAFkPG2dzzkx38Fab+BtJbt4DiqS9ckFBUL143AZviUg3/Ilk2WTGOzRMbl6sYx+NIwIUPu5iGo8I6eYpvW8XDsMJqnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759928904; c=relaxed/simple;
	bh=r4Plf2K9f08QRv3TGWPR5BLuKrcy0XXtH1gxW+BJPks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GVf4+sXHhuFZgKg41iouRHBOPEMQaXfL0qiqOE7yi+ooV91hZQsI+awMBfbzCV5NmNXSKBksLMSfZ7aRjEE4p3GUslYB7IS0WiK7yCQxwn7ui5lblHr048Yz4V0X5DBHxEtZ7g8RmOqmLkjVqiMMA2eG+pkgtlCqsOJpfg+l6Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LY9Pbgln; arc=fail smtp.client-ip=52.101.46.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytWI13qWoOV0EZbogTe0KNp0ilW4SiY8fHal7Sc8nVjS1W28AMWLjyR7Jr565Q5V1sDIdU1hWo5JBns9wVLTuzWUTceviQ6WEL5dEVc1HWebNLfR1hJGyvSsSgDV/CMjDobiN7IEW8pJ4PioNBLlKZGaZiuNQ979tjrusq2sg8qsYZD1OIxGJYgrRl7A8rw8MG5dI5WAAd1AzOXdijtlO+yGj+rUlasS979khwsZjaWtkTL0q904ncAeVQ6M2KeSuWtWXx3J7yMr8WVWtv8cHv5Grv81MTlqzbbWHzUFJniZe6j2y+JMFyTapd0axhyIoz2jOW/Xkx9Ezn1C07wxbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDwtl5l6yDUzgwc9auDCGKGF0YYnUM2NYlSCTX5E2yo=;
 b=JPNa7L4wFw3oJVjFfjBax600ulUhJNAb09EZT+H6W0eQ/pLBgQ5SzXwF6jfArS2Kcl9KZYkW5RQTK+OiavgLHr/7hLQXy6xgUct2sPYKI1Ttu4j74VPZSHC1/k5QaesIy7KQ7WN2pVjXT8CAc36srlK7Hwqb1GFRs/VTFlsRAP1I4IpN5UGsVuvcNujU2bK4uQAqV8CY1HYKpiC5GQ9AcjrYGnWFBaeSyiV6hHbk7Q/k9uRhaqAlD3g+N74+HHg0KCzOdJ7IGXGzndyRezXzrlTUP3oN1ltuOAbtiNfrmLgpxt//KKE4oCLi40SNUADUZEYGpUlj5U2BzW7h000vrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDwtl5l6yDUzgwc9auDCGKGF0YYnUM2NYlSCTX5E2yo=;
 b=LY9Pbglnw0JuS2l8YTV7Qa2NIu4tsTejDA355TTO2mi/x8P39bDAQvufiOKL1FbwQa96yTDvphWRA8Pkv5BEV5YtCoYEMZOrET5BdWyArUy0e/EDb2b1p683nVUIgHWSGWvzZgxYhrCRZi+PasfIAMLdR4ijvMCnksC3DRq5TKu8XTUu/SMgW1yiY5IwFJHl4nKpkBvgEBbkS5MpPIo9LzaiFI5bINFCJKC+fZlPs4cFOY3otAkZs6a35unkmbYB/rtl6IpfzhyBVHCobTWbmDECtpuR2mijW1jZFE2nAg2hLsHOuBVGRnICnmZFhLo0pVuU1zyArRo40tO4v5LC0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN8PR12MB3604.namprd12.prod.outlook.com (2603:10b6:408:45::31)
 by PH8PR12MB8608.namprd12.prod.outlook.com (2603:10b6:510:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 13:08:15 +0000
Received: from BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f]) by BN8PR12MB3604.namprd12.prod.outlook.com
 ([fe80::9629:2c9f:f386:841f%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 13:08:14 +0000
Date: Wed, 8 Oct 2025 10:08:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Vasant Hegde <vasant.hegde@amd.com>
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
Subject: Re: [PATCH v5 04/15] iommupt: Add the AMD IOMMU v1 page table format
Message-ID: <20251008130813.GB3765120@nvidia.com>
References: <4-v5-116c4948af3d+68091-iommu_pt_jgg@nvidia.com>
 <4f50b0f3-c62d-452d-9a39-5c47ac201d01@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f50b0f3-c62d-452d-9a39-5c47ac201d01@amd.com>
X-ClientProxiedBy: MN2PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:208:23a::11) To BN8PR12MB3604.namprd12.prod.outlook.com
 (2603:10b6:408:45::31)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3604:EE_|PH8PR12MB8608:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e3fbb5f-0108-417a-f353-08de066bbd7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KFc/P4eyJWw+0W9ZgC4e9+zf4Ufan9PGu4jVWG4cebLrbfKE/4HemBeKQfLN?=
 =?us-ascii?Q?oljoOa1XzoFQ2+oSAMq6NzRodsFYeSf7PG81vDnnTXJKaa65Vh6TO0vA5cGX?=
 =?us-ascii?Q?9Py+FXloB9GYcHbGHyrKuqSijE1EsaeFRBONRGXzqrzuDmhMJuQz4fbdwOLZ?=
 =?us-ascii?Q?4LOpgbtCfAOYfQfqdg4je1ZXgRD5v9hoHJtnVPehM0fdxPHl+UT/qURniJee?=
 =?us-ascii?Q?3XZtfDn6aalSvywlKkRQrr3mVJPO6ZW5Efeci88G5o3sjewGtnb1W8ExTN/Q?=
 =?us-ascii?Q?tI621bfdpeB6XjQihxvOwU5NPNbHiL2KmC8xqpYofZTdolMhSyVIRpdtOuJY?=
 =?us-ascii?Q?/6rFB0yXBcIsfWwbvS1MG7W8zR3PwTzaybXtXtNphF+wFjzD+IDPTUbJrJjF?=
 =?us-ascii?Q?M63TQhqFkX2XgfERtdXYMhGmqmCvbItphkzcG1VET51flZfdXikSd4CkAtXV?=
 =?us-ascii?Q?QYHYmSHZWnFBzA9KIctAx1N3dUMsj5B8iFVhRAo0JUKWy7FUmRkQgg0nA7Tk?=
 =?us-ascii?Q?q1AsiV62nO9lTZTspWq2UjHesHLx0h6IfV7CAMr3X4ZgVb6ypYfIqVdkf50r?=
 =?us-ascii?Q?Y1PdrZuT/iZnt/MeOO6E//dBCX2RX62WNjpEdMMY5MrmKFz4OVjTj3cRXUWg?=
 =?us-ascii?Q?5CeXdsvXRFZ6WddFCfI3K4DlAF/zvgjPALoUjlLq8c/W1AKq8aB7eiXn97T9?=
 =?us-ascii?Q?HxYk7SSxzrl2PEr2RK4y1ZAa6IqnIJZjBfWVpgEHeQx8xzX8By+Wx+byVUyY?=
 =?us-ascii?Q?OaYiBf8xCHZusbCaA75lSJlo1v9oOApzjmPdytlccYIZol7V37XTHP5COpup?=
 =?us-ascii?Q?4MdO11pGnLmVdVZP5zMoBhZCKXoYInwz5uraYOCC2qElUFjp3nPOEJ+SZ8PN?=
 =?us-ascii?Q?RJDQzX3ITgPTkBi50X8yQYfoBEbm/TcsD2YNnbylw/RwnOQ9J8d2kRf1IFs6?=
 =?us-ascii?Q?NlkWKqvPiW7V0jY0eg2uXg3G+xadoVngxkvXkGzAzDoVObZgbktMRv+2S4IF?=
 =?us-ascii?Q?SVFStUZQ0rhjM5oAFKyLP6pYnvvtBD09w8qDUZvZ2N4O/1B8+AsVc3XANzuw?=
 =?us-ascii?Q?4K+aCLby7GO+poYi5F6kV5EFmJLcwJCtZnuTnRMLk+6nK2LMVpu3oYuVucnh?=
 =?us-ascii?Q?gWsMaZAT/odA+Q8ggIBOHTKbx/4Fyn0x0YNmyJfQW91xvI/ZKHbF5aPdTc0e?=
 =?us-ascii?Q?bHftKYE2pZ/JydoKoIVVnQZG0Ajv0Q0u+b8N7w5seStgJRJWJRXwTAARf2NR?=
 =?us-ascii?Q?crq5f11m8UPenovtaJbaKTsUA+056flBgOwtTFVS28XVsYLkB9V9Dnz4KKBf?=
 =?us-ascii?Q?lBM1ahsM/tbYuLgaFbczZn7KdJWQoFtG39w8vOIgLkj0a4Y0DFd9wlRYP1hY?=
 =?us-ascii?Q?tx9+3ZMUa2RTFdEAJVqiFPvFaK0zJuiUcS1ywP198f0bEPIK7eBDKgG1Nzbo?=
 =?us-ascii?Q?ukgFoilMX09l4rxkxmrZ1v0R6PwrFb0x?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o6o67opDj1kwpwBkTaQDSGgOl5OuJoHLJA2o4VrbZ+p8Oz7OMxT2hlM51H/H?=
 =?us-ascii?Q?pCj1+/Q6YaWP5x8t4cHpWFNeYGct8rS2KnquIxEEOsS7XBeP20JCD2TynsD+?=
 =?us-ascii?Q?zY04BOiqvW3nXKfPRZg2e8k0IgAKXSF+dznZxfRGJuE++74QUw+P/4JyJB0a?=
 =?us-ascii?Q?ySse5zIBOH5HV55xHZB5o02nrtWVgfaDI1zy2g9EtM2S3XU4rT5il9ffs/sy?=
 =?us-ascii?Q?vNBjVQTHGLheoiSaf/72hb0OpmzyWCvhZXZ8snlnZauCsTkdo0u1Uo9y/tRu?=
 =?us-ascii?Q?ljryEFVWisPFpLV2dNSWOXgb0dnfzSan0OJiwjcM/DSdBv10+/0uMJrV+dZJ?=
 =?us-ascii?Q?vnSIeNCL0Zfb6QUZH30n3De4jsn5YHmCGjyi1cQwLqBrv6UiYCUmnZNddjQL?=
 =?us-ascii?Q?ybyx43p+JfB46lERDLbD80PnmNCJTmCdYEw/m8CSSBUTgXqo1UzPC1XSVwRz?=
 =?us-ascii?Q?suXB4qGm7Q+Eo8KQJ4mCkhTbxNHBUqkDxDnNOtBo+HgVkYCGz/esHn76zpfZ?=
 =?us-ascii?Q?rsLZd9rZQ7jxoRtRFaXrDKGrV+zL2pweXGiXaStb79EXyPbCdYQy2C8ngB7b?=
 =?us-ascii?Q?gcLwcMCKtpQ0laAp53OLvrebtpjC/S0YOqc15e0tv87Disf6w/K5U7+lgRS9?=
 =?us-ascii?Q?eO8iD+TK2Od2+8UkdkXlR7JEuRw5urIIF0Hl98FisTfwWjT4KoYFfvP7TpSL?=
 =?us-ascii?Q?NVbU50aXT6aMmG4sOV/jQVrytfP/dRRgP02bx6jVUy5PFqfqABlZid4O5Ygy?=
 =?us-ascii?Q?AZqkV/nh4T7Ei4pYBfAvUx6Ye3Lz3W86gn1amAnftnTxI0gwDJy4R9Ve43OD?=
 =?us-ascii?Q?csFmKwcVa+hizCaRvAOGhtTqVFPjWDtHNrwF32rQ0mMR3MqezYR2PpJZsSOe?=
 =?us-ascii?Q?OSPhkZPBSwJvODoMO6o1Z8smHTiUiVlHbkgbxs/K90nHRXw/SiODfp0WDv/O?=
 =?us-ascii?Q?4f+TVYYnoERIxMZft9nhgBTYY3Up2zFRGrna8CVf49IV6waIIZ+L1DniYovx?=
 =?us-ascii?Q?Gi6AHW7ieSjH4qilXgxtRTDBbdFcuBMbv1Rj1sYkxItMZv2sF6nr3Iz0PXpa?=
 =?us-ascii?Q?Sm/9oAE5+RmhTvte04Yt1NzBgVYRBhTUUrnSL/SNIwQbfbK3tzB4Z4azvPDM?=
 =?us-ascii?Q?ov70hQCQ4ZrlMWRmOXRskl8hQ4IfpLXxz+8gAdboG6niWxhjEayTvVk/1DnA?=
 =?us-ascii?Q?249uvNQzUNdAGGtgsltUdo7E2QQVzi6HYcLV/wDMT73of/m6hoCbnjudgnuK?=
 =?us-ascii?Q?T0sviTghKaS8r2cqavtiC3yegMIc9Yd5V2HnI03QsWomF+PJZ2s5hICMoOXk?=
 =?us-ascii?Q?82Fab17c8guSZdjbJnMoO9/EcRJScWbBdU2GnhgIVygql1Z4/5xhAQ8+1l4f?=
 =?us-ascii?Q?5mzpJ6X0PPzzHQrrxFXfMpddMMOtpIGv0VTmuqf4yc5570nbxPekmfNx10At?=
 =?us-ascii?Q?fba6tZ/Bc2IzDCE4AyN8sQP7B5NgJyrvXVwDJ2DAxVTN2vC256sN3Ml7Vh5X?=
 =?us-ascii?Q?K8pyVAnCBR9EPWMcm682e1ZmIbNQkF+3nYs6C2V+TaRT/5Nej664fl23d275?=
 =?us-ascii?Q?y2xt82s2PhnlehLMHhlDaeUNJ9OPYvPEqBwZH65s?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e3fbb5f-0108-417a-f353-08de066bbd7e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 13:08:14.5255
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDRPxd7birp0CgEnwJn7uIi5Fk+M2EnA2mh/urCSWXSprDAYUjci0vg+JqvVwV2t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8608

On Wed, Oct 08, 2025 at 03:13:32PM +0530, Vasant Hegde wrote:
> Jason,
> 
> On 9/3/2025 11:16 PM, Jason Gunthorpe wrote:
> > AMD IOMMU v1 is unique in supporting contiguous pages with a variable size
> > and it can decode the full 64 bit VA space. Unlike other x86 page tables
> > this explicitly does not do sign extension as part of allowing the entire
> > 64 bit VA space to be supported.
> 
> I am still catching up w/ entire series.. But here is few fixes needed to boot
> this series w/ SME.

I got them all, like this - thanks a lot!

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 92095fd17b3899..0b97db94c8c4e0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2054,7 +2054,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 						       &pt_info);
 			}
 
-			new.data[0] |= pt_info.host_pt_root |
+			new.data[0] |= __sme_set(pt_info.host_pt_root) |
 				       (pt_info.mode & DEV_ENTRY_MODE_MASK)
 					       << DEV_ENTRY_MODE_SHIFT;
 		}
@@ -2166,7 +2166,7 @@ static int init_gcr3_table(struct iommu_dev_data *dev_data,
 		return ret;
 
 	pt_iommu_x86_64_hw_info(&pdom->amdv2, &pt_info);
-	ret = update_gcr3(dev_data, 0, pt_info.gcr3_pt, true);
+	ret = update_gcr3(dev_data, 0, __sme_set(pt_info.gcr3_pt), true);
 	if (ret)
 		free_gcr3_table(&dev_data->gcr3_info);
 
diff --git a/drivers/iommu/generic_pt/fmt/amdv1.h b/drivers/iommu/generic_pt/fmt/amdv1.h
index d7660d4170ef78..26e29b08a9b4ae 100644
--- a/drivers/iommu/generic_pt/fmt/amdv1.h
+++ b/drivers/iommu/generic_pt/fmt/amdv1.h
@@ -73,22 +73,29 @@ enum {
 
 static inline pt_oaddr_t amdv1pt_table_pa(const struct pt_state *pts)
 {
-	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, pts->entry),
-			  PT_GRANULE_LG2SZ);
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(AMDV1PT_FMT_OA, entry), PT_GRANULE_LG2SZ);
 }
 #define pt_table_pa amdv1pt_table_pa
 
 /* Returns the oa for the start of the contiguous entry */
 static inline pt_oaddr_t amdv1pt_entry_oa(const struct pt_state *pts)
 {
-	pt_oaddr_t oa = FIELD_GET(AMDV1PT_FMT_OA, pts->entry);
+	u64 entry = pts->entry;
+	pt_oaddr_t oa;
 
-	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) ==
-	    AMDV1PT_FMT_NL_SIZE) {
+	if (pts_feature(pts, PT_FEAT_AMDV1_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	oa = FIELD_GET(AMDV1PT_FMT_OA, entry);
+
+	if (FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) == AMDV1PT_FMT_NL_SIZE) {
 		unsigned int sz_bits = oaffz(oa);
 
 		oa = oalog2_set_mod(oa, 0, sz_bits);
-	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, pts->entry) !=
+	} else if (PT_WARN_ON(FIELD_GET(AMDV1PT_FMT_NEXT_LEVEL, entry) !=
 			      AMDV1PT_FMT_NL_DEFAULT))
 		return 0;
 	return oalog2_mul(oa, PT_GRANULE_LG2SZ);
diff --git a/drivers/iommu/generic_pt/fmt/x86_64.h b/drivers/iommu/generic_pt/fmt/x86_64.h
index be2a0a770f903f..d33b2fcd865b84 100644
--- a/drivers/iommu/generic_pt/fmt/x86_64.h
+++ b/drivers/iommu/generic_pt/fmt/x86_64.h
@@ -79,14 +79,22 @@ enum {
 
 static inline pt_oaddr_t x86_64_pt_table_pa(const struct pt_state *pts)
 {
-	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
 			  PT_TABLEMEM_LG2SZ);
 }
 #define pt_table_pa x86_64_pt_table_pa
 
 static inline pt_oaddr_t x86_64_pt_entry_oa(const struct pt_state *pts)
 {
-	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, pts->entry),
+	u64 entry = pts->entry;
+
+	if (pts_feature(pts, PT_FEAT_X86_64_AMD_ENCRYPT_TABLES))
+		entry = __sme_clr(entry);
+	return oalog2_mul(FIELD_GET(X86_64_FMT_OA, entry),
 			  PT_GRANULE_LG2SZ);
 }
 #define pt_entry_oa x86_64_pt_entry_oa

