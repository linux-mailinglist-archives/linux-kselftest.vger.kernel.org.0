Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 757F77C0200
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 18:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjJJQxU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbjJJQxT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 12:53:19 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAE793;
        Tue, 10 Oct 2023 09:53:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9WT5aVhPEe/BhnJ0v37v4VTuilkt7t1HSZS+xZ+kCM3Xwqv5oTv8LiktdjIPsWup/VVOs1FEYyLQ+wVxEaiV8+wSfWq3rgeup/HhYq/Gtk5dfzn4OYn+CepoNtEf5/huxhrAgIXgl5tmYEXr2CgMXr7v0q/BYl4kRyqXR8nJ4lRJDgr/oMask634EDLnzlq+gbFIKV/X6vN/WeGcSSiVA+QkaLCQ8jy2haj4kkFPsA9UuqPnVxCFJ4AGhkDCbOplFhjrO5Cwpitl8C1kyDfy2I4M4B3ttHloO1S2Cl2yFlfySzRqZxkmzI/Gdja9+9krKZJRqXhFFl0lE2/PWzPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+5YBmlstkohNOZ4LW50exlpFyP127bE2IsDc/NZGro=;
 b=beBqJacGwGmvJLMrz5ImKdBdBziIHupcQIbUPlyFIMXkyL4RMVnBoB0u2y77qW2QbWcEEfcoEegDRxZ00QbJswe9Viqmnh/D0xQzWV8rlOEghfXyBXdSzn2gnbZv/7EDm8fRZ/YsT+o0I1vCquMLqDrKDTa/6hnOvhsIFHhqsXbIgV3hbr/EnBP0N/8N83r1sMJQB1WvB1xHGexXsGiCr2wKd6bHuFhxD9OvyPONlvdeNUsVFryinbt1GEP39jIFRzpu/9PTN/qinwCLj8xqn8H3Y16KNxfrxDSA7wGEQMRHFtzsgMA4a8200JwUlNG36H2kuVJfBMv+iKqCh83fyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+5YBmlstkohNOZ4LW50exlpFyP127bE2IsDc/NZGro=;
 b=uB8RjGTGqkuXrQmdzPcQLgWuNuj9cfZQGiTEzuhd9TXdxxovnve//pqhmlutxPXRKmahVjgw03PlvUsLpA1eKhUQdaS+K15Uq33kfoqroj+da+S2BGZ1dxHTB8eshe/pu8GiUdcXly9LXffYWJb8d0a2XCsSIJ8eSxcTm5m+Giux4OgCV1Ka4ne3pEl5aEtVNFF/PvAkU0Eu/AqyqMQT1tzJz96yOa34O1rw8GjiqXnq4YWqBqfNKpe6ITQ1NdmQtA/v//gtBp3ABtUkihYEbCCL10EfRU/1VcM7JN7lmPskJOPfUf+yvgO6n9sJr09ieJzvFC2KcezLB3YuOXqPjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Tue, 10 Oct
 2023 16:53:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 16:53:14 +0000
Date:   Tue, 10 Oct 2023 13:53:12 -0300
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
Subject: Re: [PATCH v4 00/17] iommufd: Add nesting infrastructure
Message-ID: <20231010165312.GP3952@nvidia.com>
References: <20230921075138.124099-1-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921075138.124099-1-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0421.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cb35692-1643-4ecb-d20c-08dbc9b164bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kGfJcZuPKfTdi7pvNcsw8wq3/21b69w6orZJRh4ZX1hDhxnGBNopgT+FoRxP/6zaufMPjO3DjRc4LTROT1Xd3lxOomHCIKorPEi5iPU8EpmVYo9lz7yRG7l5+7RfrTfqAXu/lSLRbUPOVdixSkJqGUNc/qN6cOwDRNtppyXVZpL/jF4Ui106k1UjcYfq89PaOtU0nrgt3eFyfM7P2eRPlyI1ipnZ6PJW9XbTNh0H2qmmR9eEO1akGMjbUBuoT7eRIbsBSkfpYOStbXWHYcvVrjA6rSy4KVxzSVamJX7+HSzQB7gzhMwxfEtRlywF2Y5TDGQxz6kvGJvZ03rSwGZmCoGvbKSeA1SSjdHeHGvlne5AYKARfy7Y7BQ6meZM1P4RdKwwt1K/TDd/x8r7xD3eSwDZJXsoQAc47uespsKHFkFXWRRsbyH5BNQr7VuW5+Ld+7M3wuFDaKIywYdWXTDgnCGqE2hYqseKxYdKbwev6JorAAbgCSGkptiVEVm/5wEFIs3/aPsnTtKuks47RRnxTxazBr9VgjglUfXMNf+dxyLEUv5KeAy9WBQglUHoCGBG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(6512007)(2616005)(6506007)(1076003)(478600001)(316002)(41300700001)(6486002)(4744005)(83380400001)(7416002)(2906002)(66556008)(5660300002)(66476007)(6916009)(66946007)(4326008)(8676002)(8936002)(26005)(38100700002)(86362001)(36756003)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ZzjV+Ww2583n8fuh18z4xiYUq/IWc3OhNXAwKGB2e2qCKP/eIJE+NN34na8?=
 =?us-ascii?Q?+YH+O7fHgQVRiuREVtCwHVXcj8YcxCqtY1OJplhTPHM4mbQl7yeSb40PZJkH?=
 =?us-ascii?Q?2I5I8Eo3Dkj1Ai203y+tkhZYLZHe6f0/XUKUpS5zK9I3zUgdvgcOj+T+i4P9?=
 =?us-ascii?Q?TiHI0bMsRWATWTF1xwVucaxb2pLEzIr9F6oUUhgghi0mnnghc18z9X/JEqVK?=
 =?us-ascii?Q?UZSYZShvw+odwU9VML7vk876sDcEWGZBBEWUuuDnElRxkTlE1btE4X9FwlFu?=
 =?us-ascii?Q?ChyeFBYzmPB+M4uLFXEZoVXJ+hV0u7JmdJS4LJsnTjVbfsUZUKfcukNpchBI?=
 =?us-ascii?Q?FJaE/tTVAqqghklBeObbMlAt5n9dS90E3RDnFn5rcv3atjVEBdZvkq8qcpUM?=
 =?us-ascii?Q?XlLBcMEsH+GaXc1Ooy9jeTM8m4pDxEkPnNElsavgp+evyok/oABWoMDlluS5?=
 =?us-ascii?Q?OIWLnMJ+aimDU7u9+/+5dasksQZOn1fiOutDkFVqT3Ar5UUaGeDIEGPazSdr?=
 =?us-ascii?Q?psna3mRCztZavhMxlWdi7BtrC6jA7MzFzav1cb7QSp39wofR8Y2/Dg+JNzO8?=
 =?us-ascii?Q?vctc5yloEkU//2abgwwd8fxfIz77CYaoQtGH0E4kx8miZMZXhXt+BUCVmwc9?=
 =?us-ascii?Q?GC7A97p0wkVT97v2Jr4dJzXRgOwcCbW1YDBA+2LZNi+ML9TVNSrix12xvHJO?=
 =?us-ascii?Q?xx6DciFj0iIxyzMsXwd9ZPQ08rJDorxNRtk2FI25smFd3I73aMmoianeDlXw?=
 =?us-ascii?Q?TYyoGc05alJ+fEg2nCEooC3AwS1OpFWgkG6CGCjSfUJLFFSQbLcPe+xC27oL?=
 =?us-ascii?Q?zzBae+R4m9P4UlFtYlVEtJiv4Ah/F4QOoZZSfLHiqi09VUXQEv3Fz5OlseIM?=
 =?us-ascii?Q?xFrT9JElC2wZkiNoqe/tHKnggjJWi5Cp4bWuB9WwzRBOuVLm7c/VQ94j1PDh?=
 =?us-ascii?Q?h5ub8vVhkoEyX8sJrhujYjngGeQktTUGKE4Onhene3TtLOyi6jBZ1xDzujwe?=
 =?us-ascii?Q?oLFjRKBNZ/En/LolHGmN8V0Dzv9MYujzG5dfH2g+SWS8TJxulkZsRrgCkkWS?=
 =?us-ascii?Q?NPjkhTFPOFXbjr4CXL8XRn7QWBNNt6RyC5uhD8vsBLoAaaRSk3w7lZSgnLSh?=
 =?us-ascii?Q?PpeGGFofYrboUybzq8aawSKaRf8Ew0y5GuWh+IvoJwt7TD02Vr+BvjtyNOZZ?=
 =?us-ascii?Q?qPbqC9rYfFRjWSO0vMsU2fFGsd3deGZJQBA2Ps3cPvwMpu/FmCjEORzPYE8l?=
 =?us-ascii?Q?KvPbXGKw2EhOYNxfxE3su+fx8JYs3N/JtIs6ht6hCAaMJpotTXoKjw5qewvx?=
 =?us-ascii?Q?E+2GeTAlj//gb3RVhvWVGgmHrC1MWLwk13aone5EJJc5pOoSjS2t5avIkZDj?=
 =?us-ascii?Q?d4sJMWUOJbofi17OPTD9LJLMLjGul7tfygGZvFH3tElmEjLhZcj23hxq5dzy?=
 =?us-ascii?Q?letiqapmdMJnuIzPAeTPnJinl1tlq+pbjZNqH34v9YuUXN3oVWZojwKgjN0e?=
 =?us-ascii?Q?YvkWuIrYLsDLfK9vlorhAAwa9lllfrIlIE4i3wo3GjNvAakpWDT3b9p+1+7J?=
 =?us-ascii?Q?mjNeX41dSLtdxS9X6GPTHOBKKvHtAQ8tbXwso6Vp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cb35692-1643-4ecb-d20c-08dbc9b164bd
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 16:53:14.2089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ysPzOQO0zTl1dANAfhV+biwvhrxqu6KFczgPao0mLH4krEcA8ifn9M87G17s6YbC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Sep 21, 2023 at 12:51:21AM -0700, Yi Liu wrote:
> v4:
>  - Separate HWPT alloc/destroy/abort functions between user-managed HWPTs
>    and kernel-managed HWPTs
>  - Rework invalidate uAPI to be a multi-request array-based design
>  - Add a struct iommu_user_data_array and a helper for driver to sanitize
>    and copy the entry data from user space invalidation array
>  - Add a patch fixing TEST_LENGTH() in selftest program
>  - Drop IOMMU_RESV_IOVA_RANGES patches
>  - Update kdoc and inline comments
>  - Drop the code to add IOMMU_RESV_SW_MSI to kernel-managed HWPT in nested translation,
>    this does not change the rule that resv regions should only be added to the
>    kernel-managed HWPT. The IOMMU_RESV_SW_MSI stuff will be added in later series
>    as it is needed only by SMMU so far.

This doesn't apply to iommufd next so you will have to resend it

Jason
