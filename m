Return-Path: <linux-kselftest+bounces-45651-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F25AC5DEBF
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id F06EE20052
	for <lists+linux-kselftest@lfdr.de>; Fri, 14 Nov 2025 15:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF86C32D7FC;
	Fri, 14 Nov 2025 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FKuE8306"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B0132C94F;
	Fri, 14 Nov 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763134068; cv=none; b=aPZDhs6gwvvmhhqFkmvK9OHJvsyI9fvvyZwQ1hY8v3vTxbbadanB1i4FXEwMVZXOAvqzF3+e8F+Y2dtm8EcCPRhVXzkTPsizimIq+2GnVPsATI70LfFCoTaLZl9E2OGa0+vKQPbI94ca0Pmnalb+77/IisjmwaKVr47Hhy4/YKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763134068; c=relaxed/simple;
	bh=NIUEqizwog69PtK/Ivh6wwK/p+ljJCckrpyJJjfVuo4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NQjmzmRixfCp4i0Eq647KRnayN1J+QF3LlYGL992AKr/QgMAGAQW2uMdNsLQj8mSPa7EVQgDgWisz1ooBpUuxItT8J0WRLYoTHHqFAbn+1PAyGH9W/tUwg5ba1mtK81fZBzCH2sPNWqKmJ0Jxy2xTEr7+nQlOr+BoWx3tCQROV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FKuE8306; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEDt58c032654;
	Fri, 14 Nov 2025 15:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=2Fqj906GjlMjAlLgzD4pKgJIN2dw
	RMppQ/s7YfSh8nM=; b=FKuE8306d86rR56CtPu7/cET0i37Sz1CRLaz3QSCDIuV
	qyKe3xmVOgAKSlfIsNt+0UT0TuwVkJ1CX8VBrXAsFSbZYKwgL641b/VJJWAkIpLG
	YTOtigyp9hDno144J7F+zPDMdOHUMJWy8SXy4O4jKI/uizPjXENTkWcPDbQnC5dl
	ei8xy2/khntC2XBOtYhdnK/dxPuhqywZzsCqIFfMP3Hn37bViEohV5v3LXP9fAOT
	AbmB/GpdEoDbiq8LZSNnLqSvTtkPKSuyOxyvURdf23Bn+SSw0bSCJSFiiONkI57X
	qEXhO0v+5FNlKORdkH5WtEZW4n2RzKO7Gxqx/2zQ+w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adreek83t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 15:27:10 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AEFR9sB030042;
	Fri, 14 Nov 2025 15:27:09 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4adreek83p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 15:27:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AEFQv1J007375;
	Fri, 14 Nov 2025 15:27:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4aajdjusqp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 15:27:08 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AEFR4iV31850822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 15:27:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A1E2004B;
	Fri, 14 Nov 2025 15:27:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B57F20040;
	Fri, 14 Nov 2025 15:26:56 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.ibm.com.com (unknown [9.43.106.27])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Nov 2025 15:26:56 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Fix htab_update/reenter_update selftest failure
Date: Fri, 14 Nov 2025 20:56:53 +0530
Message-ID: <20251114152653.356782-1-skb99@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEzMDE3OSBTYWx0ZWRfX4KpgJtGqpyGf
 m5ZNQd8A/688UWenYdvz8rUk+xdpmhJ4+nTleUKp4IqBQQhpjx/DdRsyLXPGp01fVP0w2tEyVIc
 KZ1MZ4cM9mZqBSA7ZfSWXXVSiKw7+W+oJGO1KboEdg3Difj6Vy4oxHOxJJir4hvp0VhgHa1lt65
 YBxhPGyNWlFh0CWVr0hriquulYlwrFqN/Qtn5bNj0iqVE7U4zEiW0ksTU4Rpv0MlvWmAueTwK+e
 evkbjvTAb1k045z26SnPje9uNVNEEYlhIlwIVgJfPMtfIUgFnAFF/9KeBEJhDcdKgiy1UhwsFuN
 ODBvzuFYRLEPEcBeiwTMRctsP03umi1KARnSzdNcUqrincKZO52na2Fi8jsXJYFNZsf5G1FLH1A
 wSANvqdrykvj9r2i2uUNvHRb5FO+qA==
X-Proofpoint-ORIG-GUID: K6NxuYnrRqbLt1gHrS6G-K_cO0hT9tUX
X-Authority-Analysis: v=2.4 cv=HIrO14tv c=1 sm=1 tr=0 ts=69174a4e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=OWyWG0mZGF1_bIHabSUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: NzijLG-N19HbQwnSD8esOD7Svoaekl4u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511130179

Since commit 31158ad02ddb ("rqspinlock: Add deadlock detection
and recovery") the updated path on re-entrancy now reports deadlock
via -EDEADLK instead of the previous -EBUSY.

Also, the way reentrancy was exercised (via fentry/lookup_elem_raw)
has been fragile because lookup_elem_raw may be inlined
(find_kernel_btf_id() will return -ESRCH).

To fix this fentry is attached to bpf_obj_free_fields() instead of
lookup_elem_raw() and:

- The htab map is made to use a BTF-described struct val with a
  struct bpf_timer so that check_and_free_fields() reliably calls
  bpf_obj_free_fields() on element replacement.

- The selftest is updated to do two updates to the same key (insert +
  replace) in prog_test.

- The selftest is updated to align with expected errno with the
  kernel’s current behavior.

Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
---
Changes since v1:
Addressed comments from Alexei:
* Fixed the scenario where test may fail when lookup_elem_raw()
  is inlined.

v1: https://lore.kernel.org/all/20251106052628.349117-1-skb99@linux.ibm.com/

 .../selftests/bpf/prog_tests/htab_update.c    | 38 ++++++++++++++-----
 .../testing/selftests/bpf/progs/htab_update.c | 19 +++++++---
 2 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index 2bc85f4814f4..96b65c1a321a 100644
--- a/tools/testing/selftests/bpf/prog_tests/htab_update.c
+++ b/tools/testing/selftests/bpf/prog_tests/htab_update.c
@@ -15,17 +15,17 @@ struct htab_update_ctx {
 static void test_reenter_update(void)
 {
 	struct htab_update *skel;
-	unsigned int key, value;
+	void *value = NULL;
+	unsigned int key, value_size;
 	int err;
 
 	skel = htab_update__open();
 	if (!ASSERT_OK_PTR(skel, "htab_update__open"))
 		return;
 
-	/* lookup_elem_raw() may be inlined and find_kernel_btf_id() will return -ESRCH */
-	bpf_program__set_autoload(skel->progs.lookup_elem_raw, true);
+	bpf_program__set_autoload(skel->progs.bpf_obj_free_fields, true);
 	err = htab_update__load(skel);
-	if (!ASSERT_TRUE(!err || err == -ESRCH, "htab_update__load") || err)
+	if (!ASSERT_TRUE(!err, "htab_update__load") || err)
 		goto out;
 
 	skel->bss->pid = getpid();
@@ -33,14 +33,32 @@ static void test_reenter_update(void)
 	if (!ASSERT_OK(err, "htab_update__attach"))
 		goto out;
 
-	/* Will trigger the reentrancy of bpf_map_update_elem() */
-	key = 0;
-	value = 0;
-	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
-	if (!ASSERT_OK(err, "add element"))
+	value_size = bpf_map__value_size(skel->maps.htab);
+
+	value = calloc(1, value_size);
+	if (!ASSERT_OK_PTR(value, "calloc value"))
+		goto out;
+	/*
+	 * First update: plain insert. This should NOT trigger the re-entrancy
+	 * path, because there is no old element to free yet.
+	 */
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
+	if (!ASSERT_OK(err, "first update (insert)"))
+		goto out;
+
+	/*
+	 * Second update: replace existing element with same key and trigger
+	 * the reentrancy of bpf_map_update_elem().
+	 * check_and_free_fields() calls bpf_obj_free_fields() on the old
+	 * value, which is where fentry program runs and performs a nested
+	 * bpf_map_update_elem(), triggering -EDEADLK.
+	 */
+	memset(&value, 0, sizeof(value));
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, BPF_ANY);
+	if (!ASSERT_OK(err, "second update (replace)"))
 		goto out;
 
-	ASSERT_EQ(skel->bss->update_err, -EBUSY, "no reentrancy");
+	ASSERT_EQ(skel->bss->update_err, -EDEADLK, "no reentrancy");
 out:
 	htab_update__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/htab_update.c b/tools/testing/selftests/bpf/progs/htab_update.c
index 7481bb30b29b..195d3b2fba00 100644
--- a/tools/testing/selftests/bpf/progs/htab_update.c
+++ b/tools/testing/selftests/bpf/progs/htab_update.c
@@ -6,24 +6,31 @@
 
 char _license[] SEC("license") = "GPL";
 
+/* Map value type: has BTF-managed field (bpf_timer) */
+struct val {
+	struct bpf_timer t;
+	__u64 payload;
+};
+
 struct {
 	__uint(type, BPF_MAP_TYPE_HASH);
 	__uint(max_entries, 1);
-	__uint(key_size, sizeof(__u32));
-	__uint(value_size, sizeof(__u32));
+	__type(key, __u32);
+	__type(value, struct val);
 } htab SEC(".maps");
 
 int pid = 0;
 int update_err = 0;
 
-SEC("?fentry/lookup_elem_raw")
-int lookup_elem_raw(void *ctx)
+SEC("?fentry/bpf_obj_free_fields")
+int bpf_obj_free_fields(void *ctx)
 {
-	__u32 key = 0, value = 1;
+	__u32 key = 0;
+	struct val value = { .payload = 1 };
 
 	if ((bpf_get_current_pid_tgid() >> 32) != pid)
 		return 0;
 
-	update_err = bpf_map_update_elem(&htab, &key, &value, 0);
+	update_err = bpf_map_update_elem(&htab, &key, &value, BPF_ANY);
 	return 0;
 }
-- 
2.51.0


