Return-Path: <linux-kselftest+bounces-1565-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB2D80D083
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D40C2B20CCF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 16:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6754C3C6;
	Mon, 11 Dec 2023 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hYtrLQn4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649CB137;
	Mon, 11 Dec 2023 08:06:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/Sst4XnnHKVKYyWpD0f/XHpptoIQKSdkzjQ5B0h2YqYSygzGIvxWkM4r1qKTMGzkUFUJnEJt3Anp4wlvR917XDKZtxMfdeYC91PwNVJUcGyXaVmK6Uqnma3syKFvbM3VZt4GF2E/sbAcWmmRHWNUkSykyY2lA7nPFgn8hIl5fOAjS+CMwL9TJ88iYL9CEKwcdg2rdtRoIGj+2bVH0bEOpbe9zIm/uqiFvd4hOZGK000gRIeAsWnNcf72Fnuh8xge12qzPzNMWuzk7j/USLe8E8CqvEh+7BlzuR9wXlv34hapJ3NiCvF754WxKeWXuYRWUaZCUt6XIfd0utffDjSMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE3O+0ZvK2JD1c9JBdJx+fcCBvqyhVcUf5l6qIdyJ8s=;
 b=idZyZNiOzQOfKfdZjtSn7QxUyIYw11WfhNiB2Rnd1Fyvlq11KhrFGgdH3ISs/0qYry1zvcBGDknvmkfo8AT3mzuUJp1ZAPBwvoTnAR/EnT8G1sFL5qPbYUFk3DILPV0CJCyi75MYZTNsW/FTFZP97TSv888vEUwsedwkS8Oo4mEQDSjCUTz4axfURjO396guwY/S5EOUN8gKzb3LiGZqiV8alnb16p/+vG6nMLMGgL+W5KIiGgcvWRau6+O+Y6x1q9+U7B4tqYA/PklXZbe4gme5/nkwAB9iH02Np7f7e/arxD9r9FuQBCpG9byD3yBkMpim+UElv3iUCvIaLFiq9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pE3O+0ZvK2JD1c9JBdJx+fcCBvqyhVcUf5l6qIdyJ8s=;
 b=hYtrLQn4zXy+CGeRJFgC7v+sNRwcUVOh/+tveAAr70r89pBdMOydfGNx0hpemexCocjD3lRGcvAZzGNMOLj3cDlSrnmwVNLcsVl+EpB0FN3azcpuVloYXgNjbnSPPvQPK4YkPKBkvaKFXjygd0ZbVDB8GjhiZB5iDaaSWIqiFXcbtgjqap8iJefo0QgzVqr8Diy+J1Nm28qU9Mg+xtq5YqbXf6lgOzCXaXCdekvHafHmHruiiljfNhWSCx0UX9WqOisROkZkiSf5HfFW60nGZRHUcSozcfr2001b7nUm8beB/cFE0+caEK3L8aFUkuQDbQom5JPNyANdro2pUiqQng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 16:06:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 16:06:33 +0000
Date: Mon, 11 Dec 2023 12:06:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
	"chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
	"peterx@redhat.com" <peterx@redhat.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	"lulu@redhat.com" <lulu@redhat.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
	"Zeng, Xin" <xin.zeng@intel.com>,
	"Zhao, Yan Y" <yan.y.zhao@intel.com>
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211160632.GI2944114@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <BN9PR11MB527647A4DA1620DE354983898C8FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <3e77a4a3-3be8-4e04-9435-1f66df93078d@intel.com>
 <20231211130555.GB2944114@nvidia.com>
 <509489ce-0169-4021-ad56-a31544752aa4@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <509489ce-0169-4021-ad56-a31544752aa4@amd.com>
X-ClientProxiedBy: BLAPR03CA0137.namprd03.prod.outlook.com
 (2603:10b6:208:32e::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e197839-b503-45df-2c2b-08dbfa63253d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKWb7Tu5iDs7HVw6oSLxWXLhNua5tbWA+6VrmFXPOW0mBO5ngr9MU0lqzAGBhBEwOtt0CuyZBkoyptwRPJnXdHsBPDvvAWTuHcnxJJpRQc+i/qbxTNESUVBZdnAN+9SKT/YCwrCLs+5OYOPIwivZi7gMyXJBMYyWISUJu2D3rxCrxmieGDhXeE5mHBPf/QFXMKCUL5TMcl6JBPXDTb26gOQZ+wwQqsJt6Ha0Y4HH2XVbm9hbxX7IrTqVxX33wcWiTIb2Vu2UNVzglS8fuKW8sJAcLaCUnX5c+V3CWjSkf4/QKD/Zwx240N1b3yVeilIqUNQE1MpFkrDCgmpZ9jmZ54Ou7fqjU+luaH4FZo5tsIXBWCoE1v2wwj2q0OxwkVoVs7TjIuNoJ7ET1u5XwLfiYkEyVQ26xP3nrozg4DJkMhsQyW2JAAiDLHynqN73Yedl2oVdQ7fuVXWgaBz1+PgGyCY6biYzrzJB/oRJGGxkc6MKS8DvXrP6ULNFxPcvEEWNNVFlMo+MSSzY09DM/aq3yJLxtHlIO9w/N6d56+65Mys3eeUCqTW+wCPYpi+woktm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(6506007)(5660300002)(1076003)(26005)(2616005)(33656002)(36756003)(7416002)(66946007)(6486002)(54906003)(66476007)(66556008)(6916009)(2906002)(41300700001)(478600001)(86362001)(8676002)(8936002)(4326008)(316002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lFP0vGsC4zehtiAhMdxq14tLgWuBlaaZAKu88GIBYLA2S2Zlc7UsyygOs+c/?=
 =?us-ascii?Q?M6WAeG8WdAj7CiCHjJetw9qrRukBxDNvHHG23fxe6hFk/Jzh74xt8w13B52y?=
 =?us-ascii?Q?oMfCflfQSsPAUlHaaXm71ft41Wzx6vlVUhT7DmupQW3U3QYE5SES/t3NpP4q?=
 =?us-ascii?Q?L8ymPALbxXGgIrf1CNSqhluJz1PRj5rWWMNWBWiMmQNdr2PT5Mb8UeFdB576?=
 =?us-ascii?Q?2jHik47y3bE9ZOOAFs+pUQypweCzXOrQ7cx8msy9ZcEjaUOlCxTUWlsAECCY?=
 =?us-ascii?Q?55drf2KXcO+Z8e5gdemWGWnUVMd8BlWJsVXH5WLupSkwfN2DzpXI+Ss27540?=
 =?us-ascii?Q?N/z/vXW/AcNY2LcAiK4jWAwW8m+jyOPGwQmFB5yUS63g1EnYdBjGjSZq4QSz?=
 =?us-ascii?Q?9MJtT5s7pfoET+igd3cMTD2V7b/RZqZjQNTikmBWVrISur2WbtlISJTGk7Md?=
 =?us-ascii?Q?ajRd98weyTKj6Al8enMStFyQuLYRHIHL5NFlWIievogvPL1klJZsHQwyCaX5?=
 =?us-ascii?Q?Z5lzW5PWi5+/MiAoNYgPTKG1dDvzkhurfIt4Ce9sEJ9mR5VqgSZanf9Vro4f?=
 =?us-ascii?Q?U8PE/oJ1s9IXiaq63CqY3cHF51uY5jjIiFUWu4Ft50xYTeP9Q1edCqaOWySS?=
 =?us-ascii?Q?gv1y46pKASoJfvdcMKui4ziEdBvKNj8ehrNi4nn8+R6hYrtpCxeLTmPLIWo9?=
 =?us-ascii?Q?Og500SysA7s8Zmr/yR3iyDzh2j0uvQ6ZsychXDhvyuU0I0gzkPjQEBh4npDh?=
 =?us-ascii?Q?nxyo9E99D8f7b2UjiGioJBwPEirWzPy2hgLPcGa69/OS8jKi/R8ZRQsWHivn?=
 =?us-ascii?Q?oh8p3MKK29UW9pGjc7qEfH2oZyCjuUbYiM12qtmhbsAFoLudFgxcvu5Ldg4U?=
 =?us-ascii?Q?XpUBNxfxfr7TxsCj6XlXKLVgZqg+DoHmubsTP6u7UxYNz2/kAPNwuYXeQu3W?=
 =?us-ascii?Q?kbDwi4jqRS7iowwp1UTMx1pVjmh8ZsKBCkUX3krABKe7TcQQpcQAbaKqj6Rj?=
 =?us-ascii?Q?Il0TM4IK8tuZ5xq+ASQcVzu8itYvJEWsue4VY757h/Lj7Df9nlJZ7mA0PCVF?=
 =?us-ascii?Q?zytZcsUmhgLVc6NH/craoGOuon2Kb18E2PVN6zTL0AiUYbPKbYSdt0B6E/il?=
 =?us-ascii?Q?0booimHuRCtaSwVoifzVIFh0ZjxoCUvaLBrhXWeM6PceXpa69as2e4tayFKH?=
 =?us-ascii?Q?HZGKXHLJYM4bRa9gOMqnDB9ao4AalwnBtzmbMgS117dWZabciZCytLAQcxTi?=
 =?us-ascii?Q?iin/XHyQBfrL2YK0pau9jNFR8hYtEe8u3bXYjplfsqVC1pWHjEMztda8306M?=
 =?us-ascii?Q?2QZuPjS3Cwt7P/Uohh75mTauFylhHYoBv1dMfn4o6OGYWQYyKgnXoTu3vMM2?=
 =?us-ascii?Q?QgmOoffsZWsJ+/dy1AJSetWbcVMmx3Swxd1bdBfUOElKS21TEU1qtcqlGSSM?=
 =?us-ascii?Q?lyYEJieS2xXaSuJKDCSdXS4p/nbRY1EbHON+M19lSkVjD6ceagmum605Q9pN?=
 =?us-ascii?Q?6zTupLnDkvcwQu+yJEUBRIjImgEFVoH4SFDaMkqb3VspiZAO06CvNfgmy6kf?=
 =?us-ascii?Q?/GyycwcW2rVfdTY+0+/ggUDxmbl+hiwkGnfABI6U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e197839-b503-45df-2c2b-08dbfa63253d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 16:06:33.8155
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65Qa78exazLFvvK1hxxYCD/TOqzb8emCXSyOh67a6MiRE9JgdvNZnplARv82kzff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552

On Mon, Dec 11, 2023 at 10:34:09PM +0700, Suthikulpanit, Suravee wrote:

> Currently, the AMD IOMMU driver allocates a DomainId per IOMMU group.
> One issue with this is when we have nested translation where we could end up
> with multiple devices (RIDs) sharing same PASID and the same hDomainID.

Which means you also create multiple GCR3 tables since those are
(soon) per-device and we end up with the situation I described for a
functional legitimate reason :( It is just wasting memory by
duplicating GCR3 tables.
 
> For example:
> 
>   - Host view
>     Device1 (RID 1) w/ hDomainId 1
>     Device2 (RID 2) w/ hDomainId 1

So.. Groups are another ugly mess that we may have to do something
more robust about.

The group infrastructure assumes that all devices in the group have
the same translation. This is not how the VM communicates, each member
of the group gets to have its own DTE and there are legitimate cases
where the DTEs will be different (even if just temporarily)

How to mesh this is not yet solved (most likely we need to allow group
members to have temporarily different translation). But in the long
run the group should definately not be providing the cache tag, the
driver has to be smarter than this.

I think we talked about this before.. For the AMD driver the v1 page
table should store the domainid in the iommu_domain and that value
should be used everywhere

For modes with a GCR3 table the best you can do is to de-duplicate the
GCR3 tables and assign identical GCR3 tables to identical domain ids.
Ie all devices in a group will eventually share GCR3 tables so they
can converge on the same domain id.

>   - Guest view
>     Pass-through Device1 (vRID 3) w/ vDomainID A + PASID 0
>     Pass-through Device2 (vRID 4) w/ vDomainID B + PASID 0
> 
> We should be able to workaround this by changing the way we assign hDomainId
> to be per-device for VFIO pass-through devices although sharing the same v1
> (stage-2) page table. This would look like.

As I said, this doesn't quite work since the VM could do other
things. The kernel must be aware of the vDomainID and must select an
appropriate hDomainID with that knowledge in mind, otherwise
multi-device-groups in guests are fully broken.

>   - Guest view
>     Pass-through Device1 (vRID 3) w/ vDomainID A + PASID 0
>     Pass-through Device2 (vRID 4) w/ vDomainID B + PASID 0
> 
> This should avoid the IOMMU TLB conflict. However, the invalidation would
> need to be done for both DomainId 1 and 2 when updating the v1 (stage-2)
> page table.

Which is the key problem, if the VM thinks it has only one vDomainID
the VMM can't split that into two hDomainID's and expect the viommu
acceleration will work - so we shouldn't try to make it work in SW
either, IMHO.

Jason

