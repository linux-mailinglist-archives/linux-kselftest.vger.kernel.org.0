Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636BB32BCF4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Mar 2021 23:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhCCPGs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Mar 2021 10:06:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237766AbhCCApV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 19:45:21 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1230iOAC146158;
        Tue, 2 Mar 2021 19:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=67DQOxSuXUNLFgrfWdXbjqKz/37AuPpoXqCh6LJOujw=;
 b=hq3LI+yJ6oFOso2OMKBhMEF0e3PzW39iXlbFXD5mzS+FegNWpUzXW6JFH35LvFZJQoKY
 jRy0+3Tkq4mF4JyBWRN9GpF60GG3K17L9Ddv6MuHUwEJcf02VhPREoBJsEirWJIaeC6N
 J9KddugOmgIj03C9xwvOEVePipo2rml8lhALhvrkTrU0LzYjMRgdp7+3ZknVS5fzVtyK
 ZMIogbJD4wY76oXTXlUJSLvf6eMqOMj4tGVWXqH1NWw0seTDbPaBvhPXJKnWsTYlgXjk
 zySf3Q3421nzY3/92D5GFHuOQgtyxGo2mOq0YOA0QjsqMh8Uj+FCkMpcD9BywHbwI/D5 1A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 372061g052-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 19:44:30 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 1230XdUH004845;
        Wed, 3 Mar 2021 00:44:27 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3712fmhahv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Mar 2021 00:44:27 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1230iPoX39321924
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 3 Mar 2021 00:44:25 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E7247AE053;
        Wed,  3 Mar 2021 00:44:24 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98538AE04D;
        Wed,  3 Mar 2021 00:44:24 +0000 (GMT)
Received: from vm.lan (unknown [9.145.31.74])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  3 Mar 2021 00:44:24 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v5] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
Date:   Wed,  3 Mar 2021 01:44:20 +0100
Message-Id: <20210303004420.138360-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
X-TM-AS-GCONF: 00
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_08:2021-03-01,2021-03-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103030001
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the following command produces an error message:

    linux# make kselftest TARGETS=bpf O=/mnt/linux-build
    # selftests: bpf: test_libbpf.sh
    # ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
    # test_libbpf: failed at file test_l4lb.o
    # selftests: test_libbpf [FAILED]

The error message might not affect the return code of make, therefore
one needs to grep make output in order to detect it.

This is not the only instance of the same underlying problem; any test
with more than one element in $(TEST_PROGS) fails the same way. Another
example:

    linux# make O=/mnt/linux-build TARGETS=splice kselftest
    [...]
    # ./short_splice_read.sh: 15: ./splice_read: not found
    # FAIL: /sys/module/test_module/sections/.init.text 2
    not ok 2 selftests: splice: short_splice_read.sh # exit=1

The current logic prepends $(OUTPUT) only to the first member of
$(TEST_PROGS). After that, run_one() does

   cd `dirname $TEST`

For all tests except the first one, `dirname $TEST` is ., which means
they cannot access the files generated in $(OUTPUT).

Fix by using $(addprefix) to prepend $(OUTPUT)/ to each member of
$(TEST_PROGS).

Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1->v2:
- Append / to $(OUTPUT).
- Use $(addprefix) instead of $(foreach).

v2->v3:
- Split the patch in two.
- Improve the commit message.

v3: https://lore.kernel.org/linux-kselftest/20191024121347.22189-1-iii@linux.ibm.com/
v3->v4:
- Drop the first patch.
- Add a note regarding make return code to the commit message.

v4: https://lore.kernel.org/linux-kselftest/20191115150428.61131-1-iii@linux.ibm.com/
v4->v5:
- Add another reproducer to the commit message.

 tools/testing/selftests/lib.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index a5ce26d548e4..be17462fe146 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -74,7 +74,8 @@ ifdef building_out_of_srctree
 		rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT); \
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then \
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS)) ; \
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
+				  $(addprefix $(OUTPUT)/,$(TEST_PROGS))) ; \
 	else \
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS)); \
 	fi
-- 
2.29.2

