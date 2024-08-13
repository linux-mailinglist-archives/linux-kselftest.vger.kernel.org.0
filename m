Return-Path: <linux-kselftest+bounces-15190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D036594FC5B
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 05:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F4A91C2132C
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Aug 2024 03:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E022118E29;
	Tue, 13 Aug 2024 03:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nE8jvefF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E671B948;
	Tue, 13 Aug 2024 03:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723520503; cv=none; b=WpyaUYj1kD3uIJ8DkHSUP9ITFeYfhzUHkwBIm4b5GGbPpwlgaCSGu9p3fq2NyO+Q0jipeqWOFHF/RH4z4j6pFg5klNFAHU9maKjhHVbUFZoHNfweEQwLMgrPhvC4zN2L3l0DbW4GSHEpSQGXjFgXQ+LIWPHT6GHuAQ2HGDEbOmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723520503; c=relaxed/simple;
	bh=q6HAOL4mRIzCYmRvTt3tiEI4ewsKYdQjER4H6kU/+uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o5pgXW1rXpANQHV5kcYUYuOwrUwiJoxvl8Vui0u8oKX6rTxfKkU4yYCR9QQxFj9VwF9HKQzBip47aFK09XlFqNj5aI5Zm6eO5RTjYjnn1SZ6xJ3VJa8wM+ToSB6F150ItRTUxmWIcflRKK7ljj36H9+K2vWKyNEy7BWW+TB+o8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nE8jvefF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47D1IOIw007050;
	Tue, 13 Aug 2024 03:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=wuA4OOGCw/LRUjquaq3jyi/i5d
	2AjgeKB54bI8qNFNM=; b=nE8jvefFbqmVG0VPaPKAco0mJ9Snl5iE9OC7WcKAqO
	2cIwxlOUrCW7O83u3MuDeT1OJEv2rdCRj65oem9Nxdku9f0jQ5PKfkhYvLA+p2vn
	6oo9b7fJjilhE0yFGxOw2LINGKhIPJNcC2siQf1nogAEGw8UqB6mbUM2T795WWxp
	WICQrcDd0x2dIHWDlgHvGWt2E02uF4r1ARUN3HOUFl0LRDQrD5YYx8+JcDgEymeC
	gWizzCSW5w801tXMPzjoBLVsk1MnbtnMjv6Pct127geF7obKTGvo8YNRIs9WiHxb
	oLy2zbvHqAQ/+BSPdxIBnxYKFvab8OueAqsGou417Eng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40wwm7pkhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 03:41:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47CNLaAT016237;
	Tue, 13 Aug 2024 03:41:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xkhphm6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Aug 2024 03:41:32 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47D3fSON46858594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Aug 2024 03:41:30 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BBF920040;
	Tue, 13 Aug 2024 03:41:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96EF920043;
	Tue, 13 Aug 2024 03:41:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.209.27])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Aug 2024 03:41:26 +0000 (GMT)
From: Akanksha J N <akanksha@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, mathieu.desnoyers@efficios.com, mhiramat@kernel.org,
        rostedt@goodmis.org, akanksha@linux.ibm.com
Subject: [PATCH v2] selftests/ftrace: Skip test for optimized probes on PowerPC if Secure Boot is enabled
Date: Tue, 13 Aug 2024 09:10:56 +0530
Message-ID: <20240813034056.74717-1-akanksha@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BzKMvMwRMCQiFVZe88XLAjvNzytP1O3u
X-Proofpoint-ORIG-GUID: BzKMvMwRMCQiFVZe88XLAjvNzytP1O3u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1011 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408130022

Currently while accessing debugfs with Secure Boot enabled on PowerPC,
it is causing the kprobe_opt_types.tc test to fail. Below is the snippet
of the error:

+++ grep kernel_clone /sys/kernel/debug/kprobes/list
grep: /sys/kernel/debug/kprobes/list: Operation not permitted
++ PROBE=
+ '[' 2 -ne 0 ']'
+ kill -s 37 7595
++ SIG_RESULT=1
+ eval_result 1
+ case $1 in
+ prlog '	[\033[31mFAIL\033[0m]'
+ newline='\n'
+ '[' '	[\033[31mFAIL\033[0m]' = -n ']'
+ printf '	[\033[31mFAIL\033[0m]\n'
	[FAIL]

This is happening when secure boot is enabled, as it enables lockdown
by default. With lockdown, access to certain debug features and
filesystems like debugfs may be restricted or completely disabled.

To fix this, modify the test to check for Secure Boot status using
lsprop /proc/device-tree/ibm,secure-boot. And, skip execution of the
test on PowerPC if Secure Boot is enabled (00000002).

With this patch, test skips as unsupported:
=== Ftrace unit tests ===
[1] Register/unregister optimized probe	[UNSUPPORTED]

Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc       | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
index 9f5d99328086..925e74d6acc7 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
@@ -10,6 +10,11 @@ x86_64)
 arm*)
 ;;
 ppc*)
+  lsprop_output=$(lsprop /proc/device-tree/ibm,secure-boot)
+  if echo "$lsprop_output" | grep -q "00000002"; then
+    echo "Secure Boot is enabled on PowerPC."
+    exit_unsupported
+  fi
 ;;
 *)
   echo "Please implement other architecture here"
-- 
2.45.2


