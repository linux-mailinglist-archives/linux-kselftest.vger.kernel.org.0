Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B130579C67C
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjILGJG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjILGIv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188F810D9;
        Mon, 11 Sep 2023 23:08:48 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C67nTB022948;
        Tue, 12 Sep 2023 06:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=q9Xb8j5HP9E1kLEc7j7wBE0qLNTgFJmUvEApSnloaJU=;
 b=EZaGrpLxF3ZbmbWexSEPuBHUXiu2FT2GLVmZlz2kKerksVJ4wPT1J/1zwr8n+eMiEQdy
 toyNgGg4hO3HWwgOSw5jhF7mslrFm/pHaT8VSLMOQM1vSwLZDbf61XgzDjoetPkZkI8b
 S6k1JQ/KPGf/R/+BsbS4OsrML3JbAQNg+baXE6b9lMqwAT2ENL5SqiqI921nMyqL9Uaq
 1sIepKst/aPqS0nTfV0QaKAoSquWrxIO+m9KT5l1p6aiRgeasBCi83RkEAsm0omiS10s
 0pD3fa4h5XpRsSudM1ePoJ5byD+Bf5EodWf49u1VPay++E8pKhdRLGkr1Wzxov9ASgSa FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2mw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:25 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C67tp6023364;
        Tue, 12 Sep 2023 06:08:24 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2gv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:24 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C5JffP011974;
        Tue, 12 Sep 2023 06:08:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1r6bf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68I6U27722392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:08:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D77EB2004E;
        Tue, 12 Sep 2023 06:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DBBF620040;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 60CF16051E;
        Tue, 12 Sep 2023 16:08:13 +1000 (AEST)
From:   Benjamin Gray <bgray@linux.ibm.com>
To:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, llvm@lists.linux.dev,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>,
        Benjamin Gray <bgray@linux.ibm.com>
Subject: [PATCH v2 5/7] tools/perf: fix Python string escapes
Date:   Tue, 12 Sep 2023 16:07:59 +1000
Message-ID: <20230912060801.95533-6-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912060801.95533-1-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oXFyySFm0WnKsXVhO1yBMm10V3F6kD7H
X-Proofpoint-ORIG-GUID: GD8A1lF_Ao7SODdN_F8A9yrRwXNibOzv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120050
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 tools/perf/pmu-events/jevents.py                 | 2 +-
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 4 ++--
 tools/perf/scripts/python/compaction-times.py    | 2 +-
 tools/perf/scripts/python/exported-sql-viewer.py | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index a7e88332276d..980f080a5a2c 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -83,7 +83,7 @@ def c_len(s: str) -> int:
   """Return the length of s a C string
 
   This doesn't handle all escape characters properly. It first assumes
-  all \ are for escaping, it then adjusts as it will have over counted
+  all \\ are for escaping, it then adjusts as it will have over counted
   \\. The code uses \000 rather than \0 as a terminator as an adjacent
   number would be folded into a string of \0 (ie. "\0" + "5" doesn't
   equal a terminator followed by the number 5 but the escape of
diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d59ff53f1d94..de58991c78bb 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -45,8 +45,8 @@ parser = OptionParser(option_list=option_list)
 # Initialize global dicts and regular expression
 disasm_cache = dict()
 cpu_data = dict()
-disasm_re = re.compile("^\s*([0-9a-fA-F]+):")
-disasm_func_re = re.compile("^\s*([0-9a-fA-F]+)\s.*:")
+disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
+disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
 cache_size = 64*1024
 
 glb_source_file_name	= None
diff --git a/tools/perf/scripts/python/compaction-times.py b/tools/perf/scripts/python/compaction-times.py
index 2560a042dc6f..9401f7c14747 100644
--- a/tools/perf/scripts/python/compaction-times.py
+++ b/tools/perf/scripts/python/compaction-times.py
@@ -260,7 +260,7 @@ def pr_help():
 
 comm_re = None
 pid_re = None
-pid_regex = "^(\d*)-(\d*)$|^(\d*)$"
+pid_regex = r"^(\d*)-(\d*)$|^(\d*)$"
 
 opt_proc = popt.DISP_DFL
 opt_disp = topt.DISP_ALL
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py b/tools/perf/scripts/python/exported-sql-viewer.py
index 13f2d8a81610..121cf61ba1b3 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
 			#   sqlite supports GLOB (text only) which uses * and ? and is case sensitive
 			if not self.glb.dbref.is_sqlite3:
 				# Escape % and _
-				s = value.replace("%", "\%")
-				s = s.replace("_", "\_")
+				s = value.replace("%", "\\%")
+				s = s.replace("_", "\\_")
 				# Translate * and ? into SQL LIKE pattern characters % and _
 				trans = string.maketrans("*?", "%_")
 				match = " LIKE '" + str(s).translate(trans) + "'"
-- 
2.41.0

