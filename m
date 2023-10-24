Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD57D59A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjJXRXu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJXRXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:23:49 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7508128;
        Tue, 24 Oct 2023 10:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeoMB2650Y+p27zTpioPhwkBJrSVfRhBwHzp/kT0yWdfyUokmuLlA9IIjLazyhI/SB/d1Jg7ol5Hz4tltH5Tstxo+yMzFkXgQi3QmkZh0+4FResdJuUHM2sVsgOrPWytsrUbaeABoQ9C3TcIHR0GTvxUPAjVkKwNmJgTS1PZ470DAeQwt4WkV0yvBL3MovpoDIDsDn1BKFA7HVORzadbU0wKm5d9jxChswFOjDLfFliZJ9BU38gLgiuxyAQpAbY5jNG97LG7VaR0TZpJr+EQ/L/+1iTnc+E0tm3wPPPjYTng3roqHpB5V1sNAwa77iwvPWvybuSX3tGOTPhreZEWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQegSCm8eLJixrnEgPA+k31n3gtvgSNjagbXujerQrY=;
 b=H78ZyQhq1hu1drb9vGufwQiZVV1tRRlvBeHcMAlsiNgkOCG7n7hEwsnysixvOuLr/YQjF7/NCjqkyrs50bvP6lKDXWMxynr3L9fzHMp69793F7VTeldrEciqGSSh+Ezeu1VFJeIN9UdVvbmSCt4wq2efagDhP+ZHg+TQpMmr4U+jbz8iBhtlJEAf4sSuN8ha9xjnlkeZbrNaQy/mvvDvucn8yf2BInW3F7RlS3VUGXXN3AizBRa/CQNKs/2bH7/GnOPj3dPutTq04ZdETSe1AkjmgStwQlIOxqGZyde/gbF3a4gYYBR4rcsmaMkpX4DUKl6exMspmXDuGb3QHCFa6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQegSCm8eLJixrnEgPA+k31n3gtvgSNjagbXujerQrY=;
 b=O/d5Oo2LHuMsCmM8pmx4hS9GDWV7UcAUsDBgU2RaLVI8FgElfn4qEY3/JXdMUi373N8PLMCIfIheTxGsg3F5NHk1quOT6dQdQrjlv6niHux4irPvAzpmdYyvMtxKWxGfXaN/Z37yH11pn/qh9rGY2RlhHPK6/UDhY7gUMEV8sWr8tZeBlSK3Qi+P3ozQC+1iroG8SIr0jJ+LCKruwdjWAfWu/tfqIQyUpNTJdoDk2BC3y7ByB8ZMnLjestE3WvnSu4P1U43ST5H67ONs2TwXIXpoWOd3lxSQMllQ+oGHomsED834nZ6bxLeifG+neN52kl76D+fsgIOtZOJNW0zK5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW3PR12MB4444.namprd12.prod.outlook.com (2603:10b6:303:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 17:23:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:23:45 +0000
Date:   Tue, 24 Oct 2023 14:23:43 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 02/10] iommu: Pass in parent domain with user_data to
 domain_alloc_user op
Message-ID: <20231024172343.GP3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-3-yi.l.liu@intel.com>
X-ClientProxiedBy: SN7PR18CA0025.namprd18.prod.outlook.com
 (2603:10b6:806:f3::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW3PR12MB4444:EE_
X-MS-Office365-Filtering-Correlation-Id: 77066647-f96d-48c5-d276-08dbd4b5f9cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YrkGjcPZ8oPNvFLnuk0S9Sn0MJQXdaqcIL6SejvO4JvP5bzj3Kig5xVQr4XV5MQyyvONU+guqGFmNboFaCFjicZ6qC9Y154bo3Ab8eNT/nWlnxAm3659bWOlg8WcZlcEegBDB5ylpC8b3m7u5Esc6O/FM2C4am/AMmgl06CVrRfEYqgvaD3aVlgN0EAo88HX3kH7s91f+7sPMfrXgTDzOXvUSnbq/9vPlBZrIhFPf28dQ8Z7jxNjcuhaNnV/FoVZuT1jXHCIcPqoNM1I0YcI8+W+dFVCMwNlZU62QqE7ei3D8JiEp9Jiez4M57xhRD8IFoA1cF67GaX5i/CSYM4XAfj+CxDq8T/FU4s9BNAka6wbw9ziyGwxWklFhhMKOJiiI3xxp0+uJqtr+JF4/nZgIbXGwRm6SQbIj0Jy53yrQkDp+F7yXh33WDON1M2AxIzcEv+2Vu4bN/AAvo81Z3dIBVVigwoCJqytB5C1kog5XNY46tfa1AffY/OzX5YnCDyXgs4OUzAplLWRCh05+0tlJ4wzY7dmYoqb/0dUv2suLtDUnA4pUv428sz5VRgGgftp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(136003)(396003)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(26005)(38100700002)(2906002)(5660300002)(86362001)(41300700001)(7416002)(36756003)(8936002)(8676002)(33656002)(4326008)(6916009)(6506007)(478600001)(1076003)(66946007)(316002)(66476007)(66556008)(2616005)(83380400001)(6512007)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SCAzC31R/3p/rtI8mKlTIlyzZ0M8MP6OWoxZK2i5VwYx/JW9Qv+e1k9XM1PO?=
 =?us-ascii?Q?YadtoHCVhGKrikHIMQR7ARF73w2c2CK1LYFLOzS9ltvL6i8PH0Rc6BAzvrhY?=
 =?us-ascii?Q?LrwPUEG+alGDMSKZFBvw0EVc8/jMrF9NsOOyXTe2G+41EU4fs9aCHc0hwIzX?=
 =?us-ascii?Q?mHjrXsLgCCrZdQtYFJBa6A2DvVyfPsLpWcDyJbvogroQbnv+y5GDGxr/fmpn?=
 =?us-ascii?Q?gbnIC61Ba21orq8PP2KU4v5+2HeR56uiGZwVaEhXp6InkgF+CfXSoewaoL+j?=
 =?us-ascii?Q?IXOtGcQMVNNNckEpIHwiTP5miRUnNoYMrVS4oZTjArSQGjcyMuM47Q90Dxef?=
 =?us-ascii?Q?Xm5dFLyVUQXDqyaE/n1pXxUnok+ELU0x/s3H8OlcZY59uIanbhklPm20nez3?=
 =?us-ascii?Q?vcAa5xUdkJs9V9RPJg2YX2w8Uay7qP3O89Zb+/mt8dwrYsDrvlbNjpNHvuWq?=
 =?us-ascii?Q?w1KJsfu108qG1iGCcOo/88GL+gpehL/bbYcTp53S8JR2WfISxrHs7eL+ek+R?=
 =?us-ascii?Q?fhcK0ZvlW/c5aB2LX0sW0fJsbdVp5hAokVF5eBT/MHYOM6GUPXE0WbUmbyOe?=
 =?us-ascii?Q?6TaxaNrN7fR9CLWmGP9NAwkW0DEZnhLoN/L7emXhk7ZC+DQXGJlPP4t5JQLR?=
 =?us-ascii?Q?lgQC8ZwTIAjIaQweY//a4QzH/DBFAlpd+Hd6ylalXzboH2/9xlPXi7bd0Hra?=
 =?us-ascii?Q?ncVYEiC1NQTl7MsknEg1kyTVGPJfIVUT4xDKGomwRembaTUF25PjYLSzO9J2?=
 =?us-ascii?Q?9p9cmFVCGOHeWerJmi35SJnJBifYldutXF2e+Wa0xp71hw6zxq2l09IzDbv7?=
 =?us-ascii?Q?Tr309PnlKtnu+eBmvIxnWt8NA78JkAJ5vmvk1GiaXFa8LpL9uT2RisYtFm2a?=
 =?us-ascii?Q?JQM3m3akMw/gTrk5UgIdZvInibpRXBPTih8bH8KYIzJIVs6J9/hHBZIb+B7V?=
 =?us-ascii?Q?2OXGVaUEUN+L31ic9mUMvYbYjdABBv0MkYtg4YnH7hK+U2oG2slNPBpskTEJ?=
 =?us-ascii?Q?nLxKymOEhYBf+VOQjxTWiBitLTc/dhzuebTaX6ycGAb5F3iBbEY9P8l4YPON?=
 =?us-ascii?Q?8nxJMwnsqh0s6G9tt1CcxWM0PdaVzMlRJWy4ZmXxGyTIcgPKbIz9m70d7HpP?=
 =?us-ascii?Q?8XrmHKVxubUeYkiqIQkiOBAXhs/MOf5laKpDEIBItoorrZIfJ5u5Vz2i7ihs?=
 =?us-ascii?Q?A2jLwiH1XSHBvavAja8Nrf+9yraM+VIRoWaXc+SbErTdgJLJD4M1bPyLc2zW?=
 =?us-ascii?Q?XmtCpyPN47oBmrpSakngg2eKNFKKYmmU+6t2vVtfx6rr2fHkunGXtA+LHWtx?=
 =?us-ascii?Q?ZNUWh7ZPmpzJJ+ZbrmriTFfOOWntMX2o77W8/fsZGwiHrjfXRIY/CHNuv0vG?=
 =?us-ascii?Q?RWBGXsrOSXQCMt9OBrH4YHPIhFj8QWYpMO1JpIVa90yd/uyjB1dPT/BXbaEB?=
 =?us-ascii?Q?2i+8jVW6xPZzaBtwu/7WDRQ25GoVwY8mYjBisTNzVCA+V8MW++GHW0bIoOEQ?=
 =?us-ascii?Q?oMfDR1eu3rqO4TW1WUh6rGx9oFBgMfu4x7h9lVE/6wqpLwU6+tyiLO+JIkAK?=
 =?us-ascii?Q?wooz5Ort2H53VQ/qv2KxUdKy+g+LtJYz7HPdP7sG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77066647-f96d-48c5-d276-08dbd4b5f9cf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:23:45.0549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G3ypnoF9pgkaD/tr9k5px15cgRET6WpHXS4A8q7gjRr5AiitEYNBNEo4DZzwFwzc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:06:01AM -0700, Yi Liu wrote:
> domain_alloc_user op already accepts user flags for domain allocation, add
> a parent domain pointer and a driver specific user data support as well.
> 
> Add a struct iommu_user_data as a bundle of data_ptr/data_len/type from an
> iommufd core uAPI structure. Make the user data opaque to the core, since
> a userspace driver must match the kernel driver. In the future, if drivers
> share some common parameter, there would be a generic parameter as well.
> 
> Define an enum iommu_hwpt_data_type (with IOMMU_HWPT_DATA_NONE type) for
> iommu drivers to add their own driver specific user data per hw_pagetable.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c          |  7 ++++++-
>  drivers/iommu/iommufd/hw_pagetable.c |  3 ++-
>  drivers/iommu/iommufd/selftest.c     |  7 ++++++-
>  include/linux/iommu.h                | 27 ++++++++++++++++++++++++---
>  include/uapi/linux/iommufd.h         |  8 ++++++++
>  5 files changed, 46 insertions(+), 6 deletions(-)

This patch should be immediately before "iommufd: Add a nested HW
pagetable object"

Since it is basically preperation for that patch

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index c44eecf5d318..fccc6315a520 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -361,6 +361,14 @@ enum iommufd_hwpt_alloc_flags {
>  	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
>  };
>  
> +/**
> + * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
> + * @IOMMU_HWPT_DATA_NONE: no data
> + */
> +enum iommu_hwpt_data_type {
> +	IOMMU_HWPT_DATA_NONE,
> +};
> +

And this hunk should go in "iommufd: Add a nested HW pagetable object"

With the rest of the uapi

Jason
