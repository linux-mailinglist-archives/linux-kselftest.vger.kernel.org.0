Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3DB16B4F73
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Mar 2023 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjCJRu6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Mar 2023 12:50:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjCJRu4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Mar 2023 12:50:56 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF05C2D140;
        Fri, 10 Mar 2023 09:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TE4S3FYmPZuK94IljfD+DsOu/So31BJOXEQjbYw4JzuVEyevuRgBy9L0vf+8f1PWM3SHnIsYMSX1rNK54YyhNds+xXuLOgdHpQsl7CGF1KgyQApCYzOxTt2Q8++Mz/i2EO1Uj7LFu/QiVnUcGFaOQXRW9rOPkR/Ho4sb9ErPWa2NdJB/VeSR05NaqejyAIidyAQf4B8RDDXA1wQ2FrsCmWjdHPlTV2RHylejoaS0UldWMacNIwVjTqYHgyhwSZN501i4FnWjQmNkiWa/mo4hu9EEe0VRQdi6DqTp4r41nCYbK5giw+xLG4Ur5l3HllB4uOzp9fYE+IEZKobGGphSwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KwVQghQY1RkoGK/a3xxiopTmhxGAPiTjcD7q4HtP8f4=;
 b=T9/aBoTz2PtD7dBBmeov5XQPPNuz0r9h+2RCUAxbR3uYXdn6l9SK/Qc9ifnCcYb2npoIH1zvfCSSgSIqgUtyZrLh5oW0b30ng/lei7Kk8eJ6rlTgQXSrZvkd2SdNE4DTigz4l8QMjoFk8FSEvyBScgAC+RZncSQVz/pKFBczzThyhPWdfCpQIrJAD6FGT4IyFxM9mpi4niKMu9mH7QatchMf2OkomGUJgzDSAA8BiCZB+tN6lo0+ZOHu1KL7r4qJXVQltVSvAX8LPBwt10ym3yhUVm6W+pe0MaKQ6Z0KeG+kzWk3E3XU6gOoUaVmcazcIzxIG/YRKiUhQ9z2L1nXcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwVQghQY1RkoGK/a3xxiopTmhxGAPiTjcD7q4HtP8f4=;
 b=OABvCs+ipqOEqb1w+AkowKpgMDh25m9EwqkOjK3ZeHTiK0WDmkAfVG0VaAof+R8WjRqHuSGU0NthcUKxJuhkKpf+/bBpxOvbW97HebVfOg5sKjFgnN7Beh7VTfDf0WQthM69mt+5yFTwrdhU/Xo+k6BWOpluxGNCmgAXl199vdgz6KHFbIGTMHyvYyqDwS0nSwg4KHL/hYB2qLODVCMzAw4IxJ9tV4BqsA/NyVVQanAsXERa96FXwVTw70C6QIsCA3i+FJHY2cakOcvhSStUnD3ht/G84E02wbS01ugz4EvAdh/C6E2Vix2u+E3lwwvt2749BKodF5FikXipQL5shQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8235.namprd12.prod.outlook.com (2603:10b6:610:120::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Fri, 10 Mar
 2023 17:50:27 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.017; Fri, 10 Mar 2023
 17:50:27 +0000
Date:   Fri, 10 Mar 2023 13:50:24 -0400
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
Subject: Re: [PATCH 07/12] iommufd: Add IOMMU_HWPT_INVALIDATE
Message-ID: <ZAtt4F9zSZxptyZh@nvidia.com>
References: <20230309080910.607396-1-yi.l.liu@intel.com>
 <20230309080910.607396-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230309080910.607396-8-yi.l.liu@intel.com>
X-ClientProxiedBy: SJ0PR03CA0110.namprd03.prod.outlook.com
 (2603:10b6:a03:333::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8235:EE_
X-MS-Office365-Filtering-Correlation-Id: 31a939c4-9588-48b1-1181-08db218feec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ocCZPbksoe7kSmpFClGLpEXIk7UC/UYCrhrZZjv5tBg61QvvrZvgAG6/VXUzPgQjneDwaWQI4szd6L9A1iax3ophk/zzL3uHr9wP6uDvqlWlOsJn53AHzr8bIaA+B2jTKuJcN7epCV/HgH7cctueLXua05afyx5UqfDbC0MrqITnFtcsHgkqx+TTzcRw0d6St9a25uRcxRcr6LAuMAhYcoYMIxt9TUzQy+rOKm5X9dN25sqNEU5dPXqbPaaj3s4vHlUNq8beqedO0WbrxfZNMzd0bEhN5gKZ23PQHIifedO2m6oObBwn2Lh2Otty03aU8atWwSnqHMrKZ36o1YYVcz9aMOo5O4FFc8jy9OhTYXvArIhXR/hFWcj2hO4l981lKc1h54kIoFm+NP+3mb9jiiSoyvjWjDdzRFquVZjWKo2hh1egdyEoY/djm/viAmjT0N0bRsJNWWypBbXgfO37RysMgTnqEeNrGsMC/Nl/agU6aOrAGtpV5FiGaXm4HLON1+5K6HBFPhwr7dBjr56ynbjINniLQjjGyRxh5yaNFDT3wJETc+eCTwMYZd44gzRNAnkByKdxQJCsmFu3ShOYmc0C2K4uLluFcRIte/d5fryy8knulN6hCZhV3SrVw1K1TjecI6FATk4YNJVVND5NVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199018)(83380400001)(478600001)(36756003)(186003)(38100700002)(66476007)(66556008)(8676002)(66946007)(4326008)(6916009)(26005)(6512007)(6506007)(2906002)(6666004)(4744005)(7416002)(2616005)(5660300002)(316002)(6486002)(41300700001)(86362001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8EP9y16+sNzPUOgngxBvsaNge4QCwRDPoP92Md20j50HgEryme5+IG8jHoc7?=
 =?us-ascii?Q?HZA4+AUaPhIarCN1HmSAjADMTDrtTqkZQHJNW7yF+41J2k00P08jBgVKzayS?=
 =?us-ascii?Q?YF5/4tpbRklU32bkmKM/JQMx+jzCPe7VAjFe7Q9VxcruronQ4bLzxaG9P8l8?=
 =?us-ascii?Q?dIf/Cydu0+uwk/XbjF9j2W8oLZVNmFfA/h543vn9AcnjZxf7sZVL0EEXDbiE?=
 =?us-ascii?Q?FXEopY3qhVS/fXs6Ub1AOdOBC1+vszZn4DbJHIMeOHUnz29SXobtP7tZcGjF?=
 =?us-ascii?Q?whQJRr0Z7DRbjq3eIg29ETC8YHu0eurBZP9cq3gOt55gkyFTY4Q9D4I8oYUb?=
 =?us-ascii?Q?OxuUMKZvzYgbqbhFAexQNBeDB/VQEIviwO5802GAAK9MWhN4xAjuleT4tLzA?=
 =?us-ascii?Q?bTiNTsxr3k/5fBkPNEWp0200Nc/d3HIb1avnC3Dibr/bKgTSpsk1brtXmEHr?=
 =?us-ascii?Q?HVgGXeORfVhOrOczAAwbj/J0jZT9dZbonhBB3HWSqs0lik/7CVGZ+LbNjwZS?=
 =?us-ascii?Q?dFqz+X8+bWb2ncCnc7xK6dhfvoK8zCzVkiaw8IqRIva4Bv7A625yydC4OZ1y?=
 =?us-ascii?Q?zrnDWYIPJRmzqRCp63OETnbNMLv3l+9d1dOJeYgfiNxjbkTUU/FQUo+N6PWb?=
 =?us-ascii?Q?ntMsveDOGXGPKf2MJ28JnuFyFla0XrmLuajJMzHgi+jg/eABPi7IKvnBR9jg?=
 =?us-ascii?Q?tEEIPCaZyoCmwOd3FfqPCur+IByOqefxJy+ggRiZFBBimTVSWgR63XGU4SDS?=
 =?us-ascii?Q?9LVobONQ+/wA56ixiVxe3xAoDEjVci/O3Et4ixQ5vcMD5bAmMTxR2nXI6nKy?=
 =?us-ascii?Q?YKu4WuW8tOkrEzC+YFHwzP3KRvxiN9bbzV4C4P5OYmBJVz3fiGTTzlfFMtzB?=
 =?us-ascii?Q?K1QWkH3nKwFCbelveuFqiYNAm3W+ogN72ilksF1SapsmF5b/CBZ56u9pzCM2?=
 =?us-ascii?Q?K9uo3+VWcwt5DNiQpROoXlXn/o0oogV7dnDXPcqSCUCrEKbSoA0nZbiDdVlV?=
 =?us-ascii?Q?/ri6m3bFiu/301c8IsxiFv2eR0h73VjRfMlPZ37AjH7Qv11rixngSas3ATxD?=
 =?us-ascii?Q?293AvyprZhmgFG9IFwcLu6rXgGiyxj4AgzIjIuMPAZZVPN9uKhL1lHjUfYBe?=
 =?us-ascii?Q?bzRWpGa2bF1cyzAsksYA4Q9MiFQSE/SHpujcR142aeQ0Xq1DQuwt+uc1JSNt?=
 =?us-ascii?Q?i9A5U5mulixFtuefQYz3knWyRsFi/eqgSd4W5HJNaLKSGAMtR/d1Tsp1mn8Z?=
 =?us-ascii?Q?BL9SL/E5FoHh51fK/LBAxJwRKbwD+qlgkEhaS3sArEbgp7KJoej9E1TuaZ7h?=
 =?us-ascii?Q?aYPsB4GrCBwVL+dRV7S7EgMOv6xSsLFUGmDcZif9iRqxODh8HcsTRoKTBZg5?=
 =?us-ascii?Q?UKay9E9NsMr9m1fR1z15NawjAzs/GZ65t55gdF2VvObm9q5h8wY8fD/d07Qf?=
 =?us-ascii?Q?sNUFZ+63sM4aTtraJzW/o1+4zittK4dX6k0/NQR178lvjk7UIqhpavfbWkw8?=
 =?us-ascii?Q?ERNF/+EyGlZsU5Oma0wIPFR1noHuX/cBpbNQNDNIT5tVmoC96x4Romql6x3c?=
 =?us-ascii?Q?adbIqQhl9il7kcKfz0jj3k54zvd1r7Vut2+B/6Bd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31a939c4-9588-48b1-1181-08db218feec6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 17:50:27.5242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTiDbv4vX7MT1cusXDCfWbpaWIXEvhP89IS48CfSuD2xjisilGvRAxw44+YhfOwU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8235
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Mar 09, 2023 at 12:09:05AM -0800, Yi Liu wrote:
> +int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hwpt_invalidate *cmd = ucmd->cmd;
> +	struct iommufd_hw_pagetable *hwpt;
> +	u64 user_ptr;
> +	u32 user_data_len, klen;
> +	int rc = 0;
> +
> +	/*
> +	 * For a user-managed HWPT, type should not be IOMMU_HWPT_TYPE_DEFAULT.
> +	 * data_len should not exceed the size of iommufd_invalidate_buffer.
> +	 */
> +	if (cmd->data_type == IOMMU_HWPT_TYPE_DEFAULT || !cmd->data_len ||
> +	    cmd->data_type >= ARRAY_SIZE(iommufd_hwpt_invalidate_info_size))
> +		return -EOPNOTSUPP;

This needs to do the standard check for zeros in unknown trailing data
bit. Check that alloc does it too

Jason
