Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489779C69A
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjILGJc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjILGJF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:09:05 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27B210F3;
        Mon, 11 Sep 2023 23:08:53 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C66IPF019526;
        Tue, 12 Sep 2023 06:08:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=eeIpZhLNEW5AXZKRPNrYr3hGhad3rh5/hRfI/n3KT8A=;
 b=aKfrsTWn+TW2qWV4le8BpfyyzcVZYv4esJ3fWqO8vcZ49dan28/3S+jqp92UlYKVnDJk
 BXv7+Gv1eblGANxbj7ahm0cxENgbYSCZgEzlmiyzZSjvoDWMQsJX/RMPjwiKmDXJpo7R
 +CZYO84/UbNXQr4PLLHA6r6vQxgsiMvSDkql/c7r9+VE2WEibu7V9glYOpdiKK8J+cip
 ELJsksCLHcvJC+a5xwcgvZHxbqZQl91CNpppt8yi5vd3nzLJ1tVi9bUG8iPht1J9CK+W
 hcp7wLVjn6jC88UlFsUsIGMF8AawcidUqwV9QKqhtxQyfAtueBfUz182I6B7ZKgm2//O ZQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j2m0m9k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:20 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C66bNh020262;
        Tue, 12 Sep 2023 06:08:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2j2m0m7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:19 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4gMur002367;
        Tue, 12 Sep 2023 06:08:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k0c7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:18 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68GCT43450866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:08:16 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88CA320049;
        Tue, 12 Sep 2023 06:08:16 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 879F52004F;
        Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 4A404602EF;
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
Subject: [PATCH v2 2/7] Documentation/sphinx: fix Python string escapes
Date:   Tue, 12 Sep 2023 16:07:56 +1000
Message-ID: <20230912060801.95533-3-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912060801.95533-1-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nVcX-8eISnUoPLAV3poLceWG0eT8WOC2
X-Proofpoint-ORIG-GUID: OUb1ytoz2-XxgbA7j22UppPEbWA49ZVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 lowpriorityscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2309120050
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Python 3.6 introduced a DeprecationWarning for invalid escape sequences.
This is upgraded to a SyntaxWarning in Python 3.12, and will eventually
be a syntax error.

Fix these now to get ahead of it before it's an error.

Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
---
 Documentation/sphinx/cdomain.py             | 2 +-
 Documentation/sphinx/kernel_abi.py          | 2 +-
 Documentation/sphinx/kernel_feat.py         | 2 +-
 Documentation/sphinx/kerneldoc.py           | 2 +-
 Documentation/sphinx/maintainers_include.py | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index a99716bf44b5..de5d132d94c5 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -93,7 +93,7 @@ def markup_ctype_refs(match):
 #
 RE_expr = re.compile(r':c:(expr|texpr):`([^\`]+)`')
 def markup_c_expr(match):
-    return '\ ``' + match.group(2) + '``\ '
+    return '\\ ``' + match.group(2) + '``\\ '
 
 #
 # Parse Sphinx 3.x C markups, replacing them by backward-compatible ones
diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index b5feb5b1d905..49797c55479c 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -138,7 +138,7 @@ class KernelCmd(Directive):
                 code_block += "\n    " + l
             lines = code_block + "\n\n"
 
-        line_regex = re.compile("^\.\. LINENO (\S+)\#([0-9]+)$")
+        line_regex = re.compile(r"^\.\. LINENO (\S+)\#([0-9]+)$")
         ln = 0
         n = 0
         f = fname
diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 27b701ed3681..b5fa2f0542a5 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -104,7 +104,7 @@ class KernelFeat(Directive):
 
         lines = self.runCmd(cmd, shell=True, cwd=cwd, env=shell_env)
 
-        line_regex = re.compile("^\.\. FILE (\S+)$")
+        line_regex = re.compile(r"^\.\. FILE (\S+)$")
 
         out_lines = ""
 
diff --git a/Documentation/sphinx/kerneldoc.py b/Documentation/sphinx/kerneldoc.py
index 9395892c7ba3..8dc134904b90 100644
--- a/Documentation/sphinx/kerneldoc.py
+++ b/Documentation/sphinx/kerneldoc.py
@@ -130,7 +130,7 @@ class KernelDocDirective(Directive):
             result = ViewList()
 
             lineoffset = 0;
-            line_regex = re.compile("^\.\. LINENO ([0-9]+)$")
+            line_regex = re.compile(r"^\.\. LINENO ([0-9]+)$")
             for line in lines:
                 match = line_regex.search(line)
                 if match:
diff --git a/Documentation/sphinx/maintainers_include.py b/Documentation/sphinx/maintainers_include.py
index 328b3631a585..dcad0fff4723 100755
--- a/Documentation/sphinx/maintainers_include.py
+++ b/Documentation/sphinx/maintainers_include.py
@@ -77,7 +77,7 @@ class MaintainersInclude(Include):
             line = line.rstrip()
 
             # Linkify all non-wildcard refs to ReST files in Documentation/.
-            pat = '(Documentation/([^\s\?\*]*)\.rst)'
+            pat = r'(Documentation/([^\s\?\*]*)\.rst)'
             m = re.search(pat, line)
             if m:
                 # maintainers.rst is in a subdirectory, so include "../".
@@ -90,11 +90,11 @@ class MaintainersInclude(Include):
                 output = "| %s" % (line.replace("\\", "\\\\"))
                 # Look for and record field letter to field name mappings:
                 #   R: Designated *reviewer*: FullName <address@domain>
-                m = re.search("\s(\S):\s", line)
+                m = re.search(r"\s(\S):\s", line)
                 if m:
                     field_letter = m.group(1)
                 if field_letter and not field_letter in fields:
-                    m = re.search("\*([^\*]+)\*", line)
+                    m = re.search(r"\*([^\*]+)\*", line)
                     if m:
                         fields[field_letter] = m.group(1)
             elif subsystems:
@@ -112,7 +112,7 @@ class MaintainersInclude(Include):
                     field_content = ""
 
                     # Collapse whitespace in subsystem name.
-                    heading = re.sub("\s+", " ", line)
+                    heading = re.sub(r"\s+", " ", line)
                     output = output + "%s\n%s" % (heading, "~" * len(heading))
                     field_prev = ""
                 else:
-- 
2.41.0

