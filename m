Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B557E45B4EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239932AbhKXHLt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 02:11:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239430AbhKXHLt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 02:11:49 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO5khwi015113;
        Wed, 24 Nov 2021 07:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=12r/xay4ODGCjZcPY9tslyI4AOHePEGBUwKqLzepX4Y=;
 b=Pp3gkDMYq9BYjLfEeoFMwLVsv14n2QreJlM2xRW1ha/VMfiU67VHi6MG54hkp97KVDAb
 gYKUh08tJvPSZJ22orTIjrFB4NnZF6X8rezaeIjFwynkNLIT9aPeuqA+GqUHmyaF6CL8
 amICm1rF8TVmuJM2jD/cqSJcp0dfMpYYrgtEszCirFrGkD+Vdb+YdCNTnKj+mYD0cTjQ
 y4SwAPqAsSynLvUg7Z19BF7TFaHAfBCQsN9CWZr+y2SjCwdsdQjmfrq4eJruxpX86W3a
 TsrRJ8wGNF7rN8YGfboM2x078J23/nzVaA5wCidxK3DwXpQCOL2ImEKAGbOAnheO7xdr aQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chfhwsaac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:36 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO6xFlG008133;
        Wed, 24 Nov 2021 07:08:34 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3cernax6hg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:34 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO71HZ464815608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 07:01:17 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 85F7C4204C;
        Wed, 24 Nov 2021 07:08:30 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 08CFE4203F;
        Wed, 24 Nov 2021 07:08:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.156.104])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 07:08:22 +0000 (GMT)
From:   Nageswara R Sastry <rnsastry@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, mpe@ellerman.id.au,
        shuah@kernel.org
Cc:     nayna@linux.ibm.com, dja@axtens.net, gcwilson@linux.ibm.com,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH 3/3] Add tests to verify kexec of blacklist and non blacklist kernel
Date:   Wed, 24 Nov 2021 12:38:02 +0530
Message-Id: <20211124070802.1765-3-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211124070802.1765-1-rnsastry@linux.ibm.com>
References: <20211124070802.1765-1-rnsastry@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2lhIz3-8PWcfRijKuQWv0Ld-Die7kGBL
X-Proofpoint-GUID: 2lhIz3-8PWcfRijKuQWv0Ld-Die7kGBL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240040
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new tests to verify kexec of blacklisted and non blacklisted
kernel based on ima policy and secureboot state.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
---
 tools/testing/selftests/kexec/Makefile        |  3 +-
 .../selftests/kexec/kexec_common_lib.sh       | 71 +++++++++++++++
 .../selftests/kexec/test_kexec_dbx_bk.sh      | 90 +++++++++++++++++++
 .../selftests/kexec/test_kexec_dbx_nbk.sh     | 62 +++++++++++++
 4 files changed, 225 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/kexec/test_kexec_dbx_bk.sh
 create mode 100755 tools/testing/selftests/kexec/test_kexec_dbx_nbk.sh

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index 806a150648c3..ac1e998e0158 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -5,7 +5,8 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
 ifeq ($(ARCH),$(filter $(ARCH),x86 ppc64le))
-TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
+TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh test_kexec_dbx_bk.sh\
+		test_kexec_dbx_nbk.sh
 TEST_FILES := kexec_common_lib.sh
 
 include ../lib.mk
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index e907c3030eb3..9f9383940a93 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -7,6 +7,7 @@ VERBOSE="${VERBOSE:-1}"
 IKCONFIG="/tmp/config-`uname -r`"
 KERNEL_IMAGE="/boot/vmlinuz-`uname -r`"
 SECURITYFS=$(grep "securityfs" /proc/mounts | awk '{print $2}')
+BLACKLIST_BIN_HASH=""
 
 log_info()
 {
@@ -244,3 +245,73 @@ check_ima_policy()
 	[ $? -eq 0 ] && ret=1
 	return $ret
 }
+
+# Look for check_blacklist in IMA Policy
+# Return 1 for found and 0 for not found.
+check_for_ima_policy_blacklist()
+{
+	local ret=0
+
+	check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+			"appraise_flag=check_blacklist"
+	ret=$?
+	[ $ret -eq 1 ] && log_info "Found IMA blacklist policy rule"
+
+	return $ret
+}
+
+# Look for blacklist_binary from blacklist keyring
+# Return 1 for found and 0 for not found.
+check_for_dbx_bin()
+{
+	local ret=0
+
+	which keyctl > /dev/null 2>&1 || log_skip "keyctl not found"
+	cmd=$(keyctl show %keyring:.blacklist | grep "blacklist: bin" | wc -l)
+	if [ $cmd -ge 1 ]; then
+		BLACKLIST_BIN_HASH=$(keyctl show %keyring:.blacklist | grep \
+					"blacklist: bin" | cut -d":" -f3)
+		log_info "Found DBX blacklist binary from keyring"
+		ret=1
+	fi
+	return $ret
+}
+
+common_steps_for_dbx()
+{
+	ima_policy=0
+        dbx=0
+	secureboot=0
+
+	# kexec requires root privileges
+	require_root_privileges
+
+	# get the kernel config
+	get_kconfig
+
+	kconfig_enabled "CONFIG_KEXEC_FILE=y" "kexec_file_load is enabled"
+	if [ $? -eq 0 ]; then
+		log_skip "kexec_file_load is not enabled"
+	fi
+
+	kconfig_enabled "CONFIG_SYSTEM_BLACKLIST_KEYRING=y" \
+			"Kernel config blacklist_keyring is enabled"
+	if [ $? -eq 0 ]; then
+		log_skip "Kernel config blacklist_keyring is not enabled"
+	fi
+
+	check_for_ima_policy_blacklist
+	ima_policy=$?
+	if [ $ima_policy -eq 0 ];then
+		log_skip "Not found IMA blacklist policy rule"
+	fi
+
+	check_for_dbx_bin
+	dbx=$?
+	if [ $dbx -eq 0 ]; then
+		log_skip "Not found blacklisted kernel"
+	fi
+
+	get_secureboot_mode
+	secureboot=$?
+}
diff --git a/tools/testing/selftests/kexec/test_kexec_dbx_bk.sh b/tools/testing/selftests/kexec/test_kexec_dbx_bk.sh
new file mode 100755
index 000000000000..212a86be290d
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_dbx_bk.sh
@@ -0,0 +1,90 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Loading a dbx black listed kernel image via the kexec_file_load syscall
+
+. ./kexec_common_lib.sh
+
+TEST="KEXEC_FILE_LOAD_DBX"
+
+# Read KERNEL_DBX_IMAGE from the environment variable
+KERNEL_DBX_IMAGE=$(printenv | grep KERNEL_DBX_IMAGE | cut -d"=" -f2)
+if [ -z $KERNEL_DBX_IMAGE ]; then
+	env_var="KERNEL_DBX_IMAGE"
+	log_skip "$env_var not found, set using 'export $env_var=value'"
+#	KERNEL_DBX_IMAGE=$KERNEL_IMAGE
+#	log_info "Continuing with booted kernel"
+fi
+
+# Look for kernel matching with blacklisted binary hash
+check_for_blacklist_kernel()
+{
+	local module_sig_string="~Module signature appended~"
+	local ret=0
+
+	tail --bytes $((${#module_sig_string} + 1)) $KERNEL_DBX_IMAGE | \
+		grep -q "$module_sig_string"
+	if [ $? -eq 0 ]; then
+		log_info "Found $KERNEL_DBX_IMAGE with Module signature"
+		# Remove the signature
+		local hash=$(../../../../scripts/extract-module-sig.pl -0\
+				${KERNEL_DBX_IMAGE} 2> /dev/null | sha256sum -\
+				|awk -F" " '{print $1}')
+		for b_hash in $BLACKLIST_BIN_HASH
+		do
+			# Make sure test is not going to run on booted kernel
+			if [ "$hash" == "$b_hash" -a \
+				"$KERNEL_IMAGE" != "$KERNEL_DBX_IMAGE" ]; then
+				KERNEL_IMAGE=$KERNEL_DBX_IMAGE
+				ret=1
+			fi
+		done
+	fi
+	return $ret
+}
+
+kexec_file_load_dbx_test()
+{
+	local succeed_msg=$1
+	local failed_msg=$2
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 ]; then
+		kexec --unload --kexec-file-syscall
+
+		# In secureboot mode with an architecture  specific
+		# policy, make sure dbx blacklist exists
+		if [ $secureboot -eq 1 ] && [ $dbx -eq 1 ]; then
+			log_fail "$succeed_msg (secureboot and dbx enabled)"
+		# secureboot mode disabled, and dbx blacklist exists
+		elif [ $dbx -eq 1 ]; then
+			log_fail "$succeed_msg (dbx enabled)"
+		fi
+	fi
+
+	# Check the reason for the kexec_file_load failure
+	if (echo $line | grep -q "Permission denied"); then
+		if [ $dbx -eq 1 ]; then
+			log_pass "$failed_msg (Permission denied)"
+		else
+			log_fail "$succeed_msg"
+		fi
+	fi
+
+	return 0
+}
+
+common_steps_for_dbx
+
+check_for_blacklist_kernel
+bk=$?
+
+if [ $bk -eq 0 ]; then
+	log_skip "Not found blacklisted hash matching kernel"
+fi
+
+# Loading the black listed kernel image via kexec_file_load syscall should fail
+succeed_msg="kexec blacklisted kernel image succeeded"
+failed_msg="kexec blacklisted kernel image failed"
+kexec_file_load_dbx_test "$succeed_msg" "$failed_msg"
diff --git a/tools/testing/selftests/kexec/test_kexec_dbx_nbk.sh b/tools/testing/selftests/kexec/test_kexec_dbx_nbk.sh
new file mode 100755
index 000000000000..8cd09dd79d01
--- /dev/null
+++ b/tools/testing/selftests/kexec/test_kexec_dbx_nbk.sh
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Loading a dbx black listed kernel image via the kexec_file_load syscall
+
+. ./kexec_common_lib.sh
+
+TEST="KEXEC_FILE_LOAD_DBX_NB"
+
+# Look for kernel matching with blacklisted binary hash
+check_for_non_blacklist_kernel()
+{
+	local module_sig_string="~Module signature appended~"
+	local ret=0
+
+	tail --bytes $((${#module_sig_string} + 1)) $KERNEL_IMAGE | \
+		grep -q "$module_sig_string"
+	if [ $? -eq 0 ]; then
+		log_info "Found $KERNEL_IMAGE with Module signature"
+		# Remove the signature
+		local hash=$(../../../../scripts/extract-module-sig.pl -0\
+				${KERNEL_IMAGE} 2> /dev/null | sha256sum -\
+				|awk -F" " '{print $1}')
+		for b_hash in $BLACKLIST_BIN_HASH
+		do
+			if ! [ "$hash" == "$b_hash" ]; then
+				ret=1
+			fi
+		done
+	fi
+	return $ret
+}
+
+kexec_file_load_nbk_test()
+{
+	local succeed_msg=$1
+	local failed_msg=$2
+
+	line=$(kexec --load --kexec-file-syscall $KERNEL_IMAGE 2>&1)
+
+	if [ $? -eq 0 -a $secureboot -eq 1 ]; then
+		kexec --unload --kexec-file-syscall
+		log_pass "$succeed_msg (secureboot enabled)"
+	elif (echo $line | grep -q "Permission denied"); then
+		log_fail "$failed_msg (Permission denied)"
+	fi
+
+}
+
+common_steps_for_dbx
+
+check_for_non_blacklist_kernel
+bk=$?
+
+if [ $bk -eq 0 ]; then
+	log_skip "Found blacklisted hash matching kernel"
+fi
+
+# Loading the black listed kernel image via kexec_file_load syscall should fail
+succeed_msg="kexec non blacklisted kernel image succeeded"
+failed_msg="kexec non blacklisted kernel image failed"
+kexec_file_load_nbk_test "$succeed_msg" "$failed_msg"
-- 
2.23.0

