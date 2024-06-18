Return-Path: <linux-kselftest+bounces-12116-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09E790C1D3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 04:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5FE1C2174A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 02:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F242C181;
	Tue, 18 Jun 2024 02:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="unfU/2B7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA501865C;
	Tue, 18 Jun 2024 02:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718677479; cv=fail; b=G+aXGb9g8W4+914qsuutJrfNuetMGHMcZz8B+d+w+R2o1J91hB29OG69p7Oe0ztpEG6s80VwcPJmR2zD6+feiAy458HuDq833X/Qtc1bR1ECsyT242pYPQciMggKlkP/uK+5vNfcw45rWQZ6UM0M0R+ZTLRRXDcOo+MLsU9HmPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718677479; c=relaxed/simple;
	bh=q+9YpcAlaI3uXyh3nuYNyDBif9Xmi86C6G1DTXRjHVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HcV6IXh1WiVXXXcwvKYV70x2uH6FeY5hkdU5DmAf68m7KGVygW0EYDwpoTMsFIM6AzQIHiNWQRkSb1Ne0ENJyU8XHhiHH6Jib5xJIGMDSa6Eh+g+fAD4SwlRBv+1d2L7w70o8e7Kege65x95atOJ6OOwvEYyGn7KamqvfYlqsSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=unfU/2B7; arc=fail smtp.client-ip=40.107.243.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE5V3gwtPkzAJYHK5OTIxJ3ahRQlx7B/vzOjqFsg/FXwrQT0mQPYyJu/vbsUPzz8TfwncEpkC8VuGBNymFwlYiedC56g+N38M5UC52dNker09l2g/BXNhp/GOLGXFN6Cr0fche1FZQv3dqWGJe9kxTK9Wh3Yw02oFS5WLm4Jg4SxApknRAmlnGUvE1JI/2ayZncPwiCbPfJj4zQjIBPo1qE7Ei8w1uWLq8x76bW1rZI569N1U9ssKfsPsrbaCqHNVBFQezVU9HQjknR6jZpd1JZs+XiVx10ymVREA2Bm+AgaVHSx/3o0jdKMw+NadMvyrKkwYoY3jcUkhVtN8yzQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NF9Ze1k6wBxs36mbUWWURPDYNQVjIyEe/phljaLt/7o=;
 b=Nde/Fe+3hXJcEej4TLKpRGfzq06fMhbD1Imo0T4YijB6M0+Vo/NtFGZOmYaDXPLGsAFlxmmEYR7I8wIrTRyqwGdiReetkVX8ci6sUsRkq0IcSJog2heeWygAOEuV3SVgv/Eza35enBIzp5DzYw23LoD4NSXu6LAGRIdOP26ziBHXPCRYZnZ+ISlWfqInbCSysrQlNePkdRuygUWu56n945mJb9+7aPQkBxOx5U63ftFXr2HeTESIIKEq2gHTtvsgVD1dqB1WSJzOuE/NG0392usueDbYXTDHj2m8sodKJrGa/ovdeMztkrFlBkLZPLkqm0divtWmqOG1Rk/PYzl75g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NF9Ze1k6wBxs36mbUWWURPDYNQVjIyEe/phljaLt/7o=;
 b=unfU/2B7Mm9333WD/1JP64ahV+Il/GbQ0ZVRE1yMvN5vXdIRmWeY43STPfBtCAtXUOVo6aMyb/d9S3W0VDb0/iAi6MrNvK+nStAMm6Qo1OYTaGfvKYeChkdBusdYqLsyeYuARIshADhibm7EVHfGhRnV0XJQhEDGT0FP+YlmO0MYWuRXwMOBR6nubV3RnO+OYmifIUaFLgbhpGoUE96DHmiIUhTQUjW8gjPrlTV3gRWS2syuhnCEdLjuv92lTyJ+c0fyz3EbQVB6x2PoNn7MtvELsDpuCp5YGmolaEkNNh3tZ/AzT8t+p2uCqMdIfrsgtOnkCGSCm6Ys2wA6ouHrnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by SA3PR12MB8047.namprd12.prod.outlook.com (2603:10b6:806:31b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:24:29 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::2cf4:5198:354a:cd07%4]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:24:29 +0000
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
Subject: [PATCH v3 6/6] selftests/mm: remove local __NR_* definitions
Date: Mon, 17 Jun 2024 19:24:22 -0700
Message-ID: <20240618022422.804305-7-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240618022422.804305-1-jhubbard@nvidia.com>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:a03:60::40) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR12MB4130:EE_|SA3PR12MB8047:EE_
X-MS-Office365-Filtering-Correlation-Id: 25746475-ecc1-478d-b6f2-08dc8f3dc814
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|7416011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gTfik7Fd8UcEX7bUPyF7gBwS4/ub/5SxjMQEizGMvN/NB10qPmN9uoYIWOaN?=
 =?us-ascii?Q?j+eegs4PAqRtwxkN4W3nsM+7e1NRiigciM3hGMvb4KC/6dU/bK8tO1v2sD31?=
 =?us-ascii?Q?xiNDItv1LG0EQC5KWlroofPAyTZMlGkf2RoI0nsw4KxwXn3FdGQwiC2z0yt4?=
 =?us-ascii?Q?FtwNaZP9TEKpaHgTnrYXnU/2yGR8EKootjP5JnGzBCj1n+QL35+evFkCA5dC?=
 =?us-ascii?Q?oMUerO1J5lco4nsviaQUDEEeuqtgUPSNsOV0fldGDLOQduWrOUj2ku7Af0l6?=
 =?us-ascii?Q?yMWWMubgWE9m2OGbtDrbbmbzwCFHIdkqV1oozsnqpC8cRadZ2BYQdeqaXZf8?=
 =?us-ascii?Q?6MbNO8YdyjgO3IErlBHo2SIbkNDVQ7OK5fs6h/Ku+xF+dsdqLWAE+9cjCXeJ?=
 =?us-ascii?Q?npJ/GOEGNnLL+wpKBp2pKbZzlMcP3Du+h8vKaRF6FHokhKEPouYbeM8S57tV?=
 =?us-ascii?Q?YSWhfMvN/sfhrPU4gdGcviLCy34bo38wMUOvlKCSf1Qs5wsCvNmzNf/jucop?=
 =?us-ascii?Q?fKpGt5RkSkVpzVcrNiVMSkiC28oKp7fMoaW8f/U7dxroZHOzYtUMvpirKaE9?=
 =?us-ascii?Q?tTbh4dyBqd8e6o2EiVqHazcTGNJRYU+2X6RmstHFVtR+ZgA8ZB+H12QnHY0A?=
 =?us-ascii?Q?cr/0EXW78dy5kvCmjq5qrNUiS5QQplUFz46NPRU97PHrOHCBSv72tjwJI4hM?=
 =?us-ascii?Q?G9CSPfjUI0MiT38Btm1boPxk/3LgLgvlMQanaYixN/LfLli4RqG4PR+2ZBgc?=
 =?us-ascii?Q?iuNQHk61DkEIOVXX0zhisMzy5OKBBKNbFPWASTyDQU4u6SVErgQcVVgYWtI/?=
 =?us-ascii?Q?8j5hgZyXmSQAOK0xSK0WaArUbadRPDMhT6D6K+Dt3WGeSu4nAXMW3EFOA5iQ?=
 =?us-ascii?Q?c8/5wBYkV9mExGXFrBoQciM8b1rCdHorzvYv73o3E3gpM2E+2/D/s4xmnTye?=
 =?us-ascii?Q?unyQjZa1lxTVdEf4qgLg/8imOQM+qtPMuUCFoTXMRZS8mWUqaR1nTEmXHiDD?=
 =?us-ascii?Q?QWhYM7IC1TSVMMPGUqwGZ+KRFRvuDqhs+rfFwXFM0JI+lOP1aXmnwkXAtA6y?=
 =?us-ascii?Q?7Hb7v6CoKQFzsuh/KyfFRDAwn00bXu+H4Ic9tl/HXMkdt9nhM1qdG/lhvaLi?=
 =?us-ascii?Q?K0XHA5pqihXTpoS65pAYsiyW4coGglPKakV3sIbDLcMq9UjbpAHqS4FiRnCb?=
 =?us-ascii?Q?qMLo0sb0DpATUYwuTugQX/tWteGkDoiuf5iSF2BLQvWPfBQn0Y4cl9Hr1HAg?=
 =?us-ascii?Q?d/eMnxv19gBdT4djSN21K9QP1nQkoERh9Eo2/Jjk2HDVSjqpgjQ3W1C+UwMQ?=
 =?us-ascii?Q?AmK2x08Gk4i+drBXYhpwhERJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(7416011)(376011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M+83bU0V89Wll6783m/V5ceVo/6LGobBEwaYcRDve+nh+/e3GDx/JJq9LaI+?=
 =?us-ascii?Q?CaAeKES9nFTeB14zoUhf2yJvZokV5sv6OVlGNwicypUZiilyjkmJP9PVxk6L?=
 =?us-ascii?Q?rvdLUNbAOchL2AMkhJ9ejMWiok7nXQ7JmNb/NOvUJb9TstfrgrzNg6VvYpuI?=
 =?us-ascii?Q?2EgXgtUTnl4u9kYzJHiucbqzHKbCdVyRRX/0i73NoJdUDIam81CVQfJpG+LB?=
 =?us-ascii?Q?A4Z5iUMjWFLPud0LLP9JhXOdEavZfEuVTldWtzC2f8iOTzDUqWqYysU8LJ21?=
 =?us-ascii?Q?sOcPCQNTN20KfWBAezhTDS6x62gW5lgzg+VsILXVnYmQvOm1wCKbCbjr1Swo?=
 =?us-ascii?Q?m5SBt3h221eLMUDgrPmZ+5kp5XZ8ffEOEpTViFtamqkp22apnFLcWTblVWgy?=
 =?us-ascii?Q?KsyJx0GNOuX57dk8brDVwPqmFwCQXPr7zxWS9lEYG77kJmHlPexOEP03X2NS?=
 =?us-ascii?Q?Sam6iSx0h/wEhNHVkqpNQNp/zAyBgBSS3FxH4QN77UDkmsa/deSlph2U6Xxl?=
 =?us-ascii?Q?6/YS9Uwcc98vm0BId+N+IeoRyLEyTMHvTBLhuWHXTvz4BXXHBmbk95TU9+by?=
 =?us-ascii?Q?l/ev/W24euqk5LZHTDBlWJwVWQzMEMU0R+pfiZTAyKKlKR5sSxlbNza8DeyW?=
 =?us-ascii?Q?hmfTIP3owbOMVjqaE/Lhltptoi8l3rTFMqd7kgbMRemm3SWHCo20pDjW9WLG?=
 =?us-ascii?Q?ynBivdAlO7Y+SHMRIznWHY++P8CMhuOET0EFa72U3rTxGKkA1dS+rkDBVJdM?=
 =?us-ascii?Q?TigWJk6zHZtBrUYEg0OG+YW5MRhW04keAYve56sA+EOsYGJq1GQVVURGii/k?=
 =?us-ascii?Q?qXyZNC9rS3WucZ3xY71aTGhFfVZt+R8jIfCACT7COXi2iJmgJ2ySWb48viZb?=
 =?us-ascii?Q?erBu4R6NqlVNWiAoC6fOXSjtsu30HrISegVbzwC4D+7kcS1vcp7LsK9jFVqj?=
 =?us-ascii?Q?GZU99mbL3ewgI/O8bRZ9rYnEpp1at6ZB4rOYt/qujw+Vg6t+0y6gjeEKyULQ?=
 =?us-ascii?Q?p50rBjAyQABfxi80c8hF16WzXI41ugommQ4byv3YEC0w1jG0SzjOcWWObGXn?=
 =?us-ascii?Q?PtlOdYDGEpab90bY4sIxvqHUUaFiJt1FlHr2ZXPJBWGRv/VPMw4NpunjOWAw?=
 =?us-ascii?Q?biEO/nomfxLIxNgXAqq1n6stBO2XRmAcNs+KB3NFEN7PHOMSCNoHCkHYbbco?=
 =?us-ascii?Q?d6Mj4S3x58vzmWLFwSws7dERAOU3sMd+m4+e0u8cIXsFkn0e+VW9Mf2GkujC?=
 =?us-ascii?Q?tgOxiOQAxf9r1BZV8KVpiQS8xx3l+XLvpWVcy1pSN4i3eOirBFfgip/cVifG?=
 =?us-ascii?Q?O7Sf9MQ7ZdaxOOGcbqFueyu11FbRChapsT1t2i3NP+AxRmR5WbZQ6CdKlH4e?=
 =?us-ascii?Q?G3CQI9Wxk8TGsuL7z/1mmJLr2vD8aH2VhU8//sHi/uZYAbDLdlTIPylqsZ9x?=
 =?us-ascii?Q?9DQ6OdY/wfiiFxAdhc0FFmWNAW7TkmhEKIKIfc86L97Cx7TQWXH0kJQe/X/D?=
 =?us-ascii?Q?Y2s9COpvKuK+kLRByxFUYPyipP2fdiPcQgeN+2Z26OWtz7R0rAAT1rjUBmN8?=
 =?us-ascii?Q?dyjZmzldOGIx5MHNP6/fG+frB7XypdFkOj0SDwIp?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25746475-ecc1-478d-b6f2-08dc8f3dc814
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:24:29.3173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndPuPpq2Dx+robDDNs4oio40yWwg+c8qBZodoVSpGfwv7UKe7aeybFYG7PIDxMmN7avo30rbznTFLL2Ax8Lr6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8047

This continues the work on getting the selftests to build without
requiring people to first run "make headers" [1].

Now that the system call numbers are in the correct, checked-in
locations in the kernel tree (./tools/include/uapi/asm/unistd*.h),
make sure that the mm selftests include that file (indirectly).

Doing so provides guaranteed definitions at build time, so remove all of
the checks for "ifdef __NR_xxx" in the mm selftests, because they will
always be true (defined).

[1] commit e076eaca5906 ("selftests: break the dependency upon local
header files")

Acked-by: David Hildenbrand <david@redhat.com>
Cc: Jeff Xu <jeffxu@chromium.org>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 tools/testing/selftests/mm/hugepage-mremap.c     |  2 +-
 .../testing/selftests/mm/ksm_functional_tests.c  |  8 +-------
 tools/testing/selftests/mm/memfd_secret.c        | 14 +-------------
 tools/testing/selftests/mm/mkdirty.c             |  8 +-------
 tools/testing/selftests/mm/mlock2.h              |  1 +
 tools/testing/selftests/mm/pagemap_ioctl.c       |  2 +-
 tools/testing/selftests/mm/protection_keys.c     |  2 +-
 tools/testing/selftests/mm/uffd-common.c         |  4 ----
 tools/testing/selftests/mm/uffd-stress.c         | 16 +---------------
 tools/testing/selftests/mm/uffd-unit-tests.c     | 14 +-------------
 10 files changed, 9 insertions(+), 62 deletions(-)

diff --git a/tools/testing/selftests/mm/hugepage-mremap.c b/tools/testing/selftests/mm/hugepage-mremap.c
index c463d1c09c9b..ada9156cc497 100644
--- a/tools/testing/selftests/mm/hugepage-mremap.c
+++ b/tools/testing/selftests/mm/hugepage-mremap.c
@@ -15,7 +15,7 @@
 #define _GNU_SOURCE
 #include <stdlib.h>
 #include <stdio.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <sys/mman.h>
 #include <errno.h>
 #include <fcntl.h> /* Definition of O_* constants */
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index 37de82da9be7..5cbf3f783d6c 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -11,7 +11,7 @@
 #include <string.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <errno.h>
 #include <fcntl.h>
 #include <sys/mman.h>
@@ -369,7 +369,6 @@ static void test_unmerge_discarded(void)
 	munmap(map, size);
 }
 
-#ifdef __NR_userfaultfd
 static void test_unmerge_uffd_wp(void)
 {
 	struct uffdio_writeprotect uffd_writeprotect;
@@ -430,7 +429,6 @@ static void test_unmerge_uffd_wp(void)
 unmap:
 	munmap(map, size);
 }
-#endif
 
 /* Verify that KSM can be enabled / queried with prctl. */
 static void test_prctl(void)
@@ -665,9 +663,7 @@ int main(int argc, char **argv)
 		exit(test_child_ksm());
 	}
 
-#ifdef __NR_userfaultfd
 	tests++;
-#endif
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -694,9 +690,7 @@ int main(int argc, char **argv)
 	test_unmerge();
 	test_unmerge_zero_pages();
 	test_unmerge_discarded();
-#ifdef __NR_userfaultfd
 	test_unmerge_uffd_wp();
-#endif
 
 	test_prot_none();
 
diff --git a/tools/testing/selftests/mm/memfd_secret.c b/tools/testing/selftests/mm/memfd_secret.c
index 9a0597310a76..74c911aa3aea 100644
--- a/tools/testing/selftests/mm/memfd_secret.c
+++ b/tools/testing/selftests/mm/memfd_secret.c
@@ -17,7 +17,7 @@
 
 #include <stdlib.h>
 #include <string.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <errno.h>
 #include <stdio.h>
 #include <fcntl.h>
@@ -28,8 +28,6 @@
 #define pass(fmt, ...) ksft_test_result_pass(fmt, ##__VA_ARGS__)
 #define skip(fmt, ...) ksft_test_result_skip(fmt, ##__VA_ARGS__)
 
-#ifdef __NR_memfd_secret
-
 #define PATTERN	0x55
 
 static const int prot = PROT_READ | PROT_WRITE;
@@ -334,13 +332,3 @@ int main(int argc, char *argv[])
 
 	ksft_finished();
 }
-
-#else /* __NR_memfd_secret */
-
-int main(int argc, char *argv[])
-{
-	printf("skip: skipping memfd_secret test (missing __NR_memfd_secret)\n");
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_memfd_secret */
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index b8a7efe9204e..1db134063c38 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -9,7 +9,7 @@
  */
 #include <fcntl.h>
 #include <signal.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <string.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -265,7 +265,6 @@ static void test_pte_mapped_thp(void)
 	munmap(mmap_mem, mmap_size);
 }
 
-#ifdef __NR_userfaultfd
 static void test_uffdio_copy(void)
 {
 	struct uffdio_register uffdio_register;
@@ -322,7 +321,6 @@ static void test_uffdio_copy(void)
 	munmap(dst, pagesize);
 	free(src);
 }
-#endif /* __NR_userfaultfd */
 
 int main(void)
 {
@@ -335,9 +333,7 @@ int main(void)
 			       thpsize / 1024);
 		tests += 3;
 	}
-#ifdef __NR_userfaultfd
 	tests += 1;
-#endif /* __NR_userfaultfd */
 
 	ksft_print_header();
 	ksft_set_plan(tests);
@@ -367,9 +363,7 @@ int main(void)
 	if (thpsize)
 		test_pte_mapped_thp();
 	/* Placing a fresh page via userfaultfd may set the PTE dirty. */
-#ifdef __NR_userfaultfd
 	test_uffdio_copy();
-#endif /* __NR_userfaultfd */
 
 	err = ksft_get_fail_cnt();
 	if (err)
diff --git a/tools/testing/selftests/mm/mlock2.h b/tools/testing/selftests/mm/mlock2.h
index 4417eaa5cfb7..1e5731bab499 100644
--- a/tools/testing/selftests/mm/mlock2.h
+++ b/tools/testing/selftests/mm/mlock2.h
@@ -3,6 +3,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
+#include <asm-generic/unistd.h>
 
 static int mlock2_(void *start, size_t len, int flags)
 {
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index 2d785aca72a5..0e18f2ca8d93 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -15,7 +15,7 @@
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <math.h>
-#include <asm/unistd.h>
+#include <asm-generic/unistd.h>
 #include <pthread.h>
 #include <sys/resource.h>
 #include <assert.h>
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index 48dc151f8fca..eaa6d1fc5328 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -42,7 +42,7 @@
 #include <sys/wait.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <unistd.h>
+#include <asm-generic/unistd.h>
 #include <sys/ptrace.h>
 #include <setjmp.h>
 
diff --git a/tools/testing/selftests/mm/uffd-common.c b/tools/testing/selftests/mm/uffd-common.c
index 7ad6ba660c7d..717539eddf98 100644
--- a/tools/testing/selftests/mm/uffd-common.c
+++ b/tools/testing/selftests/mm/uffd-common.c
@@ -673,11 +673,7 @@ int uffd_open_dev(unsigned int flags)
 
 int uffd_open_sys(unsigned int flags)
 {
-#ifdef __NR_userfaultfd
 	return syscall(__NR_userfaultfd, flags);
-#else
-	return -1;
-#endif
 }
 
 int uffd_open(unsigned int flags)
diff --git a/tools/testing/selftests/mm/uffd-stress.c b/tools/testing/selftests/mm/uffd-stress.c
index f78bab0f3d45..0abb9af0fc7f 100644
--- a/tools/testing/selftests/mm/uffd-stress.c
+++ b/tools/testing/selftests/mm/uffd-stress.c
@@ -33,11 +33,9 @@
  * pthread_mutex_lock will also verify the atomicity of the memory
  * transfer (UFFDIO_COPY).
  */
-
+#include <asm-generic/unistd.h>
 #include "uffd-common.h"
 
-#ifdef __NR_userfaultfd
-
 #define BOUNCE_RANDOM		(1<<0)
 #define BOUNCE_RACINGFAULTS	(1<<1)
 #define BOUNCE_VERIFY		(1<<2)
@@ -466,15 +464,3 @@ int main(int argc, char **argv)
 	       nr_pages, nr_pages_per_cpu);
 	return userfaultfd_stress();
 }
-
-#else /* __NR_userfaultfd */
-
-#warning "missing __NR_userfaultfd definition"
-
-int main(void)
-{
-	printf("skip: Skipping userfaultfd test (missing __NR_userfaultfd)\n");
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_userfaultfd */
diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 21ec23206ab4..b3d21eed203d 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -5,12 +5,11 @@
  *  Copyright (C) 2015-2023  Red Hat, Inc.
  */
 
+#include <asm-generic/unistd.h>
 #include "uffd-common.h"
 
 #include "../../../../mm/gup_test.h"
 
-#ifdef __NR_userfaultfd
-
 /* The unit test doesn't need a large or random size, make it 32MB for now */
 #define  UFFD_TEST_MEM_SIZE               (32UL << 20)
 
@@ -1554,14 +1553,3 @@ int main(int argc, char *argv[])
 	return ksft_get_fail_cnt() ? KSFT_FAIL : KSFT_PASS;
 }
 
-#else /* __NR_userfaultfd */
-
-#warning "missing __NR_userfaultfd definition"
-
-int main(void)
-{
-	printf("Skipping %s (missing __NR_userfaultfd)\n", __file__);
-	return KSFT_SKIP;
-}
-
-#endif /* __NR_userfaultfd */
-- 
2.45.2


