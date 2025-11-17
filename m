Return-Path: <linux-kselftest+bounces-45716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C56C6278E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 07:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EAE84E1A64
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Nov 2025 06:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366C030DECA;
	Mon, 17 Nov 2025 06:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eOrUM3k0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E591DE4F1;
	Mon, 17 Nov 2025 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763359716; cv=none; b=g+LkxEV9AaqcVtKFkmPdDHopKlK4hTF7DloHVCQhnQ8iR1H0UJ264uvwygXMSjz4mNatq68c4opKoqxoD1JAXwcc3o0JZ9cfmpQu01TlJw4U+F5SHGOy+LtDAFQ5tDxEB/fhaNVSrmeUpwVsOYqykWV4iqxZ40heZSk0vNJimDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763359716; c=relaxed/simple;
	bh=5exeFA4PvWa9zGC34Jv+GN0zgLA37PX93/hZLeLRQho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7jcQCDUlQGs3dCUZa10WJ1eVngFAiuf1S7bpPxs175cBNrSif6P8vcQxQOqmsbLz0/aE3IE/QDFWacfsgIRvwETNK5rjuRNEaGBZXzilgTYAupb6MsKXunn8L0bFvjUvIHi441yxgqyPN6aRFjxJ5/pN09VlQjPKcYgqx4vx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eOrUM3k0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AGNrRW7023733;
	Mon, 17 Nov 2025 06:08:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=Of90jTA9Jm6O+wSu9R8qa7EHyFJq
	DApeDmaEYYYzUJg=; b=eOrUM3k0HmTQ96YShyjzwNy1+64wipyRyPmLROgi2QvF
	rTKgc0DexkFXaYN4NGRPlqSS0PM9DaQ0KfedpnLO8QSO4GMJkG6fIFlHsjq++5bg
	p+CyoIrpiYWnMGDTWsGVEr4qBFkGC7veFeHbf8xpWR4TWKbHZaK7tlLplO9LFCa8
	HNK3fBWcotpmRseCKNVgX90l/69maSebllZk7WCv6QJlGcp7dJWjQ87fuBGl0Urh
	CoORoNqnIEVVupRr/lkI6c5KXA4pshfNZuCBnSi00/7z3JrCBZPPbJfAbn9TcgM1
	Iv6VCWKpJr7YJdjQ0+ffEskk3UMRmwhqjeAlrLm4LQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtmjwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:08:01 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AH66c94013809;
	Mon, 17 Nov 2025 06:08:01 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejjtmjwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:08:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AH2K7YW030778;
	Mon, 17 Nov 2025 06:08:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47xmccv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Nov 2025 06:08:00 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AH67ua937159204
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 06:07:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B81520043;
	Mon, 17 Nov 2025 06:07:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08D2E20040;
	Mon, 17 Nov 2025 06:07:53 +0000 (GMT)
Received: from li-621bac4c-27c7-11b2-a85c-c2bf7c4b3c07.in.ibm.com (unknown [9.109.219.153])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Nov 2025 06:07:52 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: hbathini@linux.ibm.com, sachinpb@linux.ibm.com, venkat88@linux.ibm.com,
        andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Fix htab_update/reenter_update selftest failure
Date: Mon, 17 Nov 2025 11:37:52 +0530
Message-ID: <20251117060752.129648-1-skb99@linux.ibm.com>
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
X-Proofpoint-GUID: xxILBiZnEYgMM_d-xKtle5G55zeeC96H
X-Proofpoint-ORIG-GUID: 4dErHjxhjFCEKGysii-MQbGMkt-bLPCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX19seRaKeOscm
 XwAni5SvrUjJDFOF8YMLWbBbLEWX4cDhHBESwHbGB9IgVV11aWBi8DD5+qM9EjddkW3Aep2/opp
 ucvVgPwHR/Fw4k5Rn+TDIhRYsI1Bd6HP1uumBNtBeB+AZ77xFhhgX+QJsiEbFRcm2xQXeDj58Y7
 EaPLIKxLpkGu7z6Kes92ajKrMfaJ7iQqD3b3y5pbScB6ghYBA+psH4gNTN9ZHGugqOkdN1n4yoI
 b1qCqcs3RtxQIQ5dla09u4jcfD/l2HwtKh0jVWElRKIAoGZGupdNTh4HtWmNX9gF3M+L55gXjtn
 DkfMNhF7YsrSXY5y9Dbe0gW/pmEOuspL/t4Yk0nBVRMNEoTpS3K6J/vn2ZjdEFj5LRW3RO75hcH
 eog4vwD0ARyOXscyLGGTw9SadRB1qw==
X-Authority-Analysis: v=2.4 cv=SvOdKfO0 c=1 sm=1 tr=0 ts=691abbc1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=VtCtHh7gqfizx-1pb5MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511150032

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
Changes since v2:
Addressed CI failures:
* Initialize key to 0 before the first update.
* Used pointer value to pass for update and memset rather than
  &value.

v2: https://lore.kernel.org/all/20251114152653.356782-1-skb99@linux.ibm.com/

Changes since v1:
Addressed comments from Alexei:
* Fixed the scenario where test may fail when lookup_elem_raw()
  is inlined.

v1: https://lore.kernel.org/all/20251106052628.349117-1-skb99@linux.ibm.com/

 .../selftests/bpf/prog_tests/htab_update.c    | 37 ++++++++++++++-----
 .../testing/selftests/bpf/progs/htab_update.c | 19 +++++++---
 2 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/htab_update.c b/tools/testing/selftests/bpf/prog_tests/htab_update.c
index 2bc85f4814f4..d0b405eb2966 100644
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
@@ -33,14 +33,33 @@ static void test_reenter_update(void)
 	if (!ASSERT_OK(err, "htab_update__attach"))
 		goto out;
 
-	/* Will trigger the reentrancy of bpf_map_update_elem() */
+	value_size = bpf_map__value_size(skel->maps.htab);
+
+	value = calloc(1, value_size);
+	if (!ASSERT_OK_PTR(value, "calloc value"))
+		goto out;
+	/*
+	 * First update: plain insert. This should NOT trigger the re-entrancy
+	 * path, because there is no old element to free yet.
+	 */
 	key = 0;
-	value = 0;
-	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, &value, 0);
-	if (!ASSERT_OK(err, "add element"))
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, value, BPF_ANY);
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
+	memset(value, 0, value_size);
+	err = bpf_map_update_elem(bpf_map__fd(skel->maps.htab), &key, value, BPF_ANY);
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


