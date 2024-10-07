Return-Path: <linux-kselftest+bounces-19171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193E6993482
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E73283D25
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40EB1DCB11;
	Mon,  7 Oct 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LDsSRDOy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2060.outbound.protection.outlook.com [40.107.94.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145291DC752;
	Mon,  7 Oct 2024 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321084; cv=fail; b=ouBmaom5/ufNRUY869iOy2peyKBnLpfyWVxA0o5dyPrXPPQNmBbMRb2ciWflC2zg5Kz0McHm2FrR0kUPYqldbk4MtPLz8HDprKzwycTP82wwtPce56lUWgB3F4CNuOVJeQwG5QhYfP8u/Hvi6glSKKQH2GkgHnfe8qJUHhVZ0vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321084; c=relaxed/simple;
	bh=gAlLVbx4J7ooikmefB70tjHCqTjvJtajV0Xadh+RTKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gGOFO+XG6rwwizVXsU0RrtsusfXv0I5bCldPpbyaO0zkmXNvBxeo+e445v56q4Fcs4Xe77qsBmPDrcdFfMEA7n6Hr98KA6dxZzMfpujFFlbIdQToXOtikvEFL1UTKReJr5i3Qv2seeMzb5bGtVS4+sIZNeFFgtniX8UF968YvQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LDsSRDOy; arc=fail smtp.client-ip=40.107.94.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKLpojojxqeGu4wGrFRUnWFE/iIALT1YRP//uHfgdLgvl7ELDWgyu0qJn+vDr7QIo2Xqh+ga4amR9jJjq7IGntjOe9/oANCapS0aFTkXHR4aL7jV0AAwfkWvx0z3uLBaDSjB/KDMHS+pu4n+nzDcOQX7YZ7U1b36CWZbk1UUuETWlO9cHQewLx6rC8Ce67eGcjiUiLMNV5PVmonzXjr9rsHPcl/oVtWdzXVzcmZY4RN8sTW3j1Sh/IZOimopMAoXOHD1f9oPM0rlUxrLHEngEz9ElC+vwqG10HRFniIhhRW1FOZIdB8pakUWj/Pl6pSCKOHeRWEhfDYVnSkrqXSKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJU4bru04wvPiEqGWa41nhX3PgGGm3YanxHxazw4Rf0=;
 b=YmM9SqOXq9kTtd9Xk+PV9UdokRsYXJMTQ9b+fWa5zvpyLfUorcWFcAjhT1/NslzipjMPa5MD2f0MruQ8zXAZnICzhAXa3TPciDwSIstPgIqoQohD9gwKyyoUpfk88HSS282ItQVZwi9trQwapMaBrocFgxVFhXlm39hhK2zN+h9ntx1x6PJ/emq2k4uFYU5iYCoyAo1SAh5vM0hgb3OolRUn7YLYTfXV+1pPiALJaCzuZ2wqU3PrXpa7cva4hol6EDukMu5eoLOMp5vxCgvMY5hrdNPhnDBpqrVeJbXw7jg39s4c/a/uiq+cxJgoRN756MRxikc/hnvnmYITR+aldw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJU4bru04wvPiEqGWa41nhX3PgGGm3YanxHxazw4Rf0=;
 b=LDsSRDOywyykavIHUvxDlbwxQe7LYZ3Fud9Gme3qktL84m5amJPZ6xT36Pn9wwnqBbOGDMRGXJVW4eGtZnCf3I/kFd6Xs1scbSBjPggtBOkbRd4gp75J+Hp2D/gV86Gh3VCQomRmGDLxqT5IFVGZE5AgttYbKtr+DxVvy+saJ5e/DsBAbmENlS+2ICZcma9dHnyrD/TG+zOfjbZ7c6kB1nD1ZkfJv0xrRD2/byEjVxfCfUjmkEUejY5uPNe+WtgjmE1K6J6Sb8USEPx2okQYRnJhfhbQkESlTB3dfQesYHBwKatl3MHl9Jv4Z/ZnRf3fasVWNJxl6PKX6Nku2Qjmjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by BL4PR12MB9508.namprd12.prod.outlook.com (2603:10b6:208:58e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Mon, 7 Oct
 2024 17:11:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:11:20 +0000
Date: Mon, 7 Oct 2024 14:11:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, will@kernel.org, joro@8bytes.org,
	suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com, shuah@kernel.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org, eric.auger@redhat.com,
	jean-philippe@linaro.org, mdf@kernel.org, mshavit@google.com,
	shameerali.kolothum.thodi@huawei.com, smostafa@google.com,
	yi.l.liu@intel.com
Subject: Re: [PATCH v2 10/19] iommufd/viommu: Add vdev_id helpers for IOMMU
 drivers
Message-ID: <20241007171119.GY1365916@nvidia.com>
References: <cover.1724776335.git.nicolinc@nvidia.com>
 <6ccdfb27c7aa5a5bb7e153165cf90114cae4687c.1724776335.git.nicolinc@nvidia.com>
 <20240905161415.GS1358970@nvidia.com>
 <ZtnwG/Kmaf+fZFAv@nvidia.com>
 <20240911231103.GR58321@nvidia.com>
 <ZuJdPHRbMeYFATT7@nvidia.com>
 <ZwDMb3F8/cCFhwcQ@Asurada-Nvidia>
 <20241007153837.GT1365916@nvidia.com>
 <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwQOAvoJrMWOuxxd@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:52f::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|BL4PR12MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: 918f6ab4-de9d-4aa7-e9ed-08dce6f30fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jHHO8Yrex1UYN5Gpqgw5Sxzj65eD2+nTC/5cqZYrJWZ5QFJzIn+VfnPkmUPB?=
 =?us-ascii?Q?S7xESOKRX6/B4Hn0nGGdbUTW5/e30jPFVwHdRheqwsT9pd57AXrse6wJ1E64?=
 =?us-ascii?Q?YeV+HMZl6HUB0JmMojedwQY4YtTZPsRrMoBD2NCi8SBy8CttFD7fubglnklB?=
 =?us-ascii?Q?UTYbuz09iOXN4hikN3XJLn7q4IaFr90kyUimtuD9letBq51WXB0t8adv235Q?=
 =?us-ascii?Q?/878Uy1+FehcPMJj2ccQ7jao1q5NnLoLk2Da038YQFO6mSc7C4wcLTIs2ySP?=
 =?us-ascii?Q?OOlRwsldtPU1Vaw7J6QNTEfOiDrRvoEhcMyNYC2X49vBFdpq23oU9FFmIyT3?=
 =?us-ascii?Q?cX1YSKStogEDjEo09Mgr2Ois6ybVb1DgwQ8pSYfo4IdNtbMlz1/JNPSlXQ0e?=
 =?us-ascii?Q?iQXgHRU0FZXISNssjcNoqZGSG2Srbi9Q7m6C3MMIAaQtG6VUm0XC8frPoVPC?=
 =?us-ascii?Q?S2mrtnPKfP3BQVUqtOgUzDR/FQmr4PeG+V13xWRz3LE5AtzF38jzXsbRqTuV?=
 =?us-ascii?Q?WW3Iv+zEDZi1DW1a+hIWtGjr/HDXG+QguJ8itJ0xURRYRl69UCWzxqLEqXL6?=
 =?us-ascii?Q?GTtXq8soJZ0PEDLkvgQvhclqxGGZLOjRL4CMFeW5tJ2zcdYFucJvTrSEn2M1?=
 =?us-ascii?Q?4k6ExG5T+JIKaA3sNregjdTDw5VhJEP92zMW0nRPHPQduYfmzGQzZu7Tli3v?=
 =?us-ascii?Q?5678otxiNI/POQuOBk/k4IZv5FmgKqxaB8Re1lzby+NZs40zVNUKvMtaPusx?=
 =?us-ascii?Q?hd+hp74seAU7dKj/vILf6reNSJ/79ruDMytpY+j1NgjjKQCkvWOMbriLVx0k?=
 =?us-ascii?Q?+EbxF6Gr5BzjzIDimvId/XsxDzgM926R61JAFxLZGJBuHvoojVnhpmn3DCjr?=
 =?us-ascii?Q?0/nMZ+vaYPPsV80wEZu/VZ/Z+3YmoSySraztVZRkkvDzvQrDvdVvHZWZj5kH?=
 =?us-ascii?Q?Wb0lzKdyCqVvHbvuN+RqJqeXmXA2+0PZrZy6XOpDIu6imzG1vHzKw4ilXdjJ?=
 =?us-ascii?Q?+k3u/BYqRNEoaXafwBHmy8KstM/t78Jzyl5lpbpHqRaGeG1Fe8E5geB6gxGn?=
 =?us-ascii?Q?onFxOUNDAzYUzD9LQe9aeuLlS66t3qqbc5iFJhc6S+a50IinuZrUn6VQAxzQ?=
 =?us-ascii?Q?fA1Ha48RlQvtket5DyktiKcKhZrtKmsk3qk6MAs1dmWyLiNOmPWpuBbC3B2f?=
 =?us-ascii?Q?w1ro4kN9qM8hrCS26Gi3z0XUH+VBbfCAzaUgd8Nb3Ipv5WUSwZOupxiPWrlh?=
 =?us-ascii?Q?0B0p49D0OySvdRP1ovteZTWnFLC6M1nMZwolr5i90w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f7HqZ5S3ffJuJHcs1ZgjsLzkiPGUyqXMRD5a3KDST+aiCtfNSghzddHBCPH+?=
 =?us-ascii?Q?EKJrz+J9ZB3p83EwiKeRS1UcVV+LAeEwQirBSjUSOMvaOpARNR7CAyA29xor?=
 =?us-ascii?Q?3mMLg2XWe7NERMQPcBHGT0wYqQL7yb0BWlL98RRe2YibmkkvLRwnDRyGMWTB?=
 =?us-ascii?Q?rExBeWiHjRmDXDJRzmy4ap7rFGCfmZs5qSTbLdTMtiTZsBmTE/TyuRwIMmuj?=
 =?us-ascii?Q?/YrBBpewJ37OdsS+yKxhuggAZDp1uKn3W9NNTPd0PIJ8miGQt8WRqxxxHz3s?=
 =?us-ascii?Q?VKaz1H3pc4lqEFxdxwdMyOrL9xmLYScRY2kK2xDAiz1eF3tmvnNv1vCFGpd/?=
 =?us-ascii?Q?affL73BXJrewUP4duGCSwoKyIeH9YctWVmDpzTX2S/bbozINiniYzYIjig1T?=
 =?us-ascii?Q?BJ8Tfa9J+h2EYOX5a7SNoUut1fb8WODVvN22fKvreQeDa2BETR1EKGnUZCgn?=
 =?us-ascii?Q?FUmfPnozaD+2VdyoeUQNgJ8x2v/BCuxzPYYf5ZchPDyuyH6LvJS+ZKjeS8I+?=
 =?us-ascii?Q?HbnPV/ZS2JkcJP40X0TFFUOCTNKMig14vlMoneuoo9KbJR/VFxrly3HgFmxp?=
 =?us-ascii?Q?45Hn3m//tFKDJEyC6A6KtXXieWxiGFiZvhgNStv2E9/N5cUzaJuY005eEiq/?=
 =?us-ascii?Q?v9ZqhCTR0S52m0tBGVyLsX6dpZS6erJ+vOLLYQTc8Sd5lmyFkScOYv1kfxMA?=
 =?us-ascii?Q?HRDz+4wG/M/F4iYc+HsgVOMRKHj5L0jShQomkq+zXbZQmkmnVNqSXbI4MjxW?=
 =?us-ascii?Q?EaFFirGfKc1NCaTEYnxS5giU0z7mRVXxYkcsoXBzYsCQme0Ms2gFm+HJneNw?=
 =?us-ascii?Q?8SfIQJo0mKspo738gVSPd5zH9Hu0nKfIy/VhReFdEtTdje1k3m4VuzgsuiZD?=
 =?us-ascii?Q?nfrV/yPy9L8jFkHxeVhAz8RhzLmiDe5/uASQV3udXz2y+0BzwlIoflrXZu2Z?=
 =?us-ascii?Q?Ybd8znFhalKbcukoqm/N96A9rpAYX4y5Fur2urWB4b49CeLVSsbk1XDoXdiF?=
 =?us-ascii?Q?G4/ryeDcXuvrSriWCAgDb2txjfg0jxXWeTGlRPI6YXj6wPVOS0yaJ1x0AAVs?=
 =?us-ascii?Q?bAUoQECCYu3Ezm/5hukAq8WE2vpGTME8WYOAyQibNGvEGuMy7nb7fAPbuuU/?=
 =?us-ascii?Q?Ps1XvUlOQ2vRU3wWq+bdN5x8ERlDM4Xgxx03msmgrFh86aXDfl46GqkQxyLl?=
 =?us-ascii?Q?ndpeQhlWVthoiZtDWgXXAfCyNFvx9AJ8o46LB4ON6eKj9+cUmUsTKvmyEd9e?=
 =?us-ascii?Q?L7eMkLOHpeYgZ5iT9xso5qf1ZvbVPKLzbnmmwQis5T3EAoGQE43cWVMyIzKf?=
 =?us-ascii?Q?6+LKqvUZ8Wj4i9jbrl9qsd6epJ1iUMQrNWc/ORFuq2slClrXAUWC4GCEFlV/?=
 =?us-ascii?Q?oHLJP2DRh5hArpJBLSbtV39RBzDSxoWbkf3wZXwDFQocAM/e5a7iCSNkYXmy?=
 =?us-ascii?Q?UsBDBEy26LsdOc1YiKAcTwve+itbSvBEgJGYnbYBKkbvB9J9Fb6/cQ6O5onz?=
 =?us-ascii?Q?J8qyHpRE7TYAyN7KD2qwPJXbcPFRfazakFeDPNP7zftBjhYNMm9l2mNfOEGM?=
 =?us-ascii?Q?oWkbZRIYfumZjz/Smo0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918f6ab4-de9d-4aa7-e9ed-08dce6f30fea
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:11:19.9593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Czcey7Og5Wqv0RtyQDEOElGbepya07M06WBfr2/aj78OLZZQKgzfYphgO0X/iTIi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9508

On Mon, Oct 07, 2024 at 09:36:18AM -0700, Nicolin Chen wrote:
> On Mon, Oct 07, 2024 at 12:38:37PM -0300, Jason Gunthorpe wrote:
> > On Fri, Oct 04, 2024 at 10:19:43PM -0700, Nicolin Chen wrote:
> > > I tried exposing the struct iommufd_viommu to drivers, and was
> > > able to drop a couple of helpers, except these two:
> > > 
> > > struct device *vdev_to_dev(struct iommufd_vdevice *vdev)
> > > {
> > > 	return vdev ? vdev->idev->dev : NULL;
> > > } // Without it, we need to expose struct iommufd_device.
> > > 
> > > struct iommu_domain *
> > > iommufd_viommu_to_parent_domain(struct iommufd_viommu *viommu)
> > > {
> > > 	if (!viommu || !viommu->hwpt)
> > > 		return NULL;
> > > 	return viommu->hwpt->common.domain;
> > > } // Without it, we need to expose struct iommufd_hwpt_page.
> > 
> > It seems OK, there isn't really locking entanglements or performance
> > path on this stuff?
> 
> -----
> The typical use case of the first one is like:
> 	dev = vdev_to_dev(xa_load(&viommu->vdevs, (unsigned long)vdev_id));
> so I am asking for:
> /* Caller should lock via viommu->vdevs_rwsem with proper permission */

Why would vdev_to_dev need that locking? The viommu cannot change hwpt
during its lifecycle?

Jason

