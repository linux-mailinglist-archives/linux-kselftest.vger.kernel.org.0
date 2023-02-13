Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD45B6948A6
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Feb 2023 15:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBMOvp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Feb 2023 09:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBMOvn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Feb 2023 09:51:43 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD421BAF3;
        Mon, 13 Feb 2023 06:51:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aY87mxhN5sPbDg9SIqiejg3HYTIEHNJLG7Ebj1kFzKSVJt4ott/iOJBszwSTjrxzeVA3Vaw5LZx379Luvry1Wbrnx0Ckg0/4wq+XvIeGN1TZppRI1rgEHRWdpm4w8QjEjTFSDW5GC3jqOCyBF5jmkYwoi4AjcNapfdfPuo4tVWHJJi4VEY+JI5QklQPEqh9rrOCdsmdVrfzq55J88d711hA+LNQMS+a4BVDyNbqe/WcUpzn/xC2MH4Fz6qN8OjdQ5v3j97zGg3lVdR3IfFj2d80uSr0RrJdEMH0n8cGhNH04xVMXktQituk3idm71flEJWLyR/wwIumfCf8KoLM7uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZnDbqOju59BLOWg38WoCQ7Qvcie5Ro3mMyhaCs5DH4=;
 b=Y01n0xjWMHsm4iGN+rZt1s9ea8w1r1ljBZJcy1bwltUkBmV/h73EQshSGSMQ6xjlw101eciZ8rdD0F/z+qJlMhIByGHRZKiAHynXxOmcSGbfzrGgs0mVTsqMkyBPS8jKUQtOuFe4G/nOENaMaVhWu3G0u5+/nT24sW454lbHda3EOUEPkRPkq6w6mYIO4okeOAHCZ7OMHloKAkHqhyMGfqaFhgmLI0oEfGCp+pQdbV+TFlZooU8z6pQtEIWCQ706o0C3SSgNAku7Tl34GfIeYiNIYHawPMcbODMWSL/+SapuZG7fX3PUPfrdDMw+kUgTZekm2Fg2/GvJMLtLDn2kOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZnDbqOju59BLOWg38WoCQ7Qvcie5Ro3mMyhaCs5DH4=;
 b=VfM3nT8UpUBpICe+BPItc8JJ67F/Ji0zbxXvpAuoV8xcsQwLYFojh3sm8eHM9lwtFXsBSosHu+QLSuF+WL2LC/Yp5hyUEGn+a/0GZhYWewX50wSmwLC/iGH5/7iQpypgQ8rizmt7Nbc3F0GnjekMVBLF66VdwW8ptewsC8qsQ7S+JbFJrQTfUFry/nSu+7zFE3mowZvs7f6GOmI7o7nGPFul5lXfgsHzM73IDtA5SyK1VrnXMbv2dg638NOMOk7H2u25LTdNhUCc7Um1Tb80zAeAiA90zH1pRkclmX+3DOWO6r3GqqfDbHFRvxOFvJ6DbKvekc2ej3h1hebRPfqzTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB6128.namprd12.prod.outlook.com (2603:10b6:208:3c4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 14:51:22 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%6]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 14:51:22 +0000
Date:   Mon, 13 Feb 2023 10:51:20 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
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
Message-ID: <Y+pOaPOaparSpkGj@nvidia.com>
References: <20230209041642.9346-1-yi.l.liu@intel.com>
 <20230209041642.9346-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209041642.9346-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR02CA0060.namprd02.prod.outlook.com
 (2603:10b6:207:3d::37) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB6128:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c801de-9e57-4842-dccb-08db0dd1c5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Teo3cVmgPfFlCaDdknwnS/6R55xX8Jd7ch62n32kRhWPQiNjT3AcdXGE8SReJbL6EkitM6M/FQtq65QzG7yJqZ7x2/2LyGo+vqcbtjQTDN+gZPSprVRHL4NBn9mjQF+MzOO4BwhxBKKhTimVI7VMvSk6Rug6j3ZYX/kww1OyLBaG2OpGg/9bbsP1M+vfbp5fIFbdnGtAxoM9FLQkSE1JWdbJRzYQUdXgv+paawrHaWr19SGusiTC7U6oZEDW66xht+ZhumY/Mdr1apZN1Ionfe+4rG5Kste6OORqRIQPnMV5vYzg+uTTm4R1XBapBAdEynNmqHS9k8mIgImh7qHDsA80xS8/aIoZggsZjkHIcj5sFB1WQUynoWKEtjyPEjs+qjtpURMfBHFs6/niG3GdnU7m1CKOwCMFrI6tazhvdltn6ibUL+S7e4xvdipk9ytBgtW55/7JGStnK94S8OKGkRJWgxwMbUB85BoCLAFQn8x+81fLDlHQnNNbn1WoLfbmIpD1ungdVt3M4stAC53zHQ50AtewIiZiFutKspCMBHtW551BbANw/7gS/+Sf0QDjNt/9R55RPbsmeoyHkrAGwI26LXuoQTlgJ32kk0i3lT916UusWFLr/0VadTLHh0nxDDD8fztKoYbpToa7JztJXUiKvsKYbm5U19HViqW9aarfvk+0Ldo1VGY+VImxcrf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(451199018)(2906002)(86362001)(38100700002)(478600001)(4744005)(36756003)(7416002)(6512007)(5660300002)(6486002)(26005)(186003)(6506007)(8936002)(2616005)(41300700001)(8676002)(66556008)(66476007)(6916009)(4326008)(66946007)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2PgLYiVYJjtPihNx1W4qh0hvtK+21nY8in38mYJatHNEE1buCcruiuEC0zu?=
 =?us-ascii?Q?VNi1JgykVpywKd7WQEupSBE+jYYmwBh6BaiJLz5VQ6Lu1nGGBNgBZ+tjiezG?=
 =?us-ascii?Q?XOGqJW+gBITi4mwi2UOh08H0Rl3UdyfCPb8RrTO8eEWO9UTX/2C/DMTWblzc?=
 =?us-ascii?Q?L8bNwQ25SvxEwfkN09DNa9FIuAD2VdH//Krs1WuBmPepVRw6NImbO8vtk1QN?=
 =?us-ascii?Q?ORHOa0DyJO+Z5TFY8+3Q/7GZCJ3cXQvmYBJE4fnoF4JAK2nRSVbQse7UwI77?=
 =?us-ascii?Q?rFpvdNCGkhEqlROA525fS9J6Cmqy6Wwug4hV49Tyh73wNBnr+qoikAWNb3Hi?=
 =?us-ascii?Q?weW/ZlCiVX0owX5AgEJ6nwDB/Mth67qnyq9HYO4R17N9cCMaxkcd9Y6ZvosP?=
 =?us-ascii?Q?V5swTip3GdcTk7ZigZwuX9006aE2itYCNfP/rJlbe6K4sykGjQwIX/YbVo++?=
 =?us-ascii?Q?l0ky+dRRyfuA8w/LfTZaaacZkBygkG2l9rhxb7BhT+vkM3Ji7PIb1KMdTk1n?=
 =?us-ascii?Q?TrGfc7B0zB9R+H9+WnV3LMxhTuTBjw5KaVHuSTU+4noZUBKB2g5ryHAjIm5N?=
 =?us-ascii?Q?karqFoGhtLDSju6und7lncPTdWGygqGjX4P5BvOBK3vNMIWoN8PkSLPPCZO2?=
 =?us-ascii?Q?RdOMdnkXqYFMw8Y6kzafZIioOl779vnus4itIpgiTCdER5ILbjtzi8ZIkvOX?=
 =?us-ascii?Q?BzFlFSSIS6Q0YbVZ+xb8bPRLzNsQ6LudYEda3gMMhjIJP/napr1V41588wZC?=
 =?us-ascii?Q?O2A0L23YKz0MSTnk/lkrcILJZQ29tQsmnxLsFml+C1Zgjjn6JZfjsufze7qA?=
 =?us-ascii?Q?xxbOKl56OKvtYH6yB0cP1hGNtzoTLivmlLELh9i2pYdU7uXfsAjdI9SyTh2Y?=
 =?us-ascii?Q?9y2yIKUexA17gU6T6EAx/Eyt24W+N0dCUri1S8/752D2jGpJN9lE3gr7UeF7?=
 =?us-ascii?Q?i0bZ398VHcTYXDvUD6lUf60Sbs8JHG/n7VIowNBpVm0LtUbzcMiQwsxRoIMC?=
 =?us-ascii?Q?wdjDyuuE+bf7GZlungIPu3mB35dINfgaIgiTuNmwllh0OPVlfRMGckA1tSni?=
 =?us-ascii?Q?GQpld7ulNQ9lH4YWkUicWJrhmAG/XdnTqCN7fIHgKMGcOiV5mQDNI81v2YWm?=
 =?us-ascii?Q?rUgiDI+4iHiE5F90sLP05QKC6X60t/2l8TMYDxYxFSSd3EMzwLoyGVqfZ66h?=
 =?us-ascii?Q?Gc5voV7+qXX0p3QDkhtqvCyGsKXtkodl05t7M7rlvjArEVJ9nAomgjYwxMS8?=
 =?us-ascii?Q?0UneEprJqY35CIJlkP8B52eYDvPw8HM0sATIkafI70v6faHux/y4eAHnYZhj?=
 =?us-ascii?Q?4nByyuhslKN32s7/o9WzdeVPfJAXnb/mzxjU4oCcrMAFaL1rNqbvKvXmhecH?=
 =?us-ascii?Q?acVDK/DIkBlRhDcQ3tMsxNxMGwF/dslXlxhuY1YI4RZgY16pcb15cejpqJRc?=
 =?us-ascii?Q?ZnPxYL/Ezt23YYJROd+8AT8HzmSFxZb3aQaDGcgPQVSkW0P3a7tF0KOvPkVw?=
 =?us-ascii?Q?+qYNRurz8YTIfu4gLcFu94ZeuLkb/rmRTijSVwB0EjebLGzCORDKTDjyTYD3?=
 =?us-ascii?Q?mgukiT5oiHJQiPHL4QkPTY/wvBYreJZxnnuQp3wW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c801de-9e57-4842-dccb-08db0dd1c5d3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 14:51:22.3891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxQZWwj6ig+/NdQpXkWvXEqAQZbr0W65m5ZVFRYgpbNQzneklOjkHzBSvFDhhMc9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6128
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Feb 08, 2023 at 08:16:38PM -0800, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> To support nested translation in the userspace, it should check the
> underlying hardware information for the capabilities.
> 
> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>  drivers/iommu/intel/iommu.h  |  1 +
>  include/uapi/linux/iommufd.h | 21 +++++++++++++++++++++
>  3 files changed, 41 insertions(+)

This should come after the next patch in the series

Jason
