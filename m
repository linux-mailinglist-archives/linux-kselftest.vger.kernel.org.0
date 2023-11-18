Return-Path: <linux-kselftest+bounces-269-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 006777F0217
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 19:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD71B280E81
	for <lists+linux-kselftest@lfdr.de>; Sat, 18 Nov 2023 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD03134B3;
	Sat, 18 Nov 2023 18:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o+J4Q9A3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2071.outbound.protection.outlook.com [40.92.91.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6C1B7;
	Sat, 18 Nov 2023 10:48:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvdMaQGm8/Q7uUaRkuFFvj9dWfqyxbMwhqnZqiHuJ8ytC8VAKNShlUMhX3olcUv2BuwPrMgV/F5P6zzcDRqBkktS3Bd4wsIlv5qL96h4Peml37r/ig3To4Fll5dp+jQ2Tt8Mn/N39k+ss8sw1KQ88wcN2/xoZv/FQ7wl+l5ZEugvvpi6Gat/Z63Pxuk7802lutAj43n0wx7oeX42NgmX+RNx35PuRX+gWSSc3inxp8Iwuf22Nc/3NlUPvBumKRcnfm6fu5FkcvAyvCNxLzq06nxPMPNvS7eYbgGdNrj9N03Oxe9Sx7se+fivwA2kEHNlyvT/DnlNORYCEzkfjAvMTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=BGnyt1Mn9M/mfFfnYVIXducEnji2rcjtq+ojOWA90AiS7MhvR7KHbFdO/hJNoVCk5Lbj7ypUy6FmkWdYNVcgP7gRO7RK6xtoY9ezeSho0PHacNa13dnZSkOuVFLEXhDzKfvi36pGo0wB0VzOLDXk0+n6L+i1FfuF/m1ipgiCzyisQ4s1i3RfK6294IRwICZQjTpTGkxmreAaFJqTAFBVK87aqvfqdn+NbLqb9HBI5KWq4mCUIuYHBaJarbN3kjrk4ZYPcBnPI8oDjWEPswCtjBvNoxmcJj0zsw1yii4+YWVZNCar4wIvzOMC3YcQaWDsLM3RfLbSkyw2CS1STkeP9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEV6FSvKBUg1qgQLg6TT1AC2iHwQLooeot5R9UOQzCQ=;
 b=o+J4Q9A3Ae+1x88XvQR5kDf40CSKA+ZUsvB3TWrt4umMzhU2S05GToomGVADTF2EJbVwv7LBmNZOS08X5y7H19vZ2ZtcZ1TGD6jv2e0Qd2kv3qRcKuZcZ55hq5jWhopPoLGR8R4WehrLFn2thBEMHxs5HoV0w8U+4O+Ni/k96+Scqf10CSKnkgZ/yJVjULSijXsrhovVF/tZ+fg5pKp4lbenqNQ1WCbheUIYhNjZEOWmVfagCZrG4fP7kR8sa+vz8pHWqLTxglrBtw8ljKLQUfJN9sdHYfYLI06Lz5ps5sCm75M5evPaV/nLYDPeqG44rdK3crziGA8kpoj4rAFUpg==
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
 by AS1PR10MB7936.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:471::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sat, 18 Nov
 2023 18:48:27 +0000
Received: from GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450]) by GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6c45:bfdf:a384:5450%7]) with mapi id 15.20.7002.025; Sat, 18 Nov 2023
 18:48:27 +0000
From: Yuran Pereira <yuran.pereira@hotmail.com>
To: bpf@vger.kernel.org
Cc: Yuran Pereira <yuran.pereira@hotmail.com>,
	andrii@kernel.org,
	andrii.nakryiko@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH bpf-next v2 4/4] selftests/bpf: Replaces the usage of CHECK calls for ASSERTs in vmlinux
Date: Sun, 19 Nov 2023 00:17:57 +0530
Message-ID:
 <GV1PR10MB656325F13ABA4DBFD4663C33E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
References: <GV1PR10MB6563AECF8E94798A1E5B36A4E8B6A@GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [/8NAesCYMHq/Ig6o3N/ES7xBrt69hz/u]
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:83::20)
X-Microsoft-Original-Message-ID:
 <20231118184757.231739-1-yuran.pereira@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR10MB6563:EE_|AS1PR10MB7936:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b09d681-79e5-4a25-135f-08dbe866f32c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hfHZTdVuTc/mnt90k23lNrpY+GvXYa6AOxAED39gUgCVuK4mkZ92CdwMmClk3TZ2is2K58n2txuan7g/LU3zsoMyiGriyF5HU9CbFh0nFwfHsRtYVuF0q56/ZyFSIuaMS7Wk4x3tRifw6HRh7HPv1jiWI3snjRv3+s8eBperjlUoqcw8wjxXduVpZ49k22wS2SQc+44O/HfEV8ZtXfFh48grSamNwTKiyhs/00BdXLTUIhKDY1igmiA1b1/Qxr0THIQ7Qt2MJLglKlf7W9Cl/NqEpigop3n7noAHzciiC7PDPmMFC9ytyaMKeJLTJubM00UOCEGsm5Zw6zXr3Uky4mgaY5LoUw1c2ZKU0lCwFeGZ0kIjgLdN7ZdcAKIXJPVk9wkQxCwBuJkHdInzC7D8GPb4vLq0d3dSRTnlpsOuD1AccCiumhmoETj/T8/Nqg1Cc31BXHBTTSeJRvKSkFEu7Eyk6ujEK80A2xf4KQmQbjeeUW9Atf96t0NeXjYadCooHcjx6+edVTnYYS76iFRaWw0UBhOFtfgxwfyWZMnvNyIOo77rv62Oevlf2LnYn6J+Wtl88K4CXtalGo2ioFCpKXWJDnNunAHevGFgRJrheYE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mI8wYgHAavySXjmsy71P7Fks4gTn3rEuM0zlexguhI2X83L2qHHR4olIEXHv?=
 =?us-ascii?Q?evXb2kPcqprXnEJ2IrE3e1Wfhs/G1NWkXNmzZg66KmOyT7Iw4Mw+eekHfb7U?=
 =?us-ascii?Q?YFx69+IFsbYa9enyWjCD+abBsGr6sx0UFaro1xknQfRMiOcgzPx6vhzNO2T1?=
 =?us-ascii?Q?HTD922Ab0+hhmGaIjVmGRNnlabKsHNW3vo9iNQpUQHcJR8HpsmRuURkbatBq?=
 =?us-ascii?Q?J9twGb+guJqu4qMBh9wD4IajigWFzxjRkc/3uZK/T/KshKsovp1Vx8Sfb/th?=
 =?us-ascii?Q?pvTe3KY5nNyn7af/VTiyeJkXPlmOEbZxNxXCNYJg4xYcOyDfJHVzrqG7Jgih?=
 =?us-ascii?Q?VJDKFmdF11pmJrxtDwxfE8T4zoN3xT3/y3Miwns9Gi61ZL+FbJDGESjSqOYA?=
 =?us-ascii?Q?mfqmHC0N3g50bkH9axiSK6PETnydWzYtG94Qri+mOhHxXVEpaVmUH652iXUB?=
 =?us-ascii?Q?oUU4X8clHEA/Xvvgqc+zi3dxoudpZKffuLnXIs9i9Zypf9OjTcsxBnLSc+LF?=
 =?us-ascii?Q?/3zoog2KNzKt6MSVQJoQSAJ+o9xHWg0LjviVOqyjNDqa+ZJt+6MLpqYrv5nK?=
 =?us-ascii?Q?DEDz2Patul7ZKToDXa2aNollDWqfxDOxvedk8+V2pWtBKHwgDh0fGtpC308G?=
 =?us-ascii?Q?e0XZ4zDubmiiJuflDZ5wi2RXYLRHAeG63urN/bpO9p/hz+NfAMAOYplylV+8?=
 =?us-ascii?Q?6adZL0HJjEGZ7ccLVigq1nyC9LPweftMFVi6uuHNeUiifq5KYsO6k4RxT/lw?=
 =?us-ascii?Q?S/6ka9z7CMZmRuAB2T6aRT+GV5Tg/mIrGqjbWsCXxoirBK/R3U8vJM11gn9j?=
 =?us-ascii?Q?0Aa7B/66lA/eIY94sVwxkFolYZka3r8YHZkzJouttXHEcEsS1ipBhaQNuc8m?=
 =?us-ascii?Q?7v1chpJDZB51m8E00gkVbEzQFDrxVrmG9En26fHt5uSEDh9bm3Cc3RHjX2Bm?=
 =?us-ascii?Q?Wxz0gvDBzGfxtgliCfaPQ2uTWf+ExlHRQMcDbBgp4l2qZjZki8FY+9g+dMqs?=
 =?us-ascii?Q?/wVGSlEKHVAe8T1qliXa8aNvEYGKDRZguDHqfUalBiPjd1jxSTtq2bxrZta/?=
 =?us-ascii?Q?lbitd8yHwZI6z8KF1OEMPPVkAw+SLgFTmTa1Apr9o2iZVjwBFiYSUerQbmeL?=
 =?us-ascii?Q?lLQPri75doah7b71pf2UqW3KoQiQuUD2iEcN/bCoGxC3pzWAwCWU5eLrtQzj?=
 =?us-ascii?Q?Nxqd2efJJ4bZ4SnIQcg1nJVgR5wv5arG/09Hfr/sOoou1Jfdsvz5/vPaFJk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-6b909.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b09d681-79e5-4a25-135f-08dbe866f32c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR10MB6563.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2023 18:48:27.1860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB7936

vmlinux.c uses the `CHECK` calls even though the use of ASSERT_ series
of macros is preferred in the bpf selftests.

This patch replaces all `CHECK` calls for equivalent `ASSERT_`
macro calls.

Signed-off-by: Yuran Pereira <yuran.pereira@hotmail.com>
---
 tools/testing/selftests/bpf/prog_tests/vmlinux.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/vmlinux.c b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
index 72310cfc6474..6fb2217d940b 100644
--- a/tools/testing/selftests/bpf/prog_tests/vmlinux.c
+++ b/tools/testing/selftests/bpf/prog_tests/vmlinux.c
@@ -16,27 +16,27 @@ static void nsleep()
 
 void test_vmlinux(void)
 {
-	int duration = 0, err;
+	int err;
 	struct test_vmlinux* skel;
 	struct test_vmlinux__bss *bss;
 
 	skel = test_vmlinux__open_and_load();
-	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+	if (!ASSERT_OK_PTR(skel, "test_vmlinux__open_and_load"))
 		return;
 	bss = skel->bss;
 
 	err = test_vmlinux__attach(skel);
-	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+	if (!ASSERT_OK(err, "test_vmlinux__attach"))
 		goto cleanup;
 
 	/* trigger everything */
 	nsleep();
 
-	CHECK(!bss->tp_called, "tp", "not called\n");
-	CHECK(!bss->raw_tp_called, "raw_tp", "not called\n");
-	CHECK(!bss->tp_btf_called, "tp_btf", "not called\n");
-	CHECK(!bss->kprobe_called, "kprobe", "not called\n");
-	CHECK(!bss->fentry_called, "fentry", "not called\n");
+	ASSERT_TRUE(bss->tp_called, "tp");
+	ASSERT_TRUE(bss->raw_tp_called, "raw_tp");
+	ASSERT_TRUE(bss->tp_btf_called, "tp_btf");
+	ASSERT_TRUE(bss->kprobe_called, "kprobe");
+	ASSERT_TRUE(bss->fentry_called, "fentry");
 
 cleanup:
 	test_vmlinux__destroy(skel);
-- 
2.25.1


