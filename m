Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF3B96A2584
	for <lists+linux-kselftest@lfdr.de>; Sat, 25 Feb 2023 01:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjBYA2L (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Feb 2023 19:28:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjBYA2K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Feb 2023 19:28:10 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0EF5B96;
        Fri, 24 Feb 2023 16:28:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8DioV139lw5wAsgLnVNiUC1doSjmgIWdJurdvAtO4GitstaJcpAMS6aVDBVEaOcHtpMe3PfA3vDzbxO38YHBmHN015Nf5N4Liw/mB33dZuQuBD036iR1Zs7yJBGVvFenuCawPXkY9+1YFHBwoRW45ZkuEz31xdtlOXEBQ4Ni7jPqeddHyIhSog1ZX52dCldSYPYfs/u2BntOl4l0fO+CR2aqAQdLVT6I1FCQKhi/9kSSz4NPtguXa4lWlY3fT6v4RW29j0E1XJAurDU4S+8tB/KE8jD+AEJcrJ/ongq8hRlMFq5M0Da+sZMAjOPC8qXGQGDGjGMPjJwd1GeH6x0wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzAwhhrKn3w0dk9EHUJLUTC4ccWseV42hXhYzMtlCvQ=;
 b=Uw7ILcN2ddsTVtjTasTKzT67smCR2Da3SITOlkmk08dxytlooOksvZYbFzqVPT3ln6onhSrH3XkiLNYouwdH1V1GB43jzKbUZrDve477/qZXHdBcVEt54gnBMTbcabkAX820W8GW62YTBYPjtps1jvVae9PQSJlIo0NnhfsKfstJYbUU2wjIIjPKH6Z7DXr2vJIA+kP4/GZglPu4rwJUjlcqSP3L/IHZWV3sNdk4UzbS7268BqdkmOhAyVmf9a5ZD+SRhERVKqM0QttfAeIkXztuhmmD/9lTU4ylra5p1febwZjHOJOnciVI8bRfQIc1vJR/ykX/dN2Bpq4o5HMo5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzAwhhrKn3w0dk9EHUJLUTC4ccWseV42hXhYzMtlCvQ=;
 b=sS7kjzWkFuX23RSxwrf1f/LqGHOQUJbT+Zk2trvzsEj3MDdwbg7FYjFeuH9Uu09rrCZIm77oBej20eZ2JYAvGABLD93b5fAmvM/vw0rkafgdVIv/pkJbbIqbETr5XgsnUdI2FpVmR3gwJJSMQU9v1BWo3oVu9JXU7OWrZ27KEbH1fJESvX6UOEBUfTBXxGaLncilBtuGFMxwaRUrmIKk1I1mAVT1IqTRhOKWEn/Cy6CllSmSraO5ApeGO6TumpVXB4uTUJMYXxYUG4oA1dS5p/6Niw1ADLSMjnoSUgJekCxVscOY78o6Dl+qHJ3P2zLJPhm8D628fqCbi1aRObngEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS7PR12MB6096.namprd12.prod.outlook.com (2603:10b6:8:9b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6134.21; Sat, 25 Feb 2023 00:28:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3cb3:2fce:5c8f:82ee%4]) with mapi id 15.20.6134.021; Sat, 25 Feb 2023
 00:28:03 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>,
        Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH 11/14] iommufd/selftest: Test iommufd_device_replace()
Date:   Fri, 24 Feb 2023 20:27:56 -0400
Message-Id: <11-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v1-7612f88c19f5+2f21-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0150.namprd03.prod.outlook.com
 (2603:10b6:208:32e::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS7PR12MB6096:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c2b6316-6a2c-4550-c8d0-08db16c72707
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2AaO6WDLmwdec4ZDnPEmv3e9gkhkb/umMangZR+UjmntverOESX0SiIutMBmwXfjPHVOoAoOU+3Wm2Ef6G08UVKL1MAN5mlV2CpjkQAkB31swQqqv6DqVjzHLgM27nIZTxzI61hUXsHGt+s6oR0/ySavYBoFaWrQ+kBBeCLa4BgbQJSyJYkTl2sII1QwEEr2IvGg3WsjYWdthQirCFzwgtporgsKaZorYXhoLWOPPnTH/2YNidOwNLMlJmfGSfO6Bt7JH3fhtlkyHGXtKxSdKrbxoqFV+wAhb/kA6OvEev4Qz+HMh4VUGfgNG5VhhA6fEpj/5KeIJSyTP5aGfUR+I+lPwZr8f9iIL8bDLrGHbDdLpiv6cXdyulM4N10m/pFYWlEELg9CMCDndvloyzzc751MVHjvxyt50Zu7NS+PFPDZH3CfDPd9KP8CJ748fNzknVHm+HcxTzvN4S9+hBwisr+yWS7ZmschKFmYK16KElO4q5w6bfC4m/r8ZnfYZpJCZRetxyilfkSD1qxrs7ncvk4a7oy4djGU7PgSFDf6ztYF2C++G9KKpbfPN1dqbsDlGrqi8yB8bbpPUQTtfSx3j7nUEuu8lbxMxMS55pgOC4/VmjFO8+zaqmKo6p47iLVv54RHlfXYDke2OIAwjWXZtQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199018)(2616005)(41300700001)(83380400001)(5660300002)(54906003)(478600001)(8936002)(4326008)(38100700002)(26005)(186003)(86362001)(8676002)(66946007)(6506007)(6512007)(66556008)(316002)(66476007)(36756003)(66899018)(6486002)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VHO0xjNeTsTrSPuGjVliCYAGmkq2otY/WK5OtfnuhPHZZa4/aFzMZewdNooS?=
 =?us-ascii?Q?/dHVBMu4HhjhPee3YLXh6vvjkExGbC+si6wM8ogkjYQbCYACgMPjsgLzKwOm?=
 =?us-ascii?Q?qnevfQOblSLSwjjOzY3xSg/YVVG83UoJCaL7sKnyrLTZSZu5aYle/E7ANM8d?=
 =?us-ascii?Q?mMg15TKVxPjHvTIrhkhncJHFZdF8tX16uCBGu0azOtx5yxmqQqKMVJc0XJMg?=
 =?us-ascii?Q?N+vXppApFDgIRB2QsN4XYnvnrSFdqdmgzwUGnMVaVuWFo4wstONyk3VGgiNX?=
 =?us-ascii?Q?rnm7TLQcwH3SWtnYVxCK29kEDqvDcmsdolnS5xGT0W0cXAQXFfiBZcsg3jXg?=
 =?us-ascii?Q?jPMJU0C5UYrr7vO8ptcdqS2XEj9aCS/Jsob8ag5ZVjnosqNSkeMfO+eHlGwY?=
 =?us-ascii?Q?uT4dhfdQLpH7PK/nHzwyS8pstgD/Irw7w+foYhb60nhzOv0E5F7P4utTZa1t?=
 =?us-ascii?Q?hRawlqjEAa4zQTBEtYN01HguzO6UQDVKD70xSKYRj/CwGw+EGtCS/Lj+14nH?=
 =?us-ascii?Q?TNrLRrOSAepem5ssSNjrhTNeoYRUA+wZh//zvcikw9uA3EPS8vxN3+NIpDlI?=
 =?us-ascii?Q?lJ7BS6WyHk0ELuaet95uC0kkNV2El1tj2BwcRsKAML8xOX7aED5VRBmHi2MH?=
 =?us-ascii?Q?HCHQpo9Wyh9XbfwnH8C7Hzl/lWTMkzEfmyPgohP1DBXmIPP7HHdcQM6VSSPf?=
 =?us-ascii?Q?nMQz3YA6NeOo6mu07ogffDgKxo+UrKC6NR5QvT5CJrR2Hi/tj2n1g0UwobDd?=
 =?us-ascii?Q?S5LRFdyzz7O08IWMF4w9adv3R0WfO5H/wgyzX+xz58s6fP6Qt40uomizkhBF?=
 =?us-ascii?Q?hhaWRPytZytOzt4MT1+LknrmMqB9iCzNQsJWwRFDJSNzlt0VQfvyH+Q58EvI?=
 =?us-ascii?Q?a5s0AKwgRxpvsYfCHgcb0uygZWAoh31zuG+8q6c2mQsY6shhb9IwMq8MxVOi?=
 =?us-ascii?Q?AKXNT7gXONivfmmH5AiQ2J8b8JPWKewqusq9Zv2HcQKkkoWhTiKLnIrGzojm?=
 =?us-ascii?Q?8YwF7gB86E57MXZ2bu0CxAPYYmZI0qn1gpsz47CjdHMlkFv7Pc1eA1cS2NfA?=
 =?us-ascii?Q?KVNpWEEqhN+/8NEtDVao1d9cAxezLFKSZVbbio2ltqBJhkXsDTKBn9DTPVcL?=
 =?us-ascii?Q?ZG4NyEB6giCgYtISKbOAYxq9yVZw0DTg/AYV6Nrb2f4Yy027YLJ9JdsnHCnn?=
 =?us-ascii?Q?KSlZQGcyDKUp5ndIa1gp+q5dFEBBQJ/PB4M+SsLlMzcrPeA5hxnC3pJEb0O/?=
 =?us-ascii?Q?etLUseWuv8oFtg8BjPjdAVn4HJ/ccuzT9bHKX7i3oMtItNWXwlSMg9/fvbMt?=
 =?us-ascii?Q?K2anOAZKujuXLCSUC0EUOxWJ92bdd97XM/uwJ3ZdoqjXfxTsMSsAxqATVPoN?=
 =?us-ascii?Q?ATvs+OQoJshE/fC6fkSQf1NI91EESGSN2U1o0/ou9u7tt5vzww8rrTo1BA54?=
 =?us-ascii?Q?Mf88GZfXvkt7X8sxOOxt35aHGkNr3Y+E/uXKOsAMQM5SCYYYVu/S6ooeTECY?=
 =?us-ascii?Q?bIV3j9UDDKtt/uH0NJol/a809rBKmAdjaueSHc1sz5Ol3zQgHUEwkupHSw4/?=
 =?us-ascii?Q?7+IZp21D2Fh53B3QUk3EgQVHjyuhWghz0p+NAI0u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2b6316-6a2c-4550-c8d0-08db16c72707
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2023 00:28:01.4837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bEP1eUw0qKKT19T3fpKBfE5S2hKeuWk8ALYbgZJ4b6uMWoT2vK+ou+DN+CLp5Ujp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Nicolin Chen <nicolinc@nvidia.com>

Allow the selftest to call the function on the mock idev, add some tests
to exercise it.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Yi Liu <yi.l.liu@intel.com>
---
 drivers/iommu/iommufd/iommufd_test.h          |  4 ++
 drivers/iommu/iommufd/selftest.c              | 39 +++++++++++++++++++
 include/linux/iommufd.h                       |  1 +
 tools/testing/selftests/iommu/iommufd.c       | 34 +++++++++++++++-
 .../selftests/iommu/iommufd_fail_nth.c        | 27 +++++++++++++
 tools/testing/selftests/iommu/iommufd_utils.h | 28 +++++++++++++
 6 files changed, 132 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index 1d96a8f466fd29..c60c501775e9bb 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -17,6 +17,7 @@ enum {
 	IOMMU_TEST_OP_ACCESS_PAGES,
 	IOMMU_TEST_OP_ACCESS_RW,
 	IOMMU_TEST_OP_SET_TEMP_MEMORY_LIMIT,
+	IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
 };
 
 enum {
@@ -52,6 +53,9 @@ struct iommu_test_cmd {
 			__u32 out_device_id;
 			__u32 out_hwpt_id;
 		} mock_domain;
+		struct {
+			__u32 pt_id;
+		} mock_domain_replace;
 		struct {
 			__aligned_u64 iova;
 			__aligned_u64 length;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index 8540adcb68f1f0..701d6d6be3f06d 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -455,6 +455,42 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	return rc;
 }
 
+/* Replace the mock domain with a manually allocated hw_pagetable */
+static int iommufd_test_mock_domain_replace(struct iommufd_ucmd *ucmd,
+					    unsigned int device_id, u32 pt_id,
+					    struct iommu_test_cmd *cmd)
+{
+	struct iommufd_object *dev_obj;
+	struct selftest_obj *sobj;
+	int rc;
+
+	/*
+	 * Prefer to use the OBJ_SELFTEST because the destroy_rwsem will ensure
+	 * it doesn't race with detach, which is not allowed.
+	 */
+	dev_obj =
+		iommufd_get_object(ucmd->ictx, device_id, IOMMUFD_OBJ_SELFTEST);
+	if (IS_ERR(dev_obj))
+		return PTR_ERR(dev_obj);
+
+	sobj = container_of(dev_obj, struct selftest_obj, obj);
+	if (sobj->type != TYPE_IDEV) {
+		rc = -EINVAL;
+		goto out_dev_obj;
+	}
+
+	rc = iommufd_device_replace(sobj->idev.idev, &pt_id);
+	if (rc)
+		goto out_dev_obj;
+
+	cmd->mock_domain_replace.pt_id = pt_id;
+	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
+
+out_dev_obj:
+	iommufd_put_object(dev_obj);
+	return rc;
+}
+
 /* Add an additional reserved IOVA to the IOAS */
 static int iommufd_test_add_reserved(struct iommufd_ucmd *ucmd,
 				     unsigned int mockpt_id,
@@ -939,6 +975,9 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
 						 cmd->add_reserved.length);
 	case IOMMU_TEST_OP_MOCK_DOMAIN:
 		return iommufd_test_mock_domain(ucmd, cmd);
+	case IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE:
+		return iommufd_test_mock_domain_replace(
+			ucmd, cmd->id, cmd->mock_domain_replace.pt_id, cmd);
 	case IOMMU_TEST_OP_MD_CHECK_MAP:
 		return iommufd_test_md_check_pa(
 			ucmd, cmd->id, cmd->check_map.iova,
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index c0b5b3ac34f1e0..3044a432a83e22 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -22,6 +22,7 @@ struct iommufd_device *iommufd_device_bind(struct iommufd_ctx *ictx,
 void iommufd_device_unbind(struct iommufd_device *idev);
 
 int iommufd_device_attach(struct iommufd_device *idev, u32 *pt_id);
+int iommufd_device_replace(struct iommufd_device *idev, u32 *pt_id);
 void iommufd_device_detach(struct iommufd_device *idev);
 
 struct iommufd_access_ops {
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 91f6bcd5b8f5e9..e1252a874f0b32 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -1001,6 +1001,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t ioas_id;
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
+	uint32_t device_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1022,7 +1023,8 @@ FIXTURE_SETUP(iommufd_mock_domain)
 	ASSERT_GE(ARRAY_SIZE(self->hwpt_ids), variant->mock_domains);
 
 	for (i = 0; i != variant->mock_domains; i++)
-		test_cmd_mock_domain(self->ioas_id, NULL, &self->hwpt_ids[i]);
+		test_cmd_mock_domain(self->ioas_id, &self->device_ids[i],
+				     &self->hwpt_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1274,6 +1276,36 @@ TEST_F(iommufd_mock_domain, user_copy)
 	test_ioctl_destroy(ioas_id);
 }
 
+TEST_F(iommufd_mock_domain, replace)
+{
+	uint32_t ioas_id;
+
+	test_ioctl_ioas_alloc(&ioas_id);
+
+	test_cmd_mock_domain_replace(self->device_ids[0], ioas_id);
+
+	/*
+	 * Replacing the IOAS causes the prior HWPT to be deallocated, thus we
+	 * should get enoent when we try to use it.
+	 */
+	if (variant->mock_domains == 1)
+		test_err_mock_domain_replace(ENOENT, self->device_ids[0],
+					     self->hwpt_ids[0]);
+
+	test_cmd_mock_domain_replace(self->device_ids[0], ioas_id);
+	if (variant->mock_domains >= 2) {
+		test_cmd_mock_domain_replace(self->device_ids[0],
+					     self->hwpt_ids[1]);
+		test_cmd_mock_domain_replace(self->device_ids[0],
+					     self->hwpt_ids[1]);
+		test_cmd_mock_domain_replace(self->device_ids[0],
+					     self->hwpt_ids[0]);
+	}
+
+	test_cmd_mock_domain_replace(self->device_ids[0], self->ioas_id);
+	test_ioctl_destroy(ioas_id);
+}
+
 /* VFIO compatibility IOCTLs */
 
 TEST_F(iommufd, simple_ioctls)
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index dda8f0187cd88b..352835cfe84de0 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -569,4 +569,31 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	return 0;
 }
 
+/* device.c */
+TEST_FAIL_NTH(basic_fail_nth, device)
+{
+	uint32_t ioas_id;
+	uint32_t ioas_id2;
+	uint32_t device_id;
+
+	self->fd = open("/dev/iommu", O_RDWR);
+	if (self->fd == -1)
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id))
+		return -1;
+
+	if (_test_ioctl_ioas_alloc(self->fd, &ioas_id2))
+		return -1;
+
+	fail_nth_enable();
+
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &device_id, NULL))
+		return -1;
+
+	if (_test_cmd_mock_domain_replace(self->fd, device_id, ioas_id2, NULL))
+		return -1;
+	return 0;
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 0d1f46369c2a30..68dbb59f9a515a 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -66,6 +66,34 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *device_id,
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
 						   device_id, hwpt_id))
 
+static int _test_cmd_mock_domain_replace(int fd, __u32 device_id, __u32 pt_id,
+					 __u32 *hwpt_id)
+{
+	struct iommu_test_cmd cmd = {
+		.size = sizeof(cmd),
+		.op = IOMMU_TEST_OP_MOCK_DOMAIN_REPLACE,
+		.id = device_id,
+		.mock_domain_replace = {
+			.pt_id = pt_id,
+		},
+	};
+	int ret;
+
+	ret = ioctl(fd, IOMMU_TEST_CMD, &cmd);
+	if (ret)
+		return ret;
+	if (hwpt_id)
+		*hwpt_id = cmd.mock_domain_replace.pt_id;
+	return 0;
+}
+
+#define test_cmd_mock_domain_replace(device_id, pt_id)                         \
+	ASSERT_EQ(0, _test_cmd_mock_domain_replace(self->fd, device_id, pt_id, \
+						   NULL))
+#define test_err_mock_domain_replace(_errno, device_id, pt_id) \
+	EXPECT_ERRNO(_errno, _test_cmd_mock_domain_replace(    \
+				     self->fd, device_id, pt_id, NULL))
+
 static int _test_cmd_create_access(int fd, unsigned int ioas_id,
 				   __u32 *access_id, unsigned int flags)
 {
-- 
2.39.1

