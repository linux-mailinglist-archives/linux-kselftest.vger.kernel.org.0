Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D549A61F5F8
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Nov 2022 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiKGO2m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Nov 2022 09:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbiKGO1s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Nov 2022 09:27:48 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA026C;
        Mon,  7 Nov 2022 06:22:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mszigofpctcsQJW4/5/c9dT8/q/93cKReoaCC5vcF8vp7IF9eY/5+m86o1d1OWrZHhtgxh8FsWy90rrO2YOgXRcfzGkVTav33eRuxUnCALNpbZf3gcdroTzZI5yx7RGbSD8CkEOzJTc7pjLKCUJUuPfP+UT8GDenaL4zhFI1uWvysrldxNXduGsJGqV8wpNCIwkcQcXyVC9SV0Uys81PEMtQ0gWucfOhCKgzETvABU6BFdJz4aDOSaGTRcq5bN7G8FH1OSIWwWGk7CXstePJZO17l9YgMXOJl/FlgUotoguSTSzPdEk3tK/s+PCw5BjpYCKN03tlx+8xjD60DE+YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9gDiS/6kxpQdRLNP3zKaMUPXYGbn1G70pfZMF6dAKg=;
 b=Xh4qAqe7mBiVCF3FW0C3BXxTasVLbEP2OdX1p0p/2mj550feFJUyyoaALGv7F0JK+cvQsFya3xU5QKpg3xGzadnS1Pzz1LCosJCWLUlSI64///U5x6qfLuQV2EO0X0QDpEt9X0dpDEhdtbDriaHDPfnZYybI0ozPZU7qbT7BZMQOfPtr3kNUzb7rLvabXdtH4/YPsA1vqBP4M95mkzW2W/YyZYgHU5trCdeqt0qevGQR7SmHiGUX5EQ4cssZvc72gkjvzUEAEbDeOOJaOxslxSyKrP32fc2kX41Zj+rSh8xh7DEcX1ZchaQJv4to2QgbGpmxpvsH1PCti/4qoaVBHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9gDiS/6kxpQdRLNP3zKaMUPXYGbn1G70pfZMF6dAKg=;
 b=P0YtFMnDRKvjNPdjsArHwWSUtxE/VCyc+5GNnSEzmVuhIAkXAfY+kulvGg3UvfChVFNUFnDtkXrNVXZytX0nYr1gLfz5AEPXR/UfpC99m9u8exEK3v4EupDrZ7SkArOmSA5B3jfBoabBo0NzoVDXVuW+OdJGpUuVHhze0/N9gS8gg8CAi+tS/yfX8DjOXuZ2vUktxa7z5veZHhPrP36MLx4j9sMN6u1/ZPjl60cfxicXJsqoStsGueLgEX8aceFGx6+UNwwpdQRahuvkpmWrIiqf+nF3FJ6rYkUZPsS3Zu/uiSAtDPbPHhlGu8ZaJU6zJgoZEUWPfVRqL6xRMk/yoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6436.namprd12.prod.outlook.com (2603:10b6:208:3ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Mon, 7 Nov
 2022 14:22:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 14:22:34 +0000
Date:   Mon, 7 Nov 2022 10:22:33 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
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
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 00/15] IOMMUFD Generic interface
Message-ID: <Y2kUqW9e8xQemel4@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <20221104152713.3ae1c409.alex.williamson@redhat.com>
 <20221104160348.07aed446.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104160348.07aed446.alex.williamson@redhat.com>
X-ClientProxiedBy: BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6436:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c7f3e4b-1acd-42ee-e688-08dac0cb8390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Te4F77/FHbMbcrn+dWCWC8bakqSZ4abKsGdqL9wfqVzKnbisQTWDDrqXCzag/h5edr+yNHZ88wT0XY4xK2WWP0s9C4ZsnPM/yUcoLXS2oynL4jZhi5FiGvuLtnVaOThYXc1F/21Z/+daEA3zgjN3lvMrn4raAPjfDVA40YSiFUdfcGPx3rUlRamnIIiwBt12ze1SCpEK8QgZzNIyKVNfKRW39VLy7cNOHR+1yUsAVPUTFCGBKoL7GSUcFEEl2IKeaLU8mk2CTKrlM/pIePUaEIqf0IDO9zU6DzsUjZm316ofF8ZiqsFZrbR2Eo1B2Rzqkt1aolgqtDaKZ1CZgswwWPYilje9rUvYpF/Yv/fV7+Vj0+v1hX4+mkqZjrXw1h0fy7WXZE3HCU70Y5+h9zIIbPGktP/V5Rt44Zftk7TKesBS+Wvp1ULNPNRTNYLpq3S3BQzhVBgMEGJPLHJVy7PFxxQaAvKohoG3sW6B/h+Ok5JeeLLlmmNKOh1nHOwIrQTPhuL8sMxd9+DlJAyelhxBVS4ScpDO/2nll6C09Fj1olR78Qoi994oR4tlnZdSzQ4UErZ4MtNhNRpDxrU3AGKJ9gfDx4dpA8IXLx5dcADoopOtNeAxk1wfgBWum2+r2E5fx3ApCEINmV+wtIuv915KVw9Fu5pOWMlE2JfjlbB+7j5ElAopijBwgnkE/f71WUbQ/SQH8+8/Ngjovp0YRlOscbOWCLBrUToIbGpTcBSsMGrUQXHm+3ZuhCoJ4KTmFog3wtFJow5wf2dJkNUF6b/MyOM5gf4QIDC4PirM7l+rdUL9NVvznyNGbYGCUsvQ5rJXGZZEwQvKI7qeouAA49TcpDdBtI8BgEAWZdf5Q26I9rn9fmv4pef0MoGqecyLmOwk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(38100700002)(2906002)(86362001)(6506007)(8676002)(2616005)(186003)(26005)(6512007)(316002)(6916009)(54906003)(66946007)(966005)(6486002)(66476007)(478600001)(66556008)(7406005)(7416002)(5660300002)(4326008)(41300700001)(8936002)(83380400001)(36756003)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/PS1qkbTKUQZA/HtJYH1/pTkObW8rONpW32O3JHN7SK8Y/zc1MWrMYwNGdV?=
 =?us-ascii?Q?nqnu0FQT3lb/WvIREYJK9dnqm6Qjo2qmcFQ1LBrkyvBzQJw24vRkR1mNUpkT?=
 =?us-ascii?Q?efgd14H6PPAEteP5TAijh8Z+ltMgmfjbjA6JnM4tGKEu1U7rYO+ylcTwaUnd?=
 =?us-ascii?Q?rXmGfMBEMCRhYpGGeyVk2ki5mCt+ak4OBt6/kFAMpVIvXQU2BlZ1x447IgHv?=
 =?us-ascii?Q?D0w+6ONVzGPLz+fl+u5c3MQe7Z2gQAPrx03qiS8meC48Y2vx+fkRTu8HYZBY?=
 =?us-ascii?Q?sw+1Xa5A1JQe94KXtCOa2Foc0sKicXL8Rms6a9REUXEzFmFOKHZ23XAY2Qas?=
 =?us-ascii?Q?Fp9XEN5V+GvHgTnp7nNKGBdIjqKI1tb+5D8mkOkpXaQQTYuDYN9/KzN9LbFe?=
 =?us-ascii?Q?h2xstJlMk34apP/6DMuTJjzGkWyKUms4khd9MqgL2DV35jwCF7GHTdnYmzCH?=
 =?us-ascii?Q?Nba2lm5BYSOKpVc8o3gz1oDEglchRmTsbWdzbCt2NJ8Nqv8bH4He+fRG+ZzU?=
 =?us-ascii?Q?fvXDWT5GADX6ykRAFgFlsnyCF1AhhZtFO/7IKONDfbS/sckSv/oMXnrmFGYG?=
 =?us-ascii?Q?QRch8qnM8eUMtxd9+VyERMI92lkN0IbUc8Q1prPqvLfSEMt6Y79kKUANamYr?=
 =?us-ascii?Q?8ZECkz8D5MN5ikoMJxuFClws+i5V3dkYlgCDzq6g7smRd8nofBoIY+fbs7ra?=
 =?us-ascii?Q?hVvisC3HKu7pYpc5f85Bmz2JR1E2dNywfOse6b0L7RE/CoWZ00q4K74yVZ0G?=
 =?us-ascii?Q?hPW6ympAV8YJ9eqvePgzC1rAStJFNOwdK3oEcb4YiszZUwXirApM8pR/iNgs?=
 =?us-ascii?Q?fVdD+l2GBLGS9aDL4C4Gh4T7vK14hQbaOFt93qqMkm+Y3JphqzTLWqP//4Ss?=
 =?us-ascii?Q?EAPzaYXHEPSB98iUtIPYvutRGmq8/cPZ2xxITDq01BSsmbsdhCWgPOVaGKFm?=
 =?us-ascii?Q?/jTlcbtF3c5I64T0dmIggXGn+OiI0D7KaCCRI15iwdsHFUk1DAIjtuVvVVht?=
 =?us-ascii?Q?K3b/Ht6zNLn+MrjpRIBMtza97LKhHmFQODqRHm7aWD+iQTehdO/WcZeuhgX+?=
 =?us-ascii?Q?pXWz8rJTQjEB22gkQFuIwxC3Bmo4EnVEryRVgphTGndq2atJUNTd10aaM/xA?=
 =?us-ascii?Q?Wouy9ljnCP3TdgY04CUUb8LhsUGPYUfyGlJFZG3Vf2B2OYsAi9eOVg9pySck?=
 =?us-ascii?Q?44MYBVseuJs2MzlRuR0n2s5+/VMGHZY6C8PLvt5YBDCo2qztRnw4FJz6dsVh?=
 =?us-ascii?Q?NxrZMMFaeaYq3tUQXJWo4xBb//BHbq99DJ9Fx7HPL1Zj3AdfqaBsPKBl1zgO?=
 =?us-ascii?Q?5A3AvZCDr3LVljH8wIBE3+EExmCRDtIiV46nG7aLbWrgvnSb2JzrLCcJJ6Vn?=
 =?us-ascii?Q?zMZIN/gp4bXir8mU2wU05w7A9Pr3R7yClzufZeSuTX1fmfAV/ddkOsEV6+zc?=
 =?us-ascii?Q?XJ//JE/1y+zG7SR6YYMTQ0qmjU1sO0JrQxfbyk6gKU502/b8x+AT8sjnF6oB?=
 =?us-ascii?Q?3ACXXimxu28mkOkMcNilMLK0i4iW9mrrrO/j6JV+9pydbUpaw+xNaHaZITUT?=
 =?us-ascii?Q?6nJUsFYvpByGh2z+S9c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c7f3e4b-1acd-42ee-e688-08dac0cb8390
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2022 14:22:34.6894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pwqoshIMUwn3yMMiyACOec1TO5SW7YG13QruI1zBJshveVX34z0e8KQUEA+VmduW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6436
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 04, 2022 at 04:03:48PM -0600, Alex Williamson wrote:
> On Fri, 4 Nov 2022 15:27:13 -0600
> Alex Williamson <alex.williamson@redhat.com> wrote:
> 
> > On Tue, 25 Oct 2022 15:12:09 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> > 
> > > [
> > > At this point everything is done and I will start putting this work into a
> > > git tree and into linux-next with the intention of sending it during the
> > > next merge window.
> > > 
> > > I intend to focus the next several weeks on more intensive QA to look at
> > > error flows and other things. Hopefully including syzkaller if I'm lucky
> > > ]  
> > 
> > In case this one hasn't been reported yet (with IOMMUFD_VFIO_CONTAINER):
> 
> And...
> 
> ------------[ cut here ]------------
> WARNING: CPU: 4 PID: 1736 at drivers/iommu/iommufd/io_pagetable.c:660 iopt_destroy_table+0x91/0xc0 [iommufd]

This is a generic splat that says accounting has gone wrong

syzkaller hit splats like this and they are fixed, so I'm guessing it
is sorted out now. Most likely:

https://lore.kernel.org/all/Y2QfqAWxqT5cCfmN@nvidia.com/
https://lore.kernel.org/all/Y2U9LiwXxPO7G6YW@nvidia.com/

I hope to post v4 by the end of the day (the fixes on are on the
github already), so please re-test this

Jason
