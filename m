Return-Path: <linux-kselftest+bounces-27066-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65A1DA3DAA8
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 14:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BFCB16EA4B
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B8711F0E42;
	Thu, 20 Feb 2025 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OWzlsZx2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33CB79C8;
	Thu, 20 Feb 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740056471; cv=none; b=ZOxieHCnPgtR4NZWr+v9tAHF3SPi0AWK1YdCMHzbUjb6KcTaY8FX3ZGmy/M9fQQLs/Plje4RRioTExbyCk7FcG1w93MoJuT8WmVJ3sMdpoAsVTz8vNQQVOZ1QZw5bAoi6lx6CYyVNawQpi08+Odl7iM0F02kapFPDxf+XFecwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740056471; c=relaxed/simple;
	bh=l1w0+lyiZ65S3cAJQpzDmBFyQVQl7D7mEE+bo97iMPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoRKxLR+TvIU7Bn1ZaLyGMoVRDnIfSeuG9Z01TWHVNp1s4HPYYuu4nGnr0wdJrmfWbsiRKs2Nk/fOuOYlQiV7G1x2ZGYVDS+zjdtPOoGGPKq+6gLBtH9xgLClHNIz0SBy198hEC/eGeegIerYULme4LZ2Qm6V+TYOl9Vge75FBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OWzlsZx2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KAKXbC012889;
	Thu, 20 Feb 2025 13:01:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=uxa5PCd5TtVPSlEW7mce6b3lLsV62hgbts+mgfZ3s
	TY=; b=OWzlsZx2b1s9mX72yy3/O0FYnqM/oxZfHkWPzt6t0iL9zJq7TmWww2euw
	iaJdm/rsv/0uHNPLpVFhr9PkRGMoYjB5bVXLdm47pB/vMp1jKEqVEwktikSHZeiz
	vAqM4liEs4k8wqezWTm8c4udW1HfLESUx0DjJJB4+s/rQ47ijUpPgyJ0vC2bk0dd
	4qsJlptZDsOanGCK1RUQqUx0EWjv5WCZx7EOMhuUrQm3shlq+duA4SIFmwx6vec4
	CgxtrBP09VivpgaWY3bbSCoXR4ozzad4UNA0OaMbSTG5Soj+oHWbiPrcLv4/Pz+/
	6+n7lgXYqIDWF08kiK23CZtZrmrxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wreabdr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 13:01:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KBQS2K027098;
	Thu, 20 Feb 2025 13:01:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025a1y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 13:01:04 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KD13Vn30867968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 13:01:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5702004B;
	Thu, 20 Feb 2025 13:01:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 173B120043;
	Thu, 20 Feb 2025 13:01:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 13:01:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Use readelf to find entry point in uprobe test
Date: Thu, 20 Feb 2025 14:01:02 +0100
Message-ID: <20250220130102.2079179-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S7TRqR8J_A56GPHqP5O-6KoE4Jq5iXs_
X-Proofpoint-GUID: S7TRqR8J_A56GPHqP5O-6KoE4Jq5iXs_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_05,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200094

The uprobe events test fails on s390, but also on x86 (Fedora 41). The
problem appears to be that there is an assumption that adding a uprobe to
the beginning of the executable mapping of /bin/sh is sufficient to trigger
a uprobe event when /bin/sh is executed.

This assumption is not necessarily true. Therefore use "readelf -h" to find
the entry point address of /bin/sh and use this address when adding the
uprobe event.

This adds a dependency to readelf which is not always installed. Therefore
add a check and exit with exit_unresolved if it is not installed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 .../ftrace/test.d/dynevent/add_remove_uprobe.tc        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
index 86c76679c56e..f2048c244526 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_uprobe.tc
@@ -3,14 +3,18 @@
 # description: Generic dynamic event - add/remove/test uprobe events
 # requires: uprobe_events
 
+if ! which readelf > /dev/null 2>&1 ; then
+  echo "No readelf found. skipped."
+  exit_unresolved
+fi
+
 echo 0 > events/enable
 echo > dynamic_events
 
 REALBIN=`readlink -f /bin/sh`
+ENTRYPOINT=`readelf -h ${REALBIN} | grep Entry | sed -e 's/[^0]*//'`
 
-echo 'cat /proc/$$/maps' | /bin/sh | \
-	grep "r-xp .*${REALBIN}$" | \
-	awk '{printf "p:myevent %s:0x%s\n", $6,$3 }' >> uprobe_events
+echo "p:myevent ${REALBIN}:${ENTRYPOINT}" >> uprobe_events
 
 grep -q myevent uprobe_events
 test -d events/uprobes/myevent
-- 
2.45.2


