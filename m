Return-Path: <linux-kselftest+bounces-19697-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C626099DC02
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 04:02:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 849D028347B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 02:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144D7159596;
	Tue, 15 Oct 2024 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cEen0aRi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2114F9FF;
	Tue, 15 Oct 2024 02:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728957721; cv=fail; b=PmDcrHBhmmjL0z7co9QxNSITa4cEcAIeftrI7389s/C+zZ8e2FAHaaJkYpZIloAmomFlnJ5uTc/C2p8n8c7IPT/Y8yCMbH+Ecm24FSORWETjGcgBv5PDlevSm5IYXr8eA2Ewazc4HubdT0aDXcORBVx+DwqH97KdZlPOSkxS4jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728957721; c=relaxed/simple;
	bh=4cSU1TZFucouVtdNIvaFgcfBvlezjLhwIQpKb7N43iU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgDH/4JqaCx9eJXlnGZSA/RW6h0vZ22+PlxznqrGZXNXXvoI+f6xEubti0l2pZ2CVRxePrXUQXV4/P1ktJvGJVg0+JqwPQhbS+R/3ta79ckDvE5Gnc+cCCOmfKzusr+PFIPHkH1n1383nM6Tkv5bwtVLOQ3jKHaqc6aJsrFr8HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cEen0aRi; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpNsRgbZ6gx5bGI353Sc5dLIIkxOxBRPnzNfYkS16nnSfy8QIROioZWtYIQxilzFLr7re6X8BvTMx4MOZkz72jLhvMiM1GLL4YkYuwpHBHeTe39JFGFM8N1Jg72qBTeUPL2zKYSlL3t3XFDZ5e0aVS4mDyRZqVv9gtH6Ofjr40XtodNxmUpX+2kmRvCUWLpmJsZkWnF85aTBvudBM2NAAuScf6BmgJJ6bmss0D0PLNrywC7jXCVpt1W/3a2rHTIUnfExYk3Bb5SSDLEsDsTWCC/sqJCz3MQiebiJD1sKnMyE1dSXuuRcfU3IDmjN9O2HRHm5FV5HsDx54BBfs2b/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5Ps2CAKPpJwy7nUeVQPb6Ut/8+UDPvqAhFKjqwx7uQ=;
 b=RQn86+u0eGeIXkcRvnbVut9Cq9QA8wGToahWzOUsvVL6io0AQ6uI1yqS8Tb+z4aayTdOxs0x9MHMTD5bGnub3uvf+M6rpo1a9peIeX61QlqRdKic1cu3BfrKxwOo3QHhuPKhXJJx0WQEtsgszZUEKqJAaJBTyY/KS1crIeBMoEHgIn7SeNEYmno1lMvSEYRe5hBjWO6CLzY06DyISZpw8EKg+1nH8RxV6cPQhDwTU+2Qn29BTw8qGZvc9SGlS5qyTF00bfySojgYOat+xnfZn9Uvc29Hq8ZbJgIDzHoSTruEYrRwLXIIno0D449XAnaCV0qrK7UyFsl0MG3T0CyRaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5Ps2CAKPpJwy7nUeVQPb6Ut/8+UDPvqAhFKjqwx7uQ=;
 b=cEen0aRiHhApGv6lBj/3a8dl6h6259aXJ/jTSkgP31DC8Ve+nD9rhX9x013LDXkrgR7bUQT5URZ4I7YKlD9jX0qHW6S3ckTeL/NnL9W377LGrk+7KkkLKb+8s4vpUqtUTWGg9FuLaye0Y2EtD/F4qTXEThSJ5y592ogBxS6UdN599PGMbbZUEyJcKK3eLBXCG+nd23CBPyC0RFbo7Pw0d5cgA7qExvaI8X/LTx1TY8frt/sa6boO2+ghmPaRMrUKG3clxb378k/q4p82UyoGdgQuorF+HPCUJDcyMv7MNN0VKLM/0x9cB9YoTWss3GTdWDDFFk1cYgsmaM/jb0Solg==
Received: from MN2PR20CA0027.namprd20.prod.outlook.com (2603:10b6:208:e8::40)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 02:01:56 +0000
Received: from BL6PEPF00022574.namprd02.prod.outlook.com
 (2603:10b6:208:e8:cafe::75) by MN2PR20CA0027.outlook.office365.com
 (2603:10b6:208:e8::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 02:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022574.mail.protection.outlook.com (10.167.249.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 02:01:55 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 19:01:37 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 19:01:37 -0700
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Mon, 14 Oct 2024 19:01:35 -0700
Date: Mon, 14 Oct 2024 19:01:34 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Zhangfei Gao <zhangfei.gao@linaro.org>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<eric.auger@redhat.com>, <jean-philippe@linaro.org>, <mdf@kernel.org>,
	<mshavit@google.com>, <shameerali.kolothum.thodi@huawei.com>,
	<smostafa@google.com>, <yi.l.liu@intel.com>, <aik@amd.com>,
	<patches@lists.linux.dev>
Subject: Re: [PATCH v3 03/11] iommufd: Introduce IOMMUFD_OBJ_VIOMMU and its
 related struct
Message-ID: <Zw3M/h1KYe9MjcZK@Asurada-Nvidia>
References: <cover.1728491453.git.nicolinc@nvidia.com>
 <88114b5c725bb3300a9599d3eeebded221a0b1f9.1728491453.git.nicolinc@nvidia.com>
 <CABQgh9Eaj_vy1=sS2Pf7RC7Vy5PopDfwoshECULEU-jK3JF_sQ@mail.gmail.com>
 <Zwn/4m8Ac0xEiJi8@Asurada-Nvidia>
 <CABQgh9Ft=xxJK-bjS6wCZ5BN4AiKtF9fzdBkevA3x2yb_4O4Kg@mail.gmail.com>
 <CABQgh9HP1M8GAXMwf0ZNn5EpMBAvJU3JLRWcN5H1wfGrqXSe1Q@mail.gmail.com>
 <Zw08z9TOFL57z07O@Asurada-Nvidia>
 <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CABQgh9H-SB7q1v_XtWaO12K7jMMaq8Lj7F4kpDv9sJ5v-F6DZw@mail.gmail.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022574:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: d4f0adc7-fcc5-418b-198a-08dcecbd5884
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9QDtV321rwDiY4fFKIZzWYbAb7+Fji9R3sJJzx1TkGMtBqMlmJ1vNfosWKCb?=
 =?us-ascii?Q?+kiqx33k4iiJVH0prjq/VhF9/KBaNMQrIen0Xz+2r6KFBSCirvQuB3R1idak?=
 =?us-ascii?Q?xIbOPj6XufHD+yFTEp4RHzJHnIt1EKZ5IIrjmok1GrAxrqmMXXuulsKGxe6x?=
 =?us-ascii?Q?LPK0sxMhARybraTuExMVM0yo/ihaNGuviQTSV3e1rOX5qkgjNNCqXNEdC2/X?=
 =?us-ascii?Q?0Y0oAaYSLue2Kcui5tuUJp7N+HNoPze8hqWi4XHhHGb0MpcIuX8o3rYBRhZ/?=
 =?us-ascii?Q?1OHMztCdNEulo9PYiyMq+3yy908FiSllrxQbtdLmGDVuR+shzIcc50qeLzHz?=
 =?us-ascii?Q?fhyohuW6TYYCS248XQyOpwnhilnGq0piMp6qyVVx7d4IdLdr4wxfGEc+SwEg?=
 =?us-ascii?Q?RQdSo8Pq7OTBrYlm0xRZlv9vlXlr+GyMNIh6tkv7viC0Q7r6+Dxhm4D2MibF?=
 =?us-ascii?Q?k2Z6Jk9muLTdRREt8FnPvdhmVyT2XL+lNUlFJHQwptRhBLN1bVAPHgfdjc3C?=
 =?us-ascii?Q?guW/ls2bJfbMMiFnR/KoAyewxxH3pPu9DdBHw4B2+cqUWO+PYB95HOnJuup4?=
 =?us-ascii?Q?q7bcrgK8AydSHPfvpnusDtAoEhNAU1cwN9Z7OQuZZGnpRggs8Pj1htxCaLh/?=
 =?us-ascii?Q?cgamM/g3nrnwNAk2kO7rQZ+iS2z5QRjnHyN1GVfHK9s9DIn8KxjkSp+ejObF?=
 =?us-ascii?Q?MCLNND8xWhEceQ5WM5xAdJ7yRAhwD2k6R0E9NCGMF+4mocd/Zx2xN309Xb42?=
 =?us-ascii?Q?Hhg8vB1RDYA2rIpkLtqJO7JklI8BdJZATolz8/j4RFIgAmMZDGFo+QNmavfh?=
 =?us-ascii?Q?DXArp5KzllKa1p9rmE5R79KHviVPNxOodjEqx3qf1HZAQ4HxT+URQerQ0lnW?=
 =?us-ascii?Q?PFHQCdGUOMDGATKxy7FBgkPhS9DpG4n9f+nCRAWD9lMUCVwLDpGRvT8aDI0N?=
 =?us-ascii?Q?qSHeSCP3EWtR+ObO0t0YYIB60K9j7LjPfioPIDlg2usmm8sPBzXWz8JzWnpO?=
 =?us-ascii?Q?wQvtPx4piZ4RMIO1WYW1ivPRHrf14A1kq+C7up/IPiZS8Jzm1TSKKNcrLSx5?=
 =?us-ascii?Q?VfdH4O8xdG381MPUT+BWbGzsIE0Lb7Dh/GyJECawUn2IkOSjgjGnqLMp11+A?=
 =?us-ascii?Q?bS3UOl1sNcvjTgnifpz1CSEWiRkrNOG8hyuvelJjJgz7M17X2Qooen36pUeV?=
 =?us-ascii?Q?4ZNcOcMQcGU+WCAEEGpLDXcg2+CrwciI59k95VoLVwRETCK6qLx+SUWf+ytf?=
 =?us-ascii?Q?B9+P2tPft0TciyW+a5JzFlIkvZzt30SistltC/fO7b8NcW4II/RZBKwd48US?=
 =?us-ascii?Q?JpuEclGXz93KmpMicAeQiLy1AR36QZTcHCHQjyNc3oQWfLOLunnzFqZqbbDc?=
 =?us-ascii?Q?Vro3GfQUB7j4knTQ3rZVl3nwAe8P?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 02:01:55.5762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4f0adc7-fcc5-418b-198a-08dcecbd5884
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022574.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

On Tue, Oct 15, 2024 at 09:15:01AM +0800, Zhangfei Gao wrote:

> > > iommufd_device_bind
> > > iommufd_device_attach
> > > iommufd_vdevice_alloc_ioctl
> > >
> > > iommufd_device_detach
> > > iommufd_device_unbind // refcount check fail
> > > iommufd_vdevice_destroy ref--
> >
> > Things should be symmetric. As you suspected, vdevice should be
> > destroyed before iommufd_device_detach.
> 
> I am trying based on your for_iommufd_viommu_p2-v3 branch, do you have
> this issue?
> In checking whether close fd before unbind?

Oops, my bad. I will provide a fix.

Nicolin

