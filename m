Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8416B32F8
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 01:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjCJA41 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 Mar 2023 19:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCJA4Z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 Mar 2023 19:56:25 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D011CF34DB;
        Thu,  9 Mar 2023 16:56:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwUwSi4dWfVK+YGBpsvXPzpIYuJLE8Y3H4196m1j58P7Lw3Bob/Zre39QavP4MUsNRvBuNXJiTZBkHGe66W5iJVdWtYrloK/V8ULldne8xtAUf2t8xytI7xpngQkmep+WJ+XiFS3V2fjqCk27p1ceZgAvvtt6vYgfAvgIIOLKvvO5SOkF07nXzfO9vYevHG3/606EI1710w2b8+Jeu8Uo2pEAELR30ErwlFYdknqInjeyjss9QG94qEzBs4WeOLqt/XOXzs0qMvbRfp79rwn8NP200S42VaWHX/P00fGgUKaGpf9nN0jU2RPlyCpp346s7gMkPAoUCytHlL+lo4riQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=16nKaIX3IhG7u+LlTSDYRgjathcc6N6nTWoFEkdZdoM=;
 b=b7FrEnHQjn/pqZxUxfj94XLS9ShZRNIj6iUf0UG44ieNVliBZHP43HXpODzz/46RwJ+D9rAqEycLoV/Ndzx0cQtVSCHGxnaYI0E2fN6kirFstaOWOOuc1Vse7WDjx7+F9/eDJoGOnHcNSegQKdLuCRG0cTDS46Eh4ziOJgmyQmDhHHuNROiHAmQMd+OJ+i0lFAyiDWwJDW/peLfFOepIbHugTcvx9T5zDas2xypjseDVIxi7G7YtTmVcu0v0PM8tiZ/Dwhs49XrdoOs46KHX5PBTbOu+srLixpmMs0SGNcTgpZebqIUzYrSe2DCI1actaRlI8IpkQSykTM3rkaxGag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=16nKaIX3IhG7u+LlTSDYRgjathcc6N6nTWoFEkdZdoM=;
 b=NsZg6xpRMNfxc38eDjSzVCaoxFlILb9teEQvCxRz1gU98mdXNlyHWQk1fs9qZcovT11g5LJnebOCkk/l1y/FrwFlmmIoID8Uw1nCIpUMTB4x+x5T3VEXEnpOq0Qk6CFhQN1P/3QFPm+b8cljpjXS5HKI8P/vG/C4vBpzUg2hWOI9Kx8Bb/a5v2r1ZuNrtJhvytHgqrJNsKTDX1nfl1pbqFd4ZNwYT/nmE6A/Sq1ig0RGzINeezfpRy9WLRtQxZgKVRaQ5oOacyQFvzJjtg301oxzV4t/YE4VN+9gEiwrwTsWYYeCdFpJdfbAvUiy4n2Kd3jsj1rK43WsxhewZPKkuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB5998.namprd12.prod.outlook.com (2603:10b6:510:1da::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 00:56:10 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 00:56:10 +0000
Date:   Thu, 9 Mar 2023 20:56:06 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, nicolinc@nvidia.com, kvm@vger.kernel.org,
        mjrosato@linux.ibm.com, chao.p.peng@linux.intel.com,
        yi.y.sun@linux.intel.com, peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 01/12] iommu: Add new iommu op to create domains owned by
 userspace
Message-ID: <ZAqAJgoQ3f0L2Gfo@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-2-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309080910.607396-2-yi.l.liu@intel.com>
X-ClientProxiedBy: SJ0PR03CA0352.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ff04f1-d0f2-4602-db6e-08db21023cf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /trdMB+F0CJE5kqwHrLVbrmNpTHjnc5B+DkWAKeo4iUVwyweBgn0jXXvuzEDntZSfJ/sC5v+Frn8zNedzjX9iq0d2HjV8+ge+jjfNrnFw4jZgwahDlyG75cFjQOXi1oe5LUOKaG2P8CcNIhrDcDqY46juVgiE1Nv2hEcaNfm5cyo5E6unfW3mvginBCxwIpxacLzJ2gyI3bUtYuygaaCLGLTBAVJE5zp2uiOzuM8nLcC7QY3e3lhx2O8SVfMXtA2ZN87q+W8rJC1epHiqevjUIsiSDJn7oEyLBDtSDyTLvL+iIFJLbXDllZ5gUEVdA3a0qaRxJT+khIAhx7UGphhZ8yPK45+w8KJ8hoNvefaUxyl1Nq7v4s2nZevoVaXn8HwhHvurFRHKqWVqXzPK3dBqGDT/+BGQXYv5EbJqHlnTAR4BYOiLen8wpRNnWdcs7HcFlgolHbRRHMf+NeicRW4+vLlRUt2P27G6CRqaHbyeSkTkZU68Ng2RKoTAX7UxSYsFlIMmhARnIboOVQ+5keJnswFDlEJkZwLu/ghRm3CzdqaC6O4QvDU4X8/uqbcYe1sscNylsYdqzikz/tDb4kc5mhsYAcLO+eYLPLb6cMBljRfPLUkr+JPLYOPHt3zASX50tR1R5Ylsbzvlm2psYBNgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(396003)(366004)(376002)(346002)(451199018)(8936002)(36756003)(7416002)(5660300002)(26005)(6506007)(6512007)(6666004)(38100700002)(83380400001)(186003)(2616005)(316002)(86362001)(66556008)(41300700001)(66476007)(6916009)(66946007)(8676002)(4326008)(6486002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VuYE+qWekGncWIKOYYoBFLODEN5RmI/Xn26/s8HpkUQQ9+rZ7bpK2j18bWIs?=
 =?us-ascii?Q?kvAVci4wiMyG60sKT9awwdALzUkKUYvLfZrS0A96lS4YYy7i4lSH5gqG2NFr?=
 =?us-ascii?Q?9CRosK3qSL4okBJ49ehlJe5QtezcJG0StjjOMZ/yZzOGWFdQcM8aWRCFvKRm?=
 =?us-ascii?Q?pxQlWFf7OjoLbHHJwhJRM2wLNqrSZ+mWWu+Z8b+FCJOq+1wSVZehSnGK1hWu?=
 =?us-ascii?Q?/u8sw4iJfV5AHU+O9FHOJN+JFZL+e6jWUbmqi6JEAUidCqb6c55uG/tDAZv7?=
 =?us-ascii?Q?IGgYziSs+PffH5oZCPaYFHEMayHq8SwAO4qroadMN+fismqRMoRzm70r7a9W?=
 =?us-ascii?Q?WUx00blNua2Q+vcGNxF6FRzAjZcqRv3qbKOZvLh/wFXrZpAnu0YcYG3jop60?=
 =?us-ascii?Q?hIpu90Su8PgDggf/aoJRbzwFw9qDCs7iIkrzBMFNbbE8uoQEE8sGCqzsaan9?=
 =?us-ascii?Q?cR5OZjTSuEZzKi5vSulXcZfNiNme///FLYRQwskIlUvgQQ81c+jRpiYsaBEV?=
 =?us-ascii?Q?YylzRMdrjbfJICyX+OpQfe1f3+kC0dMWeDgPVw55E1WXrDLt5wl4CaRdEy6h?=
 =?us-ascii?Q?3rY7T+rjaSOdZZnL1+bRdpILWilYmHK10f6UciAsrCjVwgR9d+xiNDe4vQzE?=
 =?us-ascii?Q?uOyMBqfi7nuM0qbPXQn9q/vFJ8WDRHPVrvv0uaZfRnI7AfckEnEzFZGPLopq?=
 =?us-ascii?Q?3TVz8wbuln7GZBRuhXEdCZgukjaq6lZ8E61H9qBaHWQrztgvQ93uG8WEJyYy?=
 =?us-ascii?Q?B3jYoQx9DEF7X3iYwaL0dYVibs6MD8FaKnp0WZZAMmnV93iibqXaG+jbGELz?=
 =?us-ascii?Q?MCRmiE3B2ngt43KapMebwCdBuWaIt08/nbMYWBNwL+KW0KeHEfWStTSeor6k?=
 =?us-ascii?Q?VuZnex5Kj1D28rMG8SbELmeR7xVK6FIEIkO33++YusYADsa0q42TAprSwSg8?=
 =?us-ascii?Q?xhTDHBNQfAyxGNYT6gUmc/5dPMHGUMJD1aohcR/GfmTju0+/qvSZ650NFcad?=
 =?us-ascii?Q?2U754bCob5T5Gx4uy5VcUuBO1M1tUZhQ/pNAZYGJHzm7t6N/U8gzBuvjFd7e?=
 =?us-ascii?Q?XkQD43GqGVRdDbmk6zCWrkMMgZ3GBExQFmPYCORMf9Z77byIzfUUpk2xBiaj?=
 =?us-ascii?Q?KjKRU43VgfiEi9Ykr46hclB4PV858x7ftvZKU9bZJO1OAsopUeLwLM6He2A2?=
 =?us-ascii?Q?aIvGcPH/wXGpovhj5vgQf3Oz/Ciym2yip0ZBIrPaR2mndcsj0j8AI68ZCp56?=
 =?us-ascii?Q?WtdHjeO2AInV9ymNUyAfqDUeSj+P3o4qFXcLjqClB/RG150a3Vv/hhjCFjrH?=
 =?us-ascii?Q?mqGLiSH1vrjCdquFGnWB9s6uIBDhV4vo2tC2DVc4xiBoxezVxpPrFMnx324u?=
 =?us-ascii?Q?Qxop+HP8ElSJ4NMJB5Nev1iFQyvUVybFze4CLtVdn4IWPxHE6iQ3dDUvMY4d?=
 =?us-ascii?Q?IH/oysfdyiiedMLf8ZxnjfueeRmPvwGYPc6nslzvRdn0NqESPGxHF0eIzMH/?=
 =?us-ascii?Q?7VWHcGT8o6Cm8/BxwYRX4t22ryK2mEWCmH907BB5vXN3zIX9xjvWRo1rg80L?=
 =?us-ascii?Q?loaWcv69GgKuCVUlTBw9Qjm+L0CsW5OpRRqlsdua?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ff04f1-d0f2-4602-db6e-08db21023cf2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 00:56:10.1770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1d0Dyw6W7YYTERLH+gxuRmV9PC86lCNEY9zjkkhWybB+a08+k9e58qZs5MqsvdQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5998
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 12:08:59AM -0800, Yi Liu wrote:
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3ef84ee359d2..a269bc62a31c 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -229,6 +229,7 @@ struct iommu_iotlb_gather {
>   *           after use. Return the data buffer if success, or ERR_PTR on
>   *           failure.
>   * @domain_alloc: allocate iommu domain
> + * @domain_alloc_user: allocate user iommu domain
>   * @probe_device: Add device to iommu driver handling
>   * @release_device: Remove device from iommu driver handling
>   * @probe_finalize: Do final setup work after the device is added to an IOMMU
> @@ -266,6 +267,9 @@ struct iommu_ops {
>  
>  	/* Domain allocation and freeing by the iommu driver */
>  	struct iommu_domain *(*domain_alloc)(unsigned iommu_domain_type);
> +	struct iommu_domain *(*domain_alloc_user)(struct device *dev,
> +						  struct iommu_domain *parent,
> +						  const void *user_data);

Since the kernel does the copy from user and manages the zero fill
compat maybe this user_data have a union like Robin suggested.

But yes, this is the idea.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
