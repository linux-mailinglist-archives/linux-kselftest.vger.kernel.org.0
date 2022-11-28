Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0F363A958
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 14:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbiK1NU7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 08:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiK1NUd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 08:20:33 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD89913D29;
        Mon, 28 Nov 2022 05:20:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k0eeVshzzvsCsZ1yCL2Alb5GiGlmL2cfr5qOggH3TsBKDxUpXYk7uSGHNDsOToUf7Jyx7RB0u0sRCUg+eyFByhfODpGo8Ign3prxvY86MdaWPxERKohvpjk09tdnquI7jHwsQfwuMCeE1PkqxxWZQ+TPnf3CPzvF/XkET2XwXUUQpJ4VNeATu94i+8jNz7LDF3Mv1nTOwtylmKvJ6ol71R5dOienfdxxG+VbmKXDzAUKPiMz0wG0NEnM+SqnEK2kNki8HWSb8Wh9lYi9Uy7C7aXQBpBwUQnGP+TQgeoqiL8KTQQ7kowwNF6moeDlTTvAofToeZtnJKLXcjy8DAzNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRWnvhGlHyeIEXXDUt4pt8I9hkwiCOSjvvGKpliGi8s=;
 b=jEUa+90T3hpeDBKET+bwN26lJlPN3RbzSqMkKp7iaklSIG3bHyS1hl+BO7wUVyc5Hx3duUOtyQWhpHgz2JWJlKsxetLaBCa10F/W9PWUX11N3ACQ/4bymV4WHCQ46kmwrR2w9l+J9jCQEhOTufunGt7CSb2b7Ms3ir5efeo3m2FNM6GBIymp4Q7nGmlWrzWznLcRQQZ6e0SkcYQLm2qYc43tW7VNVl/d5bTD3tj2OdR20SpbwlldxiCbMMViRe+iaXbSdUCdgyGQFgg+yBcIVr+Ncg5uN1d63wTUaicZZHpkYPezapTr7zzPmLBmbR6Ht8DZ++l85wkOFSY75LcCgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRWnvhGlHyeIEXXDUt4pt8I9hkwiCOSjvvGKpliGi8s=;
 b=Lj0o9/a7omQBuXcUaS0pggZh2nYCoxHYcvBe9F3HlYIAtmw5N7Hs/bbrPT3Xv8FBYwPzHe83lA92Bl22bd/jwdSx+tzroIUn5DqbwAsi4juF9945RVCO2Mj+1wacScVf8eWGPBruv0zlCYHOJiP6BHxOzFPehV/VM+xQMJ/uZibl+qaGeIpjFAEbNVNZYKce6y/TBntTxws+6NvzoFjjTA0rR2r9FuZwSjDjBehYBAb/zebq0TtP1dImHCPJX95UraBvwOmUhEMqbKahHYsNjxHVq1GoJYtTJ5gfMKC63vNMAYDmjDUVSIki6VeD2ot3tlHWmh43Ch5wapmEIhzzIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BL1PR12MB5159.namprd12.prod.outlook.com (2603:10b6:208:318::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 13:20:07 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 13:20:06 +0000
Date:   Mon, 28 Nov 2022 09:20:05 -0400
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
Subject: Re: [PATCH v5 13/19] iommufd: Add kAPI toward external drivers for
 physical devices
Message-ID: <Y4S1hYFm9HaP0KdR@nvidia.com>
References: <13-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <4c429c36-146e-e2b2-0cb4-d256ca659280@redhat.com>
 <Y4P9VzpCv/DyHeaD@nvidia.com>
 <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94e6034a-c4c1-be0a-ea8c-f5934dbadd4c@redhat.com>
X-ClientProxiedBy: BL1P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BL1PR12MB5159:EE_
X-MS-Office365-Filtering-Correlation-Id: dd826de7-677e-46e7-061e-08dad143445a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eKLs4SujOSMQ7uAXvSEtI29HfwfzxX68UwdBZfsZ0e32rUWhSqpDzGTCTCwtCWqEp01vak76SbsG2FA3O2Pdi8ffdq8tB6ZkS4J9rTkbyG4KQuDKgmCPWe01MRXcSlvsWWjxSdqm/XfxM3LVkRGJPXZTUxZzHB6Jd1WWonrMjPLRXFrEHeD7B6E1PDotGlDMmCXn3JMhbFIveM5Wym/YFPC6f2yDKBysRGREoCicJm7AgA7fAvT8FZhngS9D7v6O/JDMnTeRtgi0mS/ksWRdyD8JzJD/EHIR31KZW12xlYRApuXYbz4UQW3KlqjhZj9chx7dDOiwKddR5VNnn9JO+dYE7VY40yBOZgpet+UUhBpSadUPYYR13qsRB2zVrFz3VgijBPTy0xKCHbkfxQrD2ceYfGNdDjaMw49vPxzWS7tVkrpamonP9V3fuATFOh77LHWY0FKeTVIKsyMV49+ee6QD97j6J8BG9JFZiWBiTtaaoXZsQi0RXTc/P/ndRnNRoPUlbIhrfOfjNGVc1ZU1OJK5obLClLFMbKU5kZsvmVdsEPJc3gB3eSCFrP8e7/+1epI95ef4RuwQN2MDRet40xUk7Jj0d7c4Qlosh9dHZujWSN2uwdneJfRY8BffH+6N
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(39860400002)(366004)(136003)(396003)(451199015)(86362001)(478600001)(6486002)(7406005)(7416002)(2906002)(36756003)(6512007)(186003)(83380400001)(2616005)(38100700002)(66476007)(66946007)(41300700001)(6506007)(316002)(66556008)(26005)(54906003)(8676002)(6916009)(4326008)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?A1ZK9UnnXnl5KOzr2RWTYfmFUoyKEjPj4Xy+raNjpSq9us3L5uM2nDZVhmKk?=
 =?us-ascii?Q?9TjMUCYRkSiMtrRrIRKsFV/QVNN1RtHIo2XVgz0nzEineZ/+/g5V6Fgy5Ym2?=
 =?us-ascii?Q?qviTcIuMI4FGguT4srJKAb/Br70PdYCi0eQFrvXQ+drWUSMGW5Xr7DNDCUAQ?=
 =?us-ascii?Q?fnnt94JzBUC2iZyIvspbMUzefMz6YjjyQoV3Ie1zmiwZ/qkLSZnG/QWnDc9c?=
 =?us-ascii?Q?wU4xKhbGC3jvONzPtIziKaAfr93QAs3PbXQDkTzeIE3rZCII+FdIsKYKwTfE?=
 =?us-ascii?Q?sgvjZeQpQcviFSfXTVTtaHaXnMFbQC9IgRbkDFvaGNLofi1wDqjRpqSYq2QC?=
 =?us-ascii?Q?nasqwIb3CSYkepw8MQHe5DSTGlrNtHpD4ImzifVMeBfA6hArXQwiKTUy2Gzk?=
 =?us-ascii?Q?EdGvfPPRK97mGOb0ZgzDE36ptMZKIi0zQn6ZzRKjTigRnnivXdTZhPimcqAF?=
 =?us-ascii?Q?kCZWn8qgK/+lGm9c3dBSVpZoPRgvSkagBab+MWXuOX2VKgkkTeZXGenGzFwZ?=
 =?us-ascii?Q?H5zHI946UcOHGYtav7oYT3WI9iozUWXBcw8hOmm5Vhisk+qoI41UX+eMD6p6?=
 =?us-ascii?Q?5khomKHn3dstxNR42Po9YRhNrqU6JTDTDwn5RTA/qwsVwE66YQzfieMnMHyy?=
 =?us-ascii?Q?dBQ7Tb2qDbip8HYIJjhwMrpiW72RQIZFLHhyYJs2Ss3V1Ej2EqFgF9rKOpSo?=
 =?us-ascii?Q?LtfIrnpyBjaN1l8wYz4frilaZfHZbvlC1pJQGfyJRHpZY+jviE1fRMuletMi?=
 =?us-ascii?Q?y3sL/NzK8eRwgsGGH+McgQCeut46zae1OVR4rqiKa3mlAgdBjkLt+Imr+dRL?=
 =?us-ascii?Q?sKn0/HPE/1dUq6ci1m6CownOi3V8T49DGS65ll5IdNV06QxH/cbGKC1YUgZ5?=
 =?us-ascii?Q?DAWQf28MR5Ex7xTDAgOFYB/6odhti5XuD3hF8SqjbgLYSfIHjgD3UwEXP+HD?=
 =?us-ascii?Q?iwwoZ9cejcQ6m59QHHZPExBBow0NZooA4HRttAX03+obmEZxOB8sfSOkYt6G?=
 =?us-ascii?Q?/Wu1ZMKxWThscR026jsL0hfBgsjblU72nxc1me2klymbCgntWWOHjbu6rL4w?=
 =?us-ascii?Q?s6iYS/AlDZEejmtIl3BIgll8GowCM0UV9x1S3wX9/9wy6qWqljqubPRYnS5K?=
 =?us-ascii?Q?LMp8eSGeVwiDriAvSC+4NIrFedziNDYVIVDSSDs2R2CAJ1kUSti42PijIlsi?=
 =?us-ascii?Q?h2GsaZcjyAjW8YAWy4tFaozPkNlpkoPWIw5m90AuoIeFijMrt5CNIquvrg7b?=
 =?us-ascii?Q?/vP5Ag8dfOt46M8pSLRQGfX/QJZ03wM674WFYwij+Gfc2xuTCycgMk9JA1GQ?=
 =?us-ascii?Q?3dAhK+4tqJ9HGOJtrFZ2An5EZPiPlE9hIq3T7Ft+fBe51Q6UXBK/SmlehxHX?=
 =?us-ascii?Q?tzreYp9qxJ0JneLYJCftmLvawY4KSYBOoV492mVFrQp0PcfPZqc/Np00UwT9?=
 =?us-ascii?Q?PVPjz451qVarmELpwZiLTLjaNjsQ+vMdMPSkhFnMcZCetXzei9egWiN+Q7l5?=
 =?us-ascii?Q?ei5LNNlGN4HdhqTE1kRHqqdtCt42ytbueEaIoDiLmVMRSxzWKN+OqFtgAFMq?=
 =?us-ascii?Q?iHAYkV1i0EcYuvQvFZU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd826de7-677e-46e7-061e-08dad143445a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 13:20:06.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCNm6OAoQ9ijBaji6RI9OBFqTDNtyHOaDFy6rO+cNkl5i2R7ugolbYjsrVpt/U5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5159
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 11:55:41AM +0100, Eric Auger wrote:

> > Not really. The name is a mess, but as it is implemented, it means the
> > platform is implementing MSI security. How exactly that is done is not
> > really defined, and it doesn't really belong as an iommu property.
> > However the security is being created is done in a way that is
> > transparent to the iommu_domain user.
> Some 'ARM platforms' implement what you call MSI security but they do
> not advertise IOMMU_CAP_INTR_REMAP

Sounds like a bug.
 
> Besides refering to include/linux/iommu.h:
> IOMMU_CAP_INTR_REMAP,           /* IOMMU supports interrupt isolation */

Documentation doesn't match code.

> > It doesn't matter how it is done, if it remapping HW, fancy
> > iommu_domain tricks, or built into the MSI controller. Set this flag
> > if the platform is secure and doesn't need the code triggered by
> > irq_domain_check_msi_remap().

> this is not what is implemented as of now. If the IOMMU does support
> interrupt isolation, it advertises IOMMU_CAP_INTR_REMAP. On ARM this
> feature is implemented by the ITS MSI controller instead and the only
> way to retrieve the info whether the device MSIs are directed to that
> kind of MSI controller is to use irq_domain_check_msi_remap().

It is important to keep the Linux design seperated from what the
architecture papers describes. In Linux the IOMMU is represented by
the iommu_domain and the iommu_ops. On x86 neither of these objects
play any role in interrupt delivery. Yes, the x86 architecture papers
place some of the interrupt logic inside what they consider the iommu
block, but that is just some historical stuff and shouldn't impact the
SW design.

If we had put the IRTE bits inside the irqchip layer instead of in the
iommu driver, it would have made a lot more sense.

The fact that ARM was allowed to be different (or rather the x86 mess
wasn't cleaned up before the ARM mess was overlayed on top) is why
this is so confusing. They are doing the same things, just in
unnecessarily different ways.

> >> irq_domain_check_msi_remap() instead means the MSI controller
> >> implements that functionality (a given device id is able to trigger
> > Not quite, it means that MSI isolation is available, however it is not
> > transparent and the iommu_domain user must do the little dance that
> > follows.
> No I do not agree on that point. The 'little dance' is needed because
> the SMMU does not bypass MSI writes as done on Intel. And someone must
> take care of the MSI transaction mapping. This is the role of the MSI
> cookie stuff. To me this is independent on the above discussion whether
> MSI isolation is implemented.

OK, so you are worried about someone who sets
allow_unsafe_interrupts=1 they will not get the iommu_get_msi_cookie()
call done even though they still need it? That does seem wrong.

> > This was sort of sloppy copied from VFIO - we should just delete
> > it. The is no driver that sets both, and once the platform asserts
> > irq_domain_check_msi_remap() it is going down the non-transparent path
> > anyhow and must set a cookie to work. [again the names doesn't make
> > any sense for the functionality]
> >
> > Failing with EPERM is probably not so bad since the platform is using
> > an invalid configuration. I'm kind of inclined to leave this for
> > right

> I don't understand why it is invalid? HW MSI RESV region is a valid
> config and not sure you tested with that kind of setup, did you?

Why would it be a valid config? No driver sets both..

HW MSI RESV should set IOMMU_CAP_INTR_REMAP like Intel does.

irq_domain_check_msi_remap() is only for SW MSI RESV regions.

This is what the code implements, and yes it makes no sense.

Jason
