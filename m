Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8E767314
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjG1RQ5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG1RQ4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:16:56 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A870B5;
        Fri, 28 Jul 2023 10:16:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzwNQXy23fOw5ThNtRLTCQ3/l/rEhjcLEL6409nMbsWeY7iYUFIMkGMI9rjYEFo3YEIUomkoSgLiJ9zSPFu49ovH0ZLY7hR9mAdhj5k69OIWbRWdcDJ+PbdeHvW6BuAdX+WqBUcO5quUCiWDh9akSfcnQJmZhzXN9pU3TOZ3WpqvtslNsZVmUA0HALkg8tTJOF6sDLjQUnWmrRuRfed4vUzngCUQn7yvb7f/bGpZcFE9K2XS6+deolOv/4Y+7u0kThk0im1SFvFyvOoBBvy1r+F+I6K3YfLtoPy8f7mI59Au9yayIcG0tT9ByysScFAs5vVoGqb5LrZb/6sLecH3lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xo+rL2FRDTJ6JU+Q+po61nE7D30fa0gmXmKP4dKN6Gs=;
 b=YqeQPI5aMw5X+w/U2J5S6EOQQDKJKcEPUy1jnT25lDWaPiSAtxzKt++Jo6ds04wzOAFp4H6G53o2IXYRiw8dApQ0DXbXMET+bFuGcTPvdvaCAhulb9A31nGu2fKthBbMkZebqsJ+rh/i5dmXYoj9MxXywrvBlQDLctQxLNWzT9LwzFTkXnc7qZJcQ/odIgqtp+afntQO/SGao7dkO0R6rmz4MCpIUgkFKp/k5jllbidS0hfSMOzf27CxzemYDyb8Cp0EyR9UQM1zi5tKP6WtI3kQF9DBRJb6VENC49kAkH1LObU9HjMqecH/8UgHO8ZC6m2I+DsjDqXkcDpwKyLx4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xo+rL2FRDTJ6JU+Q+po61nE7D30fa0gmXmKP4dKN6Gs=;
 b=fDlWd5LjgRzsZV8YgUN+mmjHDDBrQLK4+piJ+qvdVJGnL0BTizoU6aHVQMO3514nZhTgdFyCANnek7uQjEIv/mko+phFKD+Og3q0aTvjZ1FrqxH0VBW//bvq+GlP9lvcBDs0XD92EIUvkpgo1hmNUcpHClxLXIATK3m/OYX6PG/nsNWVM9/S3glG2Mq77SLcKqTskvPhEzxgfsmhhw+Nr7+EpFVeQSjQlI1pUIrEMKPifpnMqV7f9DE4z8h7JirYot0PFtJTni1AU1XjSLxDN4wyuu07UHjxgqkHcRCgoUYbP2XMkdexdhjJJMVBQsc8LIPWESq90BffSdM6CE44ig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4539.namprd12.prod.outlook.com (2603:10b6:303:59::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:16:52 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 17:16:52 +0000
Date:   Fri, 28 Jul 2023 14:16:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 07/17] iommufd: Add IOMMU_RESV_IOVA_RANGES
Message-ID: <ZMP4AhdE6RaXXgZH@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-8-yi.l.liu@intel.com>
 <BN9PR11MB5276AAD6B3785DC247E4F35F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB5276AAD6B3785DC247E4F35F8C06A@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH2PR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:610:56::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4539:EE_
X-MS-Office365-Filtering-Correlation-Id: b38f3ec5-d54a-4480-2e11-08db8f8e6faa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LB35rtaFvGlc4dxvQ53xX8h2O2i80DJZd5mQ/Mx/PYPjkTPPZjVpHkNzTB6795y8vonoAU0wPlWmN1zmrm5oRTr1+5894oBMsYVOyzu+kK5bCEW1mGcbZqDmdjGV21V6RVQfv4L266kfcgn01UcsQDrn/9PP3q4YjjKcE+73cyq1E3ybshUZpnw5DWiqC+zCtwUohuwO7HvwCV72wIQJcFH/bBTovILOVEm+ckqnLwNLKsFN/GTr/vn/Ew4+2EHomiTUFtHpDT28HthoOFbVTXPRruG6Je5mWxJck1clzg3p13McLcxNCTBoTGIHXOJS5qS2k6OANQjBxMpq+l/jO7Fp2iVj2/nCMa1JZKoEg2j5rjk0sDt2POFm90Kkkxf+xGNcu0qQQDobzMj4VbqPIa+StFWiLnE4FAhTBAXf79uQ7/yVPANTTNenpBJlwku2qkvId8xyex+5jfPDvTFsb+lgmgqakS1bYkYEGWiRjEz5W6+hYN3b+04i6OaYwzI94ldpLHYDht9A2irw2SnPifdCSKmCAY3dlFlAvidZBPrULzScbBm6FK6MHzz9imLL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(39860400002)(136003)(346002)(396003)(451199021)(316002)(26005)(8936002)(6506007)(41300700001)(66556008)(54906003)(4326008)(66476007)(66946007)(6916009)(6512007)(478600001)(8676002)(6486002)(38100700002)(36756003)(2616005)(2906002)(86362001)(186003)(5660300002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZqqAeMdpB3hxnoSlVlejJ40ANiXyRXDxjpUMr21qN1jUkGZHQCGARqxec932?=
 =?us-ascii?Q?4rUREIu+bdTW7eaTYf6K8FqtOBPWoD5w2hhbq0+pM2DvGFc/RGn0EOD3GZGz?=
 =?us-ascii?Q?JBYMBiFjUotuqXlz4AQeceSGRiGnZ8hoT72QViDO2AwuuHtxmR8OS7LclNa+?=
 =?us-ascii?Q?FH4JOqlvBitEN5EL6ZmITeGvYZSFub9p5yjdyVU7ClxqU3AAb4OScKElUah6?=
 =?us-ascii?Q?an1zs1fwJ4oTA2cvUkgifcTlzKPMPFmjj6pn+sXAuGJpWZulGX8p86F7Xb0c?=
 =?us-ascii?Q?oM4yerSUkYToW0rvmGltS5IE3mM+DJBA8uDqXHdkbVG5fsNSHppAYE5t3iqW?=
 =?us-ascii?Q?DwivSroCm6X6QrWddmJyT/tmVY/T1Xq+FjN4tWlPoDMDzsV7fammwMfkLV47?=
 =?us-ascii?Q?ydcFEvRE2+vVTImlpVcQUXs6aWcIZJ+k1wtUlxJKBHv0WrEUq3/eIAiEc/oy?=
 =?us-ascii?Q?mgwO8d8b0+dQPRXpZmTQawCqK2VWoqx8QQS97eQ9hI58Gt4s33JGC+fUrefm?=
 =?us-ascii?Q?V1tw3O+UKHLxVrmx2ab5xdI2KypfwK4JGOwwHkjYE5sAL+ZC/a+5pyj45BbQ?=
 =?us-ascii?Q?65dX/I3fNhtEE0T42KpQP/OVXTGzC2zGBBRGXwXUe7iNT/w6Cm35OWTSoQqC?=
 =?us-ascii?Q?ls+t5SA1RGzFM6ZmfrjGB0YskHOcuWelUKgdrIYlm/o9uDnI4WJUjw5CZOKy?=
 =?us-ascii?Q?dCsULCvO+Vs0nlIvgnMbFixrWtKLT5kFnQlh/K20MJmPFcmZu+PneE9BkTkV?=
 =?us-ascii?Q?3ZbrZSZmVKYp9VlZztFuCu2nl5oCnI60IDDR4E99uhEvbAuQxTZOVlQqT2d2?=
 =?us-ascii?Q?BGxOSh0Mqof+v//K54+GEFJyEY7dPpwMdhu5ttB453fpJYQ4PutaUGUFjTxr?=
 =?us-ascii?Q?EDcQ38xOqjVLUwxtdOkCWAMDS9fjWOs6JzPNspUtg8Usj7TQGZJWOQMjkPkH?=
 =?us-ascii?Q?3eMMP5qf5PhsH+5Sz/oihBh+RFQQ1xRl+xjkxyHVjQlL1KjuqtZy393ld95e?=
 =?us-ascii?Q?+8sVPwHIkE134r5KcyUe2dV1GZ+XJd1HxlCjmEZLUlw8Uall7CjuI7fqlD1I?=
 =?us-ascii?Q?K7Zg75vww4gkuxhf7FV62+hKb9+cBbMZScI6lmnHCfCyncX86g7MRAHKNK6H?=
 =?us-ascii?Q?dLeMiCmtWu//ikmpnAPluA2sEjl53DQ767juutmS0u6Dq5JrMpPlD/YiUc/0?=
 =?us-ascii?Q?L4DvHg5BZf1Hu5C+3GnNhJJM5G0oWCnoCqDT8Udbje+9t2tMbvrCdPpAhCWT?=
 =?us-ascii?Q?72zI3l3CtIGH3VmfiwCL3HQ79VfLzBEwdptf0ZhBqE5ju7ruhfnubSiJtc39?=
 =?us-ascii?Q?oh4Vh873KZYyH8c2H8Os05DgbDheBQgCPSKkLwhUjR2Zfn6K59sqsM9qjgB1?=
 =?us-ascii?Q?FtpKXNpoX2XfdF9GcSh/vrK76XYzbmDOW2awjjy19Qmqlv3+QVO7vyK05p1O?=
 =?us-ascii?Q?g62F10dU8dLRiFZUEq1B3eFP6+QPG0N0AIw3135SqMcfQCHfauFN4znlgvFv?=
 =?us-ascii?Q?vit1xq+oDABV9rSsJloGKeOC36B6TsWYiH+MoDs+OKd3QNV9ZHYnGBY7X3EH?=
 =?us-ascii?Q?BgDnKhJRUyglS41aKQLw9VVg/CrGAdu0FX7iv0dP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b38f3ec5-d54a-4480-2e11-08db8f8e6faa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:16:52.7280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gql+hcNuQ1MElFkPsAYyrzhqGCw4NcGUBpOtLfRcc8snw3KcxN+fz5LEQEdhZK0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Jul 28, 2023 at 10:07:58AM +0000, Tian, Kevin wrote:
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, July 24, 2023 7:04 PM
> > 
> > This reports device's reserved IOVA regions to userspace. This is needed
> > in the nested translation as userspace owns stage-1 HWPT, and userspace
> > needs to exclude the reserved IOVA regions in the stage-1 HWPT hence
> > exclude
> > them in the device's DMA address space.
> > 
> > This can also be used to figure out allowed IOVAs of an IOAS.
> 
> We may need a special type to mark SW_MSI since it requires identity
> mapping in stage-1 instead of being reserved.

Only the kernel can do this, so there is no action for user space to
take beyond knowing that is is not mappable IOVA.

The merit for "SW_MSI" may be to inform the rest of the system about
the IOVA of the ITS page, but with the current situation that isn't
required since only the kernel needs that information.

I think the long term way forward is to somehow arrange for the SW_MSI
to not become mapped when creating the parent HWPT and instead cause
the ITS page to be mapped through some explicit IOCTL.

Jason
