Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A7778474
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Aug 2023 02:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHKAHu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Aug 2023 20:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjHKAHu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Aug 2023 20:07:50 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92504FD;
        Thu, 10 Aug 2023 17:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691712460;
        bh=AYyH4FOO/VIrSq+SDBQ9ZbyN9SODJ2goYLvhKL3Mw20=;
        h=From:To:Cc:Subject:Date;
        b=QbBIFmm+bV9cRztFMn14LXPJcl5nB+YfibkiBTh7gn5AXlLWQ4G32rvQTKKARoDFS
         VR+v/z1ig6DpPP0EKaEJLwoIKiIcmUJdxvs5oieA5klk5YkX9tr41eWBvBS/U8pyZK
         gMXjUfWIW+59siBv9hhdJqrmUkuC3PZPt8PCwue0=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id D958B698; Fri, 11 Aug 2023 07:54:21 +0800
X-QQ-mid: xmsmtpt1691711661tkkupw841
Message-ID: <tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com>
X-QQ-XMAILINFO: MFdGPHhuqhNoD+8K/Ve4A6yyZK7J1hWB4CtBFqXpFB5TeNVpIgNKlQIuNp27xS
         /vdkpaHhuKwzgOwU+GB/1Kb6bqoxOm71kSkgB0wUrohJ8jvigoZ8KNsOUm+nKhyymsW0EkZDGEFS
         ZpXa7NZRtIT+1znj31GaAc67iWwkl+qD/G4qdKCC6RDhLAE1QwM90qTj2fhwWPQNc1bKFXREAHpc
         s3fNPwaoFj1pbo/y5/8479JeZMvxq+Q53kQNsJFyG/lQ7wbsMWJxUEB0xk+Kl5ueOe/1TrPdPr6f
         93YnjDPFDcIs+SQCfVcpNOvw21iJqPhapDjUnflvv/2/S8naxja5eh3CvSzBriiNNQKh5EpeCcSx
         RdGK+ujYyC2Zn7N0LoSpZL6sKTdaBpcyL11VP7O9FXx6K+p+gF2/wDRkaI2FTXz8FRlbcbASvcWR
         eSaIl36y6pYXFLEnB9Vrf1PAQusXvuuTFWxK9rAMw5klbOSOiKBbmv5h3hcHjJlmvZRwPv0BKTGW
         c/kETO8muw6Y15VL3jakGdsRTwiMLG2HZBsguWE2Ik4EPkSFu9TxB5bepAdSH/9cLzqb69OtEPEa
         bB9Yk2ppNXpTCT+Kcs7PO3odn4IZb70GzW3yU+rFV1itZ0ZqRs+fYTaqzVOeKq8+gYwnl7xugOyK
         EPC1EdzxqzIsDmzEjI7rWHLeFy5AFtP01X69luy3yVAUxc1iq8Wzpy1wKSb6NDdfzSVBAitVPZ6x
         sz3hknQosZ4bot3dXZnzkTZWZMOvnCn1xrP9phvh5rBBt9pPSrTc4GASxjitXIM3eUpSpeeXsG0O
         qLopTvkl5zMgijMvt+oB/ogbvkXbb0V71SSB9RYtyEUCuB0QIwmHhEH78UKDuU0JKc+u5tOOFu6k
         CRLl9D22AeHkzGOP3OmA1gQP0t8mR7kSoJuV/jh6/dau5EbOZKOcm8SV+X+71Ubi+OJ1WT1YSqDl
         eL4RRnwBs+SjhR5o6adlj+y2RVEYCKMkm6W93yYQA=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     rongtao@cestc.cn, Andrii Nakryiko <andrii@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [SELFTESTS] (Test Runners &
        Infrastructure)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v2] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Fri, 11 Aug 2023 07:54:19 +0800
X-OQ-MSGID: <20230810235420.297758-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        T_SPF_HELO_TEMPERROR,T_SPF_TEMPERROR,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

Static ksyms often have problems because the number of symbols exceeds the
MAX_SYMS limit. Like changing the MAX_SYMS from 300000 to 400000 in
commit e76a014334a6("selftests/bpf: Bump and validate MAX_SYMS") solves
the problem somewhat, but it's not the perfect way.

This commit uses dynamic memory allocation, which completely solves the
problem caused by the limitation of the number of kallsyms.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v2: Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 tools/testing/selftests/bpf/trace_helpers.c | 73 ++++++++++++++-------
 1 file changed, 48 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..cda5a2328450 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,9 +18,37 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
-static int sym_cnt;
+static struct {
+	struct ksym *syms;
+	unsigned int sym_cap;
+	unsigned int sym_cnt;
+} ksyms = {
+	.syms = NULL,
+	.sym_cap = 1024,
+	.sym_cnt = 0,
+};
+
+static int ksyms__add_symbol(const char *name, unsigned long addr)
+{
+	void *tmp;
+	unsigned int new_cap;
+
+	if (ksyms.sym_cnt + 1 > ksyms.sym_cap) {
+		new_cap = ksyms.sym_cap * 4 / 3;
+		tmp = realloc(ksyms.syms, sizeof(struct ksym) * new_cap);
+		if (!tmp)
+			return -ENOMEM;
+		ksyms.syms = tmp;
+		ksyms.sym_cap = new_cap;
+	}
+
+	ksyms.syms[ksyms.sym_cnt].addr = addr;
+	ksyms.syms[ksyms.sym_cnt].name = strdup(name);
+
+	ksyms.sym_cnt++;
+
+	return 0;
+}
 
 static int ksym_cmp(const void *p1, const void *p2)
 {
@@ -33,9 +61,10 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
 
-	sym_cnt = 0;
+	ksyms.syms = malloc(sizeof(struct ksym) * ksyms.sym_cap);
+	if (!ksyms.syms)
+		return -ENOMEM;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,16 +75,10 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
-
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ksyms__add_symbol(func, (unsigned long)addr);
 	}
 	fclose(f);
-	sym_cnt = i;
-	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
+	qsort(ksyms.syms, ksyms.sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
 }
 
@@ -65,48 +88,48 @@ int load_kallsyms(void)
 	 * This is called/used from multiplace places,
 	 * load symbols just once.
 	 */
-	if (sym_cnt)
+	if (ksyms.sym_cnt)
 		return 0;
 	return load_kallsyms_refresh();
 }
 
 struct ksym *ksym_search(long key)
 {
-	int start = 0, end = sym_cnt;
+	int start = 0, end = ksyms.sym_cnt;
 	int result;
 
 	/* kallsyms not loaded. return NULL */
-	if (sym_cnt <= 0)
+	if (ksyms.sym_cnt <= 0)
 		return NULL;
 
 	while (start < end) {
 		size_t mid = start + (end - start) / 2;
 
-		result = key - syms[mid].addr;
+		result = key - ksyms.syms[mid].addr;
 		if (result < 0)
 			end = mid;
 		else if (result > 0)
 			start = mid + 1;
 		else
-			return &syms[mid];
+			return &ksyms.syms[mid];
 	}
 
-	if (start >= 1 && syms[start - 1].addr < key &&
-	    key < syms[start].addr)
+	if (start >= 1 && ksyms.syms[start - 1].addr < key &&
+	    key < ksyms.syms[start].addr)
 		/* valid ksym */
-		return &syms[start - 1];
+		return &ksyms.syms[start - 1];
 
 	/* out of range. return _stext */
-	return &syms[0];
+	return &ksyms.syms[0];
 }
 
 long ksym_get_addr(const char *name)
 {
 	int i;
 
-	for (i = 0; i < sym_cnt; i++) {
-		if (strcmp(syms[i].name, name) == 0)
-			return syms[i].addr;
+	for (i = 0; i < ksyms.sym_cnt; i++) {
+		if (strcmp(ksyms.syms[i].name, name) == 0)
+			return ksyms.syms[i].addr;
 	}
 
 	return 0;
-- 
2.39.3

