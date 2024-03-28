Return-Path: <linux-kselftest+bounces-6754-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC0E88F5FF
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 04:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CE151F27E1B
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Mar 2024 03:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6504838FA6;
	Thu, 28 Mar 2024 03:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yzgyxwir"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2047.outbound.protection.outlook.com [40.107.101.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D60381C9;
	Thu, 28 Mar 2024 03:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711596873; cv=fail; b=bFwo5UDfyVtzpkUYi3Vso4I6Z99IfZpqlT1GQGK8CAsj6BClc+yliG4GmMTKTdhprkeCjGg+vozK63cX6wLOVA1NO4gZkER/nrVUQCn4V8cs29dd1bzDOdKRnYH/nOOWKJoYSCP8EY7ZEPmn3BW/FD5EuK0mcfrMZ+oyykS//iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711596873; c=relaxed/simple;
	bh=eDTekoGC6vkTUxTevDG0sjQNYAhSPVfinXfdUYSo4Zo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7Quy5NFhvO6DRRWLEAk43rDCZNS+rX2q+aWe6DepNeSidf0OStUBe3ePGUvAsNyQL/73fCXXhRTmMGQ5fIrFWqEUrV1BpAD8hvM/653C7tvy2xWicD1gDVubHfU7kaJLqYcuOSAwKscN6Xi25MXIRJHJDWh+0Y4P5cA4cdt+e4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yzgyxwir; arc=fail smtp.client-ip=40.107.101.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2ym/S2bH0EfCw5rUZRMf7P/a031nAjNGMsRJoX2Z89FdXD2AiM4RwesFXnDsxu5SW73eHXOPDOlArZf5zY216L17AExsZ4IilUncf2HsX5Pqb0BVB6+4W6u3hzRCDZAkC/KwyXX9k4iAaeaoSanryT4iDJucCnV6ebjCt2VGdTxndezeRBDEw4fINufPCZDx1KrXI1/AU65OMlzFCrSzmUnP7T8yvCEGNsOnYdqYFmqGbHDILuCb2c9GZddSDaMpjbOpXcMxhPtIz3VslTd0wfLMRB87F2S3PnV6uEEGHa3qEhWhy4gyLZhsMJMX8+1hqYPs6NRQYkYEck+YrnmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wZrh6YSD7uNTj7TV3XRmzbBOFgFmdcgSko+aQNsQbIw=;
 b=jP4ldwRvUMf2OmEp9DZIu7psiwxdGSlsOIImV4rF9rkgbRbeKbJqSL5g9fQtB5df/zPd8TQ12rLhjVwATkqmyekBWA17+isO2IBGgKfXejJ7EKhSY6Oi6rbBkp3nxtvSxsV42xSAE0qpXNYS4e3+LnhBr2rzXhqDidUScM9JyJdDZfX78Lq/Uy4MozddQoc05GvpQSQupPUEXdgWlRebaRwKzbIna6TpelQ5lphuFw6CeE7pxgs+foc36EmuBLKhB33JP0uPTBRnlU/LRkNDHcbcaCP9MIhEnwdbEm0DEeFtECcYDcc0UDNsHD3ZklHHl0boh2WDraDReKf4I/yPIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wZrh6YSD7uNTj7TV3XRmzbBOFgFmdcgSko+aQNsQbIw=;
 b=Yzgyxwirkvahg6hRjTOQiHxPbsKHKHRAPqVM7hMCTliWdrzQPRiKkHlpUOQuBfqK+pQ9HhAqA68nBgmHfp0nxrDAAsIhV5ez3X0oTaTURkC/WuBITypwlf/aDnIZkgOtKnuf3We6sb9CF0LDIQxomZXRlQcCO7D/108tVpihi9VkB28RzDMCSgsseTji3se2vwytqt0qTCxh2KbrcdiPvh9xGuzfGfQKeU5zO3oCOtx4pQ99ziR1+RQ2dHmkMlpeyzL7hJbGZ0yl0QzLswlTvR7c4ormPWy+PtY+kNMsVCmzjbkmhNEoJG6SSa7913HHnkDYOq4jnGZkxjuoAMZVGQ==
Received: from SN7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::13)
 by CH3PR12MB7642.namprd12.prod.outlook.com (2603:10b6:610:14a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 03:34:26 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::59) by SN7P220CA0008.outlook.office365.com
 (2603:10b6:806:123::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 03:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 03:34:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 27 Mar
 2024 20:34:20 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Wed, 27 Mar 2024 20:34:20 -0700
Received: from blueforge.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Wed, 27 Mar 2024 20:34:20 -0700
From: John Hubbard <jhubbard@nvidia.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, "Shuah
 Khan" <shuah@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, "Andrea
 Arcangeli" <aarcange@redhat.com>, <linux-mm@kvack.org>,
	<linux-kselftest@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, "John
 Hubbard" <jhubbard@nvidia.com>, Mark Brown <broonie@kernel.org>, "Muhammad
 Usama Anjum" <usama.anjum@collabora.com>, Suren Baghdasaryan
	<surenb@google.com>, Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/2] selftests/mm: fix additional build errors for selftests
Date: Wed, 27 Mar 2024 20:34:18 -0700
Message-ID: <20240328033418.203790-3-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328033418.203790-1-jhubbard@nvidia.com>
References: <20240328033418.203790-1-jhubbard@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|CH3PR12MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 511b17ad-89b5-4da8-364d-08dc4ed7f7c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QcFfmdjxLphQyzLrIUnvSftG78yFLqf+PJg+s0n8sWRQTjzVj2z/Hs6NTtpyW+I7vu39sg+qVRh6OF9rd8WgToyx/uHxcK3PCaGHDSEu8L9VxXKDn6NcPPZl5tOJmRdItSSBwwwePtCx+gz/JRCJovuwaYsrxLxjee5W+mscpK6vrAMPGlDsHXbKCCsM4SiB4JnTcTS38ott4XhpbxNNGa1erYjELPQ+CrzxEDprQTaIxrMXLW78JbDI6CJy5mC/4EH9O3hHhSfbPsNl5b9I9G1mqryEaERQjTQw6X10gOaIHD9oaKquUURY4ywNQo2CCWqtwwFPHSAu538UAAeulGAdDlGYz7pTrfT2RApHzV94B1ERMnLy11Zdbe+KPJqy4mpjeMVOtoPJKd24fmws33rEaU9V4ujnGg7igcQxpn0jf9OeMD1vnaXIj84ixMzTgCXJ+f1dJGEkzSfOPh+5vrCgDuWJbSATe/znKYSmDdt1MhEP7z4JecFeDfuKZV0U3VtwaUGEwJI+cVqps0XgcK3vWVf6CNWk4DQa5gxasao2WlEOYVErgO8xzfmV9LWIqmQUKZert9K00gDUHZjWps3g1C8IOUcDWgSn5E4Cj1wRZPvwCLh0cwo9VkQk9bTecl1w2XU2mphb8OzDta3uCwb15IxjMV4B2uMDTTEo76A+N/KLGVk0Ur0v6nGfmtq0qyMU6DgetzOpX9HLvWp2dEEf/I3qOWf3xQuGIC4J6kjaDY0FioGRiHMnqhoZkOQk
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 03:34:26.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511b17ad-89b5-4da8-364d-08dc4ed7f7c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7642

These build errors only occur if one fails to first run "make headers".
However, that is a non-obvious and instrusive requirement, and so there
was a discussion on how to get rid of it [1]. This uses that solution.

These two files were created by taking a snapshot of the generated
header files that are created via "make headers". These two files were
copied from ./usr/include/linux/ to ./tools/include/uapi/linux/ .

That fixes the selftests/mm build on today's Arch Linux (which required
the userfaultfd.h) and Ubuntu 23.04 (which additionally required
memfd.h).

[1] https://lore.kernel.org/all/783a4178-1dec-4e30-989a-5174b8176b09@redhat.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/include/uapi/linux/memfd.h       |  39 +++
 tools/include/uapi/linux/userfaultfd.h | 386 +++++++++++++++++++++++++
 2 files changed, 425 insertions(+)
 create mode 100644 tools/include/uapi/linux/memfd.h
 create mode 100644 tools/include/uapi/linux/userfaultfd.h

diff --git a/tools/include/uapi/linux/memfd.h b/tools/include/uapi/linux/memfd.h
new file mode 100644
index 000000000000..01c0324e7733
--- /dev/null
+++ b/tools/include/uapi/linux/memfd.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_MEMFD_H
+#define _LINUX_MEMFD_H
+
+#include <asm-generic/hugetlb_encode.h>
+
+/* flags for memfd_create(2) (unsigned int) */
+#define MFD_CLOEXEC		0x0001U
+#define MFD_ALLOW_SEALING	0x0002U
+#define MFD_HUGETLB		0x0004U
+/* not executable and sealed to prevent changing to executable. */
+#define MFD_NOEXEC_SEAL		0x0008U
+/* executable */
+#define MFD_EXEC		0x0010U
+
+/*
+ * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
+ * size other than the default is desired.  See hugetlb_encode.h.
+ * All known huge page size encodings are provided here.  It is the
+ * responsibility of the application to know which sizes are supported on
+ * the running system.  See mmap(2) man page for details.
+ */
+#define MFD_HUGE_SHIFT	HUGETLB_FLAG_ENCODE_SHIFT
+#define MFD_HUGE_MASK	HUGETLB_FLAG_ENCODE_MASK
+
+#define MFD_HUGE_64KB	HUGETLB_FLAG_ENCODE_64KB
+#define MFD_HUGE_512KB	HUGETLB_FLAG_ENCODE_512KB
+#define MFD_HUGE_1MB	HUGETLB_FLAG_ENCODE_1MB
+#define MFD_HUGE_2MB	HUGETLB_FLAG_ENCODE_2MB
+#define MFD_HUGE_8MB	HUGETLB_FLAG_ENCODE_8MB
+#define MFD_HUGE_16MB	HUGETLB_FLAG_ENCODE_16MB
+#define MFD_HUGE_32MB	HUGETLB_FLAG_ENCODE_32MB
+#define MFD_HUGE_256MB	HUGETLB_FLAG_ENCODE_256MB
+#define MFD_HUGE_512MB	HUGETLB_FLAG_ENCODE_512MB
+#define MFD_HUGE_1GB	HUGETLB_FLAG_ENCODE_1GB
+#define MFD_HUGE_2GB	HUGETLB_FLAG_ENCODE_2GB
+#define MFD_HUGE_16GB	HUGETLB_FLAG_ENCODE_16GB
+
+#endif /* _LINUX_MEMFD_H */
diff --git a/tools/include/uapi/linux/userfaultfd.h b/tools/include/uapi/linux/userfaultfd.h
new file mode 100644
index 000000000000..4283de22d5b6
--- /dev/null
+++ b/tools/include/uapi/linux/userfaultfd.h
@@ -0,0 +1,386 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ *  include/linux/userfaultfd.h
+ *
+ *  Copyright (C) 2007  Davide Libenzi <davidel@xmailserver.org>
+ *  Copyright (C) 2015  Red Hat, Inc.
+ *
+ */
+
+#ifndef _LINUX_USERFAULTFD_H
+#define _LINUX_USERFAULTFD_H
+
+#include <linux/types.h>
+
+/* ioctls for /dev/userfaultfd */
+#define USERFAULTFD_IOC 0xAA
+#define USERFAULTFD_IOC_NEW _IO(USERFAULTFD_IOC, 0x00)
+
+/*
+ * If the UFFDIO_API is upgraded someday, the UFFDIO_UNREGISTER and
+ * UFFDIO_WAKE ioctls should be defined as _IOW and not as _IOR.  In
+ * userfaultfd.h we assumed the kernel was reading (instead _IOC_READ
+ * means the userland is reading).
+ */
+#define UFFD_API ((__u64)0xAA)
+#define UFFD_API_REGISTER_MODES (UFFDIO_REGISTER_MODE_MISSING |	\
+				 UFFDIO_REGISTER_MODE_WP |	\
+				 UFFDIO_REGISTER_MODE_MINOR)
+#define UFFD_API_FEATURES (UFFD_FEATURE_PAGEFAULT_FLAG_WP |	\
+			   UFFD_FEATURE_EVENT_FORK |		\
+			   UFFD_FEATURE_EVENT_REMAP |		\
+			   UFFD_FEATURE_EVENT_REMOVE |		\
+			   UFFD_FEATURE_EVENT_UNMAP |		\
+			   UFFD_FEATURE_MISSING_HUGETLBFS |	\
+			   UFFD_FEATURE_MISSING_SHMEM |		\
+			   UFFD_FEATURE_SIGBUS |		\
+			   UFFD_FEATURE_THREAD_ID |		\
+			   UFFD_FEATURE_MINOR_HUGETLBFS |	\
+			   UFFD_FEATURE_MINOR_SHMEM |		\
+			   UFFD_FEATURE_EXACT_ADDRESS |		\
+			   UFFD_FEATURE_WP_HUGETLBFS_SHMEM |	\
+			   UFFD_FEATURE_WP_UNPOPULATED |	\
+			   UFFD_FEATURE_POISON |		\
+			   UFFD_FEATURE_WP_ASYNC |		\
+			   UFFD_FEATURE_MOVE)
+#define UFFD_API_IOCTLS				\
+	((__u64)1 << _UFFDIO_REGISTER |		\
+	 (__u64)1 << _UFFDIO_UNREGISTER |	\
+	 (__u64)1 << _UFFDIO_API)
+#define UFFD_API_RANGE_IOCTLS			\
+	((__u64)1 << _UFFDIO_WAKE |		\
+	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_ZEROPAGE |		\
+	 (__u64)1 << _UFFDIO_MOVE |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_POISON)
+#define UFFD_API_RANGE_IOCTLS_BASIC		\
+	((__u64)1 << _UFFDIO_WAKE |		\
+	 (__u64)1 << _UFFDIO_COPY |		\
+	 (__u64)1 << _UFFDIO_WRITEPROTECT |	\
+	 (__u64)1 << _UFFDIO_CONTINUE |		\
+	 (__u64)1 << _UFFDIO_POISON)
+
+/*
+ * Valid ioctl command number range with this API is from 0x00 to
+ * 0x3F.  UFFDIO_API is the fixed number, everything else can be
+ * changed by implementing a different UFFD_API. If sticking to the
+ * same UFFD_API more ioctl can be added and userland will be aware of
+ * which ioctl the running kernel implements through the ioctl command
+ * bitmask written by the UFFDIO_API.
+ */
+#define _UFFDIO_REGISTER		(0x00)
+#define _UFFDIO_UNREGISTER		(0x01)
+#define _UFFDIO_WAKE			(0x02)
+#define _UFFDIO_COPY			(0x03)
+#define _UFFDIO_ZEROPAGE		(0x04)
+#define _UFFDIO_MOVE			(0x05)
+#define _UFFDIO_WRITEPROTECT		(0x06)
+#define _UFFDIO_CONTINUE		(0x07)
+#define _UFFDIO_POISON			(0x08)
+#define _UFFDIO_API			(0x3F)
+
+/* userfaultfd ioctl ids */
+#define UFFDIO 0xAA
+#define UFFDIO_API		_IOWR(UFFDIO, _UFFDIO_API,	\
+				      struct uffdio_api)
+#define UFFDIO_REGISTER		_IOWR(UFFDIO, _UFFDIO_REGISTER, \
+				      struct uffdio_register)
+#define UFFDIO_UNREGISTER	_IOR(UFFDIO, _UFFDIO_UNREGISTER,	\
+				     struct uffdio_range)
+#define UFFDIO_WAKE		_IOR(UFFDIO, _UFFDIO_WAKE,	\
+				     struct uffdio_range)
+#define UFFDIO_COPY		_IOWR(UFFDIO, _UFFDIO_COPY,	\
+				      struct uffdio_copy)
+#define UFFDIO_ZEROPAGE		_IOWR(UFFDIO, _UFFDIO_ZEROPAGE,	\
+				      struct uffdio_zeropage)
+#define UFFDIO_MOVE		_IOWR(UFFDIO, _UFFDIO_MOVE,	\
+				      struct uffdio_move)
+#define UFFDIO_WRITEPROTECT	_IOWR(UFFDIO, _UFFDIO_WRITEPROTECT, \
+				      struct uffdio_writeprotect)
+#define UFFDIO_CONTINUE		_IOWR(UFFDIO, _UFFDIO_CONTINUE,	\
+				      struct uffdio_continue)
+#define UFFDIO_POISON		_IOWR(UFFDIO, _UFFDIO_POISON, \
+				      struct uffdio_poison)
+
+/* read() structure */
+struct uffd_msg {
+	__u8	event;
+
+	__u8	reserved1;
+	__u16	reserved2;
+	__u32	reserved3;
+
+	union {
+		struct {
+			__u64	flags;
+			__u64	address;
+			union {
+				__u32 ptid;
+			} feat;
+		} pagefault;
+
+		struct {
+			__u32	ufd;
+		} fork;
+
+		struct {
+			__u64	from;
+			__u64	to;
+			__u64	len;
+		} remap;
+
+		struct {
+			__u64	start;
+			__u64	end;
+		} remove;
+
+		struct {
+			/* unused reserved fields */
+			__u64	reserved1;
+			__u64	reserved2;
+			__u64	reserved3;
+		} reserved;
+	} arg;
+} __attribute__((packed));
+
+/*
+ * Start at 0x12 and not at 0 to be more strict against bugs.
+ */
+#define UFFD_EVENT_PAGEFAULT	0x12
+#define UFFD_EVENT_FORK		0x13
+#define UFFD_EVENT_REMAP	0x14
+#define UFFD_EVENT_REMOVE	0x15
+#define UFFD_EVENT_UNMAP	0x16
+
+/* flags for UFFD_EVENT_PAGEFAULT */
+#define UFFD_PAGEFAULT_FLAG_WRITE	(1<<0)	/* If this was a write fault */
+#define UFFD_PAGEFAULT_FLAG_WP		(1<<1)	/* If reason is VM_UFFD_WP */
+#define UFFD_PAGEFAULT_FLAG_MINOR	(1<<2)	/* If reason is VM_UFFD_MINOR */
+
+struct uffdio_api {
+	/* userland asks for an API number and the features to enable */
+	__u64 api;
+	/*
+	 * Kernel answers below with the all available features for
+	 * the API, this notifies userland of which events and/or
+	 * which flags for each event are enabled in the current
+	 * kernel.
+	 *
+	 * Note: UFFD_EVENT_PAGEFAULT and UFFD_PAGEFAULT_FLAG_WRITE
+	 * are to be considered implicitly always enabled in all kernels as
+	 * long as the uffdio_api.api requested matches UFFD_API.
+	 *
+	 * UFFD_FEATURE_MISSING_HUGETLBFS means an UFFDIO_REGISTER
+	 * with UFFDIO_REGISTER_MODE_MISSING mode will succeed on
+	 * hugetlbfs virtual memory ranges. Adding or not adding
+	 * UFFD_FEATURE_MISSING_HUGETLBFS to uffdio_api.features has
+	 * no real functional effect after UFFDIO_API returns, but
+	 * it's only useful for an initial feature set probe at
+	 * UFFDIO_API time. There are two ways to use it:
+	 *
+	 * 1) by adding UFFD_FEATURE_MISSING_HUGETLBFS to the
+	 *    uffdio_api.features before calling UFFDIO_API, an error
+	 *    will be returned by UFFDIO_API on a kernel without
+	 *    hugetlbfs missing support
+	 *
+	 * 2) the UFFD_FEATURE_MISSING_HUGETLBFS can not be added in
+	 *    uffdio_api.features and instead it will be set by the
+	 *    kernel in the uffdio_api.features if the kernel supports
+	 *    it, so userland can later check if the feature flag is
+	 *    present in uffdio_api.features after UFFDIO_API
+	 *    succeeded.
+	 *
+	 * UFFD_FEATURE_MISSING_SHMEM works the same as
+	 * UFFD_FEATURE_MISSING_HUGETLBFS, but it applies to shmem
+	 * (i.e. tmpfs and other shmem based APIs).
+	 *
+	 * UFFD_FEATURE_SIGBUS feature means no page-fault
+	 * (UFFD_EVENT_PAGEFAULT) event will be delivered, instead
+	 * a SIGBUS signal will be sent to the faulting process.
+	 *
+	 * UFFD_FEATURE_THREAD_ID pid of the page faulted task_struct will
+	 * be returned, if feature is not requested 0 will be returned.
+	 *
+	 * UFFD_FEATURE_MINOR_HUGETLBFS indicates that minor faults
+	 * can be intercepted (via REGISTER_MODE_MINOR) for
+	 * hugetlbfs-backed pages.
+	 *
+	 * UFFD_FEATURE_MINOR_SHMEM indicates the same support as
+	 * UFFD_FEATURE_MINOR_HUGETLBFS, but for shmem-backed pages instead.
+	 *
+	 * UFFD_FEATURE_EXACT_ADDRESS indicates that the exact address of page
+	 * faults would be provided and the offset within the page would not be
+	 * masked.
+	 *
+	 * UFFD_FEATURE_WP_HUGETLBFS_SHMEM indicates that userfaultfd
+	 * write-protection mode is supported on both shmem and hugetlbfs.
+	 *
+	 * UFFD_FEATURE_WP_UNPOPULATED indicates that userfaultfd
+	 * write-protection mode will always apply to unpopulated pages
+	 * (i.e. empty ptes).  This will be the default behavior for shmem
+	 * & hugetlbfs, so this flag only affects anonymous memory behavior
+	 * when userfault write-protection mode is registered.
+	 *
+	 * UFFD_FEATURE_WP_ASYNC indicates that userfaultfd write-protection
+	 * asynchronous mode is supported in which the write fault is
+	 * automatically resolved and write-protection is un-set.
+	 * It implies UFFD_FEATURE_WP_UNPOPULATED.
+	 *
+	 * UFFD_FEATURE_MOVE indicates that the kernel supports moving an
+	 * existing page contents from userspace.
+	 */
+#define UFFD_FEATURE_PAGEFAULT_FLAG_WP		(1<<0)
+#define UFFD_FEATURE_EVENT_FORK			(1<<1)
+#define UFFD_FEATURE_EVENT_REMAP		(1<<2)
+#define UFFD_FEATURE_EVENT_REMOVE		(1<<3)
+#define UFFD_FEATURE_MISSING_HUGETLBFS		(1<<4)
+#define UFFD_FEATURE_MISSING_SHMEM		(1<<5)
+#define UFFD_FEATURE_EVENT_UNMAP		(1<<6)
+#define UFFD_FEATURE_SIGBUS			(1<<7)
+#define UFFD_FEATURE_THREAD_ID			(1<<8)
+#define UFFD_FEATURE_MINOR_HUGETLBFS		(1<<9)
+#define UFFD_FEATURE_MINOR_SHMEM		(1<<10)
+#define UFFD_FEATURE_EXACT_ADDRESS		(1<<11)
+#define UFFD_FEATURE_WP_HUGETLBFS_SHMEM		(1<<12)
+#define UFFD_FEATURE_WP_UNPOPULATED		(1<<13)
+#define UFFD_FEATURE_POISON			(1<<14)
+#define UFFD_FEATURE_WP_ASYNC			(1<<15)
+#define UFFD_FEATURE_MOVE			(1<<16)
+	__u64 features;
+
+	__u64 ioctls;
+};
+
+struct uffdio_range {
+	__u64 start;
+	__u64 len;
+};
+
+struct uffdio_register {
+	struct uffdio_range range;
+#define UFFDIO_REGISTER_MODE_MISSING	((__u64)1<<0)
+#define UFFDIO_REGISTER_MODE_WP		((__u64)1<<1)
+#define UFFDIO_REGISTER_MODE_MINOR	((__u64)1<<2)
+	__u64 mode;
+
+	/*
+	 * kernel answers which ioctl commands are available for the
+	 * range, keep at the end as the last 8 bytes aren't read.
+	 */
+	__u64 ioctls;
+};
+
+struct uffdio_copy {
+	__u64 dst;
+	__u64 src;
+	__u64 len;
+#define UFFDIO_COPY_MODE_DONTWAKE		((__u64)1<<0)
+	/*
+	 * UFFDIO_COPY_MODE_WP will map the page write protected on
+	 * the fly.  UFFDIO_COPY_MODE_WP is available only if the
+	 * write protected ioctl is implemented for the range
+	 * according to the uffdio_register.ioctls.
+	 */
+#define UFFDIO_COPY_MODE_WP			((__u64)1<<1)
+	__u64 mode;
+
+	/*
+	 * "copy" is written by the ioctl and must be at the end: the
+	 * copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 copy;
+};
+
+struct uffdio_zeropage {
+	struct uffdio_range range;
+#define UFFDIO_ZEROPAGE_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * "zeropage" is written by the ioctl and must be at the end:
+	 * the copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 zeropage;
+};
+
+struct uffdio_writeprotect {
+	struct uffdio_range range;
+/*
+ * UFFDIO_WRITEPROTECT_MODE_WP: set the flag to write protect a range,
+ * unset the flag to undo protection of a range which was previously
+ * write protected.
+ *
+ * UFFDIO_WRITEPROTECT_MODE_DONTWAKE: set the flag to avoid waking up
+ * any wait thread after the operation succeeds.
+ *
+ * NOTE: Write protecting a region (WP=1) is unrelated to page faults,
+ * therefore DONTWAKE flag is meaningless with WP=1.  Removing write
+ * protection (WP=0) in response to a page fault wakes the faulting
+ * task unless DONTWAKE is set.
+ */
+#define UFFDIO_WRITEPROTECT_MODE_WP		((__u64)1<<0)
+#define UFFDIO_WRITEPROTECT_MODE_DONTWAKE	((__u64)1<<1)
+	__u64 mode;
+};
+
+struct uffdio_continue {
+	struct uffdio_range range;
+#define UFFDIO_CONTINUE_MODE_DONTWAKE		((__u64)1<<0)
+	/*
+	 * UFFDIO_CONTINUE_MODE_WP will map the page write protected on
+	 * the fly.  UFFDIO_CONTINUE_MODE_WP is available only if the
+	 * write protected ioctl is implemented for the range
+	 * according to the uffdio_register.ioctls.
+	 */
+#define UFFDIO_CONTINUE_MODE_WP			((__u64)1<<1)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 mapped;
+};
+
+struct uffdio_poison {
+	struct uffdio_range range;
+#define UFFDIO_POISON_MODE_DONTWAKE		((__u64)1<<0)
+	__u64 mode;
+
+	/*
+	 * Fields below here are written by the ioctl and must be at the end:
+	 * the copy_from_user will not read past here.
+	 */
+	__s64 updated;
+};
+
+struct uffdio_move {
+	__u64 dst;
+	__u64 src;
+	__u64 len;
+	/*
+	 * Especially if used to atomically remove memory from the
+	 * address space the wake on the dst range is not needed.
+	 */
+#define UFFDIO_MOVE_MODE_DONTWAKE		((__u64)1<<0)
+#define UFFDIO_MOVE_MODE_ALLOW_SRC_HOLES	((__u64)1<<1)
+	__u64 mode;
+	/*
+	 * "move" is written by the ioctl and must be at the end: the
+	 * copy_from_user will not read the last 8 bytes.
+	 */
+	__s64 move;
+};
+
+/*
+ * Flags for the userfaultfd(2) system call itself.
+ */
+
+/*
+ * Create a userfaultfd that can handle page faults only in user mode.
+ */
+#define UFFD_USER_MODE_ONLY 1
+
+#endif /* _LINUX_USERFAULTFD_H */
-- 
2.44.0


