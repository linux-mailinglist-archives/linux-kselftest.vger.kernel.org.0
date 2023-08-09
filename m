Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F0776544
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Aug 2023 18:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjHIQnm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Aug 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjHIQnl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Aug 2023 12:43:41 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CDE1BD9;
        Wed,  9 Aug 2023 09:43:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IO/5v4wzSEUc2PydNkpoFe4ADm6NeR8h/AtnNORxQpKGohqEKZYnT4SuJhWpdKPkZFAyxreSmsErqP1leO0YonZ4tXyUzEQCmsiganW5PgO/JHVV2O/2i0TtHmoFSzUvLZeMlCSaTRtpbrXTqSWlqYzcx7eOiCXPjO8Dt8QkT3Mz8RR+PfKDXxWJyqCcKUu7ppzHHQK3wej22K6l6R1Npb52YG3pWrzpFLtQF5Qyg/SDBB/j8WUT2/K0U+/NALomcTm4ispb4EgHVCP0c7FzTCh4XM3i78gbUWRlYcpaNwr9fxLcfzbaKu2KRfnPvG6LVZsskgqK5bzpHPjbrGhndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlnAzR+DK4eiEGt851MoVpLGi8DGxEsjhA3tTsYhjNA=;
 b=j0dfAvOhk0wWkODxTDwJ8sBfq8riYBwTUCM0TrHZVfyXXPaOrmHBCND+EEDp194Q69nDlJMf4VKCsW5wWhbt0CmQv3h3A50Fkx2USyTOkYnWfr0wIh11dBmDVEfw5CiwgOt4OsueD57Fiu/sI3ZHYThQEChHCT6vpZo+31BQ0fNqmfsMlIa32Xwga24xaIvvzqYSgPyRHqndRFQeZfHuwvxla8aAJzmqsNbsmj+h0nVAOE872LoKaR9OAqyZGb+SFJ7kv5q2G4kwx+TmkH8GHoamNONVxjetISph9llh6a3vIHfS/YaNsMq6R4Hs3JYaWtV441QxrU0T/yzH7hOQNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlnAzR+DK4eiEGt851MoVpLGi8DGxEsjhA3tTsYhjNA=;
 b=sQwxlFtF4xGOnDu3vbPa3H29GR9Ps4dN6CkyfzhB+Xj6ukFcEDpicaa9frbyco1ALD6B3AUMYyQgM71u2binx2Z12jPhflYzrJHkb7bLT/Xxfg5ygLe1t0BZOVLsB2HyI0GRyqtwm3+2py5nwvD/qkZpcFjoolpDcTssM0beh6ogS+fGDSeVoRPRPBbF/BkrzESTlcD7Rc6xI68ctWPZL50d+hknkqy5K67BNLP4ybyA9ezV9H0J93JG2v1YgXd81aydHgCT2TkWK85M2ZIa+Y0JuqS3ppHuOqmWGWPgOTmJWVG9xz/YK/9Zlv0b0isomsFsdZ+8InU5OP788k5+Ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8129.namprd12.prod.outlook.com (2603:10b6:806:323::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 16:43:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 16:43:38 +0000
Date:   Wed, 9 Aug 2023 13:43:33 -0300
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
Subject: Re: [PATCH v6 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZNPCNQxUesiMD1wM@nvidia.com>
References: <20230808153510.4170-1-yi.l.liu@intel.com>
 <20230808153510.4170-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808153510.4170-4-yi.l.liu@intel.com>
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8129:EE_
X-MS-Office365-Filtering-Correlation-Id: 5039e698-cc16-493a-1f7a-08db98f7c7a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OFEZJtxtvBVzzDJXM1UVuPycL11N/srPEqGE3IBFbQBgztK1lYC37X5ZhS9uRl/MIWfFs7VC5KxS5SViwmwfnO4i3AZVlrpfL6Z9LQ02/lgEtgp8140A5C8iGpmJxuOo1fic2KcTpVDl6lQTl1BV+YQbxQys7q57hRhHBZkM6y8zpA9JReOUQKxKGV56YBIFJp9IHkVzpefQvX3hW8xRnh5keWGoHKnrxKkk4s7Z65CdSd2TY3le59Kvv2O9pxhQkDj7BeGbOFOx+hCZv7Nn+zlouET6LEW4XlU8lVd6nrFzpU1/HaczsSi6TZ3dcOZy8ZfSoLVON6Cbo5v4GAeLGMLocYqxx8IMznJ9oS/2tYsRuwMjpATd5+1AgXmsy3GgJ9jw7xkHIrrotBAuxq9Z08ZXCSQ/PQvzwmJa3yf75tYOa9eJLQ+JV8+zYmMIe/k8OjA0y4DssJblyPMy2jVB8UDRXZtjQjA8gJZTGWqa2R5MtM8TeUCU4ybGKAKGwduN0f/8BmEdsbzMrM/PyJTyx7Yb8WQ3z41SA6PoRxqaRDAa2uwjFvnlDBEKlHOBS003
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(186006)(451199021)(1800799006)(83380400001)(2616005)(2906002)(7416002)(6916009)(4326008)(4744005)(5660300002)(8936002)(38100700002)(8676002)(316002)(66476007)(66946007)(66556008)(86362001)(478600001)(6666004)(6512007)(6486002)(41300700001)(36756003)(26005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2G4+mDWctULKvMdeuul0ma3UzL3QklRDAOsZSkSolDgTgbU4oFSCnLBO6Xm?=
 =?us-ascii?Q?HktZnwKjO8gnskQ4gjF/uOFxDbXYoq3MTm//vF07JaxrLCb4/ObGG/7kaeTG?=
 =?us-ascii?Q?B9UDk3FAMcvOmaeDQnWTKZUI5lpxkzlO6mjT+xq4crgOYxVTHwxPakhov57v?=
 =?us-ascii?Q?aEJ9I59/1BX3f7KU2Mfgmo9lf7XBHEdCFmqRVbbFd2f3WyjX07M+j2rPyvNU?=
 =?us-ascii?Q?MO8F+yVhddopN1ypC501C6WbhXQAoSGyYUU8VxHfrY/0+Zjx2o0KiHp4lk4Q?=
 =?us-ascii?Q?kgvr0ebrQjIGM5P+czrpY8NxV/HyZn3dBpXGHiYHAKZfLTBBJ2R3rKOfPIxb?=
 =?us-ascii?Q?GhWa7d+GbL6qOZsy5x1m+1NuKvSIxGU/7IUq/ae7a5wgP9kNGHyWPpJ2A6A3?=
 =?us-ascii?Q?/QhGY46MqjJDQ4h9LSXtv/tKHPwtOWKL7uk1F2xkAxUVSuaSTZ0arYmFfnRq?=
 =?us-ascii?Q?bdq/pmGonsuRyf1f261KU4Kugb/tjAGBUH5Rj6Wq7dhGRfaKuKDO5wj/Puau?=
 =?us-ascii?Q?P50CqCHPKPYtNyzrOVkXy6nKOS9yB69RNEU/gd3VgIvOnc4v0V4NZv8mRqRB?=
 =?us-ascii?Q?JFrgPHqr+UKpIO19Tpds1FLd3W5on5DzG8HtCTYwkqjbQd0nAHbYxrEvJRDQ?=
 =?us-ascii?Q?Jo61Fknbx/2IgUiO7YzFlDj0cceRTrgjCAMAfz9ChdLMN5UgO3BXRRo5513V?=
 =?us-ascii?Q?GCQxeAZHFyJd4A8uVJPuiCcrXgeOvZwb7nRsYjNeSW492Qztx5BkW7d30cdt?=
 =?us-ascii?Q?1frsG1oE4b8S6YKmn5GvaD7B1HhAHOZAchG/ZkaZMa/cJ0jH9dPm1pSwJBWw?=
 =?us-ascii?Q?eb/dEuURrCcTmLllPYAD4g1abYOQu+vQcq3x4oQiFsgxrYzwJuR42WIRswxf?=
 =?us-ascii?Q?56549jxnQvav7m7uZh0ZrJOq/vnyzyJ2aXX/tlvO++25aC7ZFnPO3+ZkimCY?=
 =?us-ascii?Q?ZP2KBPad9Yv4txkVIhARkQGACd5jLXCLhrZqdWbsZCs+xIjHJZntVGgkh5rz?=
 =?us-ascii?Q?G21RDICEm25KHFrPh8VjSZxfCesX38nwkelTqTt9IkJQTq2y+Z4QCNBeO5t8?=
 =?us-ascii?Q?Ty+fEz1VKVOKLdUnfczw80mRFbNO3J4Q7i4WpVvudfxmxs71/XOc1CzZBi8S?=
 =?us-ascii?Q?MwAJL1AaLmgksHL5SG/bk0FIv8Tsd+AUdn8i+dl0sX5pBiKD99iKQNdQ8qBb?=
 =?us-ascii?Q?AjiWJ0l4esHy8KQmJ88Ke/VGxxchvQS4W9s4Qtm6GG2dC5L5NuxciCpo0DPi?=
 =?us-ascii?Q?+EdZq0FiQ2/G1DfnYxUYlXGjXVCDIDNlpQSpjfoMvYag0BI/2kM6m17OBiGH?=
 =?us-ascii?Q?S7F9DfZVIq/lhJhXNO4x2bHKUvQo7Zh/wm8dsPjvR6iuJdiKPhkFdsm4cV7X?=
 =?us-ascii?Q?kusyjZ0XeR+G/Ct2Rg38VGcuBgjypPW7NWSlpwD3E1DhEd+3ZwWdEs2ZOimx?=
 =?us-ascii?Q?kOMXcYK7IHFCebqS1EP8M9ki3l4zxztKX99hDcs2dbfe6gDxke84WeQX3C1i?=
 =?us-ascii?Q?8jN9KyI9UIILCXfBRQGLXMAWwe0F9q7npnNPakMXU9RpFCHNtEwMNjreuQY+?=
 =?us-ascii?Q?TamI2HjZNB11yIwLtg63Hlws1Tw6qy2MxA9oEe3N?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5039e698-cc16-493a-1f7a-08db98f7c7a4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 16:43:37.9355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGrSD/4PD8cZDntRJ+QWn2OQFGq2xJdcQHQ7vi/5aAJ6CiWFrmH+iZFWAzFUYwd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8129
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Aug 08, 2023 at 08:35:09AM -0700, Yi Liu wrote:
> +static int iommufd_zero_fill_user(void __user *ptr, size_t bytes)
> +{
> +	int index = 0;
> +
> +	for (; index < bytes; index++) {
> +		if (put_user(0, (uint8_t __user *)(ptr + index)))
> +			return -EFAULT;
> +	}

I've recently learned this routine is spelled 'clear_user()'

Jason
