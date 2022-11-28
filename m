Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0330F63B259
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 20:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbiK1ThL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 14:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiK1ThK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 14:37:10 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D416B10;
        Mon, 28 Nov 2022 11:37:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3NHtOO98YYxfLLyoDL+2GsRun5F8s2KKR/OKqr7AC11Sos0HU33FheJiib74ZIm0FeVyMna9Zo1rDDi+gNNAa7LyFaLVqRN6gPMqPUfLXhWMiZeRIsLdc8uheMUxgBYhrc70oH14zkJG6x6btnHz8iWmMbFCtSi8GQFG7+GdsIc848OHhri817cpW9YyFIe4/hkNG/RctWGU8+57ac+WxeaAOOYyCSp+MRDdWc1BGPeKJlfDcf16ndNnPg+VyzliThJ1AoRh2okUPMjzYZxG70SVlchirFbEqJlm8FJc1UsJZ6X2GuOqMJT9DWfy2r8j2AcTg+kRsgtaBFdtUq+pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+/XakltiqK9sZrCP0G8diU4NULejcT+PAv+4/+sWcY=;
 b=SNqrImDTgoAsTq1qYyqPg04qvZsXltyBVsZzb3taK6RP/gtWeqnHx6DCL+BZ6u7SGyYdVzIR5qaSmROrMRW6wrI5SfuqKo8vn1p4ap2f6fiwQ8q5WrXcJDcokA7MqHTg9AyEDGST+PAJDBHfUmL9NMFkNWN2eSTp0C8KBFDkEuejKacoyddhjU7bV2gt56lDqEAvjdOEzMBOxsZZhqYwzRMDizp+EQwZ9/JZIS40ZyZj0pZQ45FB46Xl478GQovzKuVzpbaJRLV7VNbf15ElqxLqDqKdfcC9ps8bYx/7xAcinEJFe6nLEmerF2EUcG2Pr818XvaBauhof4jKKhqQDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+/XakltiqK9sZrCP0G8diU4NULejcT+PAv+4/+sWcY=;
 b=OGIpzZRMpOCLcKjM36loxZffNlM9I8qJEEGrpkBZb1ghGNs4UEK0Isn54Dqld4JNmylbhQRPdnQm+5TqU0Wtk2c2JXwZXBOvdsxp7/+12h/8gGLjw8idIqdAqysRyaGO8pfNA3vyGFD2rUZa8FCgjDMfRHN6PC0JfES6gbP3cGTgk7ReEkzhAhtw1WMD/2jNBQfG28d5PDJ0yiK/Kn0fKJaoymG4RNGTeKeMaWSKvmrjQAiRsublH1cua/+ygvu3sU2FYDOG69zYwUfg/cb9liBNEUknNivcR9qk53kkl+t1klTXCIg8Syvka4PwLGhCP75N8qneoABlUbiMqZvTfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4184.namprd12.prod.outlook.com (2603:10b6:610:a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 19:37:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 19:37:07 +0000
Date:   Mon, 28 Nov 2022 15:37:06 -0400
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
Subject: Re: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y4UN4qVpNqTP/JEF@nvidia.com>
References: <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <81f898b6-e40f-be72-78d4-b5d836981d8f@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81f898b6-e40f-be72-78d4-b5d836981d8f@redhat.com>
X-ClientProxiedBy: MN2PR19CA0047.namprd19.prod.outlook.com
 (2603:10b6:208:19b::24) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4184:EE_
X-MS-Office365-Filtering-Correlation-Id: 17fa30cd-7810-46d6-5b57-08dad177ef26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A9HBaYDl3gD3HKE/iZe8NXYEL7G/UULnvlKhjTshJ//AIMXQnBxwCmLFiW2eCyQi7ikdvRmxPvDTdOCrWqhCjAxGgfBj6Pu2Id+hLRi8TYy2Irhg5yfJm+FAjerC2/SkC35RAqQIhhjpwdXOuPxgl20bYdSN4Y8IcDEPWkBDzkf4+Pfu1e+T1In8VqQRC8QUjNa7zby6xKawz7zZIRP1RXcLELfZk+mhpzcGfMT3YoEt7ERHt9QVxsEsU9qyOZ10RP02ZlQZiSeHVVeChioEAURTKUn/DuJQi5HeA7MeT2No26no9NJV3wTc4DNmFfe0008T7nNGvPJdUYhYx7PxQcIsTJJT9EaHBpzKr4fZTI53RG6PSWh6k8K3OUvUBpf4tLmeMGzCSi5n/AbczTKOZ1+fvP9k6ALCYdZr/cs4FoHWjk4dJZaXMbXIuFRbwN44rjBlq2MgFejzKRPr4mpCGvZlANO6MB9MVGWAFJjSI/hwMCUFKrhpmQnGeN8i85rDI2JiN9fj4FBX/Uw4kqIC1xs9uX3QH2eS6I61nEZqQoyAkFwX4h7aXUH05Sf5ufp6ds1g7Iz13SMz+3GaZYL0CRuJaHWZm2AEYEYCK8vlEISqbpKJ9dx5/Siv+EXhLwlf2tOyRR2py+8oZyfRuMuByJjZVfsALJVHJXfKSpnrVbrHKmZfRxy00c9NUTKW0fyxBQlE2bXlcMD8T+ND9SbXmSg+5ChUaJDc7KAim2asr1NjNkBNXTNULa2DGBBvNKZF360pkfs/+T/QJ1hoIJwVog==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(366004)(39860400002)(396003)(376002)(451199015)(2906002)(4326008)(41300700001)(66476007)(6916009)(54906003)(36756003)(66556008)(186003)(66946007)(8676002)(316002)(8936002)(5660300002)(26005)(2616005)(6512007)(86362001)(966005)(6486002)(7406005)(7416002)(478600001)(6506007)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aMumD6eNN62oXTkxHoI2WlmYuE63iP2hoysjfQm77QXVIEnLWc0zzC4utsoa?=
 =?us-ascii?Q?muQ90vdvTgxO1gM42sTHsJmYWC1KBWhNRIIMBDFPhcJk53RxtYXyEjbp3Ao9?=
 =?us-ascii?Q?SIGUGeKR6SGrtHlztVv9OCp8Zfa9/5Aw45SuJ7Hf2WHUxKHRkFj87sb4REqO?=
 =?us-ascii?Q?hMcK7RtuFwSsPBSiswLEvwnKfTGTvHQaiF3bYOqhPgRAHm7HwNES3huLZ2G+?=
 =?us-ascii?Q?BVyW6LC7K8FMvXN5bOIt3uJ4WVaWXJK3N9Vmj7SlzfUjBs4BUR9Htx99B19E?=
 =?us-ascii?Q?QXILlmDIZAQd6E0OqJr5A/TvIagU88EmSrQykRAga+fsv75wQdOWI9PsjHaa?=
 =?us-ascii?Q?N9JDzjgPmdPyQ/n/KmZRgDlLXVYqNeECwVCsyAy5Urfkpcfm9skwUk532wf5?=
 =?us-ascii?Q?va6rsrbGxBo5waJJr8Vu/WtcMpieckdsQG2jeJGieGugWuvJ49/KiRL/IwCY?=
 =?us-ascii?Q?6qXyuLI7bL7wdj6Yw1uwOdOImyu51X3ZnU0iOOEXcI4eRR23WzhRepH3bueD?=
 =?us-ascii?Q?1mmUr1ZDyUgUIrzZe4DvPHZu21ySgVltC6sSYlogjzEmRge7LC++yQOETqPR?=
 =?us-ascii?Q?I0e0OOu5nRPtFrPDFoNRI5x1m/vG2nIbFeEeSwMwqsyy3GprXpZnEMxoWh6s?=
 =?us-ascii?Q?gP00TxAKFJWBjcbQAvw1NieaLIQxYAgP3l9xy2CbtBUqt5PzosxxxFJY9l1O?=
 =?us-ascii?Q?OQo4eokNwpJ7NN7Oq1/mm2kDJJEcOrtKYadJ6IENh7OlykgRP/YsfGVX+FzZ?=
 =?us-ascii?Q?iNQeYyD8qWpYMI2yG6nxSGpLev6UsLH6n5EJIbaoj+il4aPnbF/6CLmEHQNw?=
 =?us-ascii?Q?vp/5fMgWKRxRuUaEgA4O/0XKvuQyNPKPZLMD0pHrNfjDc/LVm1IqSlyYKKSR?=
 =?us-ascii?Q?lNlIAmAXfBiJJJAF/usQMwqWrtY2RhB8tDJvNpiMEf/gpcnVKwmVVHRXzgiy?=
 =?us-ascii?Q?ZF1zb7GqacCrdX159b+WWL+qBVcPQO0XtKSfAU8EnapHb/+Y7oF7U8o4VYBN?=
 =?us-ascii?Q?G8/AixnsBptnpFOIpJttYfR5QdypqYDdHz6mqdCEmDwZAvqapSysYpai9eB+?=
 =?us-ascii?Q?CWOQDSBB06BrG7nDsjQvJKeYK9Pium4k5SK/e3l93z2KLIV50l/O6Cj0hHwu?=
 =?us-ascii?Q?6Laltl5WkR/DSIyS2rcr1qOvVIY3RwjayGO/pSNW7aHftS5M+/oqcDPmQkg9?=
 =?us-ascii?Q?0ln7j3oIfP9Wey4tAvfHSwS8pjLkWIOWcH8RqVxfVfpbbACxPdK4zVwx4ZkT?=
 =?us-ascii?Q?RxmblZgOXVdfnJ+6M7p9112NMPxMfAZtSiY6bG5cdAi4WbocN2E/viO5yKnS?=
 =?us-ascii?Q?dx6h28I4bxv5QBfQDJR78qpLf5f+Z0kXuk5ddgpI7EcfHIT+ENvLmhN45I+x?=
 =?us-ascii?Q?2J59HAF1KqEC83WV8UpxsUaq084qebqtS1bVwlcHpjT6R0InkYMkr3An2g8g?=
 =?us-ascii?Q?9R/QgVXwABow+QOFUzwgEbt18nZngY0mEEnDE8YE3riO98ns0zI40JA96A7n?=
 =?us-ascii?Q?wo1Z0j/rOkxXPSVF/Cx8WF+rsQJaF7VkIDnkMvwrs8wbQgBDJ5EYuZa9VXQf?=
 =?us-ascii?Q?sWn9AJdXVFtsAYGCiKY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17fa30cd-7810-46d6-5b57-08dad177ef26
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 19:37:07.1803
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KTFR7mwVPp4l0vPfy7e2JAd/saL1MhpMHsY6poPecK6LRt3/sTWiL/XVtz2WzYdp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 06:53:12PM +0100, Eric Auger wrote:

> > +static int iommufd_vfio_map_dma(struct iommufd_ctx *ictx, unsigned int cmd,
> > +				void __user *arg)
> > +{
> > +	u32 supported_flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE;
> > +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> > +	struct vfio_iommu_type1_dma_map map;
> > +	int iommu_prot = IOMMU_CACHE;
> > +	struct iommufd_ioas *ioas;
> > +	unsigned long iova;
> > +	int rc;
> > +
> > +	if (copy_from_user(&map, arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (map.argsz < minsz || map.flags & ~supported_flags)
> > +		return -EINVAL;
> > +
> > +	if (map.flags & VFIO_DMA_MAP_FLAG_READ)
> > +		iommu_prot |= IOMMU_READ;
> > +	if (map.flags & VFIO_DMA_MAP_FLAG_WRITE)
> > +		iommu_prot |= IOMMU_WRITE;
> > +
> > +	ioas = get_compat_ioas(ictx);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +
> > +	/*
> > +	 * Maps created through the legacy interface always use VFIO compatible
> > +	 * rlimit accounting. If the user wishes to use the faster user based
> > +	 * rlimit accounting then they must use the new interface.
> s/they/he

"they" has become a common neutral singular pronoun in English.

> > +static int iommufd_vfio_unmap_dma(struct iommufd_ctx *ictx, unsigned int cmd,
> > +				  void __user *arg)
> > +{
> > +	size_t minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> > +	/*
> > +	 * VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP is obsoleted by the new
> > +	 * dirty tracking direction:
> > +	 *  https://lore.kernel.org/kvm/20220731125503.142683-1-yishaih@nvidia.com/
> > +	 *  https://lore.kernel.org/kvm/20220428210933.3583-1-joao.m.martins@oracle.com/
> > +	 */
> > +	u32 supported_flags = VFIO_DMA_UNMAP_FLAG_ALL;
> > +	struct vfio_iommu_type1_dma_unmap unmap;
> > +	unsigned long unmapped = 0;
> > +	struct iommufd_ioas *ioas;
> > +	int rc;
> > +
> > +	if (copy_from_user(&unmap, arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (unmap.argsz < minsz || unmap.flags & ~supported_flags)
> > +		return -EINVAL;
> > +
> > +	ioas = get_compat_ioas(ictx);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +
> > +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_ALL) {
> > +		if (unmap.iova != 0 || unmap.size != 0) {
> > +			rc = -EINVAL;
> > +			goto err_put;
> > +		}
> > +		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
> > +	} else {
> > +		if (READ_ONCE(ioas->iopt.disable_large_pages)) {
> > +			unsigned long iovas[] = { unmap.iova + unmap.size - 1,
> > +						  unmap.iova - 1 };
> > +
> > +			rc = iopt_cut_iova(&ioas->iopt, iovas,
> > +					   unmap.iova ? 2 : 1);
> please can you add a comment to explain what this is supposed to do?

iova -1 when iova == 0 will underflow and becomes garbage

			/*
			 * Create cuts at the start and last of the requested
			 * range. If the start IOVA is 0 then it doesn't need to
			 * be cut.
			 */

> > +static int iommufd_vfio_set_iommu(struct iommufd_ctx *ictx, unsigned long type)
> > +{
> > +	struct iommufd_ioas *ioas = NULL;
> > +	int rc = 0;
> > +
> > +	if (type != VFIO_TYPE1_IOMMU && type != VFIO_TYPE1v2_IOMMU)
> > +		return -EINVAL;
> > +
> > +	/* VFIO fails the set_iommu if there is no group */
> > +	ioas = get_compat_ioas(ictx);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +	if (type == VFIO_TYPE1_IOMMU)
> > +		rc = iopt_disable_large_pages(&ioas->iopt);
> please can you document/explain this setting?

	/*
	 * The difference between TYPE1 and TYPE1v2 is the ability to unmap in
	 * the middle of mapped ranges. This is complicated by huge page support
	 * which creates single large IOPTEs that cannot be split by the iommu
	 * driver. TYPE1 is very old at this point and likely nothing uses it,
	 * however it is simple enough to emulate by simply disabling the
	 * problematic large IOPTEs. Then we can safely unmap within any range.
	 */

Thanks,
Jason
