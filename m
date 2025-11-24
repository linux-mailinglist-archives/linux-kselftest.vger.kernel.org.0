Return-Path: <linux-kselftest+bounces-46384-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C25C8081A
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 13:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9A953465BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Nov 2025 12:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858E93002DA;
	Mon, 24 Nov 2025 12:39:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723703002A3;
	Mon, 24 Nov 2025 12:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763987969; cv=none; b=dNTaHqpIy0DWY8Yjc4qM1G6en00SvMpV9lKbgbf3AQQYcIUsbqfM1CjH8DQk4Pg18Bwzj/hMThhiVz1Qs0AgznOz/RXQ0ncEen1gT9TZU1gUNU9IuGfXWvSeOE4xzoJKNunb/zS8DVTXXw6e/uqUuQrPCyXvm9RKxL47fI1gZuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763987969; c=relaxed/simple;
	bh=szqf3Kx+BUT+AouG3NOcTxdXuFk3oM/DtXY+gzj1CM4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCbsBG7U4TPEgkUtn204W+vkVdwW/WY44BGTgwiH3XCor8uYaSWIOjCeZ8MkLRvrJ5ji7BQ3+PnSD+u6lsNUIYAJ0dogUva/aRbfDYmrKqwBjQi5mdIUMF3vNP+CDjY/m5JPbHquAaXoeL5yQp13bhR3KD+KVLR6ymB4V3iAU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 98483984c93211f0a38c85956e01ac42-20251124
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_TXT, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_EXISTED
	SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:42b03b5e-27eb-45ad-9959-30113448a8c4,IP:10,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:0
X-CID-INFO: VERSION:1.3.6,REQID:42b03b5e-27eb-45ad-9959-30113448a8c4,IP:10,URL
	:0,TC:0,Content:-5,EDM:0,RT:0,SF:-5,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:fbe2a9042fa2bbbafeb5aba0e34aac7c,BulkI
	D:251124203921M1CZFT1B,BulkQuantity:0,Recheck:0,SF:17|19|38|66|78|81|82|10
	2|127|850|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bu
	lk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 98483984c93211f0a38c85956e01ac42-20251124
X-User: zhangguopeng@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhangguopeng@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 149211058; Mon, 24 Nov 2025 20:39:18 +0800
From: Guopeng Zhang <zhangguopeng@kylinos.cn>
To: tj@kernel.org,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	mkoutny@suse.com,
	muchun.song@linux.dev
Cc: lance.yang@linux.dev,
	shuah@kernel.org,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guopeng Zhang <zhangguopeng@kylinos.cn>
Subject: [PATCH v4 1/3] selftests: cgroup: Add cg_read_key_long_poll() to poll a cgroup key with retries
Date: Mon, 24 Nov 2025 20:38:14 +0800
Message-Id: <20251124123816.486164-2-zhangguopeng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
References: <20251124123816.486164-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a new helper function `cg_read_key_long_poll()` in cgroup_util.h.
This function polls the specified key in a cgroup file until it matches the expected
value or the retry limit is reached, with configurable wait intervals between retries.

This helper is particularly useful for handling asynchronously updated cgroup statistics
(e.g., memory.stat), where immediate reads may observe stale values, especially on busy systems.
It allows tests and other utilities to handle such cases more flexibly.

Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
Suggested-by: Michal Koutný <mkoutny@suse.com>
---
 .../selftests/cgroup/lib/cgroup_util.c        | 21 +++++++++++++++++++
 .../cgroup/lib/include/cgroup_util.h          |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
index 44c52f620fda..953835f5da66 100644
--- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
+++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
@@ -168,6 +168,27 @@ long cg_read_key_long(const char *cgroup, const char *control, const char *key)
 	return atol(ptr + strlen(key));
 }
 
+long cg_read_key_long_poll(const char *cgroup, const char *control,
+                             const char *key, long expected, int retries,
+                             useconds_t wait_interval_us)
+{
+        long val = -1;
+        int i;
+
+        for (i = 0; i < retries; i++) {
+                val = cg_read_key_long(cgroup, control, key);
+                if (val < 0)
+                        return val;
+
+                if (val == expected)
+                        break;
+
+                usleep(wait_interval_us);
+        }
+
+        return val;
+}
+
 long cg_read_lc(const char *cgroup, const char *control)
 {
 	char buf[PAGE_SIZE];
diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
index 7ab2824ed7b5..772f5383ddc7 100644
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
+		  const char *key, long expected, int retries,
+		  useconds_t wait_interval_us);
 extern long cg_read_lc(const char *cgroup, const char *control);
 extern int cg_write(const char *cgroup, const char *control, char *buf);
 extern int cg_open(const char *cgroup, const char *control, int flags);
-- 
2.25.1


