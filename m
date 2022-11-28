Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5851463B15B
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 19:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbiK1ScO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiK1Sb0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 13:31:26 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3851F63D6;
        Mon, 28 Nov 2022 10:27:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcZgN9aXL4I9q1mu3I/5iLQiKQsORgBqpJ88ZU3PxXVNV69bPa8wEWv3c/kXat1ihLIKjzJtcEg6q8YxfGL2kPHlNoGrMVuD0gplCljS9lWgkU6PbKrzgjWXcxycrDSeI1KiUQioHFx+JVvsV1tZdT1AqJp87RWPtFQPEScMrA82GskJ8pUYt0xTEF69JDRc4e2age/5DQarHuhOIWDvKx6BTENvcahIi+BNwyfuIZmQuvIbSc36IGYL3gtRJo79653l/+yjWYtdevKCyhCVD+gSTVxE5u4tB+LskOfzm2ipz19YkHF3bJNIQXsxnX99USJdnelh7qN/33Ui2qcbsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7sokgwrKdEuVeNtRG6nIVGjXGqNiXBqIszq1bddvG8=;
 b=dyLHPL/iVxGANDcvivHSa456YN9zbcPT6h9inbyhuau5Ps2LndMI8SzLYB+3necKVAxCH8g1MDMA7f+IUOFSSWkOlUqbXsMKXj2PUjnL8nUzQTEBZQRYNsrvWXQYyk+k+oz4xVFKbQmX3D24bqdkZo2NiaUJyI+xfRc8y6280EenDTX4ip2uk5ZE7O0ADbjLytKfZAp0vkW+5dBRmpZsdjRMHif72l97lYINSVPyB0hpixBP5jttkBFziRt6Xfy1T88Ic1NEiC38fe/dCMdG8O9QVB+ZohpyBUxz8ZpIDZOCv8ztJiovvVWMdMbkNey4+QUNEcTUvHESmPt/27Z9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U7sokgwrKdEuVeNtRG6nIVGjXGqNiXBqIszq1bddvG8=;
 b=cjEOpfWUmdjxwKe81sCxnQV3EyzMxlR5GGuyMz/4aeOkF6Gc73AA8WjuJCKzg0S1V7OIKFY07jKihmnfhiwwxJuEGIuw7hXJT6zJ54aXsWcdmczwDFyIaLcPQIlk2VOky/Xsusrc/w6uTAE3ttbHL8Wq7ybj4YpUdZzZWSq3rdwl3nZ1D6+LRkki1qf877HBXYPYYGPxBfQStwuFa7QiD8ROh2QpWal48oB4eNxMbbJbPgyNBlBnRpbWVBzbbURji+4i3Ow/qmyvOO5swUFqR378ch/zkLH9eIURsqs71am2H5GK3Rtyhw6Oa5pM1VTSf2mfiQsZWlPIq6F6DE2bZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4960.namprd12.prod.outlook.com (2603:10b6:5:1bc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 18:27:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 18:27:07 +0000
Date:   Mon, 28 Nov 2022 14:27:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Eric Auger <eric.auger@redhat.com>
Cc:     bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 11/19] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y4T9ejjPETS3TPx7@nvidia.com>
References: <11-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16bcfd63-2803-8000-7725-b42cd05061fa@redhat.com>
X-ClientProxiedBy: MN2PR15CA0007.namprd15.prod.outlook.com
 (2603:10b6:208:1b4::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4960:EE_
X-MS-Office365-Filtering-Correlation-Id: 13a2b62d-dbeb-41b9-be64-08dad16e27ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RclUn3Vosr7xWEruGKYWNiHlpfvllOMymwHkUrD6m0iPH6Dfo3O6xHGsZeAYFa9803dyFKLb087m+RhbbEpLhZ5qEkIE5x98+mjn305bTRTo7Bje91mYJEYJnNsCiXtt95D681PeJ1mdhz3rUc/i7UvCjyDIh+0ef/+YFcXUbCThyozIm4Akuoj3zxOsPwrd4XGI7N66pPgeKrVj3NlBe8folsZVYhS79mp/ol77NneGBxiCHnkLM2pk4dybOEK+oFyUQyGHxXp0wdp6UawJdNHh3w1xbqndD1enMJ0AWssOEVp6S5bRdBn0TkgzA/6cQHE6NDzl3D1pni6Zz3H7Ih/vwiw+hw/vaF923A6KoY8L/idZYuNHn2UeicDqDBeLKiPKm8pQfvnQN9Bk9ViioGHAPSkHV8ZlWVlSVi/quUo8Ujz5d97jHBuNho/Gm1UTEe5GLPmMamfBa3/Xef+MG5MSssllmUY2Sq3A9N/OMQsU8pfUs1ia3D52cok3C8UexB9EmvZ25FtMKl9qT070jsuNJMtOd8tHD8VkCZ4iF3TVxvm8Qd7/c6JhS3C1mpjeITWJpsjy3ssT3ehU6662Ph2LM/bh4b9r9BGrKIF0oUTLg42tbN31rKlyzdv+/hB1G89GSauxcsusATsImqnYnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(451199015)(5660300002)(7406005)(7416002)(41300700001)(8936002)(8676002)(66476007)(66556008)(4326008)(6486002)(54906003)(6916009)(36756003)(478600001)(316002)(66946007)(2906002)(86362001)(6512007)(6506007)(26005)(186003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEhJVWhXbFd4WG5aZXkrYk9rWndQWTF0OFpVcGw3cDlHRlExZjM5cmMrcDBP?=
 =?utf-8?B?cGtGN1JSRlp4LzNKcnkrR3AzRzBTekJXMTQrclFwVXBzaHVnd2tSVGlVUkxR?=
 =?utf-8?B?Vi9ScDlCZyt6VndYYTRhS1k4Tlp6d3hhVW9sWDJTNWdiQlZVSXNlQzl4eWlS?=
 =?utf-8?B?RmgwbzdxYmEySVBxZ0pXQktjU2FxeVVaM3lyVXNQYVQ0ZEhQWGllY0pSRVlh?=
 =?utf-8?B?NmlIbzFFMThIU2wwZFdRaEVwY3ErWCsvVzVnZSswOGtrbWptWHQ0T0RUNG5P?=
 =?utf-8?B?d1pGeEpCYXIzMW9ER1l3Rkl1Vkgrem42OHY1cUY0bHMxbW1RMlVXZWFHMjdo?=
 =?utf-8?B?ZUdrN3VxdlV6Mk1ualdoQXJmUWhjUWlvNW9lSWwrTkx6Q3N1dFhiNTlrK0Vx?=
 =?utf-8?B?bE5VWlYxUlZGSFpGYUVWN0tQa1RxMVZwREpLZk5RYXNGTzZKS0VWRjBNRVk4?=
 =?utf-8?B?eS9QRnNsOFg5UURKelh4bXBIYzl1U1JHcXd0Q0dtYkxJU3JmNFdKYnZWSytk?=
 =?utf-8?B?amZ5VTRLbjdnaVI0b3Awcm1sSnBCblQ4aWFLMFMwUWtjMWNiN2pEYjhudkg5?=
 =?utf-8?B?ZUxEY0lnTDYwT0JnTWQxYXVKTjdYNnJuOURST3FsN0huanhCeE00dDEvYWZn?=
 =?utf-8?B?MUQvdWpBL1VQTFNMdVF3bEM5OHcxbFpYbmNuUjFNK3VLRW9YT3RCb0FHaytw?=
 =?utf-8?B?My9WVFlwVi9JSkNsdUc3aVJjZmtsYnZFL0ZLNGoyY1dCSURvd3ZYeXMyNmt4?=
 =?utf-8?B?cG5wcDl0cHlqT0xYMWhUQjlYSlFJSGIzT2FvUFFRdkx6dmxOZU43aGVzZzlp?=
 =?utf-8?B?RmR0T0VBakhjRlN2NlB5Y29yOGNBWVh0Q2lQTE5RdEFqdXR2MUtBQ0l4Tmht?=
 =?utf-8?B?eGRKbWhLSFQ0a0x2SVRaQStBa2NybGRRWTFIRXFqOHVhajZTN29iUm5zQTN4?=
 =?utf-8?B?UVFTTHZuc1BnSkd1WVpHdHN3NHlIZi9obE1UeU4xYmF4Y2dzOUcwdUwyWUVH?=
 =?utf-8?B?L3VNSXJWYXU0cW40dURJVllHbmlmTFE1aU5pNzIySWRHUHZuejF1bkpGaG5a?=
 =?utf-8?B?OFBOeTM0QVJta1dGYW9DaE14cGtRUU5iUVY1dmFkVjhjVkpNZS9BWlg0RWZ6?=
 =?utf-8?B?akZweWVqRVdoenY5S3ZkRXR1Tmxwc3RZOXhYT0ZHZ1dkVEtibXZraG9OdW1D?=
 =?utf-8?B?VktlVlM5T3BBWXlTMkZMOFlQaWc3ODgxaE1KOGhocjh1YUVPVDJSK2hydTNK?=
 =?utf-8?B?MzJVdlk2TGlVRmRUbHIvbkx6WlJieHVmblBoV1hMQWZQSW5WTElvQzRyNWh5?=
 =?utf-8?B?NEs1Rkh3Z3dFRG1vb1U4TURhaS93TkpqZzZlWTE0WFFXelVlOTl2alkvNkxO?=
 =?utf-8?B?SWVYMzBLdm9aM1NyNFVSN09ETGN4MjZwdVhKL004SW4zNGxRQU8xZkNYM1BJ?=
 =?utf-8?B?OWpueGpLOHJQN0ZkeW52V0t6UVo0OE1xMXUwbnIzaFJZQWZVSUdBbzUxaTFB?=
 =?utf-8?B?ZkFoR1ZtOGd4d1lRL21tdEhaZ01vbGdUUDc4MzkxRWJFRExpbFVWN2lMNEND?=
 =?utf-8?B?aTBMQ0JORXJKNk9BWnB1b2s5cnFvYVkvMXRuZmIwRTV5YWlLSDJsQkVlbjhq?=
 =?utf-8?B?K1Z3dHZOV1Fyamlud0JkUjJSVW5EOVc4NlM1VUVXQkNEbTV0emdORkpnS3Fr?=
 =?utf-8?B?djNxRXJUV1FGN2kvS2dDQ0tVSG1FOCtEWlB2Ync0djZ0WVpmbVRKaGUwdmxk?=
 =?utf-8?B?ekgyejZacUJvUkV4WXRNZmdoK240QnhSeHlLWVFpb1g2M3hMa21vdTVHbDJa?=
 =?utf-8?B?Zys2YnY3ZDY1LzZXM2JrcTRidVQ5ZFhDVE01QTdPQ3AwL1U1NlQ2WUIwRkQz?=
 =?utf-8?B?eHhUTklLOXJRQzhHWWVwbGRyYXdzNjhXaHJWOWVhdUg5WXdGK1lzaU5IcVBq?=
 =?utf-8?B?ZFoyY1RBMHZpbDJVRmsvUmVhN3l4Ymw4T3l4QzNvb2FwUkM4dkRVWXVFVEEy?=
 =?utf-8?B?TjBQRWNSOXV5aFQ3ckp0bzZiQUVTdzNaRDNoUTFQRkNzMi9HSDBublBxSzlq?=
 =?utf-8?B?aFpraWIxc3ZxaldVdXJzdG9QK1o2a2NNNGsvcGU1emtWU1lUVTFTWTNRTEp6?=
 =?utf-8?Q?N04k=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13a2b62d-dbeb-41b9-be64-08dad16e27ae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 18:27:07.2792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PIn6nOhFXTkMap2zqDclZmhxvdBvlTABbunbA+K9zs5AspQPlSMfgN4w6hRMxPCx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4960
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Nov 27, 2022 at 06:49:29PM +0100, Eric Auger wrote:

> > +static int iommufd_ioas_load_iovas(struct rb_root_cached *itree,
> > +				   struct iommu_iova_range __user *ranges,
> > +				   u32 num)
> > +{
> > +	u32 i;
> > +
> > +	for (i = 0; i != num; i++) {

> shouldn't it be < ?

It is logically equivalent

> > +int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_allow_iovas *cmd = ucmd->cmd;
> > +	struct rb_root_cached allowed_iova = RB_ROOT_CACHED;
> > +	struct interval_tree_node *node;
> > +	struct iommufd_ioas *ioas;
> > +	struct io_pagetable *iopt;
> > +	int rc = 0;
> > +
> > +	if (cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +
> > +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +	iopt = &ioas->iopt;
> > +
> > +	rc = iommufd_ioas_load_iovas(&allowed_iova,
> > +				     u64_to_user_ptr(cmd->allowed_iovas),
> > +				     cmd->num_iovas);
> > +	if (rc)
> > +		goto out_free;
> > +
> > +	rc = iopt_set_allow_iova(iopt, &allowed_iova);
> Please can you add a comment about why you need to proceed in 2 steps,
> ie. add the ranges in a first tree and then 'swap' to the
> iopt->allowed_tree (and eventually delete the first tree)?

Sure

	/*
	 * We want the allowed tree update to be atomic, so we have to keep the
	 * original nodes around, and keep track of the new nodes as we allocate
	 * memory for them. The simplest solution is to have a new/old tree and
	 * then swap new for old. On success we free the old tree, on failure we
	 * free the new tree.
	 */

> > +static int conv_iommu_prot(u32 map_flags)
> > +{
> > +	int iommu_prot;
> > +
> > +	/*
> > +	 * We provide no manual cache coherency ioctls to userspace and most
> > +	 * architectures make the CPU ops for cache flushing privileged.
> > +	 * Therefore we require the underlying IOMMU to support CPU coherent
> > +	 * operation. Support for IOMMU_CACHE is enforced by the
> > +	 * IOMMU_CAP_CACHE_COHERENCY test during bind.
> > +	 */
> > +	iommu_prot = IOMMU_CACHE;
> at init?

done

> > +int iommufd_ioas_map(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_map *cmd = ucmd->cmd;
> > +	struct iommufd_ioas *ioas;
> > +	unsigned int flags = 0;
> > +	unsigned long iova;
> > +	int rc;
> > +
> > +	if ((cmd->flags &
> > +	     ~(IOMMU_IOAS_MAP_FIXED_IOVA | IOMMU_IOAS_MAP_WRITEABLE |
> > +	       IOMMU_IOAS_MAP_READABLE)) ||
> > +	    cmd->__reserved)
> > +		return -EOPNOTSUPP;
> > +	if (cmd->iova >= ULONG_MAX || cmd->length >= ULONG_MAX)
> > +		return -EOVERFLOW;
> > +
> > +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +
> > +	if (!(cmd->flags & IOMMU_IOAS_MAP_FIXED_IOVA))
> > +		flags = IOPT_ALLOC_IOVA;
> > +	iova = cmd->iova;
> can be done either at initialization or only if MAP_FIXED_IOVA.

Done


> > +int iommufd_option_rlimit_mode(struct iommu_option *cmd,
> > +			       struct iommufd_ctx *ictx)
> > +{
> *object_id  and __reserved should be checked as per the uapi doc*

Ohh, yes, thanks:

@@ -317,6 +322,9 @@ int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
 int iommufd_option_rlimit_mode(struct iommu_option *cmd,
                               struct iommufd_ctx *ictx)
 {
+       if (cmd->object_id)
+               return -EOPNOTSUPP;
+
        if (cmd->op == IOMMU_OPTION_OP_GET) {
                cmd->val64 = ictx->account_mode == IOPT_PAGES_ACCOUNT_MM;
                return 0;
diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
index de5cc01023c0c5..bcb463e581009c 100644
--- a/drivers/iommu/iommufd/main.c
+++ b/drivers/iommu/iommufd/main.c
@@ -215,6 +215,9 @@ static int iommufd_option(struct iommufd_ucmd *ucmd)
        struct iommu_option *cmd = ucmd->cmd;
        int rc;
 
+       if (cmd->__reserved)
+               return -EOPNOTSUPP;
+
        switch (cmd->option_id) {
        case IOMMU_OPTION_RLIMIT_MODE:
                rc = iommufd_option_rlimit_mode(cmd, ucmd->ictx);

> > +/**
> > + * struct iommu_ioas_iova_ranges - ioctl(IOMMU_IOAS_IOVA_RANGES)
> > + * @size: sizeof(struct iommu_ioas_iova_ranges)
> > + * @ioas_id: IOAS ID to read ranges from
> > + * @num_iovas: Input/Output total number of ranges in the IOAS
> > + * @__reserved: Must be 0
> > + * @allowed_iovas: Pointer to the output array of struct iommu_iova_range
> > + * @out_iova_alignment: Minimum alignment required for mapping IOVA
> > + *
> > + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these ranges
> > + * is not allowed. num_iovas will be set to the total number of iovas and
> > + * the allowed_iovas[] will be filled in as space permits.
> > + *
> > + * The allowed ranges are dependent on the HW path the DMA operation takes, and
> > + * can change during the lifetime of the IOAS. A fresh empty IOAS will have a
> > + * full range, and each attached device will narrow the ranges based on that
> > + * device's HW restrictions. Detatching a device can widen the ranges. Userspace
> detaching
> > + * should query ranges after every attach/detatch to know what IOVAs are valid
> detach

Done

> > + * for mapping.
> > + *
> > + * On input num_iovas is the length of the allowed_iovas array. On output it is
> > + * the total number of iovas filled in. The ioctl will return -EMSGSIZE and set
> > + * num_iovas to the required value if num_iovas is too small. In this case the
> > + * caller should allocate a larger output array and re-issue the ioctl.
> > + */
> > +struct iommu_ioas_iova_ranges {
> > +	__u32 size;
> > +	__u32 ioas_id;
> > +	__u32 num_iovas;
> > +	__u32 __reserved;
> > +	__aligned_u64 allowed_iovas;
> > +	__aligned_u64 out_iova_alignment;
> document @out_iova_alignment?

 * out_iova_alignment returns the minimum IOVA alignment that can be given
 * to IOMMU_IOAS_MAP/COPY. IOVA's must satisfy:
 *   starting_iova % out_iova_alignment == 0
 *   (starting_iova + length) % out_iova_alignment == 0
 * out_iova_alignment can be 1 indicating any IOVA is allowed. It cannot
 * be higher than the system PAGE_SIZE.

> > +/**
> > + * struct iommu_ioas_map - ioctl(IOMMU_IOAS_MAP)
> > + * @size: sizeof(struct iommu_ioas_map)
> > + * @flags: Combination of enum iommufd_ioas_map_flags
> > + * @ioas_id: IOAS ID to change the mapping of
> > + * @__reserved: Must be 0
> > + * @user_va: Userspace pointer to start mapping from
> > + * @length: Number of bytes to map
> > + * @iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is set
> > + *        then this must be provided as input.
> > + *
> > + * Set an IOVA mapping from a user pointer. If FIXED_IOVA is specified then the
> > + * mapping will be established at iova, otherwise a suitable location based on
> > + * the reserved and allowed lists will be automatically selected and returned in
> > + * iova.
> You do not mention anything about the fact the IOCTL cannot be called
> twice for a given @user_va w/ FIXED_IOVA
> Refering to VFIO_DMA_MAP_FLAG_VADDR.

 * If IOMMU_IOAS_MAP_FIXED_IOVA is specified then the iova range must currently
 * be unused, existing IOVA cannot be replaced.

> > +/**
> > + * struct iommu_ioas_copy - ioctl(IOMMU_IOAS_COPY)
> > + * @size: sizeof(struct iommu_ioas_copy)
> > + * @flags: Combination of enum iommufd_ioas_map_flags
> > + * @dst_ioas_id: IOAS ID to change the mapping of
> > + * @src_ioas_id: IOAS ID to copy from
> > + * @length: Number of bytes to copy and map
> > + * @dst_iova: IOVA the mapping was placed at. If IOMMU_IOAS_MAP_FIXED_IOVA is
> > + *            set then this must be provided as input.
> > + * @src_iova: IOVA to start the copy
> > + *
> > + * Copy an already existing mapping from src_ioas_id and establish it in
> > + * dst_ioas_id. The src iova/length must exactly match a range used with
> > + * IOMMU_IOAS_MAP.
> > + *
> > + * This may be used to efficiently clone a subset of an IOAS to another, or as a
> > + * kind of 'cache' to speed up mapping. Copy has an effciency advantage over
> efficiency
> > + * establishing equivalent new mappings, as internal resources are shared, and
> > + * the kernel will pin the user memory only once.
> > + */
> > +struct iommu_ioas_copy {
> > +	__u32 size;
> > +	__u32 flags;
> > +	__u32 dst_ioas_id;
> > +	__u32 src_ioas_id;
> is src_ioas_id == dst_ioas_id allowed?

Yes

> > +/**
> > + * struct iommu_option - iommu option multiplexer
> > + * @size: sizeof(struct iommu_option)
> > + * @option_id: One of enum iommufd_option
> > + * @op: One of enum iommufd_option_ops
> > + * @__reserved: Must be 0
> > + * @object_id: ID of the object if required
> > + * @val64: Option value to set or value returned on get
> > + *
> > + * Change a simple option value. This multiplexor allows controlling a options
> s/a options/options

Done

Thanks,
Jason
