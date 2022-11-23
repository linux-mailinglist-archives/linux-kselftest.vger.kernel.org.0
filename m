Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05610635F4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 14:23:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiKWNXk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 08:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238395AbiKWNXT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 08:23:19 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2067.outbound.protection.outlook.com [40.107.102.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EEE4733D;
        Wed, 23 Nov 2022 05:03:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CV/Tpwujk+32u4athLMf1lpfjw1phLZd4zIT2fL9aRDtNIVnYMG/ZTuSDbV8tlRn/mzeXYVE/Zsl3zk+UWR2AnLeFWttt5wLnH0wVQ5F4J3V/XpfdelnA2jzQMioRPvT/TIM0xAf7CLm2nC0TVjKu3inMpmo3tBYHxvEBNCD5AqkXpLttsMEQN7gdzsOXv+GoWtHBrkWZz5gO92lkWkHsNehoMVA63y5t0AcmHS0vSajWt35ZBGpKg5wso8EqPewBvEP8+8UQkL9zVyP0ixr45+qhz5I0h02B//qe+s687c+7q++siFbVEY41dCbz5aeoQOS8xG8GACdDlLxke5j1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iPPVb1Z/5lQGck2N/JEfzyRg1bfeLV6ckiNRSpSgnl8=;
 b=jmbuHZUtaibEvFj2FUrUJA3j6SW+HFnZX/aO/f5tzxUSSowRrtQLUb0apwZQOL9VEgSeb+RgnhIt0Q8lbWTFihwcTqtdFeD5K2cGYJjeuK/B9qceJfkCz7YyqaBlKKwPg9FqWe92ZOyrQjeEvCYETVh365csi3aMSSOFuKVO9nULA0Z+GCGjvuQoQcuDT5sK3pNkqXO25wAdP+bLWJVFoYdj6NFpgRj8BJLOok3lmyCz4uH74fvS5ksj/EdY5KctToYTa/emBCngjY/Pk3yazxwLICKuntO9TuM+WbkxrUFJJ5EXeYRXH62Zuy7/DKS9z7uuY4wPf6jxabNElwN78w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iPPVb1Z/5lQGck2N/JEfzyRg1bfeLV6ckiNRSpSgnl8=;
 b=as2yB3xFBdKf8s6RCL2czCTJAuzPcu1bKY8OHpl7B+pTnydnfcWTKx0pX0PzQYy1OkMp1x75t9pN/bMlb441af+SH/Sl9BhSJmRXhOsJhpQmnUVdrTmZaLx4S+ZaadU1cAHXVGx24lUkASoVy3RUFOvSqImW2w5Vzdi8vmmVEpIaFp3eHHioVCpbmZSfvvDGI1UXd4g48p3l1vOsmaqijouV1EhZ9XREXKga/ufuPHudUciG/22OgQevRLk8hDExpOLM9UmE91R9gwjqKpvtTH775++bGU0MBxfsjW1sxKFCzNk1lUbmMTY5y1S7s3dpmN5h2dSCBuS0DiKSpkO9OA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5318.namprd12.prod.outlook.com (2603:10b6:208:31d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 13:03:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 13:03:12 +0000
Date:   Wed, 23 Nov 2022 09:03:11 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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
        Anthony Krowiak <akrowiak@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jason Herne <jjherne@linux.ibm.com>,
        "Martins, Joao" <joao.m.martins@oracle.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "Yang, Lixiao" <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v5 15/19] iommufd: vfio container FD ioctl compatibility
Message-ID: <Y34aD4TheDlxTGbt@nvidia.com>
References: <0-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <15-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <BN9PR11MB5276B0219008568A30F5A4738C099@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y3ejMSTWvJuELQ7K@nvidia.com>
 <BN9PR11MB5276939555C1460EFBFD15A68C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276939555C1460EFBFD15A68C0C9@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5318:EE_
X-MS-Office365-Filtering-Correlation-Id: e4ee93a2-e996-43ac-2fe9-08dacd5313db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MFH4AnygVw5yE/Io7Dnr4TBJvziIgYJfMz+iujpfZrhsi+D2jP9QuPVidkxDnLAWtDSOhEpZfXb0+MFKvkVcKELBx4SxorPhj8q77LdIpJ4ADi4SH4IpZ9zHGbTSMNHKEidpOowHLpSvYzzP6USOPsFAO/Cp3tc3qIB0sdggnTb1V9Ku6COafqlXe4dnld1fM4eHwo58Z9IQbiVNa0HeZf52O5C5ZRKD2KztI0N8mLLI9mFqefTyMvJq4f1zDZSYsa61cqs8Frnv/SPPIKvJniTYPRa796Cp5zQ27G3G/X50FdYqX8fw8K5eaqaramc8YdiKFp4PooDDAxv+CsueqTIegpyZM85nn2WWBkLW8SD6Xkh08UuFVtBZwA3zogwbnGy9hNM2jZi8gmdoNpho9+Yd64+RXsRnRSLrOtL9ZkO3QClJim8HIJIxBgSpPAu/+IMhVKOclddVGShiFCtpoNeHUhILGrMOOgDPCb+bvxxdKnw332nyPbrHZgCs7ZSoG2TypTgpL+kUt30bBqhzN5YCMsff42TnJemeUrRYW2Z22yiP89xdV3F5sgBvFrHdFubNbDPTfhfmJkZplVmtXeG/7+IdK9CWxIRyqMClhEDg4N30Sr2XuKri8rczeciCQcVQujNHyT40oZ6pJTfg5rgjxVp80kXPetVtHVs8SHf3F6SAlD2eBhWYD9lDP9HD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(8936002)(5660300002)(4326008)(66476007)(7416002)(66946007)(66556008)(7406005)(86362001)(41300700001)(8676002)(54906003)(6916009)(26005)(2616005)(2906002)(6486002)(186003)(36756003)(38100700002)(478600001)(6512007)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dr9jLZyfCfytEXDf60LaFBBsUzad0cKB+hS5KWNxnoWzmCtfiJmGgOe2sS3z?=
 =?us-ascii?Q?jgwDqxCeL+gtPaWGQK414z/N4pMkHCs8LQKsSezNkgcuLb4swkpMI7wGjd51?=
 =?us-ascii?Q?M0aTJOUeJ/eNFJ0e9J7Mf563ORZh6wnNXn5vf6+qj0EfXznhbqc84XXl2pWU?=
 =?us-ascii?Q?CqYq0rjKEgV8+hfWQAauOFB/I9PaOTSKgyEY+WSShv5FjuIEVEXQYGcZlcAG?=
 =?us-ascii?Q?0WZuF5P/lP50+zTsjlnj4wtb0gk5XTsTHlIEPiMsuS+NNSGCxn0m83PBjKg4?=
 =?us-ascii?Q?fHl2Vd4ye77OkCRNupUC6k+UgVSqINOykD0MkcHm0U5iKggQirthawcVau9y?=
 =?us-ascii?Q?8eKBnhyGQfd5zm0pd5W6P53CyKZUromxx9PSaaGnMOBfLvx6SgTjl5sWo6Cy?=
 =?us-ascii?Q?fXTuHs7l0P28SAyvWdE7vdVZkIWVjOz+pYiQ58PdyYjZmrPGILUg6tUH37dh?=
 =?us-ascii?Q?T67qKfHbQD2ely+ennPRT1M4vIGJxklmBKvOKAw07IEtErxN7k2YTNv/HAR9?=
 =?us-ascii?Q?MHlKDoQQbd2Mcnd7bt9Zi82khnCX9Aq9UQvTvoswvFFKDJAIK32c0w1MUu1c?=
 =?us-ascii?Q?GCWem+GTrAGKaby6c3ulT4ORsIa68y0wfNKNrn/7sALIlCiRt3jmY31uWab+?=
 =?us-ascii?Q?SauQbk3qy5U+kqa3K6dhbkPIQwtIAqHr/F0MvF3Xa86lXOwWC3+9ZQeuj+Bd?=
 =?us-ascii?Q?a5MN/TMBan8H/IP09fjpoDMVvNvCno/7GqG2GBnckeDAF5LCOH6jupoSioVA?=
 =?us-ascii?Q?jlQyt19BN64WHJGE7wdO3rLFuwZVY6cRzROrBLPOzM8oNV5oGNV0bVGGiiaf?=
 =?us-ascii?Q?pzDDniEWdMmpnb+G9MnTTh8LDx8lxyISmjSbcXVRhGh6wv/+4HQsfTK0NHXk?=
 =?us-ascii?Q?7KPacHb8FTUngn5zveGI3BpccpoV2qm9lu1Zx2bwNl4zPk7Rl2ZRKsz7TtQA?=
 =?us-ascii?Q?PcVYuw1unxv/6LDnrEelDoJpaZ8ntaehFcKWXuSDKoi8U/oEyE8+PcN1CTRP?=
 =?us-ascii?Q?cXekM3yX8O1u40mdzoU92nS/goUNOUKqYmJfKtELZvDA0hd/hrH0gYpArCn6?=
 =?us-ascii?Q?GLYmXrPhy8+2aZ67/72BxLjeAt8j0PKSlctm7PkQvsIYc3uIMwHPjgqqLT0o?=
 =?us-ascii?Q?K4j6sAd0baOlRHMoLUpL9lF+OJUJ8IC+UEoUA0PjXgcut8k2hmLBhx1RuOkn?=
 =?us-ascii?Q?f0Y84SjUuA2E9ZGqa8f33CCwbGOmu4S+EKoQaNAUsP+UMGlcP6F4XSHyjVWM?=
 =?us-ascii?Q?Sx9jTRvkkdROBNzvTpzJ20GSpoeItJIAcKEo6A0qeHVFPM38ohCoJnPmxS8S?=
 =?us-ascii?Q?+2Y7K6/fb3CBNet9vSnu4xQtOryVJdcbMbYfRroQ8JUsLIdUyomwAwxGwl60?=
 =?us-ascii?Q?+pPxKaCad+Dlxd0pM25+BievpvVT2WlrCoYoY7dX957yQaZ4dgZ83NsWCFPT?=
 =?us-ascii?Q?xSTrvg2vYySOwD66bvEEB8xVVgyWH8y02xfE2RdSwyNgcNvLsLksP64lnlnP?=
 =?us-ascii?Q?qF0Vb4qHLGMC9UR9jKLmKjykbtsckIWjw7PHzWK54f9hH++Q2HBf3gp+OtPY?=
 =?us-ascii?Q?dSt/1+7dUuJCmrpjEnI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4ee93a2-e996-43ac-2fe9-08dacd5313db
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 13:03:12.7488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WG6MA2rPfh3hY2c1yHCUcSq9pmHouf7RtgsXolU3coKFj9vFY+Z/FlUHeQ0eOJWq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5318
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Nov 23, 2022 at 01:33:22AM +0000, Tian, Kevin wrote:
> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Friday, November 18, 2022 11:22 PM
> > 
> > On Fri, Nov 18, 2022 at 02:58:49AM +0000, Tian, Kevin wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > Sent: Thursday, November 17, 2022 5:01 AM
> > > > index ca28a135b9675f..2fdff04000b326 100644
> > > > --- a/drivers/iommu/iommufd/Makefile
> > > > +++ b/drivers/iommu/iommufd/Makefile
> > > > @@ -5,6 +5,7 @@ iommufd-y := \
> > > >  	io_pagetable.o \
> > > >  	ioas.o \
> > > >  	main.o \
> > > > -	pages.o
> > > > +	pages.o \
> > > > +	vfio_compat.o
> > > >
> > >
> > > move vfio_compat out of core? it's not required if VFIO
> > > is not configured.
> > 
> > We can, but I don't know if we should. Compat ioctls are part of
> > /dev/iommu, and technically have nothing to do with VFIO. A native
> > iommufd application using VDPA could use them, if it wanted, for
> > instance.
> > 
> 
> I'm not sure whether that requires further VDPA support. Be safe
> I'd like VDPA to explicitly select vfio_compact when that new
> mixed scheme is supported. 

It doesn't make any sense. The ioctls provided by the "vfio container"
FD are entirely up to IOMMUFD, it doesn't matter what the consuming
subsystem is. Just think of them as alternatives to the existing
map/unmap iommfd provides in its native mode.

If you want to disable them is a decision that is driven more by
eliminating the code from the kernel because you know your userspace
doesn't use those ioctls - which has nothing to do if vfio is compiled
in or not.

Jason
