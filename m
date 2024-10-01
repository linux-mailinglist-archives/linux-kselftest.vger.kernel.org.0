Return-Path: <linux-kselftest+bounces-18813-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD2498C86F
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Oct 2024 00:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C108B285AAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 22:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1909C1CFECE;
	Tue,  1 Oct 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="P/EYlvK5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11022084.outbound.protection.outlook.com [52.101.43.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6351CF2B5;
	Tue,  1 Oct 2024 22:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727823164; cv=fail; b=nkg4VMXW8bDEVEOxLwUtqHld5rFsN6oLuQrBhS/9RuMJb6r6r2vZXvg0AUfD7cMVkDtZujz8WfQ5mhQCWw9tEhQw49lTemDq9mg7geGtvTGLLYiOkmlnhEmQytB5kg24Cl6lz0VUzqDk5o9xvpfzYlTXrUO5M8VTe3yLpx4iqwI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727823164; c=relaxed/simple;
	bh=tXx26WTRbcKC56sJeTm/4CNHeCWl0281W6iDxrTTTYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mfuoUjgn4Vlu+ULM0ynsYLzNid3BdWwfp/N/UUaKQ6ML/gw9d+vUYLHjLoje3GOPwyFed7SGRZbd1FnNQ8ootO9XtOdVWYlcR2yfrkPsVWwizZC1Y8DYSPsTcrwszQTOUJyvIpz5pFjqRel/klqpCPNvFpEzbdiQ9EhlNTE7KYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=P/EYlvK5; arc=fail smtp.client-ip=52.101.43.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aqo/ZVaPpOEmPKrIeJKCuson7pBhNjJ5nB2lE3CswpeyvyxRlp4ugZgf3WlptU7Ir5FjE8mcfm9jkLU+4eAoNvdxCZoVB4nvA8ukHywYxCj3uPEUJVMw+MKo9/Sace9JtZ1LhEroHiop7D1xnaonGsBQjQlcRc730gHSwLSKlRmIjhqkMaA3tFEwM1aqLeYLkOjfbKclTczge27JprMx4kKQooz2eduNPrf1ek4c/jI7S7nGiacnjKQdK9SbpWsSJW6CNbqlcWF+R2ZkAbaKvBffgTINp814ciVHLvBuPfAIwO8Dnz8F8nAPGp4Yete1kezfmawPPoUf1/3uztAKKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=ZcVCTO0r7QaNOJaypuYXgX6+XTLigvl8nHYqjvKrHtHRdyH8bUbty3UG1jEcDepSpXkM++WhvY1YG+M3jaFQkJ+SMI8KojG7Gaq9SnUWsXH1ul/6yHaQdJgNaYSHGhGcaugNz4ciM31AIMnBqRMKGtDDAhc6/YIwORc1cWn8anjAVWhairDxE5a4VYlXV35qLWDSM12g4Xt/ekWkT6WIpWb6Gmx8zjMebKAMmUwgDg2Yirv+QZTzOirTWYUJvYcXeG6X9Tstjjf/YYLNjJ6VMZ8QFEKTNjSDZbB4v8NegNP+SA8qLnn33Hn8NbHaxD47kXkoEilQEWTeA4HQ2JkOwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZEmI5ze4VGJmlbeh/nIhqSgSXgQnJWJLInFVw0UZe0=;
 b=P/EYlvK5qf7nqMoQR/4Zts9l9tYcC1G8uOCpXlJ8j7DoiUAbFR7FE9ulqFGLZnONmKM3Pj2MpKI9iRsCmUJMKH1DmD1j+nV04sQibSyw+60TIRKWqXC1KZ2wUi+pOe5bUZu2o6v8QU+CkGA/2TW26IernHnudUSxkRR1rX4t2U8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CO1PR01MB6678.prod.exchangelabs.com (2603:10b6:303:d9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7982.28; Tue, 1 Oct 2024 22:52:36 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%5]) with mapi id 15.20.7982.022; Tue, 1 Oct 2024
 22:52:36 +0000
From: Yang Shi <yang@os.amperecomputing.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	muchun.song@linux.dev,
	david@redhat.com,
	akpm@linux-foundation.org,
	shuah@kernel.org
Cc: yang@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v6 PATCH 2/2] selftests: arm64: add hugetlb mte tests
Date: Tue,  1 Oct 2024 15:52:20 -0700
Message-ID: <20241001225220.271178-2-yang@os.amperecomputing.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20241001225220.271178-1-yang@os.amperecomputing.com>
References: <20241001225220.271178-1-yang@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8PR19CA0036.namprd19.prod.outlook.com
 (2603:10b6:930:6::29) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CO1PR01MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d0adb-eac8-46ab-d13e-08dce26bbdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?StYg4YMZ61MBY3YhblHT0vpFfAq80ejPClg3h5jiDt5U7mAxIKEjLXBPoK9e?=
 =?us-ascii?Q?GdYhPfGbMDLeqxTiC8CH+kUCch7KQhN9IkE6/0RR1Zy4Fxg7MAQNDRN2Daew?=
 =?us-ascii?Q?88kvQU60mAgHaJbQh+GEjrEhK3SpG3fgJ8wCBweAsARlCYIUb+KEaMrR6wkt?=
 =?us-ascii?Q?2i23AkZ42NP5bsGwCOxis7afra8cxTCQtd2LX3JFCLqsC+uSP2hR27H//76f?=
 =?us-ascii?Q?VLTGx0pKQc+i+yQHdaNA7BuJ3FLzlSdvoADgTafaolPurPK/3CJs+qceQNqm?=
 =?us-ascii?Q?ehymxix2h0d85156N3MZ3g9J3ujb5QclhS8Q2cm1z3HdnVtbzwwggPv4m9BO?=
 =?us-ascii?Q?8YKJGeOhUmJhCJMJXETqWLx25KxYh0XPO+9hbPSAkDeJyLSYCHjeO5I9j/Ay?=
 =?us-ascii?Q?I9d76Ke0gKtoylkPd+P83NT8QDkyUbSuV4xU+417+dL9JhCRpCzkJt+2AYji?=
 =?us-ascii?Q?anURXg58T7MumkmsDRMMi++dLnU7o6eVjjqrlfkCONqdHmcs8q2DBmQkI/B0?=
 =?us-ascii?Q?u9OYr4juZLRdptjNCbuDbfM38cX9QPWHfDC6Xrfj/7IlgqjDJX3UUKItVb9+?=
 =?us-ascii?Q?uwChu5YWd3PdzVr8sMZ/kLRwoAz0ej2DVtasm5gvcBY/eW78ZBG4aHaQs726?=
 =?us-ascii?Q?jOyxdohQTYe8BY8uc9OFecm1mK6iiYA1qEFGyRN8SKMPFiTdP8PGrapZGDDZ?=
 =?us-ascii?Q?Epuw3Kc8eelJsyc25zepjp7cXQJhda40mHMhyuMGXm/BJ69z97xyKxS10tia?=
 =?us-ascii?Q?AXvvz9j+r63JcI5tcdZ33cVmYa6L0Jepk8JhD5u0RMFbRILxQt0oQ6ecuxym?=
 =?us-ascii?Q?YA2pPtSGnlQXNGKM+T4VEJM5nVBNnECQr6llZ54K//4GywUbfrKi36RBzcxY?=
 =?us-ascii?Q?NO+urbq2brrjuOOUe8GMdDVKjp6o86IYdGTs2s7Vbvc7wH5LKq8unG7PuVjj?=
 =?us-ascii?Q?ZzhwOhwRNDRR1kIMh3gmgyvVxJTyeoDc3JgrGXzugEWG5l5svIK4DyhZiV0i?=
 =?us-ascii?Q?OtPeeYe5HsqpZErQVXQC5lpY/FbojeVO59CR8yJ2qdI2q2iqiqAWjXWISMun?=
 =?us-ascii?Q?Is+Jn0zXwoKHD9OIo6qHi/OeQMgk9FCN1cWE/Q1VgktPZfjgT3kSGhdiOrKN?=
 =?us-ascii?Q?I1rxzfXFz/f2g2gdz4sRhawyMxfBtYY2ABB8DXO0uRn35SK7mealH2zFAvwX?=
 =?us-ascii?Q?JV8n2kqFC1Ue1Ha1v4dJVBT77HBuJPF3iJ6zGUjkl5HFdFfOWJL3DBHRG2iC?=
 =?us-ascii?Q?1DkulIOakfbhkL56CIhTfsqZXl4u7lYhYYO8Sd5BXE/1adLuVPsytGIQD9qm?=
 =?us-ascii?Q?6xm47smZJjypyBMH/eXoyDFV1bhJgwQgJbOtgNSak65NLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BT+QsbeAZGz6aOHLvIslQic+mNhoDl4oIlykcvuq2Avs9b1ZpFiHT7/HOkoy?=
 =?us-ascii?Q?yrh9aVOJYGrbxMf1RvQSFVHaOdzaixRzOICYmVOmzfMWt8WgG3VpnX6hQd+j?=
 =?us-ascii?Q?Ge9YaId8qWChzUE0sQmSc0XO8+zmj8I/xSR9neisff5AS93UJAzNdWcgSahi?=
 =?us-ascii?Q?UzWP1vF9NJPOIAnSkZCRLicS4LKCRSpbhZFaSeo/gbxePXQ17tnYOEkT47mn?=
 =?us-ascii?Q?dO4AdMo41jCiWAVl0ucWsWyAcrMiTxLae51d7enhgSuIvEA59gdVj9DjmMA8?=
 =?us-ascii?Q?rGQjQt3cGjM/7w2nCx6gTar3jctkCRYMJPmQXZiCLot9ULOS/5MMxm/ceOKH?=
 =?us-ascii?Q?tG7SY7a57HTqvakuHN5NmkySiLxFka9vPXk+FGr6MdRNHraIbnN1LevdJDtg?=
 =?us-ascii?Q?5ykOGuMtyB13SqM4vnup6vbS/gcx8kNk339phX3qPekKH+y3jSJOnHdzB1IE?=
 =?us-ascii?Q?vOVC/o+6lrNVX59b2DZ+2OZVcUtwpvGW2M10PLPFdE7kNMjQC1ueUIUMcgUD?=
 =?us-ascii?Q?uDykgZzrN344lA2C363naf0D1HDJSquhWBlGNqsHO6RZ+TF8cttOpB1xt2g4?=
 =?us-ascii?Q?wP8zKqCXvb9VY8HgQhoUPKWWJHYuX4MPNwfXrjrptKxyYNft+YBgh964vj1G?=
 =?us-ascii?Q?BQ5f64+4ecKDXYhnmLZEBGAPH1RELDPV06he3l9DpHRI4WaQDAGSK1p60mRL?=
 =?us-ascii?Q?DO+tI0Ag3rbx+4ckj6EEq4R25afsQUknnERD2f8ZkZiOBWW71xHZSE0qB1wp?=
 =?us-ascii?Q?EwQGmMEPkxAPgvEshqexP3Axe5u4pWRgGsiJxFKqhN2Hgcs7mUmKxSII+md5?=
 =?us-ascii?Q?5KI+NLfl4otrzQhE7fEP2yDrCYbZE+H70bnSqxtIWMKbR8n1AP/yFtP3OQKz?=
 =?us-ascii?Q?WCrFmUysOPYCBEj6VDkI7/2+wJ+8ZlShDyQu+KBUK0bfkYgHbNz+Fo+GAzxA?=
 =?us-ascii?Q?LhB3jJg4ebVrUklOCp6fRPBXJugO+mRcapaA5MtYtrYPrLrdRNM3h5urScmM?=
 =?us-ascii?Q?qBOca40F+uEhSL6KhYy8ca9kCyXom0ouMkACfZMLQ96MksvU8sdouZ1OYWYh?=
 =?us-ascii?Q?F2eiRwo2a58YL76KHfCqE87eBDZwfW4LxCP/pcK2J56FQLtp6fMD0AM38COb?=
 =?us-ascii?Q?czdHe7lEPyPUgoQbGKOXgU8eKJNX+GlCPZgCegaPxkxkZ3FdRk7qeMfDk5hb?=
 =?us-ascii?Q?LeAaWqXPmvYahp1IDHnPVBwK+FV6h2qqY6ohcNa8p3D5v2X1VQNk90M9GIci?=
 =?us-ascii?Q?WJqjThWIALcti1pQ/e5skVFSBiX8C89SOb5EFkBw9sWeVlSQ8ua7Wr4gh1ck?=
 =?us-ascii?Q?ZLZjLsUO2ECAtMtBaYalyC9xnxQKBURCePFV65+8/688s+1XYdIvJOmQ15iV?=
 =?us-ascii?Q?W9eAXIwPWBsKRdptJFednQIZqjrZbsRJK8X1z5KHZYXMROx0w3Aiuut1BqW3?=
 =?us-ascii?Q?IooGp5/IMffQBD6Oy+owuRk/1zwRnhMGoi0DYVOwwgB16FelGjyQX50mxaue?=
 =?us-ascii?Q?AHRxGPDGB2D8XqwZoQH7QmaL6HYckD1ZDSIdlueU8URSqmDmyBAV07kqYZ2G?=
 =?us-ascii?Q?4jANmcbBlAKEezz7B5TOsTFoe/pGK3alhBHE1Lz5S+27RCwMCz+W61mYv4tG?=
 =?us-ascii?Q?bAITNcGVcQou1JjVT9SSVM8=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d0adb-eac8-46ab-d13e-08dce26bbdd1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 22:52:35.4845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pV7IiYHSzIzsVXUFNrIs6YopDV95uybZaatt7dxpvow+FCX4cNKqnz4c6nbIw3v3xK8D0y9PE/RmIQEQkl/Sx7hs0PAD1vrONgK4iwvr9TM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6678

The tests cover mmap, mprotect hugetlb with MTE prot and COW.

Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
---
 .../arm64/mte/check_hugetlb_options.c         | 285 ++++++++++++++++++
 1 file changed, 285 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/mte/check_hugetlb_options.c

diff --git a/tools/testing/selftests/arm64/mte/check_hugetlb_options.c b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
new file mode 100644
index 000000000000..303260a6dc65
--- /dev/null
+++ b/tools/testing/selftests/arm64/mte/check_hugetlb_options.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Ampere Computing LLC
+
+#define _GNU_SOURCE
+
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ucontext.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+
+#include "kselftest.h"
+#include "mte_common_util.h"
+#include "mte_def.h"
+
+#define TAG_CHECK_ON		0
+#define TAG_CHECK_OFF		1
+
+static unsigned long default_huge_page_size(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return 0;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugepagesize:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+	return hps;
+}
+
+static bool is_hugetlb_allocated(void)
+{
+	unsigned long hps = 0;
+	char *line = NULL;
+	size_t linelen = 0;
+	FILE *f = fopen("/proc/meminfo", "r");
+
+	if (!f)
+		return false;
+	while (getline(&line, &linelen, f) > 0) {
+		if (sscanf(line, "Hugetlb:       %lu kB", &hps) == 1) {
+			hps <<= 10;
+			break;
+		}
+	}
+
+	free(line);
+	fclose(f);
+
+	if (hps > 0)
+		return true;
+
+	return false;
+}
+
+static void write_sysfs(char *str, unsigned long val)
+{
+	FILE *f;
+
+	f = fopen(str, "w");
+	if (!f) {
+		ksft_print_msg("ERR: missing %s\n", str);
+		return;
+	}
+	fprintf(f, "%lu", val);
+	fclose(f);
+}
+
+static void allocate_hugetlb()
+{
+	write_sysfs("/proc/sys/vm/nr_hugepages", 2);
+}
+
+static void free_hugetlb()
+{
+	write_sysfs("/proc/sys/vm/nr_hugepages", 0);
+}
+
+static int check_child_tag_inheritance(char *ptr, int size, int mode)
+{
+	int i, parent_tag, child_tag, fault, child_status;
+	pid_t child;
+
+	parent_tag = MT_FETCH_TAG((uintptr_t)ptr);
+	fault = 0;
+
+	child = fork();
+	if (child == -1) {
+		ksft_print_msg("FAIL: child process creation\n");
+		return KSFT_FAIL;
+	} else if (child == 0) {
+		mte_initialize_current_context(mode, (uintptr_t)ptr, size);
+		/* Do copy on write */
+		memset(ptr, '1', size);
+		mte_wait_after_trig();
+		if (cur_mte_cxt.fault_valid == true) {
+			fault = 1;
+			goto check_child_tag_inheritance_err;
+		}
+		for (i = 0; i < size; i += MT_GRANULE_SIZE) {
+			child_tag = MT_FETCH_TAG((uintptr_t)(mte_get_tag_address(ptr + i)));
+			if (parent_tag != child_tag) {
+				ksft_print_msg("FAIL: child mte tag (%d) mismatch\n", i);
+				fault = 1;
+				goto check_child_tag_inheritance_err;
+			}
+		}
+check_child_tag_inheritance_err:
+		_exit(fault);
+	}
+	/* Wait for child process to terminate */
+	wait(&child_status);
+	if (WIFEXITED(child_status))
+		fault = WEXITSTATUS(child_status);
+	else
+		fault = 1;
+	return (fault) ? KSFT_FAIL : KSFT_PASS;
+}
+
+static int check_mte_memory(char *ptr, int size, int mode, int tag_check)
+{
+	mte_initialize_current_context(mode, (uintptr_t)ptr, size);
+	memset(ptr, '1', size);
+	mte_wait_after_trig();
+	if (cur_mte_cxt.fault_valid == true)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_hugetlb_memory_mapping(int mem_type, int mode, int mapping, int tag_check)
+{
+	char *ptr, *map_ptr;
+	int result;
+	unsigned long map_size;
+
+	map_size = default_huge_page_size();
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	map_ptr = (char *)mte_allocate_memory(map_size, mem_type, mapping, false);
+	if (check_allocated_memory(map_ptr, map_size, mem_type, false) != KSFT_PASS)
+		return KSFT_FAIL;
+
+	mte_initialize_current_context(mode, (uintptr_t)map_ptr, map_size);
+	/* Only mte enabled memory will allow tag insertion */
+	ptr = mte_insert_tags((void *)map_ptr, map_size);
+	if (!ptr || cur_mte_cxt.fault_valid == true) {
+		ksft_print_msg("FAIL: Insert tags on anonymous mmap memory\n");
+		munmap((void *)map_ptr, map_size);
+		return KSFT_FAIL;
+	}
+	result = check_mte_memory(ptr, map_size, mode, tag_check);
+	mte_clear_tags((void *)ptr, map_size);
+	mte_free_memory((void *)map_ptr, map_size, mem_type, false);
+	if (result == KSFT_FAIL)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_clear_prot_mte_flag(int mem_type, int mode, int mapping)
+{
+	char *map_ptr;
+	int prot_flag, result;
+	unsigned long map_size;
+
+	prot_flag = PROT_READ | PROT_WRITE;
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	map_size = default_huge_page_size();
+	map_ptr = (char *)mte_allocate_memory_tag_range(map_size, mem_type, mapping,
+							0, 0);
+	if (check_allocated_memory_range(map_ptr, map_size, mem_type,
+					 0, 0) != KSFT_PASS)
+		return KSFT_FAIL;
+	/* Try to clear PROT_MTE property and verify it by tag checking */
+	if (mprotect(map_ptr, map_size, prot_flag)) {
+		mte_free_memory_tag_range((void *)map_ptr, map_size, mem_type,
+					  0, 0);
+		ksft_print_msg("FAIL: mprotect not ignoring clear PROT_MTE property\n");
+		return KSFT_FAIL;
+	}
+	result = check_mte_memory(map_ptr, map_size, mode, TAG_CHECK_ON);
+	mte_free_memory_tag_range((void *)map_ptr, map_size, mem_type, 0, 0);
+	if (result != KSFT_PASS)
+		return KSFT_FAIL;
+
+	return KSFT_PASS;
+}
+
+static int check_child_hugetlb_memory_mapping(int mem_type, int mode, int mapping)
+{
+	char *ptr;
+	int result;
+	unsigned long map_size;
+
+	map_size = default_huge_page_size();
+
+	mte_switch_mode(mode, MTE_ALLOW_NON_ZERO_TAG);
+	ptr = (char *)mte_allocate_memory_tag_range(map_size, mem_type, mapping,
+						    0, 0);
+	if (check_allocated_memory_range(ptr, map_size, mem_type,
+					 0, 0) != KSFT_PASS)
+		return KSFT_FAIL;
+	result = check_child_tag_inheritance(ptr, map_size, mode);
+	mte_free_memory_tag_range((void *)ptr, map_size, mem_type, 0, 0);
+	if (result == KSFT_FAIL)
+		return result;
+
+	return KSFT_PASS;
+}
+
+int main(int argc, char *argv[])
+{
+	int err;
+
+	err = mte_default_setup();
+	if (err)
+		return err;
+
+	/* Register signal handlers */
+	mte_register_signal(SIGBUS, mte_default_handler);
+	mte_register_signal(SIGSEGV, mte_default_handler);
+
+	allocate_hugetlb();
+
+	if (!is_hugetlb_allocated()) {
+		ksft_print_msg("ERR: Unable allocate hugetlb pages\n");
+		return KSFT_FAIL;
+	}
+
+	/* Set test plan */
+	ksft_set_plan(12);
+
+	mte_enable_pstate_tco();
+
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_OFF),
+	"Check hugetlb memory with private mapping, sync error mode, mmap memory and tag check off\n");
+
+	mte_disable_pstate_tco();
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_NONE_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_OFF),
+	"Check hugetlb memory with private mapping, no error mode, mmap memory and tag check off\n");
+
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, sync error mode, mmap memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, sync error mode, mmap/mprotect memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, async error mode, mmap memory and tag check on\n");
+	evaluate_test(check_hugetlb_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB, TAG_CHECK_ON),
+	"Check hugetlb memory with private mapping, async error mode, mmap/mprotect memory and tag check on\n");
+
+	evaluate_test(check_clear_prot_mte_flag(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+	"Check clear PROT_MTE flags with private mapping, sync error mode and mmap memory\n");
+	evaluate_test(check_clear_prot_mte_flag(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+	"Check clear PROT_MTE flags with private mapping and sync error mode and mmap/mprotect memory\n");
+
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MMAP, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_SYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+	evaluate_test(check_child_hugetlb_memory_mapping(USE_MPROTECT, MTE_ASYNC_ERR, MAP_PRIVATE | MAP_HUGETLB),
+		"Check child hugetlb memory with private mapping, precise mode and mmap/mprotect memory\n");
+
+	mte_restore_setup();
+	free_hugetlb();
+	ksft_print_cnts();
+	return ksft_get_fail_cnt() == 0 ? KSFT_PASS : KSFT_FAIL;
+}
-- 
2.41.0


