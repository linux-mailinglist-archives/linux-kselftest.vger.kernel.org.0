Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D671A01FC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Aug 2019 14:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfH1Mj2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Aug 2019 08:39:28 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:13906 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726339AbfH1Mj1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Aug 2019 08:39:27 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SCTbKH047577
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 08:39:26 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2unr92bpbu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Aug 2019 08:39:25 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kselftest@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Aug 2019 13:39:23 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 13:39:19 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SCdHOH55574588
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 12:39:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E37EA4064;
        Wed, 28 Aug 2019 12:39:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1646CA4060;
        Wed, 28 Aug 2019 12:39:16 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.85.129.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 12:39:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Petr Vorel <pvorel@suse.cz>, Jessica Yu <jeyu@kernel.org>,
        Dave Young <dyoung@redhat.com>, shuah <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sefltest/ima: support appended signatures (modsig)
Date:   Wed, 28 Aug 2019 08:39:06 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19082812-0012-0000-0000-00000343E072
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082812-0013-0000-0000-0000217E1D40
Message-Id: <1566995946-6582-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=752 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280133
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Detect and allow appended signatures.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 .../selftests/kexec/test_kexec_file_load.sh        | 38 +++++++++++++++++++---
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/kexec/test_kexec_file_load.sh b/tools/testing/selftests/kexec/test_kexec_file_load.sh
index fa7c24e8eefb..2ff600388c30 100755
--- a/tools/testing/selftests/kexec/test_kexec_file_load.sh
+++ b/tools/testing/selftests/kexec/test_kexec_file_load.sh
@@ -37,11 +37,20 @@ is_ima_sig_required()
 	# sequentially.  As a result, a policy rule may be defined, but
 	# might not necessarily be used.  This test assumes if a policy
 	# rule is specified, that is the intent.
+
+	# First check for appended signature (modsig), then xattr
 	if [ $ima_read_policy -eq 1 ]; then
 		check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
-			"appraise_type=imasig"
+			"appraise_type=imasig|modsig"
 		ret=$?
-		[ $ret -eq 1 ] && log_info "IMA signature required";
+		if [ $ret -eq 1 ]; then
+			log_info "IMA or appended(modsig) signature required"
+		else
+			check_ima_policy "appraise" "func=KEXEC_KERNEL_CHECK" \
+				"appraise_type=imasig"
+			ret=$?
+			[ $ret -eq 1 ] && log_info "IMA signature required";
+		fi
 	fi
 	return $ret
 }
@@ -84,6 +93,22 @@ check_for_imasig()
 	return $ret
 }
 
+# Return 1 for appended signature (modsig) found and 0 for not found.
+check_for_modsig()
+{
+	local module_sig_string="~Module signature appended~"
+	local sig="$(tail --bytes $((${#module_sig_string} + 1)) $KERNEL_IMAGE)"
+	local ret=0
+
+	if [ "$sig" == "$module_sig_string" ]; then
+		ret=1
+		log_info "kexec kernel image modsig signed"
+	else
+		log_info "kexec kernel image not modsig signed"
+	fi
+	return $ret
+}
+
 kexec_file_load_test()
 {
 	local succeed_msg="kexec_file_load succeeded"
@@ -98,7 +123,8 @@ kexec_file_load_test()
 		# In secureboot mode with an architecture  specific
 		# policy, make sure either an IMA or PE signature exists.
 		if [ $secureboot -eq 1 ] && [ $arch_policy -eq 1 ] && \
-			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ]; then
+			[ $ima_signed -eq 0 ] && [ $pe_signed -eq 0 ] \
+			  && [ $ima_modsig -eq 0 ]; then
 			log_fail "$succeed_msg (missing sig)"
 		fi
 
@@ -107,7 +133,8 @@ kexec_file_load_test()
 			log_fail "$succeed_msg (missing PE sig)"
 		fi
 
-		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ]; then
+		if [ $ima_sig_required -eq 1 ] && [ $ima_signed -eq 0 ] \
+		     && [ $ima_modsig -eq 0 ]; then
 			log_fail "$succeed_msg (missing IMA sig)"
 		fi
 
@@ -204,5 +231,8 @@ pe_signed=$?
 check_for_imasig
 ima_signed=$?
 
+check_for_modsig
+ima_modsig=$?
+
 # Test loading the kernel image via kexec_file_load syscall
 kexec_file_load_test
-- 
2.7.5

