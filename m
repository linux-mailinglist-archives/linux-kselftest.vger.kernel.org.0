Return-Path: <linux-kselftest+bounces-11461-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2220A900F33
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 04:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FE0F1F22115
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jun 2024 02:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55930125D5;
	Sat,  8 Jun 2024 02:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jOy7tgMz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4CD520;
	Sat,  8 Jun 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717812636; cv=fail; b=NbmVgrrMU5C8KGZTu5Z94TDeQSSlbihKjkFNUDLrnJJkKc2HAC69E1JJPdctZb7zo8KUYxzso60FtSxonDig/1XzSjIYi550FypvVJy4byzpL7Ov+TiKVGBQcwiVs4qHup88IM2kYPDb1Ya+BIeiEviiWFCHZrzmvsoSW3Yhbf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717812636; c=relaxed/simple;
	bh=BxGNrOHe2dfbHDfllX9TKbHgDuwBjx63EqJ45VYzzSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=seC5TcTyeCrSUbw+MGf9FlNY8toBCGQN6tmhqfCfSnun2k58nE29opbqesqcvAbMPkEJWE0SQWEb/EEtB+B6Ge3GcKzPuf/0yeSUttTOuoLdTyZ1Qlm9BS3kJnf9SfxQ4/Kkrshg5cnRD4HzWNq7LM/8+TyUrq2rnmqled9K+jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jOy7tgMz; arc=fail smtp.client-ip=40.107.243.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEB86y5js6X/KNB8PRbF8oVA+3d455xhaL5mikuk5Yu8mYXzN9hZZAUoj3yez7JFKKcBkFKTJX25CNu9YT3Xz1eMxAQ712dT3kagQOEWAvx+2ERkPuxxpvxlm1rNraCJJc1OzDI5vW82t7hn+ybclRcllVEKjJglPMqeJdHJps9o+d9SyXcPqQ1RbzH92SPlNV+9djKBqsxBfw1GTdqg0m1iTSbpDfZigBptTlXl4qRrhFH72XHb4WbuRCAIHxDBJAVC9O+qK/071Zuiaz6J4KBacJSlkp2DXMhktgki6rv1VaViVziyqiLn9XuBcWeap2Xac1CsZn8SwZP/ZzTfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eHcL2+kvCrCQkV4frQnNbum43yoJZFURF80YKG6CdtY=;
 b=lCNtwSYYThlUAKlOJNWDuWhUYQREIYcbcoRTfK9LMEAJ8wC1Z/6dnCXUP0X/UPvt1K8hMb6C7XWDTmqUYUQ7y8P4XWUQ/Q3lC9RcPQoRFLbYK3qDDoaM8+Panf5elsTebX0/LkUQ0E1PQSNtltlgZig2geVHrKSaKqilrHLpoUlvkisIIhQGCc+3xLw/os4aNk2VVMjcXPb+eU/KR68GGxcSJL4mUD1Vv4+xCK3Yon9PRqb6SijKBuU3kE2LsKG7xFHaedDKZtYoHw//kAIEjRn9UdAUtZvzvEQfyaN5SpB2w1bx6AszRfawbtey4ExiHkIGANlk1MCu8/1nJZouww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eHcL2+kvCrCQkV4frQnNbum43yoJZFURF80YKG6CdtY=;
 b=jOy7tgMz4BgwvRfHPZm55TF4LrpIsOpwHRI0Y7wTv1UAUZjj/AqdVkQSkuGLFoxqSrFSnA4w1ZMviUbddoszt9c6CzKIVOc/3BUJlt7HASTpBuvCeH9mZSRXIZNMnvwLSQlaJfFyMcUCBX19RooOSD0sroNCfIiOD7B1ji+MjWpfb9JFC7bUwkRFvcMCjhB/aH59ZLMVZDdsj/qLpnvR4CgG3Dn1IeLEKeEBGQuiWBFbJuvmkr2uOJrp0Yh46J0jS5yumlCFyOSnnLcBkRkyRqtfo/3UGEJtz0TVGm3guUcdVrPQa1ZkKurUtUSvDSH5BH/8xCs9AjEBeZb3+HJqmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB4196.namprd12.prod.outlook.com (2603:10b6:a03:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 02:10:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 02:10:27 +0000
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jeff Xu <jeffxu@chromium.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Muhammad Usama Anjum <usama.anjum@collabora.com>,
	Peter Xu <peterx@redhat.com>,
	Rich Felker <dalias@libc.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 4/5] selftests/mm: mseal, self_elf: factor out test macros and other duplicated items
Date: Fri,  7 Jun 2024 19:10:22 -0700
Message-ID: <20240608021023.176027-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240608021023.176027-1-jhubbard@nvidia.com>
References: <20240608021023.176027-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::27) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|BY5PR12MB4196:EE_
X-MS-Office365-Filtering-Correlation-Id: 805c58f5-5edf-4422-9ef2-08dc87602a49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tgxsl/RdDmMXDYpHZq+XhGs26jEg6Ah1IfVxKPYWua3vDt195qKKinDnVQ24?=
 =?us-ascii?Q?jbNsewU29RNUmDuTjW1WMXu2cS7rt51k3g/cMo7CCbxlL57prLmUuWap7Y/a?=
 =?us-ascii?Q?RJk3LqBb1aYZ/dUAUbpAZNY7qC3n57Wkja83UJEyq+fSJ4OBVvB0S0ASB7gz?=
 =?us-ascii?Q?w86oQL2KEYcpWgwqpdE8wWpACiFIE3rzik0yb8ChIUpTB3EH+F2JplkGJZX0?=
 =?us-ascii?Q?uovvPv7WBY3ziHtEBf3eTlED7m9y/0z0o/tSKno2bRi4thEPXatWeGB0phaf?=
 =?us-ascii?Q?P7z6taX61QbSRCsHmJLTfLGLj0s01TvODLK5Q3cUTi8BDF28UdIKYJJLbXql?=
 =?us-ascii?Q?CvuJTxKKiDBHR6qshhZIIvPsmxqNXiD0Aaf6EfjKAaYJ3WQnHHWCeh0uvR5x?=
 =?us-ascii?Q?lF619SJp4ALUIz26SPK0KcllSifK1L87Uyy+VfazH29GerWBpOKq1pk+W6CS?=
 =?us-ascii?Q?fV78F8xPtwxDC8M1rjYAY53vqBR0MmPi492FA2xN0vOj7sYesnvbVc8BaGhD?=
 =?us-ascii?Q?xEFyY47wqGhClfiRyoV+c0IWP7pAXCNy1AHZylrT4KuPe6bI6n2LiLvQXuSQ?=
 =?us-ascii?Q?NiVSTwG3x+qwzA93Qt+nLz99g5De5kko1Qag7MNaGlsWbUpc6Z7qrhad4I4x?=
 =?us-ascii?Q?TU9Su5c+6f6frcdRdcJWwtQCQAbVxPROsR+hIp4OJm9O2mr3jf0kufq0k8tu?=
 =?us-ascii?Q?SfxtsNPpoFuf0779aa/38aLaFeTyi9X69rDWDw0lxZFYro5pPhNYD4krmsZD?=
 =?us-ascii?Q?ZKrWbvyMIGz2UIuBtWD8Rpzm647AZTrFq+UikUatEoI5O3yp7QeVO1kzlfmm?=
 =?us-ascii?Q?Hhvfyu+kpBwB2SMtzDN1c6vghghdVRxvnWBWuZX/X+zZRqaC37MDGl9Itu4y?=
 =?us-ascii?Q?Ahkq5T8XwTXmGbw9RbMB1r6cPwnZSBcM1ZvI5fLZDBtnIzoLWwn5Hwid6WwG?=
 =?us-ascii?Q?hTeaIR/OCxF64PpiwJcDWSeWVGUQFqQpccHJZnBq2mMavgNhpZlxOSwrdqHT?=
 =?us-ascii?Q?0k7/+fG4jtB5NO7YqWZEkQu3BzbGq0DZKE4oYLzRgibVY4ebxh6IMmsYTw3D?=
 =?us-ascii?Q?5LYno+vniTnpqSog2xxIeRqlTrSMe8duchh/uuf/GVnmAgJSiVVMCllvlU9i?=
 =?us-ascii?Q?CiGyMfulPNnaPQ9L10UVfLtiil6063QlBUl9GPylwM3ptB40/XIAjyE9Tu/m?=
 =?us-ascii?Q?eu/rCvMk0GR8c+esYYDp02jAIhdEuHUwwOPDQS0t4r97/Y9O4aDDQ1H0/9Wn?=
 =?us-ascii?Q?kEeBavMCb7ruXAOuJi9esU09+ie8ZjP0Y4vBKP8k+MCG78DpT1+LzILeqQE5?=
 =?us-ascii?Q?lLw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0zfjdmSUX4aQBkpu0bgfILpmm9OXrNuxzZrPBmQywLG9edQ90gCgSNhwMSPJ?=
 =?us-ascii?Q?MXTp8Fte6r1JdrpWFxF4oHQOs5a6P6vmDU/f8Ttq2dxBRqJa/mZzPxCsbVpk?=
 =?us-ascii?Q?n71udyldX+gKy5rpGF4XtpV5FLsiWvEex5SRGz4vGgm/EAxV4q7nvlle/qYM?=
 =?us-ascii?Q?RQ8dIKNZy33wROudMDXqTWm6rAVStAC3aS9C+tFub99fDQP0aznGRCDCgZ+K?=
 =?us-ascii?Q?eZnGTERlej9ncIs3P6F+qbMNCIDg20lF+yXmkEKqQkz5APS2Jy/wmehvLae7?=
 =?us-ascii?Q?4wvThiT5UhOpLpz/w7Qs54iTsxlSWVZUNcrtmdos4slHewjFe+s1rCEV/y59?=
 =?us-ascii?Q?zfvGsz1LOUHeezigARkCUu7GXYsytjTu3gqUtp56NXJoLQpaDB14MfE60HF0?=
 =?us-ascii?Q?vb2kW+4fzubRssNt4L8NaA+/9KNa95Dn1soNbpSdHamzCnNEd2ZrjWp/sMI1?=
 =?us-ascii?Q?PfE7ArWl93JnoLdwBssaQwLoMBML5RePMBm4waxLnb7dOyKWG7wdd2rrIsWz?=
 =?us-ascii?Q?TcC2+EG7hb0lEwF/ziTWV9E4FqZEl7ldqwSoYUm1hOx4qk2srmkT8Fr/9PEa?=
 =?us-ascii?Q?wSvDHkvpblqvaK9dza3Jv9sKhlWLbtMXUiS/mXd6ekolY84t6rWch2YyJFrX?=
 =?us-ascii?Q?CDiM/KDO83osf0soBg3QyMVXAKFaCVb5hZzH3oIYPznpm+7Txx02zVFre+ik?=
 =?us-ascii?Q?V2++x9c7Fq//oIqJ/lbhZUZkWwujFnKVDxOW5VSEhqD9uDTrpm6odO6g0AlF?=
 =?us-ascii?Q?sqSjANdCdX07ASBppPez0vI3ThhVdZTy6/jCZCsU6QHAVishjqgBsxEMnDOK?=
 =?us-ascii?Q?WkykbOhAKSA1hkQ3g0ackjY5xnX6FOeJsQqpomFBo9G/Ecs8/+mThwGl8YPs?=
 =?us-ascii?Q?TfNWXUNDUAh0i05AeoEhjnYtECgBCL9UkWCQX7rFR9HBZWQ5iekuu5fwES1O?=
 =?us-ascii?Q?e98sAuJDWd06bOBuXw+cWH9mkFMM6WXeSb8XNvEoSSLZePYIV0TzZmjeTXjN?=
 =?us-ascii?Q?GSGUwtxUz96l+EVAi6A6nmrWhx2t7cvf0/QwpLRaosHADQyYqN7TIj+P4X4l?=
 =?us-ascii?Q?ARGgkDAwESmz9LoK1HfSGIvRPSR4seli0CvkJJsbKpJqxmAr7xBC0kZ1YRBH?=
 =?us-ascii?Q?WGaWvBysvg9UDSt2EfChIdM1f16Ggwlno21IejYlHHqBteCStbvzjIoEj8n0?=
 =?us-ascii?Q?y6AZH5oIg5VoIYgr1C5uLNQ5q0zn1JZHxvtPflmoSPeYgwpzHY+zqmz4SY+R?=
 =?us-ascii?Q?sj0f6tnfTa9i0tGrexZOnIuYxIEB84G38sSDW3Rp6x2o523zgt+6TObDeNjE?=
 =?us-ascii?Q?Mczt4ZdEbgxkreYfOtnSPWLAMEEiZm+foHsTvO0W6kWWXwUE42P3vpwfk1uW?=
 =?us-ascii?Q?irit5dkRKfmg7DTbcGq4DeK+iB0E3imO2M2Iq8t2X3sistbJjJ+HgquJHszv?=
 =?us-ascii?Q?BY42eMmFGtSovEUw6KTIIuRqve4h4YfMJt+czUDWHsJyl7UhTesv2LPDktNg?=
 =?us-ascii?Q?mS6yrV0vMV6IDmjK9mWrAvdKil8bfX6ukjnMjxTKS9cJIKN6EQ8IC6y0Goda?=
 =?us-ascii?Q?zLgIkq5J76rCcGguBLiQb/2j8vpPvacL/eBCxZxi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805c58f5-5edf-4422-9ef2-08dc87602a49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 02:10:27.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQhEcryErW2pRq7g53oNiIkqhs7DrMWZ3sWL6lcLzVdjWgbi2OQNFyELnB9cqlRxWXtvJBpjAR93AkoeGKVBHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4196

Clean up and move some copy-pasted items into mseal_helpers.h.

1. The test macros can be made safer and simpler, by observing that they
are invariably called when about to return. This means that the macros
do not need an intrusive label to goto; they can simply return.

2. PKEY* items. We cannot, unfortunately use pkey-helpers.h. The best we
can do is to factor out these few items into mseal_helpers.h.

3. These tests still need their own definition of u64, so also move that
to the header file.

Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/mseal_helpers.h | 40 ++++++++++++++++++
 tools/testing/selftests/mm/mseal_test.c    | 48 ----------------------
 tools/testing/selftests/mm/seal_elf.c      | 32 ---------------
 3 files changed, 40 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/mm/mseal_helpers.h b/tools/testing/selftests/mm/mseal_helpers.h
index b922d453a014..8c3bf77dcf19 100644
--- a/tools/testing/selftests/mm/mseal_helpers.h
+++ b/tools/testing/selftests/mm/mseal_helpers.h
@@ -3,3 +3,43 @@
 #ifndef __NR_mseal
 #define __NR_mseal 462
 #endif
+
+#define FAIL_TEST_IF_FALSE(test_passed)					\
+	do {								\
+		if (!(test_passed)) {					\
+			ksft_test_result_fail("%s: line:%d\n",		\
+						__func__, __LINE__);	\
+			return;						\
+		}							\
+	} while (0)
+
+#define SKIP_TEST_IF_FALSE(test_passed)					\
+	do {								\
+		if (!(test_passed)) {					\
+			ksft_test_result_skip("%s: line:%d\n",		\
+						__func__, __LINE__);	\
+			return;						\
+		}							\
+	} while (0)
+
+#define TEST_END_CHECK() ksft_test_result_pass("%s\n", __func__)
+
+#ifndef PKEY_DISABLE_ACCESS
+#define PKEY_DISABLE_ACCESS	0x1
+#endif
+
+#ifndef PKEY_DISABLE_WRITE
+#define PKEY_DISABLE_WRITE	0x2
+#endif
+
+#ifndef PKEY_BITS_PER_PKEY
+#define PKEY_BITS_PER_PKEY	2
+#endif
+
+#ifndef PKEY_MASK
+#define PKEY_MASK	(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
+#endif
+
+#ifndef u64
+#define u64 unsigned long long
+#endif
diff --git a/tools/testing/selftests/mm/mseal_test.c b/tools/testing/selftests/mm/mseal_test.c
index 20949617a036..a29935d82027 100644
--- a/tools/testing/selftests/mm/mseal_test.c
+++ b/tools/testing/selftests/mm/mseal_test.c
@@ -19,54 +19,6 @@
 #include <sys/stat.h>
 #include "mseal_helpers.h"
 
-/*
- * need those definition for manually build using gcc.
- * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 mseal_test.c -o mseal_test
- */
-#ifndef PKEY_DISABLE_ACCESS
-# define PKEY_DISABLE_ACCESS    0x1
-#endif
-
-#ifndef PKEY_DISABLE_WRITE
-# define PKEY_DISABLE_WRITE     0x2
-#endif
-
-#ifndef PKEY_BITS_PER_PKEY
-#define PKEY_BITS_PER_PKEY      2
-#endif
-
-#ifndef PKEY_MASK
-#define PKEY_MASK       (PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE)
-#endif
-
-#define FAIL_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-#define SKIP_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-
-#define TEST_END_CHECK() {\
-		ksft_test_result_pass("%s\n", __func__);\
-		return;\
-test_end:\
-		return;\
-}
-
-#ifndef u64
-#define u64 unsigned long long
-#endif
-
 static unsigned long get_vma_size(void *addr, int *prot)
 {
 	FILE *maps;
diff --git a/tools/testing/selftests/mm/seal_elf.c b/tools/testing/selftests/mm/seal_elf.c
index 4053951a535c..0fd129259647 100644
--- a/tools/testing/selftests/mm/seal_elf.c
+++ b/tools/testing/selftests/mm/seal_elf.c
@@ -18,38 +18,6 @@
 #include <sys/stat.h>
 #include "mseal_helpers.h"
 
-/*
- * need those definition for manually build using gcc.
- * gcc -I ../../../../usr/include   -DDEBUG -O3  -DDEBUG -O3 seal_elf.c -o seal_elf
- */
-#define FAIL_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_fail("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-#define SKIP_TEST_IF_FALSE(c) do {\
-		if (!(c)) {\
-			ksft_test_result_skip("%s, line:%d\n", __func__, __LINE__);\
-			goto test_end;\
-		} \
-	} \
-	while (0)
-
-
-#define TEST_END_CHECK() {\
-		ksft_test_result_pass("%s\n", __func__);\
-		return;\
-test_end:\
-		return;\
-}
-
-#ifndef u64
-#define u64 unsigned long long
-#endif
-
 /*
  * define sys_xyx to call syscall directly.
  */
-- 
2.45.2


