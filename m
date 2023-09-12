Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD10079C676
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjILGIw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjILGIu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:50 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780D10D1;
        Mon, 11 Sep 2023 23:08:46 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C67nC4022933;
        Tue, 12 Sep 2023 06:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Mrt5Om+SBC9plFsiqVzEbfiFYt6ycZbrMHc7cXLbplU=;
 b=ZC80FEiGgG1IBhRa7ajAWHytz5Uvo3Eht6YbmUNekhOlmW7SUA1Uv88josqBFGcRevxW
 5Aptekhy+aFtRuXXgHaMkpXx/sjQrTgG0DmjNGOVt06FQmA3iDkxY1PT9+Q6QJBfi6GS
 YKjN7F70ODIIH+us6L2iYArLIbJRaXlykxtq33bwiWy3l9iH+nvIMC+B5ntAGcvnSR4J
 XZPpLBiyL40Dx+srrvgUL9vWxvC3T2lQwplEaYY+YAnnySgfDSFn2RmgvFhw2wxsGMfV
 4vhIBvW7M71sbqWlptb1rE31hFeEJ1Tv3NDa0CBLyp+6EO8ZXH+/58bFROTUBYKDiPV1 Qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2k2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:24 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C68HVQ025804;
        Tue, 12 Sep 2023 06:08:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2hj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:23 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C5Orwg012069;
        Tue, 12 Sep 2023 06:08:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t13dygxrg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68JeW43778332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:08:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 757B62004D;
        Tue, 12 Sep 2023 06:08:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EDEAF20049;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6FBEF60807;
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
Subject: [PATCH v2 7/7] selftests/bpf: fix Python string escapes
Date:   Tue, 12 Sep 2023 16:08:01 +1000
Message-ID: <20230912060801.95533-8-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912060801.95533-1-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hIboO_QQnjrF-2ilBdAWsEDtjmaEdZK3
X-Proofpoint-ORIG-GUID: 5D_1LRGlKmhI0fgYbqYhUM2wNxymK6_b
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
 .../selftests/bpf/test_bpftool_synctypes.py   | 26 +++++++++----------
 tools/testing/selftests/bpf/test_offload.py   |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/test_bpftool_synctypes.py b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
index 0cfece7ff4f8..46862af44f86 100755
--- a/tools/testing/selftests/bpf/test_bpftool_synctypes.py
+++ b/tools/testing/selftests/bpf/test_bpftool_synctypes.py
@@ -66,7 +66,7 @@ class ArrayParser(BlockParser):
 
     def __init__(self, reader, array_name):
         self.array_name = array_name
-        self.start_marker = re.compile(f'(static )?const bool {self.array_name}\[.*\] = {{\n')
+        self.start_marker = re.compile(rf'(static )?const bool {self.array_name}\[.*\] = {{\n')
         super().__init__(reader)
 
     def search_block(self):
@@ -80,7 +80,7 @@ class ArrayParser(BlockParser):
         Parse a block and return data as a dictionary. Items to extract must be
         on separate lines in the file.
         """
-        pattern = re.compile('\[(BPF_\w*)\]\s*= (true|false),?$')
+        pattern = re.compile(r'\[(BPF_\w*)\]\s*= (true|false),?$')
         entries = set()
         while True:
             line = self.reader.readline()
@@ -178,7 +178,7 @@ class FileExtractor(object):
         @enum_name: name of the enum to parse
         """
         start_marker = re.compile(f'enum {enum_name} {{\n')
-        pattern = re.compile('^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
+        pattern = re.compile(r'^\s*(BPF_\w+),?(\s+/\*.*\*/)?$')
         end_marker = re.compile('^};')
         parser = BlockParser(self.reader)
         parser.search_block(start_marker)
@@ -226,8 +226,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'\*{block_name}\* := {{')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(rf'\*{block_name}\* := {{')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -245,8 +245,8 @@ class FileExtractor(object):
 
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
-        start_marker = re.compile(f'"\s*{block_name} := {{')
-        pattern = re.compile('([\w/]+) [|}]')
+        start_marker = re.compile(rf'"\s*{block_name} := {{')
+        pattern = re.compile(r'([\w/]+) [|}]')
         end_marker = re.compile('}')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -264,8 +264,8 @@ class FileExtractor(object):
 
         @macro: macro starting the block, 'HELP_SPEC_OPTIONS' in the example
         """
-        start_marker = re.compile(f'"\s*{macro}\s*" [|}}]')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]])')
+        start_marker = re.compile(rf'"\s*{macro}\s*" [|}}]')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]])')
         end_marker = re.compile('}\\\\n')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -284,7 +284,7 @@ class FileExtractor(object):
         @block_name: name of the blog to parse, 'TYPE' in the example
         """
         start_marker = re.compile(f'local {block_name}=\'')
-        pattern = re.compile('(?:.*=\')?([\w/]+)')
+        pattern = re.compile(r"(?:.*=')?([\w/]+)")
         end_marker = re.compile('\'$')
         return self.__get_description_list(start_marker, pattern, end_marker)
 
@@ -316,7 +316,7 @@ class MainHeaderFileExtractor(SourceFileExtractor):
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
         start_marker = re.compile(f'"OPTIONS :=')
-        pattern = re.compile('([\w-]+) ?(?:\||}[ }\]"])')
+        pattern = re.compile(r'([\w-]+) ?(?:\||}[ }\]"])')
         end_marker = re.compile('#define')
 
         parser = InlineListParser(self.reader)
@@ -338,8 +338,8 @@ class ManSubstitutionsExtractor(SourceFileExtractor):
 
             {'-p', '-d', '--pretty', '--debug', '--json', '-j'}
         """
-        start_marker = re.compile('\|COMMON_OPTIONS\| replace:: {')
-        pattern = re.compile('\*\*([\w/-]+)\*\*')
+        start_marker = re.compile(r'\|COMMON_OPTIONS\| replace:: {')
+        pattern = re.compile(r'\*\*([\w/-]+)\*\*')
         end_marker = re.compile('}$')
 
         parser = InlineListParser(self.reader)
diff --git a/tools/testing/selftests/bpf/test_offload.py b/tools/testing/selftests/bpf/test_offload.py
index 40cba8d368d9..fffbc375a7e7 100755
--- a/tools/testing/selftests/bpf/test_offload.py
+++ b/tools/testing/selftests/bpf/test_offload.py
@@ -429,7 +429,7 @@ class NetdevSim:
     def __init__(self, nsimdev, port_index, ifname):
         # In case udev renamed the netdev to according to new schema,
         # check if the name matches the port_index.
-        nsimnamere = re.compile("eni\d+np(\d+)")
+        nsimnamere = re.compile(r"eni\d+np(\d+)")
         match = nsimnamere.match(ifname)
         if match and int(match.groups()[0]) != port_index + 1:
             raise Exception("netdevice name mismatches the expected one")
-- 
2.41.0

