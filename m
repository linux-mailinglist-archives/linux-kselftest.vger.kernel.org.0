Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAA03AEA1B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Sep 2019 14:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388356AbfIJMSW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Sep 2019 08:18:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25160 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731146AbfIJMSV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Sep 2019 08:18:21 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ACHUxY003110
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 08:18:20 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ux9w4bxu6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Sep 2019 08:18:20 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Tue, 10 Sep 2019 13:18:18 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 10 Sep 2019 13:18:17 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ACIFxH45678818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 12:18:15 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42A3FA40A8;
        Tue, 10 Sep 2019 12:18:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DABCFA40B8;
        Tue, 10 Sep 2019 12:18:14 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.145.93.131])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 12:18:14 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2] selftests: fix prepending $(OUTPUT) to $(TEST_PROGS)
Date:   Tue, 10 Sep 2019 13:18:13 +0100
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19091012-4275-0000-0000-00000363EFFD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091012-4276-0000-0000-0000387643F7
Message-Id: <20190910121813.45742-1-iii@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100121
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The current logic prepends $(OUTPUT) only to the first member of
$(TEST_PROGS). Use $(addprefix) to prepend it to each member.

Also, $(OUTPUT) is assumed to end with a / almost everywhere else in
the kernel, make this the case for kselftest as well.

Fixes: 1a940687e424 ("selftests: lib.mk: copy test scripts and test files for make O=dir run")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1->v2:
 - Append / to $(OUTPUT).
 - Use $(addprefix) instead of $(foreach).

tools/testing/selftests/Makefile | 16 ++++++++--------
 tools/testing/selftests/lib.mk   |  3 ++-
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index c3feccb99ff5..49bcd066907e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -136,31 +136,31 @@ all: khdr
 	@for TARGET in $(TARGETS); do		\
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
 		mkdir $$BUILD_TARGET  -p;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
 	done;
 
 run_tests: all
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_tests;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET run_tests;\
 	done;
 
 hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET;\
 	done;
 
 run_hotplug: hotplug
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET run_full_test;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET run_full_test;\
 	done;
 
 clean_hotplug:
 	@for TARGET in $(TARGETS_HOTPLUG); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET clean;\
 	done;
 
 run_pstore_crash:
@@ -184,7 +184,7 @@ ifdef INSTALL_PATH
 	install -m 744 kselftest/prefix.pl $(INSTALL_PATH)/kselftest/
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET INSTALL_PATH=$(INSTALL_PATH)/$$TARGET install; \
 	done;
 
 	@# Ask all targets to emit their test scripts
@@ -203,7 +203,7 @@ ifdef INSTALL_PATH
 		echo "[ -w /dev/kmsg ] && echo \"kselftest: Running tests in $$TARGET\" >> /dev/kmsg" >> $(ALL_SCRIPT); \
 		echo "cd $$TARGET" >> $(ALL_SCRIPT); \
 		echo -n "run_many" >> $(ALL_SCRIPT); \
-		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
+		$(MAKE) -s --no-print-directory OUTPUT=$$BUILD_TARGET/ -C $$TARGET emit_tests >> $(ALL_SCRIPT); \
 		echo "" >> $(ALL_SCRIPT);	    \
 		echo "cd \$$ROOT" >> $(ALL_SCRIPT); \
 	done;
@@ -216,7 +216,7 @@ endif
 clean:
 	@for TARGET in $(TARGETS); do \
 		BUILD_TARGET=$$BUILD/$$TARGET;	\
-		$(MAKE) OUTPUT=$$BUILD_TARGET -C $$TARGET clean;\
+		$(MAKE) OUTPUT=$$BUILD_TARGET/ -C $$TARGET clean;\
 	done;
 
 .PHONY: khdr all run_tests hotplug run_hotplug clean_hotplug run_pstore_crash install clean
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
2.21.0

