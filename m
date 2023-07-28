Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF0767294
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jul 2023 18:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjG1Q7h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jul 2023 12:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjG1Q7f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jul 2023 12:59:35 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CF210E;
        Fri, 28 Jul 2023 09:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aagp/HC6wKUUHYhL2TlYwwApL0RL8FLPg2Rv9GfJjWcHeelecTxrjTIVPPVDg3odAP/eBj9TJA3y+IfYeGRyEWOH1EjQASEoLusT/n6fzfIxhYLAHkOI1kDPFjqX8soQQJVytdZdeSHR9QQsvN/N4UM8cYvSjewrMcYDboVwoIXEmSeCG5Os05HSB6gKkseylc4DVVh/Ls4WhNZVTl/uaZ35HlNPxVSYxdeIbL2OtCKisf3Togenabetej64Ch27V1k+OU/Qky7pCopzcaobn0qTjWBjubJAghWKTDotanVX/PPtWlI1eznBhKzJo9A5KKeUDSo+r7jAn9n9G2g7qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAhdFXfEFLNKL3cEu9FaIbkJm09Fj/g3sVMIhp3qrvw=;
 b=gRxtQ0Ji0LN6PWej1dzzZZf+2hb1cK2aD+hIL1fT29//+N9LqBf3hoIq/AzydUlodTbPWSnS2IBxMR76VRFiBAWc+y4a2xHOHpx5TsA4UMw+E3o9tX1vyMejrqiZZ0HFAFws7MrMv/M2wtzHiXUfLNjUelGf+vlx60kSSLkBNn9GHe93c+T6CTyMLWhwDpuPR2ZRtIKdzr/i8iVEge3mE2559sJFwfvTQ2LpiFvt456bdEqXBMD6xs10oitl0qUXECEUK5BkSGG9z0tI8m6Kr3vlTN3HtZ3EhrPE9HNn+cDJJf+Aoit08hEAb1NfGc/1U2GrDHvtHzLN1PN864PowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAhdFXfEFLNKL3cEu9FaIbkJm09Fj/g3sVMIhp3qrvw=;
 b=k4jm8fwsp81iNwsnmkZ29ohxZTh6ZBiC3VtAssQMzKyFsbofz80IpE35/B66jOjKulisXi/2tSs7NDc5uO4bp4KLgWIbUAUzTz3goCJdXKeGzVo+erUNTMZOdwYz5MCV+lUrNcq33phFy/cXj5qBsmZMhGodC7PpHZgf6FxyxsIog/Kw9G3RBps1IghPA5UZiVoPf+lg+0kppDdiD+J+6XQBebd8x385ds4PHi1Dtgjk1uDy5ArOafIxQl6xwahAYvqnZM3o6eaUQJ3x4wK8odGHdtoDSi8dKbBn/ORe1V2nt6SCkdj9hEEJDj85XtCA1I1RMTqxT453aK7uELnMPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW5PR12MB5622.namprd12.prod.outlook.com (2603:10b6:303:198::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 16:59:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.034; Fri, 28 Jul 2023
 16:59:30 +0000
Date:   Fri, 28 Jul 2023 13:59:28 -0300
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
Subject: Re: [PATCH v3 02/17] iommu: Add nested domain support
Message-ID: <ZMPz8MIevHBd6zsI@nvidia.com>
References: <20230724110406.107212-1-yi.l.liu@intel.com>
 <20230724110406.107212-3-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724110406.107212-3-yi.l.liu@intel.com>
X-ClientProxiedBy: BYAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::46) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW5PR12MB5622:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f10b194-59de-40f2-6269-08db8f8c02a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsxOE9Lu3yKWY70WxUvV8LcyFlwrtjECH0Yv/H/IoegGn6+Tb+Hbeg7OFPlMJv0nZGXynZb2EB9mVRY/NvGJ5zwuDrd9TsR6jlz4k2cyGdJnze+2WOWyoJcYxpMEh+p/N9zaK+I3Uf35zwTdh8NZGNB0T9Bt6zaYkQdCgIvKEPIWK11GrHAwC3p2erScDEjjh8QZHe2AbDFKSi8DhUFMlAbREKCupwRnb6J3TTZoibgJ+TIofBJSEdUJqi9uIJ15OMq0q3830/G5T6gEuuvg3FfyMcDGIZTdv8mYVGXhb6Oe0Z+Lf29brzJOmlD/kZb3Ptyx6CvSZHzxU/Z3Imv7u1eKTAb9B/DZOqISwFC8LoGYKfd7cXxEGJNaE8jMcypw3q6Q2VRsCHxxI0EK8YcJPMe4TPOGLQzH+zJoTaVFzAaA6smTU1iumSxn0nL+grGwZ8yLND06+vAyuC47JhnqxvOmXh/ZVAo6vaskXFN7I8J/lrziAwl1UTJ0ErsO2b/MjnDyAnWvO6ZM6FpaCj+wRvEvxI9Tj8jtYHgZYmekW2lT75d7hz4KSnXMvXM1yA2h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199021)(478600001)(6486002)(6512007)(6506007)(66476007)(2616005)(6916009)(26005)(2906002)(66556008)(316002)(8936002)(7416002)(5660300002)(8676002)(41300700001)(66946007)(38100700002)(86362001)(36756003)(83380400001)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h6SVI6MIUV1EOf9VJITOnDC9QA+GKDRXBf1np9zzzYq+WLYYgcSbusxwUbVa?=
 =?us-ascii?Q?UD5SK7O+63UmYN00DGGI0sDPAFK1dFPkL4U/c2LZMQ+qdtC+QWTDFSqTLLQn?=
 =?us-ascii?Q?lV3M+8S4WkwbxWUbkq3YYbIyRyJvOkki36dQPtFXvCNQ0Qv5MPrqZMLV44Oq?=
 =?us-ascii?Q?18iRonoILEdACon7e5W08grhFDORVQhRpkzMi1JD539dHllTG+CHo236/Qr4?=
 =?us-ascii?Q?0ADfpMovQvMhh+bJvaqU3FPo79R6+qia81PTyAvgt+Ty3g0KEGlux4Ss6jX+?=
 =?us-ascii?Q?arPl6wsyQksWjawHHUGvYPalO//1RRfFpIun26PZ+dH2oxusESpFxOiK6JhN?=
 =?us-ascii?Q?yJ5K6r1WYbNhPy2ZXKVmV59ZFM7JprwEpTxnFl6tTZr82K7Q0haBVScJLR/G?=
 =?us-ascii?Q?9C+8hKO7uwxAG2oISIUXSL5G8WlTdhzoxERuvRHqeYrbZekbnOmR6fgXzFFo?=
 =?us-ascii?Q?TpUkDmbN/zHfOTq1fXm6GwhJwNvKisX7wdXEKZhSBwBLOj7lA/eLZV8gPBNZ?=
 =?us-ascii?Q?MEbApeFhTwscvcdigj8PMWAmEjm+jWhaqXSfk68Kli3NaAuhBxclOhCdOC0+?=
 =?us-ascii?Q?7HgmTtVJlGw1qOgZZZDzJ6wJlKcWsCslTP3JwkCPtl+5vf3AOIDSUKjoWAJw?=
 =?us-ascii?Q?3LZgm7S1YhWjg/h5QTD5Uq9bui/rA5eYvZ6dzxQuDsdo2cL6eAFaujLfZl+d?=
 =?us-ascii?Q?mnX3iPoLW2Yrj4hStJ4HWIlWKuLiq4kotFcjdExWPXsS7MKMaSmmZXvEx7xA?=
 =?us-ascii?Q?iVN0cEnKcsdlGzOMeX8Ko6RsFNu/nCqurDukqkvcDNXvIGI+qcn5CI4ziso2?=
 =?us-ascii?Q?PA5E3mdtsS7z3TMgxMXLzkXnk1yVFD5EcIr0DWTWI5seTnD/Bw31sFPQqJj2?=
 =?us-ascii?Q?dIeD6/DyH4o2QxBnD5dlGLWjAMEQ2zAR5XEp45difCPuiQQ46mYHpw0/Sy1c?=
 =?us-ascii?Q?XY25AELK1sZRX30TomJqRuSLKKH6fgLeD+xcEjGq/DIAN6Br7d5MhsXNQ7YY?=
 =?us-ascii?Q?ADmgp1GuKmv9zYuBJS5Go3QuUheswSXrJFA5XBsozKE6YwIEkLtd8oU9n9jf?=
 =?us-ascii?Q?SEsQpKNjeV3dw6Lx/t3Z4QQhmnUMLMw71Z4pziFNci2eMvGkpg7FGQdWsUdZ?=
 =?us-ascii?Q?BUlEy69NUIHhYMpYLCaDnmcFyYjkkVN0O1VE5kZIrEc4z1JbClZQdQoo5ml6?=
 =?us-ascii?Q?XgKM+qrXSg+8nZwF9ypQ3bdy+28nmJfi0sy5c2YfpnzvpXSC8++xAz1DgUGE?=
 =?us-ascii?Q?LaV7Xj29JCS2CiJnon4Fcd0vriuVnGCRqQi/a2OqtMFuGWP5sm10WSngyhTO?=
 =?us-ascii?Q?/o5epHqNONPqwz6soW1qLNAaEMj/F0IK8/vlbA3gOXBNQF2HPULdieQ0OZcX?=
 =?us-ascii?Q?azSSMdRYOl1XURTPd/2CvemOJm4DsaZnsdUsWyAElOndmEV9bpR1YLnYQb09?=
 =?us-ascii?Q?uV0qegYr17LA3bWNk7HcN3vwsJ64lra9GcdX1kkVyNKoR9dsXX756PsmmqLS?=
 =?us-ascii?Q?l4FQGlztVXCJ8nm0/C7uKf4QeQSCLLDl7iCxMBrH2Nv5xP4rxj/QLahLvJ1V?=
 =?us-ascii?Q?Q4VFQ5XIIxeyFVQ2UzeaAHE/+1WgqXZbyY2PTOu8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f10b194-59de-40f2-6269-08db8f8c02a7
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 16:59:30.8361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ktglv99ZaamVr+lX9RB4hIINf3cNcZYuzDBsh3lyiJ3uHD6Oi3X8FMAEJzD8PWzN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5622
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

On Mon, Jul 24, 2023 at 04:03:51AM -0700, Yi Liu wrote:

> @@ -350,6 +354,10 @@ struct iommu_ops {
>   * @iotlb_sync_map: Sync mappings created recently using @map to the hardware
>   * @iotlb_sync: Flush all queued ranges from the hardware TLBs and empty flush
>   *            queue
> + * @cache_invalidate_user: Flush hardware TLBs caching user space IO mappings
> + * @cache_invalidate_user_data_len: Defined length of input user data for the
> + *                                  cache_invalidate_user op, being sizeof the
> + *                                  structure in include/uapi/linux/iommufd.h
>   * @iova_to_phys: translate iova to physical address
>   * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
>   *                           including no-snoop TLPs on PCIe or other platform
> @@ -379,6 +387,9 @@ struct iommu_domain_ops {
>  			       size_t size);
>  	void (*iotlb_sync)(struct iommu_domain *domain,
>  			   struct iommu_iotlb_gather *iotlb_gather);
> +	int (*cache_invalidate_user)(struct iommu_domain *domain,
> +				     void *user_data);

If we are doing const unions, then this void * should also be a const
union.

Jason
