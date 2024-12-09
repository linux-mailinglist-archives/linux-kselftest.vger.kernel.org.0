Return-Path: <linux-kselftest+bounces-22970-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510E39E8BBE
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 07:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42363163A89
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Dec 2024 06:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC9214A65;
	Mon,  9 Dec 2024 06:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BK+mrXeb"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8651D555;
	Mon,  9 Dec 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733727479; cv=none; b=X5QMKanswM7uSYEBiJL7jooQTbW7e1L9uG6TZ6eZ1P22VMrpKcK9T8SSzwtZsBjLB6yCkZEycnxV5M/ST+HEChyD4ylUCFjrWtYbv8ibcoAVdhMpqSOwT+S15TwoC55aAADnug2hCEIn+dhFZOgyFLw+69bnZCiIR78TkpmI0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733727479; c=relaxed/simple;
	bh=qe6Udq2O6ylQ7lKCDT+058J/wzrj9nl+5v4NIjILIzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VM/HelCmyOaLm9umBGkIM8O5IftiEfnfGwgDVUbr+iuQmZ2zcaiTq9lLhjyDKasGMXOVhDfrg7I/NC+urfMnrBJ/SPDAtCa9ehhFBnTYz2KAF24GmLoZrgvzXThkzO8KzI0ZrJFI/RcM6qC38gqfRvlVDsU9txwyuFpp2481/E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BK+mrXeb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B8MotJN008466;
	Mon, 9 Dec 2024 06:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6vMnIg568BJtA4W/JJ6yBSKxv2h8U/loKiehbM+EH
	Z0=; b=BK+mrXebLKo32XdeUVs2F6OhU0s3/LflbVT0YrqOzjnu2cAnV15xXgd/1
	4/e0UeW+HBzx8CQvDqKsjKk1IuzGpBq8pBldtdA9D5ZUik2pwJVIuqf9fAHpDK6E
	HRwfxyd3/iTjNcW3o+6y3bAVmRKDW0HpsEnBfmTT82W/ofYXU4+Vop6pTbu7mhKj
	u9ha03SxsTMOhxmsYkxVxUOImrEzJG5vgIhVpvh0bGld0kYyOTRVLu8Ga5gbpx1F
	KikVS/lwdOaQhTj8bko8L469TwunhVlNiDt1x62hFSYsIA/uD6jf0gq9Udv5FwBP
	bHd+pE28v2Jnd+6LCcxILNHhwIj6Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x6vxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:57:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4B96m85K005033;
	Mon, 9 Dec 2024 06:57:27 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0x6vx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:57:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B96HbH5032496;
	Mon, 9 Dec 2024 06:57:26 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d1pmwcqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 06:57:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B96vOVP50856424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 06:57:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A3192004B;
	Mon,  9 Dec 2024 06:57:24 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87B0C2004E;
	Mon,  9 Dec 2024 06:57:21 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 06:57:21 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: ast@kernel.org, hbathini@linux.ibm.com, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, mykolal@fb.com, shuah@kernel.org
Subject: [PATCH] selftests/bpf: Fix fill_link_info selftest on powerpc
Date: Mon,  9 Dec 2024 12:27:20 +0530
Message-ID: <20241209065720.234344-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EndXjGVOXSlKrwYrWNmh4Rw4xjAVbk-f
X-Proofpoint-ORIG-GUID: oXQiw0sbMxZ9FHQllso9ETUFqqmEUX7S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=857
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090051

With CONFIG_KPROBES_ON_FTRACE enabled on powerpc, ftrace_location_range
returns ftrace location for bpf_fentry_test1 at offset of 4 bytes from
function entry. This is because branch to _mcount function is at offset
of 4 bytes in function profile sequence.

To fix this, add entry_offset of 4 bytes while verifying the address for
kprobe entry address of bpf_fentry_test1 in verify_perf_link_info in
selftest, when CONFIG_KPROBES_ON_FTRACE is enabled.

Disassemble of bpf_fentry_test1:

c000000000e4b080 <bpf_fentry_test1>:
c000000000e4b080:       a6 02 08 7c     mflr    r0
c000000000e4b084:       b9 e2 22 4b     bl      c00000000007933c <_mcount>
c000000000e4b088:       01 00 63 38     addi    r3,r3,1
c000000000e4b08c:       b4 07 63 7c     extsw   r3,r3
c000000000e4b090:       20 00 80 4e     blr

When CONFIG_PPC_FTRACE_OUT_OF_LINE [1] is enabled, these function profile
sequence is moved out of line with an unconditional branch at offset 0.
So, the test works without altering the offset for
'CONFIG_KPROBES_ON_FTRACE && CONFIG_PPC_FTRACE_OUT_OF_LINE' case.

Disassemble of bpf_fentry_test1:

c000000000f95190 <bpf_fentry_test1>:
c000000000f95190:       00 00 00 60     nop
c000000000f95194:       01 00 63 38     addi    r3,r3,1
c000000000f95198:       b4 07 63 7c     extsw   r3,r3
c000000000f9519c:       20 00 80 4e     blr

[1] https://lore.kernel.org/all/20241030070850.1361304-13-hbathini@linux.ibm.com/

Fixes: 23cf7aa539dc ("selftests/bpf: Add selftest for fill_link_info")
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
 .../selftests/bpf/prog_tests/fill_link_info.c       |  4 ++++
 .../selftests/bpf/progs/test_fill_link_info.c       | 13 ++++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
index d50cbd804..e59af2aa6 100644
--- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
+++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
@@ -171,6 +171,10 @@ static void test_kprobe_fill_link_info(struct test_fill_link_info *skel,
 		/* See also arch_adjust_kprobe_addr(). */
 		if (skel->kconfig->CONFIG_X86_KERNEL_IBT)
 			entry_offset = 4;
+		if (skel->kconfig->CONFIG_PPC64 &&
+		    skel->kconfig->CONFIG_KPROBES_ON_FTRACE &&
+		    !skel->kconfig->CONFIG_PPC_FTRACE_OUT_OF_LINE)
+			entry_offset = 4;
 		err = verify_perf_link_info(link_fd, type, kprobe_addr, 0, entry_offset);
 		ASSERT_OK(err, "verify_perf_link_info");
 	} else {
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index 6afa83475..fac33a14f 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -6,13 +6,20 @@
 #include <stdbool.h>
 
 extern bool CONFIG_X86_KERNEL_IBT __kconfig __weak;
+extern bool CONFIG_PPC_FTRACE_OUT_OF_LINE __kconfig __weak;
+extern bool CONFIG_KPROBES_ON_FTRACE __kconfig __weak;
+extern bool CONFIG_PPC64 __kconfig __weak;
 
-/* This function is here to have CONFIG_X86_KERNEL_IBT
- * used and added to object BTF.
+/* This function is here to have CONFIG_X86_KERNEL_IBT,
+ * CONFIG_PPC_FTRACE_OUT_OF_LINE, CONFIG_KPROBES_ON_FTRACE,
+ * CONFIG_PPC6 used and added to object BTF.
  */
 int unused(void)
 {
-	return CONFIG_X86_KERNEL_IBT ? 0 : 1;
+	return CONFIG_X86_KERNEL_IBT ||
+			CONFIG_PPC_FTRACE_OUT_OF_LINE ||
+			CONFIG_KPROBES_ON_FTRACE ||
+			CONFIG_PPC64 ? 0 : 1;
 }
 
 SEC("kprobe")
-- 
2.45.2


