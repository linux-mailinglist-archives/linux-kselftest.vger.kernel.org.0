Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B83933D7A6
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Mar 2021 16:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhCPPeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 11:34:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39188 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237018AbhCPPdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 11:33:38 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12GFWU6o028602;
        Tue, 16 Mar 2021 11:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=wvx0A17d10zrF1mcTCQau1RHRzJqamyX8Hub+5TYDsg=;
 b=jcB8jayUDWXcLDs8vv/3dlHCZ6kG/mXfNtzU52j1DlCh2TVRuv4IzWHSdULLYfSVaDN6
 Pocc6gDD8AjHeAXEdo2X1K0rsIA9+2ZXrKwNqB691CnyAJZoxqe/zduxA2T33zz2t9qR
 DoU9zGwXDMNjRW3IfbCDc05AdUxndf8Srm/tSt7ARzswypWmpLKlgi4ZNo/wMBTC9Jrj
 4qVmwEBvo6CleNmJntgUdxQzteHYLqoo3elFFEfDbyG47FoaELSu+HCvvBmb/+PCnNPR
 Kd8OS9X/lzmZs0LKujf2VKYzkTy1Q6bPFkW8/xBbE6KiyQMoH5ePVMIGFfGX345JiuRx kQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ap2tj1ns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 11:33:19 -0400
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 12GFWnQA031997;
        Tue, 16 Mar 2021 11:33:19 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 37ap2tj1n0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 11:33:18 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 12GFKemN006178;
        Tue, 16 Mar 2021 15:33:17 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06fra.de.ibm.com with ESMTP id 378mnh9jrt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Mar 2021 15:33:16 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 12GFXEAU44630412
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Mar 2021 15:33:14 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E2AE52051;
        Tue, 16 Mar 2021 15:33:14 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.38.113])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 05C825205A;
        Tue, 16 Mar 2021 15:33:10 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To:     ast@kernel.org, shuah@kernel.org
Cc:     ravi.bangoria@linux.ibm.com, daniel@iogearbox.net, yhs@fb.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com,
        john.fastabend@gmail.com, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/bpf/get_cgroup_id: Use nanosleep() syscall instead of sleep()
Date:   Tue, 16 Mar 2021 21:00:48 +0530
Message-Id: <20210316153048.136447-1-ravi.bangoria@linux.ibm.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-16_05:2021-03-16,2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxscore=0 phishscore=0 clxscore=1011
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2103160104
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Glibc sleep() switched to clock_nanosleep() from nanosleep(),
thus syscalls:sys_enter_nanosleep tracepoint is not hitting
which is causing testcase failure. Instead of depending on
glibc sleep(), call nanosleep() systemcall directly.

Before:
  # ./get_cgroup_id_user
  ...
  main:FAIL:compare_cgroup_id kern cgid 0 user cgid 483

After:
  # ./get_cgroup_id_user
  ...
  main:PASS:compare_cgroup_id

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/testing/selftests/bpf/get_cgroup_id_user.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/get_cgroup_id_user.c b/tools/testing/selftests/bpf/get_cgroup_id_user.c
index b8d6aef99db4..99628e1a1e58 100644
--- a/tools/testing/selftests/bpf/get_cgroup_id_user.c
+++ b/tools/testing/selftests/bpf/get_cgroup_id_user.c
@@ -57,6 +57,10 @@ int main(int argc, char **argv)
 	__u32 key = 0, pid;
 	int exit_code = 1;
 	char buf[256];
+	const struct timespec req = {
+		.tv_sec = 1,
+		.tv_nsec = 0,
+	};
 
 	cgroup_fd = cgroup_setup_and_join(TEST_CGROUP);
 	if (CHECK(cgroup_fd < 0, "cgroup_setup_and_join", "err %d errno %d\n", cgroup_fd, errno))
@@ -115,7 +119,7 @@ int main(int argc, char **argv)
 		goto close_pmu;
 
 	/* trigger some syscalls */
-	sleep(1);
+	syscall(__NR_nanosleep, &req, NULL);
 
 	err = bpf_map_lookup_elem(cgidmap_fd, &key, &kcgid);
 	if (CHECK(err, "bpf_map_lookup_elem", "err %d errno %d\n", err, errno))
-- 
2.29.2

