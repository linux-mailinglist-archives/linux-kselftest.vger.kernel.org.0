Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81124780032
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 23:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355455AbjHQVzU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355543AbjHQVzO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 17:55:14 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B92D4A;
        Thu, 17 Aug 2023 14:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOHzxmKLksG98zGLjIXmALGEDTELooRicBY5ul8Qc8wYrpHfTZc8eQwJYAhV0PNvFiM1E3wUIhYoKzvnbgfq4EQnN7O5Fn94R1Mdkoy5T99Rnir0DV7iLleSVHJX2KkbPTiPFmPlSZcj4xaqEVzEGi7Rr4ULWWtElKbR/TrzaV7k24dWZJXSrdls97t+SyJd45Lzs8BmHQanD0nH1lJMe65soBJLt4uGj/aOsRU/bvw1ti/INLjQDa/izxyBjZkWzaj2T2FP7/aPLyHVtjdGM4+mMsP18dntTWXZN/jIGcMVHyI+moFvWqMNf3UuVkCqsrjrd490t1xV00U/QXQo0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBYQDubj1FXXH5CJGqohQFnaWSsNbmZINvslExYLIQo=;
 b=jzVPd16RnZHuxdFiv154h22Ez3Yviutnm0KLeJSzL1ZqRvG6psb2wFmrWIBA9vwvXkpbt9SveCgZo8jYsdOmcIvkEHKVNyQgcLt6iI2SLzWKUXIgcjoUw0n7oRf+I8v2DI7imdRB14VWvajWOPU/Bl9TAzfWkKcXW/YWAhxI7APUihszIL4zRH67rSEiLqm3jhvut4PuBaW939K5auVtmdBqcuDqLegcHbbAMBVciQ8MNJN620EdZVHtAh0uXpfpbDRjOFM1zjK1RR3kfM8qLlZjVRHHgLCWWQJOZD2kKs7J+vLnlGwQxwQOpxZe6tZ16pLVmkXzGZxXA2vYURqENg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBYQDubj1FXXH5CJGqohQFnaWSsNbmZINvslExYLIQo=;
 b=Y8O73IdpmzQfBrfRU1aJhFwfPOE1ne49PinfRaL8dwVdXZZgAYPD3AtXUCn2WmSjVN6NQwUwRcsljQ8zPKZOvqeJ2l/m/OFB+JnNt8ZtviC1ZZO9I4gtHrs5m8CTG/K4pDMqIp5l3T0yOXsjhXfhx5Cdjzd8u5TwBm5LaRDziMBNakzNhmXT3UAIY6ZoAihqzY0gdwFi2VSrlB9kZlUVsgr0cu4K1FkRdsoQI1AiHZjSf3MGjDyPtOTST9CaMuYNiGbMdESGlU8I4DylbLnw0Zx8bjeOQsaO/q+uf6NovJBoFGbvd3ghpy1qclExBYhAGbZDqVGvkidnof384u7ilQ==
Received: from CH0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:610:119::22)
 by DM4PR12MB6158.namprd12.prod.outlook.com (2603:10b6:8:a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 21:55:11 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::7b) by CH0PR03CA0369.outlook.office365.com
 (2603:10b6:610:119::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Thu, 17 Aug 2023 21:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 21:55:10 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 14:54:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 14:54:59 -0700
Received: from Asurada-Nvidia (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Thu, 17 Aug 2023 14:54:57 -0700
Date:   Thu, 17 Aug 2023 14:54:55 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
Subject: Re: [PATCH v8 4/5] iommufd/selftest: Add coverage for
 IOMMU_GET_HW_INFO ioctl
Message-ID: <ZN6XL0fCldlPJzoX@Asurada-Nvidia>
References: <20230816121349.104436-1-yi.l.liu@intel.com>
 <20230816121349.104436-5-yi.l.liu@intel.com>
 <BN9PR11MB527613651F0A023EED967BA18C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527613651F0A023EED967BA18C1AA@BN9PR11MB5276.namprd11.prod.outlook.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|DM4PR12MB6158:EE_
X-MS-Office365-Filtering-Correlation-Id: 52d899f2-a63d-42cf-18b7-08db9f6ca0e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ky94uvqjAB3HQV2JPeK7lGk2+1+oN8SDCapAC/WQHCM55r/wJrVhF6cxrD9gKGpY7GSEncBWRGb2Ir++kUlkJ1iOKdhLv4W6xZIY9wFHp0BKFAvBvW5fG6UAvjcQQjac4Uuh9Wdj8XzN1AoNdmdCXzRlFQrln66D8te7HKLeyewliyALsFTkO+iEkAO0ZB5SYNXt9/8ogAoBoBuCwQoka7nEsBGbogwUH+iSiyr/W5cHmcbXeJMYvt10z5huwFnMSlzsKYmZeRR4WjFZuzx+4Wi5TR5axJK/vnQZvP8d+cfglQWX2iNqChy5JC2Qa/4y53Z7jNjvJf0qciD8i9Q0ob54J1METp48x9mQLmyy1M3cb6hs4UDC/w5+IvEGXP+3KdbhVulc6kcYnjK3RknkMzECLQBRaLDek6DP0JcZnRmh9iSLytFifekDJniFxTEtrcD576yriN6GMSjY9VZCPUc9wtG6GIfrBMnBwRMXbGTy3haOf9xwkkRQLKGGl8lYRhzc/QJHCCJTIlLkqRLyi+nXeYzrlfa63vpfPjniex0TezoBeoS1wlK8QV6Bk5GDnzR66+aVxQaXxXFgQe7sOOSTroxKNJxpFCBU8zJJdf69nDp4GmeS3M0+m3Fxxd9qmLTl2RzqoZZAlkbVFioAsF9rUBq5/y8jIV7EYB5vo8puPWwT2G6s4QzFYHx3mFWmht71icxLUdOJxa3HWAnS2RX3rM0M08ibDO8KfHlvNWhflVy50rvpdKw65nTSYZXp
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(186009)(451199024)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(83380400001)(26005)(86362001)(7416002)(336012)(478600001)(40480700001)(426003)(9686003)(55016003)(5660300002)(36860700001)(41300700001)(82740400003)(356005)(54906003)(7636003)(316002)(70586007)(70206006)(6916009)(8676002)(4326008)(8936002)(33716001)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 21:55:10.6409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d899f2-a63d-42cf-18b7-08db9f6ca0e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6158
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Aug 17, 2023 at 07:32:52AM +0000, Tian, Kevin wrote:
> > +TEST_F(iommufd_ioas, get_hw_info)
> > +{
> > +     struct iommu_test_hw_info buffer_exact;
> > +     struct iommu_test_hw_info_buffer {
> > +             struct iommu_test_hw_info info;
> > +             uint64_t trailing_bytes;
> > +     } buffer_larger;
> > +
> > +     if (self->device_id) {
> > +             /* Provide a zero-size user_buffer */
> > +             test_cmd_get_hw_info(self->device_id, NULL, 0);
> > +             /* Provide a user_buffer with exact size */
> > +             test_cmd_get_hw_info(self->device_id, &buffer_exact,
> > sizeof(buffer_exact));
> > +             /*
> > +              * Provide a user_buffer with size larger than the exact size to
> > check if
> > +              * kernel zero the trailing bytes.
> > +              */
> > +             test_cmd_get_hw_info(self->device_id, &buffer_larger,
> > sizeof(buffer_larger));
> 
> Do we also want to test a case where size is smaller than the exact size?

Added one with the following diff:

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
