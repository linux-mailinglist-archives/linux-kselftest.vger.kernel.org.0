Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C46D61FAD1
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 18:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbiKGRIT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 12:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbiKGRIR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 12:08:17 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2052.outbound.protection.outlook.com [40.107.101.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0172822BF0;
        Mon,  7 Nov 2022 09:08:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBV/yvqV/bFPJ1G5j+h1aY+8/MtyGMI0nQDMJlQVwKfgZ6k6h9RaJymHcYTXkpIb/ETDzGqs4WSSL10ENRm19amhpbdGC70RFpQCPwEmp6npFE5pNCMpkd+In6VVXufbMvwF4aSe4EUM0i2bU1qBFMC0x9DHWGfOQcO2K7jLrGnNaJZQ5hgZXGiXCAkBirSE45+J5U4dssXmnaDNQw4XMFWaRqQYyMDG13nMoXyb5Jys7qJjzbAORPhhYKPAzyAI9Ki+/vxw2VI3gTRddrPskkIpEc0HXnf/edfpG974X0SN4eHHDekG44SUDKQRZsNG5b5nRmB67aO45DcUXV6oEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cM0asfPs9CgfEFNfkLDgpBO1YLDglUVBEDX4SQOYeb8=;
 b=Eycna+9Dw4so2DTzxvYqkoztY+RjyWBZZk9/R3HcB40UlY47dDjEmrwIZgV6doqst/7Odqs7DGehFp1Y7B8HYRAD+5Xvx+kNwyDNBo3/kJqznNAEmfcOk4jbNCALjz7DNno2f8pXp0gmNE37QOIHqM7RVC4y4/eqj6LJgLSti+1R8+2hhpHZo1aLjvGX7Bucxq4JENu6L91VEMOB+ugfgZiFg6iZT3Otv/pxynVZNqprjAJNGeupwxj+SkwOmQflQJLxpTU6/9LjUhNXwXI2Bfq/IZhBs3IShHiEqclmIkPn5Zw95Mj/V1bhA8kqjYjtKYVsE8H1c7PYxA1BfMldeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cM0asfPs9CgfEFNfkLDgpBO1YLDglUVBEDX4SQOYeb8=;
 b=cigMLUoR4cmT4+yQmAD1bXJHC7y5eBsteN/2gcpIvHax0Erz++Op00ugGviEvzPsIj7tsJ1C1H4erGJXWNboT18teSE0aAVYFxcQ06JlgXiiusXy6bEKdJwasmzs8pdbzZodhtKcSx2jQ0llwchYU6cBK4dVxlKeoIb5rCNQmMpZpjwyTQDfjHqN2tirdwqkXZWrsvnhKaewX7Jm38D+Fy7raqQJV7gMr4Tzvup1QJhEw3iYHB76WWRAz7Pr0r5Hi8ahq6K+A+NdQcl0Vg/mI+STJ5xKKSR3gN11lOPDW+gXWmGiz0W5OuWcEpjknXxZpCryN1/pk8vuIg9K/Qo8qA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 17:08:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 17:08:15 +0000
Date:   Mon, 7 Nov 2022 13:08:14 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Woodhouse <dwmw2@infradead.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Joerg Roedel <joro@8bytes.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 14/15] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y2k7fkxSzxTPTXkN@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <14-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52763ADFBACFE7AFE11F5F078C3A9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:208:91::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4917:EE_
X-MS-Office365-Filtering-Correlation-Id: d87e476b-3d93-48f6-0496-08dac0e2a87c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yJWZ79yIw26uYaA0ZF/2Rsq/+5iBAZsqiHOaoSJ1AR4OEfcduNW7NRzFUIJCV2XTZT+au41FgzGomxyDRPL2NHtuqIwg1yJxptMFTFU4e+wJmFTmLVWLDvXoucr1gopcUzFOnast02GpGRVa67+yh6L2sVZQRMxqCXt3dqIPADZiZCwUlYBc5u4Iwr8ZAlsp3gRCdrdKwT/dd1XoKKxewKrgeuvbpyJU2cpx0XXwyws7H2Z5Pta4nKrJXoEGF63UF+QYlSXDiz6RjxCq8eJs/bb2iabYctHJQ5/xG2+11SKTLhMuOLLidSADFVo5VCuYjoMAgWM5cQWX95WYSgdSgDmQ4MRlUyBRzUJeBuna4KPKimeqzCLZtMW3eQIs79HupCvrEdZyttpOqUUQBwRH1RAs0cYsO3qLDiPYztsPuiSswbd18H4u9rNFH0jXCcc1SIcO/vId9SBxoBwKrj8h9BDBoodoySrao6ytl8tLbYtBZRwc+EtxXUWgj+mvwgvevY3FmGUHW5iZGnN+AGDkwsDKfKMp9x0VrniphNZpSG21JINlBPfGNmJDMBinmAFffC3wYXVGgv2ulQlwM5WI0dEAL7vnPuCW7TbiEyOfR8fLckJWmG3r2FoHttJ/AwISXc9PkSPpWnob3840Q7xyc/Yu1i1eC0zUqiYAqyfCbRfariI436RzRuqeXd88qqMhnWbPLF4hIMDng0C57DFsUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199015)(36756003)(86362001)(66556008)(2906002)(2616005)(186003)(6512007)(26005)(83380400001)(6506007)(66476007)(66946007)(4326008)(6916009)(478600001)(54906003)(8676002)(7406005)(7416002)(8936002)(316002)(6486002)(38100700002)(5660300002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYMMsXiC/MOFB7rmr1mRg4AqC5qS1noSrzeNAGesjDn4ZAyJPP/Cz4EGvFu+?=
 =?us-ascii?Q?iT3r+XA6Pokq38oO3vw4E7sDk0nr6xJ+SMSOWMC8A2yiPT64RQ9scES1YRwL?=
 =?us-ascii?Q?jYAKMLcwgnGstWL8NhSyPRR59d0CZi+ibyiTFOaiJ/4+p6wVIebXzo2/jjke?=
 =?us-ascii?Q?MHefELAedV6uk4CnVumd9z+yP7to5zm38eCrR00zvYsCcvXEn+b/z32wRsPL?=
 =?us-ascii?Q?370H4WRh037Rsao6ibJuSVjYHf61t+Fkk8yG0PtUlG1OibyyYQltVCJ960me?=
 =?us-ascii?Q?Z/GwO6FymqjehB8YgM21Mv2GfNCewkcLH7GK13uiuE2vusJIDG/I8G9HRHRV?=
 =?us-ascii?Q?h3MDAvp56LhXuykMLt9bcWrWnlrBPGz8XhVx+cVRUFuPRRF+FkKOA965fZIe?=
 =?us-ascii?Q?OZqO+3J+OwVtkdfEgpU8220bVU2fk9WGj344PpNd6Rl8bzLE2WFr6SM5Q8+A?=
 =?us-ascii?Q?YixEV8j5yVSHKaRbr6b+sphp0yjDFVGSXu9VQEFQe669fk3QZ96+JTVxUr6H?=
 =?us-ascii?Q?0x+Zsp1Fj7Hw37SNeBmWLKXx2b7S4tkFEIxrtiDegGnd6YarGMdQjARm8dRU?=
 =?us-ascii?Q?iqIi/AAgiI9g+l7kEDk/KITmVPoSfxuhzwgns9Ld3VYiacG8LLnveCX+qK0T?=
 =?us-ascii?Q?n5uqkW2lHikY+PbbJW4r9PLev+NASh4iYLiTXixhZ/8VafnKos5zcIstm7zk?=
 =?us-ascii?Q?6ApFQkwIDWYr2q1CRi+aaCQa2+oORLNN54Nn+q+ObB8m8SjV+CCZMipkwQ1x?=
 =?us-ascii?Q?xvX9qIbkvwFYXBJu8RKW/Jmmg4vNbZTMDjGVyjuXIG4IIMavAZoVVf/VGMPE?=
 =?us-ascii?Q?HotqeenpXVE70uOZ0ZJXi097Bj0+9WinUC/QgDw+e2D7S2gPREJB0o2fKvYK?=
 =?us-ascii?Q?v5cYAgndsmRdZDFen8/2YvMuGxJGSIhMUjYImiD0kRe8+V2UAKPoYLgOXIJn?=
 =?us-ascii?Q?EizI41kOtDq3KuDBpQwEy8txAEfOWNEx5IoKpbeF/UEIETZp90Vj+TdJvhoo?=
 =?us-ascii?Q?DGvX4EE9VroBu2dzp+W8+J+J4pV3UsHKPi5cBmBX/tL18ClEVl2jOQUGB3dN?=
 =?us-ascii?Q?6JQrx4t7Vy/QQjf99jGWxs9tcIrSRQ3SocrqWItGSTozabAA+uBC7xJDTrnU?=
 =?us-ascii?Q?S1XZmfYPH8ijw8GGfcsZQxCoABakzwMs6+fOFe6Kj40Pcky2B5Nr+LpHrnW7?=
 =?us-ascii?Q?vC6G3onUI8GUYEtgRDAANbXpuMM745xLJs6nYUNQmB0B05kavRE6ISHL91jo?=
 =?us-ascii?Q?HQzDsmXH9yPEGj/7OJWSMSSe23njBJgcnki7A0IBgxrNdAilkNkZXO+sEQTX?=
 =?us-ascii?Q?uIT976OgPRAlez86wf0pcu9ucnoFDU4D6XjotbrvSi+6Y4y3/A2dMtyNrJL1?=
 =?us-ascii?Q?v+VIFT9/8rJw9TLarXGL6lnRBOBAYV2yVYCJag4GyNNd7lr3ULKguV9NPDts?=
 =?us-ascii?Q?7SZZWUTPmA/Qw72S9UGfrtKtAKkGJIL7vSl9lragjyqb6XLzjowDb+ZQuaXz?=
 =?us-ascii?Q?jI7v7Af36R1XvGeXZ/JHkRnYCkqiEVz8efFicuf8S1j2PBhHgq7CetkzJbRB?=
 =?us-ascii?Q?rM3DAq4+3WR9BCY6Vmo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d87e476b-3d93-48f6-0496-08dac0e2a87c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 17:08:15.0531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWZeATpQb28phoL7IW4DaT+XWH1ExFHVmGiOIxHRnhw+xhCLQh+PsE7r5Q/PsRbQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sat, Nov 05, 2022 at 09:31:39AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> >
> > +int iommufd_vfio_compat_ioas_id(struct iommufd_ctx *ictx, u32
> > *out_ioas_id)
> > +{
> > +	struct iommufd_ioas *ioas = NULL;
> > +	struct iommufd_ioas *out_ioas;
> > +
> > +	ioas = iommufd_ioas_alloc(ictx);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> 
> I tried to find out where the auto-created compat_ioas is destroyed.
> 
> Is my understanding correct that nobody holds a long-term users
> count on it then we expect it to be destroyed in iommufd release?

This is creating a userspace owned ID, like every other IOAS.

Userspace can obtain the ID using IOMMU_VFIO_IOAS GET and destroy it,
if it wants. We keep track in a later hunk:

+	if (ictx->vfio_ioas && &ictx->vfio_ioas->obj == obj)
+		ictx->vfio_ioas = NULL;

As with all userspace owned IDs they are always freed during iommufd
release.

So, a comment is:

	/*
	 * An automatically created compat IOAS is treated as a userspace
	 * created object. Userspace can learn the ID via IOMMU_VFIO_IOAS_GET,
	 * and if not manually destroyed it will be destroyed automatically
	 * at iommufd release.
	 */

> > +	case IOMMU_VFIO_IOAS_SET:
> > +		ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> > +		if (IS_ERR(ioas))
> > +			return PTR_ERR(ioas);
> > +		xa_lock(&ucmd->ictx->objects);
> > +		ucmd->ictx->vfio_ioas = ioas;
> > +		xa_unlock(&ucmd->ictx->objects);
> > +		iommufd_put_object(&ioas->obj);
> > +		return 0;
> 
> disallow changing vfio_ioas when it's already in-use e.g. has
> a list of hwpt attached?

I don't see a reason to do so..

The semantic we have is the IOAS, whatever it is, is fixed once the
device or access object is created. In VFIO sense that means it
becomes locked to the IOAS that was set as compat when the vfio device
is bound.

Other than that, userspace can change the IOAS it wants freely, there
is no harm to the kernel and it may even be useful.

Jason
