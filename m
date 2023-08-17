Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13377EFFD
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Aug 2023 07:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347692AbjHQFEG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Aug 2023 01:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347773AbjHQFD5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Aug 2023 01:03:57 -0400
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D821BF8;
        Wed, 16 Aug 2023 22:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1692248633;
        bh=T7TfJXiMpcyXbu9o9Q8h0T9b4Y34G7YUL6yYCw+gTrA=;
        h=From:To:Cc:Subject:Date;
        b=mOFc0EJSl9mrI7nysR+HrED1oEWHz70mSYgbuKCBgLYecQ9gGGQbD9tPYZ3o3a1oF
         AbjmAjFEE61K6JIRMe6YCinkpbDY8yQCCnH0QcYB/bOOYskhD8Ki8wu63u/lx7B//9
         DEtjQz5d7M3AEa3x+KR5+Z+oqd9D4nlzQWNnVwnE=
Received: from localhost.localdomain ([39.156.73.12])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id F0B4CB3; Thu, 17 Aug 2023 13:03:48 +0800
X-QQ-mid: xmsmtpt1692248628tspf448hc
Message-ID: <tencent_0E9E1A1C0981678D5E7EA9E4BDBA8EE2200A@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9GVejZOqymyN36NH0ARIDPyGuZGfMhvTF9JfxgZh5uiyOvC/Ly3
         S/Z8uaPJD/x8t2A5367q/E/ug4cJlzMT8F1jfbMhPd7SPeGnpGbePR8PM02WhtMOs0pk3I2zMWVT
         /DfBJVQa/6r2VavXQdbMwK5BQS8DOtAxS50w3Y2+qXPAj+/5W3ex4xSBzlitEagzn9mmGjHW3kWr
         Bwiun6SzNzusdAds6vgDm9XMO3FevHVBMuz/JHY1nOeZmE/zMEMihWmNkCUb/NF3ZNGmqsziUVQh
         KcQfjlDTj2Gq5M1PDGaHRyhs8V76N3QocpDm2dieSVVCtbD7p83LaZHpRnFurn14nqiWbT/jQVTa
         Z4gmKnWaPv7J/vx7hDEjnNgnFDlaE/NJl0/GhlbIwf3aVxwaodjoYXrKf7YKHIAMNXM85igx0svg
         vg7SKgiaCTMVIlL29XWR3ImV2+5ERg40ECkYzrroTPC3Fk5P7FI8raMwk+RgpkR2/MgzjxWRWWl9
         cFuNIYfIibVuTPJLtlic8DxkdMcEkotbofWkvss2xpcy5YExxWjHQKqrBJao+i0AAIc6d2Q3cDvq
         Yv4GMsTdLYQF2eUjFhopwetoFih4hTWaWF/JD2b+1YtRBlJjat93LB8xJgpmgACBAXjbAOqC/FqW
         hkOaMLMJLSHqGxL/dh/ieKWwcvbbS+/BcsbCMNP7hkN8OZWd9knG9N11hB092bkdTNxiOar3P2cf
         d9xIGuV3ouyZ8O0NQpjgzMgVrLeQf9O5pjguQEhh4wr17COTT2Lv8B4TUaAEpnNmRpVECbnNGv8h
         wFN6hvKz92Q7NB+8jhH3nRa5NsdphAjj/RsDl0+ONwF8iWgwbsIOasthdRLCJqfOj546H94m4HOd
         2cnLowjFpMwnU6VcJHD0Ze0ebalOf2xmq/cg1wwN7BNNzUD9OFBIdfD+8/lXH5umACzZUVAl7NyU
         obtj/Y1ZzOJWu3CpT0eWVzNPRjVXLW/O4Um36H3mamGhqHM/Qt45HGh1fHcl4mCLy9gkrzGuI32k
         Gz09D/MqusJRUn3xCa+6BPPPpCV3zzbnBDCjb0ubcOJdts32Uis/6VhiJKomE=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Rong Tao <rtoax@foxmail.com>
To:     sdf@google.com, daniel@iogearbox.net, andrii@kernel.org
Cc:     rongtao@cestc.cn, rtoax@foxmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next v5] selftests/bpf: trace_helpers.c: optimize kallsyms cache
Date:   Thu, 17 Aug 2023 13:03:45 +0800
X-OQ-MSGID: <20230817050346.19619-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
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

Acked-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
v5: Release the allocated memory once the load_kallsyms_refresh() upon error
    given it's dynamically allocated.
v4: https://lore.kernel.org/lkml/tencent_59C74613113F0C728524B2A82FE5540A5E09@qq.com/
    Make sure most cases we don't need the realloc() path to begin with,
    and check strdup() return value.
v3: https://lore.kernel.org/lkml/tencent_50B4B2622FE7546A5FF9464310650C008509@qq.com/
    Do not use structs and judge ksyms__add_symbol function return value.
v2: https://lore.kernel.org/lkml/tencent_B655EE5E5D463110D70CD2846AB3262EED09@qq.com/
    Do the usual len/capacity scheme here to amortize the cost of realloc, and
    don't free symbols.
v1: https://lore.kernel.org/lkml/tencent_AB461510B10CD484E0B2F62E3754165F2909@qq.com/
---
 tools/testing/selftests/bpf/trace_helpers.c | 62 +++++++++++++++++----
 1 file changed, 52 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/selftests/bpf/trace_helpers.c
index f83d9f65c65b..0053ba22f0cb 100644
--- a/tools/testing/selftests/bpf/trace_helpers.c
+++ b/tools/testing/selftests/bpf/trace_helpers.c
@@ -18,10 +18,47 @@
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
+	tmp = strdup(name);
+	if (!tmp)
+		return -ENOMEM;
+	syms[sym_cnt].addr = addr;
+	syms[sym_cnt].name = tmp;
+
+	sym_cnt++;
+
+	return 0;
+}
+
+static void ksyms__free(void)
+{
+	unsigned int i;
+
+	if (!syms)
+		return;
+
+	for (i = 0; i < sym_cnt; i++)
+		free(syms[i].name);
+	free(syms);
+}
+
 static int ksym_cmp(const void *p1, const void *p2)
 {
 	return ((struct ksym *)p1)->addr - ((struct ksym *)p2)->addr;
@@ -33,9 +70,14 @@ int load_kallsyms_refresh(void)
 	char func[256], buf[256];
 	char symbol;
 	void *addr;
-	int i = 0;
+	int ret;
 
+	/* Make sure most cases we don't need the realloc() path to begin with */
+	sym_cap = 400000;
 	sym_cnt = 0;
+	syms = malloc(sizeof(struct ksym) * sym_cap);
+	if (!syms)
+		return -ENOMEM;
 
 	f = fopen("/proc/kallsyms", "r");
 	if (!f)
@@ -46,17 +88,17 @@ int load_kallsyms_refresh(void)
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
+			goto error;
 	}
 	fclose(f);
-	sym_cnt = i;
 	qsort(syms, sym_cnt, sizeof(struct ksym), ksym_cmp);
 	return 0;
+
+error:
+	ksyms__free();
+	return ret;
 }
 
 int load_kallsyms(void)
-- 
2.39.3

