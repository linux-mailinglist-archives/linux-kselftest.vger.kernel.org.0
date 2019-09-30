Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5376BC26B5
	for <lists+linux-kselftest@lfdr.de>; Mon, 30 Sep 2019 22:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbfI3UjV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Sep 2019 16:39:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60744 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730679AbfI3UjV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Sep 2019 16:39:21 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8UHqnRO097382
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:59:26 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vbmmmn72p-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Sep 2019 13:59:26 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <iii@linux.ibm.com>;
        Mon, 30 Sep 2019 18:59:24 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 30 Sep 2019 18:59:22 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8UHwqdE40239526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Sep 2019 17:58:52 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B64184C052;
        Mon, 30 Sep 2019 17:59:20 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 802764C044;
        Mon, 30 Sep 2019 17:59:20 +0000 (GMT)
Received: from white.boeblingen.de.ibm.com (unknown [9.152.96.81])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 30 Sep 2019 17:59:20 +0000 (GMT)
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v3 1/2] selftests: append / to $(OUTPUT)
Date:   Mon, 30 Sep 2019 19:59:03 +0200
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190930175904.78219-1-iii@linux.ibm.com>
References: <20190930175904.78219-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19093017-4275-0000-0000-0000036CA0BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19093017-4276-0000-0000-0000387F28B2
Message-Id: <20190930175904.78219-2-iii@linux.ibm.com>
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

$(OUTPUT) is assumed to end with a / everywhere else in the tree, make
this the case for kselftest as well.

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 tools/testing/selftests/Makefile | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

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
-- 
2.23.0

