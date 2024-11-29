Return-Path: <linux-kselftest+bounces-22636-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FCD59DECAB
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 21:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC2F3B21B28
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Nov 2024 20:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01BE1A3A8D;
	Fri, 29 Nov 2024 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KC1ieI8n"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062CE154C04;
	Fri, 29 Nov 2024 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732912024; cv=none; b=X2YbWgvPHQF4aQPoEVL75jhY3MshHDw5eW0iBGPYfNVAOWU0p88iti3SJvih9mrxiBVc0vLCfpkmVbbHN5wpIjx0KkztVuBT8DUu+jos9j+vWsmTDMkqpwoxiyjiX55Un4nR/34AHwyF8yFvelbRJPLs5hRUJ8i8DViN0RR4JsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732912024; c=relaxed/simple;
	bh=NYIbTf7tmHYdVhLCzQLXCTQ/QK0YYqNw9srpQmRe1QA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CcjFgN67aY/JFUzvJ+eHtRqpYE5CtQMeoyokKVz7PXdc+iMJTikkCiIEEv2QUyyhC5wvtSdJ914u5xRD4aUyulXoM+/MXJIl2th5ldhG/haPcdujncRy+IpWN6z6S95TjJ6r2ilgaMTPDO1/xL3tW0Z0drw0ETso/Bm1rsgaoLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KC1ieI8n; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATAFP73027337;
	Fri, 29 Nov 2024 20:26:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=NY6l9TYMOSUhgOxd/kH4qvMmvUhFE+n2M671enH/a
	3s=; b=KC1ieI8nr6gpPgHCkzJFKFANERFqyfzvTkR77QJS1+qCBR5gasGJqaZLl
	n+rzlAzrz5WvUbTfpHSqYVbfmodWag9eHGeUTaDREkc0A6CsreA/ZsJ86rMpRuWD
	iZEohF9wxs16aPD9c58Tmwakc8jf5T9V+gKXrD8rv7TFleH6ia5n/hgC7sfSzLoL
	OPHTxHjm/4mGYnlss2y32VVjfFoBQq9d+oBFsM6c+7tqBsCCei5x/eg9E2AbTEkd
	hffJRX5df7g9kSepDuEZemnV1faT0HUXAcuU4CFSbKJA+rCmRhI61HN4iVrNKKoR
	WAIJvAFYEYPE6Zvp5MKpuPlrkKLrQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 436ym5dja3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 20:26:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATArMIu002585;
	Fri, 29 Nov 2024 20:26:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gmghn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 20:26:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4ATKQPMO29294904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 20:26:25 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0773F20040;
	Fri, 29 Nov 2024 20:26:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7274620043;
	Fri, 29 Nov 2024 20:26:22 +0000 (GMT)
Received: from li-bd3f974c-2712-11b2-a85c-df1cec4d728e.ibm.com.com (unknown [9.43.27.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 20:26:22 +0000 (GMT)
From: Hari Bathini <hbathini@linux.ibm.com>
To: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        "Naveen N. Rao" <naveen@kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: adjust offset for kprobe syntax error test
Date: Sat, 30 Nov 2024 01:56:21 +0530
Message-ID: <20241129202621.721159-1-hbathini@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: C_LDRTXyuQyNz_z28Lbw92rC3hQBsEWN
X-Proofpoint-ORIG-GUID: C_LDRTXyuQyNz_z28Lbw92rC3hQBsEWN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290160

In 'NOFENTRY_ARGS' test case for syntax check, any offset X of
`vfs_read+X` except function entry offset (0) fits the criterion,
even if that offset is not at instruction boundary, as the parser
comes before probing. But with "ENDBR64" instruction on x86, offset
4 is treated as function entry. So, X can't be 4 as well. Thus, 8
was used as offset for the test case. On 64-bit powerpc though, any
offset <= 16 can be considered function entry depending on build
configuration (see arch_kprobe_on_func_entry() for implementation
details). So, use `vfs_read+20` to accommodate that scenario too.

Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
---

Changes in v2:
* Use 20 as offset for all arches.


 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index a16c6a6f6055..8f1c58f0c239 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -111,7 +111,7 @@ check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
 if !grep -q 'kernel return probes support:' README; then
 check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
 fi
-check_error 'p vfs_read+8 ^$arg*'		# NOFENTRY_ARGS
+check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
 check_error 'p vfs_read ^hoge'			# NO_BTFARG
 check_error 'p kfree ^$arg10'			# NO_BTFARG (exceed the number of parameters)
 check_error 'r kfree ^$retval'			# NO_RETVAL
-- 
2.47.0


