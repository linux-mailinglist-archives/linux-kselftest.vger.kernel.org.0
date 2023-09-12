Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1784179C68F
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 08:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjILGJM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Sep 2023 02:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjILGJE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Sep 2023 02:09:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB4010DC;
        Mon, 11 Sep 2023 23:08:51 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38C68DGi017538;
        Tue, 12 Sep 2023 06:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=CzujmUXtCj26g4ccKogjBVuA4bEZ845o6ihWJ4IcBPc=;
 b=QU7oGPIfX46o//dLm9dHlXulfCWVGR1IBhmwNgUJZJg/Dyn1Iy6zn5qibZd9ueNtjrRv
 fDLU5JNexYK3912FGmrC5StPmFdKW8uBSjjn9lLE1VyS9hgZ+A4fYKMEVzQPY8pMzSca
 wlc1drVGFJL+dUlHQmHiEqDLMucG9HXBTPmoP/ckYXoLMVvfhw7bjR47orpEv7hI/ov5
 6m3sxQOr7NNa4CC8F3dgLkyfXzu8AZJ3YfApxxmb0U3TY/nj9TvC5v2Blvs45CIY1hhu
 /MiZs9Czb+wBWyZ7lNqtuiBefcTLP2nYQjCwqpDTmHpdBlEn3FGpULzrDm5m7LE/YDym 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2hv50rt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:21 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38C68KGD018137;
        Tue, 12 Sep 2023 06:08:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t2hv50rre-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:20 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38C5CmFC011971;
        Tue, 12 Sep 2023 06:08:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r1r6av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 06:08:18 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38C68Hx95046824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Sep 2023 06:08:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 080F720043;
        Tue, 12 Sep 2023 06:08:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84E952004B;
        Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.192.253.14])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 12 Sep 2023 06:08:15 +0000 (GMT)
Received: from bgray-lenovo-p15.ozlabs.ibm.com (haven.au.ibm.com [9.192.254.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 2EF67600E5;
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
Subject: [PATCH v2 0/7] Fix Python string escapes
Date:   Tue, 12 Sep 2023 16:07:54 +1000
Message-ID: <20230912060801.95533-1-bgray@linux.ibm.com>
X-Mailer: git-send-email 2.41.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: fpl9VuF9ODMnOnIbO4VQkiRY7Mc9u2vR
X-Proofpoint-GUID: 5bhN3wBgYbXJPAlC9J3b3vfBJ8N42c9A
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-12_03,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309120050
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Changes from v1:
* Dropped some changes that were independently fixed[1]
* No longer separate the f strings to their own patch
* Use r strings when the value is a regular expression
* Updated verification script

In retrospect a script to find the instances and apply fixes isn't that
useful for review, so the attached script this time just looks for
differences in the AST. Apply the series and run the script, with
the two references to compare as arguments.

There are some intentional changes to the AST now though, as the r strings
turn '\t' from a single character tab into a backslash and 't' character
pair (similar for '\n'). This does not affect the correctness of the
regular expression though.

v1: https://lore.kernel.org/all/20230814060704.79655-1-bgray@linux.ibm.com/

[1]: https://lore.kernel.org/all/20230816122133.1231599-1-vishalc@linux.ibm.com/

---
#!/usr/bin/env python3

"""
Verify Python syntax trees are equivalent between two references
"""

import argparse
import ast
from pathlib import Path
import subprocess as sp


def read_file(path: Path, ref: str) -> str:
    return sp.run(f"git show {ref}:{path}", stdout=sp.PIPE, shell=True, encoding="utf-8", check=True).stdout


parser = argparse.ArgumentParser("Compare Python ASTs between revisions")
parser.add_argument("ref1", type=str, help="First revision to use")
parser.add_argument("ref2", type=str, help="Second revision to use")
args = parser.parse_args()


for pyfile in Path(".").glob("**/*.py"):
    try:
        ref1_content = read_file(pyfile, args.ref1)
        ref2_content = read_file(pyfile, args.ref2)
    except Exception as e:
        print(f"ERROR:{pyfile}: Failed to read ({e})")
        continue

    try:
        ref1_syntax = ast.parse(ref1_content, filename=pyfile)
        ref2_syntax = ast.parse(ref2_content, filename=pyfile)
    except SyntaxError as e:
        print(f"ERROR:{pyfile}: Failed to parse, is it Python3? ({e})")
        continue

    if ast.dump(ref1_syntax) != ast.dump(ref2_syntax):
        print(f"ERROR:{pyfile}: Revisions have different AST")
        cmd = f"diff <(git show {args.ref1}:{pyfile} | python -m ast) <(git show {args.ref2}:{pyfile} | python -m ast)"
        print(cmd)
        sp.run(cmd, shell=True)
        continue

Benjamin Gray (7):
  ia64: fix Python string escapes
  Documentation/sphinx: fix Python string escapes
  drivers/comedi: fix Python string escapes
  scripts: fix Python string escapes
  tools/perf: fix Python string escapes
  tools/power: fix Python string escapes
  selftests/bpf: fix Python string escapes

 Documentation/sphinx/cdomain.py               |  2 +-
 Documentation/sphinx/kernel_abi.py            |  2 +-
 Documentation/sphinx/kernel_feat.py           |  2 +-
 Documentation/sphinx/kerneldoc.py             |  2 +-
 Documentation/sphinx/maintainers_include.py   |  8 +++---
 arch/ia64/scripts/unwcheck.py                 |  2 +-
 .../ni_routing/tools/convert_csv_to_c.py      |  2 +-
 scripts/clang-tools/gen_compile_commands.py   |  2 +-
 scripts/gdb/linux/symbols.py                  |  2 +-
 tools/perf/pmu-events/jevents.py              |  2 +-
 .../scripts/python/arm-cs-trace-disasm.py     |  4 +--
 tools/perf/scripts/python/compaction-times.py |  2 +-
 .../scripts/python/exported-sql-viewer.py     |  4 +--
 tools/power/pm-graph/bootgraph.py             | 12 ++++-----
 .../selftests/bpf/test_bpftool_synctypes.py   | 26 +++++++++----------
 tools/testing/selftests/bpf/test_offload.py   |  2 +-
 16 files changed, 38 insertions(+), 38 deletions(-)

--
2.41.0
