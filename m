Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB8C8C26F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2019 22:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbfI3UnR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Sep 2019 16:43:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726425AbfI3UnQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Sep 2019 16:43:16 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UHqpOS057682
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:59:45 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbkcb8y6s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:59:44 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 30 Sep 2019 18:59:43 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 18:59:40 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UHxcS338469846
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 17:59:38 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F7F74C04E;
        Mon, 30 Sep 2019 17:59:38 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5924B4C046;
        Mon, 30 Sep 2019 17:59:38 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 17:59:38 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 2/2] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
Date:   Mon, 30 Sep 2019 19:59:04 +0200
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930175904.78219-1-iii@linux.ibm.com>
References: <20190930175904.78219-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093017-4275-0000-0000-0000036CA0BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093017-4276-0000-0000-0000387F28B4
Message-Id: <20190930175904.78219-3-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-30_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909300164
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently the following command fails:

    linux# make kselftest TARGETS=bpf O=/mnt/linux-build
    # selftests: bpf: test_libbpf.sh
    # ./test_libbpf.sh: line 23: ./test_libbpf_open: No such file or directory
    # test_libbpf: failed at file test_l4lb.o
    # selftests: test_libbpf [FAILED]

The current logic prepends $(OUTPUT) only to the first member of
$(TEST_PROGS). After that, run_one() does

   cd `dirname $TEST`

For all tests except the first one, `dirname $TEST` is ., which means
they cannot access the files generated in $(OUTPUT).

Fix by using $(addprefix) to prepend $(OUTPUT) to each member of
$(TEST_PROGS).

Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/lib.mk | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 1c8a1963d03f..27a97a1b4e9e 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -75,7 +75,8 @@ ifdef building_out_of_srctree
 		@rsync -aq $(TEST_PROGS) $(TEST_PROGS_EXTENDED) $(TEST_FILES) $(OUTPUT)
 	fi
 	@if [ "X$(TEST_PROGS)" != "X" ]; then
-		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(OUTPUT)/$(TEST_PROGS))
+		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) \
+				  $(addprefix $(OUTPUT),$(TEST_PROGS)))
 	else
 		$(call RUN_TESTS, $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS))
 	fi
-- 
2.23.0

