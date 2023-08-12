Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830B9779D6C
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Aug 2023 07:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjHLF6i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 12 Aug 2023 01:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbjHLF6h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 12 Aug 2023 01:58:37 -0400
X-Greylist: delayed 139453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Aug 2023 22:58:35 PDT
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906D7127;
        Fri, 11 Aug 2023 22:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691819908;
        bh=6k+2tlcHY6MZU1kfTY6UiFMgENXZRojososrfddZu4I=;
        h=From:To:Cc:Subject:Date;
        b=ZmB3cJWBDsyHZM7BhMd1wkOWXlDefme40o0ikENygQfXQeg7cep7Xv03D0kVhPgig
         fGwsnlE1yKkC4fIvFAgD+s4pMcuTYRfQLifCat40X8UgT+ieDlmQzClquf4kfarpwC
         9qyd9xXzDR45PXg9P/rCypFZJQQcAGfJtjTJwknY=
Received: from localhost.localdomain ([183.197.149.136])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id E97B6647; Sat, 12 Aug 2023 13:58:23 +0800
X-QQ-mid: xmsmtpt1691819903tjj8co8sd
Message-ID: <tencent_89AF48A3CA88040670422959BB97062A2408@qq.com>
X-QQ-XMAILINFO: NcdhUYIpzyYIKndtqfunD+qyjoV23avozVjtyniOAOQzyWGfkdOsh1PmlHRmZu
         1a8cOYp2BUT3DL2R/dnbDneIQKH/79sLWHSf+DeWPx5R4fp9Icm9mr4agJYzd5b/aq94swhGCDHx
         YH5gyo/z+Lrdffh4/VOdadR4mG1F01UHOGTYbE8waE9DHSuyCnU3xJrHCYyv/unwhIFsexjgTjRm
         4+QGzFPPLfQsN22fm4H5kgtv0HFtgkUGIt2Crmd1txPC0A9f+M4zNsid55FLS5GynOjLRAiW72+D
         f+wjMNYKF7KTz33cjgptIMCI+nfBjG0zJpMuPXWzXZC/ykaOJRtc8gCmiXuxw4Bz99Xgb9tTj65U
         pNsSYC8fuiuyK6fqgepnn/F7EtWqpuRMavZj1bL5j+yp3L9rZ0IoS7wSuAgn5Z1SihX0ghICvey5
         BEIW/IsNfGu7UXSg+isDWZ3NbZdvYsx/wdOLdqT6vNxVw8wJrGZfKFEemXSH3MsV7fF6nCBtELvH
         hp01wbipUxw0nU5uqTjiIdCVpo5GKNHzeP/hL2N4hOCe77qO9HQnfMUaiw0PhqJDN+7p1pexaIm2
         DjHspo2BL/HVTxtDSZG2YkUt3lx1RFM48nw5GNmTyg4SKOnehALJ6RQraauW0ZgDk4+OtdGQ5F05
         m1X58E+CcfLOTl7MSYqequQ7919awtuH1nL2QWwDzykK7O56ZQvJXAP8ZbUK4W87YJiLDdL8vjw3
         mPKhGpjnbdgWuFH2F1MdigmSjewvtnu7KWK2v9gOS+2MjYUvLio6FivxDcYsXml+siQAWCw7/BeB
         bFuoiDnZAlUqJnRGaKDKO0XPhIaPah5XryJIa6x0Ooo+2AZj9lM3DZg65Sxw9Q3i2MmXecfMgalm
         NvxY11bixjcHwZIMchV0ELi9X4IxH02BghdfQkjSFowT2bMTI30tq0nM5dFiW04mkyImiKGeVHgd
         Ht4Ps2BVXRa9oOr9VTsD6kMPyO7sYsfi/Ytk+kHXeNQQfKJcWaWuHF8obD3R7i
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com, ast@kernel.org
Cc:     rongtao@cestc.cn, rtoax@foxmail.com,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v3] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Sat, 12 Aug 2023 13:57:02 +0800
X-OQ-MSGID: <20230812055703.7218-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
v3: Do not use structs and judge ksyms__add_symbol function return value.
v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
    Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 tools/testing/selftests/bpf/trace_helpers.c | 42 ++++++++++++++++-----
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..d8391a2122b4 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,10 +18,32 @@
 #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
 #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
 
-#define MAX_SYMS 400000
-static struct ksym syms[MAX_SYMS];
+static struct ksym *syms;
+static int sym_cap;
 static int sym_cnt;
 
+static int ksyms__add_symbol(const char *name, unsigned long addr)
+{
+	void *tmp;
+	unsigned int new_cap;
+
+	if (sym_cnt + 1 > sym_cap) {
+		new_cap = sym_cap * 4 / 3;
+		tmp = realloc(syms, sizeof(struct ksym) * new_cap);
+		if (!tmp)
+			return -ENOMEM;
+		syms = tmp;
+		sym_cap = new_cap;
+	}
+
+	syms[sym_cnt].addr = addr;
+	syms[sym_cnt].name = strdup(name);
+
+	sym_cnt++;
+
+	return 0;
+}
+
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
@@ -33,9 +55,13 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
+	int ret;
 
+	sym_cap = 1024;
 	sym_cnt = 0;
+	syms = malloc(sizeof(struct ksym) * sym_cap);
+	if (!syms)
+		return -ENOMEM;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,15 +72,11 @@ int load_kallsyms_refresh(void)
 			break;
 		if (!addr)
 			continue;
-		if (i >= MAX_SYMS)
-			return -EFBIG;
-
-		syms[i].addr = (long) addr;
-		syms[i].name = strdup(func);
-		i++;
+		ret = ksyms__add_symbol(func, (unsigned long)addr);
+		if (ret)
+			return ret;
 	}
 	fclose(f);
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
 }
-- 
2.41.0

