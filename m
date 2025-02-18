Return-Path: <linux-kselftest+bounces-26897-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F59EA3A6AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 20:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300C1188B1B7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 19:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24131E5210;
	Tue, 18 Feb 2025 19:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sjme3HO9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D881E51E3;
	Tue, 18 Feb 2025 19:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905371; cv=fail; b=kpW2Z2t4019EuEhKP+rfR/RSM2voXbI3J+utmDkthr2zGk9N390aBOovprmurtY2QJ5nw91HT7Yv+a7dGEQxOwgpwaGHhgI0TFnMtivEt/dzgNe/1vytjx7ZizdU5aL6+ED6us4RUFgIb/Fv0gMncNW5XL9Mu2kSPSqAveqX0fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905371; c=relaxed/simple;
	bh=ygswTeEaUBAh7jTBfqQUXIZR7oURmXtOTT7UifOZzHI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZN0pN9+GlXjiARzSwRD9vXOcNsbJ9IdFFAdP57CNd5OKppeLqk73SRO3Pz+SaoPZGhkI+dgpClCYE7bVUOId9O0WVB83lOtPIAmET8K+fNs0tG6SYOojKxn3QN2lKNUV5rjOZ4xF6NVBpbo7UL+lCfYFJRteSX+njrIkbXxq4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sjme3HO9; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VRVZ9C0ivcfbPCL3l9ezEDIWvvF7G3F+PKDhCtT9MpbAa7QQc5lZrl+xTpZpFowq1TbZ7CWFzjALSR0odyPgbDevUD93ed2hVf3BXTNZUJH1Z2DUBEnEMzm1iTIjys1HTGj9lY7eZF93dHxLbxWo+tq+nbfRHLuj++DQg7h7KSr84YZkmOA7RBBy3JWDbO+JomGD7gifbPmslVkp1YtvQ3YsdUkIXeofXy1mbyYJsMJRfvvLjQoHCPOBXyNagBnyreNrhg8K7+C7DHVU0oxEpPtJx+eMGQMIIBsAM9ZvK8Dgf6iGHLQ8OdnrYieUVSOU0Io7Pck9cbg48kW5hTzxYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R81WX5ieBKT/eq/FhZWpa790wf98iO4MC+KwyZIz0eA=;
 b=fHYPbYysjFDkVi0JStoArtcGe7GWYHMX90OB1XeEFfgbnxFNSTYFXdXl3xrR96xJSJ/5SjUl9kDwPqeLvT9ELCUsbzXTO/z8vDb1n9fKQmaPrMtssl89xGvORgNSmOprGYpcccnGONh7+MH8o/7Z0wdmppONTKHK9LmmsRkT19WajOQjThlMlzCY69flMaZdnnauvW2OgkCJs/a7QNHIl9+RZV3qAhLRPWNa9LQnsqvDMoQ30tm26OsnjYWaWnzz05RUowYw+eHyI69MvUNsGXnGJN6YSmV7RBB4JJy8FG+UYLFQ1OhcoUoR6a7w4fXj0rOx7Ss+/SABNPqZYt4jDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R81WX5ieBKT/eq/FhZWpa790wf98iO4MC+KwyZIz0eA=;
 b=sjme3HO9SwZ0vBKjhoWxYvJgHFfUuBcQzPGx6dqfia+IjtPwtlb0xhqmfg103U0t2QnENo4btZwO0HOjh66wdLnI6akcHQYZ8WBEQq4gBHtOPt5V0u4vZMoRd0xsMXmfCT0FuqcuUq19q9m9BgVawP6aQGNaSuem3ZaYoHt4+3jz31/wjMQLgsuNYhUfvSgwEOEAXmH71YlNhfbOuFjMFuzyS8nzp3ecDK1DK7PMRfKcCHqzTjlgiW23weU4CMzVeVbhfap6W8GmQ8/el+ldU6Fm0t3+FKapxGmVRnl6dBbqFNj2KiNRasxBd/HAsHsHPXyX+MBSi86A5sCINSyQVA==
Received: from BY5PR17CA0017.namprd17.prod.outlook.com (2603:10b6:a03:1b8::30)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 19:02:43 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::a4) by BY5PR17CA0017.outlook.office365.com
 (2603:10b6:a03:1b8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Tue,
 18 Feb 2025 19:02:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 19:02:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Feb
 2025 11:02:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 18 Feb 2025 11:02:26 -0800
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 18 Feb 2025 11:02:25 -0800
Date: Tue, 18 Feb 2025 11:02:23 -0800
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
Subject: Re: [PATCH v6 13/14] iommu/arm-smmu-v3: Report events that belong to
 devices attached to vIOMMU
Message-ID: <Z7TZP3jXlRzweFE8@nvidia.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250218185046.GK4099685@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaaf8ea-f8bd-449d-bf76-08dd504ed2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?emZINW5qdEdYa3U0aFpOYzFKemQyVkI3WU9HVDIvRlNuemwyVXhnMmoxZndX?=
 =?utf-8?B?SU8zQ2RjR0orQzZwNS9ITmZ2eHcwQ1BERnM4M0xvWm1qK0ExVHk5WG9adS9o?=
 =?utf-8?B?VWo5aHdsbHR3djJUcHlseDJIck9uMVE2UG1pcXF6ODJtNUtFd0VGS0N4OHVz?=
 =?utf-8?B?OW9CZjh2em9oZXI0akZzUU82OHkwVGZZc0xSalZScGxlL1A5T0p3TnRrNjBV?=
 =?utf-8?B?S3JyakEyd2F1L2tBYXdzRFlaYWRudTlkNFpEeU5GZlJ4MVAwcGFGU1I3blpw?=
 =?utf-8?B?UitLYVZsODNEVUVTYkxBblB3T3ZUdndKMjlEQUdXQUpsWjZmLzlNTUtvMFRS?=
 =?utf-8?B?U0pZRUF1WlBtTlhoajY0UEs3YUZtWGNaZDFVQ3RMZDVjdzBXRFZHblhRS1B5?=
 =?utf-8?B?NjFWMlNyTGpoS0F4MkdjRzVZcit2Rld2TFZ4VG53dlRLYU9LRUJ1aVU3Mmgr?=
 =?utf-8?B?dGk0TjUzUzV2YWtBcW9KQzZXaTU0N1BFcXlKMHdDakFuMzc0QVdHZkdvc21k?=
 =?utf-8?B?T1FwNzBRT1ZwUGNKbjlTKzByVDVLNkdQUGlWR1BuMmdJNUVkQ0w4MmN0TUN4?=
 =?utf-8?B?NndkQTdOeEl1ZlNWVHNiVE53L1kvdzhIdGNXWi8veDVhcDduTXNBaE5nbEdU?=
 =?utf-8?B?YW5uQ25QK0dRejRGTUppdWtxZ3VxRUQ4by8xOExvZW1tL3pTTXFZZHk3ZEpZ?=
 =?utf-8?B?RDR5d2tVQ0ZQQjJLVSs3eSt4VEhGaTBiWE5jYkR2SWpqcUJkbEwvQ2JFZnRJ?=
 =?utf-8?B?WHowL2ovSWFNeWlxa29WUzNhMXlsNjJGUTB4YlhvTlM5dzRNS1NPVGk2MEZ6?=
 =?utf-8?B?WjBHUFpGenFrRDQxcUVrUHdReUdyYVBUa3Azb21OZjJMMGRKYVFBdzlWRCsx?=
 =?utf-8?B?MFZZYkx6eitxWGhyeEtvbXI4OVpqVlZhZHo2S0g5dGhUandXR1EzeUxiMDg5?=
 =?utf-8?B?dWZFUlhTeEk3cnNURDVLWm11NHJWZVV3S3pEY0dYT1FlVm9NUGloN3hVNDJF?=
 =?utf-8?B?WHZyRlpwbU5jaTV1L0hTNWxBbmJPbTM4NzY1eVR1VjVRWHdXMitaVjVOcW1D?=
 =?utf-8?B?aFJENytRQTNVd0tvNFIwOEJNQSthZ0F6MlA0dEF6RUIzY04vMUJnMGNQUXFh?=
 =?utf-8?B?ZVArMnhJWWpoZlNsVmxVc1gzRUpQbHJ2cm1xUXR5R1dTdVd4VER1d015M2lu?=
 =?utf-8?B?bEJNdzdyL2ppZlFCRVpFWEY0N1Zwbk9SZytjSHNwdjlZcEZ4Qld1WktoWjRI?=
 =?utf-8?B?OFcvTy9EN2VkZU8rZk9nSFM1dld3NnlCbjRONmh1MUlTVlB6T3RRZjMweTZR?=
 =?utf-8?B?dVNmRW1PbC9iWDN6bkorK3NhZU83ZDFDdzFzeW5paVJEcG10WVlmangxT3pJ?=
 =?utf-8?B?ZmRCcEJtRUE2Ti9qd3NYbVBteVNBTkY5Q1Y4M1puUjhhQS8zUTZjMjcrWlpD?=
 =?utf-8?B?RlFPOVhwbXdIVHJBekhQRldmN2dNTUphZkxEVTdPSUVlYVBrVllVMWNXYzBl?=
 =?utf-8?B?M3VWbU5aQ1VLOTRpamljYzhtbnFBenU2QURCdVYyQXRIV0FqN0NSek5ZTHFO?=
 =?utf-8?B?MUw3L1IrbHJXR2d2OUtERHl6YlVSL3Zkek10VWhEc1dRVXBSUENqNnkzZEps?=
 =?utf-8?B?Mi9WZkk2UCtrV0tjUURZTXlFOU0rU0pQQW9TZGczUVZpOHpRTXhlRDduSjRD?=
 =?utf-8?B?aUE1Z2xBck5Kcjh0M2J6MlhpNlp3VGNvYmt1REZaUXArQlhPM1NDWjlKcUwv?=
 =?utf-8?B?aFE4UERzb05NakZsT1J0aG00WnFpbVdKM2t0ZENqK2xPWmNudUc2VGxSYnhs?=
 =?utf-8?B?RjFsWU5QWExJeVRWNTNUeWg1ZnVQdmcrT3phdHQ1bFlPdldxQ3ArclZQQUR5?=
 =?utf-8?B?eFJ5QzNVaXFMQmtKSmE4Z29CNlhSVWkyb3J1eXUvc214SFdWTHVrR2FtajMz?=
 =?utf-8?B?WERrcmJ4enkzL2tTc3ZUeTBlZnM4YUxXUzZCVCtZTWRjWEdLM20veDhoNElq?=
 =?utf-8?Q?KlvKy3c12E9zpU+8dGrUAZ03SjdSPA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 19:02:43.2179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaaf8ea-f8bd-449d-bf76-08dd504ed2f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361

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

Ack. SMMU spec defines three type:
"Three categories of events might be recorded into the Event queue:
 • Configuration errors.
 • Faults from the translation process.
 • Miscellaneous."

The driver cares the first two only, as you remarked here.

> > > This already holds the streams_mutex across all of this, do you think
> > > we should get rid of the vmaster_rwsem and hold the streams_mutex on
> > > write instead?
> > 
> > They are per master v.s. per smmu. The latter one would make master
> > commits/attaches exclusive, which feels unnecessary to me, although
> > it would make the code here slightly cleaner..
> 
> I'd pay the cost on the attach side to have a single lock on the fault
> side..

OK. Maybe a small patch to turn the streams_mutex to streams_rwsem?

Thanks
Nicolin

