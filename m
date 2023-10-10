Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6040C7C0274
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjJJRVp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 13:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232756AbjJJRVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 13:21:44 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4578E93;
        Tue, 10 Oct 2023 10:21:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NXIQhi7GxuwmA+gDDN2th1jEOV+1MaEUePW1a3+vC5e0WvA5zx6Fe5xi83c7/NPoUcE3ezg5Kpse/aFXiLEx0dSK9ElY2+peS0f0xJtg8vXBvUOpZtk+DkSG155vp/rLR4doclDFU+Z5Sj3BrGcSkdk5SDgKjtRbYG6C1xRPoltHrJ0oYE8gmN+fhgNa+/fzasO4KzH8eUN4vDmJM90M0dU+GFRGlTWwusvCXwe8xC8M1v938gvogT1cyT11tDwOEFg21VI5iCQ78OjTORmpt7NOpHnsxXALZ5ma2OLi1oNneCkbmAMjDiMlAynt9Q5M3bEmQrAf1TPmVb5e65W4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Lc5N5acH1hoWTZorvO9xd7FBSQOXLwK/eSp1aveFN8=;
 b=V4Anwmh1SCZGZ6hpYakeTLZaAI4fiu+MCx9WVhTvRRVcpV+yimmjPHUZUtrsrxCHAhiLUjM9CeSr4RXFmBE6EAt6crLleoIhugoc5r4sxGUhLePWDxAUPW0nc/VxKX08WcO3/jGX9CoBWXVE5+lEHJw5aGnVHJyY99Sl1CMk7ccKj0j8T3+JRgH89JKlbfUy4N6rwRxgbZ+FvW3A3HDDzBQXHe+FihjjUGOihVSv6f22/uVktDubb14gRG84klGZ8f0XE8TRSdgmKi3Z491qmQ8tN/sFTLlvKUQy2p/ypHsEC2iPu57NNtf6O0C1XyL1zE6gTj8AWuXSmADa1jGW0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Lc5N5acH1hoWTZorvO9xd7FBSQOXLwK/eSp1aveFN8=;
 b=FYI2qgXvpyyXthez8Z5wDtcQuo5/lXkVJuFrPrBeeAu8iKOGOeI2uD2/BCzGS9iZBZrccZJicypYeo0WU8WuKs3yrWL0uTV1mEl7v9LSnsW4+5Ew/VqihoMcDtPwYBnGRsBXyD/jvub/BQGBCATQNREXFanfAaAOikcq+/ygIMXr6TDUNwFgzJMm8mEkh0AI011ceAwRF3TtDkREg0on2QdHRhU2/YXUU/cRYST1EjlZvmwhZsRw36KdV+C7dQZeqyViA7sKJxI/jFmUdHu2YuTSsQN87cMhKkFUHne0aqBOhKxOKsqvkV8Uch7FuWZ/jc6IqpmEBMKcQRXEOINvDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 17:21:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 17:21:39 +0000
Date:   Tue, 10 Oct 2023 14:21:39 -0300
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
Subject: Re: [PATCH v4 02/17] iommu: Add nested domain support
Message-ID: <20231010172139.GR3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
 <20230921075138.124099-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BLAPR03CA0096.namprd03.prod.outlook.com
 (2603:10b6:208:32a::11) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4324:EE_
X-MS-Office365-Filtering-Correlation-Id: d4a36007-37d7-4826-e336-08dbc9b55d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mk/+i46oYpZORl/AAl8tWp9PBJLGT7ksgBdeb4a/uQASP7l3GyZadgnTyNJ1kajnuHZbhhZuVHkGr75xGVHzowmZujEBI4dCPgYsEamWkUo9MKSUB8vSbFvUTr18Sle5hv1ijAZXS1Y3Py9ZUnJIWJaKTnp+dFGYE1F0BfhyB2W+CoXDi1vRet7Rq1tv5V2lQ9X+EpYLqV+N0ZqAJZMqi2T8ITeJzjekNIQ9AepbVeNx5P7ZdQ+J/Ryn2Mi68t0bqt953IEzshCFryH1peAGe5ZlL/6CMlZEWQf6xHVM7uPDP8uK4KB3GIt9PduAAua9JEYf5syhRvBhdLqZ2ppdwYw6owallCaUNS6ikkHWMl6yDjgOk6kYgppHAXV0DKOXa3g3cG1nkxeArcuTfJrDmZGe/UXztGKeWzdZha8EbOINlLhkVbzWs2Xxp1MSJW8/Vyp2B7mNR2nNygQ6U/gfmkTJixmTiwRRKx39UkMDTUS4+teTM/WJsBlG/MaOGUjPKISf8ziwHlWnml4IuwQlx3mfj/OVdSLfXWIz5TcXc8jGHoXmkMV64ZLfnVmEYyuy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(2616005)(26005)(1076003)(6512007)(478600001)(6506007)(8676002)(7416002)(6486002)(2906002)(4326008)(66556008)(6916009)(41300700001)(66946007)(66476007)(316002)(8936002)(5660300002)(86362001)(36756003)(38100700002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j/Ha4QjbugjgJCdpzLLhaDiRNLQcdDJt0kvb/wSk7epNOVtHVHjIwZEOqY5K?=
 =?us-ascii?Q?rHXyGDg/sRKts07+kGEDpVpT+oFYewDQfgFN78csio7+UnfXJkvcuGRFVi8f?=
 =?us-ascii?Q?qp2WIA0iJk+YuLRMLf9wONa67ip6jlfrpnPxJN9cHAGKB+kUNO15Xa8GsOXl?=
 =?us-ascii?Q?unZ+j+elw4YVprfmEKNSXNxjOZ//wIlslJBjhfnxKTqADZQPabaaGGeudBka?=
 =?us-ascii?Q?J6gnKQhfl0uLbnwcAEFYSjN6sySts/AGl12LaPo04LLHv2zACqGOXvo8T5jj?=
 =?us-ascii?Q?5WC2G1O0TiDXSi56eFcOB1uTuNubZvGk14w+Z/OQ7fdP5UfDtwf1Q+mhGFcp?=
 =?us-ascii?Q?vDWsKAkAMLTlYxIe8fylKamnebcZYd6TGZWse0+kDd8soe2i68WXw1e9NPCm?=
 =?us-ascii?Q?ZsQUBX4ULRz1zsVh+pyDcFqOq1Z9tAf6RDFEFusKvsJFYM/clPMJIoqG7GxR?=
 =?us-ascii?Q?A3e/wSCFn8vvwdaZp+TlMuSbCLwSZ/ydQBKaHbjGUdsJPwDT7lPT5XxMTXdp?=
 =?us-ascii?Q?VbJgk6y+1gGj2Y68B9FHIpKhutCl20e8Vx34zXzJ8kbpV86FUlCAd5rS79RR?=
 =?us-ascii?Q?28wwh4WSzvpJUNULf3DcZ3lFXFqXqBWE4Rv+24CvfoBOVQ0lch5K0unj3ymF?=
 =?us-ascii?Q?OHlAzVOBloRSSA/INBzVHke12+AzZ2FaEnh6dAoznnwFeNY2xN9UDDIwy0Kg?=
 =?us-ascii?Q?Hu1iaP0XbD73OxNUEhjL1Zy68AG4S+gZcS6STqNFb/uLnfLOOkEKHiCqr0ER?=
 =?us-ascii?Q?LC5fM1BPpLED6EBlCqeqEDsnoAtYd/i/XPeX49Q7Jk160hKGwTig4aAbifMw?=
 =?us-ascii?Q?zSMysH4tjoKm7aqq2zApTby3yqwHvXXC2XxA5Xp324yAYOXuGg2XLiv8sL5b?=
 =?us-ascii?Q?jYAF4i9TJhr1K04km/7XXDRPk64REhVhDETQ0V1f8poIyeehaZlbQJv76UvO?=
 =?us-ascii?Q?S8lHNaTkk3borAyrMdxbzgxVROOO5mzedUxytrJxZOoRL/sIErllNE9lIeDo?=
 =?us-ascii?Q?Dk2PsaFHJBmgcVeqwoogKDunChJzug/9jaSpP3C6lAMVBLFnjAnqCTVwUCWT?=
 =?us-ascii?Q?WAXG+5zxCbS0szQ6gQhGpNUuHidflS9hx/Jp8sns26VUZ0DEIiJwV/Dvmpn8?=
 =?us-ascii?Q?mPAm9JhD/3SzmRT1zcdlfvDRKrBAELhGEufgrX7VftVMBMWfJ10dPBwfBllM?=
 =?us-ascii?Q?ETPufXZVV/NxspRwtZtn91Y6ADC3DKZh6CH3q+cOgcpLiQPJNrELmv67XiRf?=
 =?us-ascii?Q?Ehqag/jy368K7vVNTxjfUXavCPHeErEqhbHsD0FI39zrrLswrRpCghHyYLlg?=
 =?us-ascii?Q?UzesLJo/nvIyaTCGRC6Mbhi9Ce20u0H5mZHaGmiX017TPCHJVZCdQe4/wfYY?=
 =?us-ascii?Q?lcl6jOqFxwfGq1Do2U/bZneT/Ik0dZ5w6YJIs6ynlxmRviu3QBFuUnPbBRuz?=
 =?us-ascii?Q?PNYNoFbkRdLUl9DC25hXlVgyUdTmR/tQVCstheyt4rpSnXo1CtxdPbP6mKqu?=
 =?us-ascii?Q?OehvChF16+K58MbH+veWVOoWGS0m7ySAr/RkRm76IlQWFO9SfZkTDL1Ra4t6?=
 =?us-ascii?Q?W/kwIYapag2kZ32RE/cSd+BGIG8Yh4zQqsAr9KNw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a36007-37d7-4826-e336-08dbc9b55d64
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 17:21:39.7246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jG9aD3Ux0Su9yLGrYc2lhXt4pw5v6Feuu3La4uEc+i0rPJ8WDxRoSUxI+lmkq3G9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:23AM -0700, Yi Liu wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Introduce a new domain type for a user I/O page table, which is nested on
> top of another user space address represented by a UNMANAGED
> domain. The

Lets start using the world PAGING whenever you want to type
UNMANAGED. I'm trying to get rid of UNMANAGED.

> @@ -241,6 +245,21 @@ struct iommu_user_data {
>  	size_t len;
>  };
>  
> +/**
> + * struct iommu_user_data_array - iommu driver specific user space data array
> + * @uptr: Pointer to the user buffer array for copy_from_user()
> + * @entry_len: The fixed-width length of a entry in the array, in bytes
> + * @entry_num: The number of total entries in the array
> + *
> + * A array having a @entry_num number of @entry_len sized entries, each entry is
> + * user space data, i.e. an uAPI that is defined in include/uapi/linux/iommufd.h
> + */
> +struct iommu_user_data_array {
> +	void __user *uptr;
> +	size_t entry_len;
> +	int entry_num;
> +};

Ditto about iommu-driver.h for most of this stuff

> +
>  /**
>   * iommu_copy_user_data - Copy iommu driver specific user space data
>   * @dst_data: Pointer to an iommu driver specific user data that is defined in
> @@ -263,6 +282,34 @@ static inline int iommu_copy_user_data(void *dst_data,
>  				     src_data->uptr, src_data->len);
>  }
>  
> +/**
> + * iommu_copy_user_data_from_array - Copy iommu driver specific user space data
> + *                                   from an iommu_user_data_array input
> + * @dst_data: Pointer to an iommu driver specific user data that is defined in
> + *            include/uapi/linux/iommufd.h
> + * @src_data: Pointer to a struct iommu_user_data_array for user space data array
> + * @index: Index to offset the location in the array to copy user data from
> + * @data_len: Length of current user data structure, i.e. sizeof(struct _dst)
> + * @min_len: Initial length of user data structure for backward compatibility.
> + *           This should be offsetofend using the last member in the user data
> + *           struct that was initially added to include/uapi/linux/iommufd.h
> + */
> +static inline int
> +iommu_copy_user_data_from_array(void *dst_data,
> +				const struct iommu_user_data_array *src_array,
> +				int index, size_t data_len, size_t min_len)

Index should be 'unsigned int'

Jason
