Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9E9702F13
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 16:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjEOOA4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 10:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239190AbjEOOAw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 10:00:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC9D1FEF;
        Mon, 15 May 2023 07:00:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luJv3Fc7odhUcNduwKtIIrgwDWBwY549CIjnqBASQYh7snA537J5jpXG6dVOjGj8jm4MgqnLwe82XPG3Y1p/TeN9RUdroe96+ud1nNhkNBw0u3uUGfUoPEbLeVbxGkj4/IaAljojqK13GiboguVmNUfy6F+9XOaqeI98Pj04Spmt9JbsLvIESCVAJUoowcWsNaAAXw/riRR+kx/czCX4uxRgCpx/QyaY/p+QfYzWPwB7qQKB5dkfosKsVae9HZ0WwrWolCawCh435LNp3GIN1fvNCUPmmsWHmolKddq7MnJwbdTkiy2AuwZmhV1A/V2jnqIsuI7pSwZNTJfeJWXFVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XgUbFRY27InvAmgEBV0QhGff6QULREd4Ad0orCIt9vw=;
 b=C6Iwd8sYJpxQJwUQAFWqih/otei8lIkrgwyRWztOl2k9JJsfOMjknvTnzmw8hBAaWgCMt8aSk9/7u+RAgvxOjSJ/GMu1TSwC99EjIgIIJl8dNQvpJ6RRgTdABMTOA0iNxvXsTwTkC5j49o9DiL91EzEgQBGgMkGqUano/INtPX5RiY7alTAXDsJV4gwof8rDkUE56nY+QL+m6nq64yvVo81vScihCyq675Cff7XqbuYJD1B79CqZck8wjMUUr0eY4UZUC2KzDYlQ3EaPVXQXQSyVVQgccihbUF25k6tzaY6lQTAo/fuQaXGdLsuQkKT184dRIprBGNs2aqZlMF7qfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgUbFRY27InvAmgEBV0QhGff6QULREd4Ad0orCIt9vw=;
 b=lR8edFSZ2yk+bZ5aH845/b1aGdGQrBHQY7pQ0eosM21d1FSjxtjknKmijiZASPc43R7ZgWeRkKfG87GH4qOlnzkNukIML5ZGmSHkvRbpdzjikWN77eGYnaN0USlOeRGdZad5CpvyrPiUZULAVIEiJsw0oy7WKLsDxhuy9YWTwC21mUwGN74X7ML3GtH6adJCi2va2XvL28g+I49x01RZx4MG/mBh8eyQN2wV9RsIFeB0mxqZ7YakLVqMkUAM/xdA9XLNGCFdborX4F6ScMtSHAyF35qtD7y14YOawUW2H5PjHyKgFjTbvXdWoZuJZ3xlQA15377DuclqRBzzQIFXLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7954.namprd12.prod.outlook.com (2603:10b6:806:344::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 14:00:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 14:00:43 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     iommu@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
        Lixiao Yang <lixiao.yang@intel.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: [PATCH v7 18/19] iommufd/selftest: Return the real idev id from selftest mock_domain
Date:   Mon, 15 May 2023 11:00:33 -0300
Message-Id: <18-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
In-Reply-To: <0-v7-6c0fd698eda2+5e3-iommufd_alloc_jgg@nvidia.com>
References: 
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF00013DF8.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:b) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7954:EE_
X-MS-Office365-Filtering-Correlation-Id: 65115970-1ad3-43bb-bc2b-08db554cc210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8JeFpLUmf0yACbqYAuQxGE/IHEAHHukuFeICpVG99fdL4kljAO5wYE8TRHb5FWqNgBYtRQteDv1zAKmVumPIh8i74lFnHjU+umSpmb8o4kS4qR74LT621dE/Zi6kiWm+lqLkWSKwacw0cKWWzSweRuzz0saklTOsWyIDlUmxRk96uuDvED7W2ezMw/8wodCWTGYrFwoSS2FEzCTkgXryzCLHGKC3cxzEwh/pXm4geafgRcnESu9H3EcKlTpfh9Hbq5/XJwedG+F6udY/vMOXXWE2L/9v9JejO9qhaevVor32KM21lOzwt6xpZ9p1wKth9vhL7aRrXu0mdhKq6sw+J309Iwt2kQKekv/UtudO479N4WJLjDSOM1PWqOElJKUqgWN/vL3ePnKarOEzEWxzvi6hkRVQk+pHw6uabI0LYhmBjDBVR//zlemoVa0SsMEgO69x3r8K7t+HUdt0QxokThsvsSD2W69kR82jM/sghxfVcO9yiwelsqL9Rh3gHPbFgthjhHgCsH5PkbftMV1GSwXahimluHe7ThZl1jyD44T6QcUAbxjKA/0BPw4VJWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(83380400001)(66476007)(66556008)(66946007)(2616005)(6486002)(26005)(6506007)(6512007)(478600001)(54906003)(6666004)(186003)(5660300002)(86362001)(8676002)(8936002)(36756003)(2906002)(316002)(4326008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Im++Mf1PWnJXDLFi0JRdALbFa8FG8KeMbVPdDX+VoLDcocFNng6fcrwdS5Jq?=
 =?us-ascii?Q?FKZBxRfM3KICUrIL1wHDuPLPVmqjCpiF4J4W8LcVdDSwz3502flaJgVQJIh6?=
 =?us-ascii?Q?VCHpryX2DvmHQ2RBESmJ8nrhBXNKLXIZygNBIJWqGj757f4BcCDCePeCS0aN?=
 =?us-ascii?Q?h+W6DR7MIr+/zlj05u0nY7ahZoh3dZ/SbK0o9ClnriKsRLj+zzllC0xHmmeV?=
 =?us-ascii?Q?fBXHnt63OV5Ddzdb0QRg/ZUa2Yn8Jx9/86ZdJfAOJQavxfIplO1NuzwRHn/W?=
 =?us-ascii?Q?VueIJdQ5JbWR8B/4B/nPop6V95RLAluL0iug0IIY/1MkHwTwv1z3uVbQtV/x?=
 =?us-ascii?Q?FoeDdViBCCNUer+wXGkejJM1Nd2ejuL/dKDq1d+PuTrr/iPBALz35SxBw2an?=
 =?us-ascii?Q?kr5UFvhLPSYrYXLuVPMCxzAG+hkl/OwWGF7TXl3FQioEpKkk9LYxg+DJvF/z?=
 =?us-ascii?Q?9xJYxt3PadHY9GE66MCgkkTsbt4RJfv8HnQYc91nXVoz7TPKRU3c5AN8rTDC?=
 =?us-ascii?Q?TVIXiuiLXcutvPfS04fAYdsTfthDXpzg4CIgrFvt/v1N6TizZk0+KvncI5MD?=
 =?us-ascii?Q?wXFEWwcz+NfCX5TAU9wSSxvdonJFaiwFEyn6LFnAqwfQciMjYPb+MNcSyNRn?=
 =?us-ascii?Q?nzkLyZJQaUgNX79EHUalCQKOMFKF/MEt1JnxipYFgLT9p80ait2y+IneFO2I?=
 =?us-ascii?Q?Ut5uYopmLlvYjBCwbCc/QqDlr+HnJe4NL3DrPryPxyIK9Fx96yjw9ShCYTWD?=
 =?us-ascii?Q?VefBxb2xkM4YRtDVsgfezNYqWirr7RKdJPoBoveOk9wlCcvn6B5Wr2Ta+yYI?=
 =?us-ascii?Q?C2iQMwX2Rt2rLyArpP0G6wH4zQ6q93eXQ/gNIRg6TIWqBPJEb6j9GG7FuDu8?=
 =?us-ascii?Q?j7lzoWLo/rKQa5rdghCvEfnoKmFTSxdJ664G/wQwSbs/yMkj1B5Yg2iZthW5?=
 =?us-ascii?Q?A9wxBGXXDH+GSA/ktNmhswJXb0arqV32wmQF/IXYLC1SepXTscBxlxfFqdSm?=
 =?us-ascii?Q?4tVkQKjqQzzKMVrQcGBU3nhCZDoqopNswws0TQmeFi6o/PqT3EnzPXQk6wRL?=
 =?us-ascii?Q?5d9mIqB//g4ZE9tivN3dKpfyfLgRyFThcVkGwpzb6tCCcmakwCrIApjYhbEX?=
 =?us-ascii?Q?7N2mQvrWrPwfYUubKJCeCBVPk8mZCTJKT1/T6ihImDAZ6Lq+n7nHptnsWGLu?=
 =?us-ascii?Q?VbaYzimhegkoHaRC0qanAbB/O6AvRUpkVcRHmrs2wYDj71+XKHExqSl/56be?=
 =?us-ascii?Q?d+boBurh2swQKPFwjTgNsDbYKDfckI/tgtu4bTah7abdbAWO8ULCjLpQggDb?=
 =?us-ascii?Q?h30iwNjJPJ++u+l9Ri+xtERogtFR1s0F8e5Cj2SbHvKZXJ+CAz0FUNOIOlDr?=
 =?us-ascii?Q?qmu1cO5ThGOk4lR9OdlkslWXo2cJyXF8+pxFpJFuR6zJYhERfbhBdOmTng/i?=
 =?us-ascii?Q?O2B2EfsHlnqFWLz0Bv7/CwOtCVEK4sSROU5uVTQukQe3CZIehmBCZu58t6M7?=
 =?us-ascii?Q?3qBS51JHZhiMCxt6vBhKSoAndgtlaTTeRshcph+R9DBzAzlKxktAy//1AJpo?=
 =?us-ascii?Q?liqugztvnDJrF/l/QICtQbfTo+jp6c/ggGHWys8u?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65115970-1ad3-43bb-bc2b-08db554cc210
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 14:00:37.1300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pv7Ar9Oo3R2i8klnZUkB0Wj5+GgWhF7go/oBYqxckxG6NwM6F2L710qW7fEI7UE8
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

Now that we actually call iommufd_device_bind() we can return the
idev_id from that function to userspace for use in other APIs.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/iommufd/iommufd_test.h           |  2 ++
 drivers/iommu/iommufd/selftest.c               |  1 +
 tools/testing/selftests/iommu/iommufd.c        | 17 +++++++++--------
 .../testing/selftests/iommu/iommufd_fail_nth.c | 18 ++++++++++--------
 tools/testing/selftests/iommu/iommufd_utils.h  | 12 +++++++-----
 5 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
index e3f1035cbd6464..dd9168a20ddf4c 100644
--- a/drivers/iommu/iommufd/iommufd_test.h
+++ b/drivers/iommu/iommufd/iommufd_test.h
@@ -52,6 +52,8 @@ struct iommu_test_cmd {
 		struct {
 			__u32 out_stdev_id;
 			__u32 out_hwpt_id;
+			/* out_idev_id is the standard iommufd_bind object */
+			__u32 out_idev_id;
 		} mock_domain;
 		struct {
 			__u32 pt_id;
diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
index eb33dffb955dcf..9d43334e4faf16 100644
--- a/drivers/iommu/iommufd/selftest.c
+++ b/drivers/iommu/iommufd/selftest.c
@@ -443,6 +443,7 @@ static int iommufd_test_mock_domain(struct iommufd_ucmd *ucmd,
 	/* Userspace must destroy the device_id to destroy the object */
 	cmd->mock_domain.out_hwpt_id = pt_id;
 	cmd->mock_domain.out_stdev_id = sobj->obj.id;
+	cmd->mock_domain.out_idev_id = idev_id;
 	iommufd_object_finalize(ucmd->ictx, &sobj->obj);
 	return iommufd_ucmd_respond(ucmd, sizeof(*cmd));
 
diff --git a/tools/testing/selftests/iommu/iommufd.c b/tools/testing/selftests/iommu/iommufd.c
index 96881ecca5c757..78841aba47d038 100644
--- a/tools/testing/selftests/iommu/iommufd.c
+++ b/tools/testing/selftests/iommu/iommufd.c
@@ -211,7 +211,7 @@ FIXTURE_SETUP(iommufd_ioas)
 
 	for (i = 0; i != variant->mock_domains; i++) {
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_id,
-				     &self->hwpt_id);
+				     &self->hwpt_id, NULL);
 		self->base_iova = MOCK_APERTURE_START;
 	}
 }
@@ -262,7 +262,7 @@ TEST_F(iommufd_ioas, hwpt_attach)
 {
 	/* Create a device attached directly to a hwpt */
 	if (self->stdev_id) {
-		test_cmd_mock_domain(self->hwpt_id, NULL, NULL);
+		test_cmd_mock_domain(self->hwpt_id, NULL, NULL, NULL);
 	} else {
 		test_err_mock_domain(ENOENT, self->hwpt_id, NULL, NULL);
 	}
@@ -681,7 +681,7 @@ TEST_F(iommufd_ioas, access_pin)
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_ACCESS_PAGES),
 				   &access_cmd));
 		test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-				     &mock_hwpt_id);
+				     &mock_hwpt_id, NULL);
 		check_map_cmd.id = mock_hwpt_id;
 		ASSERT_EQ(0, ioctl(self->fd,
 				   _IOMMU_TEST_CMD(IOMMU_TEST_OP_MD_CHECK_MAP),
@@ -836,7 +836,7 @@ TEST_F(iommufd_ioas, fork_gone)
 		 * If a domain already existed then everything was pinned within
 		 * the fork, so this copies from one domain to another.
 		 */
-		test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+		test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 		check_access_rw(_metadata, self->fd, access_id,
 				MOCK_APERTURE_START, 0);
 
@@ -885,7 +885,7 @@ TEST_F(iommufd_ioas, fork_present)
 	ASSERT_EQ(8, read(efd, &tmp, sizeof(tmp)));
 
 	/* Read pages from the remote process */
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 	check_access_rw(_metadata, self->fd, access_id, MOCK_APERTURE_START, 0);
 
 	ASSERT_EQ(0, close(pipefds[1]));
@@ -1033,6 +1033,7 @@ FIXTURE(iommufd_mock_domain)
 	uint32_t hwpt_id;
 	uint32_t hwpt_ids[2];
 	uint32_t stdev_ids[2];
+	uint32_t idev_ids[2];
 	int mmap_flags;
 	size_t mmap_buf_size;
 };
@@ -1055,7 +1056,7 @@ FIXTURE_SETUP(iommufd_mock_domain)
 
 	for (i = 0; i != variant->mock_domains; i++)
 		test_cmd_mock_domain(self->ioas_id, &self->stdev_ids[i],
-				     &self->hwpt_ids[i]);
+				     &self->hwpt_ids[i], &self->idev_ids[i]);
 	self->hwpt_id = self->hwpt_ids[0];
 
 	self->mmap_flags = MAP_SHARED | MAP_ANONYMOUS;
@@ -1249,7 +1250,7 @@ TEST_F(iommufd_mock_domain, all_aligns_copy)
 			/* Add and destroy a domain while the area exists */
 			old_id = self->hwpt_ids[1];
 			test_cmd_mock_domain(self->ioas_id, &mock_stdev_id,
-					     &self->hwpt_ids[1]);
+					     &self->hwpt_ids[1], NULL);
 
 			check_mock_iova(buf + start, iova, length);
 			check_refs(buf + start / PAGE_SIZE * PAGE_SIZE,
@@ -1458,7 +1459,7 @@ FIXTURE_SETUP(vfio_compat_mock_domain)
 
 	/* Create what VFIO would consider a group */
 	test_ioctl_ioas_alloc(&self->ioas_id);
-	test_cmd_mock_domain(self->ioas_id, NULL, NULL);
+	test_cmd_mock_domain(self->ioas_id, NULL, NULL, NULL);
 
 	/* Attach it to the vfio compat */
 	vfio_ioas_cmd.ioas_id = self->ioas_id;
diff --git a/tools/testing/selftests/iommu/iommufd_fail_nth.c b/tools/testing/selftests/iommu/iommufd_fail_nth.c
index 96fb2f04623f23..8ab20df4edc8c7 100644
--- a/tools/testing/selftests/iommu/iommufd_fail_nth.c
+++ b/tools/testing/selftests/iommu/iommufd_fail_nth.c
@@ -315,7 +315,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -326,7 +326,7 @@ TEST_FAIL_NTH(basic_fail_nth, map_domain)
 	if (_test_ioctl_destroy(self->fd, stdev_id))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 	return 0;
 }
@@ -350,12 +350,13 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, 262144, &iova,
@@ -369,9 +370,10 @@ TEST_FAIL_NTH(basic_fail_nth, map_two_domains)
 	if (_test_ioctl_destroy(self->fd, stdev_id2))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id2, &hwpt_id2,
+				  NULL))
 		return -1;
 	return 0;
 }
@@ -528,7 +530,7 @@ TEST_FAIL_NTH(basic_fail_nth, access_pin_domain)
 	if (_test_ioctl_set_temp_memory_limit(self->fd, 32))
 		return -1;
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, &hwpt_id, NULL))
 		return -1;
 
 	if (_test_ioctl_ioas_map(self->fd, ioas_id, buffer, BUFFER_SIZE, &iova,
@@ -603,7 +605,7 @@ TEST_FAIL_NTH(basic_fail_nth, device)
 
 	fail_nth_enable();
 
-	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL))
+	if (_test_cmd_mock_domain(self->fd, ioas_id, &stdev_id, NULL, NULL))
 		return -1;
 
 	if (_test_cmd_mock_domain_replace(self->fd, stdev_id, ioas_id2, NULL))
diff --git a/tools/testing/selftests/iommu/iommufd_utils.h b/tools/testing/selftests/iommu/iommufd_utils.h
index 8b11bb70095269..62e01412a7679e 100644
--- a/tools/testing/selftests/iommu/iommufd_utils.h
+++ b/tools/testing/selftests/iommu/iommufd_utils.h
@@ -41,7 +41,7 @@ static unsigned long PAGE_SIZE;
 	})
 
 static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
-				 __u32 *hwpt_id)
+				 __u32 *hwpt_id, __u32 *idev_id)
 {
 	struct iommu_test_cmd cmd = {
 		.size = sizeof(cmd),
@@ -59,14 +59,16 @@ static int _test_cmd_mock_domain(int fd, unsigned int ioas_id, __u32 *stdev_id,
 	assert(cmd.id != 0);
 	if (hwpt_id)
 		*hwpt_id = cmd.mock_domain.out_hwpt_id;
+	if (idev_id)
+		*idev_id = cmd.mock_domain.out_idev_id;
 	return 0;
 }
-#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id) \
-	ASSERT_EQ(0,                                     \
-		  _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, hwpt_id))
+#define test_cmd_mock_domain(ioas_id, stdev_id, hwpt_id, idev_id)       \
+	ASSERT_EQ(0, _test_cmd_mock_domain(self->fd, ioas_id, stdev_id, \
+					   hwpt_id, idev_id))
 #define test_err_mock_domain(_errno, ioas_id, stdev_id, hwpt_id)      \
 	EXPECT_ERRNO(_errno, _test_cmd_mock_domain(self->fd, ioas_id, \
-						   stdev_id, hwpt_id))
+						   stdev_id, hwpt_id, NULL))
 
 static int _test_cmd_mock_domain_replace(int fd, __u32 stdev_id, __u32 pt_id,
 					 __u32 *hwpt_id)
-- 
2.40.1

