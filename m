Return-Path: <linux-kselftest+bounces-1620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2097180DD0B
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFED81F21BA4
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDD54BFF;
	Mon, 11 Dec 2023 21:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aplshGLV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2065.outbound.protection.outlook.com [40.107.212.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F110CF;
	Mon, 11 Dec 2023 13:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TevFgiSkD+sje6W1P497EM4yaO/dpmacP3ILRqT+mjEHYqH9Vsl+ey+uIWf3yNZkxQD5+0Ulorz/8OMbyfoWrIfb/4L/bxjE/jcl0nfq9IVqj3ey+oZLgxCdqv98YxvXKeCYUMzds7SuOPeig8y4I1P4xWFqe5dWAtHP/O1jD6b1dZ0COS+SztblvEb+QE7xsE5ds2M+dXgtR9uDaf5wOJ83noYEhwfdBMflCOd4nUruK+y2TEQdfz50OwKHUIF7iB7glJcE375aAzPp5IvI4opc74SXXtkJ6Q7sdAQM+BoR6bFKEmxFhXFBUEWxV7MDVPdOq8rEQF/Tw0F7ugs5+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FRuUIXl8vaVDPnHNevsfNZMWl/SiN74UHPxYdbcKI9I=;
 b=W616bceWUrI+OcdxQXpuLeBbsr+bbTz2qlEv95fAzSfH+ZyjikOuMEwd62/uXDNzlDDoeu+9+y3jvs2SW8BTzrs63xGWwLNH+nmLN8uXO7fE1GLqunkoyqm32M+u2sbmxAqBNODjzTqxVUKx+SdnXiH+DNYGBUkZydcbckXbjTxHuDLqq9o2mpVZXtKGoLA7vkMmrpdj0sez4YKOXiB+F1Qj8K4nvOmeLuuXdqB57J+avsXcAd8RiUPf/g/Lw0EmTqWn3MYXJEmx7bJE800/ndcGQK1ZQqn6SQFYHo7M4STzzLab9WsZ6JRrGY9PWD2ZSmA5c829Zjl6v1mO+Omj+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FRuUIXl8vaVDPnHNevsfNZMWl/SiN74UHPxYdbcKI9I=;
 b=aplshGLVtE1k1mRSFThcMgLfIadvldhjd1gjnFQyzbRhFKU6AhS+jA5A2/di/ej+XChgsgPoazwRqudSF2p5i3AeLZ01dHHT7eLR4OwVs6zmbEN38//Qubf0w6z2TIQvBc9qiMLWkx8RSYer+9SB5qMfatuPLZ+FIfb5NaITSeTqyWCSp+rcfDaDgP4LkbYC0g8rIDHmhROszNZFU8JT+Pc88bfF8hnsIbUue56aEHqgr6R2+WBTOn7LTd+WtXnsb3TdkY9/4312ZBQs3UkHtm/7dt7h66GjCCxDy11HmCWz9NnAkNmAfv9lTP8SBn4fYSyZO5Fc0AM9qWk868UVWA==
Received: from DM6PR06CA0101.namprd06.prod.outlook.com (2603:10b6:5:336::34)
 by MW6PR12MB7087.namprd12.prod.outlook.com (2603:10b6:303:238::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:27:58 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:5:336:cafe::ca) by DM6PR06CA0101.outlook.office365.com
 (2603:10b6:5:336::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Mon, 11 Dec 2023 21:27:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.18 via Frontend Transport; Mon, 11 Dec 2023 21:27:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 13:27:52 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 11 Dec
 2023 13:27:51 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Mon, 11 Dec 2023 13:27:50 -0800
Date: Mon, 11 Dec 2023 13:27:49 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, <joro@8bytes.org>,
	<alex.williamson@redhat.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <cohuck@redhat.com>, <eric.auger@redhat.com>,
	<kvm@vger.kernel.org>, <mjrosato@linux.ibm.com>,
	<chao.p.peng@linux.intel.com>, <yi.y.sun@linux.intel.com>,
	<peterx@redhat.com>, <jasowang@redhat.com>,
	<shameerali.kolothum.thodi@huawei.com>, <lulu@redhat.com>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>, <zhenzhong.duan@intel.com>,
	<joao.m.martins@oracle.com>, <xin.zeng@intel.com>, <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <ZXd+1UVrcAQePjnD@Asurada-Nvidia>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231209014726.GA2945299@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|MW6PR12MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c53d2ab-6fc0-44cb-43b7-08dbfa900c1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0mmV5Y+jtYcSrjwb1Wd7ermE8W76poF7IeewZYZ3FrHJpmmemBZPFLrUrStKFGEhylE5NzvJrV8WEKm6G88ATjT35hcADxESXE745iMwmm+4jQ9q8XDcclfZiNW3xcSV+ElK/wfdevj64y9ZqQIluX5cXZqXAEd/D2LJz3hNkZqIvxBoNwewyugxJ3MDpqlmryxlvsbYYjVJNSY2qnSXUH005tBE9cr7KFVU+eVnA5zKhg6+pFtvpnxAlTdo8xHapRp8GqRIy+jD3iino9qf6UTG/ag4gAwFXZdyXUJACNUw7MQ1Cf1Vg2KV+8+AtzBnXj52/oKvUViJuAFw7qGXlhaAIAZYeF7s0sogY5JmSPYXvqc6pLMoxYTDpW2/JSVku+HPKSXWTVLdIDB7wQG1OXOISLMaz9EGxBWaiOKZ9eDRsQrqfCOPgs1ac7y1oSHe9umHiWUiw/dFCtL7Sf7wCfImhL+9qBT9O8N1XcdC08JfiV3Sxpp+M32WOuisWI/LQa4RNnVC/nKkuQ/tcplVK/2K14hRafqDffzsf2jCTF7ZD/ltBMvcMHeuuCNMj8CNO6+1mF4JTv/RS10ec1RvMBs0mh3URNIss5ax8//847fktHGkDzWUX3B/D8eFGyWFBL7ZwR0RRHUvTuYyoJqEpe11qEENBq5hPZFV4VLN1j3vQ4hmX0tasbvpDgrR0J+8EaXF2EVq/PFOQDh6jPwwHCXpEgz7Ar4Pr8igMprJRMI4bBojgyVLWBoll+xkDLUSeDQ87LCCEHAzx0V0ucM8qg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(9686003)(478600001)(70206006)(316002)(54906003)(6636002)(70586007)(6862004)(8676002)(86362001)(4326008)(40460700003)(356005)(7636003)(82740400003)(55016003)(47076005)(36860700001)(8936002)(426003)(40480700001)(26005)(336012)(83380400001)(7416002)(5660300002)(41300700001)(2906002)(33716001)(67856001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:27:58.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c53d2ab-6fc0-44cb-43b7-08dbfa900c1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7087

On Fri, Dec 08, 2023 at 09:47:26PM -0400, Jason Gunthorpe wrote:
> What is in a Nested domain:
>  ARM: A CD table pointer
>       Nesting domains are created for every unique CD table top pointer.

I think we basically implemented in a way of syncing STE, i,e,
vSTE.Config must be "S1 Translate" besides a CD table pointer,
and a nested domain is freed when vSTE.Config=BYPASS even if a
CD table pointer is present, right?

> To make this work the iommu needs to be programmed with:
>  AMD: A vDomain-ID -> pDomain-ID table
>       A vRID -> pRID table
>       This is all bound to some "virtual function"
>  ARM: A vRID -> pRID table
>       The vCMDQ is bound to a VM_ID, so to the Nesting Parent

VCMDQ also has something called "virtual interface" that holds
a VMID and a list of CMDQ queues, which might be a bit similar
to AMD's "virtual function".

> For AMD, as above, I suggest the vDomain-ID be passed when creating
> the nesting domain.
> 
> The AMD "virtual function".. It is probably best to create a new iommufd
> object for this and it can be passed in to a few places
> 
> The vRID->pRID table should be some mostly common
> IOMMUFD_DEV_ASSIGN_VIRTUAL_ID. AMD will need to pass in the virtual
> function ID and ARM will need to pass in the Nesting Parent ID.

It sounds like our previous IOMMUFD_SET/UNSET_IDEV_DATA. I'm
wondering if we need to make it exclusive to the ID assigning?
Maybe set_idev_data could be reused for other potential cases?

If we do implement an IOMMUFD_DEV_ASSIGN_VIRTUAL_ID, do we need
an IOMMUFD_DEV_RESIGN_VIRTUAL_ID? (or better word than resign).

Could the structure just look like this?
struct iommu_dev_assign_virtual_id {
       __u32 size;
       __u32 dev_id;
       __u32 id_type;
       __u32 id;
};

> In many ways the nesting parent/virtual function are very similar
> things. Perhaps ARM should also create a virtual function object which
> is just welded to the nesting parent for API consistency.

A virtual function that holds an S2 domain/iopt + a VMID? If
this is for VCMDQ, the VMCDQ extension driver has that kinda
object holding an S2 domain: I implemented as the extension
function at the end of arm_smmu_finalise_s2() previously.

> So.. In short.. Invalidation is a PITA. The idea is the same but
> annoying little details interfere with actually having a compltely
> common API here. IMHO the uAPI in this series is fine. It will support
> Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
> setup to allow that the target domain object can be any HWPT.
> 
> ARM will be able to do IOTLB invalidation using this API.
> 
> IOMMUFD_DEV_INVALIDATE should be introduced with the same design as
> HWPT invalidate. This would be used for AMD/ARM's ATC invalidation
> (and just force the stream ID, userspace must direct the vRID to the
> correct dev_id).

SMMU's CD invalidations could fall into this category too.

> Then in yet another series we can tackle the entire "virtual function"
> vRID/pRID translation stuff when the mmapable queue thing is
> introduced.

VCMDQ is also a mmapable queue. I feel that there could be
more common stuff between "virtual function" and "virtual
interface", I'll need to take a look at AMD's stuff though.

I previously drafted something to test it out with iommufd.
Basically it needs the pairing of vRID/pRID in attach_dev()
and another ioctl to mmap/config user queue(s):
+struct iommu_hwpt_cache_config_tegra241_vcmdq {
+       __u32 vcmdq_id;			// queue id
+       __u32 vcmdq_log2size;		// queue size
+       __aligned_u64 vcmdq_base;	// queue guest PA
+};

> Thus next steps:
>  - Get an ARM patch that just does IOTLB invalidation and add it to my
>    part 3
>  - Start working on IOMMUFD_DEV_INVALIDATE along with an ARM
>    implementation of it.

I will work on these two, presumably including the new
IOMMUFD_DEV_ASSIGN_VIRTUAL_ID or so.

Thanks
Nicolin

