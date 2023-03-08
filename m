Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4E746B0BF2
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Mar 2023 15:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCHOyh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Mar 2023 09:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231972AbjCHOy2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Mar 2023 09:54:28 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0528907B0;
        Wed,  8 Mar 2023 06:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0R0lA4UFzQzgo9AhCEDpEzplhXehdTwogQYJf3Tbdtaorq8Kk0gq2SUa60ZZG/LSdoF1DqB0QhYvstwzH+ggEsK27zIGxoycOoonHnV6jR035p9ZlnNknpdq5OZVLHnC9uXkbSaWbAU13LWJ2y5AGGtzNuw3Q54/6rXB4bDp1i5DriiUOP/6ZMzA7DyQKUpNDMsU2ZpzCArQ6t/cqbbXD65AnbCfSD9f0G3+t+PPinxFsn6iZOnb84mfWWQaDeBRnp2j+pLq1bXYtF+gBu8u5mGphmUDvomzA7fGkIypbpcy1B+Ko3n1UQUcLjTCK4XzHZIcK20zjga+u4OeUmotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAbhuDFUYp0Zmg02BIcFuRdHNNPpVLtt1/R+tIM9axw=;
 b=bpDUp1b9UUPV7hjjjooBfuvYfvMsN3FoJBT+eH0Bnaw5kTmYQf8lvvwubhYznNqwAZA26PYYWPdUVT1kfypnxeILiF2Pty7GAvUDfmfMGnTy6IltTn5Gt+k3Y0M1sJq3chc8SQAa0k++1J+ix/q38SvAEEU0sfkI9x/zFx45F9Q1/JLP1iInfgPq6qSv+x1P0Ujtk46B0KAjwGhmdTyQ7OWaZfdSK4lnPUu7dMica/gESQEizcm2akpYDCD5rg1KlONxX/denUsAN3XjefMkBZubQwlzT5SPsFecdQKGdOZS8S5i8AqsOC8M2bcyZwUCw7/ekM4UlB6j6XbvLXf1xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vAbhuDFUYp0Zmg02BIcFuRdHNNPpVLtt1/R+tIM9axw=;
 b=fcBGyXETXbG0vJtskhbzxHuTo/Qo7mwdI1Se5qumfpum/VTv3TYBRtiksV7C08wnZjZ2hwHD1EKy5xLw5vEeyXJIxdAMfOBb0yqsrndvT/thFNkaX1xO9X6kp/74Px1HpXPsU3ecVqCT899pabLv2pOwbi9LMvFdX0aOOrYysSv3nRJuGqp7kOgBdBsyoVtaYtLRdxoUnefiF/Js4ZrYI/u1kPj5+QImm4pWcx6u7mg0MaFlv/yg9sdkUNRBeJoj3ildP82xuPOx4S2uhLSqT7rfJjQV/gpJvul7/b/+P1aHib/lMSLBfOgPR5/MwdUXuNFsYhs7RNI3em7CRkKXLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB7716.namprd12.prod.outlook.com (2603:10b6:610:145::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Wed, 8 Mar
 2023 14:54:12 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 14:54:12 +0000
Date:   Wed, 8 Mar 2023 10:54:09 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 04/17] iommu: Export iommu_get_resv_regions()
Message-ID: <ZAihkV/ejgUBOUkJ@nvidia.com>
References: <4-v2-51b9896e7862+8a8c-iommufd_alloc_jgg@nvidia.com>
 <1d261af5-d34d-bfdd-d7ce-70bdc7368d9d@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d261af5-d34d-bfdd-d7ce-70bdc7368d9d@linux.intel.com>
X-ClientProxiedBy: BYAPR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:74::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: 92649e9f-e765-41a1-a2e3-08db1fe4fade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5QLExluzDHSjZDD8nlZGWQ+FOeZxUTEI3QoEDLK743cpwZv+CENVfnsaPmsQ3xygkm/ANcNzBtS4kq/nA86JgypgSXwD61CwV8rN3xjk29/QyNhN2hkqWXoMtxBTwu1wpnAlUtobZwUkBY1CVMCNQCwdCB5/56pO6ZOIHeG9CtWZKWX1xm1zfLgiGqpk/cMEy8hOk8Nu1dv+NYdAwZrlYwjH4fr9r8QVcng3NrI32PGBxn7iyjAumFjOVOJxnUm69iuuuJT2CBBGjD3+PIhvrPcGpZYphx37hFW7UdsYwnCGqW9YSj04rjOmnCB7q4UUMAN9c4hiMNeJ4+K7OVnjA9cFUkNyCQYmb9HJnBKwCKI4Ajgq6ZjtI0GW515YWvqbMKPHmHNFpWlaQPLslHC4iD5GWLjGi54xBwnYH9KClhT+ufCU7OFbh5vZDWQITYcL+PvL9ikweKqZecXzolEmlQyRBzTqg6QB9MLGLc6spwbvj3eEqYJd5evhx/ZBXn1RQO0da31y+zdcxSWEh7WwtG4JrxrRyS0kwGXS6y67fpYhbbbp/DnnPPDL4AJE3MUsUQm7q6ehmLGL6TR69hVSOJGfWAgnGrC3KpeEoB/gKPzoJfr/LCwcIK5N+Hyr8gZhjNfoy+3aOV0EqGrib2XnAkYiDPN/OOVQ52qTjodP9RJwwme5sn55jn4DQtNh2250
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199018)(5660300002)(4744005)(6666004)(41300700001)(8936002)(86362001)(966005)(6486002)(316002)(54906003)(38100700002)(478600001)(36756003)(186003)(2906002)(6506007)(26005)(6512007)(2616005)(53546011)(66476007)(66946007)(66556008)(6916009)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zW991L3MWtObNF1KRzOqPGVOxq3NErIqqI3VKwkveAQ2xJSf6ZEWx0PqyfSG?=
 =?us-ascii?Q?Q4Wx5rtvHFCfVMuQp8Dqo7kqNCeFyKMW9/2xnwGdMVzf5c6FSBcd4cFfKxhE?=
 =?us-ascii?Q?JNz94NVe83+2T9wEsgzdoIMqtQ3Hr6XhBZh6r8fGXxKp3mb/jvFprlsgl5S5?=
 =?us-ascii?Q?ICENZ3ZD9ebWvuW75nLRfMyqH8xd8mZdJpy/l0u48EcmOntq2XQR5i9UWmyx?=
 =?us-ascii?Q?XeF6tCSXUx0oI8AqAMmrHex9sMzyreOK7HAM9UjftXuoldYbIG4vbIzjUeQ1?=
 =?us-ascii?Q?YHSOzrk9CSXhSCLkpXbdzSZMdRBe4BcGM4BW/fCZ87qhmh6pAxRll8+PPymJ?=
 =?us-ascii?Q?oUMBFCVRr0ROMjPIyGdqutPlvqF6z+4Tl1XsH7hQUriJF5fAYxXScIDG17PU?=
 =?us-ascii?Q?RVPvdi6uOfgTPc26/1ey8BeJGqOseiKsSnpU4I/OBo9KdYvHxcji2KnGKSz3?=
 =?us-ascii?Q?IKqr/RQoLRZQC4lAb4dR1zEKIqGPke2JkqZ65y2qIWzjuaPCA9XmpWWkq2uT?=
 =?us-ascii?Q?vduGl4ZZPlOy8bjGmtJSowjHSyRoiK6cXfPnXpGVwVOPHwJrFnpsO03Nt0Z4?=
 =?us-ascii?Q?nvYJjXYLbGklA1jSo7x0pyXj3DFy1Ly8VehjW/kUFIylCdrEvmjEP0uYUUuP?=
 =?us-ascii?Q?tQoA4E6JIWr4gRbDbxGuohQBAmxAcpATrmCE7u+ybV4rbr1h2YpGbT8Atsrs?=
 =?us-ascii?Q?ZOmRdAo309Drg3yrjMjJ6571E390vtArh+I/TpFcsTr/ECm/tUBbAuqRXmXi?=
 =?us-ascii?Q?omSzXNNY8Qo7/XUopy40JBL3GcU1YY52INPJQqDmZcN1qJ6l5k/f3qGxFfrw?=
 =?us-ascii?Q?diCkUDQKkOSwZexSAfFp772ra/ZR5kKlUjRjgvWIMsNd3id4ieisfB0pk9sl?=
 =?us-ascii?Q?cEA42nVJD9jt8nnSdEQ69ALcSr6yS6l1G449oTcegrUmJ4rAHxVFvBW5GxvT?=
 =?us-ascii?Q?HZwmH/JiAGKP65Qw2pcHqTqKa073cr8CfwpsIl9KTAKkDavbXUmjnVORx6Zp?=
 =?us-ascii?Q?whEBfKW41DeeGg9GtvEdFI6aQm2PDn/45KWQz01dUIzhlPhz08XAbRQ8rB1s?=
 =?us-ascii?Q?05GjIX8h6HaoWlIljH+OBCpopanOeYlQX4L1fG1fsIvqpXIjxcTKvCL5KHv+?=
 =?us-ascii?Q?DWsHbP/cd9H4samzyOBKF9Yc2xxBhUl6yFLdRJVHhG5eaePbBrN2lrQ2hUe3?=
 =?us-ascii?Q?eaxtTQcged26D0To58swGEEq/jdWcS6MrdOmUDZCbKnweg7UHZQDQa0A1ie2?=
 =?us-ascii?Q?DgkAwdhhktyLsoCDd1nUH3ojpMtw8bqe9/5iU801o7PRMui4V39CgId9p3TB?=
 =?us-ascii?Q?E+yaBM3c6fIdqnL/epntJ2iuyCU5I8NgR7SlVmwjp3eqbYKwO+VvC2JEfH0e?=
 =?us-ascii?Q?/rnojzDTqedwzey8Yf//e9qu83sV1UZJMHEDPmorhBLTSttL4Yo3KHLwTsCl?=
 =?us-ascii?Q?TVjCR2PItORk+Yim0l/F3yZANRSKFo0TThE3c4/697adypxzXKgJd20I+qbo?=
 =?us-ascii?Q?XVqLKdV2L9faFstWgUjCH5eFteExrhaT7Xp164flukqG7622lN/FdAI7ORHe?=
 =?us-ascii?Q?H7PnShOxDd05JAjU1/JyBvQOYIitthuvSivcyJ1q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92649e9f-e765-41a1-a2e3-08db1fe4fade
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 14:54:12.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4UyWxK6i0QIkxoqY2IPGwXMxIH5UFdKKDQ0HgvTZiLwlbAX4Ontnnb2Q1ChdlqL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 08:06:26PM +0800, Baolu Lu wrote:
> On 2023/3/8 8:35, Jason Gunthorpe wrote:
> > iommufd wants to use this in the next patch. For some reason the
> > iommu_put_resv_regions() was already exported.
> 
> "virtio-iommu calls it and can be modular."
> 
> https://lore.kernel.org/all/20220708093332.GA28988@lst.de/

Yes, but that seems to be pretty weird on its own as the list it is
managing wasn't really created by the iommu core code, and doesn't
need to use the free callback..

Jason
