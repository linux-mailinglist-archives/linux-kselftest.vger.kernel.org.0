Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2262FEB3
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Nov 2022 21:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiKRUXG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Nov 2022 15:23:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiKRUXF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Nov 2022 15:23:05 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18459179;
        Fri, 18 Nov 2022 12:23:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhKMA1OiDwIudxe38VTkwydqU69gIKO6ERkX2XUijfDgpSmmhQc9Jwtw8yK5QFXoACegzI8OC2E/Jwvk59uuAn6KtMQhP6tFgPkl3gENYXb4aKbLC9nnALK3/AT9tnA2SwZI6Hje1luBcmDrTE+/luSVhUkCg7KK+ePO+x1xR6J5eH+sMzvklVn3Kf+zUVGToNfFIKIjRWnt7lMo39gJLDgistBKbRH6vZ5ZZnNCUzztvE2y3vedPuYtI4gcWLHqoIhgTzDPrWBkqaGnk4M0BA8G3cfXBy1PJU5ZYeX1ZuBhmlXpLmtQZDHr0DG+EE92C3A71DzCAjRuN1zxBXNJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJUQ+WOfo7c01X3xhBLRMbIWkE6hAuPEP6BznAjGReg=;
 b=E7ACd6F+VXGv9pW2unJAD8S1E6ai9EPG29NztI34ZSfGcQ1nWsZl0DOcgbNGaOCafTDYXFqnjbblFFlGt7/YXdfbGMrhf2F9Dtc8F45qxCJI4JPZ0rliFW5pH+Ii2M7/ntIPd9y+cbLcrXp9VlNqwLOjzzHE+S+UyQy6FtbsGZ4zomjxflChVE+Evr8HjaodENraHZP7emX1rBTatvBrMxBcMXWGMi3iWwsTtgdNf3jtCYz3Haie8IuSfcrVU182vBuHzEwQ/IKELy2CSHemfP6FVcF/4MGtzGeSbsZhHYSdChsPsZN1LOzNGFcpWGMZXmW5I64Hlss5j0MJXlo5cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJUQ+WOfo7c01X3xhBLRMbIWkE6hAuPEP6BznAjGReg=;
 b=WJ1q/zKRy7ZI1nhhbIu/Ypf5/03GRMng5Bv3E8sUgFEwG9kkf/r7R/XIA4+uvlGrUSjzCEs4lIu5Ke+BRcJipoSuZkBNqZbFxov7lMn+Ljb2bRRuwNGteDtb7VToEpuQWtXJfUxEyaFSgEfRHHLw0oZsVfNCzzEYu/8Hp4mH6Zsbm5OcXspmpRwZj2wiM2jgu9KRdThw2k0zMRZ/UHPfIjrxqGl8+fViOnZ6xXJYH1oeecEmwB+1nGXNsCnBf7sGFHLtY+/Yti4d921CZmRPh/i6emsAgF7aicFmzE6GfgRKBUvIXYEdCuXFQMlMQq9nEUgv+zwRiVCoj+00T/3zwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Fri, 18 Nov
 2022 20:23:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Fri, 18 Nov 2022
 20:23:01 +0000
Date:   Fri, 18 Nov 2022 16:23:00 -0400
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
Subject: Re: [PATCH v5 06/19] iommufd: File descriptor, context, kconfig and
 makefiles
Message-ID: <Y3fppPM9mCm6xIz6@nvidia.com>
References: <6-v5-4001c2997bd0+30c-iommufd_jgg@nvidia.com>
 <0c6ba292-4e65-9a9f-b498-2409482a06b8@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c6ba292-4e65-9a9f-b498-2409482a06b8@redhat.com>
X-ClientProxiedBy: BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f4246ab-e871-4902-28e1-08dac9a2b0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6iKXRahjWRQfzYJoXWctxfNdhLBC2hks5s2IfHN0joLL9zEnbskHqdgtyiyRwLnC7TeNJzB4Xl9Id2AlPSOnjwjjQ4JvTAtVj7pwom9NsuNdXXgqz5YjAWJChoeSaQcb+ia7Xzpgfn8cOOCahN3JtUwA7BgtYKr/LyPPDOE0nNkkv2lfJlmboyeMDrmqEAfoM2aF10xXIs+uqOA6OCjajcMJAiafs9U/9VM3DCgm3gYArnMi3b5zykJV9XxGN+qgC6lgssOsXEZUqiFi7Thvg3j2RBEeBc7u1PNtAW5uK6gVmYnpv3bFhTjG6VD12hWKgMLoeBJly1TFJEf/fzQQbc5p+VFhE/H1qLw4Jbr6vTU+Op37y/jHClN37vDxLX/20kl6hnhqtblU9tTsPGxhKuzZRw80p9UGkSbqBXZHVk87nXl0qH+OaZic6xVbezAy79JUaR4EIp4vnZFdgnGbS9r9cyNJu63dCsF0vaO+qeVBl5YyIKNxGPny8zzHLlP/DO4mDutez+HSuiPtbWsfq0rsPHYySvNwbJ28UCSk1Wc+jUYjzfsL+rWJiGHgKJs6AJHRWw8kfqluR8oH49XFLSD8Y0wLKDIcA1Qt3pfGol4DwQeemTA0Ucisp/VVMzdtk/XhLckz7o4hwmD6wajaAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(451199015)(478600001)(83380400001)(2906002)(6486002)(66556008)(7416002)(4326008)(26005)(66946007)(66476007)(8676002)(41300700001)(6512007)(5660300002)(7406005)(54906003)(8936002)(186003)(2616005)(86362001)(6916009)(316002)(6506007)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xEiZ+pHcH7G9zTnh8ABbq0qMD4rmFizaQ3ZfXUO4EmRl79isv6wL4J0tjQjq?=
 =?us-ascii?Q?/gZk+rHvSpPZkJEiZ0XO0KG0hhCMYlJZglDC0j8EC/wjwC6A+8vNmPV5F0WP?=
 =?us-ascii?Q?0E4EcasmKR4qG8Ia396+Pv6WzWgbUNko4ZzC87bcEaObTlA4ev175Jaznvn+?=
 =?us-ascii?Q?1t5dMqZo0w2+GJBgt5HAW3tL+R4iXsVFHP+RLCsiAWGTH/55ol+77xaMSgFY?=
 =?us-ascii?Q?vakwMBBCp9kvZObqfZEaN32dhRpcw1HOlzOpuiXgJiQ6dSZ/N/PEZaHeKrJk?=
 =?us-ascii?Q?oUzgI20xcIn8cmbRRB2LrJMnGxPhO2DTiVdI+2WPKDvz/+NdyS25ZXgRXaSW?=
 =?us-ascii?Q?83j8CltJWJ0zjacV+TUGr6knkcNWxbQ5FqzK8KtBO8n0J+1qOK8dnpWQVRxw?=
 =?us-ascii?Q?Ywdi/YVGhPPiWCxbBeqn0NN+nyem/CkltzK+WxSSIdBF1G/CjTChEHat0GL/?=
 =?us-ascii?Q?ZNvpu2xvfMzXGQEcjHwvbhoRMmTG3seLatCxX+naBmp5zbyYRg/RvmLRXvV9?=
 =?us-ascii?Q?4IQgFPqyktCLCa1aFyh0SRngCBhPBOXB8T6+NKd71ZDJ6H7Dd29zs8213K+0?=
 =?us-ascii?Q?yztgUaUydvzNDATTh+ZWSvd7awI1BcYwGb95JWox6U+0fRWGWMZ9ZgT0PoMO?=
 =?us-ascii?Q?ThqixlT28ryuoq9pPV91HSN6qpNcXsiBUIP1Pb87VF7gjEFQrEZp+nAokxyA?=
 =?us-ascii?Q?FeH5+Uod+6IchWkkzGKT++ZfImiw5sFTGZ6pvoDM+5HFWpKzTnSI9xKNAcqp?=
 =?us-ascii?Q?/QSyxt1kd+6wXTO84QwESd8s4bXmVEMZGKm03LvojjvJIZwWqiBOJMZJKZLf?=
 =?us-ascii?Q?rTS09r8a5LnAJiXJpNLGX+UybY66OqyfO+SMiyoqMBokbYDTmJQ92+XYtKf7?=
 =?us-ascii?Q?E29vmB4zOcB5bYyLQHIPCPq1bo3dn81XpI2F2YUuxrmhNyg3627LMwzi7j+A?=
 =?us-ascii?Q?v23nLZoCr23etWLL4zAaaHsxBBCvbyj8u/dfo32TdpxlB6uggq/8q3tXm5tD?=
 =?us-ascii?Q?5K+CDIslDcgbyIRgsaJ3VZ0OwUmY8QKWgyRrrJv7oDjq/tmbU0TM2r4ibUYL?=
 =?us-ascii?Q?m14E9vhRsgQOZ86rjrYKJuzhhbjuslRTECzvujTabfZgr9Kd5MQgD5fWj18I?=
 =?us-ascii?Q?fkxy733O+6j12ryxn4EL4YeM3VHlsQR9jb/r3EV0h9BhBNlPOpt/noQ3+94X?=
 =?us-ascii?Q?NYFmtYLxsmS7Lk5xdbSEQzZtQ+ugfO7VXCDGe7fwm5/3Kan64nLa5jTrLcex?=
 =?us-ascii?Q?viEIo0Jrds9WdKt49f3uoLGVel3+sDRO7LjkGa5co+4cCdFCv/Y9NzFAY8JW?=
 =?us-ascii?Q?C+pTcumYbH51VErJZCNSTrwz5ItAglnJ+LlSehKar2wog5KyOaPhjHuODD/K?=
 =?us-ascii?Q?z6f3oUxYx6iwZdDlP8DrC46Aa95YvgZRZ4BGtzJciJNWapbwogVh08yjYVZC?=
 =?us-ascii?Q?ld2S+1doGznq4rVrNxQDw6iT7grDXYKNuPLonOinZOMns241/CyqxJdAPNI8?=
 =?us-ascii?Q?V0tvgdko00qxr8snipBeI7PLjSTPT+FC73iomSHf0/QeNvZqEQ70pOYPP7QZ?=
 =?us-ascii?Q?44d2ZKbzmx5MKH5i4e0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f4246ab-e871-4902-28e1-08dac9a2b0bf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 20:23:01.6218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCOfmZXy1RIt4Y+5dtf840k+hRIaKqb0eOgHnFGqSXKu3yU1d3ly7KybGDAcUCE2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Nov 18, 2022 at 05:27:35PM +0100, Eric Auger wrote:
> > +config IOMMUFD
> > +	tristate "IOMMU Userspace API"
> > +	select INTERVAL_TREE
> > +	select INTERVAL_TREE_SPAN_ITER
> > +	select IOMMU_API
> > +	default n
> > +	help
> > +	  Provides /dev/iommu the user API to control the IOMMU subsystem as
> > +	  it relates to managing IO page tables that point at user space memory.

> nit: missing ',' after /dev/iommu or Provides /dev/iommu user API

Done

> > +/**
> > + * iommufd_ref_to_users() - Switch from destroy_rwsem to users refcount
> > + *        protection
> > + * @obj - Object to release
> > + *
> > + * Objects have two refcount protections (destroy_rwsem and the refcount_t
> > + * users). Holding either of these will prevent the object from being destroyed.
> > + *
> > + * Depending on the use case, one protection or the other is appropriate.  In
> > + * most cases references are being protected by the destroy_rwsem. This allows
> > + * orderly destruction of the object because iommufd_object_destroy_user() will
> > + * wait for it to become unlocked. However, as a rwsem, it cannot be held across
> > + * a system call return. So cases that have longer term needs must switch
> > + * to the weaker users refcount_t.
> > + *
> > + * With users protection iommufd_object_destroy_user() will return -EBUSY to
> 
> iommufd_object_destroy_user() returns false and iommufd_destroy
>  retruns -EBUSY.

""
 * With users protection iommufd_object_destroy_user() will return false,
 * refusing to destroy the object, causing -EBUSY to userspace.
 */
""

> 
> > + * userspace and refuse to destroy the object.
> > + */
> > +static inline void iommufd_ref_to_users(struct iommufd_object *obj)
> > +{
> > +	up_read(&obj->destroy_rwsem);
> > +	/* iommufd_lock_obj() obtains users as well */
> Do you have a way to check that put() is done in accordance, ie. we are
> not going to try up_read() the rwsem if this latter is not used anymore?

If put becomes unbalanced then fd closure will WARN_ON

If someone misuses the rwsem (eg double up_reading it) then lockdep
will fire

> > +static int iommufd_fops_release(struct inode *inode, struct file *filp)
> > +{
> > +	struct iommufd_ctx *ictx = filp->private_data;
> > +	struct iommufd_object *obj;
> > +
> > +	/* Destroy the graph from depth first */
> I would suggest: destroy the leaf objects first thanks to the
> hierarchical user ref counting? or something alike

"depth first" is a technical term when working with graphs..

How about replacing both comments with this:

	/*
	 * The objects in the xarray form a graph of "users" counts, and we have
	 * to destroy them in a depth first manner. Leaf objects will reduce the
	 * users count of interior objects when they are destroyed.
	 *
	 * Repeatedly destroying all the "1 users" leaf objects will progress
	 * until the entire list is destroyed. If this can't progress then there
	 * is some bug related to object refcounting.
	 */

> > +	while (!xa_empty(&ictx->objects)) {
> > +		unsigned int destroyed = 0;
> > +		unsigned long index;
> > +
> > +		xa_for_each(&ictx->objects, index, obj) {
> > +			/*
> > +			 * Since we are in release elevated users must come from
> > +			 * other objects holding the users. We will eventually
> the sentense sounds a bit cryptic to me.
> > +			 * destroy the object that holds this one and the next
> > +			 * pass will progress it.
> > +			 */
> > +			if (!refcount_dec_if_one(&obj->users))
> > +				continue;
> > +			destroyed++;
> > +			xa_erase(&ictx->objects, index);
> > +			iommufd_object_ops[obj->type].destroy(obj);
> > +			kfree(obj);
> 
> Use iommufd_object_abort_and_destroy(obj) instead of the above 3 lines?

Ah, they are not quite the same things, the order is different and
abort has a protective assertion that the xa_array hasn't been messed
with. It would be messy to merge them

It is also very similar to iommufd_object_destroy_user() except we
shortcut some unncessary locking.

> > +/**
> > + * DOC: General ioctl format
> > + *
> > + * The ioctl interface follows a general format to allow for extensibility. Each
> > + * ioctl is passed in a structure pointer as the argument providing the size of
> > + * the structure in the first u32. The kernel checks that any structure space
> > + * beyond what it understands is 0. This allows userspace to use the backward
> > + * compatible portion while consistently using the newer, larger, structures.
> > + *
> > + * ioctls use a standard meaning for common errnos:
> > + *
> > + *  - ENOTTY: The IOCTL number itself is not supported at all
> > + *  - E2BIG: The IOCTL number is supported, but the provided structure has
> > + *    non-zero in a part the kernel does not understand.
> > + *  - EOPNOTSUPP: The IOCTL number is supported, and the structure is
> > + *    understood, however a known field has a value the kernel does not
> > + *    understand or support.
> > + *  - EINVAL: Everything about the IOCTL was understood, but a field is not
> > + *    correct.
> > + *  - ENOENT: An ID or IOVA provided does not exist.
> > + *  - ENOMEM: Out of memory.
> > + *  - EOVERFLOW: Mathematics oveflowed.
> overflowed

Done

Thanks,
Jason
