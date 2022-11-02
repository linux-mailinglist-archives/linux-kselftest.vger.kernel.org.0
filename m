Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A35B616372
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbiKBNLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBNLn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 09:11:43 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2041.outbound.protection.outlook.com [40.107.220.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D852A436;
        Wed,  2 Nov 2022 06:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVyANxOsiX3ThsgesZJIbRYu85VNFltjm67b0xeCKOoEbL/iCqMWIJ/4RM9GDDEILeq/3sETaZTsk6Nvemh26Opq402bdTBgDrIa7Pl7vRv+XIwKW5L/i8JnL9KZRhnDsIgKz1gLDRnT5fsj4YiHXjuwXZRaBPDp4kvb5B1UKAzCT46drnO1PaJXl5EoweorntXPEaRUstGBmEWnetCdQImnm9kgKhOalAkqKRynlAjK8KFrjBSGQai2sXSh5ImLbA7JyHKSy/qK8APQ9nTzopUYRiJN14ibvd0tkF3IZ8re6yanCWgdJyHApcvW2bde1+/Mj5fCYjf8wHF5NSY4jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8gTSa0heS+v5cxbJUQkQQH7pT4L+hSFNBL7CBsJjOA=;
 b=UomicQ8YoGoCkQ9FY9VZjUDX7iY88X0Bz1Tv3w1SylLhdYukz9pQ4+ByJvJwnAijlGFFOzL8wY5MHzC5CgRNNjRmkqVg0FGv5j3drMbyzWMxRtcYQSAe8340YyyduK/LzJNOOzHxf3cggRKcCMJdjWKAnlsoq41Cq18nVOPSrBzfVWzd99yAzMSagb6dgGuAsvZI/9huEA5qHjuXVaLc4gcfL6PXe28XH+a8M4frN16wSEfxvJhXTm7pS07n5P5JwDHOfVQNzkgjLdtlFn8lwPPaPU50CMhdMhgM3Xeqfl1J6MdFsLYFbxasGjDbMqileWFbVZro5lV2kIQwBcP3tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8gTSa0heS+v5cxbJUQkQQH7pT4L+hSFNBL7CBsJjOA=;
 b=tS6VAuN0urTnTd7biX3ihcAb2y7UiTDzMsb0EagTWmMwS1+9NoH4DFXhp5IBy6NV9+sGmgtr+vKmRZR+dlOnv4lza9rrJqyyixGue8k7J5sKXVV2QW+ay1Se2MjPZykvSYXAHPGIGbeCjocdyUAxztYuhaEEQDjFSpfsyGAZd8INEuwShSdfJAmqvEkXcbmEEB+gvx/l+/CH0y70PZiCHZQ8Yoy+j/IDVy6Oeqv1yIvKT9Zz3OLrGWHk2V0KOYdwAf2oFzJLthYoMmzEmgOWlRss6YYaSVMDGkRgWMLXkMYUk+L5o/2GQbkjNS6MLqHq7B9v32kejvUuBosepEEvgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5294.namprd12.prod.outlook.com (2603:10b6:5:39e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Wed, 2 Nov
 2022 13:11:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5769.015; Wed, 2 Nov 2022
 13:11:34 +0000
Date:   Wed, 2 Nov 2022 10:11:33 -0300
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
Subject: Re: [PATCH v3 09/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y2JshUrDXYxMwUbK@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <Y2FwydZzhcQ2vpdU@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2FwydZzhcQ2vpdU@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0133.namprd02.prod.outlook.com
 (2603:10b6:208:35::38) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5294:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fb2a762-087f-465b-2b45-08dabcd3c459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wIUAWNsKrc/Z9Tw3wUlHNQfQLzllaRWicaR5IXFvlO4B+BeT4POrdSVTiDDf2EwuCqR1XDAsPEik7YXP/dOTZGm4zzjG4PHh/SAZXWCbb+Y0fWwcP8Ol+YhafYHxVfgXJMgomjuDqVcwxpNobXTTvlkvz2GzQWnQWyAys5GgGnMaGH6wSKur0An8/DNPMXX2wa7YCL8jCmrJleyc0PsfkTsqG2s2667dgWUleneWS1Q9HDvTIpsyI/EM4KUeCFZcK8Qb18seTEFVZKfWsg3R56PBZWzNgTYgLcrPqYLwiFP2c5mj8Qs844meL77HNgu+71AQJkdhY+7SfuvOoNsSK5bWPpLWAH02SJcg/9ffNU7+dX5pl6Lh9YuBDlnE59p+972BXdDqmnphdGZw0t8e5D7mItjfsQ5ZdfBjsdL/Uo7s96bfivfZTB0z2IUoVkvsDpyf9YbBbYIM2lrC7R/cqievZn7+wBSNfU49Ld13dxQs3RJ/AUoS4QJ3V/wokLkwN3yGgrG8siPvJeusO2C1oNdxeH6PPJ6sCeavzZ4hDF0xaPCpjo+RLal6rYcLfDVeJ8eF7cjqySRPdBFQmgVcaurKTuZCKiC61KPMftZy0JGkO3ifOjeUvpQQXQHBnhUlEDR9YzVn+0X+HWbHFSc9hSjJG8v30dbtCqnHwmzPUy0gzMysXYUTMWAzIa8HP/bL+nDOcPiyNgK+E8m4tBE/Uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(451199015)(2906002)(66556008)(6506007)(186003)(4744005)(2616005)(316002)(26005)(41300700001)(6862004)(8936002)(86362001)(36756003)(6512007)(8676002)(5660300002)(7416002)(7406005)(4326008)(66946007)(6486002)(478600001)(6636002)(54906003)(38100700002)(66476007)(37006003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6DRElkTamxs25Waq7P2vJwffUWEsb3kuhNccGjt5HSq5WMhBBE3rknR/jEVX?=
 =?us-ascii?Q?R7J0hotHAYyLV0++AKwFOI9oA13EKydSu+vqr+W+nNv3fpVnttipmAmUDBss?=
 =?us-ascii?Q?4NqSsuvS6q5jfOY9z3CzkmctmIHG8GeMpFk03lTdpBktxXE1tOhwueGfgYb2?=
 =?us-ascii?Q?/BlWcHODeoCDU4g02qOlyGuYRtFa7KOhpdrhQ8MwkVSka+3vxUperRtzgWIC?=
 =?us-ascii?Q?ud4MhHwlWH62zQuVgG018JRxwrTDF5To30qND4B1qGRzHzq1A1dHhSOxgD6i?=
 =?us-ascii?Q?AtK61glA5g1XWlvXFlO3Cyxye4c0wABTMc4DqzkPNaquFdm7hBAcbhla4xB/?=
 =?us-ascii?Q?Fo7mWFFbZeXax/EtkmdGUKCwm/IU437Kp7yQtBpAl9tZAxDG6zTTiglPLwWd?=
 =?us-ascii?Q?ZI9+jkRI66d9WWWBTtWa4CQC/RVtfCATCw9tXwie9Yau2GqJNwZVF3s7dZPk?=
 =?us-ascii?Q?5/yucF7kehE7dysg1MRjblqf9crVrBdcKJY8XGmdv+Pgd1ENbGh4TPV8nLVI?=
 =?us-ascii?Q?No0O3WaJfXgL+dvhhMYh/sTIwo/PP/hBktXv0hWLEDt3nYiNuA1hGpsuCfLO?=
 =?us-ascii?Q?T6D7wOGq8j1F+OU+zqGnqpuMhuxU1McvABfPJ/vCxBLOD8RMH0GU0SusT/jW?=
 =?us-ascii?Q?QTodkEQx5pWndTvL6Gg5UBqUqrZZ2DY14ZoB2IQ8oP5mMbOp1bBtL/4Jukt4?=
 =?us-ascii?Q?2RweB4xW/sOIMDPGz7TNla2JCUBIkF/b0g4MMPg0dYnI3N1/kesEiNFxCjw4?=
 =?us-ascii?Q?rAmrN8bAdvwXzqfoBbPx3enZXIKshC6I7oonH/hEaFX6mqH+lQyWj2Zmi9BG?=
 =?us-ascii?Q?7HkvdY9w7xYb3SzjNo/715hzajlupsMHLaMoOOHI1F/+h8tiv/ldM2FSDErf?=
 =?us-ascii?Q?50JChmT5H1a3+x6wtTxlgYP8MKC734EZ0v+tIDOYOn8uaiIs6fuzdc4uBW8R?=
 =?us-ascii?Q?eoKuHldCUihbQyL+fjJjM5GA1+QHwDVaFcsXB+XBdQAEtCrrCCtu3RcrdgBn?=
 =?us-ascii?Q?f+qKUNDdpl++Qm/BdgyZQHkpHj1+SqdMXZrNaLL8lTaX6gSJjlqOpZziG+mK?=
 =?us-ascii?Q?HvLuz8NmjIlXQJ2X7HOQ966q/3HUnZBUMzmiH++D5vtwYY81uzi6oDkF/Gb+?=
 =?us-ascii?Q?D6fZ2Pckm9gKYViFwyU1Fk7axnVghFcGsr5GczV/C1wX+6Kw6Yv5a1zgltw3?=
 =?us-ascii?Q?he1IE3Sz4vtXiXxgDKUOgeQtvbTqYIIIyBVHj8a6ipGkOuzpyHx9KFY5rPPJ?=
 =?us-ascii?Q?31qMf/ABYyYnAeLa8DM6v8/GQsoSGkc1jHNh1vO+0QroqJovNjM/eJdWd9AX?=
 =?us-ascii?Q?quw0xP+qyd8W9iBmyTT+wyujsCXd3C0N26/9FinRM9GJCiz2SYgdBYhMzfnV?=
 =?us-ascii?Q?UNMP8rHUpv1h/O0keiXboF/x+IM8nObRjxDu+3+9wf1RNOLUPawe7BFrvMHG?=
 =?us-ascii?Q?jJM9EVpBjsjOmnBh8bOUTYA04iTD6zBAgQJ0wzvzls7d/pyXG3L2gJ0ln4q4?=
 =?us-ascii?Q?trieu4teYIklPF6wa/T6Gi8JnhmGU6bmg0M840zPoTzSpFuO5NJtZ+JKz2VZ?=
 =?us-ascii?Q?9+5CgkaGPhTIZf2KjRU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fb2a762-087f-465b-2b45-08dabcd3c459
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 13:11:34.6520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gNFD3BiS87BF7Mv1Z6jCoBXx+zzu0CFSJe48EsqwEYBC0zAcLd2I0op4PplxXzBA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5294
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 01, 2022 at 12:17:29PM -0700, Nicolin Chen wrote:
> On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:
> 
> > diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
> > new file mode 100644
> > index 00000000000000..27cbb652ee33cd
> > --- /dev/null
> > +++ b/drivers/iommu/iommufd/io_pagetable.c
> 
> > +void iopt_enable_large_pages(struct io_pagetable *iopt)
> > +{
> > +	down_write(&iopt->domains_rwsem);
> > +	down_write(&iopt->iova_rwsem);
> > +	WRITE_ONCE(iopt->disable_large_pages, false);
> > +	iopt_calculate_iova_alignment(iopt);
> 
> Coverity reports unchecked return value, perhaps WARN_ON()?

It really can't fail since the new alignment cannot increase, but OK,
just in case.

Jason
