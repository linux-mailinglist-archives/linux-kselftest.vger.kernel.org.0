Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6037238BA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbjFFHRg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 6 Jun 2023 03:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbjFFHRa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 6 Jun 2023 03:17:30 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF8F3;
        Tue,  6 Jun 2023 00:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+kkFvaQQfAfFnjmU9QBjUlKnxH4PmVLtwABKvTJWWVjqSqfrpD01q6ejcQUo6UXWnvbX5WiRGvBDOJw2E0h9qOhZ/9LtIDFj68sIpDBbp4k0xQeU25Yizf9qZ7BJm7XeI/ljfWoJazx2K45wN9nfK6jmvdNK25GOmhtYxofRNrFj7Tns3Dweoln3uGO1RU2yOCrmDgWjzjjvixwdJ8cNl1db38gaHIg5WcEOcH8l3yaQ+XNV0Hj4iXULHNCfyFQ6AijmLiFOMn2XVrJEueO21JXSJ3J8pPMfhjFv6ZyTax7d0eZH3K6ZqeA+pzx51rB+B/ReV/YpfS3qBhwHrOD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xYlalBEAxIzJMtKb5NGYNsMnsUemOvRTiXi3Wz6Od68=;
 b=PY2YKo+KGI7sDMXo/CM+jUAYd3FhVB9zzsO1+I55er6DlwNWqXF4+9iuVJ7fZzEDNs/LSlhZGE3eKpUliDufIn3p377KQmWwnqa+Z6BiVbTJ3uN+QnQO0uEbsNTAoDGftOFC2xy05ynky14b2b3Vvq+qHSo4n8S88UcRb9LBu3LoAw+J3LOLR+Whc/JR0uNilkn7y75zuj1yR2hs/WVWWD3bIWLf/ITdH9Ht0bncYUHbPtSBK26B7Qa1OuZZDzDqfI+tJmaQzBOzVCMFB5VBqbTAPG6vCBpW2VnR2dsiUBvmkObs9VUM4+ps5GQBzLyxtGatbHezBfOI4bcxuVC6Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xYlalBEAxIzJMtKb5NGYNsMnsUemOvRTiXi3Wz6Od68=;
 b=gxmuprP+hNR854TUEcopS/Zs6vkoR5wPAfC7GFrw2t4YQbcVgjvufEZxabPgZr3aokifyAVKTMS+V2ZtwkuQBibgm2KueXfTsVmdSN5k4ixBJnB2dggQPFtp34Xv/QlOKR11HmCHs+0nohNWCUUphFuUDaHrHzTJT8eUPOzmrzycOyCQPiPpN4ZIYlLbaeXjkzui/saK4mzxtJJ8ZWMUMU0Nfg07eYGhCSKzpjTxCEMFZjAOZQOos85javSt81oWvaqZkKcZJxG9P4+4bBbZrsDyKC/4EU8yw9Bvoo5PIhTPX3xT5cPidPYVtZ77nnGG15kysVdSVzOj3hR7GxSTKw==
Received: from BL1PR13CA0392.namprd13.prod.outlook.com (2603:10b6:208:2c2::7)
 by SA1PR12MB6896.namprd12.prod.outlook.com (2603:10b6:806:24f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.31; Tue, 6 Jun
 2023 07:17:25 +0000
Received: from BL02EPF000145BB.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::32) by BL1PR13CA0392.outlook.office365.com
 (2603:10b6:208:2c2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.19 via Frontend
 Transport; Tue, 6 Jun 2023 07:17:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000145BB.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6477.13 via Frontend Transport; Tue, 6 Jun 2023 07:17:24 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 6 Jun 2023
 00:17:12 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 6 Jun 2023
 00:17:11 -0700
Received: from sandstorm.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 6 Jun 2023 00:17:11 -0700
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
        "Shuah Khan" <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, <linux-mm@kvack.org>,
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 09/11] selftests/mm: move certain uffd*() routines from vm_util.c to uffd-common.c
Date:   Tue, 6 Jun 2023 00:16:35 -0700
Message-ID: <20230606071637.267103-10-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230606071637.267103-1-jhubbard@nvidia.com>
References: <20230606071637.267103-1-jhubbard@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BB:EE_|SA1PR12MB6896:EE_
X-MS-Office365-Filtering-Correlation-Id: d6cc912f-6d42-4481-133b-08db665e13fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jn3hwNpDKfecigcUffYa/EsiW/gU4RqXOC7H1z3rOLhM0KNDzQuKB7R0aghLmIQDQU0P6X86dE3NxqvkADIBvItGfzkjNZhfFufs57B3QgjjJKlOoNUyA/PtWxlCcFH+wIicwJoLRUbEUX+x1ZU87FclWl4G2WsZ1+wX1sMMuRQzwwS7AgxozAlsk0k9saCnP6JH52LfdMEh+W06UaI4nsVYuDMkDSHXJBf7ropF7Qd/ED3oqnvFHHQJdhz4x/kB2SNXnrlismsnKV9jXY3FM+faczNBK/EYPEeUlfGayXvzpawNfaJ6eMcTzQKFdvOSehh8kBUlEFTrgliJhcxP6lyRccg2UG5LvgRF25S6JeK8JuK5AG5vSTb64pZ8PNWNMHAuzsbIE3I1lYHJbMJVpqIhKwSGEdrqhAX8lPI4CBecV5AirUdch9HPL73m107LnNqeQ3wruKhEy8irZTn58vU+PhkDqOXOE+3+otp23cKClGgXuobXBwKt7bFVDuF5VKsE5xa3UDXfVb0zBCqUt6+vSRFsLZk9jwRMgHUsEsEGriqiZ8WjGKVFWNn+44Iwf/lU2qmCbtHf7bX+uYG1l5EtlfzU+6uXcpmu4vI87shO1oU/rSEVfn06lUG0JAhLYd8dnXHF7/AeP7LC0P5OQwMLqY5PZ5kypEjrk24Bk3DlY+PlzBwWZ+/3ShbFhGmFRIeIXkzn61jcAAd18oXkgur71hATsN/dyhfbpsqwfMvkfKszgL1WQmA5Yny8Xy4G
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199021)(40470700004)(46966006)(36840700001)(86362001)(6916009)(2906002)(5660300002)(41300700001)(4326008)(70206006)(70586007)(82740400003)(54906003)(356005)(8936002)(8676002)(82310400005)(7636003)(316002)(478600001)(36860700001)(6666004)(40460700003)(7696005)(186003)(1076003)(336012)(83380400001)(36756003)(426003)(107886003)(40480700001)(47076005)(2616005)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:17:24.9140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6cc912f-6d42-4481-133b-08db665e13fa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6896
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There are only three uffd*() routines that are used outside of the uffd
selftests. Leave these in vm_util.c, where they are available to any mm
selftest program:

    uffd_register()
    uffd_unregister()
    uffd_register_with_ioctls().

A few other uffd*() routines, however, are only used by the uffd-focused
tests found in uffd-stress.c and uffd-unit-tests.c. Move those routines
into uffd-common.c.

Cc: Peter Xu <peterx@redhat.com>
Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/uffd-common.c | 59 ++++++++++++++++++++++++
 tools/testing/selftests/mm/uffd-common.h |  5 ++
 tools/testing/selftests/mm/vm_util.c     | 59 ------------------------
 tools/testing/selftests/mm/vm_util.h     |  4 --
 4 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 61c6250adf93..ba20d7504022 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -616,3 +616,62 @@ int copy_page(int ufd, unsigned long offset, bool wp)
 {
 	return __copy_page(ufd, offset, false, wp);
 }
+
+int uffd_open_dev(unsigned int flags)
+{
+	int fd, uffd;
+
+	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return fd;
+	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
+	close(fd);
+
+	return uffd;
+}
+
+int uffd_open_sys(unsigned int flags)
+{
+#ifdef __NR_userfaultfd
+	return syscall(__NR_userfaultfd, flags);
+#else
+	return -1;
+#endif
+}
+
+int uffd_open(unsigned int flags)
+{
+	int uffd = uffd_open_sys(flags);
+
+	if (uffd < 0)
+		uffd = uffd_open_dev(flags);
+
+	return uffd;
+}
+
+int uffd_get_features(uint64_t *features)
+{
+	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
+	/*
+	 * This should by default work in most kernels; the feature list
+	 * will be the same no matter what we pass in here.
+	 */
+	int fd = uffd_open(UFFD_USER_MODE_ONLY);
+
+	if (fd < 0)
+		/* Maybe the kernel is older than user-only mode? */
+		fd = uffd_open(0);
+
+	if (fd < 0)
+		return fd;
+
+	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
+		close(fd);
+		return -errno;
+	}
+
+	*features = uffdio_api.features;
+	close(fd);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/uffd-common.h b/tools/testing/selftests/mm/uffd-common.h
index 6068f2346b86..197f5262fe0d 100644
--- a/tools/testing/selftests/mm/uffd-common.h
+++ b/tools/testing/selftests/mm/uffd-common.h
@@ -110,6 +110,11 @@ int __copy_page(int ufd, unsigned long offset, bool retry, bool wp);
 int copy_page(int ufd, unsigned long offset, bool wp);
 void *uffd_poll_thread(void *arg);
 
+int uffd_open_dev(unsigned int flags);
+int uffd_open_sys(unsigned int flags);
+int uffd_open(unsigned int flags);
+int uffd_get_features(uint64_t *features);
+
 #define TEST_ANON	1
 #define TEST_HUGETLB	2
 #define TEST_SHMEM	3
diff --git a/tools/testing/selftests/mm/vm_util.c b/tools/testing/selftests/mm/vm_util.c
index 9b06a5034808..681277615839 100644
--- a/tools/testing/selftests/mm/vm_util.c
+++ b/tools/testing/selftests/mm/vm_util.c
@@ -242,62 +242,3 @@ int uffd_unregister(int uffd, void *addr, uint64_t len)
 
 	return ret;
 }
-
-int uffd_open_dev(unsigned int flags)
-{
-	int fd, uffd;
-
-	fd = open("/dev/userfaultfd", O_RDWR | O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-	uffd = ioctl(fd, USERFAULTFD_IOC_NEW, flags);
-	close(fd);
-
-	return uffd;
-}
-
-int uffd_open_sys(unsigned int flags)
-{
-#ifdef __NR_userfaultfd
-	return syscall(__NR_userfaultfd, flags);
-#else
-	return -1;
-#endif
-}
-
-int uffd_open(unsigned int flags)
-{
-	int uffd = uffd_open_sys(flags);
-
-	if (uffd < 0)
-		uffd = uffd_open_dev(flags);
-
-	return uffd;
-}
-
-int uffd_get_features(uint64_t *features)
-{
-	struct uffdio_api uffdio_api = { .api = UFFD_API, .features = 0 };
-	/*
-	 * This should by default work in most kernels; the feature list
-	 * will be the same no matter what we pass in here.
-	 */
-	int fd = uffd_open(UFFD_USER_MODE_ONLY);
-
-	if (fd < 0)
-		/* Maybe the kernel is older than user-only mode? */
-		fd = uffd_open(0);
-
-	if (fd < 0)
-		return fd;
-
-	if (ioctl(fd, UFFDIO_API, &uffdio_api)) {
-		close(fd);
-		return -errno;
-	}
-
-	*features = uffdio_api.features;
-	close(fd);
-
-	return 0;
-}
diff --git a/tools/testing/selftests/mm/vm_util.h b/tools/testing/selftests/mm/vm_util.h
index 07f39ed2efba..c2d4ff798b91 100644
--- a/tools/testing/selftests/mm/vm_util.h
+++ b/tools/testing/selftests/mm/vm_util.h
@@ -48,10 +48,6 @@ unsigned long default_huge_page_size(void);
 int uffd_register(int uffd, void *addr, uint64_t len,
 		  bool miss, bool wp, bool minor);
 int uffd_unregister(int uffd, void *addr, uint64_t len);
-int uffd_open_dev(unsigned int flags);
-int uffd_open_sys(unsigned int flags);
-int uffd_open(unsigned int flags);
-int uffd_get_features(uint64_t *features);
 int uffd_register_with_ioctls(int uffd, void *addr, uint64_t len,
 			      bool miss, bool wp, bool minor, uint64_t *ioctls);
 
-- 
2.40.1

