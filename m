Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097C763D2C
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 19:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231792AbjGZRE0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjGZREZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 13:04:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4371724;
        Wed, 26 Jul 2023 10:04:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tmd4bwpPUXR8FZetoTFKPRLNKSG7EAbV7s53QifYfK2pCOZp3orGdW6nqv2vupsG3OZPSd0HHpHHVRc5Z2uOnXghZIgalmYpyTQfFEuIncA1Kq1xOYBAzJzON9j4Aw0LBOcOtMgC2NXrVSOP7ciH2e7xWnZ1xT+8Uv61HZbPBmOJRl0uQoSGFR47WODmjFYnrr8rsQe4UPhIPnSGkldInAtYNOvU+ONaH863jGK8EzT2EbrXqhQQeX5W1xMSzqWILkeaCf2kLwwjsJnX/N7g+eQU10j8yBJZyK8rTvDFnvq0SkJ2epi6nbE1D/I/KCg3AsEcWkURxg7X2NvOMW08jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnurN+SB0Zj/cXeebGT0WNXmvluB+n5r8u/WaKViSQo=;
 b=ddUhUtiG7r0PsSxQovlutWgpvEzR71v/8QqlP7vIG5nF4SWVnDnmyTZIYE8XR9mrLE+HflR+yPA64nz3kTL6I7zxV2VfLYkJe3f6OakbDdNH6piYrwimkDVHN/geFlz+Sk8b1qzw1yYdBC/fN/JCJM9+1HbQTR58aUVvdGAmpwbqibg/MFw7iD10uzWbZGzsMisWNP77MC0R6LtVsysy4nyZazmnQ3JPUnlOcsUeM3VXjYIOqAmSiLvy8eOlLAxEN13cytGpYKRN2VLm1rjoiOXqoOPu4giNY5X4/FLGHPQBXwJZ/4d96Lpjtpyd/rZlj+ccPn+bQGnD5RvzQ1lz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnurN+SB0Zj/cXeebGT0WNXmvluB+n5r8u/WaKViSQo=;
 b=B2LvgQuo6ogU9ThXSKEVPBwDhU76zf2OoDClwrXXj9E8AZ8CywqSM+zlMMEfC7bdRoovfV7jvmfT5qK1zicDB/WbjTA+0KsiHz6sWgFnFRo114wjB8ZOXU1dt82U7JMTSF87NpJC6lmyW0Cnk35S0/8RAyogkmLtNXDMJzOmrMmNi3Ipck1qzwTcLmewcWVOJ5HlaYFfCPq70ORAk2qvns4tGx3XGufIbXuGtA0hFsxk11a+xEdklDwy9ZcZknpuH5z/yqVLdi8SFDCrQcGh1ve2N+BdqJ8elnh/spLytIpxJcIdYlQJWKpdByYESwpaB4XaagowolMdhH5HaUZAPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 26 Jul
 2023 17:04:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 17:04:21 +0000
Date:   Wed, 26 Jul 2023 14:04:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, alex.williamson@redhat.com,
        yi.l.liu@intel.com, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        mjrosato@linux.ibm.com, farman@linux.ibm.com
Subject: Re: [PATCH v8 3/4] iommufd/selftest: Add
 IOMMU_TEST_OP_ACCESS_REPLACE_IOAS coverage
Message-ID: <ZMFSFKjPe31XYfCd@nvidia.com>
References: <cover.1690226015.git.nicolinc@nvidia.com>
 <55016f5bccaf825c28fc0dc4fd0254812967b91e.1690226015.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55016f5bccaf825c28fc0dc4fd0254812967b91e.1690226015.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0364.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: e77032a4-281c-41a2-f76e-08db8dfa5b2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RNysWPpHlLibiI8QfatOyJtPrnox5u2bhpUN2OUydpaJcLySmvRT/BY1I5Wi4ZKz1IWh01AV2bpTFebayBWndWwXnvnffX4NpQmEvry6aX0EtjcFXlQsO33mKHjLXWbWWCZ+iwELO9TUtyXQlfU2FF8A6vtRrovVvcz+1k6+uaNdPcpjI+E5QeHoy6/QLZ4njOCZH1Rf1z66P6n13GqhxvvI3xClL1D5lF1JYMIglPmjY+9yoiSp0tzhC9VJloea4K+FruoB2LUHQMALhnWBBQ4QA8+ouJZeaNzt8mFV1kTREBsNRAVkFw5uxn9/sVObk1BMzKddxgzL15yG3wvtZ9tM/hP+UuILN7F1cofl1OSQqx/6/BDo1Ax7u3550Xhd/rr9qG4vOfwAuE5PFk6+xSit+sP/JcvG94ud90lLH5wRYIAOhqFnd+UsPAwgkGeVijRqpqXo0rq7Hyam6jLwIxxrwYQCJXJN2H6K9UjYw/dIgjS3eKuKQyaflyhdz77yMQ+Iqh+pwpdwqROO78uOldFAAirEfSxmOQbLNvheNZnPBLE7bGodXBFj5kK2oDw9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(451199021)(6862004)(2906002)(26005)(186003)(4744005)(6506007)(38100700002)(6636002)(2616005)(66476007)(83380400001)(41300700001)(5660300002)(66556008)(66946007)(316002)(8676002)(8936002)(36756003)(86362001)(7416002)(6512007)(6486002)(37006003)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KShKMWTTZsI+6hzQJPaL18iTscdsIrAPX5SCu9/K/3cP+damDgidvYxGx8bB?=
 =?us-ascii?Q?sjtAjxuNSaLEveZ0vK8cKMsBlGyFVE7Tsu1XMGcj8NXxRHKJJOxlBsI+I/I5?=
 =?us-ascii?Q?wDUBtiwWBnvJGRMXKJjg01adMWL3UsZxEFrR2bVCyF+kkuo4+4W9oTVTmL+b?=
 =?us-ascii?Q?agqGTtFHgidHu9lHrVqKHZ5REJRHpUz/64IBxI+tBKFchJfZPZ/EmdJkfLD9?=
 =?us-ascii?Q?ajnFTcpjUoYPZRAz1I2CXjZbVzTXq+FXRJoxGJTwm1rKKpuONhA2eGdAM1ze?=
 =?us-ascii?Q?N/g/YTTsAu4ZdW0frH/LwLfS/jeAknloq2OwOeFpCBoTJoXPOMzqbUSA3mvQ?=
 =?us-ascii?Q?3ltyzYeOzOVt2KVEzVhHu8fFsd1arrNQWTPs8L0lX+nr6F8ZqcqB+loKb9qL?=
 =?us-ascii?Q?qQ4Gl3wM1qEdrbzvaUDUuvSm1EwElihjspOe9L876ySaBAGwfs4xvfmKQLma?=
 =?us-ascii?Q?vTTKu58AyaVyNi/3Wyz6id9Fj8jMICHrF0309+oghC9UWIA2LcMJEF8y6/hP?=
 =?us-ascii?Q?nZH9sGdm/v6Zp70MuQVHARDr4VAfC5ZnaGKFIo40a6j6R9W+EjkAY+h750X3?=
 =?us-ascii?Q?g0lU7aQBeog1zy3XjudoSQ+6YRS5ZZ4LBdYSDHa39k7P5hHI9uMtdQOlpo4A?=
 =?us-ascii?Q?MQxO9HWRTGeMfeRHqruiCArIxniEgTZgu6DeJ6ME4v8fxn7pLgXW+UrKdKyG?=
 =?us-ascii?Q?IR07eB9Cr3MUfEnc9coB6HX1+w3T9MV3JDG8wfTlMFv3CsqgjvmTmSlvRfIL?=
 =?us-ascii?Q?dTE0ADyN1jPeKxOCq/TY27ROQwqYIXN12dzDjiRlMNtNQhHmTcKaxXd5pwH/?=
 =?us-ascii?Q?28D9LujhSDLZoJGxASqqNdhEJOivIG9YlNJBRre7q2vzHoZMy6pFgGuriL29?=
 =?us-ascii?Q?WZrvi6EhnSr5hC7R5ayvxiZdpbZMPhdficBMCWBF9rsqCkwasf9/+4zvq/b4?=
 =?us-ascii?Q?C+txlH+O+jpUzf3YjJqScdlEsM2tojID3MOkvzvnhwjpsH+5Ss9UbjV8c51a?=
 =?us-ascii?Q?Ac1vpmaNdtZu+DDXPyPxb7xLMzYL4pNFNy1LBxOzmDftRW/NrSLO8ef4N7Op?=
 =?us-ascii?Q?Rz9sBL/G7dClJHVAv1LwqoBDr3GtE+xuIypoJJzV4ZHu2OrWUcmSYj8y9I3g?=
 =?us-ascii?Q?L7c28nEehrKPrnZl9ZBKwnYOPjlk6iAA1zQNWhQBzIez92CSkSohLZpO/Yte?=
 =?us-ascii?Q?3VYh1gh0RAj5QIw0u5aaWvBlAjv8Ai+2bnELEYPdRiJja7mNTvk1r1U777jf?=
 =?us-ascii?Q?+WDVowIiSgLEGHZ64HPpO88nnzvtEtRVndHvp3BMn6Zp52lJ5nuHlOMurdS6?=
 =?us-ascii?Q?593A13C7ifzjq8k4Hh93yYTyelo20+XW6keiLcznALIwNdbyOnP+xQKUBjqr?=
 =?us-ascii?Q?jqNUUCqiD1h0A0wB53MaRBJlKvkiaOeI+dArq2pn1cQgAKwinROlmzHbkrqc?=
 =?us-ascii?Q?NiiIiUVx6q3nX3zpJ37fSNFDZDqKEi7sXQBLoz3kBNM7GU/isgcMPSQsya0f?=
 =?us-ascii?Q?diEpwLvjWjocuujYLupP4pSqnZrz5R5txJ6U4kOqzoSJg8/w7DcQTjrG7oh4?=
 =?us-ascii?Q?heEkEF5lawrw4RxUhv8nhVc0ciYYAI4f36Iu8ctu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e77032a4-281c-41a2-f76e-08db8dfa5b2c
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 17:04:21.5684
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6oSciEZe9Pytiv2VZYbDBe9Jlo8OFqJW356bgpeLwiYbhO//4aYomSqQqWdnPMm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

On Mon, Jul 24, 2023 at 12:47:06PM -0700, Nicolin Chen wrote:
> Add a new IOMMU_TEST_OP_ACCESS_REPLACE_IOAS to allow replacing the
> access->ioas, corresponding to the iommufd_access_replace() helper.
> 
> Then add a replace coverage as a part of user_copy test case, which
> basically repeats the copy test after replacing the old ioas with a
> new one.
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/iommufd_test.h          |  4 +++
>  drivers/iommu/iommufd/selftest.c              | 19 ++++++++++++
>  tools/testing/selftests/iommu/iommufd.c       | 29 +++++++++++++++++--
>  tools/testing/selftests/iommu/iommufd_utils.h | 19 ++++++++++++
>  4 files changed, 69 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
