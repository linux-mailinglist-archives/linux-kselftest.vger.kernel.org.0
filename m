Return-Path: <linux-kselftest+bounces-24311-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D3AA0AECE
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 06:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F84188753B
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 05:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C4D230D2D;
	Mon, 13 Jan 2025 05:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oEQD9peO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4D914A60C;
	Mon, 13 Jan 2025 05:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736746682; cv=fail; b=oPa/YkZ2HOj8KzgOFafsl4Orw1Ez8mfiEwelZa5JQHRhvduwGnoQWY50dX1WfLQU4OdfhrSJdEnc4iXX9WYYBP/WF+iynsg8w+iCOnUCotR4WZ36FXm5+/r+NoafHkN/3d65RSn642eInY7Cj0AAUWBMgszfzWILGbKsvd7sylU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736746682; c=relaxed/simple;
	bh=Ld3VW6jlzVJHuBWQC+PINE37qIstQducsAq7VP9o0QY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3oXnu7npJhqdj+jH6K2TRH+ZOledhBDeOxW3YBDlrA0QAco4aALFx0Q/+d/ji/PWbjXDxrOVTCd7hxgAFXSfBtymL24bL4GgmCqnrbIam3fbRV/H7vxmsyj3mwxUqKaQrviCrGmKYtln8V6tJkBzTTuls6Ylq0T2TLQw5q+hbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oEQD9peO; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sqpqB0WhZH66O4IrT/tQGYCEHLmVeaqWGCM1NXkPbFdmetbd8tIiRp6k+wivM2BJwF6Ybo5JXvTQmzLvIxFomJNl1iGOY11rIrKzuQ2IAW7uczOm0J+axQgEaEd7nvJu2Gz/6ADlCEO6wUd6j6XxARfd16+RIFeez8poL2uaAyCpWXc9dWLS3iFLXyZlPGrlh4qIYUkiw9GR6Sgy1eWH3MIzbxF91CzxzP3Bfl5qAkPZ4PE7bQIjAvv46cJZnBLZMqcBuAl5PeODlLH53jOLdiUlwTi9IOXO9p689zyViCE4XcDpmY5lZaKmqZN+H5A/z0S5NOj7n0cxh0tfnPqsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC7dAT1cm3S9lm5BjcfdsDD451BrotIPbGb04BcZtGg=;
 b=rrr37O9lK+9uYDHlHhcwRsXPUkH+k44LpRWns1qcgZQDEIsJseiRh58FT3lE8DLpK37nsBdf1TnC4oipFYL4HlK7nA7F46ofsppHfXRhBiP4o0RJW43ndJcE+xkk37x9z0nA6ImL+cJwdp5tMPzvi8NrfL62cOUP1nczAooafOTcI/I+VF6piK7Zp2MQKg/uc85CL0qCLeywMh3HEsuEWK8NB8jcgcn0CvOZrl9SMSMawNocL/3Qx7hX5WTJuGhKPu7fTM7gPrC9TnyzhQnuBoTBIYHHxK1UtE0IU4ypv4cRH0I/h42fWtLfKSfTfv3wffSajX8rw+PbooXh/6NPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC7dAT1cm3S9lm5BjcfdsDD451BrotIPbGb04BcZtGg=;
 b=oEQD9peOlcVhq5EKjs/YED0Z+ipBDkYsGV54zulIjAy90PXor0Y5DRjsibxL9iHSQChYOuXuJouGlI3RVkwAol79hHyuuovdh+dQXdpubtSD4NkQGgHQICKpSx+b7+F1Rwg6tAtfeo2OrwLeeWLDXpblkyCynVMmv5juxJ2UbXTKBkLha46ki2AqbIT9JbnECito1PU2Xsz/lfAyXyYeEL/PY5bbW+hoEOQcJITgYkJ98yHVh+pZKHFTlmzWP4sHUrekBiJtPhB7O2wLtSVkI2zF/dfg+dV7fEXrRYp2ve8likqUosbwfT+KkO5fm5A8fLg1+5NNpjFTkQ3298ExpA==
Received: from SJ0PR05CA0136.namprd05.prod.outlook.com (2603:10b6:a03:33d::21)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 05:37:55 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::6e) by SJ0PR05CA0136.outlook.office365.com
 (2603:10b6:a03:33d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.6 via Frontend Transport; Mon,
 13 Jan 2025 05:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 05:37:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 Jan
 2025 21:37:44 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 12 Jan
 2025 21:37:44 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Sun, 12 Jan 2025 21:37:43 -0800
Date: Sun, 12 Jan 2025 21:37:41 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <will@kernel.org>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
References: <cover.1736237481.git.nicolinc@nvidia.com>
 <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250110195114.GJ5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a574c76-9cc0-4808-73bf-08dd33946e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0JfM7h6EqTTArKnlpH36ruJ4R5j9RslLlDLZiwCpN755PRsb4Q5u91uMNVC5?=
 =?us-ascii?Q?ajvTu2MqnKxWUldbBW53cdIg83HpVAfzpa/cIAYvntG6D1tIHzAbehRyxGaV?=
 =?us-ascii?Q?ONbhxwEweKiQ+Z8MhJsNE6dcVEA5CSAjsyjfBuAld05Oh00Ea56zY+rr40sp?=
 =?us-ascii?Q?MiYHkLfKafhVzfM27Rnv686KTr8uDah3ObbZ/YgkKqPnwtchvhVnA+daIM4j?=
 =?us-ascii?Q?1gUe6cqkHjtWaYqlDwcg2Ow0eRxLz1n38FiW+y5hShqkean0l5I3YmOBm7S9?=
 =?us-ascii?Q?JNMTAl4DoMc8wCFwkPVVT+qmVKpn4qySvSWAZJjX/ZaQVSXVZ2uqtOfpTLWQ?=
 =?us-ascii?Q?8zKRUlHOueP+X/q9lrtZo23pdXqFXTepjMkPZ9mzK3Lpi/T5ZnAMsBNwXnDj?=
 =?us-ascii?Q?DJGGC7sxMORM6ieNNs/k3YvFvJXF94Rb4Y8FvmfajzmNP++8G129pToHKipm?=
 =?us-ascii?Q?aQTe98zomELL7lJYn8iN+6GYxScBE0mtsj2Db+IItE68GYrAgGC7zj3JwWcT?=
 =?us-ascii?Q?5S8cuQkRBsLT0uRAlcAtvppX1DZerRAMo0TshqZ1jO7wpur7OUM8ZpxMJaWF?=
 =?us-ascii?Q?Vl7BPXa8uJKCmaY81wW/6QgJfqNyKfxvOuv7u0aCeyKD26WZd/9Fhqloiufg?=
 =?us-ascii?Q?dKozI4K2FL3+QuxQvA8f1c92gnnGqwesThHm1nBD5TQJXYHIuoeZXdAwdjkB?=
 =?us-ascii?Q?C+oFI15GAY/8dm6fJHCxcch+amjBGQhKGwHLAS7ENcJXjM4AaYkY38Q3qmd5?=
 =?us-ascii?Q?HS63CDPRJux5cIStRjHnGbrYzOpc+hpTqukWF26/Jlqz3rdOwM1B4rBFPkD8?=
 =?us-ascii?Q?2ru1r+anDFFoS659RH3OfeU1pMFIkoEogv6fMUEwfyWj2nGGc+GldAEgPhyo?=
 =?us-ascii?Q?FKvwuZuFUNm1Ipj6t/pfhBdJ96qYADOae/cAwrBAMYU8zkTXuVXVPizOknu2?=
 =?us-ascii?Q?DGNtK9icZ8bpVTbtjEFHaZ63wefSvaPUEP5SO8jY7Qe+bTIp3hUWE9Dmyg7R?=
 =?us-ascii?Q?EsmSf1xyT+s3nxAsCRSRWBfbwd56wBqquNVxUouBXgoXvvD9OHvL6MXVHfWX?=
 =?us-ascii?Q?RO3Fs0YjCYCOT4HaDrJltYC319JRfeF2Ryejck6G/gIUZvW3n56ig8JyMUeB?=
 =?us-ascii?Q?BCKIWqDADEgx7philUeleBjsKIFW0uVLc40VbR4Ot8KX9+geBzF/OvrHXbXk?=
 =?us-ascii?Q?6cOsBU7eS64lay8mOG37fcYEXBf2hhxT0tcmm2RTgey0G/vXdYns69vjZNAe?=
 =?us-ascii?Q?rNORUqvkrx7caeAoZwTxCDDXMlTGSenVE+juaQ2BV8YYOzyy1PD5f5dpZkj2?=
 =?us-ascii?Q?RkTnRAO1oHHd0OeBLUF8EgTbtJdQ+8GnOm1ByauzV6muZqqw5xP8MQof/Kxn?=
 =?us-ascii?Q?OSEaYAKS/iYRz25a4PNYh4eOLsalcNUmMI40A2vc2hdcauhL9ZaH0gGkKWlc?=
 =?us-ascii?Q?5mHSDfQUCaN1BQm7KUf6BSonz4HJBFBUYWcQXPHFkU/G63JgbDuijza/XLlg?=
 =?us-ascii?Q?rYhTytqu8b7wdbg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 05:37:55.3581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a574c76-9cc0-4808-73bf-08dd33946e47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

On Fri, Jan 10, 2025 at 03:51:14PM -0400, Jason Gunthorpe wrote:
> On Fri, Jan 10, 2025 at 10:38:42AM -0800, Nicolin Chen wrote:
> > > The virtual event queue should behave the same as if the physical
> > > event queue overflows, and that logic should be in the smmu driver -
> > > this should return some Exxx to indicate the queue is filled.
> > 
> > Hmm, the driver only screams...
> > 
> > static irqreturn_t arm_smmu_evtq_thread(int irq, void *dev)
> > {
> > [...]
> > 		/*
> > 		 * Not much we can do on overflow, so scream and pretend we're
> > 		 * trying harder.
> > 		 */
> > 		if (queue_sync_prod_in(q) == -EOVERFLOW)
> > 			dev_err(smmu->dev, "EVTQ overflow detected -- events lost\n");
> 
> Well it must know from the HW somehow that the overflow has happened??
> 
> > > I supposed we will need a way to indicate lost events to userspace on
> > > top of this?
> > 
> > Perhaps another u32 flag in the arm_smmuv3_vevent struct to report
> > an overflow. That said, what userspace/VMM will need to do with it?
> 
> Trigger the above code in the VM somehow?

I found two ways of forwarding an overflow flag:

1. Return -EOVERFLOW to read(). But it cannot return the read bytes
any more:
--------------------------------------------------
@@ -95,2 +95,3 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
        if (atomic_read(&veventq->num_events) == veventq->depth) {
+               set_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors);
                rc = -EOVERFLOW;

[..]

@@ -386,2 +386,5 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
+       if (test_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors))
+               rc = -EOVERFLOW;
+
        mutex_lock(&eventq->mutex);
@@ -398,2 +401,3 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
                }
+               clear_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors);
                atomic_dec(&veventq->num_events);
@@ -405,2 +409,4 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 
+       if (rc == -EOVERFLOW)
+               return rc;
        return done == 0 ? rc : done;

[..]

@@ -554,2 +554,4 @@ struct iommufd_veventq {
        atomic_t num_events;
+#define IOMMUFD_VEVENTQ_ERROR_OVERFLOW 0
+       DECLARE_BITMAP(errors, 32);
 };
--------------------------------------------------

2. Return EPOLLERR via pollfd.revents. But it cannot use POLLERR
for other errors any more:
--------------------------------------------------
@@ -420,2 +421,4 @@ static __poll_t iommufd_eventq_fops_poll(struct file *filep,
        poll_wait(filep, &eventq->wait_queue, wait);
+       if (test_bit(IOMMUFD_VEVENTQ_ERROR_OVERFLOW, veventq->errors))
+               return EPOLLERR;
        mutex_lock(&eventq->mutex);

[..]

@@ -1001,2 +1001,5 @@ static int _test_cmd_trigger_vevent(int fd, __u32 dev_id, __u32 event_fd,
 
+       if (pollfd.revents & POLLERR)
+               return -1;
+
        return event.virt_id == virt_id ? 0 : -EINVAL
--------------------------------------------------

It feels that returning at read() might be slightly nicer?

Thanks
Nicolin

