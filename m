Return-Path: <linux-kselftest+bounces-46935-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA91C9EE98
	for <lists+linux-kselftest@lfdr.de>; Wed, 03 Dec 2025 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4EBB34ACA8
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Dec 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8AB2F6162;
	Wed,  3 Dec 2025 11:57:25 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF37C2F1FD3;
	Wed,  3 Dec 2025 11:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764763045; cv=none; b=gRbFNj+vaUnKwAg5PposSOqKb91b/TK6qP1HdgJF2tNf/OgA6ir1UpJor3teH1TIUYCzFxo4BefrXwCT8sUxuXG/YhcOyC3qQWDMbTIhAvZVHmjaesHsrFWL6F9I4M8C+yXsf1Ju9CwsNlKyRod9YrLhvJckdTjYn7XB86U0Voc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764763045; c=relaxed/simple;
	bh=t5tVRa58eTUEv31wXUb5KqA4duBG0xhFhUj0ZwnvVMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZEs/8mP3uhVk8kbK680YKy2KsimdT64wfb6Ml1xS7nQdY3RequUxDJWGH9WwGNw1S3WexfS7/Yfb8MAzmtbFZrr0ezkKqDCxHxSYAG+Htm4Xrgd8xwXw9gHYYXqgHQHxctCiJCtMPxgGSwfeLWmVtE1cl97mOqb9ULZhRtrJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 32c2b594d03f11f0a38c85956e01ac42-20251203
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:9b517952-cf82-42c9-8929-cfe76af86642,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:9b517952-cf82-42c9-8929-cfe76af86642,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:2c81f6f184124145c3e33436ac1623b1,BulkI
	D:2512031957120TJFA92I,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 32c2b594d03f11f0a38c85956e01ac42-20251203
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.160.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 404167327; Wed, 03 Dec 2025 19:57:10 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	shuah@kernel.org,
	roman.gushchin@linux.dev,
	lance.yang@linux.dev,
	shakeel.butt@linux.dev
Cc: muchun.song@linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v5 1/3] selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key with retries
Date: Wed,  3 Dec 2025 19:56:29 +0800
Message-Id: <20251203115631.947908-2-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
References: <20251203115631.947908-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new helper function `cg_read_key_long_poll()` in
cgroup_util.h. This function polls the specified key in a cgroup file
until it matches the expected value or the retry limit is reached,
with configurable wait intervals between retries.

This helper is particularly useful for handling asynchronously updated
cgroup statistics (e.g., memory.stat), where immediate reads may
observe stale values, especially on busy systems. It allows tests and
other utilities to handle such cases more flexibly.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Suggested-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 .../selftests/cgroup/lib/cgroup_util.c        | 21 +++++++++++++++++++
 .../cgroup/lib/include/cgroup_util.h          |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 44c52f620fda..ce6c2642fd9b 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -168,6 +168,27 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 	return atol(ptr + strlen(key));
 }
 
+long cg_read_key_long_poll(const char *cgroup, const char *control,
+			   const char *key, long expected, int retries,
+			   useconds_t wait_interval_us)
+{
+	long val = -1;
+	int i;
+
+	for (i = 0; i < retries; i++) {
+		val = cg_read_key_long(cgroup, control, key);
+		if (val < 0)
+			return val;
+
+		if (val == expected)
+			break;
+
+		usleep(wait_interval_us);
+	}
+
+	return val;
+}
+
 long cg_read_lc(const char *cgroup, const char *control)
 {
 	char buf[PAGE_SIZE];
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 7ab2824ed7b5..77f386dab5e8 100644
--- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
+++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
@@ -17,6 +17,8 @@
 #define CG_NAMED_NAME "selftest"
 #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
 
+#define DEFAULT_WAIT_INTERVAL_US (100 * 1000) /* 100 ms */
+
 /*
  * Checks if two given values differ by less than err% of their sum.
  */
@@ -64,6 +66,9 @@ extern int cg_read_strstr(const char *cgroup, const char *control,
 extern long cg_read_long(const char *cgroup, const char *control);
 extern long cg_read_long_fd(int fd);
 long cg_read_key_long(const char *cgroup, const char *control, const char *key);
+long cg_read_key_long_poll(const char *cgroup, const char *control,
+			   const char *key, long expected, int retries,
+			   useconds_t wait_interval_us);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
-- 
2.25.1


