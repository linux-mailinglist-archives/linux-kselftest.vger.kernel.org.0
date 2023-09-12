Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCEE79C680
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjILGJG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjILGIw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:08:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC34E7A;
        Mon, 11 Sep 2023 23:08:48 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C67l6h022818;
        Tue, 12 Sep 2023 06:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=D9ft4suxW8ykLbW0M/jyXvmCz9pVutJ/MVv7YYdZiY8=;
 b=JGyIXs67NjpJBlZqs8XNxydmimSvOSWjo8B8zKqQGdKUqHK+7iCrsZaLF4ryDfDz9kjh
 UAj48oq7EIBy1XLPU5NYD8TXuYdDlfLlsL2QREhxqSo75Ft0nGbWS1NO45yveF9sV7ua
 fkXq3W+5FqgCRTkbHfJ6BQuAjtMFJZn9ZpSUvMMkXr2z68fTPLCEbCgfAEuqYUFMYv/4
 llzjaiMItzc3UvioVcfgq3QUYY8D79djlwO2srjPDuAmLOJLR9luvPHRIUnrGhZErBvT
 4O9dWF9bnG0kKKQtoTFqm0WE/YiM77Q/A3CWshrxHsiav49P1h62AMv55CUCIucyi/sz 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:26 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C68HVT025804;
        Tue, 12 Sep 2023 06:08:26 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2jbhr2kw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:25 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C4gMut002367;
        Tue, 12 Sep 2023 06:08:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t158k0c8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68IDd62456184
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:08:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D81B220040;
        Tue, 12 Sep 2023 06:08:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DB0F22004B;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 6822B6064D;
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
Subject: [PATCH v2 6/7] tools/power: fix Python string escapes
Date:   Tue, 12 Sep 2023 16:08:00 +1000
Message-ID: <20230912060801.95533-7-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912060801.95533-1-bgray@linux.ibm.com>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IviUSYOCb5QUHkrRHEz_WD4rjRokRC4F
X-Proofpoint-ORIG-GUID: QDmhJDIhqZRLk6cbjGWTKsamLVT9d-7j
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
 tools/power/pm-graph/bootgraph.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/power/pm-graph/bootgraph.py b/tools/power/pm-graph/bootgraph.py
index f96f50e0c336..c53cfdba0365 100755
--- a/tools/power/pm-graph/bootgraph.py
+++ b/tools/power/pm-graph/bootgraph.py
@@ -77,12 +77,12 @@ class SystemValues(aslib.SystemValues):
 			fp.close()
 		self.testdir = datetime.now().strftime('boot-%y%m%d-%H%M%S')
 	def kernelVersion(self, msg):
-		m = re.match('^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
+		m = re.match(r'^[Ll]inux *[Vv]ersion *(?P<v>\S*) .*', msg)
 		if m:
 			return m.group('v')
 		return 'unknown'
 	def checkFtraceKernelVersion(self):
-		m = re.match('^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
+		m = re.match(r'^(?P<x>[0-9]*)\.(?P<y>[0-9]*)\.(?P<z>[0-9]*).*', self.kernel)
 		if m:
 			val = tuple(map(int, m.groups()))
 			if val >= (4, 10, 0):
@@ -324,7 +324,7 @@ def parseKernelLog():
 		idx = line.find('[')
 		if idx > 1:
 			line = line[idx:]
-		m = re.match('[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
+		m = re.match(r'[ \t]*(\[ *)(?P<ktime>[0-9\.]*)(\]) (?P<msg>.*)', line)
 		if(not m):
 			continue
 		ktime = float(m.group('ktime'))
@@ -336,20 +336,20 @@ def parseKernelLog():
 			if(not sysvals.stamp['kernel']):
 				sysvals.stamp['kernel'] = sysvals.kernelVersion(msg)
 			continue
-		m = re.match('.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
+		m = re.match(r'.* setting system clock to (?P<d>[0-9\-]*)[ A-Z](?P<t>[0-9:]*) UTC.*', msg)
 		if(m):
 			bt = datetime.strptime(m.group('d')+' '+m.group('t'), '%Y-%m-%d %H:%M:%S')
 			bt = bt - timedelta(seconds=int(ktime))
 			data.boottime = bt.strftime('%Y-%m-%d_%H:%M:%S')
 			sysvals.stamp['time'] = bt.strftime('%B %d %Y, %I:%M:%S %p')
 			continue
-		m = re.match('^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
+		m = re.match(r'^calling *(?P<f>.*)\+.* @ (?P<p>[0-9]*)', msg)
 		if(m):
 			func = m.group('f')
 			pid = int(m.group('p'))
 			devtemp[func] = (ktime, pid)
 			continue
-		m = re.match('^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
+		m = re.match(r'^initcall *(?P<f>.*)\+.* returned (?P<r>.*) after (?P<t>.*) usecs', msg)
 		if(m):
 			data.valid = True
 			data.end = ktime
-- 
2.41.0

