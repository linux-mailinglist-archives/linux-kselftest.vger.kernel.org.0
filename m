Return-Path: <linux-kselftest+bounces-41898-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87386B86F40
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 22:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BC303A5718
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Sep 2025 20:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90B42DECBD;
	Thu, 18 Sep 2025 20:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hlb7QWjw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013005.outbound.protection.outlook.com [40.93.201.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9EFD528
	for <linux-kselftest@vger.kernel.org>; Thu, 18 Sep 2025 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228611; cv=fail; b=Utqb/YQIkCWIejla2I3lakjigXg2HVveZXl/0vctxzB4/8CvHk/0xeS2tLr+eUrzVgKoLrd9PutDQJKhi5a3/l33TTHGvjOrzsGghSftv6OAVQ8z6qrI4d1XKhg6XjkXQ/Fd3ifhncUP1Gxu1NHM/2lieXnFVSXN7prqBiv6+cU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228611; c=relaxed/simple;
	bh=1IXo9ZjS8qwR0D0KQYYWv50kiaxJuDC0t9PVR88z4Z4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVst/TKhwB02j/qpd09hAgkMTMXEtqzZwXRMUaEVd4eePWSLsrPivohgp/+na4J9HoWf9T5J5GU7OoUFJKWHyc4YBcrlCtMLSzxyKnLWj0KWnYdEor6UxR5p3zSbqcffr7V5XNlgCsAaqKj70HYqfMI/CoTVuzPnsTW+9w/ABNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hlb7QWjw; arc=fail smtp.client-ip=40.93.201.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YOcBXZmVBMNxZy/8STSgxmWlPoEBL6EzngoMZlBWA0XSfskwNYkGlEd29XVQReYp6j9pkSmF7OOTJkzTD6OF01wzy87hDfFvufBbBxccDg/agojXyqxRf9JghpYvShRhNhfptttXtYNw9zpuVZSCBJ1wySXOOAxjALOto2CJFeu5abU5xvYTmY7oO6BHqmnLIaUKKx0hQKYw+cJeL+iuWFHtocyfZSGCrx0BDVOi/CRZ9QJH74Q7X1c8EabpveVZQg6k7jaVMtCTOgaWi87jK7eAg+i4rTawtAvul0NpG59+93NTgnAgZGChPsJBK430It3pkraRnuxnDUJBQGMMlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sfzFMlZZf//Nwqp4TFoxes4b8DKVyeRTLOIfJ98ofoY=;
 b=fCsNu0nWWBcNfwXKGMhwFEDWe/0uZ726c3Lq2DIgwBQW7vBa73huaQAn2ZSLrolSXeWuWYAeH6ZBSpkBE3B50pL2RWgwuLc010Efobda5gHXlfaeYIrGVJii7/VJ4xzrtjqiPgVsuEqg3DlQjr4JJbHloCFDfzKeGzEvbHgBHsIwDVQxa4cIAFKozbZjp/QHg6Q30AZiBt21v6w2MHLLV3VxFkbrQEXtejBZQTzoPb+GVep41FMrl7eSRKwmku2F5GgbLKNZaHj9XCcdW7g/TarYgD0zFk22s7JEy482BBZgXCh8uYNMLIFwpsK8gy4RAOhBSO4O41mvrb5k4tP6xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sfzFMlZZf//Nwqp4TFoxes4b8DKVyeRTLOIfJ98ofoY=;
 b=hlb7QWjwfOWVPeevFnvFbkg40xvR9tOwTiU4SwwhhvaHGBGPkK0Z09oQV/1Q+0LIqtlooNmkZVYXCs+5Ig0WzK+0ZjWQLg8XqHaCl3Zye8LezMSZ+xWwaEmFcjse8OaysNOgf5AkhLsEfvJpWah2EwogpzHlx577g6UUAyLMtWOtIeS4vtEhfO9KF1JpEO517inmCJ8Lk43YWPLgjM4si/p1LS4obG/6n5Jk4MwrJNZMWSwbSbA2MX6+p33Yjzm6gSLPjChUAgW+CueSwVgfWWOvvHKNVKUqV9nmFGMPNipHCysfg/4s6hiA05bJP5xWZLofE/p0zvkUKkGo4nJc4Q==
Received: from CY5PR19CA0065.namprd19.prod.outlook.com (2603:10b6:930:69::13)
 by LV9PR12MB9784.namprd12.prod.outlook.com (2603:10b6:408:2ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 20:50:05 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::77) by CY5PR19CA0065.outlook.office365.com
 (2603:10b6:930:69::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 20:50:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 20:50:05 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 13:49:52 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 18 Sep 2025 13:49:51 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 18 Sep 2025 13:49:51 -0700
Date: Thu, 18 Sep 2025 13:49:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Kevin Tian
	<kevin.tian@intel.com>, <linux-kselftest@vger.kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Shuah Khan <shuah@kernel.org>, Will Deacon
	<will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<patches@lists.linux.dev>,
	<syzbot+80620e2d0d0a33b09f93@syzkaller.appspotmail.com>
Subject: Re: [PATCH 2/3] iommufd: WARN if an object is aborted with an
 elevated refcount
Message-ID: <aMxwbQ8HTXFzXS+J@Asurada-Nvidia>
References: <0-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <2-v1-02cd136829df+31-iommufd_syz_fput_jgg@nvidia.com>
 <aMuiR791LkEybdAa@Asurada-Nvidia>
 <20250918144737.GO1391379@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250918144737.GO1391379@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV9PR12MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: d9acb673-51ea-47ff-8e1d-08ddf6f4f230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E1O8lyAmgOnow4vMZyb0c/ys8TuDYoBYzabCSv006rphmKlIvNqOiXGmZLQO?=
 =?us-ascii?Q?xX0pMl8K+nAcFq1bBFutMfrqIrUUWScjZ6M/VAoPmV2iwHhk80NU53f76Xeu?=
 =?us-ascii?Q?4SNKaoqUpB5B8Bvi39Q+ltOzXAkmOQs+pHjja4CqK8p+DdbSFa5aGjM/lgqT?=
 =?us-ascii?Q?qqgHdy2WHQkNg6tOQERey5vpZ2gt0Nj2Y804+tcKhj5CS44HSHb6eRhVZJ0o?=
 =?us-ascii?Q?y7FJFZRHCrFzYMn+MD9Erpsxkd50i/ahEBXgd9GguxyfrBcoC6EtDAXZzfSJ?=
 =?us-ascii?Q?+HzCjBHfHP0YIFvk74ykOcGip29dEceR+7MRNX+23fiCsPe0nMctBlAIzSpt?=
 =?us-ascii?Q?H0XSe+VjQkTtiof78Z7AC4CR0uzkF2oTZpVjs31+ufGnkCeGLRCk7ffkwjm4?=
 =?us-ascii?Q?NMlcil1FZHXJ5APoi+jgcTPWRzVA5mh+f2kKe6JznHpon+su8R5UfeOSFebC?=
 =?us-ascii?Q?qajMvAIqcf/3u8GpTdbap4aL61BDqgCeyLzKfob742nDkpgGqOUFRH1bBKUp?=
 =?us-ascii?Q?A/Uv0YHb2GoYdOjfVATrjqXT3I9qwwRRoluAAZ5EEhzkjJSkAWWEZeczJIId?=
 =?us-ascii?Q?PbhFGTGX2mU0ZuDbMi3Zo0Ozb2vNXvGkKMdg/ThMQHN2XOKKWZ9UODmq06pd?=
 =?us-ascii?Q?/x2emd0pyEcgaUAVst4+V2ZtqZapZKGn8XlUbOPwR1Iggrv2Qk7gMSH5AiPp?=
 =?us-ascii?Q?LJo6R3+YIsIvH9X+YK+wLcFmNfjRo3TofUzNOb7YVHbSeTALYoIOmWNg1XmB?=
 =?us-ascii?Q?EptIpk9GFoPJLHh9W58xQ5oMvqvzEsmHoWMTzMU6j/dUZdublzcHskoTMN9Q?=
 =?us-ascii?Q?/a3DGHXAdr1WxIe2QNklRGRDEEuEnE9xfPXWS2Eidtkm1FcoFeLRCq4zMREv?=
 =?us-ascii?Q?3X6VXEHAJKnxBplzu4b3uArkzxg53ltdwTUTukvUDdmn22tFYsUTWpJXOwez?=
 =?us-ascii?Q?MSU6mSkiSMqvjdMdo6v7o00h08tDSvaK1hRO3T0ELPOlv8/CcjKq0G9dNp0R?=
 =?us-ascii?Q?QJpGW3E8UU7+RXOhwhTONS6I1uSzMEajtCJDfrtpQWPVEDg1EUXWEo6UPFyM?=
 =?us-ascii?Q?qIuvuYuDzazYX9HuEuZGvrQbXqFiuwtCzpMlTSMBsU2bcItex6M4l/V9xlL6?=
 =?us-ascii?Q?QUm4T0UfpLX4lCQl/byNTtrrPvGncPIMxP5VX0+kpYsgoK+Q+rtqmtYtwyBT?=
 =?us-ascii?Q?sDtcQgt2VZ4YTmR7GOluNVOSe+HoNP8h47BDd4+ojUjqF3sgB//6pD/KkaMg?=
 =?us-ascii?Q?f3jOGKYrrl4TwIJFA6NEJobN9fvaG3fHVWczy82S/VLNHTFo44prr2EppQrR?=
 =?us-ascii?Q?ypEC1BZ6rRYScfavw9s3WM6pc12o6UJ7b4yipRH6NE/keRPF6n7F7fTnsjvb?=
 =?us-ascii?Q?x2GrQFXgleKkM8HfkFckM5tuAE4KlMns/NR9YBBRXNzcQUfgeVLfrbUDuj4I?=
 =?us-ascii?Q?cSCJGGh6WRuHIG0e940pkCTgIkQ1Fs/kjL6ikJuAzhELYLDPZeLiNq5xcR7n?=
 =?us-ascii?Q?ncDvG/n9hgo9LH4qzLKb8OVlHg1BnunolDtK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 20:50:05.1056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9acb673-51ea-47ff-8e1d-08ddf6f4f230
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9784

On Thu, Sep 18, 2025 at 11:47:37AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 17, 2025 at 11:10:15PM -0700, Nicolin Chen wrote:
> > On Wed, Sep 17, 2025 at 05:01:48PM -0300, Jason Gunthorpe wrote:
> > > If something holds a refcount then it is at risk of UAFing. For abort
> > > paths we expect the caller to never share the object with a parallel
> > > thread and to clean up any refcounts it obtained on its own.
> > > 
> > > Add the missing dec inside iommufd_hwpt_paging_alloc()during error unwind
> > 
> > Space between "()" and "during"
> > 
> > And I don't see this patch touch iommufd_hwpt_paging_alloc(). Is
> > that the iommufd_object_abort() part with the WARN_ON?
> 
> iommufd_hwpt_paging_alloc() calls iommufd_hw_pagetable_detach() so
> this change gives it a put that it didn't have.

Ah, I see.

> > > diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
> > > index 0da2a81eedfa8b..627f9b78483a0e 100644
> > > --- a/drivers/iommu/iommufd/iommufd_private.h
> > > +++ b/drivers/iommu/iommufd/iommufd_private.h
> > > @@ -454,9 +454,8 @@ static inline void iommufd_hw_pagetable_put(struct iommufd_ctx *ictx,
> > >  	if (hwpt->obj.type == IOMMUFD_OBJ_HWPT_PAGING) {
> > >  		struct iommufd_hwpt_paging *hwpt_paging = to_hwpt_paging(hwpt);
> > >  
> > > -		lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
> > > -
> > >  		if (hwpt_paging->auto_domain) {
> > > +			lockdep_assert_not_held(&hwpt_paging->ioas->mutex);
> > >  			iommufd_object_put_and_try_destroy(ictx, &hwpt->obj);
> > >  			return;
> > >  		}
> > 
> > Hmm, this patch doesn't change the scope of ioas-mutex?
> 
> iommufd_hwpt_paging_alloc() now calls this and it knows it doesn't
> pass an auto_domain but it is already under the ioas->mutex in its
> callchain.

I see. This part exists for iommufd_device_change_pt() calling
iommufd_device_do_replace() where auto_domain is the only case
that is ensured to not have ioas->mutex held.

Thanks
Nicolin

