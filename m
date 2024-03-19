Return-Path: <linux-kselftest+bounces-6419-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF8B87FF38
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 14:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90BF1F256CD
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Mar 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC64F8173D;
	Tue, 19 Mar 2024 13:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PXEXeHqV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2134.outbound.protection.outlook.com [40.107.244.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44B2E400;
	Tue, 19 Mar 2024 13:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710856738; cv=fail; b=lE19b9tUrb3J3ihzXfR58KWAZ6RWCNQMaHcpf37CjgtUeuqxN/Ka6dUBYo9sG8ANWwSOzEI/bb8wy7WgMeoz07dxmybvYAEiQJnrtTc5QfiFBnVtOtLydY2Os0rSJS4a6t4SXVDUyz3JEcHN4xvG7ODeEFH3VgYjX5j+V5WZhzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710856738; c=relaxed/simple;
	bh=CV+PABi84XLG6lRivGe+LIk8p5M16ej0zvvhE85Xzwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M17b+c06dZHmdm04ZTQtOuGXwHoaO8rrNoqaUwSIL98owQfJOV5qzcvD6J/XN6glpIH7WCvtZ7tRoeMXAWuTyvqGQylT/zmpviKLxiqG2ioZcSw77p5jBLRdIqgPNdggPXXdvN1x+TyPYh6tIHjU/7TF1WgSmkjnV7eOxiEjTmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PXEXeHqV; arc=fail smtp.client-ip=40.107.244.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEpvXggE4kNP8MnIvWBtFDZ0RhOFAF0HzQ1AC9cjut0Ffi+E9F0+0YW+27wLr7O3tCXVMwNPdnk0DNdp9BkB91Us+SP0knmI041sj0cjaUPJv651iyRgmOHnq1lMV4/ALGF36yUTZV+0dvsrVa2DHe31V1IuDdVaE+4qJfI7ppS2sUhuguvvMCmZ6m0KBoRccr2hibiI4DCZ/ipMLTjNPhhJnPH2D7pExlXcreR87EtIQ0UQbIunDzoKhK0hdZwyrdHFtRSaKt2ta5VBZMtvJbViTSIqn7pdUT19mjZgtTqqJEAiUqk8OhqSbs/5i4PX79bKirZCL8HUbWginm71Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soINAdAabQmCoWQcZPyan8WqO6U+tYsCxg5eaKQdhSY=;
 b=TUVEbvVi5stIlg+QTXM2DYJ5nBvcejRv+BxO0sGIqcaTfhO9nfqBddSJjp4MjXFkOS9r2apt6iEJRjIpukB0QBSvoMfMUWxlRCFQsqLgnxGYuTUR+DTdF8dMxxDe059nHxmVd8j+8wkcwk7aRJTC+nerwU6xchI7Lks9bjuJQOgkHXerNTT2cesNiH6KPPt+paCCgfdNkW340cPBt/Dy9qes4wzQO5AReIaJpYkxMQpgCLg5yBePvzHmZhvYrZc1NZ5VB3T8qvBRo4eiqmsD61JYpgsPI5o/COd4BorQ8iRzx9Nucn6tS6vo31eBil9x6IO4+kYmDA3atFGyHls9BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soINAdAabQmCoWQcZPyan8WqO6U+tYsCxg5eaKQdhSY=;
 b=PXEXeHqV4yaS6MHEhT8HlVqGrp1vc+isk6XjPWXs5tqWSYQHxhh4FmWtZiWaz9sXKN409ZlP1tUYXlId0DBoQX+XF0foshXTFrI/Gm8SK/OC3mdhA7aBCrxXEXeKY+yDVG7wmmFy528fc08XID3NIP1droLtzXk3abCF+9K336sW2d7+zjDFVepkLvSvFe5pHqD+FcCCwUwIAuqQs4AOV1/LSFhsbikvhEMYBp3Q5zVgy/4GJBAhbMTQn8bkvFQSx9k+1vOqqMFpX3IUViKzwg8wp0hr5s3NwgtMw7smzijBoX02vgHWZa7gf9i8EuPCW18COilYTrx1bLyTazidhw==
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CY5PR12MB6131.namprd12.prod.outlook.com (2603:10b6:930:25::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 13:58:54 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 13:58:54 +0000
Date: Tue, 19 Mar 2024 10:58:52 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] seltests/iommu: runaway ./iommufd consuming 99% CPU after
 a failed assert()
Message-ID: <20240319135852.GA393211@nvidia.com>
References: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d5c3b29-fc5b-41d9-9556-5ce94262dac8@alu.unizg.hr>
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CY5PR12MB6131:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zbrnOyQEX2Dsqf+nn2ic6nbrrICCyqaA+scwK3WEupz7Lc6/LtCcWMAF1sHa9cUuU2O/TnESDgXvZWIFbn/8gZM2nKWns2IlOJilTR3/a5wMJfvEwq8k2He02BY+x0bfbt2Tw4XSWS7Cy3enzTHYtPYyfywjTKmaqcsCIa7hw/icqBswnHiI6kstwe8skw8OkhXQJiys+qQ5jXvJYn5l7RkzMnZ4PMZSMH/3i2Rd4fWo5Z70JH3FvibIOvGKignCJYBBNWx/Q2j6HX8jCN1mV7UvXP+xwbNP60LlBow+yHJ8iAK5ACUDiBspBog6XSOHBSSGndmMqPPnjAJ6KhDUoqpfJMqBEk3PcRtKK4KAKc1ez5vyBaBJgxNRk2gWlsfneUBPhdI+2L592nfij2leBa4OJyQPyl2Rx3t3ywsJYu2nCs1ZFeOqkjn4CQ2vSC4HPfgeLayKulJTWt7HrDAPUNmsd+GCIKL3YS3MP37e/OISqtFVFeJizGPlf6u0qIfeHqh/CqschZ9m+G86DuZ7kY2hbSHWtUW/7lPpacynhW0Npi4cEbYmUq1Nf0bE//GYp4iKIjAJoF2Tar1UaC7Tuk9RwoKUzJXW04GPfKdHabyoWLBa2e/o22xgz0XEwCBy4qJPEwQcgJzMIwfJjqqjhBx57A0t2Y0EFl1poTGqBSA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?avlX5AQoelfxEEd8tdPsDDdUCOT/e4wPWzFQd7KWsNaC7tZLTrC2lMXgOVEL?=
 =?us-ascii?Q?sAwjmyUhZjE9bgZEyWgVN6Qok/JkXDHJ3h6mPQfydx+wY6HlqV5dJIXh0nFW?=
 =?us-ascii?Q?umla0hDsggKwPZXg4yzuyIwfz9kKVoA+qi4EmVGKtHEFYc11eG1gurgIGx8k?=
 =?us-ascii?Q?wfWhsREb7fZmkWNDp8g1DklEon02ujmRqaoOio9PsCv1TDqtrSI5jIVe5s76?=
 =?us-ascii?Q?swf4UUuVOaN4BxC5DWU9jW9L7f9iajuOCjvkUZlPg2mGKsyKlyD5+KU+IX7u?=
 =?us-ascii?Q?ZAD7N2QXY0H+Bh1oSUIrZaW8mrUkmpRU/isgkjQjVFLP2vKgFgpnmbsoJ8xR?=
 =?us-ascii?Q?LE0np1IBppik3mvZrkEt4Uc+ejSMsZGQGzwhuQCoFEvDVtQ7gW50fkBw8tBz?=
 =?us-ascii?Q?ptTDUg/Zg5+xqAVEf5a2h90nRgV1jdMZu4psMbKzTMp2WSDGJaH3t1TKvCp0?=
 =?us-ascii?Q?WFYSX9h6D1NXUb3YK5HAXQIGq0dgr82bR2q4n8/Ry6zAaacFWhWZasR7cAeU?=
 =?us-ascii?Q?lwmfSG8NIYenXx5c+SwKCNNXgRWhSF7MLophLMbmOIbjYeqvXOVkKWoDOu6R?=
 =?us-ascii?Q?FCEJf9SWQUOhZSqCxzlumypwTkxblSBDwmallmk0CL+t/qYmmQi5aFLC5QN6?=
 =?us-ascii?Q?DAPo1oaNFyA+ko6juoXhffnmnX58XwPHWK4cCrYaTI5l77U7p5M6Lw3YohlU?=
 =?us-ascii?Q?BKIwmMCn9+FbNNOqocz8tvwU9r753Kv2YT72Pts6ch44BnuYuuK7t4vCN2+e?=
 =?us-ascii?Q?Megj/J38piI1ArUOzK8tAfg+9HwPFI9/Mmj+u6E2FmGk+0YysBf6WfGknOu/?=
 =?us-ascii?Q?HzdPRVH1x1bVVSWl8vj7+MnuKa5jIfAFY7hKe+I1WN4whqTNll1WMO26xl2d?=
 =?us-ascii?Q?azRYfKavOz8XU2onvmzYFFe4ZdJVFWGVbQIsVcWHOZkEiXIFUZgG7h7oJG4L?=
 =?us-ascii?Q?AxyNbCJn/l8st7cMsAqxJdlTfxn1p19jxH8tS0ipo+05Lb4HHl4rV6sq6p38?=
 =?us-ascii?Q?PpZtU0bswL55bBYtuQPhFtXZHtlAMBq/MOSit5QYoYXj3KYs0QKH9hrlMZit?=
 =?us-ascii?Q?BDF8tyT/ifSkb13iYCoTMwcwhVsfWF9YL01cNXcE/Ii9sB6oOoBiit3Ol6g2?=
 =?us-ascii?Q?2ruEAeSdA8rZoPI8Vugfi+WwjkrxbArpgmpg5pTxSU+rkjO20pBh7uz4njYM?=
 =?us-ascii?Q?gkUCaQdgR2EajDJTs9UjiPYPLd/X49pBw3crZ5vt9eSv+2MPgq2mYYRWyWsS?=
 =?us-ascii?Q?07gkHi/hJKyoRfJfVu4hqUs/7JaBEaFSxp6JkQfhttehsyqCo+lUbECk6knY?=
 =?us-ascii?Q?P8LPdAoTXvO3Xp2ZQ/5Zr5rZbNBvcn25G5sSXVFBJMkjkWiBAgWFz4WalXso?=
 =?us-ascii?Q?fI1djHx/QDi/Vh5i6zc+bHITaLkkJVlbncuFhq11+tcs9PDG1IVr7fKARpQO?=
 =?us-ascii?Q?H86yxXavcwlFoITaoL3NqS05nMcrAl3fjcxRTvDUpFRMlF09vKMjjAEOD17i?=
 =?us-ascii?Q?kTHH12TjskuoaZrtx6DZos4iHdsPwx3NaXOC1wgLIoZT/YBWOjwPMACYAWWB?=
 =?us-ascii?Q?2UREegnU6dum0mNf0Xk29cyHwrjIcCXBNEI9tWza?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 544b48b2-411d-4f31-1f10-08dc481cb6c6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 13:58:54.3725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aThy+QjTBArT6DhWNI1KYOBq32SB7i34as+cXUszfI/5M4QvSnNRXhipVJqNmwoP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6131

On Tue, Mar 12, 2024 at 07:35:40AM +0100, Mirsad Todorovac wrote:
> Hi,
> 
> (This is verified on the second test box.)
> 
> In the most recent 6.8.0 release of torvalds tree kernel with selftest configs on,
> process ./iommufd appears to consume 99% of a CPU core for quote a while in an
> endless loop:

There is a "bug" in the ksefltest framework where if you call a
kselftest assertion from the setup/teardown it infinite loops

The fix I know is to replace kselftest assertions with normal assert()

But I don't see an obvious thing here saying you are hitting that..

Jason

