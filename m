Return-Path: <linux-kselftest+bounces-41851-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C2FB854EA
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 16:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61B547C1C82
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B291E2F2609;
	Thu, 18 Sep 2025 14:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MVGvchvU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CD523BCFF
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 14:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206624; cv=fail; b=otD0fb7FSClui/liiJprsyJpTxmUf1v7dFQJiGS7d/9HBziVBcxNna33FMx4wh2F2+EDb0k+geimjnX2kHsZZrWdCb0JAAQRlg16VBT1iSdERlCUSLCF0P34GW0Y2P/dyZNzv3DyFLxXuDaSKTR39P7DzlIw8RM0PPkA1M8BOI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206624; c=relaxed/simple;
	bh=eCKNfxPaNs4dPn+tRg+GIlh2qRG+iXVxKUC8oKUrPrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FCDoBzvO3slMxQdW8xIo5YlP1S3oPr+OUB5HARVj5JbPnTfYDYaGy2qZBqgBWHVCYYICWT5PIKAt1VTKHohHIEYwj1uLVE35l/yo83blT6WbUt63GWXHG0gJqYFSak95lhTGq0tvuVRJyI5JijLed4hV+0PhQOkjfXHMPJUN2g8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MVGvchvU; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ei4N9UK9gfK8fztigDKcH4gqAbtaTnetUgMRfZiCF5vLS7zqQV9h4qHUDd1ZLDfvNoptw6sqDVXBw9zPvwuWSbWLzTx6oXFMn+Be4rLSETekt6iElbpvMzYCmT134at3WqiRyx4l5+LkmbQHGvJRpwCYskVPcz2R4KUKYScmHdGn0CKKeKCIqqKPatH9C8Yvav73d4PTiKoLwldnG0xoVafKPrAmzjRhCD1w7C21mYkpWUu+JlLtD3ZloYFIbK6QeyG/GyKRmY57ZdD9rIEScG8m8ZiZuGcj9MPE6wZsWH1rlkchDF5AX5AwdysNGHh+uSMRQ9Ou8Ja7DV8QFyGcLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lNlDzjPbkRGIkRB/DNVu61hYugap3W8ORsMCuh7AZz4=;
 b=QB3alyEVPnqh0r8trW/P7aDv2aoQRXa+ZSibJtd7eHTHArk6ALXdMitNHmgEp9bog1vmsXQI1bqe5nYNCVm5QqtjfV26j9J/ysEPfumxwRAzAf1XNzaG2afP5kYNt+PMs+xOgpCuKy83X7wSiBKsM56dYZiG760rS6qIfyboA3O7r64UN16MWQDwfLY+r2WiWL1BeDIvfBcJZVHlaqiU3jWfzNqFEGs0/mFrQrrezy9NDmz3KtZqtsQ9u2NmKc1NEdEhd5hKHK0nbvroGSNStjM7qYL4cyVU54+XZrf2/0ZYVfzF2/lPUJ+rZg9C2vpcQZnHJrVbUGFDD+ERMj0yQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lNlDzjPbkRGIkRB/DNVu61hYugap3W8ORsMCuh7AZz4=;
 b=MVGvchvUo207C9dg7FwFVWmITTzywpTS7T75z0fSWx501ECXI+Ew3debuyH9l9fNq2PPJKB3Vqc3He8emMbKZ366X/Rh5YjVAeThX9MyB1B4D/kSgUaQfMKJW+v73OlZ3etxniFS0BG0b6puZOTsNDWXhxRfAF/JEXlT35q/LgELCItbJWjnihI2bRWqDbmLeTWsQCa3Y9L4Rg9feauj2yyRxCLiT/TFB04LO2Ggl4uH0Wn3u5JvvRkMsFYECoafhVMEKYcb0RR/HOdvb8wCRlv+zsOOFfIxZBb6ro7ss71EhbMNFDwbeMnl6FxvrnWs4J+0fNYm5Gqu+fBSR6KfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH7PR12MB5757.namprd12.prod.outlook.com (2603:10b6:510:1d0::13)
 by PH7PR12MB6588.namprd12.prod.outlook.com (2603:10b6:510:210::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 14:43:37 +0000
Received: from PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632]) by PH7PR12MB5757.namprd12.prod.outlook.com
 ([fe80::f012:300c:6bf4:7632%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:43:37 +0000
Date: Thu, 18 Sep 2025 11:43:35 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
	Kevin Tian <kevin.tian@intel.com>, linux-kselftest@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	patches@lists.linux.dev,
	syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/3] iommufd: Fix race during abort for file descriptors
Message-ID: <20250918144335.GM1391379@nvidia.com>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <1-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <aMuTmuBKd9aU7ngO@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMuTmuBKd9aU7ngO@Asurada-Nvidia>
X-ClientProxiedBy: YT4PR01CA0130.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::19) To PH7PR12MB5757.namprd12.prod.outlook.com
 (2603:10b6:510:1d0::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5757:EE_|PH7PR12MB6588:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a167af0-ec4f-4b15-4df2-08ddf6c1c02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lT8S1oRuZ688kYNSeWPArlyWqjieAnurv1YXMfILW7JpWFcxu5zx+7khJsb2?=
 =?us-ascii?Q?W8p5YIFLqzrYcuvgVyF/aumxn2aZU9UrDBm+1Ei4hw55v6xVRBJ9Nltv02YR?=
 =?us-ascii?Q?iemCeVvWn2YeBCone5ePse41PQIEd7WHPPPBhkyqPxiQ9qMZDckZzRs9jG13?=
 =?us-ascii?Q?NoZc/wDzoTGI5Sgn6xiItM57Z3Fm5sN29APIgBu6H+cH4npTIJaTaHo7kFST?=
 =?us-ascii?Q?GTpz6rh2iA9/A4Qxly1tJ4vKgCyIJs1e9AqXzVvxAtsM7XArEw4vTnu6wZSF?=
 =?us-ascii?Q?nf3gslnWcThaDtp4v91+o0ez8EBcTXUTCsNo4pIRmLk7lgqBOjNSh5sDqaTy?=
 =?us-ascii?Q?sf1z1panw8zmBhqsxJ/GC8SRHo/Se8PTo7oat/FXGvQJZc5qyYDqppYEXT59?=
 =?us-ascii?Q?7fIOgPW0xaRtKqXZhPRhmuNyeZqmQMsWWxcOc9HDFpSvq7cwDr0lNzKuGyyh?=
 =?us-ascii?Q?jNAVFROG00NOcI74nRH2l2n6Os93NZh4TrsocNa5uIbvwXr44KNhnSPD3dMm?=
 =?us-ascii?Q?ieLlh1RTP+Z/1aMwzWQ9x+nhLhNv0nwUbfG0274zkXF6UzGC1ScJF0TSb3IP?=
 =?us-ascii?Q?nX5VIHBaoJCSPazS4dhJedWQtvy4XfNqA5GPPnsVvYvy+bA6Frhs/xY9H6B2?=
 =?us-ascii?Q?QNZrlpmCfeuBJWfPQuTSziGhGn7OxxgwaA1YqeoIMcrPCfQRg+5/Oa5bbNoC?=
 =?us-ascii?Q?ytMIj6+RidIx0EwtVhUqA9I/VWz7rKEkjlXvFG1bFWED8sv9AtjaKFjIQT7T?=
 =?us-ascii?Q?eBszNauK0wQsVUT1/nXnHoUj/4UFphmVmJE/+irjDCrxiGQv2FuaRyASI2Nu?=
 =?us-ascii?Q?SaJkz8BdvMYabWAfIh1rrSQa49GSy9eP9PB19GVdl8X5iqvIjdKmVrcyj61g?=
 =?us-ascii?Q?tkQDoBN5+uPLa1Ls0RNcG+EdpaxS4uYdhwMqFLLuVhR9Yllx+YtaQpe8rdTt?=
 =?us-ascii?Q?UFzD+n+q7m11LMaxMcy5i+KYUjL7rOQ3JRnCA1CPEewIgcP/PV9oav+rEe16?=
 =?us-ascii?Q?19c8LFd56y1px/4iZRUikqRH3qcZWctMB5BhYU0AAbQk0W6ifUrFUn/4TNlK?=
 =?us-ascii?Q?SI4Iv6kks4rrL3OPvqMjhDu/Do3P4wG3M0T0V2CRnSc+s5y7BjN6wxnF5YeJ?=
 =?us-ascii?Q?k3iP3KuHPK3wXc6I1xuzTWJ7DS83bscn/7xvkIWzsQNQV8vzvje6onkD+xoV?=
 =?us-ascii?Q?myHcDAkiPfDx5Po7ao3uzGuXIal4NC6tWwYfYH6KQmxRuF1N0AMoXqerrP4e?=
 =?us-ascii?Q?t3n8rxbyJtAdWnMHVKEKcrhnMEFSLG4Kj3djYvQmgjVQodS+Ul7z2KnPmqwj?=
 =?us-ascii?Q?vG9K7efKRvcnw01GXyRiAokIZRUCjkQPMf3s5qhRjCoQHLf2ZKr55NXbd6yu?=
 =?us-ascii?Q?M2ixYSU5JUiN5TQsAoTOxaGr7TiV6m5HLQNwcMVXuHe6uJl+YA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5757.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h/ZLOf6klA6hN3a+/a+bpzuEUmb4oF7ilQRu4rLKt4SOC3ZEy7+48nkqTFe5?=
 =?us-ascii?Q?TdSzox79bpUvwM+DfmPiwBzkrtqc58TJGwdwDXPkktjTFg6I6q0FfLhOc53T?=
 =?us-ascii?Q?KbjdayFi6ZCsm6IdVH9aRwvo/YAjoHHrwLitdb+gpa4S7E8WLuLbdlkMBxrg?=
 =?us-ascii?Q?nm/ylbFpOAIwVjwUnsi4PInSy56E4T3h/ttRqCsYNFP/oDhK38b71y98RxAz?=
 =?us-ascii?Q?NORtLrFEVSN8CNPCUuYj8DIctqBvsWQ0Inx2eXZ32XMqa9ZXtLpnLgXzRjZC?=
 =?us-ascii?Q?lmBvNEApLykGMZ9uzKSm6AatG9PZQ1sXqnA4S1qGloJCXPJ4Uyx2c5Xs9jkT?=
 =?us-ascii?Q?N4vbnz/jQRCeCMVkn3j8G2rEI1AiMgH5zsVFNXZR1Hkow2dAzw5+jwN924U9?=
 =?us-ascii?Q?8uHQLNeJl3CxDelegjAJ1g+8jbEF776Nor12tDoQz4LMb7xxpdwpBiVuLVIF?=
 =?us-ascii?Q?OIYJk5PyizCcVJvW/ur4dy/ud/Fzr/1nXuSH79VMEkN/V5p4Wx/Scq94qOZB?=
 =?us-ascii?Q?jUHw/a4OwuxEbqtm7HUPAhd2JYuvco1BVJIYNqhkYzWkmpOZR1T9CqYjN8+R?=
 =?us-ascii?Q?UUQ7HrO5OVRpQLveXP4MvhUpNgebNs8wcGMo4KNPogKrQDQkwTAljPd0ol6D?=
 =?us-ascii?Q?IsfyGHE2i9pbstwxqLmbBZYhu/ans2WwrXwlJSgiO1bf5m9IPr6EBmX2a10x?=
 =?us-ascii?Q?cpVBJ42Ib+NURZ20CQEPpc2F1zLhVrd1mwivxjCbBALz/ByLUt9fry72TWqf?=
 =?us-ascii?Q?Q+rQySuL1OvoKzfbOzuFj+neJqMf2YEnV3mrKJ2Cmw797YZ2FQP1rHMT2ufm?=
 =?us-ascii?Q?a7jJZ6vlbLelVmFPz2ScVKDybBO0pC/kwDW1SPIr4stw0QppDVC6YZyGD/HB?=
 =?us-ascii?Q?KpA39Cdj6t93vbIrKz3/JOKzpOJqI/Ey850LijsrThfyqvhDFbByHezkppeb?=
 =?us-ascii?Q?UAgbVPuZmRLsxLw8YgoQoNnCTjXGJn7zJmjnOg6bmWes2Xbs2x+oH4b+Y7E8?=
 =?us-ascii?Q?X8ldjwUjh9JYShYkvFYK8hx91iKZedDAFh1mbMdEYdpqi2sTH1WHulUIq8bf?=
 =?us-ascii?Q?C4y7FeesOnXMcthPyxktPdCARP7JWuJpWoC4di85XKW2pBMbHVPX6jq52OVx?=
 =?us-ascii?Q?YEzuU+qgDgalNevo9jteMy+1F/EMIO/jTZUOb0je1oDqea2ID6mbV+JLWIM6?=
 =?us-ascii?Q?gxv4s3m72VlmRztLDz7mE5h+pITMxhNZ7xNYWPzk0DpTR0xE2V5tLb4D+rvb?=
 =?us-ascii?Q?xEB/9cenn+buUwVkA0IUFV5GaIh22LCDIyyqWXMILqZvu9rwJ1z+Id1WE6q9?=
 =?us-ascii?Q?BABNdpLrz7tkaLaV337u4G0RFU0KZoyUkzm/yKptLT4Re/ijkpOc7tnHMflJ?=
 =?us-ascii?Q?OS3cGuI9mdIgtdOPLqAfvg8UVh1yGL1FIiKxE0Mt1cyiW+It6AmzYD3mVziv?=
 =?us-ascii?Q?1MZmIKcWiIZkN+amHDFR4vejYZHjXeaejsDKn9BQYZwNhzsWnRt+m4/vObvN?=
 =?us-ascii?Q?vhOGMAfyoFygEaCLP5VVsvIOM1YcQz4LQC8SLfnqwPGg2PkaG9nsmHKGa6RS?=
 =?us-ascii?Q?p57YdYe4wQ77jhMr38o=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a167af0-ec4f-4b15-4df2-08ddf6c1c02e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5757.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:43:37.4891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOSZC4NofJSBPm+bbkepmo0Qf3/6U95tr7chTph3Qhx6kyNdYKzbg/y5vJvg7bzH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6588

On Wed, Sep 17, 2025 at 10:07:38PM -0700, Nicolin Chen wrote:
> On Wed, Sep 17, 2025 at 05:01:47PM -0300, Jason Gunthorpe wrote:
> > Fix this by putting the core code in charge of the file lifetime, and call
> > __fput_sync() during abort to ensure that release() is called before
> > kfree. __fput_sync() is a bit too tricky to open code in all the object
> > implementations
> 
> Mind elaborating this "too tricky"? I thought that we're supposed
> to use __fput_sync(), instead of fput(), in the alloc function in
> the first place?

I don't think anything should be widely using __fput_sync(), that's
really weird and special. Our strange refcounting cycle is what
motivates this.

Drivers should be using normal fput().

> > +		/*
> > +		 * files should hold a users refcount while the file is open and
> > +		 * put it back in their release. They should hold a pointer to
> > +		 * obj in their private data. Normal fput() is deferred to a
> 
> Nit: there is only one file_offset per obj, so it should be "file"
> and "it/its"?

Ok

Thanks,
Jason

