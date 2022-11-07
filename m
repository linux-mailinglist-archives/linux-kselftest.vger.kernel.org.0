Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7D961F70A
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 16:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiKGPCx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 10:02:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiKGPC1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 10:02:27 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1026E1FE;
        Mon,  7 Nov 2022 07:02:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eK1b51OhU8FLyTxmYKhLdxxevwrHQtpkC1TFoho24YPMN2A4Wo708jEDT800ysFEIhrfPWIIWlZKaLdqrS0q6aa2S8khg7Pxr6jRJIhYLeuTYtD4ooZseX4cQWMYWEWnxFJAL5gCGN/XSaD0ttkn0y7RKiiclFebGZ6GaB/Z7Mb5kCtEqMOsT3k7bkGAeG29GueT5e90lR3/uEQhZtEZz614366oQa4ybahP/ohPoF++q/kXwoRzwCuGMS8Iq/OL0sgQLSb0rdfDPmHVdynSHsTg2Kh2GtKQw3QNPtrgfXlutFlUOXDqxEZgYLEPtK0Dha76tnzGZXbl7XfjjV4Agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJb9x0t5zlzbbau5Fi8K6VXyhsC+zvK7TYCNUeF2RFA=;
 b=Xd2IMSPGfGSjyobn+02qcAweCqVjAUpif1JEwsgZkANjgWnYbGhnpVBaF8CpJzEAnrs5XxT76JDiELZWEo7s6KmgDySCuzUJnJwHASwdjgwDi5JDljovcZi1Xe1dF5sS50hhrJFWxY+hktCv7mQDAKsTFWoaFnfUx/mPSPXVe+7YZZNaxxElJFicSW5P5yiP1w7PbG5KhZAH4QP3e++S6LVw2KKsnMuut3BUFtjugGnGsnUMVVVUf1EEONQrWt7BgKVCImoq6iZbl+s8WGOeCkr4zEFZ7eO2VjT2HOYsMnGDzXTTepZ9wkQ25K3KV5rXrVEdWOmO+BXzYxtUEal+uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJb9x0t5zlzbbau5Fi8K6VXyhsC+zvK7TYCNUeF2RFA=;
 b=lVsOm1QnF0LJrfdwSBqZ/ITzjrs7kTg+/m7NaGR7lUH72b4YETenyuOFJBelVdChHmPcQ2AJpAOmUohPqsb9pgxsexMhwLrC1dSlQHmT4ZcRFL9SIm/THkQ8GGByZjwok4SOypv5XejRGpwRtX9Sqi0kqLTarFyBcxE7drhoXxHY0u8M8W6krJtkp3FxBx9O7N+XLr19HrTSPcSxkE+/hat8DK8vFLO7im8h3UFlQ6S9d3UUemc9igcFr7/lu38Wg8uJTA6gduEgJQKRDPMvjku+cq853PKjDjR3vZcPQ9jfl5GrBW3mLXF2sFjAmTeh5eM85S3uXcI9KG6ZPWvufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7672.namprd12.prod.outlook.com (2603:10b6:8:103::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 15:02:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 15:02:22 +0000
Date:   Mon, 7 Nov 2022 11:02:20 -0400
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
Subject: Re: [PATCH v3 10/15] iommufd: IOCTLs for the io_pagetable
Message-ID: <Y2kd/Ptt0iR6SGsh@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <10-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52765289F880B8A7297077318C3B9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0187.namprd13.prod.outlook.com
 (2603:10b6:208:2be::12) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7672:EE_
X-MS-Office365-Filtering-Correlation-Id: 94623a07-d613-4e7a-d224-08dac0d11278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RohM0EV+8x8RIzgwJdPGtQmM7SDq8SFPAwNAc9UMaiN/8Iovh7gsXt+tUxfDWmNgh00OORuzW/XQVu6qPXv++bxXIXBW/99C8zQnPNM18H7uw8fGdrq1kD/4/qSue4rnY6DFLieoia4uAMX3kLT6G2eIZgB+PvPJ/er0Bo/v/QfsEMjKpjWfX6vPr91wPVJRh21xyb7Hsh6IdllbrYl6lvh5re9fHrf1NcusV3wTf6Hfp8WxEwWOjd6jzSXfaksrvPzjZd349yvS4iQZo96BBIOZi9x4JWM20pBcj3wW9yZrgrAbcmxh45XcLLmnO4b1cD0LZPA0dcLswYeAqKchHsjlGcB6sjyUs5GK7ss4EgmyW8+HxpTDyDafX6GkKymqF7Yw72agNmxncaNlfyfYturlQwQ+OXT8ndigjshETn41/YgTFKBUFoAN2eRBst3KsA63cmlE2t+hOuIYeNUFcgtjHRlAVTEjdLaoSaVsvsmniC2nNXvj+JSI2rMIBH1N/PFmUjKx2+oSQ/ybcCPMp1Wf0LSseFv73ltTq9cMaA/vNRHUcQ/wKroSqfC9YCvUSBbyOF8RDGG26ThiMNKpITFqF+QRk1z1jGZlAJTFZp3HQeLfEdF8cOtHxX5BwSWYL7tASm8jD7gLTdjBR48ox/8JqACXBzFaCF8wtHW6XKzPBD9Cvl4y56xWV+N3SiiL4mXlfbgntsDTH9rUWGCeDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(2616005)(83380400001)(186003)(38100700002)(2906002)(7406005)(7416002)(8936002)(86362001)(5660300002)(478600001)(6486002)(6512007)(26005)(6506007)(66476007)(8676002)(66556008)(316002)(4326008)(41300700001)(6916009)(54906003)(66946007)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fCZx4UwOHeET4zF4RINjrqSbJ4ol5FjywJYtCqWKcaCUYlqit5T5wbN9bb5M?=
 =?us-ascii?Q?cJRMLAZnuJLeInotAojbsefcG5euQHFEFQLuyhGx3k7k3Qf2mun7mHD4LiqX?=
 =?us-ascii?Q?NYde8+nONA6TYqf6qqlFBvR6c40H9NxgfjohZJgc3rpPgvQUs6FuBhFLOkUj?=
 =?us-ascii?Q?OteJq+qIG+z/ARgaX/vVScZZCFbAKv9G93CTlNgH22CG8sktzfJmW5blWNPc?=
 =?us-ascii?Q?VuUpSGT3ZdHDeLkPAF/5NJBZoVrgc5JEgTArZTNkUQj0wIKVB+UzKYI+byiM?=
 =?us-ascii?Q?uGj7nst2uVvC6Plsr0OVcttXimdLR5QY9NlScVnS8WjxekFvia5vREkrM4nV?=
 =?us-ascii?Q?Oec5PUK7FMX4ub5w38NHErM51I3U3jruMNsU5YKZUFGJIbU7lVEcSz035Jrh?=
 =?us-ascii?Q?SW5kU4ZJfsX9pj4Z3Y15RR5apdIqbI3tRK/2lLvvfWVn4F2DzZXrATjEus4T?=
 =?us-ascii?Q?ImjoHSf2Pbw2GBPYpt3caLSpTfgTxNNcmGhG6/xHtKt+OmePdmU9hbDFAAv9?=
 =?us-ascii?Q?Vzx1jn7USxarzByC4CAlqAT+fp0fdi35iGEk1i/c0mzgxU/alqucc+JvJ6ru?=
 =?us-ascii?Q?Lc1r8NBg9cP4D0xd1y7I7pAazZBh4M4LHo6YJjyDoTZozhhPSVIdN0qCXwkY?=
 =?us-ascii?Q?jr1QJHUhX9A/27sOA8ds0SrLCKjRop6maO7gfL7PqqU22oCE4olR2JW+7bKO?=
 =?us-ascii?Q?iMdzp8Xz39M1FV3ezdGSympDfghW4dXJpjo2021yM8mjhihSpJMyWOQA/qGL?=
 =?us-ascii?Q?6EI+F6f2J9sb+ynIQditB8dZx/LEjdhXnqrpxq12rNKNDQFkmLAt3Q0+lYl5?=
 =?us-ascii?Q?qQA20hdorZkwErGOTXZ5FJP1Gr3fSGBDFjj4tXOu2Z+bqZ5Eb/bq+sPgyXYU?=
 =?us-ascii?Q?Na1gS+rQFR5RYm86/qMhNLDZEOMU6KtDO/Mh2dd4Dch2Zcu1nGAvKeJe9Hl6?=
 =?us-ascii?Q?HWVZzAwVknww1sdLju+yHbvhrh30Seqwbk9JlkIcbr1VYs6bBB0PR9s+vl/D?=
 =?us-ascii?Q?+azTQh5QOCOLE+ye18yLgrc/UP8mqGVbt9Far9c3/+9VC8f3NU0K3rb+t76w?=
 =?us-ascii?Q?s2QN3aoktsebQ1mp6TnNnG4AXO7XaYyLcIO8Ik1nEy3hrssmzQOeJw5zLARL?=
 =?us-ascii?Q?lznMROlm6bsXmuEtwlo34pk1kwDp5PQcwFedgL9CofAcQUB6SnJNhfKiZ0R2?=
 =?us-ascii?Q?euXubVD7Vxyyx/qehhKQiX9fFOl0iEQKX7vxs1U9/dqZL7BADQwe9WJCvRVR?=
 =?us-ascii?Q?HYROy6f/nQyQKlk5lTDup1AfXxtPdIS5hzybpne6Y5SjaL8D9epYfSjgUOc4?=
 =?us-ascii?Q?2DxhfDgbIAHN97aLJLumWF5vU5FtgE3lnUnN5rgYrC2VmCk4h84sZM5Make3?=
 =?us-ascii?Q?d404DLmPJ+D7ciCsLcTekQrHG+evka5t7bkTBykLnD0yKrdxTAnqzj9UqVHr?=
 =?us-ascii?Q?p8xQGOw6O/NOTqowSKIYzO6kcLvkINZxQhzQlnnaqs69SelKbrlH6DvFxTlQ?=
 =?us-ascii?Q?DSulqmW0/nzgsnonxLGcVA0eMLN4asjszruJYyTBb8Z3F19U0n2iEF8/0Xwt?=
 =?us-ascii?Q?Azi6L+2LRdG5Bxt/pLU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94623a07-d613-4e7a-d224-08dac0d11278
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 15:02:21.9451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7jKA57/J5sFjGTCP2QhN1Mllly5gtavE1geSSmauDy+gYJt+Pudrle7mjw8nL44
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7672
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 04, 2022 at 08:32:30AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Wednesday, October 26, 2022 2:12 AM
> > 
> > +int iommufd_ioas_allow_iovas(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_allow_iovas *cmd = ucmd->cmd;
> > +	struct rb_root_cached allowed_iova = RB_ROOT_CACHED;
> > +	struct interval_tree_node *node;
> > +	struct iommufd_ioas *ioas;
> > +	struct io_pagetable *iopt;
> > +	int rc = 0;
> > +
> > +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +	iopt = &ioas->iopt;
> 
> Missed the check of __reserved field

Done

> > +
> > +int iommufd_ioas_copy(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_copy *cmd = ucmd->cmd;
> > +	struct iommufd_ioas *src_ioas;
> > +	struct iommufd_ioas *dst_ioas;
> > +	unsigned int flags = 0;
> > +	LIST_HEAD(pages_list);
> > +	unsigned long iova;
> > +	int rc;
> > +
> > +	if ((cmd->flags &
> > +	     ~(IOMMU_IOAS_MAP_FIXED_IOVA |
> > IOMMU_IOAS_MAP_WRITEABLE |
> > +	       IOMMU_IOAS_MAP_READABLE)))
> > +		return -EOPNOTSUPP;
> > +	if (cmd->length >= ULONG_MAX)
> > +		return -EOVERFLOW;
> 
> and overflow on cmd->dest_iova/src_iova

Yep

> > +
> > +	src_ioas = iommufd_get_ioas(ucmd, cmd->src_ioas_id);
> > +	if (IS_ERR(src_ioas))
> > +		return PTR_ERR(src_ioas);
> > +	rc = iopt_get_pages(&src_ioas->iopt, cmd->src_iova, cmd->length,
> > +			    &pages_list);
> > +	iommufd_put_object(&src_ioas->obj);
> > +	if (rc)
> > +		goto out_pages;
> 
> direct return given iopt_get_pages() already called
> iopt_free_pages_list() upon error.

Ok

> > +int iommufd_ioas_unmap(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_ioas_unmap *cmd = ucmd->cmd;
> > +	struct iommufd_ioas *ioas;
> > +	unsigned long unmapped = 0;
> > +	int rc;
> > +
> > +	ioas = iommufd_get_ioas(ucmd, cmd->ioas_id);
> > +	if (IS_ERR(ioas))
> > +		return PTR_ERR(ioas);
> > +
> > +	if (cmd->iova == 0 && cmd->length == U64_MAX) {
> > +		rc = iopt_unmap_all(&ioas->iopt, &unmapped);
> > +		if (rc)
> > +			goto out_put;
> > +	} else {
> > +		if (cmd->iova >= ULONG_MAX || cmd->length >=
> > ULONG_MAX) {
> > +			rc = -EOVERFLOW;
> > +			goto out_put;
> > +		}
> 
> Above check can be moved before iommufd_get_ioas().

They have to be after this:

	if (cmd->iova == 0 && cmd->length == U64_MAX) {

Or it will false trigger


> > +static int iommufd_option(struct iommufd_ucmd *ucmd)
> > +{
> > +	struct iommu_option *cmd = ucmd->cmd;
> > +	int rc;
> > +
> 
> lack of __reserved check

Done

> >  static struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
> >  	IOCTL_OP(IOMMU_DESTROY, iommufd_destroy, struct
> > iommu_destroy, id),
> > +	IOCTL_OP(IOMMU_IOAS_ALLOC, iommufd_ioas_alloc_ioctl,
> > +		 struct iommu_ioas_alloc, out_ioas_id),
> > +	IOCTL_OP(IOMMU_IOAS_ALLOW_IOVAS, iommufd_ioas_allow_iovas,
> > +		 struct iommu_ioas_allow_iovas, allowed_iovas),
> > +	IOCTL_OP(IOMMU_IOAS_COPY, iommufd_ioas_copy, struct
> > iommu_ioas_copy,
> > +		 src_iova),
> > +	IOCTL_OP(IOMMU_IOAS_IOVA_RANGES, iommufd_ioas_iova_ranges,
> > +		 struct iommu_ioas_iova_ranges, out_iova_alignment),
> > +	IOCTL_OP(IOMMU_IOAS_MAP, iommufd_ioas_map, struct
> > iommu_ioas_map,
> > +		 __reserved),
> > +	IOCTL_OP(IOMMU_IOAS_UNMAP, iommufd_ioas_unmap, struct
> > iommu_ioas_unmap,
> > +		 length),
> > +	IOCTL_OP(IOMMU_OPTION, iommufd_option, struct iommu_option,
> > +		 val64),
> >  };
> 
> Just personal preference - it reads better to me if the above order (and
> the enum definition in iommufd.h) can be same as how those commands
> are defined/explained in iommufd.h.

I prefer "keep sorted" for these kinds of lists, it is much easier to
maintain in the long run

> > + * Query an IOAS for ranges of allowed IOVAs. Mapping IOVA outside these
> > ranges
> > + * is not allowed. out_num_iovas will be set to the total number of iovas
> > and
> > + * the out_valid_iovas[] will be filled in as space permits.
> 
> out_num_iovas and out_valid_iovas[] are stale.

Done

> > + *
> > + * The allowed ranges are dependent on the HW path the DMA operation
> > takes, and
> > + * can change during the lifetime of the IOAS. A fresh empty IOAS will have a
> > + * full range, and each attached device will narrow the ranges based on that
> > + * devices HW restrictions. Detatching a device can widen the ranges.
> 
> devices -> device's

Ok

> > +/**
> > + * struct iommu_ioas_allow_iovas - ioctl(IOMMU_IOAS_ALLOW_IOVAS)
> > + * @size: sizeof(struct iommu_ioas_allow_iovas)
> > + * @ioas_id: IOAS ID to allow IOVAs from
> 
> missed num_iovas and __reserved

Hurm. how do I get make W=1 to cover the header files?

> > + * @allowed_iovas: Pointer to array of struct iommu_iova_range
> > + *
> > + * Ensure a range of IOVAs are always available for allocation. If this call
> > + * succeeds then IOMMU_IOAS_IOVA_RANGES will never return a list of
> > IOVA ranges
> > + * that are narrower than the ranges provided here. This call will fail if
> > + * IOMMU_IOAS_IOVA_RANGES is currently narrower than the given ranges.
> > + *
> > + * When an IOAS is first created the IOVA_RANGES will be maximally sized,
> > and as
> > + * devices are attached the IOVA will narrow based on the device
> > restrictions.
> > + * When an allowed range is specified any narrowing will be refused, ie
> > device
> > + * attachment can fail if the device requires limiting within the allowed
> > range.
> > + *
> > + * Automatic IOVA allocation is also impacted by this call. MAP will only
> > + * allocate within the allowed IOVAs if they are present.
> 
> According to iopt_check_iova() FIXED_IOVA can specify an iova which
> is not in allowed list but in the list of reported IOVA_RANGES. Is it
> correct or make more sense to have FIXED_IOVA also under guard of
> the allowed list (if violating then fail the map call)?

The concept was the allow list only really impacts domain
attachment. When a user uses FIXED they have to know what they are
doing. There is not a good reason to deny the user to use any IOVA
that is not restricted by the reserved list.

> > + * @length: Number of bytes to unmap, and return back the bytes
> > unmapped
> > + *
> > + * Unmap an IOVA range. The iova/length must be a superset of a
> > previously
> > + * mapped range used with IOMMU_IOAS_PAGETABLE_MAP or COPY.
> 
> remove 'PAGETABLE'

Done

> 
> > +/**
> > + * enum iommufd_option
> > + * @IOMMU_OPTION_RLIMIT_MODE:
> > + *    Change how RLIMIT_MEMLOCK accounting works. The caller must have
> > privilege
> > + *    to invoke this. Value 0 (default) is user based accouting, 1 uses process
> > + *    based accounting. Global option, object_id must be 0
> > + * @IOMMU_OPTION_HUGE_PAGES:
> > + *    Value 1 (default) allows contiguous pages to be combined when
> > generating
> > + *    iommu mappings. Value 0 disables combining, everything is mapped to
> > + *    PAGE_SIZE. This can be useful for benchmarking.  This is a per-IOAS
> > + *    option, the object_id must be the IOAS ID.
> 
> What about HWPT ID? Is there value of supporting HWPT's with different
> mapping size attached to the same IOAS?

This is a global IOAS flag, it just makes everything use PAGE_SIZE. It
is really only interesting for debugging and benchmarking. The test
suite and syzkaller have both made use of this to improve coverage.

> > +/**
> > + * @size: sizeof(struct iommu_option)
> > + * @option_id: One of enum iommufd_option
> > + * @op: One of enum iommufd_option_ops
> > + * @__reserved: Must be 0
> > + * @object_id: ID of the object if required
> > + * @val64: Option value to set or value returned on get
> > + *
> > + * Change a simple option value. This multiplexor allows controlling a
> > options
> > + * on objects. IOMMU_OPTION_OP_SET will load an option and
> > IOMMU_OPTION_OP_GET
> > + * will return the current value.
> > + */
> 
> This is quite generic. Does it imply that future device capability reporting
> can be also implemented based on this cmd, i.e. have OP_GET on a
> device object?

I don't view this as a way to do capabilities. I think we will have a
capability ioctl as well. This is really for something that can be
get & set.

Thanks,
Jason
