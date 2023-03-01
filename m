Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B936A7447
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Mar 2023 20:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjCATah (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Mar 2023 14:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCATag (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Mar 2023 14:30:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2075.outbound.protection.outlook.com [40.107.93.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95CF559F6
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Mar 2023 11:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KFFC4VpFnizZESHhm5l7T6AVPG1P+CR//MD1uh7RT2F2zlQPp/j6REMqBf6D1gXvtBxY22RDV0M+ffgvm/qAHnxMA2f0xwi9rZPudJRuicTCwY0UoOs2F02E1Q6oTG+TwrFcvEpBarXXA3v6/geUN2YB+ekztDsWuL8xiPOgRjACPzno2JbOOGi9qclk0PQ8nFQiEJWfE4/Au2ZHBnRs0tk3n2R9emYYAw9uRlG1YQXISksPgxWHOh51SJlgU/iGj3Wc1etMI3rZQw6sQYYtxr5+coPgFydg+e+uXN8E2eSEv4W8fyLQTVGG4AcE5ZZKj3vR/CgzNdkoQ8hb1Nm/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4941AQ5PYzyxSDmSn9pZznk/aYIh0RcRcpoFFMQfPC4=;
 b=MAU2bvRbEEPbEj5FbTBy2UEJyVV4+XtISWB7CvCAAtjX05r107/yxabF/YMevwi336fqTVhVkH7S/zYLJNRX5oqqPF5DxS+y2mWhzDABr5ya0JeiUdOHqaQn3j3RCEjKghmFonYarDh4x09uOpetyA/asNBy1c24Ea6ItDfeEbb2UCQOHXWwMWpx6dUjNGxm/vL1AaGc2y3DYNfFaHQ1fJDGrxQJpe1Ajtlp2h1AVM7T7EDrw+rqbz3UDtxrFqghueWooLEGaLR+d0Cqwx0NmHV3/eY+hxhigo+NKWXV9ux8V24McvP8Vg41yVQwKbgCOIHpcyXBEsaetBuTeM3vXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4941AQ5PYzyxSDmSn9pZznk/aYIh0RcRcpoFFMQfPC4=;
 b=RHmVbo3n20Jf3n33r5P07JDc2XqXEzp5xOvi+s76naiIH7y/Jv5AYGXpHTtqaN34h94YXSRrBg9mrNc5Lp332WAPR5dmrWbzHfOtDR99SgLEDCLVUmzyQ6ejSjz+umJGRrd03hZLja+bdUiowsRmWZT1eAqefK2rv5nsitfXAVni+W1CaKZVTqJhVbDSh8kjR2hHlDba7qcL/pnB66FuLi/CYqzcOLWV3aTqPQTMWFaoWpMSweT7sPHV6eJ18e/mwv/IIXe5gfAnvWElnYSO2osIowko11PzRNNWfnBStEnljAygoXMBfsrzNwNqfVWNJg4sj8STSgMBhm6u5ddojA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Wed, 1 Mar
 2023 19:30:31 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.029; Wed, 1 Mar 2023
 19:30:31 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc:     Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v3 03/12] iommufd: Consistently manage hwpt_item
Date:   Wed,  1 Mar 2023 15:30:20 -0400
Message-Id: <3-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
In-Reply-To: <0-v3-ae9c2975a131+2e1e8-iommufd_hwpt_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT4PR01CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 1461981a-f6f3-421c-cb5b-08db1a8b6b57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ByEN5sSgtsrDbQc/u+YjEFDQAfjsGhlzg5IxCxwRTZ63r/ih84295LQL+mQQB2S05DaNIv24RcLlqfyhYf5weczdV8dUk88E9MzcVRh+6PJkMgl2vV+jTPgq0ES3Vm2H/vksRhg9GYgD45Jz6az451foMgNe3EJtDZpdGsGKXkG8mSownE4Cl8KuVKWywV70WFVyrH1DPgZPtrMh6PCBafhhhtoN4n5ckTlSyIN9tYbNXtCDQ4Mp34u88RJ0iLQ4oTzR1snR7TfGPLV9cY6WM1KAqDPedDdPkgWluak0h9BUna0+SaJFRoPUcKivxEcv4+p/hi29ZxmZgAlbil0dZZ4ZJNmJNftrfB02Jdf4g1PZET/fZXmQugMO047pzkgknY2L4KMHnG2cJfTtIVpEc8RV3PSKdAtI4+K+qJmn5l2TZurbX8YybZwRQfjIgCkzGjy4fHwYsLfECBUNstntNa5Porzr3ZA4A4kLaXj2O7P+rEH8rGDdrN7Q+xzmQa8EQ1JcMRj7nFICrnQM2Q7ItWiI9stLtqygdd7VojTsBM8e5Qk9FZtQR45x9mjbnOedKrfJY2LlOdfSx9lZb+vB9XLwPPQKI7uHrQvm3Oaz/gIFMCU/oLzK+UeIDJB9TuPK7XUV4KBRmtIxzUvn9FDVXSZYui4d5zibaNZistnUVVMxT3Dt9i66mBOkzAjCsz0Y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199018)(186003)(2906002)(6512007)(5660300002)(38100700002)(26005)(6506007)(8936002)(4326008)(6486002)(41300700001)(86362001)(2616005)(8676002)(66946007)(66556008)(66476007)(6666004)(110136005)(36756003)(54906003)(83380400001)(316002)(478600001)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJwvlDAJmeIQ97HeF2hQFnXOXLpCC0HZXFFhFRFnCW32hahCID4PTvy2O4/o?=
 =?us-ascii?Q?hJpDyk4u7eahWgLR96c61lnZUxq/1ZHkByf4ECuad96FQtfm8Uq+JzyoWPyI?=
 =?us-ascii?Q?ZJJkJeYIL9xVuixiy+hSPh2LEVViIFeQgHgKz7RyosSK+ApMLGxEYcZB+Mxu?=
 =?us-ascii?Q?bKItKD/jM7cg75QLmqsh5rfNafOwwUJzJsCu1fbdv0pf5IOOxHJ+o9HhWejD?=
 =?us-ascii?Q?/3xVTvQe9jQozDj8Yok9S37sG3eJnkOeCguaq0+H5Y5GF7jRp5/GYOJ0qkQR?=
 =?us-ascii?Q?dqxtqOvIdwRnRrKURua+KndP9X9frxo27RqtYHoVdhL6yrcs7FrAb8EMB28d?=
 =?us-ascii?Q?O6OPiiR9NCDLT4cBNi8hS3WZo5qsRk8V00KH7KrvDOE+YcsR9rUUjrERvhta?=
 =?us-ascii?Q?HnEW92RvvG0i5chXKKmSktfxZ6yXSutSGX7dtJdV5w+bDogcqaS5QsAIMHfv?=
 =?us-ascii?Q?TwSLUwtgnr5pbP+BpOtfDAb00TiDDC9Pv9WxZnmrsmonZ4jBKCUmag7zKU/x?=
 =?us-ascii?Q?S/pl1MvHR3ew+EoSyi9KN8S2o6TxX+YnJVuX2G45ZcK0xVlASKqOOGpBaoV7?=
 =?us-ascii?Q?Gq1UJ6kVSheicIzn6xAISybleMi5Uah37PsT2BZnRUc1ywXR31uYhPHBLa7e?=
 =?us-ascii?Q?oJodymiuN7NtCKhG+wFHO7iPekFlpLW0GoYgfNyc9aFrMUYA5LRiYH/8NMiB?=
 =?us-ascii?Q?yvnFtHA8TUTDkk1663d3mWKHMArDr0NO1raodzd+ycY4QLR6bHAJEKzP7IIH?=
 =?us-ascii?Q?sBXhB4WoL7fYOY2k8C1AMBRuZqVVh6KPcyWDPcsW4QH5bZmNuJSFWHLLH37j?=
 =?us-ascii?Q?QuRNj2FZQ/5KEnvkGJH/yGrAywN8K7Ufv18mmLXvfaE83wSgi01/zssHJ/Jw?=
 =?us-ascii?Q?GWmjjmq3/HrSUh4U+fXwJhKlWjY7b4CMXCXiCoV4VWrtb4bQYMmLX2Sht8Eg?=
 =?us-ascii?Q?bwAxa1CvPMYdDL8SeRVVwbro3KsIaFMUzwt/07J4LX4UDPi6azYRwisivSiy?=
 =?us-ascii?Q?1B45QXntPcWTMCTta98x55OtJU/nmipA9+3UvHplqDZr2ntKma0Mmfs5+8n6?=
 =?us-ascii?Q?FROG7i1IkwBWMa7egWHusXSlRGfl564w3IHPEbk63kfNSoGVcEqFNGzUX0YZ?=
 =?us-ascii?Q?SIcWKEmbu+MT6MLsFWtj/+WAkfqv3nXPwT9OMGK95jslhWH/9gIdWH/mYuLd?=
 =?us-ascii?Q?AlFs/Fv17RNr6Y5syNx9sTmGtgHb9FSBso4v2a5+eDRu3Pp4aUWBsmRDRP3r?=
 =?us-ascii?Q?pKCWcTW4wlyHD7TjziNrYT7ZbSBDOnxPv1DKqItgnZExbUnuAEL14YMRyC+L?=
 =?us-ascii?Q?yTKvFPpAMgzWLnVQ5vR+of6Xn5GiTE3JB5VuwPmvD236hqUEF8Fl7TWfUr8b?=
 =?us-ascii?Q?WSqc+l3aPsy+0igT4+KEGDvgr4N4zmhLlhRLLFuNbFMDaKKjKyLJBqG7fosd?=
 =?us-ascii?Q?rPUgR3J3LrPqcxYJiW/2NXWxewmn9/KFSOHQNrQIomvLzUg27EBziWzLhxjV?=
 =?us-ascii?Q?9vXUsvqd8yJQ9tbMb4wMdF0O2auvzdbxNWjUwiZ44rMAHTk8QDGvIVqiqogn?=
 =?us-ascii?Q?0dhBWnANr457q4b6n/RBs8Ox47JGkfGK8N9XEDLz?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1461981a-f6f3-421c-cb5b-08db1a8b6b57
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2023 19:30:30.7999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lAG97VekCcUyKRcYBdVHfgbz4rCKgcpEcJrAUuPLR//q7yG4oAjftt59UTPDuh7z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This should be added immediately after every iopt_table_add_domain(), and
deleted after every iopt_table_remove_domain() under the ioas->mutex.

Tidy things to be consistent.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/device.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 0a80ff7b2e0d79..adb73539b39c0c 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -243,6 +243,7 @@ static int iommufd_device_do_attach(struct iommufd_device *idev,
 						   hwpt->domain);
 			if (rc)
 				goto out_detach;
+			list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
 		}
 	}
 
@@ -307,7 +308,6 @@ static int iommufd_device_auto_get_domain(struct iommufd_device *idev,
 	rc = iommufd_device_do_attach(idev, hwpt);
 	if (rc)
 		goto out_abort;
-	list_add_tail(&hwpt->hwpt_item, &ioas->hwpt_list);
 
 	mutex_unlock(&ioas->mutex);
 	iommufd_object_finalize(idev->ictx, &hwpt->obj);
@@ -753,6 +753,10 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 	if (rc)
 		goto out_hwpt;
 
+	mutex_lock(&ioas->mutex);
+	list_add_tail(&hwpt->hwpt_item, &hwpt->ioas->hwpt_list);
+	mutex_unlock(&ioas->mutex);
+
 	refcount_inc(&hwpt->obj.users);
 	iommufd_object_finalize(ictx, &hwpt->obj);
 	return hwpt;
@@ -765,7 +769,10 @@ iommufd_device_selftest_attach(struct iommufd_ctx *ictx,
 void iommufd_device_selftest_detach(struct iommufd_ctx *ictx,
 				    struct iommufd_hw_pagetable *hwpt)
 {
+	mutex_lock(&hwpt->ioas->mutex);
 	iopt_table_remove_domain(&hwpt->ioas->iopt, hwpt->domain);
+	list_del(&hwpt->hwpt_item);
+	mutex_unlock(&hwpt->ioas->mutex);
 	refcount_dec(&hwpt->obj.users);
 }
 #endif
-- 
2.39.2

