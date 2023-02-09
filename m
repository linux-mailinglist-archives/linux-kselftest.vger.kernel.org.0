Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B0D691501
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Feb 2023 00:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjBIX7w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Feb 2023 18:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjBIX7u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Feb 2023 18:59:50 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114FD5ACFE;
        Thu,  9 Feb 2023 15:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWQk41y38GqbGOFi6fHbjbmqVXWYXGh/xxWd2SP68LsSCZJyjJbJsO9KSqkWET1n9xjSS2o+DmNzOR/zdif4Xly46ChQhnfbosj+1J7iks7wvzzvzTQ5S4S4SbePbhuOIXigPafHxt8zk+4+GpCUR9OZgvKOCP7J3J3O+3+o5Q1jHb/i5rUpgNP722FVY6te6plelgJVZ+Bkl3NOD1HCC8z91WMHFzOdB3FPZps3OJecM+PspgylxxOJNUuOn9kV8U/D+TikBOIC/9f3xWt6J9P71i8bKuija1dJYq+b2YmTFaaWOAnCOH/AUoLg9CZ94VT4/ELQuWvJoMRlxEaZuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z3DmwxzYDNEU0HqHj61WmTpTWJ7jfSnBPYt5HLY3HKg=;
 b=dZZeEvXBxWRy1UgIj7FLXOYK9a9r1cfHdAGOfM0MhwfSk5JfEF+dJT6P+K2xOPAS4rO6yiS1w4kwtRnZ3MrnNmQ+zWnWr0FH5rVtksxCX5QD3KyujPUs5E/GcnHO8oYvcmlADT1K6r5XtFcGZq5kd2i8f/CqAwRD6tZrcm6MAhgFoHu+bS7anMPMCjYmJU9eZ/EMwBHdn8ps13hk2+Emnt7X1yLkMQj6lWy1tcpnMrp8/ekxjkmWHjkV5kEWjPhMHOyoS0rlOW19/ISwoLRZS7GtHrFqBfZD6bbhXYvxB1tmzdHzHapwnf+RCjQLx8nc3S/xfZ77Pqna+4CqYZSc8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z3DmwxzYDNEU0HqHj61WmTpTWJ7jfSnBPYt5HLY3HKg=;
 b=LBmtupnXMgv5dJX+rOesh6REaiDKGMxHLWiDU8Wk5x3sXXv9n5Sq1psltpWottXGk7VCTZI3c2uQY9peUME8PrybkSGDtSkSZtNB3AlUWEqHXy1kfgJIMDfeRDY37h0aOngPpq1cNm/sRA6O8jRxLZLEsnlivHvr8ZHFsRtU/k0EqeRUY6oRU7aQ80xFK8ytdrkLP6FxM7vx0GFBxN8O1ANXBo2tIJvHKS3CYZWuJRy63o/riWxtzNDEOYMlzV4lZl0VkCJfWXCNX03WkA8TXgpp6pMlZAjW3lcCNwQduhRqQ3SuPiiQnSW/e+lAI7AxjWzhW21bAJGfkXkr5YBR4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 23:59:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 23:59:23 +0000
Date:   Thu, 9 Feb 2023 19:59:22 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        kvm@vger.kernel.org, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        baolu.lu@linux.intel.com
Subject: Re: [PATCH 06/17] iommufd/hw_pagetable: Use domain_alloc_user op for
 domain allocation
Message-ID: <Y+WI2mLi/cjPYLZK@nvidia.com>
References: <20230209043153.14964-1-yi.l.liu@intel.com>
 <20230209043153.14964-7-yi.l.liu@intel.com>
 <25102c92-1831-be52-677d-60bbf2e11772@linux.ibm.com>
 <Y+U9QX4p5YX3/B3k@nvidia.com>
 <Y+VOw6dTnGapMm9L@Asurada-Nvidia>
 <Y+VaCV7DRR1+mLYY@nvidia.com>
 <Y+VyIvKYmCdMG5i7@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+VyIvKYmCdMG5i7@Asurada-Nvidia>
X-ClientProxiedBy: MN2PR05CA0057.namprd05.prod.outlook.com
 (2603:10b6:208:236::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 021e0249-01f5-481a-c68f-08db0af9aadf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vP+3acdZdf/tqb7vH3E4QGupWPjHNRqBJYZcmrcg99mqkDhgQR59E5IYuvAe72izRzrEmvysQo0eIQfntJ8ng016zzXxcmNKqpQSimbBjpxMXBD6RruIEe++O9yC6KUZQi/AyyWzfIvkC3Mc2TMz784ejmRzqWqKpweePrvzr4aiwrVB8oXE3uKtPOC9giaOVptLZd9R7mcWE1zjc9+ztDHZ9LcQgbNg6m1N8pK939yYagk6HqaXnE0lpMwpH88+ZO1doNjfDnkuizA54GJNrgZKtNznNbtJ8FrCc3fYQTa0IEqqstKRjm1qmEqwkLcT1Ew+t8Ilc+1IuHXUSfbm+7o3p+gxE5nInP6ucmh2VHM1a3L16gyPqmn6m5GzAB47sEVStgZWqir/wOw16MAlxTt14LtqLYt24VsYlbww6zbhS5J3RfSes53n0K/3i0RiZAeQgGwliD+bG3g5r+S+lcB2IC06p9Kq4TRJ5X5LILZjSTz7T2c7agKax7h5X5ISTUxBgi7EZEKCwJyLKnLfakfo0mcBT3vyWU14o0tNDejDUcZ+zLFmjSHY6OPEDphS00cVbL03ujAQ/StcZj+Hc+wDyF4/yFKUgqFiNKYyWY1if2SqEQXqNAMWA6epdXU1FVY8K4l05F0shp4SSiNmRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199018)(478600001)(186003)(6512007)(26005)(7416002)(4744005)(6486002)(6636002)(54906003)(316002)(37006003)(83380400001)(2616005)(6506007)(4326008)(66946007)(41300700001)(66556008)(5660300002)(66476007)(38100700002)(8936002)(6862004)(8676002)(2906002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G0EhZOs2jmqtvEBSRHmo9eRCdRxkm7BYy019cHtBvsfkhHgkJc8zgzbjJGAH?=
 =?us-ascii?Q?aXYnok1zV0PUzSTPCm8uSwAV+KiV5ltYo4jNO7eK/gidYYKkqXuT5n/oguJ/?=
 =?us-ascii?Q?hN6/XAMMgaPzBJYUp3BGplEXydfUjKi4vYOvyy8++p4j7JA+wiXC1Op6xKye?=
 =?us-ascii?Q?YdIbWM0r3ezqdLJatjVeo8tztPczgGmy/WfIrxjpVtlRNyNReJ0P2/DvhQ3J?=
 =?us-ascii?Q?76ViA4R6Px0+cSzybxfl7qjx2AytNLs32wrVd7GxncESiSQjlKwP4VYMOiSs?=
 =?us-ascii?Q?SiiYE7Ak2cPQ4vYh3YrS4J8U0qTnFvdRoY8iiu2UHOL0r2SH3d6oGiO+ToyT?=
 =?us-ascii?Q?IVKcYZo20FK/5sh8jA9T0qJjVTLkkPI55V2IrjZsnFIgv41gzHL6TrkC0hfx?=
 =?us-ascii?Q?MDhuoTigQAbtoIOsxIEr9RgnmBKQzCXJh02/zuykeTdpfZA+z/hoPVedyHvb?=
 =?us-ascii?Q?vYQjWBrowKmkybLFupEOu8J9mNE4pEZ8v2PeM9YZrtosYQvekgGRsksbE800?=
 =?us-ascii?Q?nhuyoSfuEHjNtPWWxPsHqqN8rFr5TGNkeJjFPFpFQw+8TvmtoFthgzBiMfy5?=
 =?us-ascii?Q?PKsDd6IbNqp+BAeXF2WUL3KXWiZg21z37hEbXpeUa25yxsQtd4yVkOWmOSfJ?=
 =?us-ascii?Q?Yxy6YEOHif8Z5op9QhkPmVQdsgEJ/cmEHB3zwwx6gP7OQrcJeW+5eSMJ3dts?=
 =?us-ascii?Q?4yUVsQM2m40CF4QCTiAke6/iHpgeq0G5kz2XfSKiElDrQ3GNg8mcCpHHHX18?=
 =?us-ascii?Q?SfD2HaEjN8UU1HuXmDnPPyXo9IjNQBV0sUrgjtpFq8c3DJ+gsyAWC0VBoF4j?=
 =?us-ascii?Q?0L+04hCNKGBnzLD7sugJ/CV8a7EJO1QPUeoYM/FBTDnt1iF4J3p0Fcx7lKFV?=
 =?us-ascii?Q?xuR1NNw9ifgy4m4bjwn2yAjfqpE2NtgktnNzNbelUreouhC782S+o5a8hmS2?=
 =?us-ascii?Q?1gRav8EcdpvKi8yngnkf5sycjEDSWQiTHk7njuY8ABhASqpuHSNQFPtwv9az?=
 =?us-ascii?Q?UtgSHcqn2cRrS/w560pVUwbKxkmMNZqKbffbOHk9jIb5jV3tZokF3ETMJoZR?=
 =?us-ascii?Q?+91bRs1FtRPXyKMSMUTzCsLCLCyQJPkDPZz6rSXF7t7NXFv1rGuxKCfdCb9d?=
 =?us-ascii?Q?gMTvbsknnrPayZu79nI22BAUgaT5BxOnck1MwSkU8498LUvCFKLa1Er/Smps?=
 =?us-ascii?Q?gAltt0+3Tqxx7TZU2+WbeH8Tced10rbIF3PK/HImDzIaYFr3W+ej3fLzsxfE?=
 =?us-ascii?Q?DdyUd1In56mvlndZ24D7KLXcLMfFERk5HRpEqeKv+cxEK/s1AbAaZa8hguQw?=
 =?us-ascii?Q?xQMQ2wE1f+5SZ8ZSqWPyzF/bookW5z9g8/Q2aAcaDtZ3YMShyW+HJitfTH8d?=
 =?us-ascii?Q?MBgHVJPDK70SZ2OJqH3xXeprVcQ0RJlKG4kGq01k47Cnk6KGKK1JxHsdiUSG?=
 =?us-ascii?Q?iqSVWZGR43DcWFK+aaLqAozzMNm0gc/viZTqOWyYdEXT3QdPMGynG1RgLf6E?=
 =?us-ascii?Q?KLu0T/lrq9/IV/YfZ4LROHRO8Ha2Yw2WBkA5MKSLrKyhQHIOzJsFP0ZaQdwm?=
 =?us-ascii?Q?GDNDhX13g0g9omr+r+zw8zw2k3adoDh6foBv8en9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 021e0249-01f5-481a-c68f-08db0af9aadf
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 23:59:23.4702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ijdTs5myrdigqNIz5VjrOkE0AGOn0EXavuTCHAuyCpmXKegWVI9fk4FxXsX86Ffl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Feb 09, 2023 at 02:22:26PM -0800, Nicolin Chen wrote:

> Yea, I think that's the only way out for now. Though I am not
> sure about other drivers yet, hopefully the SMMU driver(s) is
> the last one that we need to update...

I noticed apple dart had copy and pasted this from smmu, but I see
that it needed it.

Jason
