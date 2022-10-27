Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D5760F92C
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Oct 2022 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiJ0Nfl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Oct 2022 09:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236163AbiJ0Nfj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Oct 2022 09:35:39 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB45E171CD7;
        Thu, 27 Oct 2022 06:35:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoGMDcMD9Q4WEhMrmvVgALbZtyc4zfj4oEdUffG8bWs5+IiG71S6p9fhi/M7fyxNlZMCHE9vxYifmTvX1LmSfSn29Wf3UwB8s97bkqjvNYL5KIm7T930b2dnForUOxUv/YxOIsK3pPGtyN6JGjhGaS6Yzxolz1iKRyqDkv32/SMVFddmNeVYEQr+qAkdv1f+W5VASQVkrKpTlx4vCbHT+M5Mk7UH72GRLF2+aLTfmPNFudUDfyeZ+bDbeIVu2X6LyuKTRiCw3rjGwG6CUxvGXGDFKKvYTTP4Qkj6ETKzVx+seKSO/dQPCoo/Tsgc9D6cybjTM6SgIVltCw5fVCNbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RuPZOxaREtENcc7j2lYu2AH6WvPf9YKiP9SRSe7OK7M=;
 b=BT9usZkjwGm+XSZHW+duHJj5wQxZoUvDDu6C++iU0lGN+v68UsEcsUl7AuEer6wjER1vtNJvy12jGbwGJleCud8oYb7FoyMQ+YMshMHTp6xSVK6FL6+5gcuV2C37vO+MPCvZYd6GKGEjkNhu8t+KmlXV/Iq8nwdTfwrDB8pD9A4EomRjWv+ojz5rZAUWtD2RJn0Ug7E8Axazjzp6fW8XP7bnARbJ8/RFx6q+kNS/H3kiKwFoF7en4PeLdscnr5dp+UcmUuFeLbAlyvCxTyq07LAyVjXNUW/KkiV/2P+uTFMAq2yTyQ4+WfIU+TlmjPk+N3C+0QYwtcW5rSefPwrOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RuPZOxaREtENcc7j2lYu2AH6WvPf9YKiP9SRSe7OK7M=;
 b=a1zMlsTTucpE5CC9EUEj3FNXSTwAOmu4ufw37aZCuZk3bcdoixqmHJ88Qm+1TsTmvfdctT30UY42xcILt3vV791xMcH4ZBaGQKancfncTi94wFtSxYP2RXYRI6xLS7GcYUmUUpIjBmuRs4uUeckXr7NY4jyhG0b7tyfdBMMp1M9KOCaj2J8AR/hO0of+RiBMwoLX78fVh+5bFXYEhKUng86er8wwEhxmKbPf2rMupBYwtWmu3HJjIpAdHVZ4NhiNMKcMWoPEv8gFwkanTTB07GsV6eDJpIldwkVlklZmv6Ai62Coe8Le1zyNsKUbgLTisUdzdbCGfSdUm9Q4lPQYfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BN9PR12MB5084.namprd12.prod.outlook.com (2603:10b6:408:135::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 13:35:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::7a81:a4e4:bb9c:d1de%6]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 13:35:34 +0000
Date:   Thu, 27 Oct 2022 10:35:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, bpf@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
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
        Tom Rix <trix@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Joao Martins <joao.m.martins@oracle.com>, kvm@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Yi Liu <yi.l.liu@intel.com>, Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v3 9/15] iommufd: Data structure to provide IOVA to PFN
 mapping
Message-ID: <Y1qJJKnf2TTqznzc@nvidia.com>
References: <0-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
 <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9-v3-402a7d6459de+24b-iommufd_jgg@nvidia.com>
X-ClientProxiedBy: MN2PR01CA0054.prod.exchangelabs.com (2603:10b6:208:23f::23)
 To LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BN9PR12MB5084:EE_
X-MS-Office365-Filtering-Correlation-Id: 62bb2367-a2b1-44c5-3b9f-08dab8201fdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8SDirlRm7mXv/e6TQgUV7cjnCRF5A5JXdEsN4k3LCyk5KQ7/4oHp3j1LEpAJF4JO9so+Bnj10FT//qPhY259044mZZEdfErPS2GXcdePXMrFP/4658Xt94WBsUVVX6UX1K6pIqCjlB88+Rbho2RbfcFJCh1DQH8aLjudI1aZ0D01Lm9uTTobz0UtXdCvFTm7MaNzHINdaR5y0c+QKH5a/MW2toOpYIU+ryhlpp4oPy87tfi+egPq7ql0mooO7Y6Jqf/iPVNAB8pPdtt/zYTjpX1WKYWXvnJ0HzUGB8n4UeMaIc6D0fQPqU7UA7sHs7irafyJFWpS/RFWBsrXeXCdMMSVynQ0kMKNckZJlAngeVGxPLaOXtULxJatswgyVMNtyHq/G/GUWyhIWt47f21YN4mCHK8LS1OCrj7SoklXnj+piv8l+rH6EPZF/P9fkMCYJRrGIwPlg38zIytVbz+J1kKAVfHGdOxp703RVP6GInL6+KUF5X+a4l5WycOo1jHnnKDsCZL7fW1UXKYtaI4s0cKBjrDz6AOs7jQTlgN6ZjAevl/i4dj8V9UZzf9Px+0dfAYiXTWRRneKvAEPanoD59Ppbv/zRn+91iVWmYX0LOXnyH9Z3hnsP9YG24NyBegDY+9b/6NVXlUVWxp894IPrwVsYMT6gZ226YcHID+a88sYcHCwrYNmr2C8y0c6VvKgmBiK/fI793EqXKO7p/j0ZcQNucBDXEoDTDTxAqjK+DLL6631JhKzkt0QrmbvwR8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(38100700002)(921005)(478600001)(6486002)(54906003)(316002)(66476007)(110136005)(6512007)(26005)(8676002)(66556008)(41300700001)(83380400001)(2906002)(4326008)(8936002)(2616005)(5660300002)(66946007)(6506007)(36756003)(7406005)(7416002)(86362001)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TOuRjgwpEi1MYzqDdcSWU2BHhOrfvEAxzM9li5Q7bzktKIF5OrY9Ny0LKFx9?=
 =?us-ascii?Q?7fU0vUzVD7GndSV9XkEZGZSeapOfENAwsUaQSNypJYfcd3N4/U/UrEq7N4Kr?=
 =?us-ascii?Q?JncojlXxnVdBx9WduY8cvX1S48QylwFuLumXmhR82rc1C4sX/ajGvmB3phs4?=
 =?us-ascii?Q?HKTA/RkK4B68JkatBzDA+7fEfdz6nGZrm61lW45p+r/ML9jeC2RVv0bymfjN?=
 =?us-ascii?Q?ezDm2jy9DqG3JcUvQ3SN0Iy0DeGEXGvjvs3ebGv01Z1WcBGnlXJXxbdUoTf+?=
 =?us-ascii?Q?RLkTsL/0zugXjP79L9jhEg90twkUJXCuQv894YEoMEUXJtbimkztKK/Nf65W?=
 =?us-ascii?Q?vLg4Ae05ChrIKRt8WBBv90T8g2nlrhueDYqXeggNCW5pNv+fQ/IwtD+T1OjU?=
 =?us-ascii?Q?hBWM0lQXej3LBVI9maCkBwkIaRhobAxVqFWqZt4W2P1hCtCppLj2x9kTYe5Y?=
 =?us-ascii?Q?t2hFBYnTeE83p8KmrWLQ2Ivlrpj5igdqoJyPvgyEmBoQ1zE4g9ByKlOvlMbs?=
 =?us-ascii?Q?ZRf3Nn2qjHktDYWp8GR/eQwQUjQLGxRMTVKJ036VD/g2TDdx4/shLxt2tjVJ?=
 =?us-ascii?Q?Yn6y7T386YDnXhAViRPMiQp5lw7FjxS3y7Si3Y3S/E2xTMZzErvvMk95qxs6?=
 =?us-ascii?Q?xGk5fhHoSwCyUVH+H+6Ldq5JqdYMT1+BIy7IbsW3MxFNQv1Cs8uSyq+pDKbY?=
 =?us-ascii?Q?XCKPoAGk+xWyZ+6jH2j1dFsmHLfqox3cx7pGwDsUEfRmGd7NX8b3FmbW3x0L?=
 =?us-ascii?Q?8xgsXfnj8IxP25W8KkvwpPz9w1yhW6xLW4+u7P9jewe8lNf+PL6xCVKtM7De?=
 =?us-ascii?Q?q7tvtdmwoinxfs1jJf/W0uic3ShIRCpj80QeSmDLMpquBY9NCD3+oM/hBZzb?=
 =?us-ascii?Q?3S4elHb1g9GZak9/UGY07dnVdyQ1t+ywfAP/cP8nzIfsvA4E0lKkHN7gFZNI?=
 =?us-ascii?Q?2/fZE9eWYf23Io0wFM93Hg2N9153Ix9hiCSBeRaRuQnd9qeiw/Z+yx5gR6wF?=
 =?us-ascii?Q?NWDuzqOMaumYg1wDEalJHLZJ56+/cUI9QiW2VedLyX7A0dIdrskJco8MYic+?=
 =?us-ascii?Q?tdxBWZfVi4VsmZcsRz8fWk9oF+RQPAhNyg39ufeztV+X+xvp90/+kD2z4sqX?=
 =?us-ascii?Q?VhzYDu/ZU7v4PPw5oxpIdEaS06BduDjsJO0dCaTkcSws/OG0dpOr/ojE1zww?=
 =?us-ascii?Q?yKyEtqKpNDXBQaeKLVWRuVYCJTzuD+mOmFgrwlCnCHcbwLA7/KEOd77H92Jr?=
 =?us-ascii?Q?3DRtyjbmwxP9gMy7xQFQ6BXeErie2qAzFx73rZHLzHEeyf7Ofpvqy8NtPCZb?=
 =?us-ascii?Q?JqLY1KrVkFJvOHTHEUw1mzuPTdtV5rXpe5HxAMe1PwGmlqtJmFHLQYDTTD5I?=
 =?us-ascii?Q?evVx/fOZkenQR0BMljqSQ76NtgUwrCxGMuw0AMGPu5fPwQ6fKlH36dUX65PR?=
 =?us-ascii?Q?qVs5HprlMza17wn1MbTAfQJkwQK/19YvcgBNvZ0JsTMdDc2Q8w3dvCnVqH8g?=
 =?us-ascii?Q?hZED5bKl/OYK0NCeq9G6dDoxp/RFoNDg62x9qCrcEa4hxxbE19+nAeKKD0oO?=
 =?us-ascii?Q?TC9D6+EQ+m0wHynq5BU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb2367-a2b1-44c5-3b9f-08dab8201fdc
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 13:35:34.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q5DEy6UNROy9ohH5n1ZgYvy3LLxh3FILCeKBit9ugcb+fl5jfvSyvjlRBzfH8F1h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5084
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 25, 2022 at 03:12:18PM -0300, Jason Gunthorpe wrote:

> +/* All existing area's conform to an increased page size */
> +static int iopt_check_iova_alignment(struct io_pagetable *iopt,
> +				     unsigned long new_iova_alignment)
> +{
> +	struct iopt_area *area;
> +
> +	lockdep_assert_held(&iopt->iova_rwsem);
> +
> +	for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
> +	     area = iopt_area_iter_next(area, 0, ULONG_MAX))
> +		if ((iopt_area_iova(area) % new_iova_alignment) ||
> +		    (iopt_area_length(area) % new_iova_alignment))
> +			return -EADDRINUSE;

While working on the last syzkaller bug I noticed this doesn't reject
bad user VAs when doing an alignment upgrade, and the return code got
botched during some refactoring:

@@ -801,14 +801,16 @@ static int iopt_fill_domain(struct io_pagetable *iopt,
 static int iopt_check_iova_alignment(struct io_pagetable *iopt,
                                     unsigned long new_iova_alignment)
 {
+       unsigned long align_mask = new_iova_alignment - 1;
        struct iopt_area *area;
 
        lockdep_assert_held(&iopt->iova_rwsem);
 
        for (area = iopt_area_iter_first(iopt, 0, ULONG_MAX); area;
             area = iopt_area_iter_next(area, 0, ULONG_MAX))
-               if ((iopt_area_iova(area) % new_iova_alignment) ||
-                   (iopt_area_length(area) % new_iova_alignment))
+               if ((iopt_area_iova(area) & align_mask) ||
+                   (iopt_area_length(area) & align_mask) ||
+                   (area->page_offset & align_mask))
                        return -EADDRINUSE;
        return 0;
 }
@@ -891,7 +893,7 @@ int iopt_table_add_domain(struct io_pagetable *iopt,
        return rc;
 }
 
-static bool iopt_calculate_iova_alignment(struct io_pagetable *iopt)
+static int iopt_calculate_iova_alignment(struct io_pagetable *iopt)
 {
        unsigned long new_iova_alignment;
        struct iommu_domain *domain;
@@ -913,7 +915,7 @@ static bool iopt_calculate_iova_alignment(struct io_pagetable *iopt)
 
                rc = iopt_check_iova_alignment(iopt, new_iova_alignment);
                if (rc)
-                       return -EADDRINUSE;
+                       return rc;
        }
        iopt->iova_alignment = new_iova_alignment;
        return 0;

And added a test to cover.

Jason
