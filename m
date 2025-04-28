Return-Path: <linux-kselftest+bounces-31782-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019E0A9F20A
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 15:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1615A7554
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Apr 2025 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA6426A1A3;
	Mon, 28 Apr 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gwIgcoDE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80BE86323;
	Mon, 28 Apr 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745846429; cv=none; b=dfjHmOqSrRBbru1s/KMYC9wsJrj7pa7cbiCoBshcKWnJoEWx1cfIlHh4ReeU4W9yv3a6zfV+4P/USbh8sW/h3SzNbRVBLgEJDSanvJp3Hs4pdfdmWIMUfOClf7KTeC4YWKHWSI1qKthaRV/3qEJ+nXuNdN7OCYe1tWqFyHjDtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745846429; c=relaxed/simple;
	bh=VNjy3RmJ0lOp0z/XLQWKz5ZhB98dzUQwS+M+YnrWGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HQmtQLJP66dqY6+kT8iXCU+dVx2QtxiUh0s/gnaqt3bDqR2k1AHmW0JZH7zDmcWNQoq2F9NO8m10epfQ0KGRs8TwkJ94K5rIMnC0d6HAtlwtg0HZDuF3nTYyc3G9iNGgmpd4YVi9vsXDiiq6Jap3a/uX981Am7vxsq7BodFlhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gwIgcoDE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53SA4m0H029204;
	Mon, 28 Apr 2025 13:20:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=mom3Z6GCnmxCCrmh/s8u73ghH34c
	GZTax8lhSWhcWjc=; b=gwIgcoDE4fFjLtfmY/Ge1IvvbTHw+7Dda/qjEZ8MfqlO
	wSzVO3Flf3K5cS4v80UXaAWi4UB7SFijWfUPuyTc0qaXTm/dtdteJA/SZb0JZL7n
	VH0mWrTeaR9MKJM/wY/8OC2FmUBKVw2Fxhrv+LN/kOELtmCuxbqIQjJwEVnjLynX
	t6tqJqbwWICfPKLl4CHXNsiKQDmUlQsECdo+2zbxBiAeZVgjW4LUoU4qYzePFycC
	2ZNf0PhFtxiVJOfHdM8j24JaDSuUwa5bRDGE/LTChAk1BjcBAXbdRZSpRTHiUYAJ
	YcNrRrTIFPHW+5wiaWwcssXfgeCCDafOC6x+Hy6AQg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46a7kk0vd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:20:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53SAZjga016174;
	Mon, 28 Apr 2025 13:20:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469a706pet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Apr 2025 13:20:02 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53SDJxK943057470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Apr 2025 13:19:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F13C420043;
	Mon, 28 Apr 2025 13:19:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6053620040;
	Mon, 28 Apr 2025 13:19:55 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com (unknown [9.124.219.50])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Apr 2025 13:19:55 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Nysal Jan K.A." <nysal@linux.ibm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests/mm: Fix build break when compiling pkey_util.c
Date: Mon, 28 Apr 2025 18:49:34 +0530
Message-ID: <20250428131937.641989-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OYSYDgTY c=1 sm=1 tr=0 ts=680f8084 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=obKkJqyyVAjaa7KXnx4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nexDyk0xDNlDCevnYb_Fu1jgIGHhDnee
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDEwOCBTYWx0ZWRfXxHGyuOKchSar B9IHLyd97mmtUQOyze8E4YvwwGwlaQC6DIaTheSGzkK3EtwK/f75LN1WQJYML6Jgz7DUR6Nja7p eKFvGIzOZaiQoNoJUVfmtZHdqIO7/WKSnk7svY9cE9MP9Gzzk8+A+TYy14tAL9llPM6qP04b5ZN
 TsTP4I3DQygvNKItbD784sY4CsXvbkP3DhlD8pJOxANRKpso0+tLact/7ITlMTdUqhuajwSrYwH uxOxs0q3RuIAUWkpvX4isJHxX+uWcHWP9yKDPSSlR/vFCDSbam0jLPUFWg6wI7f2IVlZ+VQXJx8 StzLHwLHh2Ord9qJv9TcXJXR/ajRyvToxrsxMt2MLkd+1zr0yHlpH6t2/jYWKQZrbAzwIjiMA8T
 4zkslazeMp9tfkEhMICPStl4e+3d9MR/3ahVkA73+LfBwPT5fBlk9ZvXsJZf0OI8L9MN0/i9
X-Proofpoint-ORIG-GUID: nexDyk0xDNlDCevnYb_Fu1jgIGHhDnee
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280108

From: Madhavan Srinivasan <maddy@linux.ibm.com>

Commit 50910acd6f615 ("selftests/mm: use sys_pkey helpers consistently")
added a pkey_util.c to refactor some of the protection_keys functions accessible
by other tests. But this broken the build in powerpc in two ways,

pkey-powerpc.h: In function ‘arch_is_powervm’:
pkey-powerpc.h:73:21: error: storage size of ‘buf’ isn’t known
   73 |         struct stat buf;
      |                     ^~~
pkey-powerpc.h:75:14: error: implicit declaration of function ‘stat’; did you mean ‘strcat’? [-Wimplicit-function-declaration]
   75 |         if ((stat("/sys/firmware/devicetree/base/ibm,partition-name", &buf) == 0) &&
      |              ^~~~
      |              strcat

Since pkey_util.c includes pkeys-helper.h, which in turn includes pkeys-powerpc.h,
stat.h including is missing for "struct stat". This is fixed by adding "sys/stat.h"
in pkeys-powerpc.h

Secondly,

pkey-powerpc.h:55:18: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 3 has type ‘u64’ {aka ‘long unsigned int’} [-Wformat=]
   55 |         dprintf4("%s() changing %016llx to %016llx\n",
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   56 |                          __func__, __read_pkey_reg(), pkey_reg);
      |                                    ~~~~~~~~~~~~~~~~~
      |                                    |
      |                                    u64 {aka long unsigned int}
pkey-helpers.h:63:32: note: in definition of macro ‘dprintf_level’
   63 |                 sigsafe_printf(args);           \
      |                                ^~~~

These format specifier related warning are removed by adding
"__SANE_USERSPACE_TYPES__" to pkeys_utils.c.

Fixes: 50910acd6f615 ("selftests/mm: use sys_pkey helpers consistently")
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Nysal Jan K.A. <nysal@linux.ibm.com>
---
 tools/testing/selftests/mm/pkey-powerpc.h | 2 ++
 tools/testing/selftests/mm/pkey_util.c    | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/testing/selftests/mm/pkey-powerpc.h b/tools/testing/selftests/mm/pkey-powerpc.h
index 1bad310d282a..d8ec906b8120 100644
--- a/tools/testing/selftests/mm/pkey-powerpc.h
+++ b/tools/testing/selftests/mm/pkey-powerpc.h
@@ -3,6 +3,8 @@
 #ifndef _PKEYS_POWERPC_H
 #define _PKEYS_POWERPC_H
 
+#include <sys/stat.h>
+
 #ifndef SYS_pkey_alloc
 # define SYS_pkey_alloc		384
 # define SYS_pkey_free		385
diff --git a/tools/testing/selftests/mm/pkey_util.c b/tools/testing/selftests/mm/pkey_util.c
index ca4ad0d44ab2..255b332f7a08 100644
--- a/tools/testing/selftests/mm/pkey_util.c
+++ b/tools/testing/selftests/mm/pkey_util.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
+#define __SANE_USERSPACE_TYPES__
 #include <sys/syscall.h>
 #include <unistd.h>
 
-- 
2.47.0


