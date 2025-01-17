Return-Path: <linux-kselftest+bounces-24748-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35681A15972
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 23:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DEBC3A8ED1
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Jan 2025 22:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B1D1D63F1;
	Fri, 17 Jan 2025 22:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z+3jGdGO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628C819E7D1;
	Fri, 17 Jan 2025 22:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737151903; cv=fail; b=vGSnHIqJJeSwrjhl+5/rYt05hUcY0y1HPr7aYl+uNpwPmJZWb6vq2mbvtlpNiEdkjmj64IJSok9htzraBz1MMso0mGdfINZ6HRM/j2vKY0L29UWi4ViJpT9LL6Wdji/nvCfLfLmlwybUMfH7vNTqPSKlG8kON8hrDxJhYzeNlDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737151903; c=relaxed/simple;
	bh=2er5FGBPfF8GBZWJJ+AVtNTCJt/eUIApgnPNKCoAZPM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN9f38VsJ0wTnrgR8AhU+un0YTjY6c+gw2G/UUUjgct8mkHzViI9ZnE1Jj0YxFMPbikyimDHBEJk4KmR6JjeyKBG9HFQvC2fTyUbzAaz/ua30JL0m+XnQMLRGnaFt+JIBlMQ/mBgGLtktfX43DK9OdHoe5qkLd0XPHzv5AWMzME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z+3jGdGO; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE/zV0V94ZAfFiVPMkt85EcLV3VDnwd9ESyB+zadMb9HTlPcuB3uVGRTfEq07p+5O+w9Ftff1vg3Pgzxt0XFTD7XYXFRjUoMxwrI99Bzg3Q1ZsdAdTWjyrQJld1VtrcLNCdzNbWbGGbZzV2zHBy6JDetgS4t84+OY3Af8j1So7XcMSHP4QgXfuzDAwedfTt9mSjdRv1sXTr+JZKBu8sNtpNZ+PQU8oF9mfG+eMXSjQ3qHD+Xff0fxgLBPVEXf9zBJEpuHw5HQV0ZEn3uAQ33+V/Dt0pQnNQdr375/E2VeBYzyzWV+Wvmt1WaMdKNCuyXapK1/3iVP5miYGcc7SEXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyjqdsR7Vkbet2Z3z4TmkcOwrd14EAUzrjt8t8Aqvmw=;
 b=OVTLhXdlSYI6Bzsk9zg5nMNnXSZV9yDrYgJZ8P6Yj7wc7NdKWQeFnIpyFwUEOYIs/ct8xNEae/rkpVGvzqLnQoSwvYGG6+/OiEu+C8ES2a9Wa5FE06g7b32S1eLQPDfk+c/W/ffkyS+/RnhUlx5fkqoNcTADUfHJn1Zr+gV6Utyc4LzH8TbMsbz+h+DJxF+8AboQAwie+Cm9AbqsA0bIktwhlO5Zh24zydSd+2oqwzqePEQCEqM0AAA0ZR3FunlzLV/vJJHpZUWrWm/pZf7XSZUl9E2teHCr531GTRWNm1CRfAl9I8C3xRaQZtE6Z6jFW87a/qFtU8uEIFDIITaECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyjqdsR7Vkbet2Z3z4TmkcOwrd14EAUzrjt8t8Aqvmw=;
 b=Z+3jGdGO+bGl9tYV+ffUmlAhbk8zabTLl4vNUb2r2/Y+xDujk9rlNHLCB2H0ewTbsaWEE45/gAf0UXkn/UqIM8axcAWPJ/ZUKiWjMB2akqOwQrlzgjIsiGdTO5cEf/TxVxgQcDaEmL9CGiFcVHaMGv6WNFLe24bpgXv+QEBTeuGS+PqsOizY5eVgW+bMTlVuvjB/8nVb/wuG1TOAx1C21hX0hq5Pw+DbYn+YjoDTsv980SdIfmmTMg/Hhh0kIbS/RraEONicZbZs+pam3zPt9cEtlBUPZFD5Afiy62jKf7q1Zou1OcN3HCB7aTQ+e0Mez/lJA/OMHcWRtlBeW9YjgA==
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by MW5PR12MB5650.namprd12.prod.outlook.com (2603:10b6:303:19e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 22:11:39 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:33a:cafe::73) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.14 via Frontend Transport; Fri,
 17 Jan 2025 22:11:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Fri, 17 Jan 2025 22:11:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 14:11:20 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 17 Jan
 2025 14:11:19 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Fri, 17 Jan 2025 14:11:15 -0800
Date: Fri, 17 Jan 2025 14:11:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <corbet@lwn.net>, <will@kernel.org>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <robin.murphy@arm.com>,
	<dwmw2@infradead.org>, <baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v5 08/14] iommufd/viommu: Add iommufd_viommu_report_event
 helper
Message-ID: <Z4rVg1Xg5TCiFlSb@nvidia.com>
References: <b9b4f3df990934cb80b2f5e1e49e555e50c1c857.1736237481.git.nicolinc@nvidia.com>
 <20250110174132.GH396083@nvidia.com>
 <Z4FpMs4qx3NdwrnZ@Asurada-Nvidia>
 <20250110195114.GJ5556@nvidia.com>
 <Z4Smpeb4k4UF3Qso@Asurada-Nvidia>
 <20250113192144.GT5556@nvidia.com>
 <Z4Vt6DAMDfEv6tb5@Asurada-Nvidia>
 <20250113195433.GV5556@nvidia.com>
 <Z4V7NbxGyYoQN0yV@Asurada-Nvidia>
 <20250114134158.GC5556@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250114134158.GC5556@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW5PR12MB5650:EE_
X-MS-Office365-Filtering-Correlation-Id: 2554ccde-1bf1-4506-02a1-08dd3743ea68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Rn81pYGpVcZ4Ggrjp41b1ESbTkQ94nLJtuWGVlNH8kHkS+de3kXvBK/la0kS?=
 =?us-ascii?Q?AY20pm36Go04/kIQoALvF8pJHCrictG04blpxIA3Td3vhBgU8S72Q042e7Dl?=
 =?us-ascii?Q?3NyST7bKGDcgUtCf6WM7jJ6D9T0PJJcQ5lBddKSFKhgFc9QswquCicXeLWxE?=
 =?us-ascii?Q?eY0oGnm79JoduZIXVukQ5eiq32huIwvUJDtEW4d1iP8cz10U477LIztvmnee?=
 =?us-ascii?Q?U+3OfQ0y8OJDt85b067T5Gw5/TAmVSr4Tli9s0MOvoB1lAmgV9RIwqlD1ufS?=
 =?us-ascii?Q?tPFDf2RPfAn5VZActTAmu2twGnmNYOdwsc3bKmxQkbTjNlptTmkjlgjYECMa?=
 =?us-ascii?Q?w4C014fqu6xfpirlOnyFz3Pmk43+VaK+TOclW5Jvp1qln3h5rAoWuKw5Zbgw?=
 =?us-ascii?Q?Z/Pc7sPZLkagGUwQkefRMrSwQz5uRn3BzQW+JVNTEyT81YMgsJXuseKyJSxU?=
 =?us-ascii?Q?PQTRiYAcdqvLh5CQds5MOyxjMlGSfXHqGekTQadLnThyUIRvZSyLcdacelRq?=
 =?us-ascii?Q?X6uOMyzBel3EQe7Fx6Z8ANlheg+oc8kdf2tanIrYFrWfd0UFMOJPxfrzE0QG?=
 =?us-ascii?Q?7I91KyFySJlInnXZSo7qnV7hecHD2PaXxrlEYYEbL5Y5zQOK/BRAiCYAA8Jw?=
 =?us-ascii?Q?RaiVDXdcywpTgr3fVJ2xK2jed3Hc7A3oTWcEWOdYS5pHjEQ2ZjEOVk/9k6zV?=
 =?us-ascii?Q?1G5o6eBV8HkwWLXo69B6HQCG+Mr7G0+f+G39y7vqLtmaGgXy8fqKIme3+yXb?=
 =?us-ascii?Q?5xU1Anhss0b1biGzItBganglkrE9K/u4b8iOTBk3pFxEm2EUshpwbpCktLBF?=
 =?us-ascii?Q?gtPAdfZMdDQ6Ps31x7aIpu6NYSPNPc3Tp8PtF0NBgd5pn9K0KXvfo3XAbDKW?=
 =?us-ascii?Q?M4Y46I+NfYe5++7NCM9cUFzpv4gvSlW58U1kpsTrfKkOgXjAgt0C8Gi1ygaA?=
 =?us-ascii?Q?BjSt8tZA8OuNiL3iZ2o0XaD0Tg6MpN1/krkKVuWDQzDepv6TAq1TEJ9beNyf?=
 =?us-ascii?Q?Gs4fP76lXd4UJfrL5KGDloNTbo0ABI9dG/GdwOiR897aoQhuAy0kJvlGXROo?=
 =?us-ascii?Q?Gt7YqVwZmnh7sPLG9ilqSkQomizcZBrTDKI7m7xfcd9OdRbckY2XB9JnDKVX?=
 =?us-ascii?Q?nbp36RlJYsxclVn/xDJt3eaL0fdZjW/l5blxwSJdWsGb0Ecoda7AhC6Tl2iK?=
 =?us-ascii?Q?M1k9Ae//p15aDia0smCMs5sbpoiGfIi1Ul2A7CP0v0i3vdjb9fNdcM0ZCxBq?=
 =?us-ascii?Q?uPq9SIF6a7aU5AV79BWKv5Z1JmVll49YprD0V6XMOvuvtJPLHNdY8mNfhleC?=
 =?us-ascii?Q?yLoqHcqVQNlFD7qppLDmJBb2hKKceVc6TKMIqfwP/46F+KjU01t92sBrho6L?=
 =?us-ascii?Q?AqEat20U4+db2sJWt9o7VGMEpUdf6jI8f2X5bQpZpJ5UMb6GOU6x/kOyf4d/?=
 =?us-ascii?Q?3+PPA8Fzzn0ZqJVBYbPPdVi+nCrPN8yjZbL5BhniamdJQbyME5PgmRcuhZ6j?=
 =?us-ascii?Q?S6aNK9t2eL4imy0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 22:11:39.0718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2554ccde-1bf1-4506-02a1-08dd3743ea68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5650

On Tue, Jan 14, 2025 at 09:41:58AM -0400, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2025 at 12:44:37PM -0800, Nicolin Chen wrote:
> > 	IOMMU_VEVENT_HEADER_FLAGS_OVERFLOW = (1 << 0),
> > };
> > 
> > struct iommufd_vevent_header_v1 {
> > 	__u64 flags;
> > 	__u32 num_events;
> > 	__u32 num_overflows; // valid if flag_overflow is set
> > };
> 
> num_overflows is hard, I'd just keep a counter.

Ack. How does this look overall?

@@ -1013,6 +1013,33 @@ struct iommu_ioas_change_process {
 #define IOMMU_IOAS_CHANGE_PROCESS \
        _IO(IOMMUFD_TYPE, IOMMUFD_CMD_IOAS_CHANGE_PROCESS)

+/**
+ * enum iommu_veventq_state - state for struct iommufd_vevent_header
+ * @IOMMU_VEVENTQ_STATE_OK: vEVENTQ is running
+ * @IOMMU_VEVENTQ_STATE_OVERFLOW: vEVENTQ is overflowed
+ */
+enum iommu_veventq_state {
+       IOMMU_VEVENTQ_STATE_OK = (1 << 0),
+       IOMMU_VEVENTQ_STATE_OVERFLOW = (1 << 1),
+};
+
+/**
+ * struct iommufd_vevent_header - Virtual Event Header for a vEVENTQ Status
+ * @state: One of enum iommu_veventq_state
+ * @counter: A counter reflecting the state of the vEVENTQ
+ *
+ * ----------------------------------------------------------------------------
+ * | @state                       | @counter                                  |
+ * ----------------------------------------------------------------------------
+ * | IOMMU_VEVENTQ_STATE_OK       | number of readable vEVENTs in the vEVENTQ |
+ * | IOMMU_VEVENTQ_STATE_OVERFLOW | number of missed vEVENTs since overflow   |
+ * ----------------------------------------------------------------------------
+ */
+struct iommufd_vevent_header {
+       __u32 state;
+       __u32 counter;
+};
+
 /**
  * enum iommu_veventq_type - Virtual Event Queue Type
  * @IOMMU_VEVENTQ_TYPE_DEFAULT: Reserved for future use
@@ -1050,6 +1077,13 @@ struct iommu_vevent_arm_smmuv3 {
  *
  * Explicitly allocate a virtual event queue interface for a vIOMMU. A vIOMMU
  * can have multiple FDs for different types, but is confined to one per @type.
+ * User space should open the @out_veventq_fd to read vEVENTs out of a vEVENTQ,
+ * if there are vEVENTs available. A vEVENTQ will overflow if the number of the
+ * vEVENTs hits @veventq_depth.
+ *
+ * Each vEVENT in a vEVENTQ encloses a struct iommufd_vevent_header followed by
+ * a type-specific data structure. The iommufd_vevent_header reports the status
+ * of the vEVENTQ when the vEVENT is added to the vEVENTQ.
  */
 struct iommu_veventq_alloc {
        __u32 size;

