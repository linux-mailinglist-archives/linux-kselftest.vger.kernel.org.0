Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDCF37702B0
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Aug 2023 16:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjHDOM0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Aug 2023 10:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjHDOMR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Aug 2023 10:12:17 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 465DD1994;
        Fri,  4 Aug 2023 07:12:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fw2h5XOWaqYDNnDXHjvBFju359r/Faxcz/GL9T9yS/3sRzpsSgeYDw8EGMMYUyVmDCAHrij38sJ+gr+XSDdk1oi4FJmLJE8PKYN3DYxxaIJqhAzBEIIaVg+C9BtKdIrj7IA+A8ugUUeXJw7JxbNgzJJh6WbW6ZxBh/OOU70zVOnSQbYd919hgnMrvuUo+Uw3hEhZzfXJtSBRmb6lcUOPyNi4ssjalz5HlbYIDwNqv2XeohXwnFhordZsEjLd+yezJ8Tr9T+24zmLnjNKKUKxDpsqMyiAXp5E4+MiKuqSX5pVyADToLK75WEq5+0uqPd9km4/ReLb+w73SEO0ZmqA8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wTWyjrXzreKk+DJWT2zlESyKLss4moZMmmLXDbolZE=;
 b=ZzfWu5yNfQKZKtCd1m1ez6LP8i+gXWu8O8XbMkw90Bco/TWtrNBpHG/sVk6ppnXohkPcxplRdMxX0dpXBeId9pQO1oF8qrKKQTzOU+h+KN2pb/1D7a8qIN8UwaqYVi2yjec6J3ae9MG96IrvoLfDk7e83zftjQUQyrjab0ptt7usNPe61M5FfRImMHXbxNN7teY4pY/B2cEmwgc/o4KYslFz6V36moM6lCfbH7XMq8SQ+Um0AEEEICwSO35Xc4Go0fc66e9CL0FlAMuseRZkE+pZi+ukXwEVFOEREPn7ZafwkWLUTeuwtKDlkWIBsDNnEgCtVD4asIvGlGG4F8r7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wTWyjrXzreKk+DJWT2zlESyKLss4moZMmmLXDbolZE=;
 b=B9Y9NJTGF7Oz4izYXzyUwIE1/RGRLqcedo6MFJCVAMeRuUjdqsvySgT8dRV8MpSuxFzokuGuJFGwVmmvxd0DlERBfL8PFatnQ/R4V/MT5xbRAlZ4hsorLH/udZ1yLx3au6kMjizcH2cJYmryE9iKPR02X98woIrXD09f0KvpvoZXKLdVQekK8Og+PcGnIwGKQZsDk1IUMe5HOpGSWAqaHnNMtkrS64xragxfmuz9csWgoFxY28gXq0eewn3biOw85QYMKLBniMCmNzFxBtW0EMwvA7N0MhGzVw8O6uTFkiM6D5n5f2hipAeUEao8fAErhgMl3hC/FGNPdmoD6GHH3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7667.namprd12.prod.outlook.com (2603:10b6:610:14f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 14:12:13 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:12:12 +0000
Date:   Fri, 4 Aug 2023 11:12:11 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v5 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZM0HO02QRHnIKIIJ@nvidia.com>
References: <20230803143144.200945-1-yi.l.liu@intel.com>
 <20230803143144.200945-4-yi.l.liu@intel.com>
 <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51418f60-db2f-8ee3-ed9c-1a97d89774cf@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0275.namprd13.prod.outlook.com
 (2603:10b6:208:2bc::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 9740c7dc-2bb6-4ccc-0ad4-08db94f4cc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McxDhLcvl3cZqZO1KcM7wnBLIF2ZiGZLDcAVHr859B+Xn1J7lBEP+iq4nxzIWpnkzS2iAT9GJYZol0YU36TPjpR3DszoMOsKwR/RLOnTdLPN613JJU2Wr0xAsblkdb10n4DhYshVTKkNNcip6xCjsCg6H9McB0bv5XVu4iDyYLR1hZr7xWU/youT31kHNipQqcRmcdQAv8Vh0iiV9mhNCU63oQjd9PXKdm6Wyq7InWuMW1H+9hZMgd1IUEdJj6v7ado1tuUOVVmwoxVcWdqYjq7MZW+OJcb/GM3W+0rfTu2UTeNs91CU2/2zCpuZfs2widA98PaqCE8Y7gMTFT41i82VRrkZutgYk5tnhIDEuALb31cPHG5GMRd7GnSlToiGYYAjmI5DsyjdPdr8aOWmRzVqv2EVATsE448yQIuTJzYNc8NlDbCzsRGgjWb26dLDqOLo1eSP/IJeqLKchJEnUPx4P4M86WND9d86HwBHHVsUl/qcSFiclVrWQnYdl884kMILvxqFuKNCAXhgqOKyeAqfDQnHh0boBXCvNxRAuN6ZcOky2bIf23nfRqh9aDdO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(1800799003)(186006)(451199021)(2906002)(2616005)(86362001)(36756003)(38100700002)(41300700001)(6486002)(6512007)(316002)(66476007)(6916009)(4326008)(66946007)(66556008)(26005)(6506007)(53546011)(5660300002)(478600001)(7416002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rWGMS8EcZc0qcjzhpvCUB4wX0ZgCwqXX+PHWemxgF35A+Evb94iNdtnXrhPn?=
 =?us-ascii?Q?My4mThLQlP1hcIwSt26wUV70rdmvn1BsLvuMkCwR4XOlX3PJ6AuE5Iwwou2M?=
 =?us-ascii?Q?HIpbVZghFaK5PMuGEh0omQfHYHmttfj/IIxRx5yQYxMzB41W1rKXD+3evKi+?=
 =?us-ascii?Q?5BEwJffbuMEm7FJeliQf7hdlhqF9/LwYclbgfL8ksdSr4AFxCPlsY4ApDcYS?=
 =?us-ascii?Q?g56PMox3nKuivHySsjvL3z1DN9rsZ+sIhJKIsHLP6VbQvajPuy5nierCRNOO?=
 =?us-ascii?Q?lGA5L1et49RV5lgjnPQuRk8V+svDF7TsvZY4oCRhsjw6bheuOCyIQWeNk8sN?=
 =?us-ascii?Q?ocVs0qTomqsdfqmdll8oMMzlc5tWV28f48dJtBHWEFY63fpLmRlblHnmuVpA?=
 =?us-ascii?Q?nBPFy3qgsv0F7CZM1+f7kJ36fl8WiIOd7jI8pAkdcvAe0H0o+BBV+8JBCMwd?=
 =?us-ascii?Q?EHf71V/OBzNXDwXNsvweHmFZYPbWe5j4w4Amf8WBiHK9SBUqS4P9HaWRuy3p?=
 =?us-ascii?Q?fxeKFyQt9If6PfLDvrWGtyR6DgXmJv0N/mO3VkDI2kL/xxQB/4xsCtvkTRG6?=
 =?us-ascii?Q?CHTON8H/cqGVIrVyY/P1xUUD5JT2AlHMgT8+pNlb58/7zTG4QuVUlK78xUD+?=
 =?us-ascii?Q?0rLX8RuaJ8pVQyYJcEh2c19CdMGdV/wIyljh2h66tQEyIzuxwciKjs9/rO6S?=
 =?us-ascii?Q?gNq0k9byadXIULb5/w7zUNahlzD9czxzwnjKyNHVeDgrxeMVe/QSnWCb9C2c?=
 =?us-ascii?Q?L6j7epGZDKshTFBqAdO+wNbhQQWSwp0QXKlfUERM6/BWEq6djPFwE3fvYARF?=
 =?us-ascii?Q?Z1Wjtnz5nUuxLPJCUc5ZZf9g1X1hCRTuhY3Y90JJguJYb+RIsAcix+t/GTyW?=
 =?us-ascii?Q?GWCRU2X5xXUpFbePjfPNYXfnhAo6fX93dxeRlQ87hDUE+eX/sqZCfike45Hq?=
 =?us-ascii?Q?L09aiW9I/BPJXW2yn79Tvf77KDncIpOX9eGujr1TCtgfcreE/2AdYqv72tK7?=
 =?us-ascii?Q?hu6nCI6aC8NWAdeY/gHZ9wsmzMBvhFelfdAaxsrbFsMMQP0KnoS93YGjeJfv?=
 =?us-ascii?Q?vmJGcThvfbjx1f3QQgNug05vf6OFcCMIrRiJc5HCYBd7UQZlXO2rHXef/Cgj?=
 =?us-ascii?Q?KIBrxSAgvzBvgwFWh7oG8dyd2ghJWqmvo4T3+apNl2LBekZh+kk61qpaGA0B?=
 =?us-ascii?Q?5enyGE9oqby4hP28s4wHzKN+daP5RhX5zGiABsj5WL/RLgBv4Mx1LGh6HZU2?=
 =?us-ascii?Q?Ei9pPrHgYxpRCNeyyOUtyA3Ny6Wdp6tpWk0Vg0qO5ELJvfOs7FcH60ieL5nC?=
 =?us-ascii?Q?Ono6sctgkirpZByiapyPwYWqhkDsyHYf9SSv5PcLMZG+9p7JUt+AdZQWtc3Z?=
 =?us-ascii?Q?y0yg6WNSHd2P3cNHwvwDmuwnghVpCf17wxVIODUfsE6Bho0Jac2RFgZuSKiu?=
 =?us-ascii?Q?xNFB6xfY9gO7R/8G58Ow4M7l1PWO/uF7V91iPBHU15L02P0m+by0krPgNCg8?=
 =?us-ascii?Q?874Ws3mR6Cz4oiYZtHFyVqDu7P8Isw0VnZGAa6xtntTgsYBRPuKbE7pvL8Jr?=
 =?us-ascii?Q?YXWzRlz+ydxLKISgUKTjiMuMdSHEoStFSGHnnNGU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9740c7dc-2bb6-4ccc-0ad4-08db94f4cc7d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:12:12.8570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9PVJ3aSfX0XhxZA9p9RJE2peCJm+MoWWdSXEuip4ja1pDn2Kct2ueYSvPcXS9E9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7667
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 04, 2023 at 09:59:11AM +0800, Baolu Lu wrote:
> On 2023/8/3 22:31, Yi Liu wrote:
> > Under nested IOMMU translation, userspace owns the stage-1 translation
> > table (e.g. the stage-1 page table of Intel VT-d or the context table
> > of ARM SMMUv3, and etc.). Stage-1 translation tables are vendor specific,
> > and need to be compatiable with the underlying IOMMU hardware. Hence,
> 
>                  compatible
> 
> > userspace should know the IOMMU hardware capability before creating and
> > configuring the stage-1 translation table to kernel.
> > 
> > This adds IOMMU_GET_HW_INFO ioctl to query the IOMMU hardware information
> > (a.k.a capability) for a given device. The returned data is vendor specific,
> > userspace needs to decode it with the structure mapped by the @out_data_type
> > field.
> > 
> > As only physical devices have IOMMU hardware, so this will return error
> > if the given device is not a physical device.
> > 
> > Co-developed-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > ---
> >   drivers/iommu/iommufd/main.c | 79 ++++++++++++++++++++++++++++++++++++
> >   include/uapi/linux/iommufd.h | 36 ++++++++++++++++
> >   2 files changed, 115 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> > index 94c498b8fdf6..a0302bcaa97c 100644
> > --- a/drivers/iommu/iommufd/main.c
> > +++ b/drivers/iommu/iommufd/main.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/bug.h>
> >   #include <uapi/linux/iommufd.h>
> >   #include <linux/iommufd.h>
> > +#include "../iommu-priv.h"
> >   #include "io_pagetable.h"
> >   #include "iommufd_private.h"
> > @@ -177,6 +178,81 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
> >   	return 0;
> >   }
> > +static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
> > +{
> > +	int index = 0;
> > +
> > +	for (; index < bytes; index++) {
> > +		if (put_user(0, (uint8_t __user *)(ptr + index)))
> > +			return -EFAULT;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> > +{
> > +	u32 hw_info_type = IOMMU_HW_INFO_TYPE_NONE;
> > +	struct iommu_hw_info *cmd = ucmd->cmd;
> > +	unsigned int length = 0, data_len;
> > +	struct iommufd_device *idev;
> > +	const struct iommu_ops *ops;
> > +	void __user *user_ptr;
> > +	void *data = NULL;
> > +	int rc = 0;
> > +
> > +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> > +		return -EOPNOTSUPP;
> > +
> > +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> > +	if (IS_ERR(idev))
> > +		return PTR_ERR(idev);
> > +
> > +	user_ptr = u64_to_user_ptr(cmd->data_ptr);
> > +
> > +	ops = dev_iommu_ops(idev->dev);
> > +	if (!ops->hw_info)
> > +		goto done;
> > +
> > +	data = ops->hw_info(idev->dev, &data_len, &hw_info_type);
> > +	if (IS_ERR(data)) {
> > +		rc = PTR_ERR(data);
> > +		goto out_err;
> 
> Can kfree() handle a ERR_PTR input? I am afraid not,
> 
> /**
>  * kfree - free previously allocated memory
>  * @object: pointer returned by kmalloc() or kmem_cache_alloc()
>  *
>  * If @object is NULL, no operation is performed.
>  */
> void kfree(const void *object)
> {
>         struct folio *folio;
>         struct slab *slab;
>         struct kmem_cache *s;
> 
>         trace_kfree(_RET_IP_, object);
> 
>         if (unlikely(ZERO_OR_NULL_PTR(object)))
>                 return;
> 
> So, perhaps we should add
> 
> 	data = NULL;
> 
> before
> 	goto out_err;

No, use more labels.

> > +	}
> > +
> > +	/* driver has hw_info callback should have a unique hw_info_type */
> > +	if (WARN_ON_ONCE(hw_info_type == IOMMU_HW_INFO_TYPE_NONE)) {
> > +		rc = -ENODEV;
> > +		goto out_err;
> > +	}
> > +
> > +	length = min(cmd->data_len, data_len);
> > +	if (copy_to_user(user_ptr, data, length)) {
> > +		rc = -EFAULT;
> > +		goto out_err;
> > +	}
> > +
> > +done:

No label here, put it in a if {}

> > +	/*
> > +	 * Zero the trailing bytes if the user buffer is bigger than the
> > +	 * data size kernel actually has.
> > +	 */
> > +	if (length < cmd->data_len) {
> > +		rc = iommufd_zero_fill_user(user_ptr + length,
> > +					    cmd->data_len - length);
> > +		if (rc)
> > +			goto out_err;
> > +	}
> > +
> > +	cmd->data_len = length;
> > +	cmd->out_data_type = hw_info_type;
> > +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
> > +
> > +out_err:

err_free:
> > +	kfree(data);

err_put:

> > +	iommufd_put_object(&idev->obj);
> > +	return rc;
> > +}

Jason
