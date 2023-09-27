Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8947B0951
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Sep 2023 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjI0Pu7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Sep 2023 11:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjI0Pul (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Sep 2023 11:50:41 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A0D2728C;
        Wed, 27 Sep 2023 08:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QWMMvEN0TATzS0drA1Q2hvMe7PBGCz2DjGQjM+RhYBHIpMVjZjsm/2PUBiIie8np03PigNq7sVDq9p7FPo4bChC4rYqD2AXW/HNlwnrCgpQ4nkNhMKLxRHmWc/XJ5tGCJ8KuX6Rr0k1T2TRT2AeDgZL/96OuNNylZmywdE5ezonpsi8wfT4lMpF1RUUwLuy0xR+kxvKvpjpjREXCIlCVBN5xvJB15ElheaVsvDOQ1jZSjYSDkVPYe3pXEfWNiIkDMcJu7sgzzH/GBWfGiF9FMxBaFZIz8lbjS6Tq5M8/QRfszBz+WNbqQacP7pRdeyIxn/IAaqFcG5HR1s3MV2Qvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0oHtPCbD1zp6wtFL/bzCcLwZqL7mn3v/WaUNKgEpAk=;
 b=kHX/6I1yHjSdlguP+JQmgbw7bBS+tdJDyigeN+vZYWWC7OZoU9CQFh2avVHCQ8fj+Or8qCA/zq6AX4w/+7NskGuWPD7Ho5Yeg2Ut+AMSW6mjq3i7Mg6u/LGf4fgwS5UUMdNgin2i1ybnIyunMl70Vv20jmlVgvH5wL4duHZff/SHduS+P+MUjQnK/yMaRwyl/aL/IoV4F9ShOmEsotlVFAJNxJ3lFcKQjEytESyC1f9oUVNFWzyvZWtU1m+am0V/Jxmm7mirKt79heKlfAVb8A7AFEiWfv5BBf3jSvvugKM9r2rkTyGxZVivWXuOJjexZ+Tt2r/6K5ZNEKFselv/9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0oHtPCbD1zp6wtFL/bzCcLwZqL7mn3v/WaUNKgEpAk=;
 b=kMmgi04M9s7l++7idZowoYlsI/fbDe/+bNaMs+99zS1mR94VyapZKZ8Jzl7AGNtSvwklBJfKTzIM2G6FV7yTiPeUZ2cvsWPCsPArF1n2b8LzVCQKacP41N1+rj2qhZl3pEgJ63VNzTMPo/z5ZXGlOz+Q524AlqIZunnFqvXPh/0wmj+B6lO3mYk9Pp4LMwzgPGUbeU8gpzyOFQ/nULU23N1gEPpl9rVrFwIyICBj+y2gZMNU2BRaHrGkSXZasyPGJVba25nG5wexAGSTX0iLBWS4mI8/UpKLWggE3dCkJZE8DYRwf6oIOc+kDyni3ZvyEsrXatPjyue1hnhilXbYFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB9250.namprd12.prod.outlook.com (2603:10b6:610:1ae::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 15:44:25 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%5]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 15:44:25 +0000
Date:   Wed, 27 Sep 2023 12:44:24 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [RFC 3/8] iommufd: Support attach/replace hwpt per pasid
Message-ID: <20230927154424.GC339126@nvidia.com>
References: <20230926092651.17041-1-yi.l.liu@intel.com>
 <20230926092651.17041-4-yi.l.liu@intel.com>
 <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd258ee3-52ca-f944-7553-6a1cd01c5f7a@linux.intel.com>
X-ClientProxiedBy: MN2PR19CA0014.namprd19.prod.outlook.com
 (2603:10b6:208:178::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB9250:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7dd0dd-5f51-462c-a8e6-08dbbf70a0ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZhDl6P2vCmQlSVT0Rh4hN6PaPa3EVQ8apIgIdolerQRkkxDItPvaO526v3IC1r2ITgVoLlnQt0Bmhg5xoAijAhHJEPPrHs6tBCYYXdMeq+12o46/r86M8dTgoaGQexq4a2tJQMjqZMdZgRd+OE7ZBm4Ge/ujPXXddyl+sY9ckJai8ExgXOC5I6qa3FCE9dcBGmdQkwl8UQXGl3wgcj6sAdZ0U+IFjjiLNg10b57HxpR9nPRuFz+spMajYM5MshxZJMmo7q4Em7r8DChuNxCsHoM3VRZgQ0GewvBqfZv3aWjZF+ETaZK5CQQY2mHHzZiigQTfs9XRIxwBe9+nt+koAqwxTo9RzB5CRLzSNBKewlF/ORzVMsSZpmrZGBfyFlqtKxCZUMA8/0PenrxYVcgkCFW22ugbC8lVTNR6a/FbAfTNeAq+7G4Br84EMeF+FLFUaNAVxuCUjXq9ZYdnXVQj4v66VGJgq4tjaXHApoxWBzHONS+i+rf08YLbeaXo1G32CIjlZo95knSIGDoJc5zeaM2gedgOT1baE6B9tF8O55aF4oYs8F7m6rI/bBFaV/jZYHD9+5GCsJac9kmvi3dqwUd4M8D67cZ4OUxjSv6GCr3Z76MqA5zn78mTGKKYgeJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(451199024)(186009)(1800799009)(8676002)(8936002)(4326008)(53546011)(6486002)(6506007)(6512007)(478600001)(6916009)(66556008)(86362001)(2616005)(38100700002)(26005)(2906002)(41300700001)(1076003)(7416002)(66476007)(5660300002)(66946007)(33656002)(316002)(36756003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bKeQmKMmNw2DohAqhzbM+DCUbgq2NBhiVhRmvAQXkgh/bkwMZn7luExNjSdx?=
 =?us-ascii?Q?3DC2Hch5CbiYJFrIcS/AMjGht3FZbLigQE4s66bULZr8WXeJI4WE5pRs1t07?=
 =?us-ascii?Q?hkxhwviBWpf+RR1SAXOFu1xQpiju5WVAIsF/+uyKXZTdYB47y/JsaQDSc7wq?=
 =?us-ascii?Q?DCnv5Fd8Av22Kei/X7ppiLOhColkZuX/bdWBCwwEhYnkAwaxDhifZedow35R?=
 =?us-ascii?Q?WOJKXJ/2ZXS341jFpldC7W3Cs004ClEo0X1oPPOFqkC4Od9MOSNbleiOZZCJ?=
 =?us-ascii?Q?IwmvOVe4iUgqMj7opSfEmZ8Rhn1FBB6DRss/OoJ0atHw5WF7Z0MyqcPdEge2?=
 =?us-ascii?Q?PeMBPWpxnrgZzVa1x+C68mapXcmrLSeGmivUxoFh1RTuM84pxc/gky9IYG5I?=
 =?us-ascii?Q?w1/Zmx8eyu2DzBRXHzzHnI9UqrXOXhbsL6oQq9fbMitpno8SaNvPKrKgYdbQ?=
 =?us-ascii?Q?PYr67IZ1S1Mvn0QKoqmZnUe0heLb/BlThPud80S8VYMzzQETqaNKNLksPg8x?=
 =?us-ascii?Q?j0OqX2GaWP1nIMJkMPr7jdMn9UVteOWMfeZbSW0W749rhFYRYmCVZE0/Bl1x?=
 =?us-ascii?Q?c9k7aITsXSgM4oPndyktedXCelJ1s77weudM00Km12LIfVDKtOVvtE0DuKFa?=
 =?us-ascii?Q?67nPJPc5nYUWS1fet9NMn50Qt7WIn8p8anW6u/HNALOGZ4lx1MCsw5pqerAg?=
 =?us-ascii?Q?i1Z+J0Ycazp8GMjeA44MNFc1AAdHlUSH0POBzpK+mQ2hy0e+j3zYpIdML8TO?=
 =?us-ascii?Q?qg0liyc6dzPJi54y83FCV9HvosFSMmVqRqu8UUIBYqrVW8boAHyEl56ds1KD?=
 =?us-ascii?Q?FdW9kGFOPmy57Pfw/Y47DsJgogdHHxrnZO8w3uaqr3MJ0MzHXTU15p1XLIDR?=
 =?us-ascii?Q?ctZOSbzLNqRkrNbsCFwmL5k2I7p6ygzp8DaOVcxSncek0KjJfc3fABDusDtu?=
 =?us-ascii?Q?xsJEeQIX4mZmB8LHwDt6erSMTbkomWLi776yoYPRKq39UmjT8m6o3M2Rg5jB?=
 =?us-ascii?Q?cBNFX/80ABzB8nwBZTiOn3u3HmfYaS2gr/qBtRbExF6UyY9oZUAyjVUFabcd?=
 =?us-ascii?Q?L50RjpLbGtceEQVqkjxFqCZ/OUsznN0wb2Ns0OCQq1ngk2TgFub5RBbygMVY?=
 =?us-ascii?Q?m2Vis0FVXGObnsjqFnUS68HBsk6YB1kBh3xvFcsdLeAmM69DK9zWrMCrw7Ov?=
 =?us-ascii?Q?v76nWTIZizHKzvwy3GsNLFBi0d2OZqa/Zj4JMfiM2HOpm7qd4Yq3t6jVx9Oy?=
 =?us-ascii?Q?Vz8S2SKhQAJ19xfilk+DmXKe7pv9tAIls5GYLh0C+pUOda+WF/n56zSp/V1y?=
 =?us-ascii?Q?8ryo+eBOicAVOp7sb1v7DhTP4RnK63nzy0hQ3uTKaD3NObCpgzg/2wlaQrwJ?=
 =?us-ascii?Q?Pdg2+8aB8tGcfIsWsiM6yWte+hzxC+t4ttXlDpbA+D5CWaapIuXGbfgVPFz+?=
 =?us-ascii?Q?4HY3jsBo3d6Y3Wgd6lN1zlysJ8aAhPQFoHp1NsXoxBocrV2W1PI8kGQ53G2W?=
 =?us-ascii?Q?kXayqY9W9L+x/ctTQEvojHgNB49eKLL+rnE3OYIkleGlBaJRsu0YbNFX7lgs?=
 =?us-ascii?Q?J3rRcPadpYbn6TWTqxMj7ktIJDQBZTD8OfCRChJB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7dd0dd-5f51-462c-a8e6-08dbbf70a0ac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 15:44:25.7950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9eBDkdylksr4CvV9sxJ1lNjbZz7MNAJrDIClKpgYx9B6PKB8t8ok/wEF03suy/h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9250
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Sep 27, 2023 at 10:49:29AM +0800, Baolu Lu wrote:
> On 9/26/23 5:26 PM, Yi Liu wrote:
> > From: Kevin Tian<kevin.tian@intel.com>
> > 
> > This introduces three APIs for device drivers to manage pasid attach/
> > replace/detach.
> > 
> >      int iommufd_device_pasid_attach(struct iommufd_device *idev,
> > 				    u32 pasid, u32 *pt_id);
> >      int iommufd_device_pasid_replace(struct iommufd_device *idev,
> > 				     u32 pasid, u32 *pt_id);
> >      void iommufd_device_pasid_detach(struct iommufd_device *idev,
> > 				     u32 pasid);
> 
> I am a bit puzzled. Do we really need both attach and replace interfaces
> to install a hwpt onto a pasid on device? The IOMMUFD already tracks the
> connections between hwpt and {device, pasid}, so it could easily call
> the right iommu interfaces (attach vs. replace). Perhaps I overlooked
> previous discussion on this.

It was a decision that attach will fail if something is already
attached..

But for this API we could go the way of the iommu code and have only
'set' and 'unset' as the two operations.

Jason
