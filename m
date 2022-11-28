Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A1463B1B1
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 19:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiK1S4W (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 13:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiK1S4V (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 13:56:21 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F67B20189;
        Mon, 28 Nov 2022 10:56:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkB4KJ4nXj61F7AN0L7wwO9HqWFZyrTbAognkTOfBNf40b+cIN0mZ3SsjLm484HacI6s6WsHgDBC2myYRbIHubZUClaL3fKE6VC54GU3tJvTZtaIzkM2s04FdcvPC2yRMrRDpJrNKrorAqub06I7R8ru7l3B9O/y/r2w8mxSzrxIDnRx6DK7Pcg7C9dpvYHyT/Y1mzm7YoRm5w7CakwcXNdBd+vlZ0CTWuxtvt+wbHMZRF89WEdYXDRf8ZH9EDB6zGwatcKAEONEk9G+KAtJ9p/BflwCqvJqYwWVjT9dLIWYSGgLm+MkTA6vbCEEPv/ME6KJ4zlSdy/mxK5jPAMSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3E9JaZxyl71ozPTYkGyLzac8DBpc90zVq83YJtx1U4=;
 b=BEM/fhiIdRZEBFwpjZxIU1nYAi4yp9ubOocFaVgN9tX/RRht99nGSob9g1wyoiJJYPvEm5KDFc0hSYjzvz2sv+fyhE2Ku8pJypA/BKeZvfsilelXV6Emhgs9C0UJ/VVbJCphIMlU0+6kueUWunnZxtr7JaxhtZVytzCs+IissYtbz5ZE59h53dW0L/mPfltWtiMge5roexFuFYvYdDqHvPpN1qInXKAzDuMl6euybGSo6/NUtMmjanaqYLGaw2lBBkIJESVvRuscpEN046730TtCdJPj5bKfpTsxpwK+WlhnXAGdmwDUKjd9ae2CAXQFL9gFQDqgTmDnNJTd253wWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3E9JaZxyl71ozPTYkGyLzac8DBpc90zVq83YJtx1U4=;
 b=XeDlZ3vFIRUcqBBoILMyu4Be/RIEUBPmNTzQW6QRXfkDZBz4GVeynfeTt7JoTYU6vT0BVXSTHwdcG8Mo+Jt+zEdh/iXsU/dIS4o8nmu1rCR5nWDiTNU+RYLyMgeXQHcWiXFU0XBA04L8NbZJolZho3pSHjll5ic0hWRntpWcHqCCrZJt1hvGkTZal2zyRNfdbuNgjGZKvDtQY00xCazrHwS2vEAcFCk4TK9NE+y/eLzQoL0/MjqY7bPyqpXH7TlWkka4AfZ/R9YIXN3LaKrZcDOWvN7uaGrEf5DDHdhj65MkUfjd171MdKE6Th0gYU+F3IRyUhgbCSQp6xMfTkQUXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Mon, 28 Nov
 2022 18:56:18 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%9]) with mapi id 15.20.5857.021; Mon, 28 Nov 2022
 18:56:18 +0000
Date:   Mon, 28 Nov 2022 14:56:17 -0400
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
Subject: Re: [PATCH v5 14/19] iommufd: Add kAPI toward external drivers for
 kernel access
Message-ID: <Y4UEUXO09YeKhrtt@nvidia.com>
References: <14-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <44ea1bad-500c-b4a5-c2a5-e7bc79de2394@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44ea1bad-500c-b4a5-c2a5-e7bc79de2394@redhat.com>
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3ce07d-de11-4b53-f577-08dad1723ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OacnhGe6lfBbXa842ihuU5k6On7d/W+Fa5K4L46HdzDFyI67lKLyvD6h7ljWNcMhcTU4oaBz7Ql8NUVSOI21R4R+diGOiPxmFwG+SgrSZHySJjMfL6f/ev5FwnlHEA0mU7/0d4aPUgji2X3uM80Xpx8EBUTC8ldKW7NFA8sEc2SR4I8sR3Wpvahjc6vkiBcmszp1J+aTrd/cIj/FO96/iHB214ec1774OOVMamVYvZVlH6RomVMFLSmWk+lWZZZo8UMI1IqrA0SCc4LFS6TUcV0HBWkBJfM2su6DoNsxAKCpPvn7Fa7RVOX23/3jMFFRrcsnQBWia9gHV6z3aCLoNq70Qaz/VYhbuwyoYI2Kbd3eeSVVVy4Xbwto5L2MbilVsANK8W83zipI/sSClZ7QTWr4+4YNdZ9/MfY+YwCqmTAtgAMFrTiul8MQcy4tJimhkPq356vNqejXLHbETMfaUvkDF6nHz3MszqOYNMRUA/FS0QQB3Bj3BJku0nKDKGnfoBHZdQtux8IIYGIfZzWyz+3XaulHIWMwshaZyIbAWqM8mi9unNwB/v7uB7OiQpwf0561iUX2CGdTdWv5nN84l/ExY8aZocFM6ALRIWjXz/M8hHgQzaHv2HxurNI/WrIuRcje2Olgtadcf3JCrQx3WQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(451199015)(38100700002)(6486002)(66946007)(66556008)(66476007)(4326008)(41300700001)(36756003)(478600001)(7406005)(2906002)(8676002)(6916009)(54906003)(316002)(7416002)(5660300002)(8936002)(86362001)(2616005)(83380400001)(186003)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NNohlT/TzauimAgW4UVfsuUOG5HqKswu9H7Mxkof2NZoD8d3vkmqxhnp6FVI?=
 =?us-ascii?Q?PypMk5eLZteZ7d36gPPo5BZIJU4r2q/btNWtLf3iVGksl/XCCrRihf8VfLD9?=
 =?us-ascii?Q?TIuz6yeSzU3EyEJXt+2xtpJncZ+xD9oWFn/AvNtfUnxYjx/OkgaG36fGvUR7?=
 =?us-ascii?Q?F7Xug+gG3/u26DNWDWQRhCQaKEr3ppcnrPCHxP2OJggkGNcpJFVzi3nH0jiA?=
 =?us-ascii?Q?/sgW2nNZPyrR3OcSVNqALQ9YOHOBYY15nLs9s31xIVoczGo5frc1XwY1F0Zg?=
 =?us-ascii?Q?UGWYsDCDAZ02CwPFWKFDcQn9ty4VAv0EBIUsyvnMGvo1a9XhlmQWzbfWq3iF?=
 =?us-ascii?Q?jVAIJgfpYyxS4JBvveooHyadQ86ecCUyzJkN87EIOJnOKtWO2jyWNqpATWSF?=
 =?us-ascii?Q?iUZ6JrxSw6GS0VzE3rBeJVycQ967P4JuiwFqdBsPsCfkKra8ewqBq8oNb3ok?=
 =?us-ascii?Q?Z5/EVm2VndWhNskLID48DQ5v4L5ZMxcKj6faAXdepCGVTqsKKdJ7V2p58V9M?=
 =?us-ascii?Q?RFIQMeNptefXd0DigcYqKP6v/mUFPrXtdahTnBoZHt38TwfHy4yt/TZ6vmHm?=
 =?us-ascii?Q?tSxZVJTnOqqCJvsTuXwSpuoXUzh61iWgnIq7pQzrIH0AR56uCv/tG5QrgXJi?=
 =?us-ascii?Q?OVT2EbQU99YQaWbEjOu/ydD78a9nkm7SuZQJUU2/vEBa3xkIlrCjpiAlqaWN?=
 =?us-ascii?Q?Ish73LMUyGMGMPfIuEM/zGigrD8zF81LnIUjwqgxzKjKgQbGISE/sKJ7Fd9I?=
 =?us-ascii?Q?GGoGpNcR1pUCHa5yz2wa8xw7mZ+rtGvdl7jQ2/eaz5zTYtdpxuY0e7PVburP?=
 =?us-ascii?Q?HCi25JwZnfyPn3eJdoX788ivB7hfTMhdSbZdprMGjLEmvJJzEFJd7VzuIijS?=
 =?us-ascii?Q?rXElAunChh7EIDrAio93q8ZPu4Yq7fM1pMCBe8NNJ7zSxO9CE/uTkrMhoJMR?=
 =?us-ascii?Q?vC30zbOu5e7s8xpCjIZeDGEBu0Z4tBxGOGWf3Fu7tjpEKahnDkTb3Hnqcl7T?=
 =?us-ascii?Q?asRihY9MOthUDieFSe3hs1ClSGGA9Qf761RPD7YoCThafn2hOnKLAouhu4Hd?=
 =?us-ascii?Q?aN2n4eBQLbCzKIbeEYMoxWtLbwMA/S+iPZZ+ymrOLrS4XZTwH6dk7YorJ0NR?=
 =?us-ascii?Q?CiT7v6001rXwYQkNMxwuy0c2iNJed9q4wsOMFhAwGf1+x9NChYkqhgm/75S/?=
 =?us-ascii?Q?gE6bt9LYC38ZMuQOkKsVReuw6mJ7AFJFhynC9k6/wE27TWTiXeGcMVnuYIoR?=
 =?us-ascii?Q?yNWBmLYfRqxcOk6eryrPzT29Aq+7hvIfdo/O4kO68MU+6ID4URsRO3B2r7gE?=
 =?us-ascii?Q?gUZKjU+S0R1gM2p3O8IU8H/8zc5quot2NbR9R6TYZVWYaoRwnW4N9SXiT9aP?=
 =?us-ascii?Q?SZ6GucU6c83sPd5jefAbxIDy8sC9G7H1BZEl13HkFXcPhr50HsP8iJ9i2axp?=
 =?us-ascii?Q?qbPc90PXyWxMuGpLhbAwajePxab8QVC5AVFX1jImItxgohhCQMD/4hdh1PWP?=
 =?us-ascii?Q?4IaWzZW4ThJ9pEUdlrpXGmS3ynJ6VnTBazwnWF5XIrZ48V5eaA5mZouGqLuo?=
 =?us-ascii?Q?oMO5cFnJpByfpBAMZwc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3ce07d-de11-4b53-f577-08dad1723ba6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2022 18:56:18.5495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gU5zgA710HtwL/zBRizcTljRKB1270Y3m0XQqAgZuYCB2LfK/0gVzp5qWohgQez
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 28, 2022 at 04:48:58PM +0100, Eric Auger wrote:
> > +/**
> > + * iommufd_access_notify_unmap - Notify users of an iopt to stop using it
> > + * @iopt: iopt to work on
> > + * @iova: Starting iova in the iopt
> > + * @length: Number of bytes
> > + *
> > + * After this function returns there should be no users attached to the pages
> > + * linked to this iopt that intersect with iova,length. Anyone that has attached
> > + * a user through iopt_access_pages() needs to detatch it through
> detach
> > + * iommufd_access_unpin_pages() before this function returns.
> > + *
> > + * The unmap callback may not call or wait for a iommufd_access_destroy() to
> > + * complete. Once iommufd_access_destroy() returns no ops are running and no
> > + * future ops will be called.
> I don't understand the above sentence. Is that related to the
> 
> +		if (!iommufd_lock_obj(&access->obj))
> +			continue;
> 
> where is the unmap() called in that case?

It is basically saying a driver cannot write this:

unmap():
  mutex_lock(lock)
   iommufd_access_unpin_pages(access)
  mutex_unlock(lock)

driver_close
  mutex_lock(lock)
   iommufd_access_destroy(access)
  mutex_unlock(lock)

Or any other equivalent thing. How about

 * iommufd_access_destroy() will wait for any outstanding unmap callback to
 * complete. Once iommufd_access_destroy() no unmap ops are running or will
 * run in the future. Due to this a driver must not create locking that prevents
 * unmap to complete while iommufd_access_destroy() is running.

And I should really add a lockdep map here, which I will add as a
followup patch:

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index de1babd56af156..d2b8e33ffaa0d7 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -5,6 +5,7 @@
 #include <linux/slab.h>
 #include <linux/iommu.h>
 #include <linux/irqdomain.h>
+#include <linux/lockdep.h>
 
 #include "io_pagetable.h"
 #include "iommufd_private.h"
@@ -501,6 +502,15 @@ void iommufd_access_destroy(struct iommufd_access *access)
 {
 	bool was_destroyed;
 
+	/*
+	 * Alert lockdep that this cannot become entangled with an unmap
+	 * callback, or we will have deadlock.
+	 */
+#ifdef CONFIG_LOCKDEP
+	lock_acquire_exclusive(&access->ioas->iopt.unmap_map, 0, 0, NULL, _RET_IP_);
+	lock_release(&access->ioas->iopt.unmap_map, _RET_IP_);
+#endif
+
 	was_destroyed = iommufd_object_destroy_user(access->ictx, &access->obj);
 	WARN_ON(!was_destroyed);
 }
diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index 3467cea795684c..d858cc7f241fd0 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -460,6 +460,9 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	unsigned long unmapped_bytes = 0;
 	int rc = -ENOENT;
 
+#ifdef CONFIG_LOCKDEP
+	lock_acquire(&iopt->unmap_map, 0, 0, NULL, _RET_IP_);
+#endif
 	/*
 	 * The domains_rwsem must be held in read mode any time any area->pages
 	 * is NULL. This prevents domain attach/detatch from running
@@ -521,6 +524,10 @@ static int iopt_unmap_iova_range(struct io_pagetable *iopt, unsigned long start,
 	up_read(&iopt->domains_rwsem);
 	if (unmapped)
 		*unmapped = unmapped_bytes;
+
+#ifdef CONFIG_LOCKDEP
+	lock_release(&iopt->unmap_map, _RET_IP_);
+#endif
 	return rc;
 }
 
@@ -643,6 +650,14 @@ void iopt_init_table(struct io_pagetable *iopt)
 	 * restriction.
 	 */
 	iopt->iova_alignment = 1;
+
+#ifdef CONFIG_LOCKDEP
+	{
+		static struct lock_class_key key;
+
+		lockdep_init_map(&iopt->unmap_map, "access_unmap", &key, 0);
+	}
+#endif
 }
 
 void iopt_destroy_table(struct io_pagetable *iopt)
diff --git a/drivers/iommu/iommufd/iommufd_private.h b/drivers/iommu/iommufd/iommufd_private.h
index 222e86591f8ac9..8fb8e53ee0d3d3 100644
--- a/drivers/iommu/iommufd/iommufd_private.h
+++ b/drivers/iommu/iommufd/iommufd_private.h
@@ -45,6 +45,10 @@ struct io_pagetable {
 	struct rb_root_cached reserved_itree;
 	u8 disable_large_pages;
 	unsigned long iova_alignment;
+
+#ifdef CONFIG_LOCKDEP
+	struct lockdep_map unmap_map;
+#endif
 };
 
 void iopt_init_table(struct io_pagetable *iopt);

> > +/**
> > + * iommufd_access_pin_pages() - Return a list of pages under the iova
> > + * @access: IOAS access to act on
> > + * @iova: Starting IOVA
> > + * @length: Number of bytes to access
> > + * @out_pages: Output page list
> > + * @flags: IOPMMUFD_ACCESS_RW_* flags
> > + *
> > + * Reads @length bytes starting at iova and returns the struct page * pointers.
> > + * These can be kmap'd by the caller for CPU access.
> > + *
> > + * The caller must perform iopt_unaccess_pages() when done to balance this.
> this function does not exist

iommufd_access_unpin_pages()

Thanks,
Jason
