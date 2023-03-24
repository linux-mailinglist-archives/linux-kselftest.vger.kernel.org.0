Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385996C80A6
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 16:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjCXPCu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 11:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjCXPCs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 11:02:48 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EB01A669;
        Fri, 24 Mar 2023 08:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epwFUcKaES1lVxW75anRIQ6U055JVCY48S9x6sFmCCodSPjVe7lqy4V1hkxaj4sRl4GsUy2f5tTXOFMu+I5Q2ChrlA11IdaodjJDd5itTQlDp+o9vgK+d1NsVs0kNuwyj/HZwLrMgE+VtRWEo7oOBHenLzFTQqkUTAPBA0QNEeqzIYxKT7+JMKqAWFrKZhhRM376W3ebtTnr6h9GH0HPQgVcM27UUG0hvDeu9t+NBVvNSNn8l/RhVNcLkBP9y3XJPdykiFddjB3AKRHm02IvoWhIb2HWk0G75mPwDcdMU7RoyY3d2pFq2VOBxk41XmECIe/XbcMuNiHERxYGTrLwag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Hl/4dQaKckbhoFe/+2JxxgSH6/DtUTV7RGVfFCyVzc=;
 b=dxm7E16cTI1G1VVV+rXhcZOeYvR12wTEqDz8Wx5NWuqw0yf5PxNjj96Ioyxo6XuT51+72o6cbsEIuCAo6zJZ4EufAkIBdyWvnsBxr75sQukoeAaJaOoD9Lvl+E/ranNWlnenM2pxWXnFcmGDVf7qANen8j2tjeNEZnJO4kJRttDjIL0N/3t8BffW47Y5iHlNjxBJb8OiNR3YMwDdKKyp/oJCry1BKNN6QnxiDpIhCTntKnSowleJ35wGmebG4i4DXGjNkFQjybAXcaYIHc+uTHoyl2yg4V4H3kyRqi/ltWDeC21mbEPpJ2nPGzzcIkmdG0RNjIAoZSt0UI2rAjFJ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Hl/4dQaKckbhoFe/+2JxxgSH6/DtUTV7RGVfFCyVzc=;
 b=dCXF3Xd4lU4J9GiwuSQ9l8A9IaWuFY0r7UiyRZ6egqdzW8MmripRp13ZYa+WgITLT51fSFUne3W1iJFQvA25f8IbrwReQPc5Qar9lqpSvlvYnRDIm6zAcOVXahGBHisx+KIqoGVyfJc23FV+hVeNlYa0dFVjb6umnyeoc/hJ3DmBKXkKEMM5eIKs/lvgoIvuEr3WKFOqSNQbZmA2x6EEtG9f37AenP/zQXc9lrSDChfJfwKcLqH2u/XGL00nHY+hYoBjVDg5WjxhPFAp2Z82XNKgC+8za/+JbMyUsQqcIpT2UVVgHVPejHzkfEXhgrWD5MX9Ly6mzf+wRWpl7oocuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 15:02:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Fri, 24 Mar 2023
 15:02:45 +0000
Date:   Fri, 24 Mar 2023 12:02:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Nicolin Chen <nicolinc@nvidia.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v3 03/17] iommufd: Replace the hwpt->devices list with
 iommufd_group
Message-ID: <ZB27ke/vQxsCngtC@nvidia.com>
References: <0-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <3-v3-61d41fd9e13e+1f5-iommufd_alloc_jgg@nvidia.com>
 <BN9PR11MB5276E42B629C3E5AF019B6748C879@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZBxg9cRIpsozB15G@nvidia.com>
 <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB52767DA03C240F040929A2398C849@BN9PR11MB5276.namprd11.prod.outlook.com>
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6873:EE_
X-MS-Office365-Filtering-Correlation-Id: 48e92ea2-360f-4b3d-dda2-08db2c78d2dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k7C3pejkQtljnXrfLF0N6FtLwxi3x9BhLzYi+cKFfmr7HLXqBdEqJ3ejoNSfdaI4SKeK9KuoriptGA+6JqzMwXgG+jE75AHHsJCWd0i3Uod3BYMq8v96LHo2ipFV5VWLpGV7W2ebrQ7b/L0Q+yGDm898N8eY9fYYmwS/ziwl5jM/5LqUICw2q1KXZViNtGj0nKkvMPcjvpujtvc/BHxa9vhhf+a5Uw2nFyCFcm4sEq7Z/We3J1LAKkDrXCu7chlXajqSP5endDpoMt7fq4USVMFGfb/+gy3upKPEkfpyFfePMf7YEEw6b0nRbUwjygN2Z5PT1xnmcKDut3B2VTV0c0S02kcPdkripsePxq0cmuSA8splD+kSof02vO3nCLKGJk8am6+p68AbOjuv4epMonwIb3SWkkXn9LHXRF7gb+j7EqHW0eKHhMTDGLhnH15JYYpuK3ATiHktFGQg7GQHTDoN3A273YgB4jnqsuXYX+Ze0hbzx9PRlxa1E/py1PTpuH7C5GAc79R4/2B0M9eUUTFJmtGJEpGP/mn3+7MFZrX4FwiEO7frWOR7An+hczIK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(451199018)(36756003)(66946007)(8676002)(66476007)(4326008)(8936002)(41300700001)(66556008)(6916009)(6486002)(316002)(478600001)(54906003)(5660300002)(2906002)(86362001)(38100700002)(6506007)(83380400001)(6512007)(186003)(26005)(6666004)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aelACDCOgPWtwM3esJIUTSY3hputRmUbj0wt2sOyE08Uwq0WLYcJZTiROtRI?=
 =?us-ascii?Q?l36M265DmJSbNe98rwtmLUrm0iM09jkSD7wfXoqCcPRVJeS8Vh02ciLOTMhB?=
 =?us-ascii?Q?ote5yg4faPPVhWf4mIV37eU8gim5Gt7zlhyQ1qCWzelPOg2DRgDIrfsmh/0Y?=
 =?us-ascii?Q?AuWkmmX0ieFOYt9niP7t+ZGd0OKJqnzjahMdMqn2vCGqD+RJY9FUhdRkh5EC?=
 =?us-ascii?Q?bXoD+DBo4oYYFx6AkF7EqsRagZHi5jEOPKtNSRR8yeSAC+q3Wch9lnx1ojy0?=
 =?us-ascii?Q?5kbwRAUkp3SZwxcBW48tmQ6TiRSAFUa04DiXuMQ3KozIjPQiMfJvHcTvuW3O?=
 =?us-ascii?Q?X6tOJCxHhEvJm7booMxFekn2I2acebarZ5xrgaKpJoOQozxZ5KQilGPKJ40N?=
 =?us-ascii?Q?yIRtKwrJJunhq3KJlycfdJROs4le1LI2c9wWwzJPyNqUVjK+wqSSNPPqL26U?=
 =?us-ascii?Q?In84+y706HXgkUAtbKCIUlzngVXZYfdJHy2cFRxqjO01HLwKxPIKa/IpNYnG?=
 =?us-ascii?Q?1V/kzt8+lzB4OUNTvuB7zEFRHVt+T7PpQBlKNHSVLKvjCgNyRy+pxjsd9OaO?=
 =?us-ascii?Q?VSQqyB7r6UwDrPEi0ZwgbRIuaWHzkn/XNrN+rfpq47i8dn363BfjjRdFS8nM?=
 =?us-ascii?Q?7LN47iyYl89EnUFF5UBDXz58Y45KiapaeZKA0sNYthCFSoKg+trQr+6JZnVh?=
 =?us-ascii?Q?AONdjRW5jaNkKFVuiwhHosN4ZwaBpZ9R4JYr1RCijUc7wbu7N9EahMwVYZ8m?=
 =?us-ascii?Q?hBQ4XAbbVPviS5tDB6WsIFM/9d65ko81A05+Uh48kD4NfYfkHOfHJJMNRrZO?=
 =?us-ascii?Q?muQxUljJHR4SsL55oF56MWtsoj7xIKvvseuwqZe2HoxXCGZxvMe02zvm0Xnq?=
 =?us-ascii?Q?YVhYBKpSoaGwflpxSU8LYV57dg+FKtwD7ZaZDSx7Lcl5t39jg8qz44yRA7vn?=
 =?us-ascii?Q?ShST6g6FTrGjKMsrjh0iYqOo1t1p70Ndz/+H9dNzyzu5pFF2dc7YG67u+kMv?=
 =?us-ascii?Q?9A8m4Xkjjg+coleyjaQsRUqZ+nwtlfhkGfSLFpzJh6Cz+4K84JQbdPnjUg/q?=
 =?us-ascii?Q?4T7bVhAgCUDKB3cOqBA7JJnNrWUdS0a0fwLZ38JJzrNtJIH+hNpE7/ofVw82?=
 =?us-ascii?Q?Yi3zDtEHRYpyOkxY0VsuezFwL/drUmIP5ZppV1myFErqlMtfm0Q69KbB8UZD?=
 =?us-ascii?Q?/lW0aDDoVtnf57XxrMNWu2Yl1WY8Isu5VV93hRcPkcSwg1ASV4OJN5j3ArN+?=
 =?us-ascii?Q?eMaHKgisKP0znVkhXACDSLui9wCd5ZK42nacit50ZZn0ruYPb5cXTf/N5LW2?=
 =?us-ascii?Q?Nw07XAsm6crIqdxodonssgZllxM8pkfH5lbBizg431GGCr6S5wRjjTE34QQN?=
 =?us-ascii?Q?QyDJa+v6fUUZ4iSyYaz1XLrKyIvwT1ce7bpyYtpsOFU7BDkThzTB2gZE20Lf?=
 =?us-ascii?Q?CiD6Tt8fPP+XiF+3hbFuJJ2WaKaoyvXJMUTWZBN9oSYmhKDFgkJCvlqV7XxG?=
 =?us-ascii?Q?4Wzo6pMdVYhlT3ksGlpzm2CoG+dPsBw9d8j6RkcZUXybTLmmwMmgOqYbuDcY?=
 =?us-ascii?Q?/BNUfTZdc2KRlB42u10Ly/wrbp4bi0b/sXTZuzGJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48e92ea2-360f-4b3d-dda2-08db2c78d2dd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 15:02:45.0697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNEwThg0Sd4k0DV8n2y9jehr2HwKXTKvRMZl15r5xy2tpom+H85JOWe0U8tMuw7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6873
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Mar 24, 2023 at 01:37:51AM +0000, Tian, Kevin wrote:

> If vfio races attach/detach then lots of things are messed.
> 
> e.g. iommufd_device_detach() directly calls list_del(&idev->group_item)
> w/o checking whether the device has been attached.

Yeah, you obviously can't race attach/detach or detach/replace

> And with that race UAF could occur if we narrow down the lock scope
> to iommufd_hw_pagetable_attach():
> 
>               cpu0                                cpu1
> vfio_iommufd_attach()
>   iommufd_device_attach()
>     iommufd_device_auto_get_domain()
>       mutex_lock(&ioas->mutex);
>       iommufd_hw_pagetable_alloc()
>         hwpt = iommufd_object_alloc() //hwpt.users=1
>         hwpt->domain = iommu_domain_alloc(idev->dev->bus);
>         iommufd_hw_pagetable_attach() //hwpt.users=2
>                                           vfio_iommufd_detach()
>                                             iommufd_device_detach()
>                                               mutex_lock(&idev->igroup->lock);
>                                               hwpt = iommufd_hw_pagetable_detach()
>                                               mutex_unlock(&idev->igroup->lock);
>                                               iommufd_hw_pagetable_put(hwpt)
>                                                 iommufd_object_destroy_user(hwpt) //hwpt.users=0
>                                                   iommufd_hw_pagetable_destroy(hwpt)
>                                                     iommu_domain_free(hwpt->domain);
>         iopt_table_add_domain(&hwpt->ioas->iopt, hwpt->domain); //UAF

You didn't balance the refcounts properly, the cpu1 put will get to
hwpt.users=1

There is a refcount_inc in iommufd_hw_pagetable_attach(), the
iommufd_hw_pagetable_alloc() retains its reference and so the domain
is guarenteed valid

Jason
