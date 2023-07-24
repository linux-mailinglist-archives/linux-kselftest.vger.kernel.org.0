Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E533975FE86
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 19:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjGXRxw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 13:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjGXRxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 13:53:10 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e89::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42694C3A;
        Mon, 24 Jul 2023 10:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeGutcibJTXKvzZwq7TfTKt+NHY7Nwncs6QnF3XyPaHvS9QRBevaTwxua797RMAjft3lr3WqoyXFEON91Duk35wqA59OSPDLtdTgoIfkvJTfZzq9mhHEvYl9zmW0yLtDnsLHJFYTptgg9hegKovkzgM0y4twjJcTENpXiHNrRMoBA5lQ+Fqw4Kla6fB0JwTiL4dJyliO84tkk5pDC3x3EJ5t+VX9pqfB+09WGyVaqneyaiX0Am93ryvPVo9GkjiDHsN+xRj2gGDvPlUVRBIDS5V+R5AbqyFGruwzW7BngKzd+8za0901ND9p9da6u24ZgIDuN3yp0lKWrWno0d0+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=04ntbCYPcXTXIbpthOUXNHzyIQEGfHOhKcd93QVL+kY=;
 b=TLGfQcaBE8yzxqOYD5AwLkSmMt1VHxThxgi2lGh9OIGTHBDaRPcAgTBM2Iz2QbS5w05nqzbGxRBNH1GpMY5XTfK4xaaXb7isYzog4RdA7zmAnD+owclN3+OmeH3uMQ+RVgQDWhkVvPf4QESMji2SRgFFBqFwiX4fANQLe6nYpfjXNsWlmkyZQ091TqbJCXphKcTI+gDTRUkFcEUYV9PCEyT76CqMp7sRwCBoD/tQfqdeCc/WRwTvkV6PMqCONXxMP0jUsCaF3e0gfPDKAb0oodVgBdfkkGuS3EcDa3PqrcFdxOkRaLjbjfUG8Y9Fb5lN/MZfgPzlMe+QJBDESVG8QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=04ntbCYPcXTXIbpthOUXNHzyIQEGfHOhKcd93QVL+kY=;
 b=YyfK3mKcNEyAo7vXEsfIGj9Eml/KsiKuZt2Fsc3w0ajAE+enKgTPv2FulTVhLeiJI09tjCGxQrUeDhMvQyAf7OpnTWe8fTMJBVxJwSNgWlof7XaFJjLjxQcysZWT45pd+Sk8FrtbPKZgQvqOjbk8tef9hs+iSaz23fLJZoYfbiRaACNMD2MZLm3tzGhNU26rWRg4sLTDPrJ8jVeJ+kjuzQ2qnfJu7Wi+gxjYem1pxnz5uoDKJXNJY/cw2IuwAqmMeOiiUm55l4MxhX5wZ3SN1cS/gu8KeIIZXAZ9nC0YzE2Ca6e+fb6e7TmXxmhgXtGy38KNV/LqTGILXEIOIdld+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CY5PR12MB6251.namprd12.prod.outlook.com (2603:10b6:930:21::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 17:50:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:50:08 +0000
Date:   Mon, 24 Jul 2023 14:50:07 -0300
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
Subject: Re: [PATCH v4 3/4] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZL65z0i8d42Try7a@nvidia.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-4-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724105936.107042-4-yi.l.liu@intel.com>
X-ClientProxiedBy: BL1PR13CA0303.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CY5PR12MB6251:EE_
X-MS-Office365-Filtering-Correlation-Id: 107619cc-10fa-4470-8245-08db8c6e6bac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByUNXGr7oZ0lzDcQFhwfSlu4maefWdqkXInINImV78fY0uiyD9ywZ7QQqcHNAckH0JVAk+RqlCelYTwrBqbUNe0vpKnZZiWbthjIbPTohAIvXAM+tmi10BLNQXrjp2AtsuST25vAEhetk8GloghXIAAOzE5z/3MsEiSXMD3KLKCeJ0MLVTsmpCtkhQbeQqsFswm3l+ciYODVLa8hS6DN/wgq0Ap48HYE6yD5+E+lrSTFUy7JaONz/w5hAFTwxc/0hC4y/TD3B3YO6W2ggeiAAKZyBNcbLSaFH9iCeD/2XAcIj0YitNzJCkdNikToi+7LdVf4ul3AMlUiNGM3JO7MdkyjwcAWg0S7FRFlIgC6gKTCp712SBcQGpIAryh61y3iwwkTP2Etc6AlEMM9doLjTln24Cg0K1Le1B3plJ45JPawCh4HhzAXvQZW6HnvftUF1Gj7SbgQaEMbw9QgL8BjunJoilLuXvacgAmIXjtmHd+rmq1repd7R0qryBxtUwxnPU7S8Mka3RYKGDWCtjeki/gdWHpTTR6to9AhiUfkdHP/9OgPCC1Ut67NJ6JxgY7O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199021)(86362001)(38100700002)(6916009)(66476007)(66556008)(4326008)(478600001)(66946007)(41300700001)(316002)(5660300002)(7416002)(8936002)(8676002)(6486002)(6512007)(2906002)(186003)(26005)(6506007)(83380400001)(36756003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K1Fa3OYNXilVhoHGeE0cF84nC4bm5w+V3QMYyYc/YF/KDS7LHPsUqawCqdOW?=
 =?us-ascii?Q?94XAr/SaDdPKcT8BYhWcl2LZ+A0Ig03fZimukAQ+Sx7xt1X+wcgqrY/zMAAx?=
 =?us-ascii?Q?SYbHMQDg/kdxNPfP6kl5pb2zkNEpCVT3HgK9TKETenMRCkE5CFcuHXnarwtB?=
 =?us-ascii?Q?JQz3dzCNX9mSn4RKcf2i8v9PX/k8mHESIWOtXj7hJcgtEeWmxkWc5z+aYKQD?=
 =?us-ascii?Q?NmElHx7qn84EmGcfD/LV7ePA+xAZD1k73JwA9orYwD/REG8DEct/53iSMe+p?=
 =?us-ascii?Q?0JCOGRcgDylK2CapygL8dsBYm0DUsf5smLWqew9yedDjDHIxGcZACh1aGewU?=
 =?us-ascii?Q?0IZmbPCJK8YHBdDgPvKrOKY+Dfdde2qqLNs8RqItW5DM1Aw51u3CZ+eER7/9?=
 =?us-ascii?Q?erTSgcCoicJFoGFaQv75aKiNTGVlO8jyK4cM2+OrEKtbYOwoTksJ35Ea0TxS?=
 =?us-ascii?Q?30/7l26JO6UNOZEWS+/kzV7qdm+QG4JFIFhQHs/YmUk3Bms4utPH23q33Mwz?=
 =?us-ascii?Q?iOr+h1H/kLRkVtYIkCxKmmx8GxNoTA039atX0hVZCYrPpHMmugEGzdtf/pBf?=
 =?us-ascii?Q?5m5WDT0A2MGSqsDFsRC1DA+qU4R6fCKp7zGfuVt0MycDUrtr9oS7IMp+/UGv?=
 =?us-ascii?Q?b4tuAhVWBWb/qpuTuXMd6bo8igGEIVTrNYcpXRg6b1dzMno6gGpe2VT1wtsO?=
 =?us-ascii?Q?DWnkI3ESWdGAsFWC2q1PvfVtwTQjyziFL3VquaP7ptftERjfw9c89QWKnS4M?=
 =?us-ascii?Q?oDH0cPJaIliIZjWfPgrp80NkiZc6aNsehLyXBQoqZAC8MY1D9SHY+rccEQO1?=
 =?us-ascii?Q?veoXlYJvM5SL3EWwJBSYy4upI/2SDkZ7E30K28BWnIqtwmWf8U96x8ygOS4v?=
 =?us-ascii?Q?OHThoNioWL+PM6byIZeTFsFLWpCB0s3JARlB+6BB97EulnX3AWPwRB72Z7dy?=
 =?us-ascii?Q?UmBQG5rGQJ+y1/Bm4/kkpu0YCtmMs4c6kqWvO4RiMOMpxMpPM2kV6T3lLX+q?=
 =?us-ascii?Q?Zwj446bvcqw/rLkPqPZ9P5zhF+EyEW8Q/xUiRmD/kQijtNbr2kKsxdTQPVm7?=
 =?us-ascii?Q?w4BpfOFxSPRsrFCGuojlAqKTbFknniaqxiEuGEx85+ea9GDRy4346QkIlTp/?=
 =?us-ascii?Q?TLku/MVvZklhCVEPHV9PYUG7NOIJpRJNChwOk9l9qWJ7ljNPSZg5RMzmt+m0?=
 =?us-ascii?Q?PqEPpE7wAt7en4ISFlOPxcEkHwx/ZpDcdOGwSgiqmHdv35A+sXVHTlQNviOy?=
 =?us-ascii?Q?2fJXpov9NArLsPlXX5jjo2NNe1Sfok9tQ4dIR8IrFeKCyApdSa6joOjDUg9W?=
 =?us-ascii?Q?Ue4QtA6OmCrPcvfE5eeSxAHr7n2qyIwXAGa6LR8i8v/xc3bWwOm7Eu8wqzIu?=
 =?us-ascii?Q?h4/4sxB1gcCM9NAuMs49TH7QeAQ9UDzf/Z5ComcugNqtn+ab+Omse0F8ibba?=
 =?us-ascii?Q?ZOBjqugQkf0Aitp6g8lAP8CZmmcj6U3KsdlUsJuVL46TspkDekJvQqS5Dpc5?=
 =?us-ascii?Q?SOXv675/3Fb09INrPl2oQE6qaIIc9E03M/RLairzoxMEoIJjcOsJThH2pMcO?=
 =?us-ascii?Q?Q8Csgk4yPZYn+h1TEzJGayGGomGTw6tgK/nBmDm+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 107619cc-10fa-4470-8245-08db8c6e6bac
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:50:08.5378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ptNdowRmhRb4JmtdybPmR4sIWejmjhgJOsN/2tg8nELluist0yGUN3MYrHR2aEWs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6251
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 03:59:35AM -0700, Yi Liu wrote:
> diff --git a/drivers/iommu/iommufd/main.c b/drivers/iommu/iommufd/main.c
> index 94c498b8fdf6..bd3efc1d8509 100644
> --- a/drivers/iommu/iommufd/main.c
> +++ b/drivers/iommu/iommufd/main.c
> @@ -17,6 +17,7 @@
>  #include <linux/bug.h>
>  #include <uapi/linux/iommufd.h>
>  #include <linux/iommufd.h>
> +#include "../iommu-priv.h"
>  
>  #include "io_pagetable.h"
>  #include "iommufd_private.h"
> @@ -177,6 +178,78 @@ static int iommufd_destroy(struct iommufd_ucmd *ucmd)
>  	return 0;
>  }
>  
> +static int iommufd_zero_fill_user(u64 ptr, int bytes)

(void __user * ptr, size_t bytes)

> +{
> +	int index = 0;
> +
> +	for (; index < bytes; index++) {
> +		if (put_user(0, (uint8_t __user *)u64_to_user_ptr(ptr + index)))
> +			return -EFAULT;
> +	}
> +	return 0;
> +}
> +
> +static int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
> +{
> +	struct iommu_hw_info *cmd = ucmd->cmd;
> +	unsigned int length = 0, data_len;
> +	struct iommufd_device *idev;
> +	const struct iommu_ops *ops;
> +	void *data = NULL;
> +	int rc = 0;
> +
> +	if (cmd->flags || cmd->__reserved || !cmd->data_len)
> +		return -EOPNOTSUPP;
> +
> +	idev = iommufd_get_device(ucmd, cmd->dev_id);
> +	if (IS_ERR(idev))
> +		return PTR_ERR(idev);
> +
> +	ops = dev_iommu_ops(idev->dev);
> +	if (!ops->hw_info)
> +		goto done;
> +
> +	/* driver has hw_info callback should have a unique hw_info_type */
> +	if (WARN_ON_ONCE(ops->hw_info_type == IOMMU_HW_INFO_TYPE_NONE)) {
> +		pr_warn_ratelimited("iommu driver set an invalid type\n");

Don't really need both a WARN and pr_warn(), just keep the WARN_ON

Jason
