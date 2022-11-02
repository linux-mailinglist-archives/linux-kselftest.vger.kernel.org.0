Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9D76163B3
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 14:18:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbiKBNSV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 09:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbiKBNR6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 09:17:58 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA192A722;
        Wed,  2 Nov 2022 06:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKp7ohdpxGQ5tb62wfeRVXRBiZy0sIRUuCfPhJNtmdfDYvVvXcQSfkdigct2RgVVGsG92Z5Wx5/cR2ZKdr/QxaBG6LvQFhegQ1jfPkGB9p2sssuYFdA67V5MR0uDC6TVlpFZ5L0HdnYi3w5lNgCt6RDFV0D/GmCTLgnzcdn59hLNlsBe+9FdKPhsN4NFvEWryhSr1tHmsHoYpp/8Zz8YRGZtLWT8wYwS3qfO1oX0quIoFLQMK9KWWkAdmezcTmACgrbUoC7pXTbk9kzq2xZyny3R7e845WchWA0Dxbl93F5gtnkD2k1AAw8xl5lrntDecIyLWTPwrRHm6VEPbfC5SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmRaQL7SXYCVJ75qusrjG5w/TI/0E8m49d8XBfoeFgE=;
 b=e7dmRfhdasc/Mu12WWoaV3HFlh/zTOPMxcC+pPLvD6HLGs77i843YNnAmNDFv/QIGfsknDaoCBGAMuM9ZekxBPH2l5duSodXSfanInzHQFiLwKgCHj3aPvq9LXhCN78GbQ2AjUm91TcLXB3aJPq0E3FA0CJ62y4vP6UScFvaRmRd/Tf02VuAClnkxiymY9ULLCg5a7/IacepcgR01+s/wqNMXsRkcj75HM1yq+/bTvFyc7GnS1CgqkbP8DQmFDoD2fFpwW8B8BKPEC2wZzRH1PC0OEdF5UV+QcnyyPfu5EGGn1WFb5zDmoOaI5D/UJ2P/QSgRlHC+uk8VHid67TSkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NmRaQL7SXYCVJ75qusrjG5w/TI/0E8m49d8XBfoeFgE=;
 b=mDWgRlzaHjI3g6A0GLd97zx5KWJQQtp7pLtFE/+o9Qaj3UKO5C0/CPWC/LFkk2P0a0W6pme/kU64+WEjFRnuuepqQlkCqKWSTQkIZh9LIFzZh8lxbiJ03Kd0ubbF05HePolpqS4HTCPnzipKdylLuykVhtypT1b5pQlLHJrNicsYFAs/OAu9fdjfhjEl5/100oR5susd0faMC+1+83R9NS7VAUnCFyMq+mJTZcRQBecKPtGM5B776lqDxi0SxZC+WY+WuN90uHD5t7yu+JpG8INavtFtHO1ahEugrqHbWimTbZUsSKG/ylF9S41JLsy7RYqbmmVjxt7OVPlhMgz5Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CO6PR12MB5396.namprd12.prod.outlook.com (2603:10b6:303:139::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 13:17:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 13:17:46 +0000
Date:   Wed, 2 Nov 2022 10:17:45 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 15/15] iommufd: Add a selftest
Message-ID: <Y2Jt+WxNUwROJ8fN@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <15-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2GCV97lxEGwAuo6@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2GCV97lxEGwAuo6@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:208:91::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CO6PR12MB5396:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e60d49f-bf36-414f-39b0-08dabcd4a232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCD2pzrpKJ+alfJp5Gr3GaqvySVjOl7vmexgWDs6kb28GTYbO7siN2j0mszKCKGcjbGxxgRRqtf/rpUyu+qZuOUIG90AF+sGbA3Xf8/wnmlnqVQJ3F8mVOXfnHTGYsl6gmq4bVqhM8fAldArxDx385fNHiMXIidZKyXZTRksEuWQabwjuCSEJOlDcUvLPm+OHpXtaALo0TUwAQTwcLTZMNWrMq+xpEe5UoFWQsTKNUnFxTrLKn+C337TFlB1bLMzm8Wrk51tNMcEf/JHXPKmT4YIkTC7m6wHdENSrH+Cos4dAUA7ZHR3vX294kma4tv9RO4TOYJerzXiZ9kyemfIpXUVP2Hc4yetQXqql+gNgXe25SFFExjcqR2Hd5SFg5ITBfjrfAMYwpHQq8UtDYwEADYnBE6EDUmXyiCKVDWZDz9u2KFJ1gqCNM+o7Q/eHn131MfNXZtaO5o0SiXURe2o50IN+jHGniY3rxUEOkYYazv2ZRUDw5VmFA1imedbV/Xb284g8MTaUSASls5mI4cyxSLu8SXWjvYY5/XpwTksR8uN9X3b60FyBijd0n+n2820hxSmElJb4ZM4fXwtByF1q6HegkDwH6rxexC00Eg8GXuHjuYtJPfa9zm+HPZ0chOvnPapttqb7WgYaX4MFJ08xngDqX12gCOo3CuwdOmPfkjinnhGJf517gTd1+JiTgR8iVqlXJmLuAS+p9FdzqttjbJNTXdDvuSDNXrNbsKaGZttrwLf5VrfUuTk6dm14REf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199015)(4326008)(6636002)(316002)(478600001)(54906003)(37006003)(66476007)(6486002)(6506007)(8676002)(66556008)(66946007)(26005)(5660300002)(7416002)(41300700001)(7406005)(8936002)(6862004)(38100700002)(36756003)(2906002)(86362001)(83380400001)(186003)(6512007)(2616005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lrYCHkcYO2XO5GJgH+cNCSJoDeyL5XcLBICN5ka4tMeDM1Es2ANxntkNMMK+?=
 =?us-ascii?Q?gEfHPcAjliaJXvsCniGIBBSAGNK10K0OEfaCDexPCOR5Nn+Vf3sGXoS+t56d?=
 =?us-ascii?Q?xE3P0rpxrCOKaP9h4wsYZGx8o4Zbk6PnJ3STJ/xmgK4TxZKfzoy2IOzU+hLm?=
 =?us-ascii?Q?qo0Gs2T2SKRPPsJOKKB3fk67aC43Kk52qM9sRYiQGcL2FlZR6cbSgbQ6cI15?=
 =?us-ascii?Q?u/dmFtf9q5OT/WHHYwvdNKzlnCgXDKgEtKi1CKbfGdIPjoAz30fBUo8jGtrM?=
 =?us-ascii?Q?DXQ51E9ERERDvy9XYCBi9IXO7aDODcjMhilUFRQuquoII5jiX57veNwmQP6L?=
 =?us-ascii?Q?XtDI8eRZym0jXfHVbwYNP/K/aMuQuZUdJlCf7UDLD5pM+/bfOPS8X7ClPSWq?=
 =?us-ascii?Q?kGtmoS++lTzPVZqzW7VWviJTnvgA7565Bg7bcqd2wXyUicztL6ceWDq7JeIY?=
 =?us-ascii?Q?9WpmBn68izYYFSxa90OoB0GyElQUycfa+JXy1LDP/I00qKDOwJJwSctdCzNP?=
 =?us-ascii?Q?Yp+wl486qhsItJEV46iKMryLCcB40M1a96qAEsAYGb0J6zpXvbkrR1w0ryLb?=
 =?us-ascii?Q?qpJxeIbchHTgvgsCWbNb7WwAyWIgcAsZwOL57hZ8YMLQi+2J3CpJbt+nUI5r?=
 =?us-ascii?Q?LU3FPqCRCcrf05IqHDuDgfdwFrsYeDViLO/JtA6GCBydIhjJz5+3Ea0NhKd2?=
 =?us-ascii?Q?+eOGrmpN5LRdp64CM3mY1aCSONIwWSpDlAbYyfBzUToKm3b8MSTmN+H9eT7H?=
 =?us-ascii?Q?a0uf4peEIWJaS/jP1R9HMWtl2QKNFK6UraRZTlRpwQFI7XqxQL4o4/U+YlQN?=
 =?us-ascii?Q?KFFoOWaoorVAMJi4nemq68MrU80fDZKCiKuoUvrCIMvOhz5SyW00vE4ZrYly?=
 =?us-ascii?Q?Xx8d6hpoEYgNpm6lfHm2Qq+nDzQ2cyL/M1AxzrKt07e3TKgAiOAi21CMpMGs?=
 =?us-ascii?Q?07zCs9sOgg6psRM5R4AyNtuXE9WiaqdW2pNvI7EpYm1balB6fQv4cc0pR2jB?=
 =?us-ascii?Q?5YF+KdBglK9Rf+Z7gYrdx4KEIdB5jLBkMm1QVgQXizU6/CZypOZwcXVYjerc?=
 =?us-ascii?Q?DM4Qb1OM0jRuavsTpIXTkxCzxGTdk63JM3IC81rsxBvzSgNxTggsri94k8i8?=
 =?us-ascii?Q?LqAxzkpYf7Tsz6mMwqNg74a2poLhBLT/93U7j59OftyVRTEHAQFFnN7gOVrr?=
 =?us-ascii?Q?YXibFBYfb9OYV6YR1Nt/RgXMOtdzCOA40wCQY14DpypZRnYMlkKCV3HS9/X+?=
 =?us-ascii?Q?m+L04TuF9zMtfRJTMBpG2b3/X78lqQwXFrM5xv/BGQEBVoGSIxAz+a+jMhic?=
 =?us-ascii?Q?VWcWWVQ0VQGkyU9k7ZTJKPes4QQ0DrMOUjzFBqqQnFJb8TNJ5FTLRVzwQnd3?=
 =?us-ascii?Q?+QIGWyieB8cn5MP1Adrb2vXnT6qlvzlmHx2uY7SMtL0bgx7Bz3aMUOOl2peq?=
 =?us-ascii?Q?JV0vC11Ze7ipApGfDNxOwnRB1rrspyWzeKaIy0s6OTiFDtpcjEwFVmRWSHR5?=
 =?us-ascii?Q?uw5WT2pNVpwX35DVD/1/XbGqWwSJxXdOno4JDLDOR76txrJe2uAyQd6AAD+r?=
 =?us-ascii?Q?J8PMKD4/LoIrxIqgzgg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e60d49f-bf36-414f-39b0-08dabcd4a232
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 13:17:46.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjKXNYHXNHOXz9Y3PROSeaqNj70VRsDk/meElTlR1husRdvFHq1TXRCuZq4VHLGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 01:32:23PM -0700, Nicolin Chen wrote:
> On Tue, Oct 25, 2022 at 03:12:24PM -0300, Jason Gunthorpe wrote:
>  
> > diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
> 
> > +static inline struct iommufd_hw_pagetable *
> > +get_md_pagetable(struct iommufd_ucmd *ucmd, u32 mockpt_id,
> > +		 struct mock_iommu_domain **mock)
> > +{
> > +	struct iommufd_hw_pagetable *hwpt;
> > +	struct iommufd_object *obj;
> > +
> > +	obj = iommufd_get_object(ucmd->ictx, mockpt_id,
> > +				 IOMMUFD_OBJ_HW_PAGETABLE);
> > +	if (IS_ERR(obj))
> > +		return ERR_CAST(obj);
> > +	hwpt = container_of(obj, struct iommufd_hw_pagetable, obj);
> > +	if (hwpt->domain->ops != mock_ops.default_domain_ops) {
> > +		return ERR_PTR(-EINVAL);
> > +		iommufd_put_object(&hwpt->obj);
> 
> Coverity reports that return is placed before iommufd_put_object.

I'm surprised no compiler warned about this!

> 
> > +static int iommufd_test_access_pages(struct iommufd_ucmd *ucmd,
> > +				     unsigned int access_id, unsigned long iova,
> > +				     size_t length, void __user *uptr,
> > +				     u32 flags)
> > +{
> > +	struct iommu_test_cmd *cmd = ucmd->cmd;
> > +	struct selftest_access_item *item;
> > +	struct selftest_access *staccess;
> > +	struct page **pages;
> > +	size_t npages;
> > +	int rc;
> > +
> > +	if (flags & ~MOCK_FLAGS_ACCESS_WRITE)
> > +		return -EOPNOTSUPP;
> > +
> > +	staccess = iommufd_access_get(access_id);
> > +	if (IS_ERR(staccess))
> > +		return PTR_ERR(staccess);
> > +
> > +	npages = (ALIGN(iova + length, PAGE_SIZE) -
> > +		  ALIGN_DOWN(iova, PAGE_SIZE)) /
> > +		 PAGE_SIZE;
> > +	pages = kvcalloc(npages, sizeof(*pages), GFP_KERNEL_ACCOUNT);
> > +	if (!pages) {
> > +		rc = -ENOMEM;
> > +		goto out_put;
> > +	}
> > +
> > +	rc = iommufd_access_pin_pages(staccess->access, iova, length, pages,
> > +				      flags & MOCK_FLAGS_ACCESS_WRITE);
> > +	if (rc)
> > +		goto out_free_pages;
> > +
> > +	rc = iommufd_test_check_pages(
> > +		uptr - (iova - ALIGN_DOWN(iova, PAGE_SIZE)), pages, npages);
> > +	if (rc)
> > +		goto out_unaccess;
> > +
> > +	item = kzalloc(sizeof(*item), GFP_KERNEL_ACCOUNT);
> > +	if (!item) {
> > +		rc = -ENOMEM;
> > +		goto out_unaccess;
> > +	}
> > +
> > +	item->iova = iova;
> > +	item->length = length;
> > +	spin_lock(&staccess->lock);
> > +	item->id = staccess->next_id++;
> > +	list_add_tail(&item->items_elm, &staccess->items);
> > +	spin_unlock(&staccess->lock);
> > +
> > +	cmd->access_pages.out_access_item_id = item->id;
> > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +	if (rc)
> > +		goto out_free_item;
> > +	goto out_free_pages;
> > +
> > +out_free_item:
> > +	spin_lock(&staccess->lock);
> > +	list_del(&item->items_elm);
> > +	spin_unlock(&staccess->lock);
> > +	kfree(item);
> > +out_unaccess:
> > +	iommufd_access_unpin_pages(staccess->access, iova, length);
> > +out_free_pages:
> > +	kvfree(pages);
> 
> Coverity reports a double free here, call trace:
> 
> [jumped from] rc = iommufd_access_pin_pages(..., pages, ...);
> 	[in which] iopt_pages_add_access(..., out_pages, ...);
> 		[then] iopt_pages_fill_xarray(..., out_pages);
> 			[then] iopt_pages_fill_from_mm(..., out_pages);
> 				[then] user->upages = out_pages + ...;
> 				       pfn_reader_user_pin(user, ...);
> 					[then] kfree(user->upages);
> 					       return -EFAULT;
> 
> Should be the same potential issue in the other email.

Yes, looks like

Thanks,
Jason
