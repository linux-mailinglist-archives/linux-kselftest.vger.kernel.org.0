Return-Path: <linux-kselftest+bounces-12114-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED9490C1D1
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97D91F222CC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7CB21105;
	Tue, 18 Jun 2024 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sBPxiyfS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1B51CD2D;
	Tue, 18 Jun 2024 02:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677477; cv=fail; b=oSnKOZDzpTOyPTW/znLdc9sZFFvW/0pTFDUe7bU3FGqAriKfmBIdPUuqpcCrrjmp1tsd5W9kNQC88N1j78lIDZ1psRUuNeOk0WreP4BYU6IVuUX41YsYCzdIGltOOpjCRnwAiH/3vnOgKd0Q2K6kue/3n5o/R6693FFcuN74mPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677477; c=relaxed/simple;
	bh=yoWAqqL3HUASUs927z0sLL7goDrs5qAjE2F5KFLgcLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WO34fDmDiR34A4407ZNVsXrxPQluJNQ16AlhnPg86iGZYQ+RxApOjurQ1d0T1nFbc/lTZVNSRK0mP+WTH9tEn4n8eMZ/thpeqKrFxQE0KMMGLhCv0wNrL2RK0hRkL/nHXLl1XK4ARMnMEwuns+ZJm0PVrSkqrkmjm452ISAE4lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sBPxiyfS; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bo5Q1aGjvsVVc6NUf75oZmYIHuOxw45ml384XOkzeK6lWA6uORr2ggnGLU3W6JJdHD88Da+qnRfe315BWgTjoUWJS6+Ur2X0afa3XbBTdBivrcxKKB8YfvUnpcHjLmvhVHgkH1yeUh/nTfsCbXLR/tkmfIVCVrpVXvE6X/espE4IBVw2VPz4OBRtyQgWsdLg7sU3ADD5v/T5ClfjnoG1iyYis5pj5VWFulqy5eGm9fGuBWRp7GQvOZ7R3OcYYQ6wOWI0OFg2hCKtQT7joeHXUUCPzwtd4w5hdm7FS13QpEOpak0C3nI+Y5Q/8iVAHAzjn8aH05O6ckRXsI/vFggQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+DMGwe7FqnmQLeYIMLXk1zg5zgGZ88xewuLNyoQlPg=;
 b=KXMQcoBqZYiaLaiaxzvYWoc1PSy20ezsvnaWdP4tYJCForibbgJ2Sot5dCwUZ5PKh+ZKKUCYwQrWvSpTwFAvjAahAPFSZ1gylz4MVmfDXPbhjexUjk9xyuLHoPB13yfmbpJmgRjn3kUFpa9z/C+ji51eBmZdJ1Ut1+Km3U7BigqU7HLSG657QNL5SlYddF6nHxHKvspodfNWU9pcYiVrqqQYRsz0NTNog3OidKgcz+kO5dHtOkbEbi276nBupaEwS8bIPQbaU5DS5lW3Y5Dtt64Sk8WdfZJ4Hh9MbTAUsv1oRmkTd1Z1E3OIhQ5lKzA2KQ/V4yZ06gAk19CKChrTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+DMGwe7FqnmQLeYIMLXk1zg5zgGZ88xewuLNyoQlPg=;
 b=sBPxiyfS4+YLllcltooLStjBbsOIivPwul4gA05FieE91itkUXGZwH/Lpww1TzM15X8WKdjAypjHmr/60pP5MWcK3kbrAP5JuSDqQdpiY1qL3tLUyteo8lbn+WqnLfrxa6bcQ49wphG2LnYZgvr25KNqgVJlFhFVUxn7kFq/wLyWaT6x3XyckpnmnWUiy1aJieqOUNsqkHelv1SFJifhwKCfZd5S3IdktVKufuF0Pj5uEsdQSBE+hvtrd30eZL8+4har/SBtnXzg1Xuq+4y0BCcXi2/pJ9rkiVKbvIq7cSG8Zna/RhF/yfpFCoJdG9Q+P7jte0h0FTVdsTZZ+LQ/VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:27 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:27 +0000
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
Subject: [PATCH v3 4/6] selftests/mm: fix vm_util.c build failures: add snapshot of fs.h
Date: Mon, 17 Jun 2024 19:24:20 -0700
Message-ID: <20240618022422.804305-5-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0011.namprd08.prod.outlook.com
 (2603:10b6:a03:100::24) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c13d91-e30a-4126-b616-08dc8f3dc6d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TIsYiZWkbba8o4fd19caLSSp3CUd+vNXYeviMrQo7zWspVSfiTc7FPkqQUON?=
 =?us-ascii?Q?FLK0DrPSLJPQcPbr37nmmXoDcPOoKPMJlX6LqzOvXHk6OYvNil4Kbhk/IMvN?=
 =?us-ascii?Q?XJ29Gd0cVJKn8smcdpBMDPK8vyyvyqoRNyZipL9JKI6SPoFfr9hQ53p3hUR7?=
 =?us-ascii?Q?bisz4/Cl/GszX0yno2quTsB9xc1KB9mATFUA/dYe/GKVladDqCYpCAKnte8w?=
 =?us-ascii?Q?VvviJ7ELtiZyn/lbsE72NH/iquNKBSHsx0sW4JaSYzcxvkWCygTqdmCRLRHH?=
 =?us-ascii?Q?B1yoH7RVMsfaGISAj752AZLzV/4Zdh41FBf46V1Hyg7IZVcvh3giUWCeehsy?=
 =?us-ascii?Q?Kv5NuC7gvNc6R1OT1pAfzXW0GZ1zOH+u+ypLFHtkfnyL3JYZndgxEXkTrFUS?=
 =?us-ascii?Q?sZs2VXTvYkRV5HT68RMhnBqKdellm03DKQMagwyTKZ+MJE5Q0KmReNkk44X0?=
 =?us-ascii?Q?3ysXRs+Jo1uK9m3KnV0/vv9tTEG3jNt3ONp/3jGrhKYjA267a9zbrR3VDDAN?=
 =?us-ascii?Q?0HRGollnHP+XhgeDT+VeA/ioLqgzKzfsokOUdGFjmcdEQd+XoU4NxfGeV92J?=
 =?us-ascii?Q?6BfjzAljDb1oHo9/mUsPuzdOELGdWUaEDXQyO92Nbmyu15SUxjfX4zQvgKuY?=
 =?us-ascii?Q?/PAj18/+hIm7ivVe/mMZXsiA9yyOxNtyYy7TXUNsYXlP6aSdyP9x1C++OZ2B?=
 =?us-ascii?Q?iriRJWAlmPJEuwr6uZMkwOMKoq1HX/Z+0szlNmOeFk5dR0q8QcVmWls7Uf5X?=
 =?us-ascii?Q?9jAToOksHdqgYlH69yARqO8reVBInLMXq/49+F/O8tx/DVz9YuAsE8KRrxWw?=
 =?us-ascii?Q?kjfU3CmaLRAw1TvTRuFaTQGy0xcEUV0rUhLnKgYThuELhYGBHxujQMO8lsNW?=
 =?us-ascii?Q?fUNXoFIylG8RymvwmLao5BE1gv5qMwaTnqFOxK+ujxWTEYLUaMFHRhl0MWiL?=
 =?us-ascii?Q?T//YEgeOUYSJ2YbXtq66rPu4w8U1+WEOsloAtsE5QQzDJKgOlaS+t7vtCXOT?=
 =?us-ascii?Q?GjLpZECc56ymU3q0ZodcjoLutVUkLSckWEqrtpDhop36/d/3T2FKACQTGfHl?=
 =?us-ascii?Q?F09VJsRHNCnpK4zLWmotI5yS34qer1FJz9CIbdge+Nf3gOjgq4wElPiKPGcO?=
 =?us-ascii?Q?kWzBLgAGyu0AfzzOKpI7kKOp4wf+0gWel14zz50cRSOFR+rAHBnwToEScAas?=
 =?us-ascii?Q?0WOLQSx4qKS3GlplCLc32fvKjPr1zkKEPveKB+wsfBKMsN/iNllOw6ocg1cc?=
 =?us-ascii?Q?bJIcSZc/NPQWCUn4XvwyEmJLMq5MAZgfdADrzEllGmNF0s7Gdu+6MrDamuCX?=
 =?us-ascii?Q?y9MG3kqzsuJOh2QcUVvWRjnP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rho6j8UWGU4QiVcRk7qoWLAIDkYKfYQbU9kRblD7J0W8xeVkkaFXvdAps7pT?=
 =?us-ascii?Q?FYcSrDLZYRNkAin34AyFolBrzOpLvKmVqijI8L46TyXqwMLySz3AUwey9vVW?=
 =?us-ascii?Q?lfKMS0sBeshjwMNfKXBMFmAGF2faxjpCfafszppYEEKM9/W17PFBFed2qU4D?=
 =?us-ascii?Q?HVUaGJyRQZjjmx7GxOek/kl/DpmZKZDx6+lZuF7crzs8t6yIp6qJd0ODG8ev?=
 =?us-ascii?Q?KJC1N/Uk9YWXX64HQskIbNGiAcn2RimXOLWbnl6M35GyrF+UmYzOSV9qke/c?=
 =?us-ascii?Q?Ej527YhUB7b1HWFYQS64QfEHHh1Xwj8nVjyDux+r7LDQJ10RiCJkGZ5OgpmV?=
 =?us-ascii?Q?n/TJksYetq8XdQxPcW+Z7FoSQ7YmP28nKOr/77MFeGg01wlq1otQrfNECgko?=
 =?us-ascii?Q?njfJ5U95AswqAtvH2Fhh2+T2U4ugVwABm4eyC3UffFbPBqwEqzxsAhs4v2QE?=
 =?us-ascii?Q?nBlXZU4iAXxUpuuSJgVfmIuxerEXvwsDlnSg013q5j5hTfEvcqOqXmEta9oG?=
 =?us-ascii?Q?VHkY8DILEhal8O3O/lPIUcKPG5loQMxCq7BUjjySPVF3cBVHitYe5gRbSmsg?=
 =?us-ascii?Q?bgmh2l0LbKUKPy8KKbd6/TkD4DbszcLhHyBMRxQrDR8pfC4sjKzA/Bhdqpkp?=
 =?us-ascii?Q?rFF6Z6e2Luqr01bcxBNGN2f8QqDSCd8O/mSAw7N1mPdVDvVIRvWaQ6ZWVdVW?=
 =?us-ascii?Q?8pSsC2k7eP1B73LhVZ+4Dav6Kr/hdrzQe5EfVjEewpsBQma9DJVCtcTYtEqt?=
 =?us-ascii?Q?GS1mIJnU+JF64Ofe3H/MamURF4VGogEDvgfy3mwYmzx7HDXCfJ/d7btfiGMh?=
 =?us-ascii?Q?XQ36+TlZKvhNbW3AXasy2G224NoyBM540KKQdxC1CsZCcVppNL9RWI6AD+SN?=
 =?us-ascii?Q?Do9bKUqiKu3N1hTNKJOtMvhsQrvggCIQUX+nUbmE0ubiJGw8lq1IZt6GolDV?=
 =?us-ascii?Q?5eUei5R2oEuNChOpoi1VeLPB4isUwEqmcgToD/4kQQyik45fVyVpgmcG8Q0t?=
 =?us-ascii?Q?2yduh3jOsMjV9vni+dyTHu0HR2O4znS0qGa5ozJStnY0TfN9qrAwflplln7/?=
 =?us-ascii?Q?bApRg8Q6cui+tMzFCaltiz87QpSUozZ3xZkGpFpMXhKBCrTI+2uMcLt4V2Gu?=
 =?us-ascii?Q?74CoLV3KNAytnWME/yv8JUJ8c+BhFdHsjrWrguIY1bSMrvpBmkOp73jPDu3w?=
 =?us-ascii?Q?scnn1v/NcokULCzVlNlECdfTKhMwXw/9VNu4rIvLzs3tN8maiSqhNoalJuuK?=
 =?us-ascii?Q?2DGa/Tmp52A/qEmXclWWPNmnhgVj2qvi74jCG7lwQyg+58NX5k9yKHoigFVK?=
 =?us-ascii?Q?IYtK16YHIuOFkQdTX0h/wJ5muvanvY2Kc3y5uXYnWcAfRJuhEEbqgn9Pp0P8?=
 =?us-ascii?Q?56Hg1hF9IpbKHQ1S5XuOA2u49cOvkBGHgpoISRbbCi5Mc6I2PMGWgh5g99FZ?=
 =?us-ascii?Q?FqzBh57biKeDaz7+h9uS8OZdru18yi643k+UXOOYNbh7PjYhQUTyutNLUsf/?=
 =?us-ascii?Q?f7YDznhsKfzoKqgyGrUKNs6YrkktC3bnZCA0AY61HyC5FauAGokKmOMgA86S?=
 =?us-ascii?Q?ZpFqoZ/gM0QgvNfPPwOeSdEcQtgcvx8mP5/FsdQ+?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c13d91-e30a-4126-b616-08dc8f3dc6d0
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:27.2789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iKHQsZD44KAe5NvsxSiaffJ02M8XEPXl9IheGRmN6WbOwMZsJTMBWMWGT9GL6lgDLzUwwXKw7mY1yEo+cAok+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

On Ubuntu 23.04, on a clean git tree, the selftests/mm build fails due
10 or 20 missing items, all of which are found in fs.h, which is created
via "make headers". However, as per [1], the idea is to stop requiring
"make headers", and instead, take a snapshot of the files and check them
in.

Here are a few of the build errors:

vm_util.c:34:21: error: variable has incomplete type 'struct pm_scan_arg'
        struct pm_scan_arg arg;
...
vm_util.c:45:28: error: use of undeclared identifier 'PAGE_IS_WPALLOWED'
...
vm_util.c:55:21: error: variable has incomplete type 'struct page_region'
...
vm_util.c:105:20: error: use of undeclared identifier 'PAGE_IS_SOFT_DIRTY'

To fix this, add fs.h, taken from a snapshot of ./usr/include/linux/fs.h
after running "make headers".

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/include/uapi/linux/fs.h | 392 ++++++++++++++++++++++++++++++++++
 1 file changed, 392 insertions(+)
 create mode 100644 tools/include/uapi/linux/fs.h

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
new file mode 100644
index 000000000000..ca9d754bae04
--- /dev/null
+++ b/tools/include/uapi/linux/fs.h
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_FS_H
+#define _LINUX_FS_H
+
+/*
+ * This file has definitions for some important file table structures
+ * and constants and structures used by various generic file system
+ * ioctl's.  Please do not make any changes in this file before
+ * sending patches for review to linux-fsdevel@vger.kernel.org and
+ * linux-api@vger.kernel.org.
+ */
+
+#include <linux/limits.h>
+#include <linux/ioctl.h>
+#include <linux/types.h>
+#include <linux/fscrypt.h>
+
+/* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
+#include <linux/mount.h>
+
+/*
+ * It's silly to have NR_OPEN bigger than NR_FILE, but you can change
+ * the file limit at runtime and only root can increase the per-process
+ * nr_file rlimit, so it's safe to set up a ridiculously high absolute
+ * upper limit on files-per-process.
+ *
+ * Some programs (notably those using select()) may have to be 
+ * recompiled to take full advantage of the new limits..  
+ */
+
+/* Fixed constants first: */
+#undef NR_OPEN
+#define INR_OPEN_CUR 1024	/* Initial setting for nfile rlimits */
+#define INR_OPEN_MAX 4096	/* Hard limit for nfile rlimits */
+
+#define BLOCK_SIZE_BITS 10
+#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
+
+#define SEEK_SET	0	/* seek relative to beginning of file */
+#define SEEK_CUR	1	/* seek relative to current file position */
+#define SEEK_END	2	/* seek relative to end of file */
+#define SEEK_DATA	3	/* seek to the next data */
+#define SEEK_HOLE	4	/* seek to the next hole */
+#define SEEK_MAX	SEEK_HOLE
+
+#define RENAME_NOREPLACE	(1 << 0)	/* Don't overwrite target */
+#define RENAME_EXCHANGE		(1 << 1)	/* Exchange source and dest */
+#define RENAME_WHITEOUT		(1 << 2)	/* Whiteout source */
+
+struct file_clone_range {
+	__s64 src_fd;
+	__u64 src_offset;
+	__u64 src_length;
+	__u64 dest_offset;
+};
+
+struct fstrim_range {
+	__u64 start;
+	__u64 len;
+	__u64 minlen;
+};
+
+/*
+ * We include a length field because some filesystems (vfat) have an identifier
+ * that we do want to expose as a UUID, but doesn't have the standard length.
+ *
+ * We use a fixed size buffer beacuse this interface will, by fiat, never
+ * support "UUIDs" longer than 16 bytes; we don't want to force all downstream
+ * users to have to deal with that.
+ */
+struct fsuuid2 {
+	__u8	len;
+	__u8	uuid[16];
+};
+
+struct fs_sysfs_path {
+	__u8			len;
+	__u8			name[128];
+};
+
+/* extent-same (dedupe) ioctls; these MUST match the btrfs ioctl definitions */
+#define FILE_DEDUPE_RANGE_SAME		0
+#define FILE_DEDUPE_RANGE_DIFFERS	1
+
+/* from struct btrfs_ioctl_file_extent_same_info */
+struct file_dedupe_range_info {
+	__s64 dest_fd;		/* in - destination file */
+	__u64 dest_offset;	/* in - start of extent in destination */
+	__u64 bytes_deduped;	/* out - total # of bytes we were able
+				 * to dedupe from this file. */
+	/* status of this dedupe operation:
+	 * < 0 for error
+	 * == FILE_DEDUPE_RANGE_SAME if dedupe succeeds
+	 * == FILE_DEDUPE_RANGE_DIFFERS if data differs
+	 */
+	__s32 status;		/* out - see above description */
+	__u32 reserved;		/* must be zero */
+};
+
+/* from struct btrfs_ioctl_file_extent_same_args */
+struct file_dedupe_range {
+	__u64 src_offset;	/* in - start of extent in source */
+	__u64 src_length;	/* in - length of extent */
+	__u16 dest_count;	/* in - total elements in info array */
+	__u16 reserved1;	/* must be zero */
+	__u32 reserved2;	/* must be zero */
+	struct file_dedupe_range_info info[];
+};
+
+/* And dynamically-tunable limits and defaults: */
+struct files_stat_struct {
+	unsigned long nr_files;		/* read only */
+	unsigned long nr_free_files;	/* read only */
+	unsigned long max_files;		/* tunable */
+};
+
+struct inodes_stat_t {
+	long nr_inodes;
+	long nr_unused;
+	long dummy[5];		/* padding for sysctl ABI compatibility */
+};
+
+
+#define NR_FILE  8192	/* this can well be larger on a larger system */
+
+/*
+ * Structure for FS_IOC_FSGETXATTR[A] and FS_IOC_FSSETXATTR.
+ */
+struct fsxattr {
+	__u32		fsx_xflags;	/* xflags field value (get/set) */
+	__u32		fsx_extsize;	/* extsize field value (get/set)*/
+	__u32		fsx_nextents;	/* nextents field value (get)	*/
+	__u32		fsx_projid;	/* project identifier (get/set) */
+	__u32		fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	unsigned char	fsx_pad[8];
+};
+
+/*
+ * Flags for the fsx_xflags field
+ */
+#define FS_XFLAG_REALTIME	0x00000001	/* data in realtime volume */
+#define FS_XFLAG_PREALLOC	0x00000002	/* preallocated file extents */
+#define FS_XFLAG_IMMUTABLE	0x00000008	/* file cannot be modified */
+#define FS_XFLAG_APPEND		0x00000010	/* all writes append */
+#define FS_XFLAG_SYNC		0x00000020	/* all writes synchronous */
+#define FS_XFLAG_NOATIME	0x00000040	/* do not update access time */
+#define FS_XFLAG_NODUMP		0x00000080	/* do not include in backups */
+#define FS_XFLAG_RTINHERIT	0x00000100	/* create with rt bit set */
+#define FS_XFLAG_PROJINHERIT	0x00000200	/* create with parents projid */
+#define FS_XFLAG_NOSYMLINKS	0x00000400	/* disallow symlink creation */
+#define FS_XFLAG_EXTSIZE	0x00000800	/* extent size allocator hint */
+#define FS_XFLAG_EXTSZINHERIT	0x00001000	/* inherit inode extent size */
+#define FS_XFLAG_NODEFRAG	0x00002000	/* do not defragment */
+#define FS_XFLAG_FILESTREAM	0x00004000	/* use filestream allocator */
+#define FS_XFLAG_DAX		0x00008000	/* use DAX for IO */
+#define FS_XFLAG_COWEXTSIZE	0x00010000	/* CoW extent size allocator hint */
+#define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
+
+/* the read-only stuff doesn't really belong here, but any other place is
+   probably as bad and I don't want to create yet another include file. */
+
+#define BLKROSET   _IO(0x12,93)	/* set device read-only (0 = read-write) */
+#define BLKROGET   _IO(0x12,94)	/* get read-only status (0 = read_write) */
+#define BLKRRPART  _IO(0x12,95)	/* re-read partition table */
+#define BLKGETSIZE _IO(0x12,96)	/* return device size /512 (long *arg) */
+#define BLKFLSBUF  _IO(0x12,97)	/* flush buffer cache */
+#define BLKRASET   _IO(0x12,98)	/* set read ahead for block device */
+#define BLKRAGET   _IO(0x12,99)	/* get current read ahead setting */
+#define BLKFRASET  _IO(0x12,100)/* set filesystem (mm/filemap.c) read-ahead */
+#define BLKFRAGET  _IO(0x12,101)/* get filesystem (mm/filemap.c) read-ahead */
+#define BLKSECTSET _IO(0x12,102)/* set max sectors per request (ll_rw_blk.c) */
+#define BLKSECTGET _IO(0x12,103)/* get max sectors per request (ll_rw_blk.c) */
+#define BLKSSZGET  _IO(0x12,104)/* get block device sector size */
+#if 0
+#define BLKPG      _IO(0x12,105)/* See blkpg.h */
+
+/* Some people are morons.  Do not use sizeof! */
+
+#define BLKELVGET  _IOR(0x12,106,size_t)/* elevator get */
+#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */
+/* This was here just to show that the number is taken -
+   probably all these _IO(0x12,*) ioctls should be moved to blkpg.h. */
+#endif
+/* A jump here: 108-111 have been used for various private purposes. */
+#define BLKBSZGET  _IOR(0x12,112,size_t)
+#define BLKBSZSET  _IOW(0x12,113,size_t)
+#define BLKGETSIZE64 _IOR(0x12,114,size_t)	/* return device size in bytes (u64 *arg) */
+#define BLKTRACESETUP _IOWR(0x12,115,struct blk_user_trace_setup)
+#define BLKTRACESTART _IO(0x12,116)
+#define BLKTRACESTOP _IO(0x12,117)
+#define BLKTRACETEARDOWN _IO(0x12,118)
+#define BLKDISCARD _IO(0x12,119)
+#define BLKIOMIN _IO(0x12,120)
+#define BLKIOOPT _IO(0x12,121)
+#define BLKALIGNOFF _IO(0x12,122)
+#define BLKPBSZGET _IO(0x12,123)
+#define BLKDISCARDZEROES _IO(0x12,124)
+#define BLKSECDISCARD _IO(0x12,125)
+#define BLKROTATIONAL _IO(0x12,126)
+#define BLKZEROOUT _IO(0x12,127)
+#define BLKGETDISKSEQ _IOR(0x12,128,__u64)
+/*
+ * A jump here: 130-136 are reserved for zoned block devices
+ * (see uapi/linux/blkzoned.h)
+ */
+
+#define BMAP_IOCTL 1		/* obsolete - kept for compatibility */
+#define FIBMAP	   _IO(0x00,1)	/* bmap access */
+#define FIGETBSZ   _IO(0x00,2)	/* get the block size used for bmap */
+#define FIFREEZE	_IOWR('X', 119, int)	/* Freeze */
+#define FITHAW		_IOWR('X', 120, int)	/* Thaw */
+#define FITRIM		_IOWR('X', 121, struct fstrim_range)	/* Trim */
+#define FICLONE		_IOW(0x94, 9, int)
+#define FICLONERANGE	_IOW(0x94, 13, struct file_clone_range)
+#define FIDEDUPERANGE	_IOWR(0x94, 54, struct file_dedupe_range)
+
+#define FSLABEL_MAX 256	/* Max chars for the interface; each fs may differ */
+
+#define	FS_IOC_GETFLAGS			_IOR('f', 1, long)
+#define	FS_IOC_SETFLAGS			_IOW('f', 2, long)
+#define	FS_IOC_GETVERSION		_IOR('v', 1, long)
+#define	FS_IOC_SETVERSION		_IOW('v', 2, long)
+#define FS_IOC_FIEMAP			_IOWR('f', 11, struct fiemap)
+#define FS_IOC32_GETFLAGS		_IOR('f', 1, int)
+#define FS_IOC32_SETFLAGS		_IOW('f', 2, int)
+#define FS_IOC32_GETVERSION		_IOR('v', 1, int)
+#define FS_IOC32_SETVERSION		_IOW('v', 2, int)
+#define FS_IOC_FSGETXATTR		_IOR('X', 31, struct fsxattr)
+#define FS_IOC_FSSETXATTR		_IOW('X', 32, struct fsxattr)
+#define FS_IOC_GETFSLABEL		_IOR(0x94, 49, char[FSLABEL_MAX])
+#define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
+/* Returns the external filesystem UUID, the same one blkid returns */
+#define FS_IOC_GETFSUUID		_IOR(0x15, 0, struct fsuuid2)
+/*
+ * Returns the path component under /sys/fs/ that refers to this filesystem;
+ * also /sys/kernel/debug/ for filesystems with debugfs exports
+ */
+#define FS_IOC_GETFSSYSFSPATH		_IOR(0x15, 1, struct fs_sysfs_path)
+
+/*
+ * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
+ *
+ * Note: for historical reasons, these flags were originally used and
+ * defined for use by ext2/ext3, and then other file systems started
+ * using these flags so they wouldn't need to write their own version
+ * of chattr/lsattr (which was shipped as part of e2fsprogs).  You
+ * should think twice before trying to use these flags in new
+ * contexts, or trying to assign these flags, since they are used both
+ * as the UAPI and the on-disk encoding for ext2/3/4.  Also, we are
+ * almost out of 32-bit flags.  :-)
+ *
+ * We have recently hoisted FS_IOC_FSGETXATTR / FS_IOC_FSSETXATTR from
+ * XFS to the generic FS level interface.  This uses a structure that
+ * has padding and hence has more room to grow, so it may be more
+ * appropriate for many new use cases.
+ *
+ * Please do not change these flags or interfaces before checking with
+ * linux-fsdevel@vger.kernel.org and linux-api@vger.kernel.org.
+ */
+#define	FS_SECRM_FL			0x00000001 /* Secure deletion */
+#define	FS_UNRM_FL			0x00000002 /* Undelete */
+#define	FS_COMPR_FL			0x00000004 /* Compress file */
+#define FS_SYNC_FL			0x00000008 /* Synchronous updates */
+#define FS_IMMUTABLE_FL			0x00000010 /* Immutable file */
+#define FS_APPEND_FL			0x00000020 /* writes to file may only append */
+#define FS_NODUMP_FL			0x00000040 /* do not dump file */
+#define FS_NOATIME_FL			0x00000080 /* do not update atime */
+/* Reserved for compression usage... */
+#define FS_DIRTY_FL			0x00000100
+#define FS_COMPRBLK_FL			0x00000200 /* One or more compressed clusters */
+#define FS_NOCOMP_FL			0x00000400 /* Don't compress */
+/* End compression flags --- maybe not all used */
+#define FS_ENCRYPT_FL			0x00000800 /* Encrypted file */
+#define FS_BTREE_FL			0x00001000 /* btree format dir */
+#define FS_INDEX_FL			0x00001000 /* hash-indexed directory */
+#define FS_IMAGIC_FL			0x00002000 /* AFS directory */
+#define FS_JOURNAL_DATA_FL		0x00004000 /* Reserved for ext3 */
+#define FS_NOTAIL_FL			0x00008000 /* file tail should not be merged */
+#define FS_DIRSYNC_FL			0x00010000 /* dirsync behaviour (directories only) */
+#define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
+#define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
+#define FS_EXTENT_FL			0x00080000 /* Extents */
+#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
+#define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
+#define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
+#define FS_NOCOW_FL			0x00800000 /* Do not cow file */
+#define FS_DAX_FL			0x02000000 /* Inode is DAX */
+#define FS_INLINE_DATA_FL		0x10000000 /* Reserved for ext4 */
+#define FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
+#define FS_CASEFOLD_FL			0x40000000 /* Folder is case insensitive */
+#define FS_RESERVED_FL			0x80000000 /* reserved for ext2 lib */
+
+#define FS_FL_USER_VISIBLE		0x0003DFFF /* User visible flags */
+#define FS_FL_USER_MODIFIABLE		0x000380FF /* User modifiable flags */
+
+
+#define SYNC_FILE_RANGE_WAIT_BEFORE	1
+#define SYNC_FILE_RANGE_WRITE		2
+#define SYNC_FILE_RANGE_WAIT_AFTER	4
+#define SYNC_FILE_RANGE_WRITE_AND_WAIT	(SYNC_FILE_RANGE_WRITE | \
+					 SYNC_FILE_RANGE_WAIT_BEFORE | \
+					 SYNC_FILE_RANGE_WAIT_AFTER)
+
+/*
+ * Flags for preadv2/pwritev2:
+ */
+
+typedef int __bitwise __kernel_rwf_t;
+
+/* high priority request, poll if possible */
+#define RWF_HIPRI	((__kernel_rwf_t)0x00000001)
+
+/* per-IO O_DSYNC */
+#define RWF_DSYNC	((__kernel_rwf_t)0x00000002)
+
+/* per-IO O_SYNC */
+#define RWF_SYNC	((__kernel_rwf_t)0x00000004)
+
+/* per-IO, return -EAGAIN if operation would block */
+#define RWF_NOWAIT	((__kernel_rwf_t)0x00000008)
+
+/* per-IO O_APPEND */
+#define RWF_APPEND	((__kernel_rwf_t)0x00000010)
+
+/* per-IO negation of O_APPEND */
+#define RWF_NOAPPEND	((__kernel_rwf_t)0x00000020)
+
+/* mask of flags supported by the kernel */
+#define RWF_SUPPORTED	(RWF_HIPRI | RWF_DSYNC | RWF_SYNC | RWF_NOWAIT |\
+			 RWF_APPEND | RWF_NOAPPEND)
+
+/* Pagemap ioctl */
+#define PAGEMAP_SCAN	_IOWR('f', 16, struct pm_scan_arg)
+
+/* Bitmasks provided in pm_scan_args masks and reported in page_region.categories. */
+#define PAGE_IS_WPALLOWED	(1 << 0)
+#define PAGE_IS_WRITTEN		(1 << 1)
+#define PAGE_IS_FILE		(1 << 2)
+#define PAGE_IS_PRESENT		(1 << 3)
+#define PAGE_IS_SWAPPED		(1 << 4)
+#define PAGE_IS_PFNZERO		(1 << 5)
+#define PAGE_IS_HUGE		(1 << 6)
+#define PAGE_IS_SOFT_DIRTY	(1 << 7)
+
+/*
+ * struct page_region - Page region with flags
+ * @start:	Start of the region
+ * @end:	End of the region (exclusive)
+ * @categories:	PAGE_IS_* category bitmask for the region
+ */
+struct page_region {
+	__u64 start;
+	__u64 end;
+	__u64 categories;
+};
+
+/* Flags for PAGEMAP_SCAN ioctl */
+#define PM_SCAN_WP_MATCHING	(1 << 0)	/* Write protect the pages matched. */
+#define PM_SCAN_CHECK_WPASYNC	(1 << 1)	/* Abort the scan when a non-WP-enabled page is found. */
+
+/*
+ * struct pm_scan_arg - Pagemap ioctl argument
+ * @size:		Size of the structure
+ * @flags:		Flags for the IOCTL
+ * @start:		Starting address of the region
+ * @end:		Ending address of the region
+ * @walk_end		Address where the scan stopped (written by kernel).
+ *			walk_end == end (address tags cleared) informs that the scan completed on entire range.
+ * @vec:		Address of page_region struct array for output
+ * @vec_len:		Length of the page_region struct array
+ * @max_pages:		Optional limit for number of returned pages (0 = disabled)
+ * @category_inverted:	PAGE_IS_* categories which values match if 0 instead of 1
+ * @category_mask:	Skip pages for which any category doesn't match
+ * @category_anyof_mask: Skip pages for which no category matches
+ * @return_mask:	PAGE_IS_* categories that are to be reported in `page_region`s returned
+ */
+struct pm_scan_arg {
+	__u64 size;
+	__u64 flags;
+	__u64 start;
+	__u64 end;
+	__u64 walk_end;
+	__u64 vec;
+	__u64 vec_len;
+	__u64 max_pages;
+	__u64 category_inverted;
+	__u64 category_mask;
+	__u64 category_anyof_mask;
+	__u64 return_mask;
+};
+
+#endif /* _LINUX_FS_H */
-- 
2.45.2


