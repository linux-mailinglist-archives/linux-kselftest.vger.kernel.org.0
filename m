Return-Path: <linux-kselftest+bounces-14840-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 362AC948AF2
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 10:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6EA11F24EEA
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Aug 2024 08:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043601BD00D;
	Tue,  6 Aug 2024 08:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j29ELkaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AB516EB40;
	Tue,  6 Aug 2024 08:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722931853; cv=fail; b=K06+Zxc1i0GK8YtfM0SNzWyjnJDsq18fXQBOd2Wmxto1dB08Umhn3FDtoqYgw9l7DZaCYkER16M4aiWMbLbZblWW9pP2XeQlTZ+JZEOuV+xsvtBf5fSmD0HVRhIwfeYza94fhfk10ywVdj57K1f5OcBcm/xljO15al2dQNUMEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722931853; c=relaxed/simple;
	bh=EikHq8El/gI9/Vfd2PSGfeoa4aUlVCM2zDgo2Z8pwHU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=r/M0YRb0USs0g30insdLHO8FgRY+exxdTCr6W9g+Cbj+LPPoQb4QxB63eIpjmLYBft5KvhtJ2oAvmp9ISf/MkoOjZpZeA442Rgg6x6vLAFYiDKfcEgkE0ll54O1xCXPXg0H/pXedEO6Z7/r0K9Q71N2ydnHQo7DqwlEGMK9B524=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j29ELkaN; arc=fail smtp.client-ip=40.107.244.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/ysp8VdzbHKztUzjVx1swHD+geGfcIhTdWDtcK+p+cN9s3GXXd0eqLiS6jAZLgRzdaQldZIrAPrxLqmnjVqWF2zWj+cfvnXJYw7aTihD7Ej3TGqwywRxoUsRZYtJX+Nwf5sk445H909mCfMdi8ASx8caQMhvb5rpRk1keLA/65/9RqKxbTJRJcEkWEwVxOt4upMz79EviT02D/7N5HG02KTpgw1H01GLRqzRGcHtbihF8OC2osbhQYGzC5JFe23NGg1CG564s+bfGeHUIUFEpX88FsjDOxDgJ+z5spdJjqwUs6S1kP+wAWNBcszCAqDBTlYX8SBPV/houoAskH8Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bs2ggEnyeRQmDOLduo7ymTf/U4W++9raBxSHrQyjOl0=;
 b=rp0MbUR8Xfd9qG7kAI0FO7AfJoNTx1kBDmMxmfX0PaQtFCNS/94hgqDTT+bv6j1OBL/4loQ17waP6/v9lqZ/NtWTGFp48Sju4W/lqkX4CLnGqdZv/VRIcRLrhLy0oEPJtgo+yckWQt+ulCttj0m3ELULDeuFij0+Gwsj6KmRNiNLIjZ7BIs1X3PeJeurDG04Y7ahD9kZGac+yOLCosLfXJ/hIFMTx5RGg0vnjcu6dIK/ggCUFYrQJoa+ZTh6A/icVX1wvyKzafyOHxV8+f16Hz5E+JQ7nxphhvJyo88l41MsyIR6hNhkf7Juoe4o0EpKmkYLjUSBl+7DT+E23HrQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bs2ggEnyeRQmDOLduo7ymTf/U4W++9raBxSHrQyjOl0=;
 b=j29ELkaNto47bTvHBW0lM6vC34nKNQVoQLpUaz3Equ7RG3lZFs9sD6DnCOOQxtlzvj21APMdzvYf+Y9KYwPjzwnp0k8kI1Ekbas7HaAmNAwDaMTVlVY6QimQxPBNtNtb1Nv3QSQD+pB2cWn/AWFpQO/FblurYVEPWlGVHrAXYOybSE4ybkC4Trby1JLtisq9fwAh9D5ej7CI7jSxVyyTrsnZVnqt6/Kz1vYn3ENmvruIREUR6wnBkR+bM5Po3Kc9W65riQxosWOKMfymYO1sFPRh/V2g2DhXYTXcXhnTn7aFj64ls3wvc5g4KCHzVtCRGzw3AsAX339qat+RskAKNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.25; Tue, 6 Aug
 2024 08:10:49 +0000
Received: from PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f]) by PH0PR12MB7840.namprd12.prod.outlook.com
 ([fe80::dbe7:2850:c5de:b17f%6]) with mapi id 15.20.7807.026; Tue, 6 Aug 2024
 08:10:49 +0000
From: Jeremy Szu <jszu@nvidia.com>
To: shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	james.clark@arm.com,
	linux-perf-users@vger.kernel.org
Cc: Jeremy Szu <jszu@nvidia.com>
Subject: [PATCH] selftest/perf: Add perf-test to perform perf testcase
Date: Tue,  6 Aug 2024 16:10:43 +0800
Message-ID: <20240806081043.44935-1-jszu@nvidia.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: OSTP286CA0015.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:223::10) To PH0PR12MB7840.namprd12.prod.outlook.com
 (2603:10b6:510:28a::16)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7840:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f561849-35a5-4c57-4771-08dcb5ef484d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J9UzMx2wEJbSnFJ29YUEGk+czaWAhz3yUk4LSHJWHj5Ej7sEErDy0lLUaiQn?=
 =?us-ascii?Q?rjx7ul6x8Ln+2NZZejy5ef1fgJ22g8HoNox3WxrDi9scPdPVDMxO9D6ELnr7?=
 =?us-ascii?Q?y+5Ks1fWmCT1OGrHEC20yeHyL3h6FnUzj6mrEbIfI0K08pHkRzXmHLcKKnHY?=
 =?us-ascii?Q?5x0VtIKBbFgloPz80o3sf+vk7+cn1PC229X54wDHaIXibDA/xTPbFgCMthTg?=
 =?us-ascii?Q?JksA7a+bRzY+NEPVhXQYgF6ZsbR6Eg/nAqhoe0zrjuO8+tvAej0xh3tUo1J+?=
 =?us-ascii?Q?gGPMMAQ88lgHnIW2q/MKgNT68unLA8xDo8p43dZTKSwNo6agnMi3e+XA6fJt?=
 =?us-ascii?Q?PGXheHqo6dT+1kYcV77tCc63Wi17wxm02JiUWtCE1fTQN4tfSH1XMt8rqgrm?=
 =?us-ascii?Q?4BJbhZMJKt2TFmStyzkn9ts98SxhVBgW8BHlTQAv/8REPhwjqGzjAWaoLVJ9?=
 =?us-ascii?Q?jJrYTIcrFIAWwiaNzgbLA3dNdEgp882CM4kEDsO4vncA0ZdJq+0BsBmKX2Mi?=
 =?us-ascii?Q?xKiaEu6CRttdmmQrUxqYW1NSDjp9gwG43BnbRFclmYZ1tXPEa+8ww8xWcwSt?=
 =?us-ascii?Q?UYSy7pYzCTRwZEum+df/tjwOtQJqjweXaLdKYR9ICNUXf+3JGFKeFIERMVaY?=
 =?us-ascii?Q?8Ae2+LGzwVgC+6/WTiMfYuZOXkwrEFkNza/zVV/ZhoGb47JLtdWW/lp30bHF?=
 =?us-ascii?Q?Pp6z2dnxqVYmbUoe4jV0UhD0MvtBUS51F8ksePpcfkffIhPVtD8Zl/7TkXJv?=
 =?us-ascii?Q?p5ac1iBvDnD9fl3eMQdQ7zW/8TFv53/c6BDHbHn/5xKJuvKrtHbctbQx3BWE?=
 =?us-ascii?Q?k1YDVGID8BR9YSlCDZLbO2g65L5wzFf+e+nQLe0wArwLMffBdHL59OROlpMl?=
 =?us-ascii?Q?3gX9yzy/jK/8bRJ8nj6uFhbGv5QU2StOgbUFWXoJP1mFVOw8f1vWWnUamW0F?=
 =?us-ascii?Q?C50jCfFq8F/o2CehBLV+iEYGyfnA5hMaCEdsK5UXFsDrICwAu97k5oCHjJVM?=
 =?us-ascii?Q?zklOPZpdZmbkds5MUATrfH4kOn5et/U7iWlicHR/cJbb1EXqxghTT/LbiwgR?=
 =?us-ascii?Q?VFZ75fgYo73X15lsMd7YlYniFf/OZnMtPPRMVIRPhGVGC5SsLs5yh2bDxn7+?=
 =?us-ascii?Q?JQv1uopTIuI8nAlsrlzWBeU2ih3TdpGYQVP8b2lfAQbn7tAn1gs5uS3wxw0v?=
 =?us-ascii?Q?SflUOmbT+l3J34J7LT8CF0gb/9TyMycG/o8eAC23/J74eYvu7Jxkc2o8ryep?=
 =?us-ascii?Q?ZtkdQpeXhKe+twRIFr4jts5PNmfRZvpcdzH3fwbq5GPr1ZFn6PlLwur8lGod?=
 =?us-ascii?Q?mohSoZqmt+/lAfBoqhtfogJakru7QSDTzB2CjRPRaDg67w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7840.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Azp62L/qF3lHuhntQIdnv1FXqrRz03+kamAyBj/OB0bDifTqlf9fb0QJ7Vgv?=
 =?us-ascii?Q?N81CnhUQYr6kuAloixxKXzhCvGothrIVutSKoVNK7L1jW2j47ilBDggY72uM?=
 =?us-ascii?Q?5Dd18C/FMY9Idt3PyU+mv/hPNTtsGOtb4zZQvD0CP91J194D3k1BMQq9M4uk?=
 =?us-ascii?Q?J1JgC3FpiKXNHpDiUfj2cth6iHB7fgLecoiiJOGCfAWfPexRTEO1XHPd64Q7?=
 =?us-ascii?Q?wRbCQ9PIZetNphiAqsJXCCjgxHswLJNTshEqUeoFcica6mospifkcR70fuZN?=
 =?us-ascii?Q?eGkS1xoKJn/CSGF+tsuz0eEghb3aIJi6fLL9ho+FFsAMqmVC5U2Lc+JqMGru?=
 =?us-ascii?Q?lvk0JdPfbHE3OjQnz4l11aEo483lAXA1ozBGD3mYh6C4wlrcE7M6zRjTJQ8u?=
 =?us-ascii?Q?37Scm9li2OtI/Vi+SeOml+S1kU68zDE4gfIV4w2jdKXe1SfaVe3r2LBelE4b?=
 =?us-ascii?Q?1dhgvIdZ0GHrh/1Ycz5FfTAAZYfYhHJbEMIAcbcrJVz2Va0v9FzOXobSDtxV?=
 =?us-ascii?Q?+JKEUCFSHXmJUrdBBsud7sXsAmjEVCgVtdm05orYSQ0fIA92dV8g+0xvol9z?=
 =?us-ascii?Q?aRvFxn3ISsMsuFHXVkFiCjTiEB0LTt2fX1bkaTASE1JhpdQf0KlQm3ONQ7kL?=
 =?us-ascii?Q?uXx39yU/Sjw5G7RMlb8/RcW2WxxyVa9D9pGlPjWbD/Wzn+HjuK87d7qTZza/?=
 =?us-ascii?Q?zv2DdqIOQue+9XFpUeWi9q/Zac8zSR5+W112nAggru0YP/gSMXY8yopsGxpz?=
 =?us-ascii?Q?W7n0LVMFiWXh+DsuTxM2v/6n3SNdBzsEzXYcebYEqitZwrNIWHoZ8/8jftmR?=
 =?us-ascii?Q?rph61HY8XWZrFzXl9uGMMnWt3ce3c5tPEmdIYu3dcNi/zOKwDBmNCH4eFDtm?=
 =?us-ascii?Q?rTrANF4oCTTN8jrht51YrurFh+il6nG5EaWXGtWF8aN+mzRaviLWKnITAVJS?=
 =?us-ascii?Q?yUZX10o7K1ZYXa0LpuhvCj0cqMFqecSZK9SULo2Eg2CzgYAY2Cy5FeugxZA0?=
 =?us-ascii?Q?JiHXIDr/uWc37uvN1R+sy+P0J9rZij4h1hJFVykFr5dkaEzM5JrpqLiJyi4w?=
 =?us-ascii?Q?/9t58MPvxXVrGAZTyVO+GFbnpUCgHIaGnm3RkAK26Q4dgsj2YADumBl8orHx?=
 =?us-ascii?Q?/poRj/vhSyDXMNYR/3eBuDBKqEKI5ooeDKLZP/QL7PxlDbB4P62OXukBOfHX?=
 =?us-ascii?Q?nxB8GvoYG79E7MLc6XAttiPc5+hdgvfDN7OhnDGs3YKJopCTT1OJc+w6XqH3?=
 =?us-ascii?Q?s6qopuNiBseifX5yeO1USnsWRxUn7WrPCPGZ8Yt1GzPknxkQzJh4BHozYgam?=
 =?us-ascii?Q?eMGwtvtB5XbJHB7ux+qEwtU674LG8sZ/ZAr+br+3KUeRrO3spZHdS1EXDhGp?=
 =?us-ascii?Q?OHtfsPFkSw8gzQU+w/2Zb4diYW2VhoCHVv3xilfKRa3CwLXfLojKtjEtLicE?=
 =?us-ascii?Q?ZLhF0oVLo0/mkmepJrE9jFynvVVmU0XmA4+X43ricJ7YBNZzjIxP92Q8f6ew?=
 =?us-ascii?Q?9qLv5hvvZI2AmYwZIQB0TE7RvG000aK4Vqd/KxODfEadQ8EVotkSCSi4wRu2?=
 =?us-ascii?Q?fs1k6HbRk+RYGRFJgZo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f561849-35a5-4c57-4771-08dcb5ef484d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7840.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 08:10:49.6512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2trT/79T2G+e2u6F2q7BnGF5iEE7NjeRrxJHa2nrxZ/IEFRVEcAVRHNqMa/nhHbF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

The perf test supports testing many functions and includes a way to
detect the prerequisites for each test case. Add a script to launch the
perf test.

Signed-off-by: Jeremy Szu <jszu@nvidia.com>
---
 tools/testing/selftests/Makefile          |  1 +
 tools/testing/selftests/perf/Makefile     |  5 ++++
 tools/testing/selftests/perf/perf_test.sh | 30 +++++++++++++++++++++++
 tools/testing/selftests/perf/settings     |  1 +
 4 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/perf/Makefile
 create mode 100755 tools/testing/selftests/perf/perf_test.sh
 create mode 100644 tools/testing/selftests/perf/settings

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 9039f3709affb..7598dd39cad28 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -67,6 +67,7 @@ TARGETS += net/openvswitch
 TARGETS += net/tcp_ao
 TARGETS += net/netfilter
 TARGETS += nsfs
+TARGETS += perf
 TARGETS += perf_events
 TARGETS += pidfd
 TARGETS += pid_namespace
diff --git a/tools/testing/selftests/perf/Makefile b/tools/testing/selftests/perf/Makefile
new file mode 100644
index 0000000000000..72d90c71ab290
--- /dev/null
+++ b/tools/testing/selftests/perf/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TEST_PROGS := perf_test.sh
+
+include ../lib.mk
diff --git a/tools/testing/selftests/perf/perf_test.sh b/tools/testing/selftests/perf/perf_test.sh
new file mode 100755
index 0000000000000..ee78b4f9906cd
--- /dev/null
+++ b/tools/testing/selftests/perf/perf_test.sh
@@ -0,0 +1,30 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+skip() {
+    echo "SKIP: $1"
+    exit 4
+}
+
+fail() {
+    echo "FAIL: $1"
+    exit 255
+}
+
+if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
+    [ "$(id -u)" -ne 0 ] && \
+        skip "this test must be run as root."
+    which perf >/dev/null 2>&1 || \
+        skip "perf is not installed."
+
+    cmd_output=$(perf test -vv 2>&1)
+    perf_ret=$?
+
+    if [ $perf_ret -ne 0 ]; then
+        (IFS='\n'; echo $cmd_output)
+        fail "perf command returns non-zero."
+    elif [[ $cmd_output == *"FAILED!"* ]]; then
+        (IFS='\n'; echo $cmd_output)
+        fail "perf test got FAILED!"
+    fi
+fi
diff --git a/tools/testing/selftests/perf/settings b/tools/testing/selftests/perf/settings
new file mode 100644
index 0000000000000..a62d2fa1275c6
--- /dev/null
+++ b/tools/testing/selftests/perf/settings
@@ -0,0 +1 @@
+timeout=600
-- 
2.34.1


