Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D53D75FE8E
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jul 2023 19:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbjGXRyv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jul 2023 13:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGXRyf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jul 2023 13:54:35 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F0B422B;
        Mon, 24 Jul 2023 10:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD+4YGALbrTItyT3ZOOQqS9/RZdYpS/wPyG+M2KnRq30qLXWszDcCVdH34yGjOd74rCt8hR0577DeIqwMOdQXnTTvioqTdt2BalQS911t06HYZET4TWXPTGrx4+xXW71pXuuQ0jaKTz6P12XBWLeIF1/CNfepHtZ/ZCiqjBPKW4C7XySeqJhecPajr7q6Z2xMfNuJMV2NEo9RTVG3fiy/NbS7q6r8KEYgw3jyCgtyffzOmlLyf4xK0J4PZPsKzt6KdE/fsAvTSPWeHGmQ9FlVbXJkGKR/P9ki5N3wXPm2eUAxXxETSkKvG0vQRCQFbX02VR+/9/yuereQKqv6RmYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y275Fw5xKcU9mXp19DulCKlTKMmVjsp/tq3H42zac3s=;
 b=aUrzPrwW+Q3Rg2onNA98enKAyveO7aBEIE9Jf8j7Zrpele3+p5e26ylf49quAeGBtJgun3L/4fhCy/26RNK7FzBIYzs8wNmXWC+VSMdcUGxtECcDrK8e0oHL/TtcfAJJiIzKmjajhNVBJvm3ClYFwpzKpcJpMdQPfb1QcYAYvU881/zRmg+8hy/eU6xWdvprSIHfh7dtjZu6INt/wMtFDHSfWggcTP9z2H0urWZIqHrd9PNnNMADQFMMSNhwEs419STGcc7ciWUf0VqKBvJ+xlrApRmM3U3ScOjgoZbm3uU/F/APuY19UVOnyJIOuNxDZGjCPdPo+leervCbSochPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y275Fw5xKcU9mXp19DulCKlTKMmVjsp/tq3H42zac3s=;
 b=lgizKOxv7vLa6fq0iW4Fa3E3ODbIU1ZMgNycSRykxaKAk1cXJF9gzwFNF9kVUuzsob2dDQ8meOvUrvKtF98/ASLrKGFOKHDK1lHYh5WBhzq2Rvd/njIdYBappNN738VT9aEBCa+9/GQFgvDuQnSwcAXV64o/mFx1m/9K01suLBsDOQUfIOEMkyqFS48U8yF/Gktd2PNdVdqiCxLjJa/QwHHOXYYH8cIvYXNUBQRrS/NHGkrFTS4E0x7cdMdhtVaSNT2EBP8Y1qaWwZuIQmIB61fnPpKHZJRZuIMoqKnKOqiI3FvL5uIUS+G+rAw+Zr4cPDc+ineFPbTK8BAyGCDiPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8962.namprd12.prod.outlook.com (2603:10b6:930:c4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Mon, 24 Jul
 2023 17:52:16 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 17:52:16 +0000
Date:   Mon, 24 Jul 2023 14:52:14 -0300
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
Subject: Re: [PATCH v4 4/4] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZL66TtuWZXhxWFKP@nvidia.com>
References: <20230724105936.107042-1-yi.l.liu@intel.com>
 <20230724105936.107042-5-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724105936.107042-5-yi.l.liu@intel.com>
X-ClientProxiedBy: BL0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:2d::48) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8962:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b32884f-290f-43c1-2c01-08db8c6eb7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUnyGm7APNTZaZhMfJIh/fODxsJWhz6QQH2ZBLydhKkuroFumTtgd+D6l+Zz+b2prqqSc+M+MnBjFG5xrEU6ZnxPLOYp8+vQuzhE2dUJguTujHkFTVb1NeNJEQmgHssn6re7KIHKEWpvAxpEkdfaFlxB/BryxKu8RTYhN9xoW4ZzKQrL9GatJ9rq03HLYuVKZPFgLet1nW2vCrn0Cv2ztXMtKUiFquFID6M6hNbnGptv7HpoYEbuBWJys2stOLG4OQCcb5ObPsHlamE98q6VTG3HrSXtn85N0yN4rw+imZFvLhGj9VF+xa6ej8KQrb8LMwhqCJ7zPHrhDyvV9OokloH1A32NensvkAHzvzwAmAu7CWpW46aLbFWkXwuUrDAqCYGGLHUGoFB0UjtOkAvHXSFqvvR9SlMLXGYhYSbOEepWAZx0nOQALJvUBhjkR5VISwMpwimcXhUutlmmcgdarK2cizDOimfQSAjFicMYv5GBtTj8iDHlUHpW+U/M/RfpHmpOwXCn8q7KP+cz+n4xeq3liGIAjO3RteJCHOKrPU1Fa2UK/kPtD01Q24PvmfUk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199021)(2616005)(2906002)(4744005)(4326008)(316002)(66476007)(66946007)(6916009)(66556008)(6486002)(6512007)(86362001)(478600001)(36756003)(8936002)(7416002)(8676002)(38100700002)(26005)(41300700001)(6506007)(5660300002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mPDt0zclg24u3NONZl2Z83L9qpLgt+zA+/7N/SLmVJX3ZZx4b8L12/UVWQJg?=
 =?us-ascii?Q?IyhXQZeVa7TVAxJUYnXSv7EeccKmn81p/hn7fcuj2rMH2bHjQp2stn2rnRJh?=
 =?us-ascii?Q?S9AigJMH4dhaJgPhQQxMph1zWaa5M9Cz4omZatSPgLwfqP/unuVapDLWdLsC?=
 =?us-ascii?Q?np6thaE8tHiYzmUsQsmLEyZfp5r9ZT8icCnDULl9yI/qsmCCvm6nNkxE0oXJ?=
 =?us-ascii?Q?Cb/LNinPHRgw0LT7IKUe8QL7YkQXVy5B7866aKg6egl229UQdrxdwFOryE+I?=
 =?us-ascii?Q?szdSxaLfwOhqThwczbYSA7i2vMYqE3lMFVMZBqr6nCFVxMNSZtJJRFIz8tRT?=
 =?us-ascii?Q?cmVWH7hGMxPi/oe7N0U0PwPyNX9XS4q9GmrBCb+EOOzsanevtYZnYCaoVLTs?=
 =?us-ascii?Q?At34C2NywP64oz6MwzN3RgdnyZ6k9xoYOG/+yinDOeJiTPCnWmxEUtF/ZFp9?=
 =?us-ascii?Q?Xom90ehQhCO1JqoDfC6UTzV6ffj0+U0vZ4tVKZ5fgfOu/R5KQawBqDxqdEAD?=
 =?us-ascii?Q?ja+SkbV6G2d1MK/DYEt/JpaFZmdOJB9GWh0OmhvhbM3ULxp/CPMlRlcqQRC3?=
 =?us-ascii?Q?Hiifbg8VZAlV3adi0P5WJXCTyOf8Bhf2G3FPirlqtCzySiFWSQ5w3txLNIYS?=
 =?us-ascii?Q?JhwYYHU8XecDC+imEegMXDTe6qc+s7Y8I/hOG1AmKQVgUDoPhRJbr93u8m5c?=
 =?us-ascii?Q?Hb19LhDIpS7Qhrhz1LY7BfgM4HlcRxB/RQS8WnQ0KNgr32P8xuzRGJhSC/cS?=
 =?us-ascii?Q?+2IE7dbn37iLAym6R7gWfn5Vi77jKoX6vXUAZt3W2nN6bFw3K/6+bXnXgABc?=
 =?us-ascii?Q?2H628YpTSO8XZZSpGWKKK+m5u8VtqsZFtHsWLTJZLQ5Hk8xVMXG1ky5bRCOq?=
 =?us-ascii?Q?ICFjZPkQtT+O7BS4ji8z8k5SjE+uVVOrZD3Ba+EjqfMbtikk5v5m2ENGIpJ4?=
 =?us-ascii?Q?S2yKqk6hB7we6McJSWux2tX6iR1WEGkkXrpc4OkOfBk7PFvdzqCPzR5S5m89?=
 =?us-ascii?Q?J0q9eq45x3iCo/sVjVG6BA5dkCVI6wpDKPK9LmLgYaCUrbwhfk0YLZj70vdd?=
 =?us-ascii?Q?vk6rXWVA+WNlVe7/vKfpnW3ROqWz/ILDd3tOfX3ZMQJqHNb3FURxi62hhie2?=
 =?us-ascii?Q?92tnF1JAkkPygYrCPMWdgC8ECRb9N6nkCgNFKLUy4IRFQwBhDVucaIXjFKpP?=
 =?us-ascii?Q?8u1LwP5IOl+uH8be4LpkcwTvnDyHdjKRg/v/fvOH+SOMvs1yJeRjDbPBVc5M?=
 =?us-ascii?Q?cUEvQOShFdG+xJoIC2G0/IlR07ynDcjpIVJMrcC79oz3fZ0xHvriM5QYgESo?=
 =?us-ascii?Q?3MGsHd9B1qmI/AvqNrSUoVIf3PwT6+JKO6DEmW7Pqk7zUmavwmTiDEeOsfI/?=
 =?us-ascii?Q?dCoBJTffGN2jVzGDRwkZKe3cFvMGQqSCsf1moQ6EmpmxDTKS6lswaOenXRHq?=
 =?us-ascii?Q?4+RPj5QsAGmiCoNbZZb5PcmQeuNms9WiEK6Ju3Y9jfkgCxdFmTdhtztU67Ko?=
 =?us-ascii?Q?LZBJze5NxIrMVS7h687B7Dk70/ifXq0KJl/CTWDXrIjpfJznriKRbssNJ8GZ?=
 =?us-ascii?Q?YHW/FUNW7A82AJdhfl4npyoPODir6NVUeVitQ2DS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b32884f-290f-43c1-2c01-08db8c6eb7aa
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 17:52:16.0897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJMuCP+46ziXQHRrKAFSAGwiZAclO74ccHuMj9ysJKFYvrpL1h83xhgXDnOhd2i2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8962
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jul 24, 2023 at 03:59:36AM -0700, Yi Liu wrote:
> diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
> index 70353e68e599..f13df84f6b42 100644
> --- a/tools/testing/selftests/iommu/iommufd_utils.h
> +++ b/tools/testing/selftests/iommu/iommufd_utils.h
> @@ -348,3 +348,29 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
>  	})
>  
>  #endif
> +
> +static int _test_cmd_get_hw_info(int fd, __u32 device_id,
> +				 __u32 data_len, void *data)

void * data,size_t data_len

Jason
