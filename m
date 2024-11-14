Return-Path: <linux-kselftest+bounces-22044-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D319C9067
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 18:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B530B31156
	for <lists+linux-kselftest@lfdr.de>; Thu, 14 Nov 2024 16:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61CA17B50A;
	Thu, 14 Nov 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gDRWP00b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE416BE3A;
	Thu, 14 Nov 2024 16:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601217; cv=fail; b=DLMqJ1DVoLOUNwxcotO0BK5JuN5i+625Ft7u9p+skaW9GqJdSqmER57xOWgNByVMbAwmTzXSJLITRNJXhbpasHlslSUjHjGzTiKfAcriOJvFWi0FHSCU3ry5N4OoZLKM5SA+QnOIWixV8fgobEPHoIdo7H14i6hvK4/3M/2bcsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601217; c=relaxed/simple;
	bh=FdsvzdBKxB80LUHcAwA1/4kwEEz9Ot6Os7ZNRzZoVMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UcmXBbC4HZZCI+t+EzDGC53wFLrHN+wdJ47iX0Hn5RzhNcNbxHIw8TK5EWuyjHvuc0rulSHSxnWNAqIRbpOOlZbHkz5zwfL+wX8KGOaVapo31WJhij3YZo2BjeirhW0mcuOXwlRYD6oRNSF6t3/qQdnA0eMZNO9tWulnSvu74ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gDRWP00b; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JwjjRrDdahWEy89rL7Od2YRCziL98L0Fhi2I6XaE7fLC/ABc3P/27seSNfdUsCXA0Dw56Y0HqbIYoa338cmUy7gjeJyjCgDMoHrLh50U+7Z6GxKOJm+O+Q8d3lM43XMkRiki58lu/PS8ATg8/WlWcsb/2PKSZcef1HJ1s4tKivhT+g6i4ozDuYSO0mKAoYOqVkiCa8Ng1YwbN2QH3TfS/wlZZwmvISiNLgizECqG09SV4vI+psVQuXfogSjpqvjpO02EYRZb1l/i7sZBcWM8U3RjerhvjAI1SBKKT2GQvJMEKIFfURWqvbXIgf4Ku2kRnDYDZDiYnfor4EzqIdUu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJ7MZBLNlOy3nqg/0Ja5w0dDMCfwXClJZ0QpPU5piQA=;
 b=D4q0qSkk7XBEJDcZ+WKjOhsB8oSsS9MdDlLoiwCFCINY0XExa3BMUH+evbTSVZ2OULotY8SX+fBWLb+nnQT2VPGenVVIJzp52JlfLm4zRtaK0CGFxVFxGnzHGe+SALoV1bysllNxETwGVy0b99em0lCkDvbgXJTsMSR/Pw9Act8Ef/9mcZHtOTgYlSd2oO5iYF7qkx4YInh4vAuq2NRgPw2WyIzyy0b1eYPrhpSsyVhxNaBxXE64+lavA5Ds8xBHxIwUIwr+u3dB/0NobwjBCuDlFTst+Ry/qz8UGhAwSR4FBwA91gPLycz7AxdcXnAFHPYCANb0Nu4abRohH5URaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJ7MZBLNlOy3nqg/0Ja5w0dDMCfwXClJZ0QpPU5piQA=;
 b=gDRWP00bbJT18WwwkpDjFmvzv77MeClU8qqWoM4D8YK84sPbzYizHsdquAgoFdQXdrxBNWLuPCQSTc8a3WR884Q19BRXa7kj2X1mLz+OANgnszKDPxKpYE9J5SrU42CN/OgUPUzYyTimwnVhXBcN6xBaCxNSUws19Wn8g/PyHhRpfMj1C1qB0dZC5JvpACVAZG+RMxnI6i+Nae5cMYUXLGCPbw6hVWoeg/+wBp98JdI91Qa++EWW10Yw0DBxLvougor33keSMjGW1978Uqou//wl6eqC69xX6ZeWz4vwkhIsG8n/zUurDr1VD+DtB3OIK92Zx/+RJZqjYunmZn3uDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:20:11 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8137.027; Thu, 14 Nov 2024
 16:20:11 +0000
Date: Thu, 14 Nov 2024 12:20:10 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, kevin.tian@intel.com, corbet@lwn.net,
	joro@8bytes.org, suravee.suthikulpanit@amd.com, will@kernel.org,
	robin.murphy@arm.com, dwmw2@infradead.org, shuah@kernel.org,
	iommu@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	baolu.lu@linux.intel.com, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	aik@amd.com, zhangfei.gao@linaro.org, patches@lists.linux.dev
Subject: Re: [PATCH v7 13/13] Documentation: userspace-api: iommufd: Update
 vIOMMU
Message-ID: <20241114162010.GP35230@nvidia.com>
References: <cover.1730836219.git.nicolinc@nvidia.com>
 <7e4302064e0d02137c1b1e139342affc0485ed3f.1730836219.git.nicolinc@nvidia.com>
 <f0c45d5b-b8cd-4f75-a9d7-21808f18583d@intel.com>
 <ZzVB7Fun48rGztuV@Asurada-Nvidia>
 <8f6cdd11-3bd3-4c4c-9424-c0d52eaa6f93@intel.com>
 <ZzVsEmzc1UyDdi//@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzVsEmzc1UyDdi//@Asurada-Nvidia>
X-ClientProxiedBy: BL1P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:2c4::6) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ec4ea3-49e2-40d1-224d-08dd04c83683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JpD/dmRqKd6APc8dRLOx6rdFq6qpMDGncCK/Nt70riVoiGkSR1mnm31utkgI?=
 =?us-ascii?Q?f3X4vvmn3k4MBeNmJHlySVYFu74aqwK7KODpoboq6Aythftss07NM9zcXd6v?=
 =?us-ascii?Q?6MkDreIPkkWLpnsiU8nd5kP1h/BfBnlY74WXyxHox/5zig71yyCcXTTVWxZi?=
 =?us-ascii?Q?A9CHao0BkQZmfM3YDwDhsJNoe5Or9rpj/3Qte5PwqBv65pR5BUMYV9/oo8rH?=
 =?us-ascii?Q?r5DsE8LuVDp/OpiziPEsYfyO848BIeiqOLBX0niuEsHxIUY9pPpDu/AkT/gd?=
 =?us-ascii?Q?zAvZHLmGSFNJRO3JTnqAmga6F+h+jqqEjJJkLCesv6FbXvb0WuEBgGFkenSr?=
 =?us-ascii?Q?TW7zl1+JmdVgAfgX8JszQ5TO9wIu7pmONCMKsGI2r5rwtlG2KPR37MyPoHkA?=
 =?us-ascii?Q?o4RWx/DhiVM+UA3FHNOZcNB8ivfR27ZIhin8Ir7t3ih9/nV5sRsWLSeSwcR+?=
 =?us-ascii?Q?NKkt3CC+rIoTuMD0xUmS8TSAJYHDmmchpZmgbxXubsaQtMx1R7g6E1nfXCgi?=
 =?us-ascii?Q?pMMQnGOZMRqAFfUK2m0waScySW5a6XW+73DzIE/I8gF9vJcl4zCL/3CpH2Kp?=
 =?us-ascii?Q?lUvWK8zU9g6Rbn7b/d7wSD/3s7m13b1b9og+C7MffphKyVtu38UBIxVMntpK?=
 =?us-ascii?Q?8vsqCBxu7n+b9YnLCKmlru1Jsl6mKrL+GQPVZr6Sr3jpR2+6CWZw+Q8nHkJ1?=
 =?us-ascii?Q?GjovrPbORdavgYfBPGiFuo7wZnY4mZrIhWtGumwqwLEKMYG9v43zdKAk6PMv?=
 =?us-ascii?Q?A+1JhwKh2JXJ6u9aMSlZWGEIylzpKkVvqVM2iFxfw1+gdhriHtMwk0XenWs8?=
 =?us-ascii?Q?B0Wc71P1J9i+BNggj5jUzZooVtv588AzpNfQ4xSzI3KorHMUIH0EzxCJ+V4a?=
 =?us-ascii?Q?011avH1019asg4R7C50sfUn+DOkQBKg/tYpf0VBdTfirMsex4PANxa9j/Eq/?=
 =?us-ascii?Q?ZfHVQWAzK8o9d9qwyluw5ZKyRNWEKSG7yXkB9x8U7pR/mxGDZXqHNNSN4WlL?=
 =?us-ascii?Q?JBaogaq9WFKT9RSLRsHrxGeU5rBkQF2Vk5PMobx78a+0m64C5P4HQiBKkxnl?=
 =?us-ascii?Q?G0ETM6ovJ54tZ54nkXPA5yQreYcJPDvqUisgjqRu7qSv3+rz0QoseuloBdeK?=
 =?us-ascii?Q?SfEfX+LMEvDP0BUqzfHscoMkpCXFe2DsiZfOAZdOaEWJPhaIxFD601KF0NMC?=
 =?us-ascii?Q?PBVdwVx7cMjVO2Zw4zl+rerMqkZYTN8YZsqmND4HLDY1vlHyOdOu+gRlgazq?=
 =?us-ascii?Q?6Up4dL9mrWXjbuIYVf3ET+tdfdoPiyC8bAS3Ug4TRSfr1sVy3y8Rnk5J1EAt?=
 =?us-ascii?Q?XB+jtKJGtVrZomkV/hDXNVb0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4VXmmHNVHpmvXuV0xaJOWskDeRjXQf6PzwQLVWQ+H0PBmRahSQu8oFLNo7yH?=
 =?us-ascii?Q?SxTdN5p/uL24thh8sWnvtuRegLyq9wByLoTyfVqvGrPXPoVN35fF7NA9vhQK?=
 =?us-ascii?Q?7VmtycrvstyYWtaD0fRd4O7rCa+/GJ5kRr/orjBc+WMWiNXwd9izCJm1jnFG?=
 =?us-ascii?Q?zGM6QpGYaqJFE3Rj3GyrrDsaA9KAzzHFqw08VcHIbdv0pAjj1Vv8BLShn2hK?=
 =?us-ascii?Q?YdFzF4jjV1HZY5yd8/ewVKQo7vdFDKKHP76dQyEikt+FZSVP7FGTn67tRf6p?=
 =?us-ascii?Q?y+ODUe3004zOAP/ns5AgL79e6HNplap6JVRjJ7YEZDRg9XSY0T3rbW/DjEOE?=
 =?us-ascii?Q?ZlHdpqeqKpjFoxo7h6vOunxhFsrIvsmXTTOvrHprqKwl6FEqNAHuWDvb7B+Q?=
 =?us-ascii?Q?XZWbILvDJYi65YD6nY6kq2AZ2bhrULvZRsNb1ZWEd+0W2b4d7pFMsBAyJ5R7?=
 =?us-ascii?Q?LJ32MEJz+CPP5pLy4OvkMGo3P+tY8+hiiVNCup+bFRJlXQhdBOP+U5z0pfT2?=
 =?us-ascii?Q?GCZ3v0MixGG/+XfnjxhtN9dg7CA2QoWs/jSpoAwEYGcatnOIfEK8uWK/sRWD?=
 =?us-ascii?Q?scBds/4voceybmgA2MSNPZDaNb6Tq862/oLJQmg1etZGHTmiINAuGfcyjPLE?=
 =?us-ascii?Q?fLp9swWvnSsELiy/bvLi9frukp11uPn2AF3yGBTPET+9pZoUQWgOtk52ziBg?=
 =?us-ascii?Q?9c/gwpZxn4R1bTWQYpPFgNYiJo3nxU4JzGfSWSn6t/SZnWeQPRM3/DLWZ5rw?=
 =?us-ascii?Q?QmLSfNc7oVYOIa1xhkOt79K40JQYG34Z2SGez9hkxymTzsuEEDuMjeom4EH/?=
 =?us-ascii?Q?3e7P5LZYPcpnBTeqWi4v0RKcyw3VQxt7j3n5ym7ZXAzYDSJ0txuI13GbOCeX?=
 =?us-ascii?Q?77S3MDtOcRB6QyVZAkAmsPAk9ZD3yKN8dKDkq1j2TVltWFXbC80bctJKt1AH?=
 =?us-ascii?Q?deGoZv7MO48lnNHc09dnz5/4kU0QVoF+2Ml6VO24tuE9fflLwL3wCRiEzDV5?=
 =?us-ascii?Q?V9szKZyAQDt40fNlrHBpuSMoMXddBEa1uZSI/2mXsTiTSmntVrAAk150kR6B?=
 =?us-ascii?Q?4U+RkbHE25UCFGfvv8GfF6z6nLmisDEWS9RdmDkwj2EWiKwgdD89uNfLptcD?=
 =?us-ascii?Q?KlaTApxbRnm/4ScxqrgNQlXPaob3DO+JobtI2ZasHGrx1GZZg8nDia4lLg9P?=
 =?us-ascii?Q?CwFvzcWOXutkzU9g59HX4tsN0kPGxi+j32D7/T2szYtHmXe5BR6OwF+82GgH?=
 =?us-ascii?Q?NW/620c7/BZWlVy9LtHezSDGtQrw7PvNXmClhg+d3VArKTY6saD5Xg9wRWeo?=
 =?us-ascii?Q?CRgTQjqqL8YX9TNFgrX3fngmawoYy2Yc+7Sfn2BiZwLlGRn7Me2zzCK6kDOO?=
 =?us-ascii?Q?GVtQJqfkmRKyza/mO+MG1oToeT4G+BMRs2BJRpnyJq4t0b69tVhlzZ5GvNQP?=
 =?us-ascii?Q?r9qZ+6R/kx+0aNCnQShW5pTD6omY6HTHZfWulimBx8yZamX1rGob0reqgqGj?=
 =?us-ascii?Q?uoPL4Ip3m9tPWMZvk/mJetzgjeD4h6EQJTmIMaQ+6a4WG5KFuXFmDwTAGDWf?=
 =?us-ascii?Q?bouwX912Fhiwg//JzOqUKeIl7ITOddj3spC7i2z1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ec4ea3-49e2-40d1-224d-08dd04c83683
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:20:11.2802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZasJY5EEHcAUURyJzGO3kkQeoLNdlLmgvkiXGNg4Q9sABqA74vl90YC4eXfHZnoj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428

On Wed, Nov 13, 2024 at 07:18:42PM -0800, Nicolin Chen wrote:
> > so the user would try to create vDevices with a given viommu_obj until
> > failure, then it would allocate another viommu_obj for the failed device.
> > is it? sounds reasonable.
> 
> Yes. It is the same as previously dealing with a nesting parent:
> test and allocate if fails. The virtual IOMMU driver in VMM can
> keep a list of the vIOMMU objects for each device to test.

The viommu object should be tied to the VMM's vIOMMU vHW object that
it is paravirtualizing toward the VM.

So we shouldn't be creating viommu objects on demand, it should be
created when the vIOMMU is created, and the presumably the qemu
command line will describe how to link vPCI/VFIO functions to vIOMMU
instances. If they kernel won't allow the user's configuration then it
should fail, IMHO.

Some try-and-fail might be interesting to auto-provision vIOMMU's and
provision vPCI functions. Though I suspect we will be providing
information in other ioctls so something like libvirt can construct
the correct configuration directly.

Jason

