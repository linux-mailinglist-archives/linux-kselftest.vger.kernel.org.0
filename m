Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A734377D024
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbjHOQcA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 12:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbjHOQb1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 12:31:27 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3FB10D1;
        Tue, 15 Aug 2023 09:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5HNJ+AFoifb6YCdQPgZsiUx3P0bWqNejhwvk1h4GWxMpvK/L2iGYBeGHZ6ovg9+KHBzAL6+Ij4Kk3pHXy1TkCOx5HwXFV7NNQ5cibH4b96D8QtjIyPHSVQThLpZdN/TECtstkvGq7WM4Gx6CUUjxbfbx4VbaSt5xG/+5jXPbV2D5/oK/1Kw4D39GINNXngobTY6ATsJK0FuBr3dGIPWfn9bz1/+m5A7f9BPKhhGBVr+3eQCtukWW2u4ySW2qn83mHsiBjMKgA1nShhqG9BczeT34f1pp3/GM0C5BQJJEbsH4HZx+Syj+h1S++VZu03yjywhZyo87zRx0jVcJIXXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3xLhfFO3+fGfnvSB0QKCNq8h/q1TcIIiUM45dvSeMU=;
 b=PGGVrJsETJTygZ+wpjZL33nciCWCuQdjyQ+aq4wPajyiLlRXNJdwLz3iGNjeJybU0zhyClvaQmzLkWj0jBsSNKLWvwGyex2vis/Hw4kOFs6g9DULD9EvhQO0mBhlQINbkPFHpJlsajbIIsK/HaQ3tMYYX/9mBCFv3JhgxpcTsVzwvP1YHX8VrYxkzxPvgontPXU3S6rz5/RElqwcuaHBAxU6s0iZ6ZQILmr08yhcTqL8qMkBb2jG/NPAhPacaWmp+yxCFUmjUMzP2GQPSOabEbSKoo/LoS4czUZxrnX7hDk1cq1yKnuyutPesvLxqDKNdGHmRWCukJWOx8AXK706XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3xLhfFO3+fGfnvSB0QKCNq8h/q1TcIIiUM45dvSeMU=;
 b=DESYelcqXol80qislW+HPCi4H8JgLxET4y3d0ATqK/X0B1AsA8lDXEtm6h4y57yrzxGO9LM1AZX6KwUIoq+R1GeGTxcD4YXEcKD4zsJ/DbtkJMgRG/Wr/NJpbB17hlPpW7MBtEaGkBFw81YBCWHTfxsU2qliJ5qpjEkn17UNHay2vdzJo+pothGpECL3U10P5OYiM2AVrQtEyY1JlzATT20uxWVXDqclgwRRCjwsHPbdNjamjwBw5azehQYGXJQ2zTS6t+gEmTQhbmQ9vz4ret9KSX7e+1++j53OoB8gsCikkAnO2MY5dDMFJccZeE7Q/LGu4eN95NvrA9im6J+KaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB6923.namprd12.prod.outlook.com (2603:10b6:303:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 16:31:23 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 16:31:23 +0000
Date:   Tue, 15 Aug 2023 13:31:21 -0300
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
Subject: Re: [PATCH v4 11/12] iommu/vt-d: Implement hw_info for iommu
 capability query
Message-ID: <ZNuoWRH/HthxsLMd@nvidia.com>
References: <20230724111335.107427-1-yi.l.liu@intel.com>
 <20230724111335.107427-12-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724111335.107427-12-yi.l.liu@intel.com>
X-ClientProxiedBy: CH2PR19CA0017.namprd19.prod.outlook.com
 (2603:10b6:610:4d::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB6923:EE_
X-MS-Office365-Filtering-Correlation-Id: 86987be4-f503-4c91-9773-08db9dad1018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ikGarLWevNkypRkLHSYcIeaHkM7oB1JNUOk/Tyh+Y5Hzx9fFJak45Op1/2N6e60zh/ke4UTNh772ewv4yXzJpnLAd8MdyYD8bC6TFlpDBtMjgDAFSwIx+2Xvtjk44Xr4gYSVvBwIhygBsvn3+Glf66Y+9lWIVOF/9JvqpIFX/yOAFhKQi6YYmB9eAiYXHLPJoLWl6SuUi9LEqEhI2AmrMViVnpSaiuuQTuT64FPJzIPpbbN25mg7Apa7SzuQuSgj0aaEA44g4+HyVTh91yXmKxnFZoxbtnlIN306rGoLk4m6V9tdrbr4ehQwwd6GECkGPeFSnfH8lzLyi20Ue2h0qjYxM/gLLRJzyK5TR/+c3tLOyCQpxvJ83BeIc49uOC/soJIwQiGEB9mHV/lTkT09b0rp6EDi/kkVjSRwVtAUyZNQalvLBIACkc6S+bRsGGJEzQt2D6lPfctXmNpir+M/jAdHDZqVTM6vMZ9Rki/nVF8zaJg8XbQ/16UP6+KtVIKBORsWVDmhzUz5u9Cva+Oq3bxGGqtmy1tZhIPkil0ic+pm/x29Thi28fwqeq1g5wky
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(376002)(39860400002)(451199024)(1800799009)(186009)(6512007)(26005)(66556008)(2616005)(4744005)(66946007)(4326008)(316002)(66476007)(41300700001)(86362001)(8936002)(8676002)(6916009)(2906002)(36756003)(5660300002)(6486002)(7416002)(38100700002)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fLApWotOU5FmXxFKN+rPl48AxlxZbPT3cYuAS0bWptMGv8iOuO/tG7pIirRe?=
 =?us-ascii?Q?ZwBRuj9dMmBLwRteGCBEJxcJfBDdtEk4a87vLmEoodIz5nkS8X3hn9xCNYaK?=
 =?us-ascii?Q?w8qDYDeLb/Qx31Z0Mc3qIRQFihIKlNodS2Qd3MizD8pMVocUu/GWyYdpsn2V?=
 =?us-ascii?Q?CkSvIP/5NgdKekR79ul0oaKQFIX7LSBm+Ji299EMVSw+gM93tTW5rsye2hiG?=
 =?us-ascii?Q?nAJVgVWIyAArN9GXMXlgVrTpVc6uqhs0jBIRyxebjTGyDgHnpQNCm4/ch435?=
 =?us-ascii?Q?R3c11/3Rdzj7h+s9SC90a/DqLMRS8SXRPHIl8BnjhCB8vwPJTTfiz+b7WxEv?=
 =?us-ascii?Q?bIc2pRbufHHxPc3RPolcqTaLRWCKuDuEUEtZ2AYhsv6eopZ/T+ziWOuxzcja?=
 =?us-ascii?Q?SAYCldWZSHhs/XpOEqw8CxBMe0zpqnGUkNisviqRFnf1yHWUAxMemxJM2nV5?=
 =?us-ascii?Q?7UNT5j0QRZUbUdVPIsDcYYMUGhC6RiVb1fX+SHLEQIeRKcnS0eA2B8fWGlGd?=
 =?us-ascii?Q?W+JThqpFb50bS503t8tN/sprzoAMPRYsGyR8vz5FTOarmXJIzfm+8puYFOY8?=
 =?us-ascii?Q?tpoGeaB6Uxu7yBfgUmww5jql5UooZq+Rrma/UilriOOulv2aRJ4ai6FoMVB8?=
 =?us-ascii?Q?thbnMUQLxdQeAslckT3QM/URcscrqkrfTAKBYfJDmwWf0ZY1PDV1KJ4X7sBN?=
 =?us-ascii?Q?tX+Dogiy+5J/8BWrluik4aE6GaOS5D1L3QuVFGBvOHSugG0opRQE2yRQM7QV?=
 =?us-ascii?Q?i5pigiv9By5N+h/u6sTLy5Tr/sM23Upi//uUH0nh/21n4jwLCpBhf/vlndIb?=
 =?us-ascii?Q?Xzct4/M14HVu61XwyHKDuY2Ec75vdPJuxcPCpZ2ylNCK24ggEy6V82LFrihI?=
 =?us-ascii?Q?ArrWQok+ohXYondtXU2wM0tsxSqoMGP97F5ZAVxFQ9+hkZLWvE0ITf1zxpqA?=
 =?us-ascii?Q?aj1ck4AB1wCESpZhu720E1uz/NXySNWVBg88BvlhI2IPnU7l0xVT53QyOQ66?=
 =?us-ascii?Q?00QJLK4bpHjbUG7k1M7caFL0uHJm++mPUsi9bxLf/GwCa2E5Hs/3NvpTjK/l?=
 =?us-ascii?Q?fKdYTPgWFItEm+OyogkwI/bWmp42oeA25MYw+xxRrCotgz6WjsaVnxe+eR/I?=
 =?us-ascii?Q?ydZ9+u2+ivV6oSUKPSC0vRVKDkenfHlNMDKQCAzUr3rA2zN+OJ1p0OnvxDyI?=
 =?us-ascii?Q?BlGCuUxxb69EoYEawE/WfQlc2iYfmT3QxTDC0ppeMCoPqLXI/oJ/SHT03QZD?=
 =?us-ascii?Q?nUhjfPjCLbjz/C5tGeKnWR7ZrejQ9YyYGfMyIRI696snddrOi/uJLs9M7dRS?=
 =?us-ascii?Q?LD437Gy+K1uApGADQnv4hnxAVP8PtH9dacGN5FYBDnBkkN2ybmI6Eoi/TlLE?=
 =?us-ascii?Q?Gtkw4OWANMF7h2qHgbq8suszcMh5sjE/nbPmZJQFeeVvHi6EiY6LjdfwoRY/?=
 =?us-ascii?Q?Y3PGKHbgEx6V7gEzq8us0k6Kvr3bsiB7LGSDQ3VSZO9QIWlqtVGcFZhZUWpZ?=
 =?us-ascii?Q?opSSC+ol/sm4YPwk040KfMa5/ICaGkDNz7G1fR8wW0FCXPJ7XkmBxOW8osPk?=
 =?us-ascii?Q?SrkBrxEtmxlW8fV/kHH/FmQ8d2L3G7I0Fk2qfORI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86987be4-f503-4c91-9773-08db9dad1018
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 16:31:23.1513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sa5BXdUnCCem++buiCRUmgFBJ8x3a7b19w7e9z7+KNb8KYhlUHDugWpElJClcgGL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6923
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 04:13:33AM -0700, Yi Liu wrote:
> Add intel_iommu_hw_info() to report cap_reg and ecap_reg information.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c  | 19 +++++++++++++++++++
>  include/uapi/linux/iommufd.h | 23 +++++++++++++++++++++++
>  2 files changed, 42 insertions(+)

I would like to pick this patch out of this series to go with the main
get_info stuff so that we have drivers implementing what is merged. I
made the trivial fixup.

Lu are you OK?

Thanks,
Jason
