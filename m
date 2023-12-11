Return-Path: <linux-kselftest+bounces-1622-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644C680DD86
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 22:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1091F21C08
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 21:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DBD54FAF;
	Mon, 11 Dec 2023 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CMP/RVUx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2065.outbound.protection.outlook.com [40.107.244.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E46CD5;
	Mon, 11 Dec 2023 13:48:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBpxw8+Xic6YoM9bj/HrqoVUVrrPGA1uo+ncozHX04/cCrhDeo0a83EW0txzUPC5y0LrgGxXDl4h12xqmuL2vStkS9XjoLpaGSzZ0uKNPC/9nsIEQRElfxnwzW3qwwaBo0M1p0+E5+noBVf+b0GKHMHu0DpjHY00ObPCR70pWfra/Ya/DCcbTzu26qhgNNx3UMUwbxzR9BWfhMfTVYuN/etQXJRsf5GT8vhbhgitmaf6OSCkJUxBu31tVH2bzYtbJ4nxShAFG1ZkyjWsPB+jrEVI75JsMQvp07QgrWJpxC7uwATqN+IvOI0hXC1rsuRqBt1xhKHm0G9HDPrrIhutQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TX0lSt+o+2FnjAgjWeFMslPvvVURHD8S0u7zd9l7UjQ=;
 b=ci5bJFl+EX7ppH8QtabAAmxjqOA734g0z8CHzHYlURnBWl5GExiDTgyvsRxqhoJ1Dwvc5zulv8HfuddZoWHJ1kE36JOAIFbbBu1BMKxZMo3P05ppLqm/oHxbK1MZN4vFCg+tAra2Hx2755XoxGlHZ1tJR4BCf6Kcso3aNiGX13HWXvJpTWY+XI+p/aqee9t+m7AO7zP3VBgWhbRFN3trMD8zmV/9tw03FMnRCKDhmQjGpKOjLIwDpK1OYCg5XRnzOOpjZghUag19WXbhkAcmA+0sGL2v1UbL4IW+S6M7OX3cqyToRr0R+wn2MAsp0QMd5SUXScjN4FUa76nQd/NhSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TX0lSt+o+2FnjAgjWeFMslPvvVURHD8S0u7zd9l7UjQ=;
 b=CMP/RVUxF8vyhjjV8MO5Kv9noxCEBBvNutmT9Z9Ki0LshziKzOEH1PgzVUWPa7RqDHbc7eUxgtHeA4N7mdTaUfmnYfsRuFTovnB7ioKcQFEQzuIrZOvG7HX9v9cQ8CAgmtlfGVf8F0LmqgzZ7PoPa58Fe+ZSTqRsE64Mt9iLu2UPxiQ2spjucbsFc9DZ+DTH3N8P8yS1bfDfMbK1QxNFRvnN1RscIhF5TetevEB9dXZnh7dFnqSdH/BX8nnP0n3Vc4rOwKxBdKf2GSXtQKVNu9f2Sc4vdQygGY6GJ7zAnzmnZXfpeseDUdt97AWKagIm+w0NWu8RPlPhioD+n332Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Mon, 11 Dec
 2023 21:48:47 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 21:48:47 +0000
Date: Mon, 11 Dec 2023 17:48:46 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Yi Liu <yi.l.liu@intel.com>, "Giani, Dhaval" <Dhaval.Giani@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
	robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
	eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
	chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
	peterx@redhat.com, jasowang@redhat.com,
	shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, zhenzhong.duan@intel.com,
	joao.m.martins@oracle.com, xin.zeng@intel.com, yan.y.zhao@intel.com
Subject: Re: [PATCH v6 0/6] iommufd: Add nesting infrastructure (part 2/2)
Message-ID: <20231211214846.GA3014157@nvidia.com>
References: <20231117130717.19875-1-yi.l.liu@intel.com>
 <20231209014726.GA2945299@nvidia.com>
 <77ac47d0-2ef0-41fa-86c2-091358541465@intel.com>
 <20231211132041.GE2944114@nvidia.com>
 <ZXds7V0Dz0ycF5IR@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXds7V0Dz0ycF5IR@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:208:fc::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc646f7-810b-4600-780d-08dbfa92f454
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PzAJQwCJbPtkTQtMY3SwuQO7U3iIw4moJLm5Og4fjYV4wpdF+NTc0rhg+sxBU/BZo147qt5XFkNH1MZA/UrSwrfmI8or12VfmivRjJNAkQPCDwDg65zZb5RAl+a33wf0ddGujnxPW5r9tj2dlUmlnLgyBXg9TGefythsFgVA8HSrL3rA76uIzdWyRAIWGDcAas2i2Vn7BzRrlqiDjRkdEV4aZclklXgCaYo+JsON/wopXsxFQryDKzgGnIMJb/O+b3nZqak9keyY/Ag4hsvEH/mgBX0dXSVsx8plF8s8AKOkPjmiEsDH5VlPeyQ2sLvj6cETjiFOo5dBBMQ+NG8ZwhiKrk4pY95Nuzrx94HSy2VcQxydYSQDQOSPfBbpokqe9lA5cEl8eMMX2JjupsgkstCM4JR7CWJat48ob4Ilf8BQ4L+Jj1N5YdZCgml8JNRR2taWFIdn1J9W5HQi89cwDTdH/WKmzyQvPHu6aKSnUanP2WsQuaQxzP9OkssUJmVmCWkt6c1yaLYqc8voSG8PRhGYJ2Vf2/Wo7sdrWkh1dehHWUkJygEoV40o1gJ2t+WB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2906002)(41300700001)(86362001)(478600001)(66556008)(66476007)(6636002)(54906003)(7416002)(66946007)(6486002)(316002)(38100700002)(37006003)(8676002)(6862004)(4326008)(8936002)(6506007)(6512007)(66899024)(36756003)(33656002)(1076003)(5660300002)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VyBfoeU43U/AIzoA/551ueGOliW2d0OGw8kG/z2AZWtQ76kQHxmsnAIda0RP?=
 =?us-ascii?Q?b/tYDe0I7uB7ooWkl4/wtZha0Kpj/J16AFNFx4DVU1381xGPLCqlTBai+Mvx?=
 =?us-ascii?Q?ZX+3DIJFww5ojTl/ML+Wvw5AmgsnKY+RIckeMpSwmj+ITNfx4OhfpZes69jD?=
 =?us-ascii?Q?cjvi+x7nfi0l6IkjbsH8XckuGHiZkuLAmuafUFPoCp3HjvGHIEpAjmIJvc2l?=
 =?us-ascii?Q?dysbhxYIMnEoHFaMaPQTrV+w4QK+0SMED6yInxrhJz/RXOKu3m+fmTlp1hG9?=
 =?us-ascii?Q?PWQAFWaGqPkO8uacvUT1KsAtmllNKq87l6uO5t79dfL5wP0E4XtGO2lSwLcJ?=
 =?us-ascii?Q?QhfqvWQqVJDso8OrYOwSrj2ZNsrvDH0zayQHnVu95545rT75MsjPuCVQrhR8?=
 =?us-ascii?Q?xV4UWFZJaNHj8pRJU8oUZE4S25esuqIT2mKKFfBrxL4OkhvknmiSzxi7rNaW?=
 =?us-ascii?Q?6ki20i61LJPe7uVtiS14VklX/Ry8s1csJqxVjROEorAvcTnZ9FJ/rBxKFTDM?=
 =?us-ascii?Q?C6tPBIdx6MW9Z9LM0Z1WOWyYyZKt7jymtWEpPopacy1pRxVoBpcRZuboCwZ7?=
 =?us-ascii?Q?2pU/HgQzVOizP4zzO4QLeUByi4l9zJ9ctXGHWeVr893tfvk6M6yB9dn7HFyH?=
 =?us-ascii?Q?qo0a3Pr1UAJ8RVRT8ukRXu+Z/qfteiT+r0Pyv3P71wjY4ZVP5DJR3QAmVSn/?=
 =?us-ascii?Q?yBmF48RZhd2FKQAMNUevSpaFA8p3Dlebf5iJ1pWDqW1mjkx9+ZF012G+gFQ3?=
 =?us-ascii?Q?WWBsXE1PuFItgCTvY/BDyUGSsdDA2Mq4tGnHFbsLZzByjHG6cVCDGJCLzQSZ?=
 =?us-ascii?Q?S/FeHtblW4VO9/FiB1sAcj8Z8WXl1Zdqjoq7vffQaQFisDCd4CjNayBqySnF?=
 =?us-ascii?Q?zACFLPuc8vYk8v1iHvjwOd5+VZ95vg1K2UUy5QwD6SjYbw/FDCM7U2O4uZhP?=
 =?us-ascii?Q?tWZWaQOi89PnokxZppNDydjLDxx+VDDoG/n+fn7O4wvmfiE3UpsbTUimK/7l?=
 =?us-ascii?Q?OFHnu5FXIC8IhrzOlNlSjpCbcZerxgHKAqAHaAgNkS0Nm/SkwHFqik0HG+ov?=
 =?us-ascii?Q?nUrpYsDdDBRAVkZqwJ9zkfbM57vxEShdlSG84TXzt77HrbsTuIOjMGFnuwyT?=
 =?us-ascii?Q?mLWezcMYwxZcWb1RGmjHsc7K1Mehlc6GnIDQVd2JcIwZki5pa6gamLzblVg7?=
 =?us-ascii?Q?VBYjztUiM5M1bz3EoWWH387SfmnXQ9KyYsvCw1M8psgD59mxp+W4iZ3egBVE?=
 =?us-ascii?Q?24ZCIQjHA92+i2yrbM6KNsHDNMSA9S54JAjElZeBOb76Z0pLOyx8Jtnm2fv9?=
 =?us-ascii?Q?pNm3tFWHteoElvKClK55tfNKuxZO8Q/kWl1vNuUq1UGhWvqI5UnNeI3VzwBE?=
 =?us-ascii?Q?q96tJvD3i/ZBDR9GUtvx1ZEY7YPaTbTo065rO+eSLb1hZjI0sX6sKWpjc7pR?=
 =?us-ascii?Q?riGSnyPB7usfwgNKD4L1RETilPLdAAKkt3FakJjLR6QK8JgF0giZzNP/w5Yv?=
 =?us-ascii?Q?FG1KqQx2rzaGvrQQlphBo+lH4fHFImCTnwll2NGZW5KBky+Df7EUM/JqbE36?=
 =?us-ascii?Q?ZWPUE7Q6vGffs1Z8g4ArmSU61VwcrdV12llkV7xY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc646f7-810b-4600-780d-08dbfa92f454
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 21:48:47.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fk3cZcqCs+daPBsL4zhGPWmZhEUj35f9f7cpSmA4kc7z8w2Hf19qJVA+SaVQYqg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171

On Mon, Dec 11, 2023 at 12:11:25PM -0800, Nicolin Chen wrote:
> On Mon, Dec 11, 2023 at 09:20:41AM -0400, Jason Gunthorpe wrote:
> > On Mon, Dec 11, 2023 at 08:35:09PM +0800, Yi Liu wrote:
> > > > So.. In short.. Invalidation is a PITA. The idea is the same but
> > > > annoying little details interfere with actually having a compltely
> > > > common API here. IMHO the uAPI in this series is fine. It will support
> > > > Intel invalidation and non-ATC invalidation on AMD/ARM. It should be
> > > > setup to allow that the target domain object can be any HWPT.
> > > 
> > > This HWPT is still nested domain. Is it? But it can represent a guest I/O
> > > page table (VT-d), guest CD table (ARM), guest CR3 Table (AMD, it seems to
> > > be a set of guest CR3 table pointers). May ARM and AMD guys keep me honest
> > > here.
> > 
> > I was thinking ARM would not want to use a nested domain because
> > really the invalidation is global to the entire nesting parent.
> > 
> > But, there is an issue with that - the nesting parent could be
> > attached to multiple iommu instances but we only want to invalidate a
> > single instance. 
> 
> I am still not sure about attaching an S2 domain to multiple
> SMMUs. An S2 domain is created per SMMU, and we have such a
> rejection in arm_smmu_attach_dev():
> 	} else if (smmu_domain->smmu != smmu)
> 		ret = -EINVAL;

I intend to remove that eventually

> I understand that it would be probably ideal to share the S2
> iopt among the SMMUs. But in the driver the objects (domain)
> holding a shared S2 iopt must be different to allocate their
> own VMIDs, right?

No, the vmid will be moved into the struct arm_smmu_master_domain

Jason

