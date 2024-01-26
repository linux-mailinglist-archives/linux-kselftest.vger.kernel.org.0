Return-Path: <linux-kselftest+bounces-3617-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB82F83D3E9
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 06:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 635D5289341
	for <lists+linux-kselftest@lfdr.de>; Fri, 26 Jan 2024 05:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F37B676;
	Fri, 26 Jan 2024 05:23:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2047.outbound.protection.outlook.com [40.92.89.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788EB660
	for <linux-kselftest@vger.kernel.org>; Fri, 26 Jan 2024 05:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706246616; cv=fail; b=gDIZGv2ViAC28QjhkbFVpsBJc/D6V0ML62NMC/GZhT9+Ego76TdC0rKjQa6eqofEbvtIlcgA5K3CwGDIWQzitloQR2DlxN9WWYyp/6ylNFc8/XTp2UEYuVEiRsmhlzNVAo8TtzhnqeG8dNzivbmd1EFDpbpD8siOC3zEWwrozfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706246616; c=relaxed/simple;
	bh=w2s2qdnZ/fGR2MSX3PaqtR1TdaokoiliusIqVWYRsWo=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=QjeZh0n4tC9v35yw2iIb6TmejXoy6NxQKcuk8L+uUXXPx6CsUenHVy5YpM8/JMXuGfZf3hBk/SbawbZTBfFzbr08auxXqtI4rfwrELWDlRCaxlkIxb6BJD3XQj2sccfPf9w7klgykUzJlq4/z1WPqnxudzA5Ljyz80KdCXqt0RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de; spf=pass smtp.mailfrom=hotmail.de; arc=fail smtp.client-ip=40.92.89.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFEjXrJM8aBahieUsK5h8j/UKXJgYHCJDWOue4grEm3pp+eln79BkL9ZulPMk0P9Ewqq83iUdenYe8yYG2RxQwivp6A4/LVq7/n04ozvMPqpUEf5GHYInZZJMNrWcTdSyejH2Z09bX2NBj/xvbiR6MUaTKj7L826jA+S0/gvDSW8owlOYQFEsKhOsiqwfQSkLBzNh2X2SJnHC+viXwqNkayW7zwgyhbdsFJxS9rINKdFIK9ISvcKWxFm2Yx/qTlclDfW+kyrAr8p+sHDJpBVdkSJzH/YS0DTP0ojWSPfxzOMtSaj44eZkf3COvyb6aQgwN8O1EMtv4bICiPsGq1iHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDE4DC38trCN6DbAgZYvYfUfYN9iHjlr8cRpWNvtfGg=;
 b=KR7WYssaq+2B7EWcPy3wblbVRY7pTHd08a65naFlqAyPir6pUUfFM1VR+zJHfnDuT8jdoaS71WN/IZx1jCP72JvfGljkBMe7qOw78bxQQlfq8uqpR/83qiuCFSKUJzmS15PZLKfiPuAiYLRbBdIcolqbCa49yM7upsXw3t/8uDxl4/hE//Rb0E8VUECKOqpJDHdubNPFks9MH/Og8kGECliSUs26AaYSkgdqSUMmzaz74xv21G5sRLg0bNr7e05ixqIloE3gccK39SZ5Blgm/ZTkhVmvoGM7qCUpFONqYQH+g0c6Fybe4FrllhROuN1ojJ4IIaZNo14kV+4rKvYS6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AS8P193MB1879.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 05:23:32 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7228.022; Fri, 26 Jan 2024
 05:23:32 +0000
Message-ID:
 <AS8P193MB1285C963658008F1B2702AF7E4792@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Fri, 26 Jan 2024 06:24:34 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Shuah Khan <shuah@kernel.org>, damon@lists.linux.dev, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH] selftests: Add missing gitignore entries
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [h5/JnPzjPpzmLc76Ay5IQc65WWLkcfz98YTqFbEa5dLkErf+NNATIRinsMUX48dU]
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <8239a770-e98e-4458-aea0-0a5d960ab836@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AS8P193MB1879:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e912bf5-9278-494b-cfed-08dc1e2eef94
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XCZC29DyY0DfbTKvLe16ZH1u6j7vhclq5b9zDSZegRr1HJCANGAv8GTvLTdF1LaKHO9RyZPHvtDlqd6qgEnSsfHc1Jyiy33gJ94VvzXUWGZSR2j1EqErQMs2LiG9PNgWQxCz7HzmyIDqzsgHE8IDRZfJD7+2nDhd6TfNMWztlIrvnIB4oFhhUaGQNc0HtL67+gm+gBgwItD1+Fk6hUhaFbSutocg26vQrCMkjZX6rAzlwijqfLMXCXoQ1JEys+Kr8AtY9/ZUYjC4iLqktlt4qBclnhe3j3DLZrn2p4z5kb+U4VgXLXYFdG9KWS4IaxxEte3/Kk8rQsi7MoUjb8LjuvIH830cQYF6/p7hK1B3iVmOYt7bztb3bI2mm037BXHM4JTTZei+77rE747SVb5La1n57b4lLBxAK29gcAFguCXBuhHsNsn8wwAdMEGVe6HXF+xXv8dIg38yt5V+Ea5lUi2tkp/oJVr8UVZepeOT8PqBf9+H8MgW4vIfXhuC/pGQA5z2q6vQt8/VtTSeA3cvTDoVHi5Q/NhnBH86VXjQSUui0fCvKBhwIDNqtjoLMR9Y
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czZ5LzJxaDAyZmZoZlNhSDNrdXhNQjBoS0pQdUkxQUJXc3dvczVnaURDOHI0?=
 =?utf-8?B?MW8xdjMydTIwOUJFeU5sMG9zL2dQcnpRVTBVejVtL2dtbGZCemYrelBoQWhU?=
 =?utf-8?B?SjBZZGIwSWpQbWc5RlVYdjUzOU1PeGNPbHBtL0c5MmlQaVMycDZsUkxScjBT?=
 =?utf-8?B?Z01pUnpJRFA0MVUxNHpQZlF1M01qNkpRbU12OW1ybElaMHF2MGliZk1sWFUr?=
 =?utf-8?B?eW51OXN5WUo3NFBBU1dLNDUzdERtakYyVDh5TjVBM0J4M01zNW5pSVh3VUl0?=
 =?utf-8?B?WkhnS3ZxQStSMTFYMDFFWjRycUtReUJNOVE2V0FQczhUcDMxUWdpMTRRUDZ1?=
 =?utf-8?B?My9SSDBpcldUMWRZUVE2ZUtyeEJLZmdXaUxJN0J1djJZNG5QQStIRHhhWEpY?=
 =?utf-8?B?bnRpTzZXUjdWVGlMQ1AzckJ2U3g3SEpXZ09Ga3JxbDU0QkdvYlZvWFZBMm5F?=
 =?utf-8?B?ZWxKNDdLQjhlallEQ3J3NEFOT1FDbnNiMUZuSmRjK0hmdks4OVVzWGhra2px?=
 =?utf-8?B?SjBaanNqRTVYOE1ZczBvUHhicThXdVZiSXJoVXNzWWpwR0pCVWtGR3VHM2VK?=
 =?utf-8?B?Ky91RCt2b29EeFlkMmsxVmYrK3lHOW55K0N3bjR3TGVrS0o1OFdsZEJ2TVZi?=
 =?utf-8?B?Q0Z0cnc2YzVyQjNOZzZIQTlqckJKYzdaem9TTXM2SkYzT0JaeEN1aHY5YkFW?=
 =?utf-8?B?Vm9mcTZFbGx2YTM1Wnk2YnVMaGZqRk5TVGJqclJ1SWJTeFVLR2svWGRCVW9G?=
 =?utf-8?B?RFRuOFZLTU5iZzFHSUcrUlg0KzdLT1J3ZUh2OUdXUTAwbEtTMWJlSkZQUk5Q?=
 =?utf-8?B?RW5kWEVrOEtDelAxZWZQZnd4SWR0YkdsTWl3UHExVTYwMGhWOHA0Q25JRlg5?=
 =?utf-8?B?ZldkTE1wWnJEQ2ZRaXptNXJsL3dmZEZ1YW5PcnRmcTY3R0UwZ2huT2VsMk5F?=
 =?utf-8?B?M2F0S0dIalo2VkQzRnM1SVRDblY0eHRnUG90M2dQSkttSkIvazh6U0s0NkJa?=
 =?utf-8?B?T0F5QTBvVkdJVlVoeURqL20yanh2WE13eVBrSGlNeHo0Uk1QQnNMdE00T2Ft?=
 =?utf-8?B?cGlNcGdaaXJjY0dnZnlicHdqMStib0VSRXFWL1hwaU1CeEdyQlZyLzZZMi9U?=
 =?utf-8?B?aWNYRENXcXl2WXh3RFczakxoeFVmUFdBLytwa1B1TGVkVkMramgxbS9IR3B1?=
 =?utf-8?B?bGptVE5TQ1oyT3NTSGJTamJRM05nRVZIT3EwNEpjTEVoS0hFU0luMm9pSGJZ?=
 =?utf-8?B?a1hXZWdMS3lsVUxaTDF6TzhKcFc3TFpwMUkvVjRJQll3UURXSnI1Q1haNTF0?=
 =?utf-8?B?VmdBL2FPTUw3M0NaTVR3dldaRzhGSE9mQ1JkVEpRUjlTSTVZbDllZFFmS0RQ?=
 =?utf-8?B?RzdoSlF3L3F6dWJMMnNDMkcwQVpwdW9zRE9CbUhRSnN2SkJDOTVGRktlcXp3?=
 =?utf-8?B?WXVMNTkwNEREUU16c29JRUwvTjFUYUJyWXcvUVM2WkI5RXBWc0NTOGpleXFv?=
 =?utf-8?B?Z004Q3NucTFFaStMcmlWWVVyWFBUTEZEUnh6UHlNRVBOUG54REw1T0txSGha?=
 =?utf-8?B?L211eGxjYlhzZ1FrK3IwcXJITkhoMFhnSEV2WlFyZEkrR1Rqd3JKdHp5KzhM?=
 =?utf-8?B?VTBCTm9aYTZRd2tSdXJ4eHdUZ0tuUzg3MEcyWENRUFF1TmFpU3dBY25kV0NP?=
 =?utf-8?B?MFdDVGtXZTAxSGJudmxsYkt2U29DS204bnVGUzM0ZzVDQ3BsRkY0emFOY05v?=
 =?utf-8?Q?yCUpJNB4CV4AVTt0co=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e912bf5-9278-494b-cfed-08dc1e2eef94
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 05:23:32.0049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1879

Prevent them from polluting git status after building selftests.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
---
 tools/testing/selftests/damon/.gitignore                       | 1 +
 tools/testing/selftests/thermal/intel/power_floor/.gitignore   | 2 ++
 tools/testing/selftests/thermal/intel/workload_hint/.gitignore | 2 ++
 tools/testing/selftests/uevent/.gitignore                      | 2 ++
 4 files changed, 7 insertions(+)
 create mode 100644 tools/testing/selftests/thermal/intel/power_floor/.gitignore
 create mode 100644 tools/testing/selftests/thermal/intel/workload_hint/.gitignore
 create mode 100644 tools/testing/selftests/uevent/.gitignore

diff --git a/tools/testing/selftests/damon/.gitignore b/tools/testing/selftests/damon/.gitignore
index c6c2965a6607..79b32e30fce3 100644
--- a/tools/testing/selftests/damon/.gitignore
+++ b/tools/testing/selftests/damon/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 huge_count_read_write
+access_memory
diff --git a/tools/testing/selftests/thermal/intel/power_floor/.gitignore b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
new file mode 100644
index 000000000000..754810406b33
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/power_floor/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+power_floor_test
diff --git a/tools/testing/selftests/thermal/intel/workload_hint/.gitignore b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
new file mode 100644
index 000000000000..b5448c0576c9
--- /dev/null
+++ b/tools/testing/selftests/thermal/intel/workload_hint/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+workload_hint_test
diff --git a/tools/testing/selftests/uevent/.gitignore b/tools/testing/selftests/uevent/.gitignore
new file mode 100644
index 000000000000..15127939d872
--- /dev/null
+++ b/tools/testing/selftests/uevent/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+uevent_filtering
-- 
2.39.2

