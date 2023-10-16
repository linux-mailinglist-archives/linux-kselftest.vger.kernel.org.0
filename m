Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83E7CAAFD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Oct 2023 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbjJPOJ2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Oct 2023 10:09:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbjJPOJ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Oct 2023 10:09:28 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33EEBEE
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Oct 2023 07:09:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8av4e9fVTWu0GDGxQKZDi+HQea99d/a/y7u1d/TPUAAl/Jl/CqqEn8VN5TmfQzbeSWVFhu0zWknh6Jm1go90HuJjCW0B6atcjg+2UTwLXqb5eRvcA+1KbdMDTSqF9f0Cnj0u3dGduA0Zf/SLUAtRLA2lSeMV57SQh3yDe2yMv5Hthg144MND+ciexM0YAvda1c5N1O2f9roZkfUMpD1tbWMT3rmUqHaGro7Oy9bD2YBA6uqL2hioTaWjH1wjg3jp2SuK+vzo5AKLyHhb9IpA22MC0LgyoHwdzQ+TWkG7mCeAdEVv3U3aDWMVvsA8KDiWFzE3xBQKOUOcVbCEXjtUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II/lVz5/1IiN0/LRYxzSU6oVkOfytZj2uKMoGnLOuqY=;
 b=OWJi1RG/21y1u+2zJdspuFs8CvFQwFwy6rQq1KkOf/SYMsIuS17fKqtunUaMBY13j+VeYXtnflv2IAtpkolP1IUm+uXFh6dCSjRVqdhvnA5XICQq7woHTllR41spYzx54+CWzNVS6aX0pbxMkNx8gGnR97kjkYOKgoUaky08GhnoIubXBOcDFPqaOV8QHANPe0uY9odyU4VJA3TnlMJ9gB0R4XF0niq/sq1Acq4+IVqAdRTGBmT8cGFr6WIUN1KhEHg0QDeKFxQ7tW07n1dVrkvVToLdJPNVu8we+MwzcFpl83NFdOrl/XiqrG0WDtbF9uwz/OhaPOxVeQ90Gwxm1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II/lVz5/1IiN0/LRYxzSU6oVkOfytZj2uKMoGnLOuqY=;
 b=ek+ZHIl5Qdz7iAy2afx1eXG9+ttjgLFJ+lcdTMPFgGUALFryAO1k00BpqLX0/JuIf7yUCoQW7DzM2jGZh+aBCa1rlfDf8xK1BJozCg9NkzWV3bWcnFVFLIhC5kxPu6TsZbpkHJESaur2zbCn7SuKMZ4NiLNgnzUgo1+lEKqo93tagFzXbUskU7jICO1Nvh4hOSJ0J0k9s8E/5HWSyZ0HHj2nrYStlJcT7evBFfx/537RjnS7QeR3IHgQNIEaTkfBqdhssXZZZDGAoOWsQzZ9W/Tecia8Zk/OylCncq5XWJbHFLnvTQXLPr5rlqRLKMuDzaAWCqgked2ZzOPrWkDsdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8816.namprd12.prod.outlook.com (2603:10b6:8:14f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 14:09:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 14:09:24 +0000
Date:   Mon, 16 Oct 2023 11:09:21 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Nicolin Chen <nicolinc@nvidia.com>
Cc:     kevin.tian@intel.com, yi.l.liu@intel.com, shuah@kernel.org,
        iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] iommufd/selftest: Rework TEST_LENGTH to test min_size
 explicitly
Message-ID: <20231016140921.GU3952@nvidia.com>
References: <20231015074648.24185-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231015074648.24185-1-nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0218.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8816:EE_
X-MS-Office365-Filtering-Correlation-Id: c6ba6b9e-9288-42d1-7dc8-08dbce518036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dBzSqJhgMjQESj6XvWoIZQ2kr80sedp1QB+Vgsk2PXptLe0TS45bontRuoJ34AJy2nMiOYmkpiwPeuMK+bxP4faeAxnnV8Op5S6waonjY5yTlU9+tOCZ4wc7e80qlQpHoQw8t1kw9MAJ1ZsmkFNpZ3wr959AVOoUqUjXc+tEpdGLyPWw4Ap9eScC7t4vqF5m/A9J1hl3NjX/VEZBszBnQxlKShbpLg7PRxiGOVfLs8Ki8LXqZQc/TvSXGS9Q5tOsIePSNAawNZ68dqUcbCfrEE1Ig+fnL/PkTzef/62YfQEyQYMDw16Vdhr11cg/RAYyivYs3WjThJDoerQGDKA0NsN0ZKxRT31+cJUMwiirV0ni0tNCxd5TqiU66ePgHkqrx/zo1tFxfxpWpb35vhs5MvwQH/EiUjiDDIy73u31qv5wjAPz1PURtd5mD0e6B+SOPjmTVFOEN3sDZzxoV3dYWc9JbNISTA1hI4OpivT63Cc8fL8BTc5Q9Ssum2R8NTZXKQKp7nAny6Xr0w9ZNnPQa5/oI70OTe5IxpMm7/M3MYs7e9WYJ9OFSH4jxFXo0ZQW0oZY6fLkmf0RFpvdp+JVvVettm/9+SoiaXIPx2zdk2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(966005)(6486002)(37006003)(6636002)(2616005)(66476007)(66556008)(66946007)(478600001)(316002)(1076003)(26005)(6512007)(6506007)(5660300002)(6862004)(8676002)(8936002)(4326008)(2906002)(41300700001)(86362001)(33656002)(6666004)(36756003)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxikN5OVeuivqs++DlVlq2MSI0qL8+UUm+PIRQeeJ7yORmXd0ow78nUMQ135?=
 =?us-ascii?Q?hY6s4OBs7Gt3/1id+gKK75u/aAqsA50ULqDRlg3TS2hMQlS30PfkPTiOa+k+?=
 =?us-ascii?Q?QsNhK2UvA28ZGdkyrONBHPwXmNXVBa0AhEx633CsI3QMUFEfg7tJeHrePphO?=
 =?us-ascii?Q?iEfVBn+KKGHbjD73ZrTCl7j8o6doJvcbTQE728PURT70UlBg+XZ3JkQX61uz?=
 =?us-ascii?Q?ZGQ/bf8qeK2RfJ5X+5aAgdvnXky0HrdOsq+Z0MRXz7gFmMJ/TCRyGnD61yHV?=
 =?us-ascii?Q?t2sVdiGhgEDBT8YVD87tEO+RJR7q7a+bB0NjAKyjMzBgeHLZ0MvB6IcznNv5?=
 =?us-ascii?Q?JmTUa45CMcSJrXmo2WC8H5hqvsUSHT7xLLQTKyaYbFUJUr8/mOKWVy5Jzpgy?=
 =?us-ascii?Q?CrN8+r3oWHvZSOs1nBo9tTmbTQHHQSu6qMy5Aw2O7DlaOtNdtPOiNnCv1qOb?=
 =?us-ascii?Q?1H7d0QoGIs8ldHitVTQtHsNQ8a34hUuj3wu59nCsTRTOWC0aFNRYKTayVKQZ?=
 =?us-ascii?Q?rGdDALHrLM0VA4dRsS5Eflzr6uDnz1VHyXeOguOeSUf2iyaqtwPsK69kZD20?=
 =?us-ascii?Q?FEoh8fD5ixSu3FrYmyZsIBFLU+dPw8T/AdtKvGKc/NuP9MQ3re9tECX/tVl3?=
 =?us-ascii?Q?ySAQBIFPVuL4Ja4UEvAPMtdCShxAstHY9U4yze1iqkjstzIt2BdxIioxRLQF?=
 =?us-ascii?Q?TUDRz3N8nQQ9BHve6PTOj/txUHWwK8k1TAYPXPOVS1BiaksUKjoKEoIN4E2T?=
 =?us-ascii?Q?FABbq1NoqpVPoydAf6esYySrpEQvdXFvNMBEwz1zgSuNDlKug1YaYrZsd/eT?=
 =?us-ascii?Q?ZZ5OJRqK9HzWie+MWsx0If6BcpGh1g1mFyyWsrjOVP7yfAdB++gWu56qRDqO?=
 =?us-ascii?Q?DSaEzH+TmeYSDhE+8NHQXicz2Q0/hoOkCJ537IAlWkCynKv1ppNYQUjDHuX7?=
 =?us-ascii?Q?/cZPy7yX2UBC2uGPVF84TVK+u/ooNBgVgeuqdJWA3b6L3u0vL13tfAjGqMfB?=
 =?us-ascii?Q?/AXF3YJL2v79wFWccV9UDqegXRzkGLL3FxtLVPvGFNiBhKlIaM5IRftGnyCv?=
 =?us-ascii?Q?30Aa2IZTT6qlZjvi3CzXMPD2fNBznFs6WzZJsPOtfG1/rxPEDnDml6zf2Cd2?=
 =?us-ascii?Q?M+WqZkJqgwvPkXJVwOSkjnPGNQJjCufknJc6VcihV2cPilhRzwD/iTkZc/jW?=
 =?us-ascii?Q?8D+U44O7GF99EqoZCWextBVPHyll57CGXScohJBh/QP3TdkAOA4eL39G/Rxq?=
 =?us-ascii?Q?ha6tLyrbeZBhVIhaVPC7+pBD+uBB4M9u+op0GEj5kJZT7tr6buHLbFoWOrKP?=
 =?us-ascii?Q?tfKgm9gTLUwxDUXPR52vV4sVDXm7xOjBvsJmQN7l6J+cAiDvrxh6lllLKfz6?=
 =?us-ascii?Q?su+xBSmAq8jo/UC6TzK/AhG5/HSz4DEmOozoLhq/LdXjorlwaeIlUq3lEMA0?=
 =?us-ascii?Q?LBgk8zITz8di+zPIyiXnmpIAQPdcdARQY+V6+EKhVEPeqYX5ccauM2UXBwPm?=
 =?us-ascii?Q?gkT0BDplcZHrYxesg4AjEk2rRlvFNiruwy98nQrros3Y98nYvYg2r4RHCHKr?=
 =?us-ascii?Q?3fkrvBGtqkpsHeBCLOmnpqhHuIEyLk+owAZ7bfuy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6ba6b9e-9288-42d1-7dc8-08dbce518036
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 14:09:24.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPfRprF+NjzvPlkx7Idu8KhUTn1PhKg6uHhhq42z/UVm+OB/gjwxOxE9h7jWBAXv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8816
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Sun, Oct 15, 2023 at 12:46:48AM -0700, Nicolin Chen wrote:
> TEST_LENGTH passing ".size = sizeof(struct _struct) - 1" expects -EINVAL
> from "if (ucmd.user_size < op->min_size)" check in iommufd_fops_ioctl().
> This has been working when min_size is exactly the size of the structure.
> 
> However, if the size of the structure becomes larger than min_size, i.e.
> the passing size above is larger than min_size, that min_size sanity no
> longer works.
> 
> Since the first test in TEST_LENGTH() was to test that min_size sanity
> routine, rework it to support a min_size calculation, rather than using
> the full size of the structure.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
> Hi Jason/Kevin,
> 
> This was a part of the nesting series. Its link in v4:
> https://lore.kernel.org/linux-iommu/20230921075138.124099-13-yi.l.liu@intel.com/
> 
> I just realized that this should go in prior to the nesting series.
> One of the nesting patches changes the IOMMU_HWPT_ALLOC structure,
> which would break the cmd_length test without this patch.
> 
> Thanks!
> Nicolin
> 
>  tools/testing/selftests/iommu/iommufd.c | 29 ++++++++++++++-----------
>  1 file changed, 16 insertions(+), 13 deletions(-)

Applied to iommufd for-next

Thanks,
Jason
