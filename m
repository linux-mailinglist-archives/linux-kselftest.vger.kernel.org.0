Return-Path: <linux-kselftest+bounces-27112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1172A3E60E
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 21:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7EBD7A82D7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 20:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C425B1EB198;
	Thu, 20 Feb 2025 20:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Br586DHA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21541E4AB;
	Thu, 20 Feb 2025 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084378; cv=fail; b=S6LgWFrUPIjeV2F/BOefhAmr0z9RQNCqk37Val1U7uVttno1R0nhQZGCpdy6Iy7Y8VnGzL6J4Qlj4FISeHtcCvUA/IE2slBKI7N39vX9P0CTOy6ULWRS4qopB9yuT03AkvUrWiy+vo+CIyC98G/82ZbZV34K0fa+h9MnztFc9kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084378; c=relaxed/simple;
	bh=thQbq7lsK7utedwJjQoAv8Sx0IALEbnU5EXlvnj/EFU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6vJZnmBHZsC7AMfhvmwKqnkOqudYvTPblAF/EaGJCHVsMB9Ak/mmw1uwAhjUT5hYhIpLvoEsDHCnS+xsKaBIb4G+421zDJRqIuH19ArZdm9it8llpUdoLg1n/zVtxAbEiUswzKe6D2NCTGU5cMG8Hce5cw6MKiXxtSEqeiaEiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Br586DHA; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lLh1tdYN78lfBXWsygoBEaKldEATjq8lMUBfLuC0SqCDOjBTNULN0pJgHQJ7IfX10L+58JRIv1Sl3W6uTaWOdSJ/eLZ7iNLYCdXNeSd5pA+2NO69ZvGkfMGRQw1wT70Kf2TAYN+o9zCyIBDOxEn8AGRMKVwUWnjXn82fVfIckT3QdP2Y5Epw3xwE9GPHLyInpMLo2w+peWBXlBDhP10U1ILGwOSATGRpjj1jQ5eWF42FiXlIssZ9umaJhMyKAHD4agm6/sMl76nvEarM0idfijKxgegcvmRBDECpK20K5SeXRfDZO0KgMJg+daWGn4P4Z8KIRSVCd5GH2gA6IMGj1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIgsBPUs1pAndce6o7L1w7JDUoloTdFqm3UKzTdqSpI=;
 b=sgz0BuieOCwhJW9mFUi5ac+FMWi1wFdymXK1shlbOreCtmvjXPSU9Cb4f5xHn+TsiG0gOmmkbRQoAix5J3xsdx/EEIYiDipnyIVDyqDmo4+/m/0o65Qx5LJ8Y6BiJpb68kZqOjsFuusgKDhVVDjgQZ3mPOzkNA0TAuj9lVXtbGCSCOteN2nlRl90EzwLPVXoZju8o+JkYDIgsdIT94tOZpHPZ0jfw07dD0mlGce+AAxHe6j8yHVxIWES+On4hi8mBgDS5T7CaIhzaEWzgQRZ3aWo/iG/SIJbwqEQmcfEEvNrOUBXnjgT7sZreVLYtmiIkpSEUTSPKbkGsjsvGEJ+jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIgsBPUs1pAndce6o7L1w7JDUoloTdFqm3UKzTdqSpI=;
 b=Br586DHAWklCRfViEadcPx8fz8L3oqYCm0OK0xYefDFEzUtBJnaoGf0w0T3r2+UMElOOIzT5nSKdATCO7zKf7bkI4c0Td8kxqrqkewmLCbp8zTSlYlhOB8i3AoErWdURhDR3HMF6GiWrBWVFDniPuLyI5vg2L/zXEQ4XzepE1955/EbO3BNUqiok25rpPruBUf6Mes4TRJ1gcK8Et0JD44ccWDt3NphPIonRwyVZ6WWL8cNE30y+Rbirg71C+viDOp7kJehX9ea0sdO5woy6JugSp7ee3kOrTQlLfQF/t9OoqVeQQ1x8mJVFKCIL4fz8igXHnbYJamWsZnEOoPqjKQ==
Received: from BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 20:46:06 +0000
Received: from SJ1PEPF000023D8.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::58) by BY5PR20CA0002.outlook.office365.com
 (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 20:46:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D8.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.2 via Frontend Transport; Thu, 20 Feb 2025 20:46:06 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 12:45:49 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 12:45:48 -0800
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Feb 2025 12:45:47 -0800
Date: Thu, 20 Feb 2025 12:45:46 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>, <robin.murphy@arm.com>,
	<will@kernel.org>
CC: <kevin.tian@intel.com>, <corbet@lwn.net>, <joro@8bytes.org>,
	<suravee.suthikulpanit@amd.com>, <dwmw2@infradead.org>,
	<baolu.lu@linux.intel.com>, <shuah@kernel.org>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kselftest@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <eric.auger@redhat.com>,
	<jean-philippe@linaro.org>, <mdf@kernel.org>, <mshavit@google.com>,
	<shameerali.kolothum.thodi@huawei.com>, <smostafa@google.com>,
	<ddutile@redhat.com>, <yi.l.liu@intel.com>, <patches@lists.linux.dev>
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7eUeg/SmiJGTgbi@Asurada-Nvidia>
References: <cover.1737754129.git.nicolinc@nvidia.com>
 <b71a5b132e8ba771998c5b810675f10b100d4ff3.1737754129.git.nicolinc@nvidia.com>
 <20250218171821.GG4099685@nvidia.com>
 <Z7TRNL0u0YmN30ax@nvidia.com>
 <20250218185046.GK4099685@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250218185046.GK4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D8:EE_|LV2PR12MB5917:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e65159-6a33-416b-1b6b-08dd51ef9923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cLTVXT9N7doFeE5P4/0yE7+DZS7RiisSRSidhCRiFcjl681Hea0ojidE+u1s?=
 =?us-ascii?Q?SKO6KKhizJiD7GEoK8vbiqM+BbG8Vey+CoY+sxLM5c2dw4qK8ArCnVdkKA76?=
 =?us-ascii?Q?9HeVJRETQmsxO0I2obi/hbFJ9aBF0sXvsiowwMR7Dt0bzTgVWFcNMqZrnWvG?=
 =?us-ascii?Q?sxpH/WOHk3WAZSCjdL5WDlbPcFTduIEyBc4qM3OMRc1Rhic4ty/Slr5stjTY?=
 =?us-ascii?Q?BB0RiNQ85Tma51Q755W7OcWcHJRFUj6mWqrybq8NzaEK0Nr+AP0sXJ6EyirF?=
 =?us-ascii?Q?+4H64ld2aukTEqcXeuFzUaq6sJ3bIhvh0xyVBzWqgmu1ryWqUemKJQ4wSjsD?=
 =?us-ascii?Q?uFILy1B3oGRNZKkqyZNNitlyOybYUJ8aPa0SYn7ShGjqNgR32yEQMWGZAOps?=
 =?us-ascii?Q?gWv/TDKJTnHiiRs2ZOgNpxul1KuS9+HgBVgKG+60F459Thks3F9bx0+id3h9?=
 =?us-ascii?Q?/dFxTZ6/1JKwVN5QcuhUUKYuZR2xxAezhmYw8Kh5KmS2Ed5gaQl05EAH1DCr?=
 =?us-ascii?Q?cdGwqh8T6drt/oqf/Q0AOltP8ksO6rr8UY0+wlJh4bJqlTV/gkvDvT4BBxsD?=
 =?us-ascii?Q?mPsM6pnS+IbQvsc9ZoAq/NcNkenVjU4ClvJ35WxZzQ7Bqru9NI9XVV7Ra4KQ?=
 =?us-ascii?Q?tIdBDClSs6hcIM4A05GlbGBrEC8L0BE5SSHyRduW/wV/vGGJSM4ecVzrQJV7?=
 =?us-ascii?Q?LbWLFzOemrWaWiuZ6tRe1v3CWN6h0OuZpqpQsC6P6yI40tlxJyfN/vjK6jDB?=
 =?us-ascii?Q?/F2cWygWU7vO/xeeG3osOmRQQpjqsNrLgKMUPagq7LdjVkpLG/RstrNq9WYe?=
 =?us-ascii?Q?XZYe9C+3oAC0PBzaO3SdkEpd22mAKLVcKQQtRLrx+5UHfF6ULyhzTbYXTVJ6?=
 =?us-ascii?Q?TcfF3ZwUOywtqXigHz8WuKFQNTqhRypT/S7BB0koDPHhvd6OanbCBjGJ6N2F?=
 =?us-ascii?Q?dxbvYU8CZIBiv3v35r0BI9je7owz7vVsKESaxVFxELUxkUBW6olankHusSmt?=
 =?us-ascii?Q?nCmBTzBCcbtl5vO6CA6HIE4DSRNYAbgs67Le9ZKc6abD8ZxMlDoWGrctpA3U?=
 =?us-ascii?Q?ZrQIMc4z11ThWehS8dE08VMbNDzZUW9kwy+QSOV5Sqrmatwemus9eWc7Htte?=
 =?us-ascii?Q?3+XVnUuU6RdnLNXAla6WxHQD+0F/kaH+pmQomJ/OKaTO+p/TBirEQZuY0+zL?=
 =?us-ascii?Q?cEDHeSvAS2GCE9jlJsvEx7oSbqileJIRYiANkO12peQ0i0Mkhnn9sb3cciyf?=
 =?us-ascii?Q?HtqdixpbW11vOf4Nl9oZJiUbt9UXsJ+c6BQ88Dgnc4h8lP0Lkd91MvCXS6Ph?=
 =?us-ascii?Q?UGPZmgJSd9OrM5wzsPugxufzWsG4XmGmvbvv5FAed18ddRiMjmnmySrfh3Zg?=
 =?us-ascii?Q?pVb8fQCUcAutUjw3wkiF0UWKkDbH8Ex+FQnw4XuFjfntdCVd8GkbnOj1OjR7?=
 =?us-ascii?Q?FEgaJ3d/VkVGvlvvUnh1OQITNSP3rXiCZ515vqrgoGCUq8++1wJswW1frogn?=
 =?us-ascii?Q?0Sj+Vv8llIZ9vdM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:46:06.4570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e65159-6a33-416b-1b6b-08dd51ef9923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917

On Tue, Feb 18, 2025 at 02:50:46PM -0400, Jason Gunthorpe wrote:
> On Tue, Feb 18, 2025 at 10:28:04AM -0800, Nicolin Chen wrote:
> > On Tue, Feb 18, 2025 at 01:18:21PM -0400, Jason Gunthorpe wrote:
> > > On Fri, Jan 24, 2025 at 04:30:42PM -0800, Nicolin Chen wrote:
> > > 
> > > > @@ -1831,31 +1831,30 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu,
> > > >  		return -EOPNOTSUPP;
> > > >  	}
> > > 
> > > There is still the filter at the top:
> > > 
> > > 	switch (event->id) {
> > > 	case EVT_ID_TRANSLATION_FAULT:
> > > 	case EVT_ID_ADDR_SIZE_FAULT:
> > > 	case EVT_ID_ACCESS_FAULT:
> > > 	case EVT_ID_PERMISSION_FAULT:
> > > 		break;
> > > 	default:
> > > 		return -EOPNOTSUPP;
> > > 	}
> > > 
> > > Is that right here or should more event types be forwarded to the
> > > guest?
> > 
> > That doesn't seem to be right. Something like EVT_ID_BAD_CD_CONFIG
> > should be forwarded too. I will go through the list.
> 
> I think the above should decode into a 'faultable' path because they
> all decode to something with an IOVA
> 
> The rest should decode to things that include a SID and the SID decode
> should always be forwarded to the VM. Maybe there are small
> exclusions, but generally that is how I would see it..

I think we are safe to add these:

------------------------------------------------------------
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index fd2f13a63f27..be9746ecdc65 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -1067,7 +1067,16 @@ enum iommu_veventq_type {
  * struct iommu_vevent_arm_smmuv3 - ARM SMMUv3 Virtual Event
  *                                  (IOMMU_VEVENTQ_TYPE_ARM_SMMUV3)
  * @evt: 256-bit ARM SMMUv3 Event record, little-endian.
- *       (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *       Reported event records: (Refer to "7.3 Event records" in SMMUv3 HW Spec)
+ *       - 0x02 C_BAD_STREAMID
+ *       - 0x04 C_BAD_STE
+ *       - 0x06 F_STREAM_DISABLED
+ *       - 0x08 C_BAD_SUBSTREAMID
+ *       - 0x0a C_BAD_STE
+ *       - 0x10 F_TRANSLATION
+ *       - 0x11 F_ADDR_SIZE
+ *       - 0x12 F_ACCESS
+ *       - 0x13 F_PERMISSION
  *
  * StreamID field reports a virtual device ID. To receive a virtual event for a
  * device, a vDEVICE must be allocated via IOMMU_VDEVICE_ALLOC.
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0efda55ad6bd..f3aa9ce16058 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -1827,7 +1827,15 @@ static int arm_smmu_handle_event(struct arm_smmu_device *smmu, u64 *evt,
        case EVT_ID_ADDR_SIZE_FAULT:
        case EVT_ID_ACCESS_FAULT:
        case EVT_ID_PERMISSION_FAULT:
+       case EVT_ID_BAD_CD_CONFIG:
+       case EVT_ID_BAD_STE_CONFIG:
+       case EVT_ID_BAD_STREAMID_CONFIG:
+       case EVT_ID_BAD_SUBSTREAMID_CONFIG:
+       case EVT_ID_STREAM_DISABLED_FAULT:
                break;
+       case EVT_ID_STE_FETCH_FAULT:
+       case EVT_ID_CD_FETCH_FAULT:
+               /* FIXME need to replace fetch_addr with IPA? */
        default:
                return -EOPNOTSUPP;
        }
------------------------------------------------------------

All of the supported events require vSID replacement. Those faults
with addresses are dealing with stage-1 IOVA or IPA, i.e. IOVA and
PA for a VM. So, they could be simply forwarded.

But F_CD_FETCH and F_STE_FETCH seem to be complicated here, as both
report PA in their FetchAddr fields, although the spec does mention
both might be injected to a guest VM:
 - "Note: This event might be injected into a guest VM, as though
    from a virtual SMMU, when a hypervisor receives a stage 2
    Translation-related fault indicating CD fetch as a cause (with
    CLASS == CD)."
 - "Note: This event might be injected into a guest VM, as though
    from a virtual SMMU, when a hypervisor detects invalid guest
    configuration that would cause a guest STE fetch from an illegal
    IPA."

For F_CD_FETCH, at least the CD table pointer in the nested STE is
an IPA, and all the entries in the CD table that can be 2-level are
IPAs as well. So, we need some kinda reverse translation from a PA
to IPA using its stage-2 mapping. I am not sure what's the best way
to do that...

For F_STE_FETCH, the host prepared the nested STE, so there is no
IPA involved. We would have to ask VMM to fill the field since an
STE IPA should be just a piece of entry given the vSID. One thing
that I am not sure is whether the FetchAddr is STE-size aligned or
not, though we can carry the offset in the FetchAddr field via the
vEVENT by masking away any upper bits...

I wonder if @Robin or @Will may also shed some light on these two
events.

Otherwise, perhaps not-supporting them in this series might be a
safer bet?

Thanks
Nicolin

