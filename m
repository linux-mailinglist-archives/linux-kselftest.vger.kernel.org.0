Return-Path: <linux-kselftest+bounces-45573-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5B1C5946A
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 18:54:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 142AD3AA79B
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Nov 2025 17:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878F13570C6;
	Thu, 13 Nov 2025 17:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UuKfaNfD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C86350A04;
	Thu, 13 Nov 2025 17:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763055911; cv=fail; b=OM2c6cfGpJW7wRcb9H4H3weVBbV+RIxZ1lLBpagVK8xwenxpqNS+zE87o9ajo0AvsypODMqUPhB/lN90ZeGckXKTC8UVbl+c9qMSA+84vzSVg77GjxzStXgFWvLXDVi2Lg5Kfrb17IaEpOpHFp605zxn/YBDUa579Qan57Kr/lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763055911; c=relaxed/simple;
	bh=CY2UEh+leGovuJdyEg9GpT9gfgGs2MSgFIJO78wY0dk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iyl88W32P8dd6ResOTTduZSYejQO9yZ3V2EVtOLWs/pNkNInq1+77F4CfiIie6XEvvVwwEXAETjE8TThvt3A1hSnlqbM2N6sMtWdCHEu1XXmwdP7sEf3lGnpZYkPJGJh4lvMtZVSncn0hkTlPZz5h16EvHlEYLHChFLAU9yOvjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UuKfaNfD; arc=fail smtp.client-ip=52.101.43.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRZXG3ZtO7hInUH5kFP2a+vNF0EPsRjyZqgVJT++nGJc3wW7ngLYt7SJa1JBdVX/x63SjCg0fIWzp9mNCPdnqkjnpfJB04NyZhZpXCv8tpx+RE+SC2uq2lpNoaCnBQ4xjrDB0grQA6Wtk8B41QvQsC7/mL06kRr/EjRQrTOFxFl7YieOj2+c4x3vEfJ7O6wcur1zHvhoGwKDS0g/P+TDzklU0EtVEGAdasG3lfjw5+k5Eel66ZTH6wf3VUG4iZEdhCSavMAsUCw4H7A/+4qaH+pJzrwAVnD5aYGAsLQoEOy1q6RhN7cBoANRcDGsdhPlhdt9eEDvQSrfcc78657IJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ddD6ndxNrGig7m6IvjtFRNFYOpnnqQzxf9WNt+ceF4o=;
 b=jokhiIlPIBXlBqjzxqbfMlwDg8TQG8GR6nhGbff+rmy6CKl98zmh6MCvN/+4VaQk7nHu0V8xKNYBt2qoaYQC6SNMh1tVreWanUfvAf0jyYCYNcOUOr3hJUbAXOv+9t9W1QLSbcQNTXK9y9282+pWCQNFsSOZAKU2W9xLST++fprbKNXIUu1ZqDe+ioic2Ea0Pn/SojW2+uK88+Moz+DzSpH6VQsKmrhhqAg+O0zjmqX1g4sbtJF+jtbgtRXBvuFVkheckQVIao8OjVKASHUeTJ6AIrrja8rDgxMr8BoMligX/li1uwzeLXWPyDq3AOCQv1qvVtuPzNObGk3o3szxbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.alibaba.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ddD6ndxNrGig7m6IvjtFRNFYOpnnqQzxf9WNt+ceF4o=;
 b=UuKfaNfDzBaJ71Yy6TT4focxRV3bgakI/NhUlLD5Ter04e1t7qMRB08UcZUtjfCp1b4xuh2LgrXtEYoYPjgQCMvTo/x9rkFzjKu3+zVh1IbFL/e9EuVTsr1EmpZkRlLD+e8wAHOUCkJtRb9B5v+aMOJita7iM85XmbmpJfttAZA/fwcKyuTX0dGG5QDVGQEnJMUjfX2hu8rD4zkDnvXqPRziG+hvbmpi6WOAophxJyj2AsAIThqHWs6DQrZkyO84h8MKugW/PMnbJSOpp/UT9P04+XFTlM5fxip5xdHGipiP1xCuQR0r4QKZPF2ux62u94zSyfJVS5yGSSZmUsZ6uw==
Received: from CH2PR04CA0024.namprd04.prod.outlook.com (2603:10b6:610:52::34)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 17:45:06 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:52:cafe::38) by CH2PR04CA0024.outlook.office365.com
 (2603:10b6:610:52::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 17:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 17:45:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 09:44:49 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 09:44:49 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 09:44:47 -0800
Date: Thu, 13 Nov 2025 09:44:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson <alex@shazbot.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <iommu@lists.linux.dev>, Joerg Roedel
	<joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, <kvm@vger.kernel.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-kselftest@vger.kernel.org>,
	<linux-media@vger.kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Shuah
 Khan" <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Will Deacon
	<will@kernel.org>, Krishnakant Jaju <kjaju@nvidia.com>, Leon Romanovsky
	<leon@kernel.org>, Matt Ochs <mochs@nvidia.com>, <patches@lists.linux.dev>,
	Simona Vetter <simona.vetter@ffwll.ch>, Vivek Kasireddy
	<vivek.kasireddy@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH 0/9] Initial DMABUF support for iommufd
Message-ID: <aRYZDj/rMg6qEGzW@Asurada-Nvidia>
References: <0-v1-af84a3ab44f5+f68-iommufd_buf_jgg@nvidia.com>
 <aQ4x7UiMMCB0m0dH@Asurada-Nvidia>
 <29f0cddc-3c23-4ab1-92d9-8c9918ddc187@linux.alibaba.com>
 <aRWKA4zBwi+JagaT@Asurada-Nvidia>
 <37715c7b-8914-4ce7-84a7-288a808d7933@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <37715c7b-8914-4ce7-84a7-288a808d7933@linux.alibaba.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a1ce46-71c4-4452-7f42-08de22dc6193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4MUJskqt8YTPlIqoijzGzAtMBrz3eU7mwphPK9ZAlVWi8oc/p5Kk7X4/oDZh?=
 =?us-ascii?Q?j0wOkQ6wqJZNTXf++JBhluQthNnnfED782rJcBkdXT7t6ORE8bnwLunnmuwh?=
 =?us-ascii?Q?aKX7FPRROxhwTDJm136K/vXQeTdY1yifdITUGxl7dn3tiAtN3rcYpmHfsmjK?=
 =?us-ascii?Q?u4qUkYs9x1k0GG6Zw3is1W1FKmkimZbkqiO2zl62Z8mjGHOxvNbu8FgcguyS?=
 =?us-ascii?Q?Og+uXabp5IHlGfqEHqa7q4x0FuXnPlMNSCHevOOWyHz3JesOcadO0Yh3kQo9?=
 =?us-ascii?Q?EFU34//DabWkH72Wmosj89FxpVcdBh85TJrEJVpX/qlF14SIQ16Mcb7cK877?=
 =?us-ascii?Q?qgRaeG1d1RaoXN0JZwAxFNWk8+0setzLNBiz9FS9WJ0OYOZRAQuot7f+e9og?=
 =?us-ascii?Q?dcAdP3CV3mgLyagupO22hXT9domsD1HIVUghBJ/hiITImOw3O8GrWp+UDOeR?=
 =?us-ascii?Q?PYImIg7ObNLhlHfkXoehcyjdl7tsxKbl7OzDuacAOrA8qUbW0lnkUDK6oz7D?=
 =?us-ascii?Q?BdW4KoSOqAsqxx3jWoHZt+m6uuFb3MPAGPL1a8sgWNd9RRdiHxzUohs4XjGU?=
 =?us-ascii?Q?XCXDWgi8QmnBZxLA9IOfikJM3re6pog6gTWID0U9bNdULP6NoohstljRed0O?=
 =?us-ascii?Q?bqcnqQYH4L99Ns+3x3Lxk0ztGcb0tducP1QXg3U7+/T/gtI6/V7gi08xyD89?=
 =?us-ascii?Q?ET5/QJGzRWuH9VHouP5IV5ANcEUklhh6rv5B7tJ1usEXf81YASUZpf/2IeL+?=
 =?us-ascii?Q?0Qzikp0SZWz3KYJtZ5qrJT9vXjFJ/hjKPEEQZq1pLbRUhki2UuIZKnNmVF1t?=
 =?us-ascii?Q?LtwBvWVsIXXD3VJTVz/d+n/pxS/byb4jPoQOnZ3iUp8x+4NbsAaZ0ACX0X0i?=
 =?us-ascii?Q?xp7GKMQs1oUjdD/TmCfhwlw9RXkmy9I8PVdqJ0ayTk1HeJ/3t1gtFo/eo2yY?=
 =?us-ascii?Q?OioCi96fcNsCvHiEahdRD/l9Lnlof9ENLqG5/Z0lnMFGUc5iXI3JuAStdJmD?=
 =?us-ascii?Q?u6OsJPSf53AoqsA/8VH7djPsHRvYdQ5JCiOMzkhV/k/F1XgG2wY0PVleCSDz?=
 =?us-ascii?Q?FsPdxj1E2gAJhpuEKaUqxi72ymgjh3ykTccWqZ2e3V+3n0NQkE6ttYd8g8qe?=
 =?us-ascii?Q?ggx5WrMhXe1hh4XztxlWdeF/oMpDtmobP7YgNUfallZOuxDwQNMoJDSw8iNn?=
 =?us-ascii?Q?NMPfleY2kbJmtQG9TCHhtgdh67sLoe+APxWBM1mG+aFqB363Od7/pI6plNbs?=
 =?us-ascii?Q?QY1tqfXTNYaOgAPmDapfTcOIsXFLyGx6w14mtbXHqCvL2ANfZYjtQSRAB6KD?=
 =?us-ascii?Q?nZILZYPthLYwSLjHJdpOcwB44yOIL02eYbkhiyDBQXQFETVGZr6AsWvHgVKu?=
 =?us-ascii?Q?M+N2rHYOCB476Rphg4GbAjrKBo1kI1OfHCNhGA175x5ympeXfXu8+NOpkeco?=
 =?us-ascii?Q?3H5sDiOocQJruDzjbgsAqiHjldKgbs4LyyLbTSCIIoUe3nxFvdcJtA3iicvp?=
 =?us-ascii?Q?DebuSX5ufHcIZKNZFxtCJplWx7ZtG9NpZg7LwnteG3iCcb9qXWpg2lzAZ/lw?=
 =?us-ascii?Q?pv5NxHxTvE/3Ts20s1c=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 17:45:05.6869
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a1ce46-71c4-4452-7f42-08de22dc6193
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

On Thu, Nov 13, 2025 at 07:32:46PM +0800, Shuai Xue wrote:
> Thanks for sharing the command line. The issue was with my QEMU command
> line configuration.
> 
> Using your command line, I can now boot my v6.6 kernel cleanly in the
> VM, and the PCIe passthrough device works correctly.
> 
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

Glad to hear that. Thanks for testing!

Nicolin

