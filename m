Return-Path: <linux-kselftest+bounces-334-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 698D07F1A91
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C286BB20759
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 17:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAED21A0C;
	Mon, 20 Nov 2023 17:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lLjb5JXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B81F4;
	Mon, 20 Nov 2023 09:37:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUxVIIcHGyS/ivmwPoXjaxf+WDrEN3AL+hGV7cKpI8fsUJKHA7/Dfl72oigaD5CV1mbg8CBkzHcuTsKWNVGDjerGeKB7A3WtWgS6YzaeK07TV5XB5GmtcGHMa1bR5KS4h71qb+EUGla+ZncYdyDErVMK7oq/MTWvVvM0vAeCUWEu1EIAZQby4MXz+hGIuAYK9hodOb4MiYU8RlqMyAnpZXntiQCu4ACzcFFnPaCDgE7Tuu/CxAJvkuPixwgQnRQNl+MVL1gAPRtxpJeKDAzSSfwd8fYIVS2PflHT2X/lR/Vlygwv02m+fgEFDaErSpBI05MCNd0hOfbwTc+NYKYSRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhZwJ20CqL6sdve2xchAM9rsVw29+8BY5EX0MItUy0w=;
 b=YjrGyAsOSwDDm5avZD7nfk/vmVf1UJ/FTp8cjqphMC1F9Sjc5BFwUW3cz+1iF0WFo/lhUgA251MIZbEJBKr5t1IWV2YPfvj3otkN1QDYbx8PNiKxGPZHLmDNRrceJ4HKzIDQIzsY3widyoVK21CifoyZ621nwjEgMFULwRGQQIWsc0uEs6CIuyt84WbK0iKsyGd5hJ2t+gEd7oBfCj08IemiAeQZ6qOQTceO+NxoKcnrK+K9fKjIxwIYE+M6Ur6jXcv34pkJjXRaZvPSD1+2kT0l4YL48Gu+CC4c58R2bVo1XoNFGBQhxmfz/C1fznnn2XSVrkrEK63poA7k98d2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhZwJ20CqL6sdve2xchAM9rsVw29+8BY5EX0MItUy0w=;
 b=lLjb5JXJ8fiEPsGDkVbuuLPr4tMh2dk1kCPUbqcra0xBdhMnEdFAQJ1syU5XRDFwkvBcNPNYGdMcvWfNn3e1tRJyy8Vvm8xiTGCMlGzPSrEc8CrqluW+FGTYI117cqykhAQw6jgz578S2nZvjDbGOrhqeDU9wEyO8TX9jtmARKZ2yB6cdPyY16lgn43cWLE7t4SRTT+GxEePzJnoDZSnu2GXEw6RSOJYuCYw92KP6WBGHZi6uWidXfyeUOSS5LXxe2bMPhKiCQ4aeo6mVSl5FjgdT/aE7v4zBI7ln+ExlJUqgrsVSIhvrZZSrcvwjSeJJLt++Am9sT1IkUuC5fp7BA==
Received: from CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::23)
 by SJ2PR12MB7867.namprd12.prod.outlook.com (2603:10b6:a03:4cd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 17:37:14 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:610:11d:cafe::dc) by CH0P221CA0043.outlook.office365.com
 (2603:10b6:610:11d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Mon, 20 Nov 2023 17:37:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.12 via Frontend Transport; Mon, 20 Nov 2023 17:37:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 09:37:01 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 20 Nov
 2023 09:37:00 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 20 Nov 2023 09:36:59 -0800
Date: Mon, 20 Nov 2023 09:36:57 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>, "jgg@nvidia.com"
	<jgg@nvidia.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "mjrosato@linux.ibm.com"
	<mjrosato@linux.ibm.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "yi.y.sun@linux.intel.com"
	<yi.y.sun@linux.intel.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, "lulu@redhat.com" <lulu@redhat.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "Duan,
 Zhenzhong" <zhenzhong.duan@intel.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Zeng, Xin" <xin.zeng@intel.com>, "Zhao, Yan Y"
	<yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 2/6] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZVuZOYFzAaCuJjXZ@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231117130717.19875-3-yi.l.liu@intel.com>
 <BN9PR11MB5276D8406BF08B853329288C8CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <fa736836-e136-4ed4-a6af-8ea2f0e7c0dd@intel.com>
 <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527659462CCB7280055858D98CB4A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ2PR12MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: dec4ebed-d41e-407b-298b-08dbe9ef54d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0WtQ0b+9HXG6TTj+StAwCjQOfnfLyCCZ8AFc4VMMFwQ7DLwNqcDDeUeqzb7ocIhvkHKen2xkK9muw7u8JAdxRqlhTmYNcG3//znRorVF7QgnyP3NslXSAF32TE2DAju5OzIS0TMXsfoPq7YLu55e/DOdl6nRW1l9r5hLCo0z25hraCNga/vivPZygVRNuWDPj0PSX4HUhNcEVqYOy/rlNprMvCNMf2lszhrXbLSxLbBl1FCSM6tU8l5IAkAuVKj4cEiCeilyImG1y5U1ijDkiLXDqC7gwhM0V0BPMKjef8U0MN+ScasMvmK5M+lr5L6D7VE9Pt4qZIPKf0cMLOw60kPybK/XnrhvhIIggAC8tE0RrMKMQgjT6Zf7BzaBgOKXONlWNt7vOiHF59H2juipoaQWhYhXeO3jtZiV423rc0qUIcgNlmNnCM9CGkg5Ht6EwY0xtgdFZjuyvV1FJ1ssSUPY4/gUGqJ9yInn4xqCLzMnAPtO7wbpbKKdMjML4+gYVLuc/3J2GhMJ7HOEBtvs8GLj7AgecbZVxgCxDbBjh6qzLOSVtCHdaWHr+XXEkop4a/OsLE+BigGlAyxliWwsfLeYm27PSCuDBdA8Jl89iVCcwiUhwoV3EhXjXlC1TfDCm63tpMfbvGXOkDfstCDd77rm5nbJs7aS1tPuBJti32gPHOQmYoN+dV0kZud/Omi91iFX4dm/+/U68GQqj9ViiPOCGxAIpIS7FLgwCGM+u0NIcDpK7BGyDn/QITw1vw9H
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(82310400011)(451199024)(1800799012)(186009)(64100799003)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(86362001)(7416002)(5660300002)(2906002)(33716001)(82740400003)(7636003)(356005)(40480700001)(83380400001)(9686003)(478600001)(53546011)(26005)(55016003)(336012)(426003)(4326008)(8676002)(8936002)(70206006)(316002)(47076005)(6916009)(70586007)(54906003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 17:37:13.1468
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec4ebed-d41e-407b-298b-08dbe9ef54d9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7867

On Mon, Nov 20, 2023 at 08:34:58AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, November 20, 2023 4:30 PM
> >
> > On 2023/11/20 16:09, Tian, Kevin wrote:
> > >> From: Liu, Yi L <yi.l.liu@intel.com>
> > >> Sent: Friday, November 17, 2023 9:07 PM
> > >> + * @req_len: Length (in bytes) of a request entry in the request array
> > >> + * @req_num: Input the number of cache invalidation requests in the
> > array.
> > >> + *           Output the number of requests successfully handled by kernel.
> > >> + * @out_driver_error_code: Report a driver speicifc error code upon
> > failure.
> > >> + *                         It's optional, driver has a choice to fill it or
> > >> + *                         not.
> > >
> > > Being optional how does the user tell whether the code is filled or not?

Well, naming it "error_code" indicates zero means no error while
non-zero means something? An error return from this ioctl could
also tell the user space to look up for this driver error code,
if it ever cares.

> > seems like we need a flag for it. otherwise, a reserved special value is
> > required. or is it enough to just document it that this field is available
> > or not per the iommu_hw_info_type?
> >
> 
> No guarantee that a reserved special value applies to all vendors.
> 
> I'll just remove the optional part. the viommu driver knows what a valid
> code is, if the driver fills it.

Hmm, remove out_driver_error_code? Do you mean by reusing ioctl
error code to tell the user space what driver error code it gets?

Nicolin

