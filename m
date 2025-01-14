Return-Path: <linux-kselftest+bounces-24449-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD3DA1096E
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 15:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DEA1608F2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 14:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FED11474A5;
	Tue, 14 Jan 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AjLS4P50"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94A313A879;
	Tue, 14 Jan 2025 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865145; cv=none; b=uTlrj9fsDZHKU/58qheTHFNS3lgCrwpwVss0cXvFieUi/YR/0DfUHvhPvm6vej3Na1GGWELMY2jpzCgYifbCHE/VETCcOd7I5P4yf+0xxKOQypNt0fRz0FBn606JezjQNePGlJsNob0aMqGIOaAL+Bf2SyHQLxH0XxD3C4MXF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865145; c=relaxed/simple;
	bh=kF0aFyyo7XaoEXlUuD7nHmdei0HxOgClY6gAvpRoQRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUmNJ+F6DMtTO/WmH6LrNEjoWix7syD3EJa3rHz4AkXz/8SC78EUVXDMPfDNWt1CPFI2a6dz+36S1nFeF388JJFxoI7a6T8rHLGat+n6Lx1v24fNOEM8TR/x5//FMOFEKh86nqKLPHxBwqNAP6DZbpnQUL+EmMyXCj9rssy2l7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AjLS4P50; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50E3s7DV005799;
	Tue, 14 Jan 2025 14:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=WuwNzSCv4EUuRn8dRTh7pIOxZia6gwwm11Bgq1t1C
	Ak=; b=AjLS4P501IufRuKc92kDYkBUM694yB5w/MZlTC7+3X9c7BC+BgMMfBs/N
	vitm9AUJcpmRlfYQtxRG04HyOkPUcQy9vxfJ6aUQyE2bqjrNYYISglkfK1Q4QgmH
	qIBTC+QXuWShepkfFmZkHBaCgPpzJ6fV1WGfTC0CEJLWRWh9q/g3f/530INX32vb
	PHjeBfAklyhJ5F9zeqTWnbeWMm5c+9PtdGd9ER+L5wn/ujIM9C4j/GvObFtHX5pf
	jJO7f7rodkOa1Y5yhdSTjILTf7G0FXwSbF+z55S0yRI+yVoN+0JhpLEORdFf7Vdg
	HWpZYoqFQ57sqNu9qhMkaEcnkJ7zQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdjjaa2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 50EETRnd029597;
	Tue, 14 Jan 2025 14:32:02 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 445gdjja9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50EEJctk017014;
	Tue, 14 Jan 2025 14:32:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4444fk3fc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jan 2025 14:32:00 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50EEVxHk29754032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jan 2025 14:31:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDA5C20043;
	Tue, 14 Jan 2025 14:31:58 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA0D420040;
	Tue, 14 Jan 2025 14:31:52 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.0.219])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Jan 2025 14:31:52 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, shuah@kernel.org
Cc: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, live-patching@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [PATCH] selftests: livepatch: handle PRINTK_CALLER in check_result()
Date: Tue, 14 Jan 2025 20:01:44 +0530
Message-ID: <20250114143144.164250-1-maddy@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qnPN_SzONfNK6j-06uxQuxcWq8HlKsP6
X-Proofpoint-ORIG-GUID: gCspiTx0ec9vkIAjl20tG56LdC5i68fC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=635
 suspectscore=0 malwarescore=0 bulkscore=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501140115

Some arch configs (like ppc64) enable CONFIG_PRINTK_CALLER, which
adds the caller id as part of the dmesg. Due to this, even though
the expected vs observed are same, end testcase results are failed.

 -% insmod test_modules/test_klp_livepatch.ko
 -livepatch: enabling patch 'test_klp_livepatch'
 -livepatch: 'test_klp_livepatch': initializing patching transition
 -livepatch: 'test_klp_livepatch': starting patching transition
 -livepatch: 'test_klp_livepatch': completing patching transition
 -livepatch: 'test_klp_livepatch': patching complete
 -% echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
 -livepatch: 'test_klp_livepatch': initializing unpatching transition
 -livepatch: 'test_klp_livepatch': starting unpatching transition
 -livepatch: 'test_klp_livepatch': completing unpatching transition
 -livepatch: 'test_klp_livepatch': unpatching complete
 -% rmmod test_klp_livepatch
 +[   T3659] % insmod test_modules/test_klp_livepatch.ko
 +[   T3682] livepatch: enabling patch 'test_klp_livepatch'
 +[   T3682] livepatch: 'test_klp_livepatch': initializing patching transition
 +[   T3682] livepatch: 'test_klp_livepatch': starting patching transition
 +[    T826] livepatch: 'test_klp_livepatch': completing patching transition
 +[    T826] livepatch: 'test_klp_livepatch': patching complete
 +[   T3659] % echo 0 > /sys/kernel/livepatch/test_klp_livepatch/enabled
 +[   T3659] livepatch: 'test_klp_livepatch': initializing unpatching transition
 +[   T3659] livepatch: 'test_klp_livepatch': starting unpatching transition
 +[    T789] livepatch: 'test_klp_livepatch': completing unpatching transition
 +[    T789] livepatch: 'test_klp_livepatch': unpatching complete
 +[   T3659] % rmmod test_klp_livepatch

  ERROR: livepatch kselftest(s) failed
 not ok 1 selftests: livepatch: test-livepatch.sh # exit=1

Currently the check_result() handles the "[time]" removal from
the dmesg. Enhance the check to handle removal of "[Tid]" also.

Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
---
 tools/testing/selftests/livepatch/functions.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/livepatch/functions.sh b/tools/testing/selftests/livepatch/functions.sh
index e5d06fb40233..a1730c1864a4 100644
--- a/tools/testing/selftests/livepatch/functions.sh
+++ b/tools/testing/selftests/livepatch/functions.sh
@@ -306,7 +306,8 @@ function check_result {
 	result=$(dmesg | awk -v last_dmesg="$LAST_DMESG" 'p; $0 == last_dmesg { p=1 }' | \
 		 grep -e 'livepatch:' -e 'test_klp' | \
 		 grep -v '\(tainting\|taints\) kernel' | \
-		 sed 's/^\[[ 0-9.]*\] //')
+		 sed 's/^\[[ 0-9.]*\] //' | \
+		 sed 's/^\[[ ]*T[0-9]*\] //')
 
 	if [[ "$expect" == "$result" ]] ; then
 		echo "ok"
-- 
2.47.0


