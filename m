Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C136C121A
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjCTMnl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 08:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCTMnj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 08:43:39 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B72119B6;
        Mon, 20 Mar 2023 05:43:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyhHSox2FZTnEDoir+4DJOeZO8MuI4thFfRyMgYlpC3Ujqg7ziR4Yyo6EEnGOsC6U1ZTkb5AXho2acKZWS1JMxypYfTiHrrsy319aZV0v0sNcTBewWlg/3phoOvJu3pxLOz2aPgxfqpzrXYb/rKGXxNxHD3jYszQH4OIYVqiZUKKBEiCahSgwCdxGKWgyZvN6LANQ5NXJ8OYQ09Kvhio2YZ+4wS2Ju0HGMDjuinxoNijgYCTtb6P0wu9vXMd9u1mZo9pNJG3WDpvjfjZFxLz6eUR/DctoLKpEmim1ayvceD6yHF+ZsKQq0mV1SvESCZ4Q0QszargfuXTdClpG4JWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7eMOayg9P1prabRZ+S8SyoQ5m7H8DyngUO6obOrvIJg=;
 b=iXqCU9tZ6Pt70cHR54M0cIRMr58WxLpltbXMK8216adH+5r9ONzbBX9kLhsG+SxKy/7q4TxUdbJkePC2p/cc8efW/JNPzHlx5fxt2D6/ZFfjMzbayS9Y8bRrstdaR/TG6stvDJy4nwgPngc802Ce9YGUH0ErzOwntXmEmXBhmtj5r/O2djhcJuTkKK57ReNhOWH88YmSDxjfbMFikGHnZl1zVHdsiP140+LyUxuxYLE+iQWh72n/tJuwweis8tD+xLmsPr0ZgS1EppKxX4C1f3p//A4ncWAoTu+L5+CoWLg1Vxbza3ucTjyUs9YL9kqcPIg64GlUOI2vlLVE5Eb76Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7eMOayg9P1prabRZ+S8SyoQ5m7H8DyngUO6obOrvIJg=;
 b=TNrDWqI38wKT8Ou395TxvQ2fXkaxoeKH6gUPIjCDv+pOy9pIa8g8oFFiYj8zSBvCuPaibaH3tctz2567lfUQICNzhBb6+z3+Vq+d0KwBVeCaq0VB0HPrAXGX/BMuWSz3M23tY5PniaMtDNbv4Gh3jWOO9/XQUzudn3Je6Je0QZ1U7LC7znRcgfqufkeFDmQIfjDYwlI00SDEbrs4+sg9nrg2mOYK1RE5j8eUNP62CyX0ypkz12qghJlAcjMvvHhNWeXx+Elm/ZE9o0jFfZBVhG/NNx6YImvjCAqTGImiCT9Wf/EEie0XL0Gmsxx2J0ZVEecqVNeLGAob/Hlc+kwVkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 12:43:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 12:43:32 +0000
Date:   Mon, 20 Mar 2023 09:43:30 -0300
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
Subject: Re: [PATCH v2 4/4] iommufd/selftest: Add coverage for
 IOMMU_DEVICE_GET_HW_INFO ioctl
Message-ID: <ZBhU8p4RZKVWKKBG@nvidia.com>
References: <20230309075358.571567-1-yi.l.liu@intel.com>
 <20230309075358.571567-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309075358.571567-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR0102CA0012.prod.exchangelabs.com
 (2603:10b6:207:18::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|BY5PR12MB4049:EE_
X-MS-Office365-Filtering-Correlation-Id: 079d1dd4-9583-4a2a-877d-08db2940b6a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XUgmWTNhXjCSmDDKx0Tk4cpzA03g2OnyIG7SpjIqWhqk9Dz+mDNiGnnJHIaKhCCoxToerLm77hwknKrbBME29+uKkrynv61RCTsl8mLHutCpSVFgPtpbJeC/do/DTZbXWSplZUhrvf6kiagefMNrvzVZE/a42QSMlg8iPuGhmCI8YEtrqt+3QgyX1tfZsdYOh0Z7Jvv+//Q0Ghw6N9WJu0rnlVPruJy6tFJCIR2ZtiC/v93DpZ0mCd5A+vSeDIHuaryr/Kc8ZGtdAy0+r1wt+/Ctad/TsA75daeIKaEeXxJfp6pxnQqxhLrtfZTPalpIc4t9Lo6Ntf+9qFskrGph82w56RBNsJS3jZErTB2raO2A2yaPLeyDItT+eGOcyhyaC22hjselzv4f6LDadxzxTFX4K/rjunqYhMSKaQIQjyOUAR+mK9ijrQU0SAdAp9HkllI6Y+9fuMO9az/OHm5YAGqb/h0BVIsahxdA4Ea4Ad/wlHSbxYrAs7tKbkTYJBpZh7PMWiAEzhC09i76PQomQf6S6tT0nT/UgQnf5e8dbF76GdDQkWbykcFt1AquQvtdxWchnEmaCkJghmoHMS0W+7EY0QwugIEJ2ycEGy6mxTKs3ohBEQpbod3I3Zq05BsnYsRDAntV5VNif+q/xwS/3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199018)(2616005)(6486002)(6512007)(5660300002)(478600001)(186003)(316002)(6506007)(26005)(7416002)(38100700002)(86362001)(2906002)(8936002)(66946007)(41300700001)(4744005)(4326008)(8676002)(6916009)(66476007)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?APb2bAYE4bkGc2nRmctk/oAb6zLH5ok5iXRDy/en78TrxB4+M/aKhPXRCcWX?=
 =?us-ascii?Q?YRIZQLjUlVjxEnmaDU/CYTwyVNUazNbscQOuS2E3ExMEjHzlIy6eobnE8T6l?=
 =?us-ascii?Q?vYMQym4P5fTGXukLOu1tLXqdHXxtbQY9Eq+SRXndQluBn4blnEol9AXeYzZ9?=
 =?us-ascii?Q?AC54sby/52EJ4ICgtGtfc8AkKpx3saVMdDj/J06V1c2VvDtvabi2f61GJy7n?=
 =?us-ascii?Q?TzfMYf/+QxZSM7peobj/2IWXuF+6wgF0t5qTwU+bNKL8LHTe0MuWP+k6dFns?=
 =?us-ascii?Q?ir/xsMFJQcGQ7Dte9/TrWLnEkoW76Dhxm58Si+xsv2GE+dUI3iayOI1Q4b3G?=
 =?us-ascii?Q?7lUu7xG4BgIZD59ATOdFX8O9zBvLT/i8Onmp7wcdHK7rZbB8OeqIrrjcf7s1?=
 =?us-ascii?Q?SKmOTf475PgCvhml/q7mW+QRaj5tgyUmsleDdTK5kznYy3Kf8rjFatOl2/bj?=
 =?us-ascii?Q?P7dwXEQJTv10vmF/GoP5FAmW/8Q6SF4qk2zY8Tl5njLL9JO+baLe6fEEN5N2?=
 =?us-ascii?Q?FxFc1JywcrXw7twQSPvoGMPu+YHnnCR12pUG3kmMDFV6UndjyIVXoyVy6T6C?=
 =?us-ascii?Q?tdikMVCwFdnDkyYnqSSVFMvly3ONO9yAJSF2vmIZXU7gO14stZ7ZCEMZNkhK?=
 =?us-ascii?Q?Wb181PzpFfJJgGxo+vVUxVn30V6a5q16k6UxD1hUyVghAt95fB+QRPZOYtmA?=
 =?us-ascii?Q?qOikHP4Bish4OJEuOZB8Wll1tXnfjUiVW7n3d6tRqlFW9ixttBLJz9AUP57d?=
 =?us-ascii?Q?8qfT/7R8u/2ILOp2r+IeqIM6OyYKi22OVuAbG0OJMP8L0GMcASFfgDuiG090?=
 =?us-ascii?Q?N5fF2J2YjWmUxNLJGL31AvPGpR5HSUPq16Dt435CvWLZlpAMIVX9gQ8obHow?=
 =?us-ascii?Q?Xpv2y/C4F/AvM595ua5CFNuT0ofTl7J9+YixQTw+ma/S2lVaqquMEysrSIDH?=
 =?us-ascii?Q?2JGFg1h2g5ElLQN2XIFVWxovqYlVWpgu/YUfvGprtVolwTEKO6l9Hu1BvNh5?=
 =?us-ascii?Q?MJKgECwM2Sjs6zpLXKmtVyjIlyhgVDbf9PEThLW1UyfH0rqnqXO9Tt/m7zld?=
 =?us-ascii?Q?nGlihz3MdpTAeoQlIHw8lO1Hn2Y6KQ9BBWZjBJdxGt6bWbXSrHYh8nvNlzxn?=
 =?us-ascii?Q?3EvkTe1hGBb+HD7Cwm3xoQDF016a5ylWdq45/YP7B4a7SATIl3hDwp68s1II?=
 =?us-ascii?Q?6DhSnHwYSe+fshXgnh1Evsptry4ulVEqIN3oMk2a8p+zeyRNjpGOWIkVjmzc?=
 =?us-ascii?Q?yY/LoK3ZQCxRlTQuikP0PWX6e59sFFeeAm8+lzzQp0XnPYaLb9H+QTIruOcU?=
 =?us-ascii?Q?OYEELaNYiXvsVG1fk8rxSWjQHmnJaKotSrzqLBnZiCOQPzx5p9wWBslIzQEk?=
 =?us-ascii?Q?QfiPJEzid6aWfPqVc4yaZoWRQ5AalF93jzvoIaFHme/+L2Ky3Zo4YyNfh4Ef?=
 =?us-ascii?Q?WakOAw6WIeKI5q3tnoCNHWBY/B3lphWGY2JdrYP98Q6xzfuzbDPsaCfAopSX?=
 =?us-ascii?Q?WQGWin58itLeK/jSNPc75HJqLLX+oyxTw0SsPUfoFCUAifSvWnQU2jHQ9nGx?=
 =?us-ascii?Q?36zkC/G/Ru+UMT/ZTfhNPxoU//jt1mRK0LFn3wib?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079d1dd4-9583-4a2a-877d-08db2940b6a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 12:43:32.4282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X2NXdq3iA19xwdPaOXueomKxvKgiDggKtyTUolV79P/3NfcddJlkmSDAyLVJdb6n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Mar 08, 2023 at 11:53:58PM -0800, Yi Liu wrote:
> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
> index da1898a9128f..578691602d94 100644
> --- a/drivers/iommu/iommufd/iommufd_test.h
> +++ b/drivers/iommu/iommufd/iommufd_test.h
> @@ -100,4 +100,19 @@ struct iommu_test_cmd {
>  };
>  #define IOMMU_TEST_CMD _IO(IOMMUFD_TYPE, IOMMUFD_CMD_BASE + 32)
>  
> +/* Mock structs for IOMMU_DEVICE_GET_HW_INFO ioctl */
> +#define IOMMU_HW_INFO_TYPE_SELFTEST	0xfeedbeef
> +#define IOMMU_HW_INFO_SELFTEST_REGVAL	0xdeadbeef
> +
> +/**
> + * struct iommu_hw_info_selftest
> + *
> + * @flags: Must be set to 0
> + * @test_reg: Pass IOMMU_HW_INFO_SELFTEST_REGVAL to user selftest program
> + */

Probably don't need the comment, it is misleading

> +struct iommu_hw_info_selftest {

struct iommu_test_hw_info

Jason
