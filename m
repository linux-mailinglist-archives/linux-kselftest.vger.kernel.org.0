Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBB9692BDA
	for <lists+linux-kselftest@lfdr.de>; Sat, 11 Feb 2023 01:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjBKAP4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Feb 2023 19:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjBKAPz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Feb 2023 19:15:55 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBCC84500;
        Fri, 10 Feb 2023 16:15:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKr2mXkdV2GtO2JuM5J0Fl7ULLaaJfpI4FeVR2zw7oPjpOwJRUHHfQDjyZs4vS3Mm+BBReUMHH1D/wUDjnBe671oJoZOZlpjh0F4F0RiNzO6wcQSg6c100FlJOgiJ1FCsAyPMiLumST11yDAuRAiWR9kCtMVmo9lWUyYP7Et7pkf4FSW833C2CWrgZ1yG8mmdnxeqP+dcDkXKNTPOPWiiNqqeWeDs9yxAeEBdbxg/ZsJOSiGsVzU2sxXPgwLe1GfurRNizms5nch7RQaNKyMxx+iQdHEGdzCYMcEZALFpRNodUwpPcRemPrFxfSmaNvRVtIIz9AWd/P3FMCP1qhQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bROt+PZngeKtfR+cCAr+OPWc8LHp1E97cVuV/fq64S8=;
 b=MG/0vl9mHG5gPLPfWSn6J+v128vRADRlChd8hR7GF/G2OuKX/JrG6bmcLCU8RWh92jUGqfIjQWizpPOiDl6UBFOMe5GpoaYsLXV/Wy4uvTGjeLV9sbPxtphM5Q1JL3htOgA1Zpf42zwyBJjXqoVZdK/sUVqFyje2XFj2OazAwdlwn8V+Ge++jUEuINoh1dre01PZE/FIQ8dAMs9RyJDH0ucWOhKUX1PQvo6mMJynTBWF5JmE3DjVR8fC4dkO4AlGTgfqCHk24g2e2xYSdDi5K5C2MpSkKojvTuellFPmFeYMm41aYLt/WTheLuSYRC6nJ7OyROZsdJuNxYHf4teGSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bROt+PZngeKtfR+cCAr+OPWc8LHp1E97cVuV/fq64S8=;
 b=Fyxo6ttB0X3Om6+hEKJjkCwA2cFX4MsgXd6k8QdRGUzM3pPaBRVGLwIgfbTk7IL5AGE5vcXvMACWpqxVGzoJLfLD5/rS6Dx3cgf/sYeE1PS8aLTfuoI5pinJAKnE1xRWg9Uhh+m1eCitbjH/LYH5R8d0JOXoJRzrlACozxdBWvi3/T2UCFpaNYuDJ1vdOBioMmQWgAjNi1oB8JEDmtpf3TuT/61lwWv5ZgtU17MyJBTFwH3o94HlFcKC2pguZL4CKqrO65bVsNfv5MPTz8mt2htXN7f5FzPH1Fa7FucSsbNrnh5zxM5u+DSy0xVQELFXXUh7Y2HyAegu9HDhGAsO7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Sat, 11 Feb
 2023 00:15:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Sat, 11 Feb 2023
 00:15:51 +0000
Date:   Fri, 10 Feb 2023 20:15:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 2/6] iommu/vt-d: Implement hw_info for iommu capability
 query
Message-ID: <Y+beNa5LXUvZSaEb@nvidia.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
 <20230210154410.2b3b8296.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210154410.2b3b8296.alex.williamson@redhat.com>
X-ClientProxiedBy: MN2PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:208:239::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9147d3-2442-4c1d-2f7c-08db0bc521d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1F0qcP/3MRDHv3djKeoF+l2P1iWaUVyCORX0sTdgGOioeA6K20vZiTCaGHXgyTfSCE891pMw3mwPeDPs4dw25FlBx29puD+dbUWJ3YtOox7g8lc7v55Z69zoU+bXGAQahg+DuHbghk9M68NdsEmL9FtcNENG7Hkajk3RC+LhEWR5VMzqYbfaospr/yp+DQKzGzvst976FHpuwIYgf48TvzWCRZyoRQn6tuwV/B6MYHpP8EzWGw4fqm7+PouOLrfLf2GHwwJvRm2D3/yAMkBZ75abHhuFvjWUphqNTaRRuDhzj2huKO54KeqTme4hBMp/1iOZrOKIz/bwiNVkOaNxh6dKRzAGC1+VnJ0y1eBNAABHvqbJFcvsWULQYy18oYBLJwQYMHrdHO3HhzoH0SibndSmI6HSbiH0KFOM051SjXkMw6m4RdhYAoTF3MgVSP3yQTnRcrKTDYd0Gx9dikPMdhMPt2FhYGZ4jPWkgjeHtXYdpIHMjH5BKhE12LV5sRFd7JGCXVfCG/3b3K/pFScSLJVmtCT4MWRLy6CUYM6HPX7nSn5KyvndILpVbqFOT8Mu+tLUoYmv/ghOsu01Fn3ofboiXLlsdaPG4TtJmA3I2oiZfaDV96rWvFnnkmAp4zR8mf4YHupNFFggIUuaubEEAGHD3K7UbniJRgMNL7DZgK86O7i8kyMsOLn5mUFyO5x
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(451199018)(26005)(2616005)(83380400001)(6512007)(6486002)(478600001)(6506007)(5660300002)(7416002)(316002)(186003)(8676002)(66946007)(66556008)(66476007)(4326008)(6916009)(38100700002)(8936002)(41300700001)(36756003)(2906002)(86362001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qcp1VG9ApHJ5SYBaId42tH4Ojw4j00bnhOg9GnSee7MDqA6phHcVrGjrGf1M?=
 =?us-ascii?Q?39pYMErmy5qlDn0dD5ZTbL+8v265kGl2uVbxE3O5qRhHQaf3bVEegRsRGCfD?=
 =?us-ascii?Q?xrJwfSmjFZH405qzeeVcEovESh3GYPAZajcyNnHXFlyW5UwBPW6uV2/MvJtT?=
 =?us-ascii?Q?XeZ0CJfBkXOXXbKzofIObD76uEkQ2V8gn0jqR4vcc9LNUU7zYACnVDb2Dyup?=
 =?us-ascii?Q?LI+8JcRlLkazz+7PwUbW28yh64NoQRNXMH4Io2w9ZxDRTZfng+CJ7p+6jID/?=
 =?us-ascii?Q?4bjuW+Bk2ce19ybdkPwI41O84NRJ+f13QbngdAHm4hB2tr3t8aYwjAg+odyj?=
 =?us-ascii?Q?GaYK/FCJvddX/hflGZBACWU/oGEJHwIn2hbnLxuk+ls+DrvVFxtnrQic4bZE?=
 =?us-ascii?Q?5ugPQuwsBYeTNSHJCFbrLnPyh2v7M3r58ZbRzfOHWi0HvmZ0pIM3xlV8GI28?=
 =?us-ascii?Q?i6n4XoUteWxGBBKsRecv5G8610HreNu+X11a2zLdzBFI6iB+/vpBkTAViM8d?=
 =?us-ascii?Q?9xIQhVaNDxjd/+JE0KyQ3XrgsSaBaYa8xpl1zj/2BVaguAUElm5VTu2tY8sL?=
 =?us-ascii?Q?IiXIy+T+FaaUzuRES8wwQXPDDUqNky+SolKQ1FE16Pn+haV+kBtWd0Djl7o0?=
 =?us-ascii?Q?gmwjLnVezJExYCHwlTB8RattXeEH23tJOiIHk/R3F0IQxvV5FDydb+knxOAV?=
 =?us-ascii?Q?BsNR6/3mpnQrEFer+rNV/3UvF1Q7RV9XpROGhY4nd8dnwpb1d+JE16R0B8FR?=
 =?us-ascii?Q?8CkxYQwWlV0NkmIGPrPWFFc9t7J+X3a7Rzh6RT0Uxc+hTkQSISAT6Mzu6fvA?=
 =?us-ascii?Q?TIdU7RCuchbJWd3imQcrEouE4XI1U/MJdFkScXvkm8Acp/gsfaqLQVNfZf4U?=
 =?us-ascii?Q?GJkdZZc2XvwWwg6GAy703WYe680ih4FOUmJUiid0c4+F8JhlOzWaVi2JHMSu?=
 =?us-ascii?Q?+ggnFp0fw2fqU3DZysOqm77oWd28Yu0YnMKq8W488HklEwI7zElbU+6Y/9wz?=
 =?us-ascii?Q?C4a5+FV/rBiSNWk2epEdg+Usm5JzKQTnafM9cT5CJcSKHAG00mYkUykd7+gY?=
 =?us-ascii?Q?WZi32xgN3QepvYWYmQHxBHtEyVJR4ERFLpW074VFVecH2HxFT2Gr0p1iQRh0?=
 =?us-ascii?Q?PzuLwwyt7/OQFEfRNgmpwVRszqiJPvEitcMQEQfpRFJfntCvQawgZ5MhtDYk?=
 =?us-ascii?Q?2z0RxPSOIkD44feyYdn9Wy1Yog4yywfQCoMnQlItvEXMjdBmhyl4quAyQE9I?=
 =?us-ascii?Q?yrXf0r2eULkrpocbquB2oRbRaKyKiXbrkLVJnxMfsBz0clcDQDj+ZlzKx9Yf?=
 =?us-ascii?Q?49o2ObackHSbx4SyWfhVwXWkgZOvR9GaOtHXukTszJIF2ehSrdVWziGBrppO?=
 =?us-ascii?Q?t1WinebHqEqydOZBk3+krXNxg0myUs/uNqa5uKCD7w8wFyoM6K6Y6bkorDzm?=
 =?us-ascii?Q?U+mfjudKUPlJ1yISfEMd/zXHNc4hmddbxwz2+0gqCLyfc/06kCPrjtzfJA/z?=
 =?us-ascii?Q?c6GWS8oENmbGOZzpwpNd2C7fX6rHQrLWjNdHnS1sBF2TSWuSWOWaPVdJW2or?=
 =?us-ascii?Q?PIT0Zf+GC2HC4pVdglVBoFdGnK6ltzaEK+11qUaW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9147d3-2442-4c1d-2f7c-08db0bc521d8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2023 00:15:50.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxcjekogU4ogLb6t0sLPjBia17FehX0a7/NjOVzEugE6kSdrFYD6/dO3gJ4E7pkO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Feb 10, 2023 at 03:44:10PM -0700, Alex Williamson wrote:
> On Wed,  8 Feb 2023 20:16:38 -0800
> Yi Liu <yi.l.liu@intel.com> wrote:
> 
> > From: Lu Baolu <baolu.lu@linux.intel.com>
> > 
> > To support nested translation in the userspace, it should check the
> > underlying hardware information for the capabilities.
> > 
> > Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> > 
> > Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
> >  drivers/iommu/intel/iommu.h  |  1 +
> >  include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
> >  3 files changed, 41 insertions(+)
> > 
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 59df7e42fd53..929f600cc350 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -4760,8 +4760,26 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> >  	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> >  }
> >  
> > +static void *intel_iommu_hw_info(struct device *dev, u32 *length)
> > +{
> > +	struct device_domain_info *info = dev_iommu_priv_get(dev);
> > +	struct intel_iommu *iommu = info->iommu;
> > +	struct iommu_device_info_vtd *vtd;
> > +
> > +	vtd = kzalloc(sizeof(*vtd), GFP_KERNEL);
> > +	if (!vtd)
> > +		return ERR_PTR(-ENOMEM);
> > +
> > +	vtd->cap_reg = iommu->cap;
> > +	vtd->ecap_reg = iommu->ecap;
> 
> Just a friendly reminder that these registers are already exposed to
> userspace under /sys/class/iommu/ and each device has an iommu link
> back to their iommu device there. 

I think in cases of mdevs w/ PASID (eg SIOV) it is not general to get
from vfio sysfs to the sysfs path for the iommu.

> This series doesn't really stand on its own without some discussion
> of why that interface is not sufficient for this use case.

IMHO I don't really like the idea of mixing iommufd with sysfs, it
should stand on its own.

In particular there is no generic way to go from a iommufd dev_id to
any sysfs path, userspace would need prior unique knowledge about the
subsystem that is being bound to iommufd first.

So, I think some of those explanations would be good in the commit
message?

I would also add explanation about what userspace is supposed to do
with these bits when it operates the nesting feature.

Jason
