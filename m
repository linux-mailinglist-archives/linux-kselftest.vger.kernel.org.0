Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEC77D2A1
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Aug 2023 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbjHOS57 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Aug 2023 14:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbjHOS5i (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Aug 2023 14:57:38 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FC8212E;
        Tue, 15 Aug 2023 11:57:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OW/uUc/FwE8whGwiPcMMLmTEclF8BAZ5jG6F3Lbhz3FfgT++hxVWcFj9OUk99MVd5Q1Fg7Th+qzRSMUPrTrKvD/hYcCaAPVJ+xVH5YRiVMsS9isCM91xk8fh2TwIyceOanq9v79dCh2j2Vr4ZG7V76HL+t+eJE04w+KEXyIjNJt/jeZBqcxeG4SGPsE1NEb65DNzA3gVOi5C8Y3t2x0DKTuStQmvv1XS5tCxrd4AoYV707XD/sc8ieb+03bNgaCAjQeO0w+HEBYCyBr5ns/gyW2CScBdvIIQrWxOFDxRt/Zr0EzujJvE9YjVZokpOG2W+wOXl4Td9w+qQz3gi3od0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iehL6paUx6BVwq4DAQkr4e4dphnpfIuKp89FsWYf4QU=;
 b=D9a2AENn25A8YNakVWspKhRqLRpT+m+aGjpL89/F/Nwnxk+6AkQLMbwI7lp6uHuBsc401eopIKQgRnSfUgPD4dEg5ePGlvErusIol7TsD16zh6+hmvAzd1kEX9CrR01BwAgmLeu8LWq43kh2MAPpw0MS6mJQGQ5ZVU2A92O8SuogWJ6GiaUsSK+rfE4xEGvspKZsvqP9M7eCwGkQJr//F1KFtrVq2ERj4bCQSLD4yMiuzoGEdI6JER/HnqwltAt5n4Xs4hzoMGm1R6kzGnjDvF6fUJfTP+knUoKOPkZnPBVpTOeXbBAvZ/Tu3Na18IJuG7vQcJ17lEWxtLVnwhzsPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iehL6paUx6BVwq4DAQkr4e4dphnpfIuKp89FsWYf4QU=;
 b=X/9cKrUnHpEy6x91wWaVXuNjl42UvOdnENrDXm7Hq/muVUXhSOsz83VXem5ns4IL042lD/jCsK+tSLNRmBnDDZk3rDcmi7g2LPosQu4LzwxwvARcvkqw7ZBi6z5sGPUEJmJMzN+Odj1SKGEmj4wMSqyvFHxIN626uOCvb/FiuJYbxaptM0cJXK6ZFejSIXzkCDPX3f8GoMflFJDxiBx5F7OsoCvPW8I8vxZAwxm0PqGMKIxETRD3cg4Z6VQwUxHvQecb/O9ihzV6aCw6d8js/IE4qgFts+qHIqI/miGBiIEwopookrF8LsQhVwB2zaPHT1ERtbzlK3DJtRmBJg30Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 18:56:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 18:56:41 +0000
Date:   Tue, 15 Aug 2023 15:56:37 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org,
        alex.williamson@redhat.com, kevin.tian@intel.com,
        robin.murphy@arm.com, baolu.lu@linux.intel.com, cohuck@redhat.com,
        eric.auger@redhat.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        zhenzhong.duan@intel.com
Subject: Re: [PATCH v7 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNvKZWcqrjp34zpe@nvidia.com>
References: <20230811071501.4126-1-yi.l.liu@intel.com>
 <20230811071501.4126-4-yi.l.liu@intel.com>
 <ZNuogZV2eEeVwNX4@nvidia.com>
 <ZNu2XWS0BERqykIA@Asurada-Nvidia>
 <ZNvEAWF8ljWHrcws@nvidia.com>
 <ZNvJph2AHKroujFe@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNvJph2AHKroujFe@Asurada-Nvidia>
X-ClientProxiedBy: SJ0PR03CA0078.namprd03.prod.outlook.com
 (2603:10b6:a03:331::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB5402:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0c3423-7435-4235-1936-08db9dc15c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FYFaLXuhzFicR1a+fP1qMmlGfE3ydO72cCqkofr588ODHG4OhaKekK7M0QqIe1tHRlk8Yki5yiHDhtM6QqiBqyFoJ41CxETPQjQTTocuieZ1/cfLqxGXIJ971idXGvRXXdAipVMUtqkhkabXcXfgLPVUPc4LtQm8f1Gpl6bfGo9ONeNFxcU1jS5KHuxs4d54VZ4tSUfKTolweS1Y+9VE8RYZoSaxm4T8kgzi9D57b4n3LXTkRCiiOc7BuFXX6QpPfEiUe0QU1CSta+noigZdojigCH1wpK2uHRAh8irn7qVWmqzYP6U+N5wFFKWPzyars8asaBoRXADyg7Bhtackkn4ftchEJA6614b+Mtl4XcvqodUYL0489WT8qBjikS44MKWu7nOGY/0zEZ+yqPPe0l1n+Tz6UCYipUFpIdnUtvJq9knwoMNNJElHsWt58VEkBXAUgugBMkz0j7xLNIZCC9xSxx0RTtMFBGIrYtufHsYCsjKDkz2UNhQDYd++JxyD3Q/EmqFJhhI6DYxott0m3dPRFRotKi1hPbdjvJMhIewWc+L2vZ2MMVnWQbWBO0eX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(346002)(396003)(39860400002)(1800799009)(186009)(451199024)(6512007)(66556008)(66476007)(86362001)(2906002)(4744005)(37006003)(478600001)(6486002)(2616005)(36756003)(38100700002)(6506007)(41300700001)(5660300002)(6862004)(8936002)(6666004)(316002)(6636002)(26005)(8676002)(4326008)(66946007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tSEDxxUmtcwH54NkNs8XOLC4J/OMH/MpBK+FJQxVp1RCvxbqk1q+v+iNgQIR?=
 =?us-ascii?Q?NbRRMYQ0PJhJCGOyI7e2mEq68O6OZVVfSVRfJdnnGpne/sYQbres6KIF8sT9?=
 =?us-ascii?Q?vsqQ7CIPgHiwEUG/SPEkl5f5JgyeB+oMOR4pPgV7kro6Z37k84oBf4b1jTQ/?=
 =?us-ascii?Q?aRT/8603FDa7Jn7oBKmYmz1MxvDGHOXFMudLhbJCCKE/7Va6UxccZnoRdJqR?=
 =?us-ascii?Q?LeHFg2/msAEkpRxJdtBkOGJHXLtDqUYmgSUXLJK9VblGd7nRy80Km8tH1OfF?=
 =?us-ascii?Q?yZoo+TH1gEUYr3n/QkHGiZnUXywPvxgoW6VZc4M2qiVcUA137b1CZf2YeBM4?=
 =?us-ascii?Q?jYsRJEiWp9xrfLzvxex/O6FDgYjkTNjFeLOp52WVWJfYob102BInmoP4+sRS?=
 =?us-ascii?Q?P8cenKJEt73o421l1Q3csY4hI60A6u4WYukm2P8zGgIiT/ya1he2PRSCbJDD?=
 =?us-ascii?Q?ZXx4yDGMVXHbMeJhvfZ8PyzFeoVKJedQv/bHRJS+SasiYfK3/FJcbENSicCe?=
 =?us-ascii?Q?RL4ZY8bGw3FqoZVO6KUrAqedawfmjM+17zhm+KVWPPKDkelWSgteoArfOE0E?=
 =?us-ascii?Q?O/9CJ4tiZCkJVbStuI4fEVq15RcKAVqUKCv+nSVLljnSSXtKLQ6UKP2TwJem?=
 =?us-ascii?Q?i8srl4VeDlW1dwzLFMDoDyG3flPxZq07uFF8n2drmJmqkPN5WVJJLzZDtfDB?=
 =?us-ascii?Q?qKSbQ051AF1r5q6QlZKfxkg3c701320gzwurleBEGJiS8N0wrKNd5dZr+XIJ?=
 =?us-ascii?Q?vpfr5bE0aRuEsQAqX+Py1lz2DPkQ55p8dCuF2ptTy3nyxw+8E2YVdug94uQX?=
 =?us-ascii?Q?AMKbOR633KGbTMKIF52qvofY6hLyflOlCubGkgG5opQtllkHJEJft7Tiu+xN?=
 =?us-ascii?Q?8ryWpc/TnNZ3F+Js7UWfLNQEGVfdZHSXm/DRDb6Qj7Q72yB6WVktrvYpYa/d?=
 =?us-ascii?Q?mGde02028Wf96ppGdN+VwwvaFF2d9CGeYAktnI9YQZ1qUEQ0c+VQkmTAsc77?=
 =?us-ascii?Q?0Ek69E7IWAWtwAdulFMCAzQsn9GcNp67UDctq9j84rRmGHu3Q+Qy5YuE0vpw?=
 =?us-ascii?Q?g7vgTsbjVhvsBtd4iKJsz7xqKV5raA1xLno/+0624qOla5OBS+0vlbohNhV0?=
 =?us-ascii?Q?uiuvucjNmaKHM5oQOcFMToGU6d40SQvhrVgiiP38WrZRB8Y9a4aZPbJVY6Rh?=
 =?us-ascii?Q?0e43/cG9k1hTNpUkUraQcA0jW9W+CSAZnjsQInnUJl6a04BD0ddeXZJIYuk6?=
 =?us-ascii?Q?bEvo8pTrkSqCMvnmDAro2Jm1XCsTf7jPkoz0QpGxepAZWP2lGrgnxM3NaQQi?=
 =?us-ascii?Q?LnyDfp8dAgoXMPfvSlOfBr0vyfaH8J+RQU2WeQ2jsU/M4WGrqq5s42g4BKEz?=
 =?us-ascii?Q?SGSFUKetPW4/6JXXpJAlFPWWV7+MQy3Kv4XJOK66yCYhQD71WOXNfIGJ4iFJ?=
 =?us-ascii?Q?IAVW19GRFskt3I9moMJox37Rmd3bNyx0uec/VmQb+E40vHqEJFrOsY0X80tX?=
 =?us-ascii?Q?MtPk+YzZi+1NUV6jynZFrRgG6ikOntE5fu64gfHjT0tak/0QTerJzMKIwEvZ?=
 =?us-ascii?Q?YJIMR8dwAN7sO1bSxHNFWTRKRzibKlSzBS9aERHY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0c3423-7435-4235-1936-08db9dc15c66
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 18:56:40.9025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BaDK3H8Wea//g2acpIK7eHVkiWpyPioo/DXaQwEJ3fKkc8ub9QGnoR1YDdm6+YZ2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 15, 2023 at 11:53:26AM -0700, Nicolin Chen wrote:
> > 	ops = dev_iommu_ops(idev->dev);
> > 	if (!ops->hw_info) {
> > 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
> 
> It should be:
>  	if (ops->hw_info) {

Hmm, the test suite probably needs some more stuff then too since it
passed like that :)

Jason
