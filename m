Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF516784E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jan 2023 19:30:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjAWS3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 23 Jan 2023 13:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbjAWS3n (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 23 Jan 2023 13:29:43 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689EC32533;
        Mon, 23 Jan 2023 10:29:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9TUek+8erOgKfzpSbI85WEiOfkYrm+nz4R0eQYVnJY6/D8muRWOFOGWhWcyq+l08Rpi0LHkXSEzr+vPnKMXdFjIyOuuEcSQ97vljnueAIlz9a/UNbxO9MyswsqJ34Fv6EMBeAHnElBGJziGZ9t8woe/nQhwq51JncptQi8XixLGtzQaDveilvtAPbKNynNyGBBRRWCc1r+vO/6+H3WeCF4kWRUJA8W6U1EAUKLsUqv1OuNTYDshUlwnE4Ib9ADZ2TlfD9hPeYmaSNnZn438ARCGA9YTPGP1+V5Aj094RrK6HUUStYs4rfM1obaRdn0gz571lcckIDmnqTKRLHqKfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RvUtbck8/uCkZ6XxQAQMf9HHd2X0EDJ3wSN7FyWtW1Y=;
 b=EAXwGiJ78D4aM7kg1pGT2XX7tYgJ+4Y3MkG2yVkAIE1/myuD4MQhehLrgLH9/hKQM/VXAWA7qYD+9uwSLM6jagN7EdbapJI2l89LlmtniJyL0+Ayf4RoBfRN/+areSJn/xFM+P/C3aRib7PM2eUjme7bQtjGPH/LfLUWln2208vbYC7uBE13eikqQq7xq5sV4VM/jrdVrzJXpB0z0f2eLPQ7XZqcTtO7sy2o/H5VEAtDexIIMGkbiHd97JmFcowPLi9fCYBCqeZZHrNdw7RdEIXe1+cbsiiBt2DhMIUrd9owLOUjXB8KD9AzqOyIbkyubVFCiIIZq3DYgof1j3rZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RvUtbck8/uCkZ6XxQAQMf9HHd2X0EDJ3wSN7FyWtW1Y=;
 b=SILtexqbHNTNRIRwiRrD0fMT3rtW+yXEAUfL5lyTUdmULKVXoKFmhRYeXMtPg3YPeUnz5q2uxybsJll+XFmxvVcV+1ytlQ3qJMfVVBC6B92lid16luHw8z0LHnBg0R5mds4OLSAqFKQoyTz7mfEy68RLTD/8C1aHCsGFPxlR+9fyAMaqn2eSbcYrqjoO5H4d6VU1jP5sn/i0vq4qgbCjpLlzOBd/uSqFMPybH9sDkVBL03YoS8Lz33UzgOojyalO5SS08cJfO6bD3RXzhgJSAZsnv3jxbPYJfO4+t9oNSwEE/4sH1XwiRSZOvgYv0DQp62F+1Ud92LNmbQr5w8hrjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5985.namprd12.prod.outlook.com (2603:10b6:8:68::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.28; Mon, 23 Jan
 2023 18:28:33 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 18:28:32 +0000
Date:   Mon, 23 Jan 2023 14:28:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, shuah@kernel.org, yi.l.liu@intel.com,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: iommu: Fix test_cmd_destroy_access() call in
 user_copy
Message-ID: <Y87Rzy9oNKx9BWWx@nvidia.com>
References: <20230120074204.1368-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230120074204.1368-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1P222CA0004.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5985:EE_
X-MS-Office365-Filtering-Correlation-Id: 7326fdc5-25ec-4d66-579b-08dafd6fa1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IfGhtT9m7HrO9U+C/v/aI3H+Rde+kNj4nVoca7hwavQMKY5SthMEFtMwfLP3/+fJhgoYiJhjM45XFTfdkboucOpf49ZhogNJsZflN6mf387pcFSjrwSFh0Vd1e4aCxWnXRUgtVatm8GlaAPDMBRcmZjrH9pPTHF1MNB+U4xX1EW5wceEMCUjzoDvaAWz865CqIT2B8izVJNGALpTm4o6k+W31PQAV7tYctMvNqpMldfMH8E+mN5PxjYwLBL9wTb4ooZ0yh9eCNY6aALiB4OgQmp9YaGf2oM9F133Xh2nZz1CDBdmCzy3m8vBGtDlJ7iR8t0WJI25rh04YiszktX+rzV9vcgExHLViFVA0wYWt8R26FBiyCmHayY640WCuY2DNSW9x6rhRKZ7qwDO0mrEBsuHGglrLEID2KuKhuh6w2yx1Vm6AusjMZW546Z2N1dfoUPym/ho+cilS2JFiclpy3aE2ffwNRv2fyk3AHx+YEzu0eFrL/UYinP4anSpEudqHEG76WnsUu5V+QGMEuaQgzLxzaF8iBs/XIllxaVce0kPT+yNVgw1Nn3brQnsM+r+cLfE9Vw30tVoFUOetcLspR/b9Xwj7idDjUeHe3IuXbmR2x7EM1WO+igwEjQXkQplk4QfWDxx6hvfwaHkdnUYN6NdZ6drmPqDy4Qs4Dmwbsy7/Smns8JcMSjLKV85P7Mi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(346002)(376002)(39860400002)(396003)(136003)(451199015)(36756003)(66476007)(4326008)(66946007)(86362001)(4744005)(5660300002)(8676002)(6862004)(66556008)(2906002)(8936002)(38100700002)(316002)(478600001)(37006003)(6636002)(6486002)(41300700001)(83380400001)(186003)(6506007)(6512007)(26005)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dL24uyY4SJo0+jaZSTSqsAxfVpYvVEteUXU4a4v8YdMpo5v/LUEeF/rHcqCa?=
 =?us-ascii?Q?q82thaAviAUWHGrI/+CMGLU7tfZNvyfrvdocNvtWtQUucI0hFaUGjlmBdfTo?=
 =?us-ascii?Q?68RoBbAM8QcHAFLMfHrfRiAJC3bat68jcJOPBNCtyXdufhLwE+KgRKx5XVkH?=
 =?us-ascii?Q?D1NvhwtczhXVCHIbHW8YjXRkS8rcKmEupIOQjHw1iazDr92vhlIisnWLgGa5?=
 =?us-ascii?Q?7gZXt+GOz9MUFSiJBATNXrXv4LSAD2hrL9LEcIisjBjRgd+u/CRpKyDzvms3?=
 =?us-ascii?Q?UpxV+lfqor+qIZJ9q6czgAO6V595Wx87OC2v659Cifn2gfLqlqa22FwXHZ36?=
 =?us-ascii?Q?LzQxo/meuMWuROHjodEFdMSrn4DtfNQdAyF0pGK6E9UwQpFTHWy/XNi8ASJe?=
 =?us-ascii?Q?h58K4DOy65h5u95XwCmQie2N2QfINEmsi5pVKK/0dDVe9OGa5KWAzJR1ETex?=
 =?us-ascii?Q?pd8jRR/aFWOoRhASJ77ezVcz6Yu7sUaAGzJiSfFgd6PcRnEnBRYwK3aY4N0N?=
 =?us-ascii?Q?mDgdCt19PR4uwF4GThOHWMe/pzodJ/P/EpqVQY+T0nQMPup8cTzuk7OXnEnZ?=
 =?us-ascii?Q?VYncNsLif8HrSda3QFt94jCYPib+FRa7uKaTLU76Ppkrp+MeG16fIfHAKX9X?=
 =?us-ascii?Q?UPUxIrwPWHPcXOU+db9weOGU5d9nSJ5U+GEhHyM+A8z5YYklYveqsZk4Bd9v?=
 =?us-ascii?Q?XuWgNWUFsob9zpPn6JAxyepUMsQNkHHyzYbAMRL1TgCZik9+dumRqpuJ9IL7?=
 =?us-ascii?Q?tcpGFN5o9XzddmX0pgeHDBaitkW+VrOZVM5TGjRkIAIWBSunv7gYascKZX3F?=
 =?us-ascii?Q?tNccFldKiPGy38LDr973SBM7TTZVuKbG75aZTl7nzpAovzze7gF4mayyPn6D?=
 =?us-ascii?Q?iql+hI57wUWhqafVk1hHzT8dMNjnUUmrrr3IiDhIb1nZrhNrZ4Alvpkq2eN2?=
 =?us-ascii?Q?XHv9yv2zDN9pPuX7OO0Xe9zhG1uXK1x+NzSCw7nodTMAIF5XIgxizui6XUev?=
 =?us-ascii?Q?F3T0KnhcylxyljrMGkO4/ODZePk5ZFyuTgwUhSgQYD/rxuwba5InvPgmg0ts?=
 =?us-ascii?Q?0IBWq4VbVn7vXrmlrPNla0eDtTIifneBdJiR1Wu1miUV8EtJhyETNspJZ7YP?=
 =?us-ascii?Q?4cILChX3taVgSXxku1yWLV3zDvYFvSR+aauHdj6N17+HaGLQUNXwpHInWCrP?=
 =?us-ascii?Q?bX5rrQdc+WyE/Pfot+GBeHCVSoxU78N4NJhvj9jUWedfejoDbPgNOqnEyfE6?=
 =?us-ascii?Q?U6W8ib9dz4ZV0/O1EgSe2jrXValXBgGcfNO0R9QSf8nzNFxn3L6ItGMy7G+P?=
 =?us-ascii?Q?RrYFnZ/LCE+N/qEzG4WKiD1mBEVIOyV5JiQ+6Ylc/0c0Jud+WtlESYOoN5zl?=
 =?us-ascii?Q?Ng3ewFBY+Im1QSEDhJORerSnJ4JfC8o56Vx6Two9UZKj1hm7oxTviuvE+J4Z?=
 =?us-ascii?Q?KES4gwNklWn8cuuoHg0t8gjk0mAELTwBT/HU53r9D+2VSKZm52rYY/7k+mx4?=
 =?us-ascii?Q?vw3cBk87QtMhDVAfR6QfwpDw0XU9Kja7hhGx5SDaZ18N3JVNOM7wLCuPPF+W?=
 =?us-ascii?Q?qrSo2yTRIvXoSBww4kgVdTgYgnRYUDQITMaWkQEI?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7326fdc5-25ec-4d66-579b-08dafd6fa1fe
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2023 18:28:32.8906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZIo3Wlw2JfXkQAsdS/pqee4Je2xPdLc8x6hWSX6hEn76v/kOMO66ax3Qq371504
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5985
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 19, 2023 at 11:42:04PM -0800, Nicolin Chen wrote:
> The test_cmd_destroy_access() should end with a semicolon, so add one.
> There is a test_ioctl_destroy(ioas_id) following already, so drop one.
> 
> Fixes: 57f0988706fe ("iommufd: Add a selftest")
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  tools/testing/selftests/iommu/iommufd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied thanks

Jason
