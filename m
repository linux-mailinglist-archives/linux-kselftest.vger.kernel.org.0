Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBE514B0DB
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2020 09:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgA1Iaq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Jan 2020 03:30:46 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgA1Iaq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Jan 2020 03:30:46 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00S8P23V144884
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2020 03:30:45 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xrk3cky8b-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Jan 2020 03:30:44 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <svens@linux.ibm.com>;
        Tue, 28 Jan 2020 08:30:42 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 28 Jan 2020 08:30:40 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00S8UdOE46792994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Jan 2020 08:30:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 280CDA4040;
        Tue, 28 Jan 2020 08:30:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 211A0A4059;
        Tue, 28 Jan 2020 08:30:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Jan 2020 08:30:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id C6D49E0663; Tue, 28 Jan 2020 09:30:38 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v4] selftests/ftrace: fix glob selftest
Date:   Tue, 28 Jan 2020 09:30:29 +0100
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 20012808-0016-0000-0000-000002E15901
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012808-0017-0000-0000-0000334418C9
Message-Id: <20200128083029.34050-1-svens@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-28_02:2020-01-24,2020-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 spamscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001280069
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

test.d/ftrace/func-filter-glob.tc is failing on s390 because it has
ARCH_INLINE_SPIN_LOCK and friends set to 'y'. So the usual
__raw_spin_lock symbol isn't in the ftrace function list. Change
'*aw*lock' to '*spin*lock' which would hopefully match some of the
locking functions on all platforms.

Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---

Changes in v4:
  - rebase to latest master

Changes in v3:
  change '*spin*lock' to '*pin*lock' to not match the beginning

Changes in v2:
  use '*spin*lock' instead of '*ktime*ns'

 .../testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
index 27a54a17da65..f4e92afab14b 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/func-filter-glob.tc
@@ -30,7 +30,7 @@ ftrace_filter_check '*schedule*' '^.*schedule.*$'
 ftrace_filter_check 'schedule*' '^schedule.*$'
 
 # filter by *mid*end
-ftrace_filter_check '*aw*lock' '.*aw.*lock$'
+ftrace_filter_check '*pin*lock' '.*pin.*lock$'
 
 # filter by start*mid*
 ftrace_filter_check 'mutex*try*' '^mutex.*try.*'
-- 
2.17.1

