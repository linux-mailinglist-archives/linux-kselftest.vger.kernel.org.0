Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADDF67802B2
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Aug 2023 02:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356431AbjHRAWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 20:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356429AbjHRAWC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 20:22:02 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AFC5FE;
        Thu, 17 Aug 2023 17:22:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nh5pAXHDmte3ZhSYzXnJcpgjuUAP/1W+pBQ0Mx2D6LN4okGQrKE5qna5GM0tvpIE6tS6fyZ1lw+gBIzujBMc/QNPtzTAeMmLjWmBlWo1sDWSNFfSJDg/5VEfYe6qnbeSVRH/k86t6744d3CvTzhgtBMKY6HaE13MHM3vu8v0j2lpWBtuF0VOxzw1KahZ/bVGUvPxGRlL45st8yUu3XmN21eyFL/WNME3S9WahauHEk+uZydDWbcgf1n1LFM4jq+N24NMNlq1J/4bttqrizHoOwmzLXh6kTEpTebp/v/GWopGKWvRY10bgWCaKeZPzJmmaTLX9p449EMzRCNnYcveEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bl0ywFW2Xy2yup6foME1hdV7IQF2AwFWkZpU6txOmPQ=;
 b=dwmzfJwoFzrOPU6/o4JlRVZy8TzWMpHlmQT0PVlpNdPE5MeTDxj+Iy/HpSYlMIN+zDljpvnbCVb8y8BZrf1pagZsLXMsDJVSnQHdkXR1VSx2juiQNTDIC+Xsf/QAHSQ2XINzBpUxbiFAU6+E+R5Huh1QQiDfoIuVo8HLEFCYGVqr/3tlUMIQFaBLbwbfKB9VDGZsMkGYzqM9YDCLzaxEoDkKRszyYoThBGB2wccWL9Ii8GEZQrv2OmK5wxnVkNFJt1Rk/IESS6FG90WJkwJ8oPR9FtdsiL83VKxG1ymFPm1sKt5Ta5l0fE/98kw8dCm0ayktRr6vHsnytzHKU3M06A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bl0ywFW2Xy2yup6foME1hdV7IQF2AwFWkZpU6txOmPQ=;
 b=MD3AAyWdXRSEwhzWJTkfz91q/VjEc0S6d1SZJ6brC+7/pX5UNjOPzTeWe7GB9MpEP2CMs+j22N+eAdbGAvmHVT1vIYJfguIXdG7LJns7FpEzASVLIx7jJEfQH5QrgtpuSK8ocg2RENgONlpdn5c5CzXhLCPw6qKX6cJ9zgrTP6UVdsCY9TwU0YbloUp0tLI4Y4Sr4DNx9u3H8Jzt6hhwIep4xhvWT9m6RJmMGUQZOSn/iOkgEZj1R/0c9Yj4KiMj6pM3xDSXfvcamO9jl/JSyvh3fT9tm9ZBYwxEhzUSZZBP/5XIh3H0PEiyCCrwvfvmL9NvSbgASP05JMOKtn9bSQ==
Received: from BY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:a03:1f4::41)
 by CY8PR12MB7491.namprd12.prod.outlook.com (2603:10b6:930:92::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 00:21:57 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::10) by BY5PR20CA0028.outlook.office365.com
 (2603:10b6:a03:1f4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 00:21:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 00:21:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 17:21:43 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 17:21:43 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 17:21:41 -0700
Date:   Thu, 17 Aug 2023 17:21:39 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
CC:     "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v8 3/5] iommufd: Add IOMMU_GET_HW_INFO
Message-ID: <ZN65kwqeP04ptyKq@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-4-yi.l.liu@intel.com>
 <BN9PR11MB527620AAA752DEFEECF260918C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZN6MKnCOk7ufYnV8@Asurada-Nvidia>
 <DS0PR11MB7529F6CA52479527F7B87B00C31BA@DS0PR11MB7529.namprd11.prod.outlook.com>
 <ZN62flrw24cVcMLq@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qk/r+jMfsH0Su+MX"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZN62flrw24cVcMLq@Asurada-Nvidia>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY8PR12MB7491:EE_
X-MS-Office365-Filtering-Correlation-Id: 038887bf-5d8a-4156-8bd8-08db9f8121b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1j6Pc7jMac/0nNSH6OGt+zDaSN8PDBH3zWXsvjguGsPHuUx4sfTFJsxJzAPLRP3Ail79hmkkZrAWmkVWJqAzcEylLwuNTJMojYztEhhBVty5CSzFMTfy0WHfzU6Lw+utpF8aKtbnGIWeBaZMPEJQExcQ0pfz9Nk0cAEb2jTOmyAadcjJcihV5vxKQn83sNlqy4DWujK8pUD8zBfMqel8atqVBDneCg3qUIgiCjCFIJIIN7adQL5hPnR5r0hQQJsZfY6e6scxaiMgFTfc88QkppeYrrn6k7nnz9rQykId90nExmA/mEw4FE1nkfvw6XH5OsWDXLmKbqYrRMb1k43MQa7Letht68CZNv5ilOP1q8foV1OJGRyWyQGK5N1jIqfy7uPAJ0ehjmPW+yxEUsg43d7U4aYTxoNlz0Hb22uk3VcbbyMzDQRYjiABi8pzbINKInntz1dw0+KSJP4YpH2tukgDGmXULlpSn+T5Hw4/Oms+awqk5FvPVRtstV36dOUodc6vJLj1rzXBm49cp4VPS15Y/gPhipf5OkpliivrVIJCUaETrAgnmfvR5pmJu/J8EGS7k/Dw4liQXhBOQak0SvlzUtda1DR0MuH+F9DGouDvHrpLxuVKe5CtzE2kSQJmIJ2Ay9gQxv7T2JTLaagNJCdKctrPm7eHSIt6rtHMnZvgrFeH3oVItFkp93T6rvb0JEhm8VNJhx0+dcUNdtHtSjDN3fjdXBMjd34/kZb+MuyrekZ5yr3xQoif6S6mckJXXZiqTVES2mLU64k8n/JzMfxylT3qs5skc7af81KgonyLULEW0UWljvBjH/qpCKpc
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(1800799009)(82310400011)(186009)(451199024)(40470700004)(46966006)(36840700001)(6916009)(55016003)(40480700001)(40460700003)(966005)(7416002)(54906003)(70206006)(70586007)(82740400003)(356005)(478600001)(7636003)(316002)(41300700001)(4326008)(83380400001)(5660300002)(8936002)(8676002)(235185007)(2906002)(47076005)(336012)(9686003)(44144004)(36860700001)(33964004)(26005)(426003)(86362001)(33716001)(2700100001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 00:21:56.6622
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 038887bf-5d8a-4156-8bd8-08db9f8121b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7491
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

--qk/r+jMfsH0Su+MX
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Thu, Aug 17, 2023 at 05:08:34PM -0700, Nicolin Chen wrote:
> On Fri, Aug 18, 2023 at 12:04:29AM +0000, Liu, Yi L wrote:
> 
> > > From: Nicolin Chen <nicolinc@nvidia.com>
> > > Sent: Friday, August 18, 2023 5:08 AM
> > >
> > > Looks like Yi's latest code has not addressed these comments.
> > 
> > Yeah. Not yet. In progress to incorporate them. 😊
> 
> I fixed them all in my local tree. I'm finalizing with alloc_user.
> Let me send my branch after that, and you can edit upon :)

https://github.com/nicolinc/iommufd/tree/wip/iommufd_alloc_user-08172023-nic
Attached two sets of git-diff for the updates that I made to the
two series. Note that I didn't make any change to the VT-d patch.

Thanks
Nic

--qk/r+jMfsH0Su+MX
Content-Type: text/plain; charset="us-ascii"; name="diff-hw_info.patch"
Content-Disposition: attachment; filename="diff-hw_info.patch"
Content-Description: diff-hw_info.patch

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 36dff7ca3ae4..f5836a5bdbbc 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -1144,7 +1144,7 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 		data = ops->hw_info(idev->dev, &data_len, &cmd->out_data_type);
 		if (IS_ERR(data)) {
 			rc = PTR_ERR(data);
-			goto err_put;
+			goto out_put;
 		}
 
 		/*
@@ -1154,18 +1154,17 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 		if (WARN_ON_ONCE(cmd->out_data_type ==
 				 IOMMU_HW_INFO_TYPE_NONE)) {
 			rc = -ENODEV;
-			goto out;
+			goto out_free;
 		}
 	} else {
 		cmd->out_data_type = IOMMU_HW_INFO_TYPE_NONE;
 		data_len = 0;
-		data = NULL;
 	}
 
 	copy_len = min(cmd->data_len, data_len);
 	if (copy_to_user(user_ptr, data, copy_len)) {
 		rc = -EFAULT;
-		goto out;
+		goto out_free;
 	}
 
 	/*
@@ -1175,7 +1174,7 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	if (copy_len < cmd->data_len) {
 		if (clear_user(user_ptr + copy_len, cmd->data_len - copy_len)) {
 			rc = -EFAULT;
-			goto out;
+			goto out_free;
 		}
 	}
 
@@ -1186,9 +1185,9 @@ int iommufd_get_hw_info(struct iommufd_ucmd *ucmd)
 	cmd->data_len = data_len;
 
 	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
-out:
+out_free:
 	kfree(data);
-err_put:
+out_put:
 	iommufd_put_object(&idev->obj);
 	return rc;
 }
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index f2d6a3989713..bd6a1110b294 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -228,14 +228,10 @@ struct iommu_iotlb_gather {
 /**
  * struct iommu_ops - iommu ops and capabilities
  * @capable: check capability
- * @hw_info: IOMMU hardware information. The type of the returned data is
- *           marked by the output type of this op. Type is one of
- *           enum iommu_hw_info_type defined in include/uapi/linux/iommufd.h.
- *           The drivers that support this op should define a unique type
- *           in include/uapi/linux/iommufd.h. The data buffer returned by this
- *           op is allocated in the IOMMU driver and the caller should free it
- *           after use. Return the data buffer if success, or ERR_PTR on
- *           failure.
+ * @hw_info: report iommu hardware information. The data buffer returned by this
+ *           op is allocated in the iommu driver and freed by the caller after
+ *           use. The information type is one of enum iommu_hw_info_type defined
+ *           in include/uapi/linux/iommufd.h.
  * @domain_alloc: allocate iommu domain
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 42f024c07006..b4ba0c0cbab6 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -429,10 +429,7 @@ enum iommu_hw_info_type {
  * fills the buffer using the given length in @data_len. If the ioctl succeeds,
  * @data_len will be updated to the length that kernel actually supports,
  * @out_data_type will be filled to decode the data filled in the buffer
- * pointed by @data_uptr. Input @data_len == zero is allowed, no information
- * data will be filled to user, but user space could get the iommu_hw_info_type
- * filled in @out_data_type and the iommu hardware information data length
- * supported by kernel filled in @data_len.
+ * pointed by @data_uptr. Input @data_len == zero is allowed.
  */
 struct iommu_hw_info {
 	__u32 size;
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index a068bfbe9f83..33d08600be13 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -295,10 +295,13 @@ TEST_F(iommufd_ioas, ioas_area_auto_destroy)
 TEST_F(iommufd_ioas, get_hw_info)
 {
 	struct iommu_test_hw_info buffer_exact;
-	struct iommu_test_hw_info_buffer {
+	struct iommu_test_hw_info_buffer_larger {
 		struct iommu_test_hw_info info;
 		uint64_t trailing_bytes;
 	} buffer_larger;
+	struct iommu_test_hw_info_buffer_smaller {
+		__u32 flags;
+	} buffer_smaller;
 
 	if (self->device_id) {
 		/* Provide a zero-size user_buffer */
@@ -310,6 +313,11 @@ TEST_F(iommufd_ioas, get_hw_info)
 		 * kernel zero the trailing bytes.
 		 */
 		test_cmd_get_hw_info(self->device_id, &buffer_larger, sizeof(buffer_larger));
+		/*
+		 * Provide a user_buffer with size smaller than the exact size to check if
+		 * the fields within the size range still gets updated.
+		 */
+		test_cmd_get_hw_info(self->device_id, &buffer_smaller, sizeof(buffer_smaller));
 	} else {
 		test_err_get_hw_info(ENOENT, self->device_id,
 				     &buffer_exact, sizeof(buffer_exact));
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 097418f2fdb3..e0753d03ecaa 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -21,6 +21,10 @@ static unsigned long BUFFER_SIZE;
 
 static unsigned long PAGE_SIZE;
 
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
+
 /*
  * Have the kernel check the refcount on pages. I don't know why a freshly
  * mmap'd anon non-compound page starts out with a ref of 3
@@ -353,13 +357,13 @@ static void teardown_iommufd(int fd, struct __test_metadata *_metadata)
 static int _test_cmd_get_hw_info(int fd, __u32 device_id,
 				 void *data, size_t data_len)
 {
+	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	struct iommu_hw_info cmd = {
 		.size = sizeof(cmd),
 		.dev_id = device_id,
 		.data_len = data_len,
 		.data_uptr = (uint64_t)data,
 	};
-	struct iommu_test_hw_info *info = (struct iommu_test_hw_info *)data;
 	int ret;
 
 	ret = ioctl(fd, IOMMU_GET_HW_INFO, &cmd);
@@ -389,8 +393,10 @@ static int _test_cmd_get_hw_info(int fd, __u32 device_id,
 	}
 
 	if (info) {
-		assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
-		assert(!info->flags);
+		if (data_len >= offsetofend(struct iommu_test_hw_info, test_reg))
+			assert(info->test_reg == IOMMU_HW_INFO_SELFTEST_REGVAL);
+		if (data_len >= offsetofend(struct iommu_test_hw_info, flags))
+			assert(!info->flags);
 	}
 
 	return 0;

--qk/r+jMfsH0Su+MX
Content-Type: text/plain; charset="us-ascii"; name="diff-alloc_user.patch"
Content-Disposition: attachment; filename="diff-alloc_user.patch"
Content-Description: diff-alloc_user.patch

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1d9ba7454605..3f3644375bf1 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -109,18 +109,4 @@ struct iommu_test_hw_info {
 	__u32 test_reg;
 };
 
-/* Should not be equal to any defined value in enum iommu_hwpt_type */
-#define IOMMU_HWPT_TYPE_SELFTEST		0xdead
-
-/**
- * struct iommu_hwpt_selftest
- *
- * @flags: page table entry attributes, must be 0
- * @test_type: can be either IOMMU_HW_INFO_TYPE_NONE or IOMMU_HWPT_TYPE_SELFTEST
- */
-struct iommu_hwpt_selftest {
-	__u64 flags;
-	__u32 test_type;
-};
-
 #endif
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 3cd1b17638bc..0bd7534be257 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -88,8 +88,6 @@ void iommufd_test_syz_conv_iova_id(struct iommufd_ucmd *ucmd,
 struct mock_iommu_domain {
 	struct iommu_domain domain;
 	struct xarray pfns;
-	/* mock domain test data */
-	enum iommu_hwpt_type hwpt_type;
 };
 
 enum selftest_obj_type {
@@ -150,10 +148,17 @@ static void *mock_domain_hw_info(struct device *dev, u32 *length, u32 *type)
 
 static const struct iommu_ops mock_ops;
 
+union mock_domain_alloc_data {
+	struct iommu_hwpt_default default_data;
+};
+
 static struct iommu_domain *
-__mock_domain_alloc(unsigned int iommu_domain_type,
-		    const struct iommu_hwpt_selftest *user_cfg)
+__mock_domain_alloc_default(unsigned int iommu_domain_type,
+			    const union mock_domain_alloc_data *data)
 {
+	const struct iommu_hwpt_default *user_cfg =
+		(const struct iommu_hwpt_default *)data;
+	dma_addr_t aperture_end = MOCK_APERTURE_LAST;
 	struct mock_iommu_domain *mock;
 
 	if (iommu_domain_type == IOMMU_DOMAIN_BLOCKED)
@@ -162,16 +167,21 @@ __mock_domain_alloc(unsigned int iommu_domain_type,
 	if (iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
 
+	if (user_cfg) {
+		if (user_cfg->max_addr > MOCK_APERTURE_LAST ||
+		    user_cfg->max_addr <= MOCK_APERTURE_START)
+			return ERR_PTR(-EINVAL);
+		aperture_end = user_cfg->max_addr;
+	}
+
 	mock = kzalloc(sizeof(*mock), GFP_KERNEL);
 	if (!mock)
 		return ERR_PTR(-ENOMEM);
 	mock->domain.type = iommu_domain_type;
 	mock->domain.geometry.aperture_start = MOCK_APERTURE_START;
-	mock->domain.geometry.aperture_end = MOCK_APERTURE_LAST;
+	mock->domain.geometry.aperture_end = aperture_end;
 	mock->domain.ops = mock_ops.default_domain_ops;
 	mock->domain.pgsize_bitmap = MOCK_IO_PAGE_SIZE;
-	if (user_cfg)
-		mock->hwpt_type = user_cfg->test_type;
 	xa_init(&mock->pfns);
 	return &mock->domain;
 }
@@ -183,7 +193,7 @@ static struct iommu_domain *mock_domain_alloc(unsigned int iommu_domain_type)
 	if (iommu_domain_type != IOMMU_DOMAIN_BLOCKED &&
 	    iommu_domain_type != IOMMU_DOMAIN_UNMANAGED)
 		return NULL;
-	domain = __mock_domain_alloc(iommu_domain_type, NULL);
+	domain = __mock_domain_alloc_default(iommu_domain_type, NULL);
 	if (IS_ERR(domain))
 		domain = NULL;
 	return domain;
@@ -193,27 +203,31 @@ static struct iommu_domain *mock_domain_alloc_user(struct device *dev,
 						   enum iommu_hwpt_type hwpt_type,
 						   const struct iommu_user_data *user_data)
 {
-	const size_t min_len =
-		offsetofend(struct iommu_hwpt_selftest, test_type);
+	struct iommu_domain *(*alloc_fn)(unsigned int iommu_domain_type,
+					 const union mock_domain_alloc_data *data);
 	unsigned int iommu_domain_type = IOMMU_DOMAIN_UNMANAGED;
-	struct iommu_hwpt_selftest data, *user_cfg = NULL;
-
-	if (hwpt_type != IOMMU_HWPT_TYPE_DEFAULT &&
-	    hwpt_type != IOMMU_HWPT_TYPE_SELFTEST)
+	union mock_domain_alloc_data data, *user_cfg = NULL;
+	size_t data_len, min_len;
+
+	switch (hwpt_type) {
+	case IOMMU_HWPT_TYPE_DEFAULT:
+		alloc_fn = __mock_domain_alloc_default;
+		data_len = sizeof(struct iommu_hwpt_default);
+		min_len = offsetofend(struct iommu_hwpt_default, max_addr);
+		break;
+	default:
 		return ERR_PTR(-EINVAL);
+	}
 
 	if (user_data) {
 		int rc = iommu_copy_user_data(&data, user_data,
-					      sizeof(data), min_len);
+					      data_len, min_len);
 		if (rc)
 			return ERR_PTR(rc);
-		/* Expecting test program to pass hwpt_type in test data too */
-		if (data.test_type != hwpt_type)
-			return ERR_PTR(rc);
 		user_cfg = &data;
 	}
 
-	return __mock_domain_alloc(iommu_domain_type, user_cfg);
+	return alloc_fn(iommu_domain_type, user_cfg);
 }
 
 static void mock_domain_free(struct iommu_domain *domain)
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 7eb7b88459bd..2cbe47c80c09 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -274,20 +274,31 @@ TEST_F(iommufd_ioas, ioas_destroy)
 TEST_F(iommufd_ioas, hwpt_alloc)
 {
 	const uint32_t min_data_len =
-		offsetofend(struct iommu_hwpt_selftest, test_type);
-	struct iommu_hwpt_selftest data = {
+		offsetofend(struct iommu_hwpt_default, max_addr);
+	struct iommu_hwpt_default data = {
 		.flags = 0,
-		.test_type = IOMMU_HWPT_TYPE_SELFTEST,
 	};
 	uint32_t new_hwpt_id[2] = {};
 
 	if (self->stdev_id && self->device_id) {
 		test_cmd_hwpt_alloc(self->device_id,
 				    self->ioas_id, &new_hwpt_id[0]);
+		/* Try alloc_user w/o data */
+		test_err_cmd_hwpt_alloc_user(EINVAL,
+					     self->device_id, self->ioas_id,
+					     &new_hwpt_id[1],
+					     IOMMU_HWPT_TYPE_DEFAULT,
+					     0, &data);
+		test_err_cmd_hwpt_alloc_user(EINVAL,
+					     self->device_id, self->ioas_id,
+					     &new_hwpt_id[1],
+					     IOMMU_HWPT_TYPE_DEFAULT,
+					     min_data_len, NULL);
 		test_cmd_hwpt_alloc_user(self->device_id, self->ioas_id,
 					 &new_hwpt_id[1],
-					 IOMMU_HWPT_TYPE_SELFTEST,
-					 min_data_len, &data);
+					 IOMMU_HWPT_TYPE_DEFAULT, 0, NULL);
+
+		/* Replace the auto domain with new_hwpt_id[0] */
 		test_cmd_mock_domain_replace(self->stdev_id, new_hwpt_id[0]);
 		/* hw_pagetable cannot be freed if a device is attached to it */
 		EXPECT_ERRNO(EBUSY,
@@ -302,6 +313,25 @@ TEST_F(iommufd_ioas, hwpt_alloc)
 		/* Detach from the new hw_pagetable[1] and try again */
 		test_cmd_mock_domain_replace(self->stdev_id, self->ioas_id);
 		test_ioctl_destroy(new_hwpt_id[1]);
+
+		/* Try alloc_user with data */
+		data.max_addr = MOCK_APERTURE_START - 1;
+		test_err_cmd_hwpt_alloc_user(EINVAL,
+					     self->device_id, self->ioas_id,
+					     &new_hwpt_id[1],
+					     IOMMU_HWPT_TYPE_DEFAULT,
+					     min_data_len, &data);
+		data.max_addr = (uint64_t)MOCK_APERTURE_LAST + 1;
+		test_err_cmd_hwpt_alloc_user(EINVAL,
+					     self->device_id, self->ioas_id,
+					     &new_hwpt_id[1],
+					     IOMMU_HWPT_TYPE_DEFAULT,
+					     min_data_len, &data);
+		data.max_addr = MOCK_APERTURE_LAST;
+		test_cmd_hwpt_alloc_user(self->device_id, self->ioas_id,
+					 &new_hwpt_id[1],
+					 IOMMU_HWPT_TYPE_DEFAULT,
+					 min_data_len, &data);
 	} else {
 		test_err_cmd_hwpt_alloc(ENOENT,
 					self->device_id, self->ioas_id,
@@ -309,7 +339,7 @@ TEST_F(iommufd_ioas, hwpt_alloc)
 		test_err_cmd_hwpt_alloc_user(ENOENT,
 					     self->device_id, self->ioas_id,
 					     &new_hwpt_id[1],
-					     IOMMU_HWPT_TYPE_SELFTEST,
+					     IOMMU_HWPT_TYPE_DEFAULT,
 					     min_data_len, &data);
 		test_err_mock_domain_replace(ENOENT,
 					     self->stdev_id, new_hwpt_id[0]);

--qk/r+jMfsH0Su+MX--
