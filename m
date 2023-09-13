Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919CA79DD21
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Sep 2023 02:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbjIMA1b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 20:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIMA1a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 20:27:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA6C10CC;
        Tue, 12 Sep 2023 17:27:26 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38D08gwA019846;
        Wed, 13 Sep 2023 00:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=vJ47LIlyMN6BcmeJQaZ+TSvAsnWDFx+CGPLVYoUMJMg=;
 b=Xai9qt3q8ndV/PNBfxS7QCXdrMaeQiAerixJV6Qt4NKeTNsrmH+U3pSl/xfdqVWDLP7o
 wkI4XsWMNAQSuLlC4Bn9Qllc/jmm8KOS1idnQPh0PKCGLLOVkbBtymf/6iUJj3LDfC1+
 jTMTrx1PjxbwcgTdEKKbi8lIh0jNoIp8ld4DPVN+L4bhDQUHpWUfKpW1t6zkFJIQSpmt
 kNAoRTVxxYyLSY9RfyNz8olm+cruSF8b6ZeRLxPVJWTkQReHcpVkFiOTOVEEVy0+BCBy
 PhTrub0p/b1To2XW06S/YYyW03Tw/BZzfNPVxJORqeAVhEVkCorCmmyEBXghUGumnsd/ bw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t31w18rp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 00:27:01 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38D0GGLG015456;
        Wed, 13 Sep 2023 00:27:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t31w18rp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 00:27:00 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38CMOSwJ011967;
        Wed, 13 Sep 2023 00:26:59 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1xpht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 00:26:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38D0QvIY15270576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Sep 2023 00:26:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8D92004B;
        Wed, 13 Sep 2023 00:26:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ACB3820040;
        Wed, 13 Sep 2023 00:26:56 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 13 Sep 2023 00:26:56 +0000 (GMT)
Received: from [10.61.2.107] (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 9206B600D2;
        Wed, 13 Sep 2023 10:26:53 +1000 (AEST)
Message-ID: <d603d3b3-7563-d1c9-5086-c5bb78ea2e52@linux.ibm.com>
Date:   Wed, 13 Sep 2023 10:26:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/7] tools/perf: fix Python string escapes
To:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        linux-perf-users@vger.kernel.org,
        Todd E Brandt <todd.e.brandt@linux.intel.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>
References: <20230912060801.95533-1-bgray@linux.ibm.com>
 <20230912060801.95533-6-bgray@linux.ibm.com>
 <340eae90-d270-5e52-4982-a67459bc46dd@intel.com>
Content-Language: en-US, en-AU
From:   Benjamin Gray <bgray@linux.ibm.com>
In-Reply-To: <340eae90-d270-5e52-4982-a67459bc46dd@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nPp4DIV1vcd4fwS4D0Cqs57ORl3eAsK5
X-Proofpoint-ORIG-GUID: AEImhDdKX-tnhwvE_4BGBdHirF0d-OVB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_23,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120205
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/9/23 8:56 pm, Adrian Hunter wrote:
> On 12/09/23 09:07, Benjamin Gray wrote:
>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>> index a7e88332276d..980f080a5a2c 100755
>> --- a/tools/perf/pmu-events/jevents.py
>> +++ b/tools/perf/pmu-events/jevents.py
>> @@ -83,7 +83,7 @@ def c_len(s: str) -> int:
>>     """Return the length of s a C string
>>   
>>     This doesn't handle all escape characters properly. It first assumes
>> -  all \ are for escaping, it then adjusts as it will have over counted
>> +  all \\ are for escaping, it then adjusts as it will have over counted
> 
> It looks like the whole string should be a raw string
> 
...
>> -				s = value.replace("%", "\%")
>> -				s = s.replace("_", "\_")
>> +				s = value.replace("%", "\\%")
>> +				s = s.replace("_", "\\_")
> 
> Raw strings seem more readable, so could be
> used here too

Yeah, sounds good. I normally use r strings only for regex, but there 
shouldn't be any ambiguity here (it might have been misleading if the 
search argument to replace looked like a regex).

Having the docstring be an r string is a good catch. There's probably a 
few like that in the kernel, but finding them is a little more 
complicated because they might be 'valid' syntax (e.g., the '\000' just 
becomes a null byte. This series is focused on the syntax errors though, 
so I'll just leave it be.

How is the following?
---
Subject: [PATCH] tools/perf: fix Python string escapes

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

diff --git a/tools/perf/pmu-events/jevents.py 
b/tools/perf/pmu-events/jevents.py
index a7e88332276d..1b4519333a28 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -80,7 +80,7 @@ def file_name_to_table_name(prefix: str, parents: 
Sequence[str],


  def c_len(s: str) -> int:
-  """Return the length of s a C string
+  r"""Return the length of s a C string

    This doesn't handle all escape characters properly. It first assumes
    all \ are for escaping, it then adjusts as it will have over counted
diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py 
b/tools/perf/scripts/python/arm-cs-trace-disasm.py
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
diff --git a/tools/perf/scripts/python/compaction-times.py 
b/tools/perf/scripts/python/compaction-times.py
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
diff --git a/tools/perf/scripts/python/exported-sql-viewer.py 
b/tools/perf/scripts/python/exported-sql-viewer.py
index 13f2d8a81610..78763531fe5a 100755
--- a/tools/perf/scripts/python/exported-sql-viewer.py
+++ b/tools/perf/scripts/python/exported-sql-viewer.py
@@ -677,8 +677,8 @@ class CallGraphModelBase(TreeModel):
  			#   sqlite supports GLOB (text only) which uses * and ? and is case 
sensitive
  			if not self.glb.dbref.is_sqlite3:
  				# Escape % and _
-				s = value.replace("%", "\%")
-				s = s.replace("_", "\_")
+				s = value.replace("%", r"\%")
+				s = s.replace("_", r"\_")
  				# Translate * and ? into SQL LIKE pattern characters % and _
  				trans = string.maketrans("*?", "%_")
  				match = " LIKE '" + str(s).translate(trans) + "'"
-- 
2.41.0


