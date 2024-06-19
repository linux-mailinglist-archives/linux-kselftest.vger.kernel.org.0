Return-Path: <linux-kselftest+bounces-12184-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85C490E05F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72FBE2832BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 00:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6607B23A8;
	Wed, 19 Jun 2024 00:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="o2j3NCQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4446193;
	Wed, 19 Jun 2024 00:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718755535; cv=none; b=AZSZct0KKcuUNndRSBpJfZ4VUBgnOVciR7Z/Ud4obIH8UqiUWPSAEMesNyDjFXHNf3MfuvkpoHkvqlnBgJ1FociiPzzNZTmkCYE2A9Z/ArsNENQxUhEoY7TnJmCRNFXAh4N45tVw5XuIPe04xzinmWwQgZVoynqMC6NpWkRqh0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718755535; c=relaxed/simple;
	bh=3rFLb8JSB4SyXYfQa9wLnefBGieNG3xQZFmGCShvn4Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=o0JoOhy7tOnL7luS3PWhdPrX3pPWtJIDy9/GMjvGbFe3fL9fG9fcZ7NkVuWN+ElLfYsko5gXzxk/qmaKbCu+azjvLp+nq5VHdDZvcvJP/i/HnT+5U3Mw+R3eoMoXsk6XS4AuRlbKaaEa+FPmAnV6LFD0d9wksgvD/Q+ho07kfsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=o2j3NCQE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ILb6Xo000504;
	Wed, 19 Jun 2024 00:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iMkszGdm9ae/n7pRpO/rrT8MarQ3LgEe54I6kubPvLI=; b=o2j3NCQEJTFU2hZA
	IcfJBRdS+w2hLNTSnVEQqnCk6AXpZRPDzzyjWU3587KuuQzZLw5I/0tOLUNVu6UP
	Rs6j0xFWBjkFJmhUD+PeP0g9pvohDo5Y8d2hN4+BOXp6oLp/9rFH5UWggdClLz25
	rRhoaL7pj6CoQXuGDGoeGiDlQlUrTPKq5n4fqNiF4XWg7fYW2lZIs0xabEKlei/F
	fubw4xm7gCPQsE4bGTlJ+UpHrkc22hnsqi5ae6AcKEp8m+Dmg7hgq2ReUMYGqtoV
	N2eCzPir57qdth9XiRT9nDGlGmmenoIIk2FhV/utsVba60mRmieP4CfYuSeG0BnC
	WXrfVg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yujag07ba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45J05IcW029972
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 00:05:18 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 18 Jun 2024 17:05:18 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Tue, 18 Jun 2024 17:05:11 -0700
Subject: [PATCH RFC 5/5] mm/gup_test: Verify GUP grabs same pages twice
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240618-exclusive-gup-v1-5-30472a19c5d1@quicinc.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
In-Reply-To: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, <maz@kernel.org>
CC: <kvm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>, <pbonzini@redhat.com>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: unhDqPMZarSEVc31r4x6VcJKNGdRtYup
X-Proofpoint-ORIG-GUID: unhDqPMZarSEVc31r4x6VcJKNGdRtYup
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_06,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxlogscore=880 bulkscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406180176

GUP'ing pages should get the same pages, test it. In case of
FOLL_EXCLUSIVE, the second pin should fail to get any pages.

Note: this change ought to be refactored to pull out the GUP'ing bits
that's duplicated between the original and the second GUP.

Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 mm/gup_test.c                         | 86 +++++++++++++++++++++++++++++++++++
 mm/gup_test.h                         |  1 +
 tools/testing/selftests/mm/gup_test.c |  5 +-
 3 files changed, 91 insertions(+), 1 deletion(-)

diff --git a/mm/gup_test.c b/mm/gup_test.c
index 9c6b8c93e44a7..28cc422b60b78 100644
--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -86,6 +86,89 @@ static void verify_exclusive_pinned(unsigned int gup_flags, struct page **pages,
 	}
 }
 
+static int verify_gup_twice(unsigned int cmd, struct gup_test *gup,
+			    struct page **expected_pages,
+			    unsigned long expected_nr_pages)
+{
+	unsigned long i, nr_pages, addr, next;
+	long nr;
+	struct page **pages __free(kfree) = NULL;
+	int ret = 0;
+
+	nr_pages = gup->size / PAGE_SIZE;
+	pages = kvcalloc(nr_pages, sizeof(void *), GFP_KERNEL);
+	if (!pages)
+		return -ENOMEM;
+
+	i = 0;
+	nr = gup->nr_pages_per_call;
+	for (addr = gup->addr; addr < gup->addr + gup->size; addr = next) {
+		if (nr != gup->nr_pages_per_call)
+			break;
+
+		next = addr + nr * PAGE_SIZE;
+		if (next > gup->addr + gup->size) {
+			next = gup->addr + gup->size;
+			nr = (next - addr) / PAGE_SIZE;
+		}
+
+		switch (cmd) {
+		case GUP_FAST_BENCHMARK:
+			nr = get_user_pages_fast(addr, nr, gup->gup_flags,
+						 pages + i);
+			break;
+		case GUP_BASIC_TEST:
+			nr = get_user_pages(addr, nr, gup->gup_flags, pages + i);
+			break;
+		case PIN_FAST_BENCHMARK:
+			nr = pin_user_pages_fast(addr, nr, gup->gup_flags,
+						 pages + i);
+			break;
+		case PIN_BASIC_TEST:
+			nr = pin_user_pages(addr, nr, gup->gup_flags, pages + i);
+			break;
+		case PIN_LONGTERM_BENCHMARK:
+			nr = pin_user_pages(addr, nr,
+					    gup->gup_flags | FOLL_LONGTERM,
+					    pages + i);
+			break;
+		default:
+			pr_err("cmd %d not supported for %s\n", cmd, __func__);
+			return -EINVAL;
+		}
+
+		if (nr <= 0)
+			break;
+		i += nr;
+	}
+
+	nr_pages = i;
+
+	if (gup->gup_flags & FOLL_EXCLUSIVE) {
+		if (WARN(nr_pages,
+			 "Able to acquire exclusive pin twice for %ld of %ld pages",
+			 nr_pages, expected_nr_pages)) {
+			dump_page(pages[0],
+				  "gup_test: verify_gup_twice() test");
+			ret = -EIO;
+		}
+	} else if (nr_pages != expected_nr_pages) {
+		pr_err("%s: Expected %ld pages, got %ld\n", __func__,
+		       expected_nr_pages, nr_pages);
+		ret = -EIO;
+	} else {
+		for (i = 0; i < nr_pages; i++) {
+			if (WARN(pages[i] != expected_pages[i],
+				 "pages[%lu] mismatch\n", i))
+				break;
+		}
+	}
+
+	put_back_pages(cmd, pages, nr_pages, gup->test_flags);
+
+	return ret;
+}
+
 static void dump_pages_test(struct gup_test *gup, struct page **pages,
 			    unsigned long nr_pages)
 {
@@ -210,6 +293,9 @@ static int __gup_test_ioctl(unsigned int cmd,
 	if (cmd == DUMP_USER_PAGES_TEST)
 		dump_pages_test(gup, pages, nr_pages);
 
+	if (gup->test_flags & GUP_TEST_FLAG_GUP_TWICE)
+		ret = verify_gup_twice(cmd, gup, pages, nr_pages);
+
 	start_time = ktime_get();
 
 	put_back_pages(cmd, pages, nr_pages, gup->test_flags);
diff --git a/mm/gup_test.h b/mm/gup_test.h
index 5b37b54e8bea6..fcd41919b0159 100644
--- a/mm/gup_test.h
+++ b/mm/gup_test.h
@@ -17,6 +17,7 @@
 #define GUP_TEST_MAX_PAGES_TO_DUMP		8
 
 #define GUP_TEST_FLAG_DUMP_PAGES_USE_PIN	0x1
+#define GUP_TEST_FLAG_GUP_TWICE			0x2
 
 struct gup_test {
 	__u64 get_delta_usec;
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index bdeaac67ff9aa..b4b10c8338f80 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -98,7 +98,7 @@ int main(int argc, char **argv)
 	pthread_t *tid;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:tTLUuwWSHpz")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:dtTLUuwWSHpz")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -172,6 +172,9 @@ int main(int argc, char **argv)
 			/* fault pages in gup, do not fault in userland */
 			touch = 1;
 			break;
+		case 'd':
+			gup.test_flags |= GUP_TEST_FLAG_GUP_TWICE;
+			break;
 		default:
 			ksft_exit_fail_msg("Wrong argument\n");
 		}

-- 
2.34.1


