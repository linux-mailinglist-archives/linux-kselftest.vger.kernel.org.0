Return-Path: <linux-kselftest+bounces-20039-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03D39A2D8B
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 21:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D45285E7A
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 19:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EAD21BAE4;
	Thu, 17 Oct 2024 19:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="um0N6ZAZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83F121D2DB;
	Thu, 17 Oct 2024 19:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729192465; cv=fail; b=X+FqAHDZbo3nZl1PO6FqIimf29j8g6qBlXgW2dkGr6Hajzvnj/WsUI+P4dxs3X/ccHqZFyWeCyt9U6PQcKGZbWFwJuMKS14HpgOnKfYTtJ5dPxtO6eHXdJUidEda3+nyEEL1Mzbw94xiXg/+NrAji3Yp1NppTeYywSI/7VaF6B8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729192465; c=relaxed/simple;
	bh=8fTf2ZiZj6go1iVqT0Tf14EDaQxaVN3ZOiz0xMPLIDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WZFzvI4PiEaoeEfTK8qvVkI9TgNCvsnjV++o3LPpvFMnslrEyrlH0CY+4CCjbr20vguGjskxN12pnXYvTX3Zd8+XQmmR0BtJ2vAC/u9lb8TMO2IcqhBT4TH0R7cEjQPWnh5izVoDuGqs7Un8Jon719wUq7JfT7p2Ye9+XIvF/8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=um0N6ZAZ; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EUxr5OzGcf6ixvaOJgKKSbyZ6gL0tu5ZlluQqFwTaGLBFNqCk0IadwJhCXnTdBbQbKjhOMykO2xHNyTnCYGNb7s2s9mEsXSXlMmc3HwEdGz9xNHvJBx7CfnKCHOi6YSeOT//m/wl3qqYOUCRRCx0pUXADUKrusJZuP8QcZWlqNywUt4zRbOBMrOU7QzOSQt0JtfwMzx1OooAxcV+si/e6GQMJO3bdVitJELvlDaEYAO0fVWJDDJoJ0eLPmOqfWNWfruuDkHnpUGY6p5vCyTj/bfIktzeOQIYXs/sJdcBfV4ZDolWJ//hC2dD8B+ZF6bQT2AqNr3ZBg4VsJepOYDJJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8fTf2ZiZj6go1iVqT0Tf14EDaQxaVN3ZOiz0xMPLIDs=;
 b=zSoxkWcvb1z084bcGsiqSCbzUhVEqOyC56E7rsBl6tVHVw3lT++870dIAtZuWQ2cmK9OHqpsQl59R7CoMp8fA0Q/deQAGpuTQJinTGcY4M5SEm/DrnMkJVaQgIxyl+ierOoWizcTmPpqXjlS4GUU8CbNnaNww/nNfei6glXYCIaJT1Zx63W77+B4Tvzr43C76p38gh7OaaJH9jVeVfYAqViuV7VT5c5Xu/srEaqZy1hWHsTP3mK6+DcGCzLVynoZJBoz2cQKj3eqKZIJPIodhQQ7IK0DVZTTHNiFDSpN72F4+y849EzVzHX3ccXD3VlUKPwD0DVnkgIsMvvzS0V9uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8fTf2ZiZj6go1iVqT0Tf14EDaQxaVN3ZOiz0xMPLIDs=;
 b=um0N6ZAZrkSd5iisURbOlqnxTlYFClFqCw5LAfyu9kQGP9rf2N1L1v6WmsHuvAEpSpvoRWMWjz6YmDgG8LEr4W/oJ53Sij+D+AndUNtveCHplfHcfhUpXPHVioLs8BISwaXSFV/JkvUcZLushK3JFxu+hhcL27hyRWPsG2fZtGfAngXOhppet6mOflAxp94YVMl1LnVhNMd1zi4syzAHsAbmJxWy3Z8Mn0g577bT7yYVjH3cwk0NhMFVTuPEHWFmAF1fsFzsWPufHIXUaqhvCMEF8COR12MWHJ6UGYtihqJWRAJjOWQN7v1uIxegVNEDseDTFJ//o7or6CZuyvqHJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 19:14:17 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 19:14:17 +0000
Date: Thu, 17 Oct 2024 16:14:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com, aik@amd.com, patches@lists.linux.dev
Subject: Re: [PATCH v3 00/16] cover-letter: iommufd: Add vIOMMU
 infrastructure (Part-2: vDEVICE)
Message-ID: <20241017191416.GZ3559746@nvidia.com>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <cover.1728491532.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728491532.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL6PEPF00013E0C.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:e) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: 877d8965-5213-4137-e7eb-08dceedfe537
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TcH1J5cX9kXITqGNzGCWCHBJGUnm/5p9bT7THF++poHjiJ8D7r2NXcsrrQX0?=
 =?us-ascii?Q?SFw5Zt2gdCNb3SFL96BlktohBT9gdJmUqLJj/PfFtWOt28irKf2a9u+9xUXU?=
 =?us-ascii?Q?6NZLx+MUgYGNDPI6hNNQJVojNZUKSlpJNEuwBCprc8YB8iI3+P8Q4IAv0cqC?=
 =?us-ascii?Q?Jp1a5ID5Ym3DaLqpodGPUqQCSjL1NoPd2zHOqeTfucyOY9AR11vvqvSaasQa?=
 =?us-ascii?Q?aWFs5Ej0qcQBEybfbEMWtJbttq9qI/fBWDAGqZ9YJ8cIRt/MI6PoF6mEAFD9?=
 =?us-ascii?Q?Cp2oLviKUVRlPtG7QADxJZpHFfTpt/uXWSLPD6dshf0KmLwfXtwTbCTxlJZz?=
 =?us-ascii?Q?BRTx26PDpNiov/9v+iK4m/4c2Jfh/hufSExJU2Gg68sQ61uQ3MhUAih2R+9f?=
 =?us-ascii?Q?z/0kBiGz95E+QyEmPwpNM1nTVUB6c3u055W074hW9oZA/vfkjL1eQ5SHj+nV?=
 =?us-ascii?Q?OkNqeqyCKuApDTueVHSgwYhkqUPehEBx8DExSohq9gBjGPl6yFHNIbX9hYYa?=
 =?us-ascii?Q?M+qyNd/TFvxqbLxclTtjTk+cQwNVB8/HQUP+0ZgpAyl8B7/eIoMEPkY15rt8?=
 =?us-ascii?Q?VIt1tmuhxvuAZ0GHV56Xz/lxF3JbMfFSbxjVkPxCP7QBWum0MJn8IRin7KSR?=
 =?us-ascii?Q?pLxOqL6BV45qSwxJ9JkqCqpkzpzCX9FRFrkgXpHLiD2lgaX2qJV2BypUPV/h?=
 =?us-ascii?Q?ZTQrvkp7qf6bR4WceurvIRrpyQQeakiciK0VBo++QvXFXfgYOMXNdHcsfONK?=
 =?us-ascii?Q?mvhh/A45X31xG+VN634qBhfj7raNFfEKzON8E2yWwHIIoS6/i75gQA7QUUun?=
 =?us-ascii?Q?v4hn3Yr6prnUpVRcRvN+5O5qJgTtuAVZXJxSBw62Lm1cB3Cc6tvEdn2iOiuS?=
 =?us-ascii?Q?58dpmql3fAEDg+ixd0yUN206jWN/r1bRlTR3I/joYxAbvtlNUL2LcYMn15Id?=
 =?us-ascii?Q?ckE5IxGpKURZag/ShsoE5dsCIIU8xhc4Uc04OX2EHlkebsdOk/x393EYQ89+?=
 =?us-ascii?Q?j0J8HSZG5bz/Gk+KoC0CauEuZNM3Jhx4kyY3G64QV3zZ8ddx8clVPUBHOLIc?=
 =?us-ascii?Q?qfuvQG09toMlbXZYNe5MxCL8gD/rrny8zqkaHc1682WXEqljI14OEYUkEKY1?=
 =?us-ascii?Q?ILldaIJd9w+arGajgnIV7QmgjDVYT9DPpOENM058oWPOy20tCyLhZjgCo0a9?=
 =?us-ascii?Q?ahXTuTjAFm2Kv3C0bhcQHOMDiT6rwQRw0q1Ov5RjN161cerv8mcvaybwZDcF?=
 =?us-ascii?Q?ukLop//VUvNmC0BA5iEQSpVbOPMDiYQXZc2jvfuX8itM2LY4mGljydE65T3X?=
 =?us-ascii?Q?WuHsfo6hwfanypiIlxjq6l8u?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a8DwqKk8gs6ah4Kx7EcVSPwUWGbbUJ2T5PY7sLF/corIDWEslRFM6q9bftkZ?=
 =?us-ascii?Q?GhVlmL/5sPTdgvA3HODovho/GxLgS88xjpPHFHlFjZfYVVmMVROlTzoEeKI+?=
 =?us-ascii?Q?H5XjAXlG9wAncana/R8Kb2Z2CYl/k2Gm65PI/XifXoRkBz4ahGUADgllj9yS?=
 =?us-ascii?Q?EuxS/2L5+E6fyQ5J8IYXF+nLyS6Nn+3kvKn6u5YqY/4s2nSjbKbCH9ANRUAu?=
 =?us-ascii?Q?b8t1fugfm8xFYC1vHkT7hDtlkhvC9kHD6BKKYWz6I08TlSp3beFYFwiu9PC0?=
 =?us-ascii?Q?WnT48DG5UtjrI87FAsIzttBhsb+ncrv4Uwi4MAYxIYqFoEepf2S5zuhADWVt?=
 =?us-ascii?Q?3DT1i8r633exaDEgFo5u5FI+nSY47wg+95P6AyVIOzPegdFJCGp77N1Tih7k?=
 =?us-ascii?Q?UYHgKFvlILhOOTzgSLg1RY2OMVOjaEzEzFbwKgizHiAIjjQ806amUDa9CztN?=
 =?us-ascii?Q?sN6Zep7WDvIEgbgIm9z2OEDVswDOOkHJ7MWNfmsX3BhwD+3sdYRuiGN0Zm/Q?=
 =?us-ascii?Q?w58KIdro+DLk1SYitZIOvDqWWT4zQEpWwf4AaLpvHQBJbb5CkNvrXIcxOcMG?=
 =?us-ascii?Q?mEv5OAJXchgB9xNTUabhqAWBTCEMnvWrGqBWUZFLJvVt4P/JcUgcXsbBMmHs?=
 =?us-ascii?Q?l8xq8YQLKHMq9smr07gQeiggufadN/Ck7KWIYvEqKR19dQeBteuLJcyU7HXi?=
 =?us-ascii?Q?vi5vnUTjL/zPSzaxbkA4HwJsGyWuRiXI+TFdre9NJ2wbeirKoZlJnEE3IP37?=
 =?us-ascii?Q?MP0a3XNGunK4Uj1mL3rmLzq3lluzu/SmhZYZi+jp/SThppHML74D9Ctn51tF?=
 =?us-ascii?Q?XCx0hb+BGHFd5r42V7FmvFnfMugKMf5At71R8Bed5LKYw+fwu6Vafu+jYqhU?=
 =?us-ascii?Q?gMzWRvaAHmG6L8pO6qwDpU/TD0eniNwWMD++S/AwJsbsQt/Wb41wH5o8BI2B?=
 =?us-ascii?Q?p1kh7QBYuN2LKSnvV0iwGrTmBCr/T0QSWduooo/2zg1MVGbemdMpgDI3EXlf?=
 =?us-ascii?Q?FngUSimFX18SIKZZUBD4RvrXzB56dU88BpV++OYd/T7/pJqQXdiAJI9LV3XD?=
 =?us-ascii?Q?WE3W0LDK7TdxoWR0OCe+ND95Db4aHrBLNAlnb7JN2GqBr2SScgbHpbS5qypO?=
 =?us-ascii?Q?TbbjVY6k19D/J1Gm3hUb0dlwdNPV34NStqTzryUaVsbfEEyxIl5U4Xj1IQp1?=
 =?us-ascii?Q?Q6v+hMOZgwK8n6btNIPYg75Fk66hIj1eyqqoH4REjN8bVL4K8ooxwtuCYPUk?=
 =?us-ascii?Q?gSexoRQGcLfwRW8nm1gS2kUtSSHJZwG8SC43uDErnrVwRLegqQLIZX09k2pM?=
 =?us-ascii?Q?bNqQpuW/JvPziJz+arFCQzGiO9CWWIwb5gySZAMuGMzIoPbqe8kHLyeH1gVm?=
 =?us-ascii?Q?YO82vmNhI3Uees2chq/gSoOPNsPpJ+IIjDaWeFBGNEv2f6MMhwcZ70tdPVu8?=
 =?us-ascii?Q?qZifw6fMaCn3IdUV9ZazFd7rsTMenOTZHNTyz20RAIBRkQvFAk2LhtupSOdh?=
 =?us-ascii?Q?jrUXMsrNgqp2DqZk5p1uKm1eVx4ekl8xB5dc5yFjeUCDix/3ePvBC30V+fhN?=
 =?us-ascii?Q?SxSI8xboL8+oFSVY9EA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 877d8965-5213-4137-e7eb-08dceedfe537
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 19:14:17.1914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFGO0WpdS22Rtg4pHd70g0TrpbQzQptC8gHRhehM1Wk8sNru8q8s4l2OJ88Dp8TU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

On Wed, Oct 09, 2024 at 09:38:12AM -0700, Nicolin Chen wrote:
> Following the previous vIOMMU series, this adds another vDEVICE structure,
> representing the association from an iommufd_device to an iommufd_viommu.
> This gives the whole architecture a new "v" layer:

Don't thread series together like this with reply-to, it breaks b4 and
other tools ability to tell them apart.. Just post them separately
normally.

Jason

