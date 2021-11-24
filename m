Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918D545B4EB
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Nov 2021 08:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237774AbhKXHLm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Nov 2021 02:11:42 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27094 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229604AbhKXHLm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Nov 2021 02:11:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AO6kgfV010840;
        Wed, 24 Nov 2021 07:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ijGdtLy37iLQb4XFeQBKr82dFHHofQJVyd6j/tLtoRw=;
 b=IX/lnMNc3DRYflAXiW2fefOjrousGac0Rqh59X9kSM2SoUFspayLwCZUL6+rf0fFkZ0L
 G/2ZSHABGMpcbGxfOUZUtG1mwPDgLlWF3J0NzUI9hgVtu4lDH/TqQsu48XnXeFFGCb+d
 WNGHQw2td7lHfVDIxJLcjzEwDPH5kG4AjVoYYyJSNRVy2JPQFby95oRoZcA9r0d5znwn
 e/MpyMVHEOzPu7jvqQGJwP8nsbr2rEtChuYtZnOv4hT5a8TFCdcVbjbTaoaTDyBpI3H4
 8oBlQRSSd+xvClyhKoCXY3esfnCwu6fnIT0dah2M82tphkHOvn6zv9EpOOHpK4CPcKNi 7w== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3chgdyrbp8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:27 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AO6wigA021313;
        Wed, 24 Nov 2021 07:08:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3cern9mu0n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 Nov 2021 07:08:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AO78Mxr20513068
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 07:08:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 369C042047;
        Wed, 24 Nov 2021 07:08:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 608D74203F;
        Wed, 24 Nov 2021 07:08:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.211.156.104])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 24 Nov 2021 07:08:16 +0000 (GMT)
From:   Nageswara R Sastry <rnsastry@linux.ibm.com>
To:     zohar@linux.ibm.com, linux-kselftest@vger.kernel.org,
        linux-integrity@vger.kernel.org, mpe@ellerman.id.au,
        shuah@kernel.org
Cc:     nayna@linux.ibm.com, dja@axtens.net, gcwilson@linux.ibm.com,
        Nageswara R Sastry <rnsastry@linux.ibm.com>
Subject: [PATCH 2/3] selftests/kexec: Enable secureboot tests for PowerPC
Date:   Wed, 24 Nov 2021 12:38:01 +0530
Message-Id: <20211124070802.1765-2-rnsastry@linux.ibm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20211124070802.1765-1-rnsastry@linux.ibm.com>
References: <20211124070802.1765-1-rnsastry@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4O-oHu9G0xzBHT1h1qlhRQXxUoXXTM_O
X-Proofpoint-GUID: 4O-oHu9G0xzBHT1h1qlhRQXxUoXXTM_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-24_02,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 mlxlogscore=999 clxscore=1015 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111240040
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Existing test cases determine secureboot state using efi variable, which is
available only on x86 architecture.
Add support for determining secureboot state using device tree property on
PowerPC architecture.

Signed-off-by: Nageswara R Sastry <rnsastry@linux.ibm.com>
---
 tools/testing/selftests/kexec/Makefile        |  2 +-
 .../selftests/kexec/kexec_common_lib.sh       | 38 ++++++++++++++++---
 .../selftests/kexec/test_kexec_file_load.sh   |  8 +++-
 3 files changed, 39 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kexec/Makefile b/tools/testing/selftests/kexec/Makefile
index aa91d2063249..806a150648c3 100644
--- a/tools/testing/selftests/kexec/Makefile
+++ b/tools/testing/selftests/kexec/Makefile
@@ -4,7 +4,7 @@
 uname_M := $(shell uname -m 2>/dev/null || echo not)
 ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
 
-ifeq ($(ARCH),x86)
+ifeq ($(ARCH),$(filter $(ARCH),x86 ppc64le))
 TEST_PROGS := test_kexec_load.sh test_kexec_file_load.sh
 TEST_FILES := kexec_common_lib.sh
 
diff --git a/tools/testing/selftests/kexec/kexec_common_lib.sh b/tools/testing/selftests/kexec/kexec_common_lib.sh
index 43017cfe88f7..e907c3030eb3 100755
--- a/tools/testing/selftests/kexec/kexec_common_lib.sh
+++ b/tools/testing/selftests/kexec/kexec_common_lib.sh
@@ -91,6 +91,27 @@ get_efi_var_secureboot_mode()
 	return 0;
 }
 
+# On powerpc platform, check device-tree property
+# /proc/device-tree/ibm,secureboot/os-secureboot-enforcing
+# to detect secureboot state.
+get_ppc64_secureboot_mode()
+{
+	local secure_boot_file="/proc/device-tree/ibm,secureboot/os-secureboot-enforcing"
+	# Check for secure boot file existence
+	if [ -f $secure_boot_file ]; then
+		log_info "Secureboot is enabled (Device tree)"
+		return 1;
+	fi
+	log_info "Secureboot is not enabled (Device tree)"
+	return 0;
+}
+
+# Return the architecture of the system
+get_arch()
+{
+	echo $(arch)
+}
+
 # Check efivar SecureBoot-$(the UUID) and SetupMode-$(the UUID).
 # The secure boot mode can be accessed either as the last integer
 # of "od -An -t u1 /sys/firmware/efi/efivars/SecureBoot-*" or from
@@ -100,14 +121,19 @@ get_efi_var_secureboot_mode()
 get_secureboot_mode()
 {
 	local secureboot_mode=0
+	local system_arch=$(get_arch)
 
-	get_efivarfs_secureboot_mode
-	secureboot_mode=$?
-
-	# fallback to using the efi_var files
-	if [ $secureboot_mode -eq 0 ]; then
-		get_efi_var_secureboot_mode
+	if [ "$system_arch" == "ppc64le" ]; then
+		get_ppc64_secureboot_mode
 		secureboot_mode=$?
+	else
+		get_efivarfs_secureboot_mode
+		secureboot_mode=$?
+		# fallback to using the efi_var files
+		if [ $secureboot_mode -eq 0 ]; then
+			get_efi_var_secureboot_mode
+			secureboot_mode=$?
+		fi
 	fi
 
 	if [ $secureboot_mode -eq 0 ]; then
diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index 99f6fc23ee31..c9ccb3c93d72 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -226,8 +226,12 @@ get_secureboot_mode
 secureboot=$?
 
 # Are there pe and ima signatures
-check_for_pesig
-pe_signed=$?
+if [ "$(get_arch)" == 'ppc64le' ]; then
+	pe_signed=0
+else
+	check_for_pesig
+	pe_signed=$?
+fi
 
 check_for_imasig
 ima_signed=$?
-- 
2.23.0

