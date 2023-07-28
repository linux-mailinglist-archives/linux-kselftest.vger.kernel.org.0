Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D214E76740B
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 19:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbjG1R4J (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 13:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjG1R4F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 13:56:05 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9B4205;
        Fri, 28 Jul 2023 10:56:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhIxpmdoC5XMqTrAVOTob9IC5uAqc399Xgmbwksitl0EORBZ0WRuTZ0ryEJKki4pWEWQS+cptCwME71dnurSRxu4R8XvRnvs0hEMPImr8nZNxj5FawrwQTSYp+uixNhuWnbioGYMBJvlRNAeQFT4cltjuNvWisMsE0Rd7rpf+pj7FhJLBYESg0xkWyi4RCKxpKv/MQdABqZszJCj92LLx40rYTm/8xYBenLhB4Bvds/uF2ui/H8vIstDWJS9euKdbmkhYMJ/JD+vKi1k25DSO4Yy71iqmIErpO3QCu+oHQNgp7gTbqzilYNIzBUy8oq8Viki84b3b38xz5JEfWs97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcuW2MghGpMTVkzvR4Zgk5HLNpEnjEwathmDj3laAdo=;
 b=d/hspTclx3ZUXegOamKlDzXKDP8B4zHHmoT6ZtNTUjqSn1eF6hQmvppYr+3sv6vjDiYhDgVi0zrC1luOr7p5YKaT853qW88+GS/zWOQJKQ9L8en2x6s4hntEGNhGhAajhmvekHxPZqZqFMOGlqGeI/gHW6lkETe+IcCvMPBaD7Oo4NblpKb05+voYFN7/K7Vkb2QLJ7l7aZhHDkQ7KtaY/+iRmQ6PiW+ZuZphtndEtQcpQg6RSBfgiKPO9ZWTwC68W13EkrLGJNs4WPFl1pMK4sb48ftDEzDXqgSBYgyorbdRfrnc0zHpvkScJsu3lwpdei5TpklwRozd2ffNE5G4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcuW2MghGpMTVkzvR4Zgk5HLNpEnjEwathmDj3laAdo=;
 b=G8v2gCP0h4mb9ZbkY+r1YLG7fBhD020ktiBV9fX5PlEb36jcq9xz0qUzHa5H9DgSysksRlEHZHA6Sxan7SU6NhRGgLthB1r8hRqwA9oHcfe11288G6VphWWE+iJGYgtSnkMYjRi/EabMrPvwgwsZTfULbaKDRo79HVeoCvTuq9dKyCYmfNDZXXMBF8CrjHph+Uc6SGHP4/pcD1QG3kjkQNhNzMXGIhCmP0nMoMCls1Y5e7gRnKZP771Ef7jv7Z8OrE8Yd4uOK9VXm8UPRwvNnLe+mzDhSwCw0tibkWnaxVwA9ftuvGvNgFtZBJ/bqfDmf1uDuZi29JTfZBI1JuOxhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB6590.namprd12.prod.outlook.com (2603:10b6:8:8f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:55:59 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 17:55:59 +0000
Date:   Fri, 28 Jul 2023 14:55:57 -0300
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
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v3 08/17] iommufd: IOMMU_HWPT_ALLOC allocation with user
 data
Message-ID: <ZMQBLTm+U+5bgC/Z@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-9-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110406.107212-9-yi.l.liu@intel.com>
X-ClientProxiedBy: YT4PR01CA0170.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::10) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB6590:EE_
X-MS-Office365-Filtering-Correlation-Id: b44abea2-e965-4769-636c-08db8f93e69a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3AQ5EtFV/YZT61FBmNMcaa5f3b9VtnE1so8htlauMUNFZ1W+D6uf/VBed8QTHWj80jA49Fbp7xGd4YXo3ma8QaFAYIDYcYIWeoeqsy2RA/B6e7owbUqrVcoa1dxb8BZURScmHAmELdJIsO8fL1fwWSqCaLdUOQ/R+M/mPuIFfIXUYG81duBZLPS5eEevAzw0JnChMZxS6iYAw9lk2uSaIhZtdZJpPBnvALhNxlyGMfi4mf9iWLb55Mg5VI4fD81VPB1yakaVHlmtl/dnsZmFxtP5lBdnDJJcMNqddFrdR1eRkFNxTrtqFKjUIf0Lmy1v4i7UttxC2mVzieoAWc8CxLGeC+0xRLxlq0Mu4qlcft4UmrYHeFPcbhi5oapQVuZ8MiZKqzt/tjvIGEH0QjYAPY//QevpzZQymnYS+DqPvbCYqDr/wi5Ta2xQRAXhZOS4myBqMVlNFEKnwsW7sKODuMi9AT90Qs3lKKeaY4QAv4bG2p4wqW9nTWlSPVAhYOIW5Nq9E0v36kB/ist9IIqLWnrF8sLD1D7TaSTVEFWCbPfmjMgOVsv6jJz2l1HhSjN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(86362001)(6512007)(6486002)(36756003)(186003)(38100700002)(2616005)(6506007)(26005)(66556008)(4326008)(6916009)(66476007)(66946007)(316002)(2906002)(5660300002)(7416002)(41300700001)(8676002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z40oc5ewkQmKYph3UWJj1EtIdef73HFKU2CQ4nQ92EkjwG0D/bgXwXOhCjet?=
 =?us-ascii?Q?dPI+B49mwhQeKdGgJNsljKrdQGs1r3MChhRHwxWuuoyQo5k8Ou8kjPk48Ohu?=
 =?us-ascii?Q?VIZuABZ1rTOV0jdJ6U5bI2zAssqnPN1F4E0LfBCXORiEvizWRDtxXsKigz6C?=
 =?us-ascii?Q?JJsJ/jo49A5+Ox4aOWKrb22ZwyLQF68+URaCA20GfyWZ1CO8D0/+fWewXRXp?=
 =?us-ascii?Q?J+Q0SdXM02LC6EGsxWVUhQGJe0OLGOzsLVjAbvdcPS3mFpwVU7VGeS7PKsPZ?=
 =?us-ascii?Q?Oyo8XoCs9kLzwkpdvPA/4TORo5FceaTtD0BZYxcjfxXcc8Ct42BlEbu42o7O?=
 =?us-ascii?Q?3mFNpOVF6Tj4FZaeFWMjiwFVckDyh6JchqwbMxq97EA4+ju6dThmbIhy0AaL?=
 =?us-ascii?Q?kim4/bf0AQ7X2iRLz1tHJAThHqcxKkJ5oRX0bsCn/TquDQsb5qwxWjKEiOZs?=
 =?us-ascii?Q?q8OlHZ9H6P9XWSFB8AlJ/fsewsyx27DTpHaUy4mhsxI6uORSZTdeE28nrf25?=
 =?us-ascii?Q?qzGJ3WGKh8jdPl35aV0mLkUrJ6n0aUnmmS6hXUZdVG5u55qXImsEGsQ2iKcb?=
 =?us-ascii?Q?/qQFzydDUo/v77QqqZwxNYMmJB4u38Qb8Fz0k1LfneY5hr+kkNIOMwwE7yIP?=
 =?us-ascii?Q?JYL+gVwsgxUUOOTLd72cgP1JHYDXI47lACHO7sDsu2ndn2/Z7lHmrSfTRPMA?=
 =?us-ascii?Q?21f7t0sBrOR1ydHJwhOmMTTs4mieKtcRtXhEyM4gTA+/kv6GSbXD97Uqcd+P?=
 =?us-ascii?Q?rx+GmDnzCTmA2dYqp/+KAYARzQl+S7vytMsEkzc3fqWMEJ4zCs6oJq0TwRAh?=
 =?us-ascii?Q?GUC1SGn7M/cD3iXwDgH3AwAqLu4wSpX2ADI+1LxMWy4T5uPUZESFrkRzS3bS?=
 =?us-ascii?Q?jxwMEXso/RIkjJsACTUeMWwhIN3pfc9nzPad9VIzv3YQBO5bx2n1bBjhQplu?=
 =?us-ascii?Q?ffkAQlFL4XcafH8mSkHWBsrwcpNyjBvR6gVKEWxV099BQVTAPM7obHkOBLfb?=
 =?us-ascii?Q?zsahY/VQ9LKgrkfKnyNsFpfqIUX4ViunoKUfo6u9rwc/WpEATL7OBMliIeNT?=
 =?us-ascii?Q?CwSu1aHY2odHEu/aRnyOf5CI8FkS7IKsFtQsWI2IwmZuw5Zb+jvJDWnIFi+H?=
 =?us-ascii?Q?HOdqMau1u8ImPwXCSMlqFiN5ALIpgYUrR4MApK5IOdsFLtBoPnpcC2b2SL5r?=
 =?us-ascii?Q?gv/+kcxbc7GWlc20BGZb+q7mCbfCAnyv+Zw+iEm+5gtBQaBylGyIDdIqxIel?=
 =?us-ascii?Q?52sXFaSpuFVgFO0zTg+WIA8XPXP5HDOjRDYYAXtkL7GsRX4oAzTGSC/F9opj?=
 =?us-ascii?Q?sG2eviN8QOGYYfbwBz34Q+8Pm8fQMdvOxS3UVQtgSwYEZeoxsEfj4JRftn5A?=
 =?us-ascii?Q?lgL1sZzavHLT3Mq/KxbQBhviiZsfeLAmBYby1nKV/oTHZvz3T4CSfe44QFny?=
 =?us-ascii?Q?kAMAoe8l7aA0t8Rh9Hw8N4NUPbrw6I/G9pG/uLZdS75C4hLrBmFHROSrfbGB?=
 =?us-ascii?Q?p0eFusbxQo3AlUmTly/msH4YEsDe3xeXRp16BLf5VWCs4ubj+5cN5rRYcOFx?=
 =?us-ascii?Q?/kdDPE6HEO8ykKeGBZ1UMs4JaIL6qwdmTUdZ5spV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44abea2-e965-4769-636c-08db8f93e69a
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:55:59.7478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eobb3c3ThPk96H1/EXsPAg3aAZ2pFhsYMnLxTTq2HgK+LlGccpSytn78k3WwC8BA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6590
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 04:03:57AM -0700, Yi Liu wrote:

> +	switch (pt_obj->type) {
> +	case IOMMUFD_OBJ_IOAS:
> +		ioas = container_of(pt_obj, struct iommufd_ioas, obj);
> +		break;
> +	case IOMMUFD_OBJ_HW_PAGETABLE:
> +		/* pt_id points HWPT only when hwpt_type is !IOMMU_HWPT_TYPE_DEFAULT */
> +		if (cmd->hwpt_type == IOMMU_HWPT_TYPE_DEFAULT) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
> +
> +		parent = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
> +		/*
> +		 * Cannot allocate user-managed hwpt linking to auto_created
> +		 * hwpt. If the parent hwpt is already a user-managed hwpt,
> +		 * don't allocate another user-managed hwpt linking to it.
> +		 */
> +		if (parent->auto_domain || parent->parent) {
> +			rc = -EINVAL;
> +			goto out_put_pt;
> +		}
> +		ioas = parent->ioas;

Why do we set ioas here? I would think it should be NULL.

I think it is looking like a mistake to try and re-use
iommufd_hw_pagetable_alloc() directly for the nested case. It should
not have a IOAS argument, it should not do enforce_cc, or iopt_*
functions

So must of the function is removed. Probably better to make a new
ioas-less function for the nesting case.

> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 510db114fc61..5f4420626421 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -426,7 +426,7 @@ static const struct iommufd_ioctl_op iommufd_ioctl_ops[] = {
>  	IOCTL_OP(IOMMU_GET_HW_INFO, iommufd_get_hw_info, struct iommu_hw_info,
>  		 __reserved),
>  	IOCTL_OP(IOMMU_HWPT_ALLOC, iommufd_hwpt_alloc, struct iommu_hwpt_alloc,
> -		 __reserved),
> +		 data_uptr),

Nono, these can never change once we put them it. It specifies the
hard minimum size that userspace must provide. If userspace gives less
than this then the ioctl always fails. Changing it breaks all the
existing software.

The core code ensures that the trailing part of the cmd struct is
zero'd the extended implementation must cope with Zero'd values, which
this does.

> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index f2026cde2d64..73bf9af91e99 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -364,12 +364,27 @@ enum iommu_hwpt_type {
>   * @pt_id: The IOAS to connect this HWPT to
>   * @out_hwpt_id: The ID of the new HWPT
>   * @__reserved: Must be 0
> + * @hwpt_type: One of enum iommu_hwpt_type
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
>   *
>   * Explicitly allocate a hardware page table object. This is the same object
>   * type that is returned by iommufd_device_attach() and represents the
>   * underlying iommu driver's iommu_domain kernel object.
>   *
> - * A HWPT will be created with the IOVA mappings from the given IOAS.
> + * A kernel-managed HWPT will be created with the mappings from the given
> + * IOAS via the @pt_id. The @hwpt_type for this allocation can be set to
> + * either IOMMU_HWPT_TYPE_DEFAULT or a pre-defined type corresponding to
> + * an I/O page table type supported by the underlying IOMMU hardware.


> + * A user-managed HWPT will be created from a given parent HWPT via the
> + * @pt_id, in which the parent HWPT must be allocated previously via the
> + * same ioctl from a given IOAS (@pt_id). In this case, the @hwpt_type
> + * must be set to a pre-defined type corresponding to an I/O page table
> + * type supported by the underlying IOMMU hardware.
> + *
> + * If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT, both the @data_len
> + * and the @data_uptr will be ignored. Otherwise, both must be
> given.

 If the @hwpt_type is set to IOMMU_HWPT_TYPE_DEFAULT then @data_len
 must be zero.

Jason
