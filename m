Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A4F7D5985
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjJXRNV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343756AbjJXRNT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 13:13:19 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1368122;
        Tue, 24 Oct 2023 10:13:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfoTx8nZQLQYxS+XihDO7F9890n/rkiqlgA7NDxb2WNSFqO/bJKwQv8PmaXXfhxqJpmyuKJTpz/y+50Qfur5RvIVUEdbcd75GLm2XrXrT2iRFRtHr9ArtPciOS3gSkz4iD7vF9VMbAAl4P/UNR8+O00c/AvZelfLfJ9Jw67V7BfWewSiiPPy2sdvP2kPHcyaHUj/EAbKXCgdtRPcoG5GoSWot87igTAysIgRSDNlQ7E/pcrwqON96sRzx33/uyql+8z8Rke/j7oh6Noqqqfi3YyGt95hn8cmRRDVDQg1ZeixZKKY1rWktCSn5nw9Ucanv44mDjsPIUkalbn2KUKcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPYM8mgDb0TZJkw6QWxbRl4SZU7cTubJFmbqpWDGflY=;
 b=WVm7xZhca9XWqs9lseH8s+5K/svRLI8/fLUpmsTLlngOYDM7ubxwBBR1w66nBnOiDC5nH3wGxZb32znol7rG2NJIm/H+pz7IUr3aQPkAIz31kxebTC2myJwIV9C+PcXdHgQdIGSDBc1V0vtchTj2FXFcMCqobwqH9yEEhw8pyAH6/4jQcyBZ+mnVtK2qoXwybrINz0Fb89oYYGBsekplj937Km7OkK3err+3VFNrDhYR7Zk5xqgEMvg0MFvzEZd+UWUbpbwCOMyiGcJc10M+BBA1tNve4+AeBR5AttVrfiQsGx3059ZZ+f+/e51Y2x9iHweXKVSI0gK/J0FmlVI+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPYM8mgDb0TZJkw6QWxbRl4SZU7cTubJFmbqpWDGflY=;
 b=ehi5wdMII25YZvi/nwRGexNYfB71WGDpjW0OhouIZTwcf/f8DLAGCBzOFr487dF8b5bwwRfZ6eLOpXX7vToO+/hilGP4VJaw0Y/dziSGNbBCLBiQqYbfewKcu35RS2ZzWBtOZf0cd+7ffEVXPfwlybv9W4r4OP32aPOOmjhRpuXhqtY8S6prrl+KbQ9owx1bplJIwM/OOa3U0mW/7uDL4T4ne6BL9lR/DFFjcRu70gaQeCzWfdravL55/psRBczHXzmJTSgGAlZ7R3vNr8SxgiKMXbLKI5E9BwWYMNkU089QP9HDSPIyITM34TpSbK8U8ggS80LP7GX2+wKSAYGgMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Tue, 24 Oct
 2023 17:13:14 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Tue, 24 Oct 2023
 17:13:14 +0000
Date:   Tue, 24 Oct 2023 14:13:12 -0300
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
        zhenzhong.duan@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v6 07/10] iommufd: Add a nested HW pagetable object
Message-ID: <20231024171312.GN3952@nvidia.com>
References: <20231024150609.46884-1-yi.l.liu@intel.com>
 <20231024150609.46884-8-yi.l.liu@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024150609.46884-8-yi.l.liu@intel.com>
X-ClientProxiedBy: SA1P222CA0107.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: d3095d42-2328-4a01-dd65-08dbd4b481ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UH5EiV/YwFecdFYB+oY8RXEwqVvopD7j/zYupH9ywm63ZkM77v00yxaY36eF8Oe/auPks8uprSzu6mU3vghxgZ/S28xm4yJHnC2HLgSCXfdc+jhUnyn9qTbcBmisf/srxCZmdMSDUS5h1UkSM25OhsnrQFfNL7TxxQtC8KfAjbg9hfJQS9pne01LOfWAQsloes4Ax4rCjcqJncEvOHiKKaDKxqUXQb0UFgxGWT1oO3r+rs2XPYNkx5t0PaxNMWhrwLEewDpORYe8LDeQZ80IHNslhgV9NOZ9v1DB1iHl4zHtclRm6pVVvuq1Torr6pJ1EDwvqLvRPTrajXuPEKqEYWNkJdP6c8GJ7lfTcMl1Y9ZfF3/FMeaw/dwa3gVUMPdJZRWwCoTjWYxBQqduBN3v0u5oNTKJQ1VnuSD11faw47aFANC0F+IDJs9I5EMQPQ4WBZ5JpnGEc5NWwB7PcyzNNhSMLgRoKNRg82BgdWp2UYjYIhn7fXxaznUU9Px4Jww4AxNqohVM8VURXT8cAWeXh7FZ0RWVm+35HdADEF9MrvMb5LrjeHCQShCrqXNeLnOT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(33656002)(6916009)(2906002)(5660300002)(7416002)(4326008)(8676002)(36756003)(8936002)(66476007)(66556008)(41300700001)(66946007)(86362001)(478600001)(6506007)(6486002)(6512007)(316002)(2616005)(26005)(1076003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jZwF40CtG1GxoNtTObjpRGxFWvko2PHxmPsQF7FR4JynOO63+vCsDmtehmzr?=
 =?us-ascii?Q?3WS6xL87LWtrq3hjME0PU/g33Dv8PZ3JzOzCpk/0zWzNEQiFXk5BNNZSj8uc?=
 =?us-ascii?Q?Hm7A5tW2oFaPMXn46orzsBc3J61E/g9VUjet6vEc+1hKTmKvLWWysbJXXur8?=
 =?us-ascii?Q?PAOHDmxToxD+LzR4/OxN7xVTHO6IUmcwWWlNO55JJ8leMgsoNBg5JnP7f85T?=
 =?us-ascii?Q?KVJl+4WcPZfZngQhgUtNz3lecYsU8jkCEZPOLuwREagANfHx4jMyv2xvmvzZ?=
 =?us-ascii?Q?4TU1HsB8qAStJzxvCyY/u1zyTbUSvR6HwmLGndx6aNmkLSh0KxfhkSmwIYT4?=
 =?us-ascii?Q?VlBItLfaTfLxH2mftgnBxnTM0xUxeDWRulL/RXpxd3Itnd2hMXkYJRAubV5j?=
 =?us-ascii?Q?P9uHuZ/kqwqbHYNxVBclMnCTHbn+pbfjYYBu+8jV7rrmL1dpa05aQAOBTeeN?=
 =?us-ascii?Q?H8iraetgUKaBule3NneZpCxgAVDTT+bzJU+5YvhIvwrylLSZvFDDrXYvuMeH?=
 =?us-ascii?Q?OoIvxrWPWW1TFJaHGnizcQXc8aFlAQjyGTwnrBgf9lIJdXMjMEsk8NLcdmfP?=
 =?us-ascii?Q?ODRxz1jhHR/XqoMn2tgHZuJ0JFQkb0VzD2eqWZDInPFRu+nSLR8k+3+sA05m?=
 =?us-ascii?Q?fnoupIc5OLcc552XpT8gL7TGVb25iMEpPkjgeiwzPsKQ99IW5zQzZuhruyJL?=
 =?us-ascii?Q?EZ1zdzplR4J4VlZ/v66nBcjZfV1FdyREQmx50bytGHEBJcKZlrngL1R/UID2?=
 =?us-ascii?Q?9d9fCq2Tz8D9L6K9TqMLjDAppFMtA3m1Le5w56GPywsMTvsNSLTWc8OKA8+U?=
 =?us-ascii?Q?ZyloQC2gCzAc3po9lgN42RA1JU+dp8Nwq7S9GCRQc2xSkJS+hC3cNdNsg3Yw?=
 =?us-ascii?Q?6yQL5Yxl9Sudc+F9KQjufzfBjDba99vSIzpaHK3Q5v9KY9riQgxHIdTrvEqf?=
 =?us-ascii?Q?m+Fdd7Sm4wNHNz2ahaXlS2bgqXjyw/uGZDCqelFugJHpN8F2uCVVS2QxIpN9?=
 =?us-ascii?Q?ctRwUHv7BgGz/8qsfbgzclmVN9ZbtVr/KA7AG9A4yRAPM7b1k5ZQ2mLHZoUx?=
 =?us-ascii?Q?QXyd1idF+OYrPPLwi/XF9Wq9+zFVdBBWMdgEAF+vLeSg4RCaaBhym2ayn+Us?=
 =?us-ascii?Q?D3y7n4MP3nJKLTHSFzzfMBrVTWQU73Vpd1jTBPX8uFQIGD1O5PG6RTWOUs/o?=
 =?us-ascii?Q?CLx5nSG1ayqA7NzrUyIw1y3pxszFuu8tvPogoQA5gk2F72+npFTxNaoEciBf?=
 =?us-ascii?Q?0YpBBx0DkGfb3b4JbbqOuthPEw2QFc4AsJn4kFL0uKj9Ol9GX22xOpS0Xcpr?=
 =?us-ascii?Q?qcj+JDc8iMrDylu8FlcPrlBJ48/hrfenNB9ZROxL/zHnUwmz/7YzTKHqOSoP?=
 =?us-ascii?Q?i+Xdo5B9JEsWI7drKXrmOh2aknqyGV4XVDgJ3jbczvwh+5tUtyYN2Sz+BY+F?=
 =?us-ascii?Q?OpjlhoTmQlsPDaMqRKptCPXkYANeOuQTu1C19dowGGH8CIPgLBHMY4XkThRt?=
 =?us-ascii?Q?fY48xpxc94k/j+7D1Spssw6yDdjnaBY4BodTd5sVEIUHlEQw9skhW8zKX0H0?=
 =?us-ascii?Q?zRX+bHHeJigoqzhF3MKdXerQ+pFt6eSfhv4Sjw3H?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3095d42-2328-4a01-dd65-08dbd4b481ef
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 17:13:14.3555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNyHNYruIADH3Q5qu1k9rFt/t34HNUMnygL/OI1L7EHue0CzRsAdX/R3Ws7Yst46
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Oct 24, 2023 at 08:06:06AM -0700, Yi Liu wrote:
> +static struct iommufd_hwpt_nested *
> +iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
> +			  struct iommufd_hwpt_paging *parent,
> +			  struct iommufd_device *idev, u32 flags,
> +			  const struct iommu_user_data *user_data)
> +{
> +	const struct iommu_ops *ops = dev_iommu_ops(idev->dev);
> +	struct iommufd_hwpt_nested *hwpt_nested;
> +	struct iommufd_hw_pagetable *hwpt;
> +	int rc;
> +
> +	if (flags != 0)
> +		return ERR_PTR(-EOPNOTSUPP);
> +	if (!user_data)
> +		return ERR_PTR(-EINVAL);

user_data is never NULL now, I removed this

> +	if (user_data->type == IOMMU_HWPT_DATA_NONE)
> +		return ERR_PTR(-EINVAL);
> +	if (parent->auto_domain)
> +		return ERR_PTR(-EINVAL);
> +	if (!parent->nest_parent)
> +		return ERR_PTR(-EINVAL);

And put these all together

	if (flags || user_data->type == IOMMU_HWPT_DATA_NONE ||
	    !ops->domain_alloc_user)
		return ERR_PTR(-EOPNOTSUPP);
	if (parent->auto_domain || !parent->nest_parent)
		return ERR_PTR(-EINVAL);


> +
> +	if (!ops->domain_alloc_user)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	hwpt_nested = __iommufd_object_alloc(ictx, hwpt_nested,
> +					     IOMMUFD_OBJ_HWPT_NESTED,
> +					     common.obj);
> +	if (IS_ERR(hwpt_nested))
> +		return ERR_CAST(hwpt_nested);
> +	hwpt = &hwpt_nested->common;
> +
> +	refcount_inc(&parent->common.obj.users);
> +	hwpt_nested->parent = parent;
> +
> +	hwpt->domain = ops->domain_alloc_user(idev->dev, 0,

And we may as well pass flags here even though we know it is 0 today.

Jason
