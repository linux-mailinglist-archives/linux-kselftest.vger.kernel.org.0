Return-Path: <linux-kselftest+bounces-12115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E6690C1D2
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:25:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C626B20FD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CDD2233A;
	Tue, 18 Jun 2024 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AhlobOrt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2304F1D69E;
	Tue, 18 Jun 2024 02:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677478; cv=fail; b=K7Sn2oe4I7y1GwMeewjQi0PXyykxMDJvev8Dg4ZrgenOubeA96iQPVh08QQg3Tp9gMml4PPVGGfQyAoqdT8/okHbTPgTdx5plf/XmQ4ZBVI3UNhZKMFJVkEUJ839+RTtrFZBQHx5Bof1mhGvIZEfBhBxYRP+Wf1NK/dbGz2i6QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677478; c=relaxed/simple;
	bh=r25R3DLw42bRvjPfM3GMuKdb4gojkuS9PIw/UC3TZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h91uFnlHtvsXfKmnIfjLoBby97hI6e/2S0hqBVzfkennZAWfixqGqfn1LsTJaPYsOg1BArMDxLoVR4HSp7RWeDYv7YxNGEN+hwE+6cGVV6EB9z6TApbxqXr48dqxERYLKxQI2GKU0OjXIa5Gc4XTBSeqV24w0otBDjJ3A2JV96k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AhlobOrt; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDrr9S0oRn+91wwIiq294ubX+avDQOwls+aSZdoS97GzRNg46cCyV7onvTF3JhgIg7ufoT+GudPUF3pS+ptq6HogrkSzWNHdtpnBizG/YJSjf3lefg2WLQnhvD2wyYYzkTqmvTDq9Y4FO7rPXCjn4rLkBVG6t4ui+4tqhymhNNMPQy2G6Q/6LVUe5ZMGh3QMcnJ1QIM0xiSmgr5F2/1JKhaAuYDpAMaKEBvL5dwbLpMeK0f23E96rvwucf194xJTFlEBExmQhdKT6SoNz6WN3Fwq/Bm/3MtoygXW95B4ryyveeY1O9BtPd96eQ0km3nfPo7kdAQxKbPEUyxQqQdi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4WrJZsMOp+aqB2aUs9lp8RMTT8HkgthjIv6hrWU1MrU=;
 b=KNTx82HyDraD0RMqW7QMOty/gSPsOuM6ZSk2jMBUpOZ+UOe3yVJLNTB4UuyX+KwI+wr9E4aK0xGW3cE6zFLWRJNp0bNhfSVs140eHXcIBSbMr+zajhnm5DGUEH07K4/IjbWZeV+6QH/+zfGQhmUCYABy4wocoSO8Y6jlHc/EJ/5+DGeoCBrHjtYL6gM9RxECTUNf6gOmWpE9bzPqNl9A1ebpUTJ2x325CF9mvWya4RD2CpSI/gyUyeRFbs1H33TaaQRQ2Did+oyhWBZl1xtC4QejVW64bfEDeG3n/4mPZNPWDBLyUm4boklrkcXu0sasCRvB3LV6is+MAUzQDkmeTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4WrJZsMOp+aqB2aUs9lp8RMTT8HkgthjIv6hrWU1MrU=;
 b=AhlobOrtlM0TA3PddqACMmosnzhlwwIGhiqqeuZShqeDlxap11Q3xqG+z7m+3aZbWWfdJEsqTczxmDh3q2fc52AfKsxEI02KTDN9S3gg0pZBf8UT59M7ygUst+XR/WKYAiH4DPRURMVicKY+h3zRQB73t/6fpw+chmw8eXHGDIsCo2bJqpubhA7J1MkhPWn4oXTbkT/SlSvzuAVhwBri8foRaEqXA1FSRPAWZLF+konjIPvQx26nEPvElKStrOvxvFO9VubflNKMmQSP+tfO7UsYIt1AtAJZTI+1yPOeNkP0FB16GF8lDpA6AmUSYGi4m7DI3T94cH0Xb5yiB6YHlA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:28 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:28 +0000
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
Subject: [PATCH v3 5/6] selftests/mm: kvm, mdwe fixes to avoid requiring "make headers"
Date: Mon, 17 Jun 2024 19:24:21 -0700
Message-ID: <20240618022422.804305-6-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:a03:100::44) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 097689c9-3b85-48c6-9f82-08dc8f3dc77c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?brUIShgwJo/KYRpEuOBq71ayEfuUiXSwAaxjf0u1g4ZOmGJ+gFbPt+mREJvZ?=
 =?us-ascii?Q?X6uFq6AUSGTM9skJcgVEvBVXQUmzCdG/hPDMmee/Q28EYa2d+fTebgk+ttoz?=
 =?us-ascii?Q?sHdD05cLXV+7jfwNYKUTs1kxx7Wh9drjb2Qtz8Aq3TH80EjQeMjS0hZ8uwbH?=
 =?us-ascii?Q?GP90G5C2eso+3Si7J7tR8BSr2zwgu73MF7ThCHtTzQdbc9mSc0ymRlEUv8kW?=
 =?us-ascii?Q?wbaU6iPKxo4BfDLcxD7f43xN4KT/McRkAlxXaAkEPWmgUwZaGwpoixTEZm7z?=
 =?us-ascii?Q?ysiNxiAnj+5z/p+QS0qbtMsRYC+TcIQ1/ZPR1rDimY2nPrs3ksXu0kHcD0mo?=
 =?us-ascii?Q?ojMh1uk9O9gGnJh/q2w+jDv+QPmoSTU1zpuR8C6IFWcsRxfey6JRAbh/ancF?=
 =?us-ascii?Q?rp/HJ5QDrpY7qbbdk+0zrA6a1ENw/ACdVrxlDcqaG3kRbYSLzr5lbIOHdk+K?=
 =?us-ascii?Q?6NGgbziCZpwrl5Xy0tS5khCFWLm1QUKjOGG44E7xqbOMxGQb0fF5npiOMb7N?=
 =?us-ascii?Q?DHA7ivXiirJJXM4ucj4ASYOzbdIRguhCadh/eYmXxqicLwpVJzX2CWd4w8Db?=
 =?us-ascii?Q?vP3F9VE/ZYQ0iWz4Vp4q7LQVlA4HdfC6g+uZsnpUuTo43t7QAcf5Igo4Cj/A?=
 =?us-ascii?Q?Y7O/KVFEuGjko0mbyDqMmkuPc9KNi4RvbTH/xYcpxKScQ9Cw544sUtICZkju?=
 =?us-ascii?Q?w/GRhDzlhRs0M5F2Q/5H/KWD7LSd0rPJFcd8FMHORgCgVKFPeL03KOR2k6BC?=
 =?us-ascii?Q?NYNRYql/2MamKL3Q/7avmvCG+JlvFipTfwXoVSiVqgrgS5Smw3XTiOcqvRuE?=
 =?us-ascii?Q?aqzTHil9jCV9qF1mwY8DyumcBY2ZHrPl3upPt0sWDfo277kgvp8MHndL3Ix0?=
 =?us-ascii?Q?FwxPBSom55hKq8acJ8fBs0Up8po+ITybeerFZ60q9y81J9W7bH3ZPW4oe56h?=
 =?us-ascii?Q?K+RN1Iy2q0FUPTztbXhDQfXy269Nm3JnRvavYXpKYmUwcPofTRtHae1fYnhs?=
 =?us-ascii?Q?Y0qnRongnIkmcCPZ34J1FFxKwRdW4kRWM9YRJdpn7VTOV/f+Lz+aIchx8w1k?=
 =?us-ascii?Q?VgPE1u3iLmqxJ9afa+/lUD1SmDW9oSWetnc5HiIggF4gUSDqI4lq61kwpwBY?=
 =?us-ascii?Q?jndIKpqkV2pecqql0mk/J4sj2MSYeJoi4FByOvxGuPqgoBMeHmL8ZRRM/YJc?=
 =?us-ascii?Q?A53+XoCL78MnHmOJes/abYvbjP+OF2K4p7UVvTV7KWJTFCNgtiHyqnW25XZg?=
 =?us-ascii?Q?jaBa98J0OYXVxJ3kB8xVSDA0J8RZrp0vo//P7YErq2adzyySVnFisc/bFqiG?=
 =?us-ascii?Q?phXuGkD1DgCYgGY1f3UmtSu9?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hBpX8LMzeWxBz3bIWqUnzJMRP1pdMBuTzkRnItu0kgATfOf4FAbtACMaV70D?=
 =?us-ascii?Q?rZMlHnRlYL/jr+HZFgpzt4LHACAK1DMfgk5OsGkDLQ0Lq1+ZGdghLlOjNFZS?=
 =?us-ascii?Q?RsjVFZrCNxkSCnJcjcV8GiI/nqL5rYGpUkpeAhgMbdlkhHBO1sqcWBmuN8t+?=
 =?us-ascii?Q?d3bWMS1hU/t9Wfc0oHvIDxR0IQfT5AA+tNm7rTB4Q0BtAx1C62BIBQg2XqwD?=
 =?us-ascii?Q?kbXf5DDX1i797Go84BFH7L6LKlZULkDkyZJVglU59SPRJGPbvEz+ELXEnZp1?=
 =?us-ascii?Q?JtMdDi526azFiJHWShdQYaMyUIYbEVidkvQv64CWiO77vrCeEzXNKekBqsBu?=
 =?us-ascii?Q?qNH7wq0tKvE90rt1ppkrwo9CVi4L+5wKR0ZfXsJFuKGZcgrf8VT5YPdp3dH5?=
 =?us-ascii?Q?PhFBswjF+7Q9ZbTa/SvmzoNi1ohXe4wYe6aYeP5sY2r0WKWEt2va+923D+W1?=
 =?us-ascii?Q?rp7MBvWJhB2iKTTaD4bEzjtTILFIgh3Jb2Z1xIrA5DnQng0oxriIPXsAxzJe?=
 =?us-ascii?Q?nrztgAmi/3idI7kRQtVGHd8Mh1RcTgfznLj8MxlgPMQq1VJzhMi6OJe6ECsi?=
 =?us-ascii?Q?HMtTEOIpqRQ5zdvto/7clxwQ2/6BQIMSe6b8jbmd3A/K5n/G708ozSVpLXgY?=
 =?us-ascii?Q?HQQ+RLFWIdAF5xu6TlDOWjlhNEgciflrz963GGTgY8UX4Fbt3FDuyxCRDQwm?=
 =?us-ascii?Q?lJjUdXxTKA9JwMtAqu5nrsPdO6H46l6Cr2biK1xjp/Q6P/HlshObn9d/p7FI?=
 =?us-ascii?Q?+4mnTlPj/wsNbWJoGzmsnUZSDNyRx2mAmX0IR0MlZMBXv69w4NDSqSDgCgbB?=
 =?us-ascii?Q?cVxPvUAmv/vH7GXEDsSKJu4hOKd70WR/HLUIrvAhs4OL8RJRxDfCrfYyLWId?=
 =?us-ascii?Q?i+4Yazx1nun7zLmAz6RuHBP7XPIKDk5DEJi5XOhd4+C0PWOTq4WVtiEGpCaZ?=
 =?us-ascii?Q?T4NYhUsBSC6xAZjPXVylKR6mNa5vmVCpa29TDzGPum1/0RqHKJUnA9xJNOU5?=
 =?us-ascii?Q?5GukvWvCHFhuwwE0REbZoLvCTKMLqOnj/NZ0aXJORDdo7Tz++ASMkdXrmvem?=
 =?us-ascii?Q?3otSRS78T0y+9mx/6mADQJvmTkGUMFIBJka/ofUhW6Eeu1Tut7A2BMvzEeAQ?=
 =?us-ascii?Q?YZnV4w4uCSdlUhB7SrgU2UaYyGlG8V593cx9aAuErDKelYyYJDHXnUjdjAgd?=
 =?us-ascii?Q?K58JulX565adPcJ+MSm+1PKCCs80CA6hUy8U7g7TvBUR5Ji/jYVqyW9ANUFV?=
 =?us-ascii?Q?Tfn8wItuduEyjLt0clc2hyIcYg7tZ0v1Ysy+1+6TXvuJjq6zs5ygnfeloQEb?=
 =?us-ascii?Q?t9EDM3Q01WHZX2O1kklC0pqkhPudfiGzGVJg8rcFeKQeqJvIEh+2Y8vqfnjY?=
 =?us-ascii?Q?DwQ3IRyjJXhzFwUINRRL5KoVRAB9KfMf7qmDyLyN94dmZKYbo8kfrVgphKHe?=
 =?us-ascii?Q?mtxBwG80ym8mLJsNWqzaUAzVK/AWJ2Q3du3LUrRH1vmRiHK0V9q9yP/i4mOn?=
 =?us-ascii?Q?TRkQcNtzrlDj8bypitUg+8XlA4VdKgK/xLZQCgi3Dj/l6WdWEIrAklaVub8w?=
 =?us-ascii?Q?bav+QEHVub/S/xAT1GpNMH++6E/YKWDgqXDqgzux?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097689c9-3b85-48c6-9f82-08dc8f3dc77c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:28.3026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSCeEj0YnJgUbH+ry1AHGvrcB2a0QvboOKXJy96oXAJtjm67FQtyq0MnvyCTcntKe1uuuzKtXJqPXqyiQO8Xig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
missing a few items that are found in prctl.h. Here is an excerpt of the
build failures:

ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
...
mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'

Fix these errors by adding a new tools/include/uapi/linux/prctl.h . This
file was created by running "make headers", and then copying a snapshot
over from ./usr/include/linux/prctl.h, as per the approach we settled on
in [1].

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/include/uapi/linux/prctl.h | 331 +++++++++++++++++++++++++++++++
 1 file changed, 331 insertions(+)
 create mode 100644 tools/include/uapi/linux/prctl.h

diff --git a/tools/include/uapi/linux/prctl.h b/tools/include/uapi/linux/prctl.h
new file mode 100644
index 000000000000..35791791a879
--- /dev/null
+++ b/tools/include/uapi/linux/prctl.h
@@ -0,0 +1,331 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef _LINUX_PRCTL_H
+#define _LINUX_PRCTL_H
+
+#include <linux/types.h>
+
+/* Values to pass as first argument to prctl() */
+
+#define PR_SET_PDEATHSIG  1  /* Second arg is a signal */
+#define PR_GET_PDEATHSIG  2  /* Second arg is a ptr to return the signal */
+
+/* Get/set current->mm->dumpable */
+#define PR_GET_DUMPABLE   3
+#define PR_SET_DUMPABLE   4
+
+/* Get/set unaligned access control bits (if meaningful) */
+#define PR_GET_UNALIGN	  5
+#define PR_SET_UNALIGN	  6
+# define PR_UNALIGN_NOPRINT	1	/* silently fix up unaligned user accesses */
+# define PR_UNALIGN_SIGBUS	2	/* generate SIGBUS on unaligned user access */
+
+/* Get/set whether or not to drop capabilities on setuid() away from
+ * uid 0 (as per security/commoncap.c) */
+#define PR_GET_KEEPCAPS   7
+#define PR_SET_KEEPCAPS   8
+
+/* Get/set floating-point emulation control bits (if meaningful) */
+#define PR_GET_FPEMU  9
+#define PR_SET_FPEMU 10
+# define PR_FPEMU_NOPRINT	1	/* silently emulate fp operations accesses */
+# define PR_FPEMU_SIGFPE	2	/* don't emulate fp operations, send SIGFPE instead */
+
+/* Get/set floating-point exception mode (if meaningful) */
+#define PR_GET_FPEXC	11
+#define PR_SET_FPEXC	12
+# define PR_FP_EXC_SW_ENABLE	0x80	/* Use FPEXC for FP exception enables */
+# define PR_FP_EXC_DIV		0x010000	/* floating point divide by zero */
+# define PR_FP_EXC_OVF		0x020000	/* floating point overflow */
+# define PR_FP_EXC_UND		0x040000	/* floating point underflow */
+# define PR_FP_EXC_RES		0x080000	/* floating point inexact result */
+# define PR_FP_EXC_INV		0x100000	/* floating point invalid operation */
+# define PR_FP_EXC_DISABLED	0	/* FP exceptions disabled */
+# define PR_FP_EXC_NONRECOV	1	/* async non-recoverable exc. mode */
+# define PR_FP_EXC_ASYNC	2	/* async recoverable exception mode */
+# define PR_FP_EXC_PRECISE	3	/* precise exception mode */
+
+/* Get/set whether we use statistical process timing or accurate timestamp
+ * based process timing */
+#define PR_GET_TIMING   13
+#define PR_SET_TIMING   14
+# define PR_TIMING_STATISTICAL  0       /* Normal, traditional,
+                                                   statistical process timing */
+# define PR_TIMING_TIMESTAMP    1       /* Accurate timestamp based
+                                                   process timing */
+
+#define PR_SET_NAME    15		/* Set process name */
+#define PR_GET_NAME    16		/* Get process name */
+
+/* Get/set process endian */
+#define PR_GET_ENDIAN	19
+#define PR_SET_ENDIAN	20
+# define PR_ENDIAN_BIG		0
+# define PR_ENDIAN_LITTLE	1	/* True little endian mode */
+# define PR_ENDIAN_PPC_LITTLE	2	/* "PowerPC" pseudo little endian */
+
+/* Get/set process seccomp mode */
+#define PR_GET_SECCOMP	21
+#define PR_SET_SECCOMP	22
+
+/* Get/set the capability bounding set (as per security/commoncap.c) */
+#define PR_CAPBSET_READ 23
+#define PR_CAPBSET_DROP 24
+
+/* Get/set the process' ability to use the timestamp counter instruction */
+#define PR_GET_TSC 25
+#define PR_SET_TSC 26
+# define PR_TSC_ENABLE		1	/* allow the use of the timestamp counter */
+# define PR_TSC_SIGSEGV		2	/* throw a SIGSEGV instead of reading the TSC */
+
+/* Get/set securebits (as per security/commoncap.c) */
+#define PR_GET_SECUREBITS 27
+#define PR_SET_SECUREBITS 28
+
+/*
+ * Get/set the timerslack as used by poll/select/nanosleep
+ * A value of 0 means "use default"
+ */
+#define PR_SET_TIMERSLACK 29
+#define PR_GET_TIMERSLACK 30
+
+#define PR_TASK_PERF_EVENTS_DISABLE		31
+#define PR_TASK_PERF_EVENTS_ENABLE		32
+
+/*
+ * Set early/late kill mode for hwpoison memory corruption.
+ * This influences when the process gets killed on a memory corruption.
+ */
+#define PR_MCE_KILL	33
+# define PR_MCE_KILL_CLEAR   0
+# define PR_MCE_KILL_SET     1
+
+# define PR_MCE_KILL_LATE    0
+# define PR_MCE_KILL_EARLY   1
+# define PR_MCE_KILL_DEFAULT 2
+
+#define PR_MCE_KILL_GET 34
+
+/*
+ * Tune up process memory map specifics.
+ */
+#define PR_SET_MM		35
+# define PR_SET_MM_START_CODE		1
+# define PR_SET_MM_END_CODE		2
+# define PR_SET_MM_START_DATA		3
+# define PR_SET_MM_END_DATA		4
+# define PR_SET_MM_START_STACK		5
+# define PR_SET_MM_START_BRK		6
+# define PR_SET_MM_BRK			7
+# define PR_SET_MM_ARG_START		8
+# define PR_SET_MM_ARG_END		9
+# define PR_SET_MM_ENV_START		10
+# define PR_SET_MM_ENV_END		11
+# define PR_SET_MM_AUXV			12
+# define PR_SET_MM_EXE_FILE		13
+# define PR_SET_MM_MAP			14
+# define PR_SET_MM_MAP_SIZE		15
+
+/*
+ * This structure provides new memory descriptor
+ * map which mostly modifies /proc/pid/stat[m]
+ * output for a task. This mostly done in a
+ * sake of checkpoint/restore functionality.
+ */
+struct prctl_mm_map {
+	__u64	start_code;		/* code section bounds */
+	__u64	end_code;
+	__u64	start_data;		/* data section bounds */
+	__u64	end_data;
+	__u64	start_brk;		/* heap for brk() syscall */
+	__u64	brk;
+	__u64	start_stack;		/* stack starts at */
+	__u64	arg_start;		/* command line arguments bounds */
+	__u64	arg_end;
+	__u64	env_start;		/* environment variables bounds */
+	__u64	env_end;
+	__u64	*auxv;			/* auxiliary vector */
+	__u32	auxv_size;		/* vector size */
+	__u32	exe_fd;			/* /proc/$pid/exe link file */
+};
+
+/*
+ * Set specific pid that is allowed to ptrace the current task.
+ * A value of 0 mean "no process".
+ */
+#define PR_SET_PTRACER 0x59616d61
+# define PR_SET_PTRACER_ANY ((unsigned long)-1)
+
+#define PR_SET_CHILD_SUBREAPER	36
+#define PR_GET_CHILD_SUBREAPER	37
+
+/*
+ * If no_new_privs is set, then operations that grant new privileges (i.e.
+ * execve) will either fail or not grant them.  This affects suid/sgid,
+ * file capabilities, and LSMs.
+ *
+ * Operations that merely manipulate or drop existing privileges (setresuid,
+ * capset, etc.) will still work.  Drop those privileges if you want them gone.
+ *
+ * Changing LSM security domain is considered a new privilege.  So, for example,
+ * asking selinux for a specific new context (e.g. with runcon) will result
+ * in execve returning -EPERM.
+ *
+ * See Documentation/userspace-api/no_new_privs.rst for more details.
+ */
+#define PR_SET_NO_NEW_PRIVS	38
+#define PR_GET_NO_NEW_PRIVS	39
+
+#define PR_GET_TID_ADDRESS	40
+
+#define PR_SET_THP_DISABLE	41
+#define PR_GET_THP_DISABLE	42
+
+/*
+ * No longer implemented, but left here to ensure the numbers stay reserved:
+ */
+#define PR_MPX_ENABLE_MANAGEMENT  43
+#define PR_MPX_DISABLE_MANAGEMENT 44
+
+#define PR_SET_FP_MODE		45
+#define PR_GET_FP_MODE		46
+# define PR_FP_MODE_FR		(1 << 0)	/* 64b FP registers */
+# define PR_FP_MODE_FRE		(1 << 1)	/* 32b compatibility */
+
+/* Control the ambient capability set */
+#define PR_CAP_AMBIENT			47
+# define PR_CAP_AMBIENT_IS_SET		1
+# define PR_CAP_AMBIENT_RAISE		2
+# define PR_CAP_AMBIENT_LOWER		3
+# define PR_CAP_AMBIENT_CLEAR_ALL	4
+
+/* arm64 Scalable Vector Extension controls */
+/* Flag values must be kept in sync with ptrace NT_ARM_SVE interface */
+#define PR_SVE_SET_VL			50	/* set task vector length */
+# define PR_SVE_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SVE_GET_VL			51	/* get task vector length */
+/* Bits common to PR_SVE_SET_VL and PR_SVE_GET_VL */
+# define PR_SVE_VL_LEN_MASK		0xffff
+# define PR_SVE_VL_INHERIT		(1 << 17) /* inherit across exec */
+
+/* Per task speculation control */
+#define PR_GET_SPECULATION_CTRL		52
+#define PR_SET_SPECULATION_CTRL		53
+/* Speculation control variants */
+# define PR_SPEC_STORE_BYPASS		0
+# define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH		2
+/* Return and control values for PR_SET/GET_SPECULATION_CTRL */
+# define PR_SPEC_NOT_AFFECTED		0
+# define PR_SPEC_PRCTL			(1UL << 0)
+# define PR_SPEC_ENABLE			(1UL << 1)
+# define PR_SPEC_DISABLE		(1UL << 2)
+# define PR_SPEC_FORCE_DISABLE		(1UL << 3)
+# define PR_SPEC_DISABLE_NOEXEC		(1UL << 4)
+
+/* Reset arm64 pointer authentication keys */
+#define PR_PAC_RESET_KEYS		54
+# define PR_PAC_APIAKEY			(1UL << 0)
+# define PR_PAC_APIBKEY			(1UL << 1)
+# define PR_PAC_APDAKEY			(1UL << 2)
+# define PR_PAC_APDBKEY			(1UL << 3)
+# define PR_PAC_APGAKEY			(1UL << 4)
+
+/* Tagged user address controls for arm64 */
+#define PR_SET_TAGGED_ADDR_CTRL		55
+#define PR_GET_TAGGED_ADDR_CTRL		56
+# define PR_TAGGED_ADDR_ENABLE		(1UL << 0)
+/* MTE tag check fault modes */
+# define PR_MTE_TCF_NONE		0UL
+# define PR_MTE_TCF_SYNC		(1UL << 1)
+# define PR_MTE_TCF_ASYNC		(1UL << 2)
+# define PR_MTE_TCF_MASK		(PR_MTE_TCF_SYNC | PR_MTE_TCF_ASYNC)
+/* MTE tag inclusion mask */
+# define PR_MTE_TAG_SHIFT		3
+# define PR_MTE_TAG_MASK		(0xffffUL << PR_MTE_TAG_SHIFT)
+/* Unused; kept only for source compatibility */
+# define PR_MTE_TCF_SHIFT		1
+
+/* Control reclaim behavior when allocating memory */
+#define PR_SET_IO_FLUSHER		57
+#define PR_GET_IO_FLUSHER		58
+
+/* Dispatch syscalls to a userspace handler */
+#define PR_SET_SYSCALL_USER_DISPATCH	59
+# define PR_SYS_DISPATCH_OFF		0
+# define PR_SYS_DISPATCH_ON		1
+/* The control values for the user space selector when dispatch is enabled */
+# define SYSCALL_DISPATCH_FILTER_ALLOW	0
+# define SYSCALL_DISPATCH_FILTER_BLOCK	1
+
+/* Set/get enabled arm64 pointer authentication keys */
+#define PR_PAC_SET_ENABLED_KEYS		60
+#define PR_PAC_GET_ENABLED_KEYS		61
+
+/* Request the scheduler to share a core */
+#define PR_SCHED_CORE			62
+# define PR_SCHED_CORE_GET		0
+# define PR_SCHED_CORE_CREATE		1 /* create unique core_sched cookie */
+# define PR_SCHED_CORE_SHARE_TO		2 /* push core_sched cookie to pid */
+# define PR_SCHED_CORE_SHARE_FROM	3 /* pull core_sched cookie to pid */
+# define PR_SCHED_CORE_MAX		4
+# define PR_SCHED_CORE_SCOPE_THREAD		0
+# define PR_SCHED_CORE_SCOPE_THREAD_GROUP	1
+# define PR_SCHED_CORE_SCOPE_PROCESS_GROUP	2
+
+/* arm64 Scalable Matrix Extension controls */
+/* Flag values must be in sync with SVE versions */
+#define PR_SME_SET_VL			63	/* set task vector length */
+# define PR_SME_SET_VL_ONEXEC		(1 << 18) /* defer effect until exec */
+#define PR_SME_GET_VL			64	/* get task vector length */
+/* Bits common to PR_SME_SET_VL and PR_SME_GET_VL */
+# define PR_SME_VL_LEN_MASK		0xffff
+# define PR_SME_VL_INHERIT		(1 << 17) /* inherit across exec */
+
+/* Memory deny write / execute */
+#define PR_SET_MDWE			65
+# define PR_MDWE_REFUSE_EXEC_GAIN	(1UL << 0)
+# define PR_MDWE_NO_INHERIT		(1UL << 1)
+
+#define PR_GET_MDWE			66
+
+#define PR_SET_VMA		0x53564d41
+# define PR_SET_VMA_ANON_NAME		0
+
+#define PR_GET_AUXV			0x41555856
+
+#define PR_SET_MEMORY_MERGE		67
+#define PR_GET_MEMORY_MERGE		68
+
+#define PR_RISCV_V_SET_CONTROL		69
+#define PR_RISCV_V_GET_CONTROL		70
+# define PR_RISCV_V_VSTATE_CTRL_DEFAULT		0
+# define PR_RISCV_V_VSTATE_CTRL_OFF		1
+# define PR_RISCV_V_VSTATE_CTRL_ON		2
+# define PR_RISCV_V_VSTATE_CTRL_INHERIT		(1 << 4)
+# define PR_RISCV_V_VSTATE_CTRL_CUR_MASK	0x3
+# define PR_RISCV_V_VSTATE_CTRL_NEXT_MASK	0xc
+# define PR_RISCV_V_VSTATE_CTRL_MASK		0x1f
+
+#define PR_RISCV_SET_ICACHE_FLUSH_CTX	71
+# define PR_RISCV_CTX_SW_FENCEI_ON	0
+# define PR_RISCV_CTX_SW_FENCEI_OFF	1
+# define PR_RISCV_SCOPE_PER_PROCESS	0
+# define PR_RISCV_SCOPE_PER_THREAD	1
+
+/* PowerPC Dynamic Execution Control Register (DEXCR) controls */
+#define PR_PPC_GET_DEXCR		72
+#define PR_PPC_SET_DEXCR		73
+/* DEXCR aspect to act on */
+# define PR_PPC_DEXCR_SBHE		0 /* Speculative branch hint enable */
+# define PR_PPC_DEXCR_IBRTPD		1 /* Indirect branch recurrent target prediction disable */
+# define PR_PPC_DEXCR_SRAPD		2 /* Subroutine return address prediction disable */
+# define PR_PPC_DEXCR_NPHIE		3 /* Non-privileged hash instruction enable */
+/* Action to apply / return */
+# define PR_PPC_DEXCR_CTRL_EDITABLE	 0x1 /* Aspect can be modified with PR_PPC_SET_DEXCR */
+# define PR_PPC_DEXCR_CTRL_SET		 0x2 /* Set the aspect for this process */
+# define PR_PPC_DEXCR_CTRL_CLEAR	 0x4 /* Clear the aspect for this process */
+# define PR_PPC_DEXCR_CTRL_SET_ONEXEC	 0x8 /* Set the aspect on exec */
+# define PR_PPC_DEXCR_CTRL_CLEAR_ONEXEC	0x10 /* Clear the aspect on exec */
+# define PR_PPC_DEXCR_CTRL_MASK		0x1f
+
+#endif /* _LINUX_PRCTL_H */
-- 
2.45.2


