Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A717169F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 18:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjE3QnH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 12:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232771AbjE3QnE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 12:43:04 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CFFEC;
        Tue, 30 May 2023 09:43:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eEdrQeoVRVW4WHNsTXlE91m4drkqxrE8iEjNQgmCpFOWpWzOQFEYmYLQVq4uW9hzH9FQ8bF2XwRe1HamBqF1NkbC6VU12zQ0S7fkv5x6MZTpFbu3q0hS1sNMHfXMG8TKv7I5tZDPh8l2pJTP08JVGO8eNV7kSKUEOo2fQ3EYrVGmZVYV51waLEQ2aukpNl7MiUzCzgLUC4wat864XyyIPicAIomuy4M/Tr1vxMK2NrwfaZ4VeYMgUoHnWeIl84HLRi0nYtXnzPR2alLkgXVlOKtIVhnFiQPqvFlkt4yVi2+1hHcKcyC99jZiTN5qnne5Ly2UIyjAbMeAM8hI0Jxjfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP91f1MduvAlMfS9U7qsIj/aBxarTpjE6RMbZRkVrY8=;
 b=ce65ugLuG62mF03pZE03kqRi7i14zwm/umidsI2rJOewhkHL5DKHqJPW72vPFG3oOZXl8N3x7eayEFLnN8PdujVvSBDKWhNVlYihnNdHfqzmQ6xpfI52sDansoQhtuyRuzduX/IthRcOgmzu0nFjhNkcOF7i4ee0AE0OnkddfrAKXr+BdMxTA0zBvf9V78QLHxmfacc5MRzYFCx66KkuXwkbV4gP/Xk1wUvaL3eqlOzd29rUDz6CY6nDOkD8r5hxlnwK/rNuHArtF7THkEanug6M/jK/3WEIUqmKM6z74YzWQ4N5QOZzP2X9pdfqQj8RozIK1S8wDjmyQ8FXMq9JYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP91f1MduvAlMfS9U7qsIj/aBxarTpjE6RMbZRkVrY8=;
 b=CAAjT2yaU3S7oFzUuN1kPmT/HcXzLSgmOiUnaLda7D5r4EFkmfFIcpP6hbuPIz07+WAQssEh1hilSop4XqQu7+H7mPc93QXEHlBkcu12rmJDcCyNTI8iR5H9mDle+TJTX6UA0kwwSIoa4UxBxNGayGu43ezT9jeXdeSW+JjVTlW/dt7DAHYTlZ6fqSthwZjpXjQKhmaMt6oy+zQbba436tJqNsZQprCuFBZXYksKKXV3rP4oiWhi4tBMuXhaIyfOrScJX+RVWxBh+E/nUpN+zqOGmnTvmhDqXx2sJdKUrAKkd5Ky9hrJMujS/p0mEIvTxNZ/yi+9gfNt1M7m5395Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 16:43:00 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6433.017; Tue, 30 May 2023
 16:43:00 +0000
Date:   Tue, 30 May 2023 13:42:57 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 00/10] Add Intel VT-d nested translation
Message-ID: <ZHYnkckYAHI3EA/6@nvidia.com>
References: <20230511145110.27707-1-yi.l.liu@intel.com>
 <BN9PR11MB52765FA8255FB8F8A1A6F11B8C419@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZHTyNgnjj/bOkIgi@nvidia.com>
 <20230529181644.3a6a5c7b.alex.williamson@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529181644.3a6a5c7b.alex.williamson@redhat.com>
X-ClientProxiedBy: SJ0PR13CA0240.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 7457eff9-0ede-4d79-903a-08db612cede9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MR5h3F+KdJOE0xqAYPjb/Km3sX0KMuD/CqF96+vk+3i/x86nFNh9bj3OxcokTe8xpJBikF8DX73fZ9V33GqEhx9URuyB1kivfeNUaqWvcBLtXliMUbGEdVcwayAbGTvUTHPDtDcFlS46bWXooZXURCoNodoqxopJx7fCY2khxKaEMMzeU7kGMjMAk7w3/YjdRphnnvRA6VTp1NmxblCxAQTZ4g9QkHskMWX1ZFa0SWlPKghF6B7h0dya8cEEXd0hVWISOJmw2llStRPOJmEWqlHa6IjTQbBE/JCR19dLBW21ee6vLpOXruGmcL86UFnuzCV5z+xcoQLrI+36DI4jaiDCSTFdG+Jks3xVWQuSUzqn6rH457EueanIHSXXqh9LWIrNO9Y0tZjD4tV2G3HiM+96M5m7nJwAFspxsivxDrGrcnJLqVgyjDEXPu0SsyIAdpM2Gfx9S2UpcWDi3FGyzjVnwVp5dYAIx/T78zkiEWLjo2D8HlT0UN51WTD7SOANmZJgUQr3+p2p1i7jBx94d1jT8BHTHRYvp0lhDUv4nUHQxCxLEGPKBozOPCP9TPQb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(451199021)(5660300002)(6666004)(316002)(36756003)(66476007)(66946007)(66556008)(7416002)(4326008)(6916009)(8936002)(8676002)(41300700001)(38100700002)(6486002)(86362001)(54906003)(2616005)(4744005)(2906002)(6506007)(186003)(6512007)(478600001)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aF4zaN7Q2HfZhEh4ib+/ufwdqA+cqY1CEb/5/wdwDEiFdtWsxeyXE6/N0mI8?=
 =?us-ascii?Q?Fl84zjc9KVqKyryOXSvgo08QidhrlmtHQhMEf9kf/r/SI5JHS2Hjg5p95j8J?=
 =?us-ascii?Q?2wIVNLAcaCsAScUxhHQM3j78kD4weuQLT3qDC9dpF1982C+HF9JZ/PMR2lQ3?=
 =?us-ascii?Q?qSU4ZaT5+iXTF5mShKSU0cahZ7hLDhgOtXJXHpE4va6mN3CgCX6T7IGi3E9s?=
 =?us-ascii?Q?lrdezu8nxQTz0NMALa+SbkwnxHCEtcxYeCHNQUMRmcv+wUrxhFg3CtxuVimk?=
 =?us-ascii?Q?ug0RGt+JsOisKAOKJztcZvbbTWDdeTnZpZdTI2bTajUctKQqH3tfIyMM6LW/?=
 =?us-ascii?Q?TsTk2+MlZ9JpsHa8FrTbgN9L5bKJzqaKwYdSuvStst6YxpEsB9h7n5Qgk0Ye?=
 =?us-ascii?Q?AycQsbP534iRDy1CJeWCUC06j7en1/CSUGN5138Mcc1aDo9601a5fay7Dsfu?=
 =?us-ascii?Q?9717Q7zWsqkzVB+HNqlXMEbQv8RzQsvylpEwy0ZtfxuMey+nTMAESeThCJyW?=
 =?us-ascii?Q?BwElak1XZq5tbCLHNW3I0x1SLBj6ibj/o1PWo3/6ntRJDf3/lSsAN60dGkSJ?=
 =?us-ascii?Q?SDo7X+rtOhAkkGNyuOLeoj2gqT2W55cR4L08C3LlOmb+DPcT0CudSnvooYKx?=
 =?us-ascii?Q?/PtgwH5Moe2FJQPYmJVxyosZWYvPz6J5bPEEFVVT+iFgvMqUR6Uya/YETOHF?=
 =?us-ascii?Q?dQP+1WexXrBRTnT9hB21Hk3z5Ze6KmsKzh9FGA30L1RgtC+8UAGEXLSott9x?=
 =?us-ascii?Q?IAGVrqFLzj9EQvrsgi6LBHY9Ha5Yp0pTKyecj5vqXUvu49mlPkYAjUGak3Zb?=
 =?us-ascii?Q?3/5ohwniC0wOitdOncLpzAtZSQannw+yRqyfYYKNOwarW1a+EOCXrKnXs4Uu?=
 =?us-ascii?Q?EjOoyCT1L6yObWBfRCFsyMnLtkC7nZqmcLKEfqKSG9I57AP89n47v24wVWhG?=
 =?us-ascii?Q?C+dakFA+z77bbreU7QEXqU5BQzHbZWKZ6OsDuol7qasxnBUvTQMwtOZb3hMV?=
 =?us-ascii?Q?e3iAhNMB3/xLcEFapxwOOLhTRjzmrSqg9GQPGqQAKNn+3ceS9BACs0xY9rdL?=
 =?us-ascii?Q?CLD4I2oJ6KODI3P7m30PUB0c2n2NbmJiBRdruyXjB0c6cFVwkGee2Pla2nPg?=
 =?us-ascii?Q?Vn9dvDUUUzmcTCCzyYaXDpis+yuHl4DpaL1Ox0+wWSw3V/VHkQbHooseBb6e?=
 =?us-ascii?Q?okLWq2nZhnFus15seVnQScY/qO7GETO8WcoUlewcnhhJpuSYoM7bap0qExd1?=
 =?us-ascii?Q?n1f0ix0PEe1MeA54jRxKB0whrEVwBr8H1FSSogmWKYbzqtspRr5pB49mfKCe?=
 =?us-ascii?Q?VeVddYgvyXPwDSvb01Tvf9uBaPRUhEfQ4hgch5hutBeyKk3UFV4RDSUpU5LP?=
 =?us-ascii?Q?NT6UOLS9nyUsO6S7Zp+Mb+a/i3CSI+nhRx2YWK20g+B/vpbZXjWDI+ywp2pc?=
 =?us-ascii?Q?1yrWst5Rr7z3mVeLxRG6QrXMswvLrHktMAug76ns+09Abc6mQ2KzRpPY2+ff?=
 =?us-ascii?Q?q8AoFxwZIpHZbDH2Q/o+NF18aegVEAwzJbABbyGV4/yuGq0AN9unsiB47ZBf?=
 =?us-ascii?Q?u39bMHk5IpAfYN4y0eeANlARSTs1pWLzhUHt8Rcf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7457eff9-0ede-4d79-903a-08db612cede9
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:43:00.3512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5WsWsHKo0GYiqkhg/HyhL5E4YLc+qJFPtKcb4spZayXjjRqwU7rKALLprkvahjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, May 29, 2023 at 06:16:44PM -0600, Alex Williamson wrote:
> On Mon, 29 May 2023 15:43:02 -0300
> Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > On Wed, May 24, 2023 at 08:59:43AM +0000, Tian, Kevin wrote:
> > 
> > > At least this looks a reasonable tradeoff to some proprietary VMMs
> > > which never adds RO mappings in stage-2 today.  
> > 
> > What is the reason for the RO anyhow?
> > 
> > Would it be so bad if it was DMA mapped as RW due to the errata?
> 
> What if it's the zero page?  Thanks,

GUP doesn't return the zero page if FOL_WRITE is specified

Jason
