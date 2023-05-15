Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFC702F1A
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbjEOOBD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239474AbjEOOAz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:55 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68C61FDB;
        Mon, 15 May 2023 07:00:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lod8OiRg41VRk2sAPFYYruKjNi6OKTBoWbIZBg3QOSF0QGW2AowaQ/NpD0p3IIRzZFlrxSCTo4FuQhHxR7csQzU9FvoqksrngqOuPZWBppiNDsCsH0lc0mamGEI9QwuPztGb6OjMUDaBNzD2c32fgC9MJIrVT+UaS7qAhzaVgOzR83MwJq3Re/h0Hlf5toCnG3WJybL6h6ur/P2BV8pj5RP/gvHj2hWivMecT9ke3UDOosdGXraoZRu2Nqj6c3USMnd/HqONHTX0YJFHMz7buhnC5AxCCyDXpr9TBOkQZI2+MxPUwr5rmC+9WtV5+rGYIfOnjHWBbu7AcBuWpzPZzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoDZT/Igs6qwPv5KuKGfSBYWF+vIWIAstp8wEac2eMA=;
 b=F6HUJYMneCehSZSkUlf7AskxjckKGW8u6jHAebe5Xp1CThVRfumN67JYk+UZwkAVMrqZqqHsUPhTeAGo8Pke/73ZoLS2+zY0iCTegAMqWp3Fi57T39TsDzLUBNPd75KglQ+0BxekcfrTqON65B7aeUIIyIU3yyD/hGvmdoRrPOI34Q6uW3moFqZU3JIH8j9CeAa9pf57NCsm8JfDFcj/GVEqkBvme7kqWS/MOCbFxn4IF0jCfaZ7bs3l2fG4UpO8+R7M2TLOenx5BUGFnbOa+CCYrQJX7D8g7aJyMk2Ac+DhkzfMy2RtFL50pBHBQhNLGbDPMBFjuE6G6XJRH3XzJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoDZT/Igs6qwPv5KuKGfSBYWF+vIWIAstp8wEac2eMA=;
 b=CwOKvF7CknitgxFvn46i3PQVhST8PFtJfOLcNzvEkmMJ3xs+3IFztFC1HBGlNOCqeV5B66cQA0Hhm/k0PQYIRFCwqjcflYQNGyHokCJnGv6WV3/WqJPNSnKzhj2IR1HSs9KzF35pXuNqWTneqWohuao6PhRMitSMiOligSJeIbMfo3Ta1sc0x6vB3ZuNcfp2hxWatScH7WUCyaCxiYasDkeimIqo46ODLfoHLJ314knnrbjk9rM1FtCHCBKLFGw9QQk0KE8Po/gjAGoidD2Ce+Kegi+lJXOEHy6x2RmMMdF4k98Jv39Etz71FLIV3Wj7Czo0ZPUkPA34DSoYxYlSOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:46 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 19/19] iommufd/selftest: Add a selftest for IOMMU_HWPT_ALLOC
Date:   Mon, 15 May 2023 11:00:34 -0300
Message-Id: <19-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR17CA0014.namprd17.prod.outlook.com
 (2603:10b6:208:15e::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e5d1a1-a57e-41ae-a475-08db554cc308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fhJ1NTTvolYNTTx0BqCM2mJlC8cUt8SuWLC/sZzwX6wXR3aDQJV96bkPpK21nwm0M/wST2IxhnNvXAJMkKwkH5u8o+MgvBzs6yzU9iL9YRoAFuo9DhG9fuSyFqppu/aI0p2TqAKSC/ITo3WZrefvz0ZC2DLxOkQSwrlUIh+medK2U6Gd0HHYlno5/hL5d4cy0ZQetkyUsk5rctO7VJmOGNdpvf/eBmUETqIoCG6Cu8wcJpHOY3A9Z9dENscMnHAgxuFMRzKD7G5fJxCUSExJlKpBWu1MrMKHz/zFVZcQGazDSeMAYIgpRKBneKkW+dQrkbDDos6dNQVNkyrNdPoIVKYszefHVFp1YonNFhb6LEvxWUC17FV7JaRV9r30uXCqV3ir+oMXf40RCHTtsfIeJKPPgIQ9szmczc8ZZxVtN5IP662owJPqCjtwQ6K0mBk+c/ZH3mW1QMiWfrrzFoceGicgHIucLcxuy6BdxHIpu32VjBZts1uN3z1fE/baZfbqdlx19fdm+CkkXFKnLqBvVFmWb2YdbttuD4iFWNPF8S6Ss1/CpPar23F3M3qGJEMA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z1MEP7rbFNb1bx39SaExL4fmnjthMIyUBxwX5PnF9MSHKbf9ZzN0ZosfB2lw?=
 =?us-ascii?Q?9rRgtcBatK3T0sxf884s/j62lkIq+BJVL8iG5v+6/14OsnB4FMwl4X5iYpK9?=
 =?us-ascii?Q?Gd5HugsKXb+rio0gYucxSvi/VS5L3P6FWoJoTEo8qInSVwxTixQIjettuuMe?=
 =?us-ascii?Q?xvoof3SQ9kPeA7uKtWrDj9/snkTMD0mrTiDjpWjpau+l7Md5KB44VfOowVlX?=
 =?us-ascii?Q?95q+wYd6hfwuWJSptD0VmngHyeQorqHGLwn46vEmJhoIWMCvIZux/PwofYev?=
 =?us-ascii?Q?vNfIX0sOxoh20/KuJWzXWqQWYCl4GInQp+lTyFhuIkbv80afYwfhriTEH7kp?=
 =?us-ascii?Q?Uxv8JcoKIt9Yv/FEzbuq7m4o9nu65v/icPcHEiWucFTs61vF+991fViHMHOy?=
 =?us-ascii?Q?7oLzqAxQicYirFl7LdBdY1Ay4RSOiMnCJ21BhGG5iW6Gow2vAkackidE4QnU?=
 =?us-ascii?Q?Eor4ez+PR+6iJYsOuEJBL8iBWkPlERCVEMRtdmbjfHIcb7+Gq5DZTCVNjnxQ?=
 =?us-ascii?Q?DnP2fvl+ab2HmJLHdHgWrYYVAa+sFI2bjuCUpb1qgfwdCvDN4Z+lq1C2dAFk?=
 =?us-ascii?Q?pA6TMcudE+mKWyrnKB144lgMOMtstevxjT2hT+Bz/C4M6n4CDauiJ5bH2NY8?=
 =?us-ascii?Q?887Bu8wXmNc3K9dOCA4s2hexLNtbnfompvbZML1XU4wQtGetFOs8i7hXfNjq?=
 =?us-ascii?Q?vSnbSGFT3u4Sy7zgMUcWIZZS73eHWqPV/P9PzJMq7a2gPK5ZCZ5Fi5ayopir?=
 =?us-ascii?Q?ifLnzKg+aY30iYzRizXbleaMRz/jk+HfTsl7Iz61tlsAIh+R7SQ6VMfRBkE4?=
 =?us-ascii?Q?mJ59VrF4YHjw50MpC1McFvyeLGJkQArMDGGQeutL26ZWEyaZKxmeAjqDaWjT?=
 =?us-ascii?Q?25wJv287LnPFPurBA2/Y2L9si3yepANmq3gQ0Tr3IIFaF1yFD+32ZYUc8hvv?=
 =?us-ascii?Q?cOLBRvwCFZJ7ien0AMqSOE/t6oWQG6MiSAJgKMIU+o04kSN8KjNZ2eP2owfQ?=
 =?us-ascii?Q?ee7wZygWzeX5uaTReZkBE+1eI7grQnlmXqV6Hq6/2r8pcb05FuiwVrTJqsg6?=
 =?us-ascii?Q?RjQaJD4LtJAwR4walLduavLILUWiCHmHz4hx3J6NSLyCbbxWDDWQyUrwQVJF?=
 =?us-ascii?Q?QzPN5nGL7fykbUtj9/nytjJJXpKQRK+PSop1KFXuNC2kMh6/t5tyjl7o62c6?=
 =?us-ascii?Q?legWg2lButcja91nEXwZ2kqb25QoCBTSwiDghcIjWocsEByRi5w0/1R1/AyJ?=
 =?us-ascii?Q?1EIA3+l/g+owFh+qK3Nc/5+rROcrkRJ6uSA1o5yhQblCHSS9o3vh1igEjPHN?=
 =?us-ascii?Q?XLYBpGepSBvjCjWjCswgXTSaDy/RkD+rUmUdBbiJOoJHqeGR61xId2wBtCM3?=
 =?us-ascii?Q?6sz761nHPmAebdORJd1an3/uaMn2R7BHGK7x7LnzRU6qX1qC9atubuRA6m95?=
 =?us-ascii?Q?NBZprMCCY9Q/g+Y64GwuYLxZ/SaV0wU5FdVeoTpgS2RcW8l/SAZteN5jN4lT?=
 =?us-ascii?Q?Q1Rr5dZdIbzqP+5ASRZhpDtQoiRfdlwTjStwptjRWz0GWZEqly+R5+H13Sa8?=
 =?us-ascii?Q?wV3JuQhA+gt1+HTE05FVgIDCnU4+zvqRqibEysBJ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e5d1a1-a57e-41ae-a475-08db554cc308
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:38.2300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+uB8/0y0DVKSlM1dqmcb+zyQy9tZpbZzsCsBBxntxC7LpSUfm6wDp3VCwGqYjWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7954
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the basic flow.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/io_pagetable.c          |  3 +++
 tools/testing/selftests/iommu/iommufd.c       | 15 +++++++++++++
 .../selftests/iommu/iommufd_fail_nth.c        | 11 +++++++++-
 tools/testing/selftests/iommu/iommufd_utils.h | 21 +++++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/io_pagetable.c b/drivers/iommu/iommufd/io_pagetable.c
index f842768b2e250b..21052f64f95649 100644
--- a/drivers/iommu/iommufd/io_pagetable.c
+++ b/drivers/iommu/iommufd/io_pagetable.c
@@ -1172,6 +1172,9 @@ int iopt_table_enforce_dev_resv_regions(struct io_pagetable *iopt,
 	unsigned int num_sw_msi = 0;
 	int rc;
 
+	if (iommufd_should_fail())
+		return -EINVAL;
+
 	down_write(&iopt->iova_rwsem);
 	/* FIXME: drivers allocate memory but there is no failure propogated */
 	iommu_get_resv_regions(dev, &resv_regions);
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 78841aba47d038..dc09c1de319f05 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1338,6 +1338,21 @@ TEST_F(iommufd_mock_domain, replace)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, alloc_hwpt)
+{
+	int i;
+
+	for (i = 0; i != variant->mock_domains; i++) {
+		uint32_t stddev_id;
+		uint32_t hwpt_id;
+
+		test_cmd_hwpt_alloc(self->idev_ids[0], self->ioas_id, &hwpt_id);
+		test_cmd_mock_domain(hwpt_id, &stddev_id, NULL, NULL);
+		test_ioctl_destroy(stddev_id);
+		test_ioctl_destroy(hwpt_id);
+	}
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 8ab20df4edc8c7..d4c552e5694812 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -579,6 +579,8 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 	uint32_t ioas_id;
 	uint32_t ioas_id2;
 	uint32_t stdev_id;
+	uint32_t idev_id;
+	uint32_t hwpt_id;
 	__u64 iova;
 
 	self->fd = open("/dev/iommu", O_RDWR);
@@ -605,11 +607,18 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL,
+				  &idev_id))
+		return -1;
+
+	if (_test_cmd_hwpt_alloc(self->fd, idev_id, ioas_id, &hwpt_id))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
 		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, hwpt_id, NULL))
+		return -1;
 	return 0;
 }
 
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 62e01412a7679e..53b4d3f2d9fc6c 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -98,6 +98,27 @@ static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(self->fd, stdev_id, \
 							   pt_id, NULL))
 
+static int _test_cmd_hwpt_alloc(int fd, __u32 device_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_hwpt_alloc cmd = {
+		.size = sizeof(cmd),
+		.dev_id = device_id,
+		.pt_id = pt_id,
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_HWPT_ALLOC, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.out_hwpt_id;
+	return 0;
+}
+
+#define test_cmd_hwpt_alloc(device_id, pt_id, hwpt_id) \
+	ASSERT_EQ(0, _test_cmd_hwpt_alloc(self->fd, device_id, pt_id, hwpt_id))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.40.1

