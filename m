Return-Path: <linux-kselftest+bounces-21318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEE39B984D
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 20:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 441AAB211B1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Nov 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367451CEEAC;
	Fri,  1 Nov 2024 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="teYo66oq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A393037B;
	Fri,  1 Nov 2024 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730488795; cv=none; b=u4xVgFz4/BiehTcaGvcgZe0A00W9SaOnTARJOm/dg5/YyLKFHi26ib0olZY9w1GmDjEAbcWheiyVl/4Aag9T0F7TSAYkBK8CQbdC0q2asSscO39nX/+FahA3HPQP6Yjf316RwNHasuLAKH9pFLtohtSrLtB2aIIrUaI+7BuXM5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730488795; c=relaxed/simple;
	bh=UY/cRm6t+njMXvBeHOuXALc357K58tlFDEAhv93bi0g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fMtAW7EuQ1OkkIsEeXlZTlV7Wf6rZ5afbeq20bqjNEqZQXIBwTi7M2sT+pWgAfGAT8WYSfxbW3LsLxXxysmgkCnmz12BmYzS9Pz5TkMQ9LLYoEHDqUfrvUkZuktdZI66GJHItipXVjV3omLRT49HY4ak0F61P8PkE/HVAo/TRpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=teYo66oq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1EV3gs030005;
	Fri, 1 Nov 2024 19:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=emW3DFFX5xSkwqDqwd8s1ekemaINDrTWI4ZEJ8ZVy
	Aw=; b=teYo66oqPhhDpjT+aLf/cOSKeRh4CcLqJ9KaxnMcKIU2kokmDFNDxYaLw
	X89hmZMbee8206Q0hs4F886QijpA069F+n86u4IngxwCzYaN9PkVV9BnzdvvKAMn
	PED3Cc6MCRdwlz/1+uKOI2tWhWhkTsabh5WvCEvlZttQWgpu7zbNsFxOhL5KsKv/
	gnA5SpO9r36mD7NTQdk4FQ0Qwr75SqxwjX++StD/0tKF5fl3Y2qSB5C//4kZMqI8
	fO3EuMWYdH1Qq9xifarIy6ibS1AXUO+/Z2qu9w5OB0OhQkZEGv7rdpm06dzmCa/u
	/AAEJFapVpjWoj0L4d7acY7d0NDyg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42n0trs4d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:19:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1J0GrG017410;
	Fri, 1 Nov 2024 19:19:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 42harsubgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 19:19:30 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A1JJSj319202362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Nov 2024 19:19:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF63A20043;
	Fri,  1 Nov 2024 19:19:28 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C1C820040;
	Fri,  1 Nov 2024 19:19:26 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.10.84])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Nov 2024 19:19:26 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] selftests/ftrace: update kprobe syntax error test for ppc64le
Date: Sat,  2 Nov 2024 00:49:25 +0530
Message-ID: <20241101191925.1550493-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R0NuKKSeMdoH9DKz0bqcplnnRXR7wh1C
X-Proofpoint-GUID: R0NuKKSeMdoH9DKz0bqcplnnRXR7wh1C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 mlxscore=0 clxscore=1011 impostorscore=0 mlxlogscore=999
 suspectscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010138

For ppc64le, depending on the kernel configuration used, offset 16
from function start address can also be considered function entry.
Update the test case to accommodate such configurations.

Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index a16c6a6f6055..c03b94cc5784 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -111,7 +111,11 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
 if !grep -q 'kernel return probes support:' README; then
 check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
 fi
+if [ "$(uname -m)" = "ppc64le" ]; then
+check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
+else
 check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
+fi
 check_error 'p vfs_read ^hoge'			# NO_BTFARG
 check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'r kfree ^$retval'			# NO_RETVAL
-- 
2.47.0


